Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8A223A938F
	for <lists+linux-iio@lfdr.de>; Wed, 16 Jun 2021 09:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbhFPHSF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 16 Jun 2021 03:18:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:40608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231168AbhFPHSF (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 16 Jun 2021 03:18:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7B83661359;
        Wed, 16 Jun 2021 07:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623827759;
        bh=kmJ1hExfoZkElJA5A1wffhXVn+RQcy0qLAtNOVtSsUo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=G0DarDTJi3vprkcFw6TVY/FdgmkALafwk2vHruKtbaEaj8vLY+LHdWZOZ1uiIWSox
         5+F+9oHk296s+Poq4zxl08EJRP2v5kYfghto2lvMqoWWCclZtTRWTliq3af2A8C25k
         2nwx/rvOtLoBdfj/OZkTo31jWqHX2OAfHiNTqdFIbulYezlp9ge56bNvye9H2UVlQ7
         q8HyWFvD2Lru2N3qGi8/omXeSFCnE0vqm+hfa8zD6br1oSgWtn1F5CAJoZqLiQs7ZH
         RHix+KruqRvSwqrXd+nwZf/KV3xNxW0cpf2/nBYJGFSSaeU3whsOTYZJMJZI5J98/L
         0AYCZsDGjJHdw==
Date:   Wed, 16 Jun 2021 09:15:55 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 2/6] iio: adc: ads1015: Balance runtime pm + 
 pm_runtime_resume_and_get()
Message-ID: <20210616091555.662c305a@coco.lan>
In-Reply-To: <20210516162103.1332291-3-jic23@kernel.org>
References: <20210516162103.1332291-1-jic23@kernel.org>
        <20210516162103.1332291-3-jic23@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Em Sun, 16 May 2021 17:20:59 +0100
Jonathan Cameron <jic23@kernel.org> escreveu:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> The call to pm_runtime_put_noidle() in remove() is not balancing a
> counter increment.  Note this doesn't matter as the runtime pm core
> will not allow the counter to go negative.  However, it is confusing
> to the reader so let's remove it.
> 
> The pm_runtime_resume_and_get() replacement was found using coccicheck
> script under review at:
> https://lore.kernel.org/lkml/20210427141946.2478411-1-Julia.Lawall@inria.fr/
> 
> This is a prequel to taking a closer look at the runtime pm in IIO drivers
> in general.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

LGTM.

Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

> ---
>  drivers/iio/adc/ti-ads1015.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
> index 5b828428be77..b0352e91ac16 100644
> --- a/drivers/iio/adc/ti-ads1015.c
> +++ b/drivers/iio/adc/ti-ads1015.c
> @@ -323,9 +323,7 @@ static int ads1015_set_power_state(struct ads1015_data *data, bool on)
>  	struct device *dev = regmap_get_device(data->regmap);
>  
>  	if (on) {
> -		ret = pm_runtime_get_sync(dev);
> -		if (ret < 0)
> -			pm_runtime_put_noidle(dev);
> +		ret = pm_runtime_resume_and_get(dev);
>  	} else {
>  		pm_runtime_mark_last_busy(dev);
>  		ret = pm_runtime_put_autosuspend(dev);
> @@ -1070,7 +1068,6 @@ static int ads1015_remove(struct i2c_client *client)
>  
>  	pm_runtime_disable(&client->dev);
>  	pm_runtime_set_suspended(&client->dev);
> -	pm_runtime_put_noidle(&client->dev);
>  
>  	/* power down single shot mode */
>  	return ads1015_set_conv_mode(data, ADS1015_SINGLESHOT);



Thanks,
Mauro
