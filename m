Return-Path: <linux-iio+bounces-18904-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A5E3AA5068
	for <lists+linux-iio@lfdr.de>; Wed, 30 Apr 2025 17:36:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E43997B1167
	for <lists+linux-iio@lfdr.de>; Wed, 30 Apr 2025 15:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E0C25D1F8;
	Wed, 30 Apr 2025 15:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a+XvV3mO"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A8015DBC1;
	Wed, 30 Apr 2025 15:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746027375; cv=none; b=bFZEDf5qSQz0hqa6fo2j62dwZ5IiGXzOEYFicNEQpCICvZ75cP6iSxsoJleNklUB9XQENcrJrPUBZgtBi5gWDyL+l0pQ5+n5frgUYfUeb562FLu21/tWOQE5B13yx2Vq3qD+XzE7akJMh02gYh/bs2ru7rW/aF541YCm1eQ0n3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746027375; c=relaxed/simple;
	bh=LkriFigpaBQ2TCKZy0fvHVXMLA0Cwu9c5uTygANFRaY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qX94ssdc7JknCtRZ8rnkgNuaI2Xg1NyH/dEETnLGULFosuuiplmJLqZFmGDN+hLy6mDNnxhJadDmJMsKvl1qj+4kqTtozbPE7aXjo5HwbvhaataJrc50OfIlACPT+74sPiEqk8EKxZEmivykuPZGp41pkPbDTa5cgRdl3YPTem8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a+XvV3mO; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-39c31e4c3e5so4809746f8f.0;
        Wed, 30 Apr 2025 08:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746027371; x=1746632171; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+MKDHPwR2l8XAq/X6LzjtjCqC8aFyohmJHmIahoU0Yg=;
        b=a+XvV3mOpXD0/plQIml84PV5buNt+5nNQQ5qQIE8jrjyi+vyN9SKXZsB7k/Z0t+sSe
         OidPwFxidPcFc32wmls5aLeR6OErf/xDkZe/uBtd12URMlB1ZpVv/7Ks06/mzUlnJrO/
         zaXUkGytnkmHBq+e88qX9MqwHj+Q9EodqlnxjDBuF5CFpQoxfROp9LaEoG39cG3IVXV9
         hHgIKsa5n4TdGwf7OObUmS37U9Iu+OvQtb9VJHjLVR7I74PEFFnVOxDTnIWfGEKSDirf
         IUra0Jl0UKXPwd8T2PaWHpcuor8Kq6MeHL4cgnq/qsRIoBcXUfhwFMnFqf4DQhFkPVYv
         C6lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746027371; x=1746632171;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+MKDHPwR2l8XAq/X6LzjtjCqC8aFyohmJHmIahoU0Yg=;
        b=doa/z01THcMeq3EJb6HetXFeC7NXcSm0OFVXclw/BaMZdY9bTMslV7wog8e2lmdije
         2rJxmrOC/XjTGEbp7Dml/jat5J+o6B66BiiHHce/nQTuM48E4bFjEwC7nRO5DRnbI2cf
         22yWojeeJfSIvKmybwVJ8BhPRWmuYyX+jry0tzVEUOOJVmdGexPbORML/wJ8KAuyKxpW
         AVT5TIo0/IOnbn6zQyCROS8ASaqAwoxcwUQiQ4wN61cP5MXv5IpLOjdMU4bd9vKlbt48
         foJrcuXknPuI6LCaO1P+N2vB0VHdUgvOqd6Xnak+af5Q8qJyFsZdq8YDl2Y+XvtyFlRs
         W4sQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8j1zce665eChF4G3BBRc8+qBG27Vlt6dujA4MBe3Mbvd/NuNKEHO233QYkx4Pno9iV//krFHsjmDe@vger.kernel.org, AJvYcCVjUTsg+bJHVmuKoIqWVQgmeYWJiCmKOxw9hsbPjIxqz9QGI/PYfEiEhVmuooe7nmkPgXXs1dps2ww/xLhK@vger.kernel.org
X-Gm-Message-State: AOJu0YyJpMrN+sCdLyTVjo3knGA+SK3lAl0CdcyvLGkI2byVayfgXAUY
	eWS2XDpBlZihvw1pyRnlSmS/rC9P6BkuvO2JOPihtZJ0hY1uQhNJ
X-Gm-Gg: ASbGncutKaPVEHzM3zdB1Sk64D4G6VdrmPotokgJ2Kti9lyjdL8zxz9DjPGOsCLi5ei
	bRzefss4RvZ6Eofz48LWA7VMrKrCVF4ap2izi+ovWAIvs1Vdo0S9nIyaeQHeaYJjMmiFlux8m0c
	97E87z/wn+KJ4vEQhykjHcOep08kOxmm5VhUGl5a0W2EikzuQHA2QSZDCXHgGpCD/ebTjAEeAXR
	z+IiPg0sRIV/PIByUGIdMl78ap7+tsOqSOWbAjfA6Zi2J8B5W/12n5X9Mi1RM9RFkoiWBk/c89Y
	oB+gAwtR7056+71WwsI5F/84kLaZl+QRVSjll9MhbLAnnnnUNQ7/qd/+SivFNFK8pO0TwF3Y5xH
	zXGZG7de5vKpK
