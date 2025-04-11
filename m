Return-Path: <linux-iio+bounces-17956-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09B77A86244
	for <lists+linux-iio@lfdr.de>; Fri, 11 Apr 2025 17:47:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DE4F4C0CA5
	for <lists+linux-iio@lfdr.de>; Fri, 11 Apr 2025 15:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D5920FA90;
	Fri, 11 Apr 2025 15:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hOWag5L+"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884131F2367;
	Fri, 11 Apr 2025 15:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744386469; cv=none; b=U3cAhrxwfV2KB+Ujt43hDSqsjKpOnGuYMYONV4gZ+cIxMppQUDgJR+F/8VhKneADYx7LY36aNGoWrSiKGtkogG4EmcooDQtMbJnNIOZ/q8s2/PrTCDrpAedi2Dfd+McxhXWuGipjxHPF3nfUhoPgOsdtCSa1+vY+KgwYbuQ0Qv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744386469; c=relaxed/simple;
	bh=ua+sG8LwZhGNuX4+8zqo0oGX4oAevu0pRYislR7Z1cI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HTttJiXBUFTE+RHZBaga357i387FEdwRWRi6JsnSNfthVEb4KWq3T+oOpOLx2uDhWneY/xXWoTcjQcAofeKaKiweiBGJhGfYoJI2YG1lm/MN0y3bZOOm9Api3KaEUkXoXrepISsZwmkVJAtiYg1C1aO6rikKSBwBc2jgOYDcgA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hOWag5L+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD1EDC4CEE2;
	Fri, 11 Apr 2025 15:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744386469;
	bh=ua+sG8LwZhGNuX4+8zqo0oGX4oAevu0pRYislR7Z1cI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hOWag5L+AY9qo3x/8cadgo3HhOUQluNpUkTGYe6zmZ97A6RBBRrfxlOgP20jVUnMy
	 7rWiweb6uYuWFPj8XkZjS0HmImaSHk6kAdZ4sxkRtaY29NQXQCJAleDza4xiRz6n7s
	 SXWvv6ECYevamXCeKPVbpP9FeUE81lwEXExfPX0EKNtUk3I1DRF0A+jtFVIrLIP363
	 kq3dphwRLl/R09kVyPoLddsL9wOhzT+MT8Gr+wIlFBkRAYpj2IIr2dE/lEWqaUkILR
	 csIZB5L4nCRifyZBnMeFIphiZqpmPLPxo9OOUyt4Yh28hqX/AlP5HVvyyGhuHQdJCW
	 SribHO5+4vCeg==
Date: Fri, 11 Apr 2025 10:47:47 -0500
From: Rob Herring <robh@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, jic23@kernel.org, lars@metafoo.de,
	Michael.Hennerich@analog.com, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v1 1/7] dt-bindings: iio: adc: Add AD4170
Message-ID: <20250411154747.GA3278243-robh@kernel.org>
References: <cover.1744200264.git.marcelo.schmitt@analog.com>
 <d2f8e8227022afe411005882cfd269124cd81e01.1744200264.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d2f8e8227022afe411005882cfd269124cd81e01.1744200264.git.marcelo.schmitt@analog.com>

On Wed, Apr 09, 2025 at 09:24:18AM -0300, Marcelo Schmitt wrote:
> Add device tree documentation for AD4170 and similar sigma-delta ADCs.
> The AD4170 is a 24-bit, multichannel, sigma-delta ADC.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---
> The AD4170 design has features to aid interfacing with weigh scale and RTD
> sensors that are expected to be setup with external circuitry for proper
> sensor operation. A key characteristic of those sensors is that the circuit
> they are in must be excited with a pair of signals. The external circuit
> can be excited either by voltage supply or by AD4170 excitation signals.
> The sensor can then be read through a different pair of lines that are
> connected to AD4170 ADC.
> 
>  .../bindings/iio/adc/adi,ad4170.yaml          | 527 ++++++++++++++++++
>  MAINTAINERS                                   |   7 +
>  2 files changed, 534 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad4170.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4170.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4170.yaml
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
> +  Analog Devices AD4170 series of Sigma-delta Analog to Digital Converters.
> +  Specifications can be found at:
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad4170-4.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad4190-4.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad4195-4.pdf
> +
> +$ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +$defs:
> +  sensor-node:
> +    type: object
> +    description: |

