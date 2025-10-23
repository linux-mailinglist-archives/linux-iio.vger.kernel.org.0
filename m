Return-Path: <linux-iio+bounces-25394-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A7EC02E81
	for <lists+linux-iio@lfdr.de>; Thu, 23 Oct 2025 20:24:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AE05E4EDA6D
	for <lists+linux-iio@lfdr.de>; Thu, 23 Oct 2025 18:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A30277035;
	Thu, 23 Oct 2025 18:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PjLi82qd"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD2615E8B;
	Thu, 23 Oct 2025 18:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761243862; cv=none; b=OeQwCEd0F9k+SdRfRVGxPuxY8A7HUyCdETRS0xBLPsfwJSTNY0Nmbw4GApbJCreAyDgto0YxIIMdQApJpUHWkdX/HXDgHwsHn7z/yLWHadS8UWRv+zKr2OktWpG9Qo3NHQDLS2PqjsQgp0ZGre2YMyXiF4+/kztQnQZ5H7aGsO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761243862; c=relaxed/simple;
	bh=/z+wbEqHml870uP8Vygkb4HC/BUPbd7Qb90vg7kU96M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sfAjoQUrv8XIkH6X+VPbIZQC7uOOkLod9tUDRMu7rGy3VPb1GT5pJE7VAX+JROHKTQEgk7jzU0xNZNK+xVd2D13MSN11yivs2wOgbKRSghmj1Fdondem9nGejoZpvnQ3IroTdfjxwvW1dsv+4DftvRSup/PEGcTCOyKZIGrVmFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PjLi82qd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16C70C4CEE7;
	Thu, 23 Oct 2025 18:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761243862;
	bh=/z+wbEqHml870uP8Vygkb4HC/BUPbd7Qb90vg7kU96M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PjLi82qdMWoglRg6on/2h/a2ymK7DKjUbIJMBQYq81QJa7o0/YPaC2Ox+BV36NHJn
	 HZe2zErkO2lHJ6wkTiCttrspOpFojm4rgpm/PC/aidskeCMQVoP5ZoXhJz8OkHn714
	 CX+PDl9a4pcXd/rz7aViNphKDxVuT8PbxDRh34nUOeyL/UIXqoi3l8g0gEcgJPjkJp
	 NLEfJE6FVRFgucObQzAbjaiiJOOv8qxeEZkFBCg+iaE33dfXT0l2GGQjSWfU9rOgbp
	 9jyCqDpLH5rvUAN3Ya8YicS6ckYOY99r3OEh5YGEspIFWqXx/G7K1H/BxL+eWI3/L4
	 FEBidfF0mUctQ==
Date: Thu, 23 Oct 2025 19:24:17 +0100
From: Conor Dooley <conor@kernel.org>
To: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: iio: dac: Document AD5446 and
 similar devices
Message-ID: <20251023-food-say-5e396be087af@spud>
References: <20251023-ad5446-bindings-v2-0-27fab9891e86@analog.com>
 <20251023-ad5446-bindings-v2-1-27fab9891e86@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="i5ohlADzVjFuLFFH"
Content-Disposition: inline
In-Reply-To: <20251023-ad5446-bindings-v2-1-27fab9891e86@analog.com>


--i5ohlADzVjFuLFFH
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 02:01:37PM +0300, Nuno S=E1 wrote:
> Add device tree binding documentation for the Analog Devices AD5446
> family of Digital-to-Analog Converters and compatible devices from
> Texas Instruments. There's both SPI and I2C interfaces and feature
> resolutions ranging from 8-bit to 16-bit.
>=20
> The binding covers 29 compatible devices including the AD5446 series,

If they're compatible, how come there's no fallback use? Just to keep
things consistent with how they've always been while probing as spi
child devices?

Conor.

