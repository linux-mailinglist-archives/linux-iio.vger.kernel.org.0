Return-Path: <linux-iio+bounces-19403-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27289AB1CB9
	for <lists+linux-iio@lfdr.de>; Fri,  9 May 2025 20:56:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C3431BC6D96
	for <lists+linux-iio@lfdr.de>; Fri,  9 May 2025 18:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 681E224169B;
	Fri,  9 May 2025 18:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mrq3mndX"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A1D22D4CE;
	Fri,  9 May 2025 18:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746816970; cv=none; b=EZ0zM0fGoIqAUJmQtNdjL3tNp7w/qL8ARa61EDjfONzGRreYAuEIHBMPkcBpZoSmDyAHDzw5UVex93AMc8hVaa8j72VUs06ReDiwIktjvZB44oUnGcGqRYmxVDjA4PzGt6RCbStS7YOVkTXa3xylLkag2+96GLfqPkgr5tDaa/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746816970; c=relaxed/simple;
	bh=heDsPvF08m+NEMuUVpwBe65zvbdhtx/k4lRSvBkDrfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X1kgRntYtZaantZsnm5ZQENLQJyP0lVpo/pMwRy0tpCLhLrM8unRwaonBc0Lshu2v4PaAk7lmP+2zF83OCsnLiji87LpqHlAWNHUzRL0Twa9h1V/QwoTMe1rMixy9Zjy6zjgh8YsMglNseyoEp/bedzr6a0CGqFtUi6HKHNA3jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mrq3mndX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40FABC4CEE4;
	Fri,  9 May 2025 18:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746816969;
	bh=heDsPvF08m+NEMuUVpwBe65zvbdhtx/k4lRSvBkDrfQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mrq3mndXAyivhDJthv7GNp1II4tF4Sl4pzuSy8hM/22Nd8PsWSESH9TzXgrsTxFGu
	 Z46ri/Wv/o5USSoF8keSKUXwhoeFly3FGqkeOvEMyxq5nBZ6EllYrMTgbfOaGpAe7z
	 4CLCe54ZK9LD5/DhtzpmFIC7rDfiWbt/sGxl8rsU/0cl4slrE9VCcL/3B6GSL1zR67
	 Acxyq/9Mk4A8LnkSZ/IjBXV6m8ykcJ1GwxCInSA2tlIvUEwoFd/uGD0x+zJnwpE+a+
	 9qcY8AsW3XGMjMQjprHBJU7s6yHZrtcYxu1wUvYawlzZJtBX5po49Dr8aDsHSPygSp
	 YT5n45u7kiA6A==
Date: Fri, 9 May 2025 13:56:07 -0500
From: Rob Herring <robh@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, jic23@kernel.org, lars@metafoo.de,
	Michael.Hennerich@analog.com, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v2 1/7] dt-bindings: iio: adc: Add AD4170
Message-ID: <20250509185607.GA3913574-robh@kernel.org>
References: <cover.1745841276.git.marcelo.schmitt@analog.com>
 <add7510bd4c9f83011ab949f4fae2c77f57fbc43.1745841276.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <add7510bd4c9f83011ab949f4fae2c77f57fbc43.1745841276.git.marcelo.schmitt@analog.com>

