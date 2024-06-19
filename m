Return-Path: <linux-iio+bounces-6587-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 865B890ED0F
	for <lists+linux-iio@lfdr.de>; Wed, 19 Jun 2024 15:13:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0342128172E
	for <lists+linux-iio@lfdr.de>; Wed, 19 Jun 2024 13:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F1E146016;
	Wed, 19 Jun 2024 13:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="lD2auHLT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3E9143C4A
	for <linux-iio@vger.kernel.org>; Wed, 19 Jun 2024 13:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718802825; cv=none; b=i0vJJugtHNvQUhoQWcw0fhOp/Efr29ho9iGTJ7IJGrdC/2JM4RZrU+YZOdu+hhpxrgyl/+r1R2RHeNme1Cg9QMQ9JItrFfPLwWNDhILfjSGiJZE4N8vBKas5HN7axRVEy/PZQlAmXPp4auJMRwuU6Tms3bIGqqGpRj/LdXys53U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718802825; c=relaxed/simple;
	bh=RbvmbYLOdTN1Un4qHqxrpTPM2JdpExyrZq/4gE2q0MU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XxoeG59vG3aieAtx6KCdsPxs9itpwyOMMtMKAedtLYBqkytqViT22Zg6I/VDIqn+HyBveHwHYIdTmjhE9N4xQPcw9C7G4zzQB0VLsHFg+n8S08F/dWiDFYEZ+BGgRiEemsTcfJCqgXaSZ6xc/nXXPjIrceDYcTovx69BcrCTAiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=lD2auHLT; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6f9fbec4fd9so3835403a34.2
        for <linux-iio@vger.kernel.org>; Wed, 19 Jun 2024 06:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718802822; x=1719407622; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ivs1qkflrAzWFvaDZPs9VVhewLqqdL+rqJ080vGZJVQ=;
        b=lD2auHLT2/xEze50+hztLX3b5g3wbbtLFzzPgXxgx1D278XPUbiIhe6ERr+PZjqSBA
         wLsZ1zvnCo3liRT6sA3fqtCbaJnnkLBKHnxRVWLjHs6pfepRoXaeVp+FQQT4HAx2Y9QM
         vPycsH5i/wuntJOE0ZxfArM6tXbeuF6NkvbGqSHFmX9q0Ct6vk4ouNLQ3r454fvtfP6f
         XiG3SzL1PuXAhA0oyzodp9uETXk1EcXD0xZlHWQVhXZ/5yZw1nNQEde7NQrpm15zitEM
         gWQZ003+MpnPPHY6N9CW9V2hloXzLrN2LC/BuQ74Jl8LB8/Gmx/F+EZJ69Wc93XP81Y2
         +GSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718802822; x=1719407622;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ivs1qkflrAzWFvaDZPs9VVhewLqqdL+rqJ080vGZJVQ=;
        b=COeh1XolvuEikL8Ssa4j6qUGlhWE28e/6LjZiSrkn6gbrTsJnWq37hlqBC3QIDDa2U
         LhbwOiPxCEyxtLcWP05WrwdlbJcvECAcpvVPI7AJ9RsDq8d7RIHhDzb/53Xm2oBk7Cdh
         EeeLKEZQxc+mO5l8qQb9EJh67QYo+iYL4EtYRRUpfB0hi5D8bzXK3QxphMHI8pCzrJjT
         W4GPfL01w+acRhNk4Swr7/jvDRMks6GzdLQn6lNXSB6vCTBODElp3nzHjP6+5ZVnX88I
         VrbEWm0SDUIcordd2JZ+jMJx5PqQDZfj8JHZN44nuzcxRlGjegQRNPQc0P9Tmgh0XuDT
         GsTA==
X-Gm-Message-State: AOJu0YzEuhqtFLVNPyRy9ZzoL8bU4n16aYB5k5GCf3XdpsfgcJWXFtE4
	rpKg8+OvsqlpQ0mwFDkn6w6xkZTegIwIN9p3jqHLVAyqwKydvVBQ1ZQ/Ttp8vJo=
X-Google-Smtp-Source: AGHT+IGTiXqUEaPrvDuYDPma+ZzU82AzsVFd9laW0PY6g+H5Fk6mm4lYrZvrDo5NZldw4NMTs1wjdQ==
X-Received: by 2002:a9d:77d1:0:b0:6f9:5dbf:d3af with SMTP id 46e09a7af769-70074302bbbmr2925141a34.22.1718802822490;
        Wed, 19 Jun 2024 06:13:42 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-6fb5b1b2de9sm2199447a34.29.2024.06.19.06.13.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jun 2024 06:13:42 -0700 (PDT)
