Return-Path: <linux-iio+bounces-25200-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 95FC7BE9AF3
	for <lists+linux-iio@lfdr.de>; Fri, 17 Oct 2025 17:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 249D635D78A
	for <lists+linux-iio@lfdr.de>; Fri, 17 Oct 2025 15:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6997336EC4;
	Fri, 17 Oct 2025 15:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DBJGnQw2"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537EB335093;
	Fri, 17 Oct 2025 15:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760714355; cv=none; b=SQVlofZQNeyhvW6KN4vA0futUeZKq/ISyNHTjYk06nyVQwdGyZCG7xCQqd9RXJuZcaTHajfPH+D5RatfL32OrPk/gpc5Ss92pkfODZIy9+TVwZjyyfC44a+Lj8k73gWmsFUcZYhezfIoEuJ3Oq36K6/qjBcIhcS0r52OnAQDnpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760714355; c=relaxed/simple;
	bh=Jkoxv5jBiXwh3/Xam1mL3Rb7nwPNp22HhVGe+o5k1sY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lT+SAjbmhvUnXrEbcrnYhlbKwuzmp3aLg2hDmd54zgIipX3/Gso+63olqogeHhotWviM6iXqDqJSoZ/8/iNUVB9qoY2optZRxuFQOdxLlJ64Ij6XUpCvvcrLH1prSrxuM9GmR43kPdOce00cKbxeMCsrXzgpnWyFOioZdOnRvX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DBJGnQw2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98656C4CEE7;
	Fri, 17 Oct 2025 15:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760714355;
	bh=Jkoxv5jBiXwh3/Xam1mL3Rb7nwPNp22HhVGe+o5k1sY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DBJGnQw29zw6lCVTKtpBhIgSG7SMX4VZD9MlmLUEPUBMWipU3K8+xfy/xqlmxz8Qi
	 mLxaq5V5Z7Et2fOTaRuUiiEspXQRrhIZZJ9xRqScULqTAgvTGjzSlFIQWaMNs3MR+A
	 dKeaol6kFcz4lkdW7DFiMk5bbpEA1Dgh/SH6u6TIXDXdKDqoochxfVVvitpFaYDKlL
	 bULb536qkalBIUpX9fU7Dk2QB8zCg/3nMjXL1nlc2Ddg/ayrRE+8/4gAavHoyhpk1Y
	 0fREHXWYLfsbUhrNzXSgnVS+UpYAnpmQOfquXa1v8/EjnKyNDqrbCpraPpvMaG8lGT
	 yY3YmE4+sr2qw==
Date: Fri, 17 Oct 2025 08:19:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre
 Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea
 <claudiu.beznea@tuxon.dev>, Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, David Miller
 <davem@davemloft.net>, Linus Walleij <linus.walleij@linaro.org>, Bartosz
 Golaszewski <brgl@bgdev.pl>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Crt Mori <cmo@melexis.com>, Jonathan Cameron
 <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Jacky Huang
 <ychuang3@nuvoton.com>, Shan-Chun Hung <schung@nuvoton.com>, Yury Norov
 <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Johannes
 Berg <johannes@sipsolutions.net>, Alex Elder <elder@ieee.org>, David Laight
 <david.laight.linux@gmail.com>, Vincent Mailhol
 <mailhol.vincent@wanadoo.fr>, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-renesas-soc@vger.kernel.org,
 linux-crypto@vger.kernel.org, qat-linux@intel.com,
 linux-gpio@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
 linux-iio@vger.kernel.org, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH treewide v3 2/4] bitfield: Add non-constant
 field_{prep,get}() helpers
Message-ID: <20251017081912.2ad26705@kernel.org>
In-Reply-To: <2d30e5ffe70ce35f952b7d497d2959391fbf0580.1739540679.git.geert+renesas@glider.be>
References: <cover.1739540679.git.geert+renesas@glider.be>
	<2d30e5ffe70ce35f952b7d497d2959391fbf0580.1739540679.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 14 Feb 2025 14:55:51 +0100 Geert Uytterhoeven wrote:
> The existing FIELD_{GET,PREP}() macros are limited to compile-time
> constants.  However, it is very common to prepare or extract bitfield
> elements where the bitfield mask is not a compile-time constant.
> 
> To avoid this limitation, the AT91 clock driver and several other
> drivers already have their own non-const field_{prep,get}() macros.
> Make them available for general use by consolidating them in
> <linux/bitfield.h>, and improve them slightly:
>   1. Avoid evaluating macro parameters more than once,
>   2. Replace "ffs() - 1" by "__ffs()",
>   3. Support 64-bit use on 32-bit architectures.
> 
> This is deliberately not merged into the existing FIELD_{GET,PREP}()
> macros, as people expressed the desire to keep stricter variants for
> increased safety, or for performance critical paths.

We already have helpers for this, please just don't know they exist :/

