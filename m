Return-Path: <linux-iio+bounces-22602-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1923AB215F8
	for <lists+linux-iio@lfdr.de>; Mon, 11 Aug 2025 21:53:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 082566254FE
	for <lists+linux-iio@lfdr.de>; Mon, 11 Aug 2025 19:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1232C25A655;
	Mon, 11 Aug 2025 19:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gkMiOi2h"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18EB927F724
	for <linux-iio@vger.kernel.org>; Mon, 11 Aug 2025 19:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754941982; cv=none; b=gSarRKaA8AZbdKpVJZGijAl7Y7+GXIsSy0WnGUieIxW9woSoZGAfxklbFgX8IAyJLniUxh1yMWfSXnzLeaWIhBjwo+GHI1UKCVJumZTVmvMfBltmg2Jd3caKvHYkAMbLb/nlTSh7AQSDxN6iVTgT21BVtEOmxy7ClSEZ5czREA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754941982; c=relaxed/simple;
	bh=QTuno58EByO1NluPa+U5Up1HhNlOHJadSBay4diMIlM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IQbtOOYmb/Hzivb32bYTWGz/O8l9q/kQYxL1Dp3mpgyzFIO3fR6ohK07VCC/FFdSWJPBl3mOiwV/XjVA7tKKS6qSwBonuEZgt3sprkicI4/Z8LGNikqrj9cROjuvDyJRClDQv4JkpHD57QaK+sUSibQxWnDqaKIHmyu3+lz/FrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gkMiOi2h; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-af93150f7c2so724957666b.3
        for <linux-iio@vger.kernel.org>; Mon, 11 Aug 2025 12:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754941979; x=1755546779; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XbELh4fvcOAyL6lP2NeAz20eZDZwj5phU3IiCRbg5EU=;
        b=gkMiOi2hz8WsG1jz1HU+lVo/u+y+f2gehCf/TLa93sm7czeeQXDvoTLkOIKTM5RYsJ
         /V+uhDWzYRnS6cZ5Nu6qH3OqXqzuLlGdx3EWLD+Nob9rE3/Poi+p9lOyBxnkbq65Reyl
         bk4b+SQgxLjX3u7Q74woH0KNfdYXOPjd+2aHLeG7oyfCiLA50ITKK0bNn1qPqaGjDZSF
         Eqt9KjzEDTIv77ImeppcK1/TnNpmjO3InN2XeN7HQhtfQX7T/i00wnvO7piLq+8P50DY
         cCuBD6x7EXoQOy1j1vj56Glpp75pBQn5Y908RUs1k2fo1zS81ZA0iwiIQ68U/pCNJgWk
         4GAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754941979; x=1755546779;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XbELh4fvcOAyL6lP2NeAz20eZDZwj5phU3IiCRbg5EU=;
        b=YpD9HZwAD7br+WM7nlMdTTY/PUrzcFCzotnLbg5fG010aYqLlgGOzw+MJ0bWP5i1Be
         epVbM3oFzu3sn/LbEWOb9lgkwPU/0yp8KhlaAhcLd6+ux/Z/HFB9Q21uUkXwAJTjviuW
         TxSvjWK6nagedi1TWU4VB3NGdqlQcqAlpwTs9maDOOT8l07T790tk8QTO7C/OPpgec1+
         BlrBZdhmjRT9sbls8FhKVKH/2R0AFAlPrH9ROk+d/61fxSE8/SxyP706QpIVAUgTU1WY
         aWdv5x2aQEnEBA0pIhXn0Hnbp5Xm3gsv93Evs+6CIN3O9iIDiGNyHyNZjJTwfoEbdAFb
         UBxQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHVOmJr8jPRq+IgKAJLIL2BUk7PpPGOblpMi8ZnFj4TkZejKgXypsCdlRk3PRB1xQcdumX9OlJqWI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg0HpzCdNEZj6Ue8ZgILTJEIB7ZrYMAWDH7Y7R3N5pWw/qpsdv
	1kB6g7H85TV3V42FflMEfGhDRDWO+5ljOYn9ImmmiXomGGmD/ssez2AukR6D2KHcEWL38vcuKM4
	W4dZfQ0HvNqU2VOPcmM9WYXkD+KukU2Ak5GoHmKk=
