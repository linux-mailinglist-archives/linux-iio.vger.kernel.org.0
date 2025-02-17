Return-Path: <linux-iio+bounces-15645-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B1AA38322
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 13:39:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D62C188B3B0
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 12:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 093C1219EA0;
	Mon, 17 Feb 2025 12:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="z8l0CR90"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41D1215F5F
	for <linux-iio@vger.kernel.org>; Mon, 17 Feb 2025 12:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739795905; cv=none; b=eqHXXBPv2sW1+5gyFXfTW7hVAtYsBg1TdanCgiiL1cwGNk4L6wpocR0AystnYosR++Qo7qK6N5MQpD0MaRNX+N3k73weTlgMJ18bYLo7s89MscYircaWm5ECEPNmbpNVQxMSYLttNBogAUSe0sTpWhuvvN5IRqfMALR0Z1eZ4Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739795905; c=relaxed/simple;
	bh=989kZF5hjUURs6JrwKokGvqFKbagot++H3To+3WIZnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NwOrmDlUwBY3yPDWj47A597B2WLll51z2t2/Fj37Kj5Anzp4likITM2EcqaoD1var/ac8SWjIHkoiONPvhxb1p4lJFB8vf4kc5ahi6MPMAwwdPYDWCzLrphK2XMhOnVo6GiejMwmlVsh5kZspERyNFmkQzr2dQmW3xbTiRHz7YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=z8l0CR90; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-abb7aecd39fso306922266b.0
        for <linux-iio@vger.kernel.org>; Mon, 17 Feb 2025 04:38:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1739795901; x=1740400701; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=989kZF5hjUURs6JrwKokGvqFKbagot++H3To+3WIZnc=;
        b=z8l0CR90jaxEjo2qECTL17ZP6yIoSBxKWQa+78LLzfEI9qOS3zu89VeMAV0gpeIh9Q
         0g74FIExPC2tCdchgWv+U5ZUdWMJkGvLSlA2z306GE9pLNOoxU6Ts0Q9vgh13L2emRyb
         o/kr0plN8zt53Yhs7ZrwBfavyAP5jeEAC8DGgeReb/ccgIgXy7i/LS8EmT/y+EWQF9q9
         ZNQ2Rf/NSft0U8j5Ug6XH84Xt/tbyglfgWGXPVvOIZrYc6dyRpMLTWRS95ft8UDCxgdq
         8ehkLv/pb8E6l1lZp1eLvGYHZ5vPeRJb7fuKRcuTO9LSWIwqBE0bGNl3t/r8ngiIwCTK
         UPLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739795901; x=1740400701;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=989kZF5hjUURs6JrwKokGvqFKbagot++H3To+3WIZnc=;
        b=myb2pHgsghFB7v53rR3Nqta5nheutqcEjiQSIXKtg+DO0iGCE6yWKis+WannTLX5eu
         6P3/OKLia+WCmU4DhfJEwK9a05z3DqLcguN6Q9avT8MUWT9EW6HwjrnqFi+zJuTsXT17
         d76rHk+VMGJiIZXh8khMXCa+fuiJ2GVXfqi5MbBLl2EXR6kvE6v+14TKdf5P9qoV5Bb8
         /plbo/v+ar3ASM1GGr4LkSYlQ3SDlNFg85ebwClAOuzjSWRuIA89wxx35OpAdzAfkvJg
         Nzz53aVLXtXagb9Yo9N4Oxr7XC9qcBBaVlfQXgL81TUtw3n2YGulOLN5zYIIDb3bJBbt
         ZKIw==
X-Forwarded-Encrypted: i=1; AJvYcCXt8M0snVMziM/5QpNITjQ0UOaKgmyTvCJl1f8B0UN77KVz4HTwORCHChGOyEDX130OK6IaKyRaQJo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw9er2E7zyYo/CiHnTygyNTAbHkpNMyZsUFCijB5dEd7SmRah3
	ogDPS/1EUzjcgdfOZjJKM3qNeDkMG+FWzf0oU4bQ5O4tEQk76l+ZyvcI/9sIa1ztAKcpTfhDdPd
	+8ys=
X-Gm-Gg: ASbGncvluLlRk68AjcwGAmFxN6nADoCooa5nvqBSQkPt3POgIalSZETBTS9C1OhNoCv
	vgRzJGmM8dv/jCWjShoMHyYFEhPTUfTyFtqRDsLDo6FYh/1zRi8fh0qMuUVN/S/q/xkX7eJMKJw
	62FGJwCn6rOUfh5tXqONXdUxGHMfIo63oLMAtHcIryo4JdG8MIw0yeFmph+noiCXkiTPGxQr2+p
	9OeI0HTlQdlM6IUw3Gdk054k1ciFnoY44MpangYzdMkLmAWBpsRhF+RK2dzgLBk6MKVQOd/bkK1
	vXrHXUC6aJuREkE3arUlI9lOslQiVCj/Dw7h4i1wtWhEXaZgXqprKz+h8g==