Don't need '|' if no formatting.

> +      Common properties of external sensor circuitry connected to the ADC.
> +
> +    properties:
> +      reg:
> +        description:
> +          Channel number. Connects the sensor to the channel with this number
> +          of the device.
> +        minimum: 1
> +        maximum: 16
> +
> +      diff-channels:
> +        $ref: /schemas/types.yaml#/definitions/uint32-array

Already has a type in adc.yaml which needs to be referenced for 
'sensor-node'.

> +        maxItems: 2
> +        minItems: 2
> +        description: |

Don't need '|'. And a few more places...

> +          ADC analog input pins to which the sensor circuit is connected.
> +          The first value specifies the positive input pin, the second
> +          specifies the negative input pin. See adc.yaml for details.
> +
> +      bipolar:
> +        $ref: /schemas/types.yaml#/definitions/flag

Already has a type.

> +        description: If provided, the channel is to be used in bipolar mode.
> +
> +      adi,sensor-type:
> +        description: Type of sensor connected to the device.
> +        $ref: /schemas/types.yaml#/definitions/uint8
> +
> +      adi,ac-excited:
> +        type: boolean
> +        description: |

Don't need '|'

> +          Whether the external circuit has to be AC or DC excited.
> +
> +      adi,excitation-pins:
> +        $ref: /schemas/types.yaml#/definitions/uint32-array
> +        description: |
> +          ADC pins used for external circuit excitation. Some applications
> +          require optimum matching between excitation currents. Using excitation
> +          current pairs minimizes the excitation current mismatch and the
> +          excitation current drift matching on the ADC. Must describe either 1
> +          or 2 pairs of pins. E.g. <0 1>; <2 3>; <0 1>, <2 3>.

This looks like a uint32-matrix instead:

items:
  minItems: 2
  maxItems: 2
  items:
    maximum: <max pin number>?

> +
> +      adi,excitation-current-microamp:
> +        description: |
> +          Excitation current in microamperes to be output to each excitation pin
> +          specified by adi,excitation-pins property.
> +        enum: [0, 10, 50, 100, 250, 500, 1000, 1500]
> +        default: 0
> +
> +      adi,reference-select:
> +        description: |
> +          Select the reference source to use when converting on the specific
> +          channel. Valid values are:
> +          0: Differential reference voltage REFIN+ - REFIN−.
> +          1: Differential reference voltage REFIN2+ - REFIN2−.
> +          2: Internal 2.5V referece (REFOUT) relative to AVSS.
> +          3: Analog supply voltage (AVDD) relative AVSS.
> +          If this field is left empty, the first external reference is selected.
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
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ad4170
> +      - adi,ad4190
> +      - adi,ad4195
> +
> +  avss-supply:
> +    description:
> +      Referece voltage supply for AVSS. If provided, describes the magnitude
> +      (absolute value) of the negative voltage supplied to the AVSS pin. Since
> +      AVSS must be −2.625V minimum and 0V maximum, the declared supply voltage
> +      must be between 0 and 2.65V. If not provided, AVSS is assumed to be at
> +      system ground (0V).
> +
> +  avdd-supply:
> +    description:
> +      A supply of 4.75V to 5.25V relative to AVSS that powers the chip (AVDD).
> +
> +  iovdd-supply:
> +    description: 1.7V to 5.25V reference supply to the serial interface (IOVDD).
> +
> +  refin1p-supply:
> +    description: REFIN+ supply that can be used as reference for conversion.
> +
> +  refin1n-supply:
> +    description: REFIN- supply that can be used as reference for conversion. If
> +      provided, describes the magnitude (absolute value) of the negative voltage
> +      supplied to the REFIN- pin.
> +
> +  refin2p-supply:
> +    description: REFIN2+ supply that can be used as reference for conversion.
> +
> +  refin2n-supply:
> +    description: REFIN2- supply that can be used as reference for conversion. If
> +      provided, describes the magnitude (absolute value) of the negative voltage
> +      supplied to the REFIN2- pin.
> +
> +  spi-cpol: true
> +
> +  spi-cpha: true
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  interrupt-names:
> +    description: |
> +      Specify which pin should be configured as Data Ready interrupt.
> +      Default if not supplied is sdo.

