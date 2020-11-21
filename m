Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAC612BC090
	for <lists+linux-iio@lfdr.de>; Sat, 21 Nov 2020 17:32:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725953AbgKUQcF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 21 Nov 2020 11:32:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:58070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725914AbgKUQcD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 21 Nov 2020 11:32:03 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8E9522206;
        Sat, 21 Nov 2020 16:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605976323;
        bh=hvZKMfDT45SrrDndTb88nBfj/K+dMn9SERmCh1poRBU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Oq3tI8Oz4rEXwir+kMVZH4uUSC7r4JxdX82Fi3ATqi4vr+Scc/oeUSxJyRGELne6v
         nabUVSzoXO0peaa0KabLXJmrdkKYWLhEFWh4JBY3H5h10VsIliDa5mt1JqWtbQTnXP
         cxi76GPl/rZeZny8fKb5bG11F9BSFj+Zyizb+md8=
Date:   Sat, 21 Nov 2020 16:31:57 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Kamel Bouhara <kamel.bouhara@bootlin.com>
Cc:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        robh+dt@kernel.org, alexandre.belloni@bootlin.com,
        linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] counter: microchip-tcb-capture: Fix CMR value check
Message-ID: <20201121163157.086ae03b@archlinux>
In-Reply-To: <20201115152617.GB2233@kb-xps>
References: <20201114232805.253108-1-vilhelm.gray@gmail.com>
        <20201115152617.GB2233@kb-xps>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 15 Nov 2020 16:26:17 +0100
Kamel Bouhara <kamel.bouhara@bootlin.com> wrote:

> On Sat, Nov 14, 2020 at 06:28:05PM -0500, William Breathitt Gray wrote:
> > The ATMEL_TC_ETRGEDG_* defines are not masks but rather possible values
> > for CMR. This patch fixes the action_get() callback to properly check
> > for these values rather than mask them.
> >
> > Fixes: 106b104137fd ("counter: Add microchip TCB capture counter")
> > Cc: Kamel Bouhara <kamel.bouhara@bootlin.com>
> > Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> > Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> > ---  
> 
> Acked-by: Kamel Bouhara <kamel.bouhara@bootlin.com>
> 
Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan

> >  drivers/counter/microchip-tcb-capture.c | 16 ++++++++++------
> >  1 file changed, 10 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/counter/microchip-tcb-capture.c b/drivers/counter/microchip-tcb-capture.c
> > index 039c54a78aa5..710acc0a3704 100644
> > --- a/drivers/counter/microchip-tcb-capture.c
> > +++ b/drivers/counter/microchip-tcb-capture.c
> > @@ -183,16 +183,20 @@ static int mchp_tc_count_action_get(struct counter_device *counter,
> >
> >  	regmap_read(priv->regmap, ATMEL_TC_REG(priv->channel[0], CMR), &cmr);
> >
> > -	*action = MCHP_TC_SYNAPSE_ACTION_NONE;
> > -
> > -	if (cmr & ATMEL_TC_ETRGEDG_NONE)
> > +	switch (cmr & ATMEL_TC_ETRGEDG) {
> > +	default:
> >  		*action = MCHP_TC_SYNAPSE_ACTION_NONE;
> > -	else if (cmr & ATMEL_TC_ETRGEDG_RISING)
> > +		break;
> > +	case ATMEL_TC_ETRGEDG_RISING:
> >  		*action = MCHP_TC_SYNAPSE_ACTION_RISING_EDGE;
> > -	else if (cmr & ATMEL_TC_ETRGEDG_FALLING)
> > +		break;
> > +	case ATMEL_TC_ETRGEDG_FALLING:
> >  		*action = MCHP_TC_SYNAPSE_ACTION_FALLING_EDGE;
> > -	else if (cmr & ATMEL_TC_ETRGEDG_BOTH)
> > +		break;
> > +	case ATMEL_TC_ETRGEDG_BOTH:
> >  		*action = MCHP_TC_SYNAPSE_ACTION_BOTH_EDGE;
> > +		break;
> > +	}
> >
> >  	return 0;
> >  }
> > --
> > 2.29.2
> >  
> 
> --
> Kamel Bouhara, Bootlin
> Embedded Linux and kernel engineering
> https://bootlin.com