X-Gm-Gg: ASbGncvqDfYBlXiNF4ugbwSsc4YjBM/KdmqRVptbSCGj4hxRMZ6DEyS2vfKUnPPyfz9
	kjCQt6HUeAMGKFvHEmvB7/vQ/ASHfChHhKlRqlQ/NkzoVAr0UlPABcpzid7sq09pQWnpnf6qaPp
	WyHtO1wZUEIMBaNlA5xdbqOKmcLjj1r5SGx+LVFlm9Xehff+0ACr9TNPNcRzRV8bViFM9+/o/3V
	+O9iQZ/FA==
X-Google-Smtp-Source: AGHT+IHJr1KOh4MWjUFWIWtNytGlT4wyrK/Rcp4pdvxZqQqYip1aqsJo8yX5aYDbX/d4y20rmbX7dwJm3QghbVHaJb4=
X-Received: by 2002:a17:907:1b0c:b0:af9:add3:6be6 with SMTP id
 a640c23a62f3a-afa1e24e88emr67235066b.58.1754941979190; Mon, 11 Aug 2025
 12:52:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811155453.31525-1-hansg@kernel.org> <20250811155453.31525-7-hansg@kernel.org>
In-Reply-To: <20250811155453.31525-7-hansg@kernel.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 11 Aug 2025 21:52:20 +0200
X-Gm-Features: Ac12FXxTqfA2EFbKVp2HoCd-nL45qdkponH3mEfnMCKnCzj6Ug3Xowlc1WvgGAg
Message-ID: <CAHp75VcozYvcAbWZ6Yvudzu6jj39fNbGD-8T=F=v+6QxEGxiKA@mail.gmail.com>
Subject: Re: [PATCH v4 6/6] iio: adc: Add Intel Dollar Cove TI PMIC ADC driver
To: Hans de Goede <hansg@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Andy Shevchenko <andy@kernel.org>, Matteo Martelli <matteomartelli3@gmail.com>, 
	Liam Beguin <liambeguin@gmail.com>, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2025 at 5:55=E2=80=AFPM Hans de Goede <hansg@kernel.org> wr=
ote:
>
> Intel has 2 completely different "Dollar Cove" PMICs for its Bay Trail /
> Cherry Trail SoCs. One is made by X-Powers and is called the AXP288.
> The AXP288's GPADC is already supported by the X-Powers AXP288 ADC driver=
.
>
> The other "Dollar Cove" PMIC is made by TI and does not have any clear TI
> denomination, its MFD driver calls it the "Intel Dollar Cove TI PMIC".
>
> Add a driver for the Intel Dollar Cove TI PMIC's general purpose ADC,
> binding to the "chtdc_ti_adc" MFD cell of the MFD driver.
>
> The "cht" in the cell name comes from Cherry Trail, but it turns out that
> just like the AXP288 the Intel Dollar Cove TI PMIC is also used with both
> Intel Bay Trail and Intel Cherry Trail SoCs, so this new ADC driver does
> not include the cht part in its name.
>
> This is loosely based on kernel/drivers/iio/adc/iio_dc_ti_gpadc.c
> from the Acer A1-840 Android kernel source-code archive named:
> "App. Guide_Acer_20151221_A_A.zip"
> which is distributed by Acer from the Acer A1-840 support page:
> https://www.acer.com/us-en/support/product-support/A1-840/downloads

...

> +config INTEL_DC_TI_ADC
> +       tristate "Intel Bay / Cherry Trail Dollar Cove TI ADC driver"

I would spell it in full
"Intel Bay Trail / Cherry Trail ..."

> +       depends on INTEL_SOC_PMIC_CHTDC_TI

...

> +       /*
> +        * As per TI (PMIC Vendor), the ADC enable and ADC start commands=
 should
> +        * not be sent together. Hence send the commands separately

Missing period.

> +        */

...

> +       /*
> +        * As per PMIC Vendor, a minimum of 50 micro seconds delay is req=
uired

We can also use SI unit acronyms, like =C2=B5s.

> +        * between ADC Enable and ADC START commands. This is also recomm=
ended
> +        * by Intel Hardware team after the timing analysis of GPADC sign=
als.
> +        * Since the I2C Write transaction to set the channel number also
> +        * imparts 25 micro seconds of delay, so we need to wait for anot=
her
> +        * 25 micro seconds before issuing ADC START command.
> +        */

