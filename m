Return-Path: <linux-iio+bounces-25199-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB968BE9EA9
	for <lists+linux-iio@lfdr.de>; Fri, 17 Oct 2025 17:33:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D903746327
	for <lists+linux-iio@lfdr.de>; Fri, 17 Oct 2025 15:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8971F3328EA;
	Fri, 17 Oct 2025 15:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="aeEPF5Zg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CC8337109
	for <linux-iio@vger.kernel.org>; Fri, 17 Oct 2025 15:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760714083; cv=none; b=Ayiqxx/fGXeYwfolvQeCGA6VJphgAg2fnLCPi+cq9wGtAoqLVa3haUqvN8ZP+dTPsoXi0aKpRnp2Grfh17LqG4YtZ8WZvZ3LDCvPbNozDbxqLRImTfHEyIkEOLNV4qUzGuEHUdmq8EQ/Gio/4MBJjLz2EH8XhQt8ciSIMWP+5Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760714083; c=relaxed/simple;
	bh=p7IYtu7Nv3p1Va76BbrP2fjM79zbzZp0jh60+HNRPDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QSO3ts7gAgLiquC8sfdOnozfb3/FJCf+Y7EC2e8c3rc02jodrtQwn/9r+ZkyaUAvH74gFrwlYW288wANdPT0t5iUylBKNGujUTmISEwXGUntaFwPAU9AR7u3pJMp/gbWU/ZTk3dpMLjtIbRehYTEIlz8GVmwb2eoSER5ioJ/xoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=aeEPF5Zg; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=p7IY
	tu7Nv3p1Va76BbrP2fjM79zbzZp0jh60+HNRPDg=; b=aeEPF5ZgjRxf5ivMgEP6
	a96riYOhKW+hG5UdPLqdTcfe5FTjmV3OHJf/2Ai2VKwYSbJR0wC1/D/r8xB5FKy1
	GFimrI814BL0MTkU/q5p8zRzfWMG6Fh/yESpyCgDfhMxlF/mSz/Ds6P/J4yWCMPU
	C8BsAzABRdLNnWBwUNATSxNK7QV1NUB3MoVqJCJqA/+jshpLIV4ExS7o2LGkzWWC
	rCepcfyhftSIouKjY3EEfHbBetJ0pbMGdjvkFgrOMTXjpe0sUGCFCa12GpnpDxYV
	4xWw2HIu1NJLb35qNr9bhseQdJasRiHRPSgoKT4f7btxD0vJSxw1zciG1ENQqpL+
	fw==
Received: (qmail 79180 invoked from network); 17 Oct 2025 17:14:33 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 17 Oct 2025 17:14:33 +0200
X-UD-Smtp-Session: l3s3148p1@AS3dMFxBjs4gAwDPXwQHAL/S9V79e5yL
Date: Fri, 17 Oct 2025 17:14:32 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Herve Codina <herve.codina@bootlin.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pascal Eberhard <pascal.eberhard@se.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 2/4] iio: adc: Add support for the Renesas RZ/N1 ADC
Message-ID: <aPJdWHjjwYW5VECZ@shikoro>
References: <20251015142816.1274605-1-herve.codina@bootlin.com>
 <20251015142816.1274605-3-herve.codina@bootlin.com>
 <aPIIVUlHnvi0BXtN@shikoro>
 <20251017170054.7a7a6d5f@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eU16krwebNarsjsY"
Content-Disposition: inline
In-Reply-To: <20251017170054.7a7a6d5f@bootlin.com>


--eU16krwebNarsjsY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> IMHO, I think the solution you proposed is similar in term of complexity
> to the RZN1_ADC_NO_CHANNEL approach. On my side, I would prefer the
> RZN1_ADC_NO_CHANNEL approach to keep the decoupling between IIO chan and
> ADC core chans.
>=20
> That's said, I am still open to move in your direction if you still think
> it is more relevant than the RZN1_ADC_NO_CHANNEL approach. Just tell me.

Well, in deed, I like "my" approach a tad better, but I am not demanding
it. It is your driver and you have reasons to do it like you implemented
it - you chose the way, I am fine with both. But maybe add a comment
(mention the decoupling) why it was decided this way.


--eU16krwebNarsjsY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmjyXVUACgkQFA3kzBSg
KbYeug/+MzLs0kUyOuNPsQ7uDp6nj5Vb9AevnkxgNb/eAHHlOb8lEDyatQmbZExt
i2W1xVVBsqr10n7IpC7ygrrEpaM3PiV4i0a37ppAxoac6wFH01OlewpRS1L61t7W
c/kPt/7xkdy/emhe5/mGTW4CH3lYK8IkzQtSkxLEdHW4Ku6BGsh/KTjrL05FV1VG
M2UG20Wp42YyflxdG/U9NAjYpA2g+8zgDI7txX52GNwkoekEX4/cIk1Z0da/fKTo
jGdeSNu1U4VupTEDap5TGafGledZQZPKuOAdSCu2JHhqXhhxkBWUJZRORbX2ztqR
VM0o5kCgejDDLhPWijtT2UNTLKf4K36IBQDhjBju7pmfHMypXDCQ+hI6pm46v9+c
UhraHkPsBG1z8Qez4MVgtXUPUmCjUjCq3pbIMub/ZY18EzadptQmjvGZfZ+D5Iot
xfTMwGhbpzQNqJ1yQyC1djszbaBWp4t9U6eUE2CLyluu9Vgpw/jvPifCnzLOue0T
Qi3RES0lAWHw8ttqY8fr04vdAh77Di/z2NNK1cYerlO1E243uPoqru8NWLWkm/OL
H+lgDLQUFTrO4T+FiJNsp29p8nMACv6S1XAPx3NZc5i+WrulcLaGbPqOgm+Miny5
qHybCE5xUm+c5tkKc+5jzG6akgft5TEHDkgmRCaVtcE/CpbgV0g=
=eQ6v
-----END PGP SIGNATURE-----

--eU16krwebNarsjsY--

