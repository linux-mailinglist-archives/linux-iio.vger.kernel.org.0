Return-Path: <linux-iio+bounces-5464-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E6A8D3CF4
	for <lists+linux-iio@lfdr.de>; Wed, 29 May 2024 18:39:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7C852895AF
	for <lists+linux-iio@lfdr.de>; Wed, 29 May 2024 16:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C7A1A0AE9;
	Wed, 29 May 2024 16:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rRanmeFP"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0500194C74;
	Wed, 29 May 2024 16:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717000602; cv=none; b=lLtqQTRq3x8Dchdbsp1cG5mEVF7BaS8FGhsuIEAZoKdq9YwdXTy3QXfiqdAfMLLlOhDaWg5Q8TPU8nMIsIhdrJTeDKLfV9b732+QKpX0MyH3HbgF3c7gBhwULwppMFzlYKPJad8IRvvoJMAgoJhaFhRKKv2Z5Pus4LC0LbDABfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717000602; c=relaxed/simple;
	bh=JC6g/M6qRPJqv/6drYqZSNRhcfUkgXCmYwGsogaBb2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YL2XfbTtkbeLV9kKHn6CfE84tzXOqF7LBy8P2IJEi2DByfJ5lTXRc4Ql5o33jU39eNxzzn0hqZqvtNrqe3xnKRu2TesGo/+8DMfXnlMFZ176xEhi5utLmka1FCEjVtTPjbIFZxSlWyto7rE3UzSvv2+YjqYt7885Z4qktWrAcf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rRanmeFP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E602C32782;
	Wed, 29 May 2024 16:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717000602;
	bh=JC6g/M6qRPJqv/6drYqZSNRhcfUkgXCmYwGsogaBb2M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rRanmeFPv0NjPJWVcB9U7Dzelf12eFPkzPFTAQVUgjuEsKubR/GgP25NYmS5i2mx8
	 K8yj/1B0WnzB8Xa4uwrVwdA1z2Z8uhAh5oGzaZd11GKcD7JCIWLDSBzIgZUWjScLR1
	 6C3HPBou6VWFKzTx9JJDTCvtJCVpC79SBIL0wVygY51oODvRjuh/xc19Fho5USXceL
	 Lr7Ag/17XFQw5CEwvNZUXcWw33B0E0irAhBl7Apzzk+JWvGB+6GjCtc1N459UsPD1c
	 HkrsQ+AFmGed1L7nmBGcq1R8u4OzG0FdTnGwf+x5sDwCLYTd8j1IDityOjZ1YsIMQW
	 5R2iZsiSTptJg==
Date: Wed, 29 May 2024 17:36:38 +0100
From: Conor Dooley <conor@kernel.org>
To: Gustavo Silva <gustavograzs@gmail.com>
Cc: jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, lars@metafoo.de, christophe.jaillet@wanadoo.fr,
	devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/6] dt-bindings: iio: chemical: add ENS160 sensor
Message-ID: <20240529-upper-brisket-f326418bcfc2@spud>
References: <20240529001504.33648-1-gustavograzs@gmail.com>
 <20240529001504.33648-2-gustavograzs@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qWWuIHVqaicUKbf/"
Content-Disposition: inline
In-Reply-To: <20240529001504.33648-2-gustavograzs@gmail.com>


--qWWuIHVqaicUKbf/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 28, 2024 at 09:14:19PM -0300, Gustavo Silva wrote:
> Add bindings for ScioSense ENS160 multi-gas sensor.
>=20
> Datasheet: https://www.sciosense.com/wp-content/uploads/2023/12/ENS160-Da=
tasheet.pdf
>=20
> Signed-off-by: Gustavo Silva <gustavograzs@gmail.com>
> ---
> changes in v2:
>  - Add devicetree binding file specifically for this sensor instead of
>    adding it to trivial-devices.yaml. This is needed in order to
>    document that this chip supports Vdd and Vddio supplies.
>  .../iio/chemical/sciosense,ens160.yaml        | 68 +++++++++++++++++++
>  1 file changed, 68 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/chemical/sciose=
nse,ens160.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/iio/chemical/sciosense,ens=
160.yaml b/Documentation/devicetree/bindings/iio/chemical/sciosense,ens160.=
yaml
> new file mode 100644
> index 000000000..7dd442f94
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/chemical/sciosense,ens160.yaml
> @@ -0,0 +1,68 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/chemical/sciosense,ens160.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ScioSense ENS160 multi-gas sensor
> +
> +maintainers:
> +  - Gustavo Silva <gustavograzs@gmail.com>
> +
> +description: |
> +  Digital Multi-Gas Sensor for Monitoring Indoor Air Quality.
> +
> +  Datasheet:
> +    https://www.sciosense.com/wp-content/uploads/2023/12/ENS160-Datashee=
t.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - sciosense,ens160
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  vdd-supply: true
> +  vddio-supply: true
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    i2c {
> +      #address-cells =3D <1>;
> +      #size-cells =3D <0>;
> +
> +      gas-sensor@52 {
> +        compatible =3D "sciosense,ens160";
> +        reg =3D <0x52>;
> +        interrupt-parent =3D <&gpio0>;
> +        interrupts =3D <19 IRQ_TYPE_EDGE_FALLING>;
> +      };
> +    };
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    spi {
> +      #address-cells =3D <1>;
> +      #size-cells =3D <0>;
> +
> +      gas-sensor@0 {
> +        compatible =3D "sciosense,ens160";
> +        reg =3D <0>;
> +        spi-max-frequency =3D <10000000>;

If you want to include this, you need to add an
allOf:
  - $ref: /schemas/spi/spi-peripheral-props.yaml#
above. Otherwise this looks pretty good, so with that added
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--qWWuIHVqaicUKbf/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZldZlgAKCRB4tDGHoIJi
0g03AQD9mMzRxuq5lalKfEVAFTGZoMACZkTJNATWvobYmPeI1gD8DdGZHwZmmO2G
xQRJoSkgZK6Dq33FTVKRxp1vaIJqWgw=
=kMRI
-----END PGP SIGNATURE-----

--qWWuIHVqaicUKbf/--

