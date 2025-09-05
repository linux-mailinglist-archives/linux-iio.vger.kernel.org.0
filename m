Return-Path: <linux-iio+bounces-23753-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A7AB45008
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 09:37:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1ECA1C82644
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 07:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B60265637;
	Fri,  5 Sep 2025 07:37:45 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111ADDF71;
	Fri,  5 Sep 2025 07:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757057865; cv=none; b=t0G15BWvg/3X2/kBtqQeX1eOyQHaCsgU2Vb8xEQ3G0TcgVex/p4NdVpOBy7bs3pLwFlDcoP5JpJyWXaiiTlsQBXG2bbZLcp5B56FyhpJPWoT2+B+8nLM5kfE4AEzaw7ernE7DbIBsO7fAP+WDrAijtIVrz0GYKJmFI11lhVWA4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757057865; c=relaxed/simple;
	bh=zZ6OUkF3arMN0uqPqWBlucr5q8ZUtJb/8hJRQOLxenY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RjSUtvCW32rnTnUkK0oNk/YcZqQJvaiAg+NL7Jd8nAr6Ni+7iY6DSVWOIhkyZXhroHSp/E+Eca9qXc13LC1vMM/oy4gYCdTddrB9ncskjmtPQQDDJWej1ZKo31EMAOQkBY6HHOCG46geHd+YHPe77rOM/72VnMrAwV2Cp+gJjXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-55f7cd8ec2cso2466811e87.2;
        Fri, 05 Sep 2025 00:37:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757057860; x=1757662660;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HUDpg8P80ENhLzXkkjoWR5Wm8BjOXjAXH7uDrrOc9Oo=;
        b=LOE7cCr2RxKoCuPPrF8D0glrfCg6RPRoGCVCKvvX8WTQND0c+fijccFlTqXlWO25mq
         qyQC7yUT9bAs92Ej9I4Feu6V9Ai4BMaoXfkRvh79Pyq34aHHE3YK0cf1Jd7LYea2tgfS
         e3c9/FHO8iscXJ2XA9vtxAEgO9ZNo7VdvnDYyW1sriC8tqao+ZdmQn036nW2HK4E9oe8
         fx2L2nRndoSu8mprN/KEC2fRJAFKxKDTOQmVHZEchwHCEEydhQvuCQZuPHxTYESDy3lv
         VbkGKet4Mo4oPSjI+SgO8ZVbshD8FEPeLhrPBXLK88W8TUK7KGHSBTTTqWDJgujpSUEj
         pddA==
X-Forwarded-Encrypted: i=1; AJvYcCU1V/551cJx65uUU/DpowNf+bLJgfk7iTMd8irgqf31MEUGDT4H+DWIznoSBig0jhiW6CR0RdMhFbvAsOzzpDafa00=@vger.kernel.org, AJvYcCU8hN7sDYIFmwl/uePH8PyidqL4T+akwuEHvXSadtRBZ96Dj72kWqKbHfMMkh5uOQMsaGgbIosVc7kOm5A=@vger.kernel.org, AJvYcCUAqhaAFUy9QzDm0vattSvyB5owpodIJ4mdJaRIHto3mgwN6NG8PoX/EX+vt6eSAYgE/OFfcAOlnGa2Pomr@vger.kernel.org, AJvYcCV2lmxovrh0qA9exCk0OVe7mI7GYLMuBhESCB58pw87ad/DgOJe77cyzQyB3f/c3uGoxABHp8DIXZgsXQ==@vger.kernel.org, AJvYcCV4st7OMORSz5LvW/Wv+cifCo7KmeGJM4TXJ51rZcnB2jXiJnB8HigUYUn0pwFaGlHo0/IAw7W95QsBQNs=@vger.kernel.org, AJvYcCW9DaBhzaHrNw1IOfy78ereRvZUcX9K/RfqcnlcpQFKvLflz0sW3gSK3Zi0k9edZnWlHjArTitH5Kaxl/17LbTWVGA=@vger.kernel.org, AJvYcCWNMUQwCC5VRqewf112IgLV2U9OiIIMDIzQ3sMWwYdhneDGlP1TWyVCTYXnCJ+huxF36sma4o8AizhFW4L3@vger.kernel.org, AJvYcCWQ5GNjv6g3ixLSR/lqrxSEvbj4BZE9xMjYKz+yahNEtz/q5woa888OasMGfRLnb6U1Z1hJCzD/TI0=@vger.kernel.org, AJvYcCWQdS6Ng1FuYlBU5cqvAowfTiTg3C6jHTa4qDOcU/oBf9E4yTBirt5zaS7fhm4SiHVTRXw2HjWcyUkG@vger.kernel.org
X-Gm-Message-State: AOJu0Yztqb7IUw/G3xKnehMynnr6EQoB6n86wPpyq9A8cVcnJV3rKCfz
	rS1ASsYzAk1ZDAH89BkU3bA8JEXQgs/HHt2UKQ9AZk7aZKhvKkdAhPGg6tGAxx0tbaU=
