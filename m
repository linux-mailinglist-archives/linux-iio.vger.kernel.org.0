Return-Path: <linux-iio+bounces-13029-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 555D59E2B1B
	for <lists+linux-iio@lfdr.de>; Tue,  3 Dec 2024 19:40:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC5D6B25416
	for <lists+linux-iio@lfdr.de>; Tue,  3 Dec 2024 16:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF67B1F8937;
	Tue,  3 Dec 2024 16:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Nxm4MYrK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5ED1F892F
	for <linux-iio@vger.kernel.org>; Tue,  3 Dec 2024 16:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733242565; cv=none; b=T2ievx6H9AmGx7oKE9SPIJad1qA20iEht52NSo4T8rKGujmHvcq25CvzMHms3LslpfSi3aNsOnanpzpsxUtNPdtuhf2s9qsH7cmTIiWj9nCmmGs8928H8HLrtQ3f1aPT4IDhN1SuJFTl7613oCC28XV2jpPtX9omkCCCa02XB6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733242565; c=relaxed/simple;
	bh=WixNact2m+y3fhZWn2jDvcKvjy8Jc0K/KP4xDkW9sEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZsS2OrYBhf9vQ5kAbElif859ys+AhWu8IajdmJSVC7xoGF0pVjPh8mnPsTYBWhhh3NpsS/zJ29STKZd4MqOPC3nrfcmWzf2Zy20rRKqxM+Oq/toCsddfBxIAb+DHdftm2eucBzjttCBGp8I+X34WgMkvOmGG6W38DVxRCBUv41o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Nxm4MYrK; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-434a852bb6eso52847255e9.3
        for <linux-iio@vger.kernel.org>; Tue, 03 Dec 2024 08:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1733242561; x=1733847361; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YtvdZ/7vzo6DmzrArlRb8GlNSqicD26fdNNlkOaFwXA=;
        b=Nxm4MYrKk0kRKVpa84dl985BPZVLMhLAJXgsQuMsdWRkGtjkbWDoqUEP9VbQ2F84rz
         fAgbEKXin6kwfayaONRqukYNL6/dmBNZi6JhxDS7zd66fb0UyspL4kFGD+6jpo41htA9
         iNkuGRkmTtgfxb03GtPNGVJVajbYXCj8mpBh6/XDW4mWVsO9SjeRYCcu47Gm3SPkPmcR
         c78ZTtEcB7SVVNnbPMVeAeEd/bOMUF4iThd47lAqHSMlyktJaCjiLGWdbpb0+1T1gMsV
         XGdfarXGNwXb95fmGAFZCMl9HGpNryGG8Mow+rw9qbb+MwxSJbYlD+7asivdkKoUbnFH
         EKdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733242561; x=1733847361;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YtvdZ/7vzo6DmzrArlRb8GlNSqicD26fdNNlkOaFwXA=;
        b=sc8xAuIoLurbYtWBSdRPFK0SNOoZYuugpyqiJlGAVKWKLLGuRoX8PzA+JzJepan71t
         vUazKyNycE23847R4w2fHoMvUCA5cdEmeWS0Ta1ZP8SNhJMIa8NxV2DR626De3ZnIOjY
         VtVw4up0sHajHcH0/2lB4H9mWFbRVY6SKlOqEZshrmpN6XMIVy14HLKd7oxp5OTz4fSL
         ZlaufkjqXint9OHlWoKuMyLG4QJQTBbKcDOSJ8Br488KHl5EOZnkDQT+iStjfcD2gqq0
         r6Oj1duzdiqvGPe/+hOcReuQ8LuTVqZIcOkPFLNB1aeohQICrvJ4jIEgi93Ip8cq+thY
         SeKw==
X-Forwarded-Encrypted: i=1; AJvYcCU3v0Dz0Ky4yatKcT+3Zbe7gEaT7lTziCDLuzaJBUEHnWnyf0KCOUBbzOG+/HeiEXqlhA6EK1U7wAE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb9ZKW3WC3AAJx8XW7Yx2GqH34ebvRWQOGxKWXHhLCOzKVD25N
	51cNtkee4nPoUCbiFoOSM3g0nhgqxq59HoVtsIQECk4KDcr/k5AsWaUGJlZRxco=
X-Gm-Gg: ASbGnctU1S8P48ylIQqEqrwQsLJ8tCWfBhtG/rhudMUMH3FOBoloXhlBaJ0pxgDNVwI
	3th9xSwA+Ejk8X2NP4cLBjoMVIlwI/pAwMCdlfL/bzAOfRSbevwgFPIYcqZwH0Jf0LgTIEpXklf
	MKWB3bEy2/+RXyp2yMajKdI7tXTUzlNm09Zf3LACgma42YIHWlMpGbYUrF0mi2+Z0tQGXG7Zb6r
	TmEGsbSl7YGl7ipZ7k4uoDue+3RZnliAz8i5wEWUSfkwcotDI79u/zjThKh+aIh7YSF/6SSz3Wn
	Hc8Y
