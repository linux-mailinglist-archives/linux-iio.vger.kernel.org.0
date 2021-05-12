Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1C6C37BE54
	for <lists+linux-iio@lfdr.de>; Wed, 12 May 2021 15:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbhELNiZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 12 May 2021 09:38:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:47594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230343AbhELNiW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 12 May 2021 09:38:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C13F961396;
        Wed, 12 May 2021 13:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620826634;
        bh=WZWUVJv6wHBuiJ8L9DgzRbddiGUflgyKMlK3SlEXGQ0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gri7qyNUIpzL2n+4B8s5R6cR3nvN/HIOeVeEd9RBoPAXl7KfzzycxFmYns61POedw
         xVfxZk0d/UEliWP0zHUyAan9yBBvwIzytEj5NwxeIGXRQOq5uaBygBTIt4L3EU01CN
         eswcEtqQoLm7ynjb1HFMEl9DoseCNUEp/NZRbEgfQHw001GK44nLiwd3tWduuW+JFt
         7Xx44kdMVnnOB+54OG7bzkiYh9KmemjwQhkOgW5RBubK8U5p+NywUa6+YQX83fG1Yi
         IvLkcZqJiwKfvXm3MpWwyTLy1CJXmoGU6hL+rH82Gx8Wack4p8AsLpxT4lS1X52Ljy
         mujMnPEjWiNVQ==
Date:   Wed, 12 May 2021 15:37:10 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Julia Lawall <Julia.Lawall@inria.fr>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sean Nyekjaer <sean@geanix.com>
Subject: Re: [PATCH 05/28] iio: accel: mma8452: Balance runtime pm + use
 pm_runtime_resume_and_get()
Message-ID: <20210512153710.6d8957a2@coco.lan>
In-Reply-To: <20210509113354.660190-6-jic23@kernel.org>
References: <20210509113354.660190-1-jic23@kernel.org>
        <20210509113354.660190-6-jic23@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Em Sun,  9 May 2021 12:33:31 +0100
Jonathan Cameron <jic23@kernel.org> escreveu:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Remove() callback calls pm_runtime_put_noidle() but there it is not
> balancing a get.  No actual affect because the runtime pm core prevents
> the reference count going negative.
> 
> Whilst here use pm_runtime_resume_and_get() rather than open coded version.
> Again, coccinelle script missed this one due to more complex code
> structure.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Sean Nyekjaer <sean@geanix.com>

LGTM.

Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

> ---
>  drivers/iio/accel/mma8452.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
> index 464a6bfe6746..715b8138fb71 100644
> --- a/drivers/iio/accel/mma8452.c
> +++ b/drivers/iio/accel/mma8452.c
> @@ -221,7 +221,7 @@ static int mma8452_set_runtime_pm_state(struct i2c_client *client, bool on)
>  	int ret;
>  
>  	if (on) {
> -		ret = pm_runtime_get_sync(&client->dev);
> +		ret = pm_runtime_resume_and_get(&client->dev);
>  	} else {
>  		pm_runtime_mark_last_busy(&client->dev);
>  		ret = pm_runtime_put_autosuspend(&client->dev);
> @@ -230,8 +230,6 @@ static int mma8452_set_runtime_pm_state(struct i2c_client *client, bool on)
>  	if (ret < 0) {
>  		dev_err(&client->dev,
>  			"failed to change power state to %d\n", on);
> -		if (on)
> -			pm_runtime_put_noidle(&client->dev);
>  
>  		return ret;
>  	}
> @@ -1711,7 +1709,6 @@ static int mma8452_remove(struct i2c_client *client)
>  
>  	pm_runtime_disable(&client->dev);
>  	pm_runtime_set_suspended(&client->dev);
> -	pm_runtime_put_noidle(&client->dev);
>  
>  	iio_triggered_buffer_cleanup(indio_dev);
>  	mma8452_trigger_cleanup(indio_dev);



Thanks,
Mauro
