Return-Path: <linux-iio+bounces-19026-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A3F2AA8587
	for <lists+linux-iio@lfdr.de>; Sun,  4 May 2025 11:34:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E4CA3B881E
	for <lists+linux-iio@lfdr.de>; Sun,  4 May 2025 09:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67D0519FA8D;
	Sun,  4 May 2025 09:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AfX4Fhh5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE6B19DF40;
	Sun,  4 May 2025 09:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746351248; cv=none; b=KTETjlfEr/7fcCqsTxRSmukkvH/Qo8nHu+VssysJsK4Gqe8tqISofT07ORSFGNTjnBCgLSfN73E10Xggs1ZWbNV2FGX86wKdCxa6WowmGOsHKSF3F9PjCNByftITQPDTZYl8HBpzYDtQcjOMhq+dkLr8ay1Lhze+4ItXst6Q+Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746351248; c=relaxed/simple;
	bh=k8R97ouehfGNcufxuN/m42cFxSz9OEVj1PcN18HxyiU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KVc3HcV4wOPNUuNo7LHy+CWw+HD6VhCsMEWXZAg38h0GHT0YMy9cbL2t6f4vTS+jCQBEp5QmDekK5aZ6TCVKu8UkuTo/xpkI5/HWzNvJKeQCH5/0p+zmUtNJhwmitEJgiugQkotuWI3R101jWCT8MrmQBmKFILf8pCcfEHjZlU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AfX4Fhh5; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43cebe06e9eso20007905e9.3;
        Sun, 04 May 2025 02:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746351244; x=1746956044; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ieqxuP1ZJjBSInFCifjwzLoCRQEmElLnyd63cEZ3uDw=;
        b=AfX4Fhh5p4+odysDKDX6Q7WsIsKXHLfyb8cC9Oq3Qlw8vSeRI6spKW495wUOS051hL
         G7l/684lP4RaENNtwRwjJ962gHa9+7QQu8wB91ETNeGP6Qpl/zcRlYpHsZLtPaaYrNRO
         prc4pogD8nlw4zThGrIBEMfcZVZN3QeVNvqDPs25yyBgwTjLW1s1TIOWqr3F9mBcpEY1
         EOJ32v3+bGCBxPb1vTLjdK2DwQ1ozW8q46kh3ZPBgt0Cp8PmyztMLxWSNXJqL0Bo7Ou6
         Um6Ga2C0pj+c0Tr8YZ4YL76iTlJv4CRkPS7QwiMXlEJ/wXNLTKcOC2757l+AjpC1R1l3
         An4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746351244; x=1746956044;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ieqxuP1ZJjBSInFCifjwzLoCRQEmElLnyd63cEZ3uDw=;
        b=vxkrPljlaEqVoBEczKH82mtvIEnJZdREOYUVoLgbmfiN4BhIPTLhkTHZMkNHodGVVY
         qdjS+reBMzY9DID9Gs3kpgVnJmaXsB2KDp4UrV7v1vBXjGl+llitwo8bWWx98wxuwp8d
         Eonue2Y48n2RY5Xp2o5keQN+39QIJLKKsUoEZgkfrOUlOkfgcQwcOcl//KYvVrfuvGfL
         XQqh8i3FkXIlz/pJN/++NzxfGLeKAs5D67pdaMIeU08jJq/wHNtt4LM56R3qHeqX6lcu
         DxdkfbXFyoTd8Tv+jsw1HVYEJUUucyW756i7QjrvdBaMAGES3tQCYNFGbZfrSmCZsUJ5
         ad+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXAL+gKmSYHCgEGlhFgTthEscqwKsSsNQ+T86P9QFK9EQrpE+7wi0GUVT0tZ2q+DlbkCqRXMMu1hvKr@vger.kernel.org, AJvYcCXrIh8XbIcwvJRZdq2UVv7z+eIx+L03GSFQKq6Gf6+kVpfrJ+9q7P1KyAR+WabJD0kLBvwSjJLoHrAVJmrA@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+YoIRBpdAB4PcvVTA2o+jfvSh26czS4ixMFfXcJ0Vb1pAG3CN
	DYh+nq/2nSi9ziFyLXP0npu3N0GcV/BYHD3gHA//rEOQ75eiMtqZKPOAzDuF
