Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3CB02352D2
	for <lists+linux-iio@lfdr.de>; Sat,  1 Aug 2020 16:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbgHAOrV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 1 Aug 2020 10:47:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:54446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725804AbgHAOrV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 1 Aug 2020 10:47:21 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B11642076B;
        Sat,  1 Aug 2020 14:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596293240;
        bh=zdcHWeBrzKjSPED8y867icWS0v0fOVWJWNrV3sdtpXs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LeC+uu+oLp53cpP8pjBHCLMFWEeBqzyHYwy6TqUZIdzet92euCl3sIx9qRMWnTrge
         cvXSae3cQHAVpHL9mgqbBq2TVDZx2ZvSWN8dQmEppVt5M9bGFGXa2ikXXQTQdOgCUq
         2N0xngbzLP5X41jGvk0evLkKJ7O9a6sZL2Nzt3Ew=
Date:   Sat, 1 Aug 2020 15:47:15 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Daniel Campello <campello@chromium.org>
Cc:     LKML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 02/15] iio: sx9310: Update macros declarations
Message-ID: <20200801154645.5ee68094@archlinux>
In-Reply-To: <20200731104555.v3.2.I30721195b2f20ec785715f7a2757930302a2a7e8@changeid>
References: <20200731164853.3020946-1-campello@chromium.org>
        <20200731104555.v3.2.I30721195b2f20ec785715f7a2757930302a2a7e8@changeid>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 31 Jul 2020 10:48:39 -0600
Daniel Campello <campello@chromium.org> wrote:

> Follows spec sheet for macro declarations.
> 
> Signed-off-by: Daniel Campello <campello@chromium.org>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>

I'm fairly sure this patch breaks bisection as you've renamed
one macro without changing everywhere it's used.
The driver has to build even half way through the series.

Jonathan


> ---
> 
> Changes in v3: None
> Changes in v2: None
> 
>  drivers/iio/proximity/sx9310.c | 143 +++++++++++++++------------------
>  1 file changed, 67 insertions(+), 76 deletions(-)
> 
> diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
> index d161f3061e353d..07895d4b935d12 100644
> --- a/drivers/iio/proximity/sx9310.c
> +++ b/drivers/iio/proximity/sx9310.c
> @@ -33,45 +33,45 @@
>  #define SX9310_REG_IRQ_SRC				0x00
>  #define SX9310_REG_STAT0				0x01
>  #define SX9310_REG_STAT1				0x02
> +#define SX9310_REG_STAT1_COMPSTAT_MASK			GENMASK(3, 0)

I was curious to see that the patch doesn't change any 'users' of
this macro.  There are a few, so this patch will leave us unable to build
the driver.

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