X-Google-Smtp-Source: AGHT+IE1yfaVRABKM5EZNt0RO3VcMqmdM1CQatWeQBmjRfHbtU6NeGFvzMlRUL0XOcxFd8pk2yQs7Q==
X-Received: by 2002:a05:6000:3102:b0:390:f394:6271 with SMTP id ffacd0b85a97d-3a08ff466dfmr3099777f8f.43.1746027371214;
        Wed, 30 Apr 2025 08:36:11 -0700 (PDT)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a073ca435dsm17262428f8f.21.2025.04.30.08.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 08:36:09 -0700 (PDT)
Message-ID: <d273fa78cb3986da5249bd800dd25c4c0bcfde7e.camel@gmail.com>
Subject: Re: [PATCH 3/5] iio: adc: ad7606: add offset and phase calibration
 support
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Angelo Dureghello <adureghello@baylibre.com>, Jonathan Cameron	
 <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?ISO-8859-1?Q?S=E1?=	 <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Lars-Peter Clausen	 <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley	 <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Date: Wed, 30 Apr 2025 16:36:13 +0100
In-Reply-To: <20250429-wip-bl-ad7606-calibration-v1-3-eb4d4821b172@baylibre.com>
References: 
	<20250429-wip-bl-ad7606-calibration-v1-0-eb4d4821b172@baylibre.com>
	 <20250429-wip-bl-ad7606-calibration-v1-3-eb4d4821b172@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-04-29 at 15:06 +0200, Angelo Dureghello wrote:
> From: Angelo Dureghello <adureghello@baylibre.com>
>=20
> Add support for offset and phase calibration, only for
> devices that support software mode, that are:
>=20
> ad7606b
> ad7606c-16
> ad7606c-18
>=20
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> ---
> =C2=A0drivers/iio/adc/ad7606.c | 160
> +++++++++++++++++++++++++++++++++++++++++++++++
> =C2=A0drivers/iio/adc/ad7606.h |=C2=A0=C2=A0 9 +++
> =C2=A02 files changed, 169 insertions(+)
>=20
> diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
> index
> ad5e6b5e1d5d2edc7f8ac7ed9a8a4e6e43827b85..ec063dd4a67eb94610c41c473e2d804=
0c919
> 74cf 100644
> --- a/drivers/iio/adc/ad7606.c
> +++ b/drivers/iio/adc/ad7606.c
> @@ -95,6 +95,22 @@ static const unsigned int ad7616_oversampling_avail[8]=
 =3D {
> =C2=A0	1, 2, 4, 8, 16, 32, 64, 128,
> =C2=A0};
> =C2=A0
> +static const int ad7606_calib_offset_avail[3] =3D {
> +	-128, 1, 127,
> +};
> +
> +static const int ad7606c_18bit_calib_offset_avail[3] =3D {
> +	-512, 4, 511,
> +};

From the DS, it seems this is 508?

