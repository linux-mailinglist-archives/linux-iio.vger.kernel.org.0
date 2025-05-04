Return-Path: <linux-iio+bounces-19025-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4D21AA8580
	for <lists+linux-iio@lfdr.de>; Sun,  4 May 2025 11:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5348188C82B
	for <lists+linux-iio@lfdr.de>; Sun,  4 May 2025 09:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 174BE19DF53;
	Sun,  4 May 2025 09:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d6x08PF/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49C119924E;
	Sun,  4 May 2025 09:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746351012; cv=none; b=WktCD5QkEHNsmmoMqNMhG8yPbvnp8HEKCqh7gg3xd/Cv20cfn78sq8UMEJ1Rx3gKuMHPm/a/mUxtYGGgiXJ+zPg6BFiU0RuQ/pKCwB44csTEabK8jIYqBsyMRR7KamfdXgKgY+14JP4qzFWQhU7nRwdfJUTy+IW9krWcjdKjUKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746351012; c=relaxed/simple;
	bh=YNCZFFAddZ74aFh3+MhEzBKxcK9wcVWR7+AMtfoz9po=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZA6UqhmahEQ8l5KYGWBXBGdnrf86yd0K+5jUHg/noRZnnd7TAQcxns86lE3nBx21LFVYc/64ZWK+gJGVP+UwbQ0GL29ygsviJQZEjLO+MEcZpFfyKvjOJ5KBl5MKfzF42dOyT0HVO42+VCMfDP2DoPJzvP9JGXw39rN4HAn3N4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d6x08PF/; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43edecbfb46so18518145e9.0;
        Sun, 04 May 2025 02:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746351009; x=1746955809; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=63q1WxRozhPxeCwLZsP8KRYfroroX74/AkZZ62OmD/I=;
        b=d6x08PF/Gz6eS/sw44NobxifgJaaEze5iPcWFiI1LtnmZvaXLf96DGKx4z/0oSxRoV
         8kMPPr0QYaOgwebhkUHvtU7/En/SlRiTTq3U6b4kADEW+jW34xcZ7vLtXcvdlV9QYMVo
         pobMA5cPKRaKXJ5zb2H0bSYzbNTpUN9cUiixUAmUX/4jMpZVQJVCAPaRe2c5jksiGfTf
         WHx1o9VWJAQTyFZxfaIC4CjWzQhpAa6XmhGGtvOgCZ34Y7B91SHTx6/w419i0ixwSZO5
         Z5Cdktr5otim6HNaCj6QX/f+0mBe/SXcxZR9QDKcmdwONl94k/UpOqghEzpoJSiR5QlQ
         F2wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746351009; x=1746955809;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=63q1WxRozhPxeCwLZsP8KRYfroroX74/AkZZ62OmD/I=;
        b=FQtLpKxuvg1uIOejzKoSxXLWQmJkge0rcDAEwEEBe80Lb5MeB7l0X95j1Uf2zixbeq
         LHXVDcSBqrvPpM9JTA/vLTPZDjWeCJUQyFuNVdlZH+ur7p7OmvRJpaCFpbYEqV/Op6HO
         hluZUTnsEDr5Sz5QyUs9HCNAJ9O3mc3JaK14Y7JaqNThfx2fhX1Y+K073SUaoIyeULsD
         SvD2ruWCosqwUE80Q99Ckc8n2ec/ZqAbgISEXFKMSIgblHfrlsXl8lk/Wu0ftBT3B7fW
         Lt2FLSGnt6cFeyLGxooIbWYvulgl3k9zTZrcWAI5LFrjAdFZgkStzQUxglRgkHbAQ7Nn
         wfLA==
