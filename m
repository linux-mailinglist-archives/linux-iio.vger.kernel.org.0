Return-Path: <linux-iio+bounces-2048-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E7A084257B
	for <lists+linux-iio@lfdr.de>; Tue, 30 Jan 2024 13:55:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 167211F2E16E
	for <lists+linux-iio@lfdr.de>; Tue, 30 Jan 2024 12:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD7FC6A32A;
	Tue, 30 Jan 2024 12:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A2lVvzO5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E01679F2
	for <linux-iio@vger.kernel.org>; Tue, 30 Jan 2024 12:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706619031; cv=none; b=IAqYRAHQgKB77jYaJGDRvaczjuMIIvAQT2oryKXBIgv/QM9ZKurnxSEh2sEhPZzpwFK5aveobOgcjMkkmGc8RqQn+toe2P7+I8ENf2i6OAKNVM00yrm558OqyuVmKO0nK/BRdP1N28Qwq69Y1RmmGaZ5E1MLZIIuA4OrN/zquBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706619031; c=relaxed/simple;
	bh=TlR0lOLRWQHoO5iizUmY3xDDur6iPUaUaOYT0SP8nEk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NU0Q/o+bJKNTpzzJEnCBGsRWdvs3BjenNIBJ4fyYOID2ZeUmn4Znao9C8+Cevip9Wm7x2FbQfut2Skd8S4jE8lCNGnPOwHG2wKIoNQTEFhxsXkHHhD65+vzpB1mgRs4EIfdWqbzoKzQENV4xGDCAaRPkZ840+jPQQr0QgwJgs6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A2lVvzO5; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40f033c2e30so4598975e9.0
        for <linux-iio@vger.kernel.org>; Tue, 30 Jan 2024 04:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706619028; x=1707223828; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4p1a02uh1H5gfZsyP65odPOfYJ0BcQhvM7ZW6ePEWsw=;
        b=A2lVvzO5RS/T0a3lTePHHk4x2lDh3tMXBjTaSafJH8MrzC5xB/+4sncSu8ogZRJXVT
         zPLfrFsmxzMjGYaoJ6dmBhJ5JT6LEHxCeGEDZujqNW0spMJi01SuAvv6ykJqwEJX51fu
         4XEMZ056Om4T1rdvCtTF+O9dfwDMCgTbXA8BRar9Kim9mDcgTElSuuXbGmnuVzVYnF9W
         FOKB0CXI3Y9feNAetrBAcy7AMUqcX7WaYfKvixBgw3iOMcKnByGfhvJv4V3NymJ7yows
         pNsKyNF0Mp2vIPdlb0O7EDkeyoOaAW3CJkGM3EWLl+E/fJpdlfgMvV+L6ouUWEUi9485
         CGSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706619028; x=1707223828;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4p1a02uh1H5gfZsyP65odPOfYJ0BcQhvM7ZW6ePEWsw=;
        b=oM2WAFcN6RIjroWH5AE4YXeA9OrfGaj8A+Q+u37QIk20+Zc37U7LypaDbd0HRStwxj
         f0pWAS50RBmiaYNSQyAvOiJld/iUEmuhr/mLu8chc7qOuRI/v3rF7FVz0x/KBF4UNP7G
         9TnfHMXiQZqompUdoXNlghQkpUmULFh9pjXpsOrZBauanW22QP4WAowOBQdbSmRI7yRw
         AbpkY7tjBOCR0xVfL1oEKH+hi8X+XVoL9BZhEWJg6SYEnNYCoXuHbRKLlT23Kzxk2uX8
         eBKm8ylN8r8h2HvNN0wUUQS7DnyNH6iEm60HBkV2oMfp9rpFDjpqSXgMT3lkOHcRVgzK
         zVMg==
X-Gm-Message-State: AOJu0YwktsXdwykOZSw1KlG4w1iaDjVPNltUWh6dPSikg2zKWxkSAq4c
	x7wiGJGn7Ux7rutTUb/jjsYLh14FA49yfDmF/iE0z0zbR5KYXZxA
X-Google-Smtp-Source: AGHT+IFCLvPLC9rY+ddVRHzFMscyovzZ7uUqB0R/KyFnzjPWqEjfG27LmewQiXDPIraXjmaJ8E1sgg==
X-Received: by 2002:a05:600c:5108:b0:40e:f5be:6c3f with SMTP id o8-20020a05600c510800b0040ef5be6c3fmr4639070wms.15.1706619027746;
        Tue, 30 Jan 2024 04:50:27 -0800 (PST)
Received: from ?IPv6:2003:f6:ef1b:2000:15d4:fc17:481e:8afe? (p200300f6ef1b200015d4fc17481e8afe.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:15d4:fc17:481e:8afe])
        by smtp.gmail.com with ESMTPSA id c4-20020a05600c0a4400b0040e621feca9sm13098072wmq.17.2024.01.30.04.50.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 04:50:24 -0800 (PST)
Message-ID: <270d95aa0190520c443eaaa94c30b5d4d9c64389.camel@gmail.com>
Subject: Re: [PATCH 03/10] iio: accel: adxl367: Use automated cleanup for
 locks and iio direct mode.
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>, Peter Zijlstra
 <peterz@infradead.org>,  Jonathan Cameron <Jonathan.Cameron@huawei.com>
Date: Tue, 30 Jan 2024 13:53:39 +0100
In-Reply-To: <20240128150537.44592-4-jic23@kernel.org>
References: <20240128150537.44592-1-jic23@kernel.org>
	 <20240128150537.44592-4-jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2024-01-28 at 15:05 +0000, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>=20
