Return-Path: <linux-iio+bounces-15771-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B7CCA3BC55
	for <lists+linux-iio@lfdr.de>; Wed, 19 Feb 2025 12:03:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 227221889CEF
	for <lists+linux-iio@lfdr.de>; Wed, 19 Feb 2025 11:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F1241D8E07;
	Wed, 19 Feb 2025 11:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fKgGVSU3"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40BC286291
	for <linux-iio@vger.kernel.org>; Wed, 19 Feb 2025 11:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739962975; cv=none; b=XMMb4Ezlb130jKTRg2YNLSFqdbunYX/XgWslRVv7ZSdygqux8cEHoquW+6itTzQvmqI+CPMtrPWQqcdGs1/gdXRHvnG3xLD0pvRkYAHac3G8qnCdDkUGOp0vR22WapslhV0STRF5o42M5uFJIZO5pmIsAnFY76rbm+967OzkKDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739962975; c=relaxed/simple;
	bh=gYuogeFi5Ky9sDxg4uRw0O9PGeXQzJGHJtxLISKyQjs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Nu10yZAxgXysrCap0dQ977OPKKlTfTfXLZnyw4cT7IBD8hScp0yQ/01zSw04/Z9Ud5YGf1oRCA1/TdCrW9u7xS06Notcq3nhxccuhe3rKy9cBuH2/JHTp3d3lIWVOAWAbx7NkdrHwxZLAMeais1yVQiOvInPNaMvr/S4AeC2Xhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fKgGVSU3; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-abba1b74586so476879566b.2
        for <linux-iio@vger.kernel.org>; Wed, 19 Feb 2025 03:02:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739962972; x=1740567772; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=o06HkSE3yrEb6kTJ1G6hMgP1ityNwB8Uh2xrUpzi7uo=;
        b=fKgGVSU3ojZeC0nA9uBzeSYpT8Bgig/2qr8ifxzlqu8TRHfkim4AufE/LJbvaMwMnF
         2R18KpS6bnnSa/2jTcKSA9RTRElArtorsTuDo4aZ6lnFvyLfhUkONbpRSFigCDRRyG+3
         do+sEH/MnT3eZnF11Pa7qbfGnH49Vz6lSxD5DOX0jWXfN+InuYvg53gFXtmaexy9+cRX
         vsq7nBwoZkW3CPvECu14t1m5oSHI41ljP0m1QbCvFyZ47y1HliQMGWrEvzMVy8hNqkJ7
         oD733JCB6ckGhO6rjp6U6QvF7wodkSsTd87OTmI2XQyNWOWnUl6Z6f/QYBRxR5ujtTRb
         2mqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739962972; x=1740567772;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o06HkSE3yrEb6kTJ1G6hMgP1ityNwB8Uh2xrUpzi7uo=;
        b=kqIq3jKEz3+ri+qwOyXK24vz0IQtlG0rNZ+mH6T49VYTvOKa8AJsXQcM7Z+gRj4PxB
         V7frWrQ0kWKePUipxxEpJcJxnYzIl7SKPdiH7KyrIK0OfjrVBgPBRA50TvUzUqep/w21
         smLQ6CWzya8TQhkW2KsTfBnhGD7um8CaXXUDTd6dMQPuTC/eLSAsySg7e9MEBhHZcTBZ
         guXMpqTdVamwBHQlcV9IVVv0fBPL2OfkScTiKy/ybQgDx7JY4LAACyP99B026vHB7P9H
         zwjjPF1quOwj5K+7bra1erj12jlEG7O/tYTUuEfdDK9XQbhJ9UPvnlw8MMXggAwq0xcV
         nLwQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5Dcwg1G/h3XB3EHMhDsr41butMvIDn6jlrcdhhVZWGmY3y0ALNbm41bn/kFKfQ7UgW6CFvaOnIUc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuuEOR0mtzQKcSQ3jT5FeeVkrPRdkAWcIHFsqjAhIvmqBZnwK/
	DeIbcbI5mVnxBQQ/fxxutAeLlxss425vyGQ9P8Ah8CSEXIOqwmQa
X-Gm-Gg: ASbGnctSMY5DEqlzmdpKUH4h6GdqKZ60r1O939cdnqlvAd9jGUbDSF2bpLpjx728/St
	BW9K05FFUAbdgV24eJ7WMS0gILkunTSF1kk8moQtSkmWUTfKIs6qCzgIl+msc44MRHXU9l5EKta
	1A3sAVsqfygkDYTyw97EpmW0QLuiHzbl17va0CxKXWQwwwIwyAC4AMiiTvyoUGE6byd3jL+sucn
	5tQyolzIfU0jnhuPUaohqq3u3Xait6XXo5d8GZL/TWZLA0PhKQUEtbQNRgchDtNGnn7VNNTC6nt
	5frtQaZ1MGl+OlBAisl74oewTwbYf+za/a4BksHlbA9j67eLzcHCtoUnOWuhJLU=
