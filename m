Return-Path: <linux-iio+bounces-21681-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BB7AB057EE
	for <lists+linux-iio@lfdr.de>; Tue, 15 Jul 2025 12:35:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A1A77A7C45
	for <lists+linux-iio@lfdr.de>; Tue, 15 Jul 2025 10:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA5112D77F8;
	Tue, 15 Jul 2025 10:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N4DU7805"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA28E21C9F5;
	Tue, 15 Jul 2025 10:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752575723; cv=none; b=q1rK5lvb9EyGEc/fM/li2jw5k1QvcJurlR8lXoqzq/hZ/1+Dk4GxpFnolXk0UyNLmy621A+Uyq6JhVLyRLHv1sKQonrpsYJSfu+fDZ8QKDA9mJXpiopXavLOjukSrowBFV1TBl70okukrYad0PVu9m892YcZUJgIxpyLm6P1ZzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752575723; c=relaxed/simple;
	bh=7Lnp4ekUojuadvqLXWT1eY9hwY4kp9qGHPisgPzd4UI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=umT9gcOjwdfpDwoeBUBP7me9yPc0TjSVpOQ3JPrtyGQTUrIySmS2UPfujIYKPgoO2DjFFs0dyDxsu8FWoi7dJnlMXtWGvlmjJDq6NGwj3j++dmlcgOdM5DeazZdM0fKhy08VBozqybGnKw5G+cUzXwCmhUu+fz9w8vCXaJweVSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N4DU7805; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4538bc52a8dso38458145e9.2;
        Tue, 15 Jul 2025 03:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752575720; x=1753180520; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gDmfRW0rwJJK8l5CzWOHEqMl1ahjJChEN0cfKoEutmY=;
        b=N4DU7805F7mDg6aK76GyVUNaO0rWADvqxBQydRfCcM6TXWcMl5Ep6NgZBbveuCjR58
         yc1oQJ64UOEGDuu/FoE51E1Yrr8W3L+ay8QhOhPzydlzmTRxNWgA5vkCM8N7gIGCS2nl
         EDy1oTt3VMLhgQdinj87UOK2HGqV/hn0yrCdfnwFAzB5jQxL2KdU4qzkMus2EzDbhOYH
         vINAIGp4rAkvizibLiuFO9eqxm9tP0u66YMt6q4emtvvcJbKP9w3oS1l9xjkdJiT39Vb
         NQ0iq4RMlUlheuSCMkan0NbdBaI8MzjRG1csVjBHyqSslBX1z6+DcDikyb/Q47kdMMKX
         70+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752575720; x=1753180520;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gDmfRW0rwJJK8l5CzWOHEqMl1ahjJChEN0cfKoEutmY=;
        b=VVV1i5nKcBg+xn1ahnSCxJqgpmuex3NnJ6rw3afWx1dKs3vGazhqPgl93DJAHw+bP9
         rwAfri8Y/euj54/oF05bpSjpy1WpQK6B/oyNbGRVl5x1LjnC2m8NNlsCvvpskWs76HsE
         BYZtEgeQ+CkC2dwCfaaw017kyCIDk/tRE5sB/IZD2gfuqo4x0RPNmfYTCHOUDw7QSyt2
         d8UQ5yoA1+EHTbuyPsxozCW8zH1Rn6TVZmp0lZpWbPF5XzPSnJnbdFwIUiB4WjzIeHrd
         zwMYjpuEDOYyjKknVQ3K15cULeeNBxD5ws0rwL+BG7f91WoT+Wr49aoQO04BLEReqxOU
         cvYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUT6xN7Av4lY0wnc4xFXds2RKtkP7hC6WcOYxSzxO6G8MAgs/6Q2m+qF75lM92X8qHomg25jIiZwUWHjA==@vger.kernel.org, AJvYcCX/njt4kBiBo+s3vsJD+fo4Hnsw/OEeDaFcQUNB5ZEWEGWbltvfJ7zc4CwcIa0G7sZAH6tAnmyLbeuu@vger.kernel.org, AJvYcCX/pbPlNt068vVgszkFZNtJeEsN9OYPMW7iVo3bLEz5xLG+yNz7cyy/KSyE92lejE+LpsdPAphPIruy+PQc@vger.kernel.org
