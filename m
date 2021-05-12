Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C901937BE70
	for <lists+linux-iio@lfdr.de>; Wed, 12 May 2021 15:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbhELNpo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 12 May 2021 09:45:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:49634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230037AbhELNpn (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 12 May 2021 09:45:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DC06F61007;
        Wed, 12 May 2021 13:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620827075;
        bh=hP7Nejt/GkL9n1f1tZQ6HOVoNycomFL/+xlQo73ztEE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EGAGPy2xm0mxXFLYNNA1cV6bZGvvv3zB7LEMRTgYgW54KFMIw9orxHz+eWt1lTVvr
         TLljU/obeGyxPJrqDlHvECW2CmU76S3l3KKkVgvpzlFF6JQPp15kXpzRdN+yuG2PEC
         CiiE1nZqVsZlWSZVJP7ff5FFBQ2IRr80UQztLQVOpDrpNBljBz4WdROB2erKxqsdai
         Orab+y0BhciOpPNwYaRO3gSYgbS5lCtLh3qKXXwhfOCra93m5gR2eGqXzB7PE+WgRM
         5wa7niqAXRH4jNupjj+1uwFy6Pzi5NI/RYUiFo+n1kJG+Lx023wQl9Kd4Z0GlgmdDQ
         vstw2vpYB+vzg==
Date:   Wed, 12 May 2021 15:44:30 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Julia Lawall <Julia.Lawall@inria.fr>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH 08/28] iio: hid: trigger: Balance runtime pm + use
 pm_runtime_resume_and_get()
Message-ID: <20210512154430.36edf9b7@coco.lan>
In-Reply-To: <20210509113354.660190-9-jic23@kernel.org>
References: <20210509113354.660190-1-jic23@kernel.org>
        <20210509113354.660190-9-jic23@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Em Sun,  9 May 2021 12:33:34 +0100
Jonathan Cameron <jic23@kernel.org> escreveu:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> The call to pm_runtime_put_noidle() in remove() callback is not
> balanced by any gets
> 
> Note this doesn't cause any problems beyond reader confusion as the runtime
> pm core protects against the reference counter going negative.
> 
> Whilst here, use pm_runtiem_resume_and_get() to simplify code a little.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

RPM get/put logic LGTM.

Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

> ---
>  drivers/iio/common/hid-sensors/hid-sensor-trigger.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> index 5a7b3e253e58..c06537e106e9 100644
> --- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> +++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> @@ -163,18 +163,15 @@ int hid_sensor_power_state(struct hid_sensor_common *st, bool state)
>  
>  	if (state) {
>  		atomic_inc(&st->user_requested_state);
> -		ret = pm_runtime_get_sync(&st->pdev->dev);
> +		ret = pm_runtime_resume_and_get(&st->pdev->dev);
>  	} else {
>  		atomic_dec(&st->user_requested_state);
>  		pm_runtime_mark_last_busy(&st->pdev->dev);
>  		pm_runtime_use_autosuspend(&st->pdev->dev);
>  		ret = pm_runtime_put_autosuspend(&st->pdev->dev);
>  	}
> -	if (ret < 0) {
> -		if (state)
> -			pm_runtime_put_noidle(&st->pdev->dev);
> +	if (ret < 0)
>  		return ret;
> -	}
>  
>  	return 0;
>  #else
> @@ -222,7 +219,6 @@ void hid_sensor_remove_trigger(struct iio_dev *indio_dev,
>  		pm_runtime_disable(&attrb->pdev->dev);
>  
>  	pm_runtime_set_suspended(&attrb->pdev->dev);
> -	pm_runtime_put_noidle(&attrb->pdev->dev);
>  
>  	cancel_work_sync(&attrb->work);
>  	iio_trigger_unregister(attrb->trigger);



Thanks,
Mauro
