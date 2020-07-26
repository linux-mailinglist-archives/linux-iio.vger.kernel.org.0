Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2A1C22DECB
	for <lists+linux-iio@lfdr.de>; Sun, 26 Jul 2020 13:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbgGZLxR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 26 Jul 2020 07:53:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:36008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725972AbgGZLxR (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 26 Jul 2020 07:53:17 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 367E92065E;
        Sun, 26 Jul 2020 11:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595764395;
        bh=j48Tafeo2upwoKndJ1W6B1E1YE988FcyMIcVN2HcnGg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=2WaImpLxeXP1S/BZAAFdFXgAmCftBbHWnywwai7p2PB/C4aaozpOv4gXsChkqkDaf
         SNbFx/uUEMwMQF36aKuiJ2rTRSajckQeUfpgAI3ua+CteaAYpnjfl8sBHddpH8Jdts
         rj1DVbQxXQ2Vuh0d4quc3c3RnG9ovqv+w7vZ+v/k=
Date:   Sun, 26 Jul 2020 12:53:09 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Daniel Campello <campello@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Enrico Granata <egranata@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH] iio: sx9310: Fixes dropped on initial commit
Message-ID: <20200726125309.4f26c044@archlinux>
In-Reply-To: <20200724183954.1.I2e29ae25368ba8a72a9e44121cfbc36ead8ecc6b@changeid>
References: <20200724183954.1.I2e29ae25368ba8a72a9e44121cfbc36ead8ecc6b@changeid>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 24 Jul 2020 18:40:26 -0600
Daniel Campello <campello@chromium.org> wrote:

> This patch brings back fixes on v9 of initial patch that got dropped
> when v8 was taken instead.

Oops. Not quite sure what happened there and I can't even find a record
of me saying I was applying v8.  Sorry about that.

>   - Updated Copyright
>   - Updated macro definitions
>   - Simplified return condition checks
>   - Removed ACPI and of table macros
> 
> Signed-off-by: Daniel Campello <campello@chromium.org>

A few minor things I noticed whilst going through this.
As Andy pointed out it needs breaking down into a series of patches.

Please order any changes that are bug fixes at the front.

Given we also have Stephen's series in flight, it would be great if you
also pick up his patches to send me one combined series.  That way
all the merge issues should be resolved by people who can test
the changes!

Thanks,

Jonathan

