Return-Path: <linux-iio+bounces-11852-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D39059BA151
	for <lists+linux-iio@lfdr.de>; Sat,  2 Nov 2024 17:00:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14F981C20CF7
	for <lists+linux-iio@lfdr.de>; Sat,  2 Nov 2024 16:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CFB419DFAC;
	Sat,  2 Nov 2024 16:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OoodaCKS"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1AC45016;
	Sat,  2 Nov 2024 16:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730563213; cv=none; b=exda6ZBqj/WNymV2+XrvAQYMBZkJnKjnR8j2QidPVRwQmioL8SW01OG5KUWklNAyqm5HljK9XurqfEp69NOtbI2HJItfq/xH9yQA1cLGtNq2lXOMAqqAF1Mta2UJI6jCMaaCvKGCuRgCTIr9U7dGMvPL9LmAZlufcil0ZBgEyxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730563213; c=relaxed/simple;
	bh=l/Le7rPKDbhqxrBPy/uf3Tc5Pa9oda1Gxc5J2ngcZJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fNXxfta6AeENM/Cmce+KKGXJ5utISGx0bK+dQPlPouy7G7U/tAMPyKt2xb/4SjWbm8PtpGekXC1P+GJyfP5lsfhnL7qiqT8uRQLbNxv4sU7/dp0pX1BQFUsiMN6HbAKwtx9PW3iAUzeFNAgQfzNR8KfoDKde8E5imhPmo61TDSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OoodaCKS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4225C4CEC3;
	Sat,  2 Nov 2024 16:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730563212;
	bh=l/Le7rPKDbhqxrBPy/uf3Tc5Pa9oda1Gxc5J2ngcZJ4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OoodaCKS3k40A8FPD9hYtz3WRAACLqjoXkQJrpKFt70JWqDe6JuynHvf4K0tBQkdZ
	 BTUXDnPPXSsY/7zqAmt2wva1e2KDC13VIWFpWWZotqe5TixRFeNXl0rfSKo1/UWYnT
	 j5k3w9WLSIDbwkcghRYTylrmq0ADT7Yw9Zr3ey6yHjd77y3NgSg0pB4YdAwDZbImlm
	 MZ1YQQRGBtrmDAhxYfytcTrDDkp6oz6n2oC+C4SK2z92WcdytCJRn5VGcYR3Q5ek7v
	 YjDw1GfuEgW3IiIuwlENy2AZ/zVIL1X83Ifh0//FyWPb2Vau41hPplew6HZRbysf+q
	 P4B/uvj2zDCeA==
Date: Sat, 2 Nov 2024 16:00:04 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nam Cao <namcao@linutronix.de>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker
 <frederic@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Andreas
 Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Miguel
 Ojeda <ojeda@kernel.org>, Kees Cook <kees@kernel.org>,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH 26/44] iio: Switch to use hrtimer_setup()
Message-ID: <20241102160004.3c7874a7@jic23-huawei>
In-Reply-To: <516b30771b0d627d6b7461611cbf476aa1fa0e6c.1729865485.git.namcao@linutronix.de>
References: <cover.1729865485.git.namcao@linutronix.de>
	<516b30771b0d627d6b7461611cbf476aa1fa0e6c.1729865485.git.namcao@linutronix.de>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 28 Oct 2024 08:35:02 +0100
Nam Cao <namcao@linutronix.de> wrote:

> There is a newly introduced hrtimer_setup() which will replace
> hrtimer_init(). This new function is similar to the old one, except that it
> also sanity-checks and initializes the timer's callback function.
> 
> Switch to use this new function.
> 
> Patch was created by using Coccinelle.
> 
> Signed-off-by: Nam Cao <namcao@linutronix.de>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Seems sensible to me.

https://lore.kernel.org/lkml/2159c09badceec667d800005ac98824105ba8dc6.1729864615.git.namcao@linutronix.de/
Has definition of hrtimer_setup()

+CC  linux-iio as an FYI.

Jonathan

> ---
> Cc: Jonathan Cameron <jic23@kernel.org>
> ---
>  drivers/iio/adc/ti-tsc2046.c           | 4 +---
>  drivers/iio/trigger/iio-trig-hrtimer.c | 4 ++--
>  2 files changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti-tsc2046.c b/drivers/iio/adc/ti-tsc2046.c
> index 311d97001249..87c86d752293 100644
> --- a/drivers/iio/adc/ti-tsc2046.c
> +++ b/drivers/iio/adc/ti-tsc2046.c
> @@ -812,9 +812,7 @@ static int tsc2046_adc_probe(struct spi_device *spi)
>  
>  	spin_lock_init(&priv->state_lock);
>  	priv->state = TSC2046_STATE_SHUTDOWN;
> -	hrtimer_init(&priv->trig_timer, CLOCK_MONOTONIC,
> -		     HRTIMER_MODE_REL_SOFT);
> -	priv->trig_timer.function = tsc2046_adc_timer;
> +	hrtimer_setup(&priv->trig_timer, tsc2046_adc_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_SOFT);
>  
>  	ret = devm_iio_trigger_register(dev, trig);
>  	if (ret) {
> diff --git a/drivers/iio/trigger/iio-trig-hrtimer.c b/drivers/iio/trigger/iio-trig-hrtimer.c
> index 716c795d08fb..82c72baccb62 100644
> --- a/drivers/iio/trigger/iio-trig-hrtimer.c
> +++ b/drivers/iio/trigger/iio-trig-hrtimer.c
> @@ -145,8 +145,8 @@ static struct iio_sw_trigger *iio_trig_hrtimer_probe(const char *name)
>  	trig_info->swt.trigger->ops = &iio_hrtimer_trigger_ops;
>  	trig_info->swt.trigger->dev.groups = iio_hrtimer_attr_groups;
>  
> -	hrtimer_init(&trig_info->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_HARD);
> -	trig_info->timer.function = iio_hrtimer_trig_handler;
> +	hrtimer_setup(&trig_info->timer, iio_hrtimer_trig_handler, CLOCK_MONOTONIC,
> +		      HRTIMER_MODE_REL_HARD);
>  
>  	trig_info->sampling_frequency[0] = HRTIMER_DEFAULT_SAMPLING_FREQUENCY;
>  	trig_info->period = NSEC_PER_SEC / trig_info->sampling_frequency[0];


