Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07AB2432EF5
	for <lists+linux-iio@lfdr.de>; Tue, 19 Oct 2021 09:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233540AbhJSHKE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 Oct 2021 03:10:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:37338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233888AbhJSHKD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 19 Oct 2021 03:10:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 83F7660F57;
        Tue, 19 Oct 2021 07:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1634627271;
        bh=9NWra0MrWNxt/ijez1QlcO7hL2hPgZ6QW5QwvinEBXQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OsD5ZsWi/IYbJo6gbWBxi26a/fwe5GCv+VdXFtq1GJy5t8mJVSdQ3FZXJk8pDSJnL
         ejrC3wqkB6/ImybwW60qVmUr3Gw00MjRbBfLv1gMdtH8lw8EKcbBKVxh/z0NzF5lT+
         a+IurMC9D4grU7ppWRPW1DQpe4CVuYcfdrq/RWOc=
Date:   Tue, 19 Oct 2021 09:07:48 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     David Lechner <david@lechnology.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] counter: drop chrdev_lock
Message-ID: <YW5uxIQ1WuW66cf0@kroah.com>
References: <20211017185521.3468640-1-david@lechnology.com>
 <YW0673OckeCY6Qs/@shinobu>
 <e8158cd7-fbde-5a9a-f4d9-a863745e3d58@lechnology.com>
 <YW5rVLrbrVVJ75SY@shinobu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YW5rVLrbrVVJ75SY@shinobu>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Oct 19, 2021 at 03:53:08PM +0900, William Breathitt Gray wrote:
> On Mon, Oct 18, 2021 at 11:03:49AM -0500, David Lechner wrote:
> > On 10/18/21 4:14 AM, William Breathitt Gray wrote:
> > > On Sun, Oct 17, 2021 at 01:55:21PM -0500, David Lechner wrote:
> > >> diff --git a/drivers/counter/counter-sysfs.c b/drivers/counter/counter-sysfs.c
> > >> index 1ccd771da25f..7bf8882ff54d 100644
> > >> --- a/drivers/counter/counter-sysfs.c
> > >> +++ b/drivers/counter/counter-sysfs.c
> > >> @@ -796,25 +796,18 @@ static int counter_events_queue_size_write(struct counter_device *counter,
> > >>   					   u64 val)
> > >>   {
> > >>   	DECLARE_KFIFO_PTR(events, struct counter_event);
> > >> -	int err = 0;
> > >> -
> > >> -	/* Ensure chrdev is not opened more than 1 at a time */
> > >> -	if (!atomic_add_unless(&counter->chrdev_lock, 1, 1))
> > >> -		return -EBUSY;
> > >> +	int err;
> > >>   
> > >>   	/* Allocate new events queue */
> > >>   	err = kfifo_alloc(&events, val, GFP_KERNEL);
> > >>   	if (err)
> > >> -		goto exit_early;
> > >> +		return err;
> > >>   
> > >>   	/* Swap in new events queue */
> > >>   	kfifo_free(&counter->events);
> > >>   	counter->events.kfifo = events.kfifo;
> > > 
> > > Do we need to hold the events_lock mutex here for this swap in case
> > > counter_chrdev_read() is in the middle of reading the kfifo to
> > > userspace, or do the kfifo macros already protect us from a race
> > > condition here?
> > > 
> > Another possibility might be to disallow changing the size while
> > events are enabled. Otherwise, we also need to protect against
> > write after free.
> > 
> > I considered this:
> > 
> > 	swap(counter->events.kfifo, events.kfifo);
> > 	kfifo_free(&events);
> > 
> > But I'm not sure that would be safe enough.
> 
> I think it depends on whether it's safe to call kfifo_free() while other
> kfifo_*() calls are executing. I suspect it is not safe because I don't
> think kfifo_free() waits until all kfifo read/write operations are
> finished before freeing -- but if I'm wrong here please let me know.
> 
> Because of that, will need to hold the counter->events_lock afterall so
> that we don't modify the events fifo while a kfifo read/write is going
> on, lest we suffer an address fault. This can happen regardless of
> whether you swap before or after the kfifo_free() because the old fifo
> address could still be in use within those uncompleted kfifo_*() calls
> if they were called before the swap but don't complete before the
> kfifo_free().
> 
> So we have a problem now that I think you have already noticed: the
> kfifo_in() call in counter_push_events() also needs protection, but it's
> executing within an interrupt context so we can't try to lock a mutex
> lest we end up sleeping.
> 
> One option we have is as you suggested: we disallow changing size while
> events are enabled. However, that will require us to keep track of when
> events are disabled and implement a spinlock to ensure that we don't
> disable events in the middle of a kfifo_in().
> 
> Alternatively, we could change events_lock to a spinlock and use it to
> protect all these operations on the counter->events fifo. Would this
> alternative be a better option so that we avoid creating another
> separate lock?

I would recommend just having a single lock here if at all possible,
until you determine that there a performance problem that can be
measured that would require it to be split up.

thanks,

greg k-h
