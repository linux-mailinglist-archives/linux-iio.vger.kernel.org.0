Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1951215656C
	for <lists+linux-iio@lfdr.de>; Sat,  8 Feb 2020 17:18:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbgBHQSy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 8 Feb 2020 11:18:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:37448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727340AbgBHQSy (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 8 Feb 2020 11:18:54 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E033421741;
        Sat,  8 Feb 2020 16:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581178732;
        bh=59XuenxOCvoUa9Wj2VYr5TaOvSsiIsqhyk+s+QJ6QYY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=B2Nf0GkpYS50q+afe1zk7Sac/Z9n70KkhSpw32/Z3OEgtb8QeWtnGYx5Qjs/8SMyO
         0uLlw1ZvelPmKn4/6YIlQnAuzBI6R0C2bmoUnlCn5ENIOIG9E3550AZ6Mn/FeOaxcL
         SAUlrOqejV8nYrSWd73OLAAb3wSEVmImiSGxxosw=
Date:   Sat, 8 Feb 2020 16:18:47 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Olivier Moysan <olivier.moysan@st.com>
Cc:     <robh+dt@kernel.org>, <mark.rutland@arm.com>, <knaack.h@gmx.de>,
        <lars@metafoo.de>, <devicetree@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <pmeerw@pmeerw.net>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 4/4] iio: adc: stm32-dfsdm: add scale and offset support
Message-ID: <20200208161847.76c7d6e8@archlinux>
In-Reply-To: <20200204101008.11411-5-olivier.moysan@st.com>
References: <20200204101008.11411-1-olivier.moysan@st.com>
        <20200204101008.11411-5-olivier.moysan@st.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 4 Feb 2020 11:10:08 +0100
Olivier Moysan <olivier.moysan@st.com> wrote:

> Add scale and offset attributes support to STM32 DFSDM.
> 
> Signed-off-by: Olivier Moysan <olivier.moysan@st.com>

Hmm. I can't remember this history of this but we've kind of
ended up backwards wrt to other consumer drivers.

In some sense this is similar to the analog gyroscopes.  In those
the consumer driver is the gyroscope which is consuming the raw
readings from an ADC connected to the channel.  This results
in us getting readings reported by the gyroscope driver.

Here we have a sigma delta convertor consuming the pulse train
from a sigma delta device.  So the channels are reported by
the sigma delta receiver, whereas i think the nearest equivalent
to the analog voltage outputing gyroscopes would have been if
we had reported the channel values at the sigma delta converter.

This wasn't really an issue when the only values available were
raw, but if we are adding scale and offset, they are things that
belong to the ad1201 for example, not the upstream stm32-dfsdm unit.

Thinking of it another way, we don't report an SPI ADC output in
the driver for the SPI master.

Could we flip it around without breaking anything?

Jonathan

