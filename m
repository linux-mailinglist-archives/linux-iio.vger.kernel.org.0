Return-Path: <linux-iio+bounces-10770-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D141F9A4D24
	for <lists+linux-iio@lfdr.de>; Sat, 19 Oct 2024 13:36:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 836BD2820D6
	for <lists+linux-iio@lfdr.de>; Sat, 19 Oct 2024 11:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C521DFE00;
	Sat, 19 Oct 2024 11:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WhYcqAjN"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9186218FDA3;
	Sat, 19 Oct 2024 11:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729337791; cv=none; b=nBZoGA2cNg3/RVRlKtIInfe4EMTijquIhRmXyssUA8YALXm7MtLE9E5sD8Pzvlsig3tB5VUr36A7xgUcqeA0+Rb6wssYN6lVkBZyD2G5xSP58sVKjY3t5iUQdwMslIg3l8kzAqSXGs3CMpPa1ppfgd5bsKPwo9As9thIu0mD62Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729337791; c=relaxed/simple;
	bh=AoYUksVy1/NcyqpEo/Od4emIysf0jcpyQy+I/XrN6Vw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qNRmye9CGNGl2uBoVoTnMZarh6C4EEOyjdXYvZeK+zlYdHd+mjOH+9Jvs1MKVxVnHyCEkNNDmIHNQIgNrDOQIHfEKr3MxLM2XUcMyNNjjWVWlzAfz+TcUwyDTt7xqTB9JVVPb35la7Du+uSKlQ5VjMiu1Su5tOYuV1AcUqPrYzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WhYcqAjN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3393C4CEC5;
	Sat, 19 Oct 2024 11:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729337791;
	bh=AoYUksVy1/NcyqpEo/Od4emIysf0jcpyQy+I/XrN6Vw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WhYcqAjN9ndlY0a1CVIXsefWOX9y4FlJHmtpcxYUG2UvSHLWI5hnB/+tDa6qGVOUk
	 7fXB0EmIh5MHMy12X/Bfuk0aYdplAH0qwfLRPgcdXseT4fKxRmhBTi6ld3ME1+mb+F
	 n+EiBChBu4qjOnMYzQl9Pwbjv6sIUyZVXMqDX1Y2cSnLOGkb4/iyr6jqbx/PrxUigZ
	 YLNNnGH+Hxh22YHl6JocYDjnYcZ3LBlYaQK6NtnG/jVfuuOI4vzv2Mm4vTWiKoCM+1
	 vnT9paIvD4N4WBBLsx2eneEGOgbRAgaBfnQkXP25Qzr4+EVfs/RBv3nNvq9Q2Tre0l
	 b2HQHmNZ5vpSA==
Date: Sat, 19 Oct 2024 12:36:23 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Justin Weiss <justin@justinweiss.com>
Cc: Alex Lanzano <lanzano.alex@gmail.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, "Derek J . Clark"
 <derekjohn.clark@gmail.com>, Philip =?UTF-8?B?TcO8bGxlcg==?=
 <philm@manjaro.org>
Subject: Re: [PATCH v2 3/6] dt-bindings: iio: imu: Add Bosch BMI260
Message-ID: <20241019123623.210ac09d@jic23-huawei>
In-Reply-To: <20241018233723.28757-4-justin@justinweiss.com>
References: <20241018233723.28757-1-justin@justinweiss.com>
	<20241018233723.28757-4-justin@justinweiss.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 18 Oct 2024 16:36:09 -0700
Justin Weiss <justin@justinweiss.com> wrote:

> Add devicetree description document for Bosch BMI260, a 6-Axis IMU.
>=20
> Signed-off-by: Justin Weiss <justin@justinweiss.com>
Looks like this would be much better as an additional compatible id
in the existing bosch,bmi270.yaml binding doc.

=46rom a quick comparison they look nearly identical.
Even if there are small differences the dt binding schema allows
those to be expressed in a single file.

Jonathan

> ---
>  .../bindings/iio/imu/bosch,bmi260.yaml        | 77 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 78 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/imu/bosch,bmi26=
0.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/iio/imu/bosch,bmi260.yaml =
b/Documentation/devicetree/bindings/iio/imu/bosch,bmi260.yaml
> new file mode 100644
> index 000000000000..6786b5e4d0fa
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/imu/bosch,bmi260.yaml
> @@ -0,0 +1,77 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/imu/bosch,bmi260.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Bosch BMI260 6-Axis IMU
> +
> +maintainers:
> +  - Justin Weiss <justin@justinweiss.com>
> +
> +description: |
> +  BMI260 is a 6-axis inertial measurement unit that can measure accelera=
tion and
> +  angular velocity. The sensor also supports configurable interrupt even=
ts such
> +  as motion detection and step counting. The sensor can communicate over
> +  I2C or SPI.
> +  https://www.bosch-sensortec.com/products/motion-sensors/imus/bmi260/
> +
> +properties:
> +  compatible:
> +    const: bosch,bmi260
> +
> +  reg:
> +    maxItems: 1
> +
> +  vdd-supply: true
> +  vddio-supply: true
> +
> +  interrupts:
> +    minItems: 1
> +    maxItems: 2
> +
> +  interrupt-names:
> +    minItems: 1
> +    maxItems: 2
> +    items:
> +      enum:
> +        - INT1
> +        - INT2
> +
> +  drive-open-drain:
> +    description:
> +      set if the specified interrupt pins should be configured as
> +      open drain. If not set, defaults to push-pull.
> +
> +  mount-matrix:
> +    description:
> +      an optional 3x3 mounting rotation matrix.
> +
> +required:
> +  - compatible
> +  - reg
> +  - vdd-supply
> +  - vddio-supply
> +
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    i2c {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        imu@68 {
> +            compatible =3D "bosch,bmi260";
> +            reg =3D <0x68>;
> +            vdd-supply =3D <&vdd>;
> +            vddio-supply =3D <&vddio>;
> +            interrupt-parent =3D <&gpio1>;
> +            interrupts =3D <16 IRQ_TYPE_EDGE_RISING>;
> +            interrupt-names =3D "INT1";
> +        };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6011af70c12e..73b6b7721dd8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4047,6 +4047,7 @@ BOSCH SENSORTEC BMI270 IMU IIO DRIVER
>  M:	Alex Lanzano <lanzano.alex@gmail.com>
>  L:	linux-iio@vger.kernel.org
>  S:	Maintained
> +F:	Documentation/devicetree/bindings/iio/imu/bosch,bmi260.yaml
>  F:	Documentation/devicetree/bindings/iio/imu/bosch,bmi270.yaml
>  F:	drivers/iio/imu/bmi270/
> =20


