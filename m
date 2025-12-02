Return-Path: <linux-iio+bounces-26642-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 308B0C9C3B3
	for <lists+linux-iio@lfdr.de>; Tue, 02 Dec 2025 17:37:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3D43C4E36ED
	for <lists+linux-iio@lfdr.de>; Tue,  2 Dec 2025 16:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3580B298CC4;
	Tue,  2 Dec 2025 16:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dAoFrGeV"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76EA293C4E;
	Tue,  2 Dec 2025 16:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764693413; cv=none; b=Qenrw5+ivwwK0PpEgMylUyMzJc8pV4/9/GVFEaL5Mmu/gdOQ+LXFf6FIlZzx0W9TGyTUR97wOoB828uVxlEIghuCP48b4TmegYuYEwkvKF/fKrSqJvRV8ENPpnOBAiGC8r5QRTVyf8e2LiorNDpWjh97CIlHNS9sXKoezASxjUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764693413; c=relaxed/simple;
	bh=83GFMtXEDYJO/Zm4n1Zxl4KGegW2MOstk7NxnWv3J1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t/HMEerR0j3AeZTE9nF/o7nqe3/EaGzLHSKY2aSO8ttoCvHC1g2jfAJi+t/3O6tRRR86JCMI7pTZmV9LiJxt5zivB077YD2sLRoT6/ygNq6qVF8FF1LtZ7eyoBT6pLc+09Xm4atqIKeXLc4eQjlKz08SVoJhIajQ9TI+zWftBTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dAoFrGeV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0D1BC116B1;
	Tue,  2 Dec 2025 16:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764693412;
	bh=83GFMtXEDYJO/Zm4n1Zxl4KGegW2MOstk7NxnWv3J1I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dAoFrGeVtYJbHrr+45DEpeJsjpFtcRh3hpTT8UcGAld18NrWGF/hf8Xu2/mZY6RgJ
	 LgSBATGoq+e4307aEGN6nI2PWs3SLKf++NKSTjbHHZPVW6PtE/0ipYCaNkMG605+Fm
	 VP/mxmYMH6MfbtRtVWHeob/8UOEdvK7eo4hVBAtGkw6wfa46U4RZeX0vkdfa0B4otf
	 6mxpfxST+FSEOcjO56Ei2tX9ox0Ru+A6ApIvvJqb6OACPOp22SYAd9AAAz/v7gVdR1
	 ifGjLPEkp2HIgzqrm0ygv3Ldgs1cwwmLRmgVNsdewWYwNW5NmsTDfq/ILRxDdzJe5d
	 Ham+e9XH3lxoA==
Date: Tue, 2 Dec 2025 16:36:47 +0000
From: Mark Brown <broonie@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: David Lechner <dlechner@baylibre.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Sean Anderson <sean.anderson@linux.dev>, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 4/7] spi: axi-spi-engine: support
 SPI_MULTI_LANE_MODE_STRIPE
Message-ID: <eb36242b-ac82-412c-b14b-648d541dcec1@sirena.org.uk>
References: <20251201-spi-add-multi-bus-support-v3-0-34e05791de83@baylibre.com>
 <20251201-spi-add-multi-bus-support-v3-4-34e05791de83@baylibre.com>
 <aS79ex5Konr_EeMA@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FPtsYwuTnMFr+BO8"
Content-Disposition: inline
In-Reply-To: <aS79ex5Konr_EeMA@smile.fi.intel.com>
X-Cookie: Beware the new TTY code!


--FPtsYwuTnMFr+BO8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 02, 2025 at 04:53:47PM +0200, Andy Shevchenko wrote:
> On Mon, Dec 01, 2025 at 08:20:42PM -0600, David Lechner wrote:
> > Add support for SPI_MULTI_LANE_MODE_STRIPE to the AXI SPI engine driver.

> > +static u8 spi_engine_all_lane_flags(struct spi_device *spi)
> > +{
> > +	u8 flags =3D 0;

> > +	int i;

> Why signed?
>=20
> > +	for (i =3D 0; i < spi->num_data_lanes; i++)
> > +		flags |=3D BIT(spi->data_lanes[i]);
> > +
> > +	return flags;

Variables called i used for iteration are typically declared signed even
if they never cover negative values; IIRC there used to be some
compiler interaction reasons to do so although I expect those aren't so
relevant any more.  Using a signed type here is perfectly normal.

--FPtsYwuTnMFr+BO8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmkvFZ4ACgkQJNaLcl1U
h9CGMAf/Z9tgkpoIquZVmlc/mWB7nE71/dWFqZPhVZukwXHsaH6elH+9y4X02z7r
i8YUfkohYtoIB8wVJwb2B1zgWGV2eHz408B1ukimCf1mw2DFiBgig8E9XmWbIOIj
RZqc3+I/6YLq4C4ElD/XRDiv5irAiErRKkJdCH7Ffl8eFzUx3Lb2TZHG2RFY7N04
GQKeByyB2+99v7Xmq+tUyZBR3v6fG7E6ajqkvM488VUx3Bbx75OXWmMvCSZBeiyZ
vnenKsxUD+Q8BBGMfA/iuAenIQsRjJRVgxY8dTegmOWUkHgmujipLk2y6ePGnqY3
mxAz2/OS4jfcQl+YEJeksBq44m/HKw==
=DHFJ
-----END PGP SIGNATURE-----

--FPtsYwuTnMFr+BO8--

