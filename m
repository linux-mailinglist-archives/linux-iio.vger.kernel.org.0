Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED73ACC40
	for <lists+linux-iio@lfdr.de>; Sun,  8 Sep 2019 12:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728330AbfIHKwe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 8 Sep 2019 06:52:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:48378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728310AbfIHKwe (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 8 Sep 2019 06:52:34 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8897206BB;
        Sun,  8 Sep 2019 10:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567939952;
        bh=nSk+dg79VdbUQ4naEBFxS3SSqiViSa6cJTOoCuPqFyk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VaQbGPvuiox2ZtggKtLK+s7qOJB0c5CLKynfGeeyasnlTV9p+kV1fw7u2CwJb3n7N
         uTabPwHrel9xNfrunXbNeMXIqJBD2VgBsQaHSKEIL3nQVombqD8ibtvflJjJ5va1FS
         E6eTiM3sT3+CjfNh9iyBwGH8xp36tHEyZMMLDHGg=
Date:   Sun, 8 Sep 2019 11:52:27 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc:     Rodrigo Carvalho <rodrigorsdc@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        alexandru.ardelean@analog.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: Re: [PATCH 1/2] dt-bindings: iio: accel: add binding documentation
 for ADIS16240
Message-ID: <20190908115227.65046733@archlinux>
In-Reply-To: <20190902171417.qbj7rwi43tr77mr5@smtp.gmail.com>
References: <20190902005938.7734-1-rodrigorsdc@gmail.com>
        <20190902171417.qbj7rwi43tr77mr5@smtp.gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 2 Sep 2019 14:14:18 -0300
Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:

> Hi Rodrigo,
> 
> This dt doc looks overal fine IMHO.
> I would just add some inline comments about the cpha and cpol
> properties.
> 
> On 09/01, Rodrigo Carvalho wrote:
> > This patch add device tree binding documentation for ADIS16240.
> > 
> > Signed-off-by: Rodrigo Ribeiro Carvalho <rodrigorsdc@gmail.com>
> > ---
> > I have doubt about what maintainer I may to put in that documentation. I
> > put Alexandru as maintainer because he reviewed my last patch on this
> > driver, so I think that he is a good candidate.
> >  .../bindings/iio/accel/adi,adis16240.yaml     | 55 +++++++++++++++++++
> >  1 file changed, 55 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/accel/adi,adis16240.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adis16240.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adis16240.yaml
> > new file mode 100644
> > index 000000000000..08019b51611c
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/accel/adi,adis16240.yaml
> > @@ -0,0 +1,55 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/accel/adi,adis16240.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: ADIS16240 Programmable Impact Sensor and Recorder driver
> > +
> > +maintainers:
> > +  - Alexandru Ardelean <alexandru.ardelean@analog.com>
> > +
> > +description: |
> > +  ADIS16240 Programmable Impact Sensor and Recorder driver that supports
> > +  SPI interface.
> > +    https://www.analog.com/en/products/adis16240.html
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - adi,adis16240
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  spi-cpha: true
> > +
> > +  spi-cpol: true  
> Boolean properties don't require to be explicitly set. It would also be
> nice to add a description pointing to the spi-bus documentation. Like
> this:
> 
>   spi-cpha:
>     description: |
>       See Documentation/devicetree/bindings/spi/spi-bus.txt
>     maxItems: 1
> 
>   spi-cpol:
>     description: |
>       See Documentation/devicetree/bindings/spi/spi-bus.txt
>     maxItems: 1
> 
> As far as I know, spi-cpol and spi-cpha stand for SPI chip polarity and
> SPI chip phase respectively. By default, it is assumed that SPI
> input/output data is available at uprising clock edges, however, some
> chips may work with different configuration (taking input data and/or
> push it out in falling edges). I'm not 100% sure but, from what I've
> seen on IIO, cpol is set to invert the input/output logic (making IO be
> taken on falling edges) while cpha is usually set when MISO valid out
> data is available on SCLK falling edge. If anyone has more comments
> about this please, add them here, I'm curious about it. :)
> 

They may well be constant for a given device (some will cope with
several combinations).  So the binding should reflect if they 'must'
be set.

Adding the cross reference is indeed nice.

Jonathan

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
> > +    #include <dt-bindings/gpio/gpio.h>
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +    spi0 {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        /* Example for a SPI device node */
> > +        accelerometer@0 {
> > +            compatible = "adi,adis16240";
> > +            reg = <0>;
> > +            spi-max-frequency = <2500000>;
> > +            spi-cpol;
> > +            spi-cpha;
> > +            interrupt-parent = <&gpio0>;
> > +            interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
> > +        };
> > +    };
> > -- 
> > 2.23.0.rc1
> > 
> > -- 
> > You received this message because you are subscribed to the Google Groups "Kernel USP" group.
> > To unsubscribe from this group and stop receiving emails from it, send an email to kernel-usp+unsubscribe@googlegroups.com.
> > To view this discussion on the web visit https://groups.google.com/d/msgid/kernel-usp/20190902005938.7734-1-rodrigorsdc%40gmail.com.  

