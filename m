Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69E7435B59A
	for <lists+linux-iio@lfdr.de>; Sun, 11 Apr 2021 16:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235778AbhDKOMN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 11 Apr 2021 10:12:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:42178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235229AbhDKOMN (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 11 Apr 2021 10:12:13 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 04E07610A8;
        Sun, 11 Apr 2021 14:11:53 +0000 (UTC)
Date:   Sun, 11 Apr 2021 15:12:15 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Yicong Yang <yangyicong@hisilicon.com>
Cc:     <linux-iio@vger.kernel.org>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <pmeerw@pmeerw.net>,
        <prime.zeng@huawei.com>, <tiantao6@hisilicon.com>
Subject: Re: [PATCH 1/7] iio: adc: adi-axi-adc: simplify
 devm_adi_axi_adc_conv_register
Message-ID: <20210411151215.5d3e5494@jic23-huawei>
In-Reply-To: <1617881896-3164-2-git-send-email-yangyicong@hisilicon.com>
References: <1617881896-3164-1-git-send-email-yangyicong@hisilicon.com>
        <1617881896-3164-2-git-send-email-yangyicong@hisilicon.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 8 Apr 2021 19:38:10 +0800
Yicong Yang <yangyicong@hisilicon.com> wrote:

> Use devm_add_action_or_reset() instead of devres_alloc() and
> devres_add(), which works the same. This will simplify the
> code. There is no functional changes.
> 
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> ---
>  drivers/iio/adc/adi-axi-adc.c | 22 +++++++++-------------
>  1 file changed, 9 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
> index 9109da2..575a63f 100644
> --- a/drivers/iio/adc/adi-axi-adc.c
> +++ b/drivers/iio/adc/adi-axi-adc.c
> @@ -210,29 +210,25 @@ static void adi_axi_adc_conv_unregister(struct adi_axi_adc_conv *conv)
>  	kfree(cl);
>  }
>  
> -static void devm_adi_axi_adc_conv_release(struct device *dev, void *res)
> +static void devm_adi_axi_adc_conv_release(void *conv)
>  {
> -	adi_axi_adc_conv_unregister(*(struct adi_axi_adc_conv **)res);
> +	adi_axi_adc_conv_unregister(conv);
>  }
>  
>  struct adi_axi_adc_conv *devm_adi_axi_adc_conv_register(struct device *dev,
>  							size_t sizeof_priv)
>  {
> -	struct adi_axi_adc_conv **ptr, *conv;
> -
> -	ptr = devres_alloc(devm_adi_axi_adc_conv_release, sizeof(*ptr),
> -			   GFP_KERNEL);
> -	if (!ptr)
> -		return ERR_PTR(-ENOMEM);
> +	struct adi_axi_adc_conv *conv;
> +	int ret;
>  
>  	conv = adi_axi_adc_conv_register(dev, sizeof_priv);
> -	if (IS_ERR(conv)) {
> -		devres_free(ptr);
> +	if (IS_ERR(conv))
>  		return ERR_CAST(conv);

Is that ERR_CAST() needed here?  conv is already of the
right type so we don't need to cast it to a void * and back gain.
Obviously was there before an not needed either, but might as well
tidy it up whilst we are here!

Thanks,

Jonathan



> -	}
>  
> -	*ptr = conv;
> -	devres_add(dev, ptr);
> +	ret = devm_add_action_or_reset(dev, devm_adi_axi_adc_conv_release,
> +				       conv);
> +	if (ret)
> +		return ERR_PTR(ret);
>  
>  	return conv;
>  }

