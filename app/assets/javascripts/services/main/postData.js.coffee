angular.module('Blog').factory('postData', ['$http', ($http) ->

  postData =
    data:
      posts: [{title: 'Loading', contents: ''}]
    isLoaded: false


  postData.createPost = (newPost) ->
    # Client-side data validation
    if newPost.newPostTitle == '' or newPost.newPostContents == ''
      alert('Neither the Title nor the Body are allowed to be left blank.')
      return false

    # Create data object to POST
    data =
      new_post:
        title: newPost.newPostTitle
        contents: newPost.newPostContents

    # Do POST request to /posts.json
    $http.post('./posts.json', data).success( (data) ->

      # Add new post to array of posts
      postData.data.posts.push(data)
      console.log('Successfully created post.')

    ).error( ->
      console.error('Failed to create new post.')
    )

    return true

  postData.editPost = (updatePost) ->
    #client-side validations
    if updatePost.editPostTitle == '' or updatePost.editPostContents == ''
      alert('Neither the Title nor the Body are allowed to be left blank.')
      return false
    
    #create data object to post
    data =
      edit_post:
        id: updatePost.editPostId
        title: updatePost.editPostTitle
        contents: updatePost.editPostContents
     
    # Do POST request to /posts.json
    $http.post('./posts.json', data).success( (data) ->
      
      # Add new post to array of posts
      postData.data.posts.push(data)
      console.log('Successfully updated post.')

    ).error( ->
      console.error('Failed to update new post.')
    )

    return true

  postData.deletePost = (updatePost) ->   
    #create data object to delete post
    data =
      delete_post:
        id: updatePost.editPostId
        title: updatePost.editPostTitle
        contents: updatePost.editPostContents
     
    # Do POST request to /posts.json
    $http.post('./posts.json', data).success( (data) ->
      
      # Add new post to array of posts
      postData.data.posts.push(data)
      console.log('Successfully deleted post.')

    ).error( ->
      console.error('Failed to delete post.')
    )

    return true

  # postData.loadPosts = (deferred) ->
  #   if !postData.isLoaded
  #     $http.get('./posts.json').success( (data) ->
  #       postData.data.posts = data
  #       postData.isLoaded = true
  #       console.log('Successfully loaded posts.')
  #       if deferred
  #         deferred.resolve()
  #     ).error( ->
  #       console.error('Failed to load posts.')
  #       if deferred
  #         deferred.reject('Failed to load posts.')
  #     )
  #   else
  #     if deferred
  #       deferred.resolve()


  postData.loadPosts = ->
    if !postData.isLoaded
      $http.get('./posts.json').success( (data) ->
        postData.data.posts = data
        postData.isLoaded = true
        console.log('Successfully loaded posts.')
      ).error( ->
        console.error('Failed to load posts.')
      )

  return postData

])



