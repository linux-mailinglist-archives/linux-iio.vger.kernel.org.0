Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF39043E27A
	for <lists+linux-iio@lfdr.de>; Thu, 28 Oct 2021 15:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbhJ1Ntu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 28 Oct 2021 09:49:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:42838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229887AbhJ1Ntt (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 28 Oct 2021 09:49:49 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0FDE961056;
        Thu, 28 Oct 2021 13:47:20 +0000 (UTC)
Date:   Thu, 28 Oct 2021 14:51:47 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <lars@metafoo.de>, <hdegoede@redhat.com>,
        <andriy.shevchenko@linux.intel.com>, <ddvlad@gmail.com>
Subject: Re: [PATCH v2] iio: accel: kxcjk-1013: Fix possible memory leak in
 probe and remove
Message-ID: <20211028145147.7ad93c5f@jic23-huawei>
In-Reply-To: <20211025124159.2700301-1-yangyingliang@huawei.com>
References: <20211025124159.2700301-1-yangyingliang@huawei.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 25 Oct 2021 20:41:59 +0800
Yang Yingliang <yangyingliang@huawei.com> wrote:

> When ACPI type is ACPI_SMO8500, the data->dready_trig will not be set, the
> memory allocated by iio_triggered_buffer_setup() will not be freed, and cause
> memory leak as follows:
> 
> unreferenced object 0xffff888009551400 (size 512):
>   comm "i2c-SMO8500-125", pid 911, jiffies 4294911787 (age 83.852s)
>   hex dump (first 32 bytes):
>     02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 20 e2 e5 c0 ff ff ff ff  ........ .......
>   backtrace:
>     [<0000000041ce75ee>] kmem_cache_alloc_trace+0x16d/0x360
>     [<000000000aeb17b0>] iio_kfifo_allocate+0x41/0x130 [kfifo_buf]
>     [<000000004b40c1f5>] iio_triggered_buffer_setup_ext+0x2c/0x210 [industrialio_triggered_buffer]
>     [<000000004375b15f>] kxcjk1013_probe+0x10c3/0x1d81 [kxcjk_1013]
> 
> Fix it by remove data->dready_trig condition in probe and remove.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: a25691c1f967 ("iio: accel: kxcjk1013: allow using an external trigger")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Applied to the fixes-togreg branch of iio.git.  Note this will hit mainline after the merge window
now.   Also, we should look at taking this driver fully over to devm managed functions.
Looks easy to do and would have avoided this particular leak.

Jonathan

> ---
> v2:
>   drop some calltrace in commit message
> ---
>  drivers/iio/accel/kxcjk-1013.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
> index a51fdd3c9b5b..24c9387c2968 100644
> --- a/drivers/iio/accel/kxcjk-1013.c
> +++ b/drivers/iio/accel/kxcjk-1013.c
> @@ -1595,8 +1595,7 @@ static int kxcjk1013_probe(struct i2c_client *client,
>  	return 0;
>  
>  err_buffer_cleanup:
> -	if (data->dready_trig)
> -		iio_triggered_buffer_cleanup(indio_dev);
> +	iio_triggered_buffer_cleanup(indio_dev);
>  err_trigger_unregister:
>  	if (data->dready_trig)
>  		iio_trigger_unregister(data->dready_trig);
> @@ -1618,8 +1617,8 @@ static int kxcjk1013_remove(struct i2c_client *client)
>  	pm_runtime_disable(&client->dev);
>  	pm_runtime_set_suspended(&client->dev);
>  
> +	iio_triggered_buffer_cleanup(indio_dev);
>  	if (data->dready_trig) {
> -		iio_triggered_buffer_cleanup(indio_dev);
>  		iio_trigger_unregister(data->dready_trig);
>  		iio_trigger_unregister(data->motion_trig);
>  	}