...

> +       /* TI (PMIC Vendor) recommends 5 sec timeout for conversion */

seconds (to be consistent with other comments) or s (to be consistent
with SI). Interestingly, you have all three variants among the
comments already.

...

> +       /* The ADC values are 10 bits */

I would write it as "...are 10-bit wide"

...

> +       /*
> +        * If channel BPTHERM has been selected, first enable the BPTHERM=
 BIAS
> +        * which provides the VREF Voltage reference to convert BPTHERM I=
nput
> +        * voltage to temperature.

> +        * As per PMIC Vendor specifications, BPTHERM BIAS should be enab=
led
> +        * 35 ms before ADC_EN command.

I would move this comment to be directly before msleep() call.

> +        */
> +       if (chan->channel =3D=3D DC_TI_ADC_BATTEMP) {
> +               ret =3D regmap_set_bits(info->regmap, DC_TI_ADC_CNTL_REG,
> +                                     DC_TI_ADC_EN_EXT_BPTH_BIAS);
> +               if (ret)
> +                       return ret;
> +               msleep(35);
> +       }

> +static int dc_ti_adc_probe(struct platform_device *pdev)
> +{
> +       struct device *dev =3D &pdev->dev;
> +       struct intel_soc_pmic *pmic =3D dev_get_drvdata(dev->parent);
> +       struct dc_ti_adc_info *info;
> +       struct iio_dev *indio_dev;
> +       unsigned int val;
> +       int irq, ret;
> +
> +       irq =3D platform_get_irq(pdev, 0);
> +       if (irq < 0)
> +               return irq;
> +
> +       indio_dev =3D devm_iio_device_alloc(dev, sizeof(*info));
> +       if (!indio_dev)
> +               return -ENOMEM;
> +
> +       info =3D iio_priv(indio_dev);
> +
> +       ret =3D devm_mutex_init(dev, &info->lock);
> +       if (ret)
> +               return ret;
> +
> +       init_waitqueue_head(&info->wait);
> +
> +       info->dev =3D dev;
> +       info->regmap =3D pmic->regmap;
> +
> +       indio_dev->name =3D "dc_ti_adc";
> +       indio_dev->channels =3D dc_ti_adc_channels;
> +       indio_dev->num_channels =3D ARRAY_SIZE(dc_ti_adc_channels);
> +       indio_dev->info =3D &dc_ti_adc_iio_info;
> +       indio_dev->modes =3D INDIO_DIRECT_MODE;
> +
> +       ret =3D regmap_read(info->regmap, DC_TI_VBAT_ZSE_GE_REG, &val);
> +       if (ret)
> +               return ret;
> +
> +       info->vbat_zse =3D sign_extend32(FIELD_GET(DC_TI_VBAT_ZSE, val), =
3);
> +       info->vbat_ge =3D sign_extend32(FIELD_GET(DC_TI_VBAT_GE, val), 3)=
;
> +
> +       dev_dbg(dev, "vbat-zse %d vbat-ge %d\n", info->vbat_zse, info->vb=
at_ge);
> +
> +       ret =3D devm_iio_map_array_register(dev, indio_dev, dc_ti_adc_def=
ault_maps);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D devm_request_threaded_irq(dev, irq, NULL, dc_ti_adc_isr,
> +                                       IRQF_ONESHOT, indio_dev->name, in=
fo);
> +       if (ret)
> +               return ret;
> +
> +       return devm_iio_device_register(dev, indio_dev);
> +}

...

> +static const struct platform_device_id dc_ti_adc_ids[] =3D {
> +       { .name =3D "chtdc_ti_adc", },

Inner comma is not required.

> +       { }
> +};

...

> +MODULE_AUTHOR("Ramakrishna Pallala <ramakrishna.pallala@intel.com>");

Wondering if the address is still alive. In this case perhaps even ask
for SoB/Co-developed-by? Otherwise if you still wish to have this
credit make it in the form of "First Last (Intel)".

--=20
With Best Regards,
Andy Shevchenko

