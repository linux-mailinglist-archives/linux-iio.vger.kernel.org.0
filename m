Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5716944EBD5
	for <lists+linux-iio@lfdr.de>; Fri, 12 Nov 2021 18:10:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235465AbhKLRM4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Fri, 12 Nov 2021 12:12:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:60052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235434AbhKLRMz (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 12 Nov 2021 12:12:55 -0500
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A28D60FE7;
        Fri, 12 Nov 2021 17:10:03 +0000 (UTC)
Date:   Fri, 12 Nov 2021 17:14:48 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     <alexandru.tachici@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 3/5] iio: adc: ad_sigma_delta: Add sequencer support
Message-ID: <20211112171448.79b4e8cc@jic23-huawei>
In-Reply-To: <20211110111750.27263-4-alexandru.tachici@analog.com>
References: <20211110111750.27263-1-alexandru.tachici@analog.com>
        <20211110111750.27263-4-alexandru.tachici@analog.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 10 Nov 2021 13:17:48 +0200
<alexandru.tachici@analog.com> wrote:

> From: Alexandru Tachici <alexandru.tachici@analog.com>
> 
> Some sigma-delta chips support sampling of multiple
> channels in continuous mode.
> 
> When the operating with more than one channel enabled,
> the channel sequencer cycles through the enabled channels
> in sequential order, from first channel to the last one.
> If a channel is disabled, it is skipped by the sequencer.
> 
> If more than one channel is used in continuous mode,
> instruct the device to append the status to the SPI transfer
> (1 extra byte) every time we receive a sample.
> All sigma-delta chips possessing a sampling sequencer have
> this ability. Inside the status register there will be
> the number of the converted channel. In this way, even
> if the CPU won't keep up with the sampling rate, it won't
> send to userspace wrong channel samples.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>

Hi Alexandru,

A few comments inline. Approach looks good.

Jonathan

> ---
>  drivers/iio/adc/ad_sigma_delta.c       | 106 ++++++++++++++++++++-----
>  include/linux/iio/adc/ad_sigma_delta.h |  22 +++++
>  2 files changed, 110 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
> index 1d652d9b2f5c..d595e7972975 100644
> --- a/drivers/iio/adc/ad_sigma_delta.c
> +++ b/drivers/iio/adc/ad_sigma_delta.c
> @@ -342,33 +342,48 @@ EXPORT_SYMBOL_GPL(ad_sigma_delta_single_conversion);
>  static int ad_sd_buffer_postenable(struct iio_dev *indio_dev)
>  {
>  	struct ad_sigma_delta *sigma_delta = iio_device_get_drvdata(indio_dev);
> -	unsigned int channel;
> +	unsigned int i, slot;
>  	int ret;
>  
> -	channel = find_first_bit(indio_dev->active_scan_mask,
> -				 indio_dev->masklength);
> -	ret = ad_sigma_delta_set_channel(sigma_delta,
> -		indio_dev->channels[channel].address);
> -	if (ret)
> -		return ret;
> +	slot = 0;
> +	for_each_set_bit(i, indio_dev->active_scan_mask, indio_dev->masklength) {
> +		sigma_delta->slots[slot] = indio_dev->channels[i].address;
> +		ret = ad_sigma_delta_set_channel(sigma_delta, indio_dev->channels[i].address);
> +		if (ret)
> +			return ret;
> +		slot++;
> +	}
> +
> +	sigma_delta->active_slots = slot;
> +	sigma_delta->current_slot = 0;
> +
> +	if (sigma_delta->active_slots > 1) {
> +		ret = ad_sigma_delta_append_status(sigma_delta, true);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	kfree(sigma_delta->samples_buf);

krealloc() preferred.   It might not be necessary to actually do an allocation after all
if we happen to have one we can already use.

> +	sigma_delta->samples_buf = kzalloc(slot * indio_dev->channels[0].scan_type.storagebits,
> +					   GFP_KERNEL);

I think this needs space for an aligned timestamp give you pass it directly
to iio_push_to_buffer_with_timestamp();

I haven't checked, but I wonder if the fact you are no longer directly using rx_buf
would allow you to relax the alignment constraint on that. (see below though as I
think you should consider keeping the original path to avoid a copy for the simple
devices).


> +	if (!sigma_delta->samples_buf)
> +		return -ENOMEM;
>  
>  	spi_bus_lock(sigma_delta->spi->master);
>  	sigma_delta->bus_locked = true;
>  	sigma_delta->keep_cs_asserted = true;
>  
>  	ret = ad_sigma_delta_set_mode(sigma_delta, AD_SD_MODE_CONTINUOUS);
> -	if (ret)
> -		goto err_unlock;
> +	if (ret) {
> +		kfree(sigma_delta->samples_buf);
> +		spi_bus_unlock(sigma_delta->spi->master);

From style point of view preferred to keep to the goto style previously used.
Also, unlock then kfree() buffer + given you pass samples_buf to kfree() on next
run of this function you need to set it to NULL to avoid a double free.


> +		return ret;
> +	}
>  
>  	sigma_delta->irq_dis = false;
>  	enable_irq(sigma_delta->spi->irq);
>  
>  	return 0;
> -
> -err_unlock:
> -	spi_bus_unlock(sigma_delta->spi->master);
> -
> -	return ret;
>  }
>  
>  static int ad_sd_buffer_postdisable(struct iio_dev *indio_dev)
> @@ -386,6 +401,9 @@ static int ad_sd_buffer_postdisable(struct iio_dev *indio_dev)
>  	sigma_delta->keep_cs_asserted = false;
>  	ad_sigma_delta_set_mode(sigma_delta, AD_SD_MODE_IDLE);
>  
> +	if (sigma_delta->status_appended)
> +		ad_sigma_delta_append_status(sigma_delta, false);
> +
>  	sigma_delta->bus_locked = false;
>  	return spi_bus_unlock(sigma_delta->spi->master);
>  }
> @@ -396,6 +414,10 @@ static irqreturn_t ad_sd_trigger_handler(int irq, void *p)
>  	struct iio_dev *indio_dev = pf->indio_dev;
>  	struct ad_sigma_delta *sigma_delta = iio_device_get_drvdata(indio_dev);
>  	uint8_t *data = sigma_delta->rx_buf;
> +	unsigned int transfer_size;
> +	unsigned int sample_size;
> +	unsigned int sample_pos;
> +	unsigned int status_pos;
>  	unsigned int reg_size;
>  	unsigned int data_reg;
>  
> @@ -408,20 +430,55 @@ static irqreturn_t ad_sd_trigger_handler(int irq, void *p)
>  	else
>  		data_reg = AD_SD_REG_DATA;
>  
> +	/* Status word will be appended to the sample during transfer */
> +	if (sigma_delta->status_appended)
> +		transfer_size = reg_size + 1;
> +	else
> +		transfer_size = reg_size;
> +
>  	switch (reg_size) {
>  	case 4:
>  	case 2:
>  	case 1:
> -		ad_sd_read_reg_raw(sigma_delta, data_reg, reg_size, &data[0]);
> +		status_pos = reg_size;
> +		ad_sd_read_reg_raw(sigma_delta, data_reg, transfer_size, &data[0]);
>  		break;
>  	case 3:
> +		status_pos = reg_size + 1;
>  		/* We store 24 bit samples in a 32 bit word. Keep the upper
>  		 * byte set to zero. */
> -		ad_sd_read_reg_raw(sigma_delta, data_reg, reg_size, &data[1]);
> +		ad_sd_read_reg_raw(sigma_delta, data_reg, transfer_size, &data[1]);
>  		break;
>  	}
>  
> -	iio_push_to_buffers_with_timestamp(indio_dev, data, pf->timestamp);

