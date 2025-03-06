Return-Path: <linux-iio+bounces-16461-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7CD8A544F6
	for <lists+linux-iio@lfdr.de>; Thu,  6 Mar 2025 09:33:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 964BE188D78B
	for <lists+linux-iio@lfdr.de>; Thu,  6 Mar 2025 08:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F195620766B;
	Thu,  6 Mar 2025 08:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="K1DXdl/j"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839352066F0
	for <linux-iio@vger.kernel.org>; Thu,  6 Mar 2025 08:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741249997; cv=none; b=BJgPlnDkIfkxMJb572UAm6qFgCPjijmmKe06mpT4SvGGy01yXytupADIzh5nQIzHubWV3s2KD9oJ4+YFLwZ+UgGnNMV1cas8CdGMHUcT/i8e7cp/WkyCdR03HkJcdLYD5+F7IisFE36LYKIFusO+POcPJDBQTj4CiCvdYpc92EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741249997; c=relaxed/simple;
	bh=hOVOOStkW8jmkt+1hp/0Jr1VkM8lrszPOZ7dkECB3lI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LlLHwBcqBlCRAECrZ598BryDkw42BdkOKMx9bjxQBcxF+V2d6jwElZPKMoUbEFMuUj57vBRl2bJrkw9EQMTMapgOBaSHb5Tky0YBZ6QSpFOL3Z363phpdDW36rmD3voquZw9JDi0HrzfPip2s40m9NLq/cM0a7kGVBbJMHr5cM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=K1DXdl/j; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4394a823036so2914115e9.0
        for <linux-iio@vger.kernel.org>; Thu, 06 Mar 2025 00:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1741249994; x=1741854794; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X2EUc1x5Of7vZCQZZ48kByIEQAeOmgrKgZ4g5Ou9HIs=;
        b=K1DXdl/jLd3lGnBeY+6K9KDo21yVRKd5LmQj11MBIpiigiwvfdb750QwYnfKRzJRGK
         qV9NWLSPf0KRZoWxkP8ZYFda/IqEYR5RmQGV/zOqxdRf+bAT7k7YkJlDEnwCnEijE93R
         wHZM9bjjVTrGaeIrUmltDSGLVO9wKSO5fOa/PGum2mWO6GISIr66RbniGALJFr5qjZk1
         0x2Qj1pvqTxbZz2scScNIEiSsX65GpCrLd3kh7fcClJkyRl+mtUC52t18A0HUGo6/MxU
         Ukr0Oeh1+5hb+u/0jg/vKSkmXsFuE4IDJt1rP9zg3KstOLMH73vb5OzcbHIv325nvV6A
         JDCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741249994; x=1741854794;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X2EUc1x5Of7vZCQZZ48kByIEQAeOmgrKgZ4g5Ou9HIs=;
        b=OQFyjcEGzHM2gXqnrfpaiq/ND/NJi7iUtz23QL8ZwwBYFQv6JyG+HveigE/lj56UST
         57sBWHm1b6BuRjcuuDiZP4kr/VqkM2i52Xb7ESKN53nCOgvMEt+IGkU8/awLf6472Vcs
         IoaFEezclOHMFnl+n4GcrbK5AsOOQE+AH146Xq3PlLkw/0Wba6++o5NwAEcWanyX5P8e
         h9NkRcRJNABO54dCUozTAeSo31DKdMShdNbZgcVrX1McdJ7Qnv9rpA0pnAm0ZT+TeZP6
         n7pOc8yeJZ+XWYb/NPfk4aQPyOYyicRktrgpco1YNTSNYypgIwqNQQTsT16UMuwhD616
         jc4g==
X-Forwarded-Encrypted: i=1; AJvYcCUHLM6aLVp+JOjyAf28d6wETenufQTKVnOoxuILXUl3z6JNQHRofIVlVt6L/O7kEULjavZJhnXgFCA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDQ9S+q0ieCivlymv3j6DHztQGWmfugm1cg+qAA8a3eVskE1Ih
	QMZLUwJOqJicfizn0p+Jn1AEE2SgtDGd8aDEwaI74pMS+18nIqYc8419TzTYMq8=
