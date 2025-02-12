Return-Path: <linux-iio+bounces-15475-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B174A32F7C
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 20:20:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABC77167E99
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 19:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2557262163;
	Wed, 12 Feb 2025 19:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AcT8gh8J"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A731D5CCC;
	Wed, 12 Feb 2025 19:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739388007; cv=none; b=CaZY2ZzOUthzU8bnSIYCqlKVH47cIXcI7+amUB9wQhBYQTUBKpnPDp+RxdOhI9/BgRa7gUlmMASz295w+236oYVB+QSFyjk+A2ZfhiLCKgSstjKWIfT9fJzR0DuNKW6815hWZeieYSui27OjJ6tscnGrN/3WaKG/dcZyqaoyOX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739388007; c=relaxed/simple;
	bh=/+7+e/jvBGvPMsVtB+/kIZ1XYrpNImVdDnT7+1bEVHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XybMd9+1Jd7aC5mPiprEO5Tp1Jc4MOnmDL75BQIZHUSVu+dPIQ0YlW33yrvr/BC3Nb/VMNaGD/R7l5EObB3/6/jDjMUikb0ElDl/hiFkmgTj+9qvxgXUvT4YJvcVQx5Q0hzzmS92IC8MwIY/igPpwKNLBTpp0X/yDhYXQAxb/Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AcT8gh8J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A7B9C4CEE5;
	Wed, 12 Feb 2025 19:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739388007;
	bh=/+7+e/jvBGvPMsVtB+/kIZ1XYrpNImVdDnT7+1bEVHk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AcT8gh8JgwgRfEIT6E8hX/7mDnv7N5ycokXyJk/Avr1G+k7FYAHx+Bf7InCMzao56
	 oUD8IEL9vI/Xdig1Zw6w9IaZn7aaNoYelFEhpwnZAMJAQdNG/K3ip1ZfYCX7ma6KVI
	 TkiTlpnyy4pf5CJPS6+4NBzTVrzXE4E9usrirdFs84uq8mCToiDlNWQ66A8kMNLJey
	 zg255T9kUGxREaqXFMYyAl6ggBIosvLWVK5G422fH3H+5KPLe5iVoSlmpnD9IK7LIY
	 0v8Sogl7rHN7GIpn+pxNEaoGAaVu8/YWLhiTELLbHwTMkSQ6thhboAFPBm+O/hfhYK
	 hQJnK29ZaFlnA==
Date: Wed, 12 Feb 2025 19:20:00 +0000
From: Conor Dooley <conor@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Emil Gedenryd <emil.gedenryd@axis.com>,
	Arthur Becker <arthur.becker@sentec.com>,
	Mudit Sharma <muditsharma.info@gmail.com>,
	Per-Daniel Olsson <perdaniel.olsson@axis.com>,
	Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>,
	Ivan Orlov <ivan.orlov0322@gmail.com>,
	David Heidelberg <david@ixit.cz>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH v1 1/3] dt-bindings: iio: light: al3010: add al3000a
 support
Message-ID: <20250212-unwritten-compile-7011777a11b3@spud>
References: <20250212064657.5683-1-clamor95@gmail.com>
 <20250212064657.5683-2-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="LbItYNKzTdw8M51m"
Content-Disposition: inline
In-Reply-To: <20250212064657.5683-2-clamor95@gmail.com>


--LbItYNKzTdw8M51m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2025 at 08:46:55AM +0200, Svyatoslav Ryhel wrote:
> AL3000a is an ambient light sensor quite closely related to
> exising AL3010 and can re-use exising schema for AL3010.

Quite close you say, but the driver is entirely different it seems. How
closely related is the hardware itself?

>=20
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  .../devicetree/bindings/iio/light/dynaimage,al3010.yaml     | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/light/dynaimage,al3010=
=2Eyaml b/Documentation/devicetree/bindings/iio/light/dynaimage,al3010.yaml
> index a3a979553e32..6db4dfd5aa6c 100644
> --- a/Documentation/devicetree/bindings/iio/light/dynaimage,al3010.yaml
> +++ b/Documentation/devicetree/bindings/iio/light/dynaimage,al3010.yaml
> @@ -4,14 +4,16 @@
>  $id: http://devicetree.org/schemas/iio/light/dynaimage,al3010.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
> =20
> -title: Dyna-Image AL3010 sensor
> +title: Dyna-Image AL3000a/AL3010 sensor
> =20
>  maintainers:
>    - David Heidelberg <david@ixit.cz>
> =20
>  properties:
>    compatible:
> -    const: dynaimage,al3010
> +    enum:
> +      - dynaimage,al3010
> +      - dynaimage,al3000a
> =20
>    reg:
>      maxItems: 1
> --=20
> 2.43.0
>=20

--LbItYNKzTdw8M51m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ6z0YAAKCRB4tDGHoIJi
0j+dAP49r84HHxrbKXxQV5QNOkt9MHHKgzrCq9fZbRdxtpQLPwD/ZAuFVV674Yte
IXcQmPTqkS6v/K0PKZEkMjblXoKiiQE=
=2zvA
-----END PGP SIGNATURE-----

--LbItYNKzTdw8M51m--

