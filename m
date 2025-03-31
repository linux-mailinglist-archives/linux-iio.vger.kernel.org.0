Return-Path: <linux-iio+bounces-17470-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55DD1A766F8
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 15:38:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA5A21680DC
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 13:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7B6C1E5B67;
	Mon, 31 Mar 2025 13:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="FMmiQJn/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0331DFE0A
	for <linux-iio@vger.kernel.org>; Mon, 31 Mar 2025 13:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743428323; cv=none; b=HkdL/VGrXXDe5+my9aM5pCQpkoS0sjk02sQZxZItaTWzfHEqX0jlwkg4O8TtWfbWXdINwkLU3SdckkXhie7QVBhW9/J2FxV8/b2nO7dBo3t59I/UexoyAgTRK9HxLMujtb4z6USGhtvzzC/hrEhWOgFsKRd0GOrzmjOs5F87zpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743428323; c=relaxed/simple;
	bh=V9C0kCsEJUtAnYIVSBMlNX8PWvKK6n59CdsCMggunTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sjQJEjIB/xLBpKysChd5kmbHUnGOXi3VBcZQzl1gB/nZQp5uTKtlBEEVTP/Pl+C5TW9mFxRSD/+K+cR3i4NVmmF0DXLaiRKfnPe2TycUA+H+zLRRY9yDIOLhInC9O2aEPTiYRLJ86UyhW+JREiqIyp6IwSIazOxWYgEu2dFazdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=FMmiQJn/; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3914bc3e01aso2525889f8f.2
        for <linux-iio@vger.kernel.org>; Mon, 31 Mar 2025 06:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1743428319; x=1744033119; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IByOBF1EgrKdbih9JrJPGD53q2iUTDQfFvW+v8CxoUQ=;
        b=FMmiQJn/BZtLqxH/i/W/Lm4AUH+eOruEp+z0aZF5PI5BaS6QJ72v1X5FoXbKfY5Jv1
         DVuC6Pu11O5b9kDubgRI/y73+JDTl5gdt7qJXXrlDHxXREaURqZX9Z0+J5LUpbrX9FPT
         o07Thyy7O11o8FrsQWr/QvSmMqRpZMdBMTR2Quuy1WnmDHLe7g4+YWtRkU+tymwE1VKY
         fdZkaV7x+xsxeG9HCWWTYA6spYoP/H6Xyi3SZDQgYDoSTkmGzDIdWfTDNuKSpghE61Zk
         2vYfyXaFgT5B5vyzUjrcXhUEPsLxWg9tx3al8eI6ZfgCeVV12V6PMJNAe/tQKolK0RTs
         iSYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743428319; x=1744033119;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IByOBF1EgrKdbih9JrJPGD53q2iUTDQfFvW+v8CxoUQ=;
        b=Ph0rWdwhTagvGWJ2PHcEBZsx2GZ6tQwfDQToCkauYJStn+t8PgqSyepIJV8t4puA2Q
         v35JwGDqv/tc4xK6IEdtU10Eg09rFVsKU+nb+zhGZXB7/D175T8oblCBKn9F/BMUQXYa
         0enBmIbw333GxKNDQQ3Q4ImZPr1wNs8hlRgDzUFxbQaxzzrfFwiFZS1I74VAZnKTuU6p
         dK7bn2H8UhFd91tKJr16zxoRK4B1ticMXGNy+OlWJk73X9wY81Nb/jibAAoq5PAXvt2G
         IQY8E1FIou+a7N/XTPkr7tT3UT1VsRNNw7T0kN9bzwYhzYH4wfUqzMFbm0aFQOeCEurP
         +Bbw==
X-Forwarded-Encrypted: i=1; AJvYcCV0RwATA/7T3VjSlPW3XHZn3qvXMGpwXaJdY8GG+pg4h+7WZ72O7BTuC5VepJDRviJpOAWcs9XNLgw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKMkWLwChgzugBT/RJI6bnmHCt5zfo9xOjXGPN6V5nsSVMBACA
	ynM85fpGo23g4TysptkASCcAglHpZpxvW+108fBIFLXjyersV6VyVoE5k7Ma8GA=
X-Gm-Gg: ASbGncvRw8ZtgcV6kUI8zd81SVqYesa9fg9kBvEbE84E3DR4ZPB1hSK3n02Y7sbeXqa
	QpJ5QCKDD7eDJxpqmzNph2oYS/k31wSCvSNjaVzwZIP/jHee4+4zHrxFdJvMoiZHTbZ5T4ED8ij
	Lb8Ywj26kTc7DxO/oXirAEKDMnQCf6UgbQx22ev4YbqHS9TBxZqfOvShmfkiakXNyYyAUs299vU
	H/dmjLZ1pDcxPGdHSt6aA4evvSNA+QuAxl72dRHrcBweKSU7SwsdDtg4uGCriZy7Iz0kmiz7q49
	JtI3/z8a/DKt+1ifXrhTqT4FUZwW9odaOut0G4iBIRMGs8+JR/evvCVuILzg7VZC8Q1u5LxnsKo
	hz8CET1K80d5MPebbWpJl8w==