> ---
> 
>  drivers/iio/proximity/sx9310.c | 377 ++++++++++++++++-----------------
>  1 file changed, 177 insertions(+), 200 deletions(-)
> 
> diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
> index d161f3061e353d..55b3d5b83e5a6a 100644
> --- a/drivers/iio/proximity/sx9310.c
> +++ b/drivers/iio/proximity/sx9310.c
> @@ -1,13 +1,13 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
> - * Copyright 2018 Google LLC.
> + * Copyright 2020 Google LLC.
>   *
>   * Driver for Semtech's SX9310/SX9311 capacitive proximity/button solution.
>   * Based on SX9500 driver and Semtech driver using the input framework
>   * <https://my.syncplicity.com/share/teouwsim8niiaud/
>   *          linux-driver-SX9310_NoSmartHSensing>.
> - * Reworked April 2019 by Evan Green <evgreen@chromium.org>
> - * and January 2020 by Daniel Campello <campello@chromium.org>
> + * Reworked in April 2019 by Evan Green <evgreen@chromium.org>
> + * and in January 2020 by Daniel Campello <campello@chromium.org>.
>   */
> 
>  #include <linux/acpi.h>
> @@ -16,7 +16,6 @@
>  #include <linux/irq.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> -#include <linux/of.h>
>  #include <linux/pm.h>
>  #include <linux/regmap.h>
>  #include <linux/slab.h>
> @@ -33,45 +32,45 @@
>  #define SX9310_REG_IRQ_SRC				0x00
>  #define SX9310_REG_STAT0				0x01
>  #define SX9310_REG_STAT1				0x02
> +#define SX9310_REG_STAT1_COMPSTAT_MASK			GENMASK(3, 0)
>  #define SX9310_REG_IRQ_MSK				0x03
>  #define   SX9310_CONVDONE_IRQ				BIT(3)
>  #define   SX9310_FAR_IRQ				BIT(5)
>  #define   SX9310_CLOSE_IRQ				BIT(6)
> -#define   SX9310_EVENT_IRQ				(SX9310_FAR_IRQ | \
> -							 SX9310_CLOSE_IRQ)
>  #define SX9310_REG_IRQ_FUNC				0x04
> 
>  #define SX9310_REG_PROX_CTRL0				0x10
> -#define   SX9310_REG_PROX_CTRL0_PROXSTAT2		0x10
> -#define   SX9310_REG_PROX_CTRL0_EN_MASK			0x0F
> +#define   SX9310_REG_PROX_CTRL0_SENSOREN_MASK		GENMASK(3, 0)
> +#define   SX9310_REG_PROX_CTRL0_SCANPERIOD_MASK		GENMASK(7, 4)
> +#define   SX9310_REG_PROX_CTRL0_SCANPERIOD_SHIFT	4
> +#define   SX9310_REG_PROX_CTRL0_SCANPERIOD_15MS		0x01
>  #define SX9310_REG_PROX_CTRL1				0x11
>  #define SX9310_REG_PROX_CTRL2				0x12
> -#define   SX9310_REG_PROX_CTRL2_COMBMODE_ALL		0x80
> -#define   SX9310_REG_PROX_CTRL2_SHIELDEN_DYNAMIC	0x04
> +#define   SX9310_REG_PROX_CTRL2_COMBMODE_CS1_CS2	(0x02 << 6)
> +#define   SX9310_REG_PROX_CTRL2_SHIELDEN_DYNAMIC	(0x01 << 2)
>  #define SX9310_REG_PROX_CTRL3				0x13
> -#define   SX9310_REG_PROX_CTRL3_GAIN0_X8		0x0c
> +#define   SX9310_REG_PROX_CTRL3_GAIN0_X8		(0x03 << 2)
>  #define   SX9310_REG_PROX_CTRL3_GAIN12_X4		0x02
>  #define SX9310_REG_PROX_CTRL4				0x14
>  #define   SX9310_REG_PROX_CTRL4_RESOLUTION_FINEST	0x07
>  #define SX9310_REG_PROX_CTRL5				0x15
> -#define   SX9310_REG_PROX_CTRL5_RANGE_SMALL		0xc0
> -#define   SX9310_REG_PROX_CTRL5_STARTUPSENS_CS1		0x04
> +#define   SX9310_REG_PROX_CTRL5_RANGE_SMALL		(0x03 << 6)
> +#define   SX9310_REG_PROX_CTRL5_STARTUPSENS_CS1		(0x01 << 2)
>  #define   SX9310_REG_PROX_CTRL5_RAWFILT_1P25		0x02
>  #define SX9310_REG_PROX_CTRL6				0x16
> -#define   SX9310_REG_PROX_CTRL6_COMP_COMMON		0x20
> +#define   SX9310_REG_PROX_CTRL6_AVGTHRESH_DEFAULT	0x20
>  #define SX9310_REG_PROX_CTRL7				0x17
> -#define   SX9310_REG_PROX_CTRL7_AVGNEGFILT_2		0x08
> +#define   SX9310_REG_PROX_CTRL7_AVGNEGFILT_2		(0x01 << 3)
>  #define   SX9310_REG_PROX_CTRL7_AVGPOSFILT_512		0x05
>  #define SX9310_REG_PROX_CTRL8				0x18
>  #define SX9310_REG_PROX_CTRL9				0x19
> -#define   SX9310_REG_PROX_CTRL8_9_PTHRESH12_28		0x40
> -#define   SX9310_REG_PROX_CTRL8_9_PTHRESH_96		0x88
> +#define   SX9310_REG_PROX_CTRL8_9_PTHRESH_28		(0x08 << 3)
> +#define   SX9310_REG_PROX_CTRL8_9_PTHRESH_96		(0x11 << 3)
>  #define   SX9310_REG_PROX_CTRL8_9_BODYTHRESH_900	0x03
>  #define   SX9310_REG_PROX_CTRL8_9_BODYTHRESH_1500	0x05
>  #define SX9310_REG_PROX_CTRL10				0x1a
> -#define   SX9310_REG_PROX_CTRL10_HYST_6PCT		0x10
> -#define   SX9310_REG_PROX_CTRL10_CLOSE_DEBOUNCE_8	0x12
> -#define   SX9310_REG_PROX_CTRL10_FAR_DEBOUNCE_8		0x03
> +#define   SX9310_REG_PROX_CTRL10_HYST_6PCT		(0x01 << 4)
> +#define   SX9310_REG_PROX_CTRL10_FAR_DEBOUNCE_2		0x01
>  #define SX9310_REG_PROX_CTRL11				0x1b
>  #define SX9310_REG_PROX_CTRL12				0x1c
>  #define SX9310_REG_PROX_CTRL13				0x1d
> @@ -82,8 +81,8 @@
>  #define SX9310_REG_PROX_CTRL18				0x22
>  #define SX9310_REG_PROX_CTRL19				0x23
>  #define SX9310_REG_SAR_CTRL0				0x2a
> -#define   SX9310_REG_SAR_CTRL0_SARDEB_4_SAMPLES		0x40
> -#define   SX9310_REG_SAR_CTRL0_SARHYST_8		0x10
> +#define   SX9310_REG_SAR_CTRL0_SARDEB_4_SAMPLES		(0x02 << 5)
> +#define   SX9310_REG_SAR_CTRL0_SARHYST_8		(0x02 << 3)
>  #define SX9310_REG_SAR_CTRL1				0x2b
>  /* Each increment of the slope register is 0.0078125. */
>  #define   SX9310_REG_SAR_CTRL1_SLOPE(_hnslope)		(_hnslope / 78125)
> @@ -91,39 +90,27 @@
>  #define   SX9310_REG_SAR_CTRL2_SAROFFSET_DEFAULT	0x3c
> 
>  #define SX9310_REG_SENSOR_SEL				0x30
> -

Prune out changes that don't really matter like these new line removals.

