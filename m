Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C86A5F5F32
	for <lists+linux-iio@lfdr.de>; Sat,  9 Nov 2019 13:56:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbfKIM4h (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 9 Nov 2019 07:56:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:46772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726267AbfKIM4g (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 9 Nov 2019 07:56:36 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A9B321848;
        Sat,  9 Nov 2019 12:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573304195;
        bh=ruOl9OKhH8I+jv/Zqo/kN3RszLAM0zMoLnCEwtHAnoM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mKxw6pj/wW4yKKVBwgAU5QBYv3LPXWzIBZ2e0t7RS7q1CKQ674TMte/wZ2MJLvSKz
         fSo7zy+1/xOlqHiSNSOI2jxHrgAOvlHaC5FOriOn/9NoNEBOkvRl0IR+qTL4mBV0rm
         d+oXOBNY+aNwPh6zbT4WZeDmxa65CQsBfswtekj4=
Date:   Sat, 9 Nov 2019 12:56:29 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Rodrigo Carvalho <rodrigorsdc@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        kernel-usp@googlegroups.com
Subject: Re: [PATCH v3] dt-bindings: iio: accel: add binding documentation
 for ADIS16240
Message-ID: <20191109125629.71b8d3e6@archlinux>
In-Reply-To: <20191105201932.GA24515@bogus>
References: <20191101000301.12901-1-rodrigorsdc@gmail.com>
        <20191105201932.GA24515@bogus>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 5 Nov 2019 14:19:32 -0600
Rob Herring <robh@kernel.org> wrote:

> On Thu, Oct 31, 2019 at 09:03:01PM -0300, Rodrigo Carvalho wrote:
> > This patch add device tree binding documentation for ADIS16240.
> > 
> > Signed-off-by: Rodrigo Ribeiro Carvalho <rodrigorsdc@gmail.com>
> > ---
> > V3:
> >    - Remove spi-cpol and spi-cpha field. They don't seem necessary  
> 
> Not necessary to document or use? The latter requires the former.
> 
> If your device only supports one timing mode, then you don't need them 
> because it should be implied and the driver can just tell the SPI 
> subsystem what mode it requires. If the device can support multiple 
> timing modes, then you should document that you are using the 
> properties.
The diagram in the datasheet is less than clear and the driver doesn't
currently enforce anything.

Looks like clock is high when in active and fall so CPOL, as per
SPI docs though this might not matter...

Sampling on rising edge (that's the bit that is unclear) so CPHA,
but the timing is such that you can probably get away with not
setting that.

As Rob said, makes sense for driver to enforce the documented correct
mode and not have anything in the binding.  We should probably audit
all drivers for this at somepoint and drop the binding requirements
for ones that have only one supported mode.

Jonathan 
> 
> >  .../bindings/iio/accel/adi,adis16240.yaml     | 51 +++++++++++++++++++
> >  1 file changed, 51 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/accel/adi,adis16240.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adis16240.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adis16240.yaml
> > new file mode 100644
> > index 000000000000..9a4cd12c4818
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/accel/adi,adis16240.yaml
> > @@ -0,0 +1,51 @@
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
> > 2.23.0
> >   

