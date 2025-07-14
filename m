Return-Path: <linux-iio+bounces-21636-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35887B03941
	for <lists+linux-iio@lfdr.de>; Mon, 14 Jul 2025 10:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5388D3B0384
	for <lists+linux-iio@lfdr.de>; Mon, 14 Jul 2025 08:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4160723D288;
	Mon, 14 Jul 2025 08:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=it-klinger.de header.i=@it-klinger.de header.b="VOTXfiYm"
X-Original-To: linux-iio@vger.kernel.org
Received: from www571.your-server.de (www571.your-server.de [78.46.3.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3887923C501;
	Mon, 14 Jul 2025 08:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.46.3.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752481297; cv=none; b=ip3ziWZ+/8+9XB4AhyLevY18m3tSGzjX1teMcLOIkN6+7Wjvxngbwg/vBkR4uizRxUwtbrfbir2BreyQ36Fx5dLOgWUB0c1UkLwRJeN6jcDBfhZx4lMYMRz0LT6ip2m4jupROCA6gzSF2kJG8DPfHBwBwKbrPIwBqI45DX83YVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752481297; c=relaxed/simple;
	bh=vGCt6e4tvbfIAxKyrSifFmcPqWkUhZMW++dsW2+fEX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S4u3eM7LNk5gxgrw4i0M5j+Sz3oMjuLOdcH13+zd3u4Inx1FxCG/kKJAKeiZanUI5is2XWPAofczgUMAtvPOye59FQ7cPn6t3r4Ex9e2U1WWRumCNQYd/XRpYZInEtT5UiB5Z/S4pwV3IJ+6BPtee3gTIyl7iX2DESXzZUU8MHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=it-klinger.de; spf=pass smtp.mailfrom=it-klinger.de; dkim=pass (2048-bit key) header.d=it-klinger.de header.i=@it-klinger.de header.b=VOTXfiYm; arc=none smtp.client-ip=78.46.3.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=it-klinger.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=it-klinger.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=it-klinger.de; s=default2502; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=LvThmsuNtvCogrKqIZq+Xt7F8YmCZbkWSaf2CIUYY8M=; b=VOTXfiYm/VslRNjilgNbtSDc07
	RJGQdFUyQAwi/8FTpwT8afj9yo1V+uwWMS8JcSinNCnACnwGWhh1MVqXsIsFgztTSZJWk2K8FsAFZ
	G5fEAOsQAvLdpRe7/40bfry0n5F1D3DGJ3sY8WbUm7rItiFQpXYZhGeXfOp4cippZmSqnqXi7HXqR
	jtYjaEs8YEi3w7L/qqNOwTNnP8v7EedIfkI4BZKVVWa3GuthnSVaEUdV0kt1p5halgGF2AqR95hZZ
	FI1+6x+T8HhzXItecizva9A2lGh3+mn7iJqcdzC8QhAhcg2rw1jn2SqRSvn9gM4T8/or6RCh7IWBt
	Hy8LCW8g==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
	by www571.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <ak@it-klinger.de>)
	id 1ubERF-000DeF-2f;
	Mon, 14 Jul 2025 10:21:29 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy03.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ak@it-klinger.de>)
	id 1ubERF-000DHU-0X;
	Mon, 14 Jul 2025 10:21:29 +0200
Date: Mon, 14 Jul 2025 10:21:27 +0200
From: Andreas Klinger <ak@it-klinger.de>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, lars@metafoo.de,
	javier.carrasco.cruz@gmail.com, mazziesaccount@gmail.com,
	arthur.becker@sentec.com, perdaniel.olsson@axis.com,
	mgonellabolduc@dimonoff.com, muditsharma.info@gmail.com,
	clamor95@gmail.com, emil.gedenryd@axis.com,
	devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/3] iio: light: add support for veml6046x00 RGBIR
 color sensor
Message-ID: <aHS-B5KmBKX72OZc@mail.your-server.de>
References: <20250526085041.9197-1-ak@it-klinger.de>
 <20250526085041.9197-3-ak@it-klinger.de>
 <aDTMSwhodZQLzZ4q@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="stXNHVz0ywEbGY6j"
Content-Disposition: inline
In-Reply-To: <aDTMSwhodZQLzZ4q@smile.fi.intel.com>
X-Virus-Scanned: Clear (ClamAV 1.0.7/27698/Sun Jul 13 10:39:53 2025)


--stXNHVz0ywEbGY6j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Andy,

many thanks for the thorough review. One comment below.

Andy Shevchenko <andriy.shevchenko@linux.intel.com> schrieb am Mo, 26. Mai =
23:17:
> > +/**
> > + * struct veml6046x00_data - Private data of driver.
> > + * @regmap:	Regmap definition of sensor.
> > + * @trig:	Industrial-IO trigger.
> > + * @rf:		Regmap field of configuration.
> > + */
> > +struct veml6046x00_data {
> > +	struct regmap *regmap;
> > +	struct iio_trigger *trig;
> > +	struct veml6046x00_rf rf;
>=20
> Does pahole agree on the choice of the layout?

This is the output of pahole:

struct veml6046x00_data {
        struct regmap *            regmap;               /*     0     4 */
        struct iio_trigger *       trig;                 /*     4     4 */
        struct veml6046x00_rf      rf;                   /*     8    20 */

        /* size: 28, cachelines: 1, members: 3 */
        /* last cacheline: 28 bytes */
};

I don't see anything wrong or did i miss something?

Best regards,

Andreas


--stXNHVz0ywEbGY6j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEE7/NrAFtB/Pj7rTUyyHDM+xwPAVEFAmh0vgcACgkQyHDM+xwP
AVHhBQwAoU1RGWaHEOX4OjCPOGm/Uthy8qABHF7YLF+oMo/O9C+wbdqzcf8mpYey
ZU797baeAuK13lM0x447v9181bBuy0B2iIaAdJQwYl9XCurnpczZKPMUzzWDGXvk
ZhdThTnL/IkGSZhQR4Qk+PyKrwNm6NL0eAkVWtsqSLpXR+cW2c81TgRSYMtrshOZ
FvSKm9BpzSZrqUNlvFP/rZ/IoaHUmPM3DevqCekiPjTAr/khSED69nrU1VzhDQFm
HOs+oY1h4FgYFcMjC/KtSinQ6qKN1IRkGEiRk9G6eI1odrgNi4/1E4PuJHyRol7w
AGaEsf3cutc7WAmMrBiWZcfrhe/QJ4u1fUq2qtq0n3Nb2rK0/C2XleZ4ukMFu3eo
5iMDw/HLeH9kf7MoGr2dd35/LnT2P+P1iaA6RjOq2z/D4xHyffALCrT0bZFtQNRp
90aX9X+Jh9ZDE//X6kC1oqaufjAoJ/VWSZuRTwIQvVno/40S+2CmSmjwFBenRT95
PFXJ4Wst
=aHbg
-----END PGP SIGNATURE-----

--stXNHVz0ywEbGY6j--