X-Google-Smtp-Source: AGHT+IEsyOurskpjMGa0Z+5pk2ktFuNwr/7zHM+P02RQ3PeErg+2PaEkg6+xutQlFDFhzkIAjkUYWw==
X-Received: by 2002:a17:907:9714:b0:aab:a02c:764e with SMTP id a640c23a62f3a-aba50fe9f48mr1707375666b.14.1739795900813;
        Mon, 17 Feb 2025 04:38:20 -0800 (PST)
Received: from localhost (p200300f65f083b0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f08:3b04::1b9])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dece1d354bsm7305537a12.45.2025.02.17.04.38.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 04:38:20 -0800 (PST)
Date: Mon, 17 Feb 2025 13:38:18 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, linux-iio@vger.kernel.org, 
	Guillaume Ranquet <granquet@baylibre.com>
Subject: Re: [PATCH v1 2/3] iio: adc: ad_sigma_delta: Disable channel after
 calibration
Message-ID: <qbs42lm4xn53tzcugvhtuao2xklz2kj5akmvmwi5mbqnkhtjzs@rl5tlo6elcxq>
References: <20250212105322.10243-5-u.kleine-koenig@baylibre.com>
 <20250212105322.10243-7-u.kleine-koenig@baylibre.com>
 <20250216163600.42211c3d@jic23-huawei>
 <slnxc6h4tkjzgjv7ory3xmhgzalyjtacde3lvgevaahjhcjg7s@jl55meuxwmvi>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2ybxokobwobnm3fz"
Content-Disposition: inline
In-Reply-To: <slnxc6h4tkjzgjv7ory3xmhgzalyjtacde3lvgevaahjhcjg7s@jl55meuxwmvi>


--2ybxokobwobnm3fz
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 2/3] iio: adc: ad_sigma_delta: Disable channel after
 calibration
MIME-Version: 1.0

[adding Guillaume who added calibration support for ad7173 to Cc:]

Hello,

On Sun, Feb 16, 2025 at 06:17:02PM +0100, Uwe Kleine-K=F6nig wrote:
> On Sun, Feb 16, 2025 at 04:36:00PM +0000, Jonathan Cameron wrote:
> > On Wed, 12 Feb 2025 11:53:23 +0100
> > Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com> wrote:
> >=20
> > > The function ad_sd_calibrate() enables the channel to calibrate at
> > > function entry but doesn't disable it on exit. This is problematic
> > > because if two (or more) channels are calibrated in a row, the second
> > > calibration isn't executed as intended as the first (still enabled)
> > > channel is recalibrated and after the first irq (i.e. when the
> > > calibration of the first channel completed) the calibration is aborte=
d.
> > >=20
> > > To fix this, disable the calibrated channel after calibration.
> > >=20
> > > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>
> > Whilst you said don't look in reply to patch 3 I ignored you. ;)
> >=20
> > This feels like it deserves a fixes tag.
>=20
> Maybe. The ad7124 driver currently doesn't use this function. And if the
> described behaviour isn't relevant for the other chips, that's fine.
>=20
> Needs some more research.

There are currently 3 drivers using ad_sd_calibrate():

 - ad7173.c
 - ad7192.c
 - ad7793.c

Reading through their data sheets and driver code:

For ad7173 the issue exists. The data sheet requests "Only one channel
can be active during calibration".

For the other two there is no problem. The .set_channel() callback
disables all channels but the requested one. (For ad7793 there can be
only one active channel, for ad7192 several channels could be enabled,
but that doesn't happen.)

The first commit that is affected by this problem for ad7173 is
031bdc8aee01 ("iio: adc: ad7173: add calibration support")

I didn't do any tests on ad7173, so my findings are only theoretic. So a
second pair of eyes to confirm my findings or even a test for that
problem would be great. Maybe Guillaume can share some hands-on
experience?

Best regards
Uwe

--2ybxokobwobnm3fz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmezLbgACgkQj4D7WH0S
/k5lPgf9H7QFREHjmXQVYQW5AE4Ez8qRMJlD5nhII3xBJWHbZsJoKu3QjqVw0vUZ
+MkvV2UwBkRcOFSMWLihrBIMeb+ihzFgetjqrxuuv0LcAgUSXRpOWVHLX3MYkeiS
0xDB3dsPHuMS6wAWPjNsGEkbViWQA5wRxzkrSS2fJB/OLfgYXpz5hLB2eX1+95ia
c7Y7xcEW+i986QFQpNIvFdS/HjH8l+m1UMZQcHHPIYtgfMlG4vllD2+lTzrt8QDH
ReZmR+kMtgNbA2ukKpnNnQU8TuRRqd05tloIGTtClySZCbAStI0GzjNRyc+qknAB
uvHCA+2MDv06DpHqTVsEusBXL7+edA==
=pjhR
-----END PGP SIGNATURE-----

--2ybxokobwobnm3fz--

