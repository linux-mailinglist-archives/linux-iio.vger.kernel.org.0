Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41C4F3A9396
	for <lists+linux-iio@lfdr.de>; Wed, 16 Jun 2021 09:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbhFPHSa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 16 Jun 2021 03:18:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:40854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231316AbhFPHS3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 16 Jun 2021 03:18:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 51B32613B9;
        Wed, 16 Jun 2021 07:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623827784;
        bh=fWPj37YLUYxF/QRsM3Gm8unH0zMXzBNgU1J+kOrytt8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=L+/soIjPInd0X71n9pX/QWnQnA7CtymA1gkkcfTCgJxZRgBWvB/dSp2dsDAm2E6zi
         k5EEifUhTQ0Dw62okWeyVDt6Up6/VJa+VLaC1adTESvErNexg4A1EIrqgxvW6H1L/y
         pwj5H1KebNiwkhnIlXLgnWqhv3CiSMJiO6VzFMAfLABpc848+nlQ+peY5LNGN10KCE
         51D/1M3RkR16a9B8ee5/KJgXh5ocHcNwqjSYEYBQOWmKBjCvWScr0ELHQAUjsPYk/0
         Dga+g6riuTHfXdmW8ClZK/YPbXS3MYT3sAXyY9J5fzV6FqpazoSsLXNCKE2kpEXtCC
         Z5W39jZDwxirg==
Date:   Wed, 16 Jun 2021 09:16:20 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>
Subject: Re: [PATCH v2 3/6] iio: chemical: atlas-sensor: Balance runtime pm
 + pm_runtime_resume_and_get()
Message-ID: <20210616091620.5f689adb@coco.lan>
In-Reply-To: <20210516162103.1332291-4-jic23@kernel.org>
References: <20210516162103.1332291-1-jic23@kernel.org>
        <20210516162103.1332291-4-jic23@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Em Sun, 16 May 2021 17:21:00 +0100
Jonathan Cameron <jic23@kernel.org> escreveu:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> The pm_runtime_put_noidle() call in remove isn't balanced with any get, so
> drop it.  Note this isn't a bug as the runtime pm core will not allow the
> reference count to go negative, making this a noop. However, it is
> confusing to the reader so let's drop it.
> 
> pm_runtime_resume_and_get() replacement found using the coccicheck script
> under review at:
> https://lore.kernel.org/lkml/20210427141946.2478411-1-Julia.Lawall@inria.fr/
> 
> As pm_runtime_resume_and_get() returns <= 0 take advantage of that to
> change the error checking to if (ret) which is more in keeping with the
> rest of this driver.
> 
> This is a prequel to taking a closer look at the runtime pm in IIO drivers
> in general.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Matt Ranostay <matt.ranostay@konsulko.com>

LGTM.

Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

> ---
>  drivers/iio/chemical/atlas-sensor.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iio/chemical/atlas-sensor.c b/drivers/iio/chemical/atlas-sensor.c
> index 0fdb3b29c5eb..9cb99585b6ff 100644
> --- a/drivers/iio/chemical/atlas-sensor.c
> +++ b/drivers/iio/chemical/atlas-sensor.c
> @@ -410,11 +410,9 @@ static int atlas_buffer_postenable(struct iio_dev *indio_dev)
>  	struct atlas_data *data = iio_priv(indio_dev);
>  	int ret;
>  
> -	ret = pm_runtime_get_sync(&data->client->dev);
> -	if (ret < 0) {
> -		pm_runtime_put_noidle(&data->client->dev);
> +	ret = pm_runtime_resume_and_get(&data->client->dev);
> +	if (ret)
>  		return ret;
> -	}
>  
>  	return atlas_set_interrupt(data, true);
>  }
> @@ -487,11 +485,9 @@ static int atlas_read_measurement(struct atlas_data *data, int reg, __be32 *val)
>  	int suspended = pm_runtime_suspended(dev);
>  	int ret;
>  
> -	ret = pm_runtime_get_sync(dev);
> -	if (ret < 0) {
> -		pm_runtime_put_noidle(dev);
> +	ret = pm_runtime_resume_and_get(dev);
> +	if (ret)
>  		return ret;
> -	}
>  
>  	if (suspended)
>  		msleep(data->chip->delay);
> @@ -741,7 +737,6 @@ static int atlas_remove(struct i2c_client *client)
>  
>  	pm_runtime_disable(&client->dev);
>  	pm_runtime_set_suspended(&client->dev);
> -	pm_runtime_put_noidle(&client->dev);
>  
>  	return atlas_set_powermode(data, 0);
>  }



Thanks,
Mauro
