Return-Path: <linux-iio+bounces-4569-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4ACB8B4BED
	for <lists+linux-iio@lfdr.de>; Sun, 28 Apr 2024 15:14:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C4DA1F2153D
	for <lists+linux-iio@lfdr.de>; Sun, 28 Apr 2024 13:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5456F6CDAF;
	Sun, 28 Apr 2024 13:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SFX7goyH"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109273A1DA;
	Sun, 28 Apr 2024 13:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714310042; cv=none; b=u5pYh7/UfGuCvQsD5+Oc9kcxYLdjDDQ03IzY6yOmmdbyZvM4z0s4s6vAPN4nSbptFC2A0ZqRZGBgkhgijihvso79BhAGVvW4s2FL8klCYGDMEGdnCISU2fH28YjZ5ObWDRjYalbp4z40ox0IVvwt8B1HaxCZ604zlf+8lJ/FCx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714310042; c=relaxed/simple;
	bh=npdY6cKzQvoP4QKnpk6wGr71YeC1qQqsUawN0D7vhVo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tqOkC6tjkeAUD0jwPW1BtcP7s+M1MdNosRMm8uyvQGrSsO2YwC/3/Es2I+G8/cN9YWrXC/Eh4BiIaWPF+p/6c6FNfC28ot+ba7I7U+m0xk4FMlDOf2WFrH5Wkb8MAQ+Xs+nnYuG9LAB104oeWEDVE0kKu1cNfvC2UTsQNwiq+pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SFX7goyH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22815C113CC;
	Sun, 28 Apr 2024 13:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714310041;
	bh=npdY6cKzQvoP4QKnpk6wGr71YeC1qQqsUawN0D7vhVo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SFX7goyHuvae4UXx0pxt3rd69b2hsm6yA44Ljc4xuSec1g8DbUD4BmS9miltKo47y
	 4YtuquS+bO53Yd6qw2HkAXhvMoAwLjYx3JwnaUS9ku9eT/kfTi9o+KbPsgYpT45Gei
	 pbJAzQwzDpnbigQgyyJkgCYJOfoEngSsYdDlNOA86IfQi/4G4tdCYRF//2pXBdQHUA
	 BPZ91Ni/p3pzH2gqfEO7p+Z3LPafDgP07q0g+ME3cy7uDC3Nfk8kaCqEXuNZMADiG+
	 lny/RCYIzqF9JotY+ES6cbsYPfjEHk48+aRV/jHonCwjD8lQ0hDI6sAvxUy1UlbUg0
	 lOHLhwJReYbiw==
Date: Sun, 28 Apr 2024 14:13:49 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: inv.git-commit@tdk.com
Cc: lars@metafoo.de, linux-iio@vger.kernel.org, stable@vger.kernel.org,
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Subject: Re: [PATCH] iio: invensense: fix timestamp glitches when switching
 frequency
Message-ID: <20240428141349.116ad03c@jic23-huawei>
In-Reply-To: <20240426094835.138389-1-inv.git-commit@tdk.com>
References: <20240426094835.138389-1-inv.git-commit@tdk.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 26 Apr 2024 09:48:35 +0000
inv.git-commit@tdk.com wrote:

