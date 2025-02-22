Return-Path: <linux-iio+bounces-15959-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B81FBA409D2
	for <lists+linux-iio@lfdr.de>; Sat, 22 Feb 2025 17:15:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81C86188D75F
	for <lists+linux-iio@lfdr.de>; Sat, 22 Feb 2025 16:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB8C51CEEBB;
	Sat, 22 Feb 2025 16:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eUaEQtPb"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E41778F2F;
	Sat, 22 Feb 2025 16:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740240853; cv=none; b=RY7aFDkuXoA9CnQQ1HEhd0OhR+VADoNuKT9lt78rvyyMtNgWApgDpaPVYrHAu8/H55Ni2bCen3dTFm9VoqfGwGp5gDxSfdTqhJ4Ej16tWoLrVrw1X29S+0HGeeWkQu/mOQzFbrYVU1fHG/428+z3IjUGcS2/3L28W4K9PTGOl6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740240853; c=relaxed/simple;
	bh=2PUB3dGoHzHfpA9fcxe5STpk3/cimK4V30cI/TaJ8L8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XgFR7/iBBEXyz1W4kwSUTrmvTaMnjjWbo1B/t86FpjDXjECiFeRYjiVQRIJfu33dTvQs4lMmRDRIWodt46d7DiBKMMDy4VIW8Z1WsKnrubpx/Rhl22u4HXGrQ5D3cVl4MWw8omsYDec4cx4PTdr4OdNdd8mkgCaecuiJUl3Ea3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eUaEQtPb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06B15C4CEE4;
	Sat, 22 Feb 2025 16:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740240852;
	bh=2PUB3dGoHzHfpA9fcxe5STpk3/cimK4V30cI/TaJ8L8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eUaEQtPbI98t3+pLIDby9HlTjoPy36wWs6J1Dj/8CuF7lWKgbc3XXNfylYyl4h5Zx
	 ArtG89hS2zPHZO6/WsU844XTnfAK89L2cMobdkC6mmaKZdSKY8Ym2ver7Tm5JkZXs0
	 VOsThmxGsrQ+y9qgKrgO1JeRfYXMFzMs/pGE97ME2HoU6ZtTtJg0l6g6BFNuGsjrV3
	 mNP65qcErdHgkirN167J2EnWVCOuvFBis4FPdZmrC/r+fD29GApAZllfA0Ycg7pLM6
	 R2sXHVLhZrc9r+4hPEhRT0npw9yaomRKe3OG9+aOteaENvQsJGkdV1YFBtfZKdnzVt
	 ++45tSecnhzWg==
Date: Sat, 22 Feb 2025 16:14:06 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jean-Baptiste Maneyrol via B4 Relay
 <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org>
Cc: jean-baptiste.maneyrol@tdk.com, Lars-Peter Clausen <lars@metafoo.de>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: imu: inv_icm42600: add WoM support
Message-ID: <20250222161406.54b2d348@jic23-huawei>
In-Reply-To: <20250220-losd-3-inv-icm42600-add-wom-support-v1-1-9b937f986954@tdk.com>
References: <20250220-losd-3-inv-icm42600-add-wom-support-v1-0-9b937f986954@tdk.com>
	<20250220-losd-3-inv-icm42600-add-wom-support-v1-1-9b937f986954@tdk.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Feb 2025 21:52:06 +0100
Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org> wrote:

> From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> 
> Add WoM as accel roc rising x|y|z event.
> 
> Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Some comments on unrelated bug (that this duplicates) inline.

Jonathan

