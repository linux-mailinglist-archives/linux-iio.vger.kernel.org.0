Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3B443E3ADB
	for <lists+linux-iio@lfdr.de>; Sun,  8 Aug 2021 16:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbhHHOnO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 8 Aug 2021 10:43:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:44910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229923AbhHHOnN (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 8 Aug 2021 10:43:13 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7ED1760F0F;
        Sun,  8 Aug 2021 14:42:52 +0000 (UTC)
Date:   Sun, 8 Aug 2021 15:45:41 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lucas Stankus <lucas.p.stankus@gmail.com>
Cc:     Rob Herring <robh@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "Bogdan, Dragos" <Dragos.Bogdan@analog.com>,
        "Berghe, Darius" <Darius.Berghe@analog.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: accel: Add binding
 documentation for ADXL313
Message-ID: <20210808154541.276e6685@jic23-huawei>
In-Reply-To: <CACKVXZB-XVYA8FSEucwktH88PBUUBXXjuARWOC02r8TzCzU8Mw@mail.gmail.com>
References: <cover.1628143857.git.lucas.p.stankus@gmail.com>
        <ad64c93df8c43c66dcb64fe8ec0c0f6b91b3c697.1628143857.git.lucas.p.stankus@gmail.com>
        <YQ16+AlpmxhVIBhE@robh.at.kernel.org>
        <CACKVXZB-XVYA8FSEucwktH88PBUUBXXjuARWOC02r8TzCzU8Mw@mail.gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 6 Aug 2021 21:33:44 -0300
Lucas Stankus <lucas.p.stankus@gmail.com> wrote:

> On Fri, Aug 6, 2021 at 3:10 PM Rob Herring <robh@kernel.org> wrote:
> >
> > On Thu, Aug 05, 2021 at 03:29:37AM -0300, Lucas Stankus wrote:  
> > > Add device tree binding documentation for ADXL313 3-axis accelerometer.
> > >
> > > Signed-off-by: Lucas Stankus <lucas.p.stankus@gmail.com>
> > > ---
> > >  .../bindings/iio/accel/adi,adxl313.yaml       | 90 +++++++++++++++++++
> > >  1 file changed, 90 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/iio/accel/adi,adxl313.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adxl313.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adxl313.yaml
> > > new file mode 100644
> > > index 000000000000..fea03b6790f3
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/iio/accel/adi,adxl313.yaml
> > > @@ -0,0 +1,90 @@
> > > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/iio/accel/adi,adxl313.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Analog Devices ADXL313 3-Axis Digital Accelerometer
> > > +
> > > +maintainers:
> > > +  - Lucas Stankus <lucas.p.stankus@gmail.com>
> > > +
> > > +description: |
> > > +  Analog Devices ADXL313 3-Axis Digital Accelerometer that supports
> > > +  both I2C & SPI interfaces.
> > > +    https://www.analog.com/en/products/adxl313.html
> > > +
> > > +properties:
> > > +  compatible:
> > > +    enum:
> > > +      - adi,adxl313
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  spi-3wire: true
> > > +
> > > +  spi-cpha: true
> > > +
> > > +  spi-cpol: true  
> >
> > These 3 generally shouldn't be needed, but can be set from the driver.
> > If they are valid, is any combination of them really valid?
> >  
> 
> Only the 3wire is optional, both cpha and cpol are required for proper
> spi connection.

We've been round this one a few time, and last time we discussed the
cases where you'd need these in DT (because of inverters on the bus)
https://lore.kernel.org/linux-iio/20191204111231.GO1998@sirena.org.uk/
conclusion was, that we don't want to put the burden on the dt files
for those odd cases.  The equivalent for interrupt lines is interestingly
different because in those cases the two-cell version includes the
type of interrupt, so it makes little sense to push that down into the
drivers as well.

Mind you I'm not 100% sure how we would retrofit a binding if necessary
for the inverted cases.  Hope we don't hit one here :)

As you note, 3wire is needed in the binding because it's optional.

Jonathan


> 
> > > +
> > > +  spi-max-frequency: true
> > > +
> > > +  vs-supply:
> > > +    description: Regulator that supplies power to the accelerometer
> > > +
> > > +  vdd-supply:
> > > +    description: Regulator that supplies the digital interface supply voltage
> > > +
> > > +  interrupts:
> > > +    maxItems: 2  
> >
> > This means there must be 2 entries. If 1 is valid, you need 'minItems'.
> >  
> 
> I'll add 'minItems' for the v3 then, thanks!
> 
> > > +
> > > +  interrupt-names:
> > > +    maxItems: 2  
> >
> > You need 'minItems' too to fix the error.
> >  
> 
> Thank you again and sorry for not catching that error before submitting.
> 
> > > +    items:
> > > +      enum:
> > > +        - INT1
> > > +        - INT2
> > > +
> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +
> > > +additionalProperties: false
> > > +
> > > +examples:
> > > +  - |
> > > +    #include <dt-bindings/gpio/gpio.h>
> > > +    #include <dt-bindings/interrupt-controller/irq.h>
> > > +    i2c0 {
> > > +        #address-cells = <1>;
> > > +        #size-cells = <0>;
> > > +
> > > +        /* Example for a I2C device node */
> > > +        accelerometer@53 {
> > > +            compatible = "adi,adxl313";
> > > +            reg = <0x53>;
> > > +            interrupt-parent = <&gpio0>;
> > > +            interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
> > > +            interrupt-names = "INT1";
> > > +        };
> > > +    };
> > > +  - |
> > > +    #include <dt-bindings/gpio/gpio.h>
> > > +    #include <dt-bindings/interrupt-controller/irq.h>
> > > +    spi {
> > > +        #address-cells = <1>;
> > > +        #size-cells = <0>;
> > > +
> > > +        /* Example for a SPI device node */
> > > +        accelerometer@0 {
> > > +            compatible = "adi,adxl313";
> > > +            reg = <0>;
> > > +            spi-max-frequency = <5000000>;
> > > +            spi-cpol;
> > > +            spi-cpha;
> > > +            interrupt-parent = <&gpio0>;
> > > +            interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
> > > +            interrupt-names = "INT1";
> > > +        };
> > > +    };
> > > --
> > > 2.32.0
> > >
> > >  