X-Gm-Gg: ASbGncsu6LVX8+OQ2MxBKJrEKwSozaXBVbYK+hz3enWrkErq0N1bHy8OHOYoQo3q2of
	eZgfrswGGn1IxI7Lxj1RWnfoyGnFxTWebAffsGdeVPZzTgp1J5OtRHm/nF4FqK9GaGc/puIH2tz
	nTRUykKvYkEOBpE6DuwnI6ebq9c1h6/mp27/ATjtC7Weq7rxJCd+PCE4yRrNk3XJF0NDP5+kHz4
	iCzBXzitkWPPmWPtRLgRok/i60LjDTrOP48nU+UfFzhNImQanWLso1l5hmZfs51mU4JFte7ME1c
	EVYOkifQzs9vB6x5k/riOaEouM1cnHpxCeYkmLvsE13CBzsLzAFK4faaeI9Wt44kzLW1SKO7Q/p
	QDXVs5X2cb/gWf3g=
X-Google-Smtp-Source: AGHT+IEAoNuoYho02jDkMUn7diMG4X9eRCzN9RupCD/B4q1VUbAFst1+pP82WALa6n1WS6UryvUdnw==
X-Received: by 2002:a05:6000:2489:b0:390:eacd:7009 with SMTP id ffacd0b85a97d-3a09fdbb87cmr2238947f8f.42.1746351244295;
        Sun, 04 May 2025 02:34:04 -0700 (PDT)
Received: from ?IPv6:2001:818:ea56:d000:56e0:ceba:7da4:6673? ([2001:818:ea56:d000:56e0:ceba:7da4:6673])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441b89cc4f8sm99060625e9.1.2025.05.04.02.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 May 2025 02:34:03 -0700 (PDT)
Message-ID: <5e08f5a5acdaa438eb4e5dcb04e2086108c06da3.camel@gmail.com>
Subject: Re: [PATCH v2 3/5] iio: adc: ad7606: add offset and phase
 calibration support
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Angelo Dureghello <adureghello@baylibre.com>, Jonathan Cameron
 <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Date: Sun, 04 May 2025 09:34:27 +0100
In-Reply-To: <c3e7ea15ea5c3ce14cdd4d99ffa98631e7ce2677.camel@gmail.com>
References: 
	<20250502-wip-bl-ad7606-calibration-v2-0-174bd0af081b@baylibre.com>
	 <20250502-wip-bl-ad7606-calibration-v2-3-174bd0af081b@baylibre.com>
	 <c3e7ea15ea5c3ce14cdd4d99ffa98631e7ce2677.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2025-05-04 at 09:30 +0100, Nuno S=C3=A1 wrote:
> On Fri, 2025-05-02 at 15:27 +0200, Angelo Dureghello wrote:
> > From: Angelo Dureghello <adureghello@baylibre.com>
> >=20
> > Add support for offset and phase calibration, only for
> > devices that support software mode, that are:
> >=20
> > ad7606b
> > ad7606c-16
> > ad7606c-18
> >=20
> > Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> > ---
>=20
> With the the proper type for the DT properties:
>=20

Disregard this... Feel free to add the tag. The comment is for other patch!
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>