X-Forwarded-Encrypted: i=1; AJvYcCVCjsCnpeAep1wfEB7VRhJAQwf/5TZUk6PzCta9VD7xgQ7FHgX+bpvL+6tLO86HVqwqIlDI2WanffsVrBE3@vger.kernel.org, AJvYcCWkBRSssKxWpnye+36FgDo/Z2qs+dVbmEz9X0T1g6dFHh3CCg5T+7tSGWCzAgdMKN74CDJFayS7xpLS@vger.kernel.org
X-Gm-Message-State: AOJu0Ywrw7GohktV6m/wAffzXyXuHkS64X7shOUPdXkw2ay1xJOeACXW
	aYCtbR/nmMwlImy570176A9vTnOh6VN9g5RpBlvhUBfMS20omjk2
X-Gm-Gg: ASbGncs2MBmHvC/7iixAuGWl/S3UnAUN1HF/yf+u3duPbciipVjs2UmwlXpoUZHohaZ
	GLixrx44eIpLURNTsDxJm9YjmktnhOjiSQIZ4HSyPBRfUw233LVf5obSYM+tm0PteDhoh5bmgz7
	oNGsQjnt27mBTT38aR9uDwBaFnqQbTxCLoa6iIIjgHtvPEf9wcFJKL9a690ibmsf76+V+Stt7+M
	X/Fvx/TkJxV/QwUEA+fVmSSiXdgtGMJnS/CFw7SnUL7aR6lseIC7xXP9PnXdMpLCEKaXd2oDATr
	W5aSty+PMC6zcv2Cvj0PzO9IvgMZOEtzLxsnpEmcax6UB72rZGrD6XpINITw2R7hDReVa2r6eE5
	zv2mzcSOu8l6j8zI=
X-Google-Smtp-Source: AGHT+IFkygT19cKzCAQawBVpo1ZDi81oeByvLxpXaIKJ/QMn2cMyZtbT15Hgc8o2kqFdgxweHrWRGg==
X-Received: by 2002:a05:600c:154c:b0:441:b3eb:570a with SMTP id 5b1f17b1804b1-441c48b04d4mr27488905e9.2.1746351008697;
        Sun, 04 May 2025 02:30:08 -0700 (PDT)
Received: from ?IPv6:2001:818:ea56:d000:56e0:ceba:7da4:6673? ([2001:818:ea56:d000:56e0:ceba:7da4:6673])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441b89ee171sm96828285e9.17.2025.05.04.02.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 May 2025 02:30:08 -0700 (PDT)
Message-ID: <c3e7ea15ea5c3ce14cdd4d99ffa98631e7ce2677.camel@gmail.com>
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
Date: Sun, 04 May 2025 09:30:31 +0100
In-Reply-To: <20250502-wip-bl-ad7606-calibration-v2-3-174bd0af081b@baylibre.com>
References: 
	<20250502-wip-bl-ad7606-calibration-v2-0-174bd0af081b@baylibre.com>
	 <20250502-wip-bl-ad7606-calibration-v2-3-174bd0af081b@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-05-02 at 15:27 +0200, Angelo Dureghello wrote:
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

