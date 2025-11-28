Return-Path: <linux-iio+bounces-26553-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DCA08C92FB0
	for <lists+linux-iio@lfdr.de>; Fri, 28 Nov 2025 19:56:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CE46A4E3BAB
	for <lists+linux-iio@lfdr.de>; Fri, 28 Nov 2025 18:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B17E92C3277;
	Fri, 28 Nov 2025 18:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u1QM8VQ6"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D792D0620;
	Fri, 28 Nov 2025 18:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764356157; cv=none; b=bay2cWxUElLNEnKNn7tmtWXFoYiGjFX/p2ZP0wWXcuW168H0UuJxNArsqkbHzbVOT4+xkwHYxK4y7p4tPol5xC9n413sY8oc/ulP61XjmjSdhuQ5Mnrm91GtpaPliD6zbdMNHWD78gPfs42hqNm0MZTUkrdshUs9Cp8KKaNFKEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764356157; c=relaxed/simple;
	bh=hyie6P9EaJ0NKDV9t8Ekku21uHrWOUai2S3ZBSnIKiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jZk3mTjApRFhWv2dM2pqa9Ca7Jogbb945ijjo96tzNBnLJja28POXvmwS+49fMkvwiENbLSt5vawTVSTf7NKAGxDVORYWZ6KqZBR+u4A5D8qS+rCoROkPqyhPSE09C7fGrwYk3VS4El5cMXAp7oz0f0gWLW6qsUnTFClv7r3igI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u1QM8VQ6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BF0FC4CEF1;
	Fri, 28 Nov 2025 18:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764356157;
	bh=hyie6P9EaJ0NKDV9t8Ekku21uHrWOUai2S3ZBSnIKiE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u1QM8VQ62wQZklrFKocM2Vyz5LuEi5qxrWqulQKovtBfjXaySompWxgWPqwYZzkoW
	 epdEKhoL+k7ko0bKVAvaKNZZBf6XZTBzFc6pw5jzCzDjFIeIaMZh94ikXSTZ6YpT6x
	 kxVa6ktgiysGz1/PFUoxoEWehgcJO/GVvt9XusLAsZSB5EfLEZpeSMCd+0Igwh/Im8
	 YSYB6+N9eCFxiB6iiCQE4JxxTDtx/BYV1r043NtOKWXirgHOo/Rv9yKJtQwthC/1iv
	 U+gPN9VAGguBMHjP7CbhcWqKaUOUuFcr44LMX763PZhUXG+j0gL/aAsA1lYWQ9DqNM
	 iq/pQ9C75Fagw==
Date: Fri, 28 Nov 2025 18:55:52 +0000
From: Conor Dooley <conor@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] dt-bindings: iio: amplifiers: add adl8113
Message-ID: <20251128-precision-outplayed-6148633ee669@spud>
References: <20251128144428.24450-1-antoniu.miclaus@analog.com>
 <20251128144428.24450-2-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="l9Y1Kiz8pfoFTBck"
Content-Disposition: inline
In-Reply-To: <20251128144428.24450-2-antoniu.miclaus@analog.com>


--l9Y1Kiz8pfoFTBck
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 28, 2025 at 04:44:10PM +0200, Antoniu Miclaus wrote:
> Add devicetree bindings for adl8113.
>=20
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
> Changes in v5:
> - Replace separate va-gpios and vb-gpios properties with single ctrl-gpio=
s array
> - Remove second example, keep only one with external bypass configuration
> - Add comments to external bypass gains in example
>=20
>  .../bindings/iio/amplifiers/adi,adl8113.yaml  | 89 +++++++++++++++++++
>  1 file changed, 89 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/amplifiers/adi,=
adl8113.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/iio/amplifiers/adi,adl8113=
=2Eyaml b/Documentation/devicetree/bindings/iio/amplifiers/adi,adl8113.yaml
> new file mode 100644
> index 000000000000..43ba51f8a235
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/amplifiers/adi,adl8113.yaml
> @@ -0,0 +1,89 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/amplifiers/adi,adl8113.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices ADL8113 Low Noise Amplifier with integrated bypass=
 switches
> +
> +maintainers:
> +  - Antoniu Miclaus <antoniu.miclaus@analog.com>
> +
> +description: |
> +  The ADL8113 is a 10MHz to 12GHz Low Noise Amplifier with integrated by=
pass
> +  switches controlled by two GPIO pins (VA and VB). The device supports =
four
> +  operation modes:
> +    - Internal Amplifier: VA=3D0, VB=3D0 - Signal passes through the int=
ernal LNA
> +    - Internal Bypass: VA=3D1, VB=3D1 - Signal bypasses through internal=
 path
> +    - External Bypass A: VA=3D0, VB=3D1 - Signal routes from RFIN to OUT=
_A and from IN_A to RFOUT
> +    - External Bypass B: VA=3D1, VB=3D0 - Signal routes from RFIN to OUT=
_B and from IN_B to RFOUT
> +
> +    https://www.analog.com/en/products/adl8113.html
> +
> +properties:
> +  compatible:
> +    const: adi,adl8113
> +
> +  vdd1-supply: true
> +
> +  vdd2-supply: true
> +
> +  vss2-supply: true
> +
> +  ctrl-gpios:
> +    description:
> +      GPIOs connected to the VA and VB control pins (in that order).
> +      Must be specified as GPIO_ACTIVE_HIGH.
> +    minItems: 2
> +    maxItems: 2

"maxItems: 2" should suffice here, minItems defaults to maxItems if not
specified. Although, this seems like it should be an items list, since
that avoids defining ordering in free-form text as you are.

pw-bot: changes-requested

Cheers,
Conor.

--l9Y1Kiz8pfoFTBck
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaSnwOAAKCRB4tDGHoIJi
0hqRAQC0MVCMTA66ZV44aeubvXf10Xr5mfE+FmJaBVw0c+86AQD+LZ9/1VAAxYYe
sfq9d8+OOed4+RwVMFNgC2JWOHGrLAI=
=KuNP
-----END PGP SIGNATURE-----

--l9Y1Kiz8pfoFTBck--

