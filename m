Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D31F43237FD
	for <lists+linux-iio@lfdr.de>; Wed, 24 Feb 2021 08:36:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233221AbhBXHgD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 24 Feb 2021 02:36:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbhBXHfx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 24 Feb 2021 02:35:53 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AA16C06178A
        for <linux-iio@vger.kernel.org>; Tue, 23 Feb 2021 23:35:12 -0800 (PST)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1lEohP-00085o-3R; Wed, 24 Feb 2021 08:35:07 +0100
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1lEohO-0000fu-9u; Wed, 24 Feb 2021 08:35:06 +0100
Date:   Wed, 24 Feb 2021 08:35:06 +0100
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     devicetree@vger.kernel.org, Ahmad Fatoum <a.fatoum@pengutronix.de>,
        linux-iio@vger.kernel.org,
        Robin van der Gracht <robin@protonic.nl>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v5 2/2] counter: add IRQ or GPIO based event counter
Message-ID: <20210224073506.GA24260@pengutronix.de>
References: <20210208135347.18494-1-o.rempel@pengutronix.de>
 <20210208135347.18494-3-o.rempel@pengutronix.de>
 <YCjlPhEtyH+vfSi4@shinobu>
 <20210215091737.fx6dwiz7tt56wbkr@pengutronix.de>
 <YDMMJJ985Zq9oEOv@shinobu>
 <20210223100656.efbshsh5bz66uhj5@pengutronix.de>
 <20210223174516.wjlh7hnrd5qe5s6w@pengutronix.de>
 <YDW7Hihg0gGQh8UR@shinobu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YDW7Hihg0gGQh8UR@shinobu>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 08:12:53 up 19:50, 18 users,  load average: 0.13, 0.12, 0.11
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello William,

On Wed, Feb 24, 2021 at 11:34:06AM +0900, William Breathitt Gray wrote:
> On Tue, Feb 23, 2021 at 06:45:16PM +0100, Oleksij Rempel wrote:
> > Hello William,
> > 
> > Here is cooled down technical answer. Excuse me for over reacting.
> 
> Hello Oleksij,
> 
> Let me apologize too if I offended you in some way in with previous
> response, I assure you that was not my intention. I truly do believe
> this is a useful driver to have in the kernel and I want to make that
> happen; my concerns with your patch are purely technical in nature and 
> I'm certain we can find a solution working together.

No problem :)

