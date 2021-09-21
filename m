Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1EC4413809
	for <lists+linux-iio@lfdr.de>; Tue, 21 Sep 2021 19:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbhIURKF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 21 Sep 2021 13:10:05 -0400
Received: from mail-ot1-f54.google.com ([209.85.210.54]:43624 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbhIURKF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Sep 2021 13:10:05 -0400
Received: by mail-ot1-f54.google.com with SMTP id x33-20020a9d37a4000000b0054733a85462so2186188otb.10;
        Tue, 21 Sep 2021 10:08:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=O9JEWZDMt2jcZLyP/IIVUSlCL8PUIazRPHBsmaclHCw=;
        b=iKd8AnNgGwxhwEGjIyhtry2I1jvYucszT2rng/TqhEywdiHfdbbrGW7aiPMy7kREG8
         Q6824ZC1lOHoMSrxwWfV/H8zhXdpN9a+KgpYPeYEB7IUCfWFEOqyXTWcFlMseovUmTuC
         D3VfvEWNUicuGiXizYM+/5v4OVwgcu8LRMkkWOjLyPDluUA1WSwXJU8oRIUxB3nYLDZI
         ta267UhgcFiLKPCEI86FKOVisPcb4OAOhPs4ALb5nL/IzJ2fiFWYov38FZvTzJPO5kET
         0XGhCzNrjWSsaiER2GwSyJUjJmIjB8dmtcI1vYmllmEapSfA9/PyGK6auWQ7MSP1kWL5
         MTIw==
X-Gm-Message-State: AOAM533k1ModSCE9k2pq/VT54Zs7DafWf6mAYdr2WeXi+DC7uQRac9mr
        2gjTgFh7vTYfYoJMnPToeMKQXJ+GQA==
X-Google-Smtp-Source: ABdhPJyAoYtMFkASDt0IJc86gZEcglM6twQLZXsVUyPadtNltehV5spM1KvUGzi/ZewiYeR0LXPzOA==
X-Received: by 2002:a9d:5a89:: with SMTP id w9mr26610982oth.91.1632244116250;
        Tue, 21 Sep 2021 10:08:36 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id f17sm3024717ook.9.2021.09.21.10.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 10:08:34 -0700 (PDT)
Received: (nullmailer pid 2964447 invoked by uid 1000);
        Tue, 21 Sep 2021 17:08:33 -0000
Date:   Tue, 21 Sep 2021 12:08:33 -0500
From:   Rob Herring <robh@kernel.org>
To:     Olivier Moysan <olivier.moysan@foss.st.com>
Cc:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 1/7] dt-bindings: iio: adc: add generic channel binding
Message-ID: <YUoRkepuJXRghzih@robh.at.kernel.org>
References: <20210908155452.25458-1-olivier.moysan@foss.st.com>
 <20210908155452.25458-2-olivier.moysan@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210908155452.25458-2-olivier.moysan@foss.st.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Sep 08, 2021 at 05:54:46PM +0200, Olivier Moysan wrote:
> Add ADC generic channel binding. This binding should
> be used as an alternate to legacy channel properties
> whenever possible.
> ADC generic channel binding allows to identify supported
> internal channels through the following reserved label names:
> "vddcore", "vrefint" and "vbat".
> This binding also allows to set a different sampling time
> for each channel.
> 
> Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
> ---
> Note: The schema here is too permissive as either legacy or generic
> channels properties are required. These properties are mutually
> exclusive, however all attempts to describe this constraint are
> failing. In particular the following schemas and their variants have
> shown unsucessful.
> 
> oneOf:
>   - anyOf:
> 	- required:
> 		- st,adc-channels
> 	- required:
> 		- st,adc-diff-channels
>   - anyOf:
> 	- required:
> 		- $nodename
> 
> - if:
>   patternProperties:
>     "^channel@([0-9]|1[0-9])$":
>       type: object

This is considered true when you don't match this property. You would 
need 'required', but that doesn't work for patterns. That's a 
json-schema limitation that's on their radar to address.

My advice is just mark the legacy nodes 'deprecated'. That doesn't do 
anything yet, but I plan to add a 'disallow deprecated properties/nodes'
mode.

