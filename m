Return-Path: <linux-iio+bounces-5500-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A0F8D4CDC
	for <lists+linux-iio@lfdr.de>; Thu, 30 May 2024 15:35:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F35801C22203
	for <lists+linux-iio@lfdr.de>; Thu, 30 May 2024 13:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3940917CA16;
	Thu, 30 May 2024 13:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g2Ew6wpH"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5217F17CA0C;
	Thu, 30 May 2024 13:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717076108; cv=none; b=Mg7Bw435ghZejdqt4a6chsfiEqlBgLzbf1vyo0dAusLd7gqfPIZ6oC7Tgj4WTr94t2M6KlrkgM1tTfE8iHfNV+pLKoo+p0UD33zuxkce+SKuBjfXXf6WRnOguZCOmeJJTLR8b5PNdOreCg7+LN3phzGuc/fukRXbNgNZGJIcNlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717076108; c=relaxed/simple;
	bh=3AnIdFj3lsHNNgl6yv0mA/L6OL0S21ZbcdFtYn1dTkk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sHrFoU0d4wyMm2FjgbIqk6KkR4xRCAZuj7B3J9sbuctYF/+muqo4giHXgtJPNESQ8oGJJ8OLkaaSudvQJcQZEVL0QWNpcYir3Qd985VtVw+LtCkUSiesc1r5wRRcOY/M0yZjynqrm8/kWAicjq67LxpDzsY+hUGvemQgx9EIzW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g2Ew6wpH; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a5a89787ea4so75990766b.2;
        Thu, 30 May 2024 06:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717076104; x=1717680904; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ityrTb+cN3E6zdWopkba23K4YFJ51mGn7zptESF64M=;
        b=g2Ew6wpH6dM/XqI+8wTZANq97DhovcLk+XgeeVEE8KcG6XLAzq856AfBwQsZnaoC7v
         9iTmDc/Xf2i602QIxKmJZ26y/oa1ppLRzkcJW4NnbJ7VusgNu45GjNwT1/nxxzfIkuWN
         usAZvSjHAfs9nDH+QYXcs9tUET82pz54OSXKpXuPB4SMSArHBh+CLIRJJ+Oy/4bce2sD
         auFwQysdS8D0CAFSeNFcmnDWq/+Ysx+plXsknrIMsqkW2TL9jqfc7h5/ezTrH36Yp/9Q
         KFO+LmWYMco85oB4PtEGF4g9R9FLwRlG1tSgwIUgQh85sg+F7F6vpFCjlRs9x7SMV1qM
         RQeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717076104; x=1717680904;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6ityrTb+cN3E6zdWopkba23K4YFJ51mGn7zptESF64M=;
        b=tz4SQoxEOC9BpDr2HtHemzlDzRfyW0k5JwhJxrEyC98OCJjbloBANzQoCUtDYmnonQ
         fYHuGww7mJCkn845RscoH/5PTRNpuLnJ8mncxNeeCUEoDlDWekGy3wxDm8BHv0XmIQtk
         DavaO07mSk2bypGrZ+vRNJOKOBaaMdsB/BluVd2QdwaV8zgDoKfAVqNz2ifC2C3cBjp6
         V1DI8AbRGbPWo5DsmPs4k+YeYnEpQgYK1utH8fcEY8z7/v4gpawS3qhMCzezRsSn8Fl8
         y+v6b54ZUs5VoTfCbxUU3R1pS+WZ3pRQXfMJ5ba3gqjaE8rZZW1f1WSNdv/hzbRF/xqj
         CzVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhPQO5JsF6oCayE/4nNsoYshCCVs+6UU68+xObmHLM+ZYWE9qv5jpIKj9eklH+EJ28WSx5DroIwAizLFXfi32dlhIduSM9Y9Q+V/HDyJHnXUw3J9Cm7ICWuuryne8oIahZRWiS9EnlTB9hW5rCczMBOZNOVsEfdjFff0S1bfrvCjp4WQ==
X-Gm-Message-State: AOJu0YwZkzbFqt6VF0QEA19Rni6Zg5QzQOMsEBo2ZVShEr90NyoOzGy8
	rMV93lzUCKbT4gsV2P6t7eW0Z2HZrNESbIuaa/Yi9Juw55mAuqpe+TI7cZPlES0ZOf2CjQaMZG/
	oJ+WYB5mqeAYpVdCHhJBEkNbB6Ps=
X-Google-Smtp-Source: AGHT+IH7FtLH1XLeHqlHgAvWr9dzcasrfRvrJ3/m57OZQa4LKdwDt7riItXkQ11EXy8nI4WkwAdBQEESRzaKO1SQlGQ=
X-Received: by 2002:a17:906:b3a0:b0:a5a:1562:5187 with SMTP id
 a640c23a62f3a-a65e924fd51mr115572766b.55.1717076104311; Thu, 30 May 2024
 06:35:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240530093410.112716-1-angelogioacchino.delregno@collabora.com> <20240530093410.112716-3-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240530093410.112716-3-angelogioacchino.delregno@collabora.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 30 May 2024 16:34:27 +0300