Message-ID: <38f99355-0186-4c2f-912a-cb03d6e4823c@baylibre.com>
Date: Wed, 19 Jun 2024 08:13:41 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/6] dt-bindings: iio: adc: Add AD4000
To: Marcelo Schmitt <marcelo.schmitt@analog.com>, broonie@kernel.org,
 lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 nuno.sa@analog.com, marcelo.schmitt1@gmail.com
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1718749981.git.marcelo.schmitt@analog.com>
 <34a16c6e513b32bc6111b695e1c8b467bd6993d9.1718749981.git.marcelo.schmitt@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <34a16c6e513b32bc6111b695e1c8b467bd6993d9.1718749981.git.marcelo.schmitt@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/18/24 6:12 PM, Marcelo Schmitt wrote:
> Add device tree documentation for AD4000 series of ADC devices.
> 
> Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/ad4000-4004-4008.pdf
> Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/ad4001-4005.pdf
> Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/ad4002-4006-4010.pdf
> Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/ad4003-4007-4011.pdf
> Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/ad4020-4021-4022.pdf
> Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/adaq4001.pdf
> Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/adaq4003.pdf

Datasheets URLs are listed in the patch, so probably don't need them
in the commit message too.

> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---
>  .../bindings/iio/adc/adi,ad4000.yaml          | 231 ++++++++++++++++++
>  MAINTAINERS                                   |   7 +
>  2 files changed, 238 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad4000.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4000.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4000.yaml
> new file mode 100644
> index 000000000000..ba50f9e0784b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4000.yaml
> @@ -0,0 +1,231 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/adi,ad4000.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices AD4000 and similar Analog to Digital Converters
> +
> +maintainers:
> +  - Marcelo Schmitt <marcelo.schmitt@analog.com>
> +
> +description: |
> +  Analog Devices AD4000 family of Analog to Digital Converters with SPI support.
> +  Specifications can be found at:
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad4000-4004-4008.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad4001-4005.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad4002-4006-4010.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad4003-4007-4011.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad4020-4021-4022.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/adaq4001.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/adaq4003.pdf
> +
> +$ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - const: adi,ad4000
> +      - items:
> +          - enum:
> +              - adi,ad4004
> +              - adi,ad4008
> +          - const: adi,ad4000
> +      - const: adi,ad4001
> +      - items:
> +          - enum:
> +              - adi,ad4005
> +          - const: adi,ad4001
> +      - const: adi,ad4002
> +      - items:
> +          - enum:
> +              - adi,ad4006
> +              - adi,ad4010
> +          - const: adi,ad4002
> +      - const: adi,ad4003
> +      - items:
> +          - enum:
> +              - adi,ad4007
> +              - adi,ad4011
> +          - const: adi,ad4003
> +      - const: adi,ad4020
> +      - items:
> +          - enum:
> +              - adi,ad4021
> +              - adi,ad4022
> +          - const: adi,ad4020
> +

There are data sheets listed for adaq400x but no compatibles.

> +  reg:
> +    maxItems: 1
> +
> +  spi-max-frequency:
> +    maximum: 102040816 # for VIO > 2.7 V, 81300813 for VIO > 1.7 V
> +
> +  adi,spi-mode:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    enum: [ single, chain ]
> +    description: |
> +      This property indicates the SPI wiring configuration.
> +
> +      When this property is omitted, it is assumed that the device is using what
> +      the datasheet calls "4-wire mode". This is the conventional SPI mode used
> +      when there are multiple devices on the same bus. In this mode, the CNV
> +      line is used to initiate the conversion and the SDI line is connected to
> +      CS on the SPI controller.
> +
> +      When this property is present, it indicates that the device is using one
> +      of the following alternative wiring configurations:
> +
> +      * single: The datasheet calls this "3-wire mode". (NOTE: The datasheet's
> +        definition of 3-wire mode is NOT at all related to the standard
> +        spi-3wire property!) This mode is often used when the ADC is the only
> +        device on the bus. In this mode, SDI is connected to MOSI or to VIO, and
> +        the CNV line can be connected to the CS line of the SPI controller or to
> +        a GPIO, in which case the CS line of the controller is unused.
> +      * chain: The datasheet calls this "chain mode". This mode is used to save
> +        on wiring when multiple ADCs are used. In this mode, the SDI line of
> +        one chip is tied to the SDO of the next chip in the chain and the SDI of
> +        the last chip in the chain is tied to GND. Only the first chip in the
> +        chain is connected to the SPI bus. The CNV line of all chips are tied
> +        together. The CS line of the SPI controller can be used as the CNV line
> +        only if it is active high.
> +
> +  '#daisy-chained-devices': true
> +
> +  vdd-supply:
> +    description: A 1.8V supply that powers the chip (VDD).
> +
> +  vio-supply:
> +    description:
> +      A 1.8V to 5.5V supply for the digital inputs and outputs (VIO).
> +
> +  ref-supply:
> +    description:
> +      A 2.5 to 5V supply for the external reference voltage (REF).
> +
> +  cnv-gpios:
> +    description:
> +      The Convert Input (CNV). This input has multiple functions. It initiates
> +      the conversions and selects the SPI mode of the device (chain or CS). In
> +      'single' mode, this property is omitted if the CNV pin is connected to the
> +      CS line of the SPI controller.
> +    maxItems: 1
> +
> +  adi,high-z-input:
> +    type: boolean
> +    description:
> +      High-Z mode allows the amplifier and RC filter in front of the ADC to be
> +      chosen based on the signal bandwidth of interest, rather than the settling
> +      requirements of the switched capacitor SAR ADC inputs.
> +
> +  adi,gain-milli:
> +    description: |
> +      The hardware gain applied to the ADC input (in milli units).
> +      The gain provided by the ADC input scaler is defined by the hardware
> +      connections between chip pins OUT+, R1K-, R1K1-, R1K+, R1K1+, and OUT-.
> +      If not present, default to 1000 (no actual gain applied).
> +    $ref: /schemas/types.yaml#/definitions/uint16

