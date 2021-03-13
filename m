Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC1E339F21
	for <lists+linux-iio@lfdr.de>; Sat, 13 Mar 2021 17:38:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233570AbhCMQhu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 13 Mar 2021 11:37:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:56570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234007AbhCMQhW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 13 Mar 2021 11:37:22 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE0B664F0C;
        Sat, 13 Mar 2021 16:37:21 +0000 (UTC)
Date:   Sat, 13 Mar 2021 16:37:19 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     <alexandru.tachici@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 1/1] iio: adc: ad7124: allow more than 8 channels
Message-ID: <20210313163719.50e84c04@archlinux>
In-Reply-To: <20210311091154.47785-2-alexandru.tachici@analog.com>
References: <20210311091154.47785-1-alexandru.tachici@analog.com>
        <20210311091154.47785-2-alexandru.tachici@analog.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 11 Mar 2021 11:11:54 +0200
<alexandru.tachici@analog.com> wrote:

> From: Alexandru Tachici <alexandru.tachici@analog.com>
> 
> Currently AD7124-8 driver cannot use more than 8 IIO channels
> because it was assigning the channel configurations bijectively
> to channels specified in the device-tree. This is not possible
> to do when using more than 8 channels as AD7124-8 has only 8
> configuration registers.
> 
> To allow the user to use all channels at once the driver
> will keep in memory configurations for all channels but
> will program only 8 of them at a time on the device.
> If multiple channels have the same configuration, only
> one configuration register will be used. If there
> are more configurations than available registers only
> the last 8 used configurations will be allowed to exist
> on the device in a LRU fashion.
> 
> Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>

Hi Alexandru,

Other than the two warnings that 0-day found I'm fine with this.
Hence I've fixed those up as follows
1) Indent was obvious so fixed.
2) val being set but not used.  As far as I can tell, it has no relevance
   where that happened, so I just dropped it.  If that's wrong let
   me know.

Diff as follows:
diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index 8b5b223938e8..9d3952b4674f 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -366,7 +366,7 @@ static int ad7124_init_config_vref(struct ad7124_state *st, struct ad7124_channe
                        dev_err(&st->sd.spi->dev,
                                "Error, trying to use external voltage reference without a %s regulator.\n",
                                ad7124_ref_names[refsel]);
-                               return PTR_ERR(st->vref[refsel]);
+                       return PTR_ERR(st->vref[refsel]);
                }
                cfg->vref_mv = regulator_get_voltage(st->vref[refsel]);
                /* Conversion from uV to mV */