> ---
>  drivers/iio/adc/stm32-dfsdm-adc.c | 105 +++++++++++++++++++++++++++++-
>  1 file changed, 102 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/stm32-dfsdm-adc.c
> index 07b9dfdf8e76..b85fd3e90496 100644
> --- a/drivers/iio/adc/stm32-dfsdm-adc.c
> +++ b/drivers/iio/adc/stm32-dfsdm-adc.c
> @@ -10,6 +10,7 @@
>  #include <linux/dma-mapping.h>
>  #include <linux/iio/adc/stm32-dfsdm-adc.h>
>  #include <linux/iio/buffer.h>
> +#include <linux/iio/consumer.h>
>  #include <linux/iio/hw-consumer.h>
>  #include <linux/iio/sysfs.h>
>  #include <linux/iio/timer/stm32-lptim-trigger.h>
> @@ -67,6 +68,13 @@ struct stm32_dfsdm_dev_data {
>  	const struct regmap_config *regmap_cfg;
>  };
>  
> +struct stm32_dfsdm_sd_chan_info {
> +	int scale_val;
> +	int scale_val2;
> +	int offset;
> +	unsigned int differential;
> +};
> +
>  struct stm32_dfsdm_adc {
>  	struct stm32_dfsdm *dfsdm;
>  	const struct stm32_dfsdm_dev_data *dev_data;
> @@ -79,6 +87,7 @@ struct stm32_dfsdm_adc {
>  	struct iio_hw_consumer *hwc;
>  	struct completion completion;
>  	u32 *buffer;
> +	struct stm32_dfsdm_sd_chan_info *sd_chan;
>  
>  	/* Audio specific */
>  	unsigned int spi_freq;  /* SPI bus clock frequency */
> @@ -1271,7 +1280,10 @@ static int stm32_dfsdm_read_raw(struct iio_dev *indio_dev,
>  				int *val2, long mask)
>  {
>  	struct stm32_dfsdm_adc *adc = iio_priv(indio_dev);
> -	int ret;
> +	struct stm32_dfsdm_filter *fl = &adc->dfsdm->fl_list[adc->fl_id];
> +	struct stm32_dfsdm_filter_osr *flo = &fl->flo[fl->fast];
> +	u32 max = flo->max << (flo->lshift - chan->scan_type.shift);
> +	int ret, idx = chan->scan_index;
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
> @@ -1307,6 +1319,41 @@ static int stm32_dfsdm_read_raw(struct iio_dev *indio_dev,
>  		*val = adc->sample_freq;
>  
>  		return IIO_VAL_INT;
> +
> +	case IIO_CHAN_INFO_SCALE:
> +		/*
> +		 * Scale is expressed in mV.
> +		 * When fast mode is disabled, actual resolution may be lower
> +		 * than 2^n, where n=realbits-1.
> +		 * This leads to underestimating input voltage. To
> +		 * compensate this deviation, the voltage reference can be
> +		 * corrected with a factor = realbits resolution / actual max
> +		 */
> +		*val = div_u64((u64)adc->sd_chan[idx].scale_val *
> +			       (u64)BIT(DFSDM_DATA_RES - 1), max);
> +		*val2 = chan->scan_type.realbits;
> +		if (adc->sd_chan[idx].differential)
> +			*val *= 2;
> +
> +		return IIO_VAL_FRACTIONAL_LOG2;
> +
> +	case IIO_CHAN_INFO_OFFSET:
> +		/*
> +		 * DFSDM output data are in the range [-2^n,2^n-1],
> +		 * with n=realbits-1.
> +		 * - Differential modulator:
> +		 * Offset correspond to SD modulator offset.
> +		 * - Single ended modulator:
> +		 * Input is in [0V,Vref] range, where 0V corresponds to -2^n.
> +		 * Add 2^n to offset. (i.e. middle of input range)
> +		 * offset = offset(sd) * vref / res(sd) * max / vref.
> +		 */
> +		*val = div_u64((u64)max * adc->sd_chan[idx].offset,
> +			       BIT(adc->sd_chan[idx].scale_val2 - 1));
> +		if (!adc->sd_chan[idx].differential)
> +			*val += max;
> +
> +		return IIO_VAL_INT;
>  	}
>  
>  	return -EINVAL;
> @@ -1430,7 +1477,9 @@ static int stm32_dfsdm_adc_chan_init_one(struct iio_dev *indio_dev,
>  	 * IIO_CHAN_INFO_RAW: used to compute regular conversion
>  	 * IIO_CHAN_INFO_OVERSAMPLING_RATIO: used to set oversampling
>  	 */
> -	ch->info_mask_separate = BIT(IIO_CHAN_INFO_RAW);
> +	ch->info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +				 BIT(IIO_CHAN_INFO_SCALE) |
> +				 BIT(IIO_CHAN_INFO_OFFSET);
>  	ch->info_mask_shared_by_all = BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO) |
>  					BIT(IIO_CHAN_INFO_SAMP_FREQ);
>  
> @@ -1481,8 +1530,10 @@ static int stm32_dfsdm_adc_init(struct iio_dev *indio_dev)
>  {
>  	struct iio_chan_spec *ch;
>  	struct stm32_dfsdm_adc *adc = iio_priv(indio_dev);
> +	struct iio_channel *channels, *chan;
> +	struct stm32_dfsdm_sd_chan_info *sd_chan;
>  	int num_ch;
> -	int ret, chan_idx;
> +	int ret, chan_idx, val2;
>  
>  	adc->oversamp = DFSDM_DEFAULT_OVERSAMPLING;
>  	ret = stm32_dfsdm_compute_all_osrs(indio_dev, adc->oversamp);
> @@ -1506,6 +1557,22 @@ static int stm32_dfsdm_adc_init(struct iio_dev *indio_dev)
>  	if (!ch)
>  		return -ENOMEM;
>  
> +	/* Get SD modulator channels */
> +	channels = iio_channel_get_all(&indio_dev->dev);
> +	if (IS_ERR(channels)) {
> +		dev_err(&indio_dev->dev, "Failed to get channel %ld\n",
> +			PTR_ERR(channels));
> +		return PTR_ERR(channels);
> +	}
> +	chan = &channels[0];
> +
> +	adc->sd_chan = devm_kzalloc(&indio_dev->dev,
> +				    sizeof(*adc->sd_chan) * num_ch, GFP_KERNEL);
> +	if (!adc->sd_chan)
> +		return -ENOMEM;
> +
> +	sd_chan = adc->sd_chan;
> +
>  	for (chan_idx = 0; chan_idx < num_ch; chan_idx++) {
>  		ch[chan_idx].scan_index = chan_idx;
>  		ret = stm32_dfsdm_adc_chan_init_one(indio_dev, &ch[chan_idx]);
> @@ -1513,6 +1580,38 @@ static int stm32_dfsdm_adc_init(struct iio_dev *indio_dev)
>  			dev_err(&indio_dev->dev, "Channels init failed\n");
>  			return ret;
>  		}
> +
> +		if (!chan->indio_dev)
> +			return -EINVAL;
> +
> +		ret = iio_read_channel_scale(chan, &sd_chan->scale_val,
> +					     &sd_chan->scale_val2);
> +		if (ret < 0) {
> +			dev_err(&indio_dev->dev,
> +				"Failed to get channel %d scale\n", chan_idx);
> +			return ret;
> +		}
> +
> +		if (iio_channel_has_info(chan->channel, IIO_CHAN_INFO_OFFSET)) {
> +			ret = iio_read_channel_offset(chan, &sd_chan->offset,
> +						      &val2);
> +			if (ret < 0) {
> +				dev_err(&indio_dev->dev,
> +					"Failed to get channel %d offset\n",
> +					chan_idx);
> +				return ret;
> +			}
> +		}
> +
> +		sd_chan->differential = chan->channel->differential;
> +
> +		dev_dbg(&indio_dev->dev, "Channel %d %s scale ref=%d offset=%d",
> +			chan_idx, chan->channel->differential ?
> +			"differential" : "single-ended",
> +			sd_chan->scale_val, sd_chan->offset);
> +
> +		chan++;
> +		sd_chan++;
>  	}
>  
>  	indio_dev->num_channels = num_ch;

