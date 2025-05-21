Return-Path: <linux-iio+bounces-19764-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E16DABEE36
	for <lists+linux-iio@lfdr.de>; Wed, 21 May 2025 10:42:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 020BB188D077
	for <lists+linux-iio@lfdr.de>; Wed, 21 May 2025 08:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C044C237180;
	Wed, 21 May 2025 08:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vqn5gZTv"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7110B2367D0;
	Wed, 21 May 2025 08:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747816912; cv=none; b=DPerqz45XL0aYtJ6j+THVJcvHa8zIUoOM0k8PRvVzqlgujgAAfsr5YMo8vBAkQmbvGipeBoAjCiPGtwzlwzB8UhNeob/tUUOsxGcQb9DvuISso444wv9fg8mZu5j0lmCa4ekpTIQFal1HZDU5phyZozM18E1W1NV/SNKpqNpEhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747816912; c=relaxed/simple;
	bh=4jfGSis9Qh/pxYay/aAdFNfBiH3s1mplkibIkIRMd1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AoDvjuRICB/v0uYhySWRzjNT7FNUwBc0yZVH7MCs5gT+qjT706hwrN9B7U3OJ0ok/FQigzc/xSD4YPG2bmO1ocDczOZz0c77spwioy+Rbb3M9KA3Lr/X+ZxCp6YldmP/V0cq65sfFOd9C9GqEmdoMJnhb7gtFfLeARaJ4gJmaIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vqn5gZTv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C5CBC4CEE4;
	Wed, 21 May 2025 08:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747816911;
	bh=4jfGSis9Qh/pxYay/aAdFNfBiH3s1mplkibIkIRMd1c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vqn5gZTvVevHaKK5ZJvIR+LOTmkVd20thr9JrgkG/VKyHCMNHEkxBoHuyjkGdLoXQ
	 7qQ4VJjeqcpTbGEsKyCd0wL3r+dBmTGIyhLbXvZywUcH7pU8KGL5xSaJ2aOBBj4z4b
	 /l9L5b3h1BCKTPNT/7QCf8cxXuf4NCXuck7g1aNJoTc9Fz0Yy0iIyD9iIGzNfKCaJx
	 S8SKoLP8NnWeljmivclytsa/2qQk3fCiO3KlqrjE7wgzrd25CSemN1vIYjr2Fn05NS
	 Dg78bPrhuIfFrCIWWtqjPQDq3+Lmm6aiOwHOjhUEsiF0FJr4SgiEiO8oJTZGk0/k1M
	 d8dJ+iBnUJIVg==
Date: Wed, 21 May 2025 10:41:49 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, jic23@kernel.org, lars@metafoo.de, 
	Michael.Hennerich@analog.com, dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	linus.walleij@linaro.org, brgl@bgdev.pl, marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v3 01/10] dt-bindings: iio: adc: Add AD4170
Message-ID: <20250521-colorful-paper-coot-ce9ffb@kuoka>
References: <cover.1747083143.git.marcelo.schmitt@analog.com>
 <5fa867cff437c0c6d3f0122af823e1677a12d189.1747083143.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <5fa867cff437c0c6d3f0122af823e1677a12d189.1747083143.git.marcelo.schmitt@analog.com>

On Tue, May 13, 2025 at 09:33:40AM GMT, Marcelo Schmitt wrote:
> Add device tree documentation for AD4170 and similar sigma-delta ADCs.
> The AD4170 is a 24-bit, multichannel, sigma-delta ADC.
>=20
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---
> Change log v2 -> v3
>=20
> [device tree changes]
> - Removed unneeded allOf.
> - Removed occurences of adi,sensor-type type re-declaration.
> - Created type for the AD4170 channels, allowing to avoid dt doc repetiti=
on.
>=20
>  .../bindings/iio/adc/adi,ad4170.yaml          | 544 ++++++++++++++++++
>  MAINTAINERS                                   |   7 +
>  2 files changed, 551 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad4170.=
yaml
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4170.yaml b/=
Documentation/devicetree/bindings/iio/adc/adi,ad4170.yaml
> new file mode 100644
> index 000000000000..0a06258b6631
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4170.yaml
> @@ -0,0 +1,544 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/adi,ad4170.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices AD4170 and similar Analog to Digital Converters
> +
> +maintainers:
> +  - Marcelo Schmitt <marcelo.schmitt@analog.com>
> +
> +description: |
> +  Analog Devices AD4170 series of Sigma-delta Analog to Digital Converte=
rs.
> +  Specifications can be found at:
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/=
ad4170-4.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/=
ad4190-4.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/=
ad4195-4.pdf
> +
> +$ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +$defs:
> +  ad4170-channel:
> +    type: object
> +    $ref: /schemas/iio/adc/adc.yaml#
> +    description:
> +      Common properties for configuring AD4170 channels.
> +
> +    properties:
> +      adi,reference-select:
> +        description: |
> +          Selects the reference source to use when converting on the spe=
cific
> +          channel. Valid values are:
> +          0: Differential reference voltage REFIN+ - REFIN=E2=88=92.
> +          1: Differential reference voltage REFIN2+ - REFIN2=E2=88=92.
> +          2: Internal 2.5V referece (REFOUT) relative to AVSS.
> +          3: Analog supply voltage (AVDD) relative AVSS.
> +        $ref: /schemas/types.yaml#/definitions/uint8
> +        enum: [0, 1, 2, 3]
> +
> +

