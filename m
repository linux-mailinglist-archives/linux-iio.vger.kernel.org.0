Return-Path: <linux-iio+bounces-3290-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB2486F657
	for <lists+linux-iio@lfdr.de>; Sun,  3 Mar 2024 18:10:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE67D28111E
	for <lists+linux-iio@lfdr.de>; Sun,  3 Mar 2024 17:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0E9B762DC;
	Sun,  3 Mar 2024 17:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VXvQDTN3"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6870F762F1
	for <linux-iio@vger.kernel.org>; Sun,  3 Mar 2024 17:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709485826; cv=none; b=PpZg1MWp562K7cUpIny8KMqfa550DBlXiyfUcbYlTi9qSeX39s8Efa0g/w5oXRX6Y0vK+5b+inpSgnReqax+Jh4BvcGFL7lDUtsE9lCwIlq0bfmnFtuNqBNc74pyQ5cb7ZFSiFQHfTurdT4Y+myG0jhtQ4GCDRPyGQBx1WFXuUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709485826; c=relaxed/simple;
	bh=vJK91lcyx53aatDQEALdWJ5XzOTDCwzmfej68bxhV2o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IUOWoS9R6Gp8QFh4m+/iz2tsntMmL4pn8zxkxkpdt4xxNfev+iKs/cskNQ9kdsxzSCw7+/x8EJtTltqJ46344oTHM2Q90teDwyVGzxb9oJwk0uIqphIkv1FxFFRt+4teoMoIjWAklRBR7XOjybk/kXAhFncC1xdFfRP86mm+Enw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VXvQDTN3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9273EC43390;
	Sun,  3 Mar 2024 17:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709485826;
	bh=vJK91lcyx53aatDQEALdWJ5XzOTDCwzmfej68bxhV2o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VXvQDTN3S5QRCNmhaT/lZCcllq4gw1sP61HFBdSc9uqvyDtTpdXy5tUQoGRXQ/oQh
	 MhVH9dml4Cx83SiJTf2BrUdP5JiT8rov2mSNNBNBzZAAR5Y8XZruxiG9vOhKBL1lWQ
	 yuHB5rDNlse0v58AwZjs6lyb+ehlhh+/53TA1xGxL5WfVGL9qvqCZtsJiBr5/HrjQo
	 5qB6X+RQFz4QSYkMvEz6puUro+OxDmrADhG0Md/lv4xUdjf8t/ULjedVZQaEtUdtP5
	 cDJdH2QYD1Td+0Ol5YlHUrFdEWyqQPj0FDr7Ye/zzakYjMcTIgcBH3SawCuJnEypdJ
	 bIRb7jaMGzmhA==
Date: Sun, 3 Mar 2024 17:10:13 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: inv.git-commit@tdk.com
Cc: lars@metafoo.de, linux-iio@vger.kernel.org, Jean-Baptiste Maneyrol
 <jean-baptiste.maneyrol@tdk.com>
Subject: Re: [PATCH 3/4] iio: imu: inv_mpu6050: add new interrupt handler
 for WoM events
Message-ID: <20240303171013.110eddee@jic23-huawei>
In-Reply-To: <20240225160027.200092-4-inv.git-commit@tdk.com>
References: <20240225160027.200092-1-inv.git-commit@tdk.com>
	<20240225160027.200092-4-inv.git-commit@tdk.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 25 Feb 2024 16:00:26 +0000
inv.git-commit@tdk.com wrote:

> From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> 
> Add new interrupt handler for generating WoM event from int status
> register bits. Launch from interrupt the trigger poll function for
> data buffer.
> 
> Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> ---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h     |  2 +
>  drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c    | 11 ----
>  drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c | 56 +++++++++++++++++--
>  3 files changed, 53 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> index 519c1eee96ad..9be67cebbd49 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> @@ -184,6 +184,7 @@ struct inv_mpu6050_hw {
>   *  @magn_orient:       magnetometer sensor chip orientation if available.
>   *  @suspended_sensors:	sensors mask of sensors turned off for suspend
>   *  @data:		read buffer used for bulk reads.
> + *  @it_timestamp:	interrupt timestamp.
>   */
>  struct inv_mpu6050_state {
>  	struct mutex lock;
> @@ -209,6 +210,7 @@ struct inv_mpu6050_state {
>  	unsigned int suspended_sensors;
>  	bool level_shifter;
>  	u8 *data;
> +	s64 it_timestamp;
>  };
>  
>  /*register and associated bit definition*/
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> index 13da6f523ca2..e282378ee2ca 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> @@ -51,21 +51,10 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
>  	u32 fifo_period;
>  	s64 timestamp;
>  	u8 data[INV_MPU6050_OUTPUT_DATA_SIZE];
> -	int int_status;
>  	size_t i, nb;
>  
>  	mutex_lock(&st->lock);
>  
> -	/* ack interrupt and check status */
> -	result = regmap_read(st->map, st->reg->int_status, &int_status);
> -	if (result) {
> -		dev_err(regmap_get_device(st->map),
> -			"failed to ack interrupt\n");
> -		goto flush_fifo;
> -	}
> -	if (!(int_status & INV_MPU6050_BIT_RAW_DATA_RDY_INT))
> -		goto end_session;
> -
>  	if (!(st->chip_config.accl_fifo_enable |
>  		st->chip_config.gyro_fifo_enable |
>  		st->chip_config.magn_fifo_enable))
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> index ec2398a87f45..7ffbb9e7c100 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> @@ -6,6 +6,7 @@
>  #include <linux/pm_runtime.h>
>  
>  #include <linux/iio/common/inv_sensors_timestamp.h>
> +#include <linux/iio/events.h>
>  
>  #include "inv_mpu_iio.h"
>  
> @@ -223,6 +224,52 @@ static const struct iio_trigger_ops inv_mpu_trigger_ops = {
>  	.set_trigger_state = &inv_mpu_data_rdy_trigger_set_state,
>  };
>  
> +static irqreturn_t inv_mpu6050_interrupt_timestamp(int irq, void *p)
> +{
> +	struct iio_dev *indio_dev = p;
> +	struct inv_mpu6050_state *st = iio_priv(indio_dev);
> +
> +	st->it_timestamp = iio_get_time_ns(indio_dev);
> +
> +	return IRQ_WAKE_THREAD;

I think you can use iio_pollfunc_store_time().

> +}
> +
> +static irqreturn_t inv_mpu6050_interrupt_handle(int irq, void *p)
> +{
> +	struct iio_dev *indio_dev = p;
> +	struct inv_mpu6050_state *st = iio_priv(indio_dev);
> +	unsigned int int_status = 0;
> +	int result;
> +
> +	mutex_lock(&st->lock);
> +
> +	/* ack interrupt and check status */
> +	result = regmap_read(st->map, st->reg->int_status, &int_status);
> +	if (result) {
> +		dev_err(regmap_get_device(st->map),
> +			"failed to ack interrupt\n");
> +		goto exit_unlock;
> +	}
> +
> +	/* handle WoM event */
> +	if (st->chip_config.wom_en && (int_status & INV_MPU6500_BIT_WOM_INT))
> +		iio_push_event(indio_dev,
> +			       IIO_UNMOD_EVENT_CODE(IIO_ACCEL, 0, IIO_EV_TYPE_MAG_ADAPTIVE,
> +						    IIO_EV_DIR_RISING),
Maybe should be modified.

Hmm. Is this magnitude of the overall acceleration or is it a per channel thing?

If it's overall then we need to know how they are combined to describe this right.
If it's an X or Y or Z thing we do have a modifier for that though I kind of
regret adding that and wish now we'd just always reported 3 events.
(problem with those X_OR_Y_OR_Z modifiers is they don't generalize well)

> +				st->it_timestamp);
> +
> +exit_unlock:
> +	mutex_unlock(&st->lock);
> +
> +	/* handle raw data interrupt */
> +	if (int_status & INV_MPU6050_BIT_RAW_DATA_RDY_INT) {
> +		indio_dev->pollfunc->timestamp = st->it_timestamp;

As above, why not use the standard function for this.
I don't think anything will have cleared it.

> +		iio_trigger_poll_nested(st->trig);
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
>  int inv_mpu6050_probe_trigger(struct iio_dev *indio_dev, int irq_type)
>  {
>  	int ret;
> @@ -235,11 +282,10 @@ int inv_mpu6050_probe_trigger(struct iio_dev *indio_dev, int irq_type)
>  	if (!st->trig)
>  		return -ENOMEM;
>  
> -	ret = devm_request_irq(&indio_dev->dev, st->irq,
> -			       &iio_trigger_generic_data_rdy_poll,
> -			       irq_type,
> -			       "inv_mpu",
> -			       st->trig);
> +	ret = devm_request_threaded_irq(&indio_dev->dev, st->irq,
> +					&inv_mpu6050_interrupt_timestamp,
> +					&inv_mpu6050_interrupt_handle,
> +					irq_type, "inv_mpu", indio_dev);
>  	if (ret)
>  		return ret;
>  


