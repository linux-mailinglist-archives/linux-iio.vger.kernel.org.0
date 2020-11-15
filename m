Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7EBF2B35C5
	for <lists+linux-iio@lfdr.de>; Sun, 15 Nov 2020 16:33:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbgKOPcn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 Nov 2020 10:32:43 -0500
Received: from mslow2.mail.gandi.net ([217.70.178.242]:42774 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726749AbgKOPcn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 15 Nov 2020 10:32:43 -0500
Received: from relay1-d.mail.gandi.net (unknown [217.70.183.193])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id 0850B3A9EDC;
        Sun, 15 Nov 2020 15:24:13 +0000 (UTC)
X-Originating-IP: 78.193.40.249
Received: from kb-xps (unknown [78.193.40.249])
        (Authenticated sender: kamel.bouhara@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 34C82240004;
        Sun, 15 Nov 2020 15:23:51 +0000 (UTC)
Date:   Sun, 15 Nov 2020 16:23:49 +0100
From:   Kamel Bouhara <kamel.bouhara@bootlin.com>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        jic23@kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] counter: microchip-tcb-capture: Fix CMR value check
Message-ID: <20201115152349.GA2233@kb-xps>
References: <20201111163807.10201-1-vilhelm.gray@gmail.com>
 <20201114224827.GQ4556@piout.net>
 <20201114225113.GR4556@piout.net>
 <X7BhFOA9uPAUluv0@shinobu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X7BhFOA9uPAUluv0@shinobu>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Nov 14, 2020 at 05:58:28PM -0500, William Breathitt Gray wrote:
> On Sat, Nov 14, 2020 at 11:51:13PM +0100, Alexandre Belloni wrote:
> > On 14/11/2020 23:48:28+0100, Alexandre Belloni wrote:
> > > On 11/11/2020 11:38:07-0500, William Breathitt Gray wrote:
> > > > The ATMEL_TC_ETRGEDG_* defines are not masks but rather possible values
> > > > for CMR. This patch fixes the action_get() callback to properly check
> > > > for these values rather than mask them.
> > > >
> > > > Fixes: 106b104137fd ("counter: Add microchip TCB capture counter")
> > > > Cc: Kamel Bouhara <kamel.bouhara@bootlin.com>
> > > > Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> > > Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> > >
> > > > ---
> > > >  drivers/counter/microchip-tcb-capture.c | 16 ++++++++++------
> > > >  1 file changed, 10 insertions(+), 6 deletions(-)
> > > >
> > > > diff --git a/drivers/counter/microchip-tcb-capture.c b/drivers/counter/microchip-tcb-capture.c
> > > > index 039c54a78aa5..142b389fc9db 100644
> > > > --- a/drivers/counter/microchip-tcb-capture.c
> > > > +++ b/drivers/counter/microchip-tcb-capture.c
> > > > @@ -183,16 +183,20 @@ static int mchp_tc_count_action_get(struct counter_device *counter,
> > > >
> > > >  	regmap_read(priv->regmap, ATMEL_TC_REG(priv->channel[0], CMR), &cmr);
> > > >
> > > > -	*action = MCHP_TC_SYNAPSE_ACTION_NONE;
> > > > -
> > > > -	if (cmr & ATMEL_TC_ETRGEDG_NONE)
> > > > +	switch (cmr & ATMEL_TC_ETRGEDG_BOTH) {
> >
> > BTW, this could be simply ATMEL_TC_ETRGEDG which is the mask.
>
> You're right, let me resubmit this patch with that change since it'll be
> much clearer.
>
> By the way, microchip-tcb-capture.c is missing a MAINTAINERS entry. Is
> Kamel the maintainer of this driver? I'd like to get a proper entry
> added so we have a point of contact in case of future bugs and changes.
>

Hello William,

Thanks for the patch, indeed Im the maintainer of this driver.

Regards,
Kamel

> Thanks,
>
> William Breathitt Gray



--
Kamel Bouhara, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
