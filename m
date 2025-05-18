Return-Path: <linux-iio+bounces-19614-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A85ABAED3
	for <lists+linux-iio@lfdr.de>; Sun, 18 May 2025 10:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A402174E2F
	for <lists+linux-iio@lfdr.de>; Sun, 18 May 2025 08:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04883211A05;
	Sun, 18 May 2025 08:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=it-klinger.de header.i=@it-klinger.de header.b="Bcl2Gkkn"
X-Original-To: linux-iio@vger.kernel.org
Received: from www571.your-server.de (www571.your-server.de [78.46.3.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8EBE4B1E76;
	Sun, 18 May 2025 08:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.46.3.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747558239; cv=none; b=qpSiwiAeHHNQ1n3WkRgo8LVowFzxSbEB+mZL0185k8WFfWx7pI3jKQamoaDE8FoS2SaP3giLaJBNmQSDKDEPdokt7XcXYf5CIjmvcTTjKvC4iuD0WNirfYoda6NKJYSFH33sebWC7+qYSDX1xK1bKXa/ngB2AzzIE6Hkyw00hOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747558239; c=relaxed/simple;
	bh=LVHqIs5dkH4wt1GgaXg7gpSs9n/7yoF/xZyc4ZS4Xjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CZMHUgNb2lul73KPh2TkTOF9YktPuMM4yddV9agT5wCQhPiiA4ul87BAnnrNYp8knG3Ux0HeNaOpn2fTjHkbve/CzCxUY46mjX81ue8eKlzeaH7+spoa7wiakvy6auG+hyWKCz/WeuYo6smncSaChi8JIuIJMl7xotNFSrPLEYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=it-klinger.de; spf=pass smtp.mailfrom=it-klinger.de; dkim=pass (2048-bit key) header.d=it-klinger.de header.i=@it-klinger.de header.b=Bcl2Gkkn; arc=none smtp.client-ip=78.46.3.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=it-klinger.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=it-klinger.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=it-klinger.de; s=default2502; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=SWchFoSCTwn2tlujVfHivMIIFyjKfu9ASZYuiJBVv/I=; b=Bcl2GkknxnuvTXTRWlzhID2Cm5
	lbPdjqfLJALhBrzv/TrPv28sy+KGueQ4si0Zo74/VIEuZjDaGSWtHyxlKhBi2e07Lk0c+yshRXZCf
	HfYSh5VMs6y46bFM4GKgdflJ/ka4JEeTbhJIQTPM+uWD5Tf5EhpRtZ7r1DCXmx39yj5uiwgPwQHIJ
	7gUhHO17HJHMyhbWcyypvGo/q9cNUKOOj0aXyGbH2CBSB0eL6fyBqI6GOBxDIi6u+EHXipeY60TJn
	X8iB/mz3KBVGFmj2CplA+aTu3DPnMBYV1dPBjQkqyDERkXuujvJmZZSCg8TdwBHsr+VnMdZ62p1IR
	HixN0/cQ==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
	by www571.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <ak@it-klinger.de>)
	id 1uGZGd-0000Zk-2x;
	Sun, 18 May 2025 10:21:07 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy06.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ak@it-klinger.de>)
	id 1uGZGd-0003Te-1c;
	Sun, 18 May 2025 10:21:07 +0200
Date: Sun, 18 May 2025 10:21:05 +0200
From: Andreas Klinger <ak@it-klinger.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	lars@metafoo.de, javier.carrasco.cruz@gmail.com,
	mazziesaccount@gmail.com, andriy.shevchenko@linux.intel.com,
	muditsharma.info@gmail.com, perdaniel.olsson@axis.com,
	emil.gedenryd@axis.com, mgonellabolduc@dimonoff.com,
	arthur.becker@sentec.com, clamor95@gmail.com,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v3 2/3] iio: light: add support for veml6046x00 RGBIR
 color sensor
Message-ID: <aCmYcTxRYDbYMo3H@mail.your-server.de>
References: <20250505202313.205522-1-ak@it-klinger.de>
 <20250505202313.205522-3-ak@it-klinger.de>
 <20250515173728.1eaebd5c@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nQuoFjpD3nGVZccU"
