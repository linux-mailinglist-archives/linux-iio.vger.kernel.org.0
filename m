Return-Path: <linux-iio+bounces-15630-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B535EA380BA
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 11:52:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B5D4188C454
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 10:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9C42163BB;
	Mon, 17 Feb 2025 10:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hnzZKsXU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E8A215F5B
	for <linux-iio@vger.kernel.org>; Mon, 17 Feb 2025 10:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739789516; cv=none; b=STwohBy7sasnIWNuClKOlJqBSYnYBFqufpk7nV+3lM979kXgaCrdRARj3f0DF7wj3f2Vd+k8PyAan80U2JkwE5t3NueTWhnIB3ogITyAPCep6Vgx/0SmvA8twfl4HLv9S74Ve87sFpqjVAA1FtyaH3RZyBSt/xRQHwS/0jnbqd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739789516; c=relaxed/simple;
	bh=jC6LGIWUcKtWrzL1AKM2mQtXTXRNQVfexooDprIg9p4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P0eIpdhzGu+1qZSe0Zyd0tX1ZVow37HYTDaz/5a4r33eBdGaIHrYw+bhLaSQu9U4lyB/Ir8qc9PbXpj11C27S8n4EDShJYeZYxFZVGy8+S9N7BxITxBodhXjPWraE5MiE7PWodJmkrDQLYeaiLf73yIacN5gqXxjldpWBYt9NAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hnzZKsXU; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4395f66a639so24856685e9.0
        for <linux-iio@vger.kernel.org>; Mon, 17 Feb 2025 02:51:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739789512; x=1740394312; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5o7M5t0BIAztc1Drr2kbHXqIJrSA+eNK5+yCVV1+Nfw=;
        b=hnzZKsXUwxklCcPZqvJ1SBcClO0Qlx4mURbxECt4aS/CiA4q2B7uFed86lxjU53ZK8
         mfb1MbhM1YoA/PHGL/1TuvRfOG+A6gdNkJkaFFYHxXBtgkqBAKJiR6SsdFmW30zz+Ov5
         2UIv2kSae7dXfIey55c965YPwnbnZo5VtpQCsHfOVyHWuCf5yET7HRGbPugD6JynsPc7
         adfZDwsZrF60UCEaXVGIs9OPMwt3w8iT+f+OgwjG8jijVW7/h78XnChqdmtMZvTAcxqL
         zVlze33vHCZRrq0hNvXIEW1wEDE2ekEEpFIN8FHIQ9tE5R9/22SiIjP/jg489n4XrgIb
         2BhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739789512; x=1740394312;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5o7M5t0BIAztc1Drr2kbHXqIJrSA+eNK5+yCVV1+Nfw=;
        b=gU5vB7jraOl0reeOqiITkjbwjiVU3vPJ9/3AAiDMqJeCLyhQo4vyH1pEZpaIDUN+qG
         P98LfJeI7eMc3UG7xGHlbQ1m4QwgRRlcBgjYfL0kzu04gb5baCmC6XvXBcJIsiXOx7jq
         TiPdE5p9jKgY3CfWBFGz8yjjVy4RuCePqfYmyJH0m99cLtU3nKco1jeHKabsKEzj4dqc
         1fLcbEPFQhKyv0WW3ANGTCZfp/U1sVhCdezYuU+Z3FawoJlM/tQX8hRRubfDoqOZc3kx
         wnLtLfwoljx0mtk32mtMqRVot54wbAjN55eL44Hs7fYBsEKEWxI84ylbQWLMi/e4pvVm
         p8UQ==
X-Forwarded-Encrypted: i=1; AJvYcCUw+3YD/5XxNpqX7LEMPJ8AwPDAPtVuvnBInDqXHG/8/v+d5f9L+9/PDFXywHDBD9dugIXT+eGh/Yo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3A/f2Ytz49tJquYyrRMSWWKv4d8K6It56iVL/uYDCgNGaSwNZ
	ZteLQOn1d8EZcMF9GVqi9lsi5FzaXbanMZrRwlZGLNepRNe/tZ9j
X-Gm-Gg: ASbGncufqUNpGsVYdqTsojM1dcVHyn8FRe4H36/dkG0/Dc/MSgoObteQoIN5awykJPJ
	y10L5/qZL5SLis9IE1NVNF3+obKCRaUoqKkwg+KfnQZr1ToNAjlu2tH07e99aFNzDEfNTpVVVUH
	ZtCFLk6qbMwrYGcOHcd388cStAoidAFzG/HVNq4bc7JRdQMiAFefbsTtVHxiA7GlY/s0ZVhBxzp
	Yu/wDvfTiXoWY7a/CyKfgP9Ep2NkBVI7/ab7KBqAEo+mduiGMn05TGbg1bmiV1+qwMq0FwwYP/k
	8JSKjdDv+bnOjg0V0FSAiNO7PNL5aNFYp6nNkRMZ62iPaiCdMOuYfjHyAdxt5oY=
