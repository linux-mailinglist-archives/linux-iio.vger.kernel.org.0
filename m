Return-Path: <linux-iio+bounces-22871-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF23AB2944E
	for <lists+linux-iio@lfdr.de>; Sun, 17 Aug 2025 18:53:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 579F41B24B69
	for <lists+linux-iio@lfdr.de>; Sun, 17 Aug 2025 16:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0CF22FD1AD;
	Sun, 17 Aug 2025 16:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pnlzjKmE"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673CA29BD97
	for <linux-iio@vger.kernel.org>; Sun, 17 Aug 2025 16:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755449611; cv=none; b=syQMNJUYauN2KlC9SYzwGI/ABaYpM6D/g0pKk7x6dW32Pn/kTOoGSnDJgx0OSqtAnLeSspCGa0mSyXo8dUowwZERK/q3Ysst1X1PfjcY22dYsTANj7RhkOUlvZxvfwLt2NzWwUpBSnGC/H5cMan6Xyjj0GsTXttEV8cq4mN4qCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755449611; c=relaxed/simple;
	bh=zCbOyhE5R8yyWr6EHy/8w2YsY2+yMvQ1oLPe9vR/h3M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W0g4aAqBs9o/j7GAhHp336PRebOpqA/Hp5MhA75CIgLK0rAxh0nN8xDyXSvBtMuN9XCGce0SfAiDToTrqr872bGvgtmHuLxoPSJu4VBquhiXssSaQPPPfZJeIz4WcLWz0aQWwcj13AzZo/alUS9njBwDP1l6x9TBDNUthq4u/+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pnlzjKmE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE76EC4CEEB;
	Sun, 17 Aug 2025 16:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755449611;
	bh=zCbOyhE5R8yyWr6EHy/8w2YsY2+yMvQ1oLPe9vR/h3M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pnlzjKmEUkRCSOMI3JJ7bPxbdZ7xUt3BKCIxxNqvKkOg7f3pJw9mJjym7eaOqoDum
	 svwn/O4iyrrktFooAwBWFg1JN2hauFLU59blmK0vfGL5GN8yDMNF0FXP4D53IhNePU
	 i15uGwhX1CJI3TpsDfjaWC7ThADOKg0c6neMGYgpGxyiVd+VnjATXJm5xhCGf15zUJ
	 DXXoocw8vmTvR5KoPQt23KwMaJck1YGbfREygnjCzagAaS18HWC8E3kuKU6y2mwJAS
	 abR9lECuq4NVSjVyj9hFjqEuhXWPbytMoBpMjwKC2EWACJHJfdXRXJC9Th7adwfu5D
	 DeEkMfuTfFjeg==
Date: Sun, 17 Aug 2025 17:53:24 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Achim Gratz <Achim.Gratz@Stromeko.DE>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Subject: Re: [RFC PATCH v2 7/9] iio: pressure: bmp280: implement
 sampling_frequency for BMx280
Message-ID: <20250817175324.1833d7bc@jic23-huawei>
In-Reply-To: <20250810185846.114355-8-Achim.Gratz@Stromeko.DE>
References: <20241017233022.238250-1-vassilisamir@gmail.com>
	<20250810185846.114355-1-Achim.Gratz@Stromeko.DE>
	<20250810185846.114355-8-Achim.Gratz@Stromeko.DE>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 10 Aug 2025 20:58:44 +0200
Achim Gratz <Achim.Gratz@Stromeko.DE> wrote:

Hi Achim,

> As was already commented in bm280.h:468, sampling_frequency can be
> emulated on BMx280 devices indirectly via t_standby configuration.
> Actually implement it to enable this useful feature.  This allows to
> switch between MODE_FORCED and MODE_NORMAL operation and use the same
> sysfs read implementations for both modes.
> 
> the bmp[235]_wait_conv() functions check if the sensor already
> operates in NORMAL_MODE and skips the wait for measurement complettion

completion

> unless a mode transition is required to save the overhead of
> re-setting the same mode superfluously.

When you say 'mode transition' here is this contradicting the 
"already operates in NORMAL_MODE" part above?  I suspect you just don't
need the "unless" onwards part of this.

> 
> The actual sampling frequency depends on the oversampling_ratio
> settings. In order to not complicate the code too much, the available
> sampling frequency values are fixed and have been calculated for
> oversampling_ratio=1 on all available channels assuming maximum
> measurement duration per the data sheet, corresponding to the minimum
> achievable sampling frequency for the highest measurement speed
> configuration.

Agreed it is more complicated but as the driver supports oversampling ratio
then you need to compensate the sampling frequencies for that to comply
with the expected ABI.  This is a common corner case.  Long ago we had
to decide whether to do oversampling as assumed to slow down sampling
frequency or not and given we had devices that had a separate burst
clock for oversampling alongside the triggering of a burst we went with
that way around.

