Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDBC818E99B
	for <lists+linux-iio@lfdr.de>; Sun, 22 Mar 2020 16:25:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbgCVPZN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 22 Mar 2020 11:25:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:50398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726781AbgCVPZN (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 22 Mar 2020 11:25:13 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC94C20724;
        Sun, 22 Mar 2020 15:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584890712;
        bh=JZp55Nw+wITCkEZ9siLzNKu9nL9D8WMb+sQ+QrKCduY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=i5AXElvrH2NIVtVaBzcdy1vrYrh3Fg99kWPVLv+nZ6nt+zSdtehLbk/wouZbmQxKb
         +Cnf/wDxk59cSK9y6MUZXO1kzAWwpPzCLJCQU5dL+y2TdLVZAAJna8XAoVbgeklOw0
         kP7Sn8TsmJQ+ubnt71q2QidXPZmhMcEI38dChhgM=
Date:   Sun, 22 Mar 2020 15:25:07 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     "alazar@startmail.com" <alazar@startmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "lars@metafoo.de" <lars@metafoo.de>
Subject: Re: [PATCH v4 1/2] dt-bindings: iio: adc: Add MAX1241 device tree
 bindings in documentation
Message-ID: <20200322152507.6e66f1b1@archlinux>
In-Reply-To: <1e51c4079222858410e9fe94c9d7f21d99abfe15.camel@analog.com>
References: <20200320150114.9297-1-alazar@startmail.com>
        <20200320150114.9297-2-alazar@startmail.com>
        <20200321173412.52548ef1@archlinux>
        <20200321193541.GA16892@leena.republic>
        <1e51c4079222858410e9fe94c9d7f21d99abfe15.camel@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 22 Mar 2020 09:02:15 +0000
"Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:

> On Sat, 2020-03-21 at 21:35 +0200, Alexandru Lazar wrote:
> > Hi Jonathan,
> >   
> > > Please consider also adding the vdd-supply.
> > > It's not really required, but if you don't add it from the start
> > > chances are high that at some point someone else will need to
> > > add it.  
> > 
> > Sorry if I'm missing something obvious here -- what vdd-supply is
> > that? Are you thinking of the regulator used for the ADC's reference
> > voltage? That's already there (vref-supply).
> > 
> > Or did you mean I should add a definition for the regulator output used
> > for the device's Vdd input (i.e. the positive supply voltage)? Needless
> > to say, I'm happy to add it if you think it's a good idea. It's just I
> > don't think I've seen it in other drivers (except maybe ad7192?) -- so I
> > figured I'd ask before sending a botched v5.
> >   
> 
> Yep.
> Jonathan refers to Vdd input/pin [on the chip] which is different from Vref [REF
> pin].
> Not all drivers define Vdd.
> Some call it AVdd.
> 
> You can check via:  git grep -i vdd | cut -d: -f1 | sort | uniq -c
> in the drivers/iio folder 
> 
> It's an idea to add it, and that can give control to the driver to power-up the
> ADC, by defining a regulator [vdd-supply] in the device-tree.
> 
> Maybe it could be interesting to move this to the IIO core as an option-flag.
> [But that's another discussion]

Can't easily move it to the core because how you actually handle it is very
much driver dependent.  A devices that has state will keep it on most of
the time, but other drivers will handle it in runtime pm if the device
starts up quickly enough.

We want this to be visible in individual drivers, even if it would be
less code perhaps in the core.

Jonathan

> 
> > Best regards,
> > Alex
> >   
> > > One trivial thing inline.  Otherwise looks good to me.
> > >   
> > > > ---
> > > >  .../bindings/iio/adc/maxim,max1241.yaml       | 61 +++++++++++++++++++
> > > >  1 file changed, 61 insertions(+)
> > > >  create mode 100644
> > > > Documentation/devicetree/bindings/iio/adc/maxim,max1241.yaml
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/iio/adc/maxim,max1241.yaml
> > > > b/Documentation/devicetree/bindings/iio/adc/maxim,max1241.yaml
> > > > new file mode 100644
> > > > index 000000000000..de41d422ce3b
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/iio/adc/maxim,max1241.yaml
> > > > @@ -0,0 +1,61 @@
> > > > +# SPDX-License-Identifier: GPL-2.0
> > > > +# Copyright 2020 Ioan-Alexandru Lazar
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/iio/adc/maxim,max1241.yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: Maxim MAX1241 12-bit, single-channel analog to digital converter
> > > > +
> > > > +maintainers:
> > > > +  - Ioan-Alexandru Lazar <alazar@startmail.com>
> > > > +
> > > > +description: |
> > > > +  Bindings for the max1241 12-bit, single-channel ADC device. This
> > > > +  driver supports voltage reading and can optionally be configured for  
> > > 
> > > Driver shouldn't be mentioned in the binding. It's a description of the
> > > hardware only.
> > >   
> > > > +  power-down mode operation. The datasheet can be found at:
> > > > +    https://datasheets.maximintegrated.com/en/ds/MAX1240-MAX1241.pdf
> > > > +
> > > > +properties:
> > > > +  compatible:
> > > > +    enum:
> > > > +      - maxim,max1241
> > > > +
> > > > +  reg:
> > > > +    maxItems: 1
> > > > +
> > > > +  vref-supply:
> > > > +    description:
> > > > +      Device tree identifier of the regulator that provides the external
> > > > +      reference voltage.
> > > > +    maxItems: 1
> > > > +
> > > > +  shdn-gpios:
> > > > +    description:
> > > > +      GPIO spec for the GPIO pin connected to the ADC's /SHDN pin. If
> > > > +      specified, the /SHDN pin will be asserted between conversions,
> > > > +      thus enabling power-down mode.
> > > > +    maxItems: 1
> > > > +
> > > > +required:
> > > > +  - compatible
> > > > +  - reg
> > > > +  - vref-supply
> > > > +
> > > > +examples:
> > > > +  - |
> > > > +    #include <dt-bindings/gpio/gpio.h>
> > > > +    spi0 {
> > > > +      #address-cells = <1>;
> > > > +      #size-cells = <0>;
> > > > +
> > > > +        adc@0 {
> > > > +            compatible = "maxim,max1241";
> > > > +            reg = <0>;
> > > > +            vref-supply = <&vdd_3v3_reg>;
> > > > +            spi-max-frequency = <1000000>;
> > > > +            shdn-gpios = <&gpio 26 1>;
> > > > +        };
> > > > +    };
> > > > +
> > > > +  

