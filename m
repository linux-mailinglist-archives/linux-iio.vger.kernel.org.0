Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE386421490
	for <lists+linux-iio@lfdr.de>; Mon,  4 Oct 2021 18:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237831AbhJDQ7V (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 4 Oct 2021 12:59:21 -0400
Received: from mail-ot1-f41.google.com ([209.85.210.41]:46848 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235803AbhJDQ7U (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 4 Oct 2021 12:59:20 -0400
Received: by mail-ot1-f41.google.com with SMTP id o59-20020a9d2241000000b0054745f28c69so22361944ota.13;
        Mon, 04 Oct 2021 09:57:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ih10pMBW5lUPCC/x9rLmG7kgKn8xGXvYQdK5s5DKY/o=;
        b=2yGafm1w/euuEn1ECHFDM2Ek44RvNwe4VK6ZzBlrmCr/0f4+anjd85j0tjJXVLEc7+
         e8FI/xbkiVmD9N5CBDBHH39ojIuLt1RhQoOc0IjaBmTqUYYn6m+44reXyrYQl8RoQ61I
         qE2xEdrVB+LGSsN+HxucQHL2h1qMFlzCJxqeoyuYyxWo2sE2nD+U2Mfhvh7XSWZXLc7A
         1jWTvJCAOM8ib3Z+gdKJTuuRb4h0PxM6fH2kKoj2CAtkaT+Uq6lj4DPpu8FKy7VeYfEm
         HwcNXx7vHQ4DhSasl09JdrfsI/O8OQ/d9O9osS1KOt/1lT0I5BiTba6PI8dMOXYirozD
         H0mA==
X-Gm-Message-State: AOAM5310/UdPXGMPFvohzcMTCPbn1qSLMLgigM2LR+lvcbYg8iS5tdxY
        HizTOZNO0uG//LMiW6uqKg==
X-Google-Smtp-Source: ABdhPJwNC9tnHciX03F9NzQzjfCfZ8I0KRSJ7pyztQajIKv6PxnNqi55xufKjBxiyphYX0bFvE61uA==
X-Received: by 2002:a9d:8a7:: with SMTP id 36mr10021321otf.263.1633366651128;
        Mon, 04 Oct 2021 09:57:31 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id s7sm2720818oiw.27.2021.10.04.09.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 09:57:30 -0700 (PDT)
Received: (nullmailer pid 1469674 invoked by uid 1000);
        Mon, 04 Oct 2021 16:57:27 -0000
Date:   Mon, 4 Oct 2021 11:57:27 -0500
From:   Rob Herring <robh@kernel.org>
To:     Olivier Moysan <olivier.moysan@foss.st.com>
Cc:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v3 1/7] dt-bindings: iio: stm32-adc: add generic channel
 binding
Message-ID: <YVsyd+O08h62NVwi@robh.at.kernel.org>
References: <20210924083410.12332-1-olivier.moysan@foss.st.com>
 <20210924083410.12332-2-olivier.moysan@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210924083410.12332-2-olivier.moysan@foss.st.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Sep 24, 2021 at 10:34:04AM +0200, Olivier Moysan wrote:
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
>  .../bindings/iio/adc/st,stm32-adc.yaml        | 100 ++++++++++++++++--
>  1 file changed, 93 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.yaml b/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.yaml
> index a58334c3bb76..1c13921b0556 100644
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
> @@ -256,6 +262,7 @@ patternProperties:
>              - 20 channels, numbered from 0 to 19 (for in0..in19) on stm32h7 and
>                stm32mp1.
>          $ref: /schemas/types.yaml#/definitions/uint32-array
> +        deprecated: true
>  
>        st,adc-diff-channels:
>          description: |
> @@ -265,7 +272,9 @@ patternProperties:
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
> @@ -279,6 +288,7 @@ patternProperties:
>                  "vinn" indicates negative input number
>                minimum: 0
>                maximum: 19
> +        deprecated: true
>  
>        st,min-sample-time-nsecs:
>          description:
> @@ -289,6 +299,42 @@ patternProperties:
>            list, to set sample time resp. for all channels, or independently for
>            each channel.
>          $ref: /schemas/types.yaml#/definitions/uint32-array
> +        deprecated: true
> +
> +    patternProperties:
> +      "^channel@([0-9]|1[0-9])$":
> +        type: object
> +        $ref: "adc.yaml"

You need 'additionalProperties: false' here. Or unevaluatedProperties if 
there are properties used and defined in adc.yaml, but not here.

> +        description: |

Don't need '|' unless you need to maintain formatting (line breaks).

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

Use standard unit suffix (-ns).

> +            $ref: /schemas/types.yaml#/definitions/uint32

And then drop this.

> +            description: |
> +              Minimum sampling time in nanoseconds. Depending on hardware (board)
> +              e.g. high/low analog input source impedance, fine tune of ADC
> +              sampling time may be recommended.
> +
> +        required:
> +          - reg
>  
>      allOf:
>        - if:
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
