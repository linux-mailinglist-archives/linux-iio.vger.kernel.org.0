Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA8436A186
	for <lists+linux-iio@lfdr.de>; Sat, 24 Apr 2021 16:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232250AbhDXOHE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 24 Apr 2021 10:07:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:54298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238146AbhDXOF2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 24 Apr 2021 10:05:28 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59E3660FDB;
        Sat, 24 Apr 2021 14:04:48 +0000 (UTC)
Date:   Sat, 24 Apr 2021 15:05:28 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Yicong Yang <yangyicong@hisilicon.com>
Cc:     <linux-iio@vger.kernel.org>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <pmeerw@pmeerw.net>,
        <prime.zeng@huawei.com>, <tiantao6@hisilicon.com>
Subject: Re: [PATCH 6/7] iio: trigger: simplify __devm_iio_trigger_register
Message-ID: <20210424150528.277b0898@jic23-huawei>
In-Reply-To: <1617881896-3164-7-git-send-email-yangyicong@hisilicon.com>
References: <1617881896-3164-1-git-send-email-yangyicong@hisilicon.com>
        <1617881896-3164-7-git-send-email-yangyicong@hisilicon.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 8 Apr 2021 19:38:15 +0800
Yicong Yang <yangyicong@hisilicon.com> wrote:

> Use devm_add_action_or_reset() instead of devres_alloc() and
> devres_add(), which works the same. This will simplify the
> code. There is no functional changes.
> 
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
Applied.

Thanks,

Jonathan

> ---
>  drivers/iio/industrialio-trigger.c | 18 +++++-------------
>  1 file changed, 5 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
> index ea3c985..0db0952 100644
> --- a/drivers/iio/industrialio-trigger.c
> +++ b/drivers/iio/industrialio-trigger.c
> @@ -624,9 +624,9 @@ struct iio_trigger *devm_iio_trigger_alloc(struct device *dev,
>  }
>  EXPORT_SYMBOL_GPL(devm_iio_trigger_alloc);
>  
> -static void devm_iio_trigger_unreg(struct device *dev, void *res)
> +static void devm_iio_trigger_unreg(void *trigger_info)
>  {
> -	iio_trigger_unregister(*(struct iio_trigger **)res);
> +	iio_trigger_unregister(trigger_info);
>  }
>  
>  /**
> @@ -647,21 +647,13 @@ int __devm_iio_trigger_register(struct device *dev,
>  				struct iio_trigger *trig_info,
>  				struct module *this_mod)
>  {
> -	struct iio_trigger **ptr;
>  	int ret;
>  
> -	ptr = devres_alloc(devm_iio_trigger_unreg, sizeof(*ptr), GFP_KERNEL);
> -	if (!ptr)
> -		return -ENOMEM;
> -
> -	*ptr = trig_info;
>  	ret = __iio_trigger_register(trig_info, this_mod);
> -	if (!ret)
> -		devres_add(dev, ptr);
> -	else
> -		devres_free(ptr);
> +	if (ret)
> +		return ret;
>  
> -	return ret;
> +	return devm_add_action_or_reset(dev, devm_iio_trigger_unreg, trig_info);
>  }
>  EXPORT_SYMBOL_GPL(__devm_iio_trigger_register);
>  