On Mon, Apr 28, 2025 at 09:27:46AM -0300, Marcelo Schmitt wrote:
> Add device tree documentation for AD4170 and similar sigma-delta ADCs.
> The AD4170 is a 24-bit, multichannel, sigma-delta ADC.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---
> [device tree changes]
> - Referenced adc.yaml from sensor-node.
> - Merged property descriptions to reduce doc duplication.
> - Every child node type is now in the example.
> - Better described sensor-type property with a list of possible types.
> - Updated adi,excitation-pins description to cover a use case I had overlooked.
> - Added default to interrupt-names and to clock-names.
> - Added support for clock-output-names
> - Dropped '|' from descriptions when not needed.
> - Added extra example
> - 
> 
>  .../bindings/iio/adc/adi,ad4170.yaml          | 554 ++++++++++++++++++
>  MAINTAINERS                                   |   7 +
>  2 files changed, 561 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad4170.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4170.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4170.yaml
> new file mode 100644
> index 000000000000..679825be1f15
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4170.yaml
> @@ -0,0 +1,554 @@
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
> +    $ref: /schemas/iio/adc/adc.yaml#
> +    description:
> +      The AD4170 and similar designs have features to aid interfacing with weigh
> +      scale, RTD, and thermocouple sensors. Each of those sensor types requires
> +      either distinct wiring configuration or external circuitry for proper
> +      sensor operation and can use different AD4170 functionality on their
> +      setups. A key characteristic of those external sensors is that they must
> +      be excited either by voltage supply or by AD4170 excitation signals. The
> +      sensor can then be read through a pair of analog inputs. These properties
> +      describe external sensor circuitry connected to the ADC.
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
> +        description:
> +          Defines the ADC input pins used to read sensor data. Only regular
> +          analog input pins can be used.
> +        items:
> +          enum: [0, 1, 2, 3, 4, 5, 6, 7, 8]
> +
> +      bipolar: true
> +
> +      adi,sensor-type:
> +        description: |
> +          Type of sensor connected to the device. Depending on the sensor type
> +          (weigh scale, RTD, or thermocouple) the values of sensor-node
> +          properties have slightly different constraints. This property
> +          specifies which particular external sensor is connected to the ADC so
> +          the sensor-node properties can be properly parsed and verified. The
> +          possible sensor types are:
> +          0: weigh scale;
> +          1: RTD;
> +          2: thermocouple.
> +        $ref: /schemas/types.yaml#/definitions/uint8
> +
> +      adi,reference-select:
> +        description: |
> +          Selects the reference source to use when converting on the specific
> +          channel. Valid values are:
> +          0: Differential reference voltage REFIN+ - REFIN−.
> +          1: Differential reference voltage REFIN2+ - REFIN2−.
> +          2: Internal 2.5V referece (REFOUT) relative to AVSS.
> +          3: Analog supply voltage (AVDD) relative AVSS.
> +        $ref: /schemas/types.yaml#/definitions/uint8
> +        enum: [0, 1, 2, 3]
> +
> +      adi,excitation-ac:
> +        type: boolean
> +        description:
> +          Whether the external sensor has to be AC or DC excited.
> +
> +      adi,excitation-pins:
> +        $ref: /schemas/types.yaml#/definitions/uint32-array
> +        description:
> +          Pins used to excite the sensor or external circuit that contains the
> +          sensor. Thermocouples and RTD sensors are excited either with one
> +          current source or with a pair of current sources to minimize the
> +          excitation current mismatch and the excitation current drift matching
> +          on the ADC. E.g. <0>; <1>; <0 1>. Load cell weigh scales may be
> +          excited with one current source, a pair of excitation currents, or two
> +          pairs of excitation currents. When four pins are defined, the first
> +          two values specify the first pair and the last ones specify the second
> +          pair of excitation currents. E.g. <0>; <0 1>; <0 1 2 3>.
> +        items:
> +          minimum: 0
> +          maximum: 20
> +
> +      adi,excitation-current-microamp:
> +        description:
> +          Excitation current in microamperes to be output to each excitation pin
> +          specified by adi,excitation-pins property. If not provided and
> +          adi,excitation-ac is true, use predefined ACX1, ACX1 negated, ACX2,
> +          and ACX2 negated signals to AC excite the bridge circuit. Those
> +          singals are output on GPIO2, GPIO0, GPIO3, and GPIO1, respectively.
> +        enum: [0, 10, 50, 100, 250, 500, 1000, 1500]
> +        default: 0
> +
> +      adi,power-down-switch-pin:
> +        description:
> +          Number of the GPIO used as power-down switch for the bridge circuit.
> +        $ref: /schemas/types.yaml#/definitions/uint8
> +        enum: [0, 1]
> +
> +      adi,vbias:
> +        type: boolean
> +        description:
> +          For unbiased thermocouple applications, the voltage generated by the
> +          thermocouple must be biased around some DC voltage. When present, this
> +          property specifies a bias voltage of (AVDD + AVSS)/2 to be applied as
> +          common-mode voltage for the sensor.
> +
> +    required:
> +      - reg
> +      - diff-channels
> +      - bipolar
> +      - adi,sensor-type
> +      - adi,reference-select
> +
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
> +    description:
> +      Specify which pin should be configured as Data Ready interrupt.
> +    enum:
> +      - sdo
> +      - dig_aux1
> +    default: sdo
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
> +    default: ext-clk
> +
> +  '#clock-cells':
> +    const: 0
> +
> +  clock-output-names:
> +    maxItems: 1
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
> +
> +      single-channel: true
> +
> +      common-mode-channel: true
> +
> +      bipolar: true
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
> +        default: 1
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
> +        default: 1
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

You already defined the type in the $defs, so no need to do it again.

> +        enum: [0, 1, 2, 3]
> +        default: 2
> +
> +    required:
> +      - reg
> +
> +    allOf:

Don't need allOf.

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

Already defined the type. And for the rest...


Rob

