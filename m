Return-Path: <linux-iio+bounces-26854-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD3CFCAAD36
	for <lists+linux-iio@lfdr.de>; Sat, 06 Dec 2025 21:07:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D53A43021053
	for <lists+linux-iio@lfdr.de>; Sat,  6 Dec 2025 20:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6AFD2DA759;
	Sat,  6 Dec 2025 20:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UotrMWZy"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F162F2D9EC2;
	Sat,  6 Dec 2025 20:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765051652; cv=none; b=dIvtlJx4SPQ3t69TAgQLEINXyin+z1pxyISGYhh6q5bnYfd/GymcAGs3n8FW5J9ITtIj9vUZkuApBtWX/nGI6R3TmLE+jszKEJFWWz4oUt5bSlaLZT4HyO81ctpxstnCBcnKNEUMKO6+ztnVR1lT8dOHuK3wQh7Xk+EiZz8WJyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765051652; c=relaxed/simple;
	bh=ursvYjz49PBzkWIzhOqA1XLEehR0auIuYy889EGKSGg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=auMr+4bUuR83XybYwhVQhrEAb1fN5JOtYqvnyJMcmyf0tsDal23u/kiBfW3ZqFfAP57ZqOwYPD9PzidBuuO14YfgaJQ7eLKlLX6pt/wKCxoFMav+dqhxZ7/yd1DovFFuGEYMlOlD0CGcuPgdeONkKX0i7ELzRPoHFHgRgKOCU6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UotrMWZy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B07D8C4CEF5;
	Sat,  6 Dec 2025 20:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765051651;
	bh=ursvYjz49PBzkWIzhOqA1XLEehR0auIuYy889EGKSGg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UotrMWZy1jcgijGgNAG0Cn29T5FjS7liGsL/qs7te7Sad0VqXfhNKkADxqO6p4xkY
	 e5kFVZ18EfY3/y3h6lQoFBaZuERTK3CrFRz9PBMGusaBd+EwRvyK6CyC2zjWcNe4ZJ
	 7GOH5JatvxAl9PcxtLki+7V71C8IVIWe+322U2Fr5hc5v7Cy7QM48j7vx/XMMWD/Ec
	 zKgZDX9WnUdwFkLfL8GKH9LykRHrxTluxALj9sbEPJIBVB8f1eE3SF9Fnf89mWOPjv
	 YCav4pd1O5KslhvbJ6bE22VMN06ZxMnafqAMS/TsUxUxntgbBAzXx+mp1KVnuIm42+
	 Qn8cqw1fOAsbQ==
Date: Sat, 6 Dec 2025 20:07:21 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Kurt Borja <kuurtb@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Tobias Sperling
 <tobias.sperling@softing.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v6 2/2] iio: adc: Add ti-ads1018 driver
Message-ID: <20251206200721.5e683a83@jic23-huawei>
In-Reply-To: <20251204-ads1x18-v6-2-2ae4a2f8e90c@gmail.com>
References: <20251204-ads1x18-v6-0-2ae4a2f8e90c@gmail.com>
	<20251204-ads1x18-v6-2-2ae4a2f8e90c@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 04 Dec 2025 13:01:28 -0500
Kurt Borja <kuurtb@gmail.com> wrote:

> Add ti-ads1018 driver for Texas Instruments ADS1018 and ADS1118 SPI
> analog-to-digital converters.
> 
> These chips' MOSI pin is shared with a data-ready interrupt. Defining
> this interrupt in devicetree is optional, therefore we only create an
> IIO trigger if one is found.
> 
> Handling this interrupt requires some considerations. When enabling the
> trigger the CS line is tied low (active), thus we need to hold
> spi_bus_lock() too, to avoid state corruption. This is done inside the
> set_trigger_state() callback, to let users use other triggers without
> wasting a bus lock.
> 
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
Hi Kurt

Generally in a good state.  A few minor things inline.
I didn't understand the delay calculation comments.

Jonathan


> diff --git a/drivers/iio/adc/ti-ads1018.c b/drivers/iio/adc/ti-ads1018.c
> new file mode 100644
> index 000000000000..419e789bd0eb
> --- /dev/null
> +++ b/drivers/iio/adc/ti-ads1018.c
> @@ -0,0 +1,826 @@

