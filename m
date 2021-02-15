Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF66231B65B
	for <lists+linux-iio@lfdr.de>; Mon, 15 Feb 2021 10:26:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbhBOJZG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 15 Feb 2021 04:25:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbhBOJZC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 15 Feb 2021 04:25:02 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4A9BC061756
        for <linux-iio@vger.kernel.org>; Mon, 15 Feb 2021 01:24:21 -0800 (PST)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1lBa75-0005Zp-Rx; Mon, 15 Feb 2021 10:24:15 +0100
Received: from ore by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1lBa72-0000zq-6l; Mon, 15 Feb 2021 10:24:12 +0100
Date:   Mon, 15 Feb 2021 10:24:12 +0100
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
        linux-arm-kernel@lists.infradead.org, alexandre.torgue@st.com
Subject: Re: [PATCH v8 17/22] counter: Add character device interface
Message-ID: <20210215092412.ptbngqge7m7nyivp@pengutronix.de>
References: <cover.1613131238.git.vilhelm.gray@gmail.com>
 <720278e3aaf3f249657ec18d158eca3f962baf8e.1613131238.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <720278e3aaf3f249657ec18d158eca3f962baf8e.1613131238.git.vilhelm.gray@gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 10:18:43 up 74 days, 23:25, 42 users,  load average: 0.03, 0.08,
 0.04
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi William,

On Fri, Feb 12, 2021 at 09:13:41PM +0900, William Breathitt Gray wrote:
> This patch introduces a character device interface for the Counter
> subsystem. Device data is exposed through standard character device read
> operations. Device data is gathered when a Counter event is pushed by
> the respective Counter device driver. Configuration is handled via ioctl
> operations on the respective Counter character device node.

.....

> +/**
> + * counter_push_event - queue event for userspace reading
> + * @counter:	pointer to Counter structure
> + * @event:	triggered event
> + * @channel:	event channel
> + *
> + * Note: If no one is watching for the respective event, it is silently
> + * discarded.
> + */
> +void counter_push_event(struct counter_device *const counter, const u8 event,
> +			const u8 channel)
> +{
> +	struct counter_event ev = {0};
> +	unsigned int copied = 0;
> +	unsigned long flags;
> +	struct counter_event_node *event_node;
> +	struct counter_comp_node *comp_node;
> +
> +	ev.timestamp = ktime_get_ns();
> +	ev.watch.event = event;
> +	ev.watch.channel = channel;
> +
> +	/* Could be in an interrupt context, so use a raw spin lock */
> +	raw_spin_lock_irqsave(&counter->events_list_lock, flags);
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

To cover my "interrupt-counter" use case, I added following line here to
convert the tail drop fifo to the head drop fifo:

+       list_for_each_entry(comp_node, &event_node->comp_list, l)
+               to_copy += sizeof(ev);
+
+       while (kfifo_avail(&counter->events) < to_copy)
+               kfifo_skip(&counter->events);

May be it make sense to make it optional and integrate in to you patches
before it goes mainline?

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