> AD5600 series, AD5620/5640/5660 variants with different voltage ranges,
> and TI DAC081s101/DAC101s101/DAC121s101 devices.
>=20
> Signed-off-by: Nuno S=E1 <nuno.sa@analog.com>
> ---
>  .../devicetree/bindings/iio/dac/adi,ad5446.yaml    | 138 +++++++++++++++=
++++++
>  MAINTAINERS                                        |   8 ++
>  2 files changed, 146 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5446.yaml b/=
Documentation/devicetree/bindings/iio/dac/adi,ad5446.yaml
> new file mode 100644
> index 000000000000..90fc8ca053fe
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5446.yaml
> @@ -0,0 +1,138 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/dac/adi,ad5446.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices AD5446 and similar DACs
> +
> +maintainers:
> +  - Michael Hennerich <michael.hennerich@analog.com>
> +  - Nuno S=E1 <nuno.sa@analog.com>
> +
> +description: |
> +  Digital to Analog Converter devices supporting both SPI and I2C interf=
aces.
> +  These devices feature a range of resolutions from 8-bit to 16-bit.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - description: SPI DACs
> +        enum:
> +          - adi,ad5300
> +          - adi,ad5310
> +          - adi,ad5320
> +          - adi,ad5444
> +          - adi,ad5446
> +          - adi,ad5450
> +          - adi,ad5451
> +          - adi,ad5452
> +          - adi,ad5453
> +          - adi,ad5512a
> +          - adi,ad5541a
> +          - adi,ad5542
> +          - adi,ad5542a
> +          - adi,ad5543
> +          - adi,ad5553
> +          - adi,ad5600
> +          - adi,ad5601
> +          - adi,ad5611
> +          - adi,ad5621
> +          - adi,ad5641
> +          - adi,ad5620-2500
> +          - adi,ad5620-1250
> +          - adi,ad5640-2500
> +          - adi,ad5640-1250
> +          - adi,ad5660-2500
> +          - adi,ad5660-1250
> +          - adi,ad5662
> +          - ti,dac081s101
> +          - ti,dac101s101
> +          - ti,dac121s101
> +      - description: I2C DACs
> +        enum:
> +          - adi,ad5301
> +          - adi,ad5311
> +          - adi,ad5321
> +          - adi,ad5602
> +          - adi,ad5612
> +          - adi,ad5622
> +
> +  reg:
> +    maxItems: 1
> +
> +  vcc-supply:
> +    description:
> +      Reference voltage supply. If not supplied, devices with internal
> +      voltage reference will use that.
> +
> +required:
> +  - compatible
> +  - reg
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - adi,ad5300
> +              - adi,ad5310
> +              - adi,ad5320
> +              - adi,ad5444
> +              - adi,ad5446
> +              - adi,ad5450
> +              - adi,ad5451
> +              - adi,ad5452
> +              - adi,ad5453
> +              - adi,ad5512a
> +              - adi,ad5541a
> +              - adi,ad5542
> +              - adi,ad5542a
> +              - adi,ad5543
> +              - adi,ad5553
> +              - adi,ad5600
> +              - adi,ad5601
> +              - adi,ad5611
> +              - adi,ad5621
> +              - adi,ad5641
> +              - adi,ad5620-2500
> +              - adi,ad5620-1250
> +              - adi,ad5640-2500
> +              - adi,ad5640-1250
> +              - adi,ad5660-2500
> +              - adi,ad5660-1250
> +              - adi,ad5662
> +              - ti,dac081s101
> +              - ti,dac101s101
> +              - ti,dac121s101
> +    then:
> +      allOf:
> +        - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    spi {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        dac@0 {
> +            compatible =3D "adi,ad5446";
> +            reg =3D <0>;
> +            vcc-supply =3D <&dac_vref>;
> +        };
> +    };
> +  - |
> +    i2c {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        dac@42 {
> +            compatible =3D "adi,ad5622";
> +            reg =3D <0x42>;
> +            vcc-supply =3D <&dac_vref>;
> +        };
> +    };
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 940889b158eb..dae04c308975 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -440,6 +440,14 @@ W:	http://wiki.analog.com/AD5398
>  W:	https://ez.analog.com/linux-software-drivers
>  F:	drivers/regulator/ad5398.c
> =20
> +AD5456	DAC DRIVER
> +M:	Michael Hennerich <michael.hennerich@analog.com>
> +M:	Nuno S=E1 <nuno.sa@analog.com>
> +L:	linux-iio@vger.kernel.org
> +S:	Supported
> +W:	https://ez.analog.com/linux-software-drivers
> +F:	Documentation/devicetree/bindings/iio/dac/adi,ad5446.yaml
> +
>  AD714X CAPACITANCE TOUCH SENSOR DRIVER (AD7142/3/7/8/7A)
>  M:	Michael Hennerich <michael.hennerich@analog.com>
>  S:	Supported
>=20
> --=20
> 2.34.1
>=20

--i5ohlADzVjFuLFFH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaPpy0QAKCRB4tDGHoIJi
0gcKAQCCEzkAiEG8hgc7lrZHxGRmyvmaSuFP3RYR0N9Bz2PykQD/fRHgjKclHDI8
nwXa920lU7k0wbpA3FQMS5itW6C3vgw=
=afCF
-----END PGP SIGNATURE-----

--i5ohlADzVjFuLFFH--