> +struct ads1018_chip_info {
> +	const char *name;
> +
> +	const struct iio_chan_spec *channels;
> +	unsigned long num_channels;
> +
> +	/* IIO_VAL_INT */
> +	const unsigned int *data_rate_mode_to_hz;
> +	unsigned long num_data_rate_mode_to_hz;
(unlike pga mode this one is fine as there are variable numbers
 of these)
> +
> +	/* IIO_VAL_INT_PLUS_NANO */
> +	const unsigned int (*pga_mode_to_gain)[2];
> +	unsigned long num_pga_mode_to_gain;

Maybe this is a case of premature addition of flexibility given
this is always 6 so far and you could just embed the data in here
rather than access via a pointer.

> +
> +	/* IIO_VAL_INT_PLUS_MICRO */
> +	const int temp_scale[2];
> +};


> +#define ADS1018_VOLT_CHAN(_index, _chan, _realbits) {				\
> +	.type = IIO_VOLTAGE,							\
> +	.channel = _chan,							\
> +	.scan_index = _index,							\
> +	.scan_type = {								\
> +		.sign = 's',							\
> +		.realbits = _realbits,						\
> +		.storagebits = 16,						\
> +		.shift = 16 - _realbits,					\
> +		.endianness = IIO_BE,						\
> +	},									\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |				\
> +			      BIT(IIO_CHAN_INFO_SCALE) |			\
> +			      BIT(IIO_CHAN_INFO_SAMP_FREQ),			\

What motivates per channel sampling frequency?

Given you have to write it each time you configure I guess it doesn't matter much
either way.

> +	.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_SCALE),		\
> +	.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
> +	.indexed = true,							\
> +}

> +/**
> + * ads1018_get_data_rate_mode - Get current data-rate mode for a channel.
> + * @ads1018: Device data
> + * @address: Channel address
> + *
> + * Context: Expects iio_device_claim_direct() is held.
> + *
> + * Return: Current data-rate mode for the channel at @address.
> + */
> +static u8 ads1018_get_data_rate_mode(struct ads1018 *ads1018, unsigned int address)
> +{
> +	return ads1018->chan_data[address].data_rate_mode;
> +}
> +
> +/**
> + * ads1018_get_pga_mode - Get current PGA mode for a channel.
> + * @ads1018: Device data
> + * @address: Channel address
> + *
> + * Context: Expects iio_device_claim_direct() is held.
> + *
> + * Return: Current PGA mode for the channel at @address.
> + */
> +static u8 ads1018_get_pga_mode(struct ads1018 *ads1018, unsigned int address)
> +{
> +	return ads1018->chan_data[address].pga_mode;
> +}
> +
> +/**
> + * ads1018_set_data_rate_mode - Set a data-rate mode for a channel.
> + * @ads1018: Device data
> + * @address: Channel address
> + * @val: New data-rate mode for channel at @address.
> + *
> + * Context: Expects iio_device_claim_direct() is held.
> + *
> + * Lazily set a new data-rate mode for a channel.

I'm not sure these tiny access helpers add anything much. Maybe
just get/set the value directly inline?  The field name in the
structure makes it fairly clear what is going on.

> + */
> +static void ads1018_set_data_rate_mode(struct ads1018 *ads1018,
> +				       unsigned int address, u8 val)
> +{
> +	ads1018->chan_data[address].data_rate_mode = val;
> +}
> +
> +/**
> + * ads1018_set_pga_mode - Set a PGA mode for a channel.
> + * @ads1018: Device data
> + * @address: Channel address
> + * @val: New PGA mode for channel at @address.
> + *
> + * Context: Expects iio_device_claim_direct() is held.
> + *
> + * Lazily set a new PGA mode for a channel.
> + */
> +static void ads1018_set_pga_mode(struct ads1018 *ads1018,
> +				 unsigned int address, u8 val)
> +{
> +	ads1018->chan_data[address].pga_mode = val;
> +}
> +
> +/**
> + * ads1018_calc_delay - Calculates a suitable delay for a single-shot reading
> + * @ads1018: Device data
> + *
> + * Calculates an appropriate delay for a single shot reading, assuming the
> + * device's maximum data-rate is used.
> + *
> + * Context: Expects iio_device_claim_direct() is held.

What in here changes if we are in buffered mode?
We have no reason to call it but why does that matter?

> + *
> + * Return: Delay in microseconds (Always greater than 0).
> + */
> +static u32 ads1018_calc_delay(struct ads1018 *ads1018)
> +{
> +	const struct ads1018_chip_info *chip_info = ads1018->chip_info;
> +	unsigned long max_drate_mode = chip_info->num_data_rate_mode_to_hz - 1;
> +	unsigned int hz = chip_info->data_rate_mode_to_hz[max_drate_mode];
> +
> +	/*
> +	 * Calculate the worst-case sampling rate on the maximum data-rate
> +	 * mode by subtracting 10% error specified in the datasheet.
> +	 */
> +	hz -= DIV_ROUND_UP(hz, 10);
> +
> +	/*
> +	 * Then calculate time per sample in microseconds.
> +	 */

Single line comment syntax appropriate here.

> +	return DIV_ROUND_UP(MICROHZ_PER_HZ, hz);
> +}

