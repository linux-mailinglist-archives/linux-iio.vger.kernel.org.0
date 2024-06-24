Return-Path: <linux-iio+bounces-6821-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 711A6915349
	for <lists+linux-iio@lfdr.de>; Mon, 24 Jun 2024 18:17:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3C07B24AA2
	for <lists+linux-iio@lfdr.de>; Mon, 24 Jun 2024 16:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE8D19DF53;
	Mon, 24 Jun 2024 16:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rTHyXUPJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35DEF19DF45;
	Mon, 24 Jun 2024 16:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719245867; cv=none; b=eMGogyPZLjL7niEsu7fplLjbhomA75obqjOrMq6rUoBMAPpiXTBy8JkW+O86M+0R02RNTb/lPLCJWhvwArSk2WndiOR1KHTbIkJtNGOy3fAlAPfqZme4tcdCayUThh/1XekdtXDsHee9IplioCdVg3aBueApDXncYxfoEgLA47Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719245867; c=relaxed/simple;
	bh=8wg+IgQ4PaKNBqjTBMybjMI9WUgplFxqmpCdUCJCerc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jZtBq710k/IF2xZ+2QrY/N7wfLrgPCs+5Wq8JDN7fO4fdBGXgXDCBV4KuEJKLe10v5v/+jALaBHvprBFi2B4u9Wb4UMFgigGNQ04q0MDFPbG6ITjGG/31Fjwl2jNcwzBhvkZErfrjAACHEEsQtKjEDLZeCHhNw3mw5df7fDKi6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rTHyXUPJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE446C2BBFC;
	Mon, 24 Jun 2024 16:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719245866;
	bh=8wg+IgQ4PaKNBqjTBMybjMI9WUgplFxqmpCdUCJCerc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rTHyXUPJB2WXXfwDpSYPM7otSVvfo8wpUGPIgc7LbX2ZW75OfcFUvpOPDpD5zYz2p
	 YUDax538+SoQ46n6+tv0dvyniBtnHgaPmFE/TxDf/XyMLR+5HknKY87m1dp+z8rNk1
	 gPEaAkYd16I0XWyiTI4hB7hHchjMtJt/IFkqsYe2zebLcUbLxtiIQEtNtD2n38Cr6h
	 ufb67Z6o8klqPwJlma0ograCtjlt7gcvlbN7uvK04OaKUKBtiUt68wyOK3P7YMV8dz
	 DW48EhClqI7XhjD5qCC5AJdBQyEUJUyNgETWs00wLUFaaDNFomzXci3sww/dp1j6X8
	 p4+w6BpcnN5yA==
Date: Mon, 24 Jun 2024 17:17:41 +0100
From: Conor Dooley <conor@kernel.org>
To: Alisa-Dariana Roman <alisadariana@gmail.com>
Cc: Alisa-Dariana Roman <alisa.roman@analog.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v6 2/6] dt-bindings: iio: adc: ad7192: Update clock config
Message-ID: <20240624-backpedal-reviving-97c8d582222a@spud>
References: <20240624124941.113010-1-alisa.roman@analog.com>
 <20240624124941.113010-3-alisa.roman@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="omsOYQBq1QY2vkXw"
Content-Disposition: inline
In-Reply-To: <20240624124941.113010-3-alisa.roman@analog.com>


--omsOYQBq1QY2vkXw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2024 at 03:49:37PM +0300, Alisa-Dariana Roman wrote:
> There are actually 4 configuration modes of clock source for AD719X
> devices. Either a crystal can be attached externally between MCLK1 and
> MCLK2 pins, or an external CMOS-compatible clock can drive the MCLK2
> pin. The other 2 modes make use of the 4.92MHz internal clock.
>=20
> To configure external clock as either a crystal or a CMOS-compatible
> clock, changing the register settings is necessary. Therefore, add clock
> name xtal alongside mclk. By selecting one or the other, the register is
> configured.
>=20
> The presence of an external clock source is optional, not required. When
> both clocks and clock-names properties are present, an external clock
> source is used. If the intention is to use the internal clock, both
> properties should be absent. Modify required properties accordingly.
>=20
> Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

--omsOYQBq1QY2vkXw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZnmcJQAKCRB4tDGHoIJi
0h3aAQCInM/tqZw1VmACMY/akNf5ilQCas16+g+ecxOMWKdA5QD/UkC9eqbbM6o7
HnyuUnbaF1oFodqRVFT7GzXHhY1KZg0=
=wLu0
-----END PGP SIGNATURE-----

--omsOYQBq1QY2vkXw--

