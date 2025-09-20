Return-Path: <linux-iio+bounces-24318-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B3D5B8C6A8
	for <lists+linux-iio@lfdr.de>; Sat, 20 Sep 2025 13:24:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C825F625D73
	for <lists+linux-iio@lfdr.de>; Sat, 20 Sep 2025 11:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D3D2F8BE8;
	Sat, 20 Sep 2025 11:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G3BmBnWu"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C631DA3D;
	Sat, 20 Sep 2025 11:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758367453; cv=none; b=XgQWussqOPRnQGnnwsLeEjAdZ9OM6aMVU103Uy3MnJNJTcaMoQ6vDSd/IIPYRKglqiH/Fur/K3YgNkDIH7S6krMa356TZUHA/7/kLauvjvRMLRgC52roRhmC1p2zOeQCccD7dc/Wl4xH/h4RB/tTeBbUw3njeEDKqneAuhE8O8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758367453; c=relaxed/simple;
	bh=0cUf7zxZNvFOOxoUYNI2sFV3TjONOO3F+iQdvZqyz4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H6gNYljxZqm+0Sc6jJ4SxtMMPteXj1YcxstlNW+KZmEwHOFJEOpUMQnYh6J/H7cNOAfGtqTxP+vrP/EmOx6o/zZhNhnkiOl72i2f0soa50JARAKABjjZFlAeL5OUMY8mKBL0/jTkcOPnV5xMlogf5a2G4y9k/NlBTZIILlKq0wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G3BmBnWu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDED0C4CEEB;
	Sat, 20 Sep 2025 11:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758367452;
	bh=0cUf7zxZNvFOOxoUYNI2sFV3TjONOO3F+iQdvZqyz4Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=G3BmBnWulNvYNQ0fp6rKuxnaLNgkBzqkp5N8H/I5sbg4RWcuvnWf8vRrag9yQ989Y
	 wjUGVSgwpbvOpZ6BUivcpPJAis8MtBSjX2zmmQSLZxYl02zl0zagmkJkfOusmEfOVj
	 UlATlHKOU31zdTvk7nYG7UeiwvvNIQF28PtvabEvonBY1aauHwR5Nnvg9i+qC2hfjx
	 TWesm0ihdclrI+Fy7jn2MfzO8bRmUR2dHyWt38JeRK7gh7IQm/8N3sKgFca4JoaPQX
	 HkR3MKbNFijllPtbcwCOSjOlsBQEdTI9e1pFYVXIi9LuhBEalevfHMsrqDCZe8IiH2
	 DL7aZJU6xq1uw==
Date: Sat, 20 Sep 2025 12:24:04 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad7124: change setup reg allocation strategy
Message-ID: <20250920122404.76277a27@jic23-huawei>
In-Reply-To: <20250917-iio-adc-ad7124-change-setup-reg-allocation-strategy-v1-1-4e17b3de046b@baylibre.com>
References: <20250917-iio-adc-ad7124-change-setup-reg-allocation-strategy-v1-1-4e17b3de046b@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 17 Sep 2025 17:05:01 -0500
David Lechner <dlechner@baylibre.com> wrote:

> Change the allocation strategy of the 8 SETUP registers from a least-
> recently-used (LRU) to a first-come-first-served basis.
> 
> The AD7124 chips can have up to 16 channels enabled at a time in the
> sequencer for buffered reads, but only have 8 SETUP configurations
> (namely the OFFSET, GAIN, CONFIG and FILTER registers) that must be
> shared among the 16 channels.  This means some of the channels must use
> the exact same configuration parameters so that they can share a single
> SETUP group of registers.  The previous LRU strategy did not keep track
> of how many different configurations were requested at the same time,
> so if there were more than 8 different configurations requested, some
> channels would end up using the incorrect configuration because the slot
> assigned to them would also be assigned to a different configuration
> that wrote over it later.
> 
> Adding such tracking to solve this would make an already complex
> algorithm even more complex.  Instead we can replace it with a simpler
> first-come-first-serve strategy.  This makes it easy to track how many
> different configurations are being requested at the same time.  This
> comes at the expense of slightly longer setup times for buffered reads
> since all setup registers must be written each time when a buffered read
> is enabled.  But this is generally not considered a hot path where
> performance is critical, so should be acceptable.

