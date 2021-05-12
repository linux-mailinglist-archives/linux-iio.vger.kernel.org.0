Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1999337BE50
	for <lists+linux-iio@lfdr.de>; Wed, 12 May 2021 15:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbhELNgW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 12 May 2021 09:36:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:47168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230213AbhELNgU (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 12 May 2021 09:36:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6DCBC613DA;
        Wed, 12 May 2021 13:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620826512;
        bh=6d2nAVBS67C1uLACZAByAQw9Bt4bjDpFVO3EmisWfC0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=C528qkQ7eTdskVUSRHKVCCgamRMas+Tv6551uoddDTGbt1TbrZa9kfQyr+1uawxCA
         qtAn3gSKFZ6Pra1sVT2nx3L8jk3MKmiUkbZmOq005XDxhbj4tr1tTbqQh0RoGg9PET
         jMAmQThKPRaDlJhkcb/ZkDxNvCz/eDn7Q0+roEzOTfQhPmcq8pDHHZxfq2O3VAx4+L
         dBsLI3t3vCPjbsKfDLNvxJr5u37KxiufpVSzi24DyYJxlka+yH0ZzBI2TV9koL6MOt
         ENGSQ7c0kcICHwkfr0UYLyUeTUzYztGuJp0hZWe+dwp+yzcwX41FuxgT5uCKYXo9bf
         bxiPjvodApuhA==
Date:   Wed, 12 May 2021 15:35:08 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Julia Lawall <Julia.Lawall@inria.fr>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Brian Masney <masneyb@onstation.org>
Subject: Re: [PATCH 03/28] iio: light: tsl2583: Balance runtime pm + use
 pm_runtime_resume_and_get()
Message-ID: <20210512153508.0b902d88@coco.lan>
In-Reply-To: <20210509113354.660190-4-jic23@kernel.org>
References: <20210509113354.660190-1-jic23@kernel.org>
        <20210509113354.660190-4-jic23@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Em Sun,  9 May 2021 12:33:29 +0100
Jonathan Cameron <jic23@kernel.org> escreveu:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Error paths in read_raw() and write_raw() callbacks failed to perform and
> type of runtime pm put().  Remove called pm_runtime_put_noidle()
> but there is no equivalent get (this is safe because the reference
> count is protected against going below zero, but it is misleading.
> 
> Whilst here use pm_runtime_resume_and_get() to replace boilerplate.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Brian Masney <masneyb@onstation.org>

LGTM.

Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>


> ---
>  drivers/iio/light/tsl2583.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/light/tsl2583.c b/drivers/iio/light/tsl2583.c
> index 0f787bfc88fc..1f4ad4047a86 100644
> --- a/drivers/iio/light/tsl2583.c
> +++ b/drivers/iio/light/tsl2583.c
> @@ -636,9 +636,7 @@ static int tsl2583_set_pm_runtime_busy(struct tsl2583_chip *chip, bool on)
>  	int ret;
>  
>  	if (on) {
> -		ret = pm_runtime_get_sync(&chip->client->dev);
> -		if (ret < 0)
> -			pm_runtime_put_noidle(&chip->client->dev);
> +		ret = pm_runtime_resume_and_get(&chip->client->dev);
>  	} else {
>  		pm_runtime_mark_last_busy(&chip->client->dev);
>  		ret = pm_runtime_put_autosuspend(&chip->client->dev);
> @@ -721,8 +719,10 @@ static int tsl2583_read_raw(struct iio_dev *indio_dev,
>  read_done:
>  	mutex_unlock(&chip->als_mutex);
>  
> -	if (ret < 0)
> +	if (ret < 0) {
> +		tsl2583_set_pm_runtime_busy(chip, false);
>  		return ret;
> +	}
>  
>  	/*
>  	 * Preserve the ret variable if the call to
> @@ -783,8 +783,10 @@ static int tsl2583_write_raw(struct iio_dev *indio_dev,
>  
>  	mutex_unlock(&chip->als_mutex);
>  
> -	if (ret < 0)
> +	if (ret < 0) {
> +		tsl2583_set_pm_runtime_busy(chip, false);
>  		return ret;
> +	}
>  
>  	ret = tsl2583_set_pm_runtime_busy(chip, false);
>  	if (ret < 0)
> @@ -872,7 +874,6 @@ static int tsl2583_remove(struct i2c_client *client)
>  
>  	pm_runtime_disable(&client->dev);
>  	pm_runtime_set_suspended(&client->dev);
> -	pm_runtime_put_noidle(&client->dev);
>  
>  	return tsl2583_set_power_state(chip, TSL2583_CNTL_PWR_OFF);
>  }



Thanks,
Mauro
