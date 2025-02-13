Return-Path: <linux-iio+bounces-15506-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C40A34F51
	for <lists+linux-iio@lfdr.de>; Thu, 13 Feb 2025 21:24:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5322516D579
	for <lists+linux-iio@lfdr.de>; Thu, 13 Feb 2025 20:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 561A726618C;
	Thu, 13 Feb 2025 20:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DbuGESRK"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05EA5266180;
	Thu, 13 Feb 2025 20:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739478277; cv=none; b=foQInCzjSBrRwLdAGjq0dZed9HGzJJj7bea4e36ajeV8ExrdUFVZKeCq9MwMni8XUhw6tSXg71HteWNIu50TMdsPZFWbuHJlMWTmyNvBU/xMoKFqjrofuaqOaO/Ji/GXlEJgDgnvn9marLQmgOhQBxd2JAOVcVqfmT+ybvEKHGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739478277; c=relaxed/simple;
	bh=vgPyFYWzWxj67eo+xKZO/b/zcPiePnk59iJY0qxFk48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mAs9p7J0l+wLOktOISuH66yooSQRA1EX8HarPmNOaiT3vUVtqh4kA8hVsp8cGWBdQZ5teGutZDYpQfUzW6Ld13KZyiqRT8wOussYNMMRR4fsdlZzoCUxngOo/xHYl+OAMUqorduHITf43vrXTDHEUcFIViVHgvbWAHb5JsCSQio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DbuGESRK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08A9FC4CED1;
	Thu, 13 Feb 2025 20:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739478276;
	bh=vgPyFYWzWxj67eo+xKZO/b/zcPiePnk59iJY0qxFk48=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DbuGESRKL2HUhlkyJcEjlKwcN2lMcx2+FHQchLaWkvCA9RLjJOv+DafFgkjdwHZD7
	 nIJ6mFSvqj8V+mP3PcDq5ji1E0WTx0TPwc+gpB5TaCm8IFxnwM2jtRSdOQzWhtc6KU
	 CtWAA2NaJiv4G4pU3erClaOfKCvFlaWhbsLhYYO4+x2z9BCvUwps7JjHsbHnWcKhJy
	 zAU5g2/vU3pfsPDKs9IzTqYfb2H9GJVxo0KZ+e7jXVfuUSRre1sTvRiju6g1e9y8TD
	 k077WAGUvf7toENcahJOusSH8pm6sEAMTraRaXlSCBUXuxtWTjYM4AbYlu/qbJcZXv
	 kyxuaZtZ+1QDA==
Date: Thu, 13 Feb 2025 20:24:31 +0000
From: Conor Dooley <conor@kernel.org>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, lars@metafoo.de,
	Michael.Hennerich@analog.com, marcelo.schmitt@analog.com,
	jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, jonath4nns@gmail.com,
	marcelo.schmitt1@gmail.com, dlechner@baylibre.com
Subject: Re: [PATCH RESEND v3 03/17] dt-bindings: iio: adc: ad7768-1: add
 trigger-sources property
Message-ID: <20250213-sympathy-suspend-2c414b383195@spud>
References: <cover.1739368121.git.Jonathan.Santos@analog.com>
 <4136b5259df75221fc314bcd4a57ecaeeab41a45.1739368121.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="lWYe9Flar0M7C111"
Content-Disposition: inline
In-Reply-To: <4136b5259df75221fc314bcd4a57ecaeeab41a45.1739368121.git.Jonathan.Santos@analog.com>


