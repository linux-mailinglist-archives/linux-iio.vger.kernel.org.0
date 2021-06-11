Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 405643A4897
	for <lists+linux-iio@lfdr.de>; Fri, 11 Jun 2021 20:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbhFKS0q (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 11 Jun 2021 14:26:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:46616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229753AbhFKS0q (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 11 Jun 2021 14:26:46 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20348613C6;
        Fri, 11 Jun 2021 18:24:44 +0000 (UTC)
Date:   Fri, 11 Jun 2021 19:26:39 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, Bastien Nocera <hadess@hadess.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v3 08/10] dt-bindings: iio: bma255: Allow multiple
 interrupts
Message-ID: <20210611192639.587838ea@jic23-huawei>
In-Reply-To: <YMOphuXSoODIVX06@gerhold.net>
References: <20210611080903.14384-1-stephan@gerhold.net>
        <20210611080903.14384-9-stephan@gerhold.net>
        <20210611185941.3487efc6@jic23-huawei>
        <YMOphuXSoODIVX06@gerhold.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 11 Jun 2021 20:21:05 +0200
Stephan Gerhold <stephan@gerhold.net> wrote:

> On Fri, Jun 11, 2021 at 06:59:41PM +0100, Jonathan Cameron wrote:
> > On Fri, 11 Jun 2021 10:09:01 +0200
> > Stephan Gerhold <stephan@gerhold.net> wrote:
> >   
> > > BMA253 has two interrupt pins (INT1 and INT2) that can be configured
> > > independently. At the moment the bmc150-accel driver does not make use
> > > of them but it might be able to in the future, so it's useful to already
> > > specify all available interrupts in the device tree.
> > > 
> > > Set maxItems: 2 for interrupts to allow specifying a second one.
> > > This is necessary as preparation to move the bosch,bma254 compatible
> > > from bosch,bma180.yaml to bosch,bma255.yaml since bma180 allows two
> > > interrupts, but BMA254 is better supported by the bmc150-accel driver.
> > > 
> > > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> > > Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> > > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > > Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> > > ---
> > >  .../devicetree/bindings/iio/accel/bosch,bma255.yaml        | 7 ++++++-
> > >  1 file changed, 6 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml b/Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml
> > > index 8afb0fe8ef5c..65b299a5619b 100644
> > > --- a/Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml
> > > +++ b/Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml
> > > @@ -32,7 +32,12 @@ properties:
> > >    vddio-supply: true
> > >  
> > >    interrupts:
> > > -    maxItems: 1
> > > +    minItems: 1
> > > +    maxItems: 2
> > > +    description: |
> > > +      The first interrupt listed must be the one connected to the INT1 pin,
> > > +      the second (optional) interrupt listed must be the one connected to the
> > > +      INT2 pin (if available).  
> > 
> > As this is a direct copy from the bma180 binding and we are moving devices
> > from one to the other, we need to support this as the default.
> > Longer term, from the bma253 datasheet, it look looks the two pins are equally
> > capable so if we get a board where only the int2 pin is connected then we will
> > need to use interrupt-names to distinguish the two (as we do in other drivers).
> >   
> 
> This kind of sounds like a strange board layout in general. But what's
> worse is that for some reason even Bosch thought this is a "good" idea
> so they released the BMC156 [1]. It works just like the BMC150 but has
> only a single interrupt pin. One would expect that would be INT1,
> but nope, it's INT2 of course. :-)
> 
> I have a device with BMC156 where this is the case, so I guess I need to
> make bmc150-accel use INT2 somehow (without specifying INT1). It might
> be easiest if we treat this the same way as the case that you mentioned,
> i.e. everyone with BMC156 would specify the interrupt-names explicitly
> to have a consistent meaning of the device tree.

That will really confuse people who think they just have one interrupt so
why do they need the name!  You'll have to special case that delight in
the driver.

> 
> [1]: https://www.mouser.de/datasheet/2/783/BST-BMC156-DS000-1509546.pdf
> 
> > Another thing to note is that we don't have to have separate binding docs just
> > because we have separate drivers. At somepoint we might want to consider just
> > fusing the two docs.
> >    
> 
> Good point! I might do that together with the BMC156 changes. :)

Great.  Best of all you can drop me as maintainer the combined binding ;)

Jonathan

> 
> Thanks!
> Stephan

