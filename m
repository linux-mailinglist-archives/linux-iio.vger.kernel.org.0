Return-Path: <linux-iio+bounces-15772-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC332A3BC5C
	for <lists+linux-iio@lfdr.de>; Wed, 19 Feb 2025 12:04:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7631E16A74D
	for <lists+linux-iio@lfdr.de>; Wed, 19 Feb 2025 11:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 146001DDA20;
	Wed, 19 Feb 2025 11:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VGl/Gd1C"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4BB286291
	for <linux-iio@vger.kernel.org>; Wed, 19 Feb 2025 11:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739962995; cv=none; b=ounVsx5X/aDR2GmwCxMPL0Bf/uZOJa+aKHje0s7tCLvHlimc+A33rzE52qtqDUf3YRRcklzyhjhmN/NJqMlmXDpzpaiWJB5v5/099vyDh12Ll5n1bUSJVOpAtkGURhKhq/maYZObVo8gR/bGutM++bO/eF9JC6/7hcBKdTJyFd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739962995; c=relaxed/simple;
	bh=nB4+tadQ3qHMZ4gAdKrs5cQVCPV9gn5Bu+bf25EeUVA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mvqEpvAbMFJJvjQJd3Q5ZoxaVWMv9OMtJS+UpH7984pB1pBjqh3r/pEaNJ2Pzpp4YKPI95m2fed4VJAo7HRbDFlamYoi8bIgjjmQIvCXkYSR2jPOJTLxHkX6BiynTP8q3f2UJsbxtRMX5ULhbbl4ikkAJj1N73kTOM7MEj65D1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VGl/Gd1C; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4397e5d5d99so21052465e9.1
        for <linux-iio@vger.kernel.org>; Wed, 19 Feb 2025 03:03:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739962992; x=1740567792; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Bpc6EsKRAAbuDPOxcTSNeJStRoXLYJMDAOweCZK3DIY=;
        b=VGl/Gd1CbTavECmWOuBn3K9xio+D0qRson/Dzl6JnmvwKcRsX38ND9Nyrhuo1a6G4w
         K6ZUgN6XZma68V1gn9fGC/pbh+kappUGbyLTqXM9/viKOKsGGnLXff0jYHLLQWfY6mHH
         33t/ukLTckEtCXjdLtvaHi2WqX7lB5AbN0m3hOQQAcUs4UTWz7CYyqUOFresHHazJQ8A
         0RI9UbCjUSnIpFhylFsyf1rNvJ6a6rG5edB96ccRl9HG7IuB02kQ90H3e1o5wAkV/g6t
         ns7H7D+RusXH6B56ecwXpWBleAbD3HH8GzAy6UsHs81O3Au8/QHeMEevsmo8cR8KRkuW
         jp5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739962992; x=1740567792;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bpc6EsKRAAbuDPOxcTSNeJStRoXLYJMDAOweCZK3DIY=;
        b=H05xIdkyBwvLZXmGy2j4ll0Trt4IIxJ1QuPznKNg2oXhxLo+khViwE5zf59FWK6Uck
         0SfPhg/4r/TrUZ3EO/H6M72yhXTAD3lXll9Upmrt2A+OwlcuroMI/zIRBwDQFbC0zWte
         8/+ljCzInIha5RrPGbIh3Nj6Gv79TE0RgiP8HZusifSqQdTI1S/V76NekGPKc1dnCTuv
         UMeqrLc4Cu/zQi4KGZPgG1vA3/wqORhLJKaBYoxyq0ARnCMw5R6gLoQrq1XLxqDUCfVr
         rxprihV0wm/6XyxkolTTFfF02pc4GBy1rjH3chfJYJgC3S3Yf+ZXN3M+EYwj4xPWQwB8
         HvDA==
