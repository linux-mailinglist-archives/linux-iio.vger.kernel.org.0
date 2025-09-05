Return-Path: <linux-iio+bounces-23762-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66214B45339
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 11:34:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B8DF7A5A3E
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 09:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F896263C91;
	Fri,  5 Sep 2025 09:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CrYRj6Ih"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63B21E487;
	Fri,  5 Sep 2025 09:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757064873; cv=none; b=XUBNycb0EK8keuzKItQMTxS0XT064M8phz/IYtQfxm6CVFz/CDFUpyXLkvvXli3FEn9X8WOYymgDhR7ndmrpksRdlDQurN07nFlHggFZSvOVF0DA3HksMagJscV89IKyt39mRnSWYInC08tJggIg7YHKn2VDNhQJPBcR1h8OlyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757064873; c=relaxed/simple;
	bh=fxW6po38fpa+VnoP8FiDQdHk6gPNDw4WKNm1oy92zAc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CBK0rMxCbzHnt5xIMXO92xWHVVkQ+pOS1wOdifkNeh/QaCEmYbEalc7MLUA0QudFh8Ci0/OZ1IOZluFOontlzXXJp6pIDhKfCBo9ddkEcriacxiAUQgyD2wREVsCJBHp4KwDmchq2lBGUw0F5TvS589UI7UhCCpZ57Wcjcw6caw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CrYRj6Ih; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b0415e03e25so280465466b.0;
        Fri, 05 Sep 2025 02:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757064870; x=1757669670; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ZXKC69S7By8Ya1ZMREMZuen7JwS2/FHlmhonyDWpnQ=;
        b=CrYRj6IhCe9KtIQdmHHYgkjdQYfG4uBemTw3/P4ae1kVl3KwoYvcoWQ6px/wJ4QD3W
         Jwmqle5Ywhp/Sw/HW53nPA3RJQAkvnli6p3OuB95vreFxw1OspSfNRyuZTtc69ni6GUC
         5XuklFMOjHF+AWS40y+R9rj8ZJy2hQxqQqFiFH6ljfKBSSdhYPvIJBvzf8Zawzx/w0t1
         oJvw+w0WPDuflgpfYnlVNcJSz096kqGU/gMZo+YuOsiA7YYaRLrR7FoyGsqv+GoPdIRt
         5lDWSeFwjlxTCLUAUpCRZi39bZIjFyNV0omyAo6IcvabaP6Wxb1ZILpQeiOC1kswhSFp
         aLIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757064870; x=1757669670;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5ZXKC69S7By8Ya1ZMREMZuen7JwS2/FHlmhonyDWpnQ=;
        b=VXxKhhVe3ucTCgOwNX5WTE/425RIL3C/tJUvgjzBc+3q7OJkP/BN3f6LGCUSWj95yq
         h6LBDjttVupwOSd+A2sAWsqNOnhOFesz3lyB4mC51tOZ2CZw4ji9agwDapYWUFLAsOoS
         8dFqOUJ9FFI4mZKQjc8obQ8gOAYg0CrWM8U2oKFYuft0iNA+KI9KU6/T+ggHKi3YPRlp
         iSfuDtujLHOwsFeB9XGZxzmp1joMaSUVG9C//8tqDqJLh2ZbB/ozRwDKnLpo/5zNlrnG
         G727iiW67zZJrQmpnGZgvVSniou+zy7s8JszSaBhE08aqHQ/j+vwp5j1b41jRGOng/uG
         S8vA==
X-Forwarded-Encrypted: i=1; AJvYcCUasFWLteE+ZtgExUAlYUg0tSCCnz3272pLvNaco2Vf0UL+MZuQfIDnOeW7ySVxrGxFMBo33EHhkBWitA==@vger.kernel.org, AJvYcCUb5TGnJlyP9yHElYemQr+lbQHEKRgiQHC04aMvR5CoMD2M/H2soaoZJV7QnvRUXuABIL2KGn8guqq1BVx3jXzXcbs=@vger.kernel.org, AJvYcCUiYxI0kXVshUOVT4uyl8RZT99e0emtzH0TjlbxZsbwxI0YTDPn4QzSWlU3fThaCrxq6A/cHaifFSA=@vger.kernel.org, AJvYcCVPv6zv3oOAzkA8ezkkYYMQeM4oP71CFHyJU46ec3Lm+q8VnuP2MkQAcr3j755JIAGwIzQ7Rjojbf96OPc=@vger.kernel.org, AJvYcCW3x+HygORLmbFG3bUPDaa3Pj9Fm9FEuUAC19HniiBWUeG5VxJurE1Jt3JHCNhk9gHEKOEavl5K5iktPmM=@vger.kernel.org, AJvYcCWZ6tegJYq4VUj7IrzBIyQ2InSKcqR5mG6YVOQLI5V77WK2VYZYuN6fwemYVyPZvAkaH8KYIhpPXZtAo8uJnmdnvGs=@vger.kernel.org, AJvYcCXhckLESZaXDgJ3DwEo+rOY7PbPpMNb6/Shivvsznc3/09wxV9TULBqV9JyvmXeMK0TALSZ5l4IyJSokCoT@vger.kernel.org, AJvYcCXiDajjlA3H+CMZ20wvKwBGhOrSazCniOC988gBAVn2Cn39xQe/WrHjhH3UlboROjvz+FsbIwgTfuE57gSD@vger.kernel.org, AJvYcCXqyJSU6+pMhbyCcf1EreU3stmDacjvbVuVyr354WfUuCJfL/CsSWXGKPYcnbsqBbn6fbFSyrBCyd8w@vger.kernel.org
X-Gm-Message-State: AOJu0YwINcKARE4xHg5qYdGCUGx2Ua+8M2XVmAv2YVBMJJxBv8iravMm
	yPhoYLPamQM1OuCYMAHy4Kt3Frj21yIIjbrFqk+XpV/KR4QetqnFzta75lVw6Hs9vIUHqjOxG2s
	G1IsVirGZSDlDGFluI/a9CIVj9KZ+XoE=
