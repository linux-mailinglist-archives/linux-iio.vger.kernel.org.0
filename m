Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 421BF1541D4
	for <lists+linux-iio@lfdr.de>; Thu,  6 Feb 2020 11:26:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728279AbgBFK0U (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 6 Feb 2020 05:26:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:42738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728394AbgBFK0U (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 6 Feb 2020 05:26:20 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A94D206CC;
        Thu,  6 Feb 2020 10:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580984779;
        bh=0JgSe6SPXxtiGzuqSpPoTEMWToGrknUcN1/s8u6Vf+M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MYc2c6ZZyJ8vOUJLwASgkPxI64n+PKHyG9kUruxfxfOcaXwKN20gVAa1F11rD/1xy
         G1lY/SCl3pbS7xjd6cl5kCtzFLQlYb3Gnci0FlILhLL5dCrwmJ2ac/BY+pS2YCxybZ
         zmLza8wlOPi9pRe8vIoNSVZmTvbr+VabbcbR7fR8=
Date:   Thu, 6 Feb 2020 10:26:14 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     "Bia, Beniamin" <Beniamin.Bia@analog.com>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "biabeniamin@outlook.com" <biabeniamin@outlook.com>
Subject: Re: [PATCH v4 4/5] dt-bindings: iio: amplifiers: Add docs for
 HMC425A Step Attenuator
Message-ID: <20200206102614.64593f10@archlinux>
In-Reply-To: <17fefa85f2c441549bc07e08fb13994b10854fbf.camel@analog.com>
References: <20200129142301.13918-1-beniamin.bia@analog.com>
        <20200129142301.13918-5-beniamin.bia@analog.com>
        <20200202105358.27b6b8a6@archlinux>
        <17fefa85f2c441549bc07e08fb13994b10854fbf.camel@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 3 Feb 2020 11:25:48 +0000
"Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:

> On Sun, 2020-02-02 at 10:53 +0000, Jonathan Cameron wrote:
> > On Wed, 29 Jan 2020 16:23:00 +0200
> > Beniamin Bia <beniamin.bia@analog.com> wrote:
> >   
> > > From: Michael Hennerich <michael.hennerich@analog.com>
> > > 
> > > Document support for Analog Devices MC425A Step Attenuator.
> > > 
> > > Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> > > Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
> > > ---
> > >  .../bindings/iio/amplifiers/adi,hmc425a.yaml  | 48 +++++++++++++++++++
> > >  1 file changed, 48 insertions(+)
> > >  create mode 100644
> > > Documentation/devicetree/bindings/iio/amplifiers/adi,hmc425a.yaml
> > > 
> > > diff --git
> > > a/Documentation/devicetree/bindings/iio/amplifiers/adi,hmc425a.yaml
> > > b/Documentation/devicetree/bindings/iio/amplifiers/adi,hmc425a.yaml
> > > new file mode 100644
> > > index 000000000000..d800639c14a5
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/iio/amplifiers/adi,hmc425a.yaml
> > > @@ -0,0 +1,48 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/iio/amplifiers/adi,hmc425a.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: HMC425A 6-bit Digital Step Attenuator
> > > +
> > > +maintainers:
> > > +- Michael Hennerich <michael.hennerich@analog.com>
> > > +- Beniamin Bia <beniamin.bia@analog.com>
> > > +
> > > +description: |
> > > +  Digital Step Attenuator IIO device with gpio interface.
> > > +  HMC425A 0.5 dB LSB GaAs MMIC 6-BIT DIGITAL POSITIVE CONTROL ATTENUATOR,
> > > 2.2 - 8.0 GHz
> > > +  
> > > https://www.analog.com/media/en/technical-documentation/data-sheets/hmc425A.pdf
> > > +
> > > +properties:
> > > +  compatible:
> > > +    enum:
> > > +      - adi,hmc425a
> > > +
> > > +  vcc-supply: true
> > > +
> > > +  ctrl-gpios:
> > > +    description:
> > > +      Must contain an array of 6 GPIO specifiers, referring to the GPIO
> > > pins
> > > +      connected to the control pins V1-V6.
> > > +    maxItems: 6  
> > 
> > Does this force exactly 6?  
> 
> I'm [also] a bit unsure whether to force this number in DT.
> One idea [with this driver] would be to maybe have it support multiple of these
> GPIO-controlled attenuators/amplifiers. And those could have a higher/lower
> number of GPIOs.
> 
> In any case, we could enforce this as-is [for now], and see later when/if adding
> new parts.
> No strong opinion from my side about this though.
It should be enforced for each of the devices supported.
So for devices with less, it would only allow precisely that
lesser number.

One slight quirk is someone crazy might wire certain pins to high or low
because they don't need the precision.

Not sure how we handle that one but can deal with it when it happens.

Jonathan

> 
> >   
> > > +
> > > +required:
> > > +  - compatible
> > > +  - ctrl-gpios
> > > +
> > > +examples:
> > > +  - |
> > > +    #include <dt-bindings/gpio/gpio.h>
> > > +    gpio_hmc425a: hmc425a {
> > > +      compatible = "adi,hmc425a";
> > > +      ctrl-gpios = <&gpio 40 GPIO_ACTIVE_HIGH>,
> > > +        <&gpio 39 GPIO_ACTIVE_HIGH>,
> > > +        <&gpio 38 GPIO_ACTIVE_HIGH>,
> > > +        <&gpio 37 GPIO_ACTIVE_HIGH>,
> > > +        <&gpio 36 GPIO_ACTIVE_HIGH>,
> > > +        <&gpio 35 GPIO_ACTIVE_HIGH>;
> > > +      vcc-supply = <&foo>;
> > > +    };
> > > +...  

