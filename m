Return-Path: <linux-iio+bounces-6988-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C34291AA78
	for <lists+linux-iio@lfdr.de>; Thu, 27 Jun 2024 17:06:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE42F289A3F
	for <lists+linux-iio@lfdr.de>; Thu, 27 Jun 2024 15:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF9AB19884D;
	Thu, 27 Jun 2024 15:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U6/AjJFA"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A030213A245;
	Thu, 27 Jun 2024 15:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719500767; cv=none; b=cSFdC6TdDPqOLVmgRH5AovASaXGhYmZa/pMsrZG3/CaABR+emwhMrwWBXid6uv3LdL/VZhDQskhoaGCq2y+sYePLMN4FtFbdKCe0G6Xg70WKEfQhsal3OHw2UDw1Tl0vxB4NDO/GPHYd3YlkY99/8NhMZe71cR2YJZHXyDGQJ3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719500767; c=relaxed/simple;
	bh=Djbrivkq0wc2jEsn+rTxgWDZpcBMsUplG+Wqu9mPo2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CJVO5BFm1k+EyoVp77BdFn92dF+U/El8vB6AW4UY3ozmWL1BCf2f4MvOAltmqKxU1ja+D2RTvgteEdCzCl+kvWlzypjq95949NG1YNtSv+Y7Dw3QkC4jAUoNdtcaDA94Ycha+dwYvuFV5A7263HIpDYJOg/YpjuWeVd10EmUkVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U6/AjJFA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE4CDC2BBFC;
	Thu, 27 Jun 2024 15:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719500767;
	bh=Djbrivkq0wc2jEsn+rTxgWDZpcBMsUplG+Wqu9mPo2g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U6/AjJFAW4WolWRAJvjof7CxpmtiX3kDNLeTk9ABltlygOqBrGDrYhzuqbdkx/eCF
	 xWGhx3JavgSEI3MSGiDZxV0XkpHbqTWKC1TNk3ATeg4148ft/pMMw4BLd1OJ5EaoDh
	 lJKDsimBob+/B/mPpw01RH35RvpRUDWm1fXOpr7mvLVc0Q4r2C/VkU9Q+8hdu9aCdV
	 +alapw+vuNIUqNPbGd7B0zfhDQsoGluza435rqEIVEFFZYN9y2O6ZHTGGiZAsbkZZm
	 NFvfZjnqorZiZJ7Cn6EpjMRAIL+el1Qt6DbEF+cnR51G7vfA7ZutVBH/7+8SwPYAlf
	 b8aLGpUerp4Aw==
Date: Thu, 27 Jun 2024 16:06:01 +0100
From: Conor Dooley <conor@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Ramona Gradinariu <ramona.gradinariu@analog.com>,
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Jun Yan <jerrysteve1101@gmail.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Mehdi Djait <mehdi.djait.k@gmail.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 1/3] dt-bindings: iio: accel: add ADXL380
Message-ID: <20240627-stiffly-annoying-f1f53fc432df@spud>
References: <20240627102617.24416-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0n+nOH0+6w7iTwZd"
Content-Disposition: inline
In-Reply-To: <20240627102617.24416-1-antoniu.miclaus@analog.com>


--0n+nOH0+6w7iTwZd
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 01:25:17PM +0300, Antoniu Miclaus wrote:
> Add dt-bindings for ADXL380/ADLX382 low noise density, low
> power, 3-axis accelerometer with selectable measurement ranges.
>=20
> Signed-off-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
> changes in v3:
>  - add power support
>  - add support for both interrupts
>  .../bindings/iio/accel/adi,adxl380.yaml       | 103 ++++++++++++++++++
>  MAINTAINERS                                   |   7 ++
>  2 files changed, 110 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/accel/adi,adxl3=
80.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adxl380.yaml=
 b/Documentation/devicetree/bindings/iio/accel/adi,adxl380.yaml
> new file mode 100644
> index 000000000000..55e25a9b31ac
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/accel/adi,adxl380.yaml
> @@ -0,0 +1,103 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/accel/adi,adxl380.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices ADXL380/382 3-Axis Digital Accelerometer
> +
> +maintainers:
> +  - Ramona Gradinariu <ramona.gradinariu@analog.com>
> +  - Antoniu Miclaus <antoniu.miclaus@analog.com>
> +
> +description: |
> +  The ADXL380/ADXL382 is a low noise density, low power, 3-axis
> +  accelerometer with selectable measurement ranges. The ADXL380
> +  supports the =B14 g, =B18 g, and =B116 g ranges, and the ADXL382 suppo=
rts
> +  =B115 g, =B130 g, and =B160 g ranges.
> +  The ADXL380/ADXL382 offers industry leading noise, enabling precision
> +  applications with minimal calibration. The low noise, and low power
> +  ADXL380/ADXL382 enables accurate measurement in an environment with
> +  high vibration, heart sounds and audio.
> +
> +  In addition to its low power consumption, the ADXL380/ADXL382 has
> +  many features to enable true system level performance. These
> +  include a built-in micropower temperature sensor, single / double /
> +  triple tap detection and a state machine to prevent a false
> +  triggering. In addition, the ADXL380/ADXL382 has provisions for
> +  external control of the sampling time and/or an external clock.

Please cull the marketing from the descriptions. "Industry leading" may
or may not be accurate at the time of going to print, but might be
completely incorrect in 5 years. Ditto "low power consumption".

With the marketing gone,
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

> diff --git a/MAINTAINERS b/MAINTAINERS
> index be590c462d91..1425182c85e2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -618,6 +618,13 @@ F:	drivers/iio/accel/adxl372.c
>  F:	drivers/iio/accel/adxl372_i2c.c
>  F:	drivers/iio/accel/adxl372_spi.c
> =20
> +ADXL380 THREE-AXIS DIGITAL ACCELEROMETER DRIVER
> +M:	Ramona Gradinariu <ramona.gradinariu@analog.com>
> +M:	Antoniu Miclaus <antoniu.miclaus@analog.com>
> +S:	Supported
> +W:	https://ez.analog.com/linux-software-drivers

Seems like having a website like
https://wiki.analog.com/resources/tools-software/linux-drivers/input-misc/a=
dxl345
would make more sense than a generic forum for all of your drivers?

--0n+nOH0+6w7iTwZd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZn1/2QAKCRB4tDGHoIJi
0j95AQDhJeGs/zhD0V7SpekjUWa7OBI/8gYbp6v6f23EddLZRwEAq9TJq+x1gWOb
QAmC4UOsxBMJ5TcKx9mPYL719tWz0g8=
=Li+x
-----END PGP SIGNATURE-----

--0n+nOH0+6w7iTwZd--