X-Google-Smtp-Source: AGHT+IGqLyepfybGAfnAR/V1TUqcZgJxa6yniZmbf/mB5pq5+soJWQQ5V+vDDb+r7cmDPKc/Bqs5Ng==
X-Received: by 2002:a05:600c:3aca:b0:42c:b187:bde9 with SMTP id 5b1f17b1804b1-434d0a23a76mr32137195e9.30.1733242561421;
        Tue, 03 Dec 2024 08:16:01 -0800 (PST)
Received: from localhost (p5dc6838f.dip0.t-ipconnect.de. [93.198.131.143])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434b0f7dccasm193628355e9.43.2024.12.03.08.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 08:16:00 -0800 (PST)
Date: Tue, 3 Dec 2024 17:15:59 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	linux-iio@vger.kernel.org, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Alisa-Dariana Roman <alisa.roman@analog.com>, Renato Lui Geh <renatogeh@gmail.com>, 
	Ceclan Dumitru <dumitru.ceclan@analog.com>, devicetree@vger.kernel.org, Nuno Sa <nuno.sa@analog.com>, 
	David Lechner <dlechner@baylibre.com>, Alexandru Ardelean <aardelean@baylibre.com>, 
	Trevor Gamblin <tgamblin@baylibre.com>
Subject: Re: [PATCH v5 08/10] iio: adc: ad_sigma_delta: Check for previous
 ready signals
Message-ID: <wfcqlw3xqs2farpvkn3jjlot2bhmsgfa7lfpyzrjwuwuininsn@ni5rcnm3zdxs>
References: <20241203110019.1520071-12-u.kleine-koenig@baylibre.com>
 <20241203110019.1520071-20-u.kleine-koenig@baylibre.com>
 <CAHp75VfuTRDAjOD73re8tCWWJsAFUq_P6hPiPd4j_mOFM8oKGw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rwpeo23tj5zjazvl"
Content-Disposition: inline
In-Reply-To: <CAHp75VfuTRDAjOD73re8tCWWJsAFUq_P6hPiPd4j_mOFM8oKGw@mail.gmail.com>


--rwpeo23tj5zjazvl
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v5 08/10] iio: adc: ad_sigma_delta: Check for previous
 ready signals
MIME-Version: 1.0

Hello Andy,

On Tue, Dec 03, 2024 at 03:10:30PM +0200, Andy Shevchenko wrote:
> On Tue, Dec 3, 2024 at 1:01=E2=80=AFPM Uwe Kleine-K=C3=B6nig
> <u.kleine-koenig@baylibre.com> wrote:
> >
> > It can happen if a previous conversion was aborted the ADC pulls down
> > the =CC=85R=CC=85D=CC=85Y line but the event wasn't handled before. In =
that case enabling
>=20
> Interesting use of Unicode, but I suggest to avoid it when it can be
> avoided, i.e.
> using the notation of #RDY_N might be appropriate as that is how
> usually the HW people refer to the active low signals.

Usage of =CC=85R=CC=85D=CC=85Y has the advantage to match the reference man=
ual and data
sheet. So I tend to keep it.

> > the irq might immediately fire (depending on the irq controller's
>=20
> controller

That matches the way I spelled it. Do you mean s/'s//?

> > capabilities) and even with a rdy-gpio isn't identified as an unrelated
> > one.
> >
> > To cure that problem check for a pending event before the measurement is
> > started and clear it if needed.
>=20
> ...
>=20
> > +       data =3D kzalloc(data_read_len + 1, GFP_KERNEL);
>=20
> Yes, I know that's not needed right now, but would make code robust
> against changes. I'm talking about using __free() here.

Given that I expect this commit to be backported to stable and

	$ git show stable/linux-4.19.y:include/linux/cleanup.h
	fatal: path 'include/linux/cleanup.h' exists on disk, but not in 'stable/l=
inux-4.19.y'

I'd not do that *now* and in this commit. But in general I agree.

Best regards and thanks for your feedback,
Uwe

--rwpeo23tj5zjazvl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmdPLrwACgkQj4D7WH0S
/k7GtQf/WLRJuiDJjBrL+ioPppHhMv5FrJDKNGh3SEGqj3GW3kPG+jZmED2eXHjC
Yy0q0+aNFUoAF4kCoX7JzQ5cvV24KOlWEw+TBuBvShfAb8ETb9c/oNMy+XTnmoIq
HlfEE0wcw1LNi37QrU6DOXsMJbgmjWTmQblipw3TiBMqEpNE+IxAT+A51HnwEKjU
cUMCT52u4HfIIGvNe9DtdNgnBJoj6df5gJsdmLMS/+pRLygBQyu3YDdcW4Jpm5j+
vr5AQYlftWjhASQvXrgybX51d1d2+8D1lNPQnEuccIPuKo9H/GfVczeE2+cE/VDZ
+4424qAunwN3Qmg33xnyBREBgE9O5Q==
=GrM6
-----END PGP SIGNATURE-----

--rwpeo23tj5zjazvl--

