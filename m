Return-Path: <linux-iio+bounces-23763-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C80CDB45348
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 11:36:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA6C1168337
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 09:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A35270572;
	Fri,  5 Sep 2025 09:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="deDpXCv/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E7A1FE45A;
	Fri,  5 Sep 2025 09:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757064974; cv=none; b=aoeUL1J0+Y91v2uMqHZB6pVcKxkd/MBxTuJStnuP0xcNkTY28J6BTWpAWTCkstcs9bNHixUy3MjNtUJ4viPK07h7/Nga1kFl7n9QjrbGH+boBYMt8PdNyCLKQLkhwWOhMFSV86MxsyIrr7uBFh2GcyvlGf0A0Oz6MK5crmw1G7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757064974; c=relaxed/simple;
	bh=KmBSaHkbj+xeQP4PQxDtYAKPe6uOtfo1+bk6LyYR/PI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sr0kBUVJaRIDxyTbrl3b37o3ttocykwmlLe0iIsGnoimIvhGEebLWxba+wKOY7HWfrz3sxK0D3Tv5Q/CP7xxIp13lNO0NHb3QQGsiv1VhZcLc1Ru01hVr62qpc8F7xGtXZLSB5sczQhqgGB4wPn16PwZcQIDEH5mqn2ucSeqaeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=deDpXCv/; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-afebb6d4093so386123966b.1;
        Fri, 05 Sep 2025 02:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757064970; x=1757669770; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nqf6D6Y//+lOVA7z+yQJwo2jJaSIwyijSnsvcGjMTK4=;
        b=deDpXCv/FmFzzDxZXrtDrTVu1GpOCP3E5y87hhjLNO77b7d6rcOd5KJVz4IuR4Z1TJ
         OasKITq4r0hBshR9I6YKf9yGjxO4LMbO2HRTPjjpXS2vYYSswEHKkzwIACBiFCZwGdgZ
         +dADvcmb05ixyHvRWoGjr4gXJbAT7wYfGj45XnJkJZXTzf10xrJJ5oKnPo2hqJgDCXfg
         FuKxYOrLUcV9/xNwdP1XAXbzHpjnvWTXzK7/27LtyTwXTP2iJE3i8wKO8ZOWMFlJ03J1
         cieUqC2jMYWOR9bWMAUUkrwcOfDNss2+d3vqOlNudBL4NYkrh3FPy1QPhklOEenIcmF3
         OJtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757064970; x=1757669770;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nqf6D6Y//+lOVA7z+yQJwo2jJaSIwyijSnsvcGjMTK4=;
        b=hgOVDyz1z0n+3Oh5Rjzm2jrZm5AyD9XE6l6E86VzS5Casgx2tgeXs7Aa31FDRy/fHX
         m8LxG6b+CetpPiUyMXbIfktz/KQ4q1iuxuWFN3IdcezVOySKIcyEUd4lP3GACtz6KrKU
         AFj9kNiWffqA/ahAQC4UdZtnz8XKE0nxA7VgJje8CT5c88eLeHuqbTxPJ5xQyOpaT2lW
         wtbTFotR9htmOXC7IxDXl3W//wfHcApbb2cqP1JoJUCX19amM1dHnPlwy0YHVod0SeeL
         g5UAM1tX2qoMisaxHIWlC2MbS0nRphYUjSGgBLjBUP/lcMnYX/ceg8hpM2MHwdcXFHaw
         +7eQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/NW7xderCxhCE/yBsBmyTqAcg0LWmCZ8ekEOg0CQnEKxw/SAK8Ztili1pwN7/TeRLsS1n0XB8pfOvOJU=@vger.kernel.org, AJvYcCUVtU9Spkc5nhqNgfVybjcSn1N/eRLUmFXkd9yeP3WRrJripn0u2uwSiZUqwRfaPx1RqBhRBjPNO2A=@vger.kernel.org, AJvYcCUdlaF9U2pCWdUc37nx14ix8FmdDHzdJC5MxNP7EmQmFk3zKDk2/IO+NVR2uuiyMQ7g4Qv/Q9tooPJAW2A=@vger.kernel.org, AJvYcCV5O1td6qzdFXHdOwzRatghSVeDY2ml5q1VznnSSfkigrHoa/Y6HhDg+0PX+cMhlNB/tDTxSFBa4UEnmRlC@vger.kernel.org, AJvYcCVB54KmCgVKdn/AMyBYk3l+3QgrzrYl14+bIIWPpt2VuB1ocn/ZojcL9e3JkxgTmCxrRuA542h5V9j90g==@vger.kernel.org, AJvYcCVuBMzp8EsOEaFWhAqKI9bnQ0CKrt8JdR42ydftrAu4Q9f031sM24RwgESLnjgouPmG8hhFRkdvc6wRpwFD@vger.kernel.org, AJvYcCW+hvEHAkOuwpCoG8Qw8ffdy5t0ttKVqRLOZLU8bc1RAYQNa5cJJgz454nlj4jSpM1s5Z9OYONB991K@vger.kernel.org, AJvYcCWCrY2NtPBhTpuoyAVQg9OWjkSXBSGr9LCh/RYcM42Fr86lr0MAhaQCoXLl7QitNNg4pfskAWvlMGPlZ7HlXSy6KVQ=@vger.kernel.org, AJvYcCWNIg4IW2DCvneP7miPXJFFaj5yAzlDQ4h2XEcEFFBk39OreugV7VjRW0fMPQwNVLQHbfMbw4poie8wJzfiBdYV/Co=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxwz5UwOoU8IU0RiuU72I6K5mEQlAqVUmTDj/tl8NSuJ5Gh2qUX
	ltLHJbGtiW1PmYqcb4dbuhv0NIioHcnWX2Rr/uM3acQ3gpHBTBBN2/sj4wc+Oy3yu7x1dfoLsw0
	zCDX7ToRZyVVEQT07YQLg9c2OFRQhBJw=