Message-ID: <CAHp75Vexddt1xUGogRDZA9pM1pFp2=ZtCQnCfXePahSCb+oKpg@mail.gmail.com>
Subject: Re: [PATCH v1 2/4] iio: adc: Add support for MediaTek MT6357/8/9
 Auxiliary ADC
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: jic23@kernel.org, lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, matthias.bgg@gmail.com, lee@kernel.org, andy@kernel.org, 
	nuno.sa@analog.com, bigunclemax@gmail.com, dlechner@baylibre.com, 
	marius.cristea@microchip.com, marcelo.schmitt@analog.com, fr0st61te@gmail.com, 
	mitrutzceclan@gmail.com, mike.looijmans@topic.nl, marcus.folkesson@gmail.com, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 30, 2024 at 12:34=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Add a driver to support reading the Auxiliary ADC IP found in the
> MediaTek MT6357, MT6358 and MT6359 Power Management ICs.
>
> This driver provides multiple ADC channels for system monitoring,
> such as battery voltage, PMIC temperature, PMIC-internal voltage
> regulators temperature, and others.

> ---

Here is no explanation on how this is differ to any of the three
existing drivers? I.o.w. why do we need a brand new one?

...

+ bits.h

> +#include <linux/delay.h>

> +#include <linux/kernel.h>

Why?

+ mod_devicetable.h
> +#include <linux/module.h>

> +#include <linux/of.h>

Why?

> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>

+ types.h

+ blank line

> +#include <linux/iio/iio.h>

+ Blank line

> +#include <linux/mfd/mt6397/core.h>

...

> +#define PMIC_RG_RESET_VAL              (BIT(0) | BIT(3))

In this form it requires a comment explaining each mentioned bit.

> +#define PMIC_AUXADC_ADCx(x)            ((x) << 1)

Seems like a useless macro, it occupies much more space than in-place shift=
.

...

> +#define MT6358_IMP0_CLEAR              (BIT(14) | BIT(7))

As per above.

...

> +/**
> + * struct mtk_pmic_auxadc_chan - PMIC AUXADC channel data
> + * @req_idx:       Request register number
> + * @req_mask:      Bitmask to activate a channel
> + * @num_samples:   Number of AUXADC samples for averaging
> + * @r_numerator:   Resistance ratio numerator
> + * @r_denominator: Resistance ratio denominator
> + */
> +struct mtk_pmic_auxadc_chan {
> +       u8 req_idx;
> +       u16 req_mask;
> +       u16 num_samples;

> +       u8 r_numerator;
> +       u8 r_denominator;

Can you add struct u8_fract to the math.h and use it? I will Ack/R the
respective patch.

> +};

...

> +struct mtk_pmic_auxadc_pdata {
> +       const struct iio_chan_spec *channels;
> +       int num_channels;

Why signed?

> +       const struct mtk_pmic_auxadc_chan *desc;
> +       const u16 *regs;
> +       u16 sec_unlock_key;
> +       u8 imp_adc_num;
> +       int (*read_imp)(struct mt6359_auxadc *adc_dev, int *vbat, int *ib=
at);
> +};

...

> +static const u16 mt6357_auxadc_regs[] =3D {
> +       [PMIC_HK_TOP_RST_CON0]  =3D 0xf90,

Can we use the fixed-width values so all of them will look nice and
easy to parse?

> +       [PMIC_AUXADC_DCM_CON]   =3D 0x122e,
> +       [PMIC_AUXADC_ADC0]      =3D 0x1088,
> +       [PMIC_AUXADC_IMP0]      =3D 0x119c,
> +       [PMIC_AUXADC_IMP1]      =3D 0x119e,
> +       [PMIC_AUXADC_RQST0]     =3D 0x110e,
> +       [PMIC_AUXADC_RQST1]     =3D 0x1114,
> +};

...

> +static const u16 mt6358_auxadc_regs[] =3D {

Ditto.

> +       [PMIC_HK_TOP_RST_CON0]  =3D 0xf90,
> +       [PMIC_AUXADC_DCM_CON]   =3D 0x1260,
> +       [PMIC_AUXADC_ADC0]      =3D 0x1088,
> +       [PMIC_AUXADC_IMP0]      =3D 0x1208,
> +       [PMIC_AUXADC_IMP1]      =3D 0x120a,
> +       [PMIC_AUXADC_RQST0]     =3D 0x1108,
> +       [PMIC_AUXADC_RQST1]     =3D 0x110a,
> +};

...

