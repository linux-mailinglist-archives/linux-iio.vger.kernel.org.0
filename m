Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCD483A93A7
	for <lists+linux-iio@lfdr.de>; Wed, 16 Jun 2021 09:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbhFPHUw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 16 Jun 2021 03:20:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:41760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231239AbhFPHUw (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 16 Jun 2021 03:20:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B15096135C;
        Wed, 16 Jun 2021 07:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623827926;
        bh=9F/86IalsbzNEi75w7Fi2yYj6JuvACRRZTWGov9fwwE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iQaxyMpl1mAOGR0sOnEh028elJ0vzmjNbpJLEScCGAQW1n1wec0CRO2UferN1JrRd
         mmDoFis1w9hGSxCGtMaw8Z9bQ9PQGHX3vya38jQ0aoc5gfy5L0KgANzmXpTvke8W34
         OAEsQcv0mPE4Z9aR+5y9dyyTaXc5ygWw4u3QgGqucaH3zHLFFYpPzpXY7aiEH90dxT
         /xutfnnMd4K+gzumYMoSJuyymwpSN7uAf0Oc6yqZ3hvHhSf+/bJC8rIWbwVbULgLDd
         0jOqLHE1o8khQV7MZbI1I/bYqbI4Wyk6BQdHvXcfhsa/PkUKuEzLgmlIwXbx02kd3v
         h1J0CQa+j2Hkw==
Date:   Wed, 16 Jun 2021 09:18:42 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>
Subject: Re: [PATCH v2 4/6] iio: prox: pulsed-light-v2: Fix misbalance
 runtime pm in error path
Message-ID: <20210616091842.7caae83e@coco.lan>
In-Reply-To: <20210516162103.1332291-5-jic23@kernel.org>
References: <20210516162103.1332291-1-jic23@kernel.org>
        <20210516162103.1332291-5-jic23@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Em Sun, 16 May 2021 17:21:01 +0100
Jonathan Cameron <jic23@kernel.org> escreveu:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> There is one path in which we don't do a runtime pm put and so
> leave the device enabled for ever more.
> 
> Reported-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Fixes: 4ac4e086fd8c ("iio: pulsedlight-lidar-lite: add runtime PM")
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Matt Ranostay <matt.ranostay@konsulko.com>

I was unable to apply it on the top of next-20210615, although
the patch looks good to me.

Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

> ---
>  drivers/iio/proximity/pulsedlight-lidar-lite-v2.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
> index 822a68ae5e03..ecaeb1e11007 100644
> --- a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
> +++ b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
> @@ -164,7 +164,7 @@ static int lidar_get_measurement(struct lidar_data *data, u16 *reg)
>  	ret = lidar_write_control(data, LIDAR_REG_CONTROL_ACQUIRE);
>  	if (ret < 0) {
>  		dev_err(&client->dev, "cannot send start measurement command");
> -		return ret;
> +		goto err;
>  	}
>  
>  	while (tries--) {
> @@ -188,6 +188,7 @@ static int lidar_get_measurement(struct lidar_data *data, u16 *reg)
>  		}
>  		ret = -EIO;
>  	}
> +err:
>  	pm_runtime_mark_last_busy(&client->dev);
>  	pm_runtime_put_autosuspend(&client->dev);
>  



Thanks,
Mauro