X-Google-Smtp-Source: AGHT+IFVLkmFvrFN4p4UqXClUjzlUXl/8ZPfpR710yCSbYsngwH29/nMSNwmUfinR0sZf60PxpcsUw==
X-Received: by 2002:a05:600c:3b92:b0:439:31e0:d9a5 with SMTP id 5b1f17b1804b1-4396e733555mr77759325e9.22.1739789512491;
        Mon, 17 Feb 2025 02:51:52 -0800 (PST)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4395a1aa7bcsm148431485e9.28.2025.02.17.02.51.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 02:51:52 -0800 (PST)
Message-ID: <1ea8021c7a68cad5211ac48dff84920e58152d30.camel@gmail.com>
Subject: Re: [PATCH v2 16/27] iio: adc: max1363: Stop using
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
Date: Mon, 17 Feb 2025 10:51:55 +0000
In-Reply-To: <20250209180624.701140-17-jic23@kernel.org>
References: <20250209180624.701140-1-jic23@kernel.org>
	 <20250209180624.701140-17-jic23@kernel.org>
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
> to check for unbalanced context.
>=20
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---

Reviewed-by: Nuno Sa <nuno.sa@analog.com>

> =C2=A0drivers/iio/adc/max1363.c | 165 ++++++++++++++++++++---------------=
---
> =C2=A01 file changed, 89 insertions(+), 76 deletions(-)
>=20
> diff --git a/drivers/iio/adc/max1363.c b/drivers/iio/adc/max1363.c
> index e8d731bc34e0..35717ec082ce 100644
> --- a/drivers/iio/adc/max1363.c
> +++ b/drivers/iio/adc/max1363.c
> @@ -364,55 +364,52 @@ static int max1363_read_single_chan(struct iio_dev
> *indio_dev,
> =C2=A0				=C2=A0=C2=A0=C2=A0 int *val,
> =C2=A0				=C2=A0=C2=A0=C2=A0 long m)
> =C2=A0{
> -	iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
> -		s32 data;
> -		u8 rxbuf[2];
> -		struct max1363_state *st =3D iio_priv(indio_dev);
> -		struct i2c_client *client =3D st->client;
> -
> -		guard(mutex)(&st->lock);
> -
> -		/*
> -		 * If monitor mode is enabled, the method for reading a
> single
> -		 * channel will have to be rather different and has not yet
> -		 * been implemented.
> -		 *
> -		 * Also, cannot read directly if buffered capture enabled.
> -		 */
> -		if (st->monitor_on)
> -			return -EBUSY;
> +	s32 data;
> +	u8 rxbuf[2];
> +	struct max1363_state *st =3D iio_priv(indio_dev);
> +	struct i2c_client *client =3D st->client;
> =C2=A0
> -		/* Check to see if current scan mode is correct */
> -		if (st->current_mode !=3D &max1363_mode_table[chan->address]) {
> -			int ret;
> +	guard(mutex)(&st->lock);
> =C2=A0
> -			/* Update scan mode if needed */
> -			st->current_mode =3D &max1363_mode_table[chan-
> >address];
> -			ret =3D max1363_set_scan_mode(st);
> -			if (ret < 0)
> -				return ret;
> -		}
> -		if (st->chip_info->bits !=3D 8) {
> -			/* Get reading */
> -			data =3D st->recv(client, rxbuf, 2);
> -			if (data < 0)
> -				return data;
> -
> -			data =3D get_unaligned_be16(rxbuf) &
> -				((1 << st->chip_info->bits) - 1);
> -		} else {
> -			/* Get reading */
> -			data =3D st->recv(client, rxbuf, 1);
> -			if (data < 0)
> -				return data;
> -
> -			data =3D rxbuf[0];
> -		}
> -		*val =3D data;
> +	/*
> +	 * If monitor mode is enabled, the method for reading a single
> +	 * channel will have to be rather different and has not yet
> +	 * been implemented.
> +	 *
> +	 * Also, cannot read directly if buffered capture enabled.
> +	 */
> +	if (st->monitor_on)
> +		return -EBUSY;
> +
> +	/* Check to see if current scan mode is correct */
> +	if (st->current_mode !=3D &max1363_mode_table[chan->address]) {
> +		int ret;
> +
> +		/* Update scan mode if needed */
> +		st->current_mode =3D &max1363_mode_table[chan->address];
> +		ret =3D max1363_set_scan_mode(st);
> +		if (ret < 0)
> +			return ret;
> +	}
> +	if (st->chip_info->bits !=3D 8) {
> +		/* Get reading */
> +		data =3D st->recv(client, rxbuf, 2);
> +		if (data < 0)
> +			return data;
> +
> +		data =3D get_unaligned_be16(rxbuf) &
> +			((1 << st->chip_info->bits) - 1);
> +	} else {
> +		/* Get reading */
> +		data =3D st->recv(client, rxbuf, 1);
> +		if (data < 0)
> +			return data;
> =C2=A0
> -		return 0;
> +		data =3D rxbuf[0];
> =C2=A0	}
> -	unreachable();
> +	*val =3D data;
> +
> +	return 0;
> =C2=A0}
> =C2=A0
> =C2=A0static int max1363_read_raw(struct iio_dev *indio_dev,
> @@ -426,7 +423,11 @@ static int max1363_read_raw(struct iio_dev *indio_de=
v,
> =C2=A0
> =C2=A0	switch (m) {
> =C2=A0	case IIO_CHAN_INFO_RAW:
> +		if (!iio_device_claim_direct(indio_dev))
> +			return -EBUSY;
> +
> =C2=A0		ret =3D max1363_read_single_chan(indio_dev, chan, val, m);
> +		iio_device_release_direct(indio_dev);
> =C2=A0		if (ret < 0)
> =C2=A0			return ret;
> =C2=A0		return IIO_VAL_INT;
> @@ -947,46 +948,58 @@ static inline int __max1363_check_event_mask(int
> thismask, int checkmask)
> =C2=A0	return ret;
> =C2=A0}
> =C2=A0
> -static int max1363_write_event_config(struct iio_dev *indio_dev,
> -	const struct iio_chan_spec *chan, enum iio_event_type type,
> +static int __max1363_write_event_config(struct max1363_state *st,
> +	const struct iio_chan_spec *chan,
> =C2=A0	enum iio_event_direction dir, bool state)
> =C2=A0{
> -	struct max1363_state *st =3D iio_priv(indio_dev);
> -
> -	iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
> -		int number =3D chan->channel;
> -		u16 unifiedmask;
> -		int ret;
> +	int number =3D chan->channel;
> +	u16 unifiedmask;
> +	int ret;
> =C2=A0
> -		guard(mutex)(&st->lock);
> +	guard(mutex)(&st->lock);
> =C2=A0
> -		unifiedmask =3D st->mask_low | st->mask_high;
> -		if (dir =3D=3D IIO_EV_DIR_FALLING) {
> +	unifiedmask =3D st->mask_low | st->mask_high;
> +	if (dir =3D=3D IIO_EV_DIR_FALLING) {
> =C2=A0
> -			if (state =3D=3D 0)
> -				st->mask_low &=3D ~(1 << number);
> -			else {
> -				ret =3D __max1363_check_event_mask((1 <<
> number),
> -							=09
> unifiedmask);
> -				if (ret)
> -					return ret;
> -				st->mask_low |=3D (1 << number);
> -			}
> -		} else {
> -			if (state =3D=3D 0)
> -				st->mask_high &=3D ~(1 << number);
> -			else {
> -				ret =3D __max1363_check_event_mask((1 <<
> number),
> -							=09
> unifiedmask);
> -				if (ret)
> -					return ret;
> -				st->mask_high |=3D (1 << number);
> -			}
> +		if (state =3D=3D 0)
> +			st->mask_low &=3D ~(1 << number);
> +		else {
> +			ret =3D __max1363_check_event_mask((1 << number),
> +							 unifiedmask);
> +			if (ret)
> +				return ret;
> +			st->mask_low |=3D (1 << number);
> +		}
> +	} else {
> +		if (state =3D=3D 0)
> +			st->mask_high &=3D ~(1 << number);
> +		else {
> +			ret =3D __max1363_check_event_mask((1 << number),
> +							 unifiedmask);
> +			if (ret)
> +				return ret;
> +			st->mask_high |=3D (1 << number);
> =C2=A0		}
> =C2=A0	}
> -	max1363_monitor_mode_update(st, !!(st->mask_high | st->mask_low));
> =C2=A0
> =C2=A0	return 0;
> +
> +}
> +static int max1363_write_event_config(struct iio_dev *indio_dev,
> +	const struct iio_chan_spec *chan, enum iio_event_type type,
> +	enum iio_event_direction dir, bool state)
> +{
> +	struct max1363_state *st =3D iio_priv(indio_dev);
> +	int ret;
> +
> +	if (!iio_device_claim_direct(indio_dev))
> +		return -EBUSY;
> +
> +	ret =3D __max1363_write_event_config(st, chan,=C2=A0 dir, state);
> +	iio_device_release_direct(indio_dev);
> +	max1363_monitor_mode_update(st, !!(st->mask_high | st->mask_low));
> +
> +	return ret;
> =C2=A0}
> =C2=A0
> =C2=A0/*