The "const" version of the helpers are specifically defined to work
on masks generated with BIT() and GENMASK(). If the mask is not
constant we should expect it to have a well defined width.

I strongly prefer that we do this instead and convert the users to
the fixed-width version:

---->8----------------

Subject: bitfield: open code the fixed-width non-const helpers so that people see them

There is a number of useful helpers defined in bitfield.h but
they are mostly invisible to the reader because they are all
generated by macros. Open code the 32b versions (which are
most commonly used) to give developers a chance to discover them.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 include/linux/bitfield.h | 82 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 81 insertions(+), 1 deletion(-)

diff --git a/include/linux/bitfield.h b/include/linux/bitfield.h
index 5355f8f806a9..0356e535f37d 100644
--- a/include/linux/bitfield.h
+++ b/include/linux/bitfield.h
@@ -173,6 +173,11 @@
 		*(_reg_p) |= (((typeof(_mask))(_val) << __bf_shf(_mask)) & (_mask));	\
 	})
 
+/* Non-constant, fixed-width helpers follow
+ * Open code u32 and le32 versions for documentation / visibility,
+ * be32 and other widths exist but are generated using macroes.
+ */
+
 extern void __compiletime_error("value doesn't fit into mask")
 __field_overflow(void);
 extern void __compiletime_error("bad bitfield mask")
@@ -188,6 +193,81 @@ static __always_inline u64 field_mask(u64 field)
 	return field / field_multiplier(field);
 }
 #define field_max(field)	((typeof(field))field_mask(field))
+
+/**
+ * u32_encode_bits() - prepare a u32 bitfield element (non-const)
+ * @v: value to put in the field
+ * @field: shifted mask defining the field's length and position
+ *
+ * Equivalent of FIELD_PREP() for u32, field does not have to be constant.
+ *
+ * Note that the helper is available for other field widths (generated below).
+ */
+static __always_inline __u32 u32_encode_bits(u32 v, u32 field)
+{
+	if (__builtin_constant_p(v) && (v & ~field_mask(field)))
+		__field_overflow();
+	return ((v & field_mask(field)) * field_multiplier(field));
+}
+
+/**
+ * u32_replace_bits() - change a u32 bitfield element (non-const)
+ * @old: old u32 value to modify
+ * @val: value to put in the field
+ * @field: shifted mask defining the field's length and position
+ *
+ * Remove the current contents of the @field in @old and set it to @new.
+ *
+ * Note that the helper is available for other field widths (generated below).
+ */
+static __always_inline __u32 u32_replace_bits(__u32 old, u32 val, u32 field)
+{
+	return (old & ~(field)) | u32_encode_bits(val, field);
+}
+
+/**
+ * u32_get_bits() - get u32 bitfield element (non-const)
+ * @v: value to extract the field from
+ * @field: shifted mask defining the field's length and position
+ *
+ * Extract the value of the field and shift it down.
+ *
+ * Note that the helper is available for other field widths (generated below).
+ */
+static __always_inline u32 u32_get_bits(__u32 v, u32 field)
+{
+	return ((v) & field) / field_multiplier(field);
+}
+
+static __always_inline void u32p_replace_bits(__u32 *p, u32 val, u32 field)
+{
+	*p = (*p & ~(field)) | u32_encode_bits(val, field);
+}
+
+static __always_inline __le32 le32_encode_bits(u32 v, u32 field)
+{
+	if (__builtin_constant_p(v) && (v & ~field_mask(field)))
+		__field_overflow();
+	return cpu_to_le32((v & field_mask(field)) * field_multiplier(field));
+}
+
+static __always_inline __le32 le32_replace_bits(__le32 old, u32 val, u32 field)
+{
+	return (old & ~cpu_to_le32(field)) | le32_encode_bits(val, field);
+}
+
+static __always_inline void le32p_replace_bits(__le32 *p, u32 val, u32 field)
+{
+	*p = (*p & ~cpu_to_le32(field)) | le32_encode_bits(val, field);
+}
+
+static __always_inline u32 le32_get_bits(__le32 v, u32 field)
+{
+	return (le32_to_cpu(v) & field) / field_multiplier(field);
+}
+
+/* Auto-generate bit ops for other field width and endian combination */
+
 #define ____MAKE_OP(type,base,to,from)					\
 static __always_inline __##type __must_check type##_encode_bits(base v, base field)	\
 {									\
@@ -215,7 +295,7 @@ static __always_inline base __must_check type##_get_bits(__##type v, base field)
 	____MAKE_OP(u##size,u##size,,)
 ____MAKE_OP(u8,u8,,)
 __MAKE_OP(16)
-__MAKE_OP(32)
+____MAKE_OP(be32,u32,cpu_to_be32,be32_to_cpu) /* Other 32b types open coded */
 __MAKE_OP(64)
 #undef __MAKE_OP
 #undef ____MAKE_OP
-- 
2.51.0


