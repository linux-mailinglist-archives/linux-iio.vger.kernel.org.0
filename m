Return-Path: <linux-iio+bounces-19502-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86960AB5908
	for <lists+linux-iio@lfdr.de>; Tue, 13 May 2025 17:48:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15DF419E0D89
	for <lists+linux-iio@lfdr.de>; Tue, 13 May 2025 15:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 474552BE7C0;
	Tue, 13 May 2025 15:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="dsyo08kx"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD3F2BE110
	for <linux-iio@vger.kernel.org>; Tue, 13 May 2025 15:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747151256; cv=none; b=UaOh7KhnHTsb4U+C13Fuek/Pv/sJoarBZ49HNy0XG2eZTyrRe+Khzz0EtiP/yJ44lUIDx8mwFjYYvSLDpFU1gH7TKRi2O8WPsBQrpVLmRegGlJqQfrKrCkdcWLaC2F0a4/icqLCrLOuGcYO8b+kSO8e7hIJXi3Mv71KjSoSTEvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747151256; c=relaxed/simple;
	bh=LgWjVXLxMRmZWHXKYHj/TIb6AGXxEOc2zoBozKupXMA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X6aS+Af6heZPi5xxHRT/g0ZNcEwEKLI0jlk/5RCJA0GFkk/UKtvyZ5uDcTOKN50m8+UFKsofETCRmGf9hJS4nRPONezp3aGZz/RoBiYopSmde96sbb8/02ZO2ZhoT/MunEXxJFfFVgSiut4ShVMqdaybCnB9Nxiau89IWt2x/do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=dsyo08kx; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-72c27166ab3so4228981a34.1
        for <linux-iio@vger.kernel.org>; Tue, 13 May 2025 08:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1747151252; x=1747756052; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jvqK9h8ZXoVcJjo3l2Osc+9QJUEe79cCes8JJ/MXKKI=;
        b=dsyo08kxEXIy8UdqaDekBb2beEns+rvSvXKMgDuwGc49P0bpi6IwJM/LFdMu+j3V5X
         0mih6ZDgHEbmMzmK/Wahlgpda/DKAKfTU0xWtH67nIKUw2WlLtKLGsDuNjw5ZLYF7bz3
         YN09TGMEAGMH5HuAlf0UsFNXJHIYMQ9fSKT+ykrGIgjJIUnngrBrUEpmEanldqUDd4uh
         h/7wmN1ljI89MYM1ZNFkXu1Yw70GIuPnJk+oCSmFjU5RYQW4688x0LhwHOvmGN06t4RD
         BgBYfeM3SKFp/GRskDju2+K6olLvEDE2MOI9ndGXohpxypifDuyUMMAsi5StDdDXz0TI
         sVKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747151252; x=1747756052;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jvqK9h8ZXoVcJjo3l2Osc+9QJUEe79cCes8JJ/MXKKI=;
        b=bOM1Buagq30DvdUmrpm30f6HNK+9icQzfoG0VCmY77eOFSuWmRqZFTMZFiR+iobt7a
         hcF7mCIOpUzhBt/UjcWP76QSFBFesRTj9xr7NZZme13rCLwaEKL7USUstwcLtZU28Qpn
         MuLfpzl3RZsLFW6Q5G6L+GgvRGPees5I72UqxJo9qHxB0rA7nR5clUGXPPub+M42lHtG
         wS1e5Mrrw5stmCkhBLWomQcrS7ikNGdBuSRu2e+tSp6LxcAE5Jyh5IyKkKEZ10Iu8Wgs
         45a5ZYPbsYQpgDR3hsDmzbQumXKgbRINBa2mFriM9i4/t1P6mojDF0hssXqgWK0MbIC0
         id1Q==
X-Forwarded-Encrypted: i=1; AJvYcCV6TwnGx3AWWVHN+1RBgBJtMAP07R1dSsDNIQ1rc22r9D+B8mAUNys1aJAn2sw1mVRNRJ3dI/czNdQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzU5Wyt35PNxyKtIuQFHM4wvWR3pxNcrgXzV4g8mnPshnN/hEW9
	XtjwQSiU3WeP59vITXvz8hGrkVXGOEYa9DV/ijlNXftbZvs3gMa54AzC7wTLB9A=
X-Gm-Gg: ASbGncvWXAhzLWzk75PVGIJrkeLEzqIO52uUxpEI+qZ+5Wguo5HUrCkUVgmfhsZEuOP
	tqpr4PG/l2XUPmbmFP/rkahQbMCOCUh4bt9LfKRuhh9WQoRXYJbCW+b9hs74ZcB9nYNQzl/U0cn
	DYQq6nUaK+rBsbRk5WtTSUeT62LVu8V0vSX4qusiLBgws+vN1JDgD4wCZrwyinkRjYt+lIQGyES
	NBeovbQNSM/DYOPmRe3HDOA/8+NJMUmWpxcj7EkIN2QVVTvfDPLzIGdrgmS4gfvnVqGlPQ08YGh
	Be3f8k+TsWmAKADahpC7JxUTm7AA4d6iCV1N5adJQM5Pvv90joPOii7Wz+Ij4vDAo1Okjc5R0Qs
	KuYO8q1v3Wk59jRH18LfNf4U=
