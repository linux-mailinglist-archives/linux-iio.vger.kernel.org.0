Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D153D400FE2
	for <lists+linux-iio@lfdr.de>; Sun,  5 Sep 2021 15:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237589AbhIENQk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Sep 2021 09:16:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:37374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229759AbhIENQi (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 5 Sep 2021 09:16:38 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2183860F45;
        Sun,  5 Sep 2021 13:15:28 +0000 (UTC)
Date:   Sun, 5 Sep 2021 14:18:52 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-input@vger.kernel.org>,
        <linux-omap@vger.kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Ryan Barnett <ryan.barnett@collins.com>,
        Jason Reeder <jreeder@ti.com>
Subject: Re: [PATCH v2 33/46] mfd: ti_am335x_tscadc: Move control register
 configuration
Message-ID: <20210905141830.1a0deaa9@jic23-huawei>
In-Reply-To: <3bc1f515-0b3c-ad0c-9624-4d4804899007@ti.com>
References: <20210902215144.507243-1-miquel.raynal@bootlin.com>
        <20210902215144.507243-34-miquel.raynal@bootlin.com>
        <3bc1f515-0b3c-ad0c-9624-4d4804899007@ti.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 3 Sep 2021 16:24:22 +0300
Grygorii Strashko <grygorii.strashko@ti.com> wrote:

> On 03/09/2021 00:51, Miquel Raynal wrote:
> > The datasheet states that most of the configuration should be set in the
> > control register in the first place, before actually enabling the
> > hardware. So far only half of the configuration was made in the first
> > step, which does not make really sense and would complicating the code
> > when introducing support for the am437x hardware.
> > 
> > Let's move that register write a bit below to enclose more configuration.
> > 
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > ---
> >   drivers/mfd/ti_am335x_tscadc.c | 2 ++
> >   1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
> > index 29ada9da8826..a0db3e4ff265 100644
> > --- a/drivers/mfd/ti_am335x_tscadc.c
> > +++ b/drivers/mfd/ti_am335x_tscadc.c
> > @@ -239,6 +239,8 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
> >   	}
> >   	regmap_write(tscadc->regmap, REG_CTRL, tscadc->ctrl);
> >   
> > +	regmap_write(tscadc->regmap, REG_CTRL, tscadc->ctrl);
> > +  
> 
> Strange change - above 2 lines a the same !?

Yup, Looks like this one got handled earlier and the rebase went wrong.
So drop it.

> 
> >   	tscadc_idle_config(tscadc);
> >   
> >   	/* Enable the TSC module enable bit */
> >   
> 

