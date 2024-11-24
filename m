Return-Path: <linux-iio+bounces-12569-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B329A9D6F99
	for <lists+linux-iio@lfdr.de>; Sun, 24 Nov 2024 14:14:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE173161D97
	for <lists+linux-iio@lfdr.de>; Sun, 24 Nov 2024 13:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 172CC1ABEC7;
	Sun, 24 Nov 2024 12:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pa688dDh"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7BDF1F667F;
	Sun, 24 Nov 2024 12:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732452734; cv=none; b=PqfVo9ypGxbWicwb/e+pQWH3NtY9/mRA9UCRGgWIsTH0HJpGxrgeNHFFXi/q07r9GobWGiJ5QKaT3a3aVH9jX2iz61EE4kGs2e08Ndwd5+f/VPk9vgm7zfOzsY22n25LE0B7eHM2ndIpMYEYuekZVME10Rvu7Nsm3GenJcelIxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732452734; c=relaxed/simple;
	bh=ZLItKeFVpAfe6+B3dnl0rc2rin68FgFRSXSioc5OKj8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aZAdSz+h6jZ2EX9JvQV65TvvKdI5mLq0D71wkrHL9NKL1s/bxsOkhDCvT4clmGVlX1mGSqfIhUUlwtvlWHUhwIuEINkYzL7wg/ktXhnFlvAsFGANfQfa+Phm+qFNauGuNDKAvBzrh6eN1Vd8Mjf9LeFzPjnN7XPCWS17kcw/wn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pa688dDh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47F54C4CED6;
	Sun, 24 Nov 2024 12:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732452734;
	bh=ZLItKeFVpAfe6+B3dnl0rc2rin68FgFRSXSioc5OKj8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pa688dDhzOGrLy4O5R+AippHWZK711zs+jdJlYfzDhJ1rACyvE6BUZSAUES6xUoFK
	 0pRkTR91nPRjDAShcmXKYbYDS4xtRqp8zL0roTT41W7jE7TydhXAel0IAkVg8XqBoS
	 6xBPlA3lh8DAp/gAqI+uIJiXEls5WAxIsmtUxPI4BJT56qubLuQa93CzExXoCFfFME
	 TUSA1DxXX4CpdSIcs8NmYyehWvLeLq249HaxoaFftCFc/Jy1pN5eTRMk5oxQ8VMg2q
	 uwval16uzXOD8VXOhR5iyyN8bOb7ZbFUY2khc1OpPPJr/ADc0qghVGkkJzvXPU2eBG
	 BoVL2J1Vy4QXA==
Date: Sun, 24 Nov 2024 12:52:06 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Trevor Gamblin <tgamblin@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 David Lechner <dlechner@baylibre.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] iio: adc: ad4695: fix buffered read, single
 sample timings
Message-ID: <20241124125206.1ffd6e6c@jic23-huawei>
In-Reply-To: <20241113-tgamblin-ad4695_improvements-v2-1-b6bb7c758fc4@baylibre.com>
References: <20241113-tgamblin-ad4695_improvements-v2-0-b6bb7c758fc4@baylibre.com>
	<20241113-tgamblin-ad4695_improvements-v2-1-b6bb7c758fc4@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Nov 2024 15:52:58 -0500
Trevor Gamblin <tgamblin@baylibre.com> wrote:

> Modify ad4695_buffer_preenable() by adding an extra SPI transfer after
> each data read to help ensure that the timing requirement between the
> last SCLK rising edge and the next CNV rising edge is met. This requires
> a restructure of the buf_read_xfer array in ad4695_state. Also define
> AD4695_T_SCK_CNV_DELAY_NS to use for each added transfer. Without this
> change it is possible for the data to become corrupted on sequential
> buffered reads due to the device not properly exiting conversion mode.
> 
> Similarly, make adjustments to ad4695_read_one_sample() so that timings
> are respected, and clean up the function slightly in the process.
> 
> Fixes: 6cc7e4bf2e08 ("iio: adc: ad4695: implement triggered buffer")
> Co-developed-by: David Lechner <dlechner@baylibre.com>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
> ---
Applied to the fixes-togreg branch of iio.git. I'll rebase that
and send out a pull shortly after rc1.

The other two will have to wait for that to cycle around to be
in the upstream for my togreg branch later in the cycle.

Thanks,

Jonathan

