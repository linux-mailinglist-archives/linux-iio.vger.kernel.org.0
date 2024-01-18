Return-Path: <linux-iio+bounces-1752-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 254008321B1
	for <lists+linux-iio@lfdr.de>; Thu, 18 Jan 2024 23:43:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92BB3B24473
	for <lists+linux-iio@lfdr.de>; Thu, 18 Jan 2024 22:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 595C51EB36;
	Thu, 18 Jan 2024 22:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="a8V+KQTy"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BCD31EA77
	for <linux-iio@vger.kernel.org>; Thu, 18 Jan 2024 22:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705617784; cv=none; b=URSr6xtop2WHHa/JmPhPOdU0cELmgtobZLc18sldIWYX8YhTRxjK/6UdbNv6kJDixzOw/eMWWGiewoglflhUEE72D1B/U2AySLCbQ9OdbfYY0vbM9lyMnqk014pN/6mhSkbD8thF6NuZfAlhAXKshRY7YKwGrJO3JP2FMP/m3Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705617784; c=relaxed/simple;
	bh=+1qKA2IP4vtwr2qgRdA4RfnQ7Z2Up8JMUN1h2ytfNpg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y2/ZhWgKRkBmv4ov+ZFMQCyBfW3e6xXf5blfekalwxS3DbMjEVqQzZVx2/rX75zn3XHE4D6PXKsWyeSBti58x/4PAPvkq5K1v/qUN0Oa6HMFPgkEsk2F/8Zyo6qBvmWbiliuf+20+YAfX1645sJx6bAI8Kahsgllv67PMesPtsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=a8V+KQTy; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2cca8eb0509so2387711fa.3
        for <linux-iio@vger.kernel.org>; Thu, 18 Jan 2024 14:43:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1705617778; x=1706222578; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S2OucYUMdApd6L43qg3jvqTNIxk03x2uwjfK2c63Pxo=;
        b=a8V+KQTyfIPD1zKSZEHMOlSnj0xACASJxNCiB2mtgHaP0efm8bsanedkMQ80vu4qxI
         bFJH7yOGD26Q+L7sQqKRSVbnWBDzvPVJ596bWFKW1y98jwpAJsgU+KQvzFB7t2AffXpH
         GzuoP5s3kyZnLCLM7OzmtxjG6U3yxVj0RvKvGrX6iQaqX2qtgTBrARklCtrraC9ksfCO
         Iy2/l+F5gVilBneOwz2+GZdUuSq46krD3uE5KG3mTbJjfqBE4RlinBYuxTsA/brFj0dA
         6LTZp53gQKCJTwaaHAnWvsF/MDUqdFeEn/V0nNckTR5cDIbyQhwaiVxTorgKOxiIzl9O
         acNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705617778; x=1706222578;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S2OucYUMdApd6L43qg3jvqTNIxk03x2uwjfK2c63Pxo=;
        b=QMSmNV/GpErI/4qByfsGbxV1Ej2aZVQCw+B0v8arQ7y7er5sCdH0VwxeSs3w5H2Od7
         Gcicn3oyiam81u9ERBrjtILDJ+CGqtWXs2VC22YvSONeVzltsiVVU54bDI1D27wr81vC
         UW4e7DDLMRmNDdldy4Dw19dH49teixZQndkPg+r+hjEIAZ5QldUI8TZmg/Z4NdP7btlj
         x8dle0cm8489xXdKzu1PmkqyHJBUYkmeORLUAPc3gwnf4vEuenPWLhNDfnMy6B3x24lL
         mEYMalqALuNBWUqtd2vWnVAWssTN8ZM7ia6X6cO/yaL0PiEdqqpiugXhyO8cN+nS+Sno
         mqpQ==
X-Gm-Message-State: AOJu0YxlBmqF5OEodV3yYVcG5CpwG1O476+72xNl4031QqarTXk+/QP1
	0iACi4zTz63ZgVk24LcE0ws6oe0rSbBcd/AcKC2sv2Rfj9SIGEQHAOUT1s2vspawM48PGFjm0xn
	WRhTj8+gLeyGQDOocmlx9fmAibhLm7paO9ZZGvg==
X-Google-Smtp-Source: AGHT+IE/0Kja/Yg1yBuySMn66AdspOWr0ARCiQ3WB9sSkWlaul5RnQsnaih5GsFZXdTaueRcVpq+OSsYZeHEUE/mZ+M=
X-Received: by 2002:a2e:888b:0:b0:2cc:e9d9:8293 with SMTP id
 k11-20020a2e888b000000b002cce9d98293mr847082lji.31.1705617778025; Thu, 18 Jan
 2024 14:42:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240118125001.12809-1-mitrutzceclan@gmail.com>
