Return-Path: <linux-iio+bounces-14852-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B6DDA24D10
	for <lists+linux-iio@lfdr.de>; Sun,  2 Feb 2025 09:27:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72B2B3A334C
	for <lists+linux-iio@lfdr.de>; Sun,  2 Feb 2025 08:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 204321D5177;
	Sun,  2 Feb 2025 08:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="Er14Dtt3"
X-Original-To: linux-iio@vger.kernel.org
Received: from out.smtpout.orange.fr (out-13.smtpout.orange.fr [193.252.22.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9F18BE7;
	Sun,  2 Feb 2025 08:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738484863; cv=none; b=r7I6IAAd8B5HpnbfRXWLtYdxv6MYPdBP/oLmyeTLde2Zr51UUwgRNYEMGPZmGRTOpvBwEmz90CSlN1cpCMv3Nc/JpV9K+ml2agsMvwTBexcnx1QIn9gbwhCk90sJTiFpVpsAu7tP5jJ6yqke+/4ab8O/eieU2SfhpNBcYBYEF4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738484863; c=relaxed/simple;
	bh=3R02TGIEWd2cVE8jGoGk2IukoLrWOAmI6UyxCl1vFdc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LUgU023YRTxZuRNY2oxBcMpXpDjnIJs5WAvy4bNrsR+IxiMNFMm4801PCYAEsuRlxo0shOtlEXLlIWhJWmrAsR54NkfvETJJRjx+g7kttnNa55zVNtwfLWbNwOUR+qAb8sYl78QGpRkYKz3Yw8koIE44Ngxy1Y+Itugh7dDksxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=Er14Dtt3; arc=none smtp.client-ip=193.252.22.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id eVIrtwgZkM6ZbeVIwtQSlb; Sun, 02 Feb 2025 09:26:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1738484790;
	bh=PzrthrLkW4R8v6fQu4F9Z0+3j1oj2AKD6gdwJR3+YjY=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=Er14Dtt3+zfNicUpvicGUD6Vdf5OQJsDpkGPvY598Y41dT4BnaZJiPDU0Z9Am45FA
	 rt5j0Pz9QRRm/z1mN2d3bb772DaBoyfWVgR/c2muJ80mlphsG3rFguogAus2nGUtIq
	 SMzYzyRktW1gkaZRsNIAjVI989zqNQFAkzvJwc+c2MnnUIjwGsK+qKlmGw7er9lbI/
	 pIddcTj+3U4H8qpjYBDjjnhQpTydKf0sXi6FZhIfK4nK0TsNcNc/SvIiJquLWgQ3LP
	 O1s8+gqFJZHGsDqv+oFJDfLSh35L6j+QPDYeBSJJCpC011UxtV+bXz1kDtn/PestXd
	 +aDON8InPsqFw==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Sun, 02 Feb 2025 09:26:30 +0100
X-ME-IP: 124.33.176.97
Message-ID: <e20a177a-30cd-4088-89e1-b479aba1356c@wanadoo.fr>
Date: Sun, 2 Feb 2025 17:26:04 +0900
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH treewide v2 1/3] bitfield: Add non-constant
 field_{prep,get}() helpers
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-renesas-soc@vger.kernel.org, linux-crypto@vger.kernel.org,
 qat-linux@intel.com, linux-gpio@vger.kernel.org,
 linux-aspeed@lists.ozlabs.org, linux-iio@vger.kernel.org,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S . Miller" <davem@davemloft.net>,
 Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski
 <brgl@bgdev.pl>, Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Crt Mori <cmo@melexis.com>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Jacky Huang <ychuang3@nuvoton.com>, Shan-Chun Hung <schung@nuvoton.com>,
 Yury Norov <yury.norov@gmail.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, Jaroslav Kysela
 <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Johannes Berg <johannes@sipsolutions.net>, Jakub Kicinski <kuba@kernel.org>,
 Alex Elder <elder@ieee.org>
References: <cover.1738329458.git.geert+renesas@glider.be>
 <1824412519cb8791ab428065116927ee7b77cf35.1738329459.git.geert+renesas@glider.be>
Content-Language: en-US
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Autocrypt: addr=mailhol.vincent@wanadoo.fr; keydata=
 xjMEZluomRYJKwYBBAHaRw8BAQdAf+/PnQvy9LCWNSJLbhc+AOUsR2cNVonvxhDk/KcW7FvN
 LFZpbmNlbnQgTWFpbGhvbCA8bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI+wrIEExYKAFoC
 GwMFCQp/CJcFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AWIQTtj3AFdOZ/IOV06OKrX+uI
 bbuZwgUCZx41XhgYaGtwczovL2tleXMub3BlbnBncC5vcmcACgkQq1/riG27mcIYiwEAkgKK
 BJ+ANKwhTAAvL1XeApQ+2NNNEwFWzipVAGvTRigA+wUeyB3UQwZrwb7jsQuBXxhk3lL45HF5
 8+y4bQCUCqYGzjgEZx4y8xIKKwYBBAGXVQEFAQEHQJrbYZzu0JG5w8gxE6EtQe6LmxKMqP6E
 yR33sA+BR9pLAwEIB8J+BBgWCgAmFiEE7Y9wBXTmfyDldOjiq1/riG27mcIFAmceMvMCGwwF
 CQPCZwAACgkQq1/riG27mcJU7QEA+LmpFhfQ1aij/L8VzsZwr/S44HCzcz5+jkxnVVQ5LZ4B
 ANOCpYEY+CYrld5XZvM8h2EntNnzxHHuhjfDOQ3MAkEK
In-Reply-To: <1824412519cb8791ab428065116927ee7b77cf35.1738329459.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 31/01/2025 at 22:46, Geert Uytterhoeven wrote:
> The existing FIELD_{GET,PREP}() macros are limited to compile-time
> constants.  However, it is very common to prepare or extract bitfield
> elements where the bitfield mask is not a compile-time constant.

Why is it that the existing FIELD_{GET,PREP}() macros must be limited to
compile time constants? Instead of creating another variant for
non-constant bitfields, wouldn't it be better to make the existing macro
accept both?

As far as I can see, only __BUILD_BUG_ON_NOT_POWER_OF_2()  and
__BF_FIELD_CHECK() need to be adjusted. I am thinking of this:

diff --git a/include/linux/bitfield.h b/include/linux/bitfield.h
index 63928f173223..c6bedab862d1 100644
--- a/include/linux/bitfield.h
+++ b/include/linux/bitfield.h
@@ -8,6 +8,7 @@
 #define _LINUX_BITFIELD_H

 #include <linux/build_bug.h>
+#include <linux/compiler.h>
 #include <asm/byteorder.h>

 /*
@@ -62,15 +63,13 @@

 #define __BF_FIELD_CHECK(_mask, _reg, _val, _pfx)                      \
        ({                                                              \
-               BUILD_BUG_ON_MSG(!__builtin_constant_p(_mask),          \
-                                _pfx "mask is not constant");          \
-               BUILD_BUG_ON_MSG((_mask) == 0, _pfx "mask is zero");    \
-               BUILD_BUG_ON_MSG(__builtin_constant_p(_val) ?           \
-                                ~((_mask) >> __bf_shf(_mask)) &        \
-                                       (0 + (_val)) : 0,               \
+               BUILD_BUG_ON_MSG(statically_true((_mask) == 0),         \
+                                _pfx "mask is zero");                  \
+               BUILD_BUG_ON_MSG(statically_true(~((_mask) >>
__bf_shf(_mask)) & \
+                                                (0 + (_val))),         \
                                 _pfx "value too large for the field"); \
-               BUILD_BUG_ON_MSG(__bf_cast_unsigned(_mask, _mask) >     \
-                                __bf_cast_unsigned(_reg, ~0ull),       \
+
BUILD_BUG_ON_MSG(statically_true(__bf_cast_unsigned(_mask, _mask) > \
+
__bf_cast_unsigned(_reg, ~0ull)), \
                                 _pfx "type of reg too small for mask"); \
                __BUILD_BUG_ON_NOT_POWER_OF_2((_mask) +                 \
                                              (1ULL << __bf_shf(_mask))); \
diff --git a/include/linux/build_bug.h b/include/linux/build_bug.h
index 3aa3640f8c18..3b8055ebb55f 100644
--- a/include/linux/build_bug.h
+++ b/include/linux/build_bug.h
@@ -18,9 +18,9 @@

 /* Force a compilation error if a constant expression is not a power of
2 */
 #define __BUILD_BUG_ON_NOT_POWER_OF_2(n)       \
-       BUILD_BUG_ON(((n) & ((n) - 1)) != 0)
+       BUILD_BUG_ON(statically_true((n) & ((n) - 1)))
 #define BUILD_BUG_ON_NOT_POWER_OF_2(n)                 \
-       BUILD_BUG_ON((n) == 0 || (((n) & ((n) - 1)) != 0))
+       BUILD_BUG_ON(statically_true(!(n) || ((n) & ((n) - 1))))

 /*
  * BUILD_BUG_ON_INVALID() permits the compiler to check the validity of the


> To avoid this limitation, the AT91 clock driver and several other
> drivers already have their own non-const field_{prep,get}() macros.
> Make them available for general use by consolidating them in
> <linux/bitfield.h>, and improve them slightly:
>   1. Avoid evaluating macro parameters more than once,
>   2. Replace "ffs() - 1" by "__ffs()",
>   3. Support 64-bit use on 32-bit architectures.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

(...)


Yours sincerely,
Vincent Mailhol


