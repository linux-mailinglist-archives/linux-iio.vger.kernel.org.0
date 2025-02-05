Return-Path: <linux-iio+bounces-15046-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11377A29623
	for <lists+linux-iio@lfdr.de>; Wed,  5 Feb 2025 17:22:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 371CE3A80E8
	for <lists+linux-iio@lfdr.de>; Wed,  5 Feb 2025 16:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5271D86E4;
	Wed,  5 Feb 2025 16:21:44 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE651B6CE3;
	Wed,  5 Feb 2025 16:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738772504; cv=none; b=hJ0uKo+khRW65AXZOGgRlqobhs/v8MNjdcWPa1lYQfZGvXwBWpba4cDdZkojJVn0/lSHE8be7zkgXwYalmqqGmRyx1FuWYMlAsVLTk0Z054BwHnNzQOWcURBtycCBXoii87JhK6LYPRvldHHrh2HV7/daDTEDo4RaU6PAg7dPM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738772504; c=relaxed/simple;
	bh=4ww4sToRM4DqZTVt/2tuXYfGdXkkbLVZoS1rRuvhxUs=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E9NRUVPHHOG6IxLGXNLt2kfufdn944bf+D2NvW6+ONR1eYtv8V2GnYqxSWKBqJU1SXW4WaB2kPIt/mxbuTUJTPSyI4m/Jjbz5G1Pe+EJlYLks/2cjO0X0iUlbfgA/2tiMyj+GCr+Q4VC1rZPhM4Jjcgo2YLoocadsbnHg9Zvpk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Yp55c2vrlz67yqV;
	Thu,  6 Feb 2025 00:19:00 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 35F841402C4;
	Thu,  6 Feb 2025 00:21:39 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 5 Feb
 2025 17:21:38 +0100
Date: Wed, 5 Feb 2025 16:21:37 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Nam Cao <namcao@linutronix.de>
CC: Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker
	<frederic@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	<linux-kernel@vger.kernel.org>, Zack Rusin <zack.rusin@broadcom.com>,
	<linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2 27/45] iio: Switch to use hrtimer_setup()
Message-ID: <20250205162137.0000404c@huawei.com>
In-Reply-To: <570792e31b28a94a511c19c6789f2171a6745685.1738746904.git.namcao@linutronix.de>
References: <cover.1738746904.git.namcao@linutronix.de>
	<570792e31b28a94a511c19c6789f2171a6745685.1738746904.git.namcao@linutronix.de>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed,  5 Feb 2025 11:46:15 +0100
Nam Cao <namcao@linutronix.de> wrote:

> hrtimer_setup() takes the callback function pointer as argument and
> initializes the timer completely.
> 
> Replace hrtimer_init() and the open coded initialization of
> hrtimer::function with the new setup mechanism.
> 
> Patch was created by using Coccinelle.
> 
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Acked-by: Zack Rusin <zack.rusin@broadcom.com>
> Signed-off-by: Nam Cao <namcao@linutronix.de>

+CC linux-iio

> ---
>  drivers/iio/adc/ti-tsc2046.c           | 4 +---
>  drivers/iio/trigger/iio-trig-hrtimer.c | 4 ++--
>  2 files changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti-tsc2046.c b/drivers/iio/adc/ti-tsc2046.c
> index 7dde5713973f..49560059f4b7 100644
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