@@ -807,7 +807,7 @@ static int ad7124_of_parse_channel_config(struct iio_dev *indio_dev,
 
 static int ad7124_setup(struct ad7124_state *st)
 {
-       unsigned int val, fclk, power_mode;
+       unsigned int fclk, power_mode;
        int i, ret;
 
        fclk = clk_get_rate(st->mclk);
@@ -834,7 +834,6 @@ static int ad7124_setup(struct ad7124_state *st)
        mutex_init(&st->cfgs_lock);
        INIT_KFIFO(st->live_cfgs_fifo);
        for (i = 0; i < st->num_channels; i++) {
-               val = st->channels[i].ain;
 
                ret = ad7124_init_config_vref(st, &st->channels[i].cfg);
                if (ret < 0)

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to see if they missed anything else :)

Jonathan

> ---
>  drivers/iio/adc/ad7124.c | 458 +++++++++++++++++++++++++--------------
>  1 file changed, 301 insertions(+), 157 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
> index 766c73333604..8b5b223938e8 100644
> --- a/drivers/iio/adc/ad7124.c
> +++ b/drivers/iio/adc/ad7124.c
> @@ -5,12 +5,14 @@
>   * Copyright 2018 Analog Devices Inc.
>   */
>  #include <linux/bitfield.h>
> +#include <linux/bitops.h>
>  #include <linux/clk.h>
>  #include <linux/delay.h>
>  #include <linux/device.h>
>  #include <linux/err.h>
>  #include <linux/interrupt.h>
>  #include <linux/kernel.h>
> +#include <linux/kfifo.h>
>  #include <linux/module.h>
>  #include <linux/of_device.h>
>  #include <linux/regulator/consumer.h>
> @@ -86,6 +88,10 @@
>  #define AD7124_SINC3_FILTER 2
>  #define AD7124_SINC4_FILTER 0
>  
> +#define AD7124_CONF_ADDR_OFFSET	20
> +#define AD7124_MAX_CONFIGS	8
> +#define AD7124_MAX_CHANNELS	16
> +
>  enum ad7124_ids {
>  	ID_AD7124_4,
>  	ID_AD7124_8,
> @@ -136,25 +142,37 @@ struct ad7124_chip_info {
>  };
>  
>  struct ad7124_channel_config {
> +	bool live;
> +	unsigned int cfg_slot;
>  	enum ad7124_ref_sel refsel;
>  	bool bipolar;
>  	bool buf_positive;
>  	bool buf_negative;
> -	unsigned int ain;
>  	unsigned int vref_mv;
>  	unsigned int pga_bits;
>  	unsigned int odr;
> +	unsigned int odr_sel_bits;
>  	unsigned int filter_type;
>  };
>  
> +struct ad7124_channel {
> +	unsigned int nr;
> +	struct ad7124_channel_config cfg;
> +	unsigned int ain;
> +	unsigned int slot;
> +};
> +
>  struct ad7124_state {
>  	const struct ad7124_chip_info *chip_info;
>  	struct ad_sigma_delta sd;
> -	struct ad7124_channel_config *channel_config;
> +	struct ad7124_channel *channels;
>  	struct regulator *vref[4];
>  	struct clk *mclk;
>  	unsigned int adc_control;
>  	unsigned int num_channels;
> +	struct mutex cfgs_lock; /* lock for configs access */
> +	unsigned long cfg_slots_status; /* bitmap with slot status (1 means it is used) */
> +	DECLARE_KFIFO(live_cfgs_fifo, struct ad7124_channel_config *, AD7124_MAX_CONFIGS);
>  };
>  
>  static const struct iio_chan_spec ad7124_channel_template = {
> @@ -238,33 +256,9 @@ static int ad7124_set_mode(struct ad_sigma_delta *sd,
>  	return ad_sd_write_reg(&st->sd, AD7124_ADC_CONTROL, 2, st->adc_control);
>  }
>  
> -static int ad7124_set_channel(struct ad_sigma_delta *sd, unsigned int channel)
> -{
> -	struct ad7124_state *st = container_of(sd, struct ad7124_state, sd);
> -	unsigned int val;
> -
> -	val = st->channel_config[channel].ain | AD7124_CHANNEL_EN(1) |
> -	      AD7124_CHANNEL_SETUP(channel);
> -
> -	return ad_sd_write_reg(&st->sd, AD7124_CHANNEL(channel), 2, val);
> -}
> -
> -static const struct ad_sigma_delta_info ad7124_sigma_delta_info = {
> -	.set_channel = ad7124_set_channel,
> -	.set_mode = ad7124_set_mode,
> -	.has_registers = true,
> -	.addr_shift = 0,
> -	.read_mask = BIT(6),
> -	.data_reg = AD7124_DATA,
> -	.irq_flags = IRQF_TRIGGER_FALLING,
> -};
> -
> -static int ad7124_set_channel_odr(struct ad7124_state *st,
> -				  unsigned int channel,
> -				  unsigned int odr)
> +static void ad7124_set_channel_odr(struct ad7124_state *st, unsigned int channel, unsigned int odr)
>  {
>  	unsigned int fclk, odr_sel_bits;
> -	int ret;
>  
>  	fclk = clk_get_rate(st->mclk);
>  	/*
> @@ -280,36 +274,12 @@ static int ad7124_set_channel_odr(struct ad7124_state *st,
>  	else if (odr_sel_bits > 2047)
>  		odr_sel_bits = 2047;
>  
> -	ret = ad7124_spi_write_mask(st, AD7124_FILTER(channel),
> -				    AD7124_FILTER_FS_MSK,
> -				    AD7124_FILTER_FS(odr_sel_bits), 3);
> -	if (ret < 0)
> -		return ret;
> -	/* fADC = fCLK / (FS[10:0] x 32) */
> -	st->channel_config[channel].odr =
> -		DIV_ROUND_CLOSEST(fclk, odr_sel_bits * 32);
> -
> -	return 0;
> -}
> -
> -static int ad7124_set_channel_gain(struct ad7124_state *st,
> -				   unsigned int channel,
> -				   unsigned int gain)
> -{
> -	unsigned int res;
> -	int ret;
> -
> -	res = ad7124_find_closest_match(ad7124_gain,
> -					ARRAY_SIZE(ad7124_gain), gain);
> -	ret = ad7124_spi_write_mask(st, AD7124_CONFIG(channel),
> -				    AD7124_CONFIG_PGA_MSK,
> -				    AD7124_CONFIG_PGA(res), 2);
> -	if (ret < 0)
> -		return ret;
> -
> -	st->channel_config[channel].pga_bits = res;
> +	if (odr_sel_bits != st->channels[channel].cfg.odr_sel_bits)
> +		st->channels[channel].cfg.live = false;
>  
> -	return 0;
> +	/* fADC = fCLK / (FS[10:0] x 32) */
> +	st->channels[channel].cfg.odr = DIV_ROUND_CLOSEST(fclk, odr_sel_bits * 32);
> +	st->channels[channel].cfg.odr_sel_bits = odr_sel_bits;
>  }
>  
>  static int ad7124_get_3db_filter_freq(struct ad7124_state *st,
> @@ -317,9 +287,9 @@ static int ad7124_get_3db_filter_freq(struct ad7124_state *st,
>  {
>  	unsigned int fadc;
>  
> -	fadc = st->channel_config[channel].odr;
> +	fadc = st->channels[channel].cfg.odr;
>  
> -	switch (st->channel_config[channel].filter_type) {
> +	switch (st->channels[channel].cfg.filter_type) {
>  	case AD7124_SINC3_FILTER:
>  		return DIV_ROUND_CLOSEST(fadc * 230, 1000);
>  	case AD7124_SINC4_FILTER:
> @@ -329,9 +299,8 @@ static int ad7124_get_3db_filter_freq(struct ad7124_state *st,
>  	}
>  }
>  
> -static int ad7124_set_3db_filter_freq(struct ad7124_state *st,
> -				      unsigned int channel,
> -				      unsigned int freq)
> +static void ad7124_set_3db_filter_freq(struct ad7124_state *st, unsigned int channel,
> +				       unsigned int freq)
>  {
>  	unsigned int sinc4_3db_odr;
>  	unsigned int sinc3_3db_odr;
> @@ -349,21 +318,211 @@ static int ad7124_set_3db_filter_freq(struct ad7124_state *st,
>  		new_odr = sinc3_3db_odr;
>  	}
>  
> -	if (st->channel_config[channel].filter_type != new_filter) {
> -		int ret;
> +	if (new_odr != st->channels[channel].cfg.odr)
> +		st->channels[channel].cfg.live = false;
>  
> -		st->channel_config[channel].filter_type = new_filter;
> -		ret = ad7124_spi_write_mask(st, AD7124_FILTER(channel),
> -					    AD7124_FILTER_TYPE_MSK,
> -					    AD7124_FILTER_TYPE_SEL(new_filter),
> -					    3);
> -		if (ret < 0)
> -			return ret;
> +	st->channels[channel].cfg.filter_type = new_filter;
> +	st->channels[channel].cfg.odr = new_odr;
> +}
> +
> +static struct ad7124_channel_config *ad7124_find_similar_live_cfg(struct ad7124_state *st,
> +								  struct ad7124_channel_config *cfg)
> +{
> +	struct ad7124_channel_config *cfg_aux;
> +	ptrdiff_t cmp_size;
> +	int i;
> +
> +	cmp_size = (u8 *)&cfg->live - (u8 *)cfg;
> +	for (i = 0; i < st->num_channels; i++) {
> +		cfg_aux = &st->channels[i].cfg;
> +
> +		if (cfg_aux->live && !memcmp(cfg, cfg_aux, cmp_size))
> +			return cfg_aux;
> +	}
> +
> +	return NULL;
> +}
> +
> +static int ad7124_find_free_config_slot(struct ad7124_state *st)
> +{
> +	unsigned int free_cfg_slot;
> +
> +	free_cfg_slot = find_next_zero_bit(&st->cfg_slots_status, AD7124_MAX_CONFIGS, 0);
> +	if (free_cfg_slot == AD7124_MAX_CONFIGS)
> +		return -1;
> +
> +	return free_cfg_slot;
> +}
> +
> +static int ad7124_init_config_vref(struct ad7124_state *st, struct ad7124_channel_config *cfg)
> +{
> +	unsigned int refsel = cfg->refsel;
> +
> +	switch (refsel) {
> +	case AD7124_REFIN1:
> +	case AD7124_REFIN2:
> +	case AD7124_AVDD_REF:
> +		if (IS_ERR(st->vref[refsel])) {
> +			dev_err(&st->sd.spi->dev,
> +				"Error, trying to use external voltage reference without a %s regulator.\n",
> +				ad7124_ref_names[refsel]);
> +				return PTR_ERR(st->vref[refsel]);
> +		}
> +		cfg->vref_mv = regulator_get_voltage(st->vref[refsel]);
> +		/* Conversion from uV to mV */
> +		cfg->vref_mv /= 1000;
> +		return 0;
> +	case AD7124_INT_REF:
> +		cfg->vref_mv = 2500;
> +		st->adc_control &= ~AD7124_ADC_CTRL_REF_EN_MSK;
> +		st->adc_control |= AD7124_ADC_CTRL_REF_EN(1);
> +		return ad_sd_write_reg(&st->sd, AD7124_ADC_CONTROL,
> +				      2, st->adc_control);
> +	default:
> +		dev_err(&st->sd.spi->dev, "Invalid reference %d\n", refsel);
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ad7124_write_config(struct ad7124_state *st, struct ad7124_channel_config *cfg,
> +			       unsigned int cfg_slot)
> +{
> +	unsigned int tmp;
> +	unsigned int val;
> +	int ret;
> +
> +	cfg->cfg_slot = cfg_slot;
> +
> +	tmp = (cfg->buf_positive << 1) + cfg->buf_negative;
> +	val = AD7124_CONFIG_BIPOLAR(cfg->bipolar) | AD7124_CONFIG_REF_SEL(cfg->refsel) |
> +	      AD7124_CONFIG_IN_BUFF(tmp);
> +	ret = ad_sd_write_reg(&st->sd, AD7124_CONFIG(cfg->cfg_slot), 2, val);
> +	if (ret < 0)
> +		return ret;
> +
> +	tmp = AD7124_FILTER_TYPE_SEL(cfg->filter_type);
> +	ret = ad7124_spi_write_mask(st, AD7124_FILTER(cfg->cfg_slot), AD7124_FILTER_TYPE_MSK,
> +				    tmp, 3);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = ad7124_spi_write_mask(st, AD7124_FILTER(cfg->cfg_slot), AD7124_FILTER_FS_MSK,
> +				    AD7124_FILTER_FS(cfg->odr_sel_bits), 3);
> +	if (ret < 0)
> +		return ret;
> +
> +	return ad7124_spi_write_mask(st, AD7124_CONFIG(cfg->cfg_slot), AD7124_CONFIG_PGA_MSK,
> +				     AD7124_CONFIG_PGA(cfg->pga_bits), 2);
> +}
> +
> +static struct ad7124_channel_config *ad7124_pop_config(struct ad7124_state *st)
> +{
> +	struct ad7124_channel_config *lru_cfg;
> +	struct ad7124_channel_config *cfg;
> +	int ret;
> +	int i;
> +
> +	/*
> +	 * Pop least recently used config from the fifo
> +	 * in order to make room for the new one
> +	 */
> +	ret = kfifo_get(&st->live_cfgs_fifo, &lru_cfg);
> +	if (ret <= 0)
> +		return NULL;
> +
> +	lru_cfg->live = false;
> +
> +	/* mark slot as free */
> +	assign_bit(lru_cfg->cfg_slot, &st->cfg_slots_status, 0);
> +
> +	/* invalidate all other configs that pointed to this one */
> +	for (i = 0; i < st->num_channels; i++) {
> +		cfg = &st->channels[i].cfg;
> +
> +		if (cfg->cfg_slot == lru_cfg->cfg_slot)
> +			cfg->live = false;
>  	}
>  
> -	return ad7124_set_channel_odr(st, channel, new_odr);
> +	return lru_cfg;
>  }
>  
> +static int ad7124_push_config(struct ad7124_state *st, struct ad7124_channel_config *cfg)
> +{
> +	struct ad7124_channel_config *lru_cfg;
> +	int free_cfg_slot;
> +
> +	free_cfg_slot = ad7124_find_free_config_slot(st);
> +	if (free_cfg_slot >= 0) {
> +		/* push the new config in configs queue */
> +		kfifo_put(&st->live_cfgs_fifo, cfg);
> +	} else {
> +		/* pop one config to make room for the new one */
> +		lru_cfg = ad7124_pop_config(st);
> +		if (!lru_cfg)
> +			return -EINVAL;
> +
> +		/* push the new config in configs queue */
> +		free_cfg_slot = lru_cfg->cfg_slot;
> +		kfifo_put(&st->live_cfgs_fifo, cfg);
> +	}
> +
> +	/* mark slot as used */
> +	assign_bit(free_cfg_slot, &st->cfg_slots_status, 1);
> +
> +	return ad7124_write_config(st, cfg, free_cfg_slot);
> +}
> +
> +static int ad7124_enable_channel(struct ad7124_state *st, struct ad7124_channel *ch)
> +{
> +	ch->cfg.live = true;
> +	return ad_sd_write_reg(&st->sd, AD7124_CHANNEL(ch->nr), 2, ch->ain |
> +			      AD7124_CHANNEL_SETUP(ch->cfg.cfg_slot) | AD7124_CHANNEL_EN(1));
> +}
> +
> +static int ad7124_prepare_read(struct ad7124_state *st, int address)
> +{
> +	struct ad7124_channel_config *cfg = &st->channels[address].cfg;
> +	struct ad7124_channel_config *live_cfg;
> +
> +	/*
> +	 * Before doing any reads assign the channel a configuration.
> +	 * Check if channel's config is on the device
> +	 */
> +	if (!cfg->live) {
> +		/* check if config matches another one */
> +		live_cfg = ad7124_find_similar_live_cfg(st, cfg);
> +		if (!live_cfg)
> +			ad7124_push_config(st, cfg);
> +		else
> +			cfg->cfg_slot = live_cfg->cfg_slot;
> +	}
> +
> +	/* point channel to the config slot and enable */
> +	return ad7124_enable_channel(st, &st->channels[address]);
> +}
> +
> +static int ad7124_set_channel(struct ad_sigma_delta *sd, unsigned int channel)
> +{
> +	struct ad7124_state *st = container_of(sd, struct ad7124_state, sd);
> +	int ret;
> +
> +	mutex_lock(&st->cfgs_lock);
> +	ret = ad7124_prepare_read(st, channel);
> +	mutex_unlock(&st->cfgs_lock);
> +
> +	return ret;
> +}
> +
> +static const struct ad_sigma_delta_info ad7124_sigma_delta_info = {
> +	.set_channel = ad7124_set_channel,
> +	.set_mode = ad7124_set_mode,
> +	.has_registers = true,
> +	.addr_shift = 0,
> +	.read_mask = BIT(6),
> +	.data_reg = AD7124_DATA,
> +	.irq_flags = IRQF_TRIGGER_FALLING
> +};
> +
>  static int ad7124_read_raw(struct iio_dev *indio_dev,
>  			   struct iio_chan_spec const *chan,
>  			   int *val, int *val2, long info)
> @@ -378,36 +537,44 @@ static int ad7124_read_raw(struct iio_dev *indio_dev,
>  			return ret;
>  
>  		/* After the conversion is performed, disable the channel */
> -		ret = ad_sd_write_reg(&st->sd,
> -				      AD7124_CHANNEL(chan->address), 2,
> -				      st->channel_config[chan->address].ain |
> -				      AD7124_CHANNEL_EN(0));
> +		ret = ad_sd_write_reg(&st->sd, AD7124_CHANNEL(chan->address), 2,
> +				      st->channels[chan->address].ain | AD7124_CHANNEL_EN(0));
>  		if (ret < 0)
>  			return ret;
>  
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_SCALE:
> -		idx = st->channel_config[chan->address].pga_bits;
> -		*val = st->channel_config[chan->address].vref_mv;
> -		if (st->channel_config[chan->address].bipolar)
> +		mutex_lock(&st->cfgs_lock);
> +
> +		idx = st->channels[chan->address].cfg.pga_bits;
> +		*val = st->channels[chan->address].cfg.vref_mv;
> +		if (st->channels[chan->address].cfg.bipolar)
>  			*val2 = chan->scan_type.realbits - 1 + idx;
>  		else
>  			*val2 = chan->scan_type.realbits + idx;
>  
> +		mutex_unlock(&st->cfgs_lock);
>  		return IIO_VAL_FRACTIONAL_LOG2;
>  	case IIO_CHAN_INFO_OFFSET:
> -		if (st->channel_config[chan->address].bipolar)
> +		mutex_lock(&st->cfgs_lock);
> +		if (st->channels[chan->address].cfg.bipolar)
>  			*val = -(1 << (chan->scan_type.realbits - 1));
>  		else
>  			*val = 0;
>  
> +		mutex_unlock(&st->cfgs_lock);
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_SAMP_FREQ:
> -		*val = st->channel_config[chan->address].odr;
> +		mutex_lock(&st->cfgs_lock);
> +		*val = st->channels[chan->address].cfg.odr;
> +		mutex_unlock(&st->cfgs_lock);
>  
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> +		mutex_lock(&st->cfgs_lock);
>  		*val = ad7124_get_3db_filter_freq(st, chan->scan_index);
> +		mutex_unlock(&st->cfgs_lock);
> +
>  		return IIO_VAL_INT;
>  	default:
>  		return -EINVAL;
> @@ -420,35 +587,54 @@ static int ad7124_write_raw(struct iio_dev *indio_dev,
>  {
>  	struct ad7124_state *st = iio_priv(indio_dev);
>  	unsigned int res, gain, full_scale, vref;
> +	int ret = 0;
> +
> +	mutex_lock(&st->cfgs_lock);
>  
>  	switch (info) {
>  	case IIO_CHAN_INFO_SAMP_FREQ:
> -		if (val2 != 0)
> -			return -EINVAL;
> +		if (val2 != 0) {
> +			ret = -EINVAL;
> +			break;
> +		}
>  
> -		return ad7124_set_channel_odr(st, chan->address, val);
> +		ad7124_set_channel_odr(st, chan->address, val);
> +		break;
>  	case IIO_CHAN_INFO_SCALE:
> -		if (val != 0)
> -			return -EINVAL;
> +		if (val != 0) {
> +			ret = -EINVAL;
> +			break;
> +		}
>  
> -		if (st->channel_config[chan->address].bipolar)
> +		if (st->channels[chan->address].cfg.bipolar)
>  			full_scale = 1 << (chan->scan_type.realbits - 1);
>  		else
>  			full_scale = 1 << chan->scan_type.realbits;
>  
> -		vref = st->channel_config[chan->address].vref_mv * 1000000LL;
> +		vref = st->channels[chan->address].cfg.vref_mv * 1000000LL;
>  		res = DIV_ROUND_CLOSEST(vref, full_scale);
>  		gain = DIV_ROUND_CLOSEST(res, val2);
> +		res = ad7124_find_closest_match(ad7124_gain, ARRAY_SIZE(ad7124_gain), gain);
>  
> -		return ad7124_set_channel_gain(st, chan->address, gain);
> +		if (st->channels[chan->address].cfg.pga_bits != res)
> +			st->channels[chan->address].cfg.live = false;
> +
> +		st->channels[chan->address].cfg.pga_bits = res;
> +		break;
>  	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> -		if (val2 != 0)
> -			return -EINVAL;
> +		if (val2 != 0) {
> +			ret = -EINVAL;
> +			break;
> +		}
>  
> -		return ad7124_set_3db_filter_freq(st, chan->address, val);
> +		ad7124_set_3db_filter_freq(st, chan->address, val);
> +		break;
>  	default:
> -		return -EINVAL;
> +		ret =  -EINVAL;
>  	}
> +
> +	mutex_unlock(&st->cfgs_lock);
> +	return ret;
>  }
>  
>  static int ad7124_reg_access(struct iio_dev *indio_dev,
> @@ -547,47 +733,14 @@ static int ad7124_check_chip_id(struct ad7124_state *st)
>  	return 0;
>  }
>  
> -static int ad7124_init_channel_vref(struct ad7124_state *st,
> -				    unsigned int channel_number)
> -{
> -	unsigned int refsel = st->channel_config[channel_number].refsel;
> -
> -	switch (refsel) {
> -	case AD7124_REFIN1:
> -	case AD7124_REFIN2:
> -	case AD7124_AVDD_REF:
> -		if (IS_ERR(st->vref[refsel])) {
> -			dev_err(&st->sd.spi->dev,
> -				"Error, trying to use external voltage reference without a %s regulator.\n",
> -				ad7124_ref_names[refsel]);
> -			return PTR_ERR(st->vref[refsel]);
> -		}
> -		st->channel_config[channel_number].vref_mv =
> -			regulator_get_voltage(st->vref[refsel]);
> -		/* Conversion from uV to mV */
> -		st->channel_config[channel_number].vref_mv /= 1000;
> -		break;
> -	case AD7124_INT_REF:
> -		st->channel_config[channel_number].vref_mv = 2500;
> -		st->adc_control &= ~AD7124_ADC_CTRL_REF_EN_MSK;
> -		st->adc_control |= AD7124_ADC_CTRL_REF_EN(1);
> -		return ad_sd_write_reg(&st->sd, AD7124_ADC_CONTROL,
> -				      2, st->adc_control);
> -	default:
> -		dev_err(&st->sd.spi->dev, "Invalid reference %d\n", refsel);
> -		return -EINVAL;
> -	}
> -
> -	return 0;
> -}
> -
>  static int ad7124_of_parse_channel_config(struct iio_dev *indio_dev,
>  					  struct device_node *np)
>  {
>  	struct ad7124_state *st = iio_priv(indio_dev);
> +	struct ad7124_channel_config *cfg;
> +	struct ad7124_channel *channels;
>  	struct device_node *child;
>  	struct iio_chan_spec *chan;
> -	struct ad7124_channel_config *chan_config;
>  	unsigned int ain[2], channel = 0, tmp;
>  	int ret;
>  
> @@ -602,16 +755,18 @@ static int ad7124_of_parse_channel_config(struct iio_dev *indio_dev,
>  	if (!chan)
>  		return -ENOMEM;
>  
> -	chan_config = devm_kcalloc(indio_dev->dev.parent, st->num_channels,
> -				   sizeof(*chan_config), GFP_KERNEL);
> -	if (!chan_config)
> +	channels = devm_kcalloc(indio_dev->dev.parent, st->num_channels, sizeof(*channels),
> +				GFP_KERNEL);
> +	if (!channels)
>  		return -ENOMEM;
>  
>  	indio_dev->channels = chan;
>  	indio_dev->num_channels = st->num_channels;
> -	st->channel_config = chan_config;
> +	st->channels = channels;
>  
>  	for_each_available_child_of_node(np, child) {
> +		cfg = &st->channels[channel].cfg;
> +
>  		ret = of_property_read_u32(child, "reg", &channel);
>  		if (ret)
>  			goto err;
> @@ -621,21 +776,20 @@ static int ad7124_of_parse_channel_config(struct iio_dev *indio_dev,
>  		if (ret)
>  			goto err;
>  
> -		st->channel_config[channel].ain = AD7124_CHANNEL_AINP(ain[0]) |
> +		st->channels[channel].nr = channel;
> +		st->channels[channel].ain = AD7124_CHANNEL_AINP(ain[0]) |
>  						  AD7124_CHANNEL_AINM(ain[1]);
> -		st->channel_config[channel].bipolar =
> -			of_property_read_bool(child, "bipolar");
> +
> +		cfg->bipolar = of_property_read_bool(child, "bipolar");
>  
>  		ret = of_property_read_u32(child, "adi,reference-select", &tmp);
>  		if (ret)
> -			st->channel_config[channel].refsel = AD7124_INT_REF;
> +			cfg->refsel = AD7124_INT_REF;
>  		else
> -			st->channel_config[channel].refsel = tmp;
> +			cfg->refsel = tmp;
>  
> -		st->channel_config[channel].buf_positive =
> -			of_property_read_bool(child, "adi,buffered-positive");
> -		st->channel_config[channel].buf_negative =
> -			of_property_read_bool(child, "adi,buffered-negative");
> +		cfg->buf_positive = of_property_read_bool(child, "adi,buffered-positive");
> +		cfg->buf_negative = of_property_read_bool(child, "adi,buffered-negative");
>  
>  		chan[channel] = ad7124_channel_template;
>  		chan[channel].address = channel;
> @@ -654,7 +808,7 @@ static int ad7124_of_parse_channel_config(struct iio_dev *indio_dev,
>  static int ad7124_setup(struct ad7124_state *st)
>  {
>  	unsigned int val, fclk, power_mode;
> -	int i, ret, tmp;
> +	int i, ret;
>  
>  	fclk = clk_get_rate(st->mclk);
>  	if (!fclk)
> @@ -677,31 +831,21 @@ static int ad7124_setup(struct ad7124_state *st)
>  	if (ret < 0)
>  		return ret;
>  
> +	mutex_init(&st->cfgs_lock);
> +	INIT_KFIFO(st->live_cfgs_fifo);
>  	for (i = 0; i < st->num_channels; i++) {
> -		val = st->channel_config[i].ain | AD7124_CHANNEL_SETUP(i);
> -		ret = ad_sd_write_reg(&st->sd, AD7124_CHANNEL(i), 2, val);
> -		if (ret < 0)
> -			return ret;
> +		val = st->channels[i].ain;
>  
> -		ret = ad7124_init_channel_vref(st, i);
> +		ret = ad7124_init_config_vref(st, &st->channels[i].cfg);
>  		if (ret < 0)
>  			return ret;
>  
> -		tmp = (st->channel_config[i].buf_positive << 1)  +
> -			st->channel_config[i].buf_negative;
> -
> -		val = AD7124_CONFIG_BIPOLAR(st->channel_config[i].bipolar) |
> -		      AD7124_CONFIG_REF_SEL(st->channel_config[i].refsel) |
> -		      AD7124_CONFIG_IN_BUFF(tmp);
> -		ret = ad_sd_write_reg(&st->sd, AD7124_CONFIG(i), 2, val);
> -		if (ret < 0)
> -			return ret;
>  		/*
>  		 * 9.38 SPS is the minimum output data rate supported
>  		 * regardless of the selected power mode. Round it up to 10 and
> -		 * set all the enabled channels to this default value.
> +		 * set all channels to this default value.
>  		 */
> -		ret = ad7124_set_channel_odr(st, i, 10);
> +		ad7124_set_channel_odr(st, i, 10);
>  	}
>  
>  	return ret;

