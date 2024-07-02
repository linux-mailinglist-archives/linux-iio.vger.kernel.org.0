Return-Path: <linux-iio+bounces-7145-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 06AEE924269
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jul 2024 17:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3EC12B238BF
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jul 2024 15:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB9611BBBF7;
	Tue,  2 Jul 2024 15:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e8n+dS+o"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BF81BB6B4;
	Tue,  2 Jul 2024 15:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719934176; cv=none; b=iBHQlhKuXuE1fQghCP7XP3h24UYa0yShByzU5jIo5t+Fm2sy6bcbgmhAyORGRPzikbrkOz88yiXsHayyO6rPFTSdFmdGltNIuis2P6eMyuetuUcQB3zKigwVgeGnG5ulIgoXcwc4a0zrLNOPDbMDlWfvPPGI3AM/w4uv3HUxf+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719934176; c=relaxed/simple;
	bh=tB3pc/GAEvExlW3al+soe/qOIG4PU/9soU281deCYgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QW/VP0swEQLK5eBno0lQdqlgNg5/ScrIggMBaKpSr9K2aZiuSsYx/qpbh+Yoi3v9eZi4FWLh/oUjW2JWu1haaiJRzF9YgwNT3/DTkctIHeOVxDa+sPpbEWXAU5IIcZjR9mhI38sp9Qdvp4AK6rtv4/xZHb7mE8dJtUo3noqjHpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e8n+dS+o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67091C116B1;
	Tue,  2 Jul 2024 15:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719934176;
	bh=tB3pc/GAEvExlW3al+soe/qOIG4PU/9soU281deCYgE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e8n+dS+oHa2z7pxgVBzNhdKTkPa5wrUvYMtvSGiaaQbvpz0McLvy7mnvbF7TYToo5
	 GYDF0sb9ksSQLEJhV7d5oylcM3+MxXOlUQoD5IOPCRzZFCqTHcJz8a/UMl8Dbpbwz/
	 szUQWxkis/TVAHS2DBEcbW4XAGIJ9dKJ8E0R3JacpCL9ciQrKm7WCRLCySUtwQa0kx
	 Vir18XosmWJWf/Y1d/t3Pb7Nr8lV5i95LWXYfXLp35pSdS4pTFXiBbz+dKZ/uPLxzA
	 cEdw/7x5d1ex3tS0DS7tEChHw5xpd3Y0O+e3hR0eQXUpdwGIwJAmbvAl8DXpsbjBLg
	 9VYeRDPaWXrug==
Date: Tue, 2 Jul 2024 16:29:31 +0100
From: Conor Dooley <conor@kernel.org>
To: Kim Seer Paller <kimseer.paller@analog.com>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Dimitri Fedrau <dima.fedrau@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Subject: Re: [PATCH v5 3/6] dt-bindings: iio: dac: Generalize DAC common
 properties
Message-ID: <20240702-candied-heroism-beb1d66ca352@spud>
References: <20240702030025.57078-1-kimseer.paller@analog.com>
 <20240702030025.57078-4-kimseer.paller@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0XHM1JO8Q9wH9n7D"
Content-Disposition: inline
In-Reply-To: <20240702030025.57078-4-kimseer.paller@analog.com>


--0XHM1JO8Q9wH9n7D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 02, 2024 at 11:00:22AM +0800, Kim Seer Paller wrote:
> Introduce a generalized DAC binding that can be used by DACs that have
> similar properties adding output-range-microamp and output-range-microvol=
t.
>=20
> Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
> ---
>  .../devicetree/bindings/iio/dac/dac.yaml      | 50 +++++++++++++++++++
>  1 file changed, 50 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/dac/dac.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/iio/dac/dac.yaml b/Documen=
tation/devicetree/bindings/iio/dac/dac.yaml
> new file mode 100644
> index 000000000000..579f52ea6eb1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/dac/dac.yaml
> @@ -0,0 +1,50 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/dac/dac.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: IIO Common Properties for DAC Channels
> +
> +maintainers:
> +  - Jonathan Cameron <jic23@kernel.org>
> +
> +description:
> +  A few properties are defined in a common way DAC channels.

"for DAC channels"

> +anyOf:
> +  - oneOf:
> +      - required:
> +          - reg
> +          - output-range-microamp
> +      - required:
> +          - reg
> +          - output-range-microvolt
> +  - required:
> +      - reg

Can't this be more simply written as

oneOf:
  - required:
      - output-range-microamp
  - required:
      - output-range-microvolt

required:
 - reg

 ?

 Cheers,
 Conor.

--0XHM1JO8Q9wH9n7D
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZoQc2wAKCRB4tDGHoIJi
0gfHAQCLkMry3ePbCRVKB11k/ubc1q67WUShFIzn4Iu8YdBEjQD+KPITnMek9oRM
wwGqlBL2irq2mCFiq+x0CFHNs4kcrQ8=
=TEFP
-----END PGP SIGNATURE-----

--0XHM1JO8Q9wH9n7D--