> ---
>  drivers/iio/imu/inv_icm42600/inv_icm42600.h        |  47 +++-
>  drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c  | 264 ++++++++++++++++++++-
>  drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c |   2 +-
>  drivers/iio/imu/inv_icm42600/inv_icm42600_core.c   |  56 ++++-
>  4 files changed, 363 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600.h b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
> index 18787a43477b89db12caee597ab040af5c8f52d5..8dfbeaf1c768d7d25cb58ecf9804446f3cbbd465 100644
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600.h
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
> @@ -135,6 +135,14 @@ struct inv_icm42600_suspended {
>  	bool temp;
>  };
>  
> +struct inv_icm42600_apex {
> +	unsigned int on;
> +	struct {
> +		bool enable;
> +		uint64_t value;
> +	} wom;
> +};
> +
>  /**
>   *  struct inv_icm42600_state - driver state variables
>   *  @lock:		lock for serializing multiple registers access.
> @@ -151,6 +159,7 @@ struct inv_icm42600_suspended {
>   *  @buffer:		data transfer buffer aligned for DMA.
>   *  @fifo:		FIFO management structure.
>   *  @timestamp:		interrupt timestamps.
> + *  @apex:		APEX features management.
>   */
>  struct inv_icm42600_state {
>  	struct mutex lock;
> @@ -164,12 +173,13 @@ struct inv_icm42600_state {
>  	struct inv_icm42600_suspended suspended;
>  	struct iio_dev *indio_gyro;
>  	struct iio_dev *indio_accel;
> -	uint8_t buffer[2] __aligned(IIO_DMA_MINALIGN);
> +	uint8_t buffer[3] __aligned(IIO_DMA_MINALIGN);
>  	struct inv_icm42600_fifo fifo;
This being after buffer also looks like a problem (see below)
This needs fixing.  Just  move it before buffer in a separate patch
and all should be fine.
>  	struct {
>  		int64_t gyro;
>  		int64_t accel;
>  	} timestamp;
Maybe this as well.
> +	struct inv_icm42600_apex apex;

That seems unwise. It's in the region that DMA transactions may
scribble all over.  Move this before buffer or you'll get some
weird and wonderful bug reports sometime in the future!

>  };
>  
>  
> @@ -253,6 +263,18 @@ struct inv_icm42600_sensor_state {
>  #define INV_ICM42600_REG_FIFO_COUNT			0x002E
>  #define INV_ICM42600_REG_FIFO_DATA			0x0030
>  
> +#define INV_ICM42600_REG_INT_STATUS2			0x0037
> +#define INV_ICM42600_INT_STATUS2_SMD_INT		BIT(3)
> +#define INV_ICM42600_INT_STATUS2_WOM_INT		GENMASK(2, 0)
> +
> +#define INV_ICM42600_REG_INT_STATUS3			0x0038
> +#define INV_ICM42600_INT_STATUS3_STEP_DET_INT		BIT(5)
> +#define INV_ICM42600_INT_STATUS3_STEP_CNT_OVF_INT	BIT(4)
> +#define INV_ICM42600_INT_STATUS3_TILT_DET_INT		BIT(3)
> +#define INV_ICM42600_INT_STATUS3_WAKE_INT		BIT(2)
> +#define INV_ICM42600_INT_STATUS3_SLEEP_INT		BIT(1)
> +#define INV_ICM42600_INT_STATUS3_TAP_DET_INT		BIT(0)
> +
>  #define INV_ICM42600_REG_SIGNAL_PATH_RESET		0x004B
>  #define INV_ICM42600_SIGNAL_PATH_RESET_DMP_INIT_EN	BIT(6)
>  #define INV_ICM42600_SIGNAL_PATH_RESET_DMP_MEM_RESET	BIT(5)
> @@ -309,6 +331,14 @@ struct inv_icm42600_sensor_state {
>  #define INV_ICM42600_TMST_CONFIG_TMST_FSYNC_EN		BIT(1)
>  #define INV_ICM42600_TMST_CONFIG_TMST_EN		BIT(0)
>  
> +#define INV_ICM42600_REG_SMD_CONFIG			0x0057
> +#define INV_ICM42600_SMD_CONFIG_WOM_INT_MODE		BIT(3)
> +#define INV_ICM42600_SMD_CONFIG_WOM_MODE		BIT(2)
> +#define INV_ICM42600_SMD_CONFIG_SMD_MODE_OFF		0x00
> +#define INV_ICM42600_SMD_CONFIG_SMD_MODE_WOM		0x01
> +#define INV_ICM42600_SMD_CONFIG_SMD_MODE_SHORT		0x02
> +#define INV_ICM42600_SMD_CONFIG_SMD_MODE_LONG		0x03
> +
>  #define INV_ICM42600_REG_FIFO_CONFIG1			0x005F
>  #define INV_ICM42600_FIFO_CONFIG1_RESUME_PARTIAL_RD	BIT(6)
>  #define INV_ICM42600_FIFO_CONFIG1_WM_GT_TH		BIT(5)
> @@ -338,6 +368,11 @@ struct inv_icm42600_sensor_state {
>  #define INV_ICM42600_INT_SOURCE0_FIFO_FULL_INT1_EN	BIT(1)
>  #define INV_ICM42600_INT_SOURCE0_UI_AGC_RDY_INT1_EN	BIT(0)
>  
> +#define INV_ICM42600_REG_INT_SOURCE1			0x0066
> +#define INV_ICM42600_INT_SOURCE1_I3C_ERROR_INT1_EN	BIT(6)
> +#define INV_ICM42600_INT_SOURCE1_SMD_INT1_EN		BIT(3)
> +#define INV_ICM42600_INT_SOURCE1_WOM_INT1_EN		GENMASK(2, 0)
> +
>  #define INV_ICM42600_REG_WHOAMI				0x0075
>  #define INV_ICM42600_WHOAMI_ICM42600			0x40
>  #define INV_ICM42600_WHOAMI_ICM42602			0x41
> @@ -373,6 +408,10 @@ struct inv_icm42600_sensor_state {
>  #define INV_ICM42600_INTF_CONFIG6_I3C_SDR_EN		BIT(0)
>  
>  /* User bank 4 (MSB 0x40) */
> +#define INV_ICM42600_REG_ACCEL_WOM_X_THR		0x404A
> +#define INV_ICM42600_REG_ACCEL_WOM_Y_THR		0x404B
> +#define INV_ICM42600_REG_ACCEL_WOM_Z_THR		0x404C
> +
>  #define INV_ICM42600_REG_INT_SOURCE8			0x404F
>  #define INV_ICM42600_INT_SOURCE8_FSYNC_IBI_EN		BIT(5)
>  #define INV_ICM42600_INT_SOURCE8_PLL_RDY_IBI_EN		BIT(4)
> @@ -423,6 +462,8 @@ int inv_icm42600_set_gyro_conf(struct inv_icm42600_state *st,
>  int inv_icm42600_set_temp_conf(struct inv_icm42600_state *st, bool enable,
>  			       unsigned int *sleep_ms);
>  
> +int inv_icm42600_set_wom(struct inv_icm42600_state *st, bool enable);
> +
>  int inv_icm42600_debugfs_reg(struct iio_dev *indio_dev, unsigned int reg,
>  			     unsigned int writeval, unsigned int *readval);
>  
> @@ -437,4 +478,8 @@ struct iio_dev *inv_icm42600_accel_init(struct inv_icm42600_state *st);
>  
>  int inv_icm42600_accel_parse_fifo(struct iio_dev *indio_dev);
>  
> +void inv_icm42600_accel_handle_events(struct iio_dev *indio_dev,
> +				      unsigned int status2, unsigned int status3,
> +				      int64_t timestamp);
> +
>  #endif
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
> index 388520ec60b5c5d21b16717978ebf330e38aa1fe..8ce2276b3edc61cc1ea26810198dd0057054ec48 100644
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c


> +
> +static int inv_icm42600_accel_enable_wom(struct iio_dev *indio_dev, bool enable)
> +{
> +	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
> +	struct inv_icm42600_sensor_state *accel_st = iio_priv(indio_dev);
> +	struct device *pdev = regmap_get_device(st->map);
> +	struct inv_icm42600_sensor_conf conf = INV_ICM42600_SENSOR_CONF_INIT;
> +	unsigned int sleep_ms = 0;
> +	int ret;
> +
> +	if (enable) {

Not a lot of shared logic. Maybe split into enable and siable functions.

> +		ret = pm_runtime_resume_and_get(pdev);
> +		if (ret)
> +			return ret;
> +		scoped_guard(mutex, &st->lock) {
> +			/* turn on accel sensor */
> +			conf.mode = accel_st->power_mode;
> +			conf.filter = accel_st->filter;
> +			ret = inv_icm42600_set_accel_conf(st, &conf, &sleep_ms);
> +			if (ret)
> +				goto error_suspend;
> +		}
> +		if (sleep_ms)
> +			msleep(sleep_ms);
> +		scoped_guard(mutex, &st->lock) {
> +			ret = inv_icm42600_set_wom(st, true);
> +			if (ret)
> +				goto error_suspend;
> +			st->apex.on++;
> +			st->apex.wom.enable = true;
> +		}
	return 0;

> +	} else {
> +		scoped_guard(mutex, &st->lock) {
> +			st->apex.wom.enable = false;
> +			st->apex.on--;
> +			ret = inv_icm42600_set_wom(st, false);
> +			if (ret)
> +				goto error_suspend;
> +			/* turn off accel sensor if not used */
> +			if (!st->apex.on && !iio_buffer_enabled(indio_dev)) {
> +				conf.mode = INV_ICM42600_SENSOR_MODE_OFF;
> +				ret = inv_icm42600_set_accel_conf(st, &conf, &sleep_ms);
> +				if (ret)
> +					goto error_suspend;
> +			}
> +		}
> +		if (sleep_ms)
> +			msleep(sleep_ms);

With return above, you could share this with the error handling.

> +		pm_runtime_mark_last_busy(pdev);
> +		pm_runtime_put_autosuspend(pdev);
> +	}
> +
> +	return 0;
> +
> +error_suspend:
> +	pm_runtime_mark_last_busy(pdev);
> +	pm_runtime_put_autosuspend(pdev);
> +	return ret;
> +}

> +static int inv_icm42600_accel_read_event_value(struct iio_dev *indio_dev,
> +					       const struct iio_chan_spec *chan,
> +					       enum iio_event_type type,
> +					       enum iio_event_direction dir,
> +					       enum iio_event_info info,
> +					       int *val, int *val2)
> +{
> +	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
> +	u32 rem;
> +
> +	guard(mutex)(&st->lock);
> +
> +	/* handle WoM (roc rising) event value */
> +	if (type == IIO_EV_TYPE_ROC && dir == IIO_EV_DIR_RISING) {

Similar to below. Consider flipping logic.

> +		/* return value in micro */
> +		*val = div_u64_rem(st->apex.wom.value, 1000000U, &rem);
> +		*val2 = rem;
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int inv_icm42600_accel_write_event_value(struct iio_dev *indio_dev,
> +						const struct iio_chan_spec *chan,
> +						enum iio_event_type type,
> +						enum iio_event_direction dir,
> +						enum iio_event_info info,
> +						int val, int val2)
> +{
> +	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
> +	struct device *dev = regmap_get_device(st->map);
> +	uint64_t value;
> +	unsigned int accel_hz, accel_uhz;
> +	int ret;
> +
> +	/* handle WoM (roc rising) event value */
> +	if (type == IIO_EV_TYPE_ROC && dir == IIO_EV_DIR_RISING) {

If you don't plan to add other event types soon I'd be tempted to flip
the logic of this to save in indent and exit early in the error case.

> +		if (val < 0 || val2 < 0)
> +			return -EINVAL;
> +		value = (uint64_t)val * 1000000ULL + (uint64_t)val2;
> +		pm_runtime_get_sync(dev);
> +		scoped_guard(mutex, &st->lock) {
> +			ret = inv_icm42600_accel_read_odr(st, &accel_hz, &accel_uhz);
> +			if (ret >= 0)
> +				ret = inv_icm42600_accel_set_wom_threshold(st, value,
> +									   accel_hz, accel_uhz);
> +		}
> +		pm_runtime_mark_last_busy(dev);
> +		pm_runtime_put_autosuspend(dev);
> +		return ret;
> +	}
> +
> +	return -EINVAL;
> +}

> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
> index ef9875d3b79db116f9fb4f6d881a7979292c1792..c0fd2770d66f02d1965fa07f819fd2db9a1d6bd2 100644
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
> @@ -404,6 +404,35 @@ int inv_icm42600_set_temp_conf(struct inv_icm42600_state *st, bool enable,
>  					  sleep_ms);
>  }
>  
> +int inv_icm42600_set_wom(struct inv_icm42600_state *st, bool enable)
> +{
> +	unsigned int val;
> +	int ret;

Given the set and disable code paths have no shared code, maybe split into
two functions?

> +
> +	if (enable) {
> +		/* enable WoM hardware */
> +		val = INV_ICM42600_SMD_CONFIG_SMD_MODE_WOM |
> +		      INV_ICM42600_SMD_CONFIG_WOM_MODE;
> +		ret = regmap_write(st->map, INV_ICM42600_REG_SMD_CONFIG, val);
		ret = regmap_write(st->map, INV_ICM42600_REG_SMD_CONFIG,
				   INV_ICM42600_SMD_CONFIG_SMD_MODE_WOM |
				   INV_ICM42600_SMD_CONFIG_WOM_MODE);
Seems not to loose any readabilty and avoids need for local variable.


> +		if (ret)
> +			return ret;
> +		/* enable WoM interrupt */
> +		ret = regmap_set_bits(st->map, INV_ICM42600_REG_INT_SOURCE1,
> +				      INV_ICM42600_INT_SOURCE1_WOM_INT1_EN);
return regmap_write()
> +	} else {
> +		/* disable WoM interrupt */
> +		ret = regmap_clear_bits(st->map, INV_ICM42600_REG_INT_SOURCE1,
> +					INV_ICM42600_INT_SOURCE1_WOM_INT1_EN);
> +		if (ret)
> +			return ret;
> +		/* disable WoM hardware */
> +		val = INV_ICM42600_SMD_CONFIG_SMD_MODE_OFF;
> +		ret = regmap_write(st->map, INV_ICM42600_REG_SMD_CONFIG, val);
return regmap_write()
and no need for val as I don't think that adds any readability advantages here.

> +	}
> +
> +	return ret;
> +}
> +
>  int inv_icm42600_debugfs_reg(struct iio_dev *indio_dev, unsigned int reg,
>  			     unsigned int writeval, unsigned int *readval)
>  {
> @@ -543,11 +572,22 @@ static irqreturn_t inv_icm42600_irq_handler(int irq, void *_data)
>  {
>  	struct inv_icm42600_state *st = _data;
>  	struct device *dev = regmap_get_device(st->map);
> -	unsigned int status;
> +	unsigned int status, status2, status3;
>  	int ret;
>  
>  	mutex_lock(&st->lock);
>  
> +	if (st->apex.on) {

I'd drag the declaration of additional local variables in here.

> +		/* read INT_STATUS2 and INT_STATUS3 in 1 operation */
> +		ret = regmap_bulk_read(st->map, INV_ICM42600_REG_INT_STATUS2, st->buffer, 2);
> +		if (ret)
> +			goto out_unlock;
> +		status2 = st->buffer[0];
> +		status3 = st->buffer[1];
> +		inv_icm42600_accel_handle_events(st->indio_accel, status2, status3,
> +						 st->timestamp.accel);
> +	}
> +


