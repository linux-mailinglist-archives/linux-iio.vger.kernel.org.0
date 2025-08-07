Return-Path: <linux-iio+bounces-22420-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57CBCB1DEDD
	for <lists+linux-iio@lfdr.de>; Thu,  7 Aug 2025 23:29:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44A2D18C118D
	for <lists+linux-iio@lfdr.de>; Thu,  7 Aug 2025 21:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB988242D88;
	Thu,  7 Aug 2025 21:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mzR2A4CW"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6464430;
	Thu,  7 Aug 2025 21:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754602147; cv=none; b=IyQdbR3N3t44BFoQGIILifWbaZWmDrMkZdy/4g/ghxMR8XbyJrYRIiw8LdOJtMkn2pQV2zVpHqmUqAGJD47aH6pOQ5BN3m0ZIaLd3eDzxPQEsMa+iRjfri94qL9GEaiF8R48P+fPFRQ5/ppGcQZGKzlE6M1MY/zpIvl/sKQw47M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754602147; c=relaxed/simple;
	bh=e5ZroBIz+n4D+tQJf8o64lB4daFJ+ZpSVvOGHo1c41U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CHeazdRYgJ4VefnJCZNkmvzprZ0Ae2DxkjsDHWdPRNtoovR55Bu9YA/Pttn/N0EKbpRONa8/WqlklKypIJKSK+rC3yWLS7XZfgwIeX3JCxy7q8YdLWSkxUZFnJyRt2Zev0eSLaXBQLo9MGw69D4Mt3aeBetSttHRtr00F+mYgXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mzR2A4CW; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-55b88369530so1657383e87.0;
        Thu, 07 Aug 2025 14:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754602144; x=1755206944; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2o6wy1hxsqYKmmF+f3dxWhM/eGBJynYmK8a0QZYd+z8=;
        b=mzR2A4CWxPpIkaILWT1LBwO25IM+M/5vsPAyTlOlDZQ942I5lB9C7jyjRtSOujsUle
         Jof7y7Xhu5z77tuj3iu8My9oZEA429psYAQupe6nol3zyPQTVyFZHe5eZXC6ft2r1aVe
         DTq47BoAaIIy9g9tzL5iPGbmQHDGAXVRGkE/jLBuLBBpHRfgj5KD48+NNt9Cq2hVQiOA
         zf85jJAB+FIhOTI4+G/1WVvWN4Z0a4/Xe7OKwz/OHB/RfaKpReFixP00j80CZUlNd5yL
         jLWQ8/0sZyQtflSwnIZyc1eYfnX+zjbYAi7zKB/j4qNr7ksqD0NS00fLrHDB+WN+NHHb
         CDxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754602144; x=1755206944;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2o6wy1hxsqYKmmF+f3dxWhM/eGBJynYmK8a0QZYd+z8=;
        b=eBdECQvrP9u8xq7L+GoHLAC1PJKnX+StSfm5qYi62/2ws74rLiAet64FdVUNcpo2sW
         QJvfQe/lAWx0ZcvhU0S+SeCKP7rfFQVznoDjZb6dsFmTpb4lMysbJz+5Bvrq6sWFgIb+
         MdADsIEq5e3DdAqDu5a8ivAqhJXLzd1vcKlJdofvcRJXFnDT1LmAsBWKn81QLd98TpVy
         rlVJdB6maW6+2VrU/Jl4vKERgz5ix32Yuq8YtC2WoeDv7MkeTY4wk4aGJ63PjY12WzYk
         IY5yI9zAJJUqNr/HNTikzX3TwnR3c+ADS7GanBAwdXiqVw+KtYNyw43CYD8nXhNSHD4H
         OCEg==
X-Forwarded-Encrypted: i=1; AJvYcCUEqCEmD9ZhfGoI+M+SMC0pRIU+3Sz9Fvtr6g54m+Dz6XfkEaUwJIFh2erdmbGdkM8U/bgO1ENmDh/d@vger.kernel.org, AJvYcCVEbuGMx/x5f2U0b+P/CwTuCvjkV3oF8Cg3/6oEymlJgknSnG/uIk0QtqHqDL3Vkk4qCDG6ouLOCyGV4piJ@vger.kernel.org, AJvYcCVP1m0V5BTKph1BEBXC2NeRLTwycJYWH6lTEzDVd0SMG4ttNoQ6VdneVAWmf0TKFDy/9obBy7jtagKh@vger.kernel.org
X-Gm-Message-State: AOJu0YzTXcAwS8CDZTSoHU2ecQB8y3bVaZhe2PWCs15LL0zdGyQLtlMX
	nEby8Dhi9ovOeay++FBYfE1itHWzfwtEIplNmBncvUzDTdSD/TJru1A1RdgPOKFB4+Dp9qFuDHD
	5TRZXDS6rWRpl91UxMQvfaaVa9QtGKoY=
