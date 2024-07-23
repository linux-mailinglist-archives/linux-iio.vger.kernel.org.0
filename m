Return-Path: <linux-iio+bounces-7818-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42BCA939C93
	for <lists+linux-iio@lfdr.de>; Tue, 23 Jul 2024 10:26:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C03CE1F226E9
	for <lists+linux-iio@lfdr.de>; Tue, 23 Jul 2024 08:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C455B14B97E;
	Tue, 23 Jul 2024 08:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dIeP168y"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F3E14B094
	for <linux-iio@vger.kernel.org>; Tue, 23 Jul 2024 08:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721723109; cv=none; b=B+c02Jf9U4sOb4uo4DtkoS0xiZe3B4o0reYKT2uNSMXpZM68JGpYQGnvlVGDd6h6LXVb3lXDzKJBVfWceIaiw4hGZMx5m2mjD4xf6FprGa8W/g9hpzam5J6WxHIoraM/HdpF9vs9snwPZ8HQ5LhXo1WAbZWZ4CmesA8BUWTa9Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721723109; c=relaxed/simple;
	bh=nqj2p6iRxiLOU1A3JS40ElnIm9jKKAZBXQizS8pASIg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=APLkki3dLRN2oyNwxo9MzLUA0CcamJ36+Oe8maus//rlocd2GHGO1MJASHwcue7B/p9BM81QRQxIKvJ+9wbRNxg4XnD5Ppea52xqZ8NpvVCDIU3WsHvtEx/11oI+i/nIcSHtlL49Pxoe5LEyEG8ft9vaF5gFUNXvzsK3bImfuA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dIeP168y; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a7a8caef11fso70298266b.0
        for <linux-iio@vger.kernel.org>; Tue, 23 Jul 2024 01:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721723106; x=1722327906; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3aqRkPGODuEHMYjbf1klGZayU53y75hrpFHkb4TgULI=;
        b=dIeP168yQ8IuzIYCFKfBCS45ORxVB0T5axd6WeNNjSPeb/Ce4vwJFzXU6BCasqBMbr
         D2XDjduPVdv71AMy5BRMXurF0Ct5S8sak02oPOWynLLSDQ9tc+tnVYayt634H1EbLOxX
         a/pxohsgF/MPEcMVKkbQJN1qyQO0bYAND92Cy8dsZTFBd/5+OXqYJiag/VAbKvgBvtFS
         99FJgWDlldkFITc/ZMp95If3jiqClrObKsBgEUgfCqvsKybD/Dl5dB8f6UHfQIdDaBaY
         Xt+onqEowiE21Fr4pLNbqLYqZ50umUr5DlhAAdTOUcEhZ5bn5TZ1+GatFtV/4r9xv4zz
         Q6/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721723106; x=1722327906;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3aqRkPGODuEHMYjbf1klGZayU53y75hrpFHkb4TgULI=;
        b=KnlVNMphPtGcrk3ZoEZAsJrlQQodc3YfRcZzooo9iD5nvDJyBxVQmGTcIOq69+Gm5a
         EGosAxptKrUENAoK4cL9rB1TMwl/yK7m0aYXA4q88xc3qqEfQkbvRdv4dpCUL1Po2k7S
         7zp7DQ2JKStZpqnTsRd6RHoOWmbwIEw2aWNX58rOGdKswwVhy5poi5/jps2OtDY4CEGv
         4w0WDOuDFbsmWeXp6tUN1vsZH9MFf8IvwmQ9uOCcGdDDwokb01bUomkdnU/M/uT00X1U
         wcXSq7pR2REj09lPdiKG+otNGVgTNQ+zQQ+HZrCKRiyGMJF+CT+RKmO1iwqSFzaw4SqV
         skhg==
X-Forwarded-Encrypted: i=1; AJvYcCV1nuQqzsW39xOBgHyj6W5jHaIn5Jh2SDRvd05SfOXCAHkHFNPbbWuDu9KSe7AYsdUZUXgevBIsxci9IiANIbnJhnpO2RnDZ9My
X-Gm-Message-State: AOJu0Ywfml8xtL7vZBBvs9eRBUc8W6qii/piSOUVW9w5Js+CA0v1jVhD
	gxPH2Qow1p23PX6dK1nSKSuJ8yGz7+PFLSnlz1LImhGrSBJ5YRF6dDqSHg==
X-Google-Smtp-Source: AGHT+IG7+aZBJPghYwxcpAzc0oLhp5+XO7hbRDO5ClyNzRV0YOK2oTustKft7a5uM9oyg993sGMeFg==
X-Received: by 2002:a17:907:6d13:b0:a72:6b08:ab24 with SMTP id a640c23a62f3a-a7a87c006famr168120966b.14.1721723105745;
        Tue, 23 Jul 2024 01:25:05 -0700 (PDT)
