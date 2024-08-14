Return-Path: <linux-iio+bounces-8469-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C85F5951F12
	for <lists+linux-iio@lfdr.de>; Wed, 14 Aug 2024 17:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EB711F22F9B
	for <lists+linux-iio@lfdr.de>; Wed, 14 Aug 2024 15:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DABF1B5819;
	Wed, 14 Aug 2024 15:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PP9GcaAF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C693F1B4C3F;
	Wed, 14 Aug 2024 15:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723650648; cv=none; b=PlTe2XAanS4hZxukHW5ddCvY2Wl7dFv+iO9FqR9cpB+GIDH5//ClO4A9/iKPQjV57XyjQ+qtTL53VgINjjufUdOb+t/DEmn3dPj/GcEHGaEYZ//YbL+XWD/ktx5UQSNgNONPoUJWFTLoI0lnoAvjrzmZfuAiRFn6/OupPo5TfTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723650648; c=relaxed/simple;
	bh=xaIRf8gburO7fSK6Qg0SNQ6c7hxnHOaaupR7/cwfZoc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SI+78MNNIdDv0NCgcB7EX0QDdbdLEL2QtB7BDILEYuCRrpjF/GCfEHgrrwDuNSgSLeUDZlKPL6AiomlIwF/kHMdTlU45Mgnjrqmrj0K0wuUiWOSheMesHMMUozd97sh62S7d98djQHBC93zMqlH4uHHMHxnmLbU4AAvOHNTaK+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PP9GcaAF; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5af326eddb2so1736500a12.1;
        Wed, 14 Aug 2024 08:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723650645; x=1724255445; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t7Sbo6wQRtkVQOZupqBdUqy9Fytqmq/TMoezSF0uEXM=;
        b=PP9GcaAFA5mgdzs56yGr2tEV1lgh2L7fY7G2aGAqC8mkdwH+604YkBGV0NhOkxXS58
         L+rMSmoPzrjUKbN8OMf3f+O0SbaS8fnAQRDnibvYhbEN3xWOjvMvQ2r9jfduXfmvvoIf
         nIZFHWdW45Ut3xSDReKKVr3Kylyt3dax04AvyC+nfDWg3eS+4DRw7dARTjNHCgwhX4o+
         K7the8zvxlAFJ8GuhaUqf4wFIDpJpRNDhSWeUihsYl7ax9v7KWzcCnddUB4isczKmj47
         M/hyge15yGbPBSL8VwkvJMGeSqFZU3jsh4TWeuxtYFCxE8krksW/5wlhlBKKLS7dcdt5
         PTuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723650645; x=1724255445;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t7Sbo6wQRtkVQOZupqBdUqy9Fytqmq/TMoezSF0uEXM=;
        b=H/cfAXxwZO5XHTUYso1U/Xjlylqd26TKIqye0sZvcOcMefX/bEjL+bZHblt2B0pt1o
         FCayyoxbdLPpBxrGCNcMW9iCpaMThfnfQY6lX/ipayGc3o6TMEuL4AceKm2iFTK6YCYa
         L68oNnyIO/jWPfVDYS3UvvxE5+yJgRFSNadFnWPsmFVADyL5vLJADhwcZiYRcVPL3UV2
         dxJ8BWP/Nd67k5TGvaxmBfuPuAakjiNsYC/pkkYpExR1+1uAPmLUpn5L75EGppgw029Q
         rwe5aR+VW5a2f/xaxgYjpa7KW2YbuR4R4J91tY3ItOOOjwXQm8XZgEY+iLWfQ/8I1EMF
         j9Og==
