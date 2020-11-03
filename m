Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54E772A4B8F
	for <lists+linux-iio@lfdr.de>; Tue,  3 Nov 2020 17:31:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726212AbgKCQbX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 3 Nov 2020 11:31:23 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:44397 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbgKCQbX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 3 Nov 2020 11:31:23 -0500
Received: by mail-oi1-f193.google.com with SMTP id t16so1599279oie.11;
        Tue, 03 Nov 2020 08:31:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mLHdnC4toqKTBaLNfdSWrYKnt7vF7lFU9KW+eiSehKM=;
        b=IS/LW9qR1TWIhV0atCUHQBzd/murSr9atMIFY2DWQoBKzlz104at+a3qtT149qbqrx
         YuCW39C5u46o5lIMheNCYOvv1uY+6OhZ/G2kl1LbegNftlmrFFBAjTEz+CJvcWsHLbvY
         PLG2quNqxI2gYVgs1UZP4sRwUmgSk4ufy0i2jSiuVO7C6pkmknvLxLeEL6w2eERraKvm
         9Upvw83/o/zvD7sKI4pgCZLPsodfUP+sAAZAPi3SEjQ3xHFfBL79+/H3Pt61PoW6q63u
         OQrkGWNyw3EC8N16J2P4cLe0V9fkt64Y/obL6pQz91EIHxsgrGFjXBKjPFI9T7KyJbTP
         GwAA==
X-Gm-Message-State: AOAM5324w8VKvyPxGjqY2oXF1TGjd/G2KA/GXlq4dL7R7r14ov4tnFJR
        Zx2DQHGtcPVoYW1Sr8wM2A==
X-Google-Smtp-Source: ABdhPJyIcYOC64YJcoWfu/6CdBz1ffdLnFnJsv45UbXRFA/iQ/8CteBnqMvwfHRm/LYoxRwxuGNw0w==
X-Received: by 2002:a54:4f93:: with SMTP id g19mr333812oiy.138.1604421081433;
        Tue, 03 Nov 2020 08:31:21 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w10sm3015055oou.47.2020.11.03.08.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 08:31:20 -0800 (PST)
Received: (nullmailer pid 1784838 invoked by uid 1000);
        Tue, 03 Nov 2020 16:31:20 -0000
Date:   Tue, 3 Nov 2020 10:31:20 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Michael Hennerich <michael.hennerich@analog.com>
Subject: Re: [PATCH 38/46] dt-bindings:iio:dac:ad5592r: txt to yaml format
 conversion.
Message-ID: <20201103163120.GE1754553@bogus>
References: <20201031184854.745828-1-jic23@kernel.org>
 <20201031184854.745828-39-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201031184854.745828-39-jic23@kernel.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Oct 31, 2020 at 06:48:46PM +0000, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> This is a more complex binding. Whilst conversion is straight forward
