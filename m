Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCB094159F5
	for <lists+linux-iio@lfdr.de>; Thu, 23 Sep 2021 10:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239807AbhIWIU6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Thu, 23 Sep 2021 04:20:58 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:50389 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237996AbhIWIU5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 23 Sep 2021 04:20:57 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 1D09FE0007;
        Thu, 23 Sep 2021 08:19:22 +0000 (UTC)
Date:   Thu, 23 Sep 2021 10:19:22 +0200
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
Message-ID: <20210923101922.2c108d2b@xps13>
In-Reply-To: <YUtSVo9HBAiomswv@google.com>
References: <20210915155908.476767-1-miquel.raynal@bootlin.com>
        <20210915155908.476767-37-miquel.raynal@bootlin.com>
        <YUtSVo9HBAiomswv@google.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Lee,

lee.jones@linaro.org wrote on Wed, 22 Sep 2021 16:57:10 +0100:

> On Wed, 15 Sep 2021, Miquel Raynal wrote:
> 
> > There was in the past a typo in the coordinate readouts property. The
> > bindings have been updated, the touchscreen driver as well and now
> > supports both. However, the MFD driver that is in charge of verifying
> > the validity of the property only checks the bogus one. Add support for
> > the correctly spelled DT property.
> > 
> > Fixes: c9aeb249bf72 ("Input: ti_am335x_tsc - fix spelling mistake in TSC/ADC DT binding")
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> >  drivers/mfd/ti_am335x_tscadc.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
> > index 155a8ed879b3..aa46ed669016 100644
> > --- a/drivers/mfd/ti_am335x_tscadc.c
> > +++ b/drivers/mfd/ti_am335x_tscadc.c
> > @@ -144,8 +144,14 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
> >  	if (tscadc->data->has_tsc) {
> >  		node = of_get_child_by_name(pdev->dev.of_node, "tsc");
> >  		of_property_read_u32(node, "ti,wires", &tscmag_wires);
> > -		of_property_read_u32(node, "ti,coordiante-readouts", &readouts);
> > +		err = of_property_read_u32(node, "ti,coordinate-readouts",
> > +					   &readouts);
> > +		if (err < 0)
> > +			of_property_read_u32(node, "ti,coordiante-readouts",
> > +					     &readouts);
> > +  
> 
> How long are you proposing that we support this churn?

Well, I am not proposing anything, I am just "fixing" the driver so
that it fits the bindings :) Given the fact that at the end of this
series there is a patch that changes the "coordiante" typo to
"coordinate" in a device tree source file, I believe it is still too
soon...


Thanks,
Miquèl