--lWYe9Flar0M7C111
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2025 at 03:16:16PM -0300, Jonathan Santos wrote:
> In addition to GPIO synchronization, The AD7768-1 also supports
> synchronization over SPI, which use is recommended when the GPIO
> cannot provide a pulse synchronous with the base MCLK signal. It
> consists of looping back the SYNC_OUT to the SYNC_IN pin and send
> a command via SPI to trigger the synchronization.
>=20
> Add a new trigger-sources property to enable synchronization over SPI
> and future multiple devices support. This property references the
> main device (or trigger provider) responsible for generating the
> SYNC_OUT pulse to drive the SYNC_IN of device.
>=20
> While at it, add description to the interrupts property.
>=20
> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> ---
> v3 Changes:
> * Fixed dt-bindings errors.
> * Trigger-source is set as an alternative to sync-in-gpios, so we
>   don't break the previous ABI.
> * increased maxItems from trigger-sources to 2.
>=20
> v2 Changes:
> * Patch added as replacement for adi,sync-in-spi patch.
> * addressed the request for a description to interrupts property.
> ---
>  .../bindings/iio/adc/adi,ad7768-1.yaml        | 28 +++++++++++++++++--
>  1 file changed, 25 insertions(+), 3 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml =
b/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
> index 3ce59d4d065f..4bcc9e20fab9 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
> @@ -26,7 +26,19 @@ properties:
>    clock-names:
>      const: mclk
> =20
> +  trigger-sources:
> +    description:
> +      Specifies the device responsible for driving the synchronization p=
in,
> +      as an alternative to adi,sync-in-gpios. If the own device node is
> +      referenced, The synchronization over SPI is enabled and the SYNC_O=
UT
> +      output will drive the SYNC_IN pin.

Maybe a silly question, but why is self-reference needed here?
sync-in-gpios is a required property at present, so why can't you
operate under the assumption that neither the trigger-sources when
neither are present? Is it because only one of the sources could be
external and one internal, or there could be either one or two internal
sources? Self-referencing properties always feel like a bit of a
mistake.

> +    maxItems: 2
> +
>    interrupts:
> +    description:
> +      Specifies the interrupt line associated with the ADC. This refers
> +      to the DRDY (Data Ready) pin, which signals when conversion result=
s are
> +      available.
>      maxItems: 1
> =20
>    '#address-cells':
> @@ -57,6 +69,9 @@ properties:
>    "#io-channel-cells":
>      const: 1
> =20
> +  "#trigger-source-cells":
> +    const: 0
> +
>  required:
>    - compatible
>    - reg
> @@ -65,7 +80,6 @@ required:
>    - vref-supply
>    - spi-cpol
>    - spi-cpha
> -  - adi,sync-in-gpios
> =20
>  patternProperties:
>    "^channel@([0-9]|1[0-5])$":
> @@ -89,6 +103,13 @@ patternProperties:
>  allOf:
>    - $ref: /schemas/spi/spi-peripheral-props.yaml#
> =20
> +  - oneOf:
> +      - required:
> +          - trigger-sources
> +          - "#trigger-source-cells"
> +      - required:
> +          - adi,sync-in-gpios
> +
>  unevaluatedProperties: false
> =20
>  examples:
> @@ -99,7 +120,7 @@ examples:
>          #address-cells =3D <1>;
>          #size-cells =3D <0>;
> =20
> -        adc@0 {
> +        adc0: adc@0 {
>              compatible =3D "adi,ad7768-1";
>              reg =3D <0>;
>              spi-max-frequency =3D <2000000>;
> @@ -108,7 +129,8 @@ examples:
>              vref-supply =3D <&adc_vref>;
>              interrupts =3D <25 IRQ_TYPE_EDGE_RISING>;
>              interrupt-parent =3D <&gpio>;
> -            adi,sync-in-gpios =3D <&gpio 22 GPIO_ACTIVE_LOW>;
> +            trigger-sources =3D <&adc0 0>;
> +            #trigger-source-cells =3D <0>;
>              reset-gpios =3D <&gpio 27 GPIO_ACTIVE_LOW>;
>              clocks =3D <&ad7768_mclk>;
>              clock-names =3D "mclk";
> --=20
> 2.34.1
>=20

--lWYe9Flar0M7C111
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ65U/wAKCRB4tDGHoIJi
0pB+AQCP+31FGFpNu1bFN4d+aHlh06rWj+vxU4ClpJYE0eJ7OwD+M/sVq6WXXvz7
w2JeNL9Irj7zUuW6MgiG84wpjZ7I6Qc=
=tZHi
-----END PGP SIGNATURE-----

--lWYe9Flar0M7C111--

