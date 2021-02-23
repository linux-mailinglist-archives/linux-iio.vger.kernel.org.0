Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17B69322892
	for <lists+linux-iio@lfdr.de>; Tue, 23 Feb 2021 11:09:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232180AbhBWKH7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 23 Feb 2021 05:07:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232211AbhBWKHn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 23 Feb 2021 05:07:43 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BFB3C061786
        for <linux-iio@vger.kernel.org>; Tue, 23 Feb 2021 02:07:03 -0800 (PST)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1lEUan-0005RW-MQ; Tue, 23 Feb 2021 11:06:57 +0100
Received: from ore by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1lEUam-00035o-RS; Tue, 23 Feb 2021 11:06:56 +0100
Date:   Tue, 23 Feb 2021 11:06:56 +0100
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>,
        Robin van der Gracht <robin@protonic.nl>,
        linux-iio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v5 2/2] counter: add IRQ or GPIO based event counter
Message-ID: <20210223100656.efbshsh5bz66uhj5@pengutronix.de>
References: <20210208135347.18494-1-o.rempel@pengutronix.de>
 <20210208135347.18494-3-o.rempel@pengutronix.de>
 <YCjlPhEtyH+vfSi4@shinobu>
 <20210215091737.fx6dwiz7tt56wbkr@pengutronix.de>
 <YDMMJJ985Zq9oEOv@shinobu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YDMMJJ985Zq9oEOv@shinobu>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 10:39:14 up 82 days, 23:45, 41 users,  load average: 0.02, 0.05,
 0.06
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Feb 22, 2021 at 10:43:00AM +0900, William Breathitt Gray wrote:
> On Mon, Feb 15, 2021 at 10:17:37AM +0100, Oleksij Rempel wrote:
> > > > +static irqreturn_t event_cnt_isr(int irq, void *dev_id)
> > > > +{
> > > > +	struct event_cnt_priv *priv = dev_id;
> > > > +
> > > > +	atomic_inc(&priv->count);
> > > 
> > > This is just used to count the number of interrupts right? I wonder if
> > > we can do this smarter. For example, the kernel already keeps track of
> > > number of interrupts that has occurred for any particular IRQ line on a
> > > CPU (see the 'kstat_irqs' member of struct irq_desc, and the
> > > show_interrupts() function in kernel/irq/proc.c). Would it make sense to
> > > simply store the initial interrupt count on driver load or enablement,
> > > and then return the difference during a count_read() callback?
> > 
> > This driver do not makes a lot of sense without your chardev patches. As
> > soon as this patches go mainline, this driver will be able to send
> > event with a timestamp and counter state to the user space.
> > 
> > With other words, we will need an irq handler anyway. In this case we
> > can't save more RAM or CPU cycles by using system irq counters.
> 
> It's true that this driver will need an IRQ handler when the timestamp
> functionality is added, but deriving the count value is different matter
> regardless. There's already code in the kernel to retrieve the number of
> interrupts, so it makes sense that we use that rather than rolling our
> own -- at the very least to ensure the value we provide to users is
> consistent with the ones already provided by other areas of the kernel.

We are talking about one or two code lines. If we will take some
duplication search engine, it will find that major part of the kernel
is matching against it.

Newer the less, this driver provides a way to reset the counter. Why
should we drop this functionality no advantage?

> To that end, I'd like to see your cnt_isr() function removed for this
> patchset (you can bring it back once timestamp support is added).

Are you suggesting to enable IRQ without interrupt handler? May be i'm
missing some thing.. I do not understand it.

> Reimplement your cnt_read/cnt_write() functions to instead use
> kstat_irqs_usr() from <linux/kernel_stat.h> to get the current number of
> interrupts the IRQ line and use it to derive your count value for this
> driver.

I can follow the counter read way, but overwriting system wide counter
for local use is bad idea.

> > > > +static struct counter_signal event_cnt_signals[] = {
> > > > +	{
> > > > +		.id = 0,
> > > > +		.name = "Channel 0 signal",
> > > 
> > > You should choose a more description name for this Signal;
> > > "Channel 0 signal" isn't very useful information for the user. Is this
> > > signal the respective GPIO line state?
> > 
> > Sounds plausible. How about "Channel 0, GPIO line state"?
> 
> Ideally, this would match the GPIO name (or I suppose the IRQ number if
> not a GPIO line). So in your probe() function you can do something like
> this I believe:
> 
> 	cnt_signals[0].name = priv->gpio->name;

to make this possible, i would need hack gpiolib framework and add
name/label exporter. But after endless rounds of pingponging me for
renaming the driver and removing interrupt handler, i feel like we are
not having serious discussion for mainlining this driver.

Is it some expensive way to prepare me for 1. April joke?

> Of course, you should first check whether this is a GPIO line or IRQ
> line and set the name accordingly.

Please, let's stop bike-shed for now. This driver has no limitless
budget. If there are serious problem, I would love to fix it, but if we
still discussing name of the driver or how to misuse kernel interrupt
handling, then it makes no sense to continue.

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