In-Reply-To: <20240118125001.12809-1-mitrutzceclan@gmail.com>
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 18 Jan 2024 16:42:47 -0600
Message-ID: <CAMknhBEmye4UvLtR_3M2VMoGOAJ7tm1Rpy7rThsojzNcpMu6vA@mail.gmail.com>
Subject: Re: [PATCH v12 1/2] dt-bindings: adc: add AD7173
To: Dumitru Ceclan <mitrutzceclan@gmail.com>
Cc: linus.walleij@linaro.org, brgl@bgdev.pl, andy@kernel.org, 
	linux-gpio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, 
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Michael Walle <michael@walle.cc>, Andy Shevchenko <andy.shevchenko@gmail.com>, 
	Arnd Bergmann <arnd@arndb.de>, ChiaEn Wu <chiaen_wu@richtek.com>, 
	Niklas Schnelle <schnelle@linux.ibm.com>, =?UTF-8?Q?Leonard_G=C3=B6hrs?= <l.goehrs@pengutronix.de>, 
	Mike Looijmans <mike.looijmans@topic.nl>, Haibo Chen <haibo.chen@nxp.com>, 
	Hugo Villeneuve <hvilleneuve@dimonoff.com>, Ceclan Dumitru <dumitru.ceclan@analog.com>, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2024 at 6:50=E2=80=AFAM Dumitru Ceclan <mitrutzceclan@gmail=
.com> wrote:
>
> The AD7173 family offer a complete integrated Sigma-Delta ADC solution
> which can be used in high precision, low noise single channel application=
s
> or higher speed multiplexed applications. The Sigma-Delta ADC is intended
> primarily for measurement of signals close to DC but also delivers
> outstanding performance with input bandwidths out to ~10kHz.
>
> Signed-off-by: Dumitru Ceclan <mitrutzceclan@gmail.com>
> ---
>
> V11->V12
>  - Drop "binding", describe hardware in binding description
>  - Rename refin and refin2 to vref and vref2
>  - Add better description to external references to better show that the =
voltage
>     value that needs to be specified is the difference between the positi=
ve and
>     negative reference pins
>  - Add optional clocks properties
>  - Add optional adi,clock-select property
>  - Add option for second interrupt, error
>  - Add description to interrupts
> V10->V11
>  - Fix example warning: '#gpio-cells' is a dependency of 'gpio-controller=
'
>  - Add description to #gpio-cells property
> V9->V10
>  - Fix dt_binding_check type warning from adi,reference-select
> V8->v9
>  - Add gpio-controller and "#gpio-cells" properties
>  - Add missing avdd2 and iovdd supplies
>  - Add string type to reference-select
> V7->V8
>  - include missing fix from V6
> V6->V7 <no changes>
> V5->V6
>  - Moved global required property to proper placement
> V4 -> V5
>  - Use string enum instead of integers for "adi,reference-select"
>  - Fix conditional checking in regards to compatible
> V3 -> V4
>  - include supply attributes
>  - add channel attribute for selecting conversion reference
> V2 -> V3
>  - remove redundant descriptions
>  - use referenced 'bipolar' property
>  - remove newlines from example
> V1 -> V2 <no changes>
>
>  .../bindings/iio/adc/adi,ad7173.yaml          | 242 ++++++++++++++++++
>  1 file changed, 242 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7173.=
yaml
>
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml b/=
Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml
> new file mode 100644
> index 000000000000..4d0870cc014c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml
> @@ -0,0 +1,242 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright 2023 Analog Devices Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/adi,ad7173.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices AD7173 ADC
> +
> +maintainers:
> +  - Ceclan Dumitru <dumitru.ceclan@analog.com>
> +
> +description: |
> +  Analog Devices AD717x ADC's:
> +  The AD717x family offer a complete integrated Sigma-Delta ADC solution=
 which
> +  can be used in high precision, low noise single channel applications
> +  (Life Science measurements) or higher speed multiplexed applications
> +  (Factory Automation PLC Input modules). The Sigma-Delta ADC is intende=
d
> +  primarily for measurement of signals close to DC but also delivers
> +  outstanding performance with input bandwidths out to ~10kHz.
> +
> +  Datasheets for supported chips:
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/=
AD7172-2.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/=
AD7173-8.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/=
AD7175-2.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/=
AD7176-2.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ad7172-2
> +      - adi,ad7173-8
> +      - adi,ad7175-2
> +      - adi,ad7176-2
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    minItems: 1
> +    description: |
> +      Ready interrupt: multiplexed with SPI data out. While SPI CS is lo=
w,
> +      can be used to indicate the completion of a conversion.
> +
> +      Error: The three error bits in the status register (ADC_ERROR, CRC=
_ERROR,
> +      and REG_ERROR) are OR'ed, inverted, and mapped to the ERROR pin. T=
herefore,
> +      the ERROR pin indicates that an error has occurred.
> +
> +  interrupt-names:
> +    minItems: 1
> +    items:
> +      - const: rdy
> +      - const: err
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +
> +  spi-max-frequency:
> +    maximum: 20000000
> +
> +  gpio-controller:
> +    description: Marks the device node as a GPIO controller.
> +
> +  "#gpio-cells":
> +    const: 2
> +    description:
> +      The first cell is the GPIO number and the second cell specifies
> +      GPIO flags, as defined in <dt-bindings/gpio/gpio.h>.
> +
> +  vref-supply:
> +    description: |
> +      Differential external reference supply used for conversion. The re=
ference
> +      voltage (Vref) specified here must be the voltage difference betwe=
en the
> +      REF+ and REF- pins: Vref =3D (REF+) - (REF-).
> +
> +  vref2-supply:
> +    description: |
> +      Differential external reference supply used for conversion. The re=
ference
> +      voltage (Vref2) specified here must be the voltage difference betw=
een the
> +      REF2+ and REF2- pins: Vref2 =3D (REF2+) - (REF2-).
> +
> +  avdd-supply:
> +    description: avdd supply, can be used as reference for conversion.

