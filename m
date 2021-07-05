Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2048B3BBBB6
	for <lists+linux-iio@lfdr.de>; Mon,  5 Jul 2021 12:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbhGELAz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 5 Jul 2021 07:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231279AbhGELAz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 5 Jul 2021 07:00:55 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6307DC061760
        for <linux-iio@vger.kernel.org>; Mon,  5 Jul 2021 03:58:18 -0700 (PDT)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1m0MIj-00083W-VX; Mon, 05 Jul 2021 12:58:09 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1m0MIi-0001Ri-NR; Mon, 05 Jul 2021 12:58:08 +0200
Date:   Mon, 5 Jul 2021 12:58:08 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>,
        Robin van der Gracht <robin@protonic.nl>,
        linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v1 2/2] iio: adc: tsc2046: fix sleeping in atomic context
 warning and a deadlock after iio_trigger_poll() call
Message-ID: <20210705105808.GA7671@pengutronix.de>
References: <20210625065922.8310-1-o.rempel@pengutronix.de>
 <20210625065922.8310-2-o.rempel@pengutronix.de>
 <20210704185710.07789b8f@jic23-huawei>
 <20210705035440.35iualr6kkg22n56@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210705035440.35iualr6kkg22n56@pengutronix.de>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 12:44:22 up 126 days, 20:19, 125 users,  load average: 26.63,
 23.43, 16.00
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Jul 05, 2021 at 05:54:40AM +0200, Oleksij Rempel wrote:
> Hi Jonathan,
> 
> On Sun, Jul 04, 2021 at 06:57:10PM +0100, Jonathan Cameron wrote:
> > On Fri, 25 Jun 2021 08:59:22 +0200
> > Oleksij Rempel <o.rempel@pengutronix.de> wrote:
> > 
> > > If iio_trigger_poll() is called after IRQ was disabled, we will call
> > > reenable_trigger() directly from hard IRQ or hrtimer context instead of
> > > IRQ thread. In this case we will run in to multiple issue as sleeping in atomic
> > > context and a deadlock.
> > 
> > Hmm. This sounds like a problem that might bite us in other circumstances.
> > 
> > So do I have the basic issue right in thinking we have a race between
> > calling iio_trigger_poll() and having no devices still using that trigger?
> > Thus we end up with all of trig->subirqs not being enabled.
> > 
> > There was a previous discussion that the calls to iio_trigger_notify_done() in
> > iio_trigger_poll() are only meant to decrement the counter, as the assumption
> > was that the calls via threads would always happen later.  Unfortunately this
> > is all clearly a little bit racy and I suspect not many of the reenable() callbacks
> > are safe if they are called in interrupt context.
> > 
> > Perhaps an alternative would be to schedule the reenable() if we hit it from
> > that path thus ensuring it doesn't happen in a place where we can't sleep?
> > 
> > Would something like that solve your problem?
> 
> Yes :)

But the initial design of the driver wasn't that good, there were two
variables to decide what to do and now there is a proper state machine.
I see this as a cleanup, that also fixes the problem with the
re-enable().

> > I'd do it by having a new function
> > 
> > iio_trigger_notify_done_schedule() that uses a work struct to call
> > trig->ops->reenable(trig) from a context that can sleep.

Said that, the driver doesn't need the re-enable from sleeping context
anymore. If you provide an initial patch I can test that.

> > It's a rare corner case so I don't really care that in theory we might have
> > a device that was safe to reenable the trigger without sleeping.  That makes
> > it easier to just have one path for this which allows sleeping.

Sure, having always the same (i.e. sleeping context) makes it easier for
the driver, especially if the non sleeping re-enable is only called
during shutdown of the trigger-consumer if an interrupt comes in.

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
