Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA19B3DC67E
	for <lists+linux-iio@lfdr.de>; Sat, 31 Jul 2021 17:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233227AbhGaPFd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 31 Jul 2021 11:05:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:49924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233192AbhGaPFc (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 31 Jul 2021 11:05:32 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D02C60F56;
        Sat, 31 Jul 2021 15:05:22 +0000 (UTC)
Date:   Sat, 31 Jul 2021 16:08:02 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Puranjay Mohan <puranjay12@gmail.com>
Cc:     Michael.Hennerich@analog.com, alexandru.ardelean@analog.com,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, lars@metafoo.de,
        Dragos.Bogdan@analog.com, Darius.Berghe@analog.com
Subject: Re: [PATCH v6 1/2] dt-bindings: iio: accel: Add DT binding doc for
 ADXL355
Message-ID: <20210731160802.6bcad833@jic23-huawei>
In-Reply-To: <20210728063430.258199-2-puranjay12@gmail.com>
References: <20210728063430.258199-1-puranjay12@gmail.com>
        <20210728063430.258199-2-puranjay12@gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 28 Jul 2021 12:04:29 +0530
Puranjay Mohan <puranjay12@gmail.com> wrote:

> Add devicetree binding document for ADXL355, a 3-Axis MEMS Accelerometer.
> 
> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
Hi Puranjay,

Biggest comment in here is we should look to make the interrupt description
more flexible. Board designers have an annoying habit of only wiring some
of the interrupts and not always the ones we would expect.

Jonathan

> ---
>  .../bindings/iio/accel/adi,adxl355.yaml       | 76 +++++++++++++++++++
>  1 file changed, 76 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/accel/adi,adxl355.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adxl355.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adxl355.yaml
> new file mode 100644
> index 000000000..6e0652ce8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/accel/adi,adxl355.yaml
> @@ -0,0 +1,76 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/accel/adi,adxl355.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices ADXL355 3-Axis, Low noise MEMS Accelerometer
> +
> +maintainers:
> +  - Puranjay Mohan <puranjay12@gmail.com>
> +
> +description: |
> +  Analog Devices ADXL355 3-Axis, Low noise MEMS Accelerometer that supports
> +  both I2C & SPI interfaces
> +    https://www.analog.com/en/products/adxl355.html
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,adxl355
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    minItems: 1
> +    items:
> +      - description: DRDY PIN
> +      - description: INT1 PIN
> +      - description: INT2 PIN

Given there are 3 interrupts, and the device can work fine with only a subset
actually wired up, the interrupt-names property should be used to allow
the driver to figure out which ones are specified and we should allow
any combination.
 
> +
> +  vdd-supply:
> +    description: Regulator that provides power to the sensor
> +
> +  vddio-supply:
> +    description: Regulator that provides power to the bus
> +
> +  spi-max-frequency: true
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +        #include <dt-bindings/gpio/gpio.h>
> +        #include <dt-bindings/interrupt-controller/irq.h>
> +        i2c0 {
drop the 0 so just
           i2c {

What we are doing is indicating it's an i2c bus but we don't care what i2c
bus as that's not the bit we are describing in this binding.

> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +
> +                /* Example for a I2C device node */
> +                accelerometer@1d {
> +                        compatible = "adi,adxl355";
> +                        reg = <0x1d>;
> +                        interrupt-parent = <&gpio>;
> +                        interrupts = <25 IRQ_TYPE_EDGE_RISING>;
> +                };
> +        };
> +  - |
> +        #include <dt-bindings/gpio/gpio.h>
> +        #include <dt-bindings/interrupt-controller/irq.h>
> +        spi0 {

           spi {

should be fine.

> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +
> +                accelerometer@0 {
> +                        compatible = "adi,adxl355";
> +                        reg = <0>;
> +                        spi-max-frequency = <1000000>;
> +                        interrupt-parent = <&gpio>;
> +                        interrupts = <25 IRQ_TYPE_EDGE_RISING>;
> +                };
> +        };

