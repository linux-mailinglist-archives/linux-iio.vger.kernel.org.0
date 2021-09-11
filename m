Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6FB407980
	for <lists+linux-iio@lfdr.de>; Sat, 11 Sep 2021 18:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbhIKQPC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 11 Sep 2021 12:15:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:36384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229460AbhIKQPC (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 11 Sep 2021 12:15:02 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 354FB611CC;
        Sat, 11 Sep 2021 16:13:46 +0000 (UTC)
Date:   Sat, 11 Sep 2021 17:17:17 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Olivier Moysan <olivier.moysan@foss.st.com>
Cc:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: Re: [PATCH 5/7] iio: adc: stm32-adc: add support of internal
 channels
Message-ID: <20210911171717.1de504ea@jic23-huawei>
In-Reply-To: <20210908155452.25458-6-olivier.moysan@foss.st.com>
References: <20210908155452.25458-1-olivier.moysan@foss.st.com>
        <20210908155452.25458-6-olivier.moysan@foss.st.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 8 Sep 2021 17:54:50 +0200
Olivier Moysan <olivier.moysan@foss.st.com> wrote:

> Add support of ADC2 internal channels VDDCORE, VREFINT and VBAT.
> The reserved label name "vddcore", "vrefint" and "vbat" must
> be used in Device Tree channel node, to enable the corresponding
> internal channel.
> 
> Note: This patch does not provide support of internal channels
> for F4 and H7.
> 
> Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
One query inline about the fact that the description is very generic (allows
different register for each internal channel) but the code using it is not
quite so generic.  If we can make them both very generic it will be both
more logic to read and hopefully more extensible in the future.

J

> ---
>  drivers/iio/adc/stm32-adc-core.h |   8 ++
>  drivers/iio/adc/stm32-adc.c      | 123 ++++++++++++++++++++++++++++++-
>  2 files changed, 128 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/stm32-adc-core.h b/drivers/iio/adc/stm32-adc-core.h
> index 2322809bfd2f..7c924f463f67 100644
> --- a/drivers/iio/adc/stm32-adc-core.h
> +++ b/drivers/iio/adc/stm32-adc-core.h
> @@ -102,6 +102,9 @@
>  #define STM32H7_ADC_CALFACT		0xC4
>  #define STM32H7_ADC_CALFACT2		0xC8
>  
> +/* STM32MP1 - ADC2 instance option register */
> +#define STM32MP1_ADC2_OR		0xD0
> +
>  /* STM32H7 - common registers for all ADC instances */
>  #define STM32H7_ADC_CSR			(STM32_ADCX_COMN_OFFSET + 0x00)
>  #define STM32H7_ADC_CCR			(STM32_ADCX_COMN_OFFSET + 0x08)
> @@ -168,11 +171,16 @@ enum stm32h7_adc_dmngt {
>  #define STM32H7_EOC_MST			BIT(2)
>  
>  /* STM32H7_ADC_CCR - bit fields */
> +#define STM32H7_VBATEN			BIT(24)
> +#define STM32H7_VREFEN			BIT(22)
>  #define STM32H7_PRESC_SHIFT		18
>  #define STM32H7_PRESC_MASK		GENMASK(21, 18)
>  #define STM32H7_CKMODE_SHIFT		16
>  #define STM32H7_CKMODE_MASK		GENMASK(17, 16)
>  
> +/* STM32MP1_ADC2_OR - bit fields */
> +#define STM32MP1_VDDCOREEN		BIT(0)
> +
>  /**
>   * struct stm32_adc_common - stm32 ADC driver common data (for all instances)
>   * @base:		control registers base cpu addr
> diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
> index ae4a314854f7..ef3d2af98025 100644
> --- a/drivers/iio/adc/stm32-adc.c
> +++ b/drivers/iio/adc/stm32-adc.c
> @@ -41,6 +41,7 @@
>  #define STM32_ADC_TIMEOUT_US		100000
>  #define STM32_ADC_TIMEOUT	(msecs_to_jiffies(STM32_ADC_TIMEOUT_US / 1000))
>  #define STM32_ADC_HW_STOP_DELAY_MS	100
> +#define STM32_ADC_CHAN_NONE		-1
>  
>  #define STM32_DMA_BUFFER_SIZE		PAGE_SIZE
>  
> @@ -77,6 +78,29 @@ enum stm32_adc_extsel {
>  	STM32_EXT20,
>  };
>  
> +enum stm32_adc_int_ch {
> +	STM32_ADC_INT_CH_VDDCORE,
> +	STM32_ADC_INT_CH_VREFINT,
> +	STM32_ADC_INT_CH_VBAT,
> +	STM32_ADC_INT_CH_NB,
> +};
> +
> +/**
> + * struct stm32_adc_ic - ADC internal channels
> + * @name:	name of the internal channel
> + * @idx:	internal channel enum index
> + */
> +struct stm32_adc_ic {
> +	const char *name;
> +	u32 idx;
> +};
> +
> +static const struct stm32_adc_ic stm32_adc_ic[STM32_ADC_INT_CH_NB] = {
> +	{ "vddcore", STM32_ADC_INT_CH_VDDCORE },
> +	{ "vrefint", STM32_ADC_INT_CH_VREFINT },
> +	{ "vbat", STM32_ADC_INT_CH_VBAT },
> +};
> +
>  /**
>   * struct stm32_adc_trig_info - ADC trigger info
>   * @name:		name of the trigger, corresponding to its source
> @@ -126,6 +150,9 @@ struct stm32_adc_regs {
>   * @res:		resolution selection register & bitfield
>   * @smpr:		smpr1 & smpr2 registers offset array
>   * @smp_bits:		smpr1 & smpr2 index and bitfields
> + * @or_vdd:		option register & vddcore bitfield
> + * @ccr_vbat:		common register & vbat bitfield
> + * @ccr_vref:		common register & vrefint bitfield
>   */
>  struct stm32_adc_regspec {
>  	const u32 dr;
> @@ -139,6 +166,9 @@ struct stm32_adc_regspec {
>  	const struct stm32_adc_regs res;
>  	const u32 smpr[2];
>  	const struct stm32_adc_regs *smp_bits;
> +	const struct stm32_adc_regs or_vdd;
> +	const struct stm32_adc_regs ccr_vbat;
> +	const struct stm32_adc_regs ccr_vref;
>  };
>  
>  struct stm32_adc;
> @@ -195,6 +225,7 @@ struct stm32_adc_cfg {
>   * @cal:		optional calibration data on some devices
>   * @chan_name:		channel name array
>   * @num_diff:		number of differential channels
> + * @int_ch:		internal channel indexes array
>   */
>  struct stm32_adc {
>  	struct stm32_adc_common	*common;
> @@ -219,6 +250,7 @@ struct stm32_adc {
>  	struct stm32_adc_calib	cal;
>  	char			chan_name[STM32_ADC_CH_MAX][STM32_ADC_CH_SZ];
>  	u32			num_diff;
> +	int			int_ch[STM32_ADC_INT_CH_NB];
>  };
>  
>  struct stm32_adc_diff_channel {
> @@ -451,6 +483,24 @@ static const struct stm32_adc_regspec stm32h7_adc_regspec = {
>  	.smp_bits = stm32h7_smp_bits,
>  };
>  
> +static const struct stm32_adc_regspec stm32mp1_adc_regspec = {
> +	.dr = STM32H7_ADC_DR,
> +	.ier_eoc = { STM32H7_ADC_IER, STM32H7_EOCIE },
> +	.ier_ovr = { STM32H7_ADC_IER, STM32H7_OVRIE },
> +	.isr_eoc = { STM32H7_ADC_ISR, STM32H7_EOC },
> +	.isr_ovr = { STM32H7_ADC_ISR, STM32H7_OVR },
> +	.sqr = stm32h7_sq,
> +	.exten = { STM32H7_ADC_CFGR, STM32H7_EXTEN_MASK, STM32H7_EXTEN_SHIFT },
> +	.extsel = { STM32H7_ADC_CFGR, STM32H7_EXTSEL_MASK,
> +		    STM32H7_EXTSEL_SHIFT },
> +	.res = { STM32H7_ADC_CFGR, STM32H7_RES_MASK, STM32H7_RES_SHIFT },
> +	.smpr = { STM32H7_ADC_SMPR1, STM32H7_ADC_SMPR2 },
> +	.smp_bits = stm32h7_smp_bits,
> +	.or_vdd = { STM32MP1_ADC2_OR, STM32MP1_VDDCOREEN },
> +	.ccr_vbat = { STM32H7_ADC_CCR, STM32H7_VBATEN },
> +	.ccr_vref = { STM32H7_ADC_CCR, STM32H7_VREFEN },
> +};
> +
>  /*
>   * STM32 ADC registers access routines
>   * @adc: stm32 adc instance
> @@ -579,6 +629,61 @@ static int stm32_adc_hw_start(struct device *dev)
>  	return ret;
>  }
>  
> +static void stm32_adc_int_ch_enable(struct iio_dev *indio_dev)
> +{
> +	struct stm32_adc *adc = iio_priv(indio_dev);
> +	u32 i, val, bits = 0, offset = 0;
> +
> +	for (i = 0; i < STM32_ADC_INT_CH_NB; i++) {
> +		if (adc->int_ch[i] == STM32_ADC_CHAN_NONE)
> +			continue;
> +
> +		switch (i) {
> +		case STM32_ADC_INT_CH_VDDCORE:
> +			dev_dbg(&indio_dev->dev, "Enable VDDCore\n");
> +			stm32_adc_set_bits(adc, adc->cfg->regs->or_vdd.reg,
> +					   adc->cfg->regs->or_vdd.mask);
> +			break;
> +		case STM32_ADC_INT_CH_VREFINT:
> +			dev_dbg(&indio_dev->dev, "Enable VREFInt\n");
> +			offset = adc->cfg->regs->ccr_vref.reg;
> +			bits |= adc->cfg->regs->ccr_vref.mask;
> +			break;
> +		case STM32_ADC_INT_CH_VBAT:
> +			dev_dbg(&indio_dev->dev, "Enable VBAT\n");
> +			offset = adc->cfg->regs->ccr_vbat.reg;
> +			bits |= adc->cfg->regs->ccr_vbat.mask;
> +			break;
> +		}
> +	}
> +
> +	if (bits) {
> +		val = readl_relaxed(adc->common->base + offset);
> +		val |= bits;
> +		writel_relaxed(val, adc->common->base + offset);
> +	}
> +}
> +
> +static void stm32_adc_int_ch_disable(struct stm32_adc *adc)
> +{
> +	u32 val, bits, offset, i;
> +
> +	stm32_adc_clr_bits(adc, adc->cfg->regs->or_vdd.reg,
> +			   adc->cfg->regs->or_vdd.mask);
> +
> +	for (i = 0; i < STM32_ADC_INT_CH_NB; i++) {
> +		if (adc->int_ch[i] != STM32_ADC_CHAN_NONE) {

If this is true then I think no need to do the or_vdd clear either?

This code doesn't feel particularly generic given we are listing ccr_vbat
and ccr_vref separately.

How painful would it be to handle the two parts independently?
stm32_adc_clr_bits(adc, adc->cfg->regs->ccr_vbat.reg,
		  adc->cfg_regs->ccr_vbat.mask);
stm32_adc_clr_bits(adc, adc->cfg->regs->ccr_vref.reg,
		   adc->cfg_regs-ccr_vref.mask);


> +			offset = adc->cfg->regs->ccr_vref.reg;
> +			bits = adc->cfg->regs->ccr_vref.mask |
> +				adc->cfg->regs->ccr_vbat.mask;
> +			val = readl_relaxed(adc->common->base + offset);
> +			val &= ~bits;
> +			writel_relaxed(bits, adc->common->base + offset);
> +			break;
> +		}
> +	}
> +}
> +
>  /**
>   * stm32f4_adc_start_conv() - Start conversions for regular channels.
>   * @indio_dev: IIO device instance
> @@ -947,11 +1052,13 @@ static int stm32h7_adc_prepare(struct iio_dev *indio_dev)
>  		goto pwr_dwn;
>  	calib = ret;
>  
> +	stm32_adc_int_ch_enable(indio_dev);
> +
>  	stm32_adc_writel(adc, STM32H7_ADC_DIFSEL, adc->difsel);
>  
>  	ret = stm32h7_adc_enable(indio_dev);
>  	if (ret)
> -		goto pwr_dwn;
> +		goto ch_disable;
>  
>  	/* Either restore or read calibration result for future reference */
>  	if (calib)
> @@ -967,6 +1074,8 @@ static int stm32h7_adc_prepare(struct iio_dev *indio_dev)
>  
>  disable:
>  	stm32h7_adc_disable(indio_dev);
> +ch_disable:
> +	stm32_adc_int_ch_disable(adc);
>  pwr_dwn:
>  	stm32h7_adc_enter_pwr_down(adc);
>  
> @@ -978,6 +1087,7 @@ static void stm32h7_adc_unprepare(struct iio_dev *indio_dev)
>  	struct stm32_adc *adc = iio_priv(indio_dev);
>  
>  	stm32h7_adc_disable(indio_dev);
> +	stm32_adc_int_ch_disable(adc);
>  	stm32h7_adc_enter_pwr_down(adc);
>  }
>  
> @@ -1805,10 +1915,13 @@ static int stm32_adc_generic_chan_init(struct iio_dev *indio_dev,
>  	const struct stm32_adc_info *adc_info = adc->cfg->adc_info;
>  	struct device_node *child;
>  	const char *name;
> -	int val, scan_index = 0, ret;
> +	int val, scan_index = 0, ret, i;
>  	bool differential;
>  	u32 vin[2];
>  
> +	for (i = 0; i < STM32_ADC_INT_CH_NB; i++)
> +		adc->int_ch[i] = STM32_ADC_CHAN_NONE;
> +
>  	for_each_available_child_of_node(node, child) {
>  		ret = of_property_read_u32(child, "reg", &val);
>  		if (ret) {
> @@ -1825,6 +1938,10 @@ static int stm32_adc_generic_chan_init(struct iio_dev *indio_dev,
>  				return -EINVAL;
>  			}
>  			strncpy(adc->chan_name[val], name, STM32_ADC_CH_SZ);
> +			for (i = 0; i < STM32_ADC_INT_CH_NB; i++) {
> +				if (!strncmp(stm32_adc_ic[i].name, name, STM32_ADC_CH_SZ))
> +					adc->int_ch[i] = val;
> +			}
>  		} else if (ret != -EINVAL) {
>  			dev_err(&indio_dev->dev, "Invalid label %d\n", ret);
>  			goto err;
> @@ -2223,7 +2340,7 @@ static const struct stm32_adc_cfg stm32h7_adc_cfg = {
>  };
>  
>  static const struct stm32_adc_cfg stm32mp1_adc_cfg = {
> -	.regs = &stm32h7_adc_regspec,
> +	.regs = &stm32mp1_adc_regspec,
>  	.adc_info = &stm32h7_adc_info,
>  	.trigs = stm32h7_adc_trigs,
>  	.has_vregready = true,

