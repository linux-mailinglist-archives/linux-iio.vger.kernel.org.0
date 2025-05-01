Return-Path: <linux-iio+bounces-18943-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EEDFDAA6264
	for <lists+linux-iio@lfdr.de>; Thu,  1 May 2025 19:37:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 526FD4C1D4B
	for <lists+linux-iio@lfdr.de>; Thu,  1 May 2025 17:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0987217F5C;
	Thu,  1 May 2025 17:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Pg4KBypU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACCF204863
	for <linux-iio@vger.kernel.org>; Thu,  1 May 2025 17:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746121046; cv=none; b=mZwqdgv82cX7X3KoCATzab6RyHwstmJVNOQH86F8WMuHXjKcJzfARMciOTcpPa4MHBSq3SwwUImfogXZd7nKs42oRB0qC6t8xdeKu5OB72NqIKZWUkcj6s7ZFig0/NqCrk5tzs9DdQDEXduR6mrXESR4HFyyhDaB8+B+CqkVFbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746121046; c=relaxed/simple;
	bh=1L3/NCL7TJkaCN+4lAJabZU6CsrzDXijUii+nvBNIKs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TS2WzjbxB6qAnrXBgmmB1NLp+VN86nkOgKJxCSHtmAnHvCatce05MPK5Of0etLoVzl1tYPCqCu0ZxJSntDvOKTqUOrIVTL+WkrO9HtJliLgcxBi3DNCesDnmDy8wXTaIRfjVsHMF+SF05k4MWMfzsr4qiB3u96DMHxtOUK1gAVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Pg4KBypU; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-605f7d3215cso614575eaf.0
        for <linux-iio@vger.kernel.org>; Thu, 01 May 2025 10:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1746121043; x=1746725843; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5gCGeZx+LjxydnEdalUtnjSKhCJu8pLazJohhfHgkO0=;
        b=Pg4KBypU5trILjnhGpXxlytaGToyqyRVguJk1iWRskYgGGZfVzIlU3HUvz2naFMuOp
         85k8U3kaewtL63yo30DHWRt2jY3rrwj+MbtKzDY/wjqPAKWD90Rw41k3oLvaYYsxoLWH
         Gl3TCHcgy4lMmhpVzzZguVYxC/zvs+By0Qlx6MB3wJL+s+uIjtb2qG+zPdv5fvio17cP
         D/QQGkP/zbVDKVSg/Jw3uIVUwTZmmc5Hf4c7b0xkiCPGwuPQJrfBE+ISAfvtwKMrv0dh
         a0E/NS03KfrI6Dd5zUekMTcxFl1FO/EI0v8O4KuCUve0XwDvFK8Jz52UUqwnsjL2pqP+
         IlsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746121043; x=1746725843;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5gCGeZx+LjxydnEdalUtnjSKhCJu8pLazJohhfHgkO0=;
        b=Gupx7lnZ4+CBbIlsq54mSAPqJvLF0+Tw49pVFCvGjWPHGJz13cAb0utFC4v1VMhGb5
         r2DVdzAoOEYArl1copTACzi20oU5fux6wz7exujKlyszyRHoz/vXfKiWmfKdPVHuU9K0
         yaVq5kVFBRsq3CO9zkFjlcWTULTfRmAequIvhfxtNfKCkwOO+eIe0xYz4ZxqGIYQNpuf
         jMxGhkiA/p0lZPrNR7Vz04Z/jOfbnpuAQ3OWtm4nZtJmsG5BfU63mcNP92nJmy+hiI+I
         W5Txzxhw57+TLo40MkmIzNxkuhBDw/FDCDCmBv8lET2ui4oLlhvrzqdGwUWDqCH649yY
         CrhQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5hiBpWTR3lrCSKsq3LhI3QgA9OH9NdHR3f3Kd4HO0I37rqrxWjlnboc8VMnuvHi3kNFfVcte4LBQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXVGherbOYMLyseaOLdaQOOHUZQNfpOzJVLdoXCBTNgN0CRDKd
	wjwGkeoOaqfPPnHumIfEHCV8RKQzg0zNqK/uTp455Hm2oZcrixlEk/EvPnU3fok=
