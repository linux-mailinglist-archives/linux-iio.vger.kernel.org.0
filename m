Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F3FA37BECC
	for <lists+linux-iio@lfdr.de>; Wed, 12 May 2021 15:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbhELNuR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 12 May 2021 09:50:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:52204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230369AbhELNuK (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 12 May 2021 09:50:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F2F1260FE6;
        Wed, 12 May 2021 13:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620827342;
        bh=uwcZFLs0Hkt9g/3P2ZK0lIEvbgx/1T54J1/52hgLWgQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZwypIsmFYuEZNQxAf5t40Har/2TuTXSMh1EXDUSsqqVFq0z6qqrr1LVOabhL15xBn
         5WRFxuXJbPEWwF5oGLKTwKqiObsLgKlZ9UHblx5jh6sdW5UMj1kzArwZrkG/3AowAG
         AyoX/+O03sgCvBkllJ7CeZfdvcmjof41suvOSiWwAkRXwoghH5BOaEmjEOuzOQ1mu+
         8vhzgN6v1zie/BPmyJndM4tLYAA2FdekVBTtZ3nlgDYBuBC8ZtcLCozDYph7DCU2qW
         1vv7WbBBqCTA2qzcf33b83wAIUKWH/HXFAVnsEZ0qWUGaYm1B+XTfVSS2V0gYihEoN
         f5Xudzy7qI2hw==
Date:   Wed, 12 May 2021 15:48:57 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Julia Lawall <Julia.Lawall@inria.fr>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 11/28] iio: magn: bmc150: Balance runtime pm + use
 pm_runtime_resume_and_get()
Message-ID: <20210512154857.26cf12db@coco.lan>
In-Reply-To: <20210509113354.660190-12-jic23@kernel.org>
References: <20210509113354.660190-1-jic23@kernel.org>
        <20210509113354.660190-12-jic23@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Em Sun,  9 May 2021 12:33:37 +0100
Jonathan Cameron <jic23@kernel.org> escreveu:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> probe() error paths after runtime pm is enabled, should disable it.
> remove() should not call pm_runtime_put_noidle() as there is no
> matching get() to have raised the reference count.  This case
> has no affect a the runtime pm core protects against going negative.
> 
> Whilst here use pm_runtime_resume_and_get() to tidy things up a little.
> coccicheck script didn't get this one due to complex code structure so
> found by inspection.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>

LGTM.

Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

> ---
>  drivers/iio/magnetometer/bmc150_magn.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/magnetometer/bmc150_magn.c b/drivers/iio/magnetometer/bmc150_magn.c
> index d75b437a43f2..39920cb764bf 100644
> --- a/drivers/iio/magnetometer/bmc150_magn.c
> +++ b/drivers/iio/magnetometer/bmc150_magn.c
> @@ -262,7 +262,7 @@ static int bmc150_magn_set_power_state(struct bmc150_magn_data *data, bool on)
>  	int ret;
>  
>  	if (on) {
> -		ret = pm_runtime_get_sync(data->dev);
> +		ret = pm_runtime_resume_and_get(data->dev);
>  	} else {
>  		pm_runtime_mark_last_busy(data->dev);
>  		ret = pm_runtime_put_autosuspend(data->dev);
> @@ -271,9 +271,6 @@ static int bmc150_magn_set_power_state(struct bmc150_magn_data *data, bool on)
>  	if (ret < 0) {
>  		dev_err(data->dev,
>  			"failed to change power state to %d\n", on);
> -		if (on)
> -			pm_runtime_put_noidle(data->dev);
> -
>  		return ret;
>  	}
>  #endif
> @@ -963,12 +960,14 @@ int bmc150_magn_probe(struct device *dev, struct regmap *regmap,
>  	ret = iio_device_register(indio_dev);
>  	if (ret < 0) {
>  		dev_err(dev, "unable to register iio device\n");
> -		goto err_buffer_cleanup;
> +		goto err_disable_runtime_pm;
>  	}
>  
>  	dev_dbg(dev, "Registered device %s\n", name);
>  	return 0;
>  
> +err_disable_runtime_pm:
> +	pm_runtime_disable(dev);
>  err_buffer_cleanup:
>  	iio_triggered_buffer_cleanup(indio_dev);
>  err_free_irq:
> @@ -992,7 +991,6 @@ int bmc150_magn_remove(struct device *dev)
>  
>  	pm_runtime_disable(dev);
>  	pm_runtime_set_suspended(dev);
> -	pm_runtime_put_noidle(dev);
>  
>  	iio_triggered_buffer_cleanup(indio_dev);
>  



Thanks,
Mauro
