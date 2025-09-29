Return-Path: <linux-iio+bounces-24564-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 781F3BA9D72
	for <lists+linux-iio@lfdr.de>; Mon, 29 Sep 2025 17:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 389E33A89F4
	for <lists+linux-iio@lfdr.de>; Mon, 29 Sep 2025 15:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D163309F03;
	Mon, 29 Sep 2025 15:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="JprmrIwl"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B4F14286
	for <linux-iio@vger.kernel.org>; Mon, 29 Sep 2025 15:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759160835; cv=none; b=uqnxVV99hFpiV9otH93DzSiX5m0jHbI3vpMgUl70pZgSkgQ3c4+ak/2LOdJ0x7FYzpxH/4SyxXv6EP4GD4GeUB53a7gSLwjjG8GgfBqLf7p50IN2Qkt2LBY1TIHdJqRUHHo+UEokxJL3d5MRbJz3tnDKbX4UPM4MBHKz1ddrHug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759160835; c=relaxed/simple;
	bh=dHV6fr+dv8yeafKARztxV5sCqMeDZmZT3iZ2JptyU9M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XjI6bRleYT9OhjJys+mqbZgn7jbxZIxNWkDmNqTtkc+oP+cG6aeAiSP/3xMajBsOCj4KdM9Q3S/nzQrC0+PYAYqalf1/E7VcJalmOieoGYiI+NXWFDeWtoOJjCPP+6KRwOmd38Q7oB0qHxd4sBj1jmbqgPV53/SnfOMpYQWRWKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=JprmrIwl; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-3612c38b902so21821641fa.2
        for <linux-iio@vger.kernel.org>; Mon, 29 Sep 2025 08:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1759160831; x=1759765631; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mj16NYHSePARtauWGJMZX4OHrp+lmJKr7bOaSlQ4c+k=;
        b=JprmrIwlCikAhjOGWHEqccbfMzhM01g/AhMjVUJGnEhcqXk5tpa6M0Ng0B3PmqVS84
         mUjb3cACoTUUAe2MbxXvEfkOPaA/8AHJcoyMbvNMkg/yYLMcS4FaT1its7sOByyA6yCS
         6IUMfX9Ntgll/T+QQFRKBo0Dg6zURFq8sH553/zyH4xkFbZerqsRATklz5fD92J8/iIT
         RXJqFWmQ/GUIb+iTt9JHyf9RMhWMYX2KH4daID0nmoqFEeTkW8z/LKJBrQhRWF7U/tzA
         b+jJr+YGqL+GRGQzoVsAcBmJYMr+SbWhaRY+d3XswF1vq37epBHJn05Gwd0xW0ERwYb0
         hjdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759160831; x=1759765631;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mj16NYHSePARtauWGJMZX4OHrp+lmJKr7bOaSlQ4c+k=;
        b=Teglo96Q4rD2cY1vUNzFedI8A6lRx02xuWK6kts53C3TKJyaH4qetUVFA+mInaIg4U
         2nbCIB3Tg/c1WMKsrU5bwGo6lts0HmUjrrISVlSJs7RWKggBlmFHL9ia8PHB2k0t95Mm
         oDJuE7HsB8CJJWVvATracEsHKt66BNLL0zYHxzkjRtwCblkvivkCbsiZFGXXhshWhi/2
         V/xwxLduLm129fpvvG080TBxtusDQT4JSWct2FhMrIJ0Kb42vd01ZGOmDshE47612ljX
         O5TULV3j0NLlnCKJ/fh/Udzya75+QhsrpbNGKIvDbACX54syfGktO/ylM0ORJEnqDBnd
         KT0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWIG0/vq2w6SIXu/ennumxV/Rqv7TQKg1iIAtp4FzeWpvJjQ6nfBFopAP6Fs/t/vXbat6NLISfdHYc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwT3Tq1uF0pHP7euxG+QA9pfEpbTNbOzsQGfDFbVPgozLftFhrB
	ueHUG3CmtkIvVQmxokkPnY36NtNgQ8Wgd6y1MaVBFFQCaND9yxgIxX7FT+lRhBG/qCNIC+38f3R
	mGmUTSD59gIg0gKthkq2R1h/evz2HH5B058dXUOsYMQ==
