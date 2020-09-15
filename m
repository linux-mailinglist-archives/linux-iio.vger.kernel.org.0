Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8DFC26AD7D
	for <lists+linux-iio@lfdr.de>; Tue, 15 Sep 2020 21:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727928AbgIOTYc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 15 Sep 2020 15:24:32 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:36339 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727653AbgIOTX4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 15 Sep 2020 15:23:56 -0400
Received: by mail-il1-f195.google.com with SMTP id t12so4131303ilh.3;
        Tue, 15 Sep 2020 12:23:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hHhXidR6Ol2FUudL/UxKb9dPjOLxVvYQvVLLZ2xDN58=;
        b=D5bP6rZgOEhZtdIFh6jqQIWVcj0ezKFcktS/N6apLJ3w8CWzb29jSYeVdwDdbSXfRe
         5hx1qM4CAXj+XRq5JQgVoRUceQk7Xw9s1BdqwewAYmkHn0F9cZxJj4+Kj+Lb5kJksQBR
         7iMj7R+dXcO+0cq9OQB+K5GKb+zqkw2P/k3yiVoyZMionsv4NImRQ1CKUmlVBGfNATkT
         mGp/5gz1PL9RqzxF2Vu4eqe2AzgLW8pFOC6TGoCppRSgphT4/rmy0WXv29uW+cOknz6Y
         tNye+qJL2Z/avil82y3bDmUZYyLKCgnhJdFet4LwS8o8CH0RtDqFvUWd4diwiO5/p4FK
         yaxA==
X-Gm-Message-State: AOAM531PgLps9/basTiRxf25orUFQKDs02lX6Np293hhF2OuiPvNFzaj
        S9hdnArW5b7jzehWOxODGw==
X-Google-Smtp-Source: ABdhPJy8vQSHlBq18AVz1hjMnw6aolAj3UOIa61p8rQjYx/XGcV7DFKRmCtqXZcRY2fsW8AFQK++KA==
X-Received: by 2002:a05:6e02:d4f:: with SMTP id h15mr16541968ilj.307.1600197834339;
        Tue, 15 Sep 2020 12:23:54 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id h2sm8055955ioj.5.2020.09.15.12.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 12:23:53 -0700 (PDT)
Received: (nullmailer pid 2350686 invoked by uid 1000);
        Tue, 15 Sep 2020 19:23:51 -0000
Date:   Tue, 15 Sep 2020 13:23:51 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>
Subject: Re: [PATCH v2 18/20] dt-bindings:iio:adc:amlogic,meson-saradc yaml
 conversion
Message-ID: <20200915192351.GA2341834@bogus>
References: <20200909175946.395313-1-jic23@kernel.org>
 <20200909175946.395313-19-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200909175946.395313-19-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Sep 09, 2020 at 06:59:44PM +0100, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> This binding is non trivial due to the range of different parts
> supported having several subtle quirks. Martin has helped
> clarify some of them.
> 
> Note, I haven't restricted the amlogic,hhi-sysctrl to only
> be present on the relevant parts if nvmem stuff also is, but
> it would seem to be rather odd if it were otherwise.
> 
> Perhaps we look to make this binding more restrictive at a later date.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Cc: Kevin Hilman <khilman@baylibre.com>
> Cc: Neil Armstrong <narmstrong@baylibre.com>
> Cc: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  .../bindings/iio/adc/amlogic,meson-saradc.txt |  48 ------
>  .../iio/adc/amlogic,meson-saradc.yaml         | 149 ++++++++++++++++++
>  2 files changed, 149 insertions(+), 48 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.txt b/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.txt
> deleted file mode 100644
> index d57e9df25f4f..000000000000
> --- a/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.txt
> +++ /dev/null
> @@ -1,48 +0,0 @@
> -* Amlogic Meson SAR (Successive Approximation Register) A/D converter
> -
> -Required properties:
> -- compatible:	depending on the SoC this should be one of:
> -			- "amlogic,meson8-saradc" for Meson8
> -			- "amlogic,meson8b-saradc" for Meson8b
> -			- "amlogic,meson8m2-saradc" for Meson8m2
> -			- "amlogic,meson-gxbb-saradc" for GXBB
> -			- "amlogic,meson-gxl-saradc" for GXL
> -			- "amlogic,meson-gxm-saradc" for GXM
> -			- "amlogic,meson-axg-saradc" for AXG
> -			- "amlogic,meson-g12a-saradc" for AXG
> -		along with the generic "amlogic,meson-saradc"
> -- reg:		the physical base address and length of the registers
> -- interrupts:	the interrupt indicating end of sampling
> -- clocks:	phandle and clock identifier (see clock-names)
> -- clock-names:	mandatory clocks:
> -			- "clkin" for the reference clock (typically XTAL)
> -			- "core" for the SAR ADC core clock
> -		optional clocks:
> -			- "adc_clk" for the ADC (sampling) clock
> -			- "adc_sel" for the ADC (sampling) clock mux
> -- vref-supply:	the regulator supply for the ADC reference voltage
> -- #io-channel-cells: must be 1, see ../iio-bindings.txt
> -
> -Optional properties:
> -- amlogic,hhi-sysctrl:	phandle to the syscon which contains the 5th bit
> -			of the TSC (temperature sensor coefficient) on
> -			Meson8b and Meson8m2 (which used to calibrate the
> -			temperature sensor)
> -- nvmem-cells:		phandle to the temperature_calib eFuse cells
> -- nvmem-cell-names:	if present (to enable the temperature sensor
> -			calibration) this must contain "temperature_calib"
> -
> -
> -Example:
> -	saradc: adc@8680 {
> -		compatible = "amlogic,meson-gxl-saradc", "amlogic,meson-saradc";
> -		#io-channel-cells = <1>;
> -		reg = <0x0 0x8680 0x0 0x34>;
> -		interrupts = <GIC_SPI 73 IRQ_TYPE_EDGE_RISING>;
> -		clocks = <&xtal>,
> -			 <&clkc CLKID_SAR_ADC>,
> -			 <&clkc CLKID_SANA>,
> -			 <&clkc CLKID_SAR_ADC_CLK>,
> -			 <&clkc CLKID_SAR_ADC_SEL>;
> -		clock-names = "clkin", "core", "sana", "adc_clk", "adc_sel";
> -	};
> diff --git a/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.yaml b/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.yaml
> new file mode 100644
> index 000000000000..6d94bf76900e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.yaml
> @@ -0,0 +1,149 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/amlogic,meson-saradc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Amlogic Meson SAR (Successive Approximation Register) A/D converter
> +
> +maintainers:
> +  - Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> +
> +description:
> +  Binding covers a range of ADCs found on amlogic meson SoCs.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - const: amlogic,meson-saradc
> +      - items:
> +          - enum:
> +              - amlogic,meson8-saradc
> +              - amlogic,meson8b-saradc
> +              - amlogic,meson8m2-saradc
> +              - amlogic,meson-gxbb-saradc
> +              - amlogic,meson-gxl-saradc
> +              - amlogic,meson-gxm-saradc
> +              - amlogic,meson-axg-saradc
> +              - amlogic,meson-g12a-saradc
> +          - const: amlogic,meson-saradc
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    description: Interrupt indicates end of sampling.
> +    maxItems: 1
> +
> +  clocks: true
> +
> +  clock-names: true

