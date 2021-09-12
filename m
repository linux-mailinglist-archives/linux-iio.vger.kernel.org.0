Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 535FB407EAD
	for <lists+linux-iio@lfdr.de>; Sun, 12 Sep 2021 18:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbhILQjy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 12 Sep 2021 12:39:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:49710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229643AbhILQjx (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 12 Sep 2021 12:39:53 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F258B6108E;
        Sun, 12 Sep 2021 16:38:37 +0000 (UTC)
Date:   Sun, 12 Sep 2021 17:42:10 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Florian Boor <florian.boor@kernelconcepts.de>
Subject: Re: [PATCH v2] iio: adc: ad799x: Add a single error handling block
 at the end of the function.
Message-ID: <20210912174210.6443865b@jic23-huawei>
In-Reply-To: <20210912064101.539-1-caihuoqing@baidu.com>
References: <20210912064101.539-1-caihuoqing@baidu.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 12 Sep 2021 14:41:01 +0800
Cai Huoqing <caihuoqing@baidu.com> wrote:

> A single error handling block at the end of the function could
> be brought in to make code a little more concise.
> 
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
+CC Florian who is reworking some of the regulator handling in this driver.

https://lore.kernel.org/linux-iio/20210908152525.2946785-1-florian.boor@kernelconcepts.de/

One suggestion I made to Florian's v2 was to make the enabling of st->vref
only occur it is actually present (rather than no there after making it
optional).  That is going to cause merge problems against this patch.

@Florian, would you mind adding Cai Huoqing's patch to your series so that
we get both your improvements and his on one go without conflicts?
Either apply it as a precursor or rebase it on top of your patches.

Thanks,

Jonathan

> ---
> v1->v2:
> Change the error path-error_disable_reg from "st->vref" to "st->reg".
> 
>  drivers/iio/adc/ad799x.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
> index 18bf8386d50a..d3dbc4c1e375 100644
> --- a/drivers/iio/adc/ad799x.c
> +++ b/drivers/iio/adc/ad799x.c
> @@ -891,20 +891,23 @@ static int __maybe_unused ad799x_resume(struct device *dev)
>  	}
>  	ret = regulator_enable(st->vref);
>  	if (ret) {
> -		regulator_disable(st->reg);
>  		dev_err(dev, "Unable to enable vref regulator\n");
> -		return ret;
> +		goto error_disable_reg;
>  	}
>  
>  	/* resync config */
>  	ret = ad799x_update_config(st, st->config);
> -	if (ret) {
> -		regulator_disable(st->vref);
> -		regulator_disable(st->reg);
> -		return ret;
> -	}
> +	if (ret)
> +		goto error_disable_vref;
>  
>  	return 0;
> +
> +error_disable_vref:
> +	regulator_disable(st->vref);
> +error_disable_reg:
> +	regulator_disable(st->reg);
> +
> +	return ret;
>  }
>  
>  static SIMPLE_DEV_PM_OPS(ad799x_pm_ops, ad799x_suspend, ad799x_resume);

