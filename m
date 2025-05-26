Return-Path: <linux-iio+bounces-19938-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44575AC3DCD
	for <lists+linux-iio@lfdr.de>; Mon, 26 May 2025 12:24:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DBAD174608
	for <lists+linux-iio@lfdr.de>; Mon, 26 May 2025 10:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA31A1F4C94;
	Mon, 26 May 2025 10:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ThEbFjcY"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C3D143C61;
	Mon, 26 May 2025 10:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748255074; cv=none; b=fRtQ/35AVFxOQF45VGsetpDP+gbPBhaOp0C18R1ZXo4zoi5nLJKZjVvXBWI2wZX1mTe317AiQ+y6wMtdAiM0arS5P1i/I+IRutZ6Bcq7wpwKLkPjkn57TqhqpQ1Zpa/ZCNuQL0BhLUdS6bp3totiOJet+7KN0xq0y8F8Y9EMCqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748255074; c=relaxed/simple;
	bh=eqMydirwLP6yy2idAoI+2A8U8zcvWCQqtqIUlPrigB8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nzUWUh2sUnxyHU5NdDlD0H4wCySrFXGOOdwgdigtJ4VHGAUabhUmrPgxal0MJtCufRhfI8e1MQiXbotd+9D/CimqcPnjLrNXk3/2m+6ZUQXZT8DXZSWgPDw3eTUOzUSvxjgQE4LMZNyJgPpIfTL805L89KjlDE6AFDiFPQ5MMDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ThEbFjcY; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ad56cbc7b07so305187466b.0;
        Mon, 26 May 2025 03:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748255071; x=1748859871; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=S9CSjA299U5LS9eq78+RzW3leSPrseR6VLCby+LH7hM=;
        b=ThEbFjcYnF1PYCwUAfBoSYymuGJQfyQoBcX09amxwP2hxLHMY/V7aXXe0dcrGiD/cj
         bjYV6cny6w4oEwN4elRO+ofe4jEQw+AwJYlkTrQIS1O9Yx/Ar/KdGH7rt0Y2PtPlYGB0
         i/z7JyxEHwdxBL5TuMuRchYljdC1mGOjgQUCnbqPfQ6hg/Qdovzm5A5gS9ots2h3AqU1
         2OIwSG4t+bLIE+a1JW4uSmOVp0TC8w97cRJnAjaOtgDCrEH8TbT1mncjXXfe03JZtpJh
         C2oEZA7WFte1MU7jxMkGtu+DRCp0cWkZwFiZJg3vTEq3N1xtU5NUZPG+cSq8fTME9MZV
         HTAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748255071; x=1748859871;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S9CSjA299U5LS9eq78+RzW3leSPrseR6VLCby+LH7hM=;
        b=V/79GfnEhJoVvTNqC7fd4HTaGnrVCgIV/Svo6kR6WuJYKvRm372qSELDN53zq/VtmE
         rvSSmNDtvn3zcowll8VxsttRRAGEXn3H3dNNlQIVBFbS08fz8Lh4zz2xKyfp9ui750bd
         4sipJ1apR+isL0cctWps4vKLOKBjlhgnNp9iEu3PD4ctnfZQm35Dr9eVOMOgFZCm0taZ
         Mdbo+i/x9SSb+q6PY0Mls2E4kpsQVFmVjCp0Bjx/URuScAS5upgrEXbW9leC9JXNxtQO
         NtKvnu4rEcymmM/l2vEHb+rR9ThtsqNrUF09YqJjsF9LEnr+uPgfGfUxteqXnHP5YBd+
         xnag==
X-Forwarded-Encrypted: i=1; AJvYcCU3xDoz7DfWXQpB+kZ+kPeExwcaYpQziZ1/xpFgbsNrHf8v1NDQXc7GgZiqv1KuJTYC0M0qPRG/yooN@vger.kernel.org, AJvYcCVf+S6+H+ktXHWMVE0vG6WIAMk90CK4p5cbM/n+Yw/ZnDOAeRF1QcDojmRZxXvNBGtjv6GoZHE7AVAF@vger.kernel.org, AJvYcCX7wKZME9JeB6TzQwNdfmmzaMsKV7FJQROKiZ1GzUddVnkcUunHcN8NkHl0KGqxLdOPYUcl0okfr38MaQ==@vger.kernel.org, AJvYcCXuaHI/4mZI8J+MqQTtVFuvXQv9fDg4gPptCzGZxdy/ownZ0cClcLex97TFw9MLAiL9fTBbWouJz1t4+JXt@vger.kernel.org
X-Gm-Message-State: AOJu0YwYd5Ng3OTvnMpF1+WiS/j05JTQ9htMgBB3PxBdpkLlZyJrXlLQ
	8DMXe0SGbY1kWyA/XL8g2iiQ5iTXry9ohVFXNGEKutVCS0q0LmkpSp7P
