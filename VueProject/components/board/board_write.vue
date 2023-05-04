<template>
<div class="container" style="margin-top:100px">
	<div class="row">
		<div class="col-sm-3"></div>
		<div class="col-sm-6">
			<div class="card shadow">
				<div class="card-body">
					
					<div class="form-group">
						<label for="content_subject">제목</label>
						<input type="text" id="content_subject" v-model="content_subject" class="form-control"/>
					</div>
					<div class="form-group">
						<label for="content_content">내용</label>
						<textarea id="content_content" v-model="content_content" class="form-control" rows="10" style="resize:none"></textarea>
					</div>
					<div class="form-group">
						<label for="content_file">첨부 이미지</label>
						<input type="file" id="content_file" name="content_file" class="form-control" accept="image/*"/>
					</div>
					<div class="form-group">
						<div class="text-right">
							<button type="button" @click='check_input' class="btn btn-primary">작성하기</button>
						</div>
					</div>
					
					
				</div>
			</div>
		</div>
		<div class="col-sm-3"></div>
	</div>
</div>
</template>
<script>
	module.exports = {
		data : function(){
			return {
				content_subject : '',
				content_content : ''
			}
		},
		methods : {
			check_input : function(){
				if(this.content_subject.length == 0){
					alert("제목을 입력해주세요")
					$("#content_subject").focus()
					return
				}
				if(this.content_content.length == 0){
					alert("내용을 입력해주세요")
					$("#content_content").focus()
					return
				}
				
				//var params = new FormData();
				var params = new URLSearchParams();

				params.append('content_writer_idx', this.$store.state.user_idx)
				params.append('content_subject', this.content_subject)
				params.append('content_text', this.content_content)
				params.append('content_file', $('#content_file')[0].files[0])
				params.append('board_idx', this.$route.params.board_idx)
				
				axios.post('server/board/add_content.asp', params).then((response) => {
					//alert(response.data.result)
					if(response.data.result === 'True'){
						alert('작성이 완료되었습니다')
						this.$router.push('/board_read/' + this.$route.params.board_idx + '/1/' + response.data.content_idx)
					}
				})
			}
		}
	}
	

</script>