default: sdo

And drop the sentence.

> +    enum:
> +      - sdo
> +      - dig_aux1
> +
> +  clocks:
> +    maxItems: 1
> +    description:
> +      Optional external clock source. Can specify either an external clock or
> +      external crystal.
> +
> +  clock-names:
> +    enum:
> +      - ext-clk
> +      - xtal

default?

> +
> +  '#clock-cells':
> +    const: 0
> +
> +  gpio-controller: true
> +
> +  "#gpio-cells":
> +    const: 2
> +    description: |
> +      The first cell is for the GPIO number: 0 to 3.
> +      The second cell takes standard GPIO flags.
> +
> +  ldac-gpios:
> +    description:
> +      GPIO connected to DIG_AUX2 pin to be used as LDAC toggle to control the
> +      transfer of data from the DAC_INPUT_A register to the DAC.
> +    maxItems: 1
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
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

Drop 'items' to imply there's only 1 entry.

> +          minimum: 0
> +          maximum: 15
> +
> +      diff-channels:
> +        description: |
> +          This property is used for defining the inputs of a differential
> +          voltage channel. The first value is the positive input and the second
> +          value is the negative input of the channel.
> +
> +          Besides the analog input pins AIN0 to AIN8, there are special inputs
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
> +          For the internal temperature sensor, use the input number for both
> +          inputs (i.e. diff-channels = <17 17>).
> +        items:
> +          enum: [0, 1, 2, 3, 4, 5, 6, 7, 8, 17, 18, 19, 20, 21, 22, 23, 24, 25,
> +                 26, 27, 28, 29]

These constraints don't apply to other cases of diff-channels?

> +
> +      single-channel: true
> +
> +      common-mode-channel: true
> +
> +      bipolar: true
> +
> +      adi,sensor-type:
> +        description: Sensor type for direct ADC sensors.
> +        $ref: /schemas/types.yaml#/definitions/uint8
> +        const: 0

Since this is optional and only one possible value, you don't need it...

