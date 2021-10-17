Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28B524309D0
	for <lists+linux-iio@lfdr.de>; Sun, 17 Oct 2021 16:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236695AbhJQOm1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 17 Oct 2021 10:42:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:59736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237972AbhJQOm0 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 17 Oct 2021 10:42:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 519B16103B;
        Sun, 17 Oct 2021 14:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1634481617;
        bh=yFokzv3wpJKEz8i/ueDpiyf7dalfoEdoP328kL01z5Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jdhzIg9PWvJ9gB7pq+4GqWniCadchsF7B2whNVeipbDqyzKEoqqlUrKKyUdfO/PIZ
         mhAKh74yT6zwxTrg+a4WlpDVmam2x+I3Sc3YEUq0M4Pcz7jNKVdUKh6gV4iqV4Qu4h
         8FTROEnuqqDSFeEL7Zoyy2+SNflEKDYIQHhlAlQ4=
Date:   Sun, 17 Oct 2021 16:40:14 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     William Breathitt Gray <vilhelm.gray@gmail.com>, jic23@kernel.org,
        linux-stm32@st-md-mailman.stormreply.com, kernel@pengutronix.de,
        a.fatoum@pengutronix.de, kamel.bouhara@bootlin.com,
        gwendal@chromium.org, david@lechnology.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, syednwaris@gmail.com,
        patrick.havelange@essensium.com, fabrice.gasnier@st.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        o.rempel@pengutronix.de, jarkko.nikula@linux.intel.com,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v17 2/9] counter: Add character device interface
Message-ID: <YWw1zoGX6SwSEVw/@kroah.com>
References: <cover.1632884256.git.vilhelm.gray@gmail.com>
 <b8b8c64b4065aedff43699ad1f0e2f8d1419c15b.1632884256.git.vilhelm.gray@gmail.com>
 <YWwqE5T6h5j14M/M@kroah.com>
 <YWwtAm0o6wVMG6xc@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YWwtAm0o6wVMG6xc@piout.net>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Oct 17, 2021 at 04:02:42PM +0200, Alexandre Belloni wrote:
> On 17/10/2021 15:50:11+0200, Greg KH wrote:
> > Note, review of this now that it has been submitted in a pull request to
> > me, sorry I missed this previously...
> > 
> > On Wed, Sep 29, 2021 at 12:15:59PM +0900, William Breathitt Gray wrote:
> > > +static int counter_chrdev_open(struct inode *inode, struct file *filp)
> > > +{
> > > +	struct counter_device *const counter = container_of(inode->i_cdev,
> > > +							    typeof(*counter),
> > > +							    chrdev);
> > > +
> > > +	/* Ensure chrdev is not opened more than 1 at a time */
> > > +	if (!atomic_add_unless(&counter->chrdev_lock, 1, 1))
> > > +		return -EBUSY;
> > 
> > I understand the feeling that you wish to stop userspace from doing
> > this, but really, it does not work.  Eventhough you are doing this
> > correctly (you should see all the other attempts at doing this), you are
> > not preventing userspace from having multiple processes access this
> > device node at the same time, so please, don't even attempt to stop this
> > from happening.
> > 
> > So you can drop the atomic "lock" you have here, it's not needed at all.
> > 
> 
> Could you elaborate a bit here because we've had a similar thing in the
> RTC subsystem:
> 
> https://elixir.bootlin.com/linux/latest/source/drivers/rtc/dev.c#L28

Yeah, that too will not work :(  Note, it does stop open from being
called from different processes, but think of the following sequence of
userspace calls:
	open()
	fork/exec()
	both processes access the file descriptor

or passing a fd across a socket?

Or duplicating the file descriptor and sending it to a different task
(like across a socket or many other IPC ways)?

Once userspace has a file descriptor, all bets are off as to where it
goes and what it does with it.  There's no need to try to save userspace
from itself by preventing multiple opens when really, it doesn't stop
anyone who really wants to do this.

If userspace does do multiple read/writes from different threads /
processes / whatever on the same file descriptor, it gets to keep the
pieces of the mess it causes.  It's not the kernel's job to try to
"protect" userspace from itself here.

Look at serial/tty connections as one example of this always being the
case.

Does that help?

> And it would mean I can remove rtc->flags completely.

I think you can do that.

thanks,

greg k-h
