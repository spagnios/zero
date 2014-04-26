use Mojolicious::Lite;

get '/:name' => sub {
 #コントローラオブジェクト
 my $self = shift;
 #パラメータ受けとり
 my $name = $self->param('name');
 my $animal = $self->param('animal');

 #描画
 $self-> render('index', name => $name, animal => $animal);
};

get '/hello2' => sub {
 #コントローラオブジェクト
 my $self = shift;
 #描画
 $self-> render('index2');
};

#アプリケーションの開始

app->start;

#データセクション
__DATA__

@@ index.html.ep
<%
 my $name = stash('name');
 my $animal = stash('animal');
%>
Name: <%= $name %> Animal: <%= $animal %>

@@ index2.html.ep
Hello2...

<%= include 'include/header' %>
Name: <%= $name %> <br> Animal: <%= $animal %> <br>あいうえお

@@ include/header.html.ep
<h1 style="border-bottom:1px solid gray">タイトル!</h1>
__END__
