Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE29837BFE5
	for <lists+linux-iio@lfdr.de>; Wed, 12 May 2021 16:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbhELO04 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 12 May 2021 10:26:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:51494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230370AbhELO0z (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 12 May 2021 10:26:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EFB2161407;
        Wed, 12 May 2021 14:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620829546;
        bh=9RUEm66qzp+Tmt9PrZLSWm8vw9XTXnH1rdvJ2y82sgU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ISjPiElU8A5b0tPv0FdD0OjPIMmKkzeRTrBrGs+5r7XBgXCPbF3H2IWycXdGwJAks
         KXwSQ9PBdM/VjYAkcnczjpYt9xkFfDkG5uJoTE9gU8YE79pC0lh+jTx5lCY48vdhdO
         HBJ8qVJ8GF9pLtvnwCCeASc8foyctU2/ewcfzVecK5cMOPf4uLAQZUuVUiFw/jPYfd
         7h1owjGD+4q73/gZ88yyyrb76iWlv7olJxtqOTo69LiDISkRlyyc2XrIQs/GWVUl03
         Gmvhc+UyUfHGvgQqha/8AtfKekJGHixNvu1ingP0k1ZnFc5LKqrqBJoKSjYT/oWPnf
         bD8Ek5MxZoD+Q==
Date:   Wed, 12 May 2021 16:25:41 +0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Julia Lawall <Julia.Lawall@inria.fr>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>
Subject: Re: [PATCH 18/28] iio: chemical: atlas-sensor: Use
 pm_runtime_resume_and_get() to replace open coding.
Message-ID: <20210512162541.078069d8@coco.lan>
In-Reply-To: <20210509113354.660190-19-jic23@kernel.org>
References: <20210509113354.660190-1-jic23@kernel.org>
        <20210509113354.660190-19-jic23@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Em Sun,  9 May 2021 12:33:44 +0100
Jonathan Cameron <jic23@kernel.org> escreveu:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Found using coccicheck script under review at:
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

Same case as patch 17: this driver also seems to have an extra
(unbalanced?) call to pm_runtime_disable() at remove().

> ---
>  drivers/iio/chemical/atlas-sensor.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/chemical/atlas-sensor.c b/drivers/iio/chemical/atlas-sensor.c
> index d10f921b233a..90bb3f5bff19 100644
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



Thanks,
Mauro
