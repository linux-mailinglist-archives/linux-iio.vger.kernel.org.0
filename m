Return-Path: <linux-iio+bounces-15621-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1030A38078
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 11:44:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4FE5188BCC1
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 10:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3FD221771D;
	Mon, 17 Feb 2025 10:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PRQMkLID"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5554217701
	for <linux-iio@vger.kernel.org>; Mon, 17 Feb 2025 10:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739789042; cv=none; b=F21IJT3A+M748ddlPCajWVD4Zu64CYITrBzitELag2ZxErR0Ib4ikC1OZbevDcu27eP815gUBvSa85YrEMmGrnnLarhRPD1CB6WLdapxGrlZY+IC8EmrvseWPllzi4/lQ8KCPIn0V5U+xXxQWJRq24prJzn1QsNL5cT75OwZG08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739789042; c=relaxed/simple;
	bh=DyQ1tzw7ZzaCXyyj08gQ3k3REkYdNxZ+gcQzG7DRn4E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F6jxI2UPGmoWlABUbvkmOe+0moZ8jbBola0OQDwPfAK7KUMVUbMJqwkHwSbgwUhwL/2xGeWnXTk9f4yjPfXwr/JotHmRXvtfw5N28ciEEV79JLtT0QcyG7rt9JUF3wTS+z5gAlVvkBZNh5TbA4NNkLjjmr6fGfGyCnal3EFV32s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PRQMkLID; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-abb892fe379so185147666b.0
        for <linux-iio@vger.kernel.org>; Mon, 17 Feb 2025 02:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739789039; x=1740393839; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jxpdAw6sK71WnwLcG+VG8EkKm9q81tY0WJ6JarSotik=;
        b=PRQMkLIDQLr67EIhaVtEsoj7CqvdsrwmBS/1gJEwXdiuc/r2kbXlNRjHKmjwBzI5dk
         GtnVadyIHv14OG72vIZFzdVAqQYGcW2wiraV1X+ZK1N63kp1rXglvZT/+HgjqCE2VNnd
         X+iit4hs1tPLG9TPEoxKXxPdz0SSmPoRkVuwRVt/v1YO5BwseRt36ZQdvD5KiYWlsavu
         WFDq7s4hP9fAxQwLwPQLxt4RSxz3yB4O5YohloSlVOy5FCTDID8O02RPCp/CJYOshdTO
         HpUOK3gjPLIaHGKIf4wBEA5pmTy5OjLfX4uzSZZSZJQGw4rwh388AY0KtcRvr9eGRkcz
         aL2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739789039; x=1740393839;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jxpdAw6sK71WnwLcG+VG8EkKm9q81tY0WJ6JarSotik=;
        b=aFN1kZia0jWACIdyPFS90K1+SHEBozwjqLCxOCvhXOtBqf/IddgbHLb6FARI0YcbvP
         eTDQOV9K7zOfV2wNcWjgRa/vLmoQk7OOfjgltyO6vmARa/t2gTXStRuj/3/MHqBn7CWW
         7MZ5/cUi9KQhfBiIDlqq9vNXyCm17EhCfZKCZIK1fOLQ0W7SR9kJ2LN1o5woteuen+6x
         KzdGdkJADeID+gEMWU83Ybl1wKgOXCb/EYNjL3vp0BIadpdCp5lIdjetvpl0FlxlPnWx
         NZG3Y4K60RxEd1ggPKhf0BxwMq1DjJkcQRJmupBuXK99lpx6WekSY6Pil0iGux0atmvP
         BxKw==
X-Forwarded-Encrypted: i=1; AJvYcCVgs9pu63Ls7RWkLaDTPrQG4I+3HPHSXBaJVoUHKqqPRH5o3+vBTSYmxqmL1vjagDM9HqlJ997qgnU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCBdcJW+L8hMSYo+sQTiaK+moG4jqlcOIBR0EUvargXUIL5wv4
	qFzTYU0/y/CLJpCsHN27ylStrW57xs0a5SnspHqE1wfQQaLCfb06
