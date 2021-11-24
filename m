Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3445045B552
	for <lists+linux-iio@lfdr.de>; Wed, 24 Nov 2021 08:27:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232182AbhKXHaf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 24 Nov 2021 02:30:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232043AbhKXHad (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 24 Nov 2021 02:30:33 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F6E7C061714
        for <linux-iio@vger.kernel.org>; Tue, 23 Nov 2021 23:27:24 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1mpmgb-00062s-Fj; Wed, 24 Nov 2021 08:27:21 +0100
Received: from ore by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1mpmga-0004X2-OY; Wed, 24 Nov 2021 08:27:20 +0100
Date:   Wed, 24 Nov 2021 08:27:20 +0100
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     linux-iio@vger.kernel.org,
        Robin van der Gracht <robin@protonic.nl>,
        linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v1] counter: interrupt-cnt: add counter_push_event()
Message-ID: <20211124072720.GA30281@pengutronix.de>
References: <20211123134540.416695-1-o.rempel@pengutronix.de>
 <YZ3XAeYyfGblfaOi@shinobu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YZ3XAeYyfGblfaOi@shinobu>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 08:21:27 up 279 days, 10:45, 125 users,  load average: 0.09, 0.15,
 0.16
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi William,

On Wed, Nov 24, 2021 at 03:09:05PM +0900, William Breathitt Gray wrote:
> On Tue, Nov 23, 2021 at 02:45:40PM +0100, Oleksij Rempel wrote:
> > Add counter_push_event() to notify user space about new pulses
> > 
> > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > ---
> >  drivers/counter/interrupt-cnt.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/counter/interrupt-cnt.c b/drivers/counter/interrupt-cnt.c
> > index 8514a87fcbee..b237137b552b 100644
> > --- a/drivers/counter/interrupt-cnt.c
> > +++ b/drivers/counter/interrupt-cnt.c
> > @@ -31,6 +31,8 @@ static irqreturn_t interrupt_cnt_isr(int irq, void *dev_id)
> >  
> >  	atomic_inc(&priv->count);
> >  
> > +	counter_push_event(&priv->counter, COUNTER_EVENT_OVERFLOW, 0);
> > +
> >  	return IRQ_HANDLED;
> >  }
> >  
> > -- 
> > 2.30.2
> 
> Hi Oleksij,
> 
> It looks like this is pushing a COUNTER_EVENT_OVERFLOW event every time
> an interrupt is handled, which I suspect is not what you want to happen.
> The COUNTER_EVENT_OVERFLOW event indicates a count value overflow event,
> so you'll need to check for a count value overflow before pushing the
> event.
> 
> It would be good idea to implement a ceiling extension as well (you can
> use the COUNTER_COMP_CEILING() macro) so that users can configure the
> particular point where the value overflows.

Thank you!

What would be the best and resource effective strategy for periodically
getting frequency of interrupts/pulses? This is actual information which is
needed for my use case.

So far, I was pushing every event to the user space, which is working
but probably not the most resource effective method of doing it.

Regards,
Oleskij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