X-Gm-Gg: ASbGnctWrPiOqp3EXQp5yAu1JqXYiaXTgvojflquc1AWLQNdpV2fvPpBAYsXTGaSCTf
	dXpwPrVjqIRIEL69wa0ndyI3eMwuZUy2GytbcwNazEtuBWtCT2cZ3NHj9Jnh/TNLjJEkThTDDD1
	+CyIE/x41wnB+qAJ66somWtyM0FlGMIEHBpzLBO0u8C1gAIjPS6vukYDy/Mo0U3W8bGGKwn734h
	3AESuYT978swFlmZZiQEqCVi3z5qnaDLSLLGfySLg==
X-Google-Smtp-Source: AGHT+IF2gn9Jbw2iuW9TmBoqCfY6sXuVmxhSrPEdUtl5zQbjv/HZcAEM7A9krusR9oI/gvhf/frzYunkfyCgqaF6we4=
X-Received: by 2002:a05:6512:39c3:b0:55b:8273:5190 with SMTP id
 2adb3069b0e04-55cc00eb78bmr91681e87.18.1754602143932; Thu, 07 Aug 2025
 14:29:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1754559149.git.mazziesaccount@gmail.com> <da7e6b31a0f25106d7e2f56fb089c8fe71224654.1754559149.git.mazziesaccount@gmail.com>
In-Reply-To: <da7e6b31a0f25106d7e2f56fb089c8fe71224654.1754559149.git.mazziesaccount@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 7 Aug 2025 23:28:27 +0200
X-Gm-Features: Ac12FXwukEbIXj-ZESPmfX-vzfO2suKhMqGuLrQ8trHV1ZCoeJdpa7KaO-sFewo
Message-ID: <CAHp75VfBvqzKR53qTbiGxE-JQdLOuA3+M-Z=9S6LTf0fGnwmvg@mail.gmail.com>
Subject: Re: [PATCH v2 09/10] iio: adc: ad7476: Support ROHM BD79105
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 7, 2025 at 11:35=E2=80=AFAM Matti Vaittinen
<mazziesaccount@gmail.com> wrote:
>
> The ROHM BD79105 is a simple 16-bit ADC accessible via SPI*.
>
> The BD79105 has a CONVSTART pin, which must be set high to start the ADC
> conversion. Unlike with the ad7091 and ad7091r which also have a
> CONVSTART pin, the BD79105 requires that the pin must remain high also
> for the duration of the SPI access.
>
> (*) Couple of words about the SPI. The BD79105 has pins named as
> CONVSTART, SCLK, DIN and DOUT. For the curious reader, DIN is not SPI
> ISO.
>
> DIN is a signal which can be used as a chip-select. When DIN is pulled
> low, the ADC will output the completed measurement via DOUT as SCLK is
> clocked. According to the data-sheet, the DIN can also be used for
> daisy-chaining multiple ADCs. Furthermore, DOUT can be used also for a
> 'data-ready' -IRQ. These modes aren't supported by this driver.
>
> Support reading ADC scale and data from the BD79105 using SPI, when DIN
> is used as a chip-select.

...

> +static void bd79105_convst_enable(struct ad7476_state *st)
> +{
> +       if (!st->convst_gpio)
> +               return;

Still consider this unneeded churn. 3us delay is tolerable in almost
any setup with this driver.

> +       gpiod_set_value(st->convst_gpio, 1);
> +       /* Worst case, 2790 nS required for conversion */

nS --> ns (SI unit for seconds is 's')

> +       ndelay(2790);
> +}

...

> +       /*
> +        * The BD79105 starts ADC data conversion when the CONVSTART line=
 is
> +        * set HIGH. The CONVSTART must be kept HIGH until the data has b=
een
> +        * read from the ADC.

Is this terminology in absolute levels of the pin or logical ones
(that implied active-low)? If it's the latter, use active/inactive
instead as the GPIO subsystem does.

> +        */

--=20
With Best Regards,
Andy Shevchenko

