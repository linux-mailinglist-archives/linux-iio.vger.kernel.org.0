Return-Path: <linux-iio+bounces-13747-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E34749FA639
	for <lists+linux-iio@lfdr.de>; Sun, 22 Dec 2024 15:48:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B682E165B8D
	for <lists+linux-iio@lfdr.de>; Sun, 22 Dec 2024 14:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C5B18F2EF;
	Sun, 22 Dec 2024 14:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WiB833vs"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E2018C928;
	Sun, 22 Dec 2024 14:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734878894; cv=none; b=YOsIvOGM4pxTyLHSN5bH43o0kTgvpF5IcahDsbmchSQvNwhZoFXjmPDI0g2s7+fy9Jzb79AUtkjeomaSBuK3Hravj7mZopEAoa3IwehYrhPwBug3ST4wHcPNGQxn6Zckl2BPScWnNemzwLAKy3SJNFRhGvlEnX/SWu0C5XjCnJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734878894; c=relaxed/simple;
	bh=0Q6YE583ngDtyCR8oWl2M6MxlCPJg1oyDVCPvo5XySM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S/XXYRLJowxun+fKrTsNgulZL8gPMU6U1rBCJuoXjN0euLLSkU+Nrt9d+60jYmwod7tvr4gTW8i+XfRjoGK6psJEXD0wdnvDq73Wq14Jhn27SDK0I6T2O3tSUbvlksFF6WFtYvTCX8wf5sQU6mCoO14yMwvDrdBCH+EfmK4+ab4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WiB833vs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B358C4CECD;
	Sun, 22 Dec 2024 14:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734878893;
	bh=0Q6YE583ngDtyCR8oWl2M6MxlCPJg1oyDVCPvo5XySM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WiB833vs0PmsOMHxMq7x/xn3KfQW16gJgE3102C5nH4pu+82sykAXNI5ji4oGPYzx
	 ATmYgCWbdGhyL3KkjPA7Gv5dXfxzv3eHS1PVaZ7E+2oCRatVu5peX/JtrPLvpffvF6
	 vn9beYAkGLZLMPUcQu8A/G9tV4NStFEQ2eq0dGHulEAgyiqWvmRefmmE2+6fUDMjbs
	 whu/q7L6NgJBSUlwDphPu0fKy9eyCMY2yOvZSIM//Lja436gmyyMwSTTHBsFbM4sIi
	 pl3BzNRBk0rsE3fakGw4jw7/d9inWgW+kO08d3jlBevhVIrY/hAE4v0jf2DXBNPBYm
	 FxIgGw0zpghHw==
Date: Sun, 22 Dec 2024 14:48:08 +0000
From: Conor Dooley <conor@kernel.org>
To: Alisa-Dariana Roman <alisadariana@gmail.com>
Cc: Alisa-Dariana Roman <alisa.roman@analog.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	David Lechner <dlechner@baylibre.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v1 2/3] dt-bindings: iio: adc: add AD7191
Message-ID: <20241222-sequester-mounted-42c0db97611f@spud>
References: <20241221155926.81954-1-alisa.roman@analog.com>
 <20241221155926.81954-3-alisa.roman@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nVlfLHwZ4yp7RbIs"
Content-Disposition: inline
In-Reply-To: <20241221155926.81954-3-alisa.roman@analog.com>


--nVlfLHwZ4yp7RbIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 21, 2024 at 05:56:01PM +0200, Alisa-Dariana Roman wrote:
> AD7191 is a pin-programmable, ultralow noise 24-bit sigma-delta ADC
> designed for precision bridge sensor measurements. It features two
> differential analog input channels, selectable output rates,
> programmable gain, internal temperature sensor and simultaneous
> 50Hz/60Hz rejection.
>=20
> Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
> ---
>  .../bindings/iio/adc/adi,ad7191.yaml          | 128 ++++++++++++++++++
>  MAINTAINERS                                   |   7 +
>  2 files changed, 135 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7191.=
yaml
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7191.yaml b/=
Documentation/devicetree/bindings/iio/adc/adi,ad7191.yaml
> new file mode 100644
> index 000000000000..f3e596918c22
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7191.yaml
> @@ -0,0 +1,128 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright 2025 Analog Devices Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/adi,ad7191.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices AD7191 ADC device driver
> +
> +maintainers:
> +  - Alisa-Dariana Roman <alisa.roman@analog.com>
> +
> +description: |
> +  Bindings for the Analog Devices AD7191 ADC device. Datasheet can be
> +  found here:
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/AD=
7191.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ad7191
> +
> +  reg:
> +    maxItems: 1
> +
> +  spi-cpol: true
> +
> +  spi-cpha: true
> +
> +  clocks:
> +    maxItems: 1
> +    description:
> +      Optionally, either a crystal can be attached externally between MC=
LK1 and
> +      MCLK2 pins, or an external CMOS-compatible clock can drive the MCL=
K2
> +      pin. If absent, internal 4.92MHz clock is used.

Without clock-names, how do you tell the difference between driven ctal and
the cmos-compatible clock? That CLKSEL's job?

> +
> +  interrupts:
> +    maxItems: 1
> +
> +  avdd-supply:
> +    description: AVdd voltage supply
> +
> +  dvdd-supply:
> +    description: DVdd voltage supply
> +
> +  vref-supply:
> +    description: Vref voltage supply
> +
> +  odr1-gpios:
> +    description: GPIO connected to ODR1 pin for output data rate selecti=
on
> +    maxItems: 1
> +
> +  odr2-gpios:
> +    description: GPIO connected to ODR2 pin for output data rate selecti=
on
> +    maxItems: 1
> +
> +  pga1-gpios:
> +    description: GPIO connected to PGA1 pin for gain selection
> +    maxItems: 1
> +
> +  pga2-gpios:
> +    description: GPIO connected to PGA2 pin for gain selection
> +    maxItems: 1
> +
> +  temp-gpios:
> +    description: GPIO connected to TEMP pin for temperature sensor enable
> +    maxItems: 1
> +
> +  chan-gpios:
> +    description: GPIO connected to CHAN pin for input channel selection
> +    maxItems: 1
> +
> +  clksel-gpios:
> +    description: GPIO connected to CLKSEL pin for clock source selection
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - avdd-supply
> +  - dvdd-supply
> +  - vref-supply
> +  - spi-cpol
> +  - spi-cpha

> +  - odr1-gpios
> +  - odr2-gpios
> +  - pga1-gpios
> +  - pga2-gpios

For these 4, since all are required, seems like grouping as odr-pgios
and pga-gpios would be a good idea?

--nVlfLHwZ4yp7RbIs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ2gmqAAKCRB4tDGHoIJi
0hZnAQDXgm3xU6b7wOsUl3ozFk8QS4leA2h3BIp+pSk67GrD7AEA5ce3h+nmK747
R7h59cG5ush1LQdxF4nLlufAtalVfAE=
=YtlD
-----END PGP SIGNATURE-----

--nVlfLHwZ4yp7RbIs--

