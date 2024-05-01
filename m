Return-Path: <linux-iio+bounces-4736-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6575D8B8E90
	for <lists+linux-iio@lfdr.de>; Wed,  1 May 2024 18:54:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 886A91C215C6
	for <lists+linux-iio@lfdr.de>; Wed,  1 May 2024 16:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D1861401C;
	Wed,  1 May 2024 16:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Xyg99y92"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C0911CBD
	for <linux-iio@vger.kernel.org>; Wed,  1 May 2024 16:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714582483; cv=none; b=gOKffIgrTP0glXPlOXoC+X7FQhM5MhhyJpKgCiEyYB6qx2mLdJG5qxfhGNzrRt4btNfXxK3y8+kQSq9NuE9dxb/UABl4nKd+oRGoJsu5ekzrwcYrcSIqbso6+01ZoioUKax4mgD+Nl0fdhu+auVoACkuvYe3li9qtaDnJOWyu6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714582483; c=relaxed/simple;
	bh=GL8aoeKVv7NTqthKTQt9djeQqR3rw/C/jRnAEiWNkz8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J8U7BnyxBqMmURxfMZpzMuCykXLS1gKU5+ROVPL8bD2hDXY7ePfzTxFAdgeFpaOe2lyvMNH1G6N2eER5ykqTcz+1l692UNbokD4MPjyO48DZze0yguuz4pUQ/VmgdodVJvCARDKBqMMImP0Pg7mxsfIuWin/b4sQyE8EX5Zwxq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Xyg99y92; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2db13ca0363so112975471fa.3
        for <linux-iio@vger.kernel.org>; Wed, 01 May 2024 09:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1714582478; x=1715187278; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w/wlojJlB2oaskScy046z1eNPepG9Aezgzs4l2bkU6o=;
        b=Xyg99y92CTooGbYfJsuPfy618xlMfQYPUp0HmeXmBNHAnZNQBbYdIg47MlOLd+pfNj
         65uHT3C9AVpQnFL8B9h+QAU76+PsQ435FjNxeTH5ib+p/ND9jSFVa7+52FlUQRALNU1v
         FvfZAUYzABdF/9GiUiZ2IYUWI44iBSKKz+Lr3516nAtP21SWc9hNg62417IkyIrx9HTh
         AW6FPSr7XiUXHZn3sTWuQE2Fjl85eiD6bcqCiemEPo4qFE0oXDf/lsoNJ8IIezr4krrd
         fw2OJaZMc6baV19oFvJlh0uLLbUKpkVRBJ48ZVMEQG3qDwUQevPrVJT3SnaqSaaSX8Cb
         nokg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714582478; x=1715187278;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w/wlojJlB2oaskScy046z1eNPepG9Aezgzs4l2bkU6o=;
        b=Hh22JV3E7/QRANJPGCKSG/PiGxOhT+RS/IEQkXgnWIgYi5/hlJGvfnRfkPFuLCcf7k
         8n822VamsaYqFBgkrA97tkMTGraEIFn+gNuJUUNXtmwoCymd+oE3e0c7eevURfCGTjdv
         As7Cus2ncwBZX9Qwl7il6gTtVkOrH7F1PIyXgIuxQGUxZgKm0p+98oAIxAUNqdEqPhjO
         BCAOskIUWlH3kwcrUEHEfbJthOtGQ99YEYrpmI0Dkso884WboqLVnHuKCN4UOceRexSi
         HIU06xs4chRZN0SCnraFCWG3nsa2mYeFxaeJM7FWxEWwlGPOWBUV6hpnHEoIXSoG8a2O
         7GEg==
X-Forwarded-Encrypted: i=1; AJvYcCWqw4/JCzYLCFIUDdt7zVrgdfud13iFB96jU3IHJJbd8bbMWpt85pw93y5K7aa7fPdatwcA9prz2nSr9yj7d33m+69HLkD409i9
X-Gm-Message-State: AOJu0YzMwOvCaWF9ZrTLdHNonShUwKs+1kPqBEy2wxnIpiLPBz2tyzpf
	elfdM/007Y2axjnzGXSvFjJuQU5p5Qls2entomxDLj9cxWBaftE1uAsslhTwjI0irrmCwLbYcRZ
	4p9Wp3HYrQwkh51/Mx2vhPIk7wxK5LEKe/ayWzw==
X-Google-Smtp-Source: AGHT+IHy8X3vNCkUoqaYTTSby7XxzA2kbJbzSLWq5fgusbVBvlv4DCRXAp8OqI8IJ6PDqlqgTl6hQqQcOvULrY1H8Pk=
X-Received: by 2002:a2e:7c0e:0:b0:2d8:5af9:90c5 with SMTP id
 x14-20020a2e7c0e000000b002d85af990c5mr2708389ljc.39.1714582478520; Wed, 01
 May 2024 09:54:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240430162946.589423-1-alisa.roman@analog.com> <20240430162946.589423-4-alisa.roman@analog.com>
