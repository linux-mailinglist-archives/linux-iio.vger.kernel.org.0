Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 242544189D5
	for <lists+linux-iio@lfdr.de>; Sun, 26 Sep 2021 17:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232211AbhIZPOW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 26 Sep 2021 11:14:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:34532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232258AbhIZPNd (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 26 Sep 2021 11:13:33 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C6B126108E;
        Sun, 26 Sep 2021 15:11:52 +0000 (UTC)
Date:   Sun, 26 Sep 2021 16:15:42 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     linux-stm32@st-md-mailman.stormreply.com, kernel@pengutronix.de,
        a.fatoum@pengutronix.de, kamel.bouhara@bootlin.com,
        gwendal@chromium.org, alexandre.belloni@bootlin.com,
        david@lechnology.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        syednwaris@gmail.com, patrick.havelange@essensium.com,
        fabrice.gasnier@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, o.rempel@pengutronix.de,
        jarkko.nikula@linux.intel.com,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v16 07/14] counter: Add character device interface
Message-ID: <20210926161542.5cf99b58@jic23-huawei>
In-Reply-To: <YUhdyRdzuBtUxOzT@shinobu>
References: <cover.1630031207.git.vilhelm.gray@gmail.com>
        <422c765c91d060cdebc4f17f7aeb255d9c1a4e16.1630031207.git.vilhelm.gray@gmail.com>
        <20210912171821.54af145b@jic23-huawei>
        <YUhdyRdzuBtUxOzT@shinobu>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 20 Sep 2021 19:09:13 +0900
William Breathitt Gray <vilhelm.gray@gmail.com> wrote:

> On Sun, Sep 12, 2021 at 05:18:42PM +0100, Jonathan Cameron wrote:
> > On Fri, 27 Aug 2021 12:47:51 +0900
> > William Breathitt Gray <vilhelm.gray@gmail.com> wrote:
> >   
> > > This patch introduces a character device interface for the Counter
> > > subsystem. Device data is exposed through standard character device read
> > > operations. Device data is gathered when a Counter event is pushed by
> > > the respective Counter device driver. Configuration is handled via ioctl
> > > operations on the respective Counter character device node.
> > > 
> > > Cc: David Lechner <david@lechnology.com>
> > > Cc: Gwendal Grignou <gwendal@chromium.org>
> > > Cc: Dan Carpenter <dan.carpenter@oracle.com>
> > > Cc: Oleksij Rempel <o.rempel@pengutronix.de>
> > > Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>  
> > 
> > Hi William,
> > 
> > Why the bit based lock?  It feels like a mutex_trylock() type approach or
> > spinlock_trylock() would be a more common solution to this problem.
> > There is precedence for doing what you have here though so I'm not that
> > worried about it.  
> 
> Hi Jonathan,
> 
> We originally used a mutex for this, but Jarkko discovered that this
> produced a warning because chrdev_lock would be held when returning to
> user space:
> https://lore.kernel.org/linux-arm-kernel/YOq19zTsOzKA8v7c@shinobu/T/#m6072133d418d598a5f368bb942c945e46cfab9a5
> 
> Following David Lechner's suggestion, I decided to reimplement
> chrdev_lock as a bitmap using an atomic flag.

Ok.  I'm not sure bit lock was quite what was intended (as there is only one of them)
but I suppose it doesn't greatly matter.

> 
> > There are a few more things inline.
> > 
> > I've now been through this patch with as fine toothed comb as I'm likely to
> > do so.  Hence I won't do another review unless there are substantial changes.
> > I nearly applied it as it stands, but given we aren't in a rush (merge window
> > open), it's worth just a little more time to tidy up loose ends.
> > 
> > Jonathan  
> 
> Responses follow below.

...
...

