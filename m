Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00EA33FCDF0
	for <lists+linux-iio@lfdr.de>; Tue, 31 Aug 2021 22:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240845AbhHaTiR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 31 Aug 2021 15:38:17 -0400
Received: from mail-oi1-f170.google.com ([209.85.167.170]:39869 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbhHaTiR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 31 Aug 2021 15:38:17 -0400
Received: by mail-oi1-f170.google.com with SMTP id v2so599920oie.6;
        Tue, 31 Aug 2021 12:37:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UR/YEfmmt/JFZ1MsJegoiIp8edIS9iLa4Q72fBQtWGE=;
        b=W9S2yUa6iB7hBCGZ3jG16A0dHwqFgwKCQCDgll82hoGnSQMkAYYjpu+7X8g34+1PjV
         AF3B+86fwXSpnDDLOoaKppDjJ3Qc3om1pK1/4jMP4euOqJ9HpIqqflJ7bcqBPb5/WE/8
         TtiMgmx14C6rC+aD2771W5fYEmaURqcS92AmTAGMlJX5mSUG887jrwUt0GY0rffFJNRa
         gVcvso4lWdJPIyqRYKSLdtWZaehqb/EEvzVZTPbUaJXo3uKTEmn8rd/Ahafc4JizLsAU
         Yt0oxD52KiGvyTuQNzZ5eZ743aeAhoHm9KkyzgDbj7xt3/MLR+F1Zu00OSJLOJHM+YX1
         k4tA==
X-Gm-Message-State: AOAM531FaiVI3HSBmy3KRfLuLYwKRXOi1Tr0L+NT5ob+kb3iJvYdeevT
        /uCAg/pWfuJe26tg5AFYrg==
X-Google-Smtp-Source: ABdhPJx36AKqFyPEdH6DPYHiZ4XQmI1wJWIziQWlHMVAxZ00XUUtxhbQ8kymJRzGOiO4V2pmQWKVIQ==
X-Received: by 2002:aca:4557:: with SMTP id s84mr4357950oia.77.1630438641091;
        Tue, 31 Aug 2021 12:37:21 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id bg38sm2167277oib.26.2021.08.31.12.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 12:37:20 -0700 (PDT)
Received: (nullmailer pid 529990 invoked by uid 1000);
        Tue, 31 Aug 2021 19:37:19 -0000
Date:   Tue, 31 Aug 2021 14:37:19 -0500
From:   Rob Herring <robh@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lee Jones <lee.jones@linaro.org>, bcousson@baylibre.com,
        Tony Lindgren <tony@atomide.com>,
        Tero Kristo <t-kristo@ti.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        "Ryan J . Barnett" <ryan.barnett@collins.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-input@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH 03/40] dt-bindings: touchscreen: ti,am3359-tsc: New yaml
 description
Message-ID: <YS6E769e/dVxrMyN@robh.at.kernel.org>
References: <20210825152518.379386-1-miquel.raynal@bootlin.com>
 <20210825152518.379386-4-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210825152518.379386-4-miquel.raynal@bootlin.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Aug 25, 2021 at 05:24:41PM +0200, Miquel Raynal wrote:
> This touchscreen controller is already described in a text file:
> Documentation/devicetree/bindings/input/touchscreen/ti-tsc-adc.txt
> 
> After introducing a proper description of the MFD, this is the second
> step. The file cannot be removed yet as it also contains an ADC
> description.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  .../input/touchscreen/ti,am3359-tsc.yaml      | 89 +++++++++++++++++++
>  1 file changed, 89 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/ti,am3359-tsc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/ti,am3359-tsc.yaml b/Documentation/devicetree/bindings/input/touchscreen/ti,am3359-tsc.yaml
> new file mode 100644
> index 000000000000..2d4ce6d04f53
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/touchscreen/ti,am3359-tsc.yaml
> @@ -0,0 +1,89 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/input/touchscreen/ti,am3359-tsc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: TI AM3359 Touchscreen controller
> +
> +maintainers:
> +  - Miquel Raynal <miquel.raynal@bootlin.com>
> +
> +properties:
> +  compatible:
> +    const: ti,am3359-tsc
> +
> +  ti,wires:
> +    description: Wires refer to application modes i.e. 4/5/8 wire touchscreen
> +      support on the platform.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [4, 5, 8]
> +
> +  ti,x-plate-resistance:
> +    description: X plate resistance
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  ti,coordinate-readouts:
> +    description: The sequencer supports a total of 16 programmable steps. Each
> +      step is used to read a single coordinate. A single readout is enough but
> +      multiple reads can increase the quality. A value of 5 means, 5 reads for
> +      X, 5 for Y and 2 for Z (always). This utilises 12 of the 16 software steps
> +      available. The remaining 4 can be used by the ADC.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 1
> +    maximum: 6
> +
> +  ti,wire-config:
> +    description: Different boards could have a different order for connecting
> +      wires on touchscreen. We need to provide an 8-bit number where the
> +      first four bits represent the analog lines and the next 4 bits represent
> +      positive/negative terminal on that input line. Notations to represent the
> +      input lines and terminals respectively are as follows, AIN0 = 0, AIN1 = 1
> +      and so on untill AIN7 = 7. XP = 0, XN = 1, YP = 2, YN = 3.
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    minItems: 4
> +    maxItems: 8
> +
> +  ti,charge-delay:
> +    description: Length of touch screen charge delay step in terms of ADC clock
> +      cycles. Charge delay value should be large in order to avoid false pen-up
> +      events. This value effects the overall sampling speed, hence need to be
> +      kept as low as possible, while avoiding false pen-up event. Start from a
> +      lower value, say 0x400, and increase value until false pen-up events are
> +      avoided. The pen-up detection happens immediately after the charge step,
> +      so this does in fact function as a hardware knob for adjusting the amount
> +      of "settling time".
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +required:
> +  - compatible
> +  - ti,wires
> +  - ti,x-plate-resistance
> +  - ti,coordinate-readouts
> +  - ti,wire-config
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>

I prefer that MFDs have just 1 complete example in the MFD schema. 

> +
> +    tscadc: tscadc@0 {

Drop unused labels.

> +        compatible = "ti,am3359-tscadc";
> +        reg = <0x0 0x1000>;
> +        interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
> +        clocks = <&adc_tsc_fck>;
> +        clock-names = "fck";
> +        status = "disabled";

status, again.

> +        dmas = <&edma 53 0>, <&edma 57 0>;
> +        dma-names = "fifo0", "fifo1";
> +
> +        tsc {
> +            compatible = "ti,am3359-tsc";
> +            ti,wires = <4>;
> +            ti,x-plate-resistance = <200>;
> +            ti,coordinate-readouts = <5>;
> +            ti,wire-config = <0x00 0x11 0x22 0x33>;
> +            ti,charge-delay = <0x400>;
> +        };
> +    };
> -- 
> 2.27.0
> 
> 
