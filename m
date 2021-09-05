Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5A4E400F68
	for <lists+linux-iio@lfdr.de>; Sun,  5 Sep 2021 13:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237870AbhIEL5W (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Sep 2021 07:57:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:57468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232168AbhIEL5V (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 5 Sep 2021 07:57:21 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3374B60E93;
        Sun,  5 Sep 2021 11:56:11 +0000 (UTC)
Date:   Sun, 5 Sep 2021 12:59:34 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, bcousson@baylibre.com,
        Tony Lindgren <tony@atomide.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-omap@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Ryan Barnett <ryan.barnett@collins.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Jason Reeder <jreeder@ti.com>
Subject: Re: [PATCH v2 03/46] dt-bindings: touchscreen: ti,am3359-tsc: New
 yaml description
Message-ID: <20210905125934.0e7d12f4@jic23-huawei>
In-Reply-To: <20210902215144.507243-4-miquel.raynal@bootlin.com>
References: <20210902215144.507243-1-miquel.raynal@bootlin.com>
        <20210902215144.507243-4-miquel.raynal@bootlin.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu,  2 Sep 2021 23:51:01 +0200
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> This touchscreen controller is already described in a text file:
> Documentation/devicetree/bindings/input/touchscreen/ti-tsc-adc.txt
> 
> After introducing a proper description of the MFD, this is the second
> step. The file cannot be removed yet as it also contains an ADC
> description.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
You addressed my comment on v1 in that thread so I'm fine with this.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  .../input/touchscreen/ti,am3359-tsc.yaml      | 76 +++++++++++++++++++
>  1 file changed, 76 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/ti,am3359-tsc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/ti,am3359-tsc.yaml b/Documentation/devicetree/bindings/input/touchscreen/ti,am3359-tsc.yaml
> new file mode 100644
> index 000000000000..e44cc65abc8c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/touchscreen/ti,am3359-tsc.yaml
> @@ -0,0 +1,76 @@
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
> +      and so on until AIN7 = 7. XP = 0, XN = 1, YP = 2, YN = 3.
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
> +    tsc {
> +        compatible = "ti,am3359-tsc";
> +        ti,wires = <4>;
> +        ti,x-plate-resistance = <200>;
> +        ti,coordinate-readouts = <5>;
> +        ti,wire-config = <0x00 0x11 0x22 0x33>;
> +        ti,charge-delay = <0x400>;
> +    };

