Return-Path: <linux-iio+bounces-15827-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45121A3D64E
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 11:17:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 041593A595F
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 10:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4BDD1F0E31;
	Thu, 20 Feb 2025 10:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XMTo2Saj"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6BB1CAA9C;
	Thu, 20 Feb 2025 10:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740046671; cv=none; b=RiHTxx2hFX0LSYes9IYIghiq1FQ4eWhKd+fJFDMs1+0SslMLXIVOOgUYOl6cqSkCKmMCRtceIHiVIlfKR/7CZ059j/I6kZ30HbeQ0qBhJb1U17ZbujkzMkVIqz5DSHiwB1QwkKZ3tpC5kQgjjsn03els6z9/eJo8dWTtnGqgU4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740046671; c=relaxed/simple;
	bh=jkjLMwlq7z/a7rNHFun0f7wbSTUHNvkofg4WYYRHwHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c0A0UtH/ejwQ1ryyv74fxXQPzuK06FhrDVYr3sZuyqOWsmArmBGB3S9GgVKNmOQJjIqDs/CKZ1o7/2K8a7ZFwyIj8VzXssHgapKs2mMiJEJHuTpUKuY0iluc+Wm5VUE43sBTxiP+ClMWRsI8D64XdZl1F8l2R5OH1LPaA0hMNaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XMTo2Saj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D387C4CED1;
	Thu, 20 Feb 2025 10:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740046670;
	bh=jkjLMwlq7z/a7rNHFun0f7wbSTUHNvkofg4WYYRHwHA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XMTo2SajVS+RAzuwMNv21Gc3CE74kqNMrgwVPSd2T5vdbRhzgNmsOTa83rZcK2BCY
	 fS/j9C9TZQHnLR2bmzP5am1G/zLuKLomhC2NKfXGOGVuXYoisyGwtv8l1RQU1wdfxZ
	 ACc2PS4NQt67Zir2d9dihWR7pbfBv8srkPAQ57tbvLlSToj+7Eqvt/HvKuJVwRQN5o
	 tOPg00ezB7GQYe/P+sINgM4SFHbCZkT/H2ASBf9FFeM6EqxosOPAbfyYCzUrKQxiLc
	 ldKQtVAjbG7IjnvlV/oq+1S9CavyaVkT8UPWNWiALbAb+RqodmtwiLZ6hh1r5nvziU
	 JooH6gi7E5ZvA==
Date: Thu, 20 Feb 2025 10:17:42 +0000
From: Simon Horman <horms@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Andy Shevchenko <andy@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>, Peter Rosin <peda@axentia.se>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-mmc@vger.kernel.org, netdev@vger.kernel.org,
	linux-phy@lists.infradead.org, linux-sound@vger.kernel.org,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v3 05/15] bus: ts-nbus: use bitmap_get_value8()
Message-ID: <20250220101742.GR1615191@kernel.org>
References: <20250210-gpio-set-array-helper-v3-0-d6a673674da8@baylibre.com>
 <20250210-gpio-set-array-helper-v3-5-d6a673674da8@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250210-gpio-set-array-helper-v3-5-d6a673674da8@baylibre.com>

On Mon, Feb 10, 2025 at 04:33:31PM -0600, David Lechner wrote:
> Use bitmap_get_value8() instead of accessing the bitmap directly.
> 
> Accessing the bitmap directly is not considered good practice. We now
> have a helper function that can be used instead, so let's use it.
> 
> Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
u> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>  drivers/bus/ts-nbus.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/bus/ts-nbus.c b/drivers/bus/ts-nbus.c
> index b4c9308caf0647a3261071d9527fffce77784af2..beac67f3b820377f8bb1fc4f4ee77e15ee240834 100644
> --- a/drivers/bus/ts-nbus.c
> +++ b/drivers/bus/ts-nbus.c
> @@ -10,6 +10,7 @@
>   * TS-4600 SoM.
>   */
>  
> +#include <linux/bitmap.h>
>  #include <linux/bitops.h>
>  #include <linux/gpio/consumer.h>
>  #include <linux/kernel.h>
> @@ -107,7 +108,7 @@ static void ts_nbus_reset_bus(struct ts_nbus *ts_nbus)
>  {
>  	DECLARE_BITMAP(values, 8);
>  
> -	values[0] = 0;
> +	bitmap_set_value8(values, byte, 0);

Hi David,

byte doesn't appear to exist in the scope of this function.

I tried this:

	bitmap_set_value8(values, 0, 8);

But when compiling with GCC 14.2.0 I see warnings that values
is used uninitialised - bitmap_set_value8() appears to rely on
it being so.

  CC      drivers/bus/ts-nbus.o
In file included from drivers/bus/ts-nbus.c:13:
In function ‘bitmap_write’,
    inlined from ‘ts_nbus_reset_bus’ at drivers/bus/ts-nbus.c:111:2:
./include/linux/bitmap.h:818:12: error: ‘values’ is used uninitialized [-Werror=uninitialized]
  818 |         map[index] &= (fit ? (~(mask << offset)) : ~BITMAP_FIRST_WORD_MASK(start));
      |         ~~~^~~~~~~
In file included from ./include/linux/kasan-checks.h:5,
                 from ./include/asm-generic/rwonce.h:26,
                 from ./arch/x86/include/generated/asm/rwonce.h:1,
                 from ./include/linux/compiler.h:344,
                 from ./include/linux/build_bug.h:5,
                 from ./include/linux/bits.h:22,
                 from ./include/linux/bitops.h:6,
                 from ./include/linux/bitmap.h:8:
drivers/bus/ts-nbus.c: In function ‘ts_nbus_reset_bus’:
drivers/bus/ts-nbus.c:109:24: note: ‘values’ declared here
  109 |         DECLARE_BITMAP(values, 8);
      |                        ^~~~~~
./include/linux/types.h:11:23: note: in definition of macro ‘DECLARE_BITMAP’
   11 |         unsigned long name[BITS_TO_LONGS(bits)]
      |                       ^~~~


>  
>  	gpiod_multi_set_value_cansleep(ts_nbus->data, values);
>  	gpiod_set_value_cansleep(ts_nbus->csn, 0);
> @@ -151,7 +152,7 @@ static void ts_nbus_write_byte(struct ts_nbus *ts_nbus, u8 byte)
>  {
>  	DECLARE_BITMAP(values, 8);
>  
> -	values[0] = byte;
> +	bitmap_set_value8(values, byte, 8);
>  
>  	gpiod_multi_set_value_cansleep(ts_nbus->data, values);
>  }
> 
> -- 
> 2.43.0
> 