Received: from [100.65.89.151] ([188.163.112.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7a3c8c2076sm504601366b.123.2024.07.23.01.25.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jul 2024 01:25:05 -0700 (PDT)
Message-ID: <0ea167a1-75d0-469d-a79f-ff2cb5e81bdc@gmail.com>
Date: Tue, 23 Jul 2024 11:25:03 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] iio: imu: inv_mpu6050: add new interrupt handler
 for WoM events
To: inv.git-commit@tdk.com, jic23@kernel.org
Cc: lars@metafoo.de, linux-iio@vger.kernel.org,
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
References: <20240311160557.437337-1-inv.git-commit@tdk.com>
 <20240311160557.437337-4-inv.git-commit@tdk.com>
Content-Language: en-US
From: Svyatoslav Ryhel <clamor95@gmail.com>
In-Reply-To: <20240311160557.437337-4-inv.git-commit@tdk.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

11.03.24 6:05 пп, inv.git-commit@tdk.com:
> From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
>
> Add new interrupt handler for generating WoM event from int status register
> bits. Launch from interrupt the trigger poll function for data buffer.
>
> Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> ---
>   drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h     |  2 +
>   drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c    | 11 ---
>   drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c | 69 +++++++++++++++++--
>   3 files changed, 66 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> index d5b0465d1f74..ca5f7d45a6d4 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> @@ -185,6 +185,7 @@ struct inv_mpu6050_hw {
>    *  @magn_orient:       magnetometer sensor chip orientation if available.
>    *  @suspended_sensors:	sensors mask of sensors turned off for suspend
>    *  @data:		read buffer used for bulk reads.
> + *  @it_timestamp:	interrupt timestamp.
>    */
>   struct inv_mpu6050_state {
>   	struct mutex lock;
> @@ -210,6 +211,7 @@ struct inv_mpu6050_state {
>   	unsigned int suspended_sensors;
>   	bool level_shifter;
>   	u8 *data;
> +	s64 it_timestamp;
>   };
>   
>   /*register and associated bit definition*/
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> index 13da6f523ca2..e282378ee2ca 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> @@ -51,21 +51,10 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
>   	u32 fifo_period;
>   	s64 timestamp;
>   	u8 data[INV_MPU6050_OUTPUT_DATA_SIZE];
> -	int int_status;
>   	size_t i, nb;
>   
>   	mutex_lock(&st->lock);
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
>   	if (!(st->chip_config.accl_fifo_enable |
>   		st->chip_config.gyro_fifo_enable |
>   		st->chip_config.magn_fifo_enable))
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> index ec2398a87f45..2514966f6495 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> @@ -6,6 +6,7 @@
>   #include <linux/pm_runtime.h>
>   
>   #include <linux/iio/common/inv_sensors_timestamp.h>
> +#include <linux/iio/events.h>
>   
>   #include "inv_mpu_iio.h"
>   
> @@ -223,6 +224,65 @@ static const struct iio_trigger_ops inv_mpu_trigger_ops = {
>   	.set_trigger_state = &inv_mpu_data_rdy_trigger_set_state,
>   };
>   
> +static irqreturn_t inv_mpu6050_interrupt_timestamp(int irq, void *p)
> +{
> +	struct iio_dev *indio_dev = p;
> +	struct inv_mpu6050_state *st = iio_priv(indio_dev);
> +
> +	st->it_timestamp = iio_get_time_ns(indio_dev);
> +
> +	return IRQ_WAKE_THREAD;
> +}
> +
> +static irqreturn_t inv_mpu6050_interrupt_handle(int irq, void *p)
> +{
> +	struct iio_dev *indio_dev = p;
> +	struct inv_mpu6050_state *st = iio_priv(indio_dev);
> +	unsigned int int_status, wom_bits;
> +	u64 ev_code;
> +	int result;
> +
> +	switch (st->chip_type) {
> +	case INV_MPU6050:
> +	case INV_MPU6500:
> +	case INV_MPU6515:
> +	case INV_MPU6880:
> +	case INV_MPU6000:
> +	case INV_MPU9150:
> +	case INV_MPU9250:
> +	case INV_MPU9255:
> +		wom_bits = INV_MPU6500_BIT_WOM_INT;
> +		break;
> +	default:
> +		wom_bits = INV_ICM20608_BIT_WOM_INT;
> +		break;
> +	}
> +
> +	scoped_guard(mutex, &st->lock) {
> +		/* ack interrupt and check status */
> +		result = regmap_read(st->map, st->reg->int_status, &int_status);
> +		if (result) {
> +			dev_err(regmap_get_device(st->map), "failed to ack interrupt\n");
> +			return IRQ_HANDLED;
> +		}
> +
> +		/* handle WoM event */
> +		if (st->chip_config.wom_en && (int_status & wom_bits)) {
> +			ev_code = IIO_MOD_EVENT_CODE(IIO_ACCEL, 0, IIO_MOD_X_OR_Y_OR_Z,
> +						     IIO_EV_TYPE_ROC, IIO_EV_DIR_RISING);
> +			iio_push_event(indio_dev, ev_code, st->it_timestamp);
> +		}
> +	}
> +
> +	/* handle raw data interrupt */
> +	if (int_status & INV_MPU6050_BIT_RAW_DATA_RDY_INT) {
> +		indio_dev->pollfunc->timestamp = st->it_timestamp;
> +		iio_trigger_poll_nested(st->trig);
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
>   int inv_mpu6050_probe_trigger(struct iio_dev *indio_dev, int irq_type)
>   {
>   	int ret;
> @@ -235,11 +295,10 @@ int inv_mpu6050_probe_trigger(struct iio_dev *indio_dev, int irq_type)
>   	if (!st->trig)
>   		return -ENOMEM;
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
>   	if (ret)
>   		return ret;
>   

Greetings!

After this patch was applied to Linux kernel I faced a regression on my 
devices LG P895/P880.

Dmesg is flooded with

[ 50.035018] inv-mpu6050-i2c 0-0068: failed to ack interrupt -121

and mpu6050 used on this device refuses to work. It did not occur before 
WoM patches were

applied and reverting patches restores normal work of mpu6050.


Best regards,

Svyatoslav R.


