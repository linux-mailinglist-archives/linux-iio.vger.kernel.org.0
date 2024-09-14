Return-Path: <linux-iio+bounces-9579-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B1CB497921A
	for <lists+linux-iio@lfdr.de>; Sat, 14 Sep 2024 18:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11EC3B21356
	for <lists+linux-iio@lfdr.de>; Sat, 14 Sep 2024 16:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 443B91D04B0;
	Sat, 14 Sep 2024 16:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PJirW4j8"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE17C2B2F2;
	Sat, 14 Sep 2024 16:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726331939; cv=none; b=pLjWPQJTOAgaAieKe+yGDWFbuU4CB99ICKTN9J3RVhGoNO48LE+6zlqgUtHMr+OBl41kI6i24AtbJSkSooq/H6WEuJON6MipDybQ1b9wbzHNXJkl278T5sg2Ogq9xclRaqAlKMTDY2l/I2MWobSVf7VTD9cgzmQHihB06+1TvXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726331939; c=relaxed/simple;
	bh=Y7psSIfNe3ZXhkf8ipeBmKl43s6ocj72i+/+qJlZG1U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iM+Wqv3Mq5LVucOImiHViIyH0gp7XTMV2B8MobdX5R2iek+Ac8B3/oEBBEmzlUYaP2F/yA1yUoePiiQ9S7H69XgI050eiy2jAXe6RMBGBLQGrrIKEf0Y4SSu0Cn8gewICv4IYgqePDkfzIqmR3RGI0jp9gML8QfT0wG5JwXv/6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PJirW4j8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 049EBC4CEC0;
	Sat, 14 Sep 2024 16:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726331937;
	bh=Y7psSIfNe3ZXhkf8ipeBmKl43s6ocj72i+/+qJlZG1U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PJirW4j847lps9AhKefB0rcBy9T/BomvaN1CIaU/ymDT6IfbSq5fO9b8Jprg7JYaO
	 /vWOUmvA63VvPKipoQ5tES5he+RWxL7EjG3j6TBYI5TGWJJdi8r07fJ9uOw45JVSuM
	 mOeKw6JE/JEqXrZklM1z5JR2h4Yl1eqV5xUNIZ3AroS1eXMNCXjFsr5aE6oZZCyh0n
	 61IxYqlJTKqKbSGzamhTIFeTbcp3I+Jar+LQps5cgD0iSqLXtlsSHndOy5Dq+NXjZj
	 Zn1I5bhipKCHTi6esxZbDp2SYnMAi0Jmkaiz5KwIfBL1q6oUbOl3GUHIbMxbGNW9aK
	 j+44BET6XHmzw==
Date: Sat, 14 Sep 2024 17:38:45 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Ramona Alexandra Nechita <ramona.nechita@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Cosmin Tanislav
 <cosmin.tanislav@analog.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Nuno Sa
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Marcelo Schmitt <marcelo.schmitt@analog.com>,
 Olivier Moysan <olivier.moysan@foss.st.com>, Dumitru Ceclan
 <mitrutzceclan@gmail.com>, Matteo Martelli <matteomartelli3@gmail.com>,
 =?UTF-8?B?Sm/Do28=?= Paulo =?UTF-8?B?R29uw6dhbHZlcw==?=
 <joao.goncalves@toradex.com>, Alisa-Dariana Roman <alisadariana@gmail.com>,
 Marius Cristea <marius.cristea@microchip.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH v5 1/3] dt-bindings: iio: adc: add a7779 doc
Message-ID: <20240914173845.22a5e374@jic23-huawei>
In-Reply-To: <20240912121609.13438-2-ramona.nechita@analog.com>
References: <20240912121609.13438-1-ramona.nechita@analog.com>
	<20240912121609.13438-2-ramona.nechita@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 12 Sep 2024 15:15:45 +0300
Ramona Alexandra Nechita <ramona.nechita@analog.com> wrote:

> Add dt bindings for AD7779 8-channel, simultaneous sampling ADC
> family with eight full =CE=A3-=CE=94 ADCs on chip and ultra-low input
> current to allow direct sensor connection.
Typo in device name in the title

Also no need to say 'doc' when in dt-bindings.
dt-bindings: iio: adc: add adi,ad7779

>=20
> Signed-off-by: Ramona Alexandra Nechita <ramona.nechita@analog.com>
> ---
>  .../bindings/iio/adc/adi,ad7779.yaml          | 84 +++++++++++++++++++
>  1 file changed, 84 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7779.=
yaml
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7779.yaml b/=
Documentation/devicetree/bindings/iio/adc/adi,ad7779.yaml
> new file mode 100644
> index 000000000000..0ed5ec5dd8fe
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7779.yaml
> @@ -0,0 +1,84 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/adi,ad7779.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices AD777X family 8-Channel, 24-Bit, Simultaneous Samp=
ling ADCs
> +
> +maintainers:
> +  - Ramona Nechita <ramona.nechita@analog.com>
> +
> +description: |
> +  The AD777X family consist of 8-channel, simultaneous sampling analog-t=
o-
> +  digital converter (ADC). Eight full =CE=A3-=CE=94 ADCs are on-chip. The
> +  AD7771 provides an ultralow input current to allow direct sensor
> +  connection. Each input channel has a programmable gain stage
> +  allowing gains of 1, 2, 4, and 8 to map lower amplitude sensor
> +  outputs into the full-scale ADC input range, maximizing the
> +  dynamic range of the signal chain.
> +
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/ad=
7770.pdf
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/ad=
7771.pdf
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/ad=
7779.pdf
> +
> +$ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ad7770
> +      - adi,ad7771
> +      - adi,ad7779

No power in general?

All power supplies should be listed and if they need to have voltage
on them for the device to function they should be in the required list.

I left feedback on this and alert gpios in review of v4.
Please address that as well for v6.



> +
> +  reg:
> +    maxItems: 1
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +
> +  clocks:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +    description:
> +      Interrupt line for DRDY signal which indicates the end of conversi=
on
> +      independently of the interface selected to read back the =CE=A3-=
=E2=88=86 conversion.
> +
> +  start-gpios:
> +    description:
> +      Pin that controls start synchronization pulse.
> +    maxItems: 1
> +
> +  reset-gpios:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - interrupts
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    spi {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        adc@0 {
> +          compatible =3D "adi,ad7779";
> +          reg =3D <0>;
> +          vref-supply =3D <&vref>;
> +          start-gpios =3D <&gpio0 87 GPIO_ACTIVE_LOW>;
> +          reset-gpios =3D <&gpio0 93 GPIO_ACTIVE_LOW>;
> +          clocks =3D <&adc_clk>;
> +        };
> +    };
> +...