> then:
>   properties:
>     st,adc-channels: false
>     st,adc-diff-channels: false
> else:
>   - anyOf:
>       - required:
>           - st,adc-channels
>       - required:
>           - st,adc-diff-channels
> ---
>  .../bindings/iio/adc/st,stm32-adc.yaml        | 100 ++++++++++++++++--
>  1 file changed, 93 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.yaml b/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.yaml
> index a58334c3bb76..a1f6cbe144ba 100644
> --- a/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.yaml
> @@ -222,6 +222,12 @@ patternProperties:
>        '#io-channel-cells':
>          const: 1
>  
> +      '#address-cells':
> +        const: 1
> +
> +      '#size-cells':
> +        const: 0
> +
>        interrupts:
>          description: |
>            IRQ Line for the ADC instance. Valid values are:
> @@ -265,7 +271,9 @@ patternProperties:
>            <vinp vinn>, <vinp vinn>,... vinp and vinn are numbered from 0 to 19.
>  
>            Note: At least one of "st,adc-channels" or "st,adc-diff-channels" is
> -          required. Both properties can be used together. Some channels can be
> +          required if no adc generic channel is defined. These legacy channel
> +          properties are exclusive with adc generic channel bindings.
> +          Both properties can be used together. Some channels can be
>            used as single-ended and some other ones as differential (mixed). But
>            channels can't be configured both as single-ended and differential.
>          $ref: /schemas/types.yaml#/definitions/uint32-matrix
> @@ -290,6 +298,44 @@ patternProperties:
>            each channel.
>          $ref: /schemas/types.yaml#/definitions/uint32-array
>  
> +    patternProperties:
> +      "^channel@([0-9]|1[0-9])$":
> +        type: object
> +        $ref: "adc.yaml"
> +        description: |
> +          Represents the external channels which are connected to the ADC.
> +
> +        properties:
> +          reg:
> +            items:
> +              minimum: 0
> +              maximum: 19
> +
> +          label:
> +            description: |
> +              Unique name to identify which channel this is.
> +              Reserved label names "vddcore", "vrefint" and "vbat"
> +              are used to identify internal channels with matching names.
> +
> +          diff-channels:
> +            $ref: /schemas/types.yaml#/definitions/uint32-array
> +            items:
> +              minimum: 0
> +              maximum: 19
> +
> +          st,min-sample-time-nsecs:
> +            $ref: /schemas/types.yaml#/definitions/uint32
> +            description: |
> +              Minimum sampling time in nanoseconds. Depending on hardware (board)
> +              e.g. high/low analog input source impedance, fine tune of ADC
> +              sampling time may be recommended.
> +
> +        required:
> +          - reg
> +
> +    dependencies:
> +      $nodename: [ '#address-cells', '#size-cells' ]

Drop this. $nodename is not a real property.

> +
>      allOf:
>        - if:
>            properties:
> @@ -369,12 +415,6 @@ patternProperties:
>  
>      additionalProperties: false
>  
> -    anyOf:
> -      - required:
> -          - st,adc-channels
> -      - required:
> -          - st,adc-diff-channels
> -
>      required:
>        - compatible
>        - reg
> @@ -451,4 +491,50 @@ examples:
>          // other adc child node follow...
>        };
>  
> +  - |
> +    // Example 3: with stm32mp157c to setup ADC2 with:
> +    // - internal channels 13, 14, 15.
> +      #include <dt-bindings/interrupt-controller/arm-gic.h>
> +      #include <dt-bindings/clock/stm32mp1-clks.h>
> +      adc122: adc@48003000 {
> +        compatible = "st,stm32mp1-adc-core";
> +        reg = <0x48003000 0x400>;
> +        interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>;
> +        clocks = <&rcc ADC12>, <&rcc ADC12_K>;
> +        clock-names = "bus", "adc";
> +        booster-supply = <&booster>;
> +        vdd-supply = <&vdd>;
> +        vdda-supply = <&vdda>;
> +        vref-supply = <&vref>;
> +        st,syscfg = <&syscfg>;
> +        interrupt-controller;
> +        #interrupt-cells = <1>;
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        adc@100 {
> +          compatible = "st,stm32mp1-adc";
> +          #io-channel-cells = <1>;
> +          reg = <0x100>;
> +          interrupts = <1>;
> +          #address-cells = <1>;
> +          #size-cells = <0>;
> +          channel@13 {
> +            reg = <13>;
> +            label = "vrefint";
> +            st,min-sample-time-nsecs = <9000>;
> +          };
> +          channel@14 {
> +            reg = <14>;
> +            label = "vddcore";
> +            st,min-sample-time-nsecs = <9000>;
> +          };
> +          channel@15 {
> +            reg = <15>;
> +            label = "vbat";
> +            st,min-sample-time-nsecs = <9000>;
> +          };
> +        };
> +      };
> +
>  ...
> -- 
> 2.17.1
> 
> 
