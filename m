Return-Path: <linux-iio+bounces-9822-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41AC2989001
	for <lists+linux-iio@lfdr.de>; Sat, 28 Sep 2024 17:14:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8F6D2826C6
	for <lists+linux-iio@lfdr.de>; Sat, 28 Sep 2024 15:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D70713B5AE;
	Sat, 28 Sep 2024 15:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PUEJATVc"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D71A1DA23;
	Sat, 28 Sep 2024 15:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727536223; cv=none; b=tQ0DbK06YiX6b9vwsUYLDLeK9l15SbMzuHj+E67jx3LsCpZBmdfL55mmrrmg0wXxfmZ0cjlfPg9eN40YU0WkuZLb9D0DaUNecMcVqIxOhq0ZANaBEl+XSUU3kHHTOSNsv1Ll09+jrTe7xK6jVR1rbrcLvhA1qG186j9y6xnrFUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727536223; c=relaxed/simple;
	bh=LBpy53VNYX6MDSkRBfGsDmeCJUMuxBYfg8nkix9xMOg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g6sA92W9EIZJiN5s+QubA6wwEWgCRZ2bgkIcjMK68Mz35Ufr6Qq1W2IxEidm95jtcZnc9/hC4We2Awt22JyFJxIR+LyzhaecXZUX3LPfTxUhQ1OsGge4QS6gtBiApOgLPs4unEcy5dq/E+12Q9xAKeEZiyqvtcAk1gpNMe8jAsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PUEJATVc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 145E3C4CEC3;
	Sat, 28 Sep 2024 15:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727536222;
	bh=LBpy53VNYX6MDSkRBfGsDmeCJUMuxBYfg8nkix9xMOg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PUEJATVcthB2IbIkCEL7phOOoajt+6WK/Zy0fRdxMpxhD/z6BMN3LjaOaP4CNHeD/
	 Ko3GA8tktm5qnl0eehOYYv2b8pX/JD0ASrNw/9B+3NB5ClbjwQ9kgfGEMoYg/3TAqd
	 juXbHSwsUuxntEhFAjMp6sumIzqmj1K6c/uNS+qeb4Vg5ev/Ez7WxytXN8MVx1Cygf
	 M3xWPLrynsu7k6G0CcuET1roXDLEJ/1NIlhby/r72Zvq6P0KPLZ9jdM2q3a0SHh9Kw
	 QphjQpWsJ9BfkYcBjgVvSLWPO/6uYL5VIyMV7WyuBvNjFwS83CLdsVL/QHI9uxVEND
	 qB4L0PfWJi6zw==
Date: Sat, 28 Sep 2024 16:10:17 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: lars@metafoo.de, andy.shevchenko@gmail.com,
 u.kleine-koenig@pengutronix.de, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v1 1/2] iio: light: rpr0521: Use generic
 iio_pollfunc_store_time()
Message-ID: <20240928161017.29fd249c@jic23-huawei>
In-Reply-To: <20240922162041.525896-2-vassilisamir@gmail.com>
References: <20240922162041.525896-1-vassilisamir@gmail.com>
	<20240922162041.525896-2-vassilisamir@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 22 Sep 2024 18:20:40 +0200
Vasileios Amoiridis <vassilisamir@gmail.com> wrote:

> The custom rpr0521_trigger_consumer_store_time() is registered as trigger
> handler in the devm_iio_triggered_buffer_setup() function. This function
> is called from the calling of the iio_trigger_poll() used in the
> sysfs/hrt triggers and it is not used anywhere else in this driver.
It might be any number of other triggers (hardware triggers from other
drivers for example).

Other than that I think your reasoning is correct but would ideally
like some input from someone more familiar with this driver.

If that isn't forthcoming I'll pick this up in a week or two.

Jonathan

> 
> The irq handler of the driver is the rpr0521_drdy_irq_handler() which
> saves the timestamp and then wakes the irq thread. The irq thread is
> the rpr0521_drdy_irq_thread() function which checks if the irq came
> from the sensor and wakes up the trigger threaded handler through
> iio_trigger_poll_nested() or returns IRQ_NONE in case the irq didn't
> come from this sensor.
> 
> This means that in the current driver, you can't reach the
> rpr0521_trigger_consumer_store_time() when the device's irq is
> triggered. This means that the extra check of iio_trigger_using_own()
> is redundant since it will always be false so the general
> iio_pollfunc_store_time() can be used.
> 
> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> ---
>  drivers/iio/light/rpr0521.c | 14 +-------------
>  1 file changed, 1 insertion(+), 13 deletions(-)
> 
> diff --git a/drivers/iio/light/rpr0521.c b/drivers/iio/light/rpr0521.c
> index 78c08e0bd077..56f5fbbf79ac 100644
> --- a/drivers/iio/light/rpr0521.c
> +++ b/drivers/iio/light/rpr0521.c
> @@ -438,18 +438,6 @@ static irqreturn_t rpr0521_drdy_irq_thread(int irq, void *private)
>  	return IRQ_NONE;
>  }
>  
> -static irqreturn_t rpr0521_trigger_consumer_store_time(int irq, void *p)
> -{
> -	struct iio_poll_func *pf = p;
> -	struct iio_dev *indio_dev = pf->indio_dev;
> -
> -	/* Other trigger polls store time here. */
> -	if (!iio_trigger_using_own(indio_dev))
> -		pf->timestamp = iio_get_time_ns(indio_dev);
> -
> -	return IRQ_WAKE_THREAD;
> -}
> -
>  static irqreturn_t rpr0521_trigger_consumer_handler(int irq, void *p)
>  {
>  	struct iio_poll_func *pf = p;
> @@ -1016,7 +1004,7 @@ static int rpr0521_probe(struct i2c_client *client)
>  		/* Trigger consumer setup */
>  		ret = devm_iio_triggered_buffer_setup(indio_dev->dev.parent,
>  			indio_dev,
> -			rpr0521_trigger_consumer_store_time,
> +			iio_pollfunc_store_time,
>  			rpr0521_trigger_consumer_handler,
>  			&rpr0521_buffer_setup_ops);
>  		if (ret < 0) {