> +
> +static const int ad7606b_calib_phase_avail[][2] =3D {
> +	{ 0, 0 }, { 0, 1250 }, { 0, 318750 },
> +};
> +
> +static const int ad7606c_calib_phase_avail[][2] =3D {
> +	{ 0, 0 }, { 0, 1000 }, { 0, 255000 },
> +};
> +
> =C2=A0static int ad7606c_18bit_chan_scale_setup(struct iio_dev *indio_dev=
,
> =C2=A0					=C2=A0 struct iio_chan_spec *chan);
> =C2=A0static int ad7606c_16bit_chan_scale_setup(struct iio_dev *indio_dev=
,
> @@ -164,6 +180,8 @@ const struct ad7606_chip_info ad7606b_info =3D {
> =C2=A0	.scale_setup_cb =3D ad7606_16bit_chan_scale_setup,
> =C2=A0	.sw_setup_cb =3D ad7606b_sw_mode_setup,
> =C2=A0	.offload_storagebits =3D 32,
> +	.calib_offset_avail =3D ad7606_calib_offset_avail,
> +	.calib_phase_avail =3D ad7606b_calib_phase_avail,
> =C2=A0};
> =C2=A0EXPORT_SYMBOL_NS_GPL(ad7606b_info, "IIO_AD7606");
> =C2=A0
> @@ -177,6 +195,8 @@ const struct ad7606_chip_info ad7606c_16_info =3D {
> =C2=A0	.scale_setup_cb =3D ad7606c_16bit_chan_scale_setup,
> =C2=A0	.sw_setup_cb =3D ad7606b_sw_mode_setup,
> =C2=A0	.offload_storagebits =3D 32,
> +	.calib_offset_avail =3D ad7606_calib_offset_avail,
> +	.calib_phase_avail =3D ad7606c_calib_phase_avail,
> =C2=A0};
> =C2=A0EXPORT_SYMBOL_NS_GPL(ad7606c_16_info, "IIO_AD7606");
> =C2=A0
> @@ -226,6 +246,8 @@ const struct ad7606_chip_info ad7606c_18_info =3D {
> =C2=A0	.scale_setup_cb =3D ad7606c_18bit_chan_scale_setup,
> =C2=A0	.sw_setup_cb =3D ad7606b_sw_mode_setup,
> =C2=A0	.offload_storagebits =3D 32,
> +	.calib_offset_avail =3D ad7606c_18bit_calib_offset_avail,
> +	.calib_phase_avail =3D ad7606c_calib_phase_avail,
> =C2=A0};
> =C2=A0EXPORT_SYMBOL_NS_GPL(ad7606c_18_info, "IIO_AD7606");
> =C2=A0
> @@ -683,6 +705,40 @@ static int ad7606_scan_direct(struct iio_dev *indio_=
dev,
> unsigned int ch,
> =C2=A0	return ret;
> =C2=A0}
> =C2=A0
> +static int ad7606_get_calib_offset(struct ad7606_state *st, int ch, int =
*val)
> +{
> +	int ret;
> +
> +	ret =3D st->bops->reg_read(st, AD7606_CALIB_OFFSET(ch));
> +	if (ret < 0)
> +		return ret;
> +
> +	*val =3D st->chip_info->calib_offset_avail[0] +
> +		ret * st->chip_info->calib_offset_avail[1];
> +
> +	return 0;
> +}
> +
> +static int ad7606_get_calib_phase(struct ad7606_state *st, int ch, int *=
val,
> +				=C2=A0 int *val2)
> +{
> +	int ret;
> +
> +	ret =3D st->bops->reg_read(st, AD7606_CALIB_PHASE(ch));
> +	if (ret < 0)
> +		return ret;
> +
> +	*val =3D 0;
> +
> +	/*
> +	 * ad7606b: phase delay from 0 to 318.75 =CE=BCs in steps of 1.25 =CE=
=BCs.
> +	 * ad7606c-16/18: phase delay from 0 =C2=B5s to 255 =C2=B5s in steps of=
 1 =C2=B5s.
> +	 */
> +	*val2 =3D ret * st->chip_info->calib_phase_avail[1][1];
> +
> +	return 0;
> +}
> +
> =C2=A0static int ad7606_read_raw(struct iio_dev *indio_dev,
> =C2=A0			=C2=A0=C2=A0 struct iio_chan_spec const *chan,
> =C2=A0			=C2=A0=C2=A0 int *val,
> @@ -717,6 +773,22 @@ static int ad7606_read_raw(struct iio_dev *indio_dev=
,
> =C2=A0		pwm_get_state(st->cnvst_pwm, &cnvst_pwm_state);
> =C2=A0		*val =3D DIV_ROUND_CLOSEST_ULL(NSEC_PER_SEC,
> cnvst_pwm_state.period);
> =C2=A0		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_CALIBBIAS:
> +		if (!iio_device_claim_direct(indio_dev))
> +			return -EBUSY;
> +		ret =3D ad7606_get_calib_offset(st, chan->scan_index, val);
> +		iio_device_release_direct(indio_dev);
> +		if (ret)
> +			return ret;
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_CALIBPHASE_DELAY:
> +		if (!iio_device_claim_direct(indio_dev))
> +			return -EBUSY;
> +		ret =3D ad7606_get_calib_phase(st, chan->scan_index, val,
> val2);
> +		iio_device_release_direct(indio_dev);
> +		if (ret)
> +			return ret;
> +		return IIO_VAL_INT_PLUS_NANO;
> =C2=A0	}
> =C2=A0	return -EINVAL;
> =C2=A0}
> @@ -767,6 +839,64 @@ static int ad7606_write_os_hw(struct iio_dev *indio_=
dev,
> int val)
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0
> +static int ad7606_set_calib_offset(struct ad7606_state *st, int ch, int =
val)
> +{
> +	int start_val, step_val, stop_val;
> +
> +	start_val =3D st->chip_info->calib_offset_avail[0];
> +	step_val =3D st->chip_info->calib_offset_avail[1];
> +	stop_val =3D st->chip_info->calib_offset_avail[2];
> +
> +	if (val < start_val || val > stop_val)
> +		return -EINVAL;
> +
> +	val +=3D start_val;

Shouldn't this be val -=3D start_val?

I also don't think we have any strict rules in the ABI for units for these =
kind
of interfaces so using "raw" values is easier. But FWIW, I think we could h=
ave
this in mv (would naturally depend on scale)=20

- Nuno S=C3=A1