> I am unsure if the full nature of required properties has been captured.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Michael Hennerich <michael.hennerich@analog.com>
> ---
>  .../devicetree/bindings/iio/dac/ad5592r.txt   | 155 --------------
>  .../bindings/iio/dac/adi,ad5592r.yaml         | 201 ++++++++++++++++++
>  2 files changed, 201 insertions(+), 155 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/dac/ad5592r.txt b/Documentation/devicetree/bindings/iio/dac/ad5592r.txt
> deleted file mode 100644
> index 989f96f31c66..000000000000
> --- a/Documentation/devicetree/bindings/iio/dac/ad5592r.txt
> +++ /dev/null
> @@ -1,155 +0,0 @@
> -Analog Devices AD5592R/AD5593R DAC/ADC device driver
> -
> -Required properties for the AD5592R:
> -	- compatible: Must be "adi,ad5592r"
> -	- reg: SPI chip select number for the device
> -	- spi-max-frequency: Max SPI frequency to use (< 30000000)
> -	- spi-cpol: The AD5592R requires inverse clock polarity (CPOL) mode
> -
> -Required properties for the AD5593R:
> -	- compatible: Must be "adi,ad5593r"
> -	- reg: I2C address of the device
> -
> -Required properties for all supported chips:
> -	- #address-cells: Should be 1.
> -	- #size-cells: Should be 0.
> -	- channel nodes:
> -	  Each child node represents one channel and has the following
> -	  Required properties:
> -		* reg: Pin on which this channel is connected to.
> -		* adi,mode: Mode or function of this channel.
> -			    Macros specifying the valid values
> -			    can be found in <dt-bindings/iio/adi,ad5592r.h>.
> -
> -			    The following values are currently supported:
> -				* CH_MODE_UNUSED (the pin is unused)
> -				* CH_MODE_ADC (the pin is ADC input)
> -				* CH_MODE_DAC (the pin is DAC output)
> -				* CH_MODE_DAC_AND_ADC (the pin is DAC output
> -					but can be monitored by an ADC, since
> -					there is no disadvantage this
> -					this should be considered as the
> -					preferred DAC mode)
> -				* CH_MODE_GPIO (the pin is registered
> -					with GPIOLIB)
> -	 Optional properties:
> -		* adi,off-state: State of this channel when unused or the
> -				 device gets removed. Macros specifying the
> -				 valid values can be found in
> -				 <dt-bindings/iio/adi,ad5592r.h>.
> -
> -				* CH_OFFSTATE_PULLDOWN (the pin is pulled down)
> -				* CH_OFFSTATE_OUT_LOW  (the pin is output low)
> -				* CH_OFFSTATE_OUT_HIGH (the pin is output high)
> -				* CH_OFFSTATE_OUT_TRISTATE (the pin is
> -					tristated output)
> -
> -
> -Optional properties:
> -	- vref-supply: Phandle to the external reference voltage supply. This should
> -	  only be set if there is an external reference voltage connected to the VREF
> -	  pin. If the property is not set the internal 2.5V reference is used.
> -	- reset-gpios : GPIO spec for the RESET pin. If specified, it will be
> -	  asserted during driver probe.
> -	- gpio-controller: Marks the device node as a GPIO controller.
> -	- #gpio-cells: Should be 2. The first cell is the GPIO number and the second
> -	  cell specifies GPIO flags, as defined in <dt-bindings/gpio/gpio.h>.
> -
> -AD5592R Example:
> -
> -	#include <dt-bindings/iio/adi,ad5592r.h>
> -
> -	vref: regulator-vref {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vref-ad559x";
> -		regulator-min-microvolt = <3300000>;
> -		regulator-max-microvolt = <3300000>;
> -		regulator-always-on;
> -	};
> -
> -	ad5592r@0 {
> -		#size-cells = <0>;
> -		#address-cells = <1>;
> -		#gpio-cells = <2>;
> -		compatible = "adi,ad5592r";
> -		reg = <0>;
> -
> -		spi-max-frequency = <1000000>;
> -		spi-cpol;
> -
> -		vref-supply = <&vref>; /* optional */
> -		reset-gpios = <&gpio0 86 0>;  /* optional */
> -		gpio-controller;
> -
> -		channel@0 {
> -			reg = <0>;
> -			adi,mode = <CH_MODE_DAC>;
> -		};
> -		channel@1 {
> -			reg = <1>;
> -			adi,mode = <CH_MODE_ADC>;
> -		};
> -		channel@2 {
> -			reg = <2>;
> -			adi,mode = <CH_MODE_DAC_AND_ADC>;
> -		};
> -		channel@3 {
> -			reg = <3>;
> -			adi,mode = <CH_MODE_DAC_AND_ADC>;
> -			adi,off-state = <CH_OFFSTATE_PULLDOWN>;
> -		};
> -		channel@4 {
> -			reg = <4>;
> -			adi,mode = <CH_MODE_UNUSED>;
> -			adi,off-state = <CH_OFFSTATE_PULLDOWN>;
> -		};
> -		channel@5 {
> -			reg = <5>;
> -			adi,mode = <CH_MODE_GPIO>;
> -			adi,off-state = <CH_OFFSTATE_PULLDOWN>;
> -		};
> -		channel@6 {
> -			reg = <6>;
> -			adi,mode = <CH_MODE_GPIO>;
> -			adi,off-state = <CH_OFFSTATE_PULLDOWN>;
> -		};
> -		channel@7 {
> -			reg = <7>;
> -			adi,mode = <CH_MODE_GPIO>;
> -			adi,off-state = <CH_OFFSTATE_PULLDOWN>;
> -		};
> -	};
> -
> -AD5593R Example:
> -
> -	#include <dt-bindings/iio/adi,ad5592r.h>
> -
> -	ad5593r@10 {
> -		#size-cells = <0>;
> -		#address-cells = <1>;
> -		#gpio-cells = <2>;
> -		compatible = "adi,ad5593r";
> -		reg = <0x10>;
> -		gpio-controller;
> -
> -		channel@0 {
> -			reg = <0>;
> -			adi,mode = <CH_MODE_DAC>;
> -			adi,off-state = <CH_OFFSTATE_PULLDOWN>;
> -		};
> -		channel@1 {
> -			reg = <1>;
> -			adi,mode = <CH_MODE_ADC>;
> -			adi,off-state = <CH_OFFSTATE_PULLDOWN>;
> -		};
> -		channel@2 {
> -			reg = <2>;
> -			adi,mode = <CH_MODE_DAC_AND_ADC>;
> -			adi,off-state = <CH_OFFSTATE_PULLDOWN>;
> -		};
> -		channel@6 {
> -			reg = <6>;
> -			adi,mode = <CH_MODE_GPIO>;
> -			adi,off-state = <CH_OFFSTATE_PULLDOWN>;
> -		};
> -	};
> diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5592r.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5592r.yaml
> new file mode 100644
> index 000000000000..c49646825c37
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5592r.yaml
> @@ -0,0 +1,201 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/dac/adi,ad5592r.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices AD5592R/AD5593R DAC/ADC
> +
> +maintainers:
> +  - Michael Hennerich <michael.hennerich@analog.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ad5592r
> +      - adi,ad5593r
> +
> +  reg:
> +    maxItems: 1
> +
> +  spi-max-frequency:
> +    maximum: 30000000
> +
> +  spi-cpol: true
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
> +  "#io-channel-cells":
> +    const: 1
> +
> +  vref-supply:
> +    description: If not set internal 2.5V reference used.
> +
> +  reset-gpios:
> +    maxItems: 1
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
> +required:
> +  - compatible
> +  - reg
> +  - "#address-cells"
> +  - "#size-cells"
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: adi,ad5592r
> +    then:
> +      required:
> +        - spi-cpol
> +    else:
> +      properties:
> +        spi-cpol: false
> +
> +additionalProperties: false
> +
> +patternProperties:
> +  "^(channel@)[0-7]$":
> +    type: object
> +    description: Child node to describe a channel
> +    properties:
> +      reg:
> +        maxItems: 1

