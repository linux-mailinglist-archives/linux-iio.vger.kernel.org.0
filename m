Return-Path: <linux-iio+bounces-12537-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0AD09D69B3
	for <lists+linux-iio@lfdr.de>; Sat, 23 Nov 2024 16:40:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70E11161729
	for <lists+linux-iio@lfdr.de>; Sat, 23 Nov 2024 15:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618F32BD1D;
	Sat, 23 Nov 2024 15:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YbFz2hGg"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1992229CEB;
	Sat, 23 Nov 2024 15:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732376446; cv=none; b=C7M6u0BSDEYmwDq69JLCtZ5YUemOKJbugBmE0bUtkMiGd2w0ZuwKcx02ens/QCwswrzLoszddb6ICgq4Y4bbup5sIubUCLyisjnhv8GLuNOCZj0+ry+DoLmkCmgowo9mTNGXaxq2m3CTX7o1mlAGqayetdeeWBvOKDAb6wGLI64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732376446; c=relaxed/simple;
	bh=MklJhwy6HeCgvxTJvor61IotvAByX8jPBg+q9zaPNls=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kb1nKEuxfWAKTbHivwUFg/8uswqJLL1h2wNazthsFjuUKXsljuQBjnFKtpziVYEJL+EmJbXDwmDscRPzLQ4gnxYwwEKJpvaNF+uqK/HGuaQiF3STtr6Fmo/agIgbzvH9Yjj7CXrNH2IcX3+GvMdEas62pQID+OPR7Ce6iBjJP6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YbFz2hGg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C9B9C4CECD;
	Sat, 23 Nov 2024 15:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732376445;
	bh=MklJhwy6HeCgvxTJvor61IotvAByX8jPBg+q9zaPNls=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YbFz2hGgy+HzVvo0OqByKl0sMmnoAL8FjJcExxko2SQFgAAvIkhtLLValRRuqRtlI
	 RJuPE5Tskbv1PRlFj4t6kobgGpKfbcg9aGYSsHzxhra4bPRyUwHzcdCHsVp33LGbdY
	 X+WYc3BQxOgxTIwj1v7lGyfwCq33kNxhGOxiUvYHjH80N/5f+04YsJO2uqHzk37dlY
	 yfvxKM4zTH9ef6V4rn2MMiHlboje/YgTrlu9zz4VBfnlTdNSIpKoCgQPNsbhS1MD92
	 oNVg+wisxopfKYXV6YnBksJhsZ4LOlbjd9QcWU2OAJrYHY9GH2zz7pLoREb72p3WLF
	 vutVFsbkAt2MQ==
Date: Sat, 23 Nov 2024 15:40:37 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Rui Miguel Silva <rmfrfs@gmail.com>, Lars-Peter Clausen
 <lars@metafoo.de>, linux-iio@vger.kernel.org (open list:NXP FXAS21002C
 DRIVER), linux-kernel@vger.kernel.org (open list), imx@lists.linux.dev
Subject: Re: [PATCH 1/1] iio: gyro: fxas21002c: Fix missing data update in
 trigger handler
Message-ID: <20241123154037.05ebcf8a@jic23-huawei>
In-Reply-To: <20241116152945.4006374-1-Frank.Li@nxp.com>
References: <20241116152945.4006374-1-Frank.Li@nxp.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 16 Nov 2024 10:29:45 -0500
Frank Li <Frank.Li@nxp.com> wrote:

> From: Carlos Song <carlos.song@nxp.com>
> 
> The fxas21002c_trigger_handler() may fail to acquire sample data because
> the runtime PM enters the autosuspend state and sensor can not return
> sample data in standby mode..
> 
> Resume the sensor before reading the sample data into the buffer within the
> trigger handler. After the data is read, place the sensor back into the
> autosuspend state.
> 
> Fixes: a0701b6263ae ("iio: gyro: add core driver for fxas21002c")
> Signed-off-by: Carlos Song <carlos.song@nxp.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
Applied to the fixes-togreg branch of iio.git and marked for stable.
Note I'll rebase on rc1 once available before sending a pull request with this in.

Thanks,

Jonathan

> ---
>  drivers/iio/gyro/fxas21002c_core.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/gyro/fxas21002c_core.c b/drivers/iio/gyro/fxas21002c_core.c
> index 688966129f704..50b908b2419be 100644
> --- a/drivers/iio/gyro/fxas21002c_core.c
> +++ b/drivers/iio/gyro/fxas21002c_core.c
> @@ -730,14 +730,21 @@ static irqreturn_t fxas21002c_trigger_handler(int irq, void *p)
>  	int ret;
>  
>  	mutex_lock(&data->lock);
> +	ret = fxas21002c_pm_get(data);
> +	if (ret < 0)
> +		goto out_unlock;
> +
>  	ret = regmap_bulk_read(data->regmap, FXAS21002C_REG_OUT_X_MSB,
>  			       data->buffer, CHANNEL_SCAN_MAX * sizeof(s16));
>  	if (ret < 0)
> -		goto out_unlock;
> +		goto out_pm_put;
>  
>  	iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
>  					   data->timestamp);
>  
> +out_pm_put:
> +	fxas21002c_pm_put(data);
> +
>  out_unlock:
>  	mutex_unlock(&data->lock);
>  