X-Google-Smtp-Source: AGHT+IFpDpi0CNtxj5OpmdexJvlDTNapRUgjOtZbg7Jv7YeIaLJYPAIrY8G50RsmcGq5t965cBMWgQ==
X-Received: by 2002:a5d:47c5:0:b0:391:2d8f:dd59 with SMTP id ffacd0b85a97d-39c120e1665mr8570517f8f.24.1743428319068;
        Mon, 31 Mar 2025 06:38:39 -0700 (PDT)
Received: from localhost (p200300f65f14610400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f14:6104::1b9])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-39c0b65b4fcsm11522189f8f.11.2025.03.31.06.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 06:38:38 -0700 (PDT)
Date: Mon, 31 Mar 2025 15:38:36 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 1/3] iio: adc: ad7124: Fix 3dB filter frequency reading
Message-ID: <p23r6fxfbbgszqaew42dby5yjwio4xipdh3y47rr3wbso6fwcb@ej7ut3sruzoa>
References: <20250317115247.3735016-5-u.kleine-koenig@baylibre.com>
 <20250317115247.3735016-6-u.kleine-koenig@baylibre.com>
 <Z-RFaLU5jtOScJiu@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kinwsuus3eeov35r"
Content-Disposition: inline
In-Reply-To: <Z-RFaLU5jtOScJiu@debian-BULLSEYE-live-builder-AMD64>


--kinwsuus3eeov35r
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 1/3] iio: adc: ad7124: Fix 3dB filter frequency reading
MIME-Version: 1.0

Hello,

On Wed, Mar 26, 2025 at 03:20:24PM -0300, Marcelo Schmitt wrote:
> Hello,
>=20
> On 03/17, Uwe Kleine-K=F6nig wrote:
> > The sinc4 filter has a factor 0.23 between Output Data Rate and f_{3dB}
> > and for sinc3 the factor is 0.272 according to the data sheets for
> > ad7124-4 (Rev. E.) and ad7124-8 (Rev. F).
>=20
> Potentially dumb question but, how do we get to these factors between ODR=
 and
> 3dB frequency?
> Looking at Table 8, Table 18, Table 28, and=20
> dividing values from Output Data Rate (SPS) column by respective
> values from f3dB (Hz) column gives me 4.3478.

Using the datasheet for AD7124-4 Rev. E in Table 8 we have for example:

	ODR =3D 19200 SPS
	f_{3dB} =3D 4416 Hz

So it's either multiplying with 0.23 (as does my patch) or dividing by
4.3478260869565215 (as you found).

But having said that, a definitive formula would be nice instead of
guessing that there is a linear correlation between the columns and
determining the factor yourself. Note that in Table 10 the f_{3dB} value
corresponding to ODR =3D 15 SPS should be 4.08 Hz. The 5.44 Hz specified
there would be the right value for ODR =3D 20 SPS which is a value that
occurs in Tables 8 and 9, but not 10. :-\

> > @@ -301,9 +301,9 @@ static int ad7124_get_3db_filter_freq(struct ad7124=
_state *st,
> > =20
> >  	switch (st->channels[channel].cfg.filter_type) {
> >  	case AD7124_SINC3_FILTER:
> > -		return DIV_ROUND_CLOSEST(fadc * 230, 1000);
> > +		return DIV_ROUND_CLOSEST(fadc * 272, 1000);
> >  	case AD7124_SINC4_FILTER:
> > -		return DIV_ROUND_CLOSEST(fadc * 262, 1000);
> > +		return DIV_ROUND_CLOSEST(fadc * 230, 1000);
> >  	default:
> >  		return -EINVAL;
> >  	}

Best regards
Uwe

--kinwsuus3eeov35r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmfqmtoACgkQj4D7WH0S
/k4+hQf+J4xsAS7AdjAyqT5r8F0/5arEI8BBUjX0rHHa9rZSgUEVcLQO4No4cAHC
XADeSR/eGYkPYD/eJcRGQGFuQR6dGEwxBghe7i8ME01wFA+fNDz+ejz/qYTji1u3
7l9vtGsLTz5nA059TFfueXtrP8lB1MavrNx9kNiCNwFNpgybdHRmIrpaUlKrDcum
0AzC/Qfe+OIWFvwY6CHfS8LlFqKr4H+iuEZSJglhAosqsd/3DM4stJ18COzuFe7d
oDS/3A8bbEkstmpVWAKpXTrUjWLI00KvdGA/zGMZSAAsRNcrWRMCwcX/kOs6UkC9
YrH9FV22Ed5EWuyAeekZDAQUv3XMjw==
=A5Kr
-----END PGP SIGNATURE-----

--kinwsuus3eeov35r--