X-Gm-Gg: ASbGncvqiz3dJDvYfd9PZ2zkfTcZfFjLtE3ifIsJzMA/06x7nofI3lWT3JfEZgB5Yu3
	pgGXyLwf9LR2nwsdUmHmiIZXBs6yumJIHi/DnrPWMqKjsobLSb+Rc+3W1SWGGsGRe87wK32VYOo
	3zDwlYavirBhUm8nGfmyKAAsoyERXs73wywLP7J6FRufDT++ILvPC6xiyRXz6O7Kon8RPmdP0/Y
	xjHFjBQf8OaMyhmdonu1JD4ACh2bhX6zhyFhPi8RFNxyc62ykDCu4Vkn4qE0FpbHPMBCKilVOxI
	k+B4K///gSfbMtUxSxmpGbyy6UCOBwiaGlPrlGGKvct74ZKhs7ktUcGEy5qm9iGj6HFXH/Gby0C
	uGf2OEIbY6XZb2vO6Qscp5oP9fRUZ
X-Google-Smtp-Source: AGHT+IFFiJ5CMMoNBA8sEnTpfASSw3P278n1k6MkkRfBVIRwZUkXTSjxm+N/VMpA5ByWEyamwY3svA==
X-Received: by 2002:a4a:ee06:0:b0:606:361b:52a6 with SMTP id 006d021491bc7-607e0d41e9amr2410872eaf.4.1746121043328;
        Thu, 01 May 2025 10:37:23 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:b1ed:e5d7:8ea6:40e0? ([2600:8803:e7e4:1d00:b1ed:e5d7:8ea6:40e0])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-607e7d8b817sm196079eaf.13.2025.05.01.10.37.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 May 2025 10:37:21 -0700 (PDT)
Message-ID: <c262ecaf-598f-46a4-976d-bbc4ae0167b6@baylibre.com>
Date: Thu, 1 May 2025 12:37:20 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 5/5] dt-bindings: iio: adc: add bindings for TI
 ADS1262
To: Sayyad Abid <sayyad.abid16@gmail.com>, linux-iio@vger.kernel.org
Cc: jic23@kernel.org, lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, nuno.sa@analog.com, javier.carrasco.cruz@gmail.com,
 olivier.moysan@foss.st.com, gstols@baylibre.com, tgamblin@baylibre.com,
 alisadariana@gmail.com, eblanc@baylibre.com, antoniu.miclaus@analog.com,
 andriy.shevchenko@linux.intel.com, stefan.popa@analog.com,
 ramona.gradinariu@analog.com, herve.codina@bootlin.com,
 tobias.sperling@softing.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250501100043.325423-1-sayyad.abid16@gmail.com>
 <20250501100043.325423-6-sayyad.abid16@gmail.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250501100043.325423-6-sayyad.abid16@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/1/25 5:00 AM, Sayyad Abid wrote:
> Add the Device Tree binding documentation for the Texas Instruments ADS1262 ADC.
> 
> Signed-off-by: Sayyad Abid <sayyad.abid16@gmail.com>
> ---

For readers, it logically makes more sense to have this be the first patch in
the series.

>  .../bindings/iio/adc/ti,ads1262.yaml          | 189 ++++++++++++++++++
>  1 file changed, 189 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads1262.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads1262.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads1262.yaml
> new file mode 100644
> index 000000000000..8c4cc2cf6467
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/ti,ads1262.yaml
> @@ -0,0 +1,189 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/ti,ads1262.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Texas Instruments' ADS1262 32-Bit Analog to Digital Converter
> +
> +maintainers:
> +  - Sayyad Abid <sayyad.abid16@gmail.com>
> +
> +description: |
> +  Texas Instruments ADS1262 32-Bit Analog to Digital Converter with,
> +  internal temperature sensor, GPIOs and PGAs
> +
> +  The ADS1262 is a 32-bit, 38-kSPS, precision ADC with a programmable gain
> +  amplifier (PGA) and internal voltage reference. It features:
> +  - 11 single-ended or 5 differential input channels
> +  - Internal temperature sensor
> +  - Programmable gain amplifier (PGA) with gains from 1 to 32
> +  - Internal voltage reference
> +  - GPIO pins for control and monitoring
> +  - SPI interface

Normally, I would say that we want to have the devicetree as complete as
possible, but this chip has so many ways to wire it up, it would take days
to do a through review, so not sure where to draw the line. But I think there
are a few obvious ones we could still add, even if the driver doesn't use them
yet.

interrupts: for the /DRDY output

clks: for the clock input (see adi,ad7173 and adi,ad7192 for inspiration)

gpio-controller and #gpio-cells: for AIN pins used as GPIO

And for later...
* voltage supply outputs
* DAC outputs
* common mode voltage inputs
* REF{P.N}{1,2,3} supplies
* per-channel reference selection