> +
> +      adi,buffered-positive:
> +        description: |
> +          Enable precharge buffer, full buffer, or skip reference buffering of
> +          the positive voltage reference. Because the output impedance of the
> +          source driving the voltage reference inputs may be dynamic, RC
> +          combinations of those inputs can cause DC gain errors if the reference
> +          inputs go unbuffered into the ADC. Enable reference buffering if the
> +          provided reference source has dynamic high impedance output. Note the
> +          absolute voltage allowed on positive reference inputs (REFIN+,
> +          REFIN2+) is from AVSS − 50 mV to AVDD + 50 mV when the reference
> +          buffers are disabled but narrows to AVSS to AVDD when reference
> +          buffering is enabled or in precharge mode.
> +          0: Reference precharge buffer.
> +          1: Full Buffer.
> +          2: Bypass reference buffers (buffering disabled).
> +        $ref: /schemas/types.yaml#/definitions/uint8
> +        enum: [0, 1, 2]
> +        default: 0
> +
> +      adi,buffered-negative:
> +        description: |
> +          Enable precharge buffer, full buffer, or skip reference buffering of
> +          the negative voltage reference. Because the output impedance of the
> +          source driving the voltage reference inputs may be dynamic, RC
> +          combinations of those inputs can cause DC gain errors if the reference
> +          inputs go unbuffered into the ADC. Enable reference buffering if the
> +          provided reference source has dynamic high impedance output. Note the
> +          absolute voltage allowed on negative reference inputs (REFIN-,
> +          REFIN2-) is from AVSS − 50 mV to AVDD + 50 mV when the reference
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
> +          Select the reference source to use when converting on the specific
> +          channel. Valid values are:
> +          0: Differential reference voltage REFIN+ - REFIN−.
> +          1: Differential reference voltage REFIN2+ - REFIN2−.
> +          2: Internal 2.5V referece (REFOUT) relative to AVSS.
> +          3: Analog supply voltage (AVDD) relative AVSS.
> +          If this field is left empty, the internal reference is selected.
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
> +          describe either 1 or 2 pairs of pins. E.g. <0 1>; <2 3>; <0 1>, <2 3>.
> +        $ref: /schemas/types.yaml#/definitions/uint32-array
> +        minItems: 2
> +        maxItems: 4
> +        items:
> +          minimum: 0
> +          maximum: 20
> +
> +      adi,excitation-current-microamp:
> +        description: |
> +          Excitation current in microamperes to be output to each excitation pin
> +          specified by adi,excitation-pins property. If not provided and
> +          adi,ac-excited is true, use predefined ACX1, ACX1 negated, ACX2, and
> +          ACX2 negated signals to AC excite the weigh scale bridge. Those
> +          singals are output on GPIO2, GPIO0, GPIO3, and GPIO1, respectively.
> +        enum: [0, 10, 50, 100, 250, 500, 1000, 1500]
> +
> +      adi,power-down-switch-pin:
> +        description: |
> +          Number of the GPIO used as power-down switch for the bridge circuit.
> +        $ref: /schemas/types.yaml#/definitions/uint8
> +        enum: [0, 1]
> +
> +  "^thermocouple@":
> +    $ref: '#/$defs/sensor-node'
> +    unevaluatedProperties: false
> +
> +    properties:
> +      diff-channels: true
> +      bipolar: true
> +
> +      adi,sensor-type:
> +        description: Thermocouple sensor.
> +        $ref: /schemas/types.yaml#/definitions/uint8
> +        const: 2
> +
> +      adi,excitation-pins:
> +        description: |
> +          ADC pins to use for bridge circuit excitation. Must describe either 1
> +          or 2 pairs of pins. E.g. <0 1>; <2 3>; <0 1>, <2 3>.
> +        $ref: /schemas/types.yaml#/definitions/uint32-array
> +        minItems: 2
> +        maxItems: 4
> +        items:
> +          minimum: 0
> +          maximum: 20
> +
> +      adi,excitation-current-microamp:
> +        description: |
> +          Excitation current in microamperes to be output to each excitation pin
> +          specified by adi,excitation-pins property. If not provided and
> +          adi,ac-excited is true, use predefined ACX1, ACX1 negated, ACX2, and
> +          ACX2 negated signals to AC excite the bridge circuit. Those singals
> +          are output on GPIO2, GPIO0, GPIO3, and GPIO1, respectively.
> +        enum: [0, 10, 50, 100, 250, 500, 1000, 1500]
> +
> +      adi,vbias:
> +        type: boolean
> +        description: |
> +          For unbiased thermocouple applications, the voltage generated by the
> +          thermocouple must be biased around some DC voltage. When present, this
> +          property specifies a bias voltage of (AVDD + AVSS)/2 to be applied as
> +          common-mode voltage for the sensor.
> +
> +      adi,power-down-switch-pin:
> +        description: |
> +          Number of the GPIO used as power-down switch for the bridge circuit.
> +        $ref: /schemas/types.yaml#/definitions/uint8
> +        enum: [0, 1]
> +
> +  "^rtd@":
> +    $ref: '#/$defs/sensor-node'
> +    unevaluatedProperties: false
> +
> +    properties:
> +      diff-channels: true
> +      bipolar: true
> +
> +      adi,sensor-type:
> +        description: RTD sensor.
> +        $ref: /schemas/types.yaml#/definitions/uint8
> +        const: 3
> +
> +      adi,excitation-pins:
> +        description: |
> +          ADC pins to use for RTD circuit excitation. Must describe a pair of
> +          pins. E.g. <0 1>; <2 3>.
> +        $ref: /schemas/types.yaml#/definitions/uint32-array
> +        minItems: 2
> +        maxItems: 2
> +        items:
> +          minimum: 0
> +          maximum: 20
> +
> +      adi,excitation-current-microamp: true
> +
> +    required:
> +      - adi,excitation-current-microamp
> +
> +required:
> +  - compatible
> +  - reg
> +  - avdd-supply
> +  - iovdd-supply
> +  - spi-cpol
> +  - spi-cpha
> +
> +allOf:
> +  # Some devices don't have integrated DAC
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - adi,ad4190
> +              - adi,ad4195
> +    then:
> +      properties:
> +        ldac-gpios: false
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        adc@0 {
> +            compatible = "adi,ad4170";
> +            reg = <0>;
> +            spi-max-frequency = <20000000>;
> +            spi-cpol;
> +            spi-cpha;
> +            avdd-supply = <&avdd>;
> +            iovdd-supply = <&iovdd>;
> +            interrupt-parent = <&gpio_in>;
> +            interrupts = <0 IRQ_TYPE_EDGE_FALLING>;
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            // Sample AIN0 with respect to AIN1 throughout AVDD/AVSS input range
> +            // Differential bipolar. If AVSS < 0V, differential true bipolar
> +            channel@0 {
> +                reg = <0>;
> +                bipolar;
> +                diff-channels = <0 1>;
> +                adi,sensor-type = /bits/ 8 <0>;
> +                adi,reference-select = /bits/ 8 <3>;
> +            };
> +            // Sample AIN2 with respect to DGND throughout AVDD/DGND input range
> +            // Pseudo-differential unipolar (fig. 2a)
> +            channel@1 {
> +                reg = <1>;
> +                single-channel = <2>;
> +                common-mode-channel = <24>;
> +                adi,sensor-type = /bits/ 8 <0>;
> +                adi,reference-select = /bits/ 8 <3>;
> +            };
> +            // Sample AIN3 with respect to 2.5V throughout AVDD/AVSS input range
> +            // Pseudo-differential bipolar (fig. 2b)
> +            channel@2 {
> +                reg = <2>;
> +                bipolar;
> +                single-channel = <3>;
> +                common-mode-channel = <29>;
> +                adi,sensor-type = /bits/ 8 <0>;
> +                adi,reference-select = /bits/ 8 <3>;
> +            };
> +            // Sample AIN4 with respect to DGND throughout AVDD/AVSS input range
> +            // Pseudo-differential bipolar (fig. 2c)
> +            channel@3 {
> +                reg = <3>;
> +                bipolar;
> +                single-channel = <4>;
> +                common-mode-channel = <24>;
> +                adi,sensor-type = /bits/ 8 <0>;
> +                adi,reference-select = /bits/ 8 <3>;
> +            };
> +            // Sample AIN5 with respect to 2.5V throughout AVDD/AVSS input range
> +            // Pseudo-differential unipolar (AD4170 datasheet page 46 example)
> +            channel@4 {
> +                reg = <4>;
> +                single-channel = <5>;
> +                common-mode-channel = <29>;
> +                adi,sensor-type = /bits/ 8 <0>;
> +                adi,reference-select = /bits/ 8 <3>;
> +            };
> +            // Sample AIN6 with respect to 2.5V throughout REFIN+/REFIN- input range
> +            // Pseudo-differential bipolar
> +            channel@5 {
> +                reg = <5>;
> +                bipolar;
> +                single-channel = <6>;
> +                common-mode-channel = <29>;
> +                adi,sensor-type = /bits/ 8 <0>;
> +                adi,reference-select = /bits/ 8 <0>;
> +            };

Can you try to have every child node type in the example rather than 
multiple cases of 'channel' nodes? We want every property defined in 
schemas in the examples if possible (but not creating every possible 
iteration).

> +            // Weigh scale sensor
> +            weighscale@6 {
> +                reg = <6>;
> +                bipolar;
> +                diff-channels = <7 8>;
> +                adi,sensor-type = /bits/ 8 <1>;
> +                adi,ac-excited;
> +                adi,excitation-pins = <17 18>, <19 20>;
> +                adi,reference-select = /bits/ 8 <0>;
> +            };
> +        };
> +    };
> +...
> +
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 030d90d38341..991b6e2e373a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1337,6 +1337,13 @@ F:	Documentation/ABI/testing/sysfs-bus-iio-adc-ad4130
>  F:	Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml
>  F:	drivers/iio/adc/ad4130.c
>  
> +ANALOG DEVICES INC AD4170 DRIVER
> +M:	Marcelo Schmitt <marcelo.schmitt@analog.com>
> +L:	linux-iio@vger.kernel.org
> +S:	Supported
> +W:	https://ez.analog.com/linux-software-drivers
> +F:	Documentation/devicetree/bindings/iio/adc/adi,ad4170.yaml
> +
>  ANALOG DEVICES INC AD4695 DRIVER
>  M:	Michael Hennerich <michael.hennerich@analog.com>
>  M:	Nuno Sá <nuno.sa@analog.com>
> -- 
> 2.47.2
> 

