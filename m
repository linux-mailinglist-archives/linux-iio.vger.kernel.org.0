Return-Path: <linux-iio+bounces-18014-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D82CA86E0F
	for <lists+linux-iio@lfdr.de>; Sat, 12 Apr 2025 18:07:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30FCD17C0C5
	for <lists+linux-iio@lfdr.de>; Sat, 12 Apr 2025 16:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CF231FF1BE;
	Sat, 12 Apr 2025 16:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rvG+V6kl"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0845BAF0;
	Sat, 12 Apr 2025 16:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744474067; cv=none; b=flhchFiBMOHMsxKvKwoD4AsEgfq1m2c15RPG5ETY8+oBvWsKVZI/e89TEcxTmnsXeYcsbtc6viLDiehu7/VgwIZNh6zl62l2QsZd/BPRJapgMEgXpJowYHhJy0vlqe7GSjSHKBHF8VB37bB4KkkPJmalN2E4afDFZQ/YIULFBUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744474067; c=relaxed/simple;
	bh=lmuYPty/lZmLcal0gRqAtGX3aUvqVaa1WHACrU34TIg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=faLSVVUXS3nDjBHOwViyB7lJRk3ukiUUVhWhQuhcNgsZkZ6O5E4NMoygXe0xqBVCGZn8FU5MbqagD7gGdD2ueQp5YJfuylwV7NXEVvJXZDtgH1F6/fpLJS8z+Ya4eqAqCmjRCbuta2DoocqCcHRMCSTSD6SLLMp6C3S4HVGGlLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rvG+V6kl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA85EC4CEE3;
	Sat, 12 Apr 2025 16:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744474066;
	bh=lmuYPty/lZmLcal0gRqAtGX3aUvqVaa1WHACrU34TIg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rvG+V6klLrizDm03pgJoi7CQPUW1HlsIcBUOc8tgLUGKFdDeRBrO+V0+CDQrmRTMV
	 I7tMjD4WTlDf9dO0D4F+pBDiHzl+OWG2JV0bCBNyb+RdVXN9CJHiey16OK3l7p8mHP
	 C9Ce7sQLJcC04g0zBG+ztNkMTXlzFhCyoLc9DcIPpQzuOOCq1mdgaNJCSFmCNa4IHO
	 ZHDNvTUtxTenplDrPWSve98MxGe6CXifQgUIjgw8npwbGRDM/0bEs37K5KD8H1b5Ud
	 LcJ8ZEBioxRBHKgZ/Bcr/kNxux0vTvBZnmnco9U2TOOAWb8EwKghqQ0Vb2n9iS5q6I
	 k6cB1wKB0i+/Q==
Date: Sat, 12 Apr 2025 17:07:37 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <lars@metafoo.de>,
 <Michael.Hennerich@analog.com>, <dlechner@baylibre.com>,
 <nuno.sa@analog.com>, <andy@kernel.org>, <robh@kernel.org>,
 <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <marcelo.schmitt1@gmail.com>
Subject: Re: [PATCH v1 1/7] dt-bindings: iio: adc: Add AD4170
Message-ID: <20250412170737.2789c5be@jic23-huawei>
In-Reply-To: <d2f8e8227022afe411005882cfd269124cd81e01.1744200264.git.marcelo.schmitt@analog.com>
References: <cover.1744200264.git.marcelo.schmitt@analog.com>
	<d2f8e8227022afe411005882cfd269124cd81e01.1744200264.git.marcelo.schmitt@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 9 Apr 2025 09:24:18 -0300
Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:

