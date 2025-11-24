Return-Path: <linux-iio+bounces-26430-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25879C8164C
	for <lists+linux-iio@lfdr.de>; Mon, 24 Nov 2025 16:40:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C89523A32EF
	for <lists+linux-iio@lfdr.de>; Mon, 24 Nov 2025 15:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D2B313E3F;
	Mon, 24 Nov 2025 15:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B71CXKXG"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DE2303CAE
	for <linux-iio@vger.kernel.org>; Mon, 24 Nov 2025 15:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763998845; cv=none; b=ApT62bcuHasqbx2VuIsNDuMrtqHhhh680p9gPxjqN2TuLagtqiuVKhK9g1pFtbkQlaXFYAsf+fBrjD4FMhLAp+24vXVwSerNIUYDw7NLrBd8S1JH0ZJQ9UF9YYBDCx4BnVQ+eBhviN7H3OqWsZ7IHyHe982VeNeffZSQj1ntgEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763998845; c=relaxed/simple;
	bh=Ur80bf67IWJP9P3NyHLEyhZMGM2yEXjoM26RAeQoVDY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q+Q3aLvKHmccVAD7zH6ddVn6sAIlMON1eyHkFvksbYpNGkLogPhOjRhjJGodNI7WDdXLfib3DUg8nuFYgBeUx3jN1PPnR4XwsQQLJxAcb28AXcDn8RIFzmC+3WyQGlqRrCiFO7OQ85W9b3hxY81gVCf/ameLi1/A6LoVa2towHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B71CXKXG; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3438d4ae152so4940945a91.1
        for <linux-iio@vger.kernel.org>; Mon, 24 Nov 2025 07:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763998842; x=1764603642; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=Llp8FG6WVJOxC42YZnLNsTS0zXwdgkxLlwBk+kzHwR8=;
        b=B71CXKXGRfl4sO0Qd4Bp3nwb2CR0DYeEU05+DJf3VB2iALLwOVrDANowFVPuyt8jG4
         P4f3SEx9KrnIV6opSeFm2y6TfC2DlzsPscmZ0T8EPXWIhBVazs8GtRmLgVFVOtQy9bgM
         bBJmEF3TYWU8z8ykZIhO8383OYuNk/paUf+6e5g18cg8M+jBwy7Ip15szx1CoTS2UPDP
         F0XtWn9XSpSeUt59CEndLHW9k97WQQ+snM/q7pu7aH/asJGE46znCRvh8b8STAUgvm+A
         hcKZbIMlwdPPMBHXy3Yc9kFdiqfGq1TiWRHf8nq/9tN8VW7Ag7aRkDmPdYRAsjXfc1He
         8urA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763998842; x=1764603642;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Llp8FG6WVJOxC42YZnLNsTS0zXwdgkxLlwBk+kzHwR8=;
        b=lz2NrKne1Ql0Ax+GX5eswb0esHjN19iG6ps8FYszsH/KsguhHFdvJSv309mERIUOqb
         0hddTESKDgiMP9YxzqlIiqLn3jjDVeO+tgzIbKZcOlKa1VpC/vvai882qPo6P+4KysNI
         QHcf1Tol7npyEqeC6xNtGf9FcbCzgOithTKj++fbDWLBDsImXybO9C/u7sozAeEjHTT8
         Yl6NlnTGXj0Na5foPTelFODQ/PQKl5KEip4FHaOSNjU8uwFNXchVGjAKSYsLuZtQdr0S
         IBJJBcNogCm5wpNwl7Vw0x++ricFKL6KOtE4Fu5/MS7Fxh/9lqLkZXbEqOXW+ZQwjn4k
         /98Q==
X-Forwarded-Encrypted: i=1; AJvYcCV63GkoiPzXeN1zKII5A2/CyUncnVteJ5TrvICyh6EgE3yV0GraidFXBsepRvUoAHNh00l9nhSzL1I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUutkHuwUdnVxCWAIcljwOeWC4lHM5/fhOun/ivbfkBt/L/Kz9
	ARgrst8CQndkeZG7FK5YYmle93gAWEUf+F1BxmBwdb8cq6BAnqZqplzP
X-Gm-Gg: ASbGncuAOiUPd8oja4PhtJqucYz50ycTXSLX2RlLgGiKJgXYxZFfSV3NynsVHhLDcun
	XRcbFg05aQ5bdJc8svkvZHwWs2Aff9jggtoghRIG1xE8TWbk1k5UEX2EQGSWaAYNoiWj7KNYqUa
	J8UU7uAPFDDOBTtDweiLdGABLBj72LyCIQl3LkaWZftWf/xssDcgg/eC78k97QlTh5Gc5ish4yW
	CFj4JC8bUMmoANfUoeXsotO3yO/Dh2HZkr7kUo25Wg4I/uaq2WgS4EkF8zjwIWV+COpOeYl5Psu
	YCFCfx/LaFJJTTxIjTHY/egXYRV4ARZaMTSLAShTHxQoqfdI32MpWsxKu8xGIq/Lr0yA3A1mp2V
	r7zV6GzRSXHm++A08F6hULyINzepGaRVpyu7KbSCEgwkI4EnizBWgedt0YpFkdekPqqDrItdI4F
	XrmGiRwL9Iw/kQAnY/X/HUDhe76065F8plxYzgWJfrz9nbBVLfhFuQoXHdp8I=
