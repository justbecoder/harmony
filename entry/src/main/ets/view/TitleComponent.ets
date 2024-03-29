import AppContext from '@ohos.app.ability.common'

import { FontSize, TitleBarStyle, WEIGHT } from '../common/Constants'

@Component
export struct TitleComponent {
  @State title: Resource = $r('app.string.title_default')
  @Link isRefresh: boolean;

  build() {
    Row() {
      Row() {
        Image($r('app.media.ic_public_back'))
          .height(TitleBarStyle.IMAGE_BACK_SIZE)
          .width(TitleBarStyle.IMAGE_BACK_SIZE)
          .margin({
            right: TitleBarStyle.IMAGE_BACK_MARGIN_RIGHT
          })
          .onClick(() => {
            let handler = getContext(this) as AppContext.UIAbilityContext
            handler.terminateSelf()
          })
        Text(this.title)
          .fontSize(FontSize.LARGE)
      }
      .width(TitleBarStyle.WEIGHT)
      .height(WEIGHT)
      .justifyContent(FlexAlign.Start)

      Row() {
        Image($r('app.media.loading'))
          .height(TitleBarStyle.IMAGE_LOADING_SIZE)
          .width(TitleBarStyle.IMAGE_LOADING_SIZE)
          .onClick(() => {
            this.isRefresh = !this.isRefresh;
          })
      }
      .width(TitleBarStyle.WEIGHT)
      .height(WEIGHT)
      .justifyContent(FlexAlign.End)

    }
    .width(WEIGHT)
    .height(TitleBarStyle.BAR_HEIGHT)
    .padding({
      left: TitleBarStyle.BAR_MARGIN_HORIZONTAL,
      right: TitleBarStyle.BAR_MARGIN_HORIZONTAL
    })
    .margin({
      top: TitleBarStyle.BAR_MARGIN_TOP
    })
    .justifyContent(FlexAlign.SpaceAround)
  }
}