If I read this correctly, ever time we call postenable()
this parses the channels enabled and first checks if an existing cfg
is usable, if not assigns the first unused slot.

If so, the algorithm is a little more complex than it needs to be because
it is allowing for holes in the used cfg registers that I don't think
can occur.

So if we add simple cfg_slots_used variable we can for example jump directly
to the next unused slot if we don't find a match and we can use this
as the loop limit to save on checking a bunch of zeros after that aren't
in use.

Maybe I'm missing something?

In general the approach you have here feels sensible.

Jonathan

> 
> This new strategy also makes hardware debugging easier since SETUPs are
> now assigned in a deterministic manner and in a logical order.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> This is something I wish I would have noticed earlier. This is
> addressing the same issue we saw recently in the ad7173 driver [1].
> 
> However, since we have added a bunch of new features to the ad7124
> driver recently, it seems too late to make a change like the one in the
> link that can be easily backported. So I didn't bother with a Fixes: tag
> here. Given how many other broken things we found in ad7124 recently,
> I'm not too worried about rushing out a fix for backporting anyway.
> 
> Instead, I implemented the idea I first proposed in [2]. I find it much
> easier to follow and reason about than the LRU implementation. And while
> working on other features, I found the LRU implementation to be annoying
> because I never knew which setup registers would be assigned to which
> channels after tweaking the channel configuration. This made debugging
> more tedious than it could have been. So this seems like an overall
> improvement to me.
> 
> B4 is picking up all of the recent patches to the ad7124 driver as
> dependencies, but really the only one that is actually needed for this
> to apply cleanly is the "iio: adc: ad7124: drop nr field" series.
> 
> [1]: https://lore.kernel.org/linux-iio/20250722-iio-adc-ad7173-fix-setup-use-limits-v2-1-8e96bdb72a9c@baylibre.com/
> [2]: https://lore.kernel.org/linux-iio/bcf599e1-7816-4580-a2f9-039b0d3c0c99@baylibre.com/
> ---
>  drivers/iio/adc/ad7124.c | 246 ++++++++++++++++++++++-------------------------
>  1 file changed, 114 insertions(+), 132 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
> index 540bd80359763bc94934160e3388621bfe5ba9a1..7be524cba18400988086a34eb581df3ecdec0fb2 100644
> --- a/drivers/iio/adc/ad7124.c
> +++ b/drivers/iio/adc/ad7124.c
> @@ -110,6 +110,8 @@
>  #define AD7124_FILTER_SINGLE_CYCLE	BIT(16)
>  #define AD7124_FILTER_FS		GENMASK(10, 0)
>  
> +#define AD7124_CFG_SLOT_UNASSIGNED	~0U
> +
>  #define AD7124_MAX_CONFIGS	8
>  #define AD7124_MAX_CHANNELS	16
>  
> @@ -175,14 +177,13 @@ enum ad7124_filter_type {
>  };
>  
>  struct ad7124_channel_config {
> -	bool live;
>  	unsigned int cfg_slot;
>  	unsigned int requested_odr;
>  	unsigned int requested_odr_micro;
>  	/*
>  	 * Following fields are used to compare for equality. If you
>  	 * make adaptations in it, you most likely also have to adapt
> -	 * ad7124_find_similar_live_cfg(), too.
> +	 * ad7124_config_equal(), too.
>  	 */
>  	struct_group(config_props,
>  		enum ad7124_ref_sel refsel;
> @@ -214,14 +215,13 @@ struct ad7124_state {
>  	unsigned int adc_control;
>  	unsigned int num_channels;
>  	struct mutex cfgs_lock; /* lock for configs access */
> -	unsigned long cfg_slots_status; /* bitmap with slot status (1 means it is used) */
> +	u8 cfg_slot_use_count[AD7124_MAX_CONFIGS];
>  
>  	/*
>  	 * Stores the power-on reset value for the GAIN(x) registers which are
>  	 * needed for measurements at gain 1 (i.e. CONFIG(x).PGA == 0)
>  	 */
>  	unsigned int gain_default;
> -	DECLARE_KFIFO(live_cfgs_fifo, struct ad7124_channel_config *, AD7124_MAX_CONFIGS);
>  };
>  
>  static const struct ad7124_chip_info ad7124_4_chip_info = {
> @@ -365,9 +365,6 @@ static void ad7124_set_channel_odr(struct ad7124_state *st, unsigned int channel
>  		  cfg->requested_odr_micro * factor / MICRO;
>  	odr_sel_bits = clamp(DIV_ROUND_CLOSEST(fclk, divisor), 1, 2047);
>  
> -	if (odr_sel_bits != st->channels[channel].cfg.odr_sel_bits)
> -		st->channels[channel].cfg.live = false;
> -
>  	st->channels[channel].cfg.odr_sel_bits = odr_sel_bits;
>  }
>  
> @@ -402,61 +399,6 @@ static int ad7124_get_3db_filter_factor(struct ad7124_state *st,
>  	}
>  }
>  
> -static struct ad7124_channel_config *ad7124_find_similar_live_cfg(struct ad7124_state *st,
> -								  struct ad7124_channel_config *cfg)
> -{
> -	struct ad7124_channel_config *cfg_aux;
> -	int i;
> -
> -	/*
> -	 * This is just to make sure that the comparison is adapted after
> -	 * struct ad7124_channel_config was changed.
> -	 */
> -	static_assert(sizeof_field(struct ad7124_channel_config, config_props) ==
> -		      sizeof(struct {
> -				     enum ad7124_ref_sel refsel;
> -				     bool bipolar;
> -				     bool buf_positive;
> -				     bool buf_negative;
> -				     unsigned int vref_mv;
> -				     unsigned int pga_bits;
> -				     unsigned int odr_sel_bits;
> -				     enum ad7124_filter_type filter_type;
> -				     unsigned int calibration_offset;
> -				     unsigned int calibration_gain;
> -			     }));
> -
> -	for (i = 0; i < st->num_channels; i++) {
> -		cfg_aux = &st->channels[i].cfg;
> -
> -		if (cfg_aux->live &&
> -		    cfg->refsel == cfg_aux->refsel &&
> -		    cfg->bipolar == cfg_aux->bipolar &&
> -		    cfg->buf_positive == cfg_aux->buf_positive &&
> -		    cfg->buf_negative == cfg_aux->buf_negative &&
> -		    cfg->vref_mv == cfg_aux->vref_mv &&
> -		    cfg->pga_bits == cfg_aux->pga_bits &&
> -		    cfg->odr_sel_bits == cfg_aux->odr_sel_bits &&
> -		    cfg->filter_type == cfg_aux->filter_type &&
> -		    cfg->calibration_offset == cfg_aux->calibration_offset &&
> -		    cfg->calibration_gain == cfg_aux->calibration_gain)
> -			return cfg_aux;
> -	}
> -
> -	return NULL;
> -}
> -
> -static int ad7124_find_free_config_slot(struct ad7124_state *st)
> -{
> -	unsigned int free_cfg_slot;
> -
> -	free_cfg_slot = find_first_zero_bit(&st->cfg_slots_status, AD7124_MAX_CONFIGS);
> -	if (free_cfg_slot == AD7124_MAX_CONFIGS)
> -		return -1;
> -
> -	return free_cfg_slot;
> -}
> -
>  /* Only called during probe, so dev_err_probe() can be used */
>  static int ad7124_init_config_vref(struct ad7124_state *st, struct ad7124_channel_config *cfg)
>  {
> @@ -485,6 +427,21 @@ static int ad7124_init_config_vref(struct ad7124_state *st, struct ad7124_channe
>  	}
>  }
>  
> +static bool ad7124_config_equal(struct ad7124_channel_config *a,
> +				struct ad7124_channel_config *b)
> +{
> +	return a->refsel == b->refsel &&
> +	       a->bipolar == b->bipolar &&
> +	       a->buf_positive == b->buf_positive &&
> +	       a->buf_negative == b->buf_negative &&
> +	       a->vref_mv == b->vref_mv &&
> +	       a->pga_bits == b->pga_bits &&
> +	       a->odr_sel_bits == b->odr_sel_bits &&
> +	       a->filter_type == b->filter_type &&
> +	       a->calibration_offset == b->calibration_offset &&
> +	       a->calibration_gain == b->calibration_gain;
> +}
> +
>  static int ad7124_write_config(struct ad7124_state *st, struct ad7124_channel_config *cfg,
>  			       unsigned int cfg_slot)
>  {
> @@ -493,13 +450,13 @@ static int ad7124_write_config(struct ad7124_state *st, struct ad7124_channel_co
>  	unsigned int post = 0;
>  	int ret;
>  
> -	cfg->cfg_slot = cfg_slot;
> -
> -	ret = ad_sd_write_reg(&st->sd, AD7124_OFFSET(cfg->cfg_slot), 3, cfg->calibration_offset);
> +	ret = ad_sd_write_reg(&st->sd, AD7124_OFFSET(cfg_slot), 3,
> +			      cfg->calibration_offset);
>  	if (ret)
>  		return ret;
>  
> -	ret = ad_sd_write_reg(&st->sd, AD7124_GAIN(cfg->cfg_slot), 3, cfg->calibration_gain);
> +	ret = ad_sd_write_reg(&st->sd, AD7124_GAIN(cfg_slot), 3,
> +			      cfg->calibration_gain);
>  	if (ret)
>  		return ret;
>  
> @@ -509,7 +466,7 @@ static int ad7124_write_config(struct ad7124_state *st, struct ad7124_channel_co
>  		(cfg->buf_negative ? AD7124_CONFIG_AIN_BUFM : 0) |
>  		FIELD_PREP(AD7124_CONFIG_PGA, cfg->pga_bits);
>  
> -	ret = ad_sd_write_reg(&st->sd, AD7124_CONFIG(cfg->cfg_slot), 2, val);
> +	ret = ad_sd_write_reg(&st->sd, AD7124_CONFIG(cfg_slot), 2, val);
>  	if (ret < 0)
>  		return ret;
>  
> @@ -561,7 +518,7 @@ static int ad7124_write_config(struct ad7124_state *st, struct ad7124_channel_co
>  	 * would be 1 and we would get a faster sampling frequency than what
>  	 * was requested.
>  	 */
> -	return ad_sd_write_reg(&st->sd, AD7124_FILTER(cfg->cfg_slot), 3,
> +	return ad_sd_write_reg(&st->sd, AD7124_FILTER(cfg_slot), 3,
>  			       FIELD_PREP(AD7124_FILTER_FILTER, filter) |
>  			       FIELD_PREP(AD7124_FILTER_REJ60, rej60) |
>  			       FIELD_PREP(AD7124_FILTER_POST_FILTER, post) |
> @@ -569,83 +526,101 @@ static int ad7124_write_config(struct ad7124_state *st, struct ad7124_channel_co
>  			       FIELD_PREP(AD7124_FILTER_FS, cfg->odr_sel_bits));
>  }
>  
> -static struct ad7124_channel_config *ad7124_pop_config(struct ad7124_state *st)
> +/**
> + * ad7124_request_config_slot() - Request a config slot for a given config
> + * @st:		Driver instance
> + * @channel:	Channel to request a slot for
> + *
> + * Tries to find a matching config already in use, otherwise finds a free
> + * slot. If this function returns successfully, the use count for the slot is
> + * increased and the slot number is stored in cfg->cfg_slot.
> + *
> + * The slot must be released again with ad7124_release_config_slot() when no
> + * longer needed.
> + *
> + * Returns: 0 if a slot was successfully assigned, -EUSERS if no slot is
> + * available or other error if SPI communication fails.
> + */
> +static int ad7124_request_config_slot(struct ad7124_state *st, u8 channel)
>  {
> -	struct ad7124_channel_config *lru_cfg;
> -	struct ad7124_channel_config *cfg;
> -	int ret;
> -	int i;
> +	unsigned int i, j;
>  
> -	/*
> -	 * Pop least recently used config from the fifo
> -	 * in order to make room for the new one
> -	 */
> -	ret = kfifo_get(&st->live_cfgs_fifo, &lru_cfg);
> -	if (ret <= 0)
> -		return NULL;
> +	/* See if we already have a matching config. */
> +	for (i = 0; i < AD7124_MAX_CONFIGS; i++) {
> +		if (st->cfg_slot_use_count[i] == 0)
> +			continue;

Aren't you filling them in order?  If so can anything match after this?
Perhaps break?

>  
> -	lru_cfg->live = false;
> +		/* Find the first channel using this slot, if any. */

Confusing comment.  Didn't previous check rule out cas where no one is
using it?

> +		for (j = 0; j < st->num_channels; j++) {
> +			if (st->channels[j].cfg.cfg_slot != i)
> +				continue;
>  
> -	/* mark slot as free */
> -	assign_bit(lru_cfg->cfg_slot, &st->cfg_slots_status, 0);
> +			/*
> +			 * If there is a match, increase the use count and share
> +			 * the slot with the requesting channel.
> +			 */
> +			if (ad7124_config_equal(&st->channels[j].cfg,
> +						&st->channels[channel].cfg)) {
> +				st->cfg_slot_use_count[i]++;
> +				st->channels[channel].cfg.cfg_slot = i;
>  
> -	/* invalidate all other configs that pointed to this one */
> -	for (i = 0; i < st->num_channels; i++) {
> -		cfg = &st->channels[i].cfg;
> +				dev_dbg(&st->sd.spi->dev,
> +					"Re-using config slot %u for channel %u, use count now %u\n",
> +					i, channel, st->cfg_slot_use_count[i]);
> +
> +				return 0;
> +			}
> +		}
> +	}
>  
> -		if (cfg->cfg_slot == lru_cfg->cfg_slot)
> -			cfg->live = false;
> +	/* Find a free slot and write setup to ADC. */
> +	for (i = 0; i < AD7124_MAX_CONFIGS; i++) {
> +		if (st->cfg_slot_use_count[i] == 0) {

If they are being filled in order, can we just keep track of number used
and shortcut this loop?

> +			st->cfg_slot_use_count[i]++;
> +			st->channels[channel].cfg.cfg_slot = i;
> +
> +			dev_dbg(&st->sd.spi->dev,
> +				"Allocated config slot %u for channel %u, use count now %u\n",
> +				i, channel, st->cfg_slot_use_count[i]);
> +
> +			return ad7124_write_config(st, &st->channels[channel].cfg, i);
> +		}
>  	}
>  
> -	return lru_cfg;
> +	/* All slots are used with different configurations. */
> +	return -EUSERS;
>  }
>  
> -static int ad7124_push_config(struct ad7124_state *st, struct ad7124_channel_config *cfg)
> +static void ad7124_release_config_slot(struct ad7124_state *st, u8 channel)
>  {
> -	struct ad7124_channel_config *lru_cfg;
> -	int free_cfg_slot;
> -
> -	free_cfg_slot = ad7124_find_free_config_slot(st);
> -	if (free_cfg_slot >= 0) {
> -		/* push the new config in configs queue */
> -		kfifo_put(&st->live_cfgs_fifo, cfg);
> -	} else {
> -		/* pop one config to make room for the new one */
> -		lru_cfg = ad7124_pop_config(st);
> -		if (!lru_cfg)
> -			return -EINVAL;
> +	unsigned int slot = st->channels[channel].cfg.cfg_slot;
>  
> -		/* push the new config in configs queue */
> -		free_cfg_slot = lru_cfg->cfg_slot;
> -		kfifo_put(&st->live_cfgs_fifo, cfg);
> -	}
> +	/*
> +	 * All of these conditions can happen at probe when all channels are
> +	 * disabled. Otherwise, they should not happen normally.
> +	 */
> +	if (channel >= st->num_channels || slot == AD7124_CFG_SLOT_UNASSIGNED ||
> +	    st->cfg_slot_use_count[slot] == 0)
> +		return;
>  
> -	/* mark slot as used */
> -	assign_bit(free_cfg_slot, &st->cfg_slots_status, 1);
> +	st->cfg_slot_use_count[slot]--;
> +	st->channels[channel].cfg.cfg_slot = AD7124_CFG_SLOT_UNASSIGNED;
>  
> -	return ad7124_write_config(st, cfg, free_cfg_slot);
> +	dev_dbg(&st->sd.spi->dev,
> +		"Released config slot %u for channel %u, use count now %u\n",
> +		slot, channel, st->cfg_slot_use_count[slot]);
>  }
>  
>  static int ad7124_prepare_read(struct ad7124_state *st, int address)
>  {
>  	struct ad7124_channel_config *cfg = &st->channels[address].cfg;
> -	struct ad7124_channel_config *live_cfg;
> +	int ret;
>  
> -	/*
> -	 * Before doing any reads assign the channel a configuration.
> -	 * Check if channel's config is on the device
> -	 */
> -	if (!cfg->live) {
> -		/* check if config matches another one */
> -		live_cfg = ad7124_find_similar_live_cfg(st, cfg);
> -		if (!live_cfg)
> -			ad7124_push_config(st, cfg);
> -		else
> -			cfg->cfg_slot = live_cfg->cfg_slot;
> -	}
> +	ret = ad7124_request_config_slot(st, address);
> +	if (ret)
> +		return ret;
>  
>  	/* point channel to the config slot and enable */
> -	cfg->live = true;
>  	return ad_sd_write_reg(&st->sd, AD7124_CHANNEL(address), 2,
>  			       st->channels[address].ain |
>  			       FIELD_PREP(AD7124_CHANNEL_SETUP, cfg->cfg_slot) |
> @@ -688,6 +663,8 @@ static int ad7124_disable_one(struct ad_sigma_delta *sd, unsigned int chan)
>  {
>  	struct ad7124_state *st = container_of(sd, struct ad7124_state, sd);
>  
> +	ad7124_release_config_slot(st, chan);
> +
>  	/* The relevant thing here is that AD7124_CHANNEL_ENABLE is cleared. */
>  	return ad_sd_write_reg(&st->sd, AD7124_CHANNEL(chan), 2, 0);
>  }
> @@ -909,9 +886,6 @@ static int ad7124_write_raw(struct iio_dev *indio_dev,
>  		gain = DIV_ROUND_CLOSEST(res, val2);
>  		res = ad7124_find_closest_match(ad7124_gain, ARRAY_SIZE(ad7124_gain), gain);
>  
> -		if (st->channels[chan->address].cfg.pga_bits != res)
> -			st->channels[chan->address].cfg.live = false;
> -
>  		st->channels[chan->address].cfg.pga_bits = res;
>  		return 0;
>  	default:
> @@ -1054,7 +1028,11 @@ static int ad7124_syscalib_locked(struct ad7124_state *st, const struct iio_chan
>  		if (ret < 0)
>  			return ret;
>  
> -		ret = ad_sd_read_reg(&st->sd, AD7124_OFFSET(ch->cfg.cfg_slot), 3,
> +		/*
> +		 * Making the assumption that a single conversion will always
> +		 * use configuration slot 0 for the OFFSET/GAIN registers.
> +		 */
> +		ret = ad_sd_read_reg(&st->sd, AD7124_OFFSET(0), 3,
>  				     &ch->cfg.calibration_offset);
>  		if (ret < 0)
>  			return ret;
> @@ -1069,7 +1047,7 @@ static int ad7124_syscalib_locked(struct ad7124_state *st, const struct iio_chan
>  		if (ret < 0)
>  			return ret;
>  
> -		ret = ad_sd_read_reg(&st->sd, AD7124_GAIN(ch->cfg.cfg_slot), 3,
> +		ret = ad_sd_read_reg(&st->sd, AD7124_GAIN(0), 3,
>  				     &ch->cfg.calibration_gain);
>  		if (ret < 0)
>  			return ret;
> @@ -1160,7 +1138,6 @@ static int ad7124_set_filter_type_attr(struct iio_dev *dev,
>  
>  	guard(mutex)(&st->cfgs_lock);
>  
> -	cfg->live = false;
>  	cfg->filter_type = value;
>  	ad7124_set_channel_odr(st, chan->address);
>  
> @@ -1479,7 +1456,6 @@ static int ad7124_setup(struct ad7124_state *st)
>  	if (ret)
>  		return ret;
>  
> -	INIT_KFIFO(st->live_cfgs_fifo);
>  	for (i = 0; i < st->num_channels; i++) {
>  		struct ad7124_channel_config *cfg = &st->channels[i].cfg;
>  
> @@ -1487,6 +1463,8 @@ static int ad7124_setup(struct ad7124_state *st)
>  		if (ret < 0)
>  			return ret;
>  
> +		cfg->cfg_slot = AD7124_CFG_SLOT_UNASSIGNED;
> +
>  		/* Default filter type on the ADC after reset. */
>  		cfg->filter_type = AD7124_FILTER_TYPE_SINC4;
>  
> @@ -1546,7 +1524,7 @@ static int __ad7124_calibrate_all(struct ad7124_state *st, struct iio_dev *indio
>  			 * ad_sigma_delta_set_channel() -> ad7124_set_channel()
>  			 * -> ad7124_prepare_read().
>  			 */
> -			ret = ad_sd_read_reg(&st->sd, AD7124_GAIN(st->channels[i].cfg.cfg_slot), 3,
> +			ret = ad_sd_read_reg(&st->sd, AD7124_GAIN(0), 3,
>  					     &st->channels[i].cfg.calibration_gain);
>  			if (ret < 0)
>  				return ret;
> @@ -1556,7 +1534,11 @@ static int __ad7124_calibrate_all(struct ad7124_state *st, struct iio_dev *indio
>  		if (ret < 0)
>  			return ret;
>  
> -		ret = ad_sd_read_reg(&st->sd, AD7124_OFFSET(st->channels[i].cfg.cfg_slot), 3,
> +		/*
> +		 * Making the assumption that a single conversion will always
> +		 * use configuration slot 0 for the OFFSET/GAIN registers.
> +		 */
> +		ret = ad_sd_read_reg(&st->sd, AD7124_OFFSET(0), 3,
>  				     &st->channels[i].cfg.calibration_offset);
>  		if (ret < 0)
>  			return ret;
> 
> ---
> base-commit: 561285d048053fec8a3d6d1e3ddc60df11c393a0
> change-id: 20250917-iio-adc-ad7124-change-setup-reg-allocation-strategy-cd1f6bcd8415
> prerequisite-change-id: 20250917-iio-adc-ad7124-drop-nr-field-518102218a61:v1
> prerequisite-patch-id: b03f80b570aa51fc82a54806345340d6453be0eb
> prerequisite-patch-id: 48e753e349ffefa570a03e7b1ddf59477d40feec
> prerequisite-patch-id: 819998144ef98c7e4bfae5237eb82a3d064f716e
> prerequisite-patch-id: e9d7d9560259b5aefb9048f02885bfcc43fd05b8
> 
> Best regards,


