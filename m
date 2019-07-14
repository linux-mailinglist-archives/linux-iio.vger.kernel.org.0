Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7CF67F75
	for <lists+linux-iio@lfdr.de>; Sun, 14 Jul 2019 16:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728442AbfGNOwC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Jul 2019 10:52:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:53344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728146AbfGNOwC (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 14 Jul 2019 10:52:02 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA525205F4;
        Sun, 14 Jul 2019 14:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563115921;
        bh=TELv7KUDYGcguKCb8eC20yqkauhe7EkkRdh84U4h57g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ndxf1N+8BbjjAPaM57WqqZU53cqzWKLXHw5MaLQSKX892Kv++j80qfz0HtIGteGll
         XLh+x3QrkOiVkEmJNGtxa9z3A7t5rmsefSDwbeE/yiu5fTqbAL7nSzg+iP5Sn4VOum
         KNbRpXYWY3VIVJMqnEywbAeGpNos07OP4lGDsprA=
Date:   Sun, 14 Jul 2019 15:51:57 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     freeman.liu@spreadtrum.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/14] iio: adc: sc27xx: Replace devm_add_action()
 followed by failure action with devm_add_action_or_reset()
Message-ID: <20190714155157.7e4a37b0@archlinux>
In-Reply-To: <20190708123243.11713-1-huangfq.daxian@gmail.com>
References: <20190708123243.11713-1-huangfq.daxian@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon,  8 Jul 2019 20:32:43 +0800
Fuqian Huang <huangfq.daxian@gmail.com> wrote:

> devm_add_action_or_reset() is introduced as a helper function which 
> internally calls devm_add_action(). If devm_add_action() fails 
> then it will execute the action mentioned and return the error code.
> This reduce source code size (avoid writing the action twice) 
> and reduce the likelyhood of bugs.
> 
> Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/sc27xx_adc.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/adc/sc27xx_adc.c b/drivers/iio/adc/sc27xx_adc.c
> index ec86f640e963..d7ca002cbb17 100644
> --- a/drivers/iio/adc/sc27xx_adc.c
> +++ b/drivers/iio/adc/sc27xx_adc.c
> @@ -546,10 +546,9 @@ static int sc27xx_adc_probe(struct platform_device *pdev)
>  		return -ENXIO;
>  	}
>  
> -	ret = devm_add_action(dev, sc27xx_adc_free_hwlock,
> +	ret = devm_add_action_or_reset(dev, sc27xx_adc_free_hwlock,
>  			      sc27xx_data->hwlock);
>  	if (ret) {
> -		sc27xx_adc_free_hwlock(sc27xx_data->hwlock);
>  		dev_err(dev, "failed to add hwspinlock action\n");
>  		return ret;
>  	}
> @@ -563,9 +562,8 @@ static int sc27xx_adc_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> -	ret = devm_add_action(dev, sc27xx_adc_disable, sc27xx_data);
> +	ret = devm_add_action_or_reset(dev, sc27xx_adc_disable, sc27xx_data);
>  	if (ret) {
> -		sc27xx_adc_disable(sc27xx_data);
>  		dev_err(dev, "failed to add ADC disable action\n");
>  		return ret;
>  	}

