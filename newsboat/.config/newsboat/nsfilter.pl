 #!/usr/local/bin/perl
use strict;
use XML::Feed;
use LWP::UserAgent;
use Encode;
use Mojo::DOM;
use Data::Dumper;
use HTML::Packer;

sub delete_at {
    my $html = shift;
    my $element = shift;
    my $item = $html->at($element);
    if ($item) {
        $item->remove;
    }
}

sub delete_all {
    my $html = shift;
    my $element = shift;
    my $item = $html->find($element);
    if ($item->size != 0) {
        $item->each(sub { shift->remove });
    }
}

sub extract_youtube_embed {
    my $html = shift;
    my $item = $html->find('span.embed-youtube > iframe')->each(sub { $_->replace( '<a href="' . $_->attr('src') . '">' . $_->attr('src') . '</a>' )});
}

sub extract_subitem {
    my $html = shift;
    my $item = shift;
    my $extract = $html->at($item);

    if ($extract) {
        $html = Mojo::DOM->new($extract->to_string);
    }

    return $html;
}

sub  minify_html {
    my $html = shift;

    HTML::Packer->init()->minify( \$html, {remove_comments => 1,
                                          remove_newlines => 1} );
    return $html;
}

sub fetch_url {
    my $url = shift;
    my $ua = LWP::UserAgent->new();
    $ua->cookie_jar({ file => "$ENV{HOME}/.newsbeuter/cookies" });
    $ua->agent('Newsbeuter Filter Feed/1.0');
    my $req = new HTTP::Request GET => $url;
    my $res = $ua->request($req);
    return $res->content;
}

sub boingboing {
    my $html = shift;

    if ($html->at('div#container')) {
        $html = Mojo::DOM->new($html->at('div#container')->to_string);
    } elsif ($html->at('article')) {
        $html = Mojo::DOM->new($html->at('article')->to_string);
    }

    delete_at($html,'div.navbyline');
    delete_at($html,'div#sidebar');
    delete_at($html,'div#share-author');
    delete_at($html,'div.share');
    delete_at($html,'div.pubnation');
    delete_at($html,'div.admargin');
    delete_at($html,'div#next-post-thumbnails');
    delete_at($html,'div#mc_embed_signup');
    delete_at($html,'div.OUTBRAIN');
    delete_all($html,'script');
    extract_youtube_embed($html);

    return $html;
}
sub distrowatch {
    my $html = shift;

    $html = extract_subitem($html,'table.News');

    delete_all($html,'script');
    extract_youtube_embed($html);

    return $html;
}
sub gatesnotes {
    my $html = shift;

    $html = extract_subitem($html,'div.article');

    delete_all($html,'script');
    extract_youtube_embed($html);

    return $html;
}
sub phoronix {
    my $html = shift;

    $html = extract_subitem($html,'article.full');

    delete_all($html,'script');
    return $html
}

sub main {
    my $input;

    while(<>) {
        $input = $input . $_;
    }

    my $feed = XML::Feed->parse(\$input);
    $feed->convert('Atom');

    my $link = $feed->link;

    for my $entry ($feed->entries) {
        my $url = $entry->link();
        my $data = fetch_url($url);        
        my $html = Mojo::DOM->new(decode_utf8($data));

        if ($link =~ 'boingboing\.net') {
            $html = boingboing($html);
        } elsif ($link =~ 'distrowatch\.com') {
            $html = distrowatch($html);
        } elsif ($link =~ 'gatesnotes\.com') {
            $html = gatesnotes($html);
        } elsif ($link =~ 'phoronix\.com') {
            $html = phoronix($html);
        }

        my $output = minify_html($html->to_string);

        $entry->content("<![CDATA[" . $output . "]]>");

    }

    print $feed->as_xml;
}

main();
