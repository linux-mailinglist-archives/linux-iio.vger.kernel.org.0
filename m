Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EBFB37C1FF
	for <lists+linux-iio@lfdr.de>; Wed, 12 May 2021 17:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbhELPGJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 12 May 2021 11:06:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:58866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233375AbhELPFQ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 12 May 2021 11:05:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4AC8C61949;
        Wed, 12 May 2021 15:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620831609;
        bh=9s3eOG8JW2vH/hVWEC1mhs43lGfp7P4v7YmbJn+wyhE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mX5fHlYTGPHzYB41RYO3bIxhh4ftOCl6YN35YHJk95eiyb6XU4KfT06lZiwXuovcE
         X1iRSHUpsk0OWQ5WXSVhtEi65PO5/tlJqpUJoMWRg37g8yAYzMhkzmbu8xue+JCVfs
         MuAAXMXBR9DHMjDDoyUzqb0SfzOEIcylcwLpNfSvA3t3GdPBSbzdPx8GXvRusfyf3Z
         A1+gARause4nylHujaidrkPWHy9Re5WGhkzq+EL/Imp3dRIUxDRc9n0Ze3WHfW7Vkh
         tjaIq7w9gt61llFMrysJw8s2itt2jx+BX01JbTB2YcpWODSNP26H9xZVQpm7QwQnni
         ZZerAq/MpJ+vg==
Date:   Wed, 12 May 2021 17:00:04 +0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Julia Lawall <Julia.Lawall@inria.fr>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: Re: [PATCH 27/28] iio: pressure: icp10100: Use
 pm_runtime_resume_and_get() + handle errors
Message-ID: <20210512170004.3c6dc2a6@coco.lan>
In-Reply-To: <20210509113354.660190-28-jic23@kernel.org>
References: <20210509113354.660190-1-jic23@kernel.org>
        <20210509113354.660190-28-jic23@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Em Sun,  9 May 2021 12:33:53 +0100
Jonathan Cameron <jic23@kernel.org> escreveu:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Using this new call makes it easy to handle failures in resume as it
> doesn't hold a reference count if it exits with an error.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
> ---
>  drivers/iio/pressure/icp10100.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/pressure/icp10100.c b/drivers/iio/pressure/icp10100.c
> index 48759fc4bf18..80cd66688731 100644
> --- a/drivers/iio/pressure/icp10100.c
> +++ b/drivers/iio/pressure/icp10100.c
> @@ -250,7 +250,9 @@ static int icp10100_get_measures(struct icp10100_state *st,
>  	__be16 measures[3];
>  	int ret;
>  
> -	pm_runtime_get_sync(&st->client->dev);
> +	ret = pm_runtime_resume_and_get(&st->client->dev);
> +	if (ret < 0)
> +		return ret;
>  
>  	mutex_lock(&st->lock);
>  	cmd = &icp10100_cmd_measure[st->mode];


This one has a logic similar to a patch I commented earlier in this
series. At probing time, it does:

        pm_runtime_get_noresume(&client->dev);
        pm_runtime_set_active(&client->dev);
        pm_runtime_enable(&client->dev);
        pm_runtime_set_autosuspend_delay(&client->dev, 2000);
        pm_runtime_use_autosuspend(&client->dev);
        pm_runtime_put(&client->dev);
        ret = devm_add_action_or_reset(&client->dev, icp10100_pm_disable,
                                       &client->dev);


Here, get/put are balanced, but the icp10100_pm_disable logic is:

static void icp10100_pm_disable(void *data)
{
        struct device *dev = data;

        pm_runtime_put_sync_suspend(dev);
        pm_runtime_disable(dev);
}

Not sure what RPM get() it is trying to balance there.

Thanks,
Mauro
