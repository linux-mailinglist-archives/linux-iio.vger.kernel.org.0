Return-Path: <linux-iio+bounces-5625-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB2C8D7586
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jun 2024 15:06:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 723D51F21F9D
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jun 2024 13:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B1F23B1A3;
	Sun,  2 Jun 2024 13:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fqea9U6Z"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4831EF1D;
	Sun,  2 Jun 2024 13:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717333585; cv=none; b=BfYH2BRCNznMFYyvvWhGPCzMsTv2pzvHgSJcQgSPlNsKvID/JIW4tGBA1eEslowzjLMQWXxUiif5m3WauvfDLTbcCIL98S44vCm4LgGWqCtMW8kzqaoWkWHrm1MiZYd62pI4sz8op6k7NF09NLlRdMUAnFNePjJrENsPiJG3iGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717333585; c=relaxed/simple;
	bh=8i/iI+njLM3WMWCjdWEYodHIWZWabw5Ask2PFKIfkR0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I6rp0AZ9i+xYb3cVjq+oXdYcyPAj/7t1goUWwT5/XcEc18HVMlG+O2ellnq0YCCi2Sc6VKU6Mh9YTgVhc0MMD7n/e0ipiEes+EkW+ziaG4uyif+AFniIu8540abFjogUua56hHvZ8SfsHv2JRN1WVNfK/bWAfopWgyTDnwiA2qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fqea9U6Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97B6EC2BBFC;
	Sun,  2 Jun 2024 13:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717333585;
	bh=8i/iI+njLM3WMWCjdWEYodHIWZWabw5Ask2PFKIfkR0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Fqea9U6ZvIHrCyekzP0Oyu9eb6L5S32BfFFxOExZ36RU9AFsW0J3Jy+8fKaioVca0
	 8b5kkDYxIv3Gw0LG68533pEhqRmkpKSYr3B6XckaCMZklbG64Xyl47eJAlMZ7daJF3
	 4v/Qk/emiVEdBWj48ER6d7L4E4o0M504iKItnUVubxIfD7PlPw41zdI1cA7y7uoE+j
	 OtaRv7qsxh8S5zU8jxTE/ZYczCQcRWW/HEE4Uydvw5C2/M9q6NO8BCqsU8uXpTJo6B
	 vnQiqiej9fjLZ9wALCYCMx6w63mFcuMlQ7yC39BUAT+l6LR1LDfTQCGn940TdRxRxG
	 VnfWrVd02wBlQ==
Date: Sun, 2 Jun 2024 14:06:14 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: inv.git-commit@tdk.com
Cc: lars@metafoo.de, linux-iio@vger.kernel.org, stable@vger.kernel.org,
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Subject: Re: [PATCH v2] iio: imu: inv_mpu6050: stabilized timestamping in
 interrupt
Message-ID: <20240602140614.5922529c@jic23-huawei>
In-Reply-To: <20240527150117.608792-1-inv.git-commit@tdk.com>
References: <20240527150117.608792-1-inv.git-commit@tdk.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 May 2024 15:01:17 +0000
inv.git-commit@tdk.com wrote:

> From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> 
> Use IRQ ONESHOT flag to ensure the timestamp is not updated in the
> hard handler during the thread handler. And use a fixed value of 1
> sample that correspond to this first timestamp.
> 
> This way we can ensure the timestamp is always corresponding to the
> value used by the timestamping mechanism. Otherwise, it is possible
> that between FIFO count read and FIFO processing the timestamp is
> overwritten in the hard handler.
> 
> Fixes: 111e1abd0045 ("iio: imu: inv_mpu6050: use the common inv_sensors timestamp module")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Applied
> ---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c    | 4 ++--
>  drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c | 1 +
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> index 0dc0f22a5582..3d3b27f28c9d 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> @@ -100,8 +100,8 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
>  		goto end_session;
>  	/* Each FIFO data contains all sensors, so same number for FIFO and sensor data */
>  	fifo_period = NSEC_PER_SEC / INV_MPU6050_DIVIDER_TO_FIFO_RATE(st->chip_config.divider);
> -	inv_sensors_timestamp_interrupt(&st->timestamp, nb, pf->timestamp);
> -	inv_sensors_timestamp_apply_odr(&st->timestamp, fifo_period, nb, 0);
> +	inv_sensors_timestamp_interrupt(&st->timestamp, 1, pf->timestamp);
> +	inv_sensors_timestamp_apply_odr(&st->timestamp, fifo_period, 1, 0);
>  
>  	/* clear internal data buffer for avoiding kernel data leak */
>  	memset(data, 0, sizeof(data));
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> index 1b603567ccc8..84273660ca2e 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> @@ -300,6 +300,7 @@ int inv_mpu6050_probe_trigger(struct iio_dev *indio_dev, int irq_type)
>  	if (!st->trig)
>  		return -ENOMEM;
>  
> +	irq_type |= IRQF_ONESHOT;
>  	ret = devm_request_threaded_irq(&indio_dev->dev, st->irq,
>  					&inv_mpu6050_interrupt_timestamp,
>  					&inv_mpu6050_interrupt_handle,


