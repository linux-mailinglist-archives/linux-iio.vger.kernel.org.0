Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5165E3F5DB3
	for <lists+linux-iio@lfdr.de>; Tue, 24 Aug 2021 14:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236907AbhHXMNw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 24 Aug 2021 08:13:52 -0400
Received: from mail-ot1-f48.google.com ([209.85.210.48]:38609 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236676AbhHXMNv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 24 Aug 2021 08:13:51 -0400
Received: by mail-ot1-f48.google.com with SMTP id i8-20020a056830402800b0051afc3e373aso34121337ots.5;
        Tue, 24 Aug 2021 05:13:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ucW5ESnazpnHopEpKtJXSrUkYd/hKt6rzSaH/p9OLnU=;
        b=QMmYisvFZCfC6pHaAo2REGXtoD0WNe58uC9nSKS8+RXFPK6d1Mx5P99y+TDcq6ciYN
         rcpYWqT8RgsnkS6esvdSR5cvhCGrrmqX5ZsKgDRxZ/MsNCZ0wc1qjNSHJft1S2M7FrDJ
         N1PW+ccAOaMjc16N/dP7mFtYjMhJgwO0DVBOVet+mUbaUsx3hXs4HO9/d4YC3FdM/8Nq
         C8OiPbd3YH2gWk9gpiqVwZ/VwwRGuUwzkMw1P3LLe6/ldmNnsaNRlynglWlXnQ/R8Pdd
         ufmUBxICKUpE1kXZ9NvVZ8v3lLJn1KDU7R1dwuSnyCOIASUEKuv8+83W1ICGSjfwLQad
         UdfQ==
X-Gm-Message-State: AOAM533hMsrbJjqyp1GCWLb/Z+VH2oHhnWlYk88QmJTDzeUi7aaY2N4+
        +yubsiWQ2Z2eTbHwIEyhlQ==
X-Google-Smtp-Source: ABdhPJwmL7fV+UFqhUhlvO56wKUhjbk2HWg/fnimn1UVUMQplLSBAYfIBSxvjbqmY8uN0GSWWUxrkA==
X-Received: by 2002:a05:6808:10c8:: with SMTP id s8mr2565522ois.6.1629807186746;
        Tue, 24 Aug 2021 05:13:06 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id 97sm4553510otv.26.2021.08.24.05.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 05:13:05 -0700 (PDT)
Received: (nullmailer pid 21234 invoked by uid 1000);
        Tue, 24 Aug 2021 12:13:04 -0000
Date:   Tue, 24 Aug 2021 07:13:04 -0500
From:   Rob Herring <robh@kernel.org>
To:     Billy Tsai <billy_tsai@aspeedtech.com>
Cc:     jic23@kernel.org, lars@metafoo.de, pmeerw@pmeerw.net,
        joel@jms.id.au, andrew@aj.id.au, p.zabel@pengutronix.de,
        lgirdwood@gmail.com, broonie@kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        BMC-SW@aspeedtech.com
Subject: Re: [v4 01/15] dt-bindings: iio: adc: Add ast2600-adc bindings
Message-ID: <YSTiUPQa+HYSA63t@robh.at.kernel.org>
References: <20210823070240.12600-1-billy_tsai@aspeedtech.com>
 <20210823070240.12600-2-billy_tsai@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210823070240.12600-2-billy_tsai@aspeedtech.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Aug 23, 2021 at 03:02:26PM +0800, Billy Tsai wrote:
> Add device tree bindings document for the aspeed ast2600 adc device
> driver.
> 
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> ---
>  .../bindings/iio/adc/aspeed,ast2600-adc.yaml  | 97 +++++++++++++++++++
>  1 file changed, 97 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/aspeed,ast2600-adc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/aspeed,ast2600-adc.yaml b/Documentation/devicetree/bindings/iio/adc/aspeed,ast2600-adc.yaml
> new file mode 100644
> index 000000000000..248cda7d91e9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/aspeed,ast2600-adc.yaml
> @@ -0,0 +1,97 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/aspeed,ast2600-adc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ADC that forms part of an ASPEED server management processor.
> +
> +maintainers:
> +  - Billy Tsai <billy_tsai@aspeedtech.com>
> +
> +description: |
> +  • 10-bits resolution for 16 voltage channels.
> +  • The device split into two individual engine and each contains 8 voltage
> +  channels.
> +  • Channel scanning can be non-continuous.
> +  • Programmable ADC clock frequency.
> +  • Programmable upper and lower threshold for each channels.
> +  • Interrupt when larger or less than threshold for each channels.
> +  • Support hysteresis for each channels.
> +  • Built-in a compensating method.
> +  • Built-in a register to trim internal reference voltage.
> +  • Internal or External reference voltage.
> +  • Support 2 Internal reference voltage 1.2v or 2.5v.
> +  • Integrate dividing circuit for battery sensing.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - aspeed,ast2600-adc0
> +      - aspeed,ast2600-adc1

What's the difference between 0 and 1?

> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    description:
> +      Input clock used to derive the sample clock. Expected to be the
> +      SoC's APB clock.

How many clocks?

> +
> +  resets:
> +    maxItems: 1
> +
> +  "#io-channel-cells":
> +    const: 1
> +
> +  vref-supply:
> +    description:
> +      The external regulator supply ADC reference voltage.
> +
> +  aspeed,int_vref_mv:

Don't use '_' in property names.

Use standard unit suffixes as defined in property-units.yaml.

> +    $ref: /schemas/types.yaml#/definitions/uint32

And then you can drop this.

> +    enum: [1200, 2500]
> +    description:
> +      ADC internal reference voltage in millivolts.
> +
> +  aspeed,battery-sensing:
> +    type: boolean
> +    description:
> +      Inform the driver that last channel will be used to sensor battery.
> +
> +  aspeed,trim-data-valid:
> +    type: boolean
> +    description: |
> +      The ADC reference voltage can be calibrated to obtain the trimming
> +      data which will be stored in otp. This property informs the driver that
> +      the data store in the otp is valid.
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - resets
> +  - "#io-channel-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/ast2600-clock.h>
> +    adc0: adc@1e6e9000 {
> +        compatible = "aspeed,ast2600-adc0";
> +        reg = <0x1e6e9000 0x100>;
> +        clocks = <&syscon ASPEED_CLK_APB2>;
> +        resets = <&syscon ASPEED_RESET_ADC>;
> +        #io-channel-cells = <1>;
> +        aspeed,int_vref_mv = <2500>;
> +    };
> +    adc1: adc@1e6e9100 {
> +        compatible = "aspeed,ast2600-adc1";
> +        reg = <0x1e6e9100 0x100>;
> +        clocks = <&syscon ASPEED_CLK_APB2>;
> +        resets = <&syscon ASPEED_RESET_ADC>;
> +        #io-channel-cells = <1>;
> +        aspeed,int_vref_mv = <2500>;
> +    };
> +...
> -- 
> 2.25.1
> 
> 