X-Gm-Gg: ASbGncutqr3qWdwDZgtx4AAtOkEcXoaywKDO/hrmv8TN0SqyCAUDZc53BkedcpmQZkH
	fwX+TzR3Z/ZlYBR+xlL2sj3Sae2RlGfBM5Fvsuzp/XgpOoHR88nObTSf6DtSPvNhuZVDfjj35E2
	udST0GhWFJtnTCTmp3JAGZER/gMnotWZHcIhAgxZOtzvlvBHmkaNlDrFXhhbTBlrUmR3mzhxbdK
	RdL/ljrJ6e6rsaT6ZatrwXqULA8zHLEk891cLfC4ROkl+P/UQp9G1vYN7F9LUmdag5i2OCdugBw
	HBxG19NpuZEIusR+/4/RoEXcrlMFzcKEKzC6HK4T3wgZ3+W+gfn0Ppc/mWzTqHs=
X-Google-Smtp-Source: AGHT+IFN1EWoYKV5IXmIUcd1S6TTIHVZBq+uoR/y/3qxEyuOkGKc1YzT0DE7ghF6cUuOAXrJ/kv+Cw==
X-Received: by 2002:a05:6402:5201:b0:5dc:d8d2:e38f with SMTP id 4fb4d7f45d1cf-5e03618307amr22090921a12.31.1739789038698;
        Mon, 17 Feb 2025 02:43:58 -0800 (PST)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb1e1bef3esm547921466b.146.2025.02.17.02.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 02:43:58 -0800 (PST)
Message-ID: <9b6484fa86a59bfd980b47970994c47a458109f6.camel@gmail.com>
Subject: Re: [PATCH v2 08/27] iio: accel: adxl367: Stop using
 iio_device_claim_direct_scoped()
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: Mudit Sharma <muditsharma.info@gmail.com>, Julien Stephan	
 <jstephan@baylibre.com>, Mariel Tinaco <Mariel.Tinaco@analog.com>, Angelo
 Dureghello <adureghello@baylibre.com>, Gustavo Silva
 <gustavograzs@gmail.com>, Nuno Sa	 <nuno.sa@analog.com>,
 =?ISO-8859-1?Q?Jo=E3o?= Paulo =?ISO-8859-1?Q?Gon=E7alves?=	
 <joao.goncalves@toradex.com>, ChiYuan Huang <cy_huang@richtek.com>, Ramona
 Alexandra Nechita <ramona.nechita@analog.com>, Trevor Gamblin
 <tgamblin@baylibre.com>, Guillaume Stols	 <gstols@baylibre.com>, David
 Lechner <dlechner@baylibre.com>, Cosmin Tanislav	 <demonsingur@gmail.com>,
 Marcelo Schmitt <marcelo.schmitt@analog.com>,  Gwendal Grignou
 <gwendal@chromium.org>, Antoni Pokusinski <apokusinski01@gmail.com>, Tomasz
 Duszynski	 <tomasz.duszynski@octakon.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Date: Mon, 17 Feb 2025 10:44:01 +0000
In-Reply-To: <20250209180624.701140-9-jic23@kernel.org>
References: <20250209180624.701140-1-jic23@kernel.org>
	 <20250209180624.701140-9-jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2025-02-09 at 18:06 +0000, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>=20
> This complex cleanup.h use case of conditional guards has proved
> to be more trouble that it is worth in terms of false positive compiler
> warnings and hard to read code.
>=20
> Move directly to the new claim/release_direct() that allow sparse
> to check for unbalanced context
>=20
> In some cases there is a convenient wrapper function to which
> the handling can be moved. Do that instead of introducing
> another layer of wrappers. In others an outer wrapper is added
> which claims direct mode, runs the original function with the
> scoped claim logic removed, releases direct mode and then checks
> for errors.
>=20
> Cc: Cosmin Tanislav <demonsingur@gmail.com>
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---

Reviewed-by: Nuno Sa <nuno.sa@analog.com>

