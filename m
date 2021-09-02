Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E641B3FE970
	for <lists+linux-iio@lfdr.de>; Thu,  2 Sep 2021 08:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242148AbhIBGsJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Thu, 2 Sep 2021 02:48:09 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:48891 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242135AbhIBGsJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 2 Sep 2021 02:48:09 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 361B224000C;
        Thu,  2 Sep 2021 06:47:06 +0000 (UTC)
Date:   Thu, 2 Sep 2021 08:47:06 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>, <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        "Ryan J . Barnett" <ryan.barnett@collins.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-input@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, Jason Reeder <jreeder@ti.com>
Subject: Re: [PATCH 28/40] mfd: ti_am335x_tscadc: Add ADC1/magnetic reader
 support
Message-ID: <20210902084706.7cd54453@xps13>
In-Reply-To: <732e002d-d732-5411-1be4-1ecafc993da5@ti.com>
References: <20210825152518.379386-1-miquel.raynal@bootlin.com>
        <20210825152518.379386-29-miquel.raynal@bootlin.com>
        <732e002d-d732-5411-1be4-1ecafc993da5@ti.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Grygorii,

Grygorii Strashko <grygorii.strashko@ti.com> wrote on Wed, 1 Sep 2021
22:26:25 +0300:

> On 25/08/2021 18:25, Miquel Raynal wrote:
> > Introduce a new compatible that has another set of driver data,
> > targeting am437x SoCs with a magnetic reader instead of the
> > touchscreen and a more featureful set of registers.
> > 
> > Co-developed-by: Jason Reeder <jreeder@ti.com>
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > Signed-off-by: Jason Reeder <jreeder@ti.com>
> > ---
> >   drivers/mfd/ti_am335x_tscadc.c       | 43 ++++++++++++++++++++++------
> >   include/linux/mfd/ti_am335x_tscadc.h |  9 +++++-
> >   2 files changed, 43 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
> > index 1a30610dc65f..f4f6b9db4d2a 100644
> > --- a/drivers/mfd/ti_am335x_tscadc.c
> > +++ b/drivers/mfd/ti_am335x_tscadc.c
> > @@ -122,9 +122,9 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
> >   	const __be32 *cur;
> >   	struct clk *clk;
> >   	u32 val;
> > -	bool use_tsc = false;
> > +	bool use_tsc = false, use_mag = false;
> >   	int tscmag_wires = 0, adc_channels = 0, readouts = 0, cell_idx = 0;
> > -	int total_channels, err;
> > +	int mag_tracks = 0, total_channels, err;  
> >   >   	/* Allocate memory for device */  
> >   	tscadc = devm_kzalloc(&pdev->dev, sizeof(*tscadc), GFP_KERNEL);
> > @@ -146,6 +146,12 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
> >   		of_property_read_u32(node, "ti,coordiante-readouts", &readouts);
> >   		if (tscmag_wires)
> >   			use_tsc = true;
> > +	} else {
> > +		node = of_get_child_by_name(pdev->dev.of_node, "mag");
> > +		of_property_read_u32(node, "ti,tracks", &mag_tracks);  
> 
> "ti,tracks" seems undocumented?

Well that's true and almost on purpose, I am not focusing on the
magnetic reader feature, it is not supported, I don't have one, I don't
plan to add support for it. But in the driver I need to know how many
"tracks" are unavailable for the ADC in order to implement the entire
logic (this block comes from TI and the naming from Jason Reeder).

I am not comfortable writing a binding file for a device that I won't
use, it's the best way to miss something and have stable broken
bindings in the future. So I assumed it was not a big deal to have this
property in the code, which may be updated/removed/enhanced later if
needed without having to mess with the code too much. What do you think?

Thanks,
Miquèl
