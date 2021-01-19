Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D1602FC4C9
	for <lists+linux-iio@lfdr.de>; Wed, 20 Jan 2021 00:35:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732160AbhASONo convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Tue, 19 Jan 2021 09:13:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732437AbhASJVN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 Jan 2021 04:21:13 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ED71C061575
        for <linux-iio@vger.kernel.org>; Tue, 19 Jan 2021 01:20:32 -0800 (PST)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1l1nBZ-0004WN-1x; Tue, 19 Jan 2021 10:20:25 +0100
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1l1nBW-0001Dn-E1; Tue, 19 Jan 2021 10:20:22 +0100
Date:   Tue, 19 Jan 2021 10:20:22 +0100
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     jic23@kernel.org, kamel.bouhara@bootlin.com, gwendal@chromium.org,
        a.fatoum@pengutronix.de, david@lechnology.com,
        linux-iio@vger.kernel.org, patrick.havelange@essensium.com,
        alexandre.belloni@bootlin.com, mcoquelin.stm32@gmail.com,
        linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        kernel@pengutronix.de, fabrice.gasnier@st.com,
        syednwaris@gmail.com, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, alexandre.torgue@st.com,
        David Jander <david@protonic.nl>
Subject: Re: [PATCH v6 3/5] counter: Add character device interface
Message-ID: <20210119092022.GA14502@pengutronix.de>
References: <cover.1606075915.git.vilhelm.gray@gmail.com>
 <b52a62196399d33221f78a1689276ac193c10229.1606075915.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <b52a62196399d33221f78a1689276ac193c10229.1606075915.git.vilhelm.gray@gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 10:05:44 up 35 days, 17:13, 74 users,  load average: 0.14, 0.75,
 1.44
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Nov 22, 2020 at 03:29:54PM -0500, William Breathitt Gray wrote:
> This patch introduces a character device interface for the Counter
> subsystem. Device data is exposed through standard character device read
> operations. Device data is gathered when a Counter event is pushed by
> the respective Counter device driver. Configuration is handled via ioctl
> operations on the respective Counter character device node.
> 
> Cc: David Lechner <david@lechnology.com>
> Cc: Gwendal Grignou <gwendal@chromium.org>
> Cc: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> ---

Hello William,

the series looks quite interesting, we have some thoughts... see below:

[...]
> +/**
> + * counter_push_event - queue event for userspace reading
> + * @counter:	pointer to Counter structure
> + * @event:	triggered event
> + * @channel:	event channel
> + *
> + * Note: If no one is watching for the respective event, it is silently
> + * discarded.
> + *
> + * RETURNS:
> + * 0 on success, negative error number on failure.
> + */
> +int counter_push_event(struct counter_device *const counter, const u8 event,
> +		       const u8 channel)
> +{
> +	struct counter_event ev = {0};
> +	unsigned int copied = 0;
> +	unsigned long flags;
> +	struct counter_event_node *event_node;
> +	struct counter_comp_node *comp_node;
> +	int err = 0;
> +
> +	ev.timestamp = ktime_get_ns();
> +	ev.watch.event = event;
> +	ev.watch.channel = channel;
> +
> +	raw_spin_lock_irqsave(&counter->events_lock, flags);
> +
> +	/* Search for event in the list */
> +	list_for_each_entry(event_node, &counter->events_list, l)
> +		if (event_node->event == event &&
> +		    event_node->channel == channel)
> +			break;
> +
> +	/* If event is not in the list */
> +	if (&event_node->l == &counter->events_list)
> +		goto exit_early;
> +
> +	/* Read and queue relevant comp for userspace */
> +	list_for_each_entry(comp_node, &event_node->comp_list, l) {
> +		err = counter_get_data(counter, comp_node, &ev.value);
> +		if (err)
> +			goto exit_early;
> +
> +		ev.watch.component = comp_node->component;
> +
> +		copied += kfifo_put(&counter->events, ev);

We want to calculate the frequency of some IRQ pulses in user space and
counter values with time stamps really fits well here. As the pulses are
from a physical system (rotating wheel), they will only change at a
certain rate. We want to have the possibility to read from the counter
device less often, we intentionally want to skip (meaning miss)
events.

When reading we're interested in the newest events. The kfifo implements
a "tail" drop FIFO, which means new values are added at the end, and if
the FIFO is full, they are dropped. We need a "head" drop FIFO which
discards the oldest events, keeping only the recent ones.

As far as we know, kfifo doesn't offer a head drop mode, but I think
this can be added.

[...]

>  struct counter_device {
>  	const char *name;
> @@ -270,12 +270,20 @@ struct counter_device {
>  
>  	int id;
>  	struct device dev;
> +	struct cdev chrdev;
> +	raw_spinlock_t events_lock;
> +	struct list_head events_list;
> +	struct list_head next_events_list;
> +	DECLARE_KFIFO(events, struct counter_event, 64);

Do you plan to make the size of the FIFO configurable?

regards,
Oleksij & Marc

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
