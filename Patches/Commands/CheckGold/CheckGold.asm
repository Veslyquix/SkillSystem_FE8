@
@所持金チェック 所持金が指定ゴールド以上かどうか
@
@40 0D [11] [22] E1 F6 E4 08
@
@-> 0x2211ゴールド(8721ゴールド)
@@org	$08E4F6E0
@thumb
.thumb
.global CheckGold
.type CheckGold, function

CheckGold:
	push	{lr}

	ldr  r0, [r0, #0x38]      @イベント命令にアクセスらしい [r3,#0x38] でイベント命令が書いてあるアドレスの場所へ
	ldrh r2, [r0, #0x2]       @引数1 40 0D [引数1] [引数2] [プログラム場所 XX XX XX 08]

	@所持金
@	ldr	r3, =$0202BCF4	@所持金を取得 FE8J
	ldr	r3, =0x0202BCF8	@所持金を取得 FE8U
	ldr	r1, [r3,#0x0]
	
	mov	r0, #0x0

	cmp	r1,r2
	BLT	exit_result
	mov	r0, #1		@金がある

exit_result:
@	ldr	r2, =$030004B0  @ + #0x30 FE8J
	ldr	r2, =0x030004B8  @ + #0x30 FE8U
	str	r0, [r2, #0x30]	@条件式で取れる領域に書き込む
						@400CXX00 0C000000	未達成ならジャンプ  / @410CXX00 0C000000	達成ならジャンプ
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
