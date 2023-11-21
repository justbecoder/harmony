import router from '@ohos.router'
@Entry
@Component
struct Profile {
  @State message: string = 'Hello '
  @State name: string = ""


  onPageShow() {
    const params = router.getParams()

    this.name = params['name']
  }

  build() {
    Row() {
      Column() {
        Text(this.message + this.name)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
      }
      .width('100%')
    }
    .height('100%')
  }
}