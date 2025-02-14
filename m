Return-Path: <linux-iio+bounces-15544-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C89FAA361CE
	for <lists+linux-iio@lfdr.de>; Fri, 14 Feb 2025 16:34:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 963C118931C3
	for <lists+linux-iio@lfdr.de>; Fri, 14 Feb 2025 15:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54BFD266EFE;
	Fri, 14 Feb 2025 15:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ECrCiL7D"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECFFE25A2AD;
	Fri, 14 Feb 2025 15:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739547245; cv=none; b=Q8rLMdVk6uEcdf6amHcr3YJv9fzmPMZ9al2T077b+EZMBn/vDJnLJrLAVhQkhJ+F/+PMLJ++XcehldhTzlu0laoE33xv+1iBtO+F+5GG6+y0/NDJGje9aQ3NjBT7t87kEaRfSSZxY6sX9icG8LwPvPKQrpoxHcrDCtyEVALwwgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739547245; c=relaxed/simple;
	bh=afzjkoDNR+5URzZhBvSQ4ZnpfxUfaPdGqiY8US/VboU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S/bf71BTKFO8Fhzgm3DuB1E9NI/C6YC2QCZfaPZEXuEvUttqtI2tS1S7ZHffMlu45TBp6SSvR2hDz2FEr+O/xRgHhpqmGI4TKT+GixrvUBh6cd8gIbsGvCv/LLZMTKgKfwaOxpAMWYmYhbHLGgID2iZZjFYy+nh9QyEftR8lkqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ECrCiL7D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E762C4CED1;
	Fri, 14 Feb 2025 15:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739547244;
	bh=afzjkoDNR+5URzZhBvSQ4ZnpfxUfaPdGqiY8US/VboU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ECrCiL7DBdPP6UFFz6PjonfFVlEUbl56ymR9CSiZzxpxCifwC27Tw8p1u6IDaNAcz
	 XemUEQwq0pq9I6NzQ57R87EtLHA58AoZUYXKU4c/a4+0bKli0nC2pWWJ0CaTzucIWf
	 zEEnZzErfP0wK5sPyu2mi2qclLmZogSRA/rGjbulFjwx2g9cjB/YQIACh2RMxA/mmG
	 B0Uv3e4Yr3cTk/XVs+liLdVf+fr5YxFQXWCevR4NaUolQnSHhBUYWJJ4xYbbe3NeAW
	 MF9KLwHoWvD7iUCoAoTnAelZhfw/GRKpfZBbyWOre6DjfvmbKONn7GTj2BMeFEUPTK
	 6xY1KtkqdoRBw==
Date: Fri, 14 Feb 2025 07:34:02 -0800
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
Message-ID: <20250214073402.0129e259@kernel.org>
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

I really really think that people should just use the static inline
helpers if the field is not constant. And we should do something like
below so that people can actually find them.

diff --git a/include/linux/bitfield.h b/include/linux/bitfield.h
index 63928f173223..e02afcd7aeee 100644
--- a/include/linux/bitfield.h
+++ b/include/linux/bitfield.h
@@ -156,6 +156,80 @@
 		(typeof(_mask))(((_reg) & (_mask)) >> __bf_shf(_mask));	\
 	})
 
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
+static __always_inline void u32p_replace_bits(__u32 * p, u32 val, u32 field)
+{
+	* p = ( * p & ~(field)) | u32_encode_bits(val, field);
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
+static __always_inline void le32p_replace_bits(__le32 * p, u32 val, u32 field)
+{
+	* p = ( * p & ~cpu_to_le32(field)) | le32_encode_bits(val, field);
+}
+
+static __always_inline u32 le32_get_bits(__le32 v, u32 field)
+{
+	return (le32_to_cpu(v) & field) / field_multiplier(field);
+}
+
+/* Auto-generate bit ops for other field width and endian combination */
+
 extern void __compiletime_error("value doesn't fit into mask")
 __field_overflow(void);
 extern void __compiletime_error("bad bitfield mask")
@@ -198,7 +272,7 @@ static __always_inline base type##_get_bits(__##type v, base field)	\
 	____MAKE_OP(u##size,u##size,,)
 ____MAKE_OP(u8,u8,,)
 __MAKE_OP(16)
-__MAKE_OP(32)
+____MAKE_OP(be32,u32,cpu_to_be32,be32_to_cpu) /* Other 32b types open coded */
 __MAKE_OP(64)
 #undef __MAKE_OP
 #undef ____MAKE_OP

