Return-Path: <linux-iio+bounces-23738-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 002ADB44E54
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 08:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44A46A015F7
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 06:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C55412D24AB;
	Fri,  5 Sep 2025 06:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BxoI3MXK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D916A2C3250;
	Fri,  5 Sep 2025 06:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757055328; cv=none; b=I+Sj/oDpjkrVsFyLCkUB+DfmhzI31Z1r1WPU3mZd7X4rNODYi9GCAQLXQEZV7/GJaGEZ8YUxoTjUc8QabgLzmqwFbRSPYX9zzx/K+5P58Jxd3iOypNWjVAMZ7HNUzTwz+WzjdhVCAryByOwj699Q/R/MfdAdXkIVfLvHb6EHX98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757055328; c=relaxed/simple;
	bh=x7s9l/pbx86wShxLXuwb3Wn6Ba1g6VdMu2rOEHVva90=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bXShy8n+nya4PJiOwNFtXYGavy+uNuz234zxFK+YA51vPTTSFhfI/K2KnWES3nGfS7MAMXlGHfu+RUstrr5ruW0+J9Pcz4IsnSDIPkhhBPPgb6pkCDQMuC76m9qpGh8kFFzOs8PzuJeHuhrYPIyj2OZVQymCUUlopINJOletZFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BxoI3MXK; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b04770a25f2so267645266b.2;
        Thu, 04 Sep 2025 23:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757055325; x=1757660125; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ps2alm7Qst/CrQIQ4Z48mSSun508P/+rPslHtvt6Zw8=;
        b=BxoI3MXKuLL6Cwwj31sgh05VArSmaAni0uBxYRPKFBlFxgphKZYQ0Lo2hoagPS70AF
         J3C4e50IJB0QrAjiZL5y46XnAFc25nR0D63Gv4OU34KN9XcTUFmfO/Y656FAKV45tE9F
         JWrF8cDJ+SAXM5JfqVFoMNNHxP90xbfgZfr0aPHHNZ+c6h35xszYNz2vrn/ww59WhncA
         FCevY7p4xS+JhDQVRoqt6RGE0PbgigrdI7Ne3ecsc7rhiXMDiWpAjeOfq+/qqT1qOQVB
         geCUc17dpMGWdvWKUtZRgDOZWgLLjLK+iwxuXHtwoxYFKwil7erP6lszMabxmyUJ8rnS
         XUpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757055325; x=1757660125;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ps2alm7Qst/CrQIQ4Z48mSSun508P/+rPslHtvt6Zw8=;
        b=uG+I4wHVd3EfkPkWUOA+z53sR7Y9lymSOZN20Ytv/VZx1pK8DWsdD/Q7EBs7w3oHve
         g/Z+yc7jCMhBioy95Evxnd7TbEEmIQKdoxZ1jmAN0IOqLVQhvnspM4eYKBjHRezXjGYi
         cmGLXBeNJQy77YbBHWZmKzAFNJV1/cbXG/J4WETdzy0UWXFIpfr5U/Ntd5SNvdak9MfS
         iLMXlZhqU73Pv/UIsh35vwJGYV/lPfYoQQwO6ATSTA02pFimkWL0SB3J+1mrNxqIklE5
         a3utExC9VSZno5/wu8TDtYKhKWZhcWnr8k1tww0q1x90jAK6jszI/gTriBXfRDA0jEpM
         lP4w==
X-Forwarded-Encrypted: i=1; AJvYcCU9B/FDIinWiT3XgvcnB6lHaCPNi7fXxJPZC9urL5XVn3E1MxyH9Pk5ofhT3FG7MgPyXTp4thM0c6PrX/nt@vger.kernel.org, AJvYcCV+CUjCXzaRlN/x40m4OMOpAXsELUIL0pKVHujPhKVrGiVrim4EdCu496d2Q7dIwAWRqTZcWkRYnyhN@vger.kernel.org, AJvYcCVgY5VnjV/HsgxdgEYKkbrzfBXRA0IWrkEgqadguFjkLM1CtRSp/jzisyoO9XnxXWAOy6SYeCYP+UcF4A==@vger.kernel.org, AJvYcCWMkvtaIFfekdpulYteIkkBQhfz2V+YROgT7OV9CjeebCpSACrVvw1nb9iAZ2Bm91tK+GkVcuQFLTPo@vger.kernel.org
X-Gm-Message-State: AOJu0YzXRTYOMF1x+02EIBpdXzwszUAbS6K2UlbprcBSesjhlBZc6n8Z
	ZRgHmhptt3I3soVTXT69WZteVhk/tmWN0+3pKmozzYm7EurZnci2SzmjNxdYoJB3UMvJ1I4e9A3
	ZJRMWnp1JIXYbpCSRYm32/0t3Xyjypf4=
