Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 082054190A9
	for <lists+linux-iio@lfdr.de>; Mon, 27 Sep 2021 10:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233382AbhI0IVA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Mon, 27 Sep 2021 04:21:00 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:52465 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233337AbhI0IVA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 27 Sep 2021 04:21:00 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id C4D80FF805;
        Mon, 27 Sep 2021 08:19:07 +0000 (UTC)
Date:   Mon, 27 Sep 2021 10:18:54 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        bcousson@baylibre.com, Tony Lindgren <tony@atomide.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-omap@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Ryan Barnett <ryan.barnett@collins.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Jason Reeder <jreeder@ti.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v3 36/47] mfd: ti_am335x_tscadc: Support the correctly
 spelled DT property
Message-ID: <20210927101854.5df3ac6f@xps13>
In-Reply-To: <YVF8PDl54lpUc+6S@google.com>
References: <20210915155908.476767-1-miquel.raynal@bootlin.com>
        <20210915155908.476767-37-miquel.raynal@bootlin.com>
        <YUtSVo9HBAiomswv@google.com>
        <20210923101922.2c108d2b@xps13>
        <YUxEsfOvn7Vr8F2c@google.com>
        <20210923113312.14fc9027@xps13>
        <YVF8PDl54lpUc+6S@google.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Lee,

lee.jones@linaro.org wrote on Mon, 27 Sep 2021 09:09:32 +0100:

> On Thu, 23 Sep 2021, Miquel Raynal wrote:
> 
> > Hi Lee,
> > 
> > lee.jones@linaro.org wrote on Thu, 23 Sep 2021 10:11:13 +0100:
> >   
> > > On Thu, 23 Sep 2021, Miquel Raynal wrote:
> > >   
> > > > Hi Lee,
> > > > 
> > > > lee.jones@linaro.org wrote on Wed, 22 Sep 2021 16:57:10 +0100:
> > > >     
> > > > > On Wed, 15 Sep 2021, Miquel Raynal wrote:
> > > > >     
> > > > > > There was in the past a typo in the coordinate readouts property. The
> > > > > > bindings have been updated, the touchscreen driver as well and now
> > > > > > supports both. However, the MFD driver that is in charge of verifying
> > > > > > the validity of the property only checks the bogus one. Add support for
> > > > > > the correctly spelled DT property.
> > > > > > 
> > > > > > Fixes: c9aeb249bf72 ("Input: ti_am335x_tsc - fix spelling mistake in TSC/ADC DT binding")
> > > > > > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > > > > > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > > > > ---
> > > > > >  drivers/mfd/ti_am335x_tscadc.c | 8 +++++++-
> > > > > >  1 file changed, 7 insertions(+), 1 deletion(-)
> > > > > > 
> > > > > > diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
> > > > > > index 155a8ed879b3..aa46ed669016 100644
> > > > > > --- a/drivers/mfd/ti_am335x_tscadc.c
> > > > > > +++ b/drivers/mfd/ti_am335x_tscadc.c
> > > > > > @@ -144,8 +144,14 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
> > > > > >  	if (tscadc->data->has_tsc) {
> > > > > >  		node = of_get_child_by_name(pdev->dev.of_node, "tsc");
> > > > > >  		of_property_read_u32(node, "ti,wires", &tscmag_wires);
> > > > > > -		of_property_read_u32(node, "ti,coordiante-readouts", &readouts);
> > > > > > +		err = of_property_read_u32(node, "ti,coordinate-readouts",
> > > > > > +					   &readouts);
> > > > > > +		if (err < 0)
> > > > > > +			of_property_read_u32(node, "ti,coordiante-readouts",
> > > > > > +					     &readouts);
> > > > > > +      
> > > > > 
> > > > > How long are you proposing that we support this churn?    
> > > > 
> > > > Well, I am not proposing anything, I am just "fixing" the driver so
> > > > that it fits the bindings :) Given the fact that at the end of this
> > > > series there is a patch that changes the "coordiante" typo to
> > > > "coordinate" in a device tree source file, I believe it is still too
> > > > soon...    
> > > 
> > > If this is something you're changing in this set, please reconsider.
> > > 
> > > I'd rather have a slightly misspelled documented property than being
> > > forced to support 2 for any length of time.  
> > 
> > I am not suggesting anything here:
> > - "coordiante" was introduced back in 2014.
> > - "coordinate" was introduced shortly later.
> > - "coordiante" was considered part of the "stable API" back in 2014 and
> >   even though the right spelling got introduced very shortly after, DT
> >   stability rules wanted us to support it forever.
> > - The touchscreen driver has immediately be fixed to support both but
> >   not the MFD driver, and this does not make any sense!
> > 
> > We *should* either support only one property (1) or support both in the
> > two drivers (2), but supporting the two in one driver and supporting
> > only one in the other one does not make any sense (given the fact that
> > these two drives are tied together, the touchscreen driver does not
> > exist without the MFD driver). That is what I am fixing here.
> > 
> > Is #1 valid? Theoretically it's the best scenario. In practice it is
> > not (yet) possible because the two versions are still used in the
> > mainline device trees:
> > $ git grep coordiante-readouts -- arch/arm/boot/dts/ | wc -l
> > 1
> > $ git grep coordinate-readouts -- arch/arm/boot/dts/ | wc -l
> > 5
> > 
> > So in this series I am fixing the MFD driver to be sure it handles
> > correctly the correctly spelled DT property which is used by 5 boards
> > since at least 6 years and I am also updating the remaining DT to use
> > the correctly spelled property as well.
> > 
> > I suppose we could propose to drop support for the "coordiante"
> > version of that property in a few years but if we decide to do it right
> > now we're definitely gonna break users.  
> 
> It's a shame that the misspelled one is still in use.  If they were
> all changed over at the start, there would be a strong case for
> dropping support for it.

It is, clearly. I believe all DT got changed in one go, but a
contributor at the same time proposed a new DT with the legacy
property "copy-pasted" from the "existing" device trees and this went
off the radar...

Anyway, I'll send a v4 soon with all your suggestions taken into
account.

Thanks,
Miquèl
