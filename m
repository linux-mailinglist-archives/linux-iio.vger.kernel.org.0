Return-Path: <linux-iio+bounces-15775-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47F4EA3BC68
	for <lists+linux-iio@lfdr.de>; Wed, 19 Feb 2025 12:07:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D38B18918F5
	for <lists+linux-iio@lfdr.de>; Wed, 19 Feb 2025 11:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88D951DE89A;
	Wed, 19 Feb 2025 11:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sgm5Akw0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBEEB1A840D
	for <linux-iio@vger.kernel.org>; Wed, 19 Feb 2025 11:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739963254; cv=none; b=Fuh3Xz/itK8wbxXpBWc598Fi6mYv8VM4PQATvTH6ODL4yvSoSFqpnnH9orT+iH8m/THouQ0YKjKhKkRka53hCP0LmYuC6t+vi96PUzT5+k98sq5BXVaDhEyIIcMaqwkUmFMsjRxHddFBtW17rgo0hGXgDlMTwYZus86lZHE2OnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739963254; c=relaxed/simple;
	bh=E5WFug75yG8f8xlG/GlH0s7iurYeHFKwMXVkW9tIGe8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Zio7E4VejF0/RAt5L+f1GOTievBhOrRvGlTOUUO5n1kaswHrdm6bEfSR+ya/4/+lj7/7tsNKLWPYxBb3eMQ+H6Nbl5aVl19RdK4L28okDR6aJ0CoMpjUHfORXemMKEUUpMTNlf8pClawfdmEFX4cUGBqykTXmiLIRqQuQF51cGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sgm5Akw0; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-38f2b7ce2f3so4321761f8f.0
        for <linux-iio@vger.kernel.org>; Wed, 19 Feb 2025 03:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739963250; x=1740568050; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cXkaZjMKHiYrpdWSAqoBgOaLvuurhl+w+iwdXcBzCrU=;
        b=Sgm5Akw0d3+1aY5iFR3AY+iX1Sj+nbqq/NynsZohhazhzdrmywdsbjZ+NOJ0HSPb9P
         UgRsMtfNf0bPwnTQAa1MV34F5IAxEqA4aNUdGuwn8SrAD9LimXR9mSWrdAhdN05LkmQb
         eXO32leWZCBgHvt8sj4/UZ2EcGmoSMhkHr3NSba3AsducLC3AYT9JkgV99ebL4RgjsN5
         Njr4fx0n+cOoiqckU7bGPYDIlHqUXXnNwVnCXhb800IslaouXMMtUpDdrJA7hGz38CGu
         t00sQOT3Ye2rUB2DvpiMzdrf5CMXwlsDZHwigUnNwOdMzGwEusGB0R4vqxgckaaKKPMR
         Dk8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739963250; x=1740568050;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cXkaZjMKHiYrpdWSAqoBgOaLvuurhl+w+iwdXcBzCrU=;
        b=EJFVJ2JWcvZMv7DEjqa1NuSXdsYrsdd3PhE/qbByhEVSrq7ZD3yK0M4j5GYPlLWAkf
         69GpaYPen+nlsJI6YEKPd5mtHIrniG07k8+Ac1lpGmdMaGdVUJg0BKdtr02ehR57JKQw
         sCtYQBEviJMvfFHwIwAf+HkdjJ5mbYuXZkkfD7HkJLr+p41tQJDFJeZgCEDG+HxTYd6w
         l73aD2BHdIdj6Luk1bl8FLvsSdvTBAZttZDHPGesrQrldCb43DuO0PoFVUPtr+LmkCQ0
         RxBTB2yNZDIIxZGnujQW69n/8StvtwpS2NLHnxv0Gu6pSJGQuRpWfdQ6Ef0/zXLv9rqu
         blNQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/HGrKnk65r1RCNgGtCzbMau39V/Kx3VwXLPI9TIVVF4XDOYsfidhwsOJp5V19EJbpa+uoLKO31As=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNygBkwzpQeygbKFBJJncTsS8wEovl2cErc73Him+P935GUQYQ
	bRRR4LuiKfFH/nd+2Y2VUP8LWsA/g8OSXxIkEwxaiAGClAjLNALE