X-Google-Smtp-Source: AGHT+IEFPQhBfCYRI3nTm1u+iQCIbAQZlcFtON++Fnq7DdJGduD9vDQYDBrSvMWcgiV0KUw17gd6Yw==
X-Received: by 2002:a17:90b:5112:b0:340:bde5:c9e3 with SMTP id 98e67ed59e1d1-34733f2d207mr11198788a91.23.1763998842365;
        Mon, 24 Nov 2025 07:40:42 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3472692e5c8sm14034703a91.11.2025.11.24.07.40.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Nov 2025 07:40:41 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <da5457ea-c1ed-4c90-8743-fc982a02ed88@roeck-us.net>
Date: Mon, 24 Nov 2025 07:40:37 -0800
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/6] Add support for the LTM8054 voltage regulator
To: Romain Gantois <romain.gantois@bootlin.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-iio@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>,
 MyungJoo Ham <myungjoo.ham@samsung.com>, Chanwoo Choi
 <cw00.choi@samsung.com>, Peter Rosin <peda@axentia.se>,
 Mariel Tinaco <Mariel.Tinaco@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Kevin Tsai <ktsai@capellamicro.com>, Linus Walleij
 <linus.walleij@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Eugen Hristev <eugen.hristev@linaro.org>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Sebastian Reichel <sre@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Support Opensource <support.opensource@diasemi.com>,
 Paul Cercueil <paul@crapouillou.net>, Iskren Chernev <me@iskren.info>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Matheus Castello <matheus@castello.eng.br>,
 Saravanan Sekar <sravanhome@gmail.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Casey Connolly <casey.connolly@linaro.org>, =?UTF-8?Q?Pali_Roh=C3=A1r?=
 <pali@kernel.org>, Orson Zhai <orsonzhai@gmail.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Chunyan Zhang <zhang.lyra@gmail.com>, Amit Kucheria <amitk@kernel.org>,
 Thara Gopinath <thara.gopinath@gmail.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Olivier Moysan <olivier.moysan@foss.st.com>,
 Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Dixit Parmar <dixitparmar19@gmail.com>, linux-hwmon@vger.kernel.org,
 linux-input@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-pm@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 Andy Shevchenko <andriy.shevchenko@intel.com>
References: <20251124-ltm8054-driver-v4-0-107a8a814abe@bootlin.com>
 <24527d76-4f6a-4008-a369-23510d492a94@roeck-us.net>
 <23111366.EfDdHjke4D@fw-rgant>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <23111366.EfDdHjke4D@fw-rgant>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/24/25 07:13, Romain Gantois wrote:
> Hello Guenter,
> 
> 
> On Monday, 24 November 2025 15:57:41 CET Guenter Roeck wrote:
> 
>  > On 11/24/25 06:48, Romain Gantois wrote:
> 
>  > > Hello everyone,
> 
>  > >
> 
>  > > This is version four of my series which adds initial support of the Linear
> 
>  > > Technology LTM8054 voltage regulator. The driver supports a fixed voltage
> 
>  > > and a tunable output current limit using a DAC-controlled pin.
> 
>  > >
> 
>  > > I'd say that the most unusual part of this series is the usage of the IIO
> 
>  > > consumer API in a regulator driver. I think this makes sense here, since
> 
>  > > the regulator driver has to access a DAC to read/set the output current
> 
>  > > limit.
> 
>  >
> 
>  > I don't think that is a valid reason. Literally every driver measuring
> 
>  > voltages or current uses a DAC to do it. How else would one convert an
> 
>  > analog value into a digital value ?
> 
> 
> Sorry, I don't quite understand your remark. To integrate this voltage
> 
> regulator component into the Linux regulator abstraction, I'm providing a
> 
> current limit control function. To provide such a function, the voltage level
> 
> on a pin has to be controlled. AFAIK, the kernel abstraction used to set
> 
> precise voltages on lines is an IO channel.
> 
> 
> Do you think that using the IIO consumer API is not correct here? What other
> 
> method do you think I should use?
> 

Ok, I had a look into the datasheet. Unless I am missing something, the chip doesn't
have a digital control or monitoring interface such as I2C or SPI.

At the same time, you copied the hardware monitoring mailing list on this summary and
on (at least) one of the patches, but apparently not on all of them. This lead to my
apparently wrong assumption that iio is used to monitor (not [just] control) something
on the chip. I wrongly assumed that IIO is used to report chip status (voltage, current,
temperature) using an internal DAC. Obviously that was a wrong assumption.
Sorry for that.

Apparently you copied the hwmon mailing list for the introduction of an IIO namespace
and its use in a couple of hwmon drivers in one of the patches. My personal opinion
is that this should not be part of this series but a series of its own. That is just
my personal opinion, though.

Guenter