> =C2=A0drivers/iio/accel/adxl367.c | 194 ++++++++++++++++++++-------------=
---
> =C2=A01 file changed, 106 insertions(+), 88 deletions(-)
>=20
> diff --git a/drivers/iio/accel/adxl367.c b/drivers/iio/accel/adxl367.c
> index a48ac0d7bd96..add4053e7a02 100644
> --- a/drivers/iio/accel/adxl367.c
> +++ b/drivers/iio/accel/adxl367.c
> @@ -477,45 +477,42 @@ static int adxl367_set_fifo_watermark(struct
> adxl367_state *st,
> =C2=A0static int adxl367_set_range(struct iio_dev *indio_dev,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0 enum adxl367_range range)
> =C2=A0{
> -	iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
> -		struct adxl367_state *st =3D iio_priv(indio_dev);
> -		int ret;
> +	struct adxl367_state *st =3D iio_priv(indio_dev);
> +	int ret;
> =C2=A0
> -		guard(mutex)(&st->lock);
> +	guard(mutex)(&st->lock);
> =C2=A0
> -		ret =3D adxl367_set_measure_en(st, false);
> -		if (ret)
> -			return ret;
> +	ret =3D adxl367_set_measure_en(st, false);
> +	if (ret)
> +		return ret;
> =C2=A0
> -		ret =3D regmap_update_bits(st->regmap, ADXL367_REG_FILTER_CTL,
> -					 ADXL367_FILTER_CTL_RANGE_MASK,
> -				=09
> FIELD_PREP(ADXL367_FILTER_CTL_RANGE_MASK,
> -						=C2=A0=C2=A0=C2=A0 range));
> -		if (ret)
> -			return ret;
> +	ret =3D regmap_update_bits(st->regmap, ADXL367_REG_FILTER_CTL,
> +				 ADXL367_FILTER_CTL_RANGE_MASK,
> +				 FIELD_PREP(ADXL367_FILTER_CTL_RANGE_MASK,
> +					=C2=A0=C2=A0=C2=A0 range));
> +	if (ret)
> +		return ret;
> =C2=A0
> -		adxl367_scale_act_thresholds(st, st->range, range);
> +	adxl367_scale_act_thresholds(st, st->range, range);
> =C2=A0
> -		/* Activity thresholds depend on range */
> -		ret =3D _adxl367_set_act_threshold(st, ADXL367_ACTIVITY,
> -						 st->act_threshold);
> -		if (ret)
> -			return ret;
> +	/* Activity thresholds depend on range */
> +	ret =3D _adxl367_set_act_threshold(st, ADXL367_ACTIVITY,
> +					 st->act_threshold);
> +	if (ret)
> +		return ret;
> =C2=A0
> -		ret =3D _adxl367_set_act_threshold(st, ADXL367_INACTIVITY,
> -						 st->inact_threshold);
> -		if (ret)
> -			return ret;
> +	ret =3D _adxl367_set_act_threshold(st, ADXL367_INACTIVITY,
> +					 st->inact_threshold);
> +	if (ret)
> +		return ret;
> =C2=A0
> -		ret =3D adxl367_set_measure_en(st, true);
> -		if (ret)
> -			return ret;
> +	ret =3D adxl367_set_measure_en(st, true);
> +	if (ret)
> +		return ret;
> =C2=A0
> -		st->range =3D range;
> +	st->range =3D range;
> =C2=A0
> -		return 0;
> -	}
> -	unreachable();
> +	return 0;
> =C2=A0}
> =C2=A0
> =C2=A0static int adxl367_time_ms_to_samples(struct adxl367_state *st, uns=
igned int
> ms)
> @@ -620,23 +617,20 @@ static int _adxl367_set_odr(struct adxl367_state *s=
t,
> enum adxl367_odr odr)
> =C2=A0
> =C2=A0static int adxl367_set_odr(struct iio_dev *indio_dev, enum adxl367_=
odr odr)
> =C2=A0{
> -	iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
> -		struct adxl367_state *st =3D iio_priv(indio_dev);
> -		int ret;
> +	struct adxl367_state *st =3D iio_priv(indio_dev);
> +	int ret;
> =C2=A0
> -		guard(mutex)(&st->lock);
> +	guard(mutex)(&st->lock);
> =C2=A0
> -		ret =3D adxl367_set_measure_en(st, false);
> -		if (ret)
> -			return ret;
> +	ret =3D adxl367_set_measure_en(st, false);
> +	if (ret)
> +		return ret;
> =C2=A0
> -		ret =3D _adxl367_set_odr(st, odr);
> -		if (ret)
> -			return ret;
> +	ret =3D _adxl367_set_odr(st, odr);
> +	if (ret)
> +		return ret;
> =C2=A0
> -		return adxl367_set_measure_en(st, true);
> -	}
> -	unreachable();
> +	return adxl367_set_measure_en(st, true);
> =C2=A0}
> =C2=A0
> =C2=A0static int adxl367_set_temp_adc_en(struct adxl367_state *st, unsign=
ed int
> reg,
> @@ -725,32 +719,29 @@ static int adxl367_read_sample(struct iio_dev
> *indio_dev,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct iio_chan_spec const =
*chan,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int *val)
> =C2=A0{
> -	iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
> -		struct adxl367_state *st =3D iio_priv(indio_dev);
> -		u16 sample;
> -		int ret;
> +	struct adxl367_state *st =3D iio_priv(indio_dev);
> +	u16 sample;
> +	int ret;
> =C2=A0
> -		guard(mutex)(&st->lock);
> +	guard(mutex)(&st->lock);
> =C2=A0
> -		ret =3D adxl367_set_temp_adc_reg_en(st, chan->address, true);
> -		if (ret)
> -			return ret;
> +	ret =3D adxl367_set_temp_adc_reg_en(st, chan->address, true);
> +	if (ret)
> +		return ret;
> =C2=A0
> -		ret =3D regmap_bulk_read(st->regmap, chan->address, &st-
> >sample_buf,
> -				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sizeof(st->sample_buf));
> -		if (ret)
> -			return ret;
> +	ret =3D regmap_bulk_read(st->regmap, chan->address, &st->sample_buf,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sizeof(st->sample_buf));
> +	if (ret)
> +		return ret;
> =C2=A0
> -		sample =3D FIELD_GET(ADXL367_DATA_MASK, be16_to_cpu(st-
> >sample_buf));
> -		*val =3D sign_extend32(sample, chan->scan_type.realbits - 1);
> +	sample =3D FIELD_GET(ADXL367_DATA_MASK, be16_to_cpu(st->sample_buf));
> +	*val =3D sign_extend32(sample, chan->scan_type.realbits - 1);
> =C2=A0
> -		ret =3D adxl367_set_temp_adc_reg_en(st, chan->address, false);
> -		if (ret)
> -			return ret;
> +	ret =3D adxl367_set_temp_adc_reg_en(st, chan->address, false);
> +	if (ret)
> +		return ret;
> =C2=A0
> -		return IIO_VAL_INT;
> -	}
> -	unreachable();
> +	return IIO_VAL_INT;
> =C2=A0}
> =C2=A0
> =C2=A0static int adxl367_get_status(struct adxl367_state *st, u8 *status,
> @@ -852,10 +843,15 @@ static int adxl367_read_raw(struct iio_dev *indio_d=
ev,
> =C2=A0			=C2=A0=C2=A0=C2=A0 int *val, int *val2, long info)
> =C2=A0{
> =C2=A0	struct adxl367_state *st =3D iio_priv(indio_dev);
> +	int ret;
> =C2=A0
> =C2=A0	switch (info) {
> =C2=A0	case IIO_CHAN_INFO_RAW:
> -		return adxl367_read_sample(indio_dev, chan, val);
> +		if (!iio_device_claim_direct(indio_dev))
> +			return -EBUSY;
> +		ret =3D adxl367_read_sample(indio_dev, chan, val);
> +		iio_device_release_direct(indio_dev);
> +		return ret;
> =C2=A0	case IIO_CHAN_INFO_SCALE:
> =C2=A0		switch (chan->type) {
> =C2=A0		case IIO_ACCEL: {
> @@ -912,7 +908,12 @@ static int adxl367_write_raw(struct iio_dev *indio_d=
ev,
> =C2=A0		if (ret)
> =C2=A0			return ret;
> =C2=A0
> -		return adxl367_set_odr(indio_dev, odr);
> +		if (!iio_device_claim_direct(indio_dev))
> +			return -EBUSY;
> +
> +		ret =3D adxl367_set_odr(indio_dev, odr);
> +		iio_device_release_direct(indio_dev);
> +		return ret;
> =C2=A0	}
> =C2=A0	case IIO_CHAN_INFO_SCALE: {
> =C2=A0		enum adxl367_range range;
> @@ -921,7 +922,12 @@ static int adxl367_write_raw(struct iio_dev *indio_d=
ev,
> =C2=A0		if (ret)
> =C2=A0			return ret;
> =C2=A0
> -		return adxl367_set_range(indio_dev, range);
> +		if (!iio_device_claim_direct(indio_dev))
> +			return -EBUSY;
> +
> +		ret =3D adxl367_set_range(indio_dev, range);
> +		iio_device_release_direct(indio_dev);
> +		return ret;
> =C2=A0	}
> =C2=A0	default:
> =C2=A0		return -EINVAL;
> @@ -1069,13 +1075,15 @@ static int adxl367_read_event_config(struct iio_d=
ev
> *indio_dev,
> =C2=A0	}
> =C2=A0}
> =C2=A0
> -static int adxl367_write_event_config(struct iio_dev *indio_dev,
> -				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct iio_chan_spec *chan,
> -				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum iio_event_type type,
> -				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum iio_event_direction dir,
> -				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool state)
> +static int __adxl367_write_event_config(struct iio_dev *indio_dev,
> +					const struct iio_chan_spec *chan,
> +					enum iio_event_type type,
> +					enum iio_event_direction dir,
> +					bool state)
> =C2=A0{
> +	struct adxl367_state *st =3D iio_priv(indio_dev);
> =C2=A0	enum adxl367_activity_type act;
> +	int ret;
> =C2=A0
> =C2=A0	switch (dir) {
> =C2=A0	case IIO_EV_DIR_RISING:
> @@ -1088,28 +1096,38 @@ static int adxl367_write_event_config(struct iio_=
dev
> *indio_dev,
> =C2=A0		return -EINVAL;
> =C2=A0	}
> =C2=A0
> -	iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
> -		struct adxl367_state *st =3D iio_priv(indio_dev);
> -		int ret;
> +	guard(mutex)(&st->lock);
> +
> +	ret =3D adxl367_set_measure_en(st, false);
> +	if (ret)
> +		return ret;
> =C2=A0
> -		guard(mutex)(&st->lock);
> +	ret =3D adxl367_set_act_interrupt_en(st, act, state);
> +	if (ret)
> +		return ret;
> =C2=A0
> -		ret =3D adxl367_set_measure_en(st, false);
> -		if (ret)
> -			return ret;
> +	ret =3D adxl367_set_act_en(st, act, state ? ADCL367_ACT_REF_ENABLED
> +				 : ADXL367_ACT_DISABLED);
> +	if (ret)
> +		return ret;
> =C2=A0
> -		ret =3D adxl367_set_act_interrupt_en(st, act, state);
> -		if (ret)
> -			return ret;
> +	return adxl367_set_measure_en(st, true);
> +}
> =C2=A0
> -		ret =3D adxl367_set_act_en(st, act, state ?
> ADCL367_ACT_REF_ENABLED
> -					 : ADXL367_ACT_DISABLED);
> -		if (ret)
> -			return ret;
> +static int adxl367_write_event_config(struct iio_dev *indio_dev,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct iio_chan_spec *chan,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum iio_event_type type,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum iio_event_direction dir,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool state)
> +{
> +	int ret;
> =C2=A0
> -		return adxl367_set_measure_en(st, true);
> -	}
> -	unreachable();
> +	if (!iio_device_claim_direct(indio_dev))
> +		return -EBUSY;
> +
> +	ret =3D __adxl367_write_event_config(indio_dev, chan, type, dir,
> state);
> +	iio_device_release_direct(indio_dev);
> +	return ret;
> =C2=A0}
> =C2=A0
> =C2=A0static ssize_t adxl367_get_fifo_enabled(struct device *dev,


