Return-Path: <linux-iio+bounces-6966-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DED2918557
	for <lists+linux-iio@lfdr.de>; Wed, 26 Jun 2024 17:09:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FCA51C22E5E
	for <lists+linux-iio@lfdr.de>; Wed, 26 Jun 2024 15:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B247318A922;
	Wed, 26 Jun 2024 15:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GZ6olwVm"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62269155C91;
	Wed, 26 Jun 2024 15:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719414545; cv=none; b=hmUDPkw0cRQypTngcu37xiYa6vLQrygSQEWR40jP2gOeZEaWStbrA2tZ6Zr6aGo/jonZn2DoOdBgR8i0DdLBylFP+4+QSiGnAm3ESTWs0dbGmZgE7lZxBs+uFx9qpsuocMwYi+3ZYNiBl4n8fUkAXvOE3SHoA/FSoD1nu8PhPH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719414545; c=relaxed/simple;
	bh=7+HyK8B/fQPVJIpKq7co7b0HBUUXOxNXHxcBIgwRlFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r5M1Dv2RPeSZhNmD6B257VeFURO3wZcyycU3nKwocbZ9s43mTPy60w6J74vB/mQBLbybK09NYfwQJ5AbSExRY2a6BTnRXRennF6pPeEUBWg1QM56V0J7ro4heZSWSZrDnjx09mmC196Z8Hog38PnWRH5XkNHJSILjR4a019GLFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GZ6olwVm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 845B6C116B1;
	Wed, 26 Jun 2024 15:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719414544;
	bh=7+HyK8B/fQPVJIpKq7co7b0HBUUXOxNXHxcBIgwRlFU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GZ6olwVmvbc8/IucRok615TR/W5kaeJx4oeQTQwW47UTb3gprgoMUUQcqdy/StpJY
	 tLSTdPNZ4/555lhGTIhoDrcIUBfZq/D/Fue9r9EHYm99Cegfdh/0uslDonUjktPMgC
	 qRgJj9b7DZlr85vlpTTNBs/ikf7q+kmLTbLC21SATpzB7fp9xPkL5Ogfz9tIC+C/td
	 ASBl1dI79UH2Lonx47/pSSEUfZ7Gu3c2AsQd0zXtGH29ITFmLGiWpfBZBs4XkYJ4er
	 iTMVKYhcb8DSlWoPwbJDmHO37pyFUN7YoaGzYhMvIq85ZR7ymbzu4Yz86O2b+lp61h
	 Ikw+WyBhs1i5g==
Date: Wed, 26 Jun 2024 16:08:58 +0100
From: Mark Brown <broonie@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, lars@metafoo.de,
	Michael.Hennerich@analog.com, jic23@kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	nuno.sa@analog.com, corbet@lwn.net, marcelo.schmitt1@gmail.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-spi@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/7] spi: Enable controllers to extend the SPI
 protocol with MOSI idle configuration
Message-ID: <7ed7f957-3e07-42ce-894a-f3f9dcf512ea@sirena.org.uk>
References: <cover.1719351923.git.marcelo.schmitt@analog.com>
 <add14694c64b574af742a5dcd5c9461e0ef5210a.1719351923.git.marcelo.schmitt@analog.com>
 <1d2cde40-ad55-4136-bc72-3d71515f7023@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="N7WFjWy5qfMLq50w"
Content-Disposition: inline
In-Reply-To: <1d2cde40-ad55-4136-bc72-3d71515f7023@baylibre.com>
X-Cookie: Results vary by individual.


--N7WFjWy5qfMLq50w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2024 at 09:57:32AM -0500, David Lechner wrote:
> On 6/25/24 4:53 PM, Marcelo Schmitt wrote:

> > +#define SPI_CONTROLLER_MOSI_IDLE_LOW    BIT(8)  /* Can idle MOSI low */
> > +#define SPI_CONTROLLER_MOSI_IDLE_HIGH   BIT(9)  /* Can idle MOSI high =
*/

> These two flags above are still not used anywhere and are redundant with
> the SPI_MOSI_IDLE_LOW/HIGH flags below so I don't think we should be addi=
ng
> these.

Yes.

> Also, what is the plan for adding these flags to other SPI controllers. F=
or
> example, the IMX controller in [1] sounds like it should also support=20
> SPI_MOSI_IDLE_HIGH. And your comments on an earlier version of this series
> made it sound like Raspberry Pi is always SPI_MOSI_IDLE_LOW, so should
> have that flag.

I don't think we need a specific plan there, obviously it'd be nice for
people to go through and enable but it's also fine to just leave this
for someone who needs the support to implement.

--N7WFjWy5qfMLq50w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZ8LwkACgkQJNaLcl1U
h9CNhgf/SSOf2uT6QPqgmc8UK28/2kDxpc+L0ItGJSbkMvq4Qzd/jESlpcCMl8D3
y5GdaWkZXfaXoyqVyGcBi077uDS/pw0IcQlPXL/yI5deRxKibzt2H6mM8Sn8gznn
BP4zQZc5fp9CrYQ256g/pMOxD3Q0Qam6xuG9TispYcNAcnLKuOAVEpuI/zC+V+lo
yZUdLIsMQbTPDVRsIrs6UPs8Au+QWkkSyb6uC0yU8CAtZpoIR2hVNz1h8ixLsANz
fneBARRJ1h/6iNI405so1ujN5D0Bw8B157RJY5TOR+PeN7+bqjwC1lfvmPA5k2R6
cF7e8HmRtu6iC8EBhzUSnCxI7/NDkw==
=SYzG
-----END PGP SIGNATURE-----

--N7WFjWy5qfMLq50w--