>=20
> > =C2=A0drivers/iio/adc/ad7606.c | 160 ++++++++++++++++++++++++++++++++++=
+++++++++++++
> > =C2=A0drivers/iio/adc/ad7606.h |=C2=A0=C2=A0 9 +++
> > =C2=A02 files changed, 169 insertions(+)
> >=20
> > diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
> > index
> > ad5e6b5e1d5d2edc7f8ac7ed9a8a4e6e43827b85..139d8b3f9bb39dd631a71c7053900=
5d719fb5b7
> > b
> > 100644
> > --- a/drivers/iio/adc/ad7606.c
> > +++ b/drivers/iio/adc/ad7606.c
> > @@ -95,6 +95,22 @@ static const unsigned int ad7616_oversampling_avail[=
8] =3D {
> > =C2=A0	1, 2, 4, 8, 16, 32, 64, 128,
> > =C2=A0};
> > =C2=A0
> > +static const int ad7606_calib_offset_avail[3] =3D {
> > +	-128, 1, 127,
> > +};
> > +
> > +static const int ad7606c_18bit_calib_offset_avail[3] =3D {
> > +	-512, 4, 508,
> > +};
> > +
> > +static const int ad7606b_calib_phase_avail[][2] =3D {
> > +	{ 0, 0 }, { 0, 1250 }, { 0, 318750 },
> > +};
> > +
> > +static const int ad7606c_calib_phase_avail[][2] =3D {
> > +	{ 0, 0 }, { 0, 1000 }, { 0, 255000 },
> > +};
> > +
> > =C2=A0static int ad7606c_18bit_chan_scale_setup(struct iio_dev *indio_d=
ev,
> > =C2=A0					=C2=A0 struct iio_chan_spec *chan);
> > =C2=A0static int ad7606c_16bit_chan_scale_setup(struct iio_dev *indio_d=
ev,
> > @@ -164,6 +180,8 @@ const struct ad7606_chip_info ad7606b_info =3D {
> > =C2=A0	.scale_setup_cb =3D ad7606_16bit_chan_scale_setup,
> > =C2=A0	.sw_setup_cb =3D ad7606b_sw_mode_setup,
> > =C2=A0	.offload_storagebits =3D 32,
> > +	.calib_offset_avail =3D ad7606_calib_offset_avail,
> > +	.calib_phase_avail =3D ad7606b_calib_phase_avail,
> > =C2=A0};
> > =C2=A0EXPORT_SYMBOL_NS_GPL(ad7606b_info, "IIO_AD7606");
> > =C2=A0
> > @@ -177,6 +195,8 @@ const struct ad7606_chip_info ad7606c_16_info =3D {
> > =C2=A0	.scale_setup_cb =3D ad7606c_16bit_chan_scale_setup,
> > =C2=A0	.sw_setup_cb =3D ad7606b_sw_mode_setup,
> > =C2=A0	.offload_storagebits =3D 32,
> > +	.calib_offset_avail =3D ad7606_calib_offset_avail,
> > +	.calib_phase_avail =3D ad7606c_calib_phase_avail,
> > =C2=A0};
> > =C2=A0EXPORT_SYMBOL_NS_GPL(ad7606c_16_info, "IIO_AD7606");
> > =C2=A0
> > @@ -226,6 +246,8 @@ const struct ad7606_chip_info ad7606c_18_info =3D {
> > =C2=A0	.scale_setup_cb =3D ad7606c_18bit_chan_scale_setup,
> > =C2=A0	.sw_setup_cb =3D ad7606b_sw_mode_setup,
> > =C2=A0	.offload_storagebits =3D 32,
> > +	.calib_offset_avail =3D ad7606c_18bit_calib_offset_avail,
> > +	.calib_phase_avail =3D ad7606c_calib_phase_avail,
> > =C2=A0};
> > =C2=A0EXPORT_SYMBOL_NS_GPL(ad7606c_18_info, "IIO_AD7606");
> > =C2=A0
> > @@ -683,6 +705,40 @@ static int ad7606_scan_direct(struct iio_dev *indi=
o_dev,
> > unsigned int ch,
> > =C2=A0	return ret;
> > =C2=A0}
> > =C2=A0
> > +static int ad7606_get_calib_offset(struct ad7606_state *st, int ch, in=
t *val)
> > +{
> > +	int ret;
> > +
> > +	ret =3D st->bops->reg_read(st, AD7606_CALIB_OFFSET(ch));
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	*val =3D st->chip_info->calib_offset_avail[0] +
> > +		ret * st->chip_info->calib_offset_avail[1];
> > +
> > +	return 0;
> > +}
> > +
> > +static int ad7606_get_calib_phase(struct ad7606_state *st, int ch, int=
 *val,
> > +				=C2=A0 int *val2)
> > +{
> > +	int ret;
> > +
> > +	ret =3D st->bops->reg_read(st, AD7606_CALIB_PHASE(ch));
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	*val =3D 0;
> > +
> > +	/*
> > +	 * ad7606b: phase delay from 0 to 318.75 =CE=BCs in steps of 1.25 =CE=
=BCs.
> > +	 * ad7606c-16/18: phase delay from 0 =C2=B5s to 255 =C2=B5s in steps =
of 1 =C2=B5s.
> > +	 */
> > +	*val2 =3D ret * st->chip_info->calib_phase_avail[1][1];
> > +
> > +	return 0;
> > +}
> > +
> > =C2=A0static int ad7606_read_raw(struct iio_dev *indio_dev,
> > =C2=A0			=C2=A0=C2=A0 struct iio_chan_spec const *chan,
> > =C2=A0			=C2=A0=C2=A0 int *val,
> > @@ -717,6 +773,22 @@ static int ad7606_read_raw(struct iio_dev *indio_d=
ev,
> > =C2=A0		pwm_get_state(st->cnvst_pwm, &cnvst_pwm_state);
> > =C2=A0		*val =3D DIV_ROUND_CLOSEST_ULL(NSEC_PER_SEC,
> > cnvst_pwm_state.period);
> > =C2=A0		return IIO_VAL_INT;
> > +	case IIO_CHAN_INFO_CALIBBIAS:
> > +		if (!iio_device_claim_direct(indio_dev))
> > +			return -EBUSY;
> > +		ret =3D ad7606_get_calib_offset(st, chan->scan_index, val);
> > +		iio_device_release_direct(indio_dev);
> > +		if (ret)
> > +			return ret;
> > +		return IIO_VAL_INT;
> > +	case IIO_CHAN_INFO_CALIBCONV_DELAY:
> > +		if (!iio_device_claim_direct(indio_dev))
> > +			return -EBUSY;
> > +		ret =3D ad7606_get_calib_phase(st, chan->scan_index, val, val2);
> > +		iio_device_release_direct(indio_dev);
> > +		if (ret)
> > +			return ret;
> > +		return IIO_VAL_INT_PLUS_NANO;
> > =C2=A0	}
> > =C2=A0	return -EINVAL;
> > =C2=A0}
> > @@ -767,6 +839,64 @@ static int ad7606_write_os_hw(struct iio_dev *indi=
o_dev, int
> > val)
> > =C2=A0	return 0;
> > =C2=A0}
> > =C2=A0
> > +static int ad7606_set_calib_offset(struct ad7606_state *st, int ch, in=
t val)
> > +{
> > +	int start_val, step_val, stop_val;
> > +
> > +	start_val =3D st->chip_info->calib_offset_avail[0];
> > +	step_val =3D st->chip_info->calib_offset_avail[1];
> > +	stop_val =3D st->chip_info->calib_offset_avail[2];
> > +
> > +	if (val < start_val || val > stop_val)
> > +		return -EINVAL;
> > +
> > +	val -=3D start_val;
> > +	val /=3D step_val;
> > +
> > +	return st->bops->reg_write(st, AD7606_CALIB_OFFSET(ch), val);
> > +}
> > +
> > +static int ad7606_set_calib_phase(struct ad7606_state *st, int ch, int=
 val,
> > +				=C2=A0 int val2)
> > +{
> > +	int wreg, start_ns, step_ns, stop_ns;
> > +
> > +	if (val !=3D 0)
> > +		return -EINVAL;
> > +
> > +	start_ns =3D st->chip_info->calib_phase_avail[0][1];
> > +	step_ns =3D st->chip_info->calib_phase_avail[1][1];
> > +	stop_ns =3D st->chip_info->calib_phase_avail[2][1];
> > +
> > +	/*
> > +	 * ad7606b: phase dielay from 0 to 318.75 =CE=BCs in steps of 1.25 =
=CE=BCs.
> > +	 * ad7606c-16/18: phase delay from 0 =C2=B5s to 255 =C2=B5s in steps =
of 1 =C2=B5s.
> > +	 */
> > +	if (val2 < start_ns || val2 > stop_ns)
> > +			return -EINVAL;
> > +
> > +	wreg =3D val2 / step_ns;
> > +
> > +	return st->bops->reg_write(st, AD7606_CALIB_PHASE(ch), wreg);
> > +}
> > +
> > +static int ad7606_write_raw_get_fmt(struct iio_dev *indio_dev,
> > +				=C2=A0=C2=A0=C2=A0 struct iio_chan_spec const *chan, long info)
> > +{
> > +	switch (info) {
> > +	case IIO_CHAN_INFO_SCALE:
> > +		return IIO_VAL_INT_PLUS_MICRO;
> > +	case IIO_CHAN_INFO_SAMP_FREQ:
> > +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> > +	case IIO_CHAN_INFO_CALIBBIAS:
> > +		return IIO_VAL_INT;
> > +	case IIO_CHAN_INFO_CALIBCONV_DELAY:
> > +		return IIO_VAL_INT_PLUS_NANO;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> > +
> > =C2=A0static int ad7606_write_raw(struct iio_dev *indio_dev,
> > =C2=A0			=C2=A0=C2=A0=C2=A0 struct iio_chan_spec const *chan,
> > =C2=A0			=C2=A0=C2=A0=C2=A0 int val,
> > @@ -820,6 +950,18 @@ static int ad7606_write_raw(struct iio_dev *indio_=
dev,
> > =C2=A0		if (val < 0 && val2 !=3D 0)
> > =C2=A0			return -EINVAL;
> > =C2=A0		return ad7606_set_sampling_freq(st, val);
> > +	case IIO_CHAN_INFO_CALIBBIAS:
> > +		if (!iio_device_claim_direct(indio_dev))
> > +			return -EBUSY;
> > +		ret =3D ad7606_set_calib_offset(st, chan->scan_index, val);
> > +		iio_device_release_direct(indio_dev);
> > +		return ret;
> > +	case IIO_CHAN_INFO_CALIBCONV_DELAY:
> > +		if (!iio_device_claim_direct(indio_dev))
> > +			return -EBUSY;
> > +		ret =3D ad7606_set_calib_phase(st, chan->scan_index, val, val2);
> > +		iio_device_release_direct(indio_dev);
> > +		return ret;
> > =C2=A0	default:
> > =C2=A0		return -EINVAL;
> > =C2=A0	}
> > @@ -998,6 +1140,14 @@ static int ad7606_read_avail(struct iio_dev *indi=
o_dev,
> > =C2=A0		*type =3D IIO_VAL_INT_PLUS_MICRO;
> > =C2=A0
> > =C2=A0		return IIO_AVAIL_LIST;
> > +	case IIO_CHAN_INFO_CALIBBIAS:
> > +		*vals =3D st->chip_info->calib_offset_avail;
> > +		*type =3D IIO_VAL_INT;
> > +		return IIO_AVAIL_RANGE;
> > +	case IIO_CHAN_INFO_CALIBCONV_DELAY:
> > +		*vals =3D (const int *)st->chip_info->calib_phase_avail;
> > +		*type =3D IIO_VAL_INT_PLUS_NANO;
> > +		return IIO_AVAIL_RANGE;
> > =C2=A0	}
> > =C2=A0	return -EINVAL;
> > =C2=A0}
> > @@ -1060,6 +1210,7 @@ static const struct iio_info ad7606_info_sw_mode =
=3D {
> > =C2=A0	.read_raw =3D &ad7606_read_raw,
> > =C2=A0	.write_raw =3D &ad7606_write_raw,
> > =C2=A0	.read_avail =3D &ad7606_read_avail,
> > +	.write_raw_get_fmt =3D ad7606_write_raw_get_fmt,
> > =C2=A0	.debugfs_reg_access =3D &ad7606_reg_access,
> > =C2=A0	.validate_trigger =3D &ad7606_validate_trigger,
> > =C2=A0	.update_scan_mode =3D &ad7606_update_scan_mode,
> > @@ -1252,6 +1403,15 @@ static int ad7606_probe_channels(struct iio_dev
> > *indio_dev)
> > =C2=A0			chan->info_mask_separate_available |=3D
> > =C2=A0				BIT(IIO_CHAN_INFO_SCALE);
> > =C2=A0
> > +			if (st->chip_info->calib_offset_avail) {
> > +				chan->info_mask_separate |=3D
> > +					BIT(IIO_CHAN_INFO_CALIBBIAS) |
> > +					BIT(IIO_CHAN_INFO_CALIBCONV_DELAY);
> > +				chan->info_mask_separate_available |=3D
> > +					BIT(IIO_CHAN_INFO_CALIBBIAS) |
> > +					BIT(IIO_CHAN_INFO_CALIBCONV_DELAY);
> > +			}
> > +
> > =C2=A0			/*
> > =C2=A0			 * All chips with software mode support oversampling,
> > =C2=A0			 * so we skip the oversampling_available check. And the
> > diff --git a/drivers/iio/adc/ad7606.h b/drivers/iio/adc/ad7606.h
> > index
> > 89d49551eaf515bab9706c12bff056dfcb707b67..4c39de36154ffb80dfbb01bb4f812=
826bdc5596
> > 7
> > 100644
> > --- a/drivers/iio/adc/ad7606.h
> > +++ b/drivers/iio/adc/ad7606.h
> > @@ -40,6 +40,11 @@
> > =C2=A0#define AD7606_RANGE_CH_ADDR(ch)	(0x03 + ((ch) >> 1))
> > =C2=A0#define AD7606_OS_MODE			0x08
> > =C2=A0
> > +#define AD7606_CALIB_GAIN(ch)		(0x09 + (ch))
> > +#define AD7606_CALIB_GAIN_MASK		GENMASK(5, 0)
> > +#define AD7606_CALIB_OFFSET(ch)		(0x11 + (ch))
> > +#define AD7606_CALIB_PHASE(ch)		(0x19 + (ch))
> > +
> > =C2=A0struct ad7606_state;
> > =C2=A0
> > =C2=A0typedef int (*ad7606_scale_setup_cb_t)(struct iio_dev *indio_dev,
> > @@ -61,6 +66,8 @@ typedef int (*ad7606_sw_setup_cb_t)(struct iio_dev *i=
ndio_dev);
> > =C2=A0 * @init_delay_ms:	required delay in milliseconds for initializat=
ion
> > =C2=A0 *			after a restart
> > =C2=A0 * @offload_storagebits: storage bits used by the offload hw impl=
ementation
> > + * @calib_offset_avail: pointer to offset calibration range/limits arr=
ay
> > + * @calib_phase_avail:=C2=A0 pointer to phase calibration range/limits=
 array
> > =C2=A0 */
> > =C2=A0struct ad7606_chip_info {
> > =C2=A0	unsigned int			max_samplerate;
> > @@ -74,6 +81,8 @@ struct ad7606_chip_info {
> > =C2=A0	bool				os_req_reset;
> > =C2=A0	unsigned long			init_delay_ms;
> > =C2=A0	u8				offload_storagebits;
> > +	const int			*calib_offset_avail;
> > +	const int			(*calib_phase_avail)[2];
> > =C2=A0};
> > =C2=A0
> > =C2=A0/**
> >=20
>=20


