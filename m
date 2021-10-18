Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 087F24312FB
	for <lists+linux-iio@lfdr.de>; Mon, 18 Oct 2021 11:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbhJRJPe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 18 Oct 2021 05:15:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:43166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231352AbhJRJPd (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 18 Oct 2021 05:15:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 79FB9610A6;
        Mon, 18 Oct 2021 09:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1634548398;
        bh=vBTVGA9M5jHoHMJ7gVkA4XvKfxKD3L12ATwHZEzqA3U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QRRgloi3vGHbfjUkSYvYBliGH68TQAlTFWabbSSlM6M0/+uGK+wteuQab6XV34oaX
         KdKbrDNOdczA2se5aH444OJKdCPERc+No6B7wc9bqqwaFh6svw4fEmVjWGjt1Sp6OY
         mdZubgL+O7ex8mKK6n6exqYt1P2cvRpbqhdFsSc0=
Date:   Mon, 18 Oct 2021 11:13:16 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     David Lechner <david@lechnology.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] counter: drop chrdev_lock
Message-ID: <YW06rLixA2Uush+n@kroah.com>
References: <20211017185521.3468640-1-david@lechnology.com>
 <YW0PVYT/GCKAnjN9@kroah.com>
 <YW03PSmpMkMVnHdp@shinobu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YW03PSmpMkMVnHdp@shinobu>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Oct 18, 2021 at 05:58:37PM +0900, William Breathitt Gray wrote:
> On Mon, Oct 18, 2021 at 08:08:21AM +0200, Greg KH wrote:
> > On Sun, Oct 17, 2021 at 01:55:21PM -0500, David Lechner wrote:
> > > This removes the chrdev_lock from the counter subsystem. This was
> > > intended to prevent opening the chrdev more than once. However, this
> > > doesn't work in practice since userspace can duplicate file descriptors
> > > and pass file descriptors to other processes. Since this protection
> > > can't be relied on, it is best to just remove it.
> > 
> > Much better, thanks!
> > 
> > One remaining question:
> > 
> > > --- a/include/linux/counter.h
> > > +++ b/include/linux/counter.h
> > > @@ -297,7 +297,6 @@ struct counter_ops {
> > >   * @events:		queue of detected Counter events
> > >   * @events_wait:	wait queue to allow blocking reads of Counter events
> > >   * @events_lock:	lock to protect Counter events queue read operations
> > > - * @chrdev_lock:	lock to limit chrdev to a single open at a time
> > >   * @ops_exist_lock:	lock to prevent use during removal
> > 
> > Why do you still need 2 locks for the same structure?
> > 
> > thanks,
> > 
> > greg k-h
> 
> Originally there was only the events_lock mutex. Initially I tried using
> it to also limit the chrdev to a single open, but then came across a
> "lock held when returning to user space" warning:
> https://lore.kernel.org/linux-arm-kernel/YOq19zTsOzKA8v7c@shinobu/T/#m6072133d418d598a5f368bb942c945e46cfab9a5
> 
> Instead of losing the benefits of a mutex lock for protecting the
> events, I ultimately implemented the chrdev_lock separately as an
> atomic_t. If the chrdev_lock is removed, then we'll use events_lock
> solely from now on for this structure.

chrdev_lock should be removed, it doesn't really do what you think it
does, as per the thread yesterday :)

So does this mean you can also drop the ops_exist_lock?

thanks,

greg k-h
