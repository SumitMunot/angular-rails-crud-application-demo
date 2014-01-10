@PostCtrl = ($scope, $routeParams, $location, postData) ->

  $scope.data =
    postData: postData.data
    currentPost:
      title: 'Loading...'
      contents: ''

  $scope.data.postId = $routeParams.postId

  postData.loadPosts()

  $scope.prepPostData = ->
    post = _.findWhere(postData.data.posts, { id: parseInt($scope.data.postId) })
    $scope.data.currentPost.title = post.title
    $scope.data.currentPost.contents = post.contents

  $scope.navNewPost = ->
    $location.url('/post/new')

  $scope.navHome = ->
    $location.url('/')

  $scope.editPost = ->
    post = _.findWhere(postData.data.posts, { id: parseInt($scope.data.postId) })
    $location.url('/post/edit/'+post.id)

  $scope.deletePost = ->
    post = _.findWhere(postData.data.posts, { id: parseInt($scope.data.postId) })
    $location.url('/post/delete/'+post.id) 

  $scope.prepPostData()

@PostCtrl.$inject = ['$scope', '$routeParams', '$location', 'postData']
