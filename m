Return-Path: <linux-iio+bounces-24862-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19E94BC68E1
	for <lists+linux-iio@lfdr.de>; Wed, 08 Oct 2025 22:18:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5114A403BE3
	for <lists+linux-iio@lfdr.de>; Wed,  8 Oct 2025 20:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B46279917;
	Wed,  8 Oct 2025 20:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eWEuV7Nd"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82B727B347;
	Wed,  8 Oct 2025 20:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759954719; cv=none; b=qZthjgjKaPG68e/jV14r++le9aW2Ay4qpSbqRcPL50DkU7mUdaKmCqVJekVzz1LU302FubAwiiL13XWxGnxI6pndmJVpAbnQ48/I113DzdEzgz8YFcXWgdrIS0pXN3il1/qkTPQdP9KP8pn8EI2L37ShdHzjqZOPsRyx0cyWLKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759954719; c=relaxed/simple;
	bh=NPfFVoW/LsVVuz6xy4asuQtfUdYNXIh1K0Bl95lxHK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K7cHN5gIrC3B0Oap6S/R+GFVEuHea0q47V4O0NNo765elBwB3FJTAQqCwh1eaSRAx1dEO4gp6KDfAFslr/5e3GY34ieStalMFAjHuopPBRuxgsBRIbEjFA2ehc1KvilA3/ThjyXD9Uz/X3nheZrBDy1fuv3vzJ6fE9vwMyXnfGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eWEuV7Nd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51887C4CEE7;
	Wed,  8 Oct 2025 20:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759954719;
	bh=NPfFVoW/LsVVuz6xy4asuQtfUdYNXIh1K0Bl95lxHK0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eWEuV7Nd5F7lsXWr/UkCGuvskUUzW9C9N2qKdcElDqx/deuTzBTWJueKZCqT5MWC/
	 kE9/oj3IagxHP2hfMgU4vzc/Njx/JocASOAc5uKkczRX+NIlOw6Mqyp/fQefLpzg8G
	 wdZ0PE/DJ3aqz4hxPAy53TqIx2L5wSKfK5n3GRFbuiq6XWwlUvSyo5gBcH5hYoqXPG
	 MjuNTh9Zt8dK2y/pJsA6K5jRLX+DyJVYc+XBwb5npwxFnU6Tg5tJW+37C8v8Bly8tm
	 xAGkxk47sVjIiMklhP2bNpjIUHz4ummV0re5RGFKkE0hpc6l4oMmX042tikLqLgpwE
	 JgOoQ+b6LPL7g==
Date: Wed, 8 Oct 2025 21:18:34 +0100
From: Conor Dooley <conor@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	linux-iio@vger.kernel.org, joshua.yeong@starfivetech.com,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v5 4/5] dt-bindings: trivial-devices: add MEMSIC 3-axis
 magnetometer
Message-ID: <20251008-subtitle-estranged-b35dfcd2d3a7@spud>
References: <20251007-i3c_ddr-v5-0-444184f7725e@nxp.com>
 <20251007-i3c_ddr-v5-4-444184f7725e@nxp.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sqGdDHF1UKLk1vs2"
Content-Disposition: inline
In-Reply-To: <20251007-i3c_ddr-v5-4-444184f7725e@nxp.com>


--sqGdDHF1UKLk1vs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 07, 2025 at 04:06:16PM -0400, Frank Li wrote:
> Add compatible string 'memsic,mmc5603' and 'memsic,mmc5633' for
> MEMSIC 3-axis magnetometer.
>=20
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>
--
pw-bot: handled-elsewhere

> ---
> Changes in v4
> - add memsic,mmc5603
>=20
> Changes from v1 .. v3
> - None
> ---
>  Documentation/devicetree/bindings/trivial-devices.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Doc=
umentation/devicetree/bindings/trivial-devices.yaml
> index 7609acaa752d5c1c89a26bb007fa38357dee1a28..72786eebfbd63beffd2a09fc2=
0c7aedbe9e96a8e 100644
> --- a/Documentation/devicetree/bindings/trivial-devices.yaml
> +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
> @@ -225,6 +225,10 @@ properties:
>            - meas,tsys01
>              # MEMSIC magnetometer
>            - memsic,mmc35240
> +            # MEMSIC 3-axis magnetometer
> +          - memsic,mmc5603
> +            # MEMSIC 3-axis magnetometer (Support I3C HDR)
> +          - memsic,mmc5633
>              # MEMSIC 3-axis accelerometer
>            - memsic,mxc4005
>              # MEMSIC 2-axis 8-bit digital accelerometer
>=20
> --=20
> 2.34.1
>=20

--sqGdDHF1UKLk1vs2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaObHGQAKCRB4tDGHoIJi
0kYFAQDlJRBo3V6un4TdXGebaBOYpaei0g/okMdZdefOo2s6WAEA7JKupNoV9yYg
TZOT/iUlzA563LqVO58o6aXWJEQGyQk=
=vzKo
-----END PGP SIGNATURE-----

--sqGdDHF1UKLk1vs2--

