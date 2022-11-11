Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE82625965
	for <lists+linux-iio@lfdr.de>; Fri, 11 Nov 2022 12:31:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233331AbiKKLb4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 11 Nov 2022 06:31:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233502AbiKKLbx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 11 Nov 2022 06:31:53 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EBD77B20F
        for <linux-iio@vger.kernel.org>; Fri, 11 Nov 2022 03:31:49 -0800 (PST)
Received: from fraeml713-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4N7xJB2wvfz67NNP;
        Fri, 11 Nov 2022 19:27:22 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml713-chm.china.huawei.com (10.206.15.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 11 Nov 2022 12:31:45 +0100
Received: from localhost (10.45.151.252) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 11 Nov
 2022 11:31:45 +0000
Date:   Fri, 11 Nov 2022 11:31:41 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Zeng Heng <zengheng4@huawei.com>
CC:     <jic23@kernel.org>, <alexandru.ardelean@analog.com>,
        <lars@metafoo.de>, <linux-iio@vger.kernel.org>,
        <liwei391@huawei.com>
Subject: Re: [PATCH] iio: fix kobject_put warning in iio_device_register
Message-ID: <20221111113141.00000917@Huawei.com>
In-Reply-To: <20221110132615.331454-1-zengheng4@huawei.com>
References: <20221110132615.331454-1-zengheng4@huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.45.151.252]
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 10 Nov 2022 21:26:15 +0800
Zeng Heng <zengheng4@huawei.com> wrote:

> There is warning reported by kobject lib in kobject_put():
> 
> kobject: '(null)' (00000000be81a546): is not initialized, yet kobject_put() is being called.
> WARNING: CPU: 0 PID: 535 at lib/kobject.c:718 kobject_put+0x12c/0x180
> Call Trace:
>  cdev_device_add
>  __iio_device_register
>  __devm_iio_device_register
>  tmp117_probe
> 
> If don't need to register chardev for most of IIO devices,
> we just register them with device_add() only, and use device_del()
> to unregister them.



> 
> Otherwise, when device_add() fails in internal and calls kobject_put()
> in error handling path, it would report warning because the device
> never be registered as chardev and there is no release function for it.
> 
> Fixes: 8ebaa3ff1e71 ("iio: core: register chardev only if needed")
> Signed-off-by: Zeng Heng <zengheng4@huawei.com>

Interesting corner case. The cdev_device_add() call is fine with
!dev->devt which is what this code was taking advantage of. The exception
as you have highlighted is the error path of device_add().

So I think it should also cope with unwinding if device_add() fails
and not be calling cdev_del()  Note that cdev_device_del() has the
appropriate guards to be safe whether or not (dev->devt) is true.

Perhaps change cdev_device_add() to have

	rc = device_add(dev);
	if (rc && dev->devt)
		cdev_del(cdev);

	return rc;

Jonathan

> ---
>  drivers/iio/industrialio-core.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 151ff3993354..f4f48bda07f7 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -1982,7 +1982,11 @@ int __iio_device_register(struct iio_dev *indio_dev, struct module *this_mod)
>  	/* assign device groups now; they should be all registered now */
>  	indio_dev->dev.groups = iio_dev_opaque->groups;
>  
> -	ret = cdev_device_add(&iio_dev_opaque->chrdev, &indio_dev->dev);
> +	if (iio_dev_opaque->attached_buffers_cnt || iio_dev_opaque->event_interface)
> +		ret = cdev_device_add(&iio_dev_opaque->chrdev, &indio_dev->dev);
> +	else
> +		ret = device_add(&indio_dev->dev);
> +
>  	if (ret < 0)
>  		goto error_unreg_eventset;
>  
> @@ -2008,7 +2012,10 @@ void iio_device_unregister(struct iio_dev *indio_dev)
>  {
>  	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
>  
> -	cdev_device_del(&iio_dev_opaque->chrdev, &indio_dev->dev);
> +	if (iio_dev_opaque->chrdev.kobj.state_initialized)
> +		cdev_device_del(&iio_dev_opaque->chrdev, &indio_dev->dev);
> +	else
> +		device_del(&indio_dev->dev);
>  
>  	mutex_lock(&iio_dev_opaque->info_exist_lock);
>  

