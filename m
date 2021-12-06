Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A204469191
	for <lists+linux-iio@lfdr.de>; Mon,  6 Dec 2021 09:32:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239501AbhLFIg0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 6 Dec 2021 03:36:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231612AbhLFIg0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 6 Dec 2021 03:36:26 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0E58C061746
        for <linux-iio@vger.kernel.org>; Mon,  6 Dec 2021 00:32:57 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1mu9Qe-0006EQ-1e; Mon, 06 Dec 2021 09:32:56 +0100
Received: from ore by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1mu9Qb-0002ya-OC; Mon, 06 Dec 2021 09:32:53 +0100
Date:   Mon, 6 Dec 2021 09:32:53 +0100
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Cc:     linux-iio@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC PATCH] iio: trigger: Fix a scheduling whilst atomic issue
 seen on tsc2046
Message-ID: <20211206083253.GB6671@pengutronix.de>
References: <20211017172209.112387-1-jic23@kernel.org>
 <20211124084822.GA18112@pengutronix.de>
 <20211205173517.59d6d913@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211205173517.59d6d913@jic23-huawei>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 09:31:50 up 291 days, 11:55, 147 users,  load average: 0.36, 0.26,
 0.17
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Dec 05, 2021 at 05:35:35PM +0000, Jonathan Cameron wrote:
> On Wed, 24 Nov 2021 09:48:22 +0100
> Oleksij Rempel <o.rempel@pengutronix.de> wrote:
> 
> > On Sun, Oct 17, 2021 at 06:22:09PM +0100, Jonathan Cameron wrote:
> > > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > 
> > > IIO triggers are software IRQ chips that split an incoming IRQ into
> > > separate IRQs routed to all devices using the trigger.
> > > When all consumers are done then a trigger callback reenable() is
> > > called.  There are a few circumstances under which this can happen
> > > in atomic context.
> > > 
> > > 1) A single user of the trigger that calls the iio_trigger_done()
> > > function from interrupt context.
> > > 2) A race between disconnecting the last device from a trigger and
> > > the trigger itself sucessfully being disabled.
> > > 
> > > To avoid a resulting scheduling whilst atomic, close this corner
> > > by using schedule_work() to ensure the reenable is not done in atomic
> > > context.
> > > 
> > > Note that drivers must be careful to manage the interaction of
> > > set_state() and reenable() callbacks to ensure appropriate reference
> > > counting if they are relying on the same hardware controls.
> > > 
> > > Completely untested beyond building. Given it is Sunday evening
> > > very high chance of it being entirely wrong.  The potential race
> > > conditions around this were giving me a headache, but I think this
> > > is at least a step in the right direction and should work for Oleksij's
> > > case.
> > > 
> > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > Cc: Oleksij Rempel <o.rempel@pengutronix.de>
> > > Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
> > > Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>  
> > 
> > Tested-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > 
> > Works for me... Thank you! :)
> 
> This patch is in the category that make me nervous, so I'm 
> not going to rush it in as a fix.  I've queued it up for the next
> merge window (and marked it for Stable).  Hopefully any issues will
> shake out before it hits a release kernel.
> 
> Applied to the togreg branch of iio.git and pushed out as testing.

Thx!

> Oleksij, what do you want to do about the work around you had?
> If you think it is a good cleanup, please resend so we get it to the
> top of people's inboxes!

I'm on vacation right now. Will do it early next year.

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
