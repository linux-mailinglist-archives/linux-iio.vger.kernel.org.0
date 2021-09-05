Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A82A400FF1
	for <lists+linux-iio@lfdr.de>; Sun,  5 Sep 2021 15:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231917AbhIENYE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Sun, 5 Sep 2021 09:24:04 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:52519 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231754AbhIENYE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 5 Sep 2021 09:24:04 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 1C587C0006;
        Sun,  5 Sep 2021 13:22:56 +0000 (UTC)
Date:   Sun, 5 Sep 2021 15:22:56 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Grygorii Strashko <grygorii.strashko@ti.com>,
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
Message-ID: <20210905152256.48259b8d@xps13>
In-Reply-To: <20210905141830.1a0deaa9@jic23-huawei>
References: <20210902215144.507243-1-miquel.raynal@bootlin.com>
        <20210902215144.507243-34-miquel.raynal@bootlin.com>
        <3bc1f515-0b3c-ad0c-9624-4d4804899007@ti.com>
        <20210905141830.1a0deaa9@jic23-huawei>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

jic23@kernel.org wrote on Sun, 5 Sep 2021 14:18:52 +0100:

> On Fri, 3 Sep 2021 16:24:22 +0300
> Grygorii Strashko <grygorii.strashko@ti.com> wrote:
> 
> > On 03/09/2021 00:51, Miquel Raynal wrote:  
> > > The datasheet states that most of the configuration should be set in the
> > > control register in the first place, before actually enabling the
> > > hardware. So far only half of the configuration was made in the first
> > > step, which does not make really sense and would complicating the code
> > > when introducing support for the am437x hardware.
> > > 
> > > Let's move that register write a bit below to enclose more configuration.
> > > 
> > > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > > ---
> > >   drivers/mfd/ti_am335x_tscadc.c | 2 ++
> > >   1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
> > > index 29ada9da8826..a0db3e4ff265 100644
> > > --- a/drivers/mfd/ti_am335x_tscadc.c
> > > +++ b/drivers/mfd/ti_am335x_tscadc.c
> > > @@ -239,6 +239,8 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
> > >   	}
> > >   	regmap_write(tscadc->regmap, REG_CTRL, tscadc->ctrl);
> > >   
> > > +	regmap_write(tscadc->regmap, REG_CTRL, tscadc->ctrl);
> > > +    
> > 
> > Strange change - above 2 lines a the same !?  
> 
> Yup, Looks like this one got handled earlier and the rebase went wrong.
> So drop it.

Exactly. That's a rebase issue I didn't notice.

Thanks,
Miquèl