X-Forwarded-Encrypted: i=1; AJvYcCWjczG05MOKIgtcDsD0eGwkf9J3X6jk5Xyu4Ik7tik5m9IiPYxcfQSTVjPnNCeC/ngtXGFxcNt67rEZoce0xBmqf4vVe7WSZybvZ1walS2aO7g99idUNC/Hqwed/BAR7t4l
X-Gm-Message-State: AOJu0YxYxywqmh6q0sEu5aUNN/uU76E9MdX9onIxvxglxk2Prg9RXMKG
	NnqbHCiJLhgVPZl9OTgEIZI4pxP6hoV/bs+h5cpcxv3I+D7AdtArMUjvRUqC
X-Google-Smtp-Source: AGHT+IFD+SXJ6j9bra4jImgUHuAQbZ7NXg7goZSpbNFpTeUCwU8XQWmuJiB72sPYUODQP/fumoI1aA==
X-Received: by 2002:a05:6402:2085:b0:5bd:464a:2623 with SMTP id 4fb4d7f45d1cf-5beb3ae3d6emr79931a12.10.1723650644717;
        Wed, 14 Aug 2024 08:50:44 -0700 (PDT)
Received: from [100.65.89.151] ([188.163.112.54])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bd1968af77sm3960461a12.40.2024.08.14.08.50.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Aug 2024 08:50:44 -0700 (PDT)
Message-ID: <045f7e8a-d462-4419-8e7b-c06857d2338f@gmail.com>
Date: Wed, 14 Aug 2024 18:50:43 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: imu: inv_mpu6050: fix interrupt status read for old
 buggy chips
To: inv.git-commit@tdk.com, jic23@kernel.org
Cc: lars@metafoo.de, linux-iio@vger.kernel.org, stable@vger.kernel.org,
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
References: <20240814143735.327302-1-inv.git-commit@tdk.com>
Content-Language: en-US
From: Svyatoslav Ryhel <clamor95@gmail.com>
In-Reply-To: <20240814143735.327302-1-inv.git-commit@tdk.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

14.08.24 5:37 пп, inv.git-commit@tdk.com:
> From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
>
> Interrupt status read seems to be broken on some old MPU-6050 like
> chips. Fix by reverting to previous driver behavior bypassing interrupt
> status read. This is working because these chips are not supporting
> WoM and data ready is the only interrupt source.
>
> Fixes: 5537f653d9be ("iio: imu: inv_mpu6050: add new interrupt handler for WoM events")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Tested-by: Andreas Westman Dorcsak <hedmoo@yahoo.com> # LG P880

Tested-by: Svyatoslav Ryhel <clamor95@gmail.com> # LG P895

> ---
>   drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c | 13 +++++++++++--
>   1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> index 84273660ca2e..3bfeabab0ec4 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> @@ -248,12 +248,20 @@ static irqreturn_t inv_mpu6050_interrupt_handle(int irq, void *p)
>   	int result;
>
>   	switch (st->chip_type) {
> +	case INV_MPU6000:
>   	case INV_MPU6050:
> +	case INV_MPU9150:
> +		/*
> +		 * WoM is not supported and interrupt status read seems to be broken for
> +		 * some chips. Since data ready is the only interrupt, bypass interrupt
> +		 * status read and always assert data ready bit.
> +		 */
> +		wom_bits = 0;
> +		int_status = INV_MPU6050_BIT_RAW_DATA_RDY_INT;
> +		goto data_ready_interrupt;
>   	case INV_MPU6500:
>   	case INV_MPU6515:
>   	case INV_MPU6880:
> -	case INV_MPU6000:
> -	case INV_MPU9150:
>   	case INV_MPU9250:
>   	case INV_MPU9255:
>   		wom_bits = INV_MPU6500_BIT_WOM_INT;
> @@ -279,6 +287,7 @@ static irqreturn_t inv_mpu6050_interrupt_handle(int irq, void *p)
>   		}
>   	}
>
> +data_ready_interrupt:
>   	/* handle raw data interrupt */
>   	if (int_status & INV_MPU6050_BIT_RAW_DATA_RDY_INT) {
>   		indio_dev->pollfunc->timestamp = st->it_timestamp;
> --
> 2.34.1
>