X-Gm-Gg: ASbGnctvxoGlm1t/3nZDZCMm8fuYS8KKSXZ0TwxPvahgyFpG1H/zqHsgfR4rueOLtDn
	Kqo95eXE9etJe6F7cPcbLbTAS8xpeEAtOolRTa6ok9o3rZK/YxvOGAKCuDKjNagFZj3GBBg2PQY
	cPzI129LNLlnn5w0vo8FUigiXyzuOXemj78UvbLizHuhc0GXDGFYqlDT3QBNyorHrKVBJbpeCc7
	9z02qM=
X-Google-Smtp-Source: AGHT+IHBr0uSK+I1LWjUDNQt/UogN8+LrAe68oPCGVClcBJ8H1wuyAECDIC+LspA1jjMHznaIrllVQvaxS5IJ7LBgHM=
X-Received: by 2002:a17:907:3d55:b0:afe:9e58:754d with SMTP id
 a640c23a62f3a-b01dda8645fmr2093915266b.64.1757055324922; Thu, 04 Sep 2025
 23:55:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1757053456.git.mazziesaccount@gmail.com> <3cc1faffcb4f71f0755b6192f193acecd36bea67.1757053456.git.mazziesaccount@gmail.com>
In-Reply-To: <3cc1faffcb4f71f0755b6192f193acecd36bea67.1757053456.git.mazziesaccount@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 5 Sep 2025 09:54:48 +0300
X-Gm-Features: Ac12FXz_6fa_cskueRP-AtbVdH-3UvVwuIvc3IqszVtR5agTuNjCBuimOxdLEwg
Message-ID: <CAHp75VdaAH+1mh16KWoYtYFMV+_ec8x9YipeD3K8g6yQr-2VjA@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] iio: adc: Support ROHM BD79112 ADC/GPIO
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Marcelo Schmitt <marcelo.schmitt@analog.com>, 
	Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
	Tobias Sperling <tobias.sperling@softing.com>, Antoniu Miclaus <antoniu.miclaus@analog.com>, 
	Trevor Gamblin <tgamblin@baylibre.com>, Esteban Blanc <eblanc@baylibre.com>, 
	Ramona Alexandra Nechita <ramona.nechita@analog.com>, Hans de Goede <hansg@kernel.org>, 
	Herve Codina <herve.codina@bootlin.com>, Alisa-Dariana Roman <alisadariana@gmail.com>, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 5, 2025 at 9:42=E2=80=AFAM Matti Vaittinen <mazziesaccount@gmai=
l.com> wrote:
>
> The ROHM BD79112 is an ADC/GPIO with 32 channels. The channel inputs can
> be used as ADC or GPIO. Using the GPIOs as IRQ sources isn't supported.
>
> The ADC is 12-bit, supporting input voltages up to 5.7V, and separate I/O
> voltage supply. Maximum SPI clock rate is 20 MHz (10 MHz with
> daisy-chain configuration) and maximum sampling rate is 1MSPS.
>
> The IC does also support CRC but it is not implemented in the driver.

...

> +config ROHM_BD79112
> +       tristate "Rohm BD79112 ADC driver"
> +       depends on I2C && GPIOLIB

Still I2C?

> +       select REGMAP_SPI
> +       select IIO_ADC_HELPER
> +       help
> +         Say yes here to build support for the ROHM BD79112 ADC. The
> +         ROHM BD79112 is a 12-bit, 32-channel, SAR ADC, which analog

which --> where

> +         inputs can also be used for GPIO.

...

> +/*
> + * The data-sheet explains register I/O communication as follows:
> + *
> + * Read, two 16-bit sequences separated by CSB:
> + * MOSI:
> + * SCK:        | 1 | 2 | 3   | 4      | 5 .. 8 | 9 .. 16 |
> + * data:| 0 | 0 |IOSET| RW (1) | ADDR   | 8'b0    |
> + *
> + * MISO:
> + * SCK:        | 1 .. 8 | 9 .. 16 |
> + * data:| 8'b0   | data    |
> + *
> + * Note, CSB is shown to be released between writing the address (MOSI) =
and
> + * reading the register data (MISO).
> + *
> + * Write, single 16-bit sequence:
> + * MOSI:
> + * SCK:        | 1 | 2 | 3   | 4     | 5 .. 8 |
> + * data:| 0 | 0 |IOSET| RW(0) | ADDR   |
> + *
> + * MISO:
> + * SCK:        | 1 .. 8 |
> + * data:| data   |
> + */

What I meant in previous reviews is that the | are not aligned (in the
same columns). Is it on purpose? If so, I can't read that as I don't
understand the meaning of | in each case. For example, the data starts
with 0, followed by 0, and the latter one is when SCL is #1? Okay, but
how to read IOSET that overlaps 2 SCK cycles and is unaligned with
times... I'm really quite confused by these charts.

...

> +        * Ouch. Seems the pin is ADC input - shouldn't happen as changin=
g mux
> +        * at runtime is not supported and non GPIO pins should be invali=
dated
> +        * by the valid_mask at probe. Maybe someone wrote register bypas=
sing

wrote a

> +        * the driver?

--=20
With Best Regards,
Andy Shevchenko

