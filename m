Return-Path: <linux-iio+bounces-22649-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8279BB245FC
	for <lists+linux-iio@lfdr.de>; Wed, 13 Aug 2025 11:49:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD4151716DA
	for <lists+linux-iio@lfdr.de>; Wed, 13 Aug 2025 09:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7862A212573;
	Wed, 13 Aug 2025 09:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="hMuMMVzg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409C62F49F6
	for <linux-iio@vger.kernel.org>; Wed, 13 Aug 2025 09:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755078024; cv=none; b=Aj2ez/NPrMoemUBhEMqdQzn+sdu2MkPzl9rN8ug5Kq0brsQq5RVHzum79Zb/u2ElSjXmIaPi+Rlz2Gf0dFsUocLRtVSYsR3jO58zCQXlDMYlih2i+FQuKfgUlQCRDQDLFeo5dlhOlj3vDo+87969AObJlqYQPE3Dbx9nf22BK9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755078024; c=relaxed/simple;
	bh=Bzl1fTy5zn3FKPpn8SCij3fXaOSeVZvede8RiBegfvw=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mh/Bf6wu/dtEBRCGgORFY+gN9KIjEitDzWuuWQ0wb4jY/ZdrE7raRY68vbckY0E++uYNncMa7Pbixd/AL/1oyM277ogSi7m7DNGpfQAwSCg107bIpOOrjrleiSwz/tmoJhrxfU2WGjuH2+rr3XDgSkIUSTU7hIHOokN0u+fg88c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=hMuMMVzg; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-556fd896c99so5405958e87.3
        for <linux-iio@vger.kernel.org>; Wed, 13 Aug 2025 02:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1755078020; x=1755682820; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:references:mime-version:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=TCLr2/gBgA535ijZwC7LDnHGKufszujGdP3EdKtVNas=;
        b=hMuMMVzgJw6F4GsH9IWakin6qXABGRo96PjIRDCQ0T10OkS6zyjG0RJHvwuBtBQeHS
         /EVORnMIHLtwDoQd/bCfVGyrNldQSq9+vvVmU4EdZDeCw2Xj05TLVenDyhizDbyBsqeU
         TSDucsiVSCVlf7Rko+6APRn2qaPPaE+HfJUxfwtXCmCMVtCfBSeVO5UfMaHD0O6yQ1Uo
         fZ0NHBS7Znrq0194PKLjvTdoyePViM/e7D+OUZj9cSSF37/l+LNoW4m0TeKFB/KTd3Nc
         hlzrtx8V4cPzCmCIV7HY01JWGfMuWASlJ7Au2cuNlBZ0GumyVDGR9ninWw15ZEjU2f/N
         Z/Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755078020; x=1755682820;
        h=cc:to:subject:message-id:date:references:mime-version:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TCLr2/gBgA535ijZwC7LDnHGKufszujGdP3EdKtVNas=;
        b=V5ObNRoPi0tpT5wB/73A7IDKgp6ghBDqP1ikz1VOaY3X5Z5juab45cJ1Cf0keb0b7D
         Y1/Xdfo2VVGSqFC92CUrBawm4S103mFcKq1dcHGU3qHCszh5GTrRYzpOya7l0+7AHu3t
         wdzwkz1th6w7wdyiOATrBNjoKPheFb2U0QjhdE2E0CmpXXr9zwNgRR0+w0xGzU9cZeRV
         R76F1VrzEC6p5VGrvDJrl24VsSceppIye4y2aSOA+5IRMcLB+bw6D44cEISk8qkKrtCG
         qBgWpcs0/CmquxWtYY4IhY93BZtbDsAfxgZEE3cTf5w8srviP2OVABTRMezcLBnfV6j+
         GMfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqi8TdRvPr3nzpEYbxE3hn5hS8nVeIc7F8GbnfcTqYXT9rEnvpRny/8PG/ahNx/OzCgLYkDM564Ic=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVWxA7kK14rU+bUcF1V92xiW7V+l+6NoVw2SwoBSzzS+tO2DlX
	vLWlJxFwBdZskUaC6vOZarP/iT2soZuGa6GxOfdfIAyUcDqPfeHrLHZDa2ZHZyPMH1C+nhLjWt2
	Fw8xlwlpx0CKxPpH2pL9o2pBqA+C4Jtf8nJJftGPUew==