X-Gm-Gg: ASbGncs4Pd0W3VcujU0dHy3s3nWZ36kLmidTPcdypyQkAbt+2JjsCmXjDgoEXBdhjTY
	wmWkBRzHhTyC+4ESU8KAXW+7QdsI0EWuYGEIDX85SbAQrXHkImVC3AMVS3Xhb3ydlhnh6R4ipDC
	4/fyIKXub5qMzzzHGNPed6Uf8dP7li1xpHzccPCzqpbvS7v9hZ+Q+0W5AxV70QU0rcGwy6gesGo
	laVuF5J+PZV+33c6EGI
X-Google-Smtp-Source: AGHT+IH7OMu1dd1ZlYosPz3SPqptVrWuN6c3SeVJCBYbCfoyYDh6z1nFqhk/368zJOb4WYqLr166BLEihh9LvFYDNYs=
X-Received: by 2002:a17:906:48c9:b0:b04:10d9:48d4 with SMTP id
 a640c23a62f3a-b0410d9523dmr1630508566b.35.1757064970102; Fri, 05 Sep 2025
 02:36:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905072423.368123-1-zhao.xichao@vivo.com> <20250905072423.368123-2-zhao.xichao@vivo.com>
 <CAHp75VforxjsHWzxrxfD_YOshvg0Y=KwrpmAPWwhyarNm2wNjQ@mail.gmail.com>
In-Reply-To: <CAHp75VforxjsHWzxrxfD_YOshvg0Y=KwrpmAPWwhyarNm2wNjQ@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 5 Sep 2025 12:35:33 +0300
X-Gm-Features: Ac12FXxkIEGZA5-qHqK-CmbOa_oJh7A8t90OuTImqynr4N5GOyYLVDsnRsxsyg0
Message-ID: <CAHp75VdRn1qnoiCr7aeZfHF9GEyQshOA5awTjiJ9oJiY6Q+Gsw@mail.gmail.com>
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

On Fri, Sep 5, 2025 at 12:33=E2=80=AFPM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Fri, Sep 5, 2025 at 10:25=E2=80=AFAM Xichao Zhao <zhao.xichao@vivo.com=
> wrote:

...

> >         ptr =3D devres_alloc(devm_thermal_of_zone_release, sizeof(*ptr)=
,
> >                            GFP_KERNEL);
> > -       if (!ptr)
> > +       if (!ptr) {
>
> > +               dev_err(dev, "Failed to allocate device resource data\n=
");
>
> We do not add error messages for ENOMEM.
>
> >                 return ERR_PTR(-ENOMEM);
>
> Even if you want so eagerly to do that, it should be
>
>    return dev_err_probe();
>
> But, it will ignore the ENOMEM error code for printing.
>
> > +       }
>
> So, the bottom line, no need to add this message here.

...

> >         tzd =3D thermal_of_zone_register(dev->of_node, sensor_id, data,=
 ops);
> >         if (IS_ERR(tzd)) {
> > +               dev_err_probe(dev, PTR_ERR(tzd),
> > +                             "Failed to register thermal zone sensor[%=
d]\n", sensor_id);
> >                 devres_free(ptr);
> >                 return tzd;
>
> I don't see how ptr is related to the message. Can't we use
>
>   return dev_err_probe(dev, PTR_ERR(...), ...);
>
> instead?

On top of that can we actually use devm_add_action_or_reset()?

--=20
With Best Regards,
Andy Shevchenko

