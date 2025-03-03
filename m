Return-Path: <linux-iio+bounces-16257-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68254A4BD6C
	for <lists+linux-iio@lfdr.de>; Mon,  3 Mar 2025 12:07:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C566C1896AF9
	for <lists+linux-iio@lfdr.de>; Mon,  3 Mar 2025 11:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F7C1F416F;
	Mon,  3 Mar 2025 11:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="MbLunlwK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99281F3BAC
	for <linux-iio@vger.kernel.org>; Mon,  3 Mar 2025 11:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740999863; cv=none; b=d2MeRnxpOiL2ycTOuWXoDSSGnsxtmkDKDsXQtsYNfKumltN52NZzbNshghWLHjBBm1Lhd+6YW2jqihpdMdr9velzPZEM9ey01eSNTmLSLKbpnsxoA/ZSCRk7OmzM/OfUyffsq5Y/yGRvBlcWiNwLmwJblHikGG2fvnHA1h7aPpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740999863; c=relaxed/simple;
	bh=DRrqRG1sz94QpOgCCsdHNLn/UQaTMpo9UGBqexq3zwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RlDvGNdVa9pCio4sanelEid2tmZFTfZf7YoYclGnM/N1TUgQdcnADcCNH8Gx2dI1qcrjfNcEQV54Gz0CGfIPUXKZ/ndrCvtVWCecjQl7LO/jyz0jWV9MrhHtBebrgE8Q3Ba+6F4ZOB7rw0LwefxnpBEhsfwMS1/9J52/X9OuNy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=MbLunlwK; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43bc30adad5so4192505e9.1
        for <linux-iio@vger.kernel.org>; Mon, 03 Mar 2025 03:04:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1740999859; x=1741604659; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZJlHDaI1NdPXB9ejhaiB5SWRNeTNxWQZYuTIRnZvcfI=;
        b=MbLunlwKouBR5nuK9ESMqUTtsSQM1ADpQo9YX6pHZsbvdxeK9cwbwyiDkq9opltTk4
         Y7+xGbNz4R8VbE+WsUoYkdGKi5cXk6U4jerEYB0cQARfCyCxhF/1dvgeB8KIGy3VN6pi
         w4XweQa4FUtXBPQ2fTl0na2HxeLxZ3JqCSz2oUlCfYQlF+fUM+Kjhev0mRPKwCtegcKn
         WB5jS8uRc4HpyRN1yyWqXjahb41dMb8cZXuHLNWOGTSlUqvD61aWZOnoFDcmRsYPb0nI
         oPgMM2DEc9f4CgjwlfwdVBE605oSpCU1x3fEVFkKrQ7iMuvwuUVB8yOwmxiv9rLT4J45
         o9PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740999859; x=1741604659;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZJlHDaI1NdPXB9ejhaiB5SWRNeTNxWQZYuTIRnZvcfI=;
        b=dJVeG9lfTjhpcDQdxYXNb6sXyQLB/C9kCksPBABxUvZZev5C2cAWWc5f963hBN4T5o
         jyt7UY+prdTJBgXniSlbcO45g28ioxT5GrYRg6BcX1TrZqzr0ZQJ5sF4kmU4Nt9lQzZX
         lahJLmVB462wc3fRN+Z6rr0/LYxXXpfXKqwyNnhpY4hlNnGtPnjJqQ9qOhcMhpuHUxoY
         tCcUFBoK2dh9o6lqBo8sONJASzXUP9jYpV1N2RsAN14zPgjHw7shkcEXayFfMfr4ICQw
         vmtQJuhGCy5SXHmhBkcMIsbWI/FSyTmEhltGSy/gX1EmV3MM11jpA2c/ZHdIkANbXEI1
         4duQ==
X-Gm-Message-State: AOJu0YzN511Fwox8g+AFOMPhKUNuKkbbQhK9XRzT4adtQ0vvaS0XymF3
	VjpdKqgrIRiUMaQLd8Fa7/F4kikL253xEc0Vg17MdBXktSULZCu5gedJJRT/oiw=
X-Gm-Gg: ASbGnctycIj1KQggahtRZMG1jzWsGUH5SQLmDzeM40hyEHRhzTGmUESIJ3p2lk/VKcq
	9iPhN/LFE+nsmqLPO+m6Emp4aF6qQoIDo7jzXoNKMBdQKDEEzKL3IiNHayCNtf+nmyRmegKFARt
	ftso/cebF2JG19QCz6e3xd65PB7Xj0x2UjzTnw+tSCj2cc/LiZkMK40JlrPqxwmwzuWEHx27csE
	x8sjeu6xcjn8OJhysXliWmzM6bckFT8LGmgtPMM2yWhY4aCdrPPJ36i8r5XLFuKMEBBIC0PFL5T
	NcQ1jVBw9UzFzcrtzidJpJ3tpWrzSdWjzl0lZdzHQWk3A25pxjUxI4MneWSYfJFs+WZiucJltmY
	Kl+xhkbdjkGNoQ7qvuHNHTSQfNg==
