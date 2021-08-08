Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC0F3E3B26
	for <lists+linux-iio@lfdr.de>; Sun,  8 Aug 2021 17:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232137AbhHHPlR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 8 Aug 2021 11:41:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:55778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229923AbhHHPlR (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 8 Aug 2021 11:41:17 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37CFC60EB5;
        Sun,  8 Aug 2021 15:40:56 +0000 (UTC)
Date:   Sun, 8 Aug 2021 16:43:45 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Puranjay Mohan <puranjay12@gmail.com>
Cc:     Michael.Hennerich@analog.com, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        lars@metafoo.de, Dragos.Bogdan@analog.com,
        Darius.Berghe@analog.com, robh+dt@kernel.org
Subject: Re: [PATCH v8 1/3] dt-bindings: iio: accel: Add DT binding doc for
 ADXL355
Message-ID: <20210808164345.799b8568@jic23-huawei>
In-Reply-To: <20210808160628.7b031948@jic23-huawei>
References: <20210804140309.31468-1-puranjay12@gmail.com>
        <20210804140309.31468-2-puranjay12@gmail.com>
        <20210808160628.7b031948@jic23-huawei>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 8 Aug 2021 16:06:28 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Wed,  4 Aug 2021 19:33:07 +0530
> Puranjay Mohan <puranjay12@gmail.com> wrote:
> 
> > Add devicetree binding document for ADXL355, a 3-Axis MEMS Accelerometer.
> > 
> > Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>  
> 
> Looks good to me. I'll pick this up once Rob and anyone else interested
> has had time to take a look assuming they don't ask for any changes.
> 
> Thanks,
> 
> Jonathan
> 
> 
> > ---
> >  .../bindings/iio/accel/adi,adxl355.yaml       | 88 +++++++++++++++++++
> >  1 file changed, 88 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/accel/adi,adxl355.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adxl355.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adxl355.yaml
> > new file mode 100644
> > index 000000000..5da3fd5ad
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/accel/adi,adxl355.yaml
> > @@ -0,0 +1,88 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/accel/adi,adxl355.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Analog Devices ADXL355 3-Axis, Low noise MEMS Accelerometer
> > +
> > +maintainers:
> > +  - Puranjay Mohan <puranjay12@gmail.com>
> > +
> > +description: |
> > +  Analog Devices ADXL355 3-Axis, Low noise MEMS Accelerometer that supports
> > +  both I2C & SPI interfaces
> > +    https://www.analog.com/en/products/adxl355.html
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - adi,adxl355
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    minItems: 1
> > +    maxItems: 3
> > +    description: |
> > +      Type should be IRQ_TYPE_LEVEL_HIGH.
> > +      Three configurable interrupt lines exist.

I just noticed from the datasheet, that INT1 and INT2 have controllable
polarity on the device.  We should look to support that rather than
stating all 3 interrupts are LEVEL_HIGH.  For now, I'd just not
state the type here, or make that statement only for the dataready pin.

Once you enable these interrupts, you will want to handle the polarity setting
in a similar fashion to the bmi160.

It is a bit messy to combine the interrupt polarity at the interrupt controller
with that at the device, but that is how we've handled these in the past.

Jonathan

> > +
> > +  interrupt-names:
> > +    description: Specify which interrupt line is in use.
> > +    items:
> > +      enum:
> > +        - INT1
> > +        - INT2
> > +        - DRDY
> > +    minItems: 1
> > +    maxItems: 3
> > +
> > +  vdd-supply:
> > +    description: Regulator that provides power to the sensor
> > +
> > +  vddio-supply:
> > +    description: Regulator that provides power to the bus
> > +
> > +  spi-max-frequency: true
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +        #include <dt-bindings/gpio/gpio.h>
> > +        #include <dt-bindings/interrupt-controller/irq.h>
> > +        i2c {
> > +                #address-cells = <1>;
> > +                #size-cells = <0>;
> > +
> > +                /* Example for a I2C device node */
> > +                accelerometer@1d {
> > +                        compatible = "adi,adxl355";
> > +                        reg = <0x1d>;
> > +                        interrupt-parent = <&gpio>;
> > +                        interrupts = <25 IRQ_TYPE_EDGE_RISING>;
> > +                        interrupt-names = "DRDY";
> > +                };
> > +        };
> > +  - |
> > +        #include <dt-bindings/gpio/gpio.h>
> > +        #include <dt-bindings/interrupt-controller/irq.h>
> > +        spi {
> > +                #address-cells = <1>;
> > +                #size-cells = <0>;
> > +
> > +                accelerometer@0 {
> > +                        compatible = "adi,adxl355";
> > +                        reg = <0>;
> > +                        spi-max-frequency = <1000000>;
> > +                        interrupt-parent = <&gpio>;
> > +                        interrupts = <25 IRQ_TYPE_EDGE_RISING>;
> > +                        interrupt-names = "DRDY";
> > +                };
> > +        };  
> 

