Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6479370E54
	for <lists+linux-iio@lfdr.de>; Sun,  2 May 2021 20:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232341AbhEBSA6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 2 May 2021 14:00:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:49904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230110AbhEBSA5 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 2 May 2021 14:00:57 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C02E610A1;
        Sun,  2 May 2021 18:00:03 +0000 (UTC)
Date:   Sun, 2 May 2021 19:00:54 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Ivan Mikhaylov <i.mikhaylov@yadro.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-hwmon@vger.kernel.org>
Subject: Re: [PATCH 1/4] iio: proximity: vcnl3020: add periodic mode
Message-ID: <20210502190054.4bd99a38@jic23-huawei>
In-Reply-To: <20210430152419.261757-2-i.mikhaylov@yadro.com>
References: <20210430152419.261757-1-i.mikhaylov@yadro.com>
        <20210430152419.261757-2-i.mikhaylov@yadro.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 30 Apr 2021 18:24:16 +0300
Ivan Mikhaylov <i.mikhaylov@yadro.com> wrote:

> Add the possibility to run proximity sensor in periodic measurement
> mode.

Without an interrupt?  Unusual and perhaps best left to userspace.

> 
> Signed-off-by: Ivan Mikhaylov <i.mikhaylov@yadro.com>
> ---
>  drivers/iio/proximity/vcnl3020.c | 138 +++++++++++++++++++++++++++++++
>  1 file changed, 138 insertions(+)
> 
> diff --git a/drivers/iio/proximity/vcnl3020.c b/drivers/iio/proximity/vcnl3020.c
> index 43817f6b3086..25c6bdba3ede 100644
> --- a/drivers/iio/proximity/vcnl3020.c
> +++ b/drivers/iio/proximity/vcnl3020.c
> @@ -36,6 +36,21 @@
>  #define VCNL_PS_OD		BIT(3) /* start on-demand proximity
>  					* measurement
>  					*/
> +#define VCNL_PS_EN		BIT(1) /* Enables periodic proximity
> +					* measurement
> +					*/
> +#define VCNL_PS_SELFTIMED_EN	BIT(0) /* Enables state machine and LP
> +					* oscillator for self timed
> +					* measurements

This rather suggests that you should just put comments on their own lines
as it will involve less wrapping and ultimately be more compact and readable!