X-Gm-Message-State: AOJu0YzT+qlIhLmzBywG7FuKt06KNtcvYSuhnjfhhDh2JeIxSkG0KmHX
	iid8a3vSyav40S0YVYRE9g6XZC0emEwJajTWl2TvCagqWWixIVR14OxF
X-Gm-Gg: ASbGncvkzRnvv2jjbPbY1G8Sdc7HrgE/jvFctzY3VcCU5BbBkzZ/t8adxudcKCHt9Or
	XyaVrPTgYCOKcjBjt9wrTRJPFIseUW/asxMg/nVightsvvSTRzsTICBNztE2OijH+mFG3QPtTXZ
	mSFkvU6FKRvRjLkRWmJOgIqgpFAmuwP8gM7/ycHmCJafFMpLKepAvuVB5OjK61MqnydiY259X3G
	RWoC1Sqce79MilPnBQkdGaB3s7li0iXqn8INRlyQjaTfZKTwwCx/mEbYVePzyza9EOI+mzPD3zZ
	MjccuAZigA7Taitnno/3psrJkAmrBTehdKRcS0nbm0SxsOWEu7M7bInb+iGRJ4SUwrNXwr2uENs
	U2xf7Nf/l/C5EpKDmCZ4KUg==
X-Google-Smtp-Source: AGHT+IGANV4j8ulc+GQwuMN6+z1opGKyDloaWA/u899elk/iQwx8rDKjSemaegSCpgx12sQQogL0tQ==
X-Received: by 2002:a05:600c:4695:b0:450:d4a6:799e with SMTP id 5b1f17b1804b1-454f4259c7cmr134360005e9.20.1752575719619;
        Tue, 15 Jul 2025 03:35:19 -0700 (PDT)
Received: from [10.5.0.2] ([45.94.208.220])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-456178ace19sm67866655e9.19.2025.07.15.03.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 03:35:19 -0700 (PDT)
Message-ID: <0fad26b4384e4163f4807f6b779361099f505a86.camel@gmail.com>
Subject: Re: [PATCH 2/7] iio: inkern: Add API for reading/writing events
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Sean Anderson <sean.anderson@linux.dev>, Jonathan Cameron
 <jic23@kernel.org>,  Jean Delvare <jdelvare@suse.com>, Guenter Roeck
 <linux@roeck-us.net>, linux-iio@vger.kernel.org, 
	linux-hwmon@vger.kernel.org
Cc: Andy Shevchenko <andy@kernel.org>, Nuno =?ISO-8859-1?Q?S=E1?=
	 <nuno.sa@analog.com>, linux-kernel@vger.kernel.org, David Lechner
	 <dlechner@baylibre.com>
Date: Tue, 15 Jul 2025 11:35:32 +0100
In-Reply-To: <20250715012023.2050178-3-sean.anderson@linux.dev>
References: <20250715012023.2050178-1-sean.anderson@linux.dev>
	 <20250715012023.2050178-3-sean.anderson@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-07-14 at 21:20 -0400, Sean Anderson wrote:
> Add an in-kernel API for reading/writing event properties. Like the
> raw-to-processed conversion, with processed-to-raw we only convert the
> integer part, introducing some round-off error.
>=20
> A common case is for other drivers to re-expose IIO events as sysfs
> properties with a different API. To help out with this, iio_event_mode
> returns the appropriate mode. It can also be used to test for existence
> if the consumer doesn't care about read/write capability.
>=20
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> ---

Just one comment on top of Andy's review