Given lots of drivers don't support scan mode, perhaps you want to keep a fast path that
avoids the extra copies used here? i.e. keep old code in place if active_slots == 1

> +	if (sigma_delta->status_appended) {
> +		u8 converted_channel;
> +
> +		converted_channel = data[status_pos] & sigma_delta->info->status_ch_mask;
> +		if (converted_channel != sigma_delta->slots[sigma_delta->current_slot]) {
> +			/* Desynq occurred during continuous sampling of multiple channels.
/*
 * Desync

preferred though i see we have some other comments in here not using that style.

> +			 * Drop this incomplete sample and start from first channel again.
> +			 */
> +
> +			sigma_delta->current_slot = 0;
> +			iio_trigger_notify_done(indio_dev->trig);
> +			sigma_delta->irq_dis = false;
> +			enable_irq(sigma_delta->spi->irq);
> +
> +			return IRQ_HANDLED;
> +		}
> +	}
> +
> +	sample_size = indio_dev->channels[0].scan_type.storagebits / 8;
> +	sample_pos = sample_size * sigma_delta->current_slot;
> +	memcpy(&sigma_delta->samples_buf[sample_pos], data, sample_size);
> +	sigma_delta->current_slot++;
> +
> +	if (sigma_delta->current_slot == sigma_delta->active_slots) {
> +		sigma_delta->current_slot = 0;
> +		iio_push_to_buffers_with_timestamp(indio_dev, sigma_delta->samples_buf,
> +						   pf->timestamp);
> +	}
>  
>  	iio_trigger_notify_done(indio_dev->trig);
>  	sigma_delta->irq_dis = false;
> @@ -430,10 +487,17 @@ static irqreturn_t ad_sd_trigger_handler(int irq, void *p)
>  	return IRQ_HANDLED;
>  }
>  
> +static bool ad_sd_validate_scan_mask(struct iio_dev *indio_dev, const unsigned long *mask)
> +{
> +	struct ad_sigma_delta *sigma_delta = iio_device_get_drvdata(indio_dev);
> +
> +	return bitmap_weight(mask, indio_dev->masklength) <= sigma_delta->info->num_slots;

I think this requires all existing drivers to have num_slots == 1 to do the same as
iio_validate_scan_mask_onehot. I'm not seeing that change in this patch, or any setting
of the default to 1.

> +}
> +
>  static const struct iio_buffer_setup_ops ad_sd_buffer_setup_ops = {
>  	.postenable = &ad_sd_buffer_postenable,
>  	.postdisable = &ad_sd_buffer_postdisable,
> -	.validate_scan_mask = &iio_validate_scan_mask_onehot,
> +	.validate_scan_mask = &ad_sd_validate_scan_mask,
>  };
>  
>  static irqreturn_t ad_sd_data_rdy_trig_poll(int irq, void *private)
> @@ -517,8 +581,14 @@ static int devm_ad_sd_probe_trigger(struct device *dev, struct iio_dev *indio_de
>   */
>  int devm_ad_sd_setup_buffer_and_trigger(struct device *dev, struct iio_dev *indio_dev)
>  {
> +	struct ad_sigma_delta *sigma_delta = iio_device_get_drvdata(indio_dev);
>  	int ret;
>  
> +	sigma_delta->slots = devm_kcalloc(dev, sigma_delta->info->num_slots,
> +					  sizeof(*sigma_delta->slots), GFP_KERNEL);
> +	if (!sigma_delta->slots)
> +		return -ENOMEM;
> +
>  	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
>  					      &iio_pollfunc_store_time,
>  					      &ad_sd_trigger_handler,
> diff --git a/include/linux/iio/adc/ad_sigma_delta.h b/include/linux/iio/adc/ad_sigma_delta.h
> index c525fd51652f..758ff25590c3 100644
> --- a/include/linux/iio/adc/ad_sigma_delta.h
> +++ b/include/linux/iio/adc/ad_sigma_delta.h
> @@ -32,6 +32,7 @@ struct iio_dev;
>  /**
>   * struct ad_sigma_delta_info - Sigma Delta driver specific callbacks and options
>   * @set_channel: Will be called to select the current channel, may be NULL.
> + * @append_status: Will be called to enable status append at the end of the sample, may be NULL.
>   * @set_mode: Will be called to select the current mode, may be NULL.
>   * @postprocess_sample: Is called for each sampled data word, can be used to
>   *		modify or drop the sample data, it, may be NULL.
> @@ -39,19 +40,24 @@ struct iio_dev;
>   *		if there is just one read-only sample data shift register.
>   * @addr_shift: Shift of the register address in the communications register.
>   * @read_mask: Mask for the communications register having the read bit set.
> + * @status_ch_mask: Mask for the channel number stored in status register.
>   * @data_reg: Address of the data register, if 0 the default address of 0x3 will
>   *   be used.
>   * @irq_flags: flags for the interrupt used by the triggered buffer
> + * @num_slots: Number of sequencer slots
>   */
>  struct ad_sigma_delta_info {
>  	int (*set_channel)(struct ad_sigma_delta *, unsigned int channel);
> +	int (*append_status)(struct ad_sigma_delta *, bool append);
>  	int (*set_mode)(struct ad_sigma_delta *, enum ad_sigma_delta_mode mode);
>  	int (*postprocess_sample)(struct ad_sigma_delta *, unsigned int raw_sample);
>  	bool has_registers;
>  	unsigned int addr_shift;
>  	unsigned int read_mask;
> +	unsigned int status_ch_mask;
>  	unsigned int data_reg;
>  	unsigned long irq_flags;
> +	unsigned int num_slots;
>  };
>  
>  /**
> @@ -76,6 +82,12 @@ struct ad_sigma_delta {
>  	uint8_t			comm;
>  
>  	const struct ad_sigma_delta_info *info;
> +	unsigned int		active_slots;
> +	unsigned int		current_slot;
> +	bool			status_appended;
> +	/* map slots to channels in order to know what to expect from devices */
> +	unsigned int		*slots;
> +	uint8_t			*samples_buf;
>  
>  	/*
>  	 * DMA (thus cache coherency maintenance) requires the
> @@ -97,6 +109,16 @@ static inline int ad_sigma_delta_set_channel(struct ad_sigma_delta *sd,
>  	return 0;
>  }
>  
> +static inline int ad_sigma_delta_append_status(struct ad_sigma_delta *sd, bool append)
> +{
> +	if (sd->info->append_status) {
> +		sd->status_appended = append;
> +		return sd->info->append_status(sd, append);
> +	}
> +
> +	return 0;
> +}
> +
>  static inline int ad_sigma_delta_set_mode(struct ad_sigma_delta *sd,
>  	unsigned int mode)
>  {