Content-Disposition: inline
In-Reply-To: <20250515173728.1eaebd5c@jic23-huawei>
X-Authenticated-Sender: ak@it-klinger.de
X-Virus-Scanned: Clear (ClamAV 1.0.7/27640/Sat May 17 10:34:06 2025)


--nQuoFjpD3nGVZccU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jonathan,

thanks for the review.

Jonathan Cameron <jic23@kernel.org> schrieb am Do, 15. Mai 17:37:
> > +/*
> > + * Factors for lux / raw count in dependency of integration time (IT) =
as rows
> > + * and driver gain in columns
> > + * Columns:
> > + * x0.25 x0.33 x0.5 x0.66 x1 x2
> > + * Rows:
> > + * 3.125 6.25 12.5 25 50 100 200 400ms
> > + */
> > +static const u32 veml6046x00_it_gains[][6][2] =3D {
> > +{{5, 376000}, {4,  72700}, {2, 688000}, {2,  36400}, {1, 344000}, {0, =
672000}},
> > +{{2, 688000}, {2,  36350}, {1, 344000}, {1,  18200}, {0, 672000}, {0, =
336000}},
> > +{{1, 344000}, {1,  18175}, {0, 672000}, {0, 509100}, {0, 336000}, {0, =
168000}},
> > +{{0, 672000}, {0, 509087}, {0, 336000}, {0, 254550}, {0, 168000}, {0, =
 84000}},
> > +{{0, 336000}, {0, 254543}, {0, 168000}, {0, 127275}, {0,  84000}, {0, =
 42000}},
> > +{{0, 168000}, {0, 127271}, {0,  84000}, {0,  63637}, {0,  42000}, {0, =
 21000}},
> > +{{0,  84000}, {0,  63635}, {0,  42000}, {0,  31818}, {0,  21000}, {0, =
 10500}},
> > +{{0,  42000}, {0,  31817}, {0,  21000}, {0,  15909}, {0,  10500}, {0, =
  5250}},
> I'd prefer
>    { { 0,  42000 }, { 0,   31817 }, etc for this formatting.
> Don't worry about going a little over 80 chars to do so - I think the rea=
dability
> makes it worth while.

I tried it and ended up with 101 characters in a line. I'll pick up the
suggestion of Andy for the next version.

Andreas

--=20

--nQuoFjpD3nGVZccU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEE7/NrAFtB/Pj7rTUyyHDM+xwPAVEFAmgpmHEACgkQyHDM+xwP
AVFDqQv/fL5ieJ5Etw0Z9jQEM+Y/RpqGD44Cfj4BF0DFACoSfHdpFiGp0rZhudn3
ZvvgelwU0+jpo/azqY+4jtD+Z2BxhPbJ4/mqiR5FySUlnU2zi+Xl+gyI8BdfdPEg
lMWkWCUI1fdLDp3PYRu5NSa6Yap/xtQOZiXTbbEJM9Q0TuogZ6s2XMmFrf/tMVZS
LFkJwVsNNzL6w5vvETHVnwyz21sAwGCwsoKN52b7yHSDaR6Ii/SLi2wLU5eihcvZ
OPF+5kCcZXg4TR9QebFPROG35pfTc1DdqDn4V3LJ/w/jLq5t3tg1sNJZREIyr2V6
rxb1tmX70TJeub6OVZe9h/Cd+41ewem0sBN6mwasEfrMisnJOV8LtBCU0SDR+l1j
hXTLASIn0I64/XDv5mAZgkuaiV7arrcieSagf9ZD8JaQdXQ5zuz3VHrlAUfwMi7z
Zv7LJoeHmBKKuGw7wGpmFlqFVrcZkD/NgCQEib5SUTa3EVG7/wOUsepUcf+eSq//
49byW0oD
=zO0V
-----END PGP SIGNATURE-----

--nQuoFjpD3nGVZccU--