>=20
> =C2=A0drivers/iio/inkern.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 198 +++++++++++++++++++++++++++++++++++
> =C2=A0include/linux/iio/consumer.h |=C2=A0 56 ++++++++++
> =C2=A02 files changed, 254 insertions(+)
>=20
> diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
> index c174ebb7d5e6..d3bbd2444fb5 100644
> --- a/drivers/iio/inkern.c
> +++ b/drivers/iio/inkern.c
> @@ -1028,3 +1028,201 @@ ssize_t iio_read_channel_label(struct iio_channel
> *chan, char *buf)
> =C2=A0	return do_iio_read_channel_label(chan->indio_dev, chan->channel,
> buf);
> =C2=A0}
> =C2=A0EXPORT_SYMBOL_GPL(iio_read_channel_label);
> +
> +static bool iio_event_exists(struct iio_channel *channel,
> +			=C2=A0=C2=A0=C2=A0=C2=A0 enum iio_event_type type,
> +			=C2=A0=C2=A0=C2=A0=C2=A0 enum iio_event_direction dir,
> +			=C2=A0=C2=A0=C2=A0=C2=A0 enum iio_event_info info)
> +{
> +	struct iio_chan_spec const *chan =3D channel->channel;
> +	int i;
> +

Can we iio_event_exists() -> iio_event_exists_locked()? Or likely the best =
way
would be to annotate it with lockdep (though that would mean some dance to =
get
the opaque object.

Anyways, bottom line is it should clear that iio_event_exists() is to be ca=
lled
with the lock held.

- Nuno S=C3=A1

> +	if (!channel->indio_dev->info)
> +		return false;
> +
> +	for (i =3D 0; i < chan->num_event_specs; i++) {
> +		if (chan->event_spec[i].type !=3D type)
> +			continue;
> +		if (chan->event_spec[i].dir !=3D dir)
> +			continue;
> +		if (chan->event_spec[i].mask_separate & BIT(info))
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
> +umode_t iio_event_mode(struct iio_channel *chan, enum iio_event_type typ=
e,
> +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum iio_event_direction dir, enu=
m iio_event_info
> info)
> +{
> +	struct iio_dev *indio_dev =3D chan->indio_dev;
> +	struct iio_dev_opaque *iio_dev_opaque =3D to_iio_dev_opaque(indio_dev);
> +	umode_t mode =3D 0;
> +
> +	guard(mutex)(&iio_dev_opaque->info_exist_lock);
> +	if (!iio_event_exists(chan, type, dir, info))
> +		return 0;
> +
> +	if (info =3D=3D IIO_EV_INFO_ENABLE) {
> +		if (indio_dev->info->read_event_config)
> +			mode |=3D 0444;
> +
> +		if (indio_dev->info->write_event_config)
> +			mode |=3D 0200;
> +	} else {
> +		if (indio_dev->info->read_event_value)
> +			mode |=3D 0444;
> +
> +		if (indio_dev->info->write_event_value)
> +			mode |=3D 0200;
> +	}
> +
> +	return mode;
> +}
> +EXPORT_SYMBOL_GPL(iio_event_mode);
> +
> +int iio_read_event_processed_scale(struct iio_channel *chan,
> +				=C2=A0=C2=A0 enum iio_event_type type,
> +				=C2=A0=C2=A0 enum iio_event_direction dir,
> +				=C2=A0=C2=A0 enum iio_event_info info, int *val,
> +				=C2=A0=C2=A0 unsigned int scale)
> +{
> +	struct iio_dev *indio_dev =3D chan->indio_dev;
> +	struct iio_dev_opaque *iio_dev_opaque =3D to_iio_dev_opaque(indio_dev);
> +	int ret, raw;
> +
> +	guard(mutex)(&iio_dev_opaque->info_exist_lock);
> +	if (!iio_event_exists(chan, type, dir, info))
> +		return -ENODEV;
> +
> +	if (info =3D=3D IIO_EV_INFO_ENABLE) {
> +		if (!indio_dev->info->read_event_config)
> +			return -EINVAL;
> +
> +		raw =3D indio_dev->info->read_event_config(indio_dev,
> +							 chan->channel, type,
> +							 dir);
> +		if (raw < 0)
> +			return raw;
> +
> +		*val =3D raw;
> +		return 0;
> +	}
> +
> +	if (!indio_dev->info->read_event_value)
> +		return -EINVAL;
> +
> +	ret =3D indio_dev->info->read_event_value(indio_dev, chan->channel,
> type,
> +						dir, info, &raw, NULL);
> +	if (ret < 0)
> +		return ret;
> +
> +	return iio_convert_raw_to_processed_unlocked(chan, raw, val, scale);
> +}
> +EXPORT_SYMBOL_GPL(iio_read_event_processed_scale);
> +
> +static int iio_convert_processed_to_raw_unlocked(struct iio_channel *cha=
n,
> +						 int processed, int *raw,
> +						 unsigned int scale)
> +{
> +	int scale_type, scale_val, scale_val2;
> +	int offset_type, offset_val, offset_val2;
> +	s64 r, scale64, raw64;
> +
> +	scale_type =3D iio_channel_read(chan, &scale_val, &scale_val2,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 IIO_CHAN_INFO_SCALE);
> +	if (scale_type < 0) {
> +		raw64 =3D processed / scale;
> +	} else {
> +		switch (scale_type) {
> +		case IIO_VAL_INT:
> +			scale64 =3D (s64)scale_val * scale;
> +			if (scale64 <=3D INT_MAX && scale64 >=3D INT_MIN)
> +				raw64 =3D processed / (int)scale64;
> +			else
> +				raw64 =3D 0;
> +			break;
> +		case IIO_VAL_INT_PLUS_MICRO:
> +			scale64 =3D scale_val * scale * 1000000LL + scale_val2;
> +			raw64 =3D div64_s64_rem(processed, scale64, &r);
> +			raw64 =3D raw64 * 1000000 +
> +				div64_s64(r * 1000000, scale64);
> +			break;
> +		case IIO_VAL_INT_PLUS_NANO:
> +			scale64 =3D scale_val * scale * 1000000000LL +
> scale_val2;
> +			raw64 =3D div64_s64_rem(processed, scale64, &r);
> +			raw64 =3D raw64 * 1000000000 +
> +				div64_s64(r * 1000000000, scale64);
> +			break;
> +		case IIO_VAL_FRACTIONAL:
> +			raw64 =3D div64_s64((s64)processed * scale_val2,
> +					=C2=A0 (s64)scale_val * scale);
> +			break;
> +		case IIO_VAL_FRACTIONAL_LOG2:
> +			raw64 =3D div64_s64((s64)processed << scale_val2,
> +					=C2=A0 (s64)scale_val * scale);
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +	}
> +
> +	offset_type =3D iio_channel_read(chan, &offset_val, &offset_val2,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 IIO_CHAN_INFO_OFFSET);
> +	if (offset_type >=3D 0) {
> +		switch (offset_type) {
> +		case IIO_VAL_INT:
> +		case IIO_VAL_INT_PLUS_MICRO:
> +		case IIO_VAL_INT_PLUS_NANO:
> +			raw64 -=3D offset_val;
> +			break;
> +		case IIO_VAL_FRACTIONAL:
> +			raw64 -=3D offset_val / offset_val2;
> +			break;
> +		case IIO_VAL_FRACTIONAL_LOG2:
> +			raw64 -=3D offset_val >> offset_val2;
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +	}
> +
> +	*raw =3D clamp(raw64, (s64)INT_MIN, (s64)INT_MAX);
> +	return 0;
> +}
> +
> +int iio_write_event_processed_scale(struct iio_channel *chan,
> +				=C2=A0=C2=A0=C2=A0 enum iio_event_type type,
> +				=C2=A0=C2=A0=C2=A0 enum iio_event_direction dir,
> +				=C2=A0=C2=A0=C2=A0 enum iio_event_info info, int processed,
> +				=C2=A0=C2=A0=C2=A0 unsigned int scale)
> +{
> +	struct iio_dev *indio_dev =3D chan->indio_dev;
> +	struct iio_dev_opaque *iio_dev_opaque =3D to_iio_dev_opaque(chan-
> >indio_dev);
> +	int ret, raw;
> +
> +	guard(mutex)(&iio_dev_opaque->info_exist_lock);
> +	if (!iio_event_exists(chan, type, dir, info))
> +		return -ENODEV;
> +
> +	if (info =3D=3D IIO_EV_INFO_ENABLE) {
> +		if (!indio_dev->info->write_event_config)
> +			return -EINVAL;
> +
> +		return indio_dev->info->write_event_config(indio_dev,
> +							=C2=A0=C2=A0 chan->channel,
> type,
> +							=C2=A0=C2=A0 dir, processed);
> +	}
> +
> +	if (!indio_dev->info->write_event_value)
> +		return -EINVAL;
> +
> +	ret =3D iio_convert_processed_to_raw_unlocked(chan, processed, &raw,
> +						=C2=A0=C2=A0=C2=A0 scale);
> +	if (ret < 0)
> +		return ret;
> +
> +	return indio_dev->info->write_event_value(indio_dev, chan->channel,
> +						=C2=A0 type, dir, info, raw, 0);
> +}
> +EXPORT_SYMBOL_GPL(iio_write_event_processed_scale);
> diff --git a/include/linux/iio/consumer.h b/include/linux/iio/consumer.h
> index 6a4479616479..16e7682474f3 100644
> --- a/include/linux/iio/consumer.h
> +++ b/include/linux/iio/consumer.h
> @@ -451,4 +451,60 @@ ssize_t iio_write_channel_ext_info(struct iio_channe=
l
> *chan, const char *attr,
> =C2=A0 */
> =C2=A0ssize_t iio_read_channel_label(struct iio_channel *chan, char *buf)=
;
> =C2=A0
> +/**
> + * iio_event_mode() - get file mode for an event property
> + * @chan: Channel being queried
> + * @type: Event type (theshold, rate-of-change, etc.)
> + * @dir: Event direction (rising, falling, etc.)
> + * @info: Event property (enable, value, etc.)
> + *
> + * Determine an appropriate mode for sysfs files derived from this event=
.
> + *
> + * Return:
> + *=C2=A0=C2=A0 - `0000` if the event is unsupported or otherwise unavail=
able
> + *=C2=A0=C2=A0 - `0444` if the event is read-only
> + *=C2=A0=C2=A0 - `0200` if the event is write-only
> + *=C2=A0=C2=A0 - `0644` if the event is read-write
> + */
> +umode_t iio_event_mode(struct iio_channel *chan, enum iio_event_type typ=
e,
> +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum iio_event_direction dir, enu=
m iio_event_info
> info);
> +
> +/**
> + * iio_read_event_processed_scale() - Read an event property
> + * @chan: Channel being queried
> + * @type: Event type (theshold, rate-of-change, etc.)
> + * @dir: Event direction (rising, falling, etc.)
> + * @info: Event property (enable, value, etc.)
> + * @val: Processed property value
> + * @scale: Factor to scale @val by
> + *
> + * Read a processed (scaled and offset) event property of a given channe=
l.
> + *
> + * Return: 0 on success, or negative error on failure
> + */
> +int iio_read_event_processed_scale(struct iio_channel *chan,
> +				=C2=A0=C2=A0 enum iio_event_type type,
> +				=C2=A0=C2=A0 enum iio_event_direction dir,
> +				=C2=A0=C2=A0 enum iio_event_info info, int *val,
> +				=C2=A0=C2=A0 unsigned int scale);
> +
> +/**
> + * iio_write_event_processed_scale() - Read an event property
> + * @chan: Channel being queried
> + * @type: Event type (theshold, rate-of-change, etc.)
> + * @dir: Event direction (rising, falling, etc.)
> + * @info: Event property (enable, value, etc.)
> + * @processed: Processed property value
> + * @scale: Factor to scale @processed by
> + *
> + * Write a processed (scaled and offset) event property of a given chann=
el.
> + *
> + * Return: 0 on success, or negative error on failure
> + */
> +int iio_write_event_processed_scale(struct iio_channel *chan,
> +				=C2=A0=C2=A0=C2=A0 enum iio_event_type type,
> +				=C2=A0=C2=A0=C2=A0 enum iio_event_direction dir,
> +				=C2=A0=C2=A0=C2=A0 enum iio_event_info info, int processed,
> +				=C2=A0=C2=A0=C2=A0 unsigned int scale);
> +
> =C2=A0#endif

