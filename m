Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E56EE609266
	for <lists+linux-iio@lfdr.de>; Sun, 23 Oct 2022 13:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbiJWLCI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 23 Oct 2022 07:02:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbiJWLCH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 23 Oct 2022 07:02:07 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A3E7393A
        for <linux-iio@vger.kernel.org>; Sun, 23 Oct 2022 04:01:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 0652FCE0EA4
        for <linux-iio@vger.kernel.org>; Sun, 23 Oct 2022 11:01:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4616EC433D6;
        Sun, 23 Oct 2022 11:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666522912;
        bh=beVeHGjEJmtA1OXiwRYC+ZXd1Mr8HXvWQdUe9eG3U7Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SERVo2TPPae246E2YQmoXEO01361J38aovUUAfqJwbTIT9rheV64jjaxu3xL7dxIN
         SWLWgGwaRCUVTF8equiId1i6OIiUxLxDsJ6B5Mx4uF9HtpvraPg+60E0maRtooV/GH
         kmrbO1VDA5gNLDFSzmR3DIUV78LV4IUZ2Aw3jJQc2MeQn3epq4mdh+s2JKXuOA3UnR
         2N4GCD7Eyopcsv6fLbAUDsRa8DrsUpvSEG6wxYDejZATUXTTuma7JRlSlu2ToxG3Kp
         zr3XM/JfXmfYZhCAcEoyFL9SPbyPRg2y18zRecQGuQJWPmVoQdn7DqJrcFikda0+xq
         JOeqUSNLSRZkA==
Date:   Sun, 23 Oct 2022 12:02:28 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     <linux-iio@vger.kernel.org>, <jonathan.cameron@huawei.com>
Subject: Re: [PATCH] iio: trigger: sysfs: fix possible memory leak in
 iio_sysfs_trig_init()
Message-ID: <20221023120228.6719e888@jic23-huawei>
In-Reply-To: <20221022074212.1386424-1-yangyingliang@huawei.com>
References: <20221022074212.1386424-1-yangyingliang@huawei.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 22 Oct 2022 15:42:12 +0800
Yang Yingliang <yangyingliang@huawei.com> wrote:

> dev_set_name() allocates memory for name, it need be freed
> when device_add() fails, call put_device() to give up the
> reference that hold in device_initialize(), so that it can
> be freed in kobject_cleanup() when the refcount hit to 0.
> 
> Fault injection test can trigger this:
> 
> unreferenced object 0xffff8e8340a7b4c0 (size 32):
>   comm "modprobe", pid 243, jiffies 4294678145 (age 48.845s)
>   hex dump (first 32 bytes):
>     69 69 6f 5f 73 79 73 66 73 5f 74 72 69 67 67 65  iio_sysfs_trigge
>     72 00 a7 40 83 8e ff ff 00 86 13 c4 f6 ee ff ff  r..@............
>   backtrace:
>     [<0000000074999de8>] __kmem_cache_alloc_node+0x1e9/0x360
>     [<00000000497fd30b>] __kmalloc_node_track_caller+0x44/0x1a0
>     [<000000003636c520>] kstrdup+0x2d/0x60
>     [<0000000032f84da2>] kobject_set_name_vargs+0x1e/0x90
>     [<0000000092efe493>] dev_set_name+0x4e/0x70
> 
> Fixes: 1f785681a870 ("staging:iio:trigger sysfs userspace trigger rework.")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan

> ---
>  drivers/iio/trigger/iio-trig-sysfs.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/trigger/iio-trig-sysfs.c b/drivers/iio/trigger/iio-trig-sysfs.c
> index d6c5e9644738..6b05eed41612 100644
> --- a/drivers/iio/trigger/iio-trig-sysfs.c
> +++ b/drivers/iio/trigger/iio-trig-sysfs.c
> @@ -203,9 +203,13 @@ static int iio_sysfs_trigger_remove(int id)
>  
>  static int __init iio_sysfs_trig_init(void)
>  {
> +	int ret;
>  	device_initialize(&iio_sysfs_trig_dev);
>  	dev_set_name(&iio_sysfs_trig_dev, "iio_sysfs_trigger");
> -	return device_add(&iio_sysfs_trig_dev);
> +	ret = device_add(&iio_sysfs_trig_dev);
> +	if (ret)
> +		put_device(&iio_sysfs_trig_dev);
> +	return ret;
>  }
>  module_init(iio_sysfs_trig_init);
>  