> > > +static int counter_chrdev_release(struct inode *inode, struct file *filp)
> > > +{
> > > +	struct counter_device *const counter = filp->private_data;
> > > +	int ret = 0;
> > > +
> > > +	mutex_lock(&counter->ops_exist_lock);
> > > +
> > > +	if (!counter->ops) {  
> > 
> > This needs a comment to explain how you would get here and
> > why these two lists need cleaning up here if we do.
> > 
> > Superficially it feels to me like you could just add a counter->ops check in
> > counter_disable_events() and then call that directly.  I'm guessing
> > I am missing a deadlock or similar however.  
> 
> I don't believe there is a risk of a deadlock, I just felt this
> conditional check isn't really related to the counter_disable_events()
> path so I kept it seperate; the events lists are freed in
> counter_disable_events() but that's incidental rather than the purpose
> of the function. My reasoning for the separation is that there are two
> scenarios where counter_chrdev_release is called: the first is when a
> user closes the chrdev, while the second is when the Counter driver is
> removed.
> 
> For the first scenario, the counter_disable_events() function is called
> to stop events from firing off when noone has the chrdev open. In the
> second scenario, we are not interested in disabling events, we know
> we're no longer going to be interacting with this device again so we
> want to free any held memory.
> 
> I want to keep the intention of these code paths clear because the
> distinction is important if we start managing additional memory in the
> future (i.e. memory unrelated to the events list that would not be freed
> in counter_disable_events()), so I'll add a comment explaining what's
> happening in this path. Alternatively, I could define a
> counter_chrdev_free() function and toss those list free calls into
> there, but perhaps that would be overkill right now for just two calls.

A comment would be enough for now I think.

> 
> > > +		counter_events_list_free(&counter->events_list);
> > > +		counter_events_list_free(&counter->next_events_list);
> > > +		ret = -ENODEV;
> > > +		goto out_unlock;
> > > +	}
> > > +
> > > +	ret = counter_disable_events(counter);
> > > +	if (ret < 0) {
> > > +		mutex_unlock(&counter->ops_exist_lock);
> > > +		return ret;
> > > +	}
> > > +
> > > +out_unlock:
> > > +	mutex_unlock(&counter->ops_exist_lock);
> > > +
> > > +	put_device(&counter->dev);
> > > +	clear_bit_unlock(0, counter->chrdev_lock);
> > > +
> > > +	return ret;
> > > +}
> > > +
> > > +static const struct file_operations counter_fops = {
> > > +	.owner = THIS_MODULE,
> > > +	.llseek = no_llseek,
> > > +	.read = counter_chrdev_read,
> > > +	.poll = counter_chrdev_poll,
> > > +	.unlocked_ioctl = counter_chrdev_ioctl,
> > > +	.open = counter_chrdev_open,
> > > +	.release = counter_chrdev_release,
> > > +};
> > > +
> > > +int counter_chrdev_add(struct counter_device *const counter)  
> > 
> > To think about: This isn't doing the add. So would counter_chrdev_init() be more
> > appropriate? The fact it can fail due to the kfifo_alloc makes that
> > naming less than ideal though.  
> 
> I've been using the "add" here to refer to adding the chrdev to the
> counter_device structure rather than to the rest of the system. I used a
> similar naming convention for the counter-sysfs.c file so I think
> "counter_chrdev_add" here should be all right and is consistent with the
> existing "counter_sysfs_add" function.

Hmm. I'll go with maybe and reserve the right to say I told you so if
it ever causes problem (and I can remember this discussion which is
fairly unlikely!).

...


...

> > >  
> > >  /**
> > > @@ -260,6 +289,16 @@ struct counter_ops {
> > >   * @num_ext:		number of Counter device extensions specified in @ext
> > >   * @priv:		optional private data supplied by driver
> > >   * @dev:		internal device structure
> > > + * @chrdev:		internal character device structure
> > > + * @events_list:	list of current watching Counter events
> > > + * @events_list_lock:	lock to protect Counter events list operations
> > > + * @next_events_list:	list of next watching Counter events
> > > + * @n_events_list_lock:	lock to protect Counter next events list operations
> > > + * @events:		queue of detected Counter events
> > > + * @events_wait:	wait queue to allow blocking reads of Counter events
> > > + * @events_lock:	lock to protect Counter events queue read operations
> > > + * @chrdev_lock:	lock to limit chrdev to a single open at a time
> > > + * @ops_exist_lock:	lock to prevent use during removal
> > >   */
> > >  struct counter_device {
> > >  	const char *name;
> > > @@ -278,12 +317,24 @@ struct counter_device {
> > >  	void *priv;
> > >  
> > >  	struct device dev;
> > > +	struct cdev chrdev;
> > > +	struct list_head events_list;
> > > +	spinlock_t events_list_lock;
> > > +	struct list_head next_events_list;
> > > +	struct mutex n_events_list_lock;
> > > +	DECLARE_KFIFO_PTR(events, struct counter_event);
> > > +	wait_queue_head_t events_wait;
> > > +	struct mutex events_lock;
> > > +	DECLARE_BITMAP(chrdev_lock, 1);  
> > 
> > Why use a bitmap for this rather than any of the other lock types?  
> 
> We can't use a mutex due to the problems mentioned in
> https://lore.kernel.org/linux-arm-kernel/YOq19zTsOzKA8v7c@shinobu/T/#m6072133d418d598a5f368bb942c945e46cfab9a5
> so I think a bitmap might be the most straightforward solution here. It
> goes without saying that I'm open to any other suggestions as well if
> there is a better solution for this case.

Add a comment here so no one tries to refactor it in the future without
understanding  your reasoning.

> 
> William Breathitt Gray


Thanks,

Jonathan