> Add device tree documentation for AD4170 and similar sigma-delta ADCs.
> The AD4170 is a 24-bit, multichannel, sigma-delta ADC.
>=20
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---
> The AD4170 design has features to aid interfacing with weigh scale and RTD
> sensors that are expected to be setup with external circuitry for proper
> sensor operation. A key characteristic of those sensors is that the circu=
it
> they are in must be excited with a pair of signals. The external circuit
> can be excited either by voltage supply or by AD4170 excitation signals.
> The sensor can then be read through a different pair of lines that are
> connected to AD4170 ADC.
>=20
>  .../bindings/iio/adc/adi,ad4170.yaml          | 527 ++++++++++++++++++
>  MAINTAINERS                                   |   7 +
>  2 files changed, 534 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad4170.=
yaml
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4170.yaml b/=
Documentation/devicetree/bindings/iio/adc/adi,ad4170.yaml
> new file mode 100644
> index 000000000000..93fe3b4648a0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4170.yaml
> @@ -0,0 +1,527 @@
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
> +  sensor-node:
> +    type: object
> +    description: |
> +      Common properties of external sensor circuitry connected to the AD=
C.
> +
> +    properties:
> +      reg:
> +        description:
> +          Channel number. Connects the sensor to the channel with this n=
umber
> +          of the device.
> +        minimum: 1
> +        maximum: 16
> +
> +      diff-channels:

Maybe add some comments to the file. I was very confused on what this def
is for, but now I think it's just an adaption of an ADC channel to a specif=
ic
sensor type.

> +        $ref: /schemas/types.yaml#/definitions/uint32-array
> +        maxItems: 2
> +        minItems: 2
> +        description: |
> +          ADC analog input pins to which the sensor circuit is connected.
> +          The first value specifies the positive input pin, the second
> +          specifies the negative input pin. See adc.yaml for details.
> +
> +      bipolar:
> +        $ref: /schemas/types.yaml#/definitions/flag
> +        description: If provided, the channel is to be used in bipolar m=
ode.
> +
> +      adi,sensor-type:
> +        description: Type of sensor connected to the device.
> +        $ref: /schemas/types.yaml#/definitions/uint8
> +
> +      adi,ac-excited:

All the existing excitation related bindings are
adi,excitation-*

Maybe adi,excitation-ac for this one?

> +        type: boolean
> +        description: |
> +          Whether the external circuit has to be AC or DC excited.

Hmm. The concept of a DC excitation source confused me a bit, but I guess
that's just a current source.=20

> +
> +      adi,excitation-pins:
> +        $ref: /schemas/types.yaml#/definitions/uint32-array
> +        description: |
> +          ADC pins used for external circuit excitation. Some applicatio=
ns
> +          require optimum matching between excitation currents. Using ex=
citation
> +          current pairs minimizes the excitation current mismatch and the
> +          excitation current drift matching on the ADC. Must describe ei=
ther 1
> +          or 2 pairs of pins. E.g. <0 1>; <2 3>; <0 1>, <2 3>.
> +
> +      adi,excitation-current-microamp:
We have an existing rtd specific version of this but I guess it can be used=
 for other
things with this chip so fair enough to generalize it.


> +        description: |
> +          Excitation current in microamperes to be output to each excita=
tion pin
> +          specified by adi,excitation-pins property.
> +        enum: [0, 10, 50, 100, 250, 500, 1000, 1500]
> +        default: 0
> +
> +      adi,reference-select:
> +        description: |
> +          Select the reference source to use when converting on the spec=
ific
> +          channel. Valid values are:
> +          0: Differential reference voltage REFIN+ - REFIN=E2=88=92.
> +          1: Differential reference voltage REFIN2+ - REFIN2=E2=88=92.
> +          2: Internal 2.5V referece (REFOUT) relative to AVSS.
> +          3: Analog supply voltage (AVDD) relative AVSS.
> +          If this field is left empty, the first external reference is s=
elected.
> +        $ref: /schemas/types.yaml#/definitions/uint8
> +        enum: [0, 1, 2, 3]
> +        default: 0
> +
> +    required:
> +      - reg
> +      - diff-channels
> +      - bipolar
> +      - adi,sensor-type
> +      - adi,excitation-pins
> +      - adi,reference-select

If it is required, why specify defaults above?

> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ad4170
> +      - adi,ad4190
> +      - adi,ad4195
> +

> +patternProperties:
> +  "^channel@[0-9a-f]$":
> +    $ref: adc.yaml
> +    type: object
> +    unevaluatedProperties: false
> +    description: |
> +      Represents the external channels which are connected to the ADC.
> +
> +    properties:
> +      reg:
> +        description: |
> +          The channel number.
> +        items:
> +          minimum: 0
> +          maximum: 15
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
> +
> +      adi,sensor-type:

This wants a fuller description somewhere in the binding.  What are the pos=
sible types?
Also why do we need them here if the sensor-nodes refer to channels?