X-Gm-Gg: ASbGncuMp/6FIrMOSPNgEAtXctw3ALwnSI8S9TxiURDrJ/hltO2OG/w/tWKHjhLoR4+
	6fdrLyRgblJXzrvn2zkl0hdGjcU/pJwnCtvu720SgzPLnAJhpQr5uv7XdXoTSgPawKAVo2KxTsS
	oqYlITG4NNLctjkk3rCotAU4aNCZdRaS+lQvQO9HhqEECOMUerQ66hc2ZP0sw9E9KOk04F7sosD
	7Hjq/4uCgFvosbJ4DevYwSDWssPjRAoTwCEqtcAz2LStzz+mfP2ZDDDGTJY9DcbjccL05JR2LRO
	atcu/t2yeRUzr7yMRmA9UWkDde7T9czXzmFModEz2uUcDnPSAiva2/GBXFaVU1Tqf/vakSbTT1A
	ndeiqRCGwqcSSL6/FA+crB2sYjdftV8HSz49ovEiBkwupwVux9tmoSN1PaYjddXUjoA==
X-Google-Smtp-Source: AGHT+IHBtSZMNHBX1uo73P5ryqj6fm/7Hpnx+HhyZwvLhOl8/3G5FqLUMCdCiLJBHYUzZ68kYMZRBw==
X-Received: by 2002:a05:6512:baa:b0:55f:48db:8139 with SMTP id 2adb3069b0e04-55f70969724mr7139045e87.47.1757057859716;
        Fri, 05 Sep 2025 00:37:39 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5608ab90ce8sm1633581e87.35.2025.09.05.00.37.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 00:37:37 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-337cc414358so17081071fa.3;
        Fri, 05 Sep 2025 00:37:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU1Jk1IWJjFJlc2ZZanOg5rCVkFKt7hW1Gr9nHBTnocJtn5+CRwqnzcUfC5WgQE3HXRTp4ebCAFAh/vnWrI7TxKN48=@vger.kernel.org, AJvYcCUDon54N64/3dLjqha9XReZi4IUFrqx/q4DyuQXDjl/GvvVyt8gi0i8Hp+kNnPWcIUlqjDv3cNjpwwR52o=@vger.kernel.org, AJvYcCULIdNnqQ9nDg1q/GvUnLzPGzDrmXoKmedHTjWCeWzoLn7qM0M3lfo0f007VibJiXt0xb8Si9eo0qY=@vger.kernel.org, AJvYcCVOHb9FjvX8GBqd2LGuAoVmIxDfMzE/z/UJSRg+DKlgvmIDWqJhUQQR2fcWtVe6LXbeA55T2Kf8o81PxT9A@vger.kernel.org, AJvYcCVPNznhEBC4fdTRuwhYdhh3EnJcl9yBHYOGy4dlKP/Xy2Vn4b9ofaxENiKJ7CuEexp1wCxZmxouKwZINFI=@vger.kernel.org, AJvYcCWFCIGDHJnigmAwrumiXplu61NKJs84PeoFZ9aiBRdU1JQk9H5CgA84c05XJrW8hiHpc49ILNMns3R1R5vkUbNoWL0=@vger.kernel.org, AJvYcCWLPKiCOsS4AVqK2NoGPiDduY+fBOPZgol1mxtyH2jOgENOM6dqnLY6Cya9Fd96JnqN6EldYGSsRC6B@vger.kernel.org, AJvYcCWkVIm1l2bylmo60ADdLo8IwiFSN/eUpNqWC23TNUidVaaOCk0x4CEUGi6nvg2vlpPhptvTWAuE/Zb1sBcA@vger.kernel.org, AJvYcCXj2XurCg1m26VIb5PLoyTASKpKVe7GcvhKr87Q6X6CHkSH/t2HN23jrhipHDhaHtPnV68nUewibr0IEw==@vger.kernel.org
X-Received: by 2002:a05:651c:1545:b0:337:ed76:7212 with SMTP id
 38308e7fff4ca-337ed767a08mr38641871fa.40.1757057857304; Fri, 05 Sep 2025
 00:37:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905072423.368123-1-zhao.xichao@vivo.com> <20250905072423.368123-4-zhao.xichao@vivo.com>