> Switching to the iio_device_claim_direct_scoped() for state
> and to guard() based unlocking of mutexes simplifies error handling
> by allowing direct returns when an error is encountered.
>=20
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
> Since RFC:
> - Use unreachable() to stop complier moaning if we have
>=20
> 	iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
> 		return 0;
> 	}
> 	unreachable(); /* can't get here */
> - Update some code from earlier attempt to handle this that was left
> =C2=A0 behind from before iio_device_claim_direct_scoped()
> - Reduce scope of some local variables only used within
> =C2=A0 iio_device_claim_direct_scoped() blocks.
> ---
> =C2=A0drivers/iio/accel/adxl367.c | 297 ++++++++++++++-------------------=
---
> =C2=A01 file changed, 118 insertions(+), 179 deletions(-)
>=20
> diff --git a/drivers/iio/accel/adxl367.c b/drivers/iio/accel/adxl367.c
> index 90b7ae6d42b7..834ee6d63947 100644
> --- a/drivers/iio/accel/adxl367.c
> +++ b/drivers/iio/accel/adxl367.c
> @@ -339,22 +339,17 @@ static int adxl367_set_act_threshold(struct
> adxl367_state *st,
> =C2=A0{
> =C2=A0	int ret;
> =C2=A0
> -	mutex_lock(&st->lock);
> +	guard(mutex)(&st->lock);
> =C2=A0
> =C2=A0	ret =3D adxl367_set_measure_en(st, false);
> =C2=A0	if (ret)
> -		goto out;
> +		return ret;
> =C2=A0
> =C2=A0	ret =3D _adxl367_set_act_threshold(st, act, threshold);
> =C2=A0	if (ret)
> -		goto out;
> -
> -	ret =3D adxl367_set_measure_en(st, true);
> -
> -out:
> -	mutex_unlock(&st->lock);
> +		return ret;
> =C2=A0
> -	return ret;
> +	return adxl367_set_measure_en(st, true);
> =C2=A0}
> =C2=A0
> =C2=A0static int adxl367_set_act_proc_mode(struct adxl367_state *st,
> @@ -482,51 +477,45 @@ static int adxl367_set_fifo_watermark(struct
> adxl367_state *st,
> =C2=A0static int adxl367_set_range(struct iio_dev *indio_dev,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0 enum adxl367_range range)
> =C2=A0{
> -	struct adxl367_state *st =3D iio_priv(indio_dev);
> -	int ret;
> +	iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
> +		struct adxl367_state *st =3D iio_priv(indio_dev);
> +		int ret;
> =C2=A0
> -	ret =3D iio_device_claim_direct_mode(indio_dev);
> -	if (ret)
> -		return ret;
> -
> -	mutex_lock(&st->lock);
> -
> -	ret =3D adxl367_set_measure_en(st, false);
> -	if (ret)
> -		goto out;
> +		guard(mutex)(&st->lock);
> =C2=A0
> -	ret =3D regmap_update_bits(st->regmap, ADXL367_REG_FILTER_CTL,
> -				 ADXL367_FILTER_CTL_RANGE_MASK,
> -				 FIELD_PREP(ADXL367_FILTER_CTL_RANGE_MASK,
> -					=C2=A0=C2=A0=C2=A0 range));
> -	if (ret)
> -		goto out;
> +		ret =3D adxl367_set_measure_en(st, false);
> +		if (ret)
> +			return ret;
> =C2=A0
> -	adxl367_scale_act_thresholds(st, st->range, range);
> +		ret =3D regmap_update_bits(st->regmap, ADXL367_REG_FILTER_CTL,
> +					 ADXL367_FILTER_CTL_RANGE_MASK,
> +				=09
> FIELD_PREP(ADXL367_FILTER_CTL_RANGE_MASK,
> +						=C2=A0=C2=A0=C2=A0 range));
> +		if (ret)
> +			return ret;
> =C2=A0
> -	/* Activity thresholds depend on range */
> -	ret =3D _adxl367_set_act_threshold(st, ADXL367_ACTIVITY,
> -					 st->act_threshold);
> -	if (ret)
> -		goto out;
> +		adxl367_scale_act_thresholds(st, st->range, range);
> =C2=A0
> -	ret =3D _adxl367_set_act_threshold(st, ADXL367_INACTIVITY,
> -					 st->inact_threshold);
> -	if (ret)
> -		goto out;
> -
> -	ret =3D adxl367_set_measure_en(st, true);
> -	if (ret)
> -		goto out;
> +		/* Activity thresholds depend on range */
> +		ret =3D _adxl367_set_act_threshold(st, ADXL367_ACTIVITY,
> +						 st->act_threshold);
> +		if (ret)
> +			return ret;
> =C2=A0
> -	st->range =3D range;
> +		ret =3D _adxl367_set_act_threshold(st, ADXL367_INACTIVITY,
> +						 st->inact_threshold);
> +		if (ret)
> +			return ret;
> =C2=A0
> -out:
> -	mutex_unlock(&st->lock);
> +		ret =3D adxl367_set_measure_en(st, true);
> +		if (ret)
> +			return ret;
> =C2=A0
> -	iio_device_release_direct_mode(indio_dev);
> +		st->range =3D range;
> =C2=A0
> -	return ret;
> +		return 0;
> +	}
> +	unreachable();
> =C2=A0}

I do agree this is irritating. Personally I would prefer to return 0 (or th=
e
last ret value) instead of the unusual unreachable() builtin. But that's me=
 :)


- Nuno S=C3=A1

