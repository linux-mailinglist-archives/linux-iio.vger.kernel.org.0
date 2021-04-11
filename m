Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2581A35B5A1
	for <lists+linux-iio@lfdr.de>; Sun, 11 Apr 2021 16:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235625AbhDKOQC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 11 Apr 2021 10:16:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:42432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235616AbhDKOQB (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 11 Apr 2021 10:16:01 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 025CA610CA;
        Sun, 11 Apr 2021 14:15:42 +0000 (UTC)
Date:   Sun, 11 Apr 2021 15:16:06 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Yicong Yang <yangyicong@hisilicon.com>
Cc:     <linux-iio@vger.kernel.org>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <pmeerw@pmeerw.net>,
        <prime.zeng@huawei.com>, <tiantao6@hisilicon.com>
Subject: Re: [PATCH 4/7] iio: triggered-buffer: simplify
 devm_iio_triggered_buffer_setup_ext
Message-ID: <20210411151606.1ec66860@jic23-huawei>
In-Reply-To: <1617881896-3164-5-git-send-email-yangyicong@hisilicon.com>
References: <1617881896-3164-1-git-send-email-yangyicong@hisilicon.com>
        <1617881896-3164-5-git-send-email-yangyicong@hisilicon.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 8 Apr 2021 19:38:13 +0800
Yicong Yang <yangyicong@hisilicon.com> wrote:

> Use devm_add_action_or_reset() instead of devres_alloc() and
> devres_add(), which works the same. This will simplify the
> code. There is no functional changes.
> 
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> ---
>  drivers/iio/buffer/industrialio-triggered-buffer.c | 19 +++++--------------
>  1 file changed, 5 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/iio/buffer/industrialio-triggered-buffer.c b/drivers/iio/buffer/industrialio-triggered-buffer.c
> index 92b8aea..63b4722 100644
> --- a/drivers/iio/buffer/industrialio-triggered-buffer.c
> +++ b/drivers/iio/buffer/industrialio-triggered-buffer.c
> @@ -92,9 +92,9 @@ void iio_triggered_buffer_cleanup(struct iio_dev *indio_dev)
>  }
>  EXPORT_SYMBOL(iio_triggered_buffer_cleanup);
>  
> -static void devm_iio_triggered_buffer_clean(struct device *dev, void *res)
> +static void devm_iio_triggered_buffer_clean(void *indio_dev)
>  {
> -	iio_triggered_buffer_cleanup(*(struct iio_dev **)res);
> +	iio_triggered_buffer_cleanup(indio_dev);
>  }
>  
>  int devm_iio_triggered_buffer_setup_ext(struct device *dev,
> @@ -104,24 +104,15 @@ int devm_iio_triggered_buffer_setup_ext(struct device *dev,
>  					const struct iio_buffer_setup_ops *ops,
>  					const struct attribute **buffer_attrs)
>  {
> -	struct iio_dev **ptr;
>  	int ret;
>  
> -	ptr = devres_alloc(devm_iio_triggered_buffer_clean, sizeof(*ptr),
> -			   GFP_KERNEL);
> -	if (!ptr)
> -		return -ENOMEM;
> -
> -	*ptr = indio_dev;
> -
>  	ret = iio_triggered_buffer_setup_ext(indio_dev, h, thread, ops,
>  					     buffer_attrs);
>  	if (!ret)
> -		devres_add(dev, ptr);
> -	else
> -		devres_free(ptr);
> +		return ret;

This looks inverted from what it should be.

	if (ret)
		return ret;

	return devm_add_action_or_reset()...

>  
> -	return ret;
> +	return devm_add_action_or_reset(dev, devm_iio_triggered_buffer_clean,
> +					indio_dev);
>  }
>  EXPORT_SYMBOL_GPL(devm_iio_triggered_buffer_setup_ext);
>  