In-Reply-To: <20250905072423.368123-4-zhao.xichao@vivo.com>
Reply-To: wens@csie.org
From: Chen-Yu Tsai <wens@csie.org>
Date: Fri, 5 Sep 2025 15:37:24 +0800
X-Gmail-Original-Message-ID: <CAGb2v665Ukqdy2dxH7d=WKuLnWNz=Qwp3U+QxnrdfEPpwVL5mg@mail.gmail.com>
X-Gm-Features: Ac12FXwDAvrTIRtRT03_-9LcU10SU7B9zXfyLBZJD9DODV-PWNu2aOFrKkfI70k
Message-ID: <CAGb2v665Ukqdy2dxH7d=WKuLnWNz=Qwp3U+QxnrdfEPpwVL5mg@mail.gmail.com>
Subject: Re: [PATCH 03/12] iio: adc: Remove redundant error log prints
To: Xichao Zhao <zhao.xichao@vivo.com>
Cc: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Guillaume La Roque <glaroque@baylibre.com>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, Markus Mayer <mmayer@broadcom.com>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	zhanghongchen <zhanghongchen@loongson.cn>, Yinbo Zhu <zhuyinbo@loongson.cn>, 
	Amit Kucheria <amitk@kernel.org>, Thara Gopinath <thara.gopinath@gmail.com>, 
	=?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Heiko Stuebner <heiko@sntech.de>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Orson Zhai <orsonzhai@gmail.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Chunyan Zhang <zhang.lyra@gmail.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Thierry Reding <thierry.reding@gmail.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Talel Shenhar <talel@amazon.com>, 
	Eduardo Valentin <edubezval@gmail.com>, Keerthy <j-keerthy@ti.com>, 
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	"open list:HARDWARE MONITORING" <linux-hwmon@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>, 
	"moderated list:ARM/Allwinner sunXi SoC support" <linux-arm-kernel@lists.infradead.org>, 
	"open list:ARM/Allwinner sunXi SoC support" <linux-sunxi@lists.linux.dev>, 
	"open list:THERMAL" <linux-pm@vger.kernel.org>, 
	"open list:THERMAL DRIVER FOR AMLOGIC SOCS" <linux-amlogic@lists.infradead.org>, 
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>, 
	"open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <imx@lists.linux.dev>, 
	"open list:QUALCOMM TSENS THERMAL DRIVER" <linux-arm-msm@vger.kernel.org>, 
	"open list:RENESAS R-CAR THERMAL DRIVERS" <linux-renesas-soc@vger.kernel.org>, 
	"open list:ARM/Rockchip SoC support" <linux-rockchip@lists.infradead.org>, 
	"open list:SAMSUNG THERMAL DRIVER" <linux-samsung-soc@vger.kernel.org>, 
	"moderated list:ARM/STM32 ARCHITECTURE" <linux-stm32@st-md-mailman.stormreply.com>, 
	"open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>, 
	"open list:TI BANDGAP AND THERMAL DRIVER" <linux-omap@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 5, 2025 at 3:26=E2=80=AFPM Xichao Zhao <zhao.xichao@vivo.com> w=
rote:
>
> devm_thermal_of_zone_register() prints error log messages when
> it fails, so there is no need to print error log messages again.
>
> Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
> ---
>  drivers/iio/adc/sun4i-gpadc-iio.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gp=
adc-iio.c
> index 6b8d6bee1873..3b33480813fe 100644
> --- a/drivers/iio/adc/sun4i-gpadc-iio.c
> +++ b/drivers/iio/adc/sun4i-gpadc-iio.c
> @@ -640,12 +640,8 @@ static int sun4i_gpadc_probe(struct platform_device =
*pdev)
>                  * Do not fail driver probing when failing to register in
>                  * thermal because no thermal DT node is found.
>                  */
> -               if (IS_ERR(info->tzd) && PTR_ERR(info->tzd) !=3D -ENODEV)=
 {
> -                       dev_err(&pdev->dev,
> -                               "could not register thermal sensor: %ld\n=
",
> -                               PTR_ERR(info->tzd));
> +               if (IS_ERR(info->tzd) && PTR_ERR(info->tzd) !=3D -ENODEV)

I think the comment above is pretty clear that we don't want a failure
or an error message when it is failing just because the DT is missing
thermal zones.

ChenYu

>                         return PTR_ERR(info->tzd);
> -               }
>         }
>
>         ret =3D devm_iio_device_register(&pdev->dev, indio_dev);
> --
> 2.34.1
>