X-Gm-Gg: ASbGncvgCL125js6DkLZX74sE72ABqJNTN/YXLXF6BUM4hFFEVlc7CIXbTfnnqsvBdG
	CAmr6cSI1yWRJWW3VQzm8dCxGdC3Mu7H/ZKADkcjzD9ZyxXh/F+CyibNZN4NYHzEmUbrnwg/83H
	nulf5/Wg+67R//66DyaqmWhf4CyiFNolA4laVk+Ij8q1xFtO/7H+K+bcILMSy0yh3Ry9G8W8vgi
	Knml+/ZqsKL1F90cOsonY9I8w8oYmhJFHgB52N6iVSgc8mxAU39wQOPgeZK+4T3G939J/tZlHcz
	l7oJgDDtUCr5drJTidCTlXgv6h71672KZ8pocf1MBidItj2cuLZIhrU5Q52HEQE=
X-Google-Smtp-Source: AGHT+IGjFuKCSWctA0H9gOy8hwHnJ81geiORvHDsg/FYzGKyZqZ2we/Bj5jlYOGx9HnxZkOr2Yre4Q==
X-Received: by 2002:adf:e80a:0:b0:38f:2230:c0ff with SMTP id ffacd0b85a97d-38f33f4ea6dmr12665266f8f.30.1739963249921;
        Wed, 19 Feb 2025 03:07:29 -0800 (PST)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f25a0fa2dsm17334892f8f.101.2025.02.19.03.07.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 03:07:28 -0800 (PST)
Message-ID: <df8ee3042ac351954ace12afbed8e63f1953fabc.camel@gmail.com>
Subject: Re: [PATCH 29/29] iio: adc: Switch to sparse friendly
 iio_device_claim/release_direct()
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>, Olivier Moysan	
 <olivier.moysan@foss.st.com>, Mike Looijmans <mike.looijmans@topic.nl>,
 Phil Reid <preid@electromag.com.au>, Marek Vasut
 <marek.vasut+renesas@gmail.com>, Miquel Raynal	
 <miquel.raynal@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, Uwe
 =?ISO-8859-1?Q?Kleine-K=F6nig?=	 <u.kleine-koenig@baylibre.com>,
 Alisa-Dariana Roman <alisa.roman@analog.com>,  Marek Vasut <marex@denx.de>,
 Frank Li <Frank.Li@nxp.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Date: Wed, 19 Feb 2025 11:07:32 +0000
In-Reply-To: <20250217141630.897334-30-jic23@kernel.org>
References: <20250217141630.897334-1-jic23@kernel.org>
	 <20250217141630.897334-30-jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-02-17 at 14:16 +0000, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>=20
