Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C23713DCD0B
	for <lists+linux-iio@lfdr.de>; Sun,  1 Aug 2021 20:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbhHASBz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Sun, 1 Aug 2021 14:01:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:58612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230146AbhHASBy (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 1 Aug 2021 14:01:54 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D86B160E76;
        Sun,  1 Aug 2021 18:01:43 +0000 (UTC)
Date:   Sun, 1 Aug 2021 19:04:22 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lucas Stankus <lucas.p.stankus@gmail.com>
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com, robh+dt@kernel.org,
        Dragos.Bogdan@analog.com, Darius.Berghe@analog.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: accel: Add binding documentation
 for ADXL313
Message-ID: <20210801190422.28fd5334@jic23-huawei>
In-Reply-To: <1e652b88a367824e58fb71896b4a660204bd7a88.1627709571.git.lucas.p.stankus@gmail.com>
References: <cover.1627709571.git.lucas.p.stankus@gmail.com>
        <1e652b88a367824e58fb71896b4a660204bd7a88.1627709571.git.lucas.p.stankus@gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 31 Jul 2021 17:36:31 -0300
Lucas Stankus <lucas.p.stankus@gmail.com> wrote:

> Add device tree binding documentation for ADXL313 3-axis accelerometer.
> 
> Signed-off-by: Lucas Stankus <lucas.p.stankus@gmail.com>

Hi Lucas, 

A few minor requests for additions inline, so we include everything
that is likely to be used by the driver in the longer term.

> ---
>  .../bindings/iio/accel/adi,adxl313.yaml       | 75 +++++++++++++++++++
>  1 file changed, 75 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/accel/adi,adxl313.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adxl313.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adxl313.yaml
> new file mode 100644
> index 000000000000..31f11d7eaaae
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/accel/adi,adxl313.yaml
> @@ -0,0 +1,75 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/accel/adi,adxl313.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices ADXL313 3-Axis Digital Accelerometer
> +
> +maintainers:
> +  - Lucas Stankus <lucas.p.stankus@gmail.com>
> +
> +description: |
> +  Analog Devices ADXL313 3-Axis Digital Accelerometer that supports
> +  both I2C & SPI interfaces.
> +    https://www.analog.com/en/products/adxl313.html
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,adxl313
> +
> +  reg:
> +    maxItems: 1
> +
> +  spi-3wire: true
> +
> +  spi-cpha: true
> +
> +  spi-cpol: true
> +
> +  spi-max-frequency: true
> +
> +  interrupts:
> +    maxItems: 2

As board designers have an annoying habit of wiring up the second
interrupt only, please also provide interrupt-names so we can
know which one is connected if it's only one.

From a quick glance at the datasheet, I see this also has two powersupplies.
Please include
vddio-supply
vs-supply - annoyingly the s just stands for supply, but v-supply seems a bit to minimal.

> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    i2c0 {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        /* Example for a I2C device node */
> +        accelerometer@53 {
> +            compatible = "adi,adxl313";
> +            reg = <0x53>;
> +            interrupt-parent = <&gpio0>;
> +            interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
> +        };
> +    };
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        /* Example for a SPI device node */
> +        accelerometer@0 {
> +            compatible = "adi,adxl313";
> +            reg = <0>;
> +            spi-max-frequency = <5000000>;
> +            spi-cpol;
> +            spi-cpha;
> +            interrupt-parent = <&gpio0>;
> +            interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
> +        };
> +    };