X-Google-Smtp-Source: AGHT+IF3SH/seGNxVtmdWwR0N83al1EGA91O7sPN34MBBVDyvgAL/wi6zlpcKelapWMWKYp7rLzEhA==
X-Received: by 2002:a17:907:80b:b0:aba:519b:f774 with SMTP id a640c23a62f3a-abb70df5d81mr1776881166b.52.1739962971717;
        Wed, 19 Feb 2025 03:02:51 -0800 (PST)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb96fa4d79sm599654266b.126.2025.02.19.03.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 03:02:51 -0800 (PST)
Message-ID: <04fae82f45ed33320e2d9618efca7ba1163c0121.camel@gmail.com>
Subject: Re: [PATCH 19/29] iio: adc: ad799x: Switch to sparse friendly
 iio_device_claim/release_direct()
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>, Olivier Moysan	
 <olivier.moysan@foss.st.com>, Mike Looijmans <mike.looijmans@topic.nl>,
 Phil Reid <preid@electromag.com.au>, Marek Vasut
 <marek.vasut+renesas@gmail.com>, Miquel Raynal	
 <miquel.raynal@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, Uwe
 =?ISO-8859-1?Q?Kleine-K=F6nig?=	 <u.kleine-koenig@baylibre.com>,
 Alisa-Dariana Roman <alisa.roman@analog.com>,  Marek Vasut <marex@denx.de>,
 Frank Li <Frank.Li@nxp.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Date: Wed, 19 Feb 2025 11:02:54 +0000
In-Reply-To: <20250217141630.897334-20-jic23@kernel.org>
References: <20250217141630.897334-1-jic23@kernel.org>
	 <20250217141630.897334-20-jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-02-17 at 14:16 +0000, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>=20
> These new functions allow sparse to find failures to release
> direct mode reducing chances of bugs over the claim_direct_mode()
> functions that are deprecated.
>=20
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>=20
> ---
> Kept this one out of the 'simple' category as it is worth considering
> factoring out the code when the claim on direct mode is held. I think
> it isn't quite complex enough to make that useful but if others disagree
> I can do so.
> ---

Fine by me:

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> =C2=A0drivers/iio/adc/ad799x.c | 14 ++++++--------
> =C2=A01 file changed, 6 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
> index aa44b4e2542b..993f4651b73a 100644
> --- a/drivers/iio/adc/ad799x.c
> +++ b/drivers/iio/adc/ad799x.c
> @@ -291,13 +291,12 @@ static int ad799x_read_raw(struct iio_dev *indio_de=
v,
> =C2=A0
> =C2=A0	switch (m) {
> =C2=A0	case IIO_CHAN_INFO_RAW:
> -		ret =3D iio_device_claim_direct_mode(indio_dev);
> -		if (ret)
> -			return ret;
> +		if (!iio_device_claim_direct(indio_dev))
> +			return -EBUSY;
> =C2=A0		mutex_lock(&st->lock);
> =C2=A0		ret =3D ad799x_scan_direct(st, chan->scan_index);
> =C2=A0		mutex_unlock(&st->lock);
> -		iio_device_release_direct_mode(indio_dev);
> +		iio_device_release_direct(indio_dev);
> =C2=A0
> =C2=A0		if (ret < 0)
> =C2=A0			return ret;
> @@ -411,9 +410,8 @@ static int ad799x_write_event_config(struct iio_dev
> *indio_dev,
> =C2=A0	struct ad799x_state *st =3D iio_priv(indio_dev);
> =C2=A0	int ret;
> =C2=A0
> -	ret =3D iio_device_claim_direct_mode(indio_dev);
> -	if (ret)
> -		return ret;
> +	if (!iio_device_claim_direct(indio_dev))
> +		return -EBUSY;
> =C2=A0
> =C2=A0	mutex_lock(&st->lock);
> =C2=A0
> @@ -429,7 +427,7 @@ static int ad799x_write_event_config(struct iio_dev
> *indio_dev,
> =C2=A0
> =C2=A0	ret =3D ad799x_write_config(st, st->config);
> =C2=A0	mutex_unlock(&st->lock);
> -	iio_device_release_direct_mode(indio_dev);
> +	iio_device_release_direct(indio_dev);
> =C2=A0	return ret;
> =C2=A0}
> =C2=A0


