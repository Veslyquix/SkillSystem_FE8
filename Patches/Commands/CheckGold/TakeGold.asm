@
@所持金から差し引く
@
@金額を引数で渡せるようにする
@
@40 0D [11] [22] 81 F6 E4 08
@-> 0x2211ゴールド(8721ゴールド)

@@org	$08E4F680
@thumb

.global TakeGold
.type TakeGold, function

TakeGold:

	push	{lr}

	ldr  r0, [r0, #0x38]      @イベント命令にアクセスらしい [r3,#0x38] でイベント命令が書いてあるアドレスの場所へ
	ldrh r2, [r0, #0x2]       @引数1 40 0D [引数1] [引数2] [プログラム場所 XX XX XX 08]

	@所持金
@	ldr	r3, =$0202BCF4	@所持金を取得	@FE8J
	ldr	r3, =0x0202BCF4	@所持金を取得
	ldr	r1, [r3,#0x0]
	
	mov	r0, #0x0

	cmp	r1,r2
	BLT	gold_collect
	sub	r0,r1,r2   @金があるなら差し引く
				   @カネがない場合は r0=0です
gold_collect:
	@所持金の変更
	str	r0, [r3,#0x0]

	mov	r0, #0
	pop	{pc}

@MEMO
@この値の挙動は、 0800dd68(FE8J)  から呼び出される。
@独自関数を読んだときに、ここにブレークポイントを置くといいと思われる。
@
@ldr  r0, [r0, #0x38]      //イベント命令にアクセスらしい [r3,#0x38] でイベント命令が書いてあるアドレスの場所へ
@ldrb r1, [r0, #0x2]       //引数1 40 0D [引数1] [引数2] [プログラム場所 XX XX XX 08]
@ldrb r2, [r0, #0x3]       //引数2 40 0D [引数1] [引数2] [プログラム場所 XX XX XX 08]
@
