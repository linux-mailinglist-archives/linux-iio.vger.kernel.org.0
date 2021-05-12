Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76FD637BE74
	for <lists+linux-iio@lfdr.de>; Wed, 12 May 2021 15:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbhELNqY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 12 May 2021 09:46:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:49966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230037AbhELNqX (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 12 May 2021 09:46:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3B6E4613D3;
        Wed, 12 May 2021 13:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620827115;
        bh=Euj+FBprSkwbzl0YkllUdPR7A7JdkhVnCehUQc9ltlk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Fb11Lm1RunUNXwW9D9JocMZfck6Alzd+00l22Y5RggoaCyyNG0pkGbTeOYRdziZNA
         u6iZwH0bKsX9sX7MLthYxBdbd6clMvJNOUpen/9R+duHZPCaxsJQeztDjf/yglwR0B
         +nizkjVh1cPK2VOYDpMVeTR+moFh7vf5UNU8uEOYdpI70TlcJ54O1fdvUarxFcxrb8
         T1Q8YXKMDPW6Cd7bORpOFPUT6xpCD9Whfz38VdvDSVGfCRr/krg0K2f4jfjMM0esQe
         +hDRfRyglOr7GOHeznkwJ+hG0nMJ9pUT2aLYWKQblqhp8sxc6ecGV3EcVvny4VpQwi
         zHpsNrGo9QEDw==
Date:   Wed, 12 May 2021 15:45:11 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Julia Lawall <Julia.Lawall@inria.fr>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 09/28] iio: imu: kmx61: Balance runtime pm + use
 pm_runtime_resume_and_get()
Message-ID: <20210512154511.48506a44@coco.lan>
In-Reply-To: <20210509113354.660190-10-jic23@kernel.org>
References: <20210509113354.660190-1-jic23@kernel.org>
        <20210509113354.660190-10-jic23@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Em Sun,  9 May 2021 12:33:35 +0100
Jonathan Cameron <jic23@kernel.org> escreveu:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> No point in calling pm_runtime_put_noidle() that isn't balancing a get.
> Note no actual impact because the runtime pm core protects against
> a negative reference counter.
> 
> For the pm_runtime_resume_and_get() main interest is in clearing
> out this old pattern to avoid it getting coppied into new submissions.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

LGTM.

Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

> ---
>  drivers/iio/imu/kmx61.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/imu/kmx61.c b/drivers/iio/imu/kmx61.c
> index d3e06ce99c1e..1dabfd615dab 100644
> --- a/drivers/iio/imu/kmx61.c
> +++ b/drivers/iio/imu/kmx61.c
> @@ -750,7 +750,7 @@ static int kmx61_set_power_state(struct kmx61_data *data, bool on, u8 device)
>  	}
>  
>  	if (on) {
> -		ret = pm_runtime_get_sync(&data->client->dev);
> +		ret = pm_runtime_resume_and_get(&data->client->dev);
>  	} else {
>  		pm_runtime_mark_last_busy(&data->client->dev);
>  		ret = pm_runtime_put_autosuspend(&data->client->dev);
> @@ -759,8 +759,6 @@ static int kmx61_set_power_state(struct kmx61_data *data, bool on, u8 device)
>  		dev_err(&data->client->dev,
>  			"Failed: kmx61_set_power_state for %d, ret %d\n",
>  			on, ret);
> -		if (on)
> -			pm_runtime_put_noidle(&data->client->dev);
>  
>  		return ret;
>  	}
> @@ -1426,7 +1424,6 @@ static int kmx61_remove(struct i2c_client *client)
>  
>  	pm_runtime_disable(&client->dev);
>  	pm_runtime_set_suspended(&client->dev);
> -	pm_runtime_put_noidle(&client->dev);
>  
>  	if (client->irq > 0) {
>  		iio_triggered_buffer_cleanup(data->acc_indio_dev);



Thanks,
Mauro
