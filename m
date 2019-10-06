Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10BD8CD011
	for <lists+linux-iio@lfdr.de>; Sun,  6 Oct 2019 11:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbfJFJ33 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 6 Oct 2019 05:29:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:54258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726250AbfJFJ33 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 6 Oct 2019 05:29:29 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC84720700;
        Sun,  6 Oct 2019 09:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570354168;
        bh=EDp/ZUvX5Z0SqZagNr/ZlDzkzQFYgPS6DAQUamBX9gg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=yFTDwAykyEAVuqtKCZyfrDy0HyPu75DEO3JWOuWXwoK/gO/cnAy3u96+lNI1RK6tQ
         9qadM9C6R6SBIHMbEQ8/Fpwm0siACUdpQN/vigpY8uQv96Y+GaaEI0ocOzecKP79+7
         4coX+nhZu3+/VIOfZdM5kv1fExv+9/bNNI6ZIQAY=
Date:   Sun, 6 Oct 2019 10:29:23 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        freeman.liu@unisoc.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, orsonzhai@gmail.com,
        zhang.lyra@gmail.com
Subject: Re: [PATCH] iio: adc: sc27xx: Use
 devm_hwspin_lock_request_specific() to simplify code
Message-ID: <20191006102923.2d3e1b24@archlinux>
In-Reply-To: <dabc353394772cd27dc64b48278e2366a763269f.1569551672.git.baolin.wang@linaro.org>
References: <dabc353394772cd27dc64b48278e2366a763269f.1569551672.git.baolin.wang@linaro.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 27 Sep 2019 10:41:19 +0800
Baolin Wang <baolin.wang@linaro.org> wrote:

> Change to use devm_hwspin_lock_request_specific() to help to simplify the
> cleanup code for drivers requesting one hwlock.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
Applied to the togreg branch of iio.git and pushed out as testing for the
autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/sc27xx_adc.c |   16 +---------------
>  1 file changed, 1 insertion(+), 15 deletions(-)
> 
> diff --git a/drivers/iio/adc/sc27xx_adc.c b/drivers/iio/adc/sc27xx_adc.c
> index a6c0465..66b387f 100644
> --- a/drivers/iio/adc/sc27xx_adc.c
> +++ b/drivers/iio/adc/sc27xx_adc.c
> @@ -477,13 +477,6 @@ static void sc27xx_adc_disable(void *_data)
>  			   SC27XX_MODULE_ADC_EN, 0);
>  }
>  
> -static void sc27xx_adc_free_hwlock(void *_data)
> -{
> -	struct hwspinlock *hwlock = _data;
> -
> -	hwspin_lock_free(hwlock);
> -}
> -
>  static int sc27xx_adc_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -520,19 +513,12 @@ static int sc27xx_adc_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> -	sc27xx_data->hwlock = hwspin_lock_request_specific(ret);
> +	sc27xx_data->hwlock = devm_hwspin_lock_request_specific(dev, ret);
>  	if (!sc27xx_data->hwlock) {
>  		dev_err(dev, "failed to request hwspinlock\n");
>  		return -ENXIO;
>  	}
>  
> -	ret = devm_add_action_or_reset(dev, sc27xx_adc_free_hwlock,
> -			      sc27xx_data->hwlock);
> -	if (ret) {
> -		dev_err(dev, "failed to add hwspinlock action\n");
> -		return ret;
> -	}
> -
>  	sc27xx_data->dev = dev;
>  
>  	ret = sc27xx_adc_enable(sc27xx_data);