X-Google-Smtp-Source: AGHT+IHlbMr3M1n0KuyDa8FhRI4eQIyo19eTEHYnG4UWZYFLfQhibqux9WDQER4ViC5sDl+8RGMnaw==
X-Received: by 2002:a05:600c:1384:b0:439:9192:f088 with SMTP id 5b1f17b1804b1-43ba66e6f80mr105906365e9.8.1740999858958;
        Mon, 03 Mar 2025 03:04:18 -0800 (PST)
Received: from localhost (amontpellier-556-1-148-206.w109-210.abo.wanadoo.fr. [109.210.4.206])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e46f580bsm13949478f8f.0.2025.03.03.03.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 03:04:18 -0800 (PST)
Date: Mon, 3 Mar 2025 12:04:16 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	Guillaume Ranquet <granquet@baylibre.com>, Alisa-Dariana Roman <alisa.roman@analog.com>, 
	Mircea Caprioru <mircea.caprioru@analog.com>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>
Subject: Re: [PATCH 0/2] iio: adc: ad71{73,92}: Grab direct mode for
 calibration
Message-ID: <yaxameuld4iw6tqlc4spxo4yuenr2muxo4wlc5kxrewnc5jc7r@evpzlwh4j6qp>
References: <cover.1740655250.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kys7cxklmj3isrma"
Content-Disposition: inline
In-Reply-To: <cover.1740655250.git.u.kleine-koenig@baylibre.com>


--kys7cxklmj3isrma
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 0/2] iio: adc: ad71{73,92}: Grab direct mode for
 calibration
MIME-Version: 1.0

On Thu, Feb 27, 2025 at 12:35:26PM +0100, Uwe Kleine-K=F6nig wrote:
> Hello,
>=20
> in a patch series I sent last week
> (https://lore.kernel.org/linux-iio/cover.1739902968.git.u.kleine-koenig@b=
aylibre.com)
> a review comment by David suggested to claim direct mode for
> calibration and he also pointed out that this is missing from a few
> other drivers.
>=20
> These drivers are fixed here.
>=20
> Best regards
> Uwe
>=20
> Uwe Kleine-K=F6nig (2):
>   iio: adc: ad7173: Grab direct mode for calibration
>   iio: adc: ad7192: Grab direct mode for calibration
>=20
>  drivers/iio/adc/ad7173.c | 5 +++++
>  drivers/iio/adc/ad7192.c | 5 +++++
>  2 files changed, 10 insertions(+)
>=20
>=20
> base-commit: 66e80e2f21762bdaa56a4d63c79e5aca5f6bd93c
> prerequisite-patch-id: afd7caae7616d474e5a1a68e963828a88fa9cd3b
> prerequisite-patch-id: f5900fd31dc701cf190c7b451e0917e5b659f03b
> prerequisite-patch-id: 3c1b44d4645eee7668f543f0e9148c52337e1cd9
> prerequisite-patch-id: 9f600afd72914d22298067f86c1298d18cb335cd
> prerequisite-patch-id: 16607d29f72b649d63790b9c4c0852c089d27a1f
> prerequisite-patch-id: edc1a70e612a16ff5a72b05741beb02f874c7d1b
> prerequisite-patch-id: 4370980539a471328b354e94529da4dfe915b573
> prerequisite-patch-id: 0bdad93ca4dd031c335799abdbf6c93e36f27dcc
> prerequisite-patch-id: 4aa927f0072026df1ad9627a82f73b45250ad950
> prerequisite-patch-id: 027c26bf1a9c762ebb9828682a61537051835cc4

Note this is non-sense. The patch set applies just fine to
66e80e2f21762bdaa56a4d63c79e5aca5f6bd93c (i.e. iio/togreg from a few
days ago). It also applies fine to today's iio/togreg.

Best regards
Uwe

--kys7cxklmj3isrma
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmfFjK4ACgkQj4D7WH0S
/k4GBgf8DjTMj1BuZDkonToYUpbMnADTDDJN0spwa4LyIIMOwaZma4d6YtyrWIe/
jNV3nnndZa0YhuVAf4Tnw+PyezLNKHQOX+xOykIkJo6PZsI7TcFrCcLKPiCtPrBq
Ira+nNuivTHrLZkx4MfqUgVfzfIBY15vbajdfnk9gxiwQ0OVUaVKa9SRQRmfrARm
J77LZBEC+fA0RGafHkjgzst6X9zI9TBoQEwPbmUBFjmc2y6BqKFrq0qTM24fwSYh
cAIY1P70SFS9LKD8mmSGmF6hp1CteIJggK1dgkwPe6GvpA3mxD5RuqsagKgfsuWG
QHPPPz0Rdtc41j3yDgw9K1yc3T26KQ==
=KnkE
-----END PGP SIGNATURE-----

--kys7cxklmj3isrma--

