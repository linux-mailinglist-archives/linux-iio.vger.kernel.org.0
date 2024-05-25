Return-Path: <linux-iio+bounces-5301-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C998CF06D
	for <lists+linux-iio@lfdr.de>; Sat, 25 May 2024 19:22:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 444A61F2114D
	for <lists+linux-iio@lfdr.de>; Sat, 25 May 2024 17:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EAEB86262;
	Sat, 25 May 2024 17:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hM0DRBM9"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0025578C78
	for <linux-iio@vger.kernel.org>; Sat, 25 May 2024 17:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716657767; cv=none; b=HcpqYARieVCnKA3YxDXlD3deZzn9faTptEOagXRM7wxdY1H4ItU1BP4qg7T4uc+z8BTW+d0dBTcEvgdBj0QtdXUCQkcpVyDNB0xLIEiqS3nCqbskPOUMiZ0XssbPFYm2pRwxDZGA1JCFHugAvXJcPLe8eo4nYxhxL2MBBHsS2X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716657767; c=relaxed/simple;
	bh=frTizI9epWGxEVNDeS5oVBjBofY/VNX7VPLFmUPw970=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PP7NdaIAQRIexNNCMW8H5MxkrQZlvW3ZWe0jR9CA7bFaMBs7+UZ1P9Bz178Lfybdgo1k4REqHl1sCe6otRaHIHM1VCqU2fe/y+FQu20Y39D0y8OOkGfwS7j6GIL7UG7vq2Ccx3n2X4Pfo8HpmTVxMLyX3/rZgt4WLdiqfqI/Hc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hM0DRBM9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D06FC2BD11;
	Sat, 25 May 2024 17:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716657766;
	bh=frTizI9epWGxEVNDeS5oVBjBofY/VNX7VPLFmUPw970=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hM0DRBM9sEIwbrmjOAAFXrL94Uov4J3AWwQD7yzMp2FJp+ejLBb0E2L3BS30TtTLO
	 Q1ouHZ58vCG1KksdcB5zymXgSOe2oKqLMT/4u/0GCnY13nxTh+1CbB/MQZo1QFOJ3Z
	 1UuyCayng8jZaet8oRgMT2Qmoov8rVaZT/Z+WY0mapMeyZd88YvpKWUPTaW2oW1rpL
	 JE3dg3Ad2pYN+A66SMkQi3hnsI22yA9TBUy+R6T9y/S9HL/MsWUf337Kkv9WSqPgry
	 ktuH/eK061CVguzwgnKFrU1x7rJzokS0QTjjjpwzlJGxvjX5swyhkz2pz6XQFo35hD
	 AjoceGRh6MFzA==
Date: Sat, 25 May 2024 18:22:35 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: inv.git-commit@tdk.com
Cc: lars@metafoo.de, linux-iio@vger.kernel.org, Jean-Baptiste Maneyrol
 <jean-baptiste.maneyrol@tdk.com>
Subject: Re: [PATCH] iio: imu: inv_mpu6050: stabilized timestamping in
 interrupt
Message-ID: <20240525182235.52c47260@jic23-huawei>
In-Reply-To: <20240523135245.552999-1-inv.git-commit@tdk.com>
References: <20240523135245.552999-1-inv.git-commit@tdk.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 May 2024 13:52:45 +0000
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
> Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Fixes tag appropriate?

Otherwise LGTM
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


