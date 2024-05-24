Return-Path: <linux-iio+bounces-5263-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D87C8CE48C
	for <lists+linux-iio@lfdr.de>; Fri, 24 May 2024 12:58:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30F661C2129E
	for <lists+linux-iio@lfdr.de>; Fri, 24 May 2024 10:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C91485C69;
	Fri, 24 May 2024 10:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gJhEB/KX"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4DED85958;
	Fri, 24 May 2024 10:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716548314; cv=none; b=PBgy0xb39JoYHyZqgOBZFgqxtxsmR+yO4bVmFLAJ+KU1LohUpZVXi7pOMW+7fRqgiTu5qdmUNdUxydEomy9U70l9XERMBFy3ZTJWmcUcIeAOUS7Gy8CQRtOEyl0Mj3jptlpRWu8s9rRTrkEhY0kv0hdhz8/t19DqdQuMvSwQYmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716548314; c=relaxed/simple;
	bh=NBENWp8cRg8XQYduemKb65qnAdmWcPYivmKhiSH10TU=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C9XYsFE75guvpXvNkPi+yPcVe7jLbMLMpCaCNVeJV2T6zGPUgooFIuxTD82PCGuEv1oMdT2nE/QqdJCLnEl9Y1zc03df1jvBbO7n+AIJ3kvr8DqgBbEaK9tvT6aI5agMac8gG04rjP+aQPUVmaGibUBaT2DSgglp0VU59i7/2vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gJhEB/KX; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42011507a4eso27157945e9.0;
        Fri, 24 May 2024 03:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716548311; x=1717153111; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gs4nl2MjM9JZidv1suTCw7KbUxLvc1jObAzundhsFFo=;
        b=gJhEB/KXt9IP45WfRHzrnKBXS82WJNw/cnHgr7TyrX7uVgZHVOKwAfvKJK5YJSNCaQ
         eGldzus27SIvSyj7pIdJnwlzfCOxgOgpkYfoOyDBJ8O31NhFijSD45LxKETpefXb32XI
         pqe+nCXdVoYELDd10UAuU+ckNQAsbEH4FvBQ63IN3UALcBKBnCCcScyxDV2kooQRApYt
         YJgTHUnSwp49xOtWorTZV2oajwhAjqEy2IlCvGFLZsMEW6CynU/efKg7eLtSIXurja8p
         8jRZQMLEuZqFeEiIkACwGFRk4JMI0yA0BN84f5frksUcUwuygmTEfai6QI8QvXRsPrtm
         phbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716548311; x=1717153111;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gs4nl2MjM9JZidv1suTCw7KbUxLvc1jObAzundhsFFo=;
        b=oL1U1izwt87wAAh+HThxD3Fkug7IHGRcuB8AAq6nIvS2ocW+gP9EIm5g2cblwl9Dl2
         6ySrWh+gcgPJNZ8SRDP/Dbwnfw8kqr1oaKQe9EZXgE5Zi/Ylb/tl3d/PqvnFxdw+oQnf
         gri9ntxnzkrEae5H8asofUilm/p7/6kJzKFqqnmQShqRLjVkD8S4Qpwr1ipLoeCi8nX1
         GRVRiX6Qv1N2cfvv2Rg85FPndAFcKQmZmWx1fqdmzZHw/aQqRmNCwtBlzHF/jt6xIY56
         OjW40zsSk6VLimxXfJmmgVZiD7XShJSzs5vC8pix+vd/r4kqVy4lHFju0Zob3R9wZuJJ
         Znjg==
