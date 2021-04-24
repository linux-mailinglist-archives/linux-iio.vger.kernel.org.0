Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2B8A36A188
	for <lists+linux-iio@lfdr.de>; Sat, 24 Apr 2021 16:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231892AbhDXONJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 24 Apr 2021 10:13:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:55964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231836AbhDXONH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 24 Apr 2021 10:13:07 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 28A60613B1;
        Sat, 24 Apr 2021 14:12:15 +0000 (UTC)
Date:   Sat, 24 Apr 2021 15:12:56 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Yicong Yang <yangyicong@hisilicon.com>
Cc:     <linux-iio@vger.kernel.org>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <pmeerw@pmeerw.net>,
        <prime.zeng@huawei.com>, <tiantao6@hisilicon.com>
Subject: Re: [PATCH 7/7] iio: inkern: simplify some devm functions
Message-ID: <20210424151256.020b24a6@jic23-huawei>
In-Reply-To: <1617881896-3164-8-git-send-email-yangyicong@hisilicon.com>
References: <1617881896-3164-1-git-send-email-yangyicong@hisilicon.com>
        <1617881896-3164-8-git-send-email-yangyicong@hisilicon.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 8 Apr 2021 19:38:16 +0800
Yicong Yang <yangyicong@hisilicon.com> wrote:

> Use devm_add_action_or_reset() instead of devres_alloc() and
> devres_add(), which works the same. This will simplify the
> code. There is no functional changes.
> 
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Jonathan

> ---
>  drivers/iio/inkern.c | 61 ++++++++++++++++++++--------------------------------
>  1 file changed, 23 insertions(+), 38 deletions(-)
> 
> diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
> index db77a2d..5de35cc 100644
> --- a/drivers/iio/inkern.c
> +++ b/drivers/iio/inkern.c
> @@ -359,30 +359,24 @@ void iio_channel_release(struct iio_channel *channel)
>  }
>  EXPORT_SYMBOL_GPL(iio_channel_release);
>  
> -static void devm_iio_channel_free(struct device *dev, void *res)
> +static void devm_iio_channel_free(void *iio_channel)
>  {
> -	struct iio_channel *channel = *(struct iio_channel **)res;
> -
> -	iio_channel_release(channel);
> +	iio_channel_release(iio_channel);
>  }
>  
>  struct iio_channel *devm_iio_channel_get(struct device *dev,
>  					 const char *channel_name)
>  {
> -	struct iio_channel **ptr, *channel;
> -
> -	ptr = devres_alloc(devm_iio_channel_free, sizeof(*ptr), GFP_KERNEL);
> -	if (!ptr)
> -		return ERR_PTR(-ENOMEM);
> +	struct iio_channel *channel;
> +	int ret;
>  
>  	channel = iio_channel_get(dev, channel_name);
> -	if (IS_ERR(channel)) {
> -		devres_free(ptr);
> +	if (IS_ERR(channel))
>  		return channel;
> -	}
>  
> -	*ptr = channel;
> -	devres_add(dev, ptr);
> +	ret = devm_add_action_or_reset(dev, devm_iio_channel_free, channel);
> +	if (ret)
> +		return ERR_PTR(ret);
>  
>  	return channel;
>  }
> @@ -392,20 +386,16 @@ struct iio_channel *devm_of_iio_channel_get_by_name(struct device *dev,
>  						    struct device_node *np,
>  						    const char *channel_name)
>  {
> -	struct iio_channel **ptr, *channel;
> -
> -	ptr = devres_alloc(devm_iio_channel_free, sizeof(*ptr), GFP_KERNEL);
> -	if (!ptr)
> -		return ERR_PTR(-ENOMEM);
> +	struct iio_channel *channel;
> +	int ret;
>  
>  	channel = of_iio_channel_get_by_name(np, channel_name);
> -	if (IS_ERR(channel)) {
> -		devres_free(ptr);
> +	if (IS_ERR(channel))
>  		return channel;
> -	}
>  
> -	*ptr = channel;
> -	devres_add(dev, ptr);
> +	ret = devm_add_action_or_reset(dev, devm_iio_channel_free, channel);
> +	if (ret)
> +		return ERR_PTR(ret);
>  
>  	return channel;
>  }
> @@ -496,29 +486,24 @@ void iio_channel_release_all(struct iio_channel *channels)
>  }
>  EXPORT_SYMBOL_GPL(iio_channel_release_all);
>  
> -static void devm_iio_channel_free_all(struct device *dev, void *res)
> +static void devm_iio_channel_free_all(void *iio_channels)
>  {
> -	struct iio_channel *channels = *(struct iio_channel **)res;
> -
> -	iio_channel_release_all(channels);
> +	iio_channel_release_all(iio_channels);
>  }
>  
>  struct iio_channel *devm_iio_channel_get_all(struct device *dev)
>  {
> -	struct iio_channel **ptr, *channels;
> -
> -	ptr = devres_alloc(devm_iio_channel_free_all, sizeof(*ptr), GFP_KERNEL);
> -	if (!ptr)
> -		return ERR_PTR(-ENOMEM);
> +	struct iio_channel *channels;
> +	int ret;
>  
>  	channels = iio_channel_get_all(dev);
> -	if (IS_ERR(channels)) {
> -		devres_free(ptr);
> +	if (IS_ERR(channels))
>  		return channels;
> -	}
>  
> -	*ptr = channels;
> -	devres_add(dev, ptr);
> +	ret = devm_add_action_or_reset(dev, devm_iio_channel_free_all,
> +				       channels);
> +	if (ret)
> +		return ERR_PTR(ret);
>  
>  	return channels;
>  }

