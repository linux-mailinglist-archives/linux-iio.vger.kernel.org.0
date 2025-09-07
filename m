Return-Path: <linux-iio+bounces-23833-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12416B47A22
	for <lists+linux-iio@lfdr.de>; Sun,  7 Sep 2025 11:37:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8030520291E
	for <lists+linux-iio@lfdr.de>; Sun,  7 Sep 2025 09:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 418B9221FD4;
	Sun,  7 Sep 2025 09:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iRyCbp/x"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2AC221FB1;
	Sun,  7 Sep 2025 09:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757237787; cv=none; b=eKCDhZhHPQalAn872Cl2BAeeb+ixf2pmAtxY5ujLpCP/qSJpYXjcimn+8Fxzs5Hgmu+pQQLWDJXmkegtM++XK8i1cJGro1xOE9lzw/s4RmxE35ZV9V9+U+xvn6ZVp7Rwa2YDJNWo1DleEQEoD5G7zuocYnKKjbhdkkyYPswLWhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757237787; c=relaxed/simple;
	bh=iLGBcFXDZOBbyHVcVJJlbKkvrBO0iFZ6GaMiwpV8uVI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zm+XYBwhe0C4P5olPAMQ0oyZEafnzkJKkpKUkXHS8QkQfWUKkDFvry4pfC2R869tGdABpk2hbUUl8j4Qd8wDVD1mSrdcGJlf1S88qlMY5SnRIm6wKrweEKYs+merdaX8VRPLOJ9APSWNXIEvh+IYUfEH1dL5D2s80gLAd3YTa78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iRyCbp/x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A25BC4CEF0;
	Sun,  7 Sep 2025 09:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757237786;
	bh=iLGBcFXDZOBbyHVcVJJlbKkvrBO0iFZ6GaMiwpV8uVI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iRyCbp/x00QIJfOHsl8x4t1yDVC5344JdJY6kBKjzLNGOLK/PboptE+FMxfcGxHsL
	 +zD9uZ9GpUcO/WAGm0FnJdWgywu+Fkg3S7OeLfPc3sQXx6pwhZJa7C1KFhV49yRoN1
	 z1l8T6/Sb7KtLK1FTeh6YKtUvGGO6W0k8iRI1xGL0rG1gu4kPh7Qz2Ygf1UHHNDQSc
	 30NgBZerulmHou68w9nublm6v6taJeyPwLZVF+SOwhJyNROlAFOwMP5/57ozf8O2mc
	 CE2cEUVjJ1s7MAZfvzhpInCH+5hI8fPI8icFWbdbunkhfFJM9RpU+jHUpZExzJMd2a
	 F6ENY8oNlvIjA==
Date: Sun, 7 Sep 2025 10:36:17 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Dixit Parmar <dixitparmar19@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v6 1/2] dt-bindings: iio: magnetometer: Infineon TLV493D
 3D Magnetic sensor
Message-ID: <20250907103617.5400c1bb@jic23-huawei>
In-Reply-To: <20250906-tlv493d-sensor-v6_16-rc5-v6-1-b1a62d968353@gmail.com>
References: <20250906-tlv493d-sensor-v6_16-rc5-v6-0-b1a62d968353@gmail.com>
	<20250906-tlv493d-sensor-v6_16-rc5-v6-1-b1a62d968353@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 06 Sep 2025 14:07:56 +0530
Dixit Parmar <dixitparmar19@gmail.com> wrote:

> Document the bindings for Infineon TLV493D Low-Power 3D Magnetic Sensor
> controlled by I2C interface. Main applications includes joysticks, control
> elements (white goods, multifunction knops), or electric meters (anti-
> tampering).
> Drop duplicate entry for infineon,tlv493d from trivial-devices.yaml as
> its documented in this separate dt-binding file now.
> 
> Datasheet: https://www.infineon.com/assets/row/public/documents/24/49/infineon-tlv493d-a1b6-datasheet-en.pdf
> Signed-off-by: Dixit Parmar <dixitparmar19@gmail.com>

Krzysztof gave an RB on version 3.  Please make sure to pick up such tags.

This time I'll apply it by hand if nothing else comes up.

Jonathan

> ---
>  .../iio/magnetometer/infineon,tlv493d-a1b6.yaml    | 45 ++++++++++++++++++++++
>  .../devicetree/bindings/trivial-devices.yaml       |  2 -
>  MAINTAINERS                                        |  7 ++++
>  3 files changed, 52 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/magnetometer/infineon,tlv493d-a1b6.yaml b/Documentation/devicetree/bindings/iio/magnetometer/infineon,tlv493d-a1b6.yaml
> new file mode 100644
> index 000000000000..dd23a9370a71
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/magnetometer/infineon,tlv493d-a1b6.yaml
> @@ -0,0 +1,45 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/magnetometer/infineon,tlv493d-a1b6.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Infineon Technologies TLV493D Low-Power 3D Magnetic Sensor
> +
> +maintainers:
> +  - Dixit Parmar <dixitparmar19@gmail.com>
> +
> +properties:
> +  $nodename:
> +    pattern: '^magnetometer@[0-9a-f]+$'
> +
> +  compatible:
> +    const: infineon,tlv493d-a1b6
> +
> +  reg:
> +    maxItems: 1
> +
> +  vdd-supply:
> +    description: 2.8V to 3.5V VDD supply
> +
> +  interrupts:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - vdd-supply
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +      magnetometer@5e {
> +        compatible = "infineon,tlv493d-a1b6";
> +        reg = <0x5e>;
> +        vdd-supply = <&hall_vcc>;
> +      };
> +    };
> diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
> index 27930708ccd5..9e0eb5c873d2 100644
> --- a/Documentation/devicetree/bindings/trivial-devices.yaml
> +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
> @@ -125,8 +125,6 @@ properties:
>            - infineon,ir36021
>              # Infineon IRPS5401 Voltage Regulator (PMIC)
>            - infineon,irps5401
> -            # Infineon TLV493D-A1B6 I2C 3D Magnetic Sensor
> -          - infineon,tlv493d-a1b6
>              # Infineon Hot-swap controller xdp710
>            - infineon,xdp710
>              # Infineon Multi-phase Digital VR Controller xdpe11280
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fad6cb025a19..35990c2701f6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11843,6 +11843,13 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/sound/infineon,peb2466.yaml
>  F:	sound/soc/codecs/peb2466.c
>  
> +INFINEON TLV493D Driver
> +M:	Dixit Parmar <dixitparmar19@gmail.com>
> +L:	linux-iio@vger.kernel.org
> +S:	Maintained
> +W:	https://www.infineon.com/part/TLV493D-A1B6
> +F:	Documentation/devicetree/bindings/iio/magnetometer/infineon,tlv493d-a1b6.yaml
> +
>  INFINIBAND SUBSYSTEM
>  M:	Jason Gunthorpe <jgg@nvidia.com>
>  M:	Leon Romanovsky <leonro@nvidia.com>
> 


