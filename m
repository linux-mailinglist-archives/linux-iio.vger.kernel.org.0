Return-Path: <linux-iio+bounces-7984-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D3893DFF3
	for <lists+linux-iio@lfdr.de>; Sat, 27 Jul 2024 17:24:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E1801C20FB8
	for <lists+linux-iio@lfdr.de>; Sat, 27 Jul 2024 15:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF377181322;
	Sat, 27 Jul 2024 15:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bsdI2Oz0"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D506F30B;
	Sat, 27 Jul 2024 15:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722093837; cv=none; b=VIB9bOs6KATfCSiP/G9ZtgnpFmtZ55lFL729aRAo0Obme9oaloCIxVUp00kUAdXAlSJFZskUZ/GI2hDkRpPkAdPhL6c2E9gA6VmWAtV8MggQYMx0GVgtiKElEziiJ7gwV7EKNirhPSmu5UmuSc0HzJIMoLNPLgGtu1O6ryHrfmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722093837; c=relaxed/simple;
	bh=8zg+3Q4qdZh2c+7tjZafeq34AmHYH10iUg/BmrKF5V4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CM463MPqi2qFSBhjP5Np1CevnDWGrrjGPGyiRAtEdzXBXO2yrDP2J7vtAdMxT8+Bip8Z2EuBzFsuSDBRBEYUv6PcTlkypmf6XGJ4/77EKhJcfurYl0wRH9GASoIvneIQBqFB7CsWVzDYo0zq8tB0LDbQHAXUMuRIGR0DCBLIDZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bsdI2Oz0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C276C32781;
	Sat, 27 Jul 2024 15:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722093836;
	bh=8zg+3Q4qdZh2c+7tjZafeq34AmHYH10iUg/BmrKF5V4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bsdI2Oz001Po1JTadNbPzemMB0CoFFoTuYed9/LvFZj5c4zfg0JG7HF8tW6kByOuf
	 hThy1gtAbO3iGRqa9lrdqmwnPIYCZxCkdlQMo/N3LY8aZ9n5TiwM5nuo4y/61iABgC
	 VVAl40n/jXhgrOHyAk4AtHRQp50LlootYtsXYAv2nOofH7zAWRiExaiGTqanvzTeN+
	 qD3jbp4ySgU+F9sC8eD1FleYrw6IsYO/OpMpgr3oq//jLlPYuCjCXsKE5kOrIHVAWz
	 KIALEti1O2eeEuJBVYpvSPUPBmrX+3I7gNaoS1ptdLZgcybfcWGc2WQZtZ+P97feON
	 yvJYivxFyQoWw==
Date: Sat, 27 Jul 2024 16:23:47 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Ramona Alexandra Nechita <ramona.nechita@analog.com>
Cc: <linux-iio@vger.kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Cosmin Tanislav <cosmin.tanislav@analog.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Andy
 Shevchenko" <andriy.shevchenko@linux.intel.com>, Nuno Sa
 <nuno.sa@analog.com>, Marcelo Schmitt <marcelo.schmitt@analog.com>, Marius
 Cristea <marius.cristea@microchip.com>, Mike Looijmans
 <mike.looijmans@topic.nl>, Liam Beguin <liambeguin@gmail.com>, Ivan
 Mikhaylov <fr0st61te@gmail.com>, Marcus Folkesson
 <marcus.folkesson@gmail.com>, <linux-kernel@vger.kernel.org>,
 <devicetree@vger.kernel.org>
Subject: Re: [PATCH v4 1/3] dt-bindings: iio: adc: add a7779 doc
Message-ID: <20240727162347.51fb6270@jic23-huawei>
In-Reply-To: <20240724155517.12470-3-ramona.nechita@analog.com>
References: <20240724155517.12470-1-ramona.nechita@analog.com>
	<20240724155517.12470-3-ramona.nechita@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 24 Jul 2024 18:54:39 +0300
Ramona Alexandra Nechita <ramona.nechita@analog.com> wrote:

> Add dt bindings for adc ad7779.
>=20
> Signed-off-by: Ramona Alexandra Nechita <ramona.nechita@analog.com>
> ---
>  .../bindings/iio/adc/adi,ad7779.yaml          | 85 +++++++++++++++++++
>  1 file changed, 85 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7779.=
yaml
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7779.yaml b/=
Documentation/devicetree/bindings/iio/adc/adi,ad7779.yaml
> new file mode 100644
> index 000000000000..10a67644e915
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7779.yaml
> @@ -0,0 +1,85 @@
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
> +

I missed this earlier, but a device that only has a reference supply is=20
novel.  A quick glance at the datasheet shows a bunch of others power suppl=
ies.
They all need to be documented and any that are required for the device to =
function
must be listed as required.

Also seems to be at least one plausible interrupt line (alert)
that needs documenting whether or not the driver supports it yet.



> +  vref-supply:
> +    description:
> +      The regulator to use as an external reference. If it does not exis=
ts the
> +      internal reference will be used.
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


