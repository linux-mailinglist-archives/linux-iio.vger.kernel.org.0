Return-Path: <linux-iio+bounces-23811-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA0A5B463E0
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 21:46:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D247189A237
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 19:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5940B261B91;
	Fri,  5 Sep 2025 19:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="B0iOfmJ7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF731F418F
	for <linux-iio@vger.kernel.org>; Fri,  5 Sep 2025 19:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757101557; cv=none; b=bsRZ1Wb0n13LITBRuLxlsIIWqSfR3I6mMBYKKoCuC5WCaxikYhgs/49Nxn81+E5i5f118vKmcyEKWwF0+MC22fr4NXh6HkPCyTwpRYzjvc/EOLfaJazwAIyMDD/p5hg//xGsut8C/HyJfbZfcpk/oBA77V6aESbEscj1KFMBOT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757101557; c=relaxed/simple;
	bh=GWjv41PMUSh+0GnLBueQAN/lr4mkZwzdenfEYc23+Ww=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TAYnV8dlCgwTp0jJEp91G8q8fZbJh2y4y5nEkeew2JmdMQUpgAWfcjUQ+xSEMoac+Naw2qb7380Xz4fjFwV94d68owoEOiavg8cMngSRqs+EIfzjhhpxYoZVmRZvCbGqUKeac98nGkLlOKd5lBFRk8EtU4CjxvilBfrwpczwTWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=B0iOfmJ7; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-30cceb749d7so1210707fac.2
        for <linux-iio@vger.kernel.org>; Fri, 05 Sep 2025 12:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1757101554; x=1757706354; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wMVeeupO7nVyHlPShS7/JEp2FA1z8twjRoXKQINqTCY=;
        b=B0iOfmJ74p7iZJtHKc5xF0lDC3G3YOecd5do4E879d0Rjkinr9mgJFIqEaVpju2FLD
         BoRpdxpvM121FSAzbgN2VP18IVNKB14/rAyTp396jMzExD46tD8N3kKHmm1uByTCDimH
         zvWAdUtam04ABu7oOwjNg96mPuoeDeWt4wCIEBEy4owgg7U/pPwxWyJNJETwbumoEiO2
         aWN1tCGujvWe6n/1xG44YlNmHMPfi0HBaJh1knFKuv17UMXmcbD6+xc7nnHCh8lthZfR
         z4ID8NzlyLRADHvk3mhrC3WSq0O8hWBGjAnekFFTapR301ai9W6rUAaYwpUczwombnBY
         HKvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757101554; x=1757706354;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wMVeeupO7nVyHlPShS7/JEp2FA1z8twjRoXKQINqTCY=;
        b=TP2NBHG8IQqj0ps3sNkcTm/dAJQHTn9z4b+ZrBV8aoj/Ptf07nyYKnkt7zx8/zXwYg
         CPolemJPgLF0OUR1Fp6NO8S0XwlWr7PrwqM3ZhpoRU+wschrlKfQ+zIm7qPRwb3+LvKw
         I9s1hCEoamEVO60Dgd+kxpFQWCzD5ZEIqwGH0GiwCyQYRiRF4ChJnCNnWmjGUhwsDIFX
         SFk93VVd4dRf/Zij207d9Mm8M6ULmTwowpwj4+Z2+SzgXduX9HzLZ1LHvO/614862jaq
         bawVwCuGOF1Km79aLiFrF8aFlJkHIdZwJDhzDEm2rYZzAX1DjF7PaEQJhHhZ448i9Z7y
         L2qg==
X-Gm-Message-State: AOJu0Yy9iYz5ssYT4PA1/KFTcMTUvx99LTw7KBD3MPQjnu1YXge0mcnP
	oxfh3berSjcQvoNoDHeR3IY8P3EVr3pgqC38yMFUYsG5mcWEuskaB8CrIXMjP6S6FSM=