> > On Tue, Feb 23, 2021 at 11:06:56AM +0100, Oleksij Rempel wrote:
> > > On Mon, Feb 22, 2021 at 10:43:00AM +0900, William Breathitt Gray wrote:
> > > > On Mon, Feb 15, 2021 at 10:17:37AM +0100, Oleksij Rempel wrote:
> > > > > > > +static irqreturn_t event_cnt_isr(int irq, void *dev_id)
> > > > > > > +{
> > > > > > > +	struct event_cnt_priv *priv = dev_id;
> > > > > > > +
> > > > > > > +	atomic_inc(&priv->count);
> > > > > > 
> > > > > > This is just used to count the number of interrupts right? I wonder if
> > > > > > we can do this smarter. For example, the kernel already keeps track of
> > > > > > number of interrupts that has occurred for any particular IRQ line on a
> > > > > > CPU (see the 'kstat_irqs' member of struct irq_desc, and the
> > > > > > show_interrupts() function in kernel/irq/proc.c). Would it make sense to
> > > > > > simply store the initial interrupt count on driver load or enablement,
> > > > > > and then return the difference during a count_read() callback?
> > > > > 
> > > > > This driver do not makes a lot of sense without your chardev patches. As
> > > > > soon as this patches go mainline, this driver will be able to send
> > > > > event with a timestamp and counter state to the user space.
> > > > > 
> > > > > With other words, we will need an irq handler anyway. In this case we
> > > > > can't save more RAM or CPU cycles by using system irq counters.
> > > > 
> > > > It's true that this driver will need an IRQ handler when the timestamp
> > > > functionality is added, but deriving the count value is different matter
> > > > regardless. There's already code in the kernel to retrieve the number of
> > > > interrupts, so it makes sense that we use that rather than rolling our
> > > > own -- at the very least to ensure the value we provide to users is
> > > > consistent with the ones already provided by other areas of the kernel.
> > 
> > The value provided by the driver is consistent only if it is not
> > overwritten by user. The driver provides an interface to reset/overwrite it.
> > At least after this step the value is not consistent.
> 
> I wasn't clear here so I apologize. What I would like is for this driver
> to maintain its own local count value derived from kstat_irqs_usr(). So
> for example, you can use the "count" member of your struct
> interrupt_cnt_priv to maintain this value (it can be unsigned int
> instead of atomic_t):
> 
> static int interrupt_cnt_read(struct counter_device *counter,
> 			      struct counter_count *count, unsigned long *val)
> {
> 	struct interrupt_cnt_priv *priv = counter->priv;
> 
> 	*val = kstat_irqs_usr(priv->irq) - priv->count;
> 
> 	return 0;
> }
> 
> static int interrupt_cnt_write(struct counter_device *counter,
> 			       struct counter_count *count,
> 			       const unsigned long val)
> {
> 	struct interrupt_cnt_priv *priv = counter->priv;
> 
> 	/* kstat_irqs_usr() returns unsigned int */
> 	if (val != (unsigned int)val)
> 		return -ERANGE;
> 
> 	priv->count = val;
> 
> 	return 0;
> }

I understand this part. There is no need to spend extra CPU cycles if
the interrupt was already counted. Just read it on user request and
calculate the offset if needed.

As soon as timestamp support is available, I will need to go back to
local counter, because the kstat_irqs_usr() will take a lot more CPU
cycles compared to private counter (it sums over all CPU local
counters). So it's better to increment a single variable, then to call
kstat_irqs_usr() from interrupt handler at IRQ rate several 10 thousands
interrupts per second.

> > > We are talking about one or two code lines. If we will take some
> > > duplication search engine, it will find that major part of the kernel
> > > is matching against it.
> > > 
> > > Newer the less, this driver provides a way to reset the counter. Why
> > > should we drop this functionality no advantage?
> > > 
> > > > To that end, I'd like to see your cnt_isr() function removed for this
> > > > patchset (you can bring it back once timestamp support is added).
> > 
> > It make no sense to request an interrupt without interrupt service
> > routine.
> > 
> > https://elixir.bootlin.com/linux/latest/source/kernel/irq/manage.c#L2072if
> > 	if (!handler) {
> > 		if (!thread_fn)
> > 			return -EINVAL;
> > 
> > As you can see, requesting an irq need at least handler or thread_fn.
> > 
> > enable_irq: this will explode at least here:
> > https://elixir.bootlin.com/linux/latest/source/kernel/irq/manage.c#L778
> > 
> > If he have no IRQ handler and some how was able to enable it, at
> > some point this IRQ will be disabled by this code:
> > https://elixir.bootlin.com/linux/latest/source/kernel/irq/spurious.c#L410
> > 	if (unlikely(desc->irqs_unhandled > 99900)) {
> > 		/*
> > 		 * The interrupt is stuck
> > 		 */
> > 		__report_bad_irq(desc, action_ret);
> > 		/*
> > 		 * Now kill the IRQ
> > 		 */
> > 		printk(KERN_EMERG "Disabling IRQ #%d\n", irq);
> > 		desc->istate |= IRQS_SPURIOUS_DISABLED;
> > 		desc->depth++;
> > 		irq_disable(desc);
> > 
> > With current code, we can't request or enable IRQ without cnt_isr(). Not
> > that it is not possible, but it make no sense to me.
> 
> What I'm requesting is to remove the interrupt code from this driver for
> now including the cnt_enable_write() callback. Yes, we will need it when
> timestamp functionality is added, but currently the Counter subsystem
> does not have that functionality yet. Once the Counter character device
> interface is merged, then it makes sense to add the interrupt service
> routine to push timestamps to the user.
> 
> It is still useful to have this driver mainlined even without the
> interrupt code: getting the body of this driver merged means a much
> easier review of the timestamp code in the future, and users can start
> using current Counter sysfs interface to track their GPIO interrupts.

This driver, even without timestamping support, can't work without
interrupt code. request_irq is the core functionality of it. The kernel
interrupt infrastructure will not enable a IRQ and it will not provide
stats without request_irq().

The minimal requirement to make it work is to call request_irq() with
a handler which will return IRQ_HANDLED value.

It makes no sense to mainline this driver without IRQ code, because it
will not work. And if we need an IRQ handler anyway, and will need local
count anyway, why should we go extra way around? :)

> > > Are you suggesting to enable IRQ without interrupt handler? May be i'm
> > > missing some thing.. I do not understand it.
> > > 
> > > > Reimplement your cnt_read/cnt_write() functions to instead use
> > > > kstat_irqs_usr() from <linux/kernel_stat.h> to get the current number of
> > > > interrupts the IRQ line and use it to derive your count value for this
> > > > driver.
> > 
> > irq descriptor has 3 counters:
> > - irq_count: this value can be reset any time by the kernel at least by
> >   the note_interrupt()
> > - irqs_unhandled: this value is increased in case of missing irq
> >   handler. Or if handler has returns IRQ_NONE.
> > - tot_count: this value should not be reset.
> > 
> > Non of this values is suitable for cnt_read() and cnt_write(). Only
> > tot_count would be suitable if cnt_write() is removed. I do not see it
> > as acceptable option.
> > 
> > For this driver, we still need extra counter, where only this driver is
> > responsible for writing to it.
> 
> Yes, I'm sorry for not being clear before. Please use priv->count for
> this; there's no need to adjust directly the system irq count.
> 
> > > I can follow the counter read way, but overwriting system wide counter
> > > for local use is bad idea.
> > > 
> > > > > > > +static struct counter_signal event_cnt_signals[] = {
> > > > > > > +	{
> > > > > > > +		.id = 0,
> > > > > > > +		.name = "Channel 0 signal",
> > > > > > 
> > > > > > You should choose a more description name for this Signal;
> > > > > > "Channel 0 signal" isn't very useful information for the user. Is this
> > > > > > signal the respective GPIO line state?
> > > > > 
> > > > > Sounds plausible. How about "Channel 0, GPIO line state"?
> > > > 
> > > > Ideally, this would match the GPIO name (or I suppose the IRQ number if
> > > > not a GPIO line). So in your probe() function you can do something like
> > > > this I believe:
> > > > 
> > > > 	cnt_signals[0].name = priv->gpio->name;
> > > 
> > 
> > > to make this possible, i would need hack gpiolib framework and add
> > > name/label exporter. But after endless rounds of pingponging me for
> > > renaming the driver and removing interrupt handler, i feel like we are
> > > not having serious discussion for mainlining this driver.
> > 
> > Probably for good reason, struct gpio_desc was made local and is located
> > in the drivers/gpio/gpiolib.h. It feels like additional hack to include
> > it. I assume, it should be done properly so there is a function to
> > provide gpio name or label.
> > 
> > @Linus Walleij are there any good way to get the GPIO name? And which
> > name will be actually used? A label provided over devicetree?
> 
> Perhaps one of the GPIO subsystem maintainers can provide more guidance
> here, but I was under the impression that this name was provided
> statically by the respective GPIO driver via their struct gpio_chip. I
> think you can see the array of names via priv->gpio->gdev->chip->names.
> 
> Alternatively, we can take a more generic approach: ignore the GPIO
> names and focus solely on the IRQ lines; because the GPIO lines will
> always be tied to respective IRQ lines here, using the IRQ as the basis
> of the name should always be valid. The "name" member of the struct
> irq_chip can work for this. I haven't tested this, but I think something
> like this would work:
> 
> 	cnt_signals[0].name = irq_get_chip(priv->irq)->name;

ok, i'll take a look at it.

> > If I see it correctly, it would need more work to make the kernel infrastructure
> > suitable for this suggestions. Some of them are only needed before
> > chardev support will go mainline and , in long term, not worth to
> > spend time on it.
> 
> I disagree, I think there is benefit in getting this driver merged
> even if we don't have the interrupt service routine. Although I
> recommend we keep this initial patch simple to introduce the driver,
> later on you can for example add support for other Counter sysfs
> attributes such as "ceiling" and "floor" if users want to specify count
> limits, or perhaps alternative count functions (maybe a user wants to
> the count to decrease instead of increase with every interrupt).
> 
> These other functionalities are tangental to the your timestamp interest
> for this driver, but I believe they will be useful to users at large as
> a convenient way to evaluate, track, and express the interrupt counts on
> their system.
> 
> William Breathitt Gray

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
