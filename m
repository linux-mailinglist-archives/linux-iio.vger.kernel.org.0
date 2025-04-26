Return-Path: <linux-iio+bounces-18690-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75BCEA9DB49
	for <lists+linux-iio@lfdr.de>; Sat, 26 Apr 2025 15:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A4441B67609
	for <lists+linux-iio@lfdr.de>; Sat, 26 Apr 2025 13:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8327252917;
	Sat, 26 Apr 2025 13:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dr4h6tpC"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69625252912;
	Sat, 26 Apr 2025 13:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745675265; cv=none; b=WUDW5d9qO9fyMNtJW/iXIQ1uLGzXlW5Qybdi2/NKlR01oqnjwL8HLI1vk0o1zfZSbsM0yI9ysTEvz0gd8S0X4fZdStZPlOx0b+leWjfr6KNlik5h4aD647L8N1YGIlmiDPUeXlnhuChZnTgPDkhemNjpxOmK/isdweOr6rEEVdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745675265; c=relaxed/simple;
	bh=FVDG2SiYFyfsbC44JdMc/Ft5iUmeAfusC2GYY7eYGeU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G2zQ2PBAGkLKD4SBpYyE5da0s/fqb4PEQpyx7/x7oj6W1DKWabdP6i826n9JQbOSg77jR43HKfwK1Spo65HEGrascfIJLcBiMWU2eoxh1cqhI83TAuYn7TFjZdmH9MnolUZasNf6VJbH6xpjsbJ8QDeEyIRRK+o2Rlw8asLf1z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dr4h6tpC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 314AEC4CEE2;
	Sat, 26 Apr 2025 13:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745675264;
	bh=FVDG2SiYFyfsbC44JdMc/Ft5iUmeAfusC2GYY7eYGeU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Dr4h6tpCkj1kAcss76dkP6aLnojrsj5Huc6MnQOwK6xxasoUiAjcY6m9V1n85R/gL
	 HlAn8eqTppycILp/6Try+liDWp1k+jkjlXFIJ33EELt8/0eMMwdy6RCf/IevMVvP6l
	 1TkFuyf2cvtZCyPvQA8qi/CYElFKS/JXZP1p3+3rtByWq5WL8PcuYbmd+Y7YC9zY45
	 k2YZHMs8RsuUwuf9GhCn0agS3yWZTmY74GT+Ygb5EIx0kpvu3I1iuJ7ZIClER+D2tz
	 ZDi+3qqRsZhZ9RS20FkLQVKaWcOdx9B5vWew2UjErNQoRf2wKxWAlEvUn3uWu4Vwdb
	 wjTMAv0hEMtQQ==
Date: Sat, 26 Apr 2025 14:47:39 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Gustavo Silva <gustavograzs@gmail.com>
Cc: Alex Lanzano <lanzano.alex@gmail.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] iio: imu: bmi270: add step counter watermark event
Message-ID: <20250426144739.31b8bd36@jic23-huawei>
In-Reply-To: <20250424-bmi270-events-v1-2-a6c722673e5f@gmail.com>
References: <20250424-bmi270-events-v1-0-a6c722673e5f@gmail.com>
	<20250424-bmi270-events-v1-2-a6c722673e5f@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Apr 2025 21:14:51 -0300
Gustavo Silva <gustavograzs@gmail.com> wrote:

> Add support for generating events when the step counter reaches the
> configurable watermark.
> 
> Signed-off-by: Gustavo Silva <gustavograzs@gmail.com>

Main thing in here is I think the event type isn't the right one.

> @@ -119,6 +128,7 @@ struct bmi270_data {
>  	 /* Protect device's private data from concurrent access */
>  	struct mutex mutex;
>  	int steps_enabled;
> +	unsigned int feature_events;

Why do we need this rather than just checking the register?


> +
> +static int bmi270_step_wtrmrk_en(struct bmi270_data *data, bool state)
> +{
> +	int ret, reg, field_value;
> +
> +	guard(mutex)(&data->mutex);
> +	if (!data->steps_enabled)
> +		return -EINVAL;
> +
> +	reg = bmi270_int_map_reg(data->irq_pin);
> +	if (reg < 0)
> +		return -EINVAL;
> +
> +	field_value = FIELD_PREP(BMI270_INT_MAP_FEAT_STEP_CNT_WTRMRK_MSK, state);
> +	ret = regmap_update_bits(data->regmap, reg,
> +				 BMI270_INT_MAP_FEAT_STEP_CNT_WTRMRK_MSK,
> +				 field_value);
> +	if (ret)
> +		return ret;
> +
> +	set_mask_bits(&data->feature_events,
> +		      BMI270_INT_MAP_FEAT_STEP_CNT_WTRMRK_MSK, field_value);

Given we wrote the register, why do we need a cached value?  Can't we just read
it back again (or rely on a regmap cache for it if enabled in this driver)

> +	return 0;
> +}
> +
>  static int bmi270_set_scale(struct bmi270_data *data, int chan_type, int uscale)
>  {
>  	int i;
> @@ -539,19 +585,32 @@ static irqreturn_t bmi270_irq_thread_handler(int irq, void *private)
>  {
>  	struct iio_dev *indio_dev = private;
>  	struct bmi270_data *data = iio_priv(indio_dev);
> -	unsigned int status;
> +	unsigned int status0, status1;
> +	s64 timestamp = iio_get_time_ns(indio_dev);
>  	int ret;
>  
>  	scoped_guard(mutex, &data->mutex) {
> +		ret = regmap_read(data->regmap, BMI270_INT_STATUS_0_REG,
> +				  &status0);
> +		if (ret)
> +			return IRQ_NONE;
> +
>  		ret = regmap_read(data->regmap, BMI270_INT_STATUS_1_REG,
> -				  &status);
> +				  &status1);
>  		if (ret)
>  			return IRQ_NONE;
>  	}
>  
> -	if (FIELD_GET(BMI270_INT_STATUS_1_ACC_GYR_DRDY_MSK, status))
> +	if (FIELD_GET(BMI270_INT_STATUS_1_ACC_GYR_DRDY_MSK, status1))
>  		iio_trigger_poll_nested(data->trig);
>  
> +	if (FIELD_GET(BMI270_INT_STATUS_0_STEP_CNT_MSK, status0))
> +		iio_push_event(indio_dev, IIO_MOD_EVENT_CODE(IIO_STEPS, 0,
> +							     IIO_NO_MOD,
why use IIO_MOD_EVENT_CODE() if not modified?

> +							     IIO_EV_TYPE_CHANGE,
> +							     IIO_EV_DIR_NONE),
As below. This looks like a rising threshold event.

Change tends to be for things like activity detection (walking/standing etc)
 
> +			       timestamp);
> +
>  	return IRQ_HANDLED;
>  }
>  
> @@ -761,10 +820,111 @@ static int bmi270_read_avail(struct iio_dev *indio_dev,
>  	}
>  }
>
> +
> +static const struct iio_event_spec bmi270_step_wtrmrk_event = {
> +	.type = IIO_EV_TYPE_CHANGE,

Change would be a per step event.
IIUC this is a rising threshold.

> +	.dir = IIO_EV_DIR_NONE,
> +	.mask_shared_by_type = BIT(IIO_EV_INFO_ENABLE) |
> +			       BIT(IIO_EV_INFO_VALUE),
> +};



