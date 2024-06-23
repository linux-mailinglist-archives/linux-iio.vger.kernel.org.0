Return-Path: <linux-iio+bounces-6742-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75CDD913988
	for <lists+linux-iio@lfdr.de>; Sun, 23 Jun 2024 12:27:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37CF0282FE8
	for <lists+linux-iio@lfdr.de>; Sun, 23 Jun 2024 10:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 270A112D205;
	Sun, 23 Jun 2024 10:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P0Ekh5L/"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C219163D;
	Sun, 23 Jun 2024 10:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719138420; cv=none; b=XwwkdIZ8yMBgPyW8pHc3tMMOIXYc97zWyAN0eRHOVVomCyueZvco/ZvAyVt+FMftbVpHKaGad6pyK6KvQdJC+8A8qLjBztogf514gU6kY4lXamAJ6HwoHLy1nkEjvzJKTDZEefnyXfb5nJjtTbuT50HXQAqMogwuipw7B9rDUhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719138420; c=relaxed/simple;
	bh=Re7lgTywR+L12UXG91oTp5BPVhuOkLEgPrrb6/7KQZw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dpFxGxfhJiYPzX9HMJloILEOHfy778e7gmxTQAkQ5D5xMI+kGNOfSqNYVxCJa/N63z0rRLFdsiPe+wplDvwq7MmJZ2nnZlZ0sv7iCjD8yj55ir6Q1bUfCcUX3vmrtSnRGUseuaIjj56KYDkdi0nNgVYI8iKYNyLR5I7ALYa1UCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P0Ekh5L/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3226C2BD10;
	Sun, 23 Jun 2024 10:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719138420;
	bh=Re7lgTywR+L12UXG91oTp5BPVhuOkLEgPrrb6/7KQZw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=P0Ekh5L/FfCuBz1Tas/4dbfgQybES6dEyY0xZaGgq3K9FNmScffissyIZ3j+qGXJA
	 b+XJntMIMilm/JzTuAu+QNwrBvfIGXfLTY2LcP2VGWlYftIHnAZWKlFvHt84Ev2eLv
	 7s+KDB+kOLwywLN/L4b2JFFcQIjWRLwe41KIGcuey25toLzSe7bZdZRd/AlfkCAZ0+
	 BcjYHkCX/+oBQBkJlDzbcePUEAKa4tvKBrvBdFN6TISnq1wcCacaQLXPNyfNVQAZt0
	 7t93CzNJCs4xHEVnn10mISiqS7rpsHUnRTpl1FNlF4vbFo+ivmQw4QDlnLz7pgN94q
	 /I//VCrMPN03Q==
Date: Sun, 23 Jun 2024 11:26:49 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Ramona Gradinariu <ramona.gradinariu@analog.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Matti
 Vaittinen <mazziesaccount@gmail.com>, Jun Yan <jerrysteve1101@gmail.com>,
 Mehdi Djait <mehdi.djait.k@gmail.com>, Mario Limonciello
 <mario.limonciello@amd.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] dt-bindings: iio: accel: add ADXL380
Message-ID: <20240623112649.12d7ab80@jic23-huawei>
In-Reply-To: <20240621101756.27218-1-antoniu.miclaus@analog.com>
References: <20240621101756.27218-1-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 21 Jun 2024 13:17:03 +0300
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> From: Ramona Gradinariu <ramona.gradinariu@analog.com>
>=20
> Add dt-bindings for ADXL380/ADLX382 low noise density, low
> power, 3-axis accelerometer with selectable measurement ranges.
>=20
> Signed-off-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
>  .../bindings/iio/accel/adi,adxl380.yaml       | 83 +++++++++++++++++++
>  MAINTAINERS                                   |  7 ++
>  2 files changed, 90 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/accel/adi,adxl3=
80.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adxl380.yaml=
 b/Documentation/devicetree/bindings/iio/accel/adi,adxl380.yaml
> new file mode 100644
> index 000000000000..992e2ab841e2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/accel/adi,adxl380.yaml
> @@ -0,0 +1,83 @@
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
> +  supports the =C2=B14 g, =C2=B18 g, and =C2=B116 g ranges, and the ADXL=
382 supports
> +  =C2=B115 g, =C2=B130 g, and =C2=B160 g ranges.
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
> +
> +    https://www.analog.com/en/products/adxl380.html
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,adxl380
> +      - adi,adxl382
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1

Picture in the datasheet has 2.  If that's wrong note that for now and
remember to come back and update the comment when a real datasheet
becomes available.

> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
No power? Magic device :)

In all seriousness, I want all new bindings for IIO devices at least to
include the power supplies they require to operate and make them required
properties.
That datasheet is less than informative "Preliminary Data sheet", but it
does mention a few in the text. vsupply and vddio


> +
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    i2c {
> +      #address-cells =3D <1>;
> +      #size-cells =3D <0>;
> +
> +      accelerometer@54 {
> +        compatible =3D "adi,adxl380";
> +        reg =3D <0x54>;
> +        interrupt-parent =3D <&gpio>;
> +        interrupts =3D <25 IRQ_TYPE_LEVEL_HIGH>;
> +      };
> +    };
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    spi {
> +      #address-cells =3D <1>;
> +      #size-cells =3D <0>;
> +
> +      accelerometer@0 {
> +        compatible =3D "adi,adxl380";
> +        reg =3D <0>;
> +        spi-max-frequency =3D <8000000>;
> +        interrupt-parent =3D <&gpio>;
> +        interrupts =3D <25 IRQ_TYPE_LEVEL_HIGH>;
> +      };
> +    };
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
> +F:	Documentation/devicetree/bindings/iio/accel/adi,adxl380.yaml
> +
>  AF8133J THREE-AXIS MAGNETOMETER DRIVER
>  M:	Ond=C5=99ej Jirman <megi@xff.cz>
>  S:	Maintained


