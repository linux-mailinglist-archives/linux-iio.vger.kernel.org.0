Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91F053FCDDD
	for <lists+linux-iio@lfdr.de>; Tue, 31 Aug 2021 22:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240607AbhHaTeL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 31 Aug 2021 15:34:11 -0400
Received: from mail-ot1-f44.google.com ([209.85.210.44]:40943 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234139AbhHaTeK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 31 Aug 2021 15:34:10 -0400
Received: by mail-ot1-f44.google.com with SMTP id 107-20020a9d0bf4000000b0051b8be1192fso505554oth.7;
        Tue, 31 Aug 2021 12:33:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=W4G3btfQoqpVB2WnXumklQXRHhxDd2G4lTDMKDvcpiw=;
        b=qqx+Gwlyiln1F6ELj6LYsBMPXmiZ9En2c5nmNlh1SArGzq5uslofwuLG8fVWGe6psL
         tO1/ylVTtdOZQ0AtxszBdmYYtl/MdlV8291dQ3Vt/lqjK2SzyhNvHwchCt0rkW98IvhQ
         aWUSwg7h/D77HW4d2dBhGLI762M+maj2ByiGcVTYglgRozIRcE6xLAONJhtYn6Oa5Egp
         LcAnQdam8oADJtKnYhT7+qp8TW/PiG/ihF3Kkg8h4KR2Qqir/ul31bRdJ8+mUluty1VP
         rQVnIqYYDPPst8jjB1V1x7UNBSPzjFLR/bYvieYCg7xPeW0GD3mxnrpn7EvZx1tmtGIz
         a0Aw==
X-Gm-Message-State: AOAM533DkZPImJn1nRZhoOxaBSkT2WzLckqGbUNwcPy4lruJfseA83hP
        v1O5RGn4WXsvXBp83soSTw==
X-Google-Smtp-Source: ABdhPJy05ej2GopPGoQw/nVfTmaL2qhTsLNPDa2RwYNtgHGf1ltyxAXGgmt/C+lmxdZeI6yxTtWCyw==
X-Received: by 2002:a05:6830:608:: with SMTP id w8mr24702828oti.73.1630438394603;
        Tue, 31 Aug 2021 12:33:14 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id s24sm3808165oic.34.2021.08.31.12.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 12:33:13 -0700 (PDT)
Received: (nullmailer pid 523904 invoked by uid 1000);
        Tue, 31 Aug 2021 19:33:12 -0000
Date:   Tue, 31 Aug 2021 14:33:12 -0500
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
Subject: Re: [PATCH 02/40] dt-bindings: mfd: ti,am3359-tscadc: Add a yaml
 description for this MFD
Message-ID: <YS6D+Hm5Y+t77JRQ@robh.at.kernel.org>
References: <20210825152518.379386-1-miquel.raynal@bootlin.com>
 <20210825152518.379386-3-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210825152518.379386-3-miquel.raynal@bootlin.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Aug 25, 2021 at 05:24:40PM +0200, Miquel Raynal wrote:
> There is a very light description of this MFD in a text file dedicated
> to a touchscreen controller (which is one of the two children of the
> MFD). Here is now a complete yaml description.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  .../bindings/mfd/ti,am3359-tscadc.yaml        | 75 +++++++++++++++++++
>  1 file changed, 75 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/ti,am3359-tscadc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mfd/ti,am3359-tscadc.yaml b/Documentation/devicetree/bindings/mfd/ti,am3359-tscadc.yaml
> new file mode 100644
> index 000000000000..96b329508d8a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/ti,am3359-tscadc.yaml
> @@ -0,0 +1,75 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/ti,am3359-tscadc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: TI AM3359 Touchscreen controller/ADC
> +
> +maintainers:
> +  - Miquel Raynal <miquel.raynal@bootlin.com>
> +
> +properties:
> +  compatible:
> +    const: ti,am3359-tscadc
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
> +    const: fck
> +
> +  dmas:
> +    items:
> +      - description: DMA controller phandle and request line for FIFO0
> +      - description: DMA controller phandle and request line for FIFO1
> +
> +  dma-names:
> +    items:
> +      - const: fifo0
> +      - const: fifo1
> +
> +patternProperties:
> +  "^adc$":
> +    description: ADC
> +
> +  "^tsc$":
> +    description: Touchscreen controller

These are fixed strings, so move to 'properties'. They also need 'type: 
object' to indicate they are nodes.

> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +  - dmas
> +  - dma-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    tscadc: tscadc@0 {
> +        compatible = "ti,am3359-tscadc";
> +        reg = <0x0 0x1000>;
> +        interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
> +        clocks = <&adc_tsc_fck>;
> +        clock-names = "fck";
> +        dmas = <&edma 53 0>, <&edma 57 0>;
> +        dma-names = "fifo0", "fifo1";
> +        status = "disabled";

Don't show 'status' in examples. It disables some checks.

> +
> +        tsc {
> +        };
> +
> +        adc {
> +        };
> +    };
> -- 
> 2.27.0
> 
> 
