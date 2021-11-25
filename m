Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDF9C45D598
	for <lists+linux-iio@lfdr.de>; Thu, 25 Nov 2021 08:37:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232991AbhKYHlD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 25 Nov 2021 02:41:03 -0500
Received: from protonic.xs4all.nl ([83.163.252.89]:38884 "EHLO
        protonic.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235464AbhKYHjD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 25 Nov 2021 02:39:03 -0500
X-Greylist: delayed 510 seconds by postgrey-1.27 at vger.kernel.org; Thu, 25 Nov 2021 02:39:02 EST
Received: from erd992 (erd988.prtnl [192.168.224.30])
        by sparta.prtnl (Postfix) with ESMTP id E7E3E44A024F;
        Thu, 25 Nov 2021 08:27:20 +0100 (CET)
Date:   Thu, 25 Nov 2021 08:27:20 +0100
From:   David Jander <david@protonic.nl>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>,
        linux-iio@vger.kernel.org,
        Robin van der Gracht <robin@protonic.nl>,
        linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Jonathan Cameron <jic23@kernel.org>, david@lechnology.com
Subject: Re: [PATCH v1] counter: interrupt-cnt: add counter_push_event()
Message-ID: <20211125082720.13782d83@erd992>
In-Reply-To: <YZ7tv79LQwLL7h3T@shinobu>
References: <20211123134540.416695-1-o.rempel@pengutronix.de>
        <YZ3XAeYyfGblfaOi@shinobu>
        <20211124072720.GA30281@pengutronix.de>
        <YZ7tv79LQwLL7h3T@shinobu>
Organization: Protonic Holland
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 25 Nov 2021 10:58:23 +0900
William Breathitt Gray <vilhelm.gray@gmail.com> wrote:

> On Wed, Nov 24, 2021 at 08:27:20AM +0100, Oleksij Rempel wrote:
> > Hi William,
> > 
> > On Wed, Nov 24, 2021 at 03:09:05PM +0900, William Breathitt Gray wrote:  
> > > On Tue, Nov 23, 2021 at 02:45:40PM +0100, Oleksij Rempel wrote:  
> > > > Add counter_push_event() to notify user space about new pulses
> > > > 
> > > > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > > > ---
> > > >  drivers/counter/interrupt-cnt.c | 2 ++
> > > >  1 file changed, 2 insertions(+)
> > > > 
> > > > diff --git a/drivers/counter/interrupt-cnt.c b/drivers/counter/interrupt-cnt.c
> > > > index 8514a87fcbee..b237137b552b 100644
> > > > --- a/drivers/counter/interrupt-cnt.c
> > > > +++ b/drivers/counter/interrupt-cnt.c
> > > > @@ -31,6 +31,8 @@ static irqreturn_t interrupt_cnt_isr(int irq, void *dev_id)
> > > >  
> > > >  	atomic_inc(&priv->count);
> > > >  
> > > > +	counter_push_event(&priv->counter, COUNTER_EVENT_OVERFLOW, 0);
> > > > +
> > > >  	return IRQ_HANDLED;
> > > >  }
> > > >  
> > > > -- 
> > > > 2.30.2  
> > > 
> > > Hi Oleksij,
> > > 
> > > It looks like this is pushing a COUNTER_EVENT_OVERFLOW event every time
> > > an interrupt is handled, which I suspect is not what you want to happen.
> > > The COUNTER_EVENT_OVERFLOW event indicates a count value overflow event,
> > > so you'll need to check for a count value overflow before pushing the
> > > event.
> > > 
> > > It would be good idea to implement a ceiling extension as well (you can
> > > use the COUNTER_COMP_CEILING() macro) so that users can configure the
> > > particular point where the value overflows.  
> > 
> > Thank you!
> > 
> > What would be the best and resource effective strategy for periodically
> > getting frequency of interrupts/pulses? This is actual information which is
> > needed for my use case.
> > 
> > So far, I was pushing every event to the user space, which is working
> > but probably not the most resource effective method of doing it.
> > 
> > Regards,
> > Oleskij
> > -- 
> > Pengutronix e.K.                           |                             |
> > Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
> > 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
> > Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |  
> 
> We could introduce a new Counter change-of-state event type which would
> trigger whenever the count value changes, but I agree with you that this
> is likely not the best way for us to derive the frequency of the
> interrupts due to the indirection of handling and parsing the event
> data.

Also something I am worried about, is the overhead it creates to generate such
an event on each and every IRQ. Looking at counter_push_event(), I can see it
using a spin-lock, besides quite a bit of code potentially being executed,
depending on user-space. The lock can probably be held by non-IRQ code
also, which can potentially introduce more latency and cause high-frequency
interrupts to be delayed far too long. This particular driver uses
atomic_inc() to increment a counter, which AFAIK on most machines should be a
single instruction. The main application for this driver is to count pulses
_fast_ with minimal CPU load. IMHO we should do better than potentially
blocking on a spin-lock in IRQ context.
I know this is akin to trying to do hard-real-time stuff in the kernel, but
since its main application is for embedded systems that have a known and
controllable interrupt environment most of the time, this can be done if one
is careful to not do certain things in IRQ context, such as using locks.

> Instead, perhaps introducing a "frequency" or "period" Count extension
> would make more sense here. This extension could report the value delta
> between counts, or alternatively the time delta from which you can
> derive frequency. Regarding implementation, you can store the previous
> value in a variable, updating it whenever an interrupt occurs, and
> compute the particular delta every time a read is requested by the user.

The original version of this driver used a circular buffer that stored the
timestamps of the last 'n' interrupts. A user-space read action would copy this
buffer repeatedly (max tries --> fail) until two copies are identical to
ensure integrity avoiding the use of locks. This is of course dead ugly and I
was hoping for a better solution. But to be better IMHO it must avoid locks in
IRQ context at all costs.
Having a sample 'n' consecutive of time-stamps in user-space, made frequency
calculation, filtering and glitch detection quite simple.

> David Lechner is implementing something similar for the TI eQEP driver
> to expose speed, so I'm CCing them here in case this is of interest to
> them.

Best regards,

-- 
David Jander
Protonic Holland.

