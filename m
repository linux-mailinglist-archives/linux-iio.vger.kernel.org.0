Return-Path: <linux-iio+bounces-27656-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 865F4D14DFD
	for <lists+linux-iio@lfdr.de>; Mon, 12 Jan 2026 20:11:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 27C2A3008CA7
	for <lists+linux-iio@lfdr.de>; Mon, 12 Jan 2026 19:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F72D313540;
	Mon, 12 Jan 2026 19:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sUAKRbHk"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C971313556;
	Mon, 12 Jan 2026 19:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768245092; cv=none; b=h/h+WN5QRevvBh1U/rr+y6J5Wr622vLdfmd6IHcP6v+mp5DnikquS5VACUaAy8lwACHpk225vJ5JTxDQ+h9h4MJ2XtoMZfxqmatn5ukd2ulxIcCslD8ugu5PknuB86mAlrfUOioxZr1AEzjAPxpdawMUOFAyy+g6Yl9mPCS2IpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768245092; c=relaxed/simple;
	bh=Bp7pBX+OGh6LLz01oUXLShkCkvbut93sLdXhad2VFwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cvF4UjnP2lKpvuDgk3jFFfopv2198vaADSYy5/HSO74YkL9Klhglx7GqPQt5g6wPeA7mru8c6/78H6E5+gxzmMp9GCHS734AnW0eVSR+KI1ewMVP9wPlMAilw+56P+jhs7Qnmp4EV4GeVBJdiD/YV62DqIYlrewZrUbYytD0nXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sUAKRbHk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3A39C19422;
	Mon, 12 Jan 2026 19:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768245091;
	bh=Bp7pBX+OGh6LLz01oUXLShkCkvbut93sLdXhad2VFwk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sUAKRbHkFCWrda42Dj1GscGYuJdquAG5ax3pbRO/IC8r/0u8yg7S5AutOGWmy1qWi
	 j1q8fZijtCmJQKWM4vAF6p2F4hz40B+62nSxlFWmASDP4c7O4PQsuGxhm0nrHiSUEi
	 kJ6PwclMzdjNZ1uRlwbtxIQX1CEs9l2YbCjSm3F2m/R9vvNlpmdWp/NTBzTPLCrPtd
	 DxOUUXbAKjOigtH6qcdpVD2PmLlf//AhB1WB6873Jkp1EJMXll2NFe0ZaCDwPnanEb
	 tyNgLzOv+wy1ia2acKU89WrrNOYC80M/fqPzvdFsMYIi+lGpqKwDpY9ygNmvRjObAH
	 d3JOb4b27W2bA==
Date: Mon, 12 Jan 2026 19:11:26 +0000
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
Subject: Re: [PATCH v5 3/9] spi: support controllers with multiple data lanes
Message-ID: <22a6a28c-0f03-4571-b2a0-8c9b82788b68@sirena.org.uk>
References: <20260112-spi-add-multi-bus-support-v5-0-295f4f09f6ba@baylibre.com>
 <20260112-spi-add-multi-bus-support-v5-3-295f4f09f6ba@baylibre.com>
 <aWVGZWg7zLpeG3Kz@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Xpu6+ZOWxbgm4kEk"
Content-Disposition: inline
In-Reply-To: <aWVGZWg7zLpeG3Kz@smile.fi.intel.com>
X-Cookie: Surprise due today.  Also the rent.


--Xpu6+ZOWxbgm4kEk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 12, 2026 at 09:07:17PM +0200, Andy Shevchenko wrote:
> On Mon, Jan 12, 2026 at 11:45:21AM -0600, David Lechner wrote:

> > +	/* Multi-lane SPI controller support. */
> > +	u32			tx_lane_map[SPI_DEVICE_DATA_LANE_CNT_MAX];
> > +	u32			num_tx_lanes;
> > +	u32			rx_lane_map[SPI_DEVICE_DATA_LANE_CNT_MAX];
> > +	u32			num_rx_lanes;

> This adds 72 bytes in _each_ instance of spi_device on the platforms that do
> not use the feature and might not ever use it. Can we move to the pointer
> and allocate the mentioned fields separately, please?

Do we have real systems where we have enough SPI devices for anyone to
care?

--Xpu6+ZOWxbgm4kEk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmllR10ACgkQJNaLcl1U
h9Bt8Qf6A6TBxg40SLuzYnQ9ggqj5mOnIE3sg7K/MtWzFZ75iD3MySRpJUNXMA5e
GbRbN0PimlOqQT3ACFUaDMGuMCH+cLYzuMjMsWz9Cn0/DgHh7DG5C5cYGwToptaB
XxUKmI16nzObMN2ENGJ8Xg6RFn0B8eBEzLvZsNZa2tFxkg0qINMIjIpKi7RkvTTC
en9aAgNJ4K98B5C1nl+YMVI/OeX7Je7k7lueu1T89b3iwLhjlQ9sc44Ez86dbzf8
Vi4Xycgb0lTCB8GsxP11lyrMDgPrjEsaueqBouOjbio59SpwtwcH2KKMdhJBoIro
eS/qCHvCAlDJMqrex2kEk38lc6tzvg==
=rtW3
-----END PGP SIGNATURE-----

--Xpu6+ZOWxbgm4kEk--

