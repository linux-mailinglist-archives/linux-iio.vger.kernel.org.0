Return-Path: <linux-iio+bounces-9823-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C84F7989004
	for <lists+linux-iio@lfdr.de>; Sat, 28 Sep 2024 17:15:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89836282622
	for <lists+linux-iio@lfdr.de>; Sat, 28 Sep 2024 15:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 954E5224D2;
	Sat, 28 Sep 2024 15:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vtb6qWGT"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E32F1B947;
	Sat, 28 Sep 2024 15:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727536533; cv=none; b=iZVXOul9lIQwTGzA51PZQ8YRsnfMY0MmHMJMiKj158yrgPogMpkeoLPHiBAVtnCBCht3zoCiXeiKSzmrAnQ8qkn8jmpJbd4sn2DxYvCDzPURjYAjDtsC4dlbUgbl4e9cLYR4XTbU2ruiERbyHKdPZVEJtzKCrrHQJ9equDQGR+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727536533; c=relaxed/simple;
	bh=kU0rM8vLZDQ1d10YiRtdiX7pecM7Uz7NffEA8r4ZGpM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IIM3vHnWgpJOhPPdIlEZ9jn8tqco35Qc+2Bng6gxBowiIlvRSnR1sBUkDgsP5qljtJoh7d74k+4DaEN9ZnfpJcmzyqumWYB4F4m3O2AQZ+TPdsWGRL7aR7YTWxJaLdsyDSXFoMf3jiMkK7onCdL1u1VwX6THelhfiiScPUHmDxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vtb6qWGT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24B7CC4CEC3;
	Sat, 28 Sep 2024 15:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727536532;
	bh=kU0rM8vLZDQ1d10YiRtdiX7pecM7Uz7NffEA8r4ZGpM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Vtb6qWGTR30Z7qZ7Nbs8eQTA3didaZ2TzdDLGhbA7Jy5rOme+7hz0VwyJf7D3bbgj
	 7V120ruSTGRNfqXho1eV4lQPoz5Fj8V+1Pdrfio0ZHh4kuxNeo+XyBZxkvuWI2/+6I
	 p4BufJMYL1C/Lduuq05ZOPPbjmwzOLsr8AvVE8AYu22QvMuARDBUaY5VjPzljxiDCq
	 MQvQJpKReGtkm0fmTC52kfUC7R6grVZGGQvh8YRGL2AzHzmMNRgVGeE8FpC2MjJRbH
	 EWU4B1ZzzosDj1/RvivVv/8XKPmqY3mNQsVtRegwqiNsup9EVz+jR/uixqnU68AOF9
	 OuksVFFd+6Y4Q==
Date: Sat, 28 Sep 2024 16:15:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: lars@metafoo.de, andy.shevchenko@gmail.com,
 u.kleine-koenig@pengutronix.de, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v1 2/2] iio: light: rpr0521: Drop unnecessary checks
 for timestamp value
Message-ID: <20240928161527.73fe0ac1@jic23-huawei>
In-Reply-To: <20240922162041.525896-3-vassilisamir@gmail.com>
References: <20240922162041.525896-1-vassilisamir@gmail.com>
	<20240922162041.525896-3-vassilisamir@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 22 Sep 2024 18:20:41 +0200
Vasileios Amoiridis <vassilisamir@gmail.com> wrote:

> The rpr0521_trigger_consumer_handler() is registered as the trigger
> threaded handler in the devm_iio_triggered_buffer_setup() function.
> This function is being called in 2 ways:
> 
> a) when there is a registered trigger being trigger like sysfs or hrt.
> The call of the trigger handler (which is the iio_pollfunc_store_time())
> follows which saves the timestamp and then, wakes up the trigger
> threaded handler.
> 
> b) The irq handler is using the iio_trigger_poll_nested() which wakes
> up the trigger threaded handler.
> 
> In both cases, the pf->timestamp has already been assigned a value
> so there is no need to check if it is 0, neither to 0 it after
> the push to the buffer.

Not quite right (I think).  The caller of iio_trigger_poll_nested() might not
be this driver.  There are other potential triggers that are nested
because of need to check some status register, but can still be used
for other devices.   In theory you could drive light capture of
the as3935 for when you want to know how bright it was just after
a lightening strike :)

We don't have a general solution for timestamps when that
happens, so this driver is papering over that with this code.


Jonathan



> 
> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> ---
>  drivers/iio/light/rpr0521.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/light/rpr0521.c b/drivers/iio/light/rpr0521.c
> index 56f5fbbf79ac..ae6a22b91b8d 100644
> --- a/drivers/iio/light/rpr0521.c
> +++ b/drivers/iio/light/rpr0521.c
> @@ -446,13 +446,8 @@ static irqreturn_t rpr0521_trigger_consumer_handler(int irq, void *p)
>  	int err;
>  
>  	/* Use irq timestamp when reasonable. */
> -	if (iio_trigger_using_own(indio_dev) && data->irq_timestamp) {
> +	if (iio_trigger_using_own(indio_dev))
>  		pf->timestamp = data->irq_timestamp;
> -		data->irq_timestamp = 0;
> -	}
> -	/* Other chained trigger polls get timestamp only here. */
> -	if (!pf->timestamp)
> -		pf->timestamp = iio_get_time_ns(indio_dev);
>  
>  	err = regmap_bulk_read(data->regmap, RPR0521_REG_PXS_DATA,
>  		data->scan.channels,
> @@ -463,7 +458,6 @@ static irqreturn_t rpr0521_trigger_consumer_handler(int irq, void *p)
>  	else
>  		dev_err(&data->client->dev,
>  			"Trigger consumer can't read from sensor.\n");
> -	pf->timestamp = 0;
>  
>  	iio_trigger_notify_done(indio_dev->trig);
>  


