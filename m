Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A44C326D89
	for <lists+linux-iio@lfdr.de>; Sat, 27 Feb 2021 16:19:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbhB0PTg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 27 Feb 2021 10:19:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:46530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229953AbhB0PTf (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 27 Feb 2021 10:19:35 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97A6C64E46;
        Sat, 27 Feb 2021 15:18:51 +0000 (UTC)
Date:   Sat, 27 Feb 2021 15:18:47 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     kernel@pengutronix.de, linux-stm32@st-md-mailman.stormreply.com,
        a.fatoum@pengutronix.de, kamel.bouhara@bootlin.com,
        gwendal@chromium.org, alexandre.belloni@bootlin.com,
        david@lechnology.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        syednwaris@gmail.com, patrick.havelange@essensium.com,
        fabrice.gasnier@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, o.rempel@pengutronix.de
Subject: Re: [PATCH v8 20/22] counter: Implement events_queue_size sysfs
 attribute
Message-ID: <20210227151847.074864df@archlinux>
In-Reply-To: <YDg65OmLa05g53qc@shinobu>
References: <cover.1613131238.git.vilhelm.gray@gmail.com>
        <013b2b8682ddc3c85038083e6d5567696b6254b3.1613131238.git.vilhelm.gray@gmail.com>
        <20210214181146.66d43da7@archlinux>
        <YC5CMLuKnXbkZond@shinobu>
        <20210221155140.3e1ef13c@archlinux>
        <YDg65OmLa05g53qc@shinobu>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 26 Feb 2021 09:03:48 +0900
William Breathitt Gray <vilhelm.gray@gmail.com> wrote:

> On Sun, Feb 21, 2021 at 03:51:40PM +0000, Jonathan Cameron wrote:
> > On Thu, 18 Feb 2021 19:32:16 +0900
> > William Breathitt Gray <vilhelm.gray@gmail.com> wrote:
> >   
> > > On Sun, Feb 14, 2021 at 06:11:46PM +0000, Jonathan Cameron wrote:  
> > > > On Fri, 12 Feb 2021 21:13:44 +0900
> > > > William Breathitt Gray <vilhelm.gray@gmail.com> wrote:
> > > >     
> > > > > The events_queue_size sysfs attribute provides a way for users to
> > > > > dynamically configure the Counter events queue size for the Counter
> > > > > character device interface. The size is in number of struct
> > > > > counter_event data structures. The number of elements will be rounded-up
> > > > > to a power of 2 due to a requirement of the kfifo_alloc function called
> > > > > during reallocation of the queue.
> > > > > 
> > > > > Cc: Oleksij Rempel <o.rempel@pengutronix.de>
> > > > > Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> > > > > ---
> > > > >  Documentation/ABI/testing/sysfs-bus-counter |  8 +++++++
> > > > >  drivers/counter/counter-chrdev.c            | 23 +++++++++++++++++++
> > > > >  drivers/counter/counter-chrdev.h            |  2 ++
> > > > >  drivers/counter/counter-sysfs.c             | 25 +++++++++++++++++++++
> > > > >  4 files changed, 58 insertions(+)
> > > > > 
> > > > > diff --git a/Documentation/ABI/testing/sysfs-bus-counter b/Documentation/ABI/testing/sysfs-bus-counter
> > > > > index 847e96f19d19..f6cb2a8b08a7 100644
> > > > > --- a/Documentation/ABI/testing/sysfs-bus-counter
> > > > > +++ b/Documentation/ABI/testing/sysfs-bus-counter
> > > > > @@ -212,6 +212,14 @@ Description:
> > > > >  		both edges:
> > > > >  			Any state transition.
> > > > >  
> > > > > +What:		/sys/bus/counter/devices/counterX/events_queue_size
> > > > > +KernelVersion:	5.13
> > > > > +Contact:	linux-iio@vger.kernel.org
> > > > > +Description:
> > > > > +		Size of the Counter events queue in number of struct
> > > > > +		counter_event data structures. The number of elements will be
> > > > > +		rounded-up to a power of 2.
> > > > > +
> > > > >  What:		/sys/bus/counter/devices/counterX/name
> > > > >  KernelVersion:	5.2
> > > > >  Contact:	linux-iio@vger.kernel.org
> > > > > diff --git a/drivers/counter/counter-chrdev.c b/drivers/counter/counter-chrdev.c
> > > > > index 16f02df7f73d..53eea894e13f 100644
> > > > > --- a/drivers/counter/counter-chrdev.c
> > > > > +++ b/drivers/counter/counter-chrdev.c
> > > > > @@ -375,6 +375,29 @@ void counter_chrdev_remove(struct counter_device *const counter)
> > > > >  	cdev_del(&counter->chrdev);
> > > > >  }
> > > > >  
> > > > > +int counter_chrdev_realloc_queue(struct counter_device *const counter,
> > > > > +				 size_t queue_size)
> > > > > +{
> > > > > +	int err;
> > > > > +	DECLARE_KFIFO_PTR(events, struct counter_event);
> > > > > +	unsigned long flags;
> > > > > +
> > > > > +	/* Allocate new events queue */
> > > > > +	err = kfifo_alloc(&events, queue_size, GFP_ATOMIC);    
> > > > 
> > > > Is there any potential for losing events?    
> > > 
> > > We take the events_list_lock down below so we're safe against missing an
> > > event, but past events currently unread in the queue will be lost.
> > > 
> > > Shortening the size of the queue is inherently a destructive process if
> > > we have more events in the current queue than can fit in the new queue.
> > > Because we a liable to lose some events in such a case, I think it's
> > > best to keep the behavior of this reallocation consistent and have it
> > > provide a fresh empty queue every time, as opposed to sometimes dropping
> > > events and sometimes not.
> > > 
> > > I also suspect an actual user would be setting the size of their queue
> > > to the required amount before they begin watching events, rather than
> > > adjusting it sporadically during a live operation.
> > >  
> > 
> > Absolutely agree.   As such I wonder if you are better off enforcing this
> > behaviour?  If the cdev is open for reading, don't allow the fifo to be
> > resized. 
> > 
> > Jonathan  
> 
> I can't really think of a good reason not to, so let's enforce it: if
> the cdev is open, then we'll return an EINVAL if the user attempts to
> resize the queue.
> 
> What is a good way to check for this condition? Should I just call
> kref_read() and see if it's greater than 1? For example, in
> counter_chrdev_realloc_queue():
> 
> 	if (kref_read(&counter->dev.kobj.kref) > 1)
> 		return -EINVAL;
In theory at least you might want the kobj.kref to be incremented
for other reasons than just open.   So to keep different concepts
separate, perhaps it's worth a separate variable somewhere to
track whether the file is open currently.

However, it's reasonable (I think) to assume the kref will have a
minimum value if open, so perhaps what you suggest works fine.

Jonathan

> 
> William Breathitt Gray

