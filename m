Return-Path: <linux-iio+bounces-27395-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E2404CE0117
	for <lists+linux-iio@lfdr.de>; Sat, 27 Dec 2025 19:25:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9FCF73020CC4
	for <lists+linux-iio@lfdr.de>; Sat, 27 Dec 2025 18:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40C932573F;
	Sat, 27 Dec 2025 18:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uqrJM4fi"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7D224DFF3;
	Sat, 27 Dec 2025 18:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766859891; cv=none; b=Qn4MabRAtcfA3vWLw8bBjd/ZpYGFsgW4b4BXMn6tpXpq+u3S56R1jwH7vhgxUhQ0XaQz2zN0zFhvc1n56MQC7QoSMUqli5FJhf3JI+zznigd7myOwomemlfX86VWxuaF/AbtnWTQqO9plUgVJZeeSika7fRftRSW9UfbM4voQW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766859891; c=relaxed/simple;
	bh=NWiqhnWTwTo9wob3Rq1b36boqIaYsC/bvLXjDaKuqbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T1w0DVMUIQcPgAVKhus/hFG03YMm9XP4FrUW5vhh0FRzjtwAQaOmPO2rhxSeWTxxD9/FOoByR6oRKJAV+O8sbMNG3/wJVlaXnmlhbm2cgnN7CA5YFziNeu8T8K/QsTNlZOAY8xyZOAvteamo6oqWW43XOdVmjAn+vT81LfFbBvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uqrJM4fi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55BEDC4CEF1;
	Sat, 27 Dec 2025 18:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766859891;
	bh=NWiqhnWTwTo9wob3Rq1b36boqIaYsC/bvLXjDaKuqbQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uqrJM4fioT0lIiOS2i/HpUA/HljIcvmUDK3wU1RACv/6X/+o7GuNfzTWkwkV7HQiv
	 lDfKzLDGuqhlOOZmWUAUIaJtev7kkqkWspYBP8Lo2bBg1/dzlC7k6VKAWlowrK0i3h
	 RxuyNQ/BuS9zCBuZXfy8hnZ9ZC5WDh0kIehoLCz3HnC9jJHhTHZEqZ9hfXlLzg8AgJ
	 iQ6eTv+2x+ihmN9H0Nu0mce0PhcyRgTQGuNdadyhCoYTw5kdmHN03FMJwTow0EITG7
	 CQU9UoiPjA57ZWstYCqmSWuIIn+Vt1g+05ndXXzrgPoSkSYzAPuAxtjC0d4VkqABFr
	 Rp0m+QjaH2y7w==
Date: Sat, 27 Dec 2025 18:24:43 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Alper Ak <alperyasinak1@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: light: gp2ap020a00f: Fix signedness bug in
 gp2ap020a00f_get_thresh_reg()
Message-ID: <20251227182443.754facb4@jic23-huawei>
In-Reply-To: <20251226154523.89215-1-alperyasinak1@gmail.com>
References: <20251226154523.89215-1-alperyasinak1@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 26 Dec 2025 18:45:21 +0300
Alper Ak <alperyasinak1@gmail.com> wrote:

> gp2ap020a00f_get_thresh_reg() returns -EINVAL on error,
> but it was declared as a u8.
> 
> Change the return type to int and update callers to use int type for
> the return value and properly check for negative error codes.
> 
> Fixes: 5d6a25bad035 ("iio:gp2ap020a00f: Switch to new event config interface")
Hi Alper,

It's not a real bug because the values that can be passed to this
must already be constrained to be ones that will match the non error
cases in that call.

The type issue is worth tidying up though.  A few comments inline.


> Signed-off-by: Alper Ak <alperyasinak1@gmail.com>
> ---
>  drivers/iio/light/gp2ap020a00f.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/light/gp2ap020a00f.c b/drivers/iio/light/gp2ap020a00f.c
> index c7df4b258e2c..9f2441fe8c52 100644
> --- a/drivers/iio/light/gp2ap020a00f.c
> +++ b/drivers/iio/light/gp2ap020a00f.c
> @@ -992,7 +992,7 @@ static irqreturn_t gp2ap020a00f_trigger_handler(int irq, void *data)
>  	return IRQ_HANDLED;
>  }
>  
> -static u8 gp2ap020a00f_get_thresh_reg(const struct iio_chan_spec *chan,
> +static int gp2ap020a00f_get_thresh_reg(const struct iio_chan_spec *chan,
>  					     enum iio_event_direction event_dir)
>  {
>  	switch (chan->type) {
> @@ -1023,12 +1023,18 @@ static int gp2ap020a00f_write_event_val(struct iio_dev *indio_dev,
>  	struct gp2ap020a00f_data *data = iio_priv(indio_dev);
>  	bool event_en = false;
>  	u8 thresh_val_id;
> -	u8 thresh_reg_l;
> +	int thresh_reg_l;
>  	int err = 0;

This never needed to be initialized as this value is never used
(that matters for suggestion that follows)


>  
>  	mutex_lock(&data->lock);
Given this isn't a fix as such (see above). You could precede it with
a patch using cleanup.h and guard() to handle the locking and remove
the need for a err_unlock; label and gotos.

>  
>  	thresh_reg_l = gp2ap020a00f_get_thresh_reg(chan, dir);
> +

Drop this blank line to keep the cause of the return value and the check
on it tightly coupled. I'd prefer this use err until we know if the value is valid.

	err = gp2ap020a00f_get_thresh_reg(chan, dir);
	if (err < 0)
		goto error_unlock;
	thresh_reg_l = err;

	

> +	if (thresh_reg_l < 0) {
> +		err = thresh_reg_l;
> +		goto error_unlock;
> +	}
> +
>  	thresh_val_id = GP2AP020A00F_THRESH_VAL_ID(thresh_reg_l);
>  
>  	if (thresh_val_id > GP2AP020A00F_THRESH_PH) {
> @@ -1080,15 +1086,15 @@ static int gp2ap020a00f_read_event_val(struct iio_dev *indio_dev,
>  				       int *val, int *val2)
>  {
>  	struct gp2ap020a00f_data *data = iio_priv(indio_dev);
> -	u8 thresh_reg_l;
> +	int thresh_reg_l;
>  	int err = IIO_VAL_INT;
>  
>  	mutex_lock(&data->lock);
>  
>  	thresh_reg_l = gp2ap020a00f_get_thresh_reg(chan, dir);
>  
> -	if (thresh_reg_l > GP2AP020A00F_PH_L_REG) {
> -		err = -EINVAL;
> +	if (thresh_reg_l < 0) {
Similar comments to above apply here as well.

Thanks

Jonathan

> +		err = thresh_reg_l;
>  		goto error_unlock;
>  	}
>  