> From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> 
> When a sensor is running and there is a FIFO frequency change due to
> another sensor turned on/off, there are glitches on timestamp. Fix that
> by using only interrupt timestamp when there is the corresponding sensor
> data in the FIFO.
> 
> Delete FIFO period handling and simplify internal functions.
> 
> Update integration inside inv_mpu6050 and inv_icm42600 drivers.
> 
> Fixes: 0ecc363ccea7 ("iio: make invensense timestamp module generic)
> CC: stable@vger.kernel.org
> Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

Whilst I don't fully follow the logic here, the new code is simpler
and seems reasonable.  Getting my head around this will probably take
longer than it's worth :(

Hence applied to the fixes-togreg branch of iio.git.

Jonathan

> ---
>  .../inv_sensors/inv_sensors_timestamp.c       | 24 +++++++++----------
>  .../imu/inv_icm42600/inv_icm42600_buffer.c    | 20 +++++++---------
>  drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c    |  2 +-
>  .../linux/iio/common/inv_sensors_timestamp.h  |  3 +--
>  4 files changed, 21 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c b/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c
> index 3b0f9598a7c7..5f3ba77da740 100644
> --- a/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c
> +++ b/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c
> @@ -70,13 +70,13 @@ int inv_sensors_timestamp_update_odr(struct inv_sensors_timestamp *ts,
>  }
>  EXPORT_SYMBOL_NS_GPL(inv_sensors_timestamp_update_odr, IIO_INV_SENSORS_TIMESTAMP);
> 
> -static bool inv_validate_period(struct inv_sensors_timestamp *ts, uint32_t period, uint32_t mult)
> +static bool inv_validate_period(struct inv_sensors_timestamp *ts, uint32_t period)
>  {
>  	uint32_t period_min, period_max;
> 
>  	/* check that period is acceptable */
> -	period_min = ts->min_period * mult;
> -	period_max = ts->max_period * mult;
> +	period_min = ts->min_period * ts->mult;
> +	period_max = ts->max_period * ts->mult;
>  	if (period > period_min && period < period_max)
>  		return true;
>  	else
> @@ -84,15 +84,15 @@ static bool inv_validate_period(struct inv_sensors_timestamp *ts, uint32_t perio
>  }
> 
>  static bool inv_update_chip_period(struct inv_sensors_timestamp *ts,
> -				    uint32_t mult, uint32_t period)
> +				   uint32_t period)
>  {
>  	uint32_t new_chip_period;
> 
> -	if (!inv_validate_period(ts, period, mult))
> +	if (!inv_validate_period(ts, period))
>  		return false;
> 
>  	/* update chip internal period estimation */
> -	new_chip_period = period / mult;
> +	new_chip_period = period / ts->mult;
>  	inv_update_acc(&ts->chip_period, new_chip_period);
>  	ts->period = ts->mult * ts->chip_period.val;
> 
> @@ -120,16 +120,14 @@ static void inv_align_timestamp_it(struct inv_sensors_timestamp *ts)
>  }
> 
>  void inv_sensors_timestamp_interrupt(struct inv_sensors_timestamp *ts,
> -				      uint32_t fifo_period, size_t fifo_nb,
> -				      size_t sensor_nb, int64_t timestamp)
> +				     size_t sample_nb, int64_t timestamp)
>  {
>  	struct inv_sensors_timestamp_interval *it;
>  	int64_t delta, interval;
> -	const uint32_t fifo_mult = fifo_period / ts->chip.clock_period;
>  	uint32_t period;
>  	bool valid = false;
> 
> -	if (fifo_nb == 0)
> +	if (sample_nb == 0)
>  		return;
> 
>  	/* update interrupt timestamp and compute chip and sensor periods */
> @@ -139,14 +137,14 @@ void inv_sensors_timestamp_interrupt(struct inv_sensors_timestamp *ts,
>  	delta = it->up - it->lo;
>  	if (it->lo != 0) {
>  		/* compute period: delta time divided by number of samples */
> -		period = div_s64(delta, fifo_nb);
> -		valid = inv_update_chip_period(ts, fifo_mult, period);
> +		period = div_s64(delta, sample_nb);
> +		valid = inv_update_chip_period(ts, period);
>  	}
> 
>  	/* no previous data, compute theoritical value from interrupt */
>  	if (ts->timestamp == 0) {
>  		/* elapsed time: sensor period * sensor samples number */
> -		interval = (int64_t)ts->period * (int64_t)sensor_nb;
> +		interval = (int64_t)ts->period * (int64_t)sample_nb;
>  		ts->timestamp = it->up - interval;
>  		return;
>  	}
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
> index b52f328fd26c..9cde9a9337ad 100644
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
> @@ -509,20 +509,20 @@ int inv_icm42600_buffer_fifo_parse(struct inv_icm42600_state *st)
>  		return 0;
> 
>  	/* handle gyroscope timestamp and FIFO data parsing */
> -	ts = iio_priv(st->indio_gyro);
> -	inv_sensors_timestamp_interrupt(ts, st->fifo.period, st->fifo.nb.total,
> -					st->fifo.nb.gyro, st->timestamp.gyro);
>  	if (st->fifo.nb.gyro > 0) {
> +		ts = iio_priv(st->indio_gyro);
> +		inv_sensors_timestamp_interrupt(ts, st->fifo.nb.gyro,
> +						st->timestamp.gyro);
>  		ret = inv_icm42600_gyro_parse_fifo(st->indio_gyro);
>  		if (ret)
>  			return ret;
>  	}
> 
>  	/* handle accelerometer timestamp and FIFO data parsing */
> -	ts = iio_priv(st->indio_accel);
> -	inv_sensors_timestamp_interrupt(ts, st->fifo.period, st->fifo.nb.total,
> -					st->fifo.nb.accel, st->timestamp.accel);
>  	if (st->fifo.nb.accel > 0) {
> +		ts = iio_priv(st->indio_accel);
> +		inv_sensors_timestamp_interrupt(ts, st->fifo.nb.accel,
> +						st->timestamp.accel);
>  		ret = inv_icm42600_accel_parse_fifo(st->indio_accel);
>  		if (ret)
>  			return ret;
> @@ -550,9 +550,7 @@ int inv_icm42600_buffer_hwfifo_flush(struct inv_icm42600_state *st,
> 
>  	if (st->fifo.nb.gyro > 0) {
>  		ts = iio_priv(st->indio_gyro);
> -		inv_sensors_timestamp_interrupt(ts, st->fifo.period,
> -						st->fifo.nb.total, st->fifo.nb.gyro,
> -						gyro_ts);
> +		inv_sensors_timestamp_interrupt(ts, st->fifo.nb.gyro, gyro_ts);
>  		ret = inv_icm42600_gyro_parse_fifo(st->indio_gyro);
>  		if (ret)
>  			return ret;
> @@ -560,9 +558,7 @@ int inv_icm42600_buffer_hwfifo_flush(struct inv_icm42600_state *st,
> 
>  	if (st->fifo.nb.accel > 0) {
>  		ts = iio_priv(st->indio_accel);
> -		inv_sensors_timestamp_interrupt(ts, st->fifo.period,
> -						st->fifo.nb.total, st->fifo.nb.accel,
> -						accel_ts);
> +		inv_sensors_timestamp_interrupt(ts, st->fifo.nb.accel, accel_ts);
>  		ret = inv_icm42600_accel_parse_fifo(st->indio_accel);
>  		if (ret)
>  			return ret;
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> index 86465226f7e1..0dc0f22a5582 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> @@ -100,7 +100,7 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
>  		goto end_session;
>  	/* Each FIFO data contains all sensors, so same number for FIFO and sensor data */
>  	fifo_period = NSEC_PER_SEC / INV_MPU6050_DIVIDER_TO_FIFO_RATE(st->chip_config.divider);
> -	inv_sensors_timestamp_interrupt(&st->timestamp, fifo_period, nb, nb, pf->timestamp);
> +	inv_sensors_timestamp_interrupt(&st->timestamp, nb, pf->timestamp);
>  	inv_sensors_timestamp_apply_odr(&st->timestamp, fifo_period, nb, 0);
> 
>  	/* clear internal data buffer for avoiding kernel data leak */
> diff --git a/include/linux/iio/common/inv_sensors_timestamp.h b/include/linux/iio/common/inv_sensors_timestamp.h
> index a47d304d1ba7..8d506f1e9df2 100644
> --- a/include/linux/iio/common/inv_sensors_timestamp.h
> +++ b/include/linux/iio/common/inv_sensors_timestamp.h
> @@ -71,8 +71,7 @@ int inv_sensors_timestamp_update_odr(struct inv_sensors_timestamp *ts,
>  				     uint32_t period, bool fifo);
> 
>  void inv_sensors_timestamp_interrupt(struct inv_sensors_timestamp *ts,
> -				     uint32_t fifo_period, size_t fifo_nb,
> -				     size_t sensor_nb, int64_t timestamp);
> +				     size_t sample_nb, int64_t timestamp);
> 
>  static inline int64_t inv_sensors_timestamp_pop(struct inv_sensors_timestamp *ts)
>  {
> --
> 2.34.1
> 