Remove excessive lines, also in other places.

> +  sensor-node:
> +    type: object
> +    $ref: '#/$defs/ad4170-channel'

I do not understand this binding. channel@ node is a channel and sensors
like rtd@ is also channel but also sensor. What is the point of channel@
which is not a sensor?


> +    description:
> +      The AD4170 and similar designs have features to aid interfacing wi=
th weigh
> +      scale, RTD, and thermocouple sensors. Each of those sensor types r=
equires
> +      either distinct wiring configuration or external circuitry for pro=
per
> +      sensor operation and can use different AD4170 functionality on the=
ir
> +      setups. A key characteristic of those external sensors is that the=
y must
> +      be excited either by voltage supply or by AD4170 excitation signal=
s. The
> +      sensor can then be read through a pair of analog inputs. These pro=
perties
> +      describe external sensor circuitry connected to the ADC.
> +
> +    properties:
> +      reg:
> +        description:
> +          Channel number. Connects the sensor to the channel with this n=
umber
> +          of the device.
> +        minimum: 1
> +        maximum: 16

=2E..

> > +patternProperties:
> +  "^channel@[0-9a-f]$":
> +    $ref: '#/$defs/ad4170-channel'
> +    unevaluatedProperties: false
> +    description:
> +      Represents the external channels which are connected to the ADC.
> +
> +    properties:
> +      reg:
> +        description:
> +          The channel number.
> +        minimum: 0
> +        maximum: 15
> +
> +      diff-channels:
> +        description: |
> +          This property is used for defining the inputs of a differential
> +          voltage channel. The first value is the positive input and the=
 second
> +          value is the negative input of the channel.
> +
> +          Besides the analog input pins AIN0 to AIN8, there are special =
inputs
> +          that can be selected with the following values:
> +          17: Internal temperature sensor
> +          18: (AVDD-AVSS)/5
> +          19: (IOVDD-DGND)/5
> +          20: DAC output
> +          21: ALDO
> +          22: DLDO
> +          23: AVSS
> +          24: DGND
> +          25: REFIN+
> +          26: REFIN-
> +          27: REFIN2+
> +          28: REFIN2-
> +          29: REFOUT
> +          For the internal temperature sensor, use the input number for =
both
> +          inputs (i.e. diff-channels =3D <17 17>).
> +        items:
> +          enum: [0, 1, 2, 3, 4, 5, 6, 7, 8, 17, 18, 19, 20, 21, 22, 23, =
24, 25,
> +                 26, 27, 28, 29]
> +
> +      single-channel: true
> +
> +      common-mode-channel: true
> +
> +      bipolar: true

Why all these 'true' are needed here and everywhere else?

> +
> +      adi,buffered-positive:
> +        description: |
> +          Enable precharge buffer, full buffer, or skip reference buffer=
ing of
> +          the positive voltage reference. Because the output impedance o=
f the
> +          source driving the voltage reference inputs may be dynamic, RC
> +          combinations of those inputs can cause DC gain errors if the r=
eference
> +          inputs go unbuffered into the ADC. Enable reference buffering =
if the
> +          provided reference source has dynamic high impedance output. N=
ote the
> +          absolute voltage allowed on positive reference inputs (REFIN+,
> +          REFIN2+) is from AVSS =E2=88=92 50 mV to AVDD + 50 mV when the=
 reference
> +          buffers are disabled but narrows to AVSS to AVDD when reference
> +          buffering is enabled or in precharge mode.
> +          0: Reference precharge buffer.
> +          1: Full Buffer.
> +          2: Bypass reference buffers (buffering disabled).
> +        $ref: /schemas/types.yaml#/definitions/uint8
> +        enum: [0, 1, 2]
> +        default: 1

Best regards,
Krzysztof