> +static const u16 mt6359_auxadc_regs[] =3D {

Ditto.

> +       [PMIC_FGADC_R_CON0]     =3D 0xd88,
> +       [PMIC_HK_TOP_WKEY]      =3D 0xfb4,
> +       [PMIC_HK_TOP_RST_CON0]  =3D 0xf90,
> +       [PMIC_AUXADC_RQST0]     =3D 0x1108,
> +       [PMIC_AUXADC_RQST1]     =3D 0x110a,
> +       [PMIC_AUXADC_ADC0]      =3D 0x1088,
> +       [PMIC_AUXADC_IMP0]      =3D 0x1208,
> +       [PMIC_AUXADC_IMP1]      =3D 0x120a,
> +       [PMIC_AUXADC_IMP3]      =3D 0x120e,
> +};

...

> +       ret =3D regmap_read_poll_timeout(adc_dev->regmap, pdata->regs[PMI=
C_AUXADC_IMP0],
> +                                      val, !!(val & MT6358_IMP0_IRQ_RDY)=
,
> +                                      IMP_POLL_DELAY_US, AUXADC_TIMEOUT_=
US);
> +       if (ret) {
> +               mt6358_stop_imp_conv(adc_dev);

> +               return ret;
> +       }
> +
> +       return 0;

  if (ret)
    foo()

  return ret;


...

> +       int val_v, ret;

Why is val_v signed?

...

> +       int val_v, val_i, ret;

Ditto for all val_*.

...

> +       /* If it succeeded, wait for the registers to be populated */
> +       usleep_range(IMP_STOP_DELAY_US, IMP_STOP_DELAY_US + 50);

fsleep() ?

...

> +       /* Assert ADC reset */
> +       regmap_set_bits(regmap, pdata->regs[PMIC_HK_TOP_RST_CON0], PMIC_R=
G_RESET_VAL);

No required delay in between?

> +       /* De-assert ADC reset */
> +       regmap_clear_bits(regmap, pdata->regs[PMIC_HK_TOP_RST_CON0], PMIC=
_RG_RESET_VAL);

...

> +       /* Wait until all samples are averaged */
> +       usleep_range(desc->num_samples * AUXADC_AVG_TIME_US,
> +                    (desc->num_samples + 1) * AUXADC_AVG_TIME_US);

fsleep()

...

> +       ret =3D regmap_read_poll_timeout(regmap,
> +                                      (pdata->regs[PMIC_AUXADC_ADC0] +
> +                                       PMIC_AUXADC_ADCx(chan->address)),

Drop unneeded parentheses and possibly make it one line.

> +                                      val, (val & PMIC_AUXADC_RDY_BIT),

Unneeded parentheses.

> +                                      AUXADC_POLL_DELAY_US, AUXADC_TIMEO=
UT_US);
> +       if (ret)
> +               return ret;

...

> +       mutex_lock(&adc_dev->lock);

Why not use cleanup.h?

...

> +static int mt6359_auxadc_probe(struct platform_device *pdev)
> +{

  struct device *dev =3D &pdev->dev;

> +       struct device *mt6397_mfd_dev =3D pdev->dev.parent;

  ... =3D dev->parent;

> +       struct mt6359_auxadc *adc_dev;
> +       struct iio_dev *indio_dev;
> +       struct regmap *regmap;
> +       int ret;
> +
> +       /* Regmap is from SoC PMIC Wrapper, parent of the mt6397 MFD */
> +       regmap =3D dev_get_regmap(mt6397_mfd_dev->parent, NULL);
> +       if (!regmap)
> +               return dev_err_probe(&pdev->dev, -ENODEV, "Failed to get =
regmap\n");
> +
> +       indio_dev =3D devm_iio_device_alloc(&pdev->dev, sizeof(*adc_dev))=
;
> +       if (!indio_dev)
> +               return -ENOMEM;
> +
> +       adc_dev =3D iio_priv(indio_dev);
> +       adc_dev->regmap =3D regmap;
> +       adc_dev->dev =3D &pdev->dev;
> +
> +       adc_dev->pdata =3D device_get_match_data(&pdev->dev);
> +       if (!adc_dev->pdata)
> +               return -EINVAL;
> +
> +       mutex_init(&adc_dev->lock);
> +
> +       mt6359_auxadc_reset(adc_dev);
> +
> +       indio_dev->dev.parent =3D &pdev->dev;
> +       indio_dev->name =3D dev_name(&pdev->dev);
> +       indio_dev->info =3D &mt6359_auxadc_info;
> +       indio_dev->modes =3D INDIO_DIRECT_MODE;
> +       indio_dev->channels =3D adc_dev->pdata->channels;
> +       indio_dev->num_channels =3D adc_dev->pdata->num_channels;
> +
> +       ret =3D devm_iio_device_register(&pdev->dev, indio_dev);
> +       if (ret < 0)

Why  ' < 0' ?

> +               return dev_err_probe(&pdev->dev, ret, "failed to register=
 iio device\n");
> +
> +       return 0;
> +}

--=20
With Best Regards,
Andy Shevchenko