>  drivers/iio/adc/ad4695.c | 100 ++++++++++++++++++++++++++++++++---------------
>  1 file changed, 69 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad4695.c b/drivers/iio/adc/ad4695.c
> index 595ec4158e73..0146aed9069f 100644
> --- a/drivers/iio/adc/ad4695.c
> +++ b/drivers/iio/adc/ad4695.c
> @@ -91,6 +91,7 @@
>  #define AD4695_T_WAKEUP_SW_MS		3
>  #define AD4695_T_REFBUF_MS		100
>  #define AD4695_T_REGCONFIG_NS		20
> +#define AD4695_T_SCK_CNV_DELAY_NS	80
>  #define AD4695_REG_ACCESS_SCLK_HZ	(10 * MEGA)
>  
>  /* Max number of voltage input channels. */
> @@ -132,8 +133,13 @@ struct ad4695_state {
>  	unsigned int vref_mv;
>  	/* Common mode input pin voltage. */
>  	unsigned int com_mv;
> -	/* 1 per voltage and temperature chan plus 1 xfer to trigger 1st CNV */
> -	struct spi_transfer buf_read_xfer[AD4695_MAX_CHANNELS + 2];
> +	/*
> +	 * 2 per voltage and temperature chan plus 1 xfer to trigger 1st
> +	 * CNV. Excluding the trigger xfer, every 2nd xfer only serves
> +	 * to control CS and add a delay between the last SCLK and next
> +	 * CNV rising edges.
> +	 */
> +	struct spi_transfer buf_read_xfer[AD4695_MAX_CHANNELS * 2 + 3];
>  	struct spi_message buf_read_msg;
>  	/* Raw conversion data received. */
>  	u8 buf[ALIGN((AD4695_MAX_CHANNELS + 2) * AD4695_MAX_CHANNEL_SIZE,
> @@ -423,7 +429,7 @@ static int ad4695_buffer_preenable(struct iio_dev *indio_dev)
>  	u8 temp_chan_bit = st->chip_info->num_voltage_inputs;
>  	u32 bit, num_xfer, num_slots;
>  	u32 temp_en = 0;
> -	int ret;
> +	int ret, rx_buf_offset = 0;
>  
>  	/*
>  	 * We are using the advanced sequencer since it is the only way to read
> @@ -449,11 +455,9 @@ static int ad4695_buffer_preenable(struct iio_dev *indio_dev)
>  	iio_for_each_active_channel(indio_dev, bit) {
>  		xfer = &st->buf_read_xfer[num_xfer];
>  		xfer->bits_per_word = 16;
> -		xfer->rx_buf = &st->buf[(num_xfer - 1) * 2];
> +		xfer->rx_buf = &st->buf[rx_buf_offset];
>  		xfer->len = 2;
> -		xfer->cs_change = 1;
> -		xfer->cs_change_delay.value = AD4695_T_CONVERT_NS;
> -		xfer->cs_change_delay.unit = SPI_DELAY_UNIT_NSECS;
> +		rx_buf_offset += xfer->len;
>  
>  		if (bit == temp_chan_bit) {
>  			temp_en = 1;
> @@ -468,21 +472,44 @@ static int ad4695_buffer_preenable(struct iio_dev *indio_dev)
>  		}
>  
>  		num_xfer++;
> +
> +		/*
> +		 * We need to add a blank xfer in data reads, to meet the timing
> +		 * requirement of a minimum delay between the last SCLK rising
> +		 * edge and the CS deassert.
> +		 */
> +		xfer = &st->buf_read_xfer[num_xfer];
> +		xfer->delay.value = AD4695_T_SCK_CNV_DELAY_NS;
> +		xfer->delay.unit = SPI_DELAY_UNIT_NSECS;
> +		xfer->cs_change = 1;
> +		xfer->cs_change_delay.value = AD4695_T_CONVERT_NS;
> +		xfer->cs_change_delay.unit = SPI_DELAY_UNIT_NSECS;
> +
> +		num_xfer++;
>  	}
>  
>  	/*
>  	 * The advanced sequencer requires that at least 2 slots are enabled.
>  	 * Since slot 0 is always used for other purposes, we need only 1
> -	 * enabled voltage channel to meet this requirement. If the temperature
> -	 * channel is the only enabled channel, we need to add one more slot
> -	 * in the sequence but not read from it.
> +	 * enabled voltage channel to meet this requirement.  If the temperature
> +	 * channel is the only enabled channel, we need to add one more slot in
> +	 * the sequence but not read from it. This is because the temperature
> +	 * sensor is sampled at the end of the channel sequence in advanced
> +	 * sequencer mode (see datasheet page 38).
> +	 *
> +	 * From the iio_for_each_active_channel() block above, we now have an
> +	 * xfer with data followed by a blank xfer to allow us to meet the
> +	 * timing spec, so move both of those up before adding an extra to
> +	 * handle the temperature-only case.
>  	 */
>  	if (num_slots < 2) {
> -		/* move last xfer so we can insert one more xfer before it */
> -		st->buf_read_xfer[num_xfer] = *xfer;
> +		/* Move last two xfers */
> +		st->buf_read_xfer[num_xfer] = st->buf_read_xfer[num_xfer - 1];
> +		st->buf_read_xfer[num_xfer - 1] = st->buf_read_xfer[num_xfer - 2];
>  		num_xfer++;
>  
> -		/* modify 2nd to last xfer for extra slot */
> +		/* Modify inserted xfer for extra slot. */
> +		xfer = &st->buf_read_xfer[num_xfer - 3];
>  		memset(xfer, 0, sizeof(*xfer));
>  		xfer->cs_change = 1;
>  		xfer->delay.value = st->chip_info->t_acq_ns;
> @@ -499,6 +526,12 @@ static int ad4695_buffer_preenable(struct iio_dev *indio_dev)
>  			return ret;
>  
>  		num_slots++;
> +
> +		/*
> +		 * We still want to point at the last xfer when finished, so
> +		 * update the pointer.
> +		 */
> +		xfer = &st->buf_read_xfer[num_xfer - 1];
>  	}
>  
>  	/*
> @@ -583,8 +616,20 @@ static irqreturn_t ad4695_trigger_handler(int irq, void *p)
>   */
>  static int ad4695_read_one_sample(struct ad4695_state *st, unsigned int address)
>  {
> -	struct spi_transfer xfer[2] = { };
> -	int ret, i = 0;
> +	struct spi_transfer xfers[2] = {
> +		{
> +			.speed_hz = AD4695_REG_ACCESS_SCLK_HZ,
> +			.bits_per_word = 16,
> +			.tx_buf = &st->cnv_cmd,
> +			.len = 2,
> +		},
> +		{
> +			/* Required delay between last SCLK and CNV/CS */
> +			.delay.value = AD4695_T_SCK_CNV_DELAY_NS,
> +			.delay.unit = SPI_DELAY_UNIT_NSECS,
> +		}
> +	};
> +	int ret;
>  
>  	ret = ad4695_set_single_cycle_mode(st, address);
>  	if (ret)
> @@ -592,29 +637,22 @@ static int ad4695_read_one_sample(struct ad4695_state *st, unsigned int address)
>  
>  	/*
>  	 * Setting the first channel to the temperature channel isn't supported
> -	 * in single-cycle mode, so we have to do an extra xfer to read the
> -	 * temperature.
> +	 * in single-cycle mode, so we have to do an extra conversion to read
> +	 * the temperature.
>  	 */
>  	if (address == AD4695_CMD_TEMP_CHAN) {
> -		/* We aren't reading, so we can make this a short xfer. */
> -		st->cnv_cmd2 = AD4695_CMD_TEMP_CHAN << 3;
> -		xfer[0].tx_buf = &st->cnv_cmd2;
> -		xfer[0].len = 1;
> -		xfer[0].cs_change = 1;
> -		xfer[0].cs_change_delay.value = AD4695_T_CONVERT_NS;
> -		xfer[0].cs_change_delay.unit = SPI_DELAY_UNIT_NSECS;
> -
> -		i = 1;
> +		st->cnv_cmd = AD4695_CMD_TEMP_CHAN << 11;
> +
> +		ret = spi_sync_transfer(st->spi, xfers, ARRAY_SIZE(xfers));
> +		if (ret)
> +			return ret;
>  	}
>  
>  	/* Then read the result and exit conversion mode. */
>  	st->cnv_cmd = AD4695_CMD_EXIT_CNV_MODE << 11;
> -	xfer[i].bits_per_word = 16;
> -	xfer[i].tx_buf = &st->cnv_cmd;
> -	xfer[i].rx_buf = &st->raw_data;
> -	xfer[i].len = 2;
> +	xfers[0].rx_buf = &st->raw_data;
>  
> -	return spi_sync_transfer(st->spi, xfer, i + 1);
> +	return spi_sync_transfer(st->spi, xfers, ARRAY_SIZE(xfers));
>  }
>  
>  static int ad4695_read_raw(struct iio_dev *indio_dev,
> 


