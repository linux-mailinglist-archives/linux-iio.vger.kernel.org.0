Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FDDC37BE57
	for <lists+linux-iio@lfdr.de>; Wed, 12 May 2021 15:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbhELNkT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 12 May 2021 09:40:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:47924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230037AbhELNkT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 12 May 2021 09:40:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8FE4A613DA;
        Wed, 12 May 2021 13:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620826750;
        bh=PV0a8omFEVfvipd7pcJ3XP5TJjFzNkWp7TP+TnJV1WQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=o9FkXulci7dJvxwaH5CpMiHzWy9IFZeK2q+wtx3x2icZtzZd+gW39OcygH7t7anOa
         ql5XqRY1pBF51ATiu2emwE5qxuMHhGowRXNkW7g05W0pobiHh15ePnlZO4gWl+XVuU
         RxWmoNUk5erROfNID762BIIY0RLzMP2kR3bwKz4RqmjTXSI+TYfQPXTjMFJ7Ld6HZ4
         FJgKfBemzON6J+pQxJ/ReAHtd1ZiETntuD0vI1dBzqrOrXHlxAadr/FtTJ0o3LSvUo
         JBvWtqfSIg4J13b4GoQnHvXZhfWCRr2Gv0UjVb1xy4nI0Kr4UhZ7YYotOdJwOY6BIE
         EZwum1rYPR2FA==
Date:   Wed, 12 May 2021 15:39:06 +0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Julia Lawall <Julia.Lawall@inria.fr>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 07/28] iio: accel: kxcjk-1013: Balance runtime pm + use
 pm_runtime_resume_and_get()
Message-ID: <20210512153906.7ae6e469@coco.lan>
In-Reply-To: <20210509113354.660190-8-jic23@kernel.org>
References: <20210509113354.660190-1-jic23@kernel.org>
        <20210509113354.660190-8-jic23@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Em Sun,  9 May 2021 12:33:33 +0100
Jonathan Cameron <jic23@kernel.org> escreveu:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> This driver alls pm_runtime_put_noidle() in it's remove function, but there
> is no matching get call.  This isn't a bug as runtime pm will not allow
> the reference counter to go negative, but it is missleading so lets remove
> it.
> 
> Whilst here use pm_runtime_resume_and_get() to tidy up some boilerplate.
> The coccicheck script didn't get this one due to the less obvious
> structure. Found by inspection.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Hans de Goede <hdegoede@redhat.com>

LGTM.

Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

> ---
>  drivers/iio/accel/kxcjk-1013.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
> index 283e6a3feffc..a9e3dae43ac5 100644
> --- a/drivers/iio/accel/kxcjk-1013.c
> +++ b/drivers/iio/accel/kxcjk-1013.c
> @@ -478,7 +478,7 @@ static int kxcjk1013_set_power_state(struct kxcjk1013_data *data, bool on)
>  	int ret;
>  
>  	if (on)
> -		ret = pm_runtime_get_sync(&data->client->dev);
> +		ret = pm_runtime_resume_and_get(&data->client->dev);
>  	else {
>  		pm_runtime_mark_last_busy(&data->client->dev);
>  		ret = pm_runtime_put_autosuspend(&data->client->dev);
> @@ -486,8 +486,6 @@ static int kxcjk1013_set_power_state(struct kxcjk1013_data *data, bool on)
>  	if (ret < 0) {
>  		dev_err(&data->client->dev,
>  			"Failed: %s for %d\n", __func__, on);
> -		if (on)
> -			pm_runtime_put_noidle(&data->client->dev);
>  		return ret;
>  	}
>  #endif
> @@ -1485,7 +1483,6 @@ static int kxcjk1013_remove(struct i2c_client *client)
>  
>  	pm_runtime_disable(&client->dev);
>  	pm_runtime_set_suspended(&client->dev);
> -	pm_runtime_put_noidle(&client->dev);
>  
>  	if (data->dready_trig) {
>  		iio_triggered_buffer_cleanup(indio_dev);



Thanks,
Mauro