X-Forwarded-Encrypted: i=1; AJvYcCX4NZ9neTM7bUQ91G6FhHt+iRgN792UJKiED6lT2nHmEeIuG+VTYhrGcndkoZVN45tZ8wX6i8GO9RgE2IDcHfyiy3LePrZdKK3i/lTCGRvIroE/5f7+UMppZjrF4oXS5FzhONW6xr6yWbcgUO2Kp9cXxLhpy8S5ILADpVEegndh3R05Rg==
X-Gm-Message-State: AOJu0YxYu+0P++4vv85h97/8ee5pzFXWrPNpy/umhU7cinpCGBCHBVLO
	X8Mx17MyyIBHV9XfNP4/geT13qN0I+KqCGueSM/ovhEBcYHjpNIUo5ohPDdm
X-Google-Smtp-Source: AGHT+IGt3m17WdUEOGnb9WWrrl2pibmF8IiJK1eroILalNXmM4QAp+8TbkaepLMEPAidzdOonY4DEg==
X-Received: by 2002:a05:600c:3b89:b0:41a:b30e:42a3 with SMTP id 5b1f17b1804b1-42108a128f0mr14972585e9.37.1716548310727;
        Fri, 24 May 2024 03:58:30 -0700 (PDT)
Received: from ?IPv6:2001:a61:35f9:9001:40df:88bb:5090:7ab6? ([2001:a61:35f9:9001:40df:88bb:5090:7ab6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421089cc4e2sm17422425e9.39.2024.05.24.03.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 03:58:30 -0700 (PDT)
Message-ID: <31a428855b7094030ba506d8638d8d830f6e01d5.camel@gmail.com>
Subject: Re: [PATCH v4 02/10] drivers: iio: imu: Add support for ADIS16501
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Ramona Gradinariu <ramona.bolboaca13@gmail.com>, 
	linux-kernel@vger.kernel.org, jic23@kernel.org, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, conor+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, robh@kernel.org, nuno.sa@analog.com
Date: Fri, 24 May 2024 12:58:30 +0200
In-Reply-To: <20240524090030.336427-3-ramona.bolboaca13@gmail.com>
References: <20240524090030.336427-1-ramona.bolboaca13@gmail.com>
	 <20240524090030.336427-3-ramona.bolboaca13@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1 (3.52.1-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-05-24 at 12:00 +0300, Ramona Gradinariu wrote:
> Add support for ADIS16501 device in already existing ADIS16475
> driver.
>=20
> Signed-off-by: Ramona Gradinariu <ramona.bolboaca13@gmail.com>
> ---

Reviewed-by: Nuno Sa <nuno.sa@analog.com>

> no changes in v4
> =C2=A0drivers/iio/imu/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 4 ++--
> =C2=A0drivers/iio/imu/adis16475.c | 23 +++++++++++++++++++++++
> =C2=A02 files changed, 25 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/iio/imu/Kconfig b/drivers/iio/imu/Kconfig
> index 52a155ff3250..782fb80e44c2 100644
> --- a/drivers/iio/imu/Kconfig
> +++ b/drivers/iio/imu/Kconfig
> @@ -36,8 +36,8 @@ config ADIS16475
> =C2=A0	select IIO_ADIS_LIB_BUFFER if IIO_BUFFER
> =C2=A0	help
> =C2=A0	=C2=A0 Say yes here to build support for Analog Devices ADIS16470,=
 ADIS16475,
> -	=C2=A0 ADIS16477, ADIS16465, ADIS16467, ADIS16500, ADIS16505, ADIS16507
> inertial
> -	=C2=A0 sensors.
> +	=C2=A0 ADIS16477, ADIS16465, ADIS16467, ADIS16500, ADIS16501, ADIS16505=
,
> +	=C2=A0 ADIS16507 inertial sensors.
>=20
> =C2=A0	=C2=A0 To compile this driver as a module, choose M here: the modu=
le will be
> =C2=A0	=C2=A0 called adis16475.
> diff --git a/drivers/iio/imu/adis16475.c b/drivers/iio/imu/adis16475.c
> index 01f55cc902fa..53872b716f4a 100644
> --- a/drivers/iio/imu/adis16475.c
> +++ b/drivers/iio/imu/adis16475.c
> @@ -661,6 +661,7 @@ enum adis16475_variant {
> =C2=A0	ADIS16467_2,
> =C2=A0	ADIS16467_3,
> =C2=A0	ADIS16500,
> +	ADIS16501,
> =C2=A0	ADIS16505_1,
> =C2=A0	ADIS16505_2,
> =C2=A0	ADIS16505_3,
> @@ -980,6 +981,25 @@ static const struct adis16475_chip_info adis16475_ch=
ip_info[]
> =3D {
> =C2=A0		.flags =3D ADIS16475_HAS_BURST32 | ADIS16475_HAS_BURST_DELTA_DATA=
,
> =C2=A0		.adis_data =3D ADIS16475_DATA(16500, &adis1650x_timeouts),
> =C2=A0	},
> +	[ADIS16501] =3D {
> +		.name =3D "adis16501",
> +		.num_channels =3D ARRAY_SIZE(adis16477_channels),
> +		.channels =3D adis16477_channels,
> +		.gyro_max_val =3D 1,
> +		.gyro_max_scale =3D IIO_RAD_TO_DEGREE(40 << 16),
> +		.accel_max_val =3D 1,
> +		.accel_max_scale =3D IIO_M_S_2_TO_G(800 << 16),
> +		.temp_scale =3D 100,
> +		.deltang_max_val =3D IIO_DEGREE_TO_RAD(720),
> +		.deltvel_max_val =3D 125,
> +		.int_clk =3D 2000,
> +		.max_dec =3D 1999,
> +		.sync =3D adis16475_sync_mode,
> +		/* pulse sync not supported */
> +		.num_sync =3D ARRAY_SIZE(adis16475_sync_mode) - 1,
> +		.flags =3D ADIS16475_HAS_BURST32 | ADIS16475_HAS_BURST_DELTA_DATA,
> +		.adis_data =3D ADIS16475_DATA(16501, &adis1650x_timeouts),
> +	},
> =C2=A0	[ADIS16505_1] =3D {
> =C2=A0		.name =3D "adis16505-1",
> =C2=A0		.num_channels =3D ARRAY_SIZE(adis16477_channels),
> @@ -1482,6 +1502,8 @@ static const struct of_device_id adis16475_of_match=
[] =3D {
> =C2=A0		.data =3D &adis16475_chip_info[ADIS16467_3] },
> =C2=A0	{ .compatible =3D "adi,adis16500",
> =C2=A0		.data =3D &adis16475_chip_info[ADIS16500] },
> +	{ .compatible =3D "adi,adis16501",
> +		.data =3D &adis16475_chip_info[ADIS16501] },
> =C2=A0	{ .compatible =3D "adi,adis16505-1",
> =C2=A0		.data =3D &adis16475_chip_info[ADIS16505_1] },
> =C2=A0	{ .compatible =3D "adi,adis16505-2",
> @@ -1513,6 +1535,7 @@ static const struct spi_device_id adis16475_ids[] =
=3D {
> =C2=A0	{ "adis16467-2", (kernel_ulong_t)&adis16475_chip_info[ADIS16467_2]=
 },
> =C2=A0	{ "adis16467-3", (kernel_ulong_t)&adis16475_chip_info[ADIS16467_3]=
 },
> =C2=A0	{ "adis16500", (kernel_ulong_t)&adis16475_chip_info[ADIS16500] },
> +	{ "adis16501", (kernel_ulong_t)&adis16475_chip_info[ADIS16501] },
> =C2=A0	{ "adis16505-1", (kernel_ulong_t)&adis16475_chip_info[ADIS16505_1]=
 },
> =C2=A0	{ "adis16505-2", (kernel_ulong_t)&adis16475_chip_info[ADIS16505_2]=
 },
> =C2=A0	{ "adis16505-3", (kernel_ulong_t)&adis16475_chip_info[ADIS16505_3]=
 },
> --
> 2.34.1
>=20


