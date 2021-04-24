Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C4E036A122
	for <lists+linux-iio@lfdr.de>; Sat, 24 Apr 2021 14:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232148AbhDXMdu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 24 Apr 2021 08:33:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:55962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232250AbhDXMdm (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 24 Apr 2021 08:33:42 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1312A6146B;
        Sat, 24 Apr 2021 12:33:01 +0000 (UTC)
Date:   Sat, 24 Apr 2021 13:33:42 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Yicong Yang <yangyicong@hisilicon.com>
Cc:     <linux-iio@vger.kernel.org>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <pmeerw@pmeerw.net>,
        <prime.zeng@huawei.com>, <tiantao6@hisilicon.com>
Subject: Re: [PATCH 2/7] iio: buffer-dmaengine: simplify
 __devm_iio_dmaengine_buffer_free
Message-ID: <20210424133342.11a63dce@jic23-huawei>
In-Reply-To: <1617881896-3164-3-git-send-email-yangyicong@hisilicon.com>
References: <1617881896-3164-1-git-send-email-yangyicong@hisilicon.com>
        <1617881896-3164-3-git-send-email-yangyicong@hisilicon.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 8 Apr 2021 19:38:11 +0800
Yicong Yang <yangyicong@hisilicon.com> wrote:

> Use devm_add_action_or_reset() instead of devres_alloc() and
> devres_add(), which works the same. This will simplify the
> code. There is no functional changes.
> 
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
Tiny amount of fuzz, but nothing that mattered.

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to poke at.

Thanks,

Jonathan

> ---
>  drivers/iio/buffer/industrialio-buffer-dmaengine.c | 22 +++++++++-------------
>  1 file changed, 9 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> index b0cb9a3..9ecc03f 100644
> --- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> +++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> @@ -228,9 +228,9 @@ static void iio_dmaengine_buffer_free(struct iio_buffer *buffer)
>  	iio_buffer_put(buffer);
>  }
>  
> -static void __devm_iio_dmaengine_buffer_free(struct device *dev, void *res)
> +static void __devm_iio_dmaengine_buffer_free(void *buffer)
>  {
> -	iio_dmaengine_buffer_free(*(struct iio_buffer **)res);
> +	iio_dmaengine_buffer_free(buffer);
>  }
>  
>  /**
> @@ -247,21 +247,17 @@ static void __devm_iio_dmaengine_buffer_free(struct device *dev, void *res)
>  struct iio_buffer *devm_iio_dmaengine_buffer_alloc(struct device *dev,
>  	const char *channel)
>  {
> -	struct iio_buffer **bufferp, *buffer;
> -
> -	bufferp = devres_alloc(__devm_iio_dmaengine_buffer_free,
> -			       sizeof(*bufferp), GFP_KERNEL);
> -	if (!bufferp)
> -		return ERR_PTR(-ENOMEM);
> +	struct iio_buffer *buffer;
> +	int ret;
>  
>  	buffer = iio_dmaengine_buffer_alloc(dev, channel);
> -	if (IS_ERR(buffer)) {
> -		devres_free(bufferp);
> +	if (IS_ERR(buffer))
>  		return buffer;
> -	}
>  
> -	*bufferp = buffer;
> -	devres_add(dev, bufferp);
> +	ret = devm_add_action_or_reset(dev, __devm_iio_dmaengine_buffer_free,
> +				       buffer);
> +	if (ret)
> +		return ERR_PTR(ret);
>  
>  	return buffer;
>  }