X-Gm-Gg: ASbGnctobiZbM+F52tPOyuaW8SgjGZlv5P9WKCBOUP1gBsLUdpd+0sqzBvZgHLSPLKz
	wICqbl9g0ndaAWKF3vGFT7omQmm/iv1v49G5DcugltIJnOGjccTkB+UEF76LdBcm8fWopVkeccX
	qJLVbsZJ30Acs2Tl4PeeL3XK4U2n7QhV3JVTCGd3YmUDA99/EVA91hudf3pZgmHiLLuUGMwFktk
	75JNENmDxN/GhsHF3b+uDV3c8UH97gZrWqi6Yk=
X-Google-Smtp-Source: AGHT+IGRkmCRYjQdB/zuZeZqz/1pbYUJ5kWF1/Fnvca1BsseHJzKEkX+Ipcliv5kgaQGrHnHPdceKTRbNuzvOMwZtj4=
X-Received: by 2002:a05:6512:1396:b0:55b:8863:2b64 with SMTP id
 2adb3069b0e04-55ce03c7c16mr795502e87.57.1755078020190; Wed, 13 Aug 2025
 02:40:20 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 13 Aug 2025 05:40:19 -0400
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 13 Aug 2025 05:40:19 -0400
From: Bartosz Golaszewski <brgl@bgdev.pl>
In-Reply-To: <6837249bddf358924e67566293944506206d2d62.1755076369.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6837249bddf358924e67566293944506206d2d62.1755076369.git.mazziesaccount@gmail.com>
Date: Wed, 13 Aug 2025 05:40:19 -0400
X-Gm-Features: Ac12FXxS1Ph05y4YxBBe16rtMjc9WlhA3zcIzqCoM52YkPZ7kk1KgpF7Zpp__fk
Message-ID: <CAMRc=Mf75cangdeg7T4E0nAhJs_BTdLyCu6GcrCL8vJzzAkFWg@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: bd79124: Add GPIOLIB dependency
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Marcelo Schmitt <marcelo.schmitt@analog.com>, 
	Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
	Tobias Sperling <tobias.sperling@softing.com>, Antoniu Miclaus <antoniu.miclaus@analog.com>, 
	Trevor Gamblin <tgamblin@baylibre.com>, Esteban Blanc <eblanc@baylibre.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 13 Aug 2025 11:16:06 +0200, Matti Vaittinen
<mazziesaccount@gmail.com> said:
> The bd79124 has ADC inputs which can be muxed to be GPIOs. The driver
> supports this by registering a GPIO-chip for channels which aren't used
> as ADC.
>
> The Kconfig entry does not handle the dependency to GPIOLIB, which
> causes errors:
>
> ERROR: modpost: "devm_gpiochip_add_data_with_key" [drivers/iio/adc/rohm-bd79124.ko] undefined!
> ERROR: modpost: "gpiochip_get_data" [drivers/iio/adc/rohm-bd79124.ko] undefined!
>
> at linking phase if GPIOLIB is not configured to be used.
>
> Fix this by adding dependency to the GPIOLIB.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202508131533.5sSkq80B-lkp@intel.com/
> Fixes: 3f57a3b9ab74 ("iio: adc: Support ROHM BD79124 ADC")
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

> ---
>
> I am somewhat curious why the failure occurs only at the linking phase?
> Wouldn't it either be better to have these functions
> devm_gpiochip_add_data_with_key() and gpiochip_get_data() only declared
> when the CONFIG_GPIOLIB is y/m, to get errors already during
> compilation, or provide stubs?

Providing stubs is not correct for sure - a GPIO provider must always pull
in the relevant infrastructure over Kconfig. As for the former: it seems it's
a common pattern for the headers containing the "provider" part of the
subystem API, you'd get the same issue with regulators or pinctrl.

I don't have a good answer, I'd just apply this as it's not a common issue
from what I can tell.

Bartosz

> ---
>  drivers/iio/adc/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 6de2abad0197..24f2572c487e 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -1300,7 +1300,7 @@ config RN5T618_ADC
>
>  config ROHM_BD79124
>  	tristate "Rohm BD79124 ADC driver"
> -	depends on I2C
> +	depends on I2C && GPIOLIB
>  	select REGMAP_I2C
>  	select IIO_ADC_HELPER
>  	help
> --
> 2.50.1
>
>