> 
> THe ODR tables for the BM[35]80 devices have been extended to allow
> for MODE_FORCED operation also and the handling of the table values is
> adapted accordingly.
> 
> Report of the actual sampling frequency via sysfs is possible, but not
> yet implemented.  In preparation for that implementation the
> calculation of measurement time has previously been factored out from
> bmp280_wait_conv into bmp280_calc_meas_time_us.
> 
> Signed-off-by: Achim Gratz <Achim.Gratz@Stromeko.DE>
> 
> ---
> 
> Calculated ODR values:
> |--------+---------+---------|
> |   t_sb | min ODR | min ODR |
> |   [ms] |  BMP280 |  BME280 |
> |--------+---------+---------|
> |      0 | 155.642 | 107.527 |
> |    0.5 | 144.404 | 102.041 |
> |   62.5 |  14.509 |  13.928 |
> |  125.0 |   7.609 |   7.446 |
> |  250.0 |   3.900 |   3.857 |
> |  500.0 |   1.975 |   1.963 |
> | 1000.0 |   0.994 |   0.991 |
> | 2000.0 |   0.498 |   0.498 |
> | 4000.0 |   0.250 |   0.249 |
> |   10.0 |  60.883 |  51.813 |
> |   20.0 |  37.843 |  34.130 |
> |--------+---------+---------|
> ---
>  drivers/iio/pressure/bmp280-core.c | 165 +++++++++++++++++++++++------
>  drivers/iio/pressure/bmp280.h      |  20 ++++
>  2 files changed, 155 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
> index 0ee40b6abb44..a66b90b3ddb8 100644
> --- a/drivers/iio/pressure/bmp280-core.c
> +++ b/drivers/iio/pressure/bmp280-core.c
> @@ -64,7 +64,47 @@
>   */
>  enum { AC1, AC2, AC3, AC4, AC5, AC6, B1, B2, MB, MC, MD };
>  
> +/*
> + * Output Data Rate of 0Hz is indicating operation in MODE_FORCED,
> + * otherwise ODR = 1/(t_meas + t_stby) (rounded down to three digits)
> + *
> + * t_meas is the maximum data sheet value calculated for an
> + * oversampling ratio of 1 for all available channels of the
> + * respective device
> + */
> +enum bmp280_odr {
> +	BMP280_ODR_0HZ,
> +	BMP280_ODR_155HZ,	/* t_meas_max = 6.425ms, t_sb =  0.0ms */
> +	BMP280_ODR_144HZ,	/* t_meas_max = 6.425ms, t_sb =  0.5ms */
> +	BMP280_ODR_14_5HZ,	/* t_meas_max = 6.425ms, t_sb = 62.5ms */
> +	BMP280_ODR_7_60HZ,	/* t_meas_max = 6.425ms, t_sb =  125ms */
> +	BMP280_ODR_3_90HZ,	/* t_meas_max = 6.425ms, t_sb =  250ms */
> +	BMP280_ODR_1_97HZ,	/* t_meas_max = 6.425ms, t_sb =  500ms */
> +	BMP280_ODR_0_99HZ,	/* t_meas_max = 6.425ms, t_sb = 1000ms */
> +	BMP280_ODR_0_49HZ,	/* t_meas_max = 6.425ms, t_sb = 2000ms */
> +	BMP280_ODR_0_24HZ,	/* t_meas_max = 6.425ms, t_sb = 4000ms */
> +};
> +
> +/*
> + * BME280 redefines the meaning of the last two register settings
> + * vs. BMP280, which are now out of order with the other values but
> + * need to be in that exact position
> + */
> +enum bme280_odr {
> +	BME280_ODR_0HZ,
> +	BME280_ODR_107HZ,	/* t_meas_max = 9.300ms, t_sb =  0.5ms */
> +	BME280_ODR_102HZ,	/* t_meas_max = 9.300ms, t_sb =  0.5ms */
> +	BME280_ODR_13_9HZ,	/* t_meas_max = 9.300ms, t_sb = 62.5ms */
> +	BME280_ODR_7_44HZ,	/* t_meas_max = 9.300ms, t_sb =  125ms */
> +	BME280_ODR_3_85HZ,	/* t_meas_max = 9.300ms, t_sb =  250ms */
> +	BME280_ODR_1_96HZ,	/* t_meas_max = 9.300ms, t_sb =  500ms */
> +	BME280_ODR_0_99HZ,	/* t_meas_max = 9.300ms, t_sb = 1000ms */
> +	BME280_ODR_51_8HZ,	/* t_meas_max = 9.300ms, t_sb =   10ms */
> +	BME280_ODR_34_1HZ,	/* t_meas_max = 9.300ms, t_sb =   20ms */
> +};
> +
>  enum bmp380_odr {
> +	BMP380_ODR_0HZ,
>  	BMP380_ODR_200HZ,
>  	BMP380_ODR_100HZ,
>  	BMP380_ODR_50HZ,
> @@ -86,6 +126,7 @@ enum bmp380_odr {
>  };
>  
>  enum bmp580_odr {
> +	BMP580_ODR_0HZ,

Whilst I've accepted using 0 as the sysfs value, internally can we name it
BMP580_ODR_FORCED on ODR_ONESHOT maybe so that we can see what it is immediately
in here.  Then match that explicitly rather than checking for != 0 below.

>  	BMP580_ODR_240HZ,
>  	BMP580_ODR_218HZ,
>  	BMP580_ODR_199HZ,

>  
> -static int bmp280_write_sampling_frequency(struct bmp280_data *data,
> +static int bmp280_write_sampling_freq(struct bmp280_data *data,
>  					   int val, int val2)
>  {
>  	const int (*avail)[2] = data->chip_info->sampling_freq_avail;
> @@ -893,7 +939,7 @@ static int bmp280_write_raw_impl(struct iio_dev *indio_dev,
>  			return -EINVAL;
>  		}
>  	case IIO_CHAN_INFO_SAMP_FREQ:
> -		return bmp280_write_sampling_frequency(data, val, val2);
> +		return bmp280_write_sampling_freq(data, val, val2);
>  	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
>  		return bmp280_write_iir_filter_coeffs(data, val);
>  	default:
> @@ -971,6 +1017,32 @@ static const unsigned long bme280_avail_scan_masks[] = {
>  	0
>  };
>  
> +static const int bmp280_odr_table[][2] = {
> +	[BMP280_ODR_0HZ]	= {0,       0},
Preference in IIO is { 0, 0 },
etc

As mentioned above you'll need to have the data for
the different oversampling rates as well and pick the right
array depending on how that is set.

> +	[BMP280_ODR_155HZ]	= {155,     0},
> +	[BMP280_ODR_144HZ]	= {144,     0},
> +	[BMP280_ODR_14_5HZ]	= {14, 500000},
> +	[BMP280_ODR_7_60HZ]	= {7,  600000},
> +	[BMP280_ODR_3_90HZ]	= {3,  900000},
> +	[BMP280_ODR_1_97HZ]	= {1,  970000},
> +	[BMP280_ODR_0_99HZ]	= {0,  990000},
> +	[BMP280_ODR_0_49HZ]	= {0,  490000},
> +	[BMP280_ODR_0_24HZ]	= {0,  240000},
> +};
> +
> +static const int bme280_odr_table[][2] = {
> +	[BME280_ODR_0HZ]	= {0,       0},
> +	[BME280_ODR_107HZ]	= {107,     0},
> +	[BME280_ODR_102HZ]	= {102,     0},
> +	[BME280_ODR_13_9HZ]	= {13, 900000},
> +	[BME280_ODR_7_44HZ]	= {7,  440000},
> +	[BME280_ODR_3_85HZ]	= {3,  850000},
> +	[BME280_ODR_1_96HZ]	= {1,  960000},
> +	[BME280_ODR_0_99HZ]	= {0,  990000},
> +	[BME280_ODR_51_8HZ]	= {51, 800000},
> +	[BME280_ODR_34_1HZ]	= {34, 100000},
> +};
> +
>  static int bmp280_preinit(struct bmp280_data *data)
>  {
>  	struct device *dev = data->dev;
> @@ -1008,6 +1080,9 @@ static int bmp280_set_mode(struct bmp280_data *data, enum bmp280_op_mode mode)
>  {
>  	int ret;
>  
> +	/* Ensure a mode transition on next measurement if we take an error exit */
> +	data->op_mode = BMP280_SLEEP;
> +
>  	ret = regmap_write_bits(data->regmap, BMP280_REG_CTRL_MEAS,
>  				BMP280_MODE_MASK, bmp280_operation_mode[mode]);
>  	if (ret) {
> @@ -1051,12 +1126,15 @@ static int bmp280_wait_conv(struct bmp280_data *data)
>  	unsigned int reg, meas_time_us, initial_wait;
>  	int ret;
>  
> -	/*
> -	 * Each new measurement requires mode setting, as at the end
> -	 * of the measurement cycle the sensor enters MODE_SLEEP
> -	 * again.
> -	 */
> -	ret = data->chip_info->set_mode(data, BMP280_FORCED);
> +	/* No mode transition and already in NORMAL_MODE, skip wait */
> +	if (data->sampling_freq && data->op_mode == BMP280_NORMAL)
> +		return 0;
> +
> +	/* switch mode based on sampling_freq */
> +	data->op_mode = data->sampling_freq ? BMP280_NORMAL : BMP280_FORCED;
> +
> +	/* Mode transition or measurement in MODE_FORCED */
> +	ret = data->chip_info->set_mode(data, data->sampling_freq ? BMP280_NORMAL : BMP280_FORCED);

Use data->op_mode?  However, generally we'd set that only after success of the set_mode
call, so use a local variable for the new mode and set the data->op_mode to that once
succeeded in setting the mode.

>  	if (ret)
>  		return ret;
>  
> @@ -1078,6 +1156,7 @@ static int bmp280_wait_conv(struct bmp280_data *data)
>  				       !(reg & BMP280_REG_STATUS_MEAS_BIT),
>  				       MIN((2 * USEC_PER_MSEC), (meas_time_us >> 1)),
>  				       (2 * USEC_PER_MSEC + meas_time_us));
> +
Unrelated and not necessarily a good change.  Shouldn't be here.
>  	if (ret) {
>  		dev_err(data->dev, "failed to read status register.\n");
>  		return ret;
> @@ -1095,21 +1174,24 @@ static int bmp280_chip_config(struct bmp280_data *data)
>  {
>  	u8 osrs = FIELD_PREP(BMP280_OSRS_TEMP_MASK, data->oversampling_temp + 1) |
>  		  FIELD_PREP(BMP280_OSRS_PRESS_MASK, data->oversampling_press + 1);
> +	u8 tstby = FIELD_PREP(BMP280_TSTBY_MASK, (data->sampling_freq ?: 1) - 1);
>  	int ret;
>  
>  	ret = regmap_write_bits(data->regmap, BMP280_REG_CTRL_MEAS,
>  				BMP280_OSRS_TEMP_MASK |
>  				BMP280_OSRS_PRESS_MASK |
>  				BMP280_MODE_MASK,
> -				osrs | BMP280_MODE_SLEEP);
> +				osrs | (data->sampling_freq ? BMP280_NORMAL : BMP280_SLEEP));
> +	if (ret)
> +		return ret;
>  	if (ret) {
>  		dev_err(data->dev, "failed to write ctrl_meas register\n");
>  		return ret;
>  	}
>  
>  	ret = regmap_update_bits(data->regmap, BMP280_REG_CONFIG,
> -				 BMP280_FILTER_MASK,
> -				 data->iir_filter_coeff);
> +				 BMP280_FILTER_MASK | BMP280_TSTBY_MASK,
> +				 tstby              | BMP280_FILTER_4X);

I'd not bother with aligning like this unless it is common in this driver.
This sort of forcing tends to just lead to code churn as further changes
turn up over time and doesn't really help readability, particularly in
this order.  Maybe just put the filter setting under the filter mask
and testby under TSTBY_MASK and it will both align better and be easier to
follow.


>
> @@ -1727,12 +1817,20 @@ static int bmp380_wait_conv(struct bmp280_data *data)
>  	unsigned int reg, meas_time_us, initial_wait;
>  	int ret;
>  
> -	/*
> -	 * Each new measurement requires mode setting, as at the end
> -	 * of the measurement cycle the sensor enters MODE_SLEEP
> -	 * again.
> -	 */
> -	ret = data->chip_info->set_mode(data, BMP280_FORCED);
> +	/* nothing to wait for, read already available data */
> +	if (data->op_mode == BMP280_NORMAL)
> +		return 0;
> +
> +	/* switch mode based on sampling_freq */
> +	data->op_mode = data->sampling_freq ? BMP280_NORMAL : BMP280_FORCED;
> +
> +	/* Mode transition or measurement in MODE_FORCED */
> +	ret = data->chip_info->set_mode(data, data->sampling_freq ? BMP280_NORMAL : BMP280_FORCED);
Use data->op_mode

> +	if (ret)
> +		return ret;
> +
> +	/* is this really necessary or can we skip if op_mode is already BMP280_NORMAL? */

I'm not sure if this question is for reviewers or something you want to check out yourself.


> +	ret = data->chip_info->set_mode(data, data->op_mode);
>  	if (ret)
>  		return ret;

> @@ -3363,10 +3465,13 @@ static int bmp280_runtime_suspend(struct device *dev)
>  {
>  	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>  	struct bmp280_data *data = iio_priv(indio_dev);
> -
> -	data->chip_info->set_mode(data, BMP280_SLEEP);
> +	int ret;
>  
>  	fsleep(data->start_up_time_us);
> +	ret = data->chip_info->set_mode(data, data->sampling_freq ? BMP280_NORMAL : BMP280_SLEEP);
> +	if (ret)
> +		return ret;
> +
>  	return regulator_bulk_disable(BMP280_NUM_SUPPLIES, data->supplies);
>  }


