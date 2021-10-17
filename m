Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 306D3430993
	for <lists+linux-iio@lfdr.de>; Sun, 17 Oct 2021 16:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236906AbhJQOE4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 17 Oct 2021 10:04:56 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:36301 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232132AbhJQOEz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 17 Oct 2021 10:04:55 -0400
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 5112E20005;
        Sun, 17 Oct 2021 14:02:42 +0000 (UTC)
Date:   Sun, 17 Oct 2021 16:02:42 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Greg KH <gregkh@linuxfoundation.org>
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
Message-ID: <YWwtAm0o6wVMG6xc@piout.net>
References: <cover.1632884256.git.vilhelm.gray@gmail.com>
 <b8b8c64b4065aedff43699ad1f0e2f8d1419c15b.1632884256.git.vilhelm.gray@gmail.com>
 <YWwqE5T6h5j14M/M@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YWwqE5T6h5j14M/M@kroah.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 17/10/2021 15:50:11+0200, Greg KH wrote:
> Note, review of this now that it has been submitted in a pull request to
> me, sorry I missed this previously...
> 
> On Wed, Sep 29, 2021 at 12:15:59PM +0900, William Breathitt Gray wrote:
> > +static int counter_chrdev_open(struct inode *inode, struct file *filp)
> > +{
> > +	struct counter_device *const counter = container_of(inode->i_cdev,
> > +							    typeof(*counter),
> > +							    chrdev);
> > +
> > +	/* Ensure chrdev is not opened more than 1 at a time */
> > +	if (!atomic_add_unless(&counter->chrdev_lock, 1, 1))
> > +		return -EBUSY;
> 
> I understand the feeling that you wish to stop userspace from doing
> this, but really, it does not work.  Eventhough you are doing this
> correctly (you should see all the other attempts at doing this), you are
> not preventing userspace from having multiple processes access this
> device node at the same time, so please, don't even attempt to stop this
> from happening.
> 
> So you can drop the atomic "lock" you have here, it's not needed at all.
> 

Could you elaborate a bit here because we've had a similar thing in the
RTC subsystem:

https://elixir.bootlin.com/linux/latest/source/drivers/rtc/dev.c#L28

And it would mean I can remove rtc->flags completely.


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