> +/**
> + * ads1018_single_shot - Performs a one-shot reading sequence
> + * @ads1018: Device data
> + * @cfg: New configuration for the device
> + * @cnv: Conversion value
> + *
> + * Writes a new configuration, waits an appropriate delay (assuming the new
> + * configuration uses the maximum data-rate) and then reads the most recent

I'm lost on this.  Normally the longest delay is governed by the minimum data rate.
I.e. Samples take longer when running few per second, so we wait longer.

I think this is meant to mean the delay needed for a sample at the minimum expected
rate for this configuration.

> + * conversion.
> + *
> + * Context: Expects iio_device_claim_direct() is held.
> + *
> + * Return: 0 on success, negative errno on error.
> + */
> +static int ads1018_single_shot(struct ads1018 *ads1018, u16 cfg, u16 *cnv)
> +{
> +	struct spi_transfer xfer[2] = {
> +		{
> +			.tx_buf = ads1018->tx_buf,
> +			.len = sizeof(ads1018->tx_buf[0]),
> +			.delay = {
> +				.value = ads1018_calc_delay(ads1018),
> +				.unit = SPI_DELAY_UNIT_USECS,
> +			},
> +			.cs_change = 1, /* 16-bit mode requires CS de-assert */
> +		},
> +		{
> +			.rx_buf = ads1018->rx_buf,
> +			.len = sizeof(ads1018->rx_buf[0]),
> +		},
> +	};
> +	int ret;
> +
> +	ads1018->tx_buf[0] = cpu_to_be16(cfg);
> +
> +	ret = spi_sync_transfer(ads1018->spi, xfer, ARRAY_SIZE(xfer));
> +	if (ret)
> +		return ret;
> +
> +	*cnv = be16_to_cpu(ads1018->rx_buf[0]);
> +
> +	return 0;
> +}
> +
> +static int
> +ads1018_read_raw_unlocked(struct iio_dev *indio_dev,

Similar comment to below.  I think unlocked is emphasising the wrong property.

> +			  struct iio_chan_spec const *chan, int *val, int *val2,
> +			  long mask)
> +{

> +static int
> +ads1018_read_raw(struct iio_dev *indio_dev, struct iio_chan_spec const *chan,
> +		 int *val, int *val2, long mask)
> +{
> +	int ret;
> +
> +	if (!iio_device_claim_direct(indio_dev))
> +		return -EBUSY;
> +	ret = ads1018_read_raw_unlocked(indio_dev, chan, val, val2, mask);
> +	iio_device_release_direct(indio_dev);
> +
> +	return ret;
> +}

> +
> +static int
> +ads1018_write_raw_unlocked(struct iio_dev *indio_dev,

Similar to the naming discussion on the ACQUIRE RFC I'm not sure
using locked here is really descriptive of more than an internal
detail of how we prevent mode switching. I'd prefer something like
ads1018_write_raw_direct_claimed() or ads1018_write_raw_direct_mode()
(the absence of any other write_raw_*** would indicate this is the only
valid one perhaps).

Also this isn't the unlocked version, it's the one that doesn't take
the lock.


> +			   struct iio_chan_spec const *chan, int val, int val2,
> +			   long mask)
> +{
...

> +
> +static int
> +ads1018_write_raw(struct iio_dev *indio_dev, struct iio_chan_spec const *chan,
> +		  int val, int val2, long mask)
> +{
> +	int ret;
> +
> +	if (!iio_device_claim_direct(indio_dev))
> +		return -EBUSY;
> +	ret = ads1018_write_raw_unlocked(indio_dev, chan, val, val2, mask);
> +	iio_device_release_direct(indio_dev);
> +
> +	return ret;
> +}