>  #define SX9310_REG_USE_MSB				0x31
>  #define SX9310_REG_USE_LSB				0x32
> -
>  #define SX9310_REG_AVG_MSB				0x33
>  #define SX9310_REG_AVG_LSB				0x34
> -
>  #define SX9310_REG_DIFF_MSB				0x35
>  #define SX9310_REG_DIFF_LSB				0x36
> -
>  #define SX9310_REG_OFFSET_MSB				0x37
>  #define SX9310_REG_OFFSET_LSB				0x38
> -
>  #define SX9310_REG_SAR_MSB				0x39
>  #define SX9310_REG_SAR_LSB				0x3a
> -
> -#define SX9310_REG_I2CADDR				0x40
> +#define SX9310_REG_I2C_ADDR				0x40
>  #define SX9310_REG_PAUSE				0x41
>  #define SX9310_REG_WHOAMI				0x42
>  #define   SX9310_WHOAMI_VALUE				0x01
>  #define   SX9311_WHOAMI_VALUE				0x02
> -
>  #define SX9310_REG_RESET				0x7f
>  #define   SX9310_SOFT_RESET				0xde
> 
> -#define SX9310_SCAN_PERIOD_MASK				GENMASK(7, 4)
> -#define SX9310_SCAN_PERIOD_SHIFT			4
> -
> -#define SX9310_COMPSTAT_MASK				GENMASK(3, 0)
> 
>  /* 4 hardware channels, as defined in STAT0: COMB, CS2, CS1 and CS0. */
>  #define SX9310_NUM_CHANNELS				4
> -#define SX9310_CHAN_ENABLED_MASK			GENMASK(3, 0)
> 
>  struct sx9310_data {
>  	/* Serialize access to registers and channel configuration */
> @@ -137,12 +124,12 @@ struct sx9310_data {
>  	 */
>  	bool prox_stat[SX9310_NUM_CHANNELS];
>  	bool trigger_enabled;
> -	__be16 buffer[SX9310_NUM_CHANNELS +
> -		      4]; /* 64-bit data + 64-bit timestamp */
> +	/* 64-bit data + 64-bit timestamp buffer */
> +	__be16 buffer[SX9310_NUM_CHANNELS + 4];

Needs __aligned(8) to ensure that the timestamp is correctly aligned
when we call push_to_buffers.  Might as well fix that whilst we are here.

>  	/* Remember enabled channels and sample rate during suspend. */
>  	unsigned int suspend_ctrl0;
>  	struct completion completion;
> -	unsigned int chan_read, chan_event;
> +	unsigned long chan_read, chan_event;
>  	int channel_users[SX9310_NUM_CHANNELS];
>  	int whoami;
>  };
> @@ -251,7 +238,7 @@ static const struct regmap_range sx9310_readable_reg_ranges[] = {
>  	regmap_reg_range(SX9310_REG_PROX_CTRL0, SX9310_REG_PROX_CTRL19),
>  	regmap_reg_range(SX9310_REG_SAR_CTRL0, SX9310_REG_SAR_CTRL2),
>  	regmap_reg_range(SX9310_REG_SENSOR_SEL, SX9310_REG_SAR_LSB),
> -	regmap_reg_range(SX9310_REG_I2CADDR, SX9310_REG_WHOAMI),
> +	regmap_reg_range(SX9310_REG_I2C_ADDR, SX9310_REG_WHOAMI),
>  	regmap_reg_range(SX9310_REG_RESET, SX9310_REG_RESET),
>  };
> 
> @@ -285,15 +272,16 @@ static const struct regmap_config sx9310_regmap_config = {
>  };
> 
>  static int sx9310_update_chan_en(struct sx9310_data *data,
> -				 unsigned int chan_read,
> -				 unsigned int chan_event)
> +				 unsigned long chan_read,
> +				 unsigned long chan_event)
>  {
>  	int ret;
> +	unsigned long channels = chan_read | chan_event;
> 
> -	if ((data->chan_read | data->chan_event) != (chan_read | chan_event)) {
> +	if ((data->chan_read | data->chan_event) != channels) {
>  		ret = regmap_update_bits(data->regmap, SX9310_REG_PROX_CTRL0,
> -					 SX9310_CHAN_ENABLED_MASK,
> -					 chan_read | chan_event);
> +					 SX9310_REG_PROX_CTRL0_SENSOREN_MASK,
> +					 channels);
>  		if (ret)
>  			return ret;
>  	}
> @@ -342,10 +330,10 @@ static int sx9310_read_prox_data(struct sx9310_data *data,
>  	int ret;
> 
>  	ret = regmap_write(data->regmap, SX9310_REG_SENSOR_SEL, chan->channel);
> -	if (ret < 0)
> +	if (ret)
>  		return ret;
> 
> -	return regmap_bulk_read(data->regmap, chan->address, val, 2);
> +	return regmap_bulk_read(data->regmap, chan->address, val, sizeof(*val));
>  }
> 
>  /*
> @@ -358,10 +346,11 @@ static int sx9310_wait_for_sample(struct sx9310_data *data)
>  	unsigned int val;
> 
>  	ret = regmap_read(data->regmap, SX9310_REG_PROX_CTRL0, &val);
> -	if (ret < 0)
> +	if (ret)
>  		return ret;
> 
> -	val = (val & SX9310_SCAN_PERIOD_MASK) >> SX9310_SCAN_PERIOD_SHIFT;
> +	val = (val & SX9310_REG_PROX_CTRL0_SCANPERIOD_MASK) >>
> +	      SX9310_REG_PROX_CTRL0_SCANPERIOD_SHIFT;
> 
>  	msleep(sx9310_scan_period_table[val]);
> 
> @@ -371,22 +360,24 @@ static int sx9310_wait_for_sample(struct sx9310_data *data)
>  static int sx9310_read_proximity(struct sx9310_data *data,
>  				 const struct iio_chan_spec *chan, int *val)
>  {
> -	int ret = 0;
> +	int ret;
>  	__be16 rawval;
> 
>  	mutex_lock(&data->mutex);
> 
>  	ret = sx9310_get_read_channel(data, chan->channel);
> -	if (ret < 0)
> +	if (ret)
>  		goto out;
> 
> -	ret = sx9310_enable_irq(data, SX9310_CONVDONE_IRQ);
> -	if (ret < 0)
> -		goto out_put_channel;
> +	if (data->client->irq) {
> +		ret = sx9310_enable_irq(data, SX9310_CONVDONE_IRQ);
> +		if (ret)
> +			goto out_put_channel;
> +	}
> 
>  	mutex_unlock(&data->mutex);
> 
> -	if (data->client->irq > 0) {
> +	if (data->client->irq) {
>  		ret = wait_for_completion_interruptible(&data->completion);
>  		reinit_completion(&data->completion);
>  	} else {
> @@ -395,22 +386,24 @@ static int sx9310_read_proximity(struct sx9310_data *data,
> 
>  	mutex_lock(&data->mutex);
> 
> -	if (ret < 0)
> +	if (ret)
>  		goto out_disable_irq;
> 
>  	ret = sx9310_read_prox_data(data, chan, &rawval);
> -	if (ret < 0)
> +	if (ret)
>  		goto out_disable_irq;
> 
>  	*val = sign_extend32(be16_to_cpu(rawval),
> -			     (chan->address == SX9310_REG_DIFF_MSB ? 11 : 15));
> +			     chan->address == SX9310_REG_DIFF_MSB ? 11 : 15);
> 
> -	ret = sx9310_disable_irq(data, SX9310_CONVDONE_IRQ);
> -	if (ret < 0)
> -		goto out_put_channel;
> +	if (data->client->irq) {
> +		ret = sx9310_disable_irq(data, SX9310_CONVDONE_IRQ);
> +		if (ret)
> +			goto out_put_channel;
> +	}
> 
>  	ret = sx9310_put_read_channel(data, chan->channel);
> -	if (ret < 0)
> +	if (ret)
>  		goto out;
> 
>  	mutex_unlock(&data->mutex);
> @@ -418,7 +411,8 @@ static int sx9310_read_proximity(struct sx9310_data *data,
>  	return IIO_VAL_INT;
> 
>  out_disable_irq:
> -	sx9310_disable_irq(data, SX9310_CONVDONE_IRQ);
> +	if (data->client->irq)
> +		sx9310_disable_irq(data, SX9310_CONVDONE_IRQ);
>  out_put_channel:
>  	sx9310_put_read_channel(data, chan->channel);
>  out:
> @@ -430,12 +424,14 @@ static int sx9310_read_proximity(struct sx9310_data *data,
>  static int sx9310_read_samp_freq(struct sx9310_data *data, int *val, int *val2)
>  {
>  	unsigned int regval;
> -	int ret = regmap_read(data->regmap, SX9310_REG_PROX_CTRL0, &regval);
> +	int ret;
> 
> -	if (ret < 0)
> +	ret = regmap_read(data->regmap, SX9310_REG_PROX_CTRL0, &regval);
> +	if (ret)
>  		return ret;
> 
> -	regval = (regval & SX9310_SCAN_PERIOD_MASK) >> SX9310_SCAN_PERIOD_SHIFT;
> +	regval = (regval & SX9310_REG_PROX_CTRL0_SCANPERIOD_MASK) >>
> +		 SX9310_REG_PROX_CTRL0_SCANPERIOD_SHIFT;
>  	*val = sx9310_samp_freq_table[regval].val;
>  	*val2 = sx9310_samp_freq_table[regval].val2;
> 
> @@ -483,8 +479,8 @@ static int sx9310_set_samp_freq(struct sx9310_data *data, int val, int val2)
>  	mutex_lock(&data->mutex);
> 
>  	ret = regmap_update_bits(data->regmap, SX9310_REG_PROX_CTRL0,
> -				 SX9310_SCAN_PERIOD_MASK,
> -				 i << SX9310_SCAN_PERIOD_SHIFT);
> +				 SX9310_REG_PROX_CTRL0_SCANPERIOD_MASK,
> +				 i << SX9310_REG_PROX_CTRL0_SCANPERIOD_SHIFT);
> 
>  	mutex_unlock(&data->mutex);
> 
> @@ -515,10 +511,9 @@ static irqreturn_t sx9310_irq_handler(int irq, void *private)
>  		iio_trigger_poll(data->trig);
> 
>  	/*
> -	 * Even if no event is enabled, we need to wake the thread to
> -	 * clear the interrupt state by reading SX9310_REG_IRQ_SRC.  It
> -	 * is not possible to do that here because regmap_read takes a
> -	 * mutex.
> +	 * Even if no event is enabled, we need to wake the thread to clear the
> +	 * interrupt state by reading SX9310_REG_IRQ_SRC.
> +	 * It is not possible to do that here because regmap_read takes a mutex.
>  	 */
>  	return IRQ_WAKE_THREAD;
>  }
> @@ -532,18 +527,18 @@ static void sx9310_push_events(struct iio_dev *indio_dev)
> 
>  	/* Read proximity state on all channels */
>  	ret = regmap_read(data->regmap, SX9310_REG_STAT0, &val);
> -	if (ret < 0) {
> +	if (ret) {
>  		dev_err(&data->client->dev, "i2c transfer error in irq\n");
>  		return;
>  	}
> 
> -	for (chan = 0; chan < SX9310_NUM_CHANNELS; chan++) {
> +	for_each_set_bit(chan, &data->chan_event, SX9310_NUM_CHANNELS) {
>  		int dir;
>  		u64 ev;
> -		bool new_prox = val & BIT(chan);
> +		bool new_prox;
> +
> +		new_prox = val & BIT(chan);
> 
> -		if (!(data->chan_event & BIT(chan)))
> -			continue;
>  		if (new_prox == data->prox_stat[chan])
>  			/* No change on this channel. */
>  			continue;
> @@ -567,12 +562,12 @@ static irqreturn_t sx9310_irq_thread_handler(int irq, void *private)
>  	mutex_lock(&data->mutex);
> 
>  	ret = regmap_read(data->regmap, SX9310_REG_IRQ_SRC, &val);
> -	if (ret < 0) {
> +	if (ret) {
>  		dev_err(&data->client->dev, "i2c transfer error in irq\n");
>  		goto out;
>  	}
> 
> -	if (val & SX9310_EVENT_IRQ)
> +	if (val & (SX9310_FAR_IRQ | SX9310_CLOSE_IRQ))
>  		sx9310_push_events(indio_dev);
> 
>  	if (val & SX9310_CONVDONE_IRQ)
> @@ -600,6 +595,7 @@ static int sx9310_write_event_config(struct iio_dev *indio_dev,
>  				     enum iio_event_direction dir, int state)
>  {
>  	struct sx9310_data *data = iio_priv(indio_dev);
> +	unsigned int eventirq = SX9310_FAR_IRQ | SX9310_CLOSE_IRQ;
>  	int ret;
> 
>  	/* If the state hasn't changed, there's nothing to do. */
> @@ -609,20 +605,20 @@ static int sx9310_write_event_config(struct iio_dev *indio_dev,
>  	mutex_lock(&data->mutex);
>  	if (state) {
>  		ret = sx9310_get_event_channel(data, chan->channel);
> -		if (ret < 0)
> +		if (ret)
>  			goto out_unlock;
>  		if (!(data->chan_event & ~BIT(chan->channel))) {
> -			ret = sx9310_enable_irq(data, SX9310_EVENT_IRQ);
> -			if (ret < 0)
> +			ret = sx9310_enable_irq(data, eventirq);
> +			if (ret)
>  				sx9310_put_event_channel(data, chan->channel);
>  		}
>  	} else {
>  		ret = sx9310_put_event_channel(data, chan->channel);
> -		if (ret < 0)
> +		if (ret)
>  			goto out_unlock;
>  		if (!data->chan_event) {
> -			ret = sx9310_disable_irq(data, SX9310_EVENT_IRQ);
> -			if (ret < 0)
> +			ret = sx9310_disable_irq(data, eventirq);
> +			if (ret)
>  				sx9310_get_event_channel(data, chan->channel);
>  		}
>  	}
> @@ -634,7 +630,7 @@ static int sx9310_write_event_config(struct iio_dev *indio_dev,
> 
>  static struct attribute *sx9310_attributes[] = {
>  	&iio_dev_attr_sampling_frequency_available.dev_attr.attr,
> -	NULL,
> +	NULL
>  };
> 
>  static const struct attribute_group sx9310_attribute_group = {
> @@ -661,7 +657,7 @@ static int sx9310_set_trigger_state(struct iio_trigger *trig, bool state)
>  		ret = sx9310_enable_irq(data, SX9310_CONVDONE_IRQ);
>  	else if (!data->chan_read)
>  		ret = sx9310_disable_irq(data, SX9310_CONVDONE_IRQ);
> -	if (ret < 0)
> +	if (ret)
>  		goto out;
> 
>  	data->trigger_enabled = state;
> @@ -690,7 +686,7 @@ static irqreturn_t sx9310_trigger_handler(int irq, void *private)
>  			 indio_dev->masklength) {
>  		ret = sx9310_read_prox_data(data, &indio_dev->channels[bit],
>  					    &val);
> -		if (ret < 0)
> +		if (ret)
>  			goto out;
> 
>  		data->buffer[i++] = val;
> @@ -710,13 +706,13 @@ static irqreturn_t sx9310_trigger_handler(int irq, void *private)
>  static int sx9310_buffer_preenable(struct iio_dev *indio_dev)
>  {
>  	struct sx9310_data *data = iio_priv(indio_dev);
> -	unsigned int channels = 0;
> +	unsigned long channels = 0;
>  	int bit, ret;
> 
>  	mutex_lock(&data->mutex);
>  	for_each_set_bit(bit, indio_dev->active_scan_mask,
>  			 indio_dev->masklength)
> -		channels |= BIT(indio_dev->channels[bit].channel);
> +		__set_bit(indio_dev->channels[bit].channel, &channels);
> 
>  	ret = sx9310_update_chan_en(data, channels, data->chan_event);
>  	mutex_unlock(&data->mutex);
> @@ -746,89 +742,77 @@ struct sx9310_reg_default {
>  	u8 def;
>  };
> 
> -#define SX_INIT(_reg, _def)			\
> -	{					\
> -		.reg = SX9310_REG_##_reg,	\
> -		.def = _def,			\
> -	}
> -
>  static const struct sx9310_reg_default sx9310_default_regs[] = {
> -	SX_INIT(IRQ_MSK, 0x00),
> -	SX_INIT(IRQ_FUNC, 0x00),
> +	{ SX9310_REG_IRQ_MSK, 0x00 },
> +	{ SX9310_REG_IRQ_FUNC, 0x00 },
>  	/*
>  	 * The lower 4 bits should not be set as it enable sensors measurements.
>  	 * Turning the detection on before the configuration values are set to
>  	 * good values can cause the device to return erroneous readings.
>  	 */
> -	SX_INIT(PROX_CTRL0, SX9310_REG_PROX_CTRL0_PROXSTAT2),
> -	SX_INIT(PROX_CTRL1, 0x00),
> -	SX_INIT(PROX_CTRL2, SX9310_REG_PROX_CTRL2_COMBMODE_ALL |
> -			    SX9310_REG_PROX_CTRL2_SHIELDEN_DYNAMIC),
> -	SX_INIT(PROX_CTRL3, SX9310_REG_PROX_CTRL3_GAIN0_X8 |
> -			    SX9310_REG_PROX_CTRL3_GAIN12_X4),
> -	SX_INIT(PROX_CTRL4, SX9310_REG_PROX_CTRL4_RESOLUTION_FINEST),
> -	SX_INIT(PROX_CTRL5, SX9310_REG_PROX_CTRL5_RANGE_SMALL |
> -			    SX9310_REG_PROX_CTRL5_STARTUPSENS_CS1 |
> -			    SX9310_REG_PROX_CTRL5_RAWFILT_1P25),
> -	SX_INIT(PROX_CTRL6, SX9310_REG_PROX_CTRL6_COMP_COMMON),
> -	SX_INIT(PROX_CTRL7, SX9310_REG_PROX_CTRL7_AVGNEGFILT_2 |
> -			    SX9310_REG_PROX_CTRL7_AVGPOSFILT_512),
> -	SX_INIT(PROX_CTRL8, SX9310_REG_PROX_CTRL8_9_PTHRESH_96 |
> -			    SX9310_REG_PROX_CTRL8_9_BODYTHRESH_1500),
> -	SX_INIT(PROX_CTRL9, SX9310_REG_PROX_CTRL8_9_PTHRESH12_28 |
> -			    SX9310_REG_PROX_CTRL8_9_BODYTHRESH_900),
> -	SX_INIT(PROX_CTRL10, SX9310_REG_PROX_CTRL10_HYST_6PCT |
> -			     SX9310_REG_PROX_CTRL10_CLOSE_DEBOUNCE_8 |
> -			     SX9310_REG_PROX_CTRL10_FAR_DEBOUNCE_8),
> -	SX_INIT(PROX_CTRL11, 0x00),
> -	SX_INIT(PROX_CTRL12, 0x00),
> -	SX_INIT(PROX_CTRL13, 0x00),
> -	SX_INIT(PROX_CTRL14, 0x00),
> -	SX_INIT(PROX_CTRL15, 0x00),
> -	SX_INIT(PROX_CTRL16, 0x00),
> -	SX_INIT(PROX_CTRL17, 0x00),
> -	SX_INIT(PROX_CTRL18, 0x00),
> -	SX_INIT(PROX_CTRL19, 0x00),
> -	SX_INIT(SAR_CTRL0, SX9310_REG_SAR_CTRL0_SARDEB_4_SAMPLES |
> -			   SX9310_REG_SAR_CTRL0_SARHYST_8),
> -	SX_INIT(SAR_CTRL1, SX9310_REG_SAR_CTRL1_SLOPE(10781250)),
> -	SX_INIT(SAR_CTRL2, SX9310_REG_SAR_CTRL2_SAROFFSET_DEFAULT),
> +	{ SX9310_REG_PROX_CTRL0, SX9310_REG_PROX_CTRL0_SCANPERIOD_15MS },
> +	{ SX9310_REG_PROX_CTRL1, 0x00 },
> +	{ SX9310_REG_PROX_CTRL2, SX9310_REG_PROX_CTRL2_COMBMODE_CS1_CS2 |
> +				 SX9310_REG_PROX_CTRL2_SHIELDEN_DYNAMIC },
> +	{ SX9310_REG_PROX_CTRL3, SX9310_REG_PROX_CTRL3_GAIN0_X8 |
> +				 SX9310_REG_PROX_CTRL3_GAIN12_X4 },
> +	{ SX9310_REG_PROX_CTRL4, SX9310_REG_PROX_CTRL4_RESOLUTION_FINEST },
> +	{ SX9310_REG_PROX_CTRL5, SX9310_REG_PROX_CTRL5_RANGE_SMALL |
> +				 SX9310_REG_PROX_CTRL5_STARTUPSENS_CS1 |
> +				 SX9310_REG_PROX_CTRL5_RAWFILT_1P25 },
> +	{ SX9310_REG_PROX_CTRL6, SX9310_REG_PROX_CTRL6_AVGTHRESH_DEFAULT },
> +	{ SX9310_REG_PROX_CTRL7, SX9310_REG_PROX_CTRL7_AVGNEGFILT_2 |
> +				 SX9310_REG_PROX_CTRL7_AVGPOSFILT_512 },
> +	{ SX9310_REG_PROX_CTRL8, SX9310_REG_PROX_CTRL8_9_PTHRESH_96 |
> +				 SX9310_REG_PROX_CTRL8_9_BODYTHRESH_1500 },
> +	{ SX9310_REG_PROX_CTRL9, SX9310_REG_PROX_CTRL8_9_PTHRESH_28 |
> +				 SX9310_REG_PROX_CTRL8_9_BODYTHRESH_900 },
> +	{ SX9310_REG_PROX_CTRL10, SX9310_REG_PROX_CTRL10_HYST_6PCT |
> +				  SX9310_REG_PROX_CTRL10_FAR_DEBOUNCE_2 },
> +	{ SX9310_REG_PROX_CTRL11, 0x00 },
> +	{ SX9310_REG_PROX_CTRL12, 0x00 },
> +	{ SX9310_REG_PROX_CTRL13, 0x00 },
> +	{ SX9310_REG_PROX_CTRL14, 0x00 },
> +	{ SX9310_REG_PROX_CTRL15, 0x00 },
> +	{ SX9310_REG_PROX_CTRL16, 0x00 },
> +	{ SX9310_REG_PROX_CTRL17, 0x00 },
> +	{ SX9310_REG_PROX_CTRL18, 0x00 },
> +	{ SX9310_REG_PROX_CTRL19, 0x00 },
> +	{ SX9310_REG_SAR_CTRL0, SX9310_REG_SAR_CTRL0_SARDEB_4_SAMPLES |
> +				SX9310_REG_SAR_CTRL0_SARHYST_8 },
> +	{ SX9310_REG_SAR_CTRL1, SX9310_REG_SAR_CTRL1_SLOPE(10781250) },
> +	{ SX9310_REG_SAR_CTRL2, SX9310_REG_SAR_CTRL2_SAROFFSET_DEFAULT },
>  };
> 
>  /* Activate all channels and perform an initial compensation. */
>  static int sx9310_init_compensation(struct iio_dev *indio_dev)
>  {
>  	struct sx9310_data *data = iio_priv(indio_dev);
> -	int i, ret;
> +	int ret;
>  	unsigned int val;
>  	unsigned int ctrl0;
> 
>  	ret = regmap_read(data->regmap, SX9310_REG_PROX_CTRL0, &ctrl0);
> -	if (ret < 0)
> +	if (ret)
>  		return ret;
> 
>  	/* run the compensation phase on all channels */
>  	ret = regmap_write(data->regmap, SX9310_REG_PROX_CTRL0,
> -			   ctrl0 | SX9310_REG_PROX_CTRL0_EN_MASK);
> -	if (ret < 0)
> +			   ctrl0 | SX9310_REG_PROX_CTRL0_SENSOREN_MASK);
> +	if (ret)
>  		return ret;
> 
> -	for (i = 100; i >= 0; i--) {
> -		msleep(20);
> -		ret = regmap_read(data->regmap, SX9310_REG_STAT1, &val);
> -		if (ret < 0)
> -			goto out;
> -		if (!(val & SX9310_COMPSTAT_MASK))
> -			break;
> -	}
> -
> -	if (i < 0) {
> -		dev_err(&data->client->dev,
> -			"initial compensation timed out: 0x%02x", val);
> -		ret = -ETIMEDOUT;
> +	ret = regmap_read_poll_timeout(data->regmap, SX9310_REG_STAT1, val,
> +				       !(val & SX9310_REG_STAT1_COMPSTAT_MASK),
> +				       20000, 2000000);
> +	if (ret) {
> +		if (ret == -ETIMEDOUT)
> +			dev_err(&data->client->dev,
> +				"0x02 << 3l compensation timed out: 0x%02x",
> +				val);
> +		return ret;
>  	}
> 
> -out:
>  	regmap_write(data->regmap, SX9310_REG_PROX_CTRL0, ctrl0);
>  	return ret;
>  }
> @@ -841,21 +825,21 @@ static int sx9310_init_device(struct iio_dev *indio_dev)
>  	unsigned int i, val;
> 
>  	ret = regmap_write(data->regmap, SX9310_REG_RESET, SX9310_SOFT_RESET);
> -	if (ret < 0)
> +	if (ret)
>  		return ret;
> 
>  	usleep_range(1000, 2000); /* power-up time is ~1ms. */
> 
>  	/* Clear reset interrupt state by reading SX9310_REG_IRQ_SRC. */
>  	ret = regmap_read(data->regmap, SX9310_REG_IRQ_SRC, &val);
> -	if (ret < 0)
> +	if (ret)
>  		return ret;
> 
>  	/* Program some sane defaults. */
>  	for (i = 0; i < ARRAY_SIZE(sx9310_default_regs); i++) {
>  		initval = &sx9310_default_regs[i];
>  		ret = regmap_write(data->regmap, initval->reg, initval->def);
> -		if (ret < 0)
> +		if (ret)
>  			return ret;
>  	}
> 
> @@ -863,25 +847,15 @@ static int sx9310_init_device(struct iio_dev *indio_dev)
>  }
> 
>  static int sx9310_set_indio_dev_name(struct device *dev,
> -				     struct iio_dev *indio_dev,
> -				     const struct i2c_device_id *id, int whoami)
> +				     struct iio_dev *indio_dev, int whoami)
>  {
> -	const struct acpi_device_id *acpi_id;
> -
> -	/* id will be NULL when enumerated via ACPI */
> -	if (id) {
> -		if (id->driver_data != whoami)
> -			dev_err(dev, "WHOAMI does not match i2c_device_id: %s",
> -				id->name);
> -	} else if (ACPI_HANDLE(dev)) {
> -		acpi_id = acpi_match_device(dev->driver->acpi_match_table, dev);
> -		if (!acpi_id)
> -			return -ENODEV;
> -		if (acpi_id->driver_data != whoami)
> -			dev_err(dev, "WHOAMI does not match acpi_device_id: %s",
> -				acpi_id->id);
> -	} else
> +	unsigned int long ddata;
> +
> +	ddata = (uintptr_t)device_get_match_data(dev);
> +	if (ddata != whoami) {
> +		dev_err(dev, "WHOAMI does not match device data: %u", whoami);
>  		return -ENODEV;
> +	}
> 
>  	switch (whoami) {
>  	case SX9310_WHOAMI_VALUE:
> @@ -898,15 +872,15 @@ static int sx9310_set_indio_dev_name(struct device *dev,
>  	return 0;
>  }
> 
> -static int sx9310_probe(struct i2c_client *client,
> -			const struct i2c_device_id *id)
> +static int sx9310_probe(struct i2c_client *client)
>  {
>  	int ret;
> +	struct device *dev = &client->dev;
>  	struct iio_dev *indio_dev;
>  	struct sx9310_data *data;
> 
> -	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> -	if (indio_dev == NULL)
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> +	if (!indio_dev)
>  		return -ENOMEM;
> 
>  	data = iio_priv(indio_dev);
> @@ -919,19 +893,17 @@ static int sx9310_probe(struct i2c_client *client,
>  		return PTR_ERR(data->regmap);
> 
>  	ret = regmap_read(data->regmap, SX9310_REG_WHOAMI, &data->whoami);
> -	if (ret < 0) {
> -		dev_err(&client->dev, "error in reading WHOAMI register: %d",
> -			ret);
> +	if (ret) {
> +		dev_err(dev, "error in reading WHOAMI register: %d", ret);
>  		return ret;
>  	}
> 
> -	ret = sx9310_set_indio_dev_name(&client->dev, indio_dev, id,
> -					data->whoami);
> -	if (ret < 0)
> +	ret = sx9310_set_indio_dev_name(dev, indio_dev, data->whoami);
> +	if (ret)
>  		return ret;
> 
> -	ACPI_COMPANION_SET(&indio_dev->dev, ACPI_COMPANION(&client->dev));
> -	indio_dev->dev.parent = &client->dev;
> +	ACPI_COMPANION_SET(&indio_dev->dev, ACPI_COMPANION(dev));
> +	indio_dev->dev.parent = dev;
>  	indio_dev->channels = sx9310_channels;
>  	indio_dev->num_channels = ARRAY_SIZE(sx9310_channels);
>  	indio_dev->info = &sx9310_info;
> @@ -939,41 +911,41 @@ static int sx9310_probe(struct i2c_client *client,
>  	i2c_set_clientdata(client, indio_dev);
> 
>  	ret = sx9310_init_device(indio_dev);
> -	if (ret < 0)
> +	if (ret)
>  		return ret;
> 
>  	if (client->irq) {
> -		ret = devm_request_threaded_irq(&client->dev, client->irq,
> +		ret = devm_request_threaded_irq(dev, client->irq,
>  						sx9310_irq_handler,
>  						sx9310_irq_thread_handler,
>  						IRQF_TRIGGER_LOW | IRQF_ONESHOT,
>  						"sx9310_event", indio_dev);
> -		if (ret < 0)
> +		if (ret)
>  			return ret;
> 
> -		data->trig =
> -			devm_iio_trigger_alloc(&client->dev, "%s-dev%d",
> -					       indio_dev->name, indio_dev->id);
> +		data->trig = devm_iio_trigger_alloc(dev, "%s-dev%d",
> +						    indio_dev->name,
> +						    indio_dev->id);
>  		if (!data->trig)
>  			return -ENOMEM;
> 
> -		data->trig->dev.parent = &client->dev;
> +		data->trig->dev.parent = dev;
>  		data->trig->ops = &sx9310_trigger_ops;
>  		iio_trigger_set_drvdata(data->trig, indio_dev);
> 
> -		ret = devm_iio_trigger_register(&client->dev, data->trig);
> +		ret = devm_iio_trigger_register(dev, data->trig);
>  		if (ret)
>  			return ret;
>  	}
> 
> -	ret = devm_iio_triggered_buffer_setup(&client->dev, indio_dev,
> +	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
>  					      iio_pollfunc_store_time,
>  					      sx9310_trigger_handler,
>  					      &sx9310_buffer_setup_ops);
> -	if (ret < 0)
> +	if (ret)
>  		return ret;
> 
> -	return devm_iio_device_register(&client->dev, indio_dev);
> +	return devm_iio_device_register(dev, indio_dev);
>  }
> 
>  static int __maybe_unused sx9310_suspend(struct device *dev)
> @@ -988,11 +960,10 @@ static int __maybe_unused sx9310_suspend(struct device *dev)
>  	mutex_lock(&data->mutex);
>  	ret = regmap_read(data->regmap, SX9310_REG_PROX_CTRL0,
>  			  &data->suspend_ctrl0);
> -
>  	if (ret)
>  		goto out;
> 
> -	ctrl0 = data->suspend_ctrl0 & ~SX9310_REG_PROX_CTRL0_EN_MASK;
> +	ctrl0 = data->suspend_ctrl0 & ~SX9310_REG_PROX_CTRL0_SENSOREN_MASK;
>  	ret = regmap_write(data->regmap, SX9310_REG_PROX_CTRL0, ctrl0);
>  	if (ret)
>  		goto out;
> @@ -1017,12 +988,18 @@ static int __maybe_unused sx9310_resume(struct device *dev)
> 
>  	ret = regmap_write(data->regmap, SX9310_REG_PROX_CTRL0,
>  			   data->suspend_ctrl0);
> +	if (ret)
> +		goto out;
> 
> -out:
>  	mutex_unlock(&data->mutex);
> 
>  	enable_irq(data->client->irq);
> 
> +	return 0;
> +
> +out:
> +	mutex_unlock(&data->mutex);
> +
>  	return ret;
>  }
> 
> @@ -1033,32 +1010,32 @@ static const struct dev_pm_ops sx9310_pm_ops = {
>  static const struct acpi_device_id sx9310_acpi_match[] = {
>  	{ "STH9310", SX9310_WHOAMI_VALUE },
>  	{ "STH9311", SX9311_WHOAMI_VALUE },
> -	{},
> +	{}
>  };
>  MODULE_DEVICE_TABLE(acpi, sx9310_acpi_match);
> 
>  static const struct of_device_id sx9310_of_match[] = {
>  	{ .compatible = "semtech,sx9310" },
>  	{ .compatible = "semtech,sx9311" },
> -	{},
> +	{}
>  };
>  MODULE_DEVICE_TABLE(of, sx9310_of_match);
> 
>  static const struct i2c_device_id sx9310_id[] = {
>  	{ "sx9310", SX9310_WHOAMI_VALUE },
>  	{ "sx9311", SX9311_WHOAMI_VALUE },
> -	{},
> +	{}
>  };
>  MODULE_DEVICE_TABLE(i2c, sx9310_id);
> 
>  static struct i2c_driver sx9310_driver = {
>  	.driver = {
>  		.name	= "sx9310",
> -		.acpi_match_table = ACPI_PTR(sx9310_acpi_match),
> -		.of_match_table = of_match_ptr(sx9310_of_match),
> +		.acpi_match_table = sx9310_acpi_match,
> +		.of_match_table = sx9310_of_match,
>  		.pm = &sx9310_pm_ops,
>  	},
> -	.probe		= sx9310_probe,
> +	.probe_new	= sx9310_probe,
>  	.id_table	= sx9310_id,
>  };
>  module_i2c_driver(sx9310_driver);
> --
> 2.28.0.rc0.142.g3c755180ce-goog
> 

