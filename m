Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0B6C26AD92
	for <lists+linux-iio@lfdr.de>; Tue, 15 Sep 2020 21:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727913AbgIOT1W (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 15 Sep 2020 15:27:22 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:43387 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727888AbgIOT0l (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 15 Sep 2020 15:26:41 -0400
Received: by mail-io1-f65.google.com with SMTP id z25so5386620iol.10;
        Tue, 15 Sep 2020 12:26:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tYBYkmkOCIGqFuOFhUoSUHBmQglmGC6EfZ4XQmGFw/Y=;
        b=QZKbIKp+I5s+b1gYwWlCBmXRlcDpAQhgMHpIpUHaaHZTcVKWv2gb3yOo6EHNws/Nix
         uCkjBJqVGtZ0iFn9kT4STa78yEJJ9HXP9knTgZFmJAmdUtquMYCV78PSxRec6JzWkNs3
         UJx8xj2lRqjxXoO62ckCRHoj7R44/Uh6WT2508dfKee5B8iHksh4ngjR01z7uChT47pZ
         lXgeT5pIoFhuoMelc9EOULCWoinCuorX8AzJqeTqj3saTV8NhjlLMAKnLikQaVB1s7Ol
         Uxps1nwGCWmy1qpIEWNBI3d0AvQH30+/sA7cGjYQKmzPIbAqalSrurkiilcS/Sa9GxjW
         zeJA==
X-Gm-Message-State: AOAM532QlhBdKUJBrflvMnsB2hgD42UapIUaj6cCVg7QVo43V3Lo7Mmw
        zEPcTm0/AawFvzyJ2CjFOg==
X-Google-Smtp-Source: ABdhPJzRkkKTAo2GBjQO1GN4lTZ329d8H4/fOhrh9SGHekW/ozIPY/JzterLnLVZXrYqh8Aed+gpng==
X-Received: by 2002:a05:6638:dd3:: with SMTP id m19mr20040971jaj.115.1600197999967;
        Tue, 15 Sep 2020 12:26:39 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id k1sm9289088ilq.59.2020.09.15.12.26.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 12:26:39 -0700 (PDT)
Received: (nullmailer pid 2354940 invoked by uid 1000);
        Tue, 15 Sep 2020 19:26:37 -0000
Date:   Tue, 15 Sep 2020 13:26:37 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Markus Pargmann <mpa@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH v2 20/20] dt-bindings:iio:adc:fsl,imx25-gcq yaml
 conversion
Message-ID: <20200915192637.GA2351801@bogus>
References: <20200909175946.395313-1-jic23@kernel.org>
 <20200909175946.395313-21-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200909175946.395313-21-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Sep 09, 2020 at 06:59:46PM +0100, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> This binding has a few corners that would have been done different today
> but hopefully the yaml schema captures the constraints correctly.
> 
> The child node names are not constrained hence the fairly open regexp.
> I've also documented the defaults for the two references that the
> driver seems to use and copied the value descriptions from the header
> because I think they should be in the dt-binding itself.
> 
> This is part of a general effort to convert all the IIO bindings
> over to yaml
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Markus Pargmann <mpa@pengutronix.de>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  .../bindings/iio/adc/fsl,imx25-gcq.txt        |  57 --------
>  .../bindings/iio/adc/fsl,imx25-gcq.yaml       | 129 ++++++++++++++++++
>  2 files changed, 129 insertions(+), 57 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/fsl,imx25-gcq.txt b/Documentation/devicetree/bindings/iio/adc/fsl,imx25-gcq.txt
> deleted file mode 100644
> index eebdcec3dab5..000000000000
> --- a/Documentation/devicetree/bindings/iio/adc/fsl,imx25-gcq.txt
> +++ /dev/null
> @@ -1,57 +0,0 @@
> -Freescale i.MX25 ADC GCQ device
> -
> -This is a generic conversion queue device that can convert any of the
> -analog inputs using the ADC unit of the i.MX25.
> -
> -Required properties:
> - - compatible: Should be "fsl,imx25-gcq".
> - - reg: Should be the register range of the module.
> - - interrupts: Should be the interrupt number of the module.
> -   Typically this is <1>.
> - - #address-cells: Should be <1> (setting for the subnodes)
> - - #size-cells: Should be <0> (setting for the subnodes)
> -
> -Optional properties:
> - - vref-ext-supply: The regulator supplying the ADC reference voltage.
> -   Required when at least one subnode uses the this reference.
> - - vref-xp-supply: The regulator supplying the ADC reference voltage on pin XP.
> -   Required when at least one subnode uses this reference.
> - - vref-yp-supply: The regulator supplying the ADC reference voltage on pin YP.
> -   Required when at least one subnode uses this reference.
> -
> -Sub-nodes:
> -Optionally you can define subnodes which define the reference voltage
> -for the analog inputs.
> -
> -Required properties for subnodes:
> - - reg: Should be the number of the analog input.
> -     0: xp
> -     1: yp
> -     2: xn
> -     3: yn
> -     4: wiper
> -     5: inaux0
> -     6: inaux1
> -     7: inaux2
> -Optional properties for subnodes:
> - - fsl,adc-refp: specifies the positive reference input as defined in
> -     <dt-bindings/iio/adc/fsl-imx25-gcq.h>
> - - fsl,adc-refn: specifies the negative reference input as defined in
> -     <dt-bindings/iio/adc/fsl-imx25-gcq.h>
> -
> -Example:
> -
> -	adc: adc@50030800 {
> -		compatible = "fsl,imx25-gcq";
> -		reg = <0x50030800 0x60>;
> -		interrupt-parent = <&tscadc>;
> -		interrupts = <1>;
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -
> -		inaux@5 {
> -			reg = <5>;
> -			fsl,adc-refp = <MX25_ADC_REFP_INT>;
> -			fsl,adc-refn = <MX25_ADC_REFN_NGND>;
> -		};
> -	};
> diff --git a/Documentation/devicetree/bindings/iio/adc/fsl,imx25-gcq.yaml b/Documentation/devicetree/bindings/iio/adc/fsl,imx25-gcq.yaml
> new file mode 100644
> index 000000000000..6c4e3ef0862c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/fsl,imx25-gcq.yaml
> @@ -0,0 +1,129 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/fsl,imx25-gcq.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Freescale ADC GCQ device
> +
> +description:
> +  This is a generic conversion queue device that can convert any of the
> +  analog inputs using the ADC unit of the i.MX25.
> +
> +maintainers:
> +  - Markus Pargmann <mpa@pengutronix.de>
> +
> +properties:
> +  compatible:
> +    const: fsl,imx25-gcq
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  vref-ext-supply:
> +    description:
> +      The regulator supplying the ADC reference voltage.
> +      Required when at least one subnode uses the this reference.
> +
> +  vref-xp-supply:
> +    description:
> +      The regulator supplying the ADC reference voltage on pin XP.
> +      Required when at least one subnode uses this reference.
> +
> +  vref-yp-supply:
> +    description:
> +      The regulator supplying the ADC reference voltage on pin YP.
> +      Required when at least one subnode uses this reference.
> +
> +  "#io-channel-cells":
> +    const: 1
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - "#address-cells"
> +  - "#size-cells"
> +
> +patternProperties:
> +  "[a-z][a-z0-9]+@[0-9a-f]+$":
> +    type: object
> +    description:
> +      Child nodes used to define the reference voltages used for each channel
> +
> +    properties:
> +      reg:
> +        description: |
> +          Number of the analog input.
> +          0: xp
> +          1: yp
> +          2: xn
> +          3: yn
> +          4: wiper
> +          5: inaux0
> +          6: inaux1
> +          7: inaux2
> +        items:
> +          - minimum: 0
> +            maximum: 7
> +
> +      fsl,adc-refp:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description: |
> +          Specifies the positive reference input as defined in
> +          <dt-bindings/iio/adc/fsl-imx25-gcq.h>
> +          0: YP voltage reference
> +          1: XP voltage reference
> +          2: External voltage reference
> +          3: Internal voltage reference (default)
> +        minimum: 0
> +        maximum: 3
> +
> +      fsl,adc-refn:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description: |
> +          Specifies the negative reference input as defined in
> +          <dt-bindings/iio/adc/fsl-imx25-gcq.h>
> +          0: XN ground reference
> +          1: YN ground reference
> +          2: Internal ground reference
> +          3: External ground reference (default)
> +        minimum: 0
> +        maximum: 3
> +
> +    required:
> +      - reg

Each level needs 'additionalProperties':

       additionalProperties: false

With that,

Reviewed-by: Rob Herring <robh@kernel.org>

> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/iio/adc/fsl-imx25-gcq.h>
> +    soc {
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +        adc@50030800 {
> +            compatible = "fsl,imx25-gcq";
> +            reg = <0x50030800 0x60>;
> +            interrupt-parent = <&tscadc>;
> +            interrupts = <1>;
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            inaux@5 {
> +                reg = <5>;
> +                fsl,adc-refp = <MX25_ADC_REFP_INT>;
> +                fsl,adc-refn = <MX25_ADC_REFN_NGND>;
> +            };
> +        };
> +    };
> +...
> -- 
> 2.28.0
> 
