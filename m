Return-Path: <linux-iio+bounces-21707-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8082FB06EE1
	for <lists+linux-iio@lfdr.de>; Wed, 16 Jul 2025 09:22:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88790502787
	for <lists+linux-iio@lfdr.de>; Wed, 16 Jul 2025 07:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E480F28A1C8;
	Wed, 16 Jul 2025 07:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NUXJsXGi"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6936218858;
	Wed, 16 Jul 2025 07:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752650551; cv=none; b=tSYFB/trpH1ian6j147MwS6JRNJrWZiMTglxI4Z6C5wmN4qrhQMX4CwftvSD+6Oqq/lX4l+ucaRV0AJHIB2ZfTttK6EqjLkXLeensg7qJKUI3ZxLu0+v7kwG0DCSdWAr5HTDnWISeILFwd2tKIdmvxKJHYbwZzGYqOp2fNYaMNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752650551; c=relaxed/simple;
	bh=IcBeacOtmCHFWAN7Z+3nTRHhmgap1sVpheslGNe4rrU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=g6KbxZh1Ri3ytWUpFutn8uUqH5MuPSCbMiacu9VdPkfSWwIi9TaTKVnPqjKpcAQu5pIHOe6GNL3REya9Z1zVXaHlFvMWxwFAYsCAJKzUfne2XWEjWqc3ZWkuvjGlKZP2DKBG5mqpUvDN5fzy3xKOgxSapyx+v9ggSDPkQpIP4QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NUXJsXGi; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-451d54214adso41823445e9.3;
        Wed, 16 Jul 2025 00:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752650548; x=1753255348; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rQ0igjN6f0ZgtsRyAdgNl4YH74awlMukDlXQcIRUqOc=;
        b=NUXJsXGiE3EEZjhpHs8yW3qQf3tN7p7280D6lnZ+QWaGwrOzUbkVpEzXBoKDRQYytc
         /tMT3G5F0UcjFv0esPhwdOW2k0yZoGvODFtAblIVkeZBmtzrNt8Buly+IVkIzXvMCUTo
         iMnXC2KoR25UD8CKiZI2cxorUcq44wfq75UuladsUIJFGjFeqpREMkwqFB7m7Vr27rD0
         Hqr8WUrcTD1kbxzByjI96jDpNoG6sV4rSSUs/ae/Oiw/B9LZnORqqNsjFBZlpqaEt/WH
         sE7ESJQJDd8KeC8wkbsK8+f+p+hxCAbqtRD7a1FbkhhF/gg6Bjl/33q1e52SgEQj3+lC
         ER8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752650548; x=1753255348;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rQ0igjN6f0ZgtsRyAdgNl4YH74awlMukDlXQcIRUqOc=;
        b=ZpQqt4IYHPjKvghJwdmVE8W+0CDb5XR0anHupwTm4Os3ud6907mS+fZweaR66zIhKD
         3FSPiHTKn/3iF3SPvz0xhJ4oN0eUcs8kAUsSksSNR1OpWERmWm6PJvgkOJOkxVrHvlDa
         BpmHWOF6nY1D3UdZQtaYlZohvlOI4Kky5J6I2OLdhbxYWwRhx0vBf81tZJvOknFNwbsa
         7Gcxrn9EAEee7GiMqcBcxz0BJ9PDC3/FAFgG5C6udDdU8b0YIGAMutZkl6BkOkClHtNN
         +W3XS1XHEyB5z+c9jMeWNigbYDwXvIV3zuaTBu/JqhhRzGwoopAIdvJy0+HHm3LXEuSb
         P/Ug==