I think it would be helpful to have a description similar to
vref-supply here. This is the voltage between AVDD and AVSS. So in
both cases AVDD=3D5V, AVSS=3D0V and AVDD=3D+2.5V, AVSS=3D-2.5V, this supply
should report 5V.

> +
> +  avdd2-supply:
> +    description: avdd2 supply, used as the input to the internal voltage=
 regulator.

This supply is also referenced to AVSS.

> +
> +  iovdd-supply:
> +    description: iovdd supply, used for the chip digital interface.
> +
> +  clocks:
> +    maxItems: 1
> +    description: |
> +      Optional external clock source. Can include one clock source: exte=
rnal
> +      clock or external crystal.
> +
> +  clock-names:
> +    enum:
> +      - ext-clk
> +      - xtal
> +
> +  adi,clock-select:
> +    description: |
> +      Select the ADC clock source. Valid values are:
> +      int         : Internal oscillator
> +      int-out     : Internal oscillator with output on XTAL2 pin
> +      ext-clk     : External clock input on XTAL2 pin
> +      xtal        : External crystal on XTAL1 and XTAL2 pins
> +
> +    $ref: /schemas/types.yaml#/definitions/string
> +    enum:
> +      - int
> +      - int-out
> +      - ext-clk
> +      - xtal
> +    default: int
> +
> +patternProperties:
> +  "^channel@[0-9a-f]$":
> +    type: object
> +    $ref: adc.yaml
> +    unevaluatedProperties: false
> +
> +    properties:
> +      reg:
> +        minimum: 0
> +        maximum: 15
> +
> +      diff-channels:
> +        items:
> +          minimum: 0
> +          maximum: 31
> +
> +      adi,reference-select:
> +        description: |
> +          Select the reference source to use when converting on
> +          the specific channel. Valid values are:
> +          vref       : REF+  /REF=E2=88=92
> +          vref2      : REF2+ /REF2=E2=88=92
> +          refout-avss: REFOUT/AVSS (Internal reference)
> +          avdd       : AVDD

Could write this as AVDD/AVSS to be consistent with the other 3 options.

(Or if this is really AVDD to 0V, we may need to reconsider some of
our other decisions.)

> +
> +          External reference ref2 only available on ad7173-8.
> +          If not specified, internal reference used.
> +        $ref: /schemas/types.yaml#/definitions/string
> +        enum:
> +          - vref
> +          - vref2
> +          - refout-avss
> +          - avdd
> +        default: refout-avss
> +
> +    required:
> +      - reg
> +      - diff-channels
> +
> +required:
> +  - compatible
> +  - reg
> +
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +  - if:
> +      properties:
> +        compatible:
> +          not:
> +            contains:
> +              const: adi,ad7173-8
> +    then:
> +      properties:
> +        vref2-supply: false
> +      patternProperties:
> +        "^channel@[0-9a-f]$":
> +          properties:
> +            adi,reference-select:
> +              enum:
> +                - vref
> +                - refout-avss
> +                - avdd
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    spi {
> +      #address-cells =3D <1>;
> +      #size-cells =3D <0>;
> +
> +      adc@0 {
> +        compatible =3D "adi,ad7173-8";
> +        reg =3D <0>;
> +
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        interrupts =3D <25 IRQ_TYPE_EDGE_FALLING>;
> +        interrupt-names =3D "rdy";
> +        interrupt-parent =3D <&gpio>;
> +        spi-max-frequency =3D <5000000>;
> +        gpio-controller;
> +        #gpio-cells =3D <2>;
> +
> +        vref-supply =3D <&dummy_regulator>;
> +
> +        channel@0 {
> +          reg =3D <0>;
> +          bipolar;
> +          diff-channels =3D <0 1>;
> +          adi,reference-select =3D "vref";
> +        };
> +
> +        channel@1 {
> +          reg =3D <1>;
> +          diff-channels =3D <2 3>;
> +        };
> +
> +        channel@2 {
> +          reg =3D <2>;
> +          bipolar;
> +          diff-channels =3D <4 5>;
> +        };
> +
> +        channel@3 {
> +          reg =3D <3>;
> +          bipolar;
> +          diff-channels =3D <6 7>;
> +        };
> +
> +        channel@4 {
> +          reg =3D <4>;
> +          diff-channels =3D <8 9>;
> +          adi,reference-select =3D "avdd";
> +        };
> +      };
> +    };
> --
> 2.42.0
>