With the the proper type for the DT properties:

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> =C2=A0drivers/iio/adc/ad7606.c | 160 ++++++++++++++++++++++++++++++++++++=
+++++++++++
> =C2=A0drivers/iio/adc/ad7606.h |=C2=A0=C2=A0 9 +++
> =C2=A02 files changed, 169 insertions(+)
>=20
> diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
> index
> ad5e6b5e1d5d2edc7f8ac7ed9a8a4e6e43827b85..139d8b3f9bb39dd631a71c70539005d=
719fb5b7b
> 100644
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
> +	-512, 4, 508,
> +};
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
> +	case IIO_CHAN_INFO_CALIBCONV_DELAY:
> +		if (!iio_device_claim_direct(indio_dev))
> +			return -EBUSY;
> +		ret =3D ad7606_get_calib_phase(st, chan->scan_index, val, val2);
> +		iio_device_release_direct(indio_dev);
> +		if (ret)
> +			return ret;
> +		return IIO_VAL_INT_PLUS_NANO;
> =C2=A0	}
> =C2=A0	return -EINVAL;
> =C2=A0}
> @@ -767,6 +839,64 @@ static int ad7606_write_os_hw(struct iio_dev *indio_=
dev, int
> val)
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
> +	val -=3D start_val;
> +	val /=3D step_val;
> +
> +	return st->bops->reg_write(st, AD7606_CALIB_OFFSET(ch), val);
> +}
> +
> +static int ad7606_set_calib_phase(struct ad7606_state *st, int ch, int v=
al,
> +				=C2=A0 int val2)
> +{
> +	int wreg, start_ns, step_ns, stop_ns;
> +
> +	if (val !=3D 0)
> +		return -EINVAL;
> +
> +	start_ns =3D st->chip_info->calib_phase_avail[0][1];
> +	step_ns =3D st->chip_info->calib_phase_avail[1][1];
> +	stop_ns =3D st->chip_info->calib_phase_avail[2][1];
> +
> +	/*
> +	 * ad7606b: phase dielay from 0 to 318.75 =CE=BCs in steps of 1.25 =CE=
=BCs.
> +	 * ad7606c-16/18: phase delay from 0 =C2=B5s to 255 =C2=B5s in steps of=
 1 =C2=B5s.
> +	 */
> +	if (val2 < start_ns || val2 > stop_ns)
> +			return -EINVAL;
> +
> +	wreg =3D val2 / step_ns;
> +
> +	return st->bops->reg_write(st, AD7606_CALIB_PHASE(ch), wreg);
> +}
> +
> +static int ad7606_write_raw_get_fmt(struct iio_dev *indio_dev,
> +				=C2=A0=C2=A0=C2=A0 struct iio_chan_spec const *chan, long info)
> +{
> +	switch (info) {
> +	case IIO_CHAN_INFO_SCALE:
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +	case IIO_CHAN_INFO_CALIBBIAS:
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_CALIBCONV_DELAY:
> +		return IIO_VAL_INT_PLUS_NANO;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> =C2=A0static int ad7606_write_raw(struct iio_dev *indio_dev,
> =C2=A0			=C2=A0=C2=A0=C2=A0 struct iio_chan_spec const *chan,
> =C2=A0			=C2=A0=C2=A0=C2=A0 int val,
> @@ -820,6 +950,18 @@ static int ad7606_write_raw(struct iio_dev *indio_de=
v,
> =C2=A0		if (val < 0 && val2 !=3D 0)
> =C2=A0			return -EINVAL;
> =C2=A0		return ad7606_set_sampling_freq(st, val);
> +	case IIO_CHAN_INFO_CALIBBIAS:
> +		if (!iio_device_claim_direct(indio_dev))
> +			return -EBUSY;
> +		ret =3D ad7606_set_calib_offset(st, chan->scan_index, val);
> +		iio_device_release_direct(indio_dev);
> +		return ret;
> +	case IIO_CHAN_INFO_CALIBCONV_DELAY:
> +		if (!iio_device_claim_direct(indio_dev))
> +			return -EBUSY;
> +		ret =3D ad7606_set_calib_phase(st, chan->scan_index, val, val2);
> +		iio_device_release_direct(indio_dev);
> +		return ret;
> =C2=A0	default:
> =C2=A0		return -EINVAL;
> =C2=A0	}
> @@ -998,6 +1140,14 @@ static int ad7606_read_avail(struct iio_dev *indio_=
dev,
> =C2=A0		*type =3D IIO_VAL_INT_PLUS_MICRO;
> =C2=A0
> =C2=A0		return IIO_AVAIL_LIST;
> +	case IIO_CHAN_INFO_CALIBBIAS:
> +		*vals =3D st->chip_info->calib_offset_avail;
> +		*type =3D IIO_VAL_INT;
> +		return IIO_AVAIL_RANGE;
> +	case IIO_CHAN_INFO_CALIBCONV_DELAY:
> +		*vals =3D (const int *)st->chip_info->calib_phase_avail;
> +		*type =3D IIO_VAL_INT_PLUS_NANO;
> +		return IIO_AVAIL_RANGE;
> =C2=A0	}
> =C2=A0	return -EINVAL;
> =C2=A0}
> @@ -1060,6 +1210,7 @@ static const struct iio_info ad7606_info_sw_mode =
=3D {
> =C2=A0	.read_raw =3D &ad7606_read_raw,
> =C2=A0	.write_raw =3D &ad7606_write_raw,
> =C2=A0	.read_avail =3D &ad7606_read_avail,
> +	.write_raw_get_fmt =3D ad7606_write_raw_get_fmt,
> =C2=A0	.debugfs_reg_access =3D &ad7606_reg_access,
> =C2=A0	.validate_trigger =3D &ad7606_validate_trigger,
> =C2=A0	.update_scan_mode =3D &ad7606_update_scan_mode,
> @@ -1252,6 +1403,15 @@ static int ad7606_probe_channels(struct iio_dev *i=
ndio_dev)
> =C2=A0			chan->info_mask_separate_available |=3D
> =C2=A0				BIT(IIO_CHAN_INFO_SCALE);
> =C2=A0
> +			if (st->chip_info->calib_offset_avail) {
> +				chan->info_mask_separate |=3D
> +					BIT(IIO_CHAN_INFO_CALIBBIAS) |
> +					BIT(IIO_CHAN_INFO_CALIBCONV_DELAY);
> +				chan->info_mask_separate_available |=3D
> +					BIT(IIO_CHAN_INFO_CALIBBIAS) |
> +					BIT(IIO_CHAN_INFO_CALIBCONV_DELAY);
> +			}
> +
> =C2=A0			/*
> =C2=A0			 * All chips with software mode support oversampling,
> =C2=A0			 * so we skip the oversampling_available check. And the
> diff --git a/drivers/iio/adc/ad7606.h b/drivers/iio/adc/ad7606.h
> index
> 89d49551eaf515bab9706c12bff056dfcb707b67..4c39de36154ffb80dfbb01bb4f81282=
6bdc55967
> 100644
> --- a/drivers/iio/adc/ad7606.h
> +++ b/drivers/iio/adc/ad7606.h
> @@ -40,6 +40,11 @@
> =C2=A0#define AD7606_RANGE_CH_ADDR(ch)	(0x03 + ((ch) >> 1))
> =C2=A0#define AD7606_OS_MODE			0x08
> =C2=A0
> +#define AD7606_CALIB_GAIN(ch)		(0x09 + (ch))
> +#define AD7606_CALIB_GAIN_MASK		GENMASK(5, 0)
> +#define AD7606_CALIB_OFFSET(ch)		(0x11 + (ch))
> +#define AD7606_CALIB_PHASE(ch)		(0x19 + (ch))
> +
> =C2=A0struct ad7606_state;
> =C2=A0
> =C2=A0typedef int (*ad7606_scale_setup_cb_t)(struct iio_dev *indio_dev,
> @@ -61,6 +66,8 @@ typedef int (*ad7606_sw_setup_cb_t)(struct iio_dev *ind=
io_dev);
> =C2=A0 * @init_delay_ms:	required delay in milliseconds for initializatio=
n
> =C2=A0 *			after a restart
> =C2=A0 * @offload_storagebits: storage bits used by the offload hw implem=
entation
> + * @calib_offset_avail: pointer to offset calibration range/limits array
> + * @calib_phase_avail:=C2=A0 pointer to phase calibration range/limits a=
rray
> =C2=A0 */
> =C2=A0struct ad7606_chip_info {
> =C2=A0	unsigned int			max_samplerate;
> @@ -74,6 +81,8 @@ struct ad7606_chip_info {
> =C2=A0	bool				os_req_reset;
> =C2=A0	unsigned long			init_delay_ms;
> =C2=A0	u8				offload_storagebits;
> +	const int			*calib_offset_avail;
> +	const int			(*calib_phase_avail)[2];
> =C2=A0};
> =C2=A0
> =C2=A0/**
>=20


