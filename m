Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4141E2FF345
	for <lists+linux-iio@lfdr.de>; Thu, 21 Jan 2021 19:38:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725922AbhAUSeC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 21 Jan 2021 13:34:02 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2394 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728826AbhAUS23 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 21 Jan 2021 13:28:29 -0500
Received: from fraeml701-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DM9ht26mvz67cZB;
        Fri, 22 Jan 2021 02:22:06 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml701-chm.china.huawei.com (10.206.15.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Thu, 21 Jan 2021 19:27:40 +0100
Received: from localhost (10.47.68.198) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Thu, 21 Jan
 2021 18:27:39 +0000
Date:   Thu, 21 Jan 2021 18:26:58 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
CC:     Oleksij Rempel <o.rempel@pengutronix.de>,
        <linux-arm-kernel@lists.infradead.org>,
        <kamel.bouhara@bootlin.com>, <gwendal@chromium.org>,
        <a.fatoum@pengutronix.de>, <david@lechnology.com>,
        <linux-iio@vger.kernel.org>, <patrick.havelange@essensium.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <alexandre.belloni@bootlin.com>, <linux-kernel@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        <mcoquelin.stm32@gmail.com>, David Jander <david@protonic.nl>,
        <fabrice.gasnier@st.com>, <syednwaris@gmail.com>,
        <kernel@pengutronix.de>, <jic23@kernel.org>,
        <alexandre.torgue@st.com>
Subject: Re: [PATCH v6 3/5] counter: Add character device interface
Message-ID: <20210121182658.00000d95@Huawei.com>
In-Reply-To: <YAk1PzXYQaJvhGSj@shinobu>
References: <cover.1606075915.git.vilhelm.gray@gmail.com>
        <b52a62196399d33221f78a1689276ac193c10229.1606075915.git.vilhelm.gray@gmail.com>
        <20210119092022.GA14502@pengutronix.de>
        <YAk1PzXYQaJvhGSj@shinobu>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.68.198]
X-ClientProxiedBy: lhreml719-chm.china.huawei.com (10.201.108.70) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 21 Jan 2021 17:03:11 +0900
William Breathitt Gray <vilhelm.gray@gmail.com> wrote:

> On Tue, Jan 19, 2021 at 10:20:22AM +0100, Oleksij Rempel wrote:
> > On Sun, Nov 22, 2020 at 03:29:54PM -0500, William Breathitt Gray wrote:  
> > > This patch introduces a character device interface for the Counter
> > > subsystem. Device data is exposed through standard character device read
> > > operations. Device data is gathered when a Counter event is pushed by
> > > the respective Counter device driver. Configuration is handled via ioctl
> > > operations on the respective Counter character device node.
> > > 
> > > Cc: David Lechner <david@lechnology.com>
> > > Cc: Gwendal Grignou <gwendal@chromium.org>
> > > Cc: Dan Carpenter <dan.carpenter@oracle.com>
> > > Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> > > ---  
> > 
> > Hello William,
> > 
> > the series looks quite interesting, we have some thoughts... see below:
> > 
> > [...]  
> > > +/**
> > > + * counter_push_event - queue event for userspace reading
> > > + * @counter:	pointer to Counter structure
> > > + * @event:	triggered event
> > > + * @channel:	event channel
> > > + *
> > > + * Note: If no one is watching for the respective event, it is silently
> > > + * discarded.
> > > + *
> > > + * RETURNS:
> > > + * 0 on success, negative error number on failure.
> > > + */
> > > +int counter_push_event(struct counter_device *const counter, const u8 event,
> > > +		       const u8 channel)
> > > +{
> > > +	struct counter_event ev = {0};
> > > +	unsigned int copied = 0;
> > > +	unsigned long flags;
> > > +	struct counter_event_node *event_node;
> > > +	struct counter_comp_node *comp_node;
> > > +	int err = 0;
> > > +
> > > +	ev.timestamp = ktime_get_ns();
> > > +	ev.watch.event = event;
> > > +	ev.watch.channel = channel;
> > > +
> > > +	raw_spin_lock_irqsave(&counter->events_lock, flags);
> > > +
> > > +	/* Search for event in the list */
> > > +	list_for_each_entry(event_node, &counter->events_list, l)
> > > +		if (event_node->event == event &&
> > > +		    event_node->channel == channel)
> > > +			break;
> > > +
> > > +	/* If event is not in the list */
> > > +	if (&event_node->l == &counter->events_list)
> > > +		goto exit_early;
> > > +
> > > +	/* Read and queue relevant comp for userspace */
> > > +	list_for_each_entry(comp_node, &event_node->comp_list, l) {
> > > +		err = counter_get_data(counter, comp_node, &ev.value);
> > > +		if (err)
> > > +			goto exit_early;
> > > +
> > > +		ev.watch.component = comp_node->component;
> > > +
> > > +		copied += kfifo_put(&counter->events, ev);  
> > 
> > We want to calculate the frequency of some IRQ pulses in user space and
> > counter values with time stamps really fits well here. As the pulses are
> > from a physical system (rotating wheel), they will only change at a
> > certain rate. We want to have the possibility to read from the counter
> > device less often, we intentionally want to skip (meaning miss)
> > events.
> > 
> > When reading we're interested in the newest events. The kfifo implements
> > a "tail" drop FIFO, which means new values are added at the end, and if
> > the FIFO is full, they are dropped. We need a "head" drop FIFO which
> > discards the oldest events, keeping only the recent ones.
> > 
> > As far as we know, kfifo doesn't offer a head drop mode, but I think
> > this can be added.  
> 
> I'm not sure if kfifo has this kind of mode, but it seems like something
> that should be there if it is not already -- I imagine this kind of
> operation mode would be pretty common. Perhaps someone knows how to
> achieve this and will share here.
> 

I don't think it does.  In IIO we started with a ring (effectively this)
- hopefully no one else remembers the horrible mess I made of it ;),
but eventually decided that there were very few usecases that
actually demanded it so just switched over to kfifo.

It's actually pretty rare that you aren't better off draining to
a backing store of some type.

Not had any demand to bring a ring back to IIO since we dropped it.


> > 
> > [...]
> >   
> > >  struct counter_device {
> > >  	const char *name;
> > > @@ -270,12 +270,20 @@ struct counter_device {
> > >  
> > >  	int id;
> > >  	struct device dev;
> > > +	struct cdev chrdev;
> > > +	raw_spinlock_t events_lock;
> > > +	struct list_head events_list;
> > > +	struct list_head next_events_list;
> > > +	DECLARE_KFIFO(events, struct counter_event, 64);  
> > 
> > Do you plan to make the size of the FIFO configurable?
> > 
> > regards,
> > Oleksij & Marc  
> 
> I suppose it wouldn't be a problem to make this a configurable setting;
> I think I can implement this via kfifo_alloc() and kfifo_free(). How
> would users control this -- maybe using a sysfs attribute?

Would make sense to do it from sysfs.

Jonathan

> 
> William Breathitt Gray
> 

