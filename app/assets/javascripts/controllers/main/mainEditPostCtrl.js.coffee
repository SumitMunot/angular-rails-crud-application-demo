@EditPostCtrl = ($scope, $routeParams, $location, postData) ->
  
  $scope.data = postData.data
  $scope.data.postId = $routeParams.postId
  post = _.findWhere(postData.data.posts, { id: parseInt($scope.data.postId) })
  postData.loadPosts(null) 

  $scope.formData =
    editPostTitle: post.title
    editPostContents: post.contents
    editPostId: post.id

  $scope.navNewPost = ->
    $location.url('/post/new')

  $scope.navHome = ->
    $location.url('/')

  $scope.updatePost = ->
    postData.editPost($scope.formData)

  $scope.removePost = ->
    postData.deletePost($scope.formData)

  $scope.clearPost = ->
    $scope.formData.editPostTitle = ''
    $scope.formData.editPostContents = ''


@EditPostCtrl.$inject = ['$scope', '$routeParams','$location', 'postData']