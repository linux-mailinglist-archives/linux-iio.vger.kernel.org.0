Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B142B36A118
	for <lists+linux-iio@lfdr.de>; Sat, 24 Apr 2021 14:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232867AbhDXMU7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 24 Apr 2021 08:20:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:52886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231836AbhDXMU6 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 24 Apr 2021 08:20:58 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B63B861468;
        Sat, 24 Apr 2021 12:20:18 +0000 (UTC)
Date:   Sat, 24 Apr 2021 13:20:58 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Joe Sandom <joe.g.sandom@gmail.com>
Cc:     andy.shevchenko@gmail.com, Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 2/2] dt-bindings: iio: light: Added AMS tsl2591
 device tree binding
Message-ID: <20210424132058.6d493499@jic23-huawei>
In-Reply-To: <20210421221330.17007-2-joe.g.sandom@gmail.com>
References: <20210421221330.17007-1-joe.g.sandom@gmail.com>
        <20210421221330.17007-2-joe.g.sandom@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 21 Apr 2021 23:13:30 +0100
Joe Sandom <joe.g.sandom@gmail.com> wrote:

> Device tree binding for AMS/TAOS tsl2591 ambient light sensor.
> 
> This driver supports configuration via device tree and sysfs.
> Supported channels for raw infrared light intensity,
> raw combined light intensity and illuminance in lux.
> The driver additionally supports iio events on lower and
> upper thresholds.
> 
> This is a very-high sensitivity light-to-digital converter that
> transforms light intensity into a digital signal.
> 
> Signed-off-by: Joe Sandom <joe.g.sandom@gmail.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Series applied to the togreg branch of iio.git and pushed out as testing
to let 0-day poke at it and see if we missed anything :)

Jonathan

> ---
> Changes in v9:
> - No changes
> 
> Notes:
> - Re-submitted to align the version with part 1 of the patch series
> 
>  .../bindings/iio/light/amstaos,tsl2591.yaml   | 50 +++++++++++++++++++
>  1 file changed, 50 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/light/amstaos,tsl2591.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/light/amstaos,tsl2591.yaml b/Documentation/devicetree/bindings/iio/light/amstaos,tsl2591.yaml
> new file mode 100644
> index 000000000000..596a3bc770f4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/light/amstaos,tsl2591.yaml
> @@ -0,0 +1,50 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/light/amstaos,tsl2591.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: AMS/TAOS TSL2591 Ambient Light Sensor (ALS)
> +
> +maintainers:
> +  - Joe Sandom <joe.g.sandom@gmail.com>
> +
> +description: |
> +  AMS/TAOS TSL2591 is a very-high sensitivity
> +  light-to-digital converter that transforms light intensity into a digital
> +  signal.
> +
> +properties:
> +  compatible:
> +    const: amstaos,tsl2591
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +    description:
> +      Interrupt (INT:Pin 2) Active low. Should be set to IRQ_TYPE_EDGE_FALLING.
> +      interrupt is used to detect if the light intensity has fallen below
> +      or reached above the configured threshold values.
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        tsl2591@29 {
> +            compatible = "amstaos,tsl2591";
> +            reg = <0x29>;
> +            interrupts = <20 IRQ_TYPE_EDGE_FALLING>;
> +       };
> +    };
> +...

