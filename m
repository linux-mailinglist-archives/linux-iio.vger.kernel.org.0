Return-Path: <linux-iio+bounces-15765-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14986A3BC2C
	for <lists+linux-iio@lfdr.de>; Wed, 19 Feb 2025 11:57:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6FF31782A7
	for <lists+linux-iio@lfdr.de>; Wed, 19 Feb 2025 10:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0484C1DE4FA;
	Wed, 19 Feb 2025 10:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lw/Toe6s"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326C11BCA11
	for <linux-iio@vger.kernel.org>; Wed, 19 Feb 2025 10:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739962617; cv=none; b=Nkme9R2n2f0XT2S1m3gR5e7AVoc3HK36SKGCm3Fc8IZKpVfgTumZS623qqIaerKgrb8l+PufxQBdv4vmS4v77E8ph4p5TzFEhTw1zKopKv5VcXONoWwUimE38CDxd0l6iCVMMlhxmn1KBxV4Y8QCksbcmUu8331COUbtq6qrdOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739962617; c=relaxed/simple;
	bh=OxnJlKD44RNYAQTLKNKq+D/HFahGTeioDEo8SNTdNnw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dsWsSrscbA6dhV7L3SiFyU7+ayS6DIf/HbIn7IBYJ5KQOllCOAiil5mfmd4SPGJjiPEx5iZsxCu7OVrkEUpBAATdGRzamMc1yjIarEK7MZvdAgN6IAhNf6AjaEy5AmydhzwpOg607dA/anEw6Gv0/iNwvRItWllNEoOk6P27H1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lw/Toe6s; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5ded69e6134so9965486a12.0
        for <linux-iio@vger.kernel.org>; Wed, 19 Feb 2025 02:56:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739962614; x=1740567414; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HccqyeYT+Kcpk4lbP7bYo+X9uUbtb0Sy0gpruCAjdU8=;
        b=lw/Toe6sl+ulVEUkeNQ6DC3rMxqqup1VwG2mEPt5DESSiuJGlwh1gFkUILfiWrWI+l
         0RtmNwhvdHnKsqh8+oZ9iZn3TtMskr1PdoESiM1QaKcfCjWGM589DJ59TtBuwn6+vfJb
         +jGCPre0Xcmof7nyyZo9vMxLiyAye2uTaZovUrKVXKZ7bs2gIBxwZ478ZTsCgZJJ3Zmh
         xEPR/ibvS5B+FYAJ9QibbQHZ1VynIZWB2FIx/iT7P1Qo/aY+54CmY/NqSzsF8oflzUYu
         ESVOunDFYeZ+2cCCAucNdjrCtattNE75Xvjc8YscCLY4g9bxkDqGAIOCMin8BXxcm/Yn
         VWEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739962614; x=1740567414;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HccqyeYT+Kcpk4lbP7bYo+X9uUbtb0Sy0gpruCAjdU8=;
        b=UZHplSmIPe+RtHK+mGlh3TFalByptuobLPueaBrAxE5skWZcndl2i8ub42CTf7VU4w
         o3FNBMfCDpOw0MzNYPZVnt/Eb0R2aJW4Pe5tcvqfv4hMbw/SDk8raVHmm7C8KpzlTxXL
         UGrQYXdQnI4t4w8kTERSCDIXM3B4XFFFkR1rf0E10RyToltfeQelZBE+7UuzQI0EmfGw
         oY1jnznF/eEObIJlUWOCtzEjHzTwzfpBBL+zm8+zzwAY1B/GrVx/mBasEqTX9YZgCmWh
         qFMTJ25k8nTtIGVfWQXyGfK6aeCoa4cBTrbCDJq0yoRbZFZda1ZM4YqIgRv6mHNHtajE
         a7Cw==
X-Forwarded-Encrypted: i=1; AJvYcCVhy0wxPyP+oHsJbOiFftTt63gcolZxkdpz5lX9M07/xt3oZAFJEdv/PHb+AkRw2ITWmkr9WpEzGL0=@vger.kernel.org
X-Gm-Message-State: AOJu0YycBsafVNQ7R97HA7oXeZWYskHKC3/hN4UYxrVI2mLhpIegU98K
	eDfO1rISs25LPPvXQMjexYznyIMhLUAQ311L1YZZFjwDKrNZT9UE
X-Gm-Gg: ASbGncsCGlukh/yKkUS5iU7lKPnTZmpYsFc4sCGBFEitmlPOIcu5+v/waGNPPZuGp+t
	vxTFZLmKKulM6EjT5iDx92a4lj75taCvVN9+O3qYFnrcIiMTC/kdh38ONiYSY8B/bW2dOrOtk3L
	8mPecXgPL/LJj5sC8Jwhw3UK7N0Z2+MmYM/rK3iJPOEj6mzyTgWGo8P1Ka3kLOwa5gRCFGmIeBG
	nQGTuHlRt3yYzdP8gmWz3gRq/8/qdk8pYTrIVRlj3NUcWrNwOzpJaRDMZnDux7L36ed+g+78NEi
	D0f7pNYFlexFabh6I5zYuslLf0VtIXpuY8L1jU0QzbQeLZgPSWOhgqgpcEwXf44=
X-Google-Smtp-Source: AGHT+IEw1HoTpcfHgLStDwseeS7KEtDT8oRcT2niHeSKxioEokfd54D02UHOjevt6xb/vnpTTSq8kw==
X-Received: by 2002:a05:6402:2347:b0:5dc:cfc5:9305 with SMTP id 4fb4d7f45d1cf-5e089cff4bcmr2891247a12.25.1739962614315;
        Wed, 19 Feb 2025 02:56:54 -0800 (PST)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ded709a92bsm9206906a12.63.2025.02.19.02.56.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 02:56:53 -0800 (PST)
Message-ID: <92eca484b407a5cb22cc998db0892181f89f148f.camel@gmail.com>
Subject: Re: [PATCH 13/29] iio: adc: ad7768-1: Switch to sparse friendly
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
Date: Wed, 19 Feb 2025 10:56:57 +0000
In-Reply-To: <20250217141630.897334-14-jic23@kernel.org>
References: <20250217141630.897334-1-jic23@kernel.org>
	 <20250217141630.897334-14-jic23@kernel.org>
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
> ---

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> =C2=A0drivers/iio/adc/ad7768-1.c | 7 +++----
> =C2=A01 file changed, 3 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
> index c2ba357b82d8..ea829c51e80b 100644
> --- a/drivers/iio/adc/ad7768-1.c
> +++ b/drivers/iio/adc/ad7768-1.c
> @@ -365,13 +365,12 @@ static int ad7768_read_raw(struct iio_dev *indio_de=
v,
> =C2=A0
> =C2=A0	switch (info) {
> =C2=A0	case IIO_CHAN_INFO_RAW:
> -		ret =3D iio_device_claim_direct_mode(indio_dev);
> -		if (ret)
> -			return ret;
> +		if (!iio_device_claim_direct(indio_dev))
> +			return -EBUSY;
> =C2=A0
> =C2=A0		ret =3D ad7768_scan_direct(indio_dev);
> =C2=A0
> -		iio_device_release_direct_mode(indio_dev);
> +		iio_device_release_direct(indio_dev);
> =C2=A0		if (ret < 0)
> =C2=A0			return ret;
> =C2=A0		*val =3D ret;


