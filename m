Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBD5136A0B2
	for <lists+linux-iio@lfdr.de>; Sat, 24 Apr 2021 12:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231771AbhDXKww (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 24 Apr 2021 06:52:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:53446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231490AbhDXKwt (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 24 Apr 2021 06:52:49 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0CB1E61396;
        Sat, 24 Apr 2021 10:52:09 +0000 (UTC)
Date:   Sat, 24 Apr 2021 11:52:50 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Tomasz Duszynski <tomasz.duszynski@octakon.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lars@metafoo.de>, <ardeleanalex@gmail.com>
Subject: Re: [PATCH v2] iio: core: fix ioctl handlers removal
Message-ID: <20210424115250.14d21a71@jic23-huawei>
In-Reply-To: <20210423080244.2790-1-tomasz.duszynski@octakon.com>
References: <20210423080244.2790-1-tomasz.duszynski@octakon.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 23 Apr 2021 10:02:44 +0200
Tomasz Duszynski <tomasz.duszynski@octakon.com> wrote:

> Currently ioctl handlers are removed twice. For the first time during
> iio_device_unregister() then later on inside
> iio_device_unregister_eventset() and iio_buffers_free_sysfs_and_mask().
> Double free leads to kernel panic.
> 
> Fix this by not touching ioctl handlers list directly but rather
> letting code responsible for registration call the matching cleanup
> routine itself.
> 
> Fixes: 8dedcc3eee3ac ("iio: core: centralize ioctl() calls to the main chardev")
> Signed-off-by: Tomasz Duszynski <tomasz.duszynski@octakon.com>
> Acked-by: Alexandru Ardelean <ardeleanalex@gmail.com>

There are a bunch of unused local variables as a result of this change
(build warnings on my standard W=1 C=1 test).  I've dropped those as well and
applied this to the fixes-togreg branch of iio.git.

We are a bit unfortunate on timing for this as I won't send a pull request
for fixes until towards the end of the merge window.  I've marked it for stable
though so it should filter back fairly quickly so kernels people actually
use.

Thanks,

Jonathan

> ---
> v2:
> * add fixes tag and ack
> 
>  drivers/iio/industrialio-core.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index d92c58a94fe4..98944cfc7331 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -1939,9 +1939,6 @@ void iio_device_unregister(struct iio_dev *indio_dev)
> 
>  	indio_dev->info = NULL;
> 
> -	list_for_each_entry_safe(h, t, &iio_dev_opaque->ioctl_handlers, entry)
> -		list_del(&h->entry);
> -
>  	iio_device_wakeup_eventset(indio_dev);
>  	iio_buffer_wakeup_poll(indio_dev);
> 
> --
> 2.31.1
> 