X-Forwarded-Encrypted: i=1; AJvYcCWu5VslsNnYCbTxboVsxxGUxnOnKNKyrK3Pm34FWa89pMPY27A1JcpgP0rT6JA82AALRB0au1wIR4c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+PhBN5xBjBRc9pYFoPz9syqXf97UuAQ8Vjy3zpEv/mq3T1f4E
	tNrlEsl+m3T9Z5we2PkUyIcFfX/MJeOd3MRQhRQ/oGyAEcFVHuB0
X-Gm-Gg: ASbGnctIlvO+/1wpiH7Z1+Nvvin/QjjsJw5p6ZTNclbTLGWWb97xH8iJBdTEhapM0hN
	b1HrbfZlGKfMMOgFfmjGPDWOPMCyaxsxQ3hTYE1tH3QV2qkkAJ5e9tT8JnKURTCWLl0tY5yqbUH
	KeA6jR0GnbMXgG+uUPeizvCw6ZRExBZ5UTXP8lDrhrgBgZQjNPnMFvFpWciITE1jxb2XcykDWL3
	p12HJrkriWG7B3aJdE3Ipor9YdWo8D+TQRycowfjcqMysdON6ul2Z6pCtfjWj94J2lkSh6XZCGu
	m5PnPjUYIKczb79EzQ1B49+0c/q/vFefzreDV2sB3vzOUVJtXPCBX1PsrArWwBo=
X-Google-Smtp-Source: AGHT+IHL3ReJcT149LYENWp0Lj8XS4AB2s+Jdx40egC2grZMZtgrlB7oGkL/zLzb4/eVmv9iSnUypw==
X-Received: by 2002:a05:600c:3ca3:b0:434:eb73:b0c0 with SMTP id 5b1f17b1804b1-4396e6d4b6bmr178827655e9.5.1739962992222;
        Wed, 19 Feb 2025 03:03:12 -0800 (PST)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258b4118sm17991223f8f.18.2025.02.19.03.03.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 03:03:11 -0800 (PST)
Message-ID: <c51aa613f1450857455521c286b257b0890b4046.camel@gmail.com>
Subject: Re: [PATCH 20/29] iio: adc: ad_sigma_delta: Switch to sparse
 friendly iio_device_claim/release_direct()
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
Date: Wed, 19 Feb 2025 11:03:15 +0000
In-Reply-To: <20250217141630.897334-21-jic23@kernel.org>
References: <20250217141630.897334-1-jic23@kernel.org>
	 <20250217141630.897334-21-jic23@kernel.org>
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
> This is a complex function with a lot more than the release of direct
> mode to unwind on error. As such no attempt made to factor out
> the inner code.
>=20
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
> ---

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> =C2=A0drivers/iio/adc/ad_sigma_delta.c | 7 +++----
> =C2=A01 file changed, 3 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad_sigma_delta.c
> b/drivers/iio/adc/ad_sigma_delta.c
> index 10e635fc4fa4..5907c35b98e5 100644
> --- a/drivers/iio/adc/ad_sigma_delta.c
> +++ b/drivers/iio/adc/ad_sigma_delta.c
> @@ -386,9 +386,8 @@ int ad_sigma_delta_single_conversion(struct iio_dev
> *indio_dev,
> =C2=A0	unsigned int data_reg;
> =C2=A0	int ret =3D 0;
> =C2=A0
> -	ret =3D iio_device_claim_direct_mode(indio_dev);
> -	if (ret)
> -		return ret;
> +	if (!iio_device_claim_direct(indio_dev))
> +		return -EBUSY;
> =C2=A0
> =C2=A0	ad_sigma_delta_set_channel(sigma_delta, chan->address);
> =C2=A0
> @@ -431,7 +430,7 @@ int ad_sigma_delta_single_conversion(struct iio_dev
> *indio_dev,
> =C2=A0	sigma_delta->keep_cs_asserted =3D false;
> =C2=A0	sigma_delta->bus_locked =3D false;
> =C2=A0	spi_bus_unlock(sigma_delta->spi->controller);
> -	iio_device_release_direct_mode(indio_dev);
> +	iio_device_release_direct(indio_dev);
> =C2=A0
> =C2=A0	if (ret)
> =C2=A0		return ret;