> Single patch for all the relatively simple cases.
>=20
> These new functions allow sparse to find failures to release
> direct mode reducing chances of bugs over the claim_direct_mode()
> functions that are deprecated.
>=20
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Olivier Moysan <olivier.moysan@foss.st.com>
> Cc: Mike Looijmans <mike.looijmans@topic.nl>
> Cc: Phil Reid <preid@electromag.com.au>
> ---

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> =C2=A0drivers/iio/adc/ad7173.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
|=C2=A0 9 +++---
> =C2=A0drivers/iio/adc/ad7266.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
|=C2=A0 7 ++---
> =C2=A0drivers/iio/adc/ad7298.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
|=C2=A0 7 ++---
> =C2=A0drivers/iio/adc/ad7380.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
| 56 ++++++++++++++-------------------
> =C2=A0drivers/iio/adc/ad7476.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
|=C2=A0 7 ++---
> =C2=A0drivers/iio/adc/ad7887.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
|=C2=A0 7 ++---
> =C2=A0drivers/iio/adc/ad7923.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
|=C2=A0 7 ++---
> =C2=A0drivers/iio/adc/ad7944.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
|=C2=A0 7 ++---
> =C2=A0drivers/iio/adc/dln2-adc.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 7 =
++---
> =C2=A0drivers/iio/adc/stm32-adc.c=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 7 ++---
> =C2=A0drivers/iio/adc/ti-adc084s021.c |=C2=A0 9 +++---
> =C2=A0drivers/iio/adc/ti-adc108s102.c |=C2=A0 7 ++---
> =C2=A0drivers/iio/adc/ti-ads1298.c=C2=A0=C2=A0=C2=A0 |=C2=A0 7 ++---
> =C2=A0drivers/iio/adc/ti-ads131e08.c=C2=A0 | 14 ++++-----
> =C2=A0drivers/iio/adc/ti-tlc4541.c=C2=A0=C2=A0=C2=A0 |=C2=A0 7 ++---
> =C2=A015 files changed, 71 insertions(+), 94 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
> index 54f9cc5a89f5..ca2b41b16cc9 100644
> --- a/drivers/iio/adc/ad7173.c
> +++ b/drivers/iio/adc/ad7173.c
> @@ -1157,11 +1157,10 @@ static int ad7173_write_raw(struct iio_dev *indio=
_dev,
> =C2=A0	struct ad7173_state *st =3D iio_priv(indio_dev);
> =C2=A0	struct ad7173_channel_config *cfg;
> =C2=A0	unsigned int freq, i;
> -	int ret;
> +	int ret =3D 0;
> =C2=A0
> -	ret =3D iio_device_claim_direct_mode(indio_dev);
> -	if (ret)
> -		return ret;
> +	if (!iio_device_claim_direct(indio_dev))
> +		return -EBUSY;
> =C2=A0
> =C2=A0	switch (info) {
> =C2=A0	/*
> @@ -1195,7 +1194,7 @@ static int ad7173_write_raw(struct iio_dev *indio_d=
ev,
> =C2=A0		break;
> =C2=A0	}
> =C2=A0
> -	iio_device_release_direct_mode(indio_dev);
> +	iio_device_release_direct(indio_dev);
> =C2=A0	return ret;
> =C2=A0}
> =C2=A0
> diff --git a/drivers/iio/adc/ad7266.c b/drivers/iio/adc/ad7266.c
> index 858c8be2ff1a..18559757f908 100644
> --- a/drivers/iio/adc/ad7266.c
> +++ b/drivers/iio/adc/ad7266.c
> @@ -153,11 +153,10 @@ static int ad7266_read_raw(struct iio_dev *indio_de=
v,
> =C2=A0
> =C2=A0	switch (m) {
> =C2=A0	case IIO_CHAN_INFO_RAW:
> -		ret =3D iio_device_claim_direct_mode(indio_dev);
> -		if (ret)
> -			return ret;
> +		if (!iio_device_claim_direct(indio_dev))
> +			return -EBUSY;
> =C2=A0		ret =3D ad7266_read_single(st, val, chan->address);
> -		iio_device_release_direct_mode(indio_dev);
> +		iio_device_release_direct(indio_dev);
> =C2=A0
> =C2=A0		if (ret < 0)
> =C2=A0			return ret;
> diff --git a/drivers/iio/adc/ad7298.c b/drivers/iio/adc/ad7298.c
> index b35bd4d9ef81..28b88092b4aa 100644
> --- a/drivers/iio/adc/ad7298.c
> +++ b/drivers/iio/adc/ad7298.c
> @@ -232,16 +232,15 @@ static int ad7298_read_raw(struct iio_dev *indio_de=
v,
> =C2=A0
> =C2=A0	switch (m) {
> =C2=A0	case IIO_CHAN_INFO_RAW:
> -		ret =3D iio_device_claim_direct_mode(indio_dev);
> -		if (ret)
> -			return ret;
> +		if (!iio_device_claim_direct(indio_dev))
> +			return -EBUSY;
> =C2=A0
> =C2=A0		if (chan->address =3D=3D AD7298_CH_TEMP)
> =C2=A0			ret =3D ad7298_scan_temp(st, val);
> =C2=A0		else
> =C2=A0			ret =3D ad7298_scan_direct(st, chan->address);
> =C2=A0
> -		iio_device_release_direct_mode(indio_dev);
> +		iio_device_release_direct(indio_dev);
> =C2=A0
> =C2=A0		if (ret < 0)
> =C2=A0			return ret;
> diff --git a/drivers/iio/adc/ad7380.c b/drivers/iio/adc/ad7380.c
> index a18dcd664c1b..f232ad1a4963 100644
> --- a/drivers/iio/adc/ad7380.c
> +++ b/drivers/iio/adc/ad7380.c
> @@ -716,16 +716,15 @@ static int ad7380_debugfs_reg_access(struct iio_dev
> *indio_dev, u32 reg,
> =C2=A0	struct ad7380_state *st =3D iio_priv(indio_dev);
> =C2=A0	int ret;
> =C2=A0
> -	ret =3D iio_device_claim_direct_mode(indio_dev);
> -	if (ret)
> -		return ret;
> +	if (!iio_device_claim_direct(indio_dev))
> +		return -EBUSY;
> =C2=A0
> =C2=A0	if (readval)
> =C2=A0		ret =3D regmap_read(st->regmap, reg, readval);
> =C2=A0	else
> =C2=A0		ret =3D regmap_write(st->regmap, reg, writeval);
> =C2=A0
> -	iio_device_release_direct_mode(indio_dev);
> +	iio_device_release_direct(indio_dev);
> =C2=A0
> =C2=A0	return ret;
> =C2=A0}
> @@ -1018,14 +1017,13 @@ static int ad7380_read_raw(struct iio_dev *indio_=
dev,
> =C2=A0
> =C2=A0	switch (info) {
> =C2=A0	case IIO_CHAN_INFO_RAW:
> -		ret =3D iio_device_claim_direct_mode(indio_dev);
> -		if (ret)
> -			return ret;
> +		if (!iio_device_claim_direct(indio_dev))
> +			return -EBUSY;
> =C2=A0
> =C2=A0		ret =3D ad7380_read_direct(st, chan->scan_index,
> =C2=A0					 scan_type, val);
> =C2=A0
> -		iio_device_release_direct_mode(indio_dev);
> +		iio_device_release_direct(indio_dev);
> =C2=A0
> =C2=A0		return ret;
> =C2=A0	case IIO_CHAN_INFO_SCALE:
> @@ -1056,13 +1054,12 @@ static int ad7380_read_raw(struct iio_dev *indio_=
dev,
> =C2=A0
> =C2=A0		return IIO_VAL_INT;
> =C2=A0	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> -		ret =3D iio_device_claim_direct_mode(indio_dev);
> -		if (ret)
> -			return ret;
> +		if (!iio_device_claim_direct(indio_dev))
> +			return -EBUSY;
> =C2=A0
> =C2=A0		ret =3D ad7380_get_osr(st, val);
> =C2=A0
> -		iio_device_release_direct_mode(indio_dev);
> +		iio_device_release_direct(indio_dev);
> =C2=A0
> =C2=A0		if (ret)
> =C2=A0			return ret;
> @@ -1155,13 +1152,12 @@ static int ad7380_write_raw(struct iio_dev *indio=
_dev,
> =C2=A0
> =C2=A0	switch (mask) {
> =C2=A0	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> -		ret =3D iio_device_claim_direct_mode(indio_dev);
> -		if (ret)
> -			return ret;
> +		if (!iio_device_claim_direct(indio_dev))
> +			return -EBUSY;
> =C2=A0
> =C2=A0		ret =3D ad7380_set_oversampling_ratio(st, val);
> =C2=A0
> -		iio_device_release_direct_mode(indio_dev);
> +		iio_device_release_direct(indio_dev);
> =C2=A0
> =C2=A0		return ret;
> =C2=A0	default:
> @@ -1186,13 +1182,12 @@ static int ad7380_read_event_config(struct iio_de=
v
> *indio_dev,
> =C2=A0	struct ad7380_state *st =3D iio_priv(indio_dev);
> =C2=A0	int tmp, ret;
> =C2=A0
> -	ret =3D iio_device_claim_direct_mode(indio_dev);
> -	if (ret)
> -		return ret;
> +	if (!iio_device_claim_direct(indio_dev))
> +		return -EBUSY;
> =C2=A0
> =C2=A0	ret =3D regmap_read(st->regmap, AD7380_REG_ADDR_CONFIG1, &tmp);
> =C2=A0
> -	iio_device_release_direct_mode(indio_dev);
> +	iio_device_release_direct(indio_dev);
> =C2=A0
> =C2=A0	if (ret)
> =C2=A0		return ret;
> @@ -1209,16 +1204,15 @@ static int ad7380_write_event_config(struct iio_d=
ev
> *indio_dev,
> =C2=A0	struct ad7380_state *st =3D iio_priv(indio_dev);
> =C2=A0	int ret;
> =C2=A0
> -	ret =3D iio_device_claim_direct_mode(indio_dev);
> -	if (ret)
> -		return ret;
> +	if (!iio_device_claim_direct(indio_dev))
> +		return -EBUSY;
> =C2=A0
> =C2=A0	ret =3D regmap_update_bits(st->regmap,
> =C2=A0				 AD7380_REG_ADDR_CONFIG1,
> =C2=A0				 AD7380_CONFIG1_ALERTEN,
> =C2=A0				 FIELD_PREP(AD7380_CONFIG1_ALERTEN, state));
> =C2=A0
> -	iio_device_release_direct_mode(indio_dev);
> +	iio_device_release_direct(indio_dev);
> =C2=A0
> =C2=A0	return ret;
> =C2=A0}
> @@ -1265,13 +1259,12 @@ static int ad7380_read_event_value(struct iio_dev
> *indio_dev,
> =C2=A0
> =C2=A0	switch (info) {
> =C2=A0	case IIO_EV_INFO_VALUE:
> -		ret =3D iio_device_claim_direct_mode(indio_dev);
> -		if (ret)
> -			return ret;
> +		if (!iio_device_claim_direct(indio_dev))
> +			return -EBUSY;
> =C2=A0
> =C2=A0		ret =3D ad7380_get_alert_th(st, dir, val);
> =C2=A0
> -		iio_device_release_direct_mode(indio_dev);
> +		iio_device_release_direct(indio_dev);
> =C2=A0		return ret;
> =C2=A0	default:
> =C2=A0		return -EINVAL;
> @@ -1332,13 +1325,12 @@ static int ad7380_write_event_value(struct iio_de=
v
> *indio_dev,
> =C2=A0
> =C2=A0	switch (info) {
> =C2=A0	case IIO_EV_INFO_VALUE:
> -		ret =3D iio_device_claim_direct_mode(indio_dev);
> -		if (ret)
> -			return ret;
> +		if (!iio_device_claim_direct(indio_dev))
> +			return -EBUSY;
> =C2=A0
> =C2=A0		ret =3D ad7380_set_alert_th(indio_dev, chan, dir, val);
> =C2=A0
> -		iio_device_release_direct_mode(indio_dev);
> +		iio_device_release_direct(indio_dev);
> =C2=A0		return ret;
> =C2=A0	default:
> =C2=A0		return -EINVAL;
> diff --git a/drivers/iio/adc/ad7476.c b/drivers/iio/adc/ad7476.c
> index aeb8e383fe71..37b0515cf4fc 100644
> --- a/drivers/iio/adc/ad7476.c
> +++ b/drivers/iio/adc/ad7476.c
> @@ -138,11 +138,10 @@ static int ad7476_read_raw(struct iio_dev *indio_de=
v,
> =C2=A0
> =C2=A0	switch (m) {
> =C2=A0	case IIO_CHAN_INFO_RAW:
> -		ret =3D iio_device_claim_direct_mode(indio_dev);
> -		if (ret)
> -			return ret;
> +		if (!iio_device_claim_direct(indio_dev))
> +			return -EBUSY;
> =C2=A0		ret =3D ad7476_scan_direct(st);
> -		iio_device_release_direct_mode(indio_dev);
> +		iio_device_release_direct(indio_dev);
> =C2=A0
> =C2=A0		if (ret < 0)
> =C2=A0			return ret;
> diff --git a/drivers/iio/adc/ad7887.c b/drivers/iio/adc/ad7887.c
> index 69add1dc4b53..87ff95643794 100644
> --- a/drivers/iio/adc/ad7887.c
> +++ b/drivers/iio/adc/ad7887.c
> @@ -152,11 +152,10 @@ static int ad7887_read_raw(struct iio_dev *indio_de=
v,
> =C2=A0
> =C2=A0	switch (m) {
> =C2=A0	case IIO_CHAN_INFO_RAW:
> -		ret =3D iio_device_claim_direct_mode(indio_dev);
> -		if (ret)
> -			return ret;
> +		if (!iio_device_claim_direct(indio_dev))
> +			return -EBUSY;
> =C2=A0		ret =3D ad7887_scan_direct(st, chan->address);
> -		iio_device_release_direct_mode(indio_dev);
> +		iio_device_release_direct(indio_dev);
> =C2=A0
> =C2=A0		if (ret < 0)
> =C2=A0			return ret;
> diff --git a/drivers/iio/adc/ad7923.c b/drivers/iio/adc/ad7923.c
> index acc44cb34f82..87945efb940b 100644
> --- a/drivers/iio/adc/ad7923.c
> +++ b/drivers/iio/adc/ad7923.c
> @@ -260,11 +260,10 @@ static int ad7923_read_raw(struct iio_dev *indio_de=
v,
> =C2=A0
> =C2=A0	switch (m) {
> =C2=A0	case IIO_CHAN_INFO_RAW:
> -		ret =3D iio_device_claim_direct_mode(indio_dev);
> -		if (ret)
> -			return ret;
> +		if (!iio_device_claim_direct(indio_dev))
> +			return -EBUSY;
> =C2=A0		ret =3D ad7923_scan_direct(st, chan->address);
> -		iio_device_release_direct_mode(indio_dev);
> +		iio_device_release_direct(indio_dev);
> =C2=A0
> =C2=A0		if (ret < 0)
> =C2=A0			return ret;
> diff --git a/drivers/iio/adc/ad7944.c b/drivers/iio/adc/ad7944.c
> index 9a7825ea5087..2f949fe55873 100644
> --- a/drivers/iio/adc/ad7944.c
> +++ b/drivers/iio/adc/ad7944.c
> @@ -407,12 +407,11 @@ static int ad7944_read_raw(struct iio_dev *indio_de=
v,
> =C2=A0
> =C2=A0	switch (info) {
> =C2=A0	case IIO_CHAN_INFO_RAW:
> -		ret =3D iio_device_claim_direct_mode(indio_dev);
> -		if (ret)
> -			return ret;
> +		if (!iio_device_claim_direct(indio_dev))
> +			return -EBUSY;
> =C2=A0
> =C2=A0		ret =3D ad7944_single_conversion(adc, chan, val);
> -		iio_device_release_direct_mode(indio_dev);
> +		iio_device_release_direct(indio_dev);
> =C2=A0		return ret;
> =C2=A0
> =C2=A0	case IIO_CHAN_INFO_SCALE:
> diff --git a/drivers/iio/adc/dln2-adc.c b/drivers/iio/adc/dln2-adc.c
> index 221a5fdc1eaa..b9029fa13b32 100644
> --- a/drivers/iio/adc/dln2-adc.c
> +++ b/drivers/iio/adc/dln2-adc.c
> @@ -314,15 +314,14 @@ static int dln2_adc_read_raw(struct iio_dev *indio_=
dev,
> =C2=A0
> =C2=A0	switch (mask) {
> =C2=A0	case IIO_CHAN_INFO_RAW:
> -		ret =3D iio_device_claim_direct_mode(indio_dev);
> -		if (ret < 0)
> -			return ret;
> +		if (!iio_device_claim_direct(indio_dev))
> +			return -EBUSY;;
> =C2=A0
> =C2=A0		mutex_lock(&dln2->mutex);
> =C2=A0		ret =3D dln2_adc_read(dln2, chan->channel);
> =C2=A0		mutex_unlock(&dln2->mutex);
> =C2=A0
> -		iio_device_release_direct_mode(indio_dev);
> +		iio_device_release_direct(indio_dev);
> =C2=A0
> =C2=A0		if (ret < 0)
> =C2=A0			return ret;
> diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
> index 9d3b23efcc06..5dbf5f136768 100644
> --- a/drivers/iio/adc/stm32-adc.c
> +++ b/drivers/iio/adc/stm32-adc.c
> @@ -1471,9 +1471,8 @@ static int stm32_adc_read_raw(struct iio_dev *indio=
_dev,
> =C2=A0	switch (mask) {
> =C2=A0	case IIO_CHAN_INFO_RAW:
> =C2=A0	case IIO_CHAN_INFO_PROCESSED:
> -		ret =3D iio_device_claim_direct_mode(indio_dev);
> -		if (ret)
> -			return ret;
> +		if (!iio_device_claim_direct(indio_dev))
> +			return -EBUSY;
> =C2=A0		if (chan->type =3D=3D IIO_VOLTAGE)
> =C2=A0			ret =3D stm32_adc_single_conv(indio_dev, chan, val);
> =C2=A0		else
> @@ -1482,7 +1481,7 @@ static int stm32_adc_read_raw(struct iio_dev *indio=
_dev,
> =C2=A0		if (mask =3D=3D IIO_CHAN_INFO_PROCESSED)
> =C2=A0			*val =3D STM32_ADC_VREFINT_VOLTAGE * adc-
> >vrefint.vrefint_cal / *val;
> =C2=A0
> -		iio_device_release_direct_mode(indio_dev);
> +		iio_device_release_direct(indio_dev);
> =C2=A0		return ret;
> =C2=A0
> =C2=A0	case IIO_CHAN_INFO_SCALE:
> diff --git a/drivers/iio/adc/ti-adc084s021.c b/drivers/iio/adc/ti-adc084s=
021.c
> index da16876c32ae..9c845ee01697 100644
> --- a/drivers/iio/adc/ti-adc084s021.c
> +++ b/drivers/iio/adc/ti-adc084s021.c
> @@ -96,19 +96,18 @@ static int adc084s021_read_raw(struct iio_dev *indio_=
dev,
> =C2=A0
> =C2=A0	switch (mask) {
> =C2=A0	case IIO_CHAN_INFO_RAW:
> -		ret =3D iio_device_claim_direct_mode(indio_dev);
> -		if (ret < 0)
> -			return ret;
> +		if (!iio_device_claim_direct(indio_dev))
> +			return -EBUSY;
> =C2=A0
> =C2=A0		ret =3D regulator_enable(adc->reg);
> =C2=A0		if (ret) {
> -			iio_device_release_direct_mode(indio_dev);
> +			iio_device_release_direct(indio_dev);
> =C2=A0			return ret;
> =C2=A0		}
> =C2=A0
> =C2=A0		adc->tx_buf[0] =3D channel->channel << 3;
> =C2=A0		ret =3D adc084s021_adc_conversion(adc, &be_val);
> -		iio_device_release_direct_mode(indio_dev);
> +		iio_device_release_direct(indio_dev);
> =C2=A0		regulator_disable(adc->reg);
> =C2=A0		if (ret < 0)
> =C2=A0			return ret;
> diff --git a/drivers/iio/adc/ti-adc108s102.c b/drivers/iio/adc/ti-adc108s=
102.c
> index 9758ac801310..7d615e2bbf39 100644
> --- a/drivers/iio/adc/ti-adc108s102.c
> +++ b/drivers/iio/adc/ti-adc108s102.c
> @@ -181,13 +181,12 @@ static int adc108s102_read_raw(struct iio_dev
> *indio_dev,
> =C2=A0
> =C2=A0	switch (m) {
> =C2=A0	case IIO_CHAN_INFO_RAW:
> -		ret =3D iio_device_claim_direct_mode(indio_dev);
> -		if (ret)
> -			return ret;
> +		if (!iio_device_claim_direct(indio_dev))
> +			return -EBUSY;
> =C2=A0
> =C2=A0		ret =3D adc108s102_scan_direct(st, chan->address);
> =C2=A0
> -		iio_device_release_direct_mode(indio_dev);
> +		iio_device_release_direct(indio_dev);
> =C2=A0
> =C2=A0		if (ret < 0)
> =C2=A0			return ret;
> diff --git a/drivers/iio/adc/ti-ads1298.c b/drivers/iio/adc/ti-ads1298.c
> index 03f762415fa5..ae30b47e4514 100644
> --- a/drivers/iio/adc/ti-ads1298.c
> +++ b/drivers/iio/adc/ti-ads1298.c
> @@ -319,13 +319,12 @@ static int ads1298_read_raw(struct iio_dev *indio_d=
ev,
> =C2=A0
> =C2=A0	switch (mask) {
> =C2=A0	case IIO_CHAN_INFO_RAW:
> -		ret =3D iio_device_claim_direct_mode(indio_dev);
> -		if (ret)
> -			return ret;
> +		if (!iio_device_claim_direct(indio_dev))
> +			return -EBUSY;
> =C2=A0
> =C2=A0		ret =3D ads1298_read_one(priv, chan->scan_index);
> =C2=A0
> -		iio_device_release_direct_mode(indio_dev);
> +		iio_device_release_direct(indio_dev);
> =C2=A0
> =C2=A0		if (ret)
> =C2=A0			return ret;
> diff --git a/drivers/iio/adc/ti-ads131e08.c b/drivers/iio/adc/ti-ads131e0=
8.c
> index 91a79ebc4bde..c6096b64664e 100644
> --- a/drivers/iio/adc/ti-ads131e08.c
> +++ b/drivers/iio/adc/ti-ads131e08.c
> @@ -505,12 +505,11 @@ static int ads131e08_read_raw(struct iio_dev *indio=
_dev,
> =C2=A0
> =C2=A0	switch (mask) {
> =C2=A0	case IIO_CHAN_INFO_RAW:
> -		ret =3D iio_device_claim_direct_mode(indio_dev);
> -		if (ret)
> -			return ret;
> +		if (!iio_device_claim_direct(indio_dev))
> +			return -EBUSY;
> =C2=A0
> =C2=A0		ret =3D ads131e08_read_direct(indio_dev, channel, value);
> -		iio_device_release_direct_mode(indio_dev);
> +		iio_device_release_direct(indio_dev);
> =C2=A0		if (ret)
> =C2=A0			return ret;
> =C2=A0
> @@ -551,12 +550,11 @@ static int ads131e08_write_raw(struct iio_dev
> *indio_dev,
> =C2=A0
> =C2=A0	switch (mask) {
> =C2=A0	case IIO_CHAN_INFO_SAMP_FREQ:
> -		ret =3D iio_device_claim_direct_mode(indio_dev);
> -		if (ret)
> -			return ret;
> +		if (!iio_device_claim_direct(indio_dev))
> +			return -EBUSY;
> =C2=A0
> =C2=A0		ret =3D ads131e08_set_data_rate(st, value);
> -		iio_device_release_direct_mode(indio_dev);
> +		iio_device_release_direct(indio_dev);
> =C2=A0		return ret;
> =C2=A0
> =C2=A0	default:
> diff --git a/drivers/iio/adc/ti-tlc4541.c b/drivers/iio/adc/ti-tlc4541.c
> index 08de997584fd..5a138be983ed 100644
> --- a/drivers/iio/adc/ti-tlc4541.c
> +++ b/drivers/iio/adc/ti-tlc4541.c
> @@ -131,11 +131,10 @@ static int tlc4541_read_raw(struct iio_dev *indio_d=
ev,
> =C2=A0
> =C2=A0	switch (m) {
> =C2=A0	case IIO_CHAN_INFO_RAW:
> -		ret =3D iio_device_claim_direct_mode(indio_dev);
> -		if (ret)
> -			return ret;
> +		if (!iio_device_claim_direct(indio_dev))
> +			return -EBUSY;
> =C2=A0		ret =3D spi_sync(st->spi, &st->scan_single_msg);
> -		iio_device_release_direct_mode(indio_dev);
> +		iio_device_release_direct(indio_dev);
> =C2=A0		if (ret < 0)
> =C2=A0			return ret;
> =C2=A0		*val =3D be16_to_cpu(st->rx_buf[0]);


