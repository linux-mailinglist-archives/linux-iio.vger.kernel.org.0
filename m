Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDE613FB648
	for <lists+linux-iio@lfdr.de>; Mon, 30 Aug 2021 14:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232454AbhH3MpC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Aug 2021 08:45:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:37312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229957AbhH3MpC (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 30 Aug 2021 08:45:02 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 063C060525;
        Mon, 30 Aug 2021 12:44:02 +0000 (UTC)
Date:   Mon, 30 Aug 2021 13:47:14 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
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
Message-ID: <20210830134714.133cbb65@jic23-huawei>
In-Reply-To: <20210825152518.379386-3-miquel.raynal@bootlin.com>
References: <20210825152518.379386-1-miquel.raynal@bootlin.com>
        <20210825152518.379386-3-miquel.raynal@bootlin.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 25 Aug 2021 17:24:40 +0200
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> There is a very light description of this MFD in a text file dedicated
> to a touchscreen controller (which is one of the two children of the
> MFD). Here is now a complete yaml description.

Make sure to call out places where you are filling in gaps in the
txt file description.  Looks like we forgot to keep that up to date as the driver
evolved. oops.

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

text documents the more specific ti,am654-tscadc as well.
Something like

   properties:
     compatible:
       oneof:
         - const: ti,am3359-tscadc
         - items:
             - const: ti,am654-tscadc
             - const: ti,am3359-tscadc

Note this superceeds my comment on later patches about changing to enum when
introducing the new compatible. Ah well.

example for this would be something like
Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.yam;

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
> +
> +        tsc {
> +        };
> +
> +        adc {
> +        };
> +    };

