Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBAB6407989
	for <lists+linux-iio@lfdr.de>; Sat, 11 Sep 2021 18:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbhIKQ0U (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 11 Sep 2021 12:26:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:39578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229519AbhIKQ0T (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 11 Sep 2021 12:26:19 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC9A760F58;
        Sat, 11 Sep 2021 16:25:03 +0000 (UTC)
Date:   Sat, 11 Sep 2021 17:28:34 +0100
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
Subject: Re: [PATCH 6/7] iio: adc: stm32-adc: add vrefint calibration
 support
Message-ID: <20210911172834.401cf4c8@jic23-huawei>
In-Reply-To: <20210908155452.25458-7-olivier.moysan@foss.st.com>
References: <20210908155452.25458-1-olivier.moysan@foss.st.com>
        <20210908155452.25458-7-olivier.moysan@foss.st.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 8 Sep 2021 17:54:51 +0200
Olivier Moysan <olivier.moysan@foss.st.com> wrote:

> Add support of vrefint calibration.
> If a channel is labeled as vrefint, get vrefint calibration
> from non volatile memory for this channel.
> A conversion on vrefint channel allows to update scale
> factor according to vrefint deviation, compared to vrefint
> calibration value.

As I mention inline, whilst technically the ABI doesn't demand it
the expectation of much of userspace software is that _scale is
pseudo constant - that is it doesn't tend to change very often and when
it does it's normally because someone deliberately made it change.
As such most software reads it just once.

Normally we work around this by applying the maths in kernel and
not exposing the scale at all. Is this something that could be done here?

Jonathan

> 
> Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
> ---
>  drivers/iio/adc/stm32-adc.c | 88 ++++++++++++++++++++++++++++++++++---
>  1 file changed, 82 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
> index ef3d2af98025..9e52a7de9b16 100644
> --- a/drivers/iio/adc/stm32-adc.c
> +++ b/drivers/iio/adc/stm32-adc.c
> @@ -21,6 +21,7 @@
>  #include <linux/io.h>
>  #include <linux/iopoll.h>
>  #include <linux/module.h>
> +#include <linux/nvmem-consumer.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/of.h>
> @@ -42,6 +43,7 @@
>  #define STM32_ADC_TIMEOUT	(msecs_to_jiffies(STM32_ADC_TIMEOUT_US / 1000))
>  #define STM32_ADC_HW_STOP_DELAY_MS	100
>  #define STM32_ADC_CHAN_NONE		-1
> +#define STM32_ADC_VREFINT_VOLTAGE	3300
>  
>  #define STM32_DMA_BUFFER_SIZE		PAGE_SIZE
>  
> @@ -79,6 +81,7 @@ enum stm32_adc_extsel {
>  };
>  
>  enum stm32_adc_int_ch {
> +	STM32_ADC_INT_CH_NONE = -1,
>  	STM32_ADC_INT_CH_VDDCORE,
>  	STM32_ADC_INT_CH_VREFINT,
>  	STM32_ADC_INT_CH_VBAT,
> @@ -137,6 +140,16 @@ struct stm32_adc_regs {
>  	int shift;
>  };
>  
> +/**
> + * struct stm32_adc_vrefint - stm32 ADC internal reference voltage data
> + * @vrefint_cal:	vrefint calibration value from nvmem
> + * @vrefint_data:	vrefint actual value
> + */
> +struct stm32_adc_vrefint {
> +	u32 vrefint_cal;
> +	u32 vrefint_data;
> +};
> +
>  /**
>   * struct stm32_adc_regspec - stm32 registers definition
>   * @dr:			data register offset
> @@ -186,6 +199,7 @@ struct stm32_adc;
>   * @unprepare:		optional unprepare routine (disable, power-down)
>   * @irq_clear:		routine to clear irqs
>   * @smp_cycles:		programmable sampling time (ADC clock cycles)
> + * @ts_vrefint_ns:	vrefint minimum sampling time in ns
>   */
>  struct stm32_adc_cfg {
>  	const struct stm32_adc_regspec	*regs;
> @@ -199,6 +213,7 @@ struct stm32_adc_cfg {
>  	void (*unprepare)(struct iio_dev *);
>  	void (*irq_clear)(struct iio_dev *indio_dev, u32 msk);
>  	const unsigned int *smp_cycles;
> +	const unsigned int ts_vrefint_ns;
>  };
>  
>  /**
> @@ -223,6 +238,7 @@ struct stm32_adc_cfg {
>   * @pcsel:		bitmask to preselect channels on some devices
>   * @smpr_val:		sampling time settings (e.g. smpr1 / smpr2)
>   * @cal:		optional calibration data on some devices
> + * @vrefint:		internal reference voltage data
>   * @chan_name:		channel name array
>   * @num_diff:		number of differential channels
>   * @int_ch:		internal channel indexes array
> @@ -248,6 +264,7 @@ struct stm32_adc {
>  	u32			pcsel;
>  	u32			smpr_val[2];
>  	struct stm32_adc_calib	cal;
> +	struct stm32_adc_vrefint vrefint;
>  	char			chan_name[STM32_ADC_CH_MAX][STM32_ADC_CH_SZ];
>  	u32			num_diff;
>  	int			int_ch[STM32_ADC_INT_CH_NB];
> @@ -1331,15 +1348,35 @@ static int stm32_adc_read_raw(struct iio_dev *indio_dev,
>  			ret = stm32_adc_single_conv(indio_dev, chan, val);
>  		else
>  			ret = -EINVAL;
> +
> +		/* If channel mask corresponds to vrefint, store data */
> +		if (adc->int_ch[STM32_ADC_INT_CH_VREFINT] == chan->channel)
> +			adc->vrefint.vrefint_data = *val;
> +
>  		iio_device_release_direct_mode(indio_dev);
>  		return ret;
>  
>  	case IIO_CHAN_INFO_SCALE:
>  		if (chan->differential) {
> -			*val = adc->common->vref_mv * 2;
> +			if (adc->vrefint.vrefint_data &&
> +			    adc->vrefint.vrefint_cal) {
> +				*val = STM32_ADC_VREFINT_VOLTAGE * 2 *
> +				       adc->vrefint.vrefint_cal /
> +				       adc->vrefint.vrefint_data;

Ah.. Dynamic scale.  This is always awkward when it occurs.
Given most / possibly all userspace software assumes a pseudo static scale
(not data dependent) we normally hide this by doing the maths internal to the
driver - sometimes meaning we need to present the particular channel as processed
not raw.

Is the expectation here that vrefint_data is actually very nearly constant? If
so then what you have here may be fine as anyone not aware the scale might change
will get very nearly the right value anyway.

> +			} else {
> +				*val = adc->common->vref_mv * 2;
> +			}
>  			*val2 = chan->scan_type.realbits;
>  		} else {
> -			*val = adc->common->vref_mv;
> +			/* Use vrefint data if available */
> +			if (adc->vrefint.vrefint_data &&
> +			    adc->vrefint.vrefint_cal) {
> +				*val = STM32_ADC_VREFINT_VOLTAGE *
> +				       adc->vrefint.vrefint_cal /
> +				       adc->vrefint.vrefint_data;
> +			} else {
> +				*val = adc->common->vref_mv;
> +			}
>  			*val2 = chan->scan_type.realbits;
>  		}
>  		return IIO_VAL_FRACTIONAL_LOG2;
> @@ -1907,6 +1944,35 @@ static int stm32_adc_legacy_chan_init(struct iio_dev *indio_dev,
>  	return scan_index;
>  }
>  
> +static int stm32_adc_get_int_ch(struct iio_dev *indio_dev, const char *ch_name,
> +				int chan)

Naming would suggest to me that it would return a channel rather than setting it
inside adc->int_ch[i]  Perhaps something like st32_adc_populate_int_ch() ?


> +{
> +	struct stm32_adc *adc = iio_priv(indio_dev);
> +	u16 vrefint;
> +	int i, ret;
> +
> +	for (i = 0; i < STM32_ADC_INT_CH_NB; i++) {
> +		if (!strncmp(stm32_adc_ic[i].name, ch_name, STM32_ADC_CH_SZ)) {
> +			adc->int_ch[i] = chan;
> +			/* If channel is vrefint get calibration data. */
> +			if (stm32_adc_ic[i].idx == STM32_ADC_INT_CH_VREFINT) {

I would reduce indentation by reversing the logic.

			if (stm32_adc_ic[i].idx != STM32_ADC_INT_CH_VREFINT)
				continue;

			ret = 
> +				ret = nvmem_cell_read_u16(&indio_dev->dev, "vrefint", &vrefint);
> +				if (ret && ret != -ENOENT && ret != -EOPNOTSUPP) {
> +					dev_err(&indio_dev->dev, "nvmem access error %d\n", ret);
> +					return ret;
> +				}
> +				if (ret == -ENOENT)
> +					dev_dbg(&indio_dev->dev,
> +						"vrefint calibration not found\n");
> +				else
> +					adc->vrefint.vrefint_cal = vrefint;
> +			}
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>  static int stm32_adc_generic_chan_init(struct iio_dev *indio_dev,
>  				       struct stm32_adc *adc,
>  				       struct iio_chan_spec *channels)
> @@ -1938,10 +2004,9 @@ static int stm32_adc_generic_chan_init(struct iio_dev *indio_dev,
>  				return -EINVAL;
>  			}
>  			strncpy(adc->chan_name[val], name, STM32_ADC_CH_SZ);
> -			for (i = 0; i < STM32_ADC_INT_CH_NB; i++) {
> -				if (!strncmp(stm32_adc_ic[i].name, name, STM32_ADC_CH_SZ))
> -					adc->int_ch[i] = val;
> -			}
> +			ret = stm32_adc_get_int_ch(indio_dev, name, val);
> +			if (ret)
> +				goto err;
>  		} else if (ret != -EINVAL) {
>  			dev_err(&indio_dev->dev, "Invalid label %d\n", ret);
>  			goto err;
> @@ -2044,6 +2109,16 @@ static int stm32_adc_chan_of_init(struct iio_dev *indio_dev, bool timestamping)
>  		 */
>  		of_property_read_u32_index(node, "st,min-sample-time-nsecs",
>  					   i, &smp);
> +
> +		/*
> +		 * For vrefint channel, ensure that the sampling time cannot
> +		 * be lower than the one specified in the datasheet
> +		 */
> +		if (channels[i].channel == adc->int_ch[STM32_ADC_INT_CH_VREFINT] &&
> +		    smp < adc->cfg->ts_vrefint_ns) {
> +			smp = adc->cfg->ts_vrefint_ns;
> +		}

		if (channels[i].channel == adc->int_ch[STM32_ADC_INT_CH_VREFINT])
			smp = max(smp, adc->cfg->ts_vrefint_ns);

> +
>  		/* Prepare sampling time settings */
>  		stm32_adc_smpr_init(adc, channels[i].channel, smp);
>  	}
> @@ -2350,6 +2425,7 @@ static const struct stm32_adc_cfg stm32mp1_adc_cfg = {
>  	.unprepare = stm32h7_adc_unprepare,
>  	.smp_cycles = stm32h7_adc_smp_cycles,
>  	.irq_clear = stm32h7_adc_irq_clear,
> +	.ts_vrefint_ns = 4300,
>  };
>  
>  static const struct of_device_id stm32_adc_of_match[] = {