> +
> +  Specifications about the part can be found at:
> +  https://www.ti.com/product/ADS1262
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ti,ads1262
> +
> +  reg:
> +    maxItems: 1
> +    description: SPI chip select number
> +
> +  spi-max-frequency:
> +    maximum: 7372800
> +    description: Maximum SPI clock frequency in Hz (7.3728 MHz)

Datasheet says minimum period is 125 ns, so that would make the max 8 MHz.

> +
> +  spi-cpha:
> +    type: boolean
> +    description: Required for SPI mode 1 operation
> +
> +  reset-gpios:
> +    maxItems: 1
> +    description: GPIO specifier for the reset pin (active low)
> +
> +  vref-supply:
> +    description: |
> +      The regulator supply for ADC reference voltage. If not specified,
> +      the internal 2.5V reference will be used.
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +
> +  '#io-channel-cells':
> +    const: 1
> +
> +  ti,pga-bypass:
> +    type: boolean
> +    description: |
> +      If true, bypass the PGA. If false or not specified, PGA is enabled.

Why is this one global but the actual gain per-channel?

> +
> +  ti,data-rate:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 0
> +    maximum: 15
> +    description: |
> +      Data acquisition rate in samples per second
> +      0: 2.5
> +      1: 5
> +      2: 10
> +      3: 16.6
> +      4: 20
> +      5: 50
> +      6: 60
> +      7: 100
> +      8: 400
> +      9: 1200
> +      10: 2400
> +      11: 4800
> +      12: 7200
> +      13: 14400
> +      14: 19200
> +      15: 38400

This is something that should be implemented with a sampling_frequency attribute
so that it can be changed at runtime rather than be hard-coded in the devicetree.

> +
> +required:
> +  - compatible
> +  - reg
> +  - spi-cpha
> +  - '#address-cells'
> +  - '#size-cells'
> +  - '#io-channel-cells'
> +
> +additionalProperties: false
> +
> +patternProperties:
> +  "^channel@([0-9]|1[0-1])$":
> +    type: object
> +    additionalProperties: false
> +    description: |
> +      Represents the external channels which are connected to the ADC.
> +      Channels 0-9 are available for external signals, channel 10 is AINCOM,
> +      and channel 11 is the internal temperature sensor.
> +
> +    properties:
> +      reg:
> +        description: |
> +          Channel number. It can have up to 10 channels numbered from 0 to 9,
> +          channel 10 is AINCOM, and channel 11 is the internal temperature sensor.
> +        items:
> +          - minimum: 0
> +            maximum: 11

Why allow the temperature input here but not other diagnostic input? Would make
more sense to me to omit temperature from the devicetree since it doesn't have
different wiring possibilities like the AIN pins.

> +
> +      diff-channels:
> +        description: |
> +          List of two channel numbers for differential measurement.
> +          First number is positive input, second is negative input.
> +          Not applicable for temperature sensor (channel 11).
> +        items:
> +          - minimum: 0
> +            maximum: 9
> +          - minimum: 0
> +            maximum: 9

Shouldn't this have max of 10 to include AINCOM?

> +
> +      ti,gain:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        minimum: 0
> +        maximum: 5
> +        description: |
> +          PGA gain setting. Not applicable for temperature sensor (channel 11).
> +          0: 1 (default)
> +          1: 2
> +          2: 4
> +          3: 8
> +          4: 16
> +          5: 32
> +
> +    required:
> +      - reg
> +
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    spi {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      ads1262: adc@0 {
> +        compatible = "ti,ads1262";
> +        reg = <0>;
> +        spi-max-frequency = <7372800>;
> +        vref-supply = <&adc_vref>;
> +        spi-cpha;
> +        reset-gpios = <&gpio1 16 GPIO_ACTIVE_LOW>;
> +        ti,pga-bypass;

If PGA is bypassed...

> +        ti,data-rate = <15>; /* 38400 SPS */
> +
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        #io-channel-cells = <1>;
> +
> +        /* Single-ended channel */
> +        channel@0 {
> +          reg = <0>;
> +        };
> +
> +        /* Differential channel */
> +        channel@1 {
> +          reg = <1>;
> +          diff-channels = <1 2>;
> +          ti,gain = <2>; /* Gain of 4 */

...then gain doesn't make sense here.

> +        };
> +
> +        /* Temperature sensor */
> +        channel@11 {
> +          reg = <11>;
> +        };
> +      };
> +    };
> +...


