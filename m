Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 818C92A1E4F
	for <lists+linux-iio@lfdr.de>; Sun,  1 Nov 2020 14:26:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbgKAN0Z convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Sun, 1 Nov 2020 08:26:25 -0500
Received: from mslow2.mail.gandi.net ([217.70.178.242]:51336 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbgKAN0Y (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 1 Nov 2020 08:26:24 -0500
Received: from relay12.mail.gandi.net (unknown [217.70.178.232])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id 2A2343A85BE
        for <linux-iio@vger.kernel.org>; Sun,  1 Nov 2020 13:26:22 +0000 (UTC)
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 9D372200006;
        Sun,  1 Nov 2020 13:25:58 +0000 (UTC)
Date:   Sun, 1 Nov 2020 14:25:57 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Philippe Reynes <tremyfr@yahoo.fr>
Subject: Re: [PATCH 07/10] dt-bindings:iio:adc:maxim,max1027: Pull out to
 separate binding doc.
Message-ID: <20201101142557.153c7b97@xps13>
In-Reply-To: <20201031181242.742301-8-jic23@kernel.org>
References: <20201031181242.742301-1-jic23@kernel.org>
        <20201031181242.742301-8-jic23@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

Jonathan Cameron <jic23@kernel.org> wrote on Sat, 31 Oct 2020 18:12:39
+0000:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> The afe/voltage-divider.yaml example uses this device with 2 properties
> not provided by trivial-devices.yaml (spi-max-frequency and #io-channel-cells)
> 
> Solve that by creating a more specific binding doc.

I don't know #io-channel-cells but spi-max-frequency is very common and
is related to the fact that this device is a SPI device (hence, a SPI
subnode), IMHO it has nothing to do with trivial-devices.yaml
description.

> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: Philippe Reynes <tremyfr@yahoo.fr>
> ---
>  .../bindings/iio/adc/maxim,max1027.yaml       | 64 +++++++++++++++++++
>  .../devicetree/bindings/trivial-devices.yaml  | 12 ----
>  2 files changed, 64 insertions(+), 12 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/maxim,max1027.yaml b/Documentation/devicetree/bindings/iio/adc/maxim,max1027.yaml
> new file mode 100644
> index 000000000000..09e853c50c76
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/maxim,max1027.yaml
> @@ -0,0 +1,64 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/maxim,max1027.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Maxim MAX1027 and similar ADCs
> +
> +maintainers:
> +  - Miquel Raynal <miquel.raynal@bootlin.com>
> +  - Philippe Reynes <tremyfr@yahoo.fr>
> +
> +description: |
> +  300ks/s SPI ADCs with temperature sensors.
> +
> +properties:
> +  compatible:
> +    enum:
> +        # 10-bit 8 channels
> +      - maxim,max1027
> +        # 10-bit 12 channels
> +      - maxim,max1029
> +        # 10-bit 16 channels
> +      - maxim,max1031
> +         # 12-bit 8 channels
> +      - maxim,max1227
> +         # 12-bit 12 channels
> +      - maxim,max1229
> +         # 12-bit 16 channels
> +      - maxim,max1231
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  spi-max-frequency: true
> +
> +  "#io-channel-cells":
> +    const: 1
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
> +    spi {
> +       #address-cells = <1>;
> +       #size-cells = <0>;
> +        maxadc: adc@0 {
> +            compatible = "maxim,max1027";
> +            reg = <0>;
> +            #io-channel-cells = <1>;
> +            interrupt-parent = <&gpio5>;
> +            interrupts = <15 IRQ_TYPE_EDGE_RISING>;
> +            spi-max-frequency = <1000000>;
> +        };
> +    };
> +...
> diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
> index d154ea97e30d..185e09e61e16 100644
> --- a/Documentation/devicetree/bindings/trivial-devices.yaml
> +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
> @@ -108,18 +108,6 @@ properties:
>            - isil,isl68137
>              # 5 Bit Programmable, Pulse-Width Modulator
>            - maxim,ds1050
> -            # 10-bit 8 channels 300ks/s SPI ADC with temperature sensor
> -          - maxim,max1027
> -            # 10-bit 12 channels 300ks/s SPI ADC with temperature sensor
> -          - maxim,max1029
> -            # 10-bit 16 channels 300ks/s SPI ADC with temperature sensor
> -          - maxim,max1031
> -            # 12-bit 8 channels 300ks/s SPI ADC with temperature sensor
> -          - maxim,max1227
> -            # 12-bit 12 channels 300ks/s SPI ADC with temperature sensor
> -          - maxim,max1229
> -            # 12-bit 16 channels 300ks/s SPI ADC with temperature sensor
> -          - maxim,max1231
>              # Low-Power, 4-/12-Channel, 2-Wire Serial, 12-Bit ADCs
>            - maxim,max1237
>              # PECI-to-I2C translator for PECI-to-SMBus/I2C protocol conversion

Thanks,
Miquèl