Since the names are the same, I prefer to have a schema that covers both 
cases here and then...

> +
> +  vref-supply: true
> +
> +  "#io-channel-cells":
> +    const: 1
> +
> +  amlogic,hhi-sysctrl:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      Syscon which contains the 5th bit of the TSC (temperature sensor
> +      coefficient) on Meson8b and Meson8m2 (which used to calibrate the
> +      temperature sensor)
> +
> +  nvmem-cells:
> +    description: phandle to the temperature_calib eFuse cells

maxItems: 1

> +
> +  nvmem-cell-names:
> +    const: temperature_calib
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - amlogic,meson8-saradc
> +              - amlogic,meson8b-saradc
> +              - amlogic,meson8m2-saradc
> +    then:
> +      properties:
> +        nvmem-cells: true
> +        nvmem-cell-names: true

You can drop these 2.

> +        clock-names:
> +          items:
> +            - const: clkin
> +            - const: core
> +          minItems: 2
> +        clocks:
> +          minItems: 2

This case just needs 'maxItems: 2' for clock-names and clocks.

> +    else:
> +      properties:
> +        nvmem-cells: false
> +        mvmem-cel-names: false
> +        clock-names:
> +          items:
> +            - const: clkin
> +            - const: core
> +            - const: adc_clk
> +            - const: adc_sel
> +          minItems: 4

And just minItems here.

> +        clocks:
> +          minItems: 4
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - amlogic,meson8b-saradc
> +              - amlogic,meson8m2-saradc
> +    then:
> +      properties:
> +        amlogic,hhi-sysctrl: true
> +    else:
> +      properties:
> +        amlogic,hhi-sysctrl: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +  - "#io-channel-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/clock/gxbb-clkc.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +        adc@8680 {
> +            compatible = "amlogic,meson-gxl-saradc", "amlogic,meson-saradc";
> +            #io-channel-cells = <1>;
> +            reg = <0x0 0x8680 0x0 0x34>;
> +            interrupts = <GIC_SPI 73 IRQ_TYPE_EDGE_RISING>;
> +            clocks = <&xtal>,
> +                <&clkc CLKID_SAR_ADC>,
> +                <&clkc CLKID_SAR_ADC_CLK>,
> +                <&clkc CLKID_SAR_ADC_SEL>;
> +            clock-names = "clkin", "core", "adc_clk", "adc_sel";
> +        };
> +        adc@9680 {
> +            compatible = "amlogic,meson8b-saradc", "amlogic,meson-saradc";
> +            #io-channel-cells = <1>;
> +            reg = <0x0 0x9680 0x0 0x34>;
> +            interrupts = <GIC_SPI 73 IRQ_TYPE_EDGE_RISING>;
> +            clocks = <&xtal>, <&clkc CLKID_SAR_ADC>;
> +            clock-names = "clkin", "core";
> +            nvmem-cells = <&tsens_caldata>;
> +            nvmem-cell-names = "temperature_calib";
> +            amlogic,hhi-sysctrl = <&hhi>;
> +        };
> +    };
> +...
> -- 
> 2.28.0
> 
