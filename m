Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA44D62C8A9
	for <lists+linux-iio@lfdr.de>; Wed, 16 Nov 2022 20:04:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231871AbiKPTEB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 16 Nov 2022 14:04:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238755AbiKPTDw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 16 Nov 2022 14:03:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8649DEAB
        for <linux-iio@vger.kernel.org>; Wed, 16 Nov 2022 11:03:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E4B861F6C
        for <linux-iio@vger.kernel.org>; Wed, 16 Nov 2022 19:03:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB7C4C433D6;
        Wed, 16 Nov 2022 19:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668625429;
        bh=N9Yvqi2qc3k4Dz+64byuqusPlGU8E1D8Qy5zxvfsjpE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jNiLxPomUu+iv24dtB5uHkSBayyuydbsK/gL2NZfttOM3fK6rC8iUfhx8pgL3uyjn
         LD8rx+QFQIvW1ADUOssavSweE/5BkAkg3upRi/NtoaG763WZJZLpSr3L/C7XdlKsxi
         PF0pyE1y5DgJRlUbWfr74j7n3nSsXMjPar1KuQTTw7ebflSAyx+82jXt0bhR77ytnF
         qOCgxkyd6M7AtfchXMH+VNlJLf8iEjZeFw//wwv9Q7P+MrSXe8nMZbb5PdLm19nruc
         YqTjguNzbV2gDWq2jrEPrcMMiCcdGjjCmKDZlHC4U9650BJim9ZXOYa7P8A83x5XD1
         8ZahyWSzgYaQA==
Date:   Wed, 16 Nov 2022 19:16:14 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Zeng Heng <zengheng4@huawei.com>
Cc:     <alexandru.ardelean@analog.com>, <lars@metafoo.de>,
        <linux-iio@vger.kernel.org>, <liwei391@huawei.com>
Subject: Re: [PATCH] iio: fix memory leak in iio_device_register_eventset()
Message-ID: <20221116191614.1f5cf29e@jic23-huawei>
In-Reply-To: <20221115023712.3726854-1-zengheng4@huawei.com>
References: <20221115023712.3726854-1-zengheng4@huawei.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 15 Nov 2022 10:37:12 +0800
Zeng Heng <zengheng4@huawei.com> wrote:

> When iio_device_register_sysfs_group() returns failed,
> iio_device_register_eventset() needs to free attrs array.
> 
> Otherwise, kmemleak would scan & report memory leak as below:
> 
> unreferenced object 0xffff88810a1cc3c0 (size 32):
>   comm "100-i2c-vcnl302", pid 728, jiffies 4295052307 (age 156.027s)
>   backtrace:
>     __kmalloc+0x46/0x1b0
>     iio_device_register_eventset at drivers/iio/industrialio-event.c:541
>     __iio_device_register at drivers/iio/industrialio-core.c:1959
>     __devm_iio_device_register at drivers/iio/industrialio-core.c:2040
> 
> Fixes: 32f171724e5c ("iio: core: rework iio device group creation")
> Signed-off-by: Zeng Heng <zengheng4@huawei.com>

Good find.

Applied to the fixes-togreg branch of iio.git.

Thanks,

Jonathan

> ---
>  drivers/iio/industrialio-event.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/industrialio-event.c b/drivers/iio/industrialio-event.c
> index 3d78da2531a9..727e2ef66aa4 100644
> --- a/drivers/iio/industrialio-event.c
> +++ b/drivers/iio/industrialio-event.c
> @@ -556,7 +556,7 @@ int iio_device_register_eventset(struct iio_dev *indio_dev)
>  
>  	ret = iio_device_register_sysfs_group(indio_dev, &ev_int->group);
>  	if (ret)
> -		goto error_free_setup_event_lines;
> +		goto error_free_group_attrs;
>  
>  	ev_int->ioctl_handler.ioctl = iio_event_ioctl;
>  	iio_device_ioctl_handler_register(&iio_dev_opaque->indio_dev,
> @@ -564,6 +564,8 @@ int iio_device_register_eventset(struct iio_dev *indio_dev)
>  
>  	return 0;
>  
> +error_free_group_attrs:
> +	kfree(ev_int->group.attrs);
>  error_free_setup_event_lines:
>  	iio_free_chan_devattr_list(&ev_int->dev_attr_list);
>  	kfree(ev_int);