X-Gm-Gg: ASbGncvjgZ1i9c8m3X9HJ5CRsJmIlWqCCudvyI9mhr1S5BGf++ZLQceuxbRTR2zE8PC
	frvxZz09/vOeup2LirxppWugcFGSnxEZxYFIRq4T8nsSE4LW0WAqIQYaGUlDW3IFEPP7L2JaPwE
	fNO23hsZ3vMyOrNfKNvN3u18ComSwbbzT+I+10iCEkj0ABgC41O3ZQQHWfu6xr8XbRqf3yFfJsc
	WMdRZx8pF7K1ltLwzw9PdDhq160v6vd8XT1akdLn8tX8OBPvieQxAJLHeM/BlzQPL83tRsGxK3k
	tLre1uvXz6tySf0DGMyW6QcumdDrXk/PWU//GelavcVr8eo5gkM2jrcxwPU6dHZ/36VxQajxiQe
	o4dVz2Wb1vip3rrPv7oKfhMotjLa3/ew3KYYlWEZAMVtR5b3d1m3YsFy/dBQ1leWjyAlwigMzrZ
	YGVyXv3YF7RTG0Lnjh7w==
X-Google-Smtp-Source: AGHT+IFbh169pik9dmu9QkSK7T9MHlBuCFpEWz92nq4qGC+TAIYCdE8K289Mo31SYJE/GyDqbaBLNQ==
X-Received: by 2002:a05:6870:a919:b0:2d5:1232:b081 with SMTP id 586e51a60fabf-319633450fbmr13205311fac.29.1757101553907;
        Fri, 05 Sep 2025 12:45:53 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:52e:cda3:16cc:72bb? ([2600:8803:e7e4:1d00:52e:cda3:16cc:72bb])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-319b58e2312sm3954351fac.10.2025.09.05.12.45.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 12:45:53 -0700 (PDT)
Message-ID: <fbea7d45-bf92-4f6b-a464-0f7a6f921bde@baylibre.com>
Date: Fri, 5 Sep 2025 14:45:52 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] iio: imu: inv_icm42600: use guard() to release
 mutexes
To: Sean Nyekjaer <sean@geanix.com>,
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, rafael@kernel.org,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250901-icm42pmreg-v3-0-ef1336246960@geanix.com>
 <20250901-icm42pmreg-v3-5-ef1336246960@geanix.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250901-icm42pmreg-v3-5-ef1336246960@geanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/1/25 2:49 AM, Sean Nyekjaer wrote:
> Replace explicit mutex_lock() and mutex_unlock() with the guard() macro
> for cleaner and safer mutex handling.
> 
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> ---
>  drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c  | 25 +++------
>  drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c | 27 ++++-----
>  drivers/iio/imu/inv_icm42600/inv_icm42600_core.c   | 65 +++++++++-------------
>  drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c   | 20 +++----
>  4 files changed, 55 insertions(+), 82 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
> index 48014b61ced335eb2c8549cfc2e79ccde1934308..fbed6974ef04ac003c9b7bd38f87bd77f4b55509 100644
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
> @@ -561,11 +561,11 @@ static int inv_icm42600_accel_write_scale(struct iio_dev *indio_dev,
>  	conf.fs = idx / 2;
>  
>  	pm_runtime_get_sync(dev);
> -	mutex_lock(&st->lock);
>  
> -	ret = inv_icm42600_set_accel_conf(st, &conf, NULL);
> +	scoped_guard(mutex, &st->lock) {
> +		ret = inv_icm42600_set_accel_conf(st, &conf, NULL);
> +	}

Don't need braces here.

>  
> -	mutex_unlock(&st->lock);
>  	pm_runtime_put_autosuspend(dev);
>  
>  	return ret;


...

> @@ -299,7 +298,7 @@ static int inv_icm42600_buffer_postenable(struct iio_dev *indio_dev)
>  	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
>  	int ret;
>  
> -	mutex_lock(&st->lock);
> +	guard(mutex)(&st->lock);
>  
>  	/* exit if FIFO is already on */
>  	if (st->fifo.on) {
> @@ -311,30 +310,29 @@ static int inv_icm42600_buffer_postenable(struct iio_dev *indio_dev)
>  	ret = regmap_set_bits(st->map, INV_ICM42600_REG_INT_SOURCE0,
>  			      INV_ICM42600_INT_SOURCE0_FIFO_THS_INT1_EN);
>  	if (ret)
> -		goto out_unlock;
> +		return ret;
>  
>  	/* flush FIFO data */
>  	ret = regmap_write(st->map, INV_ICM42600_REG_SIGNAL_PATH_RESET,
>  			   INV_ICM42600_SIGNAL_PATH_RESET_FIFO_FLUSH);
>  	if (ret)
> -		goto out_unlock;
> +		return ret;
>  
>  	/* set FIFO in streaming mode */
>  	ret = regmap_write(st->map, INV_ICM42600_REG_FIFO_CONFIG,
>  			   INV_ICM42600_FIFO_CONFIG_STREAM);
>  	if (ret)
> -		goto out_unlock;
> +		return ret;
>  
>  	/* workaround: first read of FIFO count after reset is always 0 */
>  	ret = regmap_bulk_read(st->map, INV_ICM42600_REG_FIFO_COUNT, st->buffer, 2);
>  	if (ret)
> -		goto out_unlock;
> +		return ret;
>  
>  out_on:
>  	/* increase FIFO on counter */
>  	st->fifo.on++;

I would be tempted to get rid of out_on as well even if we have to repeat
`st->fifo.on++;` in two places.

> -out_unlock:
> -	mutex_unlock(&st->lock);
> +
>  	return ret;

Can just return 0 here and simplify if (st->fifo.on).

>  }
>  
> @@ -343,7 +341,7 @@ static int inv_icm42600_buffer_predisable(struct iio_dev *indio_dev)
>  	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
>  	int ret;
>  
> -	mutex_lock(&st->lock);
> +	guard(mutex)(&st->lock);
>  
>  	/* exit if there are several sensors using the FIFO */
>  	if (st->fifo.on > 1) {
> @@ -355,25 +353,24 @@ static int inv_icm42600_buffer_predisable(struct iio_dev *indio_dev)
>  	ret = regmap_write(st->map, INV_ICM42600_REG_FIFO_CONFIG,
>  			   INV_ICM42600_FIFO_CONFIG_BYPASS);
>  	if (ret)
> -		goto out_unlock;
> +		return ret;
>  
>  	/* flush FIFO data */
>  	ret = regmap_write(st->map, INV_ICM42600_REG_SIGNAL_PATH_RESET,
>  			   INV_ICM42600_SIGNAL_PATH_RESET_FIFO_FLUSH);
>  	if (ret)
> -		goto out_unlock;
> +		return ret;
>  
>  	/* disable FIFO threshold interrupt */
>  	ret = regmap_clear_bits(st->map, INV_ICM42600_REG_INT_SOURCE0,
>  				INV_ICM42600_INT_SOURCE0_FIFO_THS_INT1_EN);
>  	if (ret)
> -		goto out_unlock;
> +		return ret;
>  
>  out_off:
>  	/* decrease FIFO on counter */
>  	st->fifo.on--;
> -out_unlock:
> -	mutex_unlock(&st->lock);
> +
>  	return ret;

Same comments apply here.

>  }
>  
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
> index 4bf436c46f1cfd7e7e1bb911d94a0a566d63e791..4db8bc68075a30c59e6e358bb0b73b1e6b9175ea 100644
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
> @@ -439,18 +439,13 @@ int inv_icm42600_debugfs_reg(struct iio_dev *indio_dev, unsigned int reg,
>  			     unsigned int writeval, unsigned int *readval)
>  {
>  	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
> -	int ret;
>  
> -	mutex_lock(&st->lock);
> +	guard(mutex)(&st->lock);
>  
>  	if (readval)
> -		ret = regmap_read(st->map, reg, readval);
> +		return regmap_read(st->map, reg, readval);
>  	else

Don't need the `else` anymore.

> -		ret = regmap_write(st->map, reg, writeval);
> -
> -	mutex_unlock(&st->lock);
> -
> -	return ret;
> +		return regmap_write(st->map, reg, writeval);
>  }
>  
>  static int inv_icm42600_set_conf(struct inv_icm42600_state *st,
> @@ -820,22 +815,23 @@ static int inv_icm42600_suspend(struct device *dev)
>  	struct device *accel_dev;
>  	bool wakeup;
>  	int accel_conf;
> -	int ret = 0;
> +	int ret;
>  
> -	mutex_lock(&st->lock);
> +	guard(mutex)(&st->lock);
>  
>  	st->suspended.gyro = st->conf.gyro.mode;
>  	st->suspended.accel = st->conf.accel.mode;
>  	st->suspended.temp = st->conf.temp_en;
> -	if (pm_runtime_suspended(dev))
> -		goto out_unlock;
> +	ret = pm_runtime_suspended(dev);
> +	if (ret)
> +		return ret;

pm_runtime_suspended() returns a bool, so this doesn't make sense.

Probably should be:

	if (pm_runtime_suspended(dev))
		return 0;

>  
>  	/* disable FIFO data streaming */
>  	if (st->fifo.on) {
>  		ret = regmap_write(st->map, INV_ICM42600_REG_FIFO_CONFIG,
>  				   INV_ICM42600_FIFO_CONFIG_BYPASS);
>  		if (ret)
> -			goto out_unlock;
> +			return ret;
>  	}
>  
>  	/* keep chip on and wake-up capable if APEX and wakeup on */
> @@ -851,7 +847,7 @@ static int inv_icm42600_suspend(struct device *dev)
>  		if (st->apex.wom.enable) {
>  			ret = inv_icm42600_disable_wom(st);
>  			if (ret)
> -				goto out_unlock;
> +				return ret;
>  		}
>  		accel_conf = INV_ICM42600_SENSOR_MODE_OFF;
>  	}
> @@ -859,15 +855,13 @@ static int inv_icm42600_suspend(struct device *dev)
>  	ret = inv_icm42600_set_pwr_mgmt0(st, INV_ICM42600_SENSOR_MODE_OFF,
>  					 accel_conf, false, NULL);
>  	if (ret)
> -		goto out_unlock;
> +		return ret;
>  
>  	/* disable vddio regulator if chip is sleeping */
>  	if (!wakeup)
>  		regulator_disable(st->vddio_supply);
>  
> -out_unlock:
> -	mutex_unlock(&st->lock);
> -	return ret;
> +	return 0;
>  }
>  
>  /*
> @@ -881,12 +875,13 @@ static int inv_icm42600_resume(struct device *dev)
>  	struct inv_icm42600_sensor_state *accel_st = iio_priv(st->indio_accel);
>  	struct device *accel_dev;
>  	bool wakeup;
> -	int ret = 0;
> +	int ret;
>  
> -	mutex_lock(&st->lock);
> +	guard(mutex)(&st->lock);
>  
> -	if (pm_runtime_suspended(dev))
> -		goto out_unlock;
> +	ret = pm_runtime_suspended(dev);
> +	if (ret)
> +		return ret;

same here.

>  
>  	/* check wakeup capability */
>  	accel_dev = &st->indio_accel->dev;

...

> @@ -690,13 +690,11 @@ static int inv_icm42600_gyro_hwfifo_set_watermark(struct iio_dev *indio_dev,
>  	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
>  	int ret;
>  
> -	mutex_lock(&st->lock);
> +	guard(mutex)(&st->lock);
>  
>  	st->fifo.watermark.gyro = val;
>  	ret = inv_icm42600_buffer_update_watermark(st);

Can return directly now.

>  
> -	mutex_unlock(&st->lock);
> -
>  	return ret;
>  }
>  