X-Gm-Gg: ASbGncsuJy0d0Tp3t7B7B1hb6E7zSqoYWug6yVYIGEvisBHzyJ8RDztWChlOzmMhn1J
	KMsgqRBier6QKiQUFIVfjG9c1zTNWVtoBW9aevICccA990adfPboNgOLDotO/EKoW2C58FDD0Fo
	Cmi/ZRtNulcdWRPD9R6uzGOMZcmEJRQ1/XTeX3rPvbU5IJ/LG9iDhR+GYMl15S9T4JY05FZYCqI
	AK/PYYUOSaWxCJbhJGi
X-Google-Smtp-Source: AGHT+IFNrkynh+/Ymp/HCHyA5XGYRylr5jF6GjIL2qDKGYyZpbM+uW2yDfuf4gc8lpHjzkwCg5YwNrLoynQjYkyhMFI=
X-Received: by 2002:a17:907:928a:b0:b04:5b3d:c31f with SMTP id
 a640c23a62f3a-b045b3dc692mr1195506366b.49.1757064869658; Fri, 05 Sep 2025
 02:34:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905072423.368123-1-zhao.xichao@vivo.com> <20250905072423.368123-2-zhao.xichao@vivo.com>
In-Reply-To: <20250905072423.368123-2-zhao.xichao@vivo.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 5 Sep 2025 12:33:53 +0300
X-Gm-Features: Ac12FXxbms9z4N7jI4jHPwNjVwlV8d4OiE5hmfmL25yynmREhxdRP_mz9jzg-_c
Message-ID: <CAHp75VforxjsHWzxrxfD_YOshvg0Y=KwrpmAPWwhyarNm2wNjQ@mail.gmail.com>
Subject: Re: [PATCH 01/12] thermal: of: Add error handling in devm_thermal_*_register()
To: Xichao Zhao <zhao.xichao@vivo.com>
Cc: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	Guillaume La Roque <glaroque@baylibre.com>, Miquel Raynal <miquel.raynal@bootlin.com>, 
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

On Fri, Sep 5, 2025 at 10:25=E2=80=AFAM Xichao Zhao <zhao.xichao@vivo.com> =
wrote:
>
> devm_thermal_of_zone_register() does not print any error message
> when registering a thermal zone with a device node sensor fails
> and allocating device resource data fails.
>
> This forces each driver to implement redundant error logging.
> Additionally, when upper-layer functions propagate these errors
> without logging, critical debugging information is lost.
>
> Add dev_err_probe() in devm_thermal_of_zone_register() to unify
> error reporting.

...

>         ptr =3D devres_alloc(devm_thermal_of_zone_release, sizeof(*ptr),
>                            GFP_KERNEL);
> -       if (!ptr)
> +       if (!ptr) {

> +               dev_err(dev, "Failed to allocate device resource data\n")=
;

We do not add error messages for ENOMEM.

>                 return ERR_PTR(-ENOMEM);

Even if you want so eagerly to do that, it should be

   return dev_err_probe();

But, it will ignore the ENOMEM error code for printing.

> +       }

So, the bottom line, no need to add this message here.

...

>         tzd =3D thermal_of_zone_register(dev->of_node, sensor_id, data, o=
ps);
>         if (IS_ERR(tzd)) {
> +               dev_err_probe(dev, PTR_ERR(tzd),
> +                             "Failed to register thermal zone sensor[%d]=
\n", sensor_id);
>                 devres_free(ptr);
>                 return tzd;

I don't see how ptr is related to the mesasge. Can't we use

  return dev_err_probe(dev, PTR_ERR(...), ...);

instead?

--=20
With Best Regards,
Andy Shevchenko

