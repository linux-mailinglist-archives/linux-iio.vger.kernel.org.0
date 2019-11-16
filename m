Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8554BFECDF
	for <lists+linux-iio@lfdr.de>; Sat, 16 Nov 2019 16:22:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727735AbfKPPW4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 16 Nov 2019 10:22:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:54572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727646AbfKPPW4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 16 Nov 2019 10:22:56 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74E1A20700;
        Sat, 16 Nov 2019 15:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573917775;
        bh=jWnniCxtWs1Awb4m3wt7Ib2Si3DnLRCkXA/19wju3a0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Hj529MRIXWbYITy3lMsjxDcjJj/4xhnTjRN8HpvZPVqMXlt/pG7iHsQYA9UG3YGim
         IKdRfCuVFB4C3pu4ru+8uoveu3gDQpmgc3mk8RUvE5X0ZfV1yKuYVAbK1/diQUVbL3
         LnjSVTwaUFn9JCjVKrMhgzom+Ui1b15X832+8Zas=
Date:   Sat, 16 Nov 2019 15:22:49 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
        Dragos Bogdan <dragos.bogdan@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        devicetree@vger.kernel.org, kernel-usp@googlegroups.com
Subject: Re: [PATCH v4 1/2] dt-bindings: iio: adc: Add dt-schema for AD7292
Message-ID: <20191116152249.483e1eaf@archlinux>
In-Reply-To: <CAL_JsqJY6YMC2ba4DNFnsq=XESOoUTDA6Q+Y7gutMT0VN--DNw@mail.gmail.com>
References: <cover.1573145089.git.marcelo.schmitt1@gmail.com>
        <a8c614894252bb139a213b8c0219f3f46210b136.1573145089.git.marcelo.schmitt1@gmail.com>
        <20191112193942.GA27334@bogus>
        <20191113145159.vw7icflfve7dnefm@smtp.gmail.com>
        <CAL_JsqJY6YMC2ba4DNFnsq=XESOoUTDA6Q+Y7gutMT0VN--DNw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 13 Nov 2019 11:06:45 -0600
Rob Herring <robh@kernel.org> wrote:

> On Wed, Nov 13, 2019 at 8:52 AM Marcelo Schmitt
> <marcelo.schmitt1@gmail.com> wrote:
> >
> > Hi Rob,
> >
> > Thanks for reviewing the binding doc again.
> > Aparently, this patch was added to Greg KH's staging tree.
> > What is the right procedure in this case? Should I send a v5 patchset or
> > just send a patch for this doc?  
> 
> You need to do an incremental patch. Greg doesn't rebase.
Sorry. I jumped the gun a bit here.  Send me an incremental patch and
we'll get it queued up.  As it can be considered 'a license fix'
we can get it lined up for straight after the merge window.

Thanks,

Jonathan


> 
> > In any case, I still have some doubts about the maximum constraint of
> > the channel property. Comments inline.
> >
> >
> > Thanks
> >
> > Marcelo
> >
> > On 11/12, Rob Herring wrote:  
> > > On Fri, Nov 08, 2019 at 10:56:09AM -0300, Marcelo Schmitt wrote:  
> > > > Add a devicetree schema for AD7292 monitor and control system.
> > > >
> > > > Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> > > > ---
> > > > Changelog V3 -> V4:
> > > > - updated SPDX identifier to GPL-2.0-only
> > > > - changed maxitems constraint on channel property
> > > >
> > > >  .../bindings/iio/adc/adi,ad7292.yaml          | 104 ++++++++++++++++++
> > > >  MAINTAINERS                                   |   7 ++
> > > >  2 files changed, 111 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml
> > > > new file mode 100644
> > > > index 000000000000..b68be3aaf587
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml
> > > > @@ -0,0 +1,104 @@
> > > > +# SPDX-License-Identifier: GPL-2.0-only  
> > >
> > > Sigh, I gave you the exact line to use:
> > >
> > > # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > >
> > > I've said to dual license with (GPL-2.0-only OR BSD-2-Clause) and people
> > > think I mean to pick one. So now I just give the whole line. I don't
> > > know how to be clearer.  
> >
> > I thought I could use just GPL-2.0 since the driver code is GPL-2.0.
> > Anyway, I'll use the above line to specify the dt-binding license.
> >  
> > >  
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/iio/adc/adi,ad7292.yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: Analog Devices AD7292 10-Bit Monitor and Control System
> > > > +
> > > > +maintainers:
> > > > +  - Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> > > > +
> > > > +description: |
> > > > +  Analog Devices AD7292 10-Bit Monitor and Control System with ADC, DACs,
> > > > +  Temperature Sensor, and GPIOs
> > > > +
> > > > +  Specifications about the part can be found at:
> > > > +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7292.pdf
> > > > +
> > > > +properties:
> > > > +  compatible:
> > > > +    enum:
> > > > +      - adi,ad7292
> > > > +
> > > > +  reg:
> > > > +    maxItems: 1
> > > > +
> > > > +  vref-supply:
> > > > +    description: |
> > > > +      The regulator supply for ADC and DAC reference voltage.
> > > > +
> > > > +  spi-cpha: true
> > > > +
> > > > +  '#address-cells':
> > > > +    const: 1
> > > > +
> > > > +  '#size-cells':
> > > > +    const: 0
> > > > +
> > > > +required:
> > > > +  - compatible
> > > > +  - reg
> > > > +  - spi-cpha
> > > > +
> > > > +patternProperties:
> > > > +  "^channel@[0-7]$":
> > > > +    type: object
> > > > +    description: |
> > > > +      Represents the external channels which are connected to the ADC.
> > > > +      See Documentation/devicetree/bindings/iio/adc/adc.txt.
> > > > +
> > > > +    properties:
> > > > +      reg:
> > > > +        description: |
> > > > +          The channel number. It can have up to 8 channels numbered from 0 to 7.
> > > > +        items:
> > > > +          maximum: 7  
> > >
> > > Not what I said either. A slight but important difference in that you
> > > are missing a '-' to make 'items' a list rather than a schema/dict.
> > >
> > > Update dt-schema. This should give a warning now.  
> >
> > I'm confused, I don't know how to make this doc the way you want.
> > I pulled the updates from the master branch of dt-schema repo and
> > reinstalled it.
> > Then I tried
> >         items:
> >           - maximum: 7
> > I've tried
> >         - items:
> >             maximum: 7
> > I also tried
> >         - items:
> >           maximum: 7
> > all gave me parsing errors when processing the ad7292 schema with
> > 'make dt_binding_check' and also with 'make -k dt_binding_check'.
> > Am I using the right branch? Should I pull from a branch other than the
> > master?  
> 
> Sorry, my fault there. The meta-schema requires 'minimum' if you give
> 'maximum'. So:
> 
>         items:
>           - minimum: 0
>             maximum: 7
> 
> The error message was less than useful, but I think I have a fix for that too.
> 
> Rob