Perhaps worth using FIELD_PREP so you don't need to separately define
the shift.

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
> @@ -82,8 +82,8 @@
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
> @@ -107,7 +107,7 @@
>  #define SX9310_REG_SAR_MSB				0x39
>  #define SX9310_REG_SAR_LSB				0x3a
>  
> -#define SX9310_REG_I2CADDR				0x40
> +#define SX9310_REG_I2C_ADDR				0x40
>  #define SX9310_REG_PAUSE				0x41
>  #define SX9310_REG_WHOAMI				0x42
>  #define   SX9310_WHOAMI_VALUE				0x01
> @@ -116,14 +116,9 @@
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
> @@ -251,7 +246,7 @@ static const struct regmap_range sx9310_readable_reg_ranges[] = {
>  	regmap_reg_range(SX9310_REG_PROX_CTRL0, SX9310_REG_PROX_CTRL19),
>  	regmap_reg_range(SX9310_REG_SAR_CTRL0, SX9310_REG_SAR_CTRL2),
>  	regmap_reg_range(SX9310_REG_SENSOR_SEL, SX9310_REG_SAR_LSB),
> -	regmap_reg_range(SX9310_REG_I2CADDR, SX9310_REG_WHOAMI),
> +	regmap_reg_range(SX9310_REG_I2C_ADDR, SX9310_REG_WHOAMI),
>  	regmap_reg_range(SX9310_REG_RESET, SX9310_REG_RESET),
>  };
>  
> @@ -292,7 +287,7 @@ static int sx9310_update_chan_en(struct sx9310_data *data,
>  
>  	if ((data->chan_read | data->chan_event) != (chan_read | chan_event)) {
>  		ret = regmap_update_bits(data->regmap, SX9310_REG_PROX_CTRL0,
> -					 SX9310_CHAN_ENABLED_MASK,
> +					 SX9310_REG_PROX_CTRL0_SENSOREN_MASK,
>  					 chan_read | chan_event);
>  		if (ret)
>  			return ret;
> @@ -361,7 +356,8 @@ static int sx9310_wait_for_sample(struct sx9310_data *data)
>  	if (ret < 0)
>  		return ret;
>  
> -	val = (val & SX9310_SCAN_PERIOD_MASK) >> SX9310_SCAN_PERIOD_SHIFT;
> +	val = (val & SX9310_REG_PROX_CTRL0_SCANPERIOD_MASK) >>
> +	      SX9310_REG_PROX_CTRL0_SCANPERIOD_SHIFT;
>  
>  	msleep(sx9310_scan_period_table[val]);
>  
> @@ -435,7 +431,8 @@ static int sx9310_read_samp_freq(struct sx9310_data *data, int *val, int *val2)
>  	if (ret < 0)
>  		return ret;
>  
> -	regval = (regval & SX9310_SCAN_PERIOD_MASK) >> SX9310_SCAN_PERIOD_SHIFT;
> +	regval = (regval & SX9310_REG_PROX_CTRL0_SCANPERIOD_MASK) >>
> +		 SX9310_REG_PROX_CTRL0_SCANPERIOD_SHIFT;
>  	*val = sx9310_samp_freq_table[regval].val;
>  	*val2 = sx9310_samp_freq_table[regval].val2;
>  
> @@ -483,8 +480,8 @@ static int sx9310_set_samp_freq(struct sx9310_data *data, int val, int val2)
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
> @@ -572,7 +569,7 @@ static irqreturn_t sx9310_irq_thread_handler(int irq, void *private)
>  		goto out;
>  	}
>  
> -	if (val & SX9310_EVENT_IRQ)
> +	if (val & (SX9310_FAR_IRQ | SX9310_CLOSE_IRQ))
>  		sx9310_push_events(indio_dev);
>  
>  	if (val & SX9310_CONVDONE_IRQ)
> @@ -600,6 +597,7 @@ static int sx9310_write_event_config(struct iio_dev *indio_dev,
>  				     enum iio_event_direction dir, int state)
>  {
>  	struct sx9310_data *data = iio_priv(indio_dev);
> +	unsigned int eventirq = SX9310_FAR_IRQ | SX9310_CLOSE_IRQ;
>  	int ret;
>  
>  	/* If the state hasn't changed, there's nothing to do. */
> @@ -612,7 +610,7 @@ static int sx9310_write_event_config(struct iio_dev *indio_dev,
>  		if (ret < 0)
>  			goto out_unlock;
>  		if (!(data->chan_event & ~BIT(chan->channel))) {
> -			ret = sx9310_enable_irq(data, SX9310_EVENT_IRQ);
> +			ret = sx9310_enable_irq(data, eventirq);
>  			if (ret < 0)
>  				sx9310_put_event_channel(data, chan->channel);
>  		}
> @@ -621,7 +619,7 @@ static int sx9310_write_event_config(struct iio_dev *indio_dev,
>  		if (ret < 0)
>  			goto out_unlock;
>  		if (!data->chan_event) {
> -			ret = sx9310_disable_irq(data, SX9310_EVENT_IRQ);
> +			ret = sx9310_disable_irq(data, eventirq);
>  			if (ret < 0)
>  				sx9310_get_event_channel(data, chan->channel);
>  		}
> @@ -746,53 +744,46 @@ struct sx9310_reg_default {
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
> @@ -809,7 +800,7 @@ static int sx9310_init_compensation(struct iio_dev *indio_dev)
>  
>  	/* run the compensation phase on all channels */
>  	ret = regmap_write(data->regmap, SX9310_REG_PROX_CTRL0,
> -			   ctrl0 | SX9310_REG_PROX_CTRL0_EN_MASK);
> +			   ctrl0 | SX9310_REG_PROX_CTRL0_SENSOREN_MASK);
>  	if (ret < 0)
>  		return ret;
>  
> @@ -992,7 +983,7 @@ static int __maybe_unused sx9310_suspend(struct device *dev)
>  	if (ret)
>  		goto out;
>  
> -	ctrl0 = data->suspend_ctrl0 & ~SX9310_REG_PROX_CTRL0_EN_MASK;
> +	ctrl0 = data->suspend_ctrl0 & ~SX9310_REG_PROX_CTRL0_SENSOREN_MASK;
>  	ret = regmap_write(data->regmap, SX9310_REG_PROX_CTRL0, ctrl0);
>  	if (ret)
>  		goto out;

