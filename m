Return-Path: <linux-iio+bounces-6586-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7329390EB57
	for <lists+linux-iio@lfdr.de>; Wed, 19 Jun 2024 14:42:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEC3B286102
	for <lists+linux-iio@lfdr.de>; Wed, 19 Jun 2024 12:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B6F6145324;
	Wed, 19 Jun 2024 12:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fUas+qbm"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12E2142E98;
	Wed, 19 Jun 2024 12:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718800960; cv=none; b=eyyhOXco3Erm7qHsJL0I88BNWYoYsibBtY+VKj0nUgrS7MwjIDSF7Ob6LEx6cBTc19KTwEd/JjvBlgbG8xQzCGJ5NV+ikQRP85pFyeCNFLIh4kLY+qSDH26+CablmCPxlVvLADc4P9s8P6c4niqNfiOidZAS0qBNPXI8YFmpFdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718800960; c=relaxed/simple;
	bh=KPpDk/Q8SfC1yDgorRALRIvtAFwEFX9pibsX1QJz6RU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cys47BlrgK1iP+/9X+zThXcaEhL7DGacD9wCgNjdKSKDjIZBXgoAIC9e+RPtasDJr+aSbyVB/++HJm4XZ4Fnov5QybCb5QXD3HlM8Xft+1NIH5/Xa2zLeeNxNIihIV6CdBrQmGzkFwklIgYvK87zea/KOkc/wqGSvls262hVTGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fUas+qbm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97E40C2BBFC;
	Wed, 19 Jun 2024 12:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718800959;
	bh=KPpDk/Q8SfC1yDgorRALRIvtAFwEFX9pibsX1QJz6RU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fUas+qbmVSfg1FpKJG8oanoTQ8rYncAfwSy9JSO2Xu3q5wok4z0ho+YvYClbgzDHf
	 7FF7CO0B1FRdL0fpYqH31h4EdtP+I1TmTRGhfZkO1h+OFT1cV92sXT6EsCEbj8/5r3
	 CxUETeaLImF/JfUZz3CNuNjsFGRyePoKEJFWTRraRBF9gWSMphvUDgOlzZgiaEP1IE
	 Hf/AGhdBaPwCNk/6zec+hltc8/wILKYXyRuJ/H8sVO+T2jNj2AbAT2UcAg8ncuOQ7n
	 xD7CdgC7aJIWugLL+tBVM98vEhKvh7eg/xpMH13pQuh0joj2u/1PEYaW1vwDa13cAe
	 w9aYbqdcxUtoQ==
Date: Wed, 19 Jun 2024 13:42:33 +0100
From: Mark Brown <broonie@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, lars@metafoo.de,
	Michael.Hennerich@analog.com, jic23@kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	nuno.sa@analog.com, dlechner@baylibre.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/6] spi: Enable controllers to extend the SPI
 protocol with MOSI idle configuration
Message-ID: <cf2ed564-bf5b-4867-b370-fdf05d8e5e50@sirena.org.uk>
References: <cover.1718749981.git.marcelo.schmitt@analog.com>
 <36eefb860f660e2cadb13b00aca04b5a65498993.1718749981.git.marcelo.schmitt@analog.com>
 <5f89baeb-c95a-4ad9-adc7-769fb124c0d4@sirena.org.uk>
 <ZnLSL6wvyhGAVyUz@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4DL4nXqS7g2BO8Jl"
Content-Disposition: inline
In-Reply-To: <ZnLSL6wvyhGAVyUz@debian-BULLSEYE-live-builder-AMD64>
X-Cookie: Don't I know you?


--4DL4nXqS7g2BO8Jl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2024 at 09:42:23AM -0300, Marcelo Schmitt wrote:
> On 06/19, Mark Brown wrote:
> > On Tue, Jun 18, 2024 at 08:10:44PM -0300, Marcelo Schmitt wrote:

> > > First replies to v3 brought the idea of having a feature detection me=
chanism.
> > > I didn't really get how to do that. If feature detection is required,=
 can
> > > somebody please provide some pointers on how to implement that?

> > Look at the checks in spi_setup() for bad_bits. =20

> Yes, I added MOSI idle configuration bits to bad_bits so spi_setup() fails
> if the feature is requested but not supported:

> 	bad_bits =3D spi->mode & ~(spi->controller->mode_bits | SPI_CS_WORD |
> 				 SPI_NO_TX | SPI_NO_RX | SPI_MOSI_IDLE_LOW |
> 				 SPI_MOSI_IDLE_HIGH);

> am I still missing anything?

That should be fine.

--4DL4nXqS7g2BO8Jl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZy0jkACgkQJNaLcl1U
h9BQaQf+O4O05aAzcOnTltf5gMMjMNi5Fotb/kw444lON7rUPza4t4/bAipiqqQC
PhiJUV3vcJ5eNDLrbAzaJ4kZKSt2hWmJSwMF735FN5VcaACoM1nDtEjnOwxv29uU
SrtgF4tJlcc0zndf1iCKa7Fd08JWMKivbO+ROm5Gbkb6sjC9IraU6jsDoYlDMJWe
pHQOBjFklVnniYDGUhkpAuLgVDbZKkPubAi/sMHa7alfNYxBorX/HZP1Ab8U7zed
yAcAz+xkwyyQ5kmsexTYBUM2P8yaAC/F9khU+F9Z8AW3aBC8MGD9e4iRz4+8Rhgq
gddvsJorttQ82L1dfWaCxtBHRm6KhQ==
=XcjU
-----END PGP SIGNATURE-----

--4DL4nXqS7g2BO8Jl--

