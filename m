Return-Path: <linux-iio+bounces-18402-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 81238A94F84
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 12:49:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 650097A3AA8
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 10:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17BA826139A;
	Mon, 21 Apr 2025 10:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qCg+XydH"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E2C6EB79;
	Mon, 21 Apr 2025 10:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745232547; cv=none; b=IKwHxYlpCWJhvmHt7T/WeCopiNEaGW2Td6B9MiOIpnVSQoNikZeXW0ql+HBHaHSXePtFEQxHoQNYiXdy+WEgmT96XCX5+sCx13/P5AV8hNg0LB21+KEGWwXEXl+EUVac+sKXoL+urfLUap+Uyc81dL84A4LEBO8RHtgj+8aiRgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745232547; c=relaxed/simple;
	bh=Vsf1C5Sz0Rt9Ggnznv6TR+Hr6QRJuvi3rx7RTg71Q1A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h/lXf4V++F0wDMIv52sEr+jRHPCRskcXY9Zl2LrVOd5nZZxlf+4nxofRa1ypjP1kDmaSljSLElAYSxRxLQwh66muZQqKruUQGb7+yWR5Si71KzWk/ovYQRhW+8HxeeXV72JLB90lY/1Z3ZmdeluBAeZsKEpfE6SbcRHfkA6MFDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qCg+XydH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9D9BC4CEE4;
	Mon, 21 Apr 2025 10:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745232547;
	bh=Vsf1C5Sz0Rt9Ggnznv6TR+Hr6QRJuvi3rx7RTg71Q1A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qCg+XydHRHs0kfi7NTDKAmAlUuMpXK8WhbpAGFD2ceeGIB/b/dLbi3HC9yMMcFaia
	 O84FKlhvWio3jwvuZpNzzgEC5eX9YCzdeJEcnVwoZ2UQkAvMqo5UJ5SLE0jXqGhVQF
	 Rp9Dv4eZmZeWB+ag8miyWNaGQIKl+7GfYtwvGK5xp1vQAdLwAWrFAtw4cSLpLIhhht
	 zZVSnb6eJjcHXShBm/1XuW0C3l9udVuTzyg/prwqqFG183/yKF/wbRiiJGapSx88VQ
	 WhTTd1ZeTf6yAPs/9kSYnZnQgPGM8Mctm6Wmx2wDZeyNNjkhUZUIZx9ITCOsUNeLjz
	 mnMzA8ILhtEXw==
Date: Mon, 21 Apr 2025 11:48:58 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jean-Baptiste Maneyrol via B4 Relay
 <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org>
Cc: jean-baptiste.maneyrol@tdk.com, Lars-Peter Clausen <lars@metafoo.de>,
 David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] iio: imu: inv_icm42600: add WoM support
Message-ID: <20250421114858.72a726c9@jic23-huawei>
In-Reply-To: <20250418-losd-3-inv-icm42600-add-wom-support-v3-1-7a180af02bfe@tdk.com>
References: <20250418-losd-3-inv-icm42600-add-wom-support-v3-0-7a180af02bfe@tdk.com>
	<20250418-losd-3-inv-icm42600-add-wom-support-v3-1-7a180af02bfe@tdk.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 18 Apr 2025 18:19:02 +0200
Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org> wrote:

> From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> 
> Add WoM as accel roc rising x|y|z event.
> 
> Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Hi Jean-Baptiste,

One thing on mixing gotos and scoped_guard().  It might be fine but we've
had weird issues with compilers and this stuff + the guidance in cleanup.h
suggests not mixing the two approaches.

Easy enough to sort out here with a helper function and I think the
end result will both avoid that issue and be easier to read.

Jonathan

> ---
>  drivers/iio/imu/inv_icm42600/inv_icm42600.h        |  54 +++-
>  drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c  | 279 ++++++++++++++++++++-
>  drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c |   2 +-
>  drivers/iio/imu/inv_icm42600/inv_icm42600_core.c   |  58 +++++
>  4 files changed, 385 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600.h b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
> index f893dbe6996506a33eb5d3be47e6765a923665c9..bcf588a048836f909c26908f0677833303a94ef9 100644
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600.h
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
> @@ -135,6 +135,14 @@ struct inv_icm42600_suspended {
>  	bool temp;
>  };
>  
> +struct inv_icm42600_apex {
> +	unsigned int on;
> +	struct {
> +		uint64_t value;
> +		bool enable;
> +	} wom;
> +};
> +
>  /**
>   *  struct inv_icm42600_state - driver state variables
>   *  @lock:		lock for serializing multiple registers access.
> @@ -148,9 +156,10 @@ struct inv_icm42600_suspended {
>   *  @suspended:		suspended sensors configuration.
>   *  @indio_gyro:	gyroscope IIO device.
>   *  @indio_accel:	accelerometer IIO device.
> - *  @buffer:		data transfer buffer aligned for DMA.
> - *  @fifo:		FIFO management structure.
>   *  @timestamp:		interrupt timestamps.
> + *  @apex:		APEX features management.

Maybe give a little more info on what APEX is somewhere?



> +static int inv_icm42600_accel_enable_wom(struct iio_dev *indio_dev)
> +{
> +	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
> +	struct inv_icm42600_sensor_state *accel_st = iio_priv(indio_dev);
> +	struct device *pdev = regmap_get_device(st->map);
> +	struct inv_icm42600_sensor_conf conf = INV_ICM42600_SENSOR_CONF_INIT;
> +	unsigned int sleep_ms = 0;
> +	int ret;
> +
> +	ret = pm_runtime_resume_and_get(pdev);
> +	if (ret)
> +		return ret;
> +
> +	scoped_guard(mutex, &st->lock) {
> +		/* turn on accel sensor */
> +		conf.mode = accel_st->power_mode;
> +		conf.filter = accel_st->filter;
> +		ret = inv_icm42600_set_accel_conf(st, &conf, &sleep_ms);
> +		if (ret)
> +			goto error_suspend;

As below.  Compilers are not great at the more complex scope vs goto stuff.
This one may be fine buf in general we avoid it.

> +	}
> +
> +	if (sleep_ms)
> +		msleep(sleep_ms);
> +
> +	scoped_guard(mutex, &st->lock) {
> +		ret = inv_icm42600_enable_wom(st);
> +		if (ret)
> +			goto error_suspend;

This doesn't follow the guidance in cleanup.h about never mixing gotos and
scoped cleanup. Two options here, either factor out everthing after the
pm handling and have
	ret = pm_runtime_resume_and_get(pdev);
	if (ret)
		return ret;

	ret = __inv_icm62600_accel_enabled_wom();
	if (ret) {
		pm_runtime_mark_last_busy(pdev);
		pm_runtime_put_autosuspend(pdev)'
		return ret;
	}

	return 0;

The rest of the cases are fine.

> +		st->apex.on++;
> +		st->apex.wom.enable = true;
> +	}
> +
> +	return 0;
> +
> +error_suspend:
> +	pm_runtime_mark_last_busy(pdev);
> +	pm_runtime_put_autosuspend(pdev);
> +	return ret;
> +}


