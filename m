Return-Path: <linux-iio+bounces-7788-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE60E939294
	for <lists+linux-iio@lfdr.de>; Mon, 22 Jul 2024 18:32:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07129B2160B
	for <lists+linux-iio@lfdr.de>; Mon, 22 Jul 2024 16:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A9016EB71;
	Mon, 22 Jul 2024 16:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k/zBGla2"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D9D16E898;
	Mon, 22 Jul 2024 16:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721665932; cv=none; b=p7UsSZl/CnSZLwF5Zz/Oj6InibmWjK+sv79LUO7WsKfy0q608pTq9LsybzTVRgLhq5uM0A++UqA65NnH7UJ7kvu/qWZjzBr11cLUvRw3uNGb5GyO1/E79KktXXYo/wyPPo11f4nO+g8jm1Jb8LTjLkFyloGmfMOLxiwvFzR+fEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721665932; c=relaxed/simple;
	bh=iuxYF76BWen5oelQAVza+RGmuADg2hrhOBQc2xTCn1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LwGZEeqIfz1HxuWaXRus1ah9SAch3pM56IpHe1eQIbe8z9YypHrmuiT5Jk98OJiS6zTf90paz7uoXcgJFRHR+KGL02DCM+PfcdiTgOGrNwdErIP79dmwxqWRq65vILnzT2Z8q3kyo9hatm82DXI2FE1dG1G44vXT7WlclUjJYaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k/zBGla2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1937EC116B1;
	Mon, 22 Jul 2024 16:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721665932;
	bh=iuxYF76BWen5oelQAVza+RGmuADg2hrhOBQc2xTCn1Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k/zBGla2VfG1JyquNRs4F0vi6HUYdyEsBsORyO0iKtrdSRSLK/AyzdPPqId0NN1om
	 EWUchZFvgItvFZDU0++lydCJDOYeJzibWu52dOFqAkktPlThKg+XVp2ccdCuCmYwG9
	 HMYGb6Ew0nXwiybCQ2PH0pmpBd42EO9lXldh/WnAwlfMWEc3H6EB2+lu3dOx+Q7nlr
	 0moztlT6aOYebW7KR+bqsd675/YHTBMV4VRZ8UvWFmZX9BfJJuUDbdKJ45/D3HwdFA
	 vrCVYjMnukmFZqjMyywLBO3lCEzc7T4C1+KeS8xvLAt6RJgbQIcW5BygvGzZ+w+Sd5
	 CrPsvd/1kkDBQ==
Date: Mon, 22 Jul 2024 17:32:08 +0100
From: Conor Dooley <conor@kernel.org>
To: Matteo Martelli <matteomartelli3@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marius Cristea <marius.cristea@microchip.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] dt-bindings: iio: adc: add binding for pac1921
Message-ID: <20240722-squire-amply-15d761c0ec10@spud>
References: <20240722-iio-pac1921-v3-0-05dc9916cb33@gmail.com>
 <20240722-iio-pac1921-v3-1-05dc9916cb33@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Ufgd4XPcO7ajK7Ys"
Content-Disposition: inline
In-Reply-To: <20240722-iio-pac1921-v3-1-05dc9916cb33@gmail.com>


--Ufgd4XPcO7ajK7Ys
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 22, 2024 at 12:03:18PM +0200, Matteo Martelli wrote:
> Add binging for Microchip PAC1921 Power/Current monitor
>=20
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Matteo Martelli <matteomartelli3@gmail.com>
> ---
>  .../bindings/iio/adc/microchip,pac1921.yaml        | 71 ++++++++++++++++=
++++++
>  1 file changed, 71 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/microchip,pac1921.=
yaml b/Documentation/devicetree/bindings/iio/adc/microchip,pac1921.yaml
> new file mode 100644
> index 000000000000..b6f01b79b91d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/microchip,pac1921.yaml
> @@ -0,0 +1,71 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/microchip,pac1921.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Microchip PAC1921 High-Side Power/Current Monitor with Anaog Outp=
ut
> +
> +maintainers:
> +  - Matteo Martelli <matteomartelli3@gmail.com>
> +
> +description: |
> +  The PAC1921 is a power/current monitoring device with an analog output
> +  and I2C/SMBus interface.
> +
> +  Datasheet can be found here:
> +  https://ww1.microchip.com/downloads/en/DeviceDoc/PAC1921-Data-Sheet-DS=
20005293E.pdf
> +
> +properties:
> +  compatible:
> +    const: microchip,pac1921
> +
> +  reg:
> +    maxItems: 1
> +
> +  vdd-supply: true
> +
> +  "#io-channel-cells":
> +    const: 1
> +
> +  shunt-resistor-micro-ohms:
> +    description:
> +      Value in micro Ohms of the shunt resistor connected between
> +      the SENSE+ and SENSE- inputs, across which the current is measured.
> +      Value is needed to compute the scaling of the measured current.
> +
> +  label:
> +    description: Unique name to identify which device this is.
> +
> +  microchip,read-int-gpios:

IIRC, it is not required to have vendor prefixes on -gpios properties.
Otherwise, this all seems pretty reasonable to me.
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--Ufgd4XPcO7ajK7Ys
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZp6JhwAKCRB4tDGHoIJi
0mXIAQCb89FgV5uHesmmcAc9VfkL+Txv5+ntVpe/hbj3eY8MBAD/faHtk6v01RC8
QPjLI1uFzG5N6lLLeGpKI6r1z19utww=
=Co9Q
-----END PGP SIGNATURE-----

--Ufgd4XPcO7ajK7Ys--

