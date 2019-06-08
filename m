Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6923A3A00F
	for <lists+linux-iio@lfdr.de>; Sat,  8 Jun 2019 15:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbfFHNxP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 8 Jun 2019 09:53:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:33108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726870AbfFHNxO (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 8 Jun 2019 09:53:14 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C80121530;
        Sat,  8 Jun 2019 13:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560001993;
        bh=nEhvEwBWpE3YstUx8jxKznP1VWozJV6Q0m/WXs8G/pA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=0gKtZYlbsd+CCA30scLCJEUZyUH3H5uEGKwBo/iAZPVH9fRa5fa+scZaaHp/zUcsy
         2HLlf2iwkHfgIUwxSnBvSyj72rGl54ee9tqXXSuqIBLzp7PTOC7jv9q7EH/5U7pE8W
         h++n5kyMVFZkRElwz2uqyCjm0DKbDvYDOTmWrV54=
Date:   Sat, 8 Jun 2019 14:53:07 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     "Popa, Stefan Serban" <StefanSerban.Popa@analog.com>,
        "lucasseikioshiro@gmail.com" <lucasseikioshiro@gmail.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "ardeleanalex@gmail.com" <ardeleanalex@gmail.com>,
        "marcelo.schmitt1@gmail.com" <marcelo.schmitt1@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "matheus.bernardino@usp.br" <matheus.bernardino@usp.br>,
        "rodrigorsdc@gmail.com" <rodrigorsdc@gmail.com>
Subject: Re: [PATCH v2] dt-bindings: iio: accel: adxl372: switch to YAML
 bindings
Message-ID: <20190608145307.39657ecb@archlinux>
In-Reply-To: <e30a3c629f0d355c5131420437c031a522caea01.camel@analog.com>
References: <20190531201114.2973-1-lucasseikioshiro@gmail.com>
        <e30a3c629f0d355c5131420437c031a522caea01.camel@analog.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 6 Jun 2019 08:49:53 +0000
"Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:

> On Fri, 2019-05-31 at 17:11 -0300, Lucas Oshiro wrote:
> > [External]
> > 
> > 
> > Convert the old device tree documentation to yaml format.
> > 
> > Signed-off-by: Lucas Oshiro <lucasseikioshiro@gmail.com>
> > Signed-off-by: Rodrigo Ribeiro <rodrigorsdc@gmail.com>
> > Co-developed-by: Rodrigo Ribeiro <rodrigorsdc@gmail.com>
> > Reviewed-by: Matheus Tavares <matheus.bernardino@usp.br>
> > Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>  
> 
> Reviewed-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
I agree, this looks good to me.

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

I'm not planning a pull request for a little while, so still time
for any comments from others to come in.

Thanks,

Jonathan

> 
> > ---
> > V2:
> >     - Update MAINTAINERS file
> >     - Remove description field for reg and interrupts properties
> >     - Add interrupts as a required property
> > 
> >  .../bindings/iio/accel/adi,adxl372.yaml       | 63 +++++++++++++++++++
> >  .../devicetree/bindings/iio/accel/adxl372.txt | 33 ----------
> >  MAINTAINERS                                   |  2 +-
> >  3 files changed, 64 insertions(+), 34 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/iio/accel/adi,adxl372.yaml
> >  delete mode 100644 Documentation/devicetree/bindings/iio/accel/adxl372.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adxl372.yaml
> > b/Documentation/devicetree/bindings/iio/accel/adi,adxl372.yaml
> > new file mode 100644
> > index 000000000000..a7fafb9bf5c6
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/accel/adi,adxl372.yaml
> > @@ -0,0 +1,63 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/accelerometers/adi,adxl372.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Analog Devices ADXL372 3-Axis, +/-(200g) Digital Accelerometer
> > +
> > +maintainers:
> > +  - Stefan Popa <stefan.popa@analog.com>
> > +
> > +description: |
> > +  Analog Devices ADXL372 3-Axis, +/-(200g) Digital Accelerometer that supports
> > +  both I2C & SPI interfaces
> > +    https://www.analog.com/en/products/adxl372.html
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - adi,adxl372
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +
> > +examples:
> > +  - |
> > +        #include <dt-bindings/gpio/gpio.h>
> > +        #include <dt-bindings/interrupt-controller/irq.h>
> > +        i2c0 {
> > +                #address-cells = <1>;
> > +                #size-cells = <0>;
> > +
> > +                /* Example for a I2C device node */
> > +                accelerometer@53 {
> > +                        compatible = "adi,adxl372";
> > +                        reg = <0x53>;
> > +                        interrupt-parent = <&gpio>;
> > +                        interrupts = <25 IRQ_TYPE_EDGE_FALLING>;
> > +                };
> > +        };
> > +  - |
> > +        #include <dt-bindings/gpio/gpio.h>
> > +        #include <dt-bindings/interrupt-controller/irq.h>
> > +        spi0 {
> > +                #address-cells = <1>;
> > +                #size-cells = <0>;
> > +
> > +                accelerometer@0 {
> > +                        compatible = "adi,adxl372";
> > +                        reg = <0>;
> > +                        spi-max-frequency = <1000000>;
> > +                        interrupt-parent = <&gpio>;
> > +                        interrupts = <25 IRQ_TYPE_EDGE_FALLING>;
> > +                };
> > +        };
> > diff --git a/Documentation/devicetree/bindings/iio/accel/adxl372.txt
> > b/Documentation/devicetree/bindings/iio/accel/adxl372.txt
> > deleted file mode 100644
> > index a289964756a7..000000000000
> > --- a/Documentation/devicetree/bindings/iio/accel/adxl372.txt
> > +++ /dev/null
> > @@ -1,33 +0,0 @@
> > -Analog Devices ADXL372 3-Axis, +/-(200g) Digital Accelerometer
> > -
> > -http://www.analog.com/media/en/technical-documentation/data-sheets/adxl372.pdf
> > -
> > -Required properties:
> > - - compatible : should be "adi,adxl372"
> > - - reg: the I2C address or SPI chip select number for the device
> > -
> > -Required properties for SPI bus usage:
> > - - spi-max-frequency: Max SPI frequency to use
> > -
> > -Optional properties:
> > - - interrupts: interrupt mapping for IRQ as documented in
> > -   Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
> > -
> > -Example for a I2C device node:
> > -
> > -       accelerometer@53 {
> > -               compatible = "adi,adxl372";
> > -               reg = <0x53>;
> > -               interrupt-parent = <&gpio>;
> > -               interrupts = <25 IRQ_TYPE_EDGE_FALLING>;
> > -       };
> > -
> > -Example for a SPI device node:
> > -
> > -       accelerometer@0 {
> > -               compatible = "adi,adxl372";
> > -               reg = <0>;
> > -               spi-max-frequency = <1000000>;
> > -               interrupt-parent = <&gpio>;
> > -               interrupts = <25 IRQ_TYPE_EDGE_FALLING>;
> > -       };
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 43a9cebb2c19..06cca7cd9627 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -559,7 +559,7 @@ S:  Supported
> >  F:     drivers/iio/accel/adxl372.c
> >  F:     drivers/iio/accel/adxl372_spi.c
> >  F:     drivers/iio/accel/adxl372_i2c.c
> > -F:     Documentation/devicetree/bindings/iio/accel/adxl372.txt
> > +F:     Documentation/devicetree/bindings/iio/accel/adi,adxl372.yaml
> > 
> >  AF9013 MEDIA DRIVER
> >  M:     Antti Palosaari <crope@iki.fi>
> > --
> > 2.21.0
> >   

