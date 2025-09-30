Return-Path: <linux-iio+bounces-24579-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30C4DBACDBA
	for <lists+linux-iio@lfdr.de>; Tue, 30 Sep 2025 14:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4C8816D193
	for <lists+linux-iio@lfdr.de>; Tue, 30 Sep 2025 12:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D46B2DF71E;
	Tue, 30 Sep 2025 12:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ISXDESIg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B48B25DAFF
	for <linux-iio@vger.kernel.org>; Tue, 30 Sep 2025 12:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759235782; cv=none; b=aJnGd306eZAjIPQ7VND1qwUCN7cQoAPPQKNCK6N0fxXFcE65gT5wXcJCu/scbMTdzeu02kxSt75xbkgnL4caQec9IqoCqz2kVvSpBmNSeP33unwo9f4g3l8dZBtOXjojh+picCjZ2WQS00XU7srygt9VtVnphtEcD2T4OBY8R+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759235782; c=relaxed/simple;
	bh=PO4Z7RsWEr9TS2rO1KIU895dXjg9NM9W+FTZoaH+pt4=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eQeYzPPMVfZ8pNe5lfawkAljxrftIm9jEhbZDtW7i1ua+TplpvYy8o6zVC96nvh+qpb+UfijpYUCdWQvDu0yoiF5u5jAQkZhOql16XGZQ+NLZsim9oB679HtFxeIBhx78vP/llZbRR7Q4Dtthwpm0NzqbtrY7yKlDwERPM1f3SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ISXDESIg; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45b4d89217aso38269885e9.2
        for <linux-iio@vger.kernel.org>; Tue, 30 Sep 2025 05:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759235778; x=1759840578; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WSqMeMxFp62mjfJFrogOyzqpaFj/9basZ/ZOODTQzbQ=;
        b=ISXDESIgTmzX65FDX94xfKhdJodUfiCUDyIj6pH3x+Uy+qxZ0whkv8zWhwselXXfiO
         i3WWzgH0Lm9aS673tqyUYyilK+DWKhzG9IvtrNeRChbc668GNb5y/9fmoiccYu8wTArY
         BOaXMF5Ei97sVT9H8+TgFXuNSDCZULFq3mimRgBY1YiTDb2cXuLuHxzKDtp9Zhi/wOWi
         4GMAQGZ+y0riFdfK6RKwDKNS3NDS3zjQ3N57eY8gbNfQUDF6UA3ZaQ4u57SOc9Z+PBLu
         Cn1CzhAdZ5qaC8NROoYPcnP2M2qF2HqLg6hMAcjPntJ9NxXqFnB7Wo5Jtj6QzWr9Ttxi
         vYxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759235778; x=1759840578;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WSqMeMxFp62mjfJFrogOyzqpaFj/9basZ/ZOODTQzbQ=;
        b=bVFLUkJcFG/fQ04GvIwptb3T6m5NrU58NziJ6jR+9S/OGBmCA3pBBdBizgfs5Tl4fj
         mYyM05BhUcx0+Wg7udxfaVpKLb5Sje4CUgWvfNtcb1tf7d1zwPp5oXGhpHAi8e4cs7W6
         Bh5ucIBZHSr6s7+6L9+IYakRY8LtnKRSrP62SXBqqBC639/hKVw2r7XxxzrRzHHsVR4h
         HrPDvop3X6M21/00cmFdkATxxssXdSTU0Mg8Xc4nYdmqRtO1+3N694TAzMpr1FaTqe0z
         QM3rdEyfTH/WLgIHPpgj0FnPVMLbBDv7txw1xnvtqxL7t7ANyW//q54tdVoQB0HazXSE
         Rrpg==
X-Forwarded-Encrypted: i=1; AJvYcCWMUkb8bs9RZDUAAq4QvlxQgfC6yNqB/PyLL0NfwrM6U1CJJoko9LrWXVKO6R2On9dIb7e327EHrrE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQr5OhC1eToAIm960YmtIm0dzA9jGV6OUxQUKvGgcKeuqCgvVa
	mz/ObHUxwDVRkeg42j/bs4UJKn1P7HvfOBjXHqyUZHdaOZ2RDtpH5hfh
