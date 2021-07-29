Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59AFF3DAFDE
	for <lists+linux-iio@lfdr.de>; Fri, 30 Jul 2021 01:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234655AbhG2XfS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 29 Jul 2021 19:35:18 -0400
Received: from mail-il1-f176.google.com ([209.85.166.176]:41798 "EHLO
        mail-il1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbhG2XfS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 29 Jul 2021 19:35:18 -0400
Received: by mail-il1-f176.google.com with SMTP id j18so4578263ile.8;
        Thu, 29 Jul 2021 16:35:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qN6sb3aX7hRui1omUtuCA3OEQ1VLaGH1+abq0moxMrw=;
        b=XIabBh9EBuQtKm4buCw+JrSikTH6W6J4lxOro1ReqK1QUsLfK0kPfWTwv7mEc5R4I3
         1VAYs6M8ZB4ajPV555Zjho5LC+s5gOmC593KTUdmYbJSiB+fJlNQlsn3OxTISjKPJ3Vy
         X4q9j1Pj5omkkMyMo7ql/sO7YP9L4cODtfI7qbanK3s5nPKTQiZAgbZ4Iv1g1ctE+KFE
         YsMy+IEQtbgwfyVUUrIhrp1HXZh+si0nAViduLa3SHoCHDAGIIZ9LG9YMzGktyt2XSZe
         fYKhwyDPt08KNl0fqM4KwBdC/lM/TOUy8e4TdGumkPao75OUjHjapP8E9sWhAQcGU9Jk
         iSIQ==
X-Gm-Message-State: AOAM5331dYvvUK05GuQA9eEp4IrRn3WbabMAsoZOB59IxNb5p33pzbBc
        GtF0S6e+hk2N13itDn3I1A==
X-Google-Smtp-Source: ABdhPJxszO+1UEg2TfA93Ai2Nl2H3bpeb+E+iXGBzOAXoT+qg9CJPPzRLK1ufpv3DRws+faFTVTtLA==
X-Received: by 2002:a92:d8cf:: with SMTP id l15mr5356394ilo.227.1627601712769;
        Thu, 29 Jul 2021 16:35:12 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id y14sm2412589ilv.76.2021.07.29.16.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 16:35:11 -0700 (PDT)
Received: (nullmailer pid 1121501 invoked by uid 1000);
        Thu, 29 Jul 2021 23:35:10 -0000
Date:   Thu, 29 Jul 2021 17:35:10 -0600
From:   Rob Herring <robh@kernel.org>
To:     Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-input@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mfd: Convert ti-tsc-adc bindings to YAML
 schema
Message-ID: <YQM7Lm+KD7C5P6i+@robh.at.kernel.org>
References: <20210726104958.8631-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210726104958.8631-1-vigneshr@ti.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Jul 26, 2021 at 04:19:58PM +0530, Vignesh Raghavendra wrote:
> Convert ti-tsc-adc binding to YAML schema. This is MFD device with
> support for resistive touchscreen and ADC. But the txt binding file for
> MFD and ADC has been incorrectly been under input/touchscreen directory,
> so split the bindings across subsystems as appropriate.
> 
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> ---
>  .../bindings/iio/adc/ti,am3359-adc.yaml       | 74 +++++++++++++++
>  .../input/touchscreen/ti,am3359-tsc.yaml      | 79 ++++++++++++++++
>  .../bindings/input/touchscreen/ti-tsc-adc.txt | 91 ------------------
>  .../bindings/mfd/ti,am3359-tscadc.yaml        | 92 +++++++++++++++++++
>  4 files changed, 245 insertions(+), 91 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,am3359-adc.yaml
>  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/ti,am3359-tsc.yaml
>  delete mode 100644 Documentation/devicetree/bindings/input/touchscreen/ti-tsc-adc.txt
>  create mode 100644 Documentation/devicetree/bindings/mfd/ti,am3359-tscadc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/ti,am3359-adc.yaml b/Documentation/devicetree/bindings/iio/adc/ti,am3359-adc.yaml
> new file mode 100644
> index 000000000000..b7884be5d378
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/ti,am3359-adc.yaml
> @@ -0,0 +1,74 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/ti,am3359-adc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Bindings for ADC part of TSCADC MFDs on TI SoCs
> +
> +maintainers:
> +  - Vignesh Raghavendra <vigneshr@ti.com>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - ti,am654-adc
> +          - const: ti,am3359-adc
> +      - const: ti,am3359-adc
> +
> +  ti,adc-channels:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    description:
> +      List of analog inputs available for ADC.
> +      AIN0 = 0, AIN1 = 1 and so on till AIN7 = 7.
> +    minItems: 1
> +    maxItems: 8
> +    items:
> +      maximum: 7
> +
> +  ti,chan-step-opendelay:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    description:
> +      List of open delays for each channel of list of analog inputs
> +      available for ADC. ADC in the order of ti,adc-channels. The
> +      value corresponds to the number of ADC clock cycles to wait
> +      after applying the step configuration registers and before
> +      sending the start of ADC conversion.
> +    minItems: 1
> +    maxItems: 8
> +    items:
> +      maximum: 0x3FFFF
> +
> +  ti,chan-step-sampledelay:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    description:
> +      List of sample delays for each channel of ADC in the order of
> +      ti,adc-channels. The value corresponds to the number of
> +      ADC clock cycles to sample (to hold start of conversion high).
> +    minItems: 1
> +    maxItems: 8
> +    items:
> +      maximum: 0xFF
> +
> +  ti,chan-step-avg:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    description:
> +      Number of averages to be performed for each channel of ADC. If
> +      average is 16 then input is sampled 16 times and averaged to
> +      get more accurate value. This increases the time taken by ADC
> +      to generate a sample.
> +    minItems: 1
> +    maxItems: 8
> +    items:
> +      maximum: 16
> +
> +  "#io-channel-cells":
> +    const: 1
> +
> +required:
> +  - compatible
> +  - "#io-channel-cells"
> +
> +additionalProperties: false
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/ti,am3359-tsc.yaml b/Documentation/devicetree/bindings/input/touchscreen/ti,am3359-tsc.yaml
> new file mode 100644
> index 000000000000..288f8d73b653
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/touchscreen/ti,am3359-tsc.yaml
> @@ -0,0 +1,79 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/input/touchscreen/ti,am3359-tsc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Bindings for TSC part of TSCADC MFDs on TI SoCs
> +
> +maintainers:
> +  - Vignesh Raghavendra <vigneshr@ti.com>
> +
> +properties:
> +  compatible:
> +    const: ti,am3359-tsc
> +
> +  ti,wires:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [4, 5, 8]
> +    description:
> +      Number of wires used by touchscreen
> +
> +  ti,x-plate-resistance:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      X plate resistance
> +
> +  ti,coordinate-readouts:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 1
> +    maximum: 5
> +    description:
> +      The sequencer supports a total of 16 programmable steps
> +      each step is used to read a single coordinate. A single
> +      readout is enough but multiple reads can increase the quality.
> +      A value of 5 means, 5 reads for X, 5 for Y and 2 for Z (always).
> +      This utilises 12 of the 16 software steps available.
> +      The remaining 4 can be used by the ADC.
> +
> +  ti,wire-config:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    description: |
> +      Different boards could have a different order for
> +      connecting wires on touchscreen. We need to provide an
> +      8 bit number where in the 1st four bits represent the
> +      analog lines and the next 4 bits represent positive/
> +      negative terminal on that input line. Notations to
> +      represent the input lines and terminals respectively
> +      is as follows:
> +      AIN0 = 0, AIN1 = 1 and so on till AIN7 = 7.
> +      XP  = 0, XN = 1, YP = 2, YN = 3.
> +      minItems: 4
> +    items:
> +      maximum: 0x73
> +
> +  ti,charge-delay:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Length of touch screen charge delay step in terms of
> +      List of analog inputs available for ADC.
> +      ADC clock cycles. Charge delay value should be large
> +      in order to avoid false pen-up events. This value
> +      effects the overall sampling speed, hence need to be
> +      kept as low as possible, while avoiding false pen-up
> +      event. Start from a lower value, say 0x400, and
> +      increase value until false pen-up events are avoided.
> +      The pen-up detection happens immediately after the
> +      charge step, so this does in fact function as a
> +      hardware knob for adjusting the amount of "settling time".
> +    minimum: 0x1
> +    maximum: 0xFFFF
> +
> +required:
> +  - compatible
> +  - ti,wires
> +  - ti,coordinate-readouts
> +  - ti,wire-config
> +  - ti,x-plate-resistance
> +
> +additionalProperties: false
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/ti-tsc-adc.txt b/Documentation/devicetree/bindings/input/touchscreen/ti-tsc-adc.txt
> deleted file mode 100644
> index aad5e34965eb..000000000000
> --- a/Documentation/devicetree/bindings/input/touchscreen/ti-tsc-adc.txt
> +++ /dev/null
> @@ -1,91 +0,0 @@
> -* TI - TSC ADC (Touschscreen and analog digital converter)
> -~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> -
> -Required properties:
> -- mfd
> -	compatible: Should be
> -		"ti,am3359-tscadc" for AM335x/AM437x SoCs
> -		"ti,am654-tscadc", "ti,am3359-tscadc" for AM654 SoCs
> -- child "tsc"
> -	compatible: Should be "ti,am3359-tsc".
> -	ti,wires: Wires refer to application modes i.e. 4/5/8 wire touchscreen
> -		  support on the platform.
> -	ti,x-plate-resistance: X plate resistance
> -	ti,coordinate-readouts: The sequencer supports a total of 16
> -				programmable steps each step is used to
> -				read a single coordinate. A single
> -                                readout is enough but multiple reads can
> -				increase the quality.
> -				A value of 5 means, 5 reads for X, 5 for
> -				Y and 2 for Z (always). This utilises 12
> -				of the 16 software steps available. The
> -				remaining 4 can be used by the ADC.
> -	ti,wire-config: Different boards could have a different order for
> -			connecting wires on touchscreen. We need to provide an
> -			8 bit number where in the 1st four bits represent the
> -			analog lines and the next 4 bits represent positive/
> -			negative terminal on that input line. Notations to
> -			represent the input lines and terminals resoectively
> -			is as follows:
> -			AIN0 = 0, AIN1 = 1 and so on till AIN7 = 7.
> -			XP  = 0, XN = 1, YP = 2, YN = 3.
> -- child "adc"
> -	compatible: Should be
> -		    "ti,am3359-adc" for AM335x/AM437x SoCs
> -		    "ti,am654-adc", "ti,am3359-adc" for AM654 SoCs
> -	ti,adc-channels: List of analog inputs available for ADC.
> -			 AIN0 = 0, AIN1 = 1 and so on till AIN7 = 7.
> -
> -Optional properties:
> -- child "tsc"
> -	ti,charge-delay: Length of touch screen charge delay step in terms of
> -			 ADC clock cycles. Charge delay value should be large
> -			 in order to avoid false pen-up events. This value
> -			 effects the overall sampling speed, hence need to be
> -			 kept as low as possible, while avoiding false pen-up
> -			 event. Start from a lower value, say 0x400, and
> -			 increase value until false pen-up events are avoided.
> -			 The pen-up detection happens immediately after the
> -			 charge step, so this does in fact function as a
> -			 hardware knob for adjusting the amount of "settling
> -			 time".
> -
> -- child "adc"
> -	ti,chan-step-opendelay: List of open delays for each channel of
> -				ADC in the order of ti,adc-channels. The
> -				value corresponds to the number of ADC
> -				clock cycles to wait after applying the
> -				step configuration registers and before
> -				sending the start of ADC conversion.
> -				Maximum value is 0x3FFFF.
> -       ti,chan-step-sampledelay: List of sample delays for each channel
> -				  of ADC in the order of ti,adc-channels.
> -				  The value corresponds to the number of
> -				  ADC clock cycles to sample (to hold
> -				  start of conversion high).
> -				  Maximum value is 0xFF.
> -       ti,chan-step-avg: Number of averages to be performed for each
> -			  channel of ADC. If average is 16 then input
> -			  is sampled 16 times and averaged to get more
> -			  accurate value. This increases the time taken
> -			  by ADC to generate a sample. Valid range is 0
> -			  average to 16 averages. Maximum value is 16.
> -
> -Example:
> -	tscadc: tscadc@44e0d000 {
> -		compatible = "ti,am3359-tscadc";
> -		tsc {
> -			ti,wires = <4>;
> -			ti,x-plate-resistance = <200>;
> -			ti,coordiante-readouts = <5>;
> -			ti,wire-config = <0x00 0x11 0x22 0x33>;
> -			ti,charge-delay = <0x400>;
> -		};
> -
> -		adc {
> -			ti,adc-channels = <4 5 6 7>;
> -			ti,chan-step-opendelay = <0x098 0x3ffff 0x098 0x0>;
> -			ti,chan-step-sampledelay = <0xff 0x0 0xf 0x0>;
> -			ti,chan-step-avg = <16 2 4 8>;
> -		};
> -	}
> diff --git a/Documentation/devicetree/bindings/mfd/ti,am3359-tscadc.yaml b/Documentation/devicetree/bindings/mfd/ti,am3359-tscadc.yaml
> new file mode 100644
> index 000000000000..61854b61e378
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/ti,am3359-tscadc.yaml
> @@ -0,0 +1,92 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/ti,am3359-tscadc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Bindings for Touchscreen + ADC MFD IPs on TI SoCs
> +
> +maintainers:
> +  - Vignesh Raghavendra <vigneshr@ti.com>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - ti,am654-tscadc
> +          - const: ti,am3359-tscadc
> +      - const: ti,am3359-tscadc
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    const: "adc_tsc_fck"

Don't need quotes

> +
> +  dmas:
> +    maxItems: 2
> +
> +  dma-names:
> +    items:
> +      - const: fifo0
> +      - const: fifo1
> +
> +  power-domains: true
> +
> +  tsc:
> +    $ref: ../input/touchscreen/ti,am3359-tsc.yaml

/schemas/input/...

> +    description:
> +      Bindings for Touchscreen part of the MFD
> +
> +  adc:
> +    $ref: ../iio/adc/ti,am3359-adc.yaml

/schemas/iio/...

> +    description:
> +      Bindings for ADC part of the MFD
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +
> +additionalProperties: false
> +
> +if:
> +  properties:
> +    compatible:
> +      contains:
> +        const: ti,am654-tscadc
> +then:
> +  properties:
> +    tsc: false
> +
> +examples:
> +  - |
> +    tscadc@44e0d000 {
> +      compatible = "ti,am3359-tscadc";
> +      reg = <0x44e0d000 0x1000>;
> +      interrupts = <16>;
> +        tsc {

indentation is off

> +          compatible = "ti,am3359-tsc";
> +          ti,wires = <4>;
> +          ti,x-plate-resistance = <200>;
> +          ti,coordinate-readouts = <5>;
> +          ti,wire-config = <0x00 0x11 0x22 0x33>;
> +          ti,charge-delay = <0x400>;
> +        };
> +
> +      adc {
> +        compatible = "ti,am3359-adc";
> +        ti,adc-channels = <4 5 6 7>;
> +        ti,chan-step-opendelay = <0x098 0x3ffff 0x098 0x0>;
> +        ti,chan-step-sampledelay = <0xff 0x0 0xf 0x0>;
> +        ti,chan-step-avg = <16 2 4 8>;
> +        #io-channel-cells = <1>;
> +      };
> +    };

With those few nits fixed,

Reviewed-by: Rob Herring <robh@kernel.org>
