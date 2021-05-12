Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A734737BEBE
	for <lists+linux-iio@lfdr.de>; Wed, 12 May 2021 15:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231559AbhELNr6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 12 May 2021 09:47:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:50636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231223AbhELNrp (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 12 May 2021 09:47:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0B7C5613DF;
        Wed, 12 May 2021 13:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620827197;
        bh=uu1ZRFBVAvgYjU1B8/yfMGHnEHrAiAkH6gAwYMSuO10=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jJTKGwNINf/t+2S9dWxGd+AoGYOlknXz2kLsZ8FXYrnLDDKQlL1gOFSh1lr1tMZPh
         LPa+jjAIlLkqAO4ASadMjQF5KqGkxPAUKq9HRmKRZ8+k/uczcI1ydj9EsJZIIBPDvA
         SDQcKPB+VgO6S1koPUzT9rZmVr6JxUQCzkUNRYl/VV0qOBT0Yq7p2BFCobFALT1QzR
         7frZzUrJW16xuiIUKn2W/iti64EHcsJRHEFLZuj7y9SWc5E4GZmSqvozyZsocwF8fM
         nLwE4/O5qPfp5wmMtvUVKQGfEN5Zyz7jQbFbAiz1ihoSbtzrcBlJvoCOUyhm3O9ava
         mOTJIJOr3MC+Q==
Date:   Wed, 12 May 2021 15:46:32 +0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Julia Lawall <Julia.Lawall@inria.fr>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Mikko Koivunen <mikko.koivunen@fi.rohmeurope.com>
Subject: Re: [PATCH 10/28] iio: light: rpr0521: Balance runtime pm + use
 pm_runtime_resume_and_get()
Message-ID: <20210512154632.12e470ec@coco.lan>
In-Reply-To: <20210509113354.660190-11-jic23@kernel.org>
References: <20210509113354.660190-1-jic23@kernel.org>
        <20210509113354.660190-11-jic23@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Em Sun,  9 May 2021 12:33:36 +0100
Jonathan Cameron <jic23@kernel.org> escreveu:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Calls to pm_runtime_put_noidle in probe() error path and remove() are
> not match to any get() calls.
> 
> The runtime pm core protects against negative reference counts, so this
> doesn't have any visible impact beyond confusing the reader.
> 
> Whilst here use pm_runtime_resume_and_get() to replace boilerplate.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Mikko Koivunen <mikko.koivunen@fi.rohmeurope.com>

LGTM.

Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

> ---
>  drivers/iio/light/rpr0521.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/light/rpr0521.c b/drivers/iio/light/rpr0521.c
> index 7e332de0e6a5..c2dd8a3d4217 100644
> --- a/drivers/iio/light/rpr0521.c
> +++ b/drivers/iio/light/rpr0521.c
> @@ -360,7 +360,7 @@ static int rpr0521_set_power_state(struct rpr0521_data *data, bool on,
>  	 * both stay enabled until _suspend().
>  	 */
>  	if (on) {
> -		ret = pm_runtime_get_sync(&data->client->dev);
> +		ret = pm_runtime_resume_and_get(&data->client->dev);
>  	} else {
>  		pm_runtime_mark_last_busy(&data->client->dev);
>  		ret = pm_runtime_put_autosuspend(&data->client->dev);
> @@ -369,9 +369,6 @@ static int rpr0521_set_power_state(struct rpr0521_data *data, bool on,
>  		dev_err(&data->client->dev,
>  			"Failed: rpr0521_set_power_state for %d, ret %d\n",
>  			on, ret);
> -		if (on)
> -			pm_runtime_put_noidle(&data->client->dev);
> -
>  		return ret;
>  	}
>  
> @@ -1038,7 +1035,6 @@ static int rpr0521_probe(struct i2c_client *client,
>  err_pm_disable:
>  	pm_runtime_disable(&client->dev);
>  	pm_runtime_set_suspended(&client->dev);
> -	pm_runtime_put_noidle(&client->dev);
>  err_poweroff:
>  	rpr0521_poweroff(data);
>  
> @@ -1053,7 +1049,6 @@ static int rpr0521_remove(struct i2c_client *client)
>  
>  	pm_runtime_disable(&client->dev);
>  	pm_runtime_set_suspended(&client->dev);
> -	pm_runtime_put_noidle(&client->dev);
>  
>  	rpr0521_poweroff(iio_priv(indio_dev));
>  



Thanks,
Mauro