> +        description: Sensor type for direct ADC sensors.
> +        $ref: /schemas/types.yaml#/definitions/uint8
> +        const: 0
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
I'm not seeing a reason (from this description) to ever pick 0.
Maybe talk about what the precharge buffer alone gets you.

> +        $ref: /schemas/types.yaml#/definitions/uint8
> +        enum: [0, 1, 2]
> +        default: 0
> +
> +      adi,buffered-negative:
> +        description: |
> +          Enable precharge buffer, full buffer, or skip reference buffer=
ing of
> +          the negative voltage reference. Because the output impedance o=
f the
> +          source driving the voltage reference inputs may be dynamic, RC
> +          combinations of those inputs can cause DC gain errors if the r=
eference
> +          inputs go unbuffered into the ADC. Enable reference buffering =
if the
> +          provided reference source has dynamic high impedance output. N=
ote the
> +          absolute voltage allowed on negative reference inputs (REFIN-,
> +          REFIN2-) is from AVSS =E2=88=92 50 mV to AVDD + 50 mV when the=
 reference
> +          buffers are disabled but narrows to AVSS to AVDD when reference
> +          buffering is enabled or in precharge mode.
> +          0: Reference precharge buffer.
> +          1: Full Buffer.
> +          2: Bypass reference buffers (buffering disabled).
> +        $ref: /schemas/types.yaml#/definitions/uint8
> +        enum: [0, 1, 2]
> +        default: 0
> +
> +      adi,reference-select:
> +        description: |
> +          Select the reference source to use when converting on the spec=
ific
> +          channel. Valid values are:
> +          0: Differential reference voltage REFIN+ - REFIN=E2=88=92.
> +          1: Differential reference voltage REFIN2+ - REFIN2=E2=88=92.
> +          2: Internal 2.5V referece (REFOUT) relative to AVSS.
> +          3: Analog supply voltage (AVDD) relative AVSS.
> +          If this field is left empty, the internal reference is selecte=
d.
> +        $ref: /schemas/types.yaml#/definitions/uint8
> +        enum: [0, 1, 2, 3]
> +        default: 2
> +
> +    required:
> +      - reg
> +
> +    allOf:
> +      - oneOf:
> +          - required: [single-channel]
> +            properties:
> +              diff-channels: false
> +          - required: [diff-channels]
> +            properties:
> +              single-channel: false
> +              common-mode-channel: false
> +
> +  "^weighscale@":
> +    $ref: '#/$defs/sensor-node'
> +    unevaluatedProperties: false
> +
> +    properties:
> +      diff-channels: true
> +      bipolar: true
> +
> +      adi,sensor-type:
> +        description: Weigh scale sensor.
> +        $ref: /schemas/types.yaml#/definitions/uint8
> +        const: 1
> +
> +      adi,excitation-pins:
> +        description: |
> +          ADC pins to use for weigh scale bridge circuit excitation. Must
> +          describe either 1 or 2 pairs of pins. E.g. <0 1>; <2 3>; <0 1>=
, <2 3>.
> +        $ref: /schemas/types.yaml#/definitions/uint32-array
> +        minItems: 2
> +        maxItems: 4
> +        items:
> +          minimum: 0
> +          maximum: 20
> +
> +      adi,excitation-current-microamp:
> +        description: |
> +          Excitation current in microamperes to be output to each excita=
tion pin
> +          specified by adi,excitation-pins property. If not provided and
> +          adi,ac-excited is true, use predefined ACX1, ACX1 negated, ACX=
2, and
> +          ACX2 negated signals to AC excite the weigh scale bridge. Those
> +          singals are output on GPIO2, GPIO0, GPIO3, and GPIO1, respecti=
vely.
> +        enum: [0, 10, 50, 100, 250, 500, 1000, 1500]
Why the repeat? This description is already in the sensor-node definition.

> +
> +      adi,power-down-switch-pin:
> +        description: |
> +          Number of the GPIO used as power-down switch for the bridge ci=
rcuit.
> +        $ref: /schemas/types.yaml#/definitions/uint8
> +        enum: [0, 1]
> +

In general, can we reduce repetition of docs across the sensor types so we =
don't
repeat anything?

J

