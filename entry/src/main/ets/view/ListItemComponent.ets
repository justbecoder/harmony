import router from '@ohos.router';
import resourceManager from '@ohos.resourceManager';
import { FontSize, FontWeight, ItemStyle, WEIGHT } from '../common/Constants'


@Component
export struct ListItemComponent {

  index?: number;
  private name?: Resource;

  // @Prop单向，数据改变时不同步父级
  @State vote: string = '';
  @Prop isSwitchDataSource: boolean;

  @State isChange: boolean = false;

  build() {
    Row() {
      Column() {
        if (this.isRenderCircleText()) {
          if (this.index !== undefined) {
            this.CircleText(this.index)
          }
        } else {
          Text(this.index?.toString())
            .lineHeight(ItemStyle.TEXT_LAYOUT_SIZE)
            .textAlign(TextAlign.Center)
            .width(ItemStyle.TEXT_LAYOUT_SIZE)
            .fontWeight(FontWeight.BOLD)
            .fontSize(FontSize.SMALL)
        }
      }
      .width(ItemStyle.LAYOUT_WEIGHT_LEFT)
      .alignItems(HorizontalAlign.Start)

      Text(this.name)
        .width(ItemStyle.LAYOUT_WEIGHT_CENTER)
        .fontWeight(FontWeight.BOLDER)
        .fontColor(this.isChange ? ItemStyle.COLOR_BLUE : ItemStyle.COLOR_BLACK)

      Text(this.vote)
        .width(ItemStyle.LAYOUT_WEIGHT_RIGHT)
        .fontWeight(FontWeight.BOLDER)
        .fontSize(FontSize.SMALL)
        .fontColor(this.isChange ? ItemStyle.COLOR_BLUE : ItemStyle.COLOR_BLACK)
    }
    .height(ItemStyle.BAR_HEIGHT)
    .width(WEIGHT)
    .onClick(async (event) => {
      console.log("touch click item" + event)
      this.isSwitchDataSource = !this.isSwitchDataSource
      this.isChange = !this.isChange
      console.log(`current name and vote ${this.name}, ${this.vote}`)

      // 获取用户名 - 获取resource资源
      const name = await getContext().resourceManager.getStringValue(this.name.id)

      router.pushUrl({
        url: 'pages/Profile',
        params: {
          name: name
        }
      })
    })
  }

  @Builder CircleText (index: number) {
    Row() {
      Text(this.index?.toString())
        .fontWeight(FontWeight.BOLD)
        .fontSize(FontSize.SMALL)
        .fontColor(Color.White)
    }
    .justifyContent(FlexAlign.Center)
    .borderRadius(ItemStyle.CIRCLE_TEXT_BORDER_RADIUS)
    .size({
      width: ItemStyle.CIRCLE_TEXT_SIZE,
      height: ItemStyle.CIRCLE_TEXT_SIZE
    })
    .backgroundColor($r('app.color.circle_text_background'))
  }

  isRenderCircleText (): boolean {
    return this.index <= 3
  }

}