X-Forwarded-Encrypted: i=1; AJvYcCVanOkynHA0vthSxfWqKsL92qOqfIDHuNrlLqxzRQx45EK8gachESSUeUtE900W9CSHQSNcH2S4XVPp5TN6@vger.kernel.org, AJvYcCXBjFbahiUpZS2DP59hjXycZhWGjbwmhtmW4ZgAWglOlGzdFbiKQcUgwnJ9PjPtKnXrbhmdJZ9v4Sb3PA==@vger.kernel.org, AJvYcCXJ2lEU3RUCSl2hnE6I7vvgj1+GqxBl6+K6hJAa7veS5CbTYfOwo5b92OgzNuY0q9bOP8Hx5w1JKHZ8@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8pacFsDh4CqSIKtoZZQvN95t/brvRYIrGPT9T1XkCMbBzp0kd
	g8nXG9795paJaFutbAudVAGqtmw9fDUbHwFfxgSLIG8bGqyymMxKkKt7
X-Gm-Gg: ASbGnctKaxHQxZv7Ru3jrgghzoRhvTeFnBn2Ao5ZFzriu2mDUGJucJjqoBN5L1ZgFoO
	348/+LTQ+2nCHSx17UJkRN/sKlwlbIe+uDAEb71LL+h1iXDmwjmVIJ1M02ZhBNDXWTh5awh0zPN
	6k4okAEyNJ/4cm8VHPMldXrBto8JMYskfskfYeIFXDztBv3YkwmFhe1C8Cj7NoRmqwlotLKw2yi
	PYx09hUZsz4SHAhX80eFODeSgkWEQSekGYb8qXIFj9rb3UF+6mRVBF4QPI4tGcNKunrOEfudhMZ
	1UmRfbh9RhiRj/tped7sBCIAnrTDubFTyC57hppdxNBlSisahE5kdPc6D2vsxcbIH2kpRIez9fY
	T86hQjfY5PjDVM1SqQ9+oYHBXzswj8uIurSiI4ocJFLtqUVNFZ7e6T/gOK6KiQdb1hyou96gEdR
	9E0o6ChBA=
X-Google-Smtp-Source: AGHT+IGtnpoxojmjcjwSAcTEuWBa5CvFqrND65xJLBjBnXwZl3JwqZZdhCQ8WuGYFXhqtKfrpF6Dsg==
X-Received: by 2002:a05:600c:1c81:b0:456:161c:3d6f with SMTP id 5b1f17b1804b1-4562dfe78dfmr16440825e9.11.1752650547459;
        Wed, 16 Jul 2025 00:22:27 -0700 (PDT)
Received: from ?IPv6:2001:818:ea56:d000:56e0:ceba:7da4:6673? ([2001:818:ea56:d000:56e0:ceba:7da4:6673])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e82ec6esm12091705e9.28.2025.07.16.00.22.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 00:22:27 -0700 (PDT)
Message-ID: <bc45e2de04d6decfcbfa60502e75e8b7bef1450e.camel@gmail.com>
Subject: Re: [PATCH 2/7] iio: inkern: Add API for reading/writing events
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Sean Anderson <sean.anderson@linux.dev>, Jonathan Cameron
 <jic23@kernel.org>,  Jean Delvare <jdelvare@suse.com>, Guenter Roeck
 <linux@roeck-us.net>, linux-iio@vger.kernel.org, 
 linux-hwmon@vger.kernel.org
Cc: Andy Shevchenko <andy@kernel.org>, Nuno =?ISO-8859-1?Q?S=E1?=
	 <nuno.sa@analog.com>, linux-kernel@vger.kernel.org, David Lechner
	 <dlechner@baylibre.com>
Date: Wed, 16 Jul 2025 07:23:05 +0100
In-Reply-To: <8e598681-f0a2-4ced-8f68-17384ef95de4@linux.dev>
References: <20250715012023.2050178-1-sean.anderson@linux.dev>
	 <20250715012023.2050178-3-sean.anderson@linux.dev>
	 <0fad26b4384e4163f4807f6b779361099f505a86.camel@gmail.com>
	 <8e598681-f0a2-4ced-8f68-17384ef95de4@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-07-15 at 11:43 -0400, Sean Anderson wrote:
> On 7/15/25 06:35, Nuno S=C3=A1 wrote:
> > On Mon, 2025-07-14 at 21:20 -0400, Sean Anderson wrote:
> > > Add an in-kernel API for reading/writing event properties. Like the
> > > raw-to-processed conversion, with processed-to-raw we only convert th=
e
> > > integer part, introducing some round-off error.
> > >=20
> > > A common case is for other drivers to re-expose IIO events as sysfs
> > > properties with a different API. To help out with this, iio_event_mod=
e
> > > returns the appropriate mode. It can also be used to test for existen=
ce
> > > if the consumer doesn't care about read/write capability.
> > >=20
> > > Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> > > ---
> >=20
> > Just one comment on top of Andy's review
> >=20
> > >=20
> > > =C2=A0drivers/iio/inkern.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 198 +++++++++++++++++++++++++++++++++++
> > > =C2=A0include/linux/iio/consumer.h |=C2=A0 56 ++++++++++
> > > =C2=A02 files changed, 254 insertions(+)
> > >=20
> > > diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
> > > index c174ebb7d5e6..d3bbd2444fb5 100644
> > > --- a/drivers/iio/inkern.c
> > > +++ b/drivers/iio/inkern.c
> > > @@ -1028,3 +1028,201 @@ ssize_t iio_read_channel_label(struct iio_cha=
nnel
> > > *chan, char *buf)
> > > =C2=A0	return do_iio_read_channel_label(chan->indio_dev, chan->channe=
l,
> > > buf);
> > > =C2=A0}
> > > =C2=A0EXPORT_SYMBOL_GPL(iio_read_channel_label);
> > > +
> > > +static bool iio_event_exists(struct iio_channel *channel,
> > > +			=C2=A0=C2=A0=C2=A0=C2=A0 enum iio_event_type type,
> > > +			=C2=A0=C2=A0=C2=A0=C2=A0 enum iio_event_direction dir,
> > > +			=C2=A0=C2=A0=C2=A0=C2=A0 enum iio_event_info info)
> > > +{
> > > +	struct iio_chan_spec const *chan =3D channel->channel;
> > > +	int i;
> > > +
> >=20
> > Can we iio_event_exists() -> iio_event_exists_locked()? Or likely the b=
est way
>=20
> wouldn't _unlocked be the convention for this file?

Oh, indeed!

>=20
> > would be to annotate it with lockdep (though that would mean some dance=
 to get
> > the opaque object.
>=20
> I will add a lockdep annotation.
>=20
> --Sean
>=20
> > Anyways, bottom line is it should clear that iio_event_exists() is to b=
e called
> > with the lock held.
> >=20
> > - Nuno S=C3=A1
> >=20
> > > +	if (!channel->indio_dev->info)
> > > +		return false;
> > > +
> > > +	for (i =3D 0; i < chan->num_event_specs; i++) {
> > > +		if (chan->event_spec[i].type !=3D type)
> > > +			continue;
> > > +		if (chan->event_spec[i].dir !=3D dir)
> > > +			continue;
> > > +		if (chan->event_spec[i].mask_separate & BIT(info))
> > > +			return true;
> > > +	}
> > > +
> > > +	return false;
> > > +}
> > > +
> > > +umode_t iio_event_mode(struct iio_channel *chan, enum iio_event_type=
 type,
> > > +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum iio_event_direction dir,=
 enum iio_event_info
> > > info)
> > > +{
> > > +	struct iio_dev *indio_dev =3D chan->indio_dev;
> > > +	struct iio_dev_opaque *iio_dev_opaque =3D to_iio_dev_opaque(indio_d=
ev);
> > > +	umode_t mode =3D 0;
> > > +
> > > +	guard(mutex)(&iio_dev_opaque->info_exist_lock);
> > > +	if (!iio_event_exists(chan, type, dir, info))
> > > +		return 0;
> > > +
> > > +	if (info =3D=3D IIO_EV_INFO_ENABLE) {
> > > +		if (indio_dev->info->read_event_config)
> > > +			mode |=3D 0444;
> > > +
> > > +		if (indio_dev->info->write_event_config)
> > > +			mode |=3D 0200;
> > > +	} else {
> > > +		if (indio_dev->info->read_event_value)
> > > +			mode |=3D 0444;
> > > +
> > > +		if (indio_dev->info->write_event_value)
> > > +			mode |=3D 0200;
> > > +	}
> > > +
> > > +	return mode;
> > > +}
> > > +EXPORT_SYMBOL_GPL(iio_event_mode);
> > > +
> > > +int iio_read_event_processed_scale(struct iio_channel *chan,
> > > +				=C2=A0=C2=A0 enum iio_event_type type,
> > > +				=C2=A0=C2=A0 enum iio_event_direction dir,
> > > +				=C2=A0=C2=A0 enum iio_event_info info, int *val,
> > > +				=C2=A0=C2=A0 unsigned int scale)
> > > +{
> > > +	struct iio_dev *indio_dev =3D chan->indio_dev;
> > > +	struct iio_dev_opaque *iio_dev_opaque =3D to_iio_dev_opaque(indio_d=
ev);
> > > +	int ret, raw;
> > > +
> > > +	guard(mutex)(&iio_dev_opaque->info_exist_lock);
> > > +	if (!iio_event_exists(chan, type, dir, info))
> > > +		return -ENODEV;
> > > +
> > > +	if (info =3D=3D IIO_EV_INFO_ENABLE) {
> > > +		if (!indio_dev->info->read_event_config)
> > > +			return -EINVAL;
> > > +
> > > +		raw =3D indio_dev->info->read_event_config(indio_dev,
> > > +							 chan->channel, type,
> > > +							 dir);
> > > +		if (raw < 0)
> > > +			return raw;
> > > +
> > > +		*val =3D raw;
> > > +		return 0;
> > > +	}
> > > +
> > > +	if (!indio_dev->info->read_event_value)
> > > +		return -EINVAL;
> > > +
> > > +	ret =3D indio_dev->info->read_event_value(indio_dev, chan->channel,
> > > type,
> > > +						dir, info, &raw, NULL);
> > > +	if (ret < 0)
> > > +		return ret;
> > > +
> > > +	return iio_convert_raw_to_processed_unlocked(chan, raw, val, scale)=
;
> > > +}
> > > +EXPORT_SYMBOL_GPL(iio_read_event_processed_scale);
> > > +
> > > +static int iio_convert_processed_to_raw_unlocked(struct iio_channel =
*chan,
> > > +						 int processed, int *raw,
> > > +						 unsigned int scale)
> > > +{
> > > +	int scale_type, scale_val, scale_val2;
> > > +	int offset_type, offset_val, offset_val2;
> > > +	s64 r, scale64, raw64;
> > > +
> > > +	scale_type =3D iio_channel_read(chan, &scale_val, &scale_val2,
> > > +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 IIO_CHAN_INFO_SCALE);
> > > +	if (scale_type < 0) {
> > > +		raw64 =3D processed / scale;
> > > +	} else {
> > > +		switch (scale_type) {
> > > +		case IIO_VAL_INT:
> > > +			scale64 =3D (s64)scale_val * scale;
> > > +			if (scale64 <=3D INT_MAX && scale64 >=3D INT_MIN)
> > > +				raw64 =3D processed / (int)scale64;
> > > +			else
> > > +				raw64 =3D 0;
> > > +			break;
> > > +		case IIO_VAL_INT_PLUS_MICRO:
> > > +			scale64 =3D scale_val * scale * 1000000LL + scale_val2;
> > > +			raw64 =3D div64_s64_rem(processed, scale64, &r);
> > > +			raw64 =3D raw64 * 1000000 +
> > > +				div64_s64(r * 1000000, scale64);
> > > +			break;
> > > +		case IIO_VAL_INT_PLUS_NANO:
> > > +			scale64 =3D scale_val * scale * 1000000000LL +
> > > scale_val2;
> > > +			raw64 =3D div64_s64_rem(processed, scale64, &r);
> > > +			raw64 =3D raw64 * 1000000000 +
> > > +				div64_s64(r * 1000000000, scale64);
> > > +			break;
> > > +		case IIO_VAL_FRACTIONAL:
> > > +			raw64 =3D div64_s64((s64)processed * scale_val2,
> > > +					=C2=A0 (s64)scale_val * scale);
> > > +			break;
> > > +		case IIO_VAL_FRACTIONAL_LOG2:
> > > +			raw64 =3D div64_s64((s64)processed << scale_val2,
> > > +					=C2=A0 (s64)scale_val * scale);
> > > +			break;
> > > +		default:
> > > +			return -EINVAL;
> > > +		}
> > > +	}
> > > +
> > > +	offset_type =3D iio_channel_read(chan, &offset_val, &offset_val2,
> > > +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 IIO_CHAN_INFO_OFFSET);
> > > +	if (offset_type >=3D 0) {
> > > +		switch (offset_type) {
> > > +		case IIO_VAL_INT:
> > > +		case IIO_VAL_INT_PLUS_MICRO:
> > > +		case IIO_VAL_INT_PLUS_NANO:
> > > +			raw64 -=3D offset_val;
> > > +			break;
> > > +		case IIO_VAL_FRACTIONAL:
> > > +			raw64 -=3D offset_val / offset_val2;
> > > +			break;
> > > +		case IIO_VAL_FRACTIONAL_LOG2:
> > > +			raw64 -=3D offset_val >> offset_val2;
> > > +			break;
> > > +		default:
> > > +			return -EINVAL;
> > > +		}
> > > +	}
> > > +
> > > +	*raw =3D clamp(raw64, (s64)INT_MIN, (s64)INT_MAX);
> > > +	return 0;
> > > +}
> > > +
> > > +int iio_write_event_processed_scale(struct iio_channel *chan,
> > > +				=C2=A0=C2=A0=C2=A0 enum iio_event_type type,
> > > +				=C2=A0=C2=A0=C2=A0 enum iio_event_direction dir,
> > > +				=C2=A0=C2=A0=C2=A0 enum iio_event_info info, int processed,
> > > +				=C2=A0=C2=A0=C2=A0 unsigned int scale)
> > > +{
> > > +	struct iio_dev *indio_dev =3D chan->indio_dev;
> > > +	struct iio_dev_opaque *iio_dev_opaque =3D to_iio_dev_opaque(chan-
> > > > indio_dev);
> > > +	int ret, raw;
> > > +
> > > +	guard(mutex)(&iio_dev_opaque->info_exist_lock);
> > > +	if (!iio_event_exists(chan, type, dir, info))
> > > +		return -ENODEV;
> > > +
> > > +	if (info =3D=3D IIO_EV_INFO_ENABLE) {
> > > +		if (!indio_dev->info->write_event_config)
> > > +			return -EINVAL;
> > > +
> > > +		return indio_dev->info->write_event_config(indio_dev,
> > > +							=C2=A0=C2=A0 chan->channel,
> > > type,
> > > +							=C2=A0=C2=A0 dir, processed);
> > > +	}
> > > +
> > > +	if (!indio_dev->info->write_event_value)
> > > +		return -EINVAL;
> > > +
> > > +	ret =3D iio_convert_processed_to_raw_unlocked(chan, processed, &raw=
,
> > > +						=C2=A0=C2=A0=C2=A0 scale);
> > > +	if (ret < 0)
> > > +		return ret;
> > > +
> > > +	return indio_dev->info->write_event_value(indio_dev, chan->channel,
> > > +						=C2=A0 type, dir, info, raw, 0);
> > > +}
> > > +EXPORT_SYMBOL_GPL(iio_write_event_processed_scale);
> > > diff --git a/include/linux/iio/consumer.h b/include/linux/iio/consume=
r.h
> > > index 6a4479616479..16e7682474f3 100644
> > > --- a/include/linux/iio/consumer.h
> > > +++ b/include/linux/iio/consumer.h
> > > @@ -451,4 +451,60 @@ ssize_t iio_write_channel_ext_info(struct iio_ch=
annel
> > > *chan, const char *attr,
> > > =C2=A0 */
> > > =C2=A0ssize_t iio_read_channel_label(struct iio_channel *chan, char *=
buf);
> > > =C2=A0
> > > +/**
> > > + * iio_event_mode() - get file mode for an event property
> > > + * @chan: Channel being queried
> > > + * @type: Event type (theshold, rate-of-change, etc.)
> > > + * @dir: Event direction (rising, falling, etc.)
> > > + * @info: Event property (enable, value, etc.)
> > > + *
> > > + * Determine an appropriate mode for sysfs files derived from this e=
vent.
> > > + *
> > > + * Return:
> > > + *=C2=A0=C2=A0 - `0000` if the event is unsupported or otherwise una=
vailable
> > > + *=C2=A0=C2=A0 - `0444` if the event is read-only
> > > + *=C2=A0=C2=A0 - `0200` if the event is write-only
> > > + *=C2=A0=C2=A0 - `0644` if the event is read-write
> > > + */
> > > +umode_t iio_event_mode(struct iio_channel *chan, enum iio_event_type=
 type,
> > > +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum iio_event_direction dir,=
 enum iio_event_info
> > > info);
> > > +
> > > +/**
> > > + * iio_read_event_processed_scale() - Read an event property
> > > + * @chan: Channel being queried
> > > + * @type: Event type (theshold, rate-of-change, etc.)
> > > + * @dir: Event direction (rising, falling, etc.)
> > > + * @info: Event property (enable, value, etc.)
> > > + * @val: Processed property value
> > > + * @scale: Factor to scale @val by
> > > + *
> > > + * Read a processed (scaled and offset) event property of a given ch=
annel.
> > > + *
> > > + * Return: 0 on success, or negative error on failure
> > > + */
> > > +int iio_read_event_processed_scale(struct iio_channel *chan,
> > > +				=C2=A0=C2=A0 enum iio_event_type type,
> > > +				=C2=A0=C2=A0 enum iio_event_direction dir,
> > > +				=C2=A0=C2=A0 enum iio_event_info info, int *val,
> > > +				=C2=A0=C2=A0 unsigned int scale);
> > > +
> > > +/**
> > > + * iio_write_event_processed_scale() - Read an event property
> > > + * @chan: Channel being queried
> > > + * @type: Event type (theshold, rate-of-change, etc.)
> > > + * @dir: Event direction (rising, falling, etc.)
> > > + * @info: Event property (enable, value, etc.)
> > > + * @processed: Processed property value
> > > + * @scale: Factor to scale @processed by
> > > + *
> > > + * Write a processed (scaled and offset) event property of a given c=
hannel.
> > > + *
> > > + * Return: 0 on success, or negative error on failure
> > > + */
> > > +int iio_write_event_processed_scale(struct iio_channel *chan,
> > > +				=C2=A0=C2=A0=C2=A0 enum iio_event_type type,
> > > +				=C2=A0=C2=A0=C2=A0 enum iio_event_direction dir,
> > > +				=C2=A0=C2=A0=C2=A0 enum iio_event_info info, int processed,
> > > +				=C2=A0=C2=A0=C2=A0 unsigned int scale);
> > > +
> > > =C2=A0#endif
>=20


