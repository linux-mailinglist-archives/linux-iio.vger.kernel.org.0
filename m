Return-Path: <linux-iio+bounces-7503-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C1E92EBE1
	for <lists+linux-iio@lfdr.de>; Thu, 11 Jul 2024 17:44:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F0F31C21F69
	for <lists+linux-iio@lfdr.de>; Thu, 11 Jul 2024 15:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303BE16C687;
	Thu, 11 Jul 2024 15:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hvSASpCG"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCEA028FF;
	Thu, 11 Jul 2024 15:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720712643; cv=none; b=ocN6VWhsLPePtM0avEHK7p/Hps3TWv1TFDP7I2QDshzqeQxK6w2Dlis5VMwnBDkBOplJ/HY8Z+V3svDdMontn6RSOXXTLfHp1ruGyrFwPv2fTbK4+RdOCB3g8c+Mxf/aD0LefWwoxwk+Go3KUIVz71yISfrvwFrgwLzHH5RmHrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720712643; c=relaxed/simple;
	bh=6xTQR2Dbjcsm8mmLfND+qt+uG4caLnLxEYW9q0IhclA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hSgqywCjTIFSbOJ5kb9HIPKGcN0JAlZeicgdyaEbbju8Z7xL+C5bBHaiAxbDfzF7F5S8z8w+jyqMECJzm5/7x049ynQ66NRCIXj9Zdqke7SQW/5brDyEN4XLhi9lSUGuMMdwL8p5aEipCgIxUhN8IquZo1c21yxS6u/MtLjmJdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hvSASpCG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5E50C116B1;
	Thu, 11 Jul 2024 15:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720712642;
	bh=6xTQR2Dbjcsm8mmLfND+qt+uG4caLnLxEYW9q0IhclA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hvSASpCG+qlpSxPDAagbNeLae8GIo6nCRbVPtyf0j7PmqrLyyd7wRaSJxL8CbxXo4
	 kzk25/ZUtNlFmUramS4UNr22Rg3ZnXweD6R0YGFEV8Mgeyxb0tTpzkrtO+5VruJqPe
	 PxNFXSQ8yF9zbNu90uGCJ0iP44CEGbepG7we3zk11ijx8k13DMv1gC251DhPvs4KfG
	 7t9gPdVfoP6f2rk+ZNlpJCWZT2HJROpJ4jAMsvp1csdC9rvdLvGllEO2ZVFl1ewbHU
	 7whG72ZXbvrhFvwCx8chJFcqe0Rrn2Ib/ND1dAl9KLvsbT9C6fJc43g8O//G3tuYM6
	 MwEycof8W0ung==
Date: Thu, 11 Jul 2024 16:43:57 +0100
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
Subject: Re: [PATCH v6 3/6] dt-bindings: iio: dac: Generalize DAC common
 properties
Message-ID: <20240711-drew-skipper-a7a35e54ac2e@spud>
References: <20240711114221.62386-1-kimseer.paller@analog.com>
 <20240711114221.62386-4-kimseer.paller@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nV8N9lxMRcLUX4/B"
Content-Disposition: inline
In-Reply-To: <20240711114221.62386-4-kimseer.paller@analog.com>


--nV8N9lxMRcLUX4/B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 11, 2024 at 07:42:18PM +0800, Kim Seer Paller wrote:
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
> index 000000000000..a9787bbcd22b
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
> +  A few properties are defined in a common way for DAC channels.
> +
> +properties:
> +  $nodename:
> +    pattern: "^channel(@[0-9a-f]+)?$"
> +    description:
> +      A channel index should match reg.
> +
> +  reg:
> +    maxItems: 1
> +
> +  label:
> +    description: Unique name to identify which channel this is.
> +
> +  output-range-microamp:
> +    maxItems: 2
> +    minItems: 2
> +    description:
> +      Specify the channel output full scale range in microamperes.
> +
> +  output-range-microvolt:
> +    maxItems: 2
> +    minItems: 2
> +    description:
> +      Specify the channel output full scale range in microvolts.
> +
> +oneOf:
> +  - required:
> +      - reg
> +      - output-range-microamp
> +  - required:
> +      - reg
> +      - output-range-microvolt
> +
> +required:
> +  - reg

I think my suggestion was outright wrong, and caused Rob's bot to
complain. Go back to what you had and,
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--nV8N9lxMRcLUX4/B
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZo/9vQAKCRB4tDGHoIJi
0vgzAPsFjVELwbDRZbfWEeqEHWdExIjuX+WPWijY5EBS7Zi4sQD7B/BLM5JhPO2q
83li+n5FyWeNOuiIvwm00eSBPmH4Hgw=
=1bv1
-----END PGP SIGNATURE-----

--nV8N9lxMRcLUX4/B--