X-Gm-Gg: ASbGncvJhtssRWsSGcbgAegAlKapxBacjNCjff239tQYolUNEaoouPfE39E7pbY/DF8
	DXjQyqHD555GeddJ4ry8wqMskLT/cIFJigGFl3BnHVNPU9T0vZIS4GqLyAR8YDCFZ5GEoOzEcKb
	shH5biWJG82WOkAjjgGhAkOGPSaWh5emIlrMuFEWnjzq866eoYiT6ot4YEgEXfGEGWc8K2RNPHQ
	RO2+iv43SseGrVEwrWkqMX/76vCilm1CSmoTHfMs6XflxRDtVMeh+3mfKMDQt10YZsrqo9XWf2R
	PX+CkTRKSU2rea8pucDIR1X2KOhechIBc2Nhq+o5uaOUaVKHq+ExEev2lMSfxKLT5sSnW0SjcKD
	xpbUAfhXNqn1C47BGj8+VXMTEnyqvUuBu1TjL66lAWR7mGpVrp+Y0Zf8MVzs3Da7kp/W9RdcovM
	tM
X-Google-Smtp-Source: AGHT+IEEuI/smK29cokzonIQEup8jptWQHmNCN9qD9fPZ7mlvXjddn70CPsdhTyJTjYrc79UGdYl3A==
X-Received: by 2002:a05:600c:820b:b0:46e:5100:326e with SMTP id 5b1f17b1804b1-46e510038cbmr92685285e9.23.1759235778385;
        Tue, 30 Sep 2025 05:36:18 -0700 (PDT)
Received: from [192.168.1.187] ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e56f536a3sm64007895e9.8.2025.09.30.05.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 05:36:18 -0700 (PDT)
Message-ID: <b4a85ca93590147c3f5943f5b0183765150c81cc.camel@gmail.com>
Subject: Re: [PATCH v2 2/6] iio: adc: ad4080: prepare driver for multi-part
 support
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>, jic23@kernel.org, 
	robh@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Date: Tue, 30 Sep 2025 13:36:46 +0100
In-Reply-To: <20250930103229.28696-2-antoniu.miclaus@analog.com>
References: <20250930103229.28696-1-antoniu.miclaus@analog.com>
	 <20250930103229.28696-2-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.0 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-09-30 at 10:32 +0000, Antoniu Miclaus wrote:
> Refactor the ad4080 driver to support multiple ADC variants with
> different resolution bits and LVDS CNV clock count maximums.
>=20
> Changes:
> - Add lvds_cnv_clk_cnt_max field to chip_info structure
> - Create AD4080_CHANNEL_DEFINE macro for variable resolution/storage bits
> - Make LVDS CNV clock count configurable per chip variant
> - Use chip_info->product_id for chip identification comparison
>=20
> This prepares the infrastructure for adding support for additional
> ADC parts with different specifications while maintaining backward
> compatibility with existing AD4080 functionality.
>=20
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> changes in v2:
> =C2=A0- allign all the \ to the left in the channel definition.
> =C2=A0drivers/iio/adc/ad4080.c | 42 ++++++++++++++++++++++---------------=
---
> =C2=A01 file changed, 23 insertions(+), 19 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad4080.c b/drivers/iio/adc/ad4080.c
> index b80560aebe2d..fa15b8f63b8a 100644
> --- a/drivers/iio/adc/ad4080.c
> +++ b/drivers/iio/adc/ad4080.c
> @@ -167,6 +167,7 @@ struct ad4080_chip_info {
> =C2=A0	const unsigned int (*scale_table)[2];
> =C2=A0	const struct iio_chan_spec *channels;
> =C2=A0	unsigned int num_channels;
> +	unsigned int lvds_cnv_clk_cnt_max;
> =C2=A0};
> =C2=A0
> =C2=A0struct ad4080_state {
> @@ -414,23 +415,25 @@ static struct iio_chan_spec_ext_info ad4080_ext_inf=
o[] =3D
> {
> =C2=A0	{ }
> =C2=A0};
> =C2=A0
> -static const struct iio_chan_spec ad4080_channel =3D {
> -	.type =3D IIO_VOLTAGE,
> -	.indexed =3D 1,
> -	.channel =3D 0,
> -	.info_mask_separate =3D BIT(IIO_CHAN_INFO_SCALE),
> -	.info_mask_shared_by_all =3D BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> -			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
> -	.info_mask_shared_by_all_available =3D
> -			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
> -	.ext_info =3D ad4080_ext_info,
> -	.scan_index =3D 0,
> -	.scan_type =3D {
> -		.sign =3D 's',
> -		.realbits =3D 20,
> -		.storagebits =3D 32,
> -	},
> -};
> +#define AD4080_CHANNEL_DEFINE(bits, storage) {				\
> +	.type =3D IIO_VOLTAGE,						\
> +	.indexed =3D 1,							\
> +	.channel =3D 0,							\
> +	.info_mask_separate =3D
> BIT(IIO_CHAN_INFO_SCALE),			\
> +	.info_mask_shared_by_all =3D BIT(IIO_CHAN_INFO_SAMP_FREQ) |	\
> +			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),		\
> +	.info_mask_shared_by_all_available =3D				\
> +			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),		\
> +	.ext_info =3D ad4080_ext_info,					\
> +	.scan_index =3D 0,						\
> +	.scan_type =3D {							\
> +		.sign =3D 's',						\
> +		.realbits =3D (bits),					\
> +		.storagebits =3D (storage),				\
> +	},								\
> +}
> +
> +static const struct iio_chan_spec ad4080_channel =3D AD4080_CHANNEL_DEFI=
NE(20,
> 32);
> =C2=A0
> =C2=A0static const struct ad4080_chip_info ad4080_chip_info =3D {
> =C2=A0	.name =3D "ad4080",
> @@ -439,6 +442,7 @@ static const struct ad4080_chip_info ad4080_chip_info=
 =3D {
> =C2=A0	.num_scales =3D ARRAY_SIZE(ad4080_scale_table),
> =C2=A0	.num_channels =3D 1,
> =C2=A0	.channels =3D &ad4080_channel,
> +	.lvds_cnv_clk_cnt_max =3D AD4080_LVDS_CNV_CLK_CNT_MAX,
> =C2=A0};
> =C2=A0
> =C2=A0static int ad4080_setup(struct iio_dev *indio_dev)
> @@ -463,7 +467,7 @@ static int ad4080_setup(struct iio_dev *indio_dev)
> =C2=A0		return ret;
> =C2=A0
> =C2=A0	id =3D get_unaligned_le16(&id);
> -	if (id !=3D AD4080_CHIP_ID)
> +	if (id !=3D st->info->product_id)
> =C2=A0		dev_info(dev, "Unrecognized CHIP_ID 0x%X\n", id);
> =C2=A0
> =C2=A0	ret =3D regmap_set_bits(st->regmap, AD4080_REG_GPIO_CONFIG_A,
> @@ -489,7 +493,7 @@ static int ad4080_setup(struct iio_dev *indio_dev)
> =C2=A0				 AD4080_REG_ADC_DATA_INTF_CONFIG_B,
> =C2=A0			=09
> AD4080_ADC_DATA_INTF_CONFIG_B_LVDS_CNV_CLK_CNT_MSK,
> =C2=A0			=09
> FIELD_PREP(AD4080_ADC_DATA_INTF_CONFIG_B_LVDS_CNV_CLK_CNT_MSK,
> -					=C2=A0=C2=A0=C2=A0 AD4080_LVDS_CNV_CLK_CNT_MAX));
> +					=C2=A0=C2=A0=C2=A0 st->info->lvds_cnv_clk_cnt_max));
> =C2=A0	if (ret)
> =C2=A0		return ret;
> =C2=A0

