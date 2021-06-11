Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2A5E3A4841
	for <lists+linux-iio@lfdr.de>; Fri, 11 Jun 2021 20:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbhFKSCj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 11 Jun 2021 14:02:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:41668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229965AbhFKSCh (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 11 Jun 2021 14:02:37 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1438F61357;
        Fri, 11 Jun 2021 18:00:36 +0000 (UTC)
Date:   Fri, 11 Jun 2021 19:02:31 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        linux@rempel-privat.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH] counter: interrupt-cnt: Add const qualifier for
 actions_list array
Message-ID: <20210611190231.57adf09f@jic23-huawei>
In-Reply-To: <20210610032347.wb4wcwr37p7qn7j7@pengutronix.de>
References: <20210610013642.149961-1-vilhelm.gray@gmail.com>
        <20210610032347.wb4wcwr37p7qn7j7@pengutronix.de>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 10 Jun 2021 05:23:47 +0200
Oleksij Rempel <o.rempel@pengutronix.de> wrote:

> Hi William,
> 
> On Thu, Jun 10, 2021 at 10:36:42AM +0900, William Breathitt Gray wrote:
> > The struct counter_synapse actions_list member expects a const enum
> > counter_synapse_action array. This patch renames
> > interrupt_cnt_synapse_actionss to interrupt_cnt_synapse_actions and adds
> > a const qualifier to match actions_list.
> > 
> > Cc: Oleksij Rempel <o.rempel@pengutronix.de>
> > Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>  
> 
> Reviewed-by: <o.rempel@pengutronix.de>
Applied to the togreg branch of iio.git and pushed out as testing for 0-day
to see if it can find anything we missed.

Thanks,

Jonathan

> 
> thank you!
> 
> > ---
> >  drivers/counter/interrupt-cnt.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/counter/interrupt-cnt.c b/drivers/counter/interrupt-cnt.c
> > index 827d785e19b4..5df7cd13d4c7 100644
> > --- a/drivers/counter/interrupt-cnt.c
> > +++ b/drivers/counter/interrupt-cnt.c
> > @@ -77,7 +77,7 @@ static const struct counter_count_ext interrupt_cnt_ext[] = {
> >  	},
> >  };
> >  
> > -static enum counter_synapse_action interrupt_cnt_synapse_actionss[] = {
> > +static const enum counter_synapse_action interrupt_cnt_synapse_actions[] = {
> >  	COUNTER_SYNAPSE_ACTION_RISING_EDGE,
> >  };
> >  
> > @@ -194,8 +194,8 @@ static int interrupt_cnt_probe(struct platform_device *pdev)
> >  	priv->counter.signals = &priv->signals;
> >  	priv->counter.num_signals = 1;
> >  
> > -	priv->synapses.actions_list = interrupt_cnt_synapse_actionss;
> > -	priv->synapses.num_actions = ARRAY_SIZE(interrupt_cnt_synapse_actionss);
> > +	priv->synapses.actions_list = interrupt_cnt_synapse_actions;
> > +	priv->synapses.num_actions = ARRAY_SIZE(interrupt_cnt_synapse_actions);
> >  	priv->synapses.signal = &priv->signals;
> >  
> >  	priv->cnts.name = "Channel 0 Count";
> > -- 
> > 2.32.0
> > 
> > 
> >   
> 

