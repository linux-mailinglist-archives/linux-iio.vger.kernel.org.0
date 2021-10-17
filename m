Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8B1D430973
	for <lists+linux-iio@lfdr.de>; Sun, 17 Oct 2021 15:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242256AbhJQNwY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 17 Oct 2021 09:52:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:56102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230400AbhJQNwY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 17 Oct 2021 09:52:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CB18C61039;
        Sun, 17 Oct 2021 13:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1634478614;
        bh=tfA7oucleLVKuvXIcjTuZZfdbNUsWA+rU4EDlt0R3OY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V6ULbkcWXClmBXpwMjJCozJ45kjb60ISvdM+ofe247OQQ3jjQDvK4WElPV1B4oplQ
         UkJqtG0kM3j2UJ45i7Oc3YsnN8cYYFG1oKMPtuR94C9nApvv+Oo5X7dtMyOl6INU5b
         cjE0lgeY4IA0AtuEOkUGAYu3rBDAjb8IasF367b8=
Date:   Sun, 17 Oct 2021 15:50:11 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     jic23@kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        kernel@pengutronix.de, a.fatoum@pengutronix.de,
        kamel.bouhara@bootlin.com, gwendal@chromium.org,
        alexandre.belloni@bootlin.com, david@lechnology.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, syednwaris@gmail.com,
        patrick.havelange@essensium.com, fabrice.gasnier@st.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        o.rempel@pengutronix.de, jarkko.nikula@linux.intel.com,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v17 2/9] counter: Add character device interface
Message-ID: <YWwqE5T6h5j14M/M@kroah.com>
References: <cover.1632884256.git.vilhelm.gray@gmail.com>
 <b8b8c64b4065aedff43699ad1f0e2f8d1419c15b.1632884256.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8b8c64b4065aedff43699ad1f0e2f8d1419c15b.1632884256.git.vilhelm.gray@gmail.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Note, review of this now that it has been submitted in a pull request to
me, sorry I missed this previously...

On Wed, Sep 29, 2021 at 12:15:59PM +0900, William Breathitt Gray wrote:
> +static int counter_chrdev_open(struct inode *inode, struct file *filp)
> +{
> +	struct counter_device *const counter = container_of(inode->i_cdev,
> +							    typeof(*counter),
> +							    chrdev);
> +
> +	/* Ensure chrdev is not opened more than 1 at a time */
> +	if (!atomic_add_unless(&counter->chrdev_lock, 1, 1))
> +		return -EBUSY;

I understand the feeling that you wish to stop userspace from doing
this, but really, it does not work.  Eventhough you are doing this
correctly (you should see all the other attempts at doing this), you are
not preventing userspace from having multiple processes access this
device node at the same time, so please, don't even attempt to stop this
from happening.

So you can drop the atomic "lock" you have here, it's not needed at all.

thanks,

greg k-h