X-Gm-Gg: ASbGncsDZNfJkZwWrFSdsDJ0JD6knRBRl+aPX/xru7E0OTODZXX4MFFgKFZG3O+DFLt
	fZfvChGGR7gmykeAL9YAslGGfXH8L3wKh9DxGOlWw/6NDtOQi/KKuPcxTImMZOFPPYUYZUhSIly
	zHmI/Esk9WHhx+e+iKgkwuuC8tidlvXD873y6Lhx3j7/ELUALWROX2p5pJ5fZV1rm/Pw2fUMZtJ
	XenynOOpXF6LTIJbEliM2OczCDgxDxYLWEPUKe+88ncq7T5VbrjyE8kIJsAYq22s8SBBSfU2edx
	SfRC52BYjIdJ/zUz+1ZqhSyx6jhWQCM35PfQWnxNg79O7UbF+vkkde2n
X-Google-Smtp-Source: AGHT+IE5X1osCQ5FXGkkSisXzzeIYflw9Tq5uzlRDWoclt2k6YwCna7YWVqguCzkNT9rIG0z7pWESQ==
X-Received: by 2002:a17:907:2cc6:b0:ad2:47a6:b309 with SMTP id a640c23a62f3a-ad85b096fffmr755465866b.17.1748255070826;
        Mon, 26 May 2025 03:24:30 -0700 (PDT)
Received: from [100.73.1.233] ([185.128.9.226])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad52d06d299sm1647668266b.48.2025.05.26.03.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 May 2025 03:24:30 -0700 (PDT)
Message-ID: <589caeefa5b00c7a6c2bfc199bb34871d43cde04.camel@gmail.com>
Subject: Re: [PATCH v3 03/10] iio: adc: ad4170: Add support for calibration
 gain
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: jic23@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 robh@kernel.org, 	krzk+dt@kernel.org, conor+dt@kernel.org,
 linus.walleij@linaro.org, brgl@bgdev.pl, 	marcelo.schmitt1@gmail.com
Date: Mon, 26 May 2025 11:24:33 +0100
In-Reply-To: <3d255162174ab160c3fd06af3c27360947c2a566.1747083143.git.marcelo.schmitt@analog.com>
References: <cover.1747083143.git.marcelo.schmitt@analog.com>
	 <3d255162174ab160c3fd06af3c27360947c2a566.1747083143.git.marcelo.schmitt@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-05-13 at 09:34 -0300, Marcelo Schmitt wrote:
> Add support for ADC calibration gain configuration.
>=20
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---
> Change log v2 -> v3
> - New patch spun out of the base driver patch.
>=20
> =C2=A0drivers/iio/adc/ad4170.c | 29 ++++++++++++++++++++++++++++-
> =C2=A01 file changed, 28 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/adc/ad4170.c b/drivers/iio/adc/ad4170.c
> index bf19b31095ee..1df214f7fdec 100644
> --- a/drivers/iio/adc/ad4170.c
> +++ b/drivers/iio/adc/ad4170.c
> @@ -642,7 +642,8 @@ static const struct iio_chan_spec ad4170_channel_temp=
late
> =3D {
> =C2=A0	.differential =3D 1,
> =C2=A0	.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BIT(IIO_CHAN_INFO_SCALE) |
> -			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BIT(IIO_CHAN_INFO_OFFSET),
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BIT(IIO_CHAN_INFO_OFFSET) |
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BIT(IIO_CHAN_INFO_CALIBSCALE),
> =C2=A0	.info_mask_separate_available =3D BIT(IIO_CHAN_INFO_SCALE),
> =C2=A0	.scan_type =3D {
> =C2=A0		.realbits =3D 24,
> @@ -953,6 +954,9 @@ static int ad4170_read_raw(struct iio_dev *indio_dev,
> =C2=A0		pga =3D FIELD_GET(AD4170_AFE_PGA_GAIN_MSK, setup->afe);
> =C2=A0		*val =3D chan_info->offset_tbl[pga];
> =C2=A0		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_CALIBSCALE:
> +		*val =3D setup->gain;

To be nitpicky, the only way this is correct for all archs is also locking =
the
load. Or read_once() but likely not worth it.

Other than that, looks good

- Nuno S=C3=A1
>=20

