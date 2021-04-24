Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E565636A173
	for <lists+linux-iio@lfdr.de>; Sat, 24 Apr 2021 15:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237374AbhDXN4m (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 24 Apr 2021 09:56:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:49894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230432AbhDXN4l (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 24 Apr 2021 09:56:41 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 079E461490;
        Sat, 24 Apr 2021 13:56:01 +0000 (UTC)
Date:   Sat, 24 Apr 2021 14:56:42 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Yicong Yang <yangyicong@hisilicon.com>
Cc:     <linux-iio@vger.kernel.org>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <pmeerw@pmeerw.net>,
        <prime.zeng@huawei.com>, <tiantao6@hisilicon.com>
Subject: Re: [PATCH 3/7] iio: hw_consumer: simplify
 devm_iio_hw_consumer_alloc
Message-ID: <20210424145642.4198b1e9@jic23-huawei>
In-Reply-To: <1617881896-3164-4-git-send-email-yangyicong@hisilicon.com>
References: <1617881896-3164-1-git-send-email-yangyicong@hisilicon.com>
        <1617881896-3164-4-git-send-email-yangyicong@hisilicon.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 8 Apr 2021 19:38:12 +0800
Yicong Yang <yangyicong@hisilicon.com> wrote:

> Use devm_add_action_or_reset() instead of devres_alloc() and
> devres_add(), which works the same. This will simplify the
> code. There is no functional changes.
> 
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
Applied,

Thanks,
> ---
>  drivers/iio/buffer/industrialio-hw-consumer.c | 25 +++++++++++--------------
>  1 file changed, 11 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/iio/buffer/industrialio-hw-consumer.c b/drivers/iio/buffer/industrialio-hw-consumer.c
> index f2d2778..87d9aab 100644
> --- a/drivers/iio/buffer/industrialio-hw-consumer.c
> +++ b/drivers/iio/buffer/industrialio-hw-consumer.c
> @@ -137,9 +137,9 @@ void iio_hw_consumer_free(struct iio_hw_consumer *hwc)
>  }
>  EXPORT_SYMBOL_GPL(iio_hw_consumer_free);
>  
> -static void devm_iio_hw_consumer_release(struct device *dev, void *res)
> +static void devm_iio_hw_consumer_release(void *iio_hwc)
>  {
> -	iio_hw_consumer_free(*(struct iio_hw_consumer **)res);
> +	iio_hw_consumer_free(iio_hwc);
>  }
>  
>  /**
> @@ -153,20 +153,17 @@ static void devm_iio_hw_consumer_release(struct device *dev, void *res)
>   */
>  struct iio_hw_consumer *devm_iio_hw_consumer_alloc(struct device *dev)
>  {
> -	struct iio_hw_consumer **ptr, *iio_hwc;
> -
> -	ptr = devres_alloc(devm_iio_hw_consumer_release, sizeof(*ptr),
> -			   GFP_KERNEL);
> -	if (!ptr)
> -		return NULL;
> +	struct iio_hw_consumer *iio_hwc;
> +	int ret;
>  
>  	iio_hwc = iio_hw_consumer_alloc(dev);
> -	if (IS_ERR(iio_hwc)) {
> -		devres_free(ptr);
> -	} else {
> -		*ptr = iio_hwc;
> -		devres_add(dev, ptr);
> -	}
> +	if (IS_ERR(iio_hwc))
> +		return iio_hwc;
> +
> +	ret = devm_add_action_or_reset(dev, devm_iio_hw_consumer_release,
> +				       iio_hwc);
> +	if (ret)
> +		return ERR_PTR(ret);
>  
>  	return iio_hwc;
>  }