Any particular reason why this needs to be uint16 instead of the more
common uint32?

> +    enum: [454, 909, 1000, 1900]
> +    default: 1000
> +
> +  interrupts:
> +    description:
> +      The SDO pin can also function as a busy indicator. This node should be
> +      connected to an interrupt that is triggered when the SDO line goes low
> +      while the SDI line is high and the CNV line is low ('single' mode) or the
> +      SDI line is low and the CNV line is high ('multi' mode); or when the SDO
> +      line goes high while the SDI and CNV lines are high (chain mode),
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - vdd-supply
> +  - vio-supply
> +  - ref-supply
> +
> +allOf:
> +  # in '4-wire' mode, cnv-gpios is required, for other modes it is optional
> +  - if:
> +      not:
> +        required:
> +          - adi,spi-mode
> +    then:
> +      required:
> +        - cnv-gpios
> +  # The configuration register can only be accessed in '3-wire' mode
> +  - if:
> +      not:
> +        properties:
> +          adi,spi-mode:
> +            contains:
> +              enum:
> +                - single

adi,spi-mode is not an array and we are only checking for one value,
so this could be simplified to:

  properties:
    adi,spi-mode:
      const: single

> +    then:
> +      properties:
> +        adi,high-z-input: false
> +  # chain mode has lower SCLK max rate
> +  - if:
> +      required:
> +        - adi,spi-mode
> +      properties:
> +        adi,spi-mode:
> +          const: chain
> +    then:
> +      properties:
> +        spi-max-frequency:
> +          maximum: 50000000 # for VIO > 2.7 V, 40000000 for VIO > 1.7 V
> +      required:
> +        - '#daisy-chained-devices'
> +    else:
> +      properties:
> +        '#daisy-chained-devices': false
> +  # Gain property only applies to ADAQ devices
> +  - if:
> +      properties:
> +        compatible:
> +          not:
> +            contains:
> +              enum:
> +                - adi,adaq4001
> +                - adi,adaq4003
> +    then:
> +      properties:
> +        adi,gain-milli: false
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        /* Example for a AD devices */

Comments are a bit redundant since it says "examples:" above and
the type of the chip in the compatible string.

> +        adc@0 {
> +            compatible = "adi,ad4020";
> +            reg = <0>;
> +            spi-max-frequency = <71000000>;
> +            vdd-supply = <&supply_1_8V>;
> +            vio-supply = <&supply_1_8V>;
> +            ref-supply = <&supply_5V>;
> +            cnv-gpios = <&gpio0 88 GPIO_ACTIVE_HIGH>;
> +        };
> +    };
> +  - |
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        /* Example for a ADAQ devices */
> +        adc@0 {
> +            compatible = "adi,adaq4003";
> +            reg = <0>;
> +            spi-max-frequency = <80000000>;
> +            vdd-supply = <&supply_1_8V>;
> +            vio-supply = <&supply_1_8V>;
> +            ref-supply = <&supply_5V>;
> +            adi,high-z-input;
> +            adi,gain-milli = /bits/ 16 <454>;
> +            adi,spi-mode = "single";
> +        };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index bff979a507ba..1f052b9cd912 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1200,6 +1200,13 @@ W:	https://ez.analog.com/linux-software-drivers
>  F:	Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
>  F:	drivers/iio/dac/ad3552r.c
>  
> +ANALOG DEVICES INC AD4000 DRIVER
> +M:	Marcelo Schmitt <marcelo.schmitt@analog.com>
> +L:	linux-iio@vger.kernel.org
> +S:	Supported
> +W:	https://ez.analog.com/linux-software-drivers
> +F:	Documentation/devicetree/bindings/iio/adc/adi,ad4000.yaml
> +
>  ANALOG DEVICES INC AD4130 DRIVER
>  M:	Cosmin Tanislav <cosmin.tanislav@analog.com>
>  L:	linux-iio@vger.kernel.org


