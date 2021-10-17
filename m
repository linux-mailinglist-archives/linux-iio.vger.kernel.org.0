Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DBAF4309CC
	for <lists+linux-iio@lfdr.de>; Sun, 17 Oct 2021 16:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236856AbhJQOlv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 17 Oct 2021 10:41:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:59158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236695AbhJQOlv (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 17 Oct 2021 10:41:51 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 139066103B;
        Sun, 17 Oct 2021 14:39:39 +0000 (UTC)
Date:   Sun, 17 Oct 2021 15:43:54 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <lars@metafoo.de>, <ardeleanalex@gmail.com>
Subject: Re: [PATCH] iio: buffer: Fix memory leak in
 iio_buffer_register_legacy_sysfs_groups()
Message-ID: <20211017154327.6e88bc05@jic23-huawei>
In-Reply-To: <20211013144242.1685060-1-yangyingliang@huawei.com>
References: <20211013144242.1685060-1-yangyingliang@huawei.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 13 Oct 2021 22:42:42 +0800
Yang Yingliang <yangyingliang@huawei.com> wrote:

> If the second iio_device_register_sysfs_group() fails,
> 'legacy_buffer_group.attrs' need be freed too or it will
> cause memory leak:
> 
> unreferenced object 0xffff888003618280 (size 64):
>   comm "xrun", pid 357, jiffies 4294907259 (age 22.296s)
>   hex dump (first 32 bytes):
>     80 f6 8c 03 80 88 ff ff 80 fb 8c 03 80 88 ff ff  ................
>     00 f9 8c 03 80 88 ff ff 80 fc 8c 03 80 88 ff ff  ................
>   backtrace:
>     [<00000000076bfd43>] __kmalloc+0x1a3/0x2f0
>     [<00000000c32e4886>] iio_buffers_alloc_sysfs_and_mask+0xc31/0x1290 [industrialio]
>     [<000000002fcd0bb8>] __iio_device_register+0x52e/0x1b40 [industrialio]
>     [<000000008116530c>] __devm_iio_device_register+0x22/0x80 [industrialio]
>     [<000000008a47327c>] adjd_s311_probe+0x195/0x200 [adjd_s311]
>     [<00000000f8eeb456>] i2c_device_probe+0xa07/0xbb0
>     [<000000000e86686c>] really_probe+0x285/0xc30
>     [<00000000a49db55c>] __driver_probe_device+0x35f/0x4f0
>     [<00000000d1fd43a1>] driver_probe_device+0x4f/0x140
>     [<000000008cdafdfa>] __device_attach_driver+0x24c/0x330
>     [<000000006466e92e>] bus_for_each_drv+0x15d/0x1e0
>     [<00000000154fbb1c>] __device_attach+0x267/0x410
>     [<000000007c84d5d1>] bus_probe_device+0x1ec/0x2a0
>     [<0000000019967467>] device_add+0xc3d/0x2020
>     [<00000000a16d2d51>] i2c_new_client_device+0x614/0xb00
>     [<00000000a56a901d>] new_device_store+0x1f4/0x410
I cut this down a bit.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: d9a625744ed0 ("iio: core: merge buffer/ & scan_elements/ attributes")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>

Ouch on this one.  I guess a classic bit of too much churn and resulting bit rot
leading to this oddity.  At somepoint it would be good to clean this up further
and tidy up the remove order to match this error path.

Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan

> ---
>  drivers/iio/industrialio-buffer.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index ba1c5c898e53..88741385764e 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -1367,10 +1367,10 @@ static int iio_buffer_register_legacy_sysfs_groups(struct iio_dev *indio_dev,
>  
>  	return 0;
>  
> -error_free_buffer_attrs:
> -	kfree(iio_dev_opaque->legacy_buffer_group.attrs);
>  error_free_scan_el_attrs:
>  	kfree(iio_dev_opaque->legacy_scan_el_group.attrs);
> +error_free_buffer_attrs:
> +	kfree(iio_dev_opaque->legacy_buffer_group.attrs);
>  
>  	return ret;
>  }