> +					*/
> +
> +/* Bit masks for ICR */
> +#define  VCNL_ICR_THRES_EN	BIT(1) /* Enable interrupts on low or high
> +					* thresholds */
> +
> +/* Bit masks for ISR */
> +#define VCNL_INT_TH_HI		BIT(0)	/* High threshold hit */
> +#define VCNL_INT_TH_LOW		BIT(1)	/* Low threshold hit */
>  
>  #define VCNL_ON_DEMAND_TIMEOUT_US	100000
>  #define VCNL_POLL_US			20000
> @@ -215,12 +230,124 @@ static int vcnl3020_write_proxy_samp_freq(struct vcnl3020_data *data, int val,
>  	return regmap_write(data->regmap, VCNL_PROXIMITY_RATE, index);
>  }
>  
> +static bool vcnl3020_is_in_periodic_mode(struct vcnl3020_data *data)
> +{
> +	int rc;
> +	unsigned int cmd;
> +
> +	rc = regmap_read(data->regmap, VCNL_COMMAND, &cmd);
> +	if (rc)
> +		return false;
> +
> +	return !!(cmd & VCNL_PS_SELFTIMED_EN);
> +}
> +
> +static bool vcnl3020_is_thr_enabled(struct vcnl3020_data *data)
> +{
> +	int rc;
> +	unsigned int icr;
> +
> +	rc = regmap_read(data->regmap, VCNL_PS_ICR, &icr);
> +	if (rc)
> +		return false;
> +
> +	return !!(icr & VCNL_ICR_THRES_EN);
> +}
> +
> +static int vcnl3020_config_threshold(struct iio_dev *indio_dev, bool state)
> +{
> +	struct vcnl3020_data *data = iio_priv(indio_dev);
> +	int rc;
> +	int icr;
> +	int cmd;
> +	int isr;
> +
> +	if (state) {
> +		rc = iio_device_claim_direct_mode(indio_dev);

Device doesn't support buffered mode, so this is a lock as in patch 3.
Don't do that as that isn't the intended use

> +		if (rc)
> +			return rc;
> +
> +		/* Enable periodic measurement of proximity data. */
> +		cmd = VCNL_PS_EN | VCNL_PS_SELFTIMED_EN;
> +
> +		/*
> +		 * Enable interrupts on threshold, for proximity data by
> +		 * default.
> +		 */
> +		icr = VCNL_ICR_THRES_EN;
> +	} else {
> +		if (!vcnl3020_is_thr_enabled(data))
> +			return 0;
> +
> +		cmd = 0;
> +		icr = 0;
> +		isr = 0;
> +	}
> +
> +	rc = regmap_write(data->regmap, VCNL_COMMAND, cmd);
> +	if (rc)
> +		goto end;
> +
> +	rc = regmap_write(data->regmap, VCNL_PS_ICR, icr);
> +	if (rc)
> +		goto end;
> +
> +	if (!state)
> +		/* Clear interrupts */

Given you don't seem to have an interrupt. I guess this is clearing
a status flag?

> +		rc = regmap_write(data->regmap, VCNL_ISR, isr);
> +
> +end:
> +	if (state)
> +		iio_device_release_direct_mode(indio_dev);

I would just allow for the small amount of repeated code and do only
one condition on if (state) in this function.

> +
> +	return rc;
> +}
> +
> +static int vcnl3020_write_event_config(struct iio_dev *indio_dev,
> +				       const struct iio_chan_spec *chan,
> +				       enum iio_event_type type,
> +				       enum iio_event_direction dir,
> +				       int state)
> +{
> +	switch (chan->type) {
> +	case IIO_PROXIMITY:
> +		return vcnl3020_config_threshold(indio_dev, state);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int vcnl3020_read_event_config(struct iio_dev *indio_dev,
> +				      const struct iio_chan_spec *chan,
> +				      enum iio_event_type type,
> +				      enum iio_event_direction dir)
> +{
> +	struct vcnl3020_data *data = iio_priv(indio_dev);
> +
> +	switch (chan->type) {
> +	case IIO_PROXIMITY:
> +		return vcnl3020_is_thr_enabled(data);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static const struct iio_event_spec vcnl3020_event_spec[] = {
> +	{
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_EITHER,
> +		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
> +	},
> +};
> +
>  static const struct iio_chan_spec vcnl3020_channels[] = {
>  	{
>  		.type = IIO_PROXIMITY,
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>  				      BIT(IIO_CHAN_INFO_SAMP_FREQ),
>  		.info_mask_separate_available = BIT(IIO_CHAN_INFO_SAMP_FREQ),
> +		.event_spec = vcnl3020_event_spec,
> +		.num_event_specs = ARRAY_SIZE(vcnl3020_event_spec),
>  	},
>  };
>  
> @@ -233,6 +360,11 @@ static int vcnl3020_read_raw(struct iio_dev *indio_dev,
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
> +
> +		/* Protect against event capture. */
> +		if (vcnl3020_is_in_periodic_mode(data))
> +			return -EBUSY;
> +
>  		rc = vcnl3020_measure_proximity(data, val);
>  		if (rc)
>  			return rc;
> @@ -254,6 +386,10 @@ static int vcnl3020_write_raw(struct iio_dev *indio_dev,
>  	int rc;
>  	struct vcnl3020_data *data = iio_priv(indio_dev);
>  
> +	/* Protect against event capture. */
> +	if (vcnl3020_is_in_periodic_mode(data))
> +		return -EBUSY;
> +
>  	switch (mask) {
>  	case IIO_CHAN_INFO_SAMP_FREQ:
>  		rc = iio_device_claim_direct_mode(indio_dev);
> @@ -287,6 +423,8 @@ static const struct iio_info vcnl3020_info = {
>  	.read_raw = vcnl3020_read_raw,
>  	.write_raw = vcnl3020_write_raw,
>  	.read_avail = vcnl3020_read_avail,
> +	.read_event_config = vcnl3020_read_event_config,
> +	.write_event_config = vcnl3020_write_event_config,
>  };
>  
>  static const struct regmap_config vcnl3020_regmap_config = {