X-Google-Smtp-Source: AGHT+IEDZtsdMIkMEjqjGIW2pZvIngRPUib7P8CaLk/cn2NBC/c3zT+CnAGOqZVaFiqMiE4gHHF9ow==
X-Received: by 2002:a05:6830:3498:b0:72b:9506:8db6 with SMTP id 46e09a7af769-732269bd8f8mr9591947a34.6.1747151252251;
        Tue, 13 May 2025 08:47:32 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:d74:845a:15c:3fdc? ([2600:8803:e7e4:1d00:d74:845a:15c:3fdc])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-732265f95c6sm1956222a34.63.2025.05.13.08.47.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 May 2025 08:47:31 -0700 (PDT)
Message-ID: <2ab9a6e2-a331-4995-8d42-00290bc825e7@baylibre.com>
Date: Tue, 13 May 2025 10:47:30 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/10] dt-bindings: iio: adc: Add AD4170
To: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: jic23@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com,
 nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, linus.walleij@linaro.org, brgl@bgdev.pl,
 marcelo.schmitt1@gmail.com
References: <cover.1747083143.git.marcelo.schmitt@analog.com>
 <5fa867cff437c0c6d3f0122af823e1677a12d189.1747083143.git.marcelo.schmitt@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <5fa867cff437c0c6d3f0122af823e1677a12d189.1747083143.git.marcelo.schmitt@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/13/25 7:33 AM, Marcelo Schmitt wrote:
> Add device tree documentation for AD4170 and similar sigma-delta ADCs.
> The AD4170 is a 24-bit, multichannel, sigma-delta ADC.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---
> Change log v2 -> v3
> 
> [device tree changes]
> - Removed unneeded allOf.
> - Removed occurences of adi,sensor-type type re-declaration.
> - Created type for the AD4170 channels, allowing to avoid dt doc repetition.
> 
>  .../bindings/iio/adc/adi,ad4170.yaml          | 544 ++++++++++++++++++
>  MAINTAINERS                                   |   7 +
>  2 files changed, 551 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad4170.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4170.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4170.yaml
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
> +  Analog Devices AD4170 series of Sigma-delta Analog to Digital Converters.
> +  Specifications can be found at:
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad4170-4.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad4190-4.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad4195-4.pdf
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
> +          Selects the reference source to use when converting on the specific
> +          channel. Valid values are:
> +          0: Differential reference voltage REFIN+ - REFIN−.
> +          1: Differential reference voltage REFIN2+ - REFIN2−.
> +          2: Internal 2.5V referece (REFOUT) relative to AVSS.
> +          3: Analog supply voltage (AVDD) relative AVSS.
> +        $ref: /schemas/types.yaml#/definitions/uint8
> +        enum: [0, 1, 2, 3]
Using strings instead of int for this and most of the other custom enums here
would make them self-documenting and easier to use.

> +
> +
> +  sensor-node:
> +    type: object
> +    $ref: '#/$defs/ad4170-channel'
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
This property seems reduandant since it has to match the node name.

i.e. weighscale@... is is always adi,sensor-type = <0>; and so on.

> +
> +      adi,excitation-ac:
> +        type: boolean
> +        description:
> +          Whether the external sensor has to be AC or DC excited.
Description could be more clear than when omitted, it is DC excited.

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
This isn't required, so what is the default if omitted?

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
s/Referece/Reference/

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
> +    maxItems: 1> +
> +  interrupt-names:
> +    description:
> +      Specify which pin should be configured as Data Ready interrupt.
> +    enum:
> +      - sdo
> +      - dig_aux1
> +    default: sdo> +
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
Shouldn't there be a depedency that if clocks is given, then clock-names is requried.

> +
> +  '#clock-cells':
> +    const: 0
> +
> +  clock-output-names:
> +    maxItems: 1
And if #clock-cells is given then clocks is forbidden.

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

A Header file with macros for these would be nice since it seems like we
have to use the higher-numbered ones a lot with the common-mode-channel
properties in the examples.

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
Could make a $def for these too to reduce duplication.

Also another case where string type would make more sense.

> +
> +    required:
> +      - reg

reg is already required by adc.yaml

> +
> +    oneOf:
> +      - required: [single-channel]

Is there a default for common-mode-channel if it isn't required in this case?

> +        properties:
> +          diff-channels: false
> +      - required: [diff-channels]
> +        properties:
> +          single-channel: false
> +          common-mode-channel: false
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
> +        const: 0
> +
> +      adi,excitation-pins: true
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
> +        const: 1
> +
> +      adi,excitation-pins: true
> +
> +      adi,excitation-current-microamp: true
> +
> +    required:
> +      - adi,excitation-pins
> +      - adi,excitation-current-microamp
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
> +        const: 2
> +
> +    required:
> +      - adi,excitation-pins
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

The patternProperties: section is so big, it would be nice to move these
before it so the are closer to the properties they actually affect.