X-Gm-Gg: ASbGncv0UKwMp3v+KDFTijBqdWnflcwyxdKr4fFCuJZSkI4mpWWix5kt9XF8IE5ClcM
	xCeUsau3S5d8LRQfEk5MVNO83N5Om9e+QwS3UfszQOAt0/5Efc8kWt24pIGRYQabao41PgLFVLg
	Y/234VU2NwWttBbXgR+wMgItpAgseJ3nji1951Yrffpo4u93RjQbsjhgtul/gahGU3RADwRbHCP
	7IlNeo=
X-Google-Smtp-Source: AGHT+IGX9f1TpZoODQmAxA8Tak+SZcsyNzqaQ6/XhEFMQL3Dbia52WbpUT464G1ke86qG0dZIH+qKmVdMN4xCd/ez68=
X-Received: by 2002:a05:651c:981:b0:36b:f63:2785 with SMTP id
 38308e7fff4ca-36f7f2485d7mr60972211fa.27.1759160831132; Mon, 29 Sep 2025
 08:47:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929145909.111243-1-antoniu.miclaus@analog.com>
In-Reply-To: <20250929145909.111243-1-antoniu.miclaus@analog.com>
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 29 Sep 2025 17:46:59 +0200
X-Gm-Features: AS18NWAke2Vzy58yaVK0orZeedCnzUntMDrOOf2F7kNqhH8hiHHVjH4H4JS4ka4
Message-ID: <CAMknhBG5nPMnSUnPA_4OyX+c=WiCJqTdm-QLwQGo4fdkfR8w9w@mail.gmail.com>
Subject: Re: [PATCH 1/5] iio: adc: ad4080: prepare driver for multi-part support
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: jic23@kernel.org, robh@kernel.org, conor+dt@kernel.org, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2025 at 4:59=E2=80=AFPM Antoniu Miclaus
<antoniu.miclaus@analog.com> wrote:
>
> Refactor the ad4080 driver to support multiple ADC variants with
> different resolution bits and LVDS CNV clock count maximums.
>
> Changes:
> - Update AD4080_CHIP_ID to correct value 0x50
> - Add lvds_cnv_clk_cnt_max field to chip_info structure
> - Create AD4080_CHANNEL_DEFINE macro for variable resolution/storage bits
> - Use AD4080_REG_PRODUCT_ID_L register for chip identification
> - Make LVDS CNV clock count configurable per chip variant
>
> This prepares the infrastructure for adding support for additional
> ADC parts with different specifications while maintaining backward
> compatibility with existing AD4080 functionality.
>
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
>  drivers/iio/adc/ad4080.c | 46 ++++++++++++++++++++++------------------
>  1 file changed, 25 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/iio/adc/ad4080.c b/drivers/iio/adc/ad4080.c
> index 6e61787ed321..9f670c290a55 100644
> --- a/drivers/iio/adc/ad4080.c
> +++ b/drivers/iio/adc/ad4080.c
> @@ -125,7 +125,7 @@
>
>  /* Miscellaneous Definitions */
>  #define AD4080_SPI_READ                                                B=
IT(7)
> -#define AD4080_CHIP_ID                                         GENMASK(2=
, 0)
> +#define AD4080_CHIP_ID                                         0x50

This sounds like a bug fix, so should be in a separate patch with a Fixes: =
tag

