
download_pascalvoc <- function(path, version = "2007") {

  if (!version == "2007")
    stop("Only the 2007 version is supported", call. = FALSE)

  if (dir.exists(path) && length(list.files(path)) != 0)
    stop("Data could be overwritten.", call. = FALSE)

  pascal <- pins::pin(
    x = "http://pjreddie.com/media/files/VOCtrainval_06-Nov-2007.tar",
    name = "Pascal VOC dataset"
  )

  files <- untar(pascal, list = TRUE)

  annotations <- files[grepl("^.*/Annotations/.*.xml$", files)]
  images <- files[grepl("^.*/JPEGImages/.*.jpg$", files)]

  untar(
    tarfile = pascal,
    files = annotations,
    exdir = file.path(path, "annotations"),
    extras = "--strip-components 3"
    )
  untar(
    tarfile = pascal,
    files = images,
    exdir = file.path(path, "images"),
    extras = "--strip-components 3"
  )
  list(
    images = file.path(
      path, "images",
      gsub("VOCdevkit/VOC2007/JPEGImages/", "", images, fixed = TRUE)
    ),
    annotations = file.path(
      path, "images",
      gsub("VOCdevkit/VOC2007/Annotations/", "", images, fixed = TRUE)
    )
  )
}

