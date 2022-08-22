notebooks_work_directory = "${CURDIR}/notebooks"
notebook_data_directory = "${CURDIR}/notebooks/data"
image_tag = "yp12-1.0.1"
image_name = "yp_notebooks"
container_name = "yp_notebook_12"

run_notebook:
	docker build . \
		--build-arg REQUIREMENTS="requirements.txt" \
		-t ${image_name}:${image_tag} 
	docker run \
		--detach \
		--name ${container_name} \
		--mount type=bind,source="${notebooks_work_directory}",target=/home/dim/work \
		--mount type=bind,source="${notebook_data_directory}",target=/home/dim/work/data \
		-it --rm -p 8888:8888 ${image_name}:${image_tag}
	sleep 10
	docker exec ${container_name} jupyter notebook list

stop_notebook:
	docker stop ${container_name}