>
>  #define AD4080_LVDS_CNV_CLK_CNT_MAX                            7
>
> @@ -167,6 +167,7 @@ struct ad4080_chip_info {
>         const unsigned int (*scale_table)[2];
>         const struct iio_chan_spec *channels;
>         unsigned int num_channels;
> +       unsigned int lvds_cnv_clk_cnt_max;
>  };
>
>  struct ad4080_state {
> @@ -414,23 +415,25 @@ static struct iio_chan_spec_ext_info ad4080_ext_inf=
o[] =3D {
>         { }
>  };
>
> -static const struct iio_chan_spec ad4080_channel =3D {
> -       .type =3D IIO_VOLTAGE,
> -       .indexed =3D 1,
> -       .channel =3D 0,
> -       .info_mask_separate =3D BIT(IIO_CHAN_INFO_SCALE),
> -       .info_mask_shared_by_all =3D BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> -                       BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
> -       .info_mask_shared_by_all_available =3D
> -                       BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
> -       .ext_info =3D ad4080_ext_info,
> -       .scan_index =3D 0,
> -       .scan_type =3D {
> -               .sign =3D 's',
> -               .realbits =3D 20,
> -               .storagebits =3D 32,
> -       },
> -};
> +#define AD4080_CHANNEL_DEFINE(bits, storage) {\

At least add one space before \. Although I think aligning all \ on
the right is preferred for readability.

> +       .type =3D IIO_VOLTAGE,\
> +       .indexed =3D 1,\
> +       .channel =3D 0,\
> +       .info_mask_separate =3D BIT(IIO_CHAN_INFO_SCALE),\
> +       .info_mask_shared_by_all =3D BIT(IIO_CHAN_INFO_SAMP_FREQ) |\
> +                       BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),\
> +       .info_mask_shared_by_all_available =3D\
> +                       BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),\
> +       .ext_info =3D ad4080_ext_info,\
> +       .scan_index =3D 0,\
> +       .scan_type =3D {\
> +               .sign =3D 's',\
> +               .realbits =3D (bits),\
> +               .storagebits =3D (storage),\
> +       },\
> +}
> +
> +static const struct iio_chan_spec ad4080_channel =3D AD4080_CHANNEL_DEFI=
NE(20, 32);
>
>  static const struct ad4080_chip_info ad4080_chip_info =3D {
>         .name =3D "ad4080",
> @@ -439,6 +442,7 @@ static const struct ad4080_chip_info ad4080_chip_info=
 =3D {
>         .num_scales =3D ARRAY_SIZE(ad4080_scale_table),
>         .num_channels =3D 1,
>         .channels =3D &ad4080_channel,
> +       .lvds_cnv_clk_cnt_max =3D AD4080_LVDS_CNV_CLK_CNT_MAX,
>  };
>
>  static int ad4080_setup(struct iio_dev *indio_dev)
> @@ -458,11 +462,11 @@ static int ad4080_setup(struct iio_dev *indio_dev)
>         if (ret)
>                 return ret;
>
> -       ret =3D regmap_read(st->regmap, AD4080_REG_CHIP_TYPE, &id);
> +       ret =3D regmap_read(st->regmap, AD4080_REG_PRODUCT_ID_L, &id);

If there is also a high word, then this should probably be
regmap_bulk_read() to read the entire product ID.

>         if (ret)
>                 return ret;
>
> -       if (id !=3D AD4080_CHIP_ID)
> +       if (id !=3D st->info->product_id)
>                 dev_info(dev, "Unrecognized CHIP_ID 0x%X\n", id);
>
>         ret =3D regmap_set_bits(st->regmap, AD4080_REG_GPIO_CONFIG_A,
> @@ -488,7 +492,7 @@ static int ad4080_setup(struct iio_dev *indio_dev)
>                                  AD4080_REG_ADC_DATA_INTF_CONFIG_B,
>                                  AD4080_ADC_DATA_INTF_CONFIG_B_LVDS_CNV_C=
LK_CNT_MSK,
>                                  FIELD_PREP(AD4080_ADC_DATA_INTF_CONFIG_B=
_LVDS_CNV_CLK_CNT_MSK,
> -                                           AD4080_LVDS_CNV_CLK_CNT_MAX))=
;
> +                                           st->info->lvds_cnv_clk_cnt_ma=
x));
>         if (ret)
>                 return ret;
>
> --
> 2.43.0
>
>