In-Reply-To: <20240430162946.589423-4-alisa.roman@analog.com>
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 1 May 2024 11:54:27 -0500
Message-ID: <CAMknhBHa7zfWeQj7LDFCZDWc8i8as1WD964L2J3z6v_Un6kXFQ@mail.gmail.com>
Subject: Re: [PATCH v7 3/6] iio: adc: ad7192: Add aincom supply
To: Alisa-Dariana Roman <alisadariana@gmail.com>
Cc: michael.hennerich@analog.com, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	alexandru.tachici@analog.com, lars@metafoo.de, jic23@kernel.org, 
	robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	lgirdwood@gmail.com, broonie@kernel.org, andy@kernel.org, nuno.sa@analog.com, 
	marcelo.schmitt@analog.com, bigunclemax@gmail.com, okan.sahin@analog.com, 
	fr0st61te@gmail.com, alisa.roman@analog.com, marcus.folkesson@gmail.com, 
	schnelle@linux.ibm.com, liambeguin@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2024 at 11:30=E2=80=AFAM Alisa-Dariana Roman
<alisadariana@gmail.com> wrote:
>
> AINCOM should actually be a supply. AINx inputs are referenced to AINCOM
> in pseudo-differential operation mode. AINCOM voltage represents the
> offset of corresponding channels.
>
> Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
> ---
>  drivers/iio/adc/ad7192.c | 41 ++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 39 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
> index ace81e3817a1..3e797ff48086 100644
> --- a/drivers/iio/adc/ad7192.c
> +++ b/drivers/iio/adc/ad7192.c
> @@ -20,6 +20,7 @@
>  #include <linux/module.h>
>  #include <linux/mod_devicetable.h>
>  #include <linux/property.h>
> +#include <linux/units.h>
>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> @@ -186,6 +187,7 @@ struct ad7192_state {
>         struct regulator                *vref;
>         struct clk                      *mclk;
>         u16                             int_vref_mv;
> +       u32                             aincom_mv;
>         u32                             fclk;
>         u32                             mode;
>         u32                             conf;
> @@ -742,10 +744,19 @@ static int ad7192_read_raw(struct iio_dev *indio_de=
v,
>                         *val =3D -(1 << (chan->scan_type.realbits - 1));
>                 else
>                         *val =3D 0;

nit: add blank line before switch for readability

> +               switch (chan->type) {
> +               case IIO_VOLTAGE:

Comment could be helpful here as a few things might not be obvious:
* Only applies to pseudo-differential inputs (!chan->differential)
* AINCOM voltage has to be converted to "raw" units.

> +                       if (st->aincom_mv && !chan->differential)
> +                               *val +=3D DIV_ROUND_CLOSEST_ULL((u64)st->=
aincom_mv * NANO,
> +                                                             st->scale_a=
vail[gain][1]);
> +                       return IIO_VAL_INT;
>                 /* Kelvin to Celsius */
> -               if (chan->type =3D=3D IIO_TEMP)
> +               case IIO_TEMP:
>                         *val -=3D 273 * ad7192_get_temp_scale(unipolar);
> -               return IIO_VAL_INT;
> +                       return IIO_VAL_INT;
> +               default:
> +                       return -EINVAL;
> +               }
>         case IIO_CHAN_INFO_SAMP_FREQ:
>                 *val =3D DIV_ROUND_CLOSEST(ad7192_get_f_adc(st), 1024);
>                 return IIO_VAL_INT;
> @@ -1052,6 +1063,7 @@ static int ad7192_probe(struct spi_device *spi)
>  {
>         struct ad7192_state *st;
>         struct iio_dev *indio_dev;
> +       struct regulator *aincom;
>         int ret;
>
>         if (!spi->irq) {
> @@ -1067,6 +1079,31 @@ static int ad7192_probe(struct spi_device *spi)
>
>         mutex_init(&st->lock);
>
> +       /*
> +        * Regulator aincom is optional to maintain compatibility with ol=
der DT.
> +        * Newer firmware should provide a zero volt fixed supply if wire=
d to
> +        * ground.
> +        */
> +       aincom =3D devm_regulator_get_optional(&spi->dev, "aincom");

Do we need to consider other errors separate from -EINVAL?

I've done something like this in other drivers:

if (IS_ERR(aincom)) {
    if (PTR_ERR(aincom) !=3D -EINVAL)
        return dev_err_probe(...);

    st->aincom_mv =3D 0;
} else {
   ...
    st->aincom_mv =3D ...;
}
> +       if (IS_ERR(aincom)) {
> +               st->aincom_mv =3D 0;
> +       } else {
> +               ret =3D regulator_enable(aincom);
> +               if (ret)
> +                       return dev_err_probe(&spi->dev, ret,
> +                                            "Failed to enable specified =
AINCOM supply\n");
> +
> +               ret =3D devm_add_action_or_reset(&spi->dev, ad7192_reg_di=
sable, aincom);
> +               if (ret)
> +                       return ret;
> +
> +               ret =3D regulator_get_voltage(aincom);
> +               if (ret < 0)
> +                       return dev_err_probe(&spi->dev, ret,
> +                                            "Device tree error, AINCOM v=
oltage undefined\n");
> +               st->aincom_mv =3D ret / 1000;
> +       }
> +
>         st->avdd =3D devm_regulator_get(&spi->dev, "avdd");
>         if (IS_ERR(st->avdd))
>                 return PTR_ERR(st->avdd);
> --
> 2.34.1
>

