Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27AE034D021
	for <lists+linux-iio@lfdr.de>; Mon, 29 Mar 2021 14:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbhC2MdY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 29 Mar 2021 08:33:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:44208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230333AbhC2MdV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 29 Mar 2021 08:33:21 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3899B61930;
        Mon, 29 Mar 2021 12:33:18 +0000 (UTC)
Date:   Mon, 29 Mar 2021 13:33:24 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <aardelean@deviqon.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] iio: buffer: return 0 for buffer getfd ioctl handler
Message-ID: <20210329133324.67eef6d8@jic23-huawei>
In-Reply-To: <20210322084135.17536-1-aardelean@deviqon.com>
References: <20210322084135.17536-1-aardelean@deviqon.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 22 Mar 2021 10:41:35 +0200
Alexandru Ardelean <aardelean@deviqon.com> wrote:

> As Lars pointed out, we could either return the FD vs memcpy-ing it to the
> userspace data object.
> 
> However, this comment exposed a bug. We should return 0 or negative from
> these ioctl() handlers. Because an ioctl() handler can also return
> IIO_IOCTL_UNHANDLED (which is positive 1), which means that the ioctl()
> handler doesn't support this ioctl number. Positive 1 could also be a valid
> FD number in some corner cases.
> 
> The reason we did this is to be able to differentiate between an error
> code and an unsupported ioctl number; for unsupported ioctl numbers, the
> main loop should keep going.
> 
> Maybe we should change this to a higher negative number, to avoid such
> cases when/if we add more ioctl() handlers.

That sounds like a sensible follow up plan to me - perhaps we could
use EOPNOTSUPP for this directly but add special handling for that in
the core so it doesn't worry about it as long as someone supports the ioctl.

> 
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Fixes: f73f7f4da5818 ("iio: buffer: add ioctl() to support opening extra buffers for IIO device")
> Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>

Applied to the togreg branch of iio.git and pushed out as testing.

Thanks,

Jonathan
> ---
>  drivers/iio/industrialio-buffer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index ee5aab9d4a23..d7a15c9bb0cd 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -1442,7 +1442,7 @@ static long iio_device_buffer_getfd(struct iio_dev *indio_dev, unsigned long arg
>  		goto error_free_ib;
>  	}
>  
> -	return fd;
> +	return 0;
>  
>  error_free_ib:
>  	kfree(ib);