minimum: 0
maximum: 7

> +
> +      adi,mode:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description: |
> +          Mode or function of this channel.
> +          Macros specifying the valid values can be found in
> +          <dt-bindings/iio/adi,ad5592r.h>.
> +
> +          The following values are currently supported:
> +          * CH_MODE_UNUSED (the pin is unused)
> +          * CH_MODE_ADC (the pin is ADC input)
> +          * CH_MODE_DAC (the pin is DAC output)
> +          * CH_MODE_DAC_AND_ADC (the pin is DAC output but can be monitored
> +            by an ADC, since there is no disadvantage this should be
> +            considered as the preferred DAC mode)
> +          * CH_MODE_GPIO (the pin is registered with GPIOLIB)

Sounds like constraints.

> +
> +      adi,off-state:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description: |
> +          State of this channel when unused or the device gets removed.
> +          Macros specifying the  valid values can be found in
> +          <dt-bindings/iio/adi,ad5592r.h>.
> +          * CH_OFFSTATE_PULLDOWN (the pin is pulled down)
> +          * CH_OFFSTATE_OUT_LOW  (the pin is output low)
> +          * CH_OFFSTATE_OUT_HIGH (the pin is output high)
> +          * CH_OFFSTATE_OUT_TRISTATE (the pin is tristated output)

Here too.

> +
> +    required:
> +      - reg
> +      - adi,mode
> +
> +    additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/iio/adi,ad5592r.h>
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        addac@0 {
> +            compatible = "adi,ad5592r";
> +            #size-cells = <0>;
> +            #address-cells = <1>;
> +            #gpio-cells = <2>;
> +            reg = <0>;
> +
> +            spi-max-frequency = <1000000>;
> +            spi-cpol;
> +
> +            vref-supply = <&vref>;
> +            reset-gpios = <&gpio0 86 0>;
> +            gpio-controller;
> +
> +            channel@0 {
> +                reg = <0>;
> +                adi,mode = <CH_MODE_DAC>;
> +            };
> +            channel@1 {
> +                reg = <1>;
> +                adi,mode = <CH_MODE_ADC>;
> +            };
> +            channel@2 {
> +                reg = <2>;
> +                adi,mode = <CH_MODE_DAC_AND_ADC>;
> +            };
> +            channel@3 {
> +                reg = <3>;
> +                adi,mode = <CH_MODE_DAC_AND_ADC>;
> +                adi,off-state = <CH_OFFSTATE_PULLDOWN>;
> +            };
> +            channel@4 {
> +                reg = <4>;
> +                adi,mode = <CH_MODE_UNUSED>;
> +                adi,off-state = <CH_OFFSTATE_PULLDOWN>;
> +            };
> +            channel@5 {
> +                reg = <5>;
> +                adi,mode = <CH_MODE_GPIO>;
> +                adi,off-state = <CH_OFFSTATE_PULLDOWN>;
> +            };
> +            channel@6 {
> +                reg = <6>;
> +                adi,mode = <CH_MODE_GPIO>;
> +                adi,off-state = <CH_OFFSTATE_PULLDOWN>;
> +            };
> +            channel@7 {
> +                reg = <7>;
> +                adi,mode = <CH_MODE_GPIO>;
> +                adi,off-state = <CH_OFFSTATE_PULLDOWN>;
> +            };
> +        };
> +        ad5593r@10 {
> +            compatible = "adi,ad5593r";
> +            #size-cells = <0>;
> +            #address-cells = <1>;
> +            #gpio-cells = <2>;
> +            reg = <0x10>;
> +            gpio-controller;
> +
> +            channel@0 {
> +                reg = <0>;
> +                adi,mode = <CH_MODE_DAC>;
> +                adi,off-state = <CH_OFFSTATE_PULLDOWN>;
> +            };
> +            channel@1 {
> +                reg = <1>;
> +                adi,mode = <CH_MODE_ADC>;
> +                adi,off-state = <CH_OFFSTATE_PULLDOWN>;
> +            };
> +            channel@2 {
> +                reg = <2>;
> +                adi,mode = <CH_MODE_DAC_AND_ADC>;
> +                adi,off-state = <CH_OFFSTATE_PULLDOWN>;
> +            };
> +            channel@6 {
> +                reg = <6>;
> +                adi,mode = <CH_MODE_GPIO>;
> +                adi,off-state = <CH_OFFSTATE_PULLDOWN>;
> +            };
> +        };
> +    };
> +...
> -- 
> 2.28.0
> 