X-Gm-Gg: ASbGnctN5Uy9R5jyPkc90eYWKO03SruaTok8fZC6NHq5hZZ0zKy0Rt01ouSowfhkzZ9
	NdS+TNsF8zeyQNdVlL5TzlmN4s8mL2+9M1TBtvyNSVf/HL6MbIv438cBOMcP8r+2u3mN5qXSquC
	DvN1maK1d5JcM6iGpmqDTN+WIXjzYHmW5fWO++4B+6V7jtEmjLMOGFyAgUylWnM64aREHkms/qI
	JpvgkQ4q8yrFfFBdHJiBv4jdm9FRvK6o/HRDfLXA2d6XLNM9YpOIso7OMwWOdGvSMH+ltJiBEKR
	2p7OgTxGai2VdModSvgLyeyLeJTSPBsfDrwvQ9CMoVO/JQAYVOaP51Wc4nPHMVN/pYOl5enAk+H
	SBVgnCjlDRrIg93gjRql0zvSsOw==
X-Google-Smtp-Source: AGHT+IENVLytuFM3iADZunJAXBOhvQ3LIEDZZsGeB1MuN2juBTFSeQk4BfBlXS8v8nNpLXWbNWI+2g==
X-Received: by 2002:a05:600c:3544:b0:439:a1f2:50a3 with SMTP id 5b1f17b1804b1-43bd29462e3mr49071765e9.4.1741249993713;
        Thu, 06 Mar 2025 00:33:13 -0800 (PST)
Received: from localhost (amontpellier-556-1-148-206.w109-210.abo.wanadoo.fr. [109.210.4.206])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c102e01sm1282552f8f.93.2025.03.06.00.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 00:33:13 -0800 (PST)
Date: Thu, 6 Mar 2025 09:33:11 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, 
	Cosmin Tanislav <cosmin.tanislav@analog.com>, Dumitru Ceclan <mitrutzceclan@gmail.com>, 
	Guillaume Ranquet <granquet@baylibre.com>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Michael Walle <michael@walle.cc>, Nuno Sa <nuno.sa@analog.com>, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 8/8] iio: adc: ad7124: Implement system calibration
Message-ID: <53jwjqqspaow6npy76vyhkz7stt6abkkwfj7hv7rs4dspazilv@54uua2bpcpk3>
References: <20250303114659.1672695-10-u.kleine-koenig@baylibre.com>
 <20250303114659.1672695-18-u.kleine-koenig@baylibre.com>
 <20250306000718.330c99db@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="braso36kgpzqa6iv"
Content-Disposition: inline
In-Reply-To: <20250306000718.330c99db@jic23-huawei>


--braso36kgpzqa6iv
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 8/8] iio: adc: ad7124: Implement system calibration
MIME-Version: 1.0

On Thu, Mar 06, 2025 at 12:07:18AM +0000, Jonathan Cameron wrote:
> On Mon,  3 Mar 2025 12:47:06 +0100
> Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com> wrote:
>=20
> > Allow triggering both zero-scale and full-scale calibration via sysfs in
> > the same way as it's done for ad7173.
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>
> > ---
> >  drivers/iio/adc/ad7124.c | 153 ++++++++++++++++++++++++++++++++++-----
> >  1 file changed, 136 insertions(+), 17 deletions(-)
> >=20
> > diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
> > index 382f46ff2b51..5ab0d3e48c43 100644
> > --- a/drivers/iio/adc/ad7124.c
> > +++ b/drivers/iio/adc/ad7124.c
> > @@ -4,6 +4,7 @@
> >   *
> >   * Copyright 2018 Analog Devices Inc.
> >   */
> > +
> Stray change.  I'm in that sort of mood so I'll tweak it whilst
> apply.  Rest looks good to me.

Ack, thanks for cleaning up behind me.

> Applied to the togreg branch of iio.git and pushed out as testing.
> As the fixes are theoretical(ish) I'll not rush them in.

Also Ack.

Thanks
Uwe

--braso36kgpzqa6iv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmfJXcUACgkQj4D7WH0S
/k7GMggAnd1NKiaoKhZmRgoFkNSYlKr3g05lRuBEs91JFvKNJxoV/UU0ZvqpGSOA
ecyBpb02lZ1gD8M95AciwtSSAtv8fRJLzvjtmN28A6W0w0ScR7TVvlCdf5HZZy4K
q8QQHWgLIBp508UFwdCqhLtsCD9UxjQROt7qM25CLj3u/x8qpNpIEpTEL9yHmaRA
NPssmTPPvd6Z/qSsxLel7QlDoYIyleuRwWT9CmD1FJ8SCKo7zcSLdnm9IAGBsn21
Jmv16gfyLeFrd7vwQs1G85Z4aPdwDhuojrjeEkSsy6LhEZl5quFCSb5rpmOT9xLV
w0hS+YekqIIB9SWL9wJweHM0xusgAw==
=C5a+
-----END PGP SIGNATURE-----

--braso36kgpzqa6iv--

