import TodoDataModel from '../viewmodel/TodoDataModel'
import CommonConstants from '../common/TodoConstants'
import TodoItem from '../view/TodoItem';

@Entry
@Component
struct Todo {
  @State message: string = 'TODO'

  private totalTasks: Array<string> = [];


  aboutToAppear() {
    this.totalTasks = TodoDataModel.getData();
  }

  build() {
    Column({
      space: CommonConstants.COLUMN_SPACE
    }) {
      Text($r('app.string.page_title'))
        .fontSize($r('app.float.title_font_size'))
        .fontWeight(FontWeight.Bold)
        .lineHeight($r('app.float.title_font_height'))
        .width(CommonConstants.TITLE_WIDTH)
        .margin({
          top: $r('app.float.title_margin_top'),
          bottom: $r('app.float.title_margin_bottom')
        })
        .textAlign(TextAlign.Start)

      ForEach(this.totalTasks, (item) => {
        TodoItem({
          content: item
        })
      }, (item: string) => JSON.stringify(item))
    }
    .width(CommonConstants.FULL_LENGTH)
    .height(CommonConstants.FULL_LENGTH)
    .backgroundColor($r('app.color.page_background'))
  }
}