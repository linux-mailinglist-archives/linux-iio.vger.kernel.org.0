Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70E72320B53
	for <lists+linux-iio@lfdr.de>; Sun, 21 Feb 2021 16:22:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbhBUPVj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Sun, 21 Feb 2021 10:21:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:34018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229685AbhBUPVi (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 21 Feb 2021 10:21:38 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B1C064E2F;
        Sun, 21 Feb 2021 15:20:53 +0000 (UTC)
Date:   Sun, 21 Feb 2021 15:20:49 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Ivan Mikhaylov <i.mikhaylov@yadro.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH 1/2] iio: proximity: vcnl3020: add proximity rate
Message-ID: <20210221152049.3b61e20b@archlinux>
In-Reply-To: <20210216145346.18304-2-i.mikhaylov@yadro.com>
References: <20210216145346.18304-1-i.mikhaylov@yadro.com>
        <20210216145346.18304-2-i.mikhaylov@yadro.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 16 Feb 2021 17:53:45 +0300
Ivan Mikhaylov <i.mikhaylov@yadro.com> wrote:

> Add the proximity rate optional option and handling of it for
> vishay vcnl3020.
> 
> Signed-off-by: Ivan Mikhaylov <i.mikhaylov@yadro.com>
Hi Ivan,

Other than dropping the dt part this mostly looks fine.
Please also implement the read_avail callback to let userspace know the
valid set of values.

Thanks

Jonathan


> ---
>  drivers/iio/proximity/vcnl3020.c | 123 ++++++++++++++++++++++++++++++-
>  1 file changed, 120 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/proximity/vcnl3020.c b/drivers/iio/proximity/vcnl3020.c
> index 37264f801ad0..833c5d5ac0a1 100644
> --- a/drivers/iio/proximity/vcnl3020.c
> +++ b/drivers/iio/proximity/vcnl3020.c
> @@ -40,6 +40,17 @@
>  #define VCNL_ON_DEMAND_TIMEOUT_US	100000
>  #define VCNL_POLL_US			20000
>  
> +static const int vcnl3020_prox_sampling_frequency[][2] = {
> +	{1, 950000},
> +	{3, 906250},
> +	{7, 812500},
> +	{16, 625000},
> +	{31, 250000},
> +	{62, 500000},
> +	{125, 0},
> +	{250, 0},
> +};
> +
>  /**
>   * struct vcnl3020_data - vcnl3020 specific data.
>   * @regmap:	device register map.
> @@ -75,12 +86,37 @@ static u32 microamp_to_reg(u32 *val)
>  	return *val /= 10000;
>  };
>  
> +static u32 hz_to_reg(u32 *val)
Hmm.  This is rather odd in the existing driver.   It makes no sense
to have callbacks like this that both modify the value passed by pointer
and return it.

Much cleaner to just pass by value and make caller do the assignment.

Given I've suggested you drop this anyway probably not that important!
> +{
> +	unsigned int i;
> +	int index = -1;
> +
> +	for (i = 0; i < ARRAY_SIZE(vcnl3020_prox_sampling_frequency); i++) {
> +		if (*val == vcnl3020_prox_sampling_frequency[i][0]) {
> +			index = i;

			return i;

> +			break;
> +		}
> +	}
> +
> +	*val = index;
> +	if (index < 0)
> +		*val = 0;
> +
> +	return *val;
> +};
> +
>  static struct vcnl3020_property vcnl3020_led_current_property = {
>  	.name = "vishay,led-current-microamp",
>  	.reg = VCNL_LED_CURRENT,
>  	.conversion_func = microamp_to_reg,
>  };
>  
> +static struct vcnl3020_property vcnl3020_proximity_rate_property = {
> +	.name = "vishay,proximity-rate-hz",
> +	.reg = VCNL_PROXIMITY_RATE,
> +	.conversion_func = hz_to_reg,
> +};
> +
>  static int vcnl3020_get_and_apply_property(struct vcnl3020_data *data,
>  					   struct vcnl3020_property prop)
>  {
> @@ -125,8 +161,18 @@ static int vcnl3020_init(struct vcnl3020_data *data)
>  	data->rev = reg;
>  	mutex_init(&data->lock);
>  
> -	return vcnl3020_get_and_apply_property(data,
> -					       vcnl3020_led_current_property);
> +	rc = vcnl3020_get_and_apply_property(data,
> +					     vcnl3020_led_current_property);
> +	if (rc) {
> +		goto err_prop_set;

Kernel style has not brackets around single line blocks like this.
	if (rc)
		goto err_prop_set;

> +	}
> +
> +	rc = vcnl3020_get_and_apply_property(data,
> +					     vcnl3020_proximity_rate_property);

From review of binding doc, I don't think this makes a much sense as a
dt property.

> +
> +err_prop_set:
> +
> +	return rc;
>  };
>  
>  static int vcnl3020_measure_proximity(struct vcnl3020_data *data, int *val)
> @@ -165,10 +211,50 @@ static int vcnl3020_measure_proximity(struct vcnl3020_data *data, int *val)
>  	return rc;
>  }
>  
> +static int vcnl3020_read_proxy_samp_freq(struct vcnl3020_data *data, int *val,
> +					 int *val2)
> +{
> +	int rc;
> +	unsigned int prox_rate;
> +
> +	rc = regmap_read(data->regmap, VCNL_PROXIMITY_RATE, &prox_rate);
> +	if (rc)
> +		return rc;
> +
> +	if (prox_rate >= ARRAY_SIZE(vcnl3020_prox_sampling_frequency))
> +		return -EINVAL;
> +
> +	*val = vcnl3020_prox_sampling_frequency[prox_rate][0];
> +	*val2 = vcnl3020_prox_sampling_frequency[prox_rate][1];
> +
> +	return 0;
> +}
> +
> +static int vcnl3020_write_proxy_samp_freq(struct vcnl3020_data *data, int val,
> +					  int val2)
> +{
> +	unsigned int i;
> +	int index = -1;
> +
> +	for (i = 0; i < ARRAY_SIZE(vcnl3020_prox_sampling_frequency); i++) {
> +		if (val == vcnl3020_prox_sampling_frequency[i][0] &&
> +		    val2 == vcnl3020_prox_sampling_frequency[i][1]) {
			return regmap_write(data->regmap,
					    VCNL_PROXIMITY_RATE, index);

> +			index = i;
> +			break;
> +		}
> +	}

return -EINVAL;

Would probably be easier to read.
> +
> +	if (index < 0)
> +		return -EINVAL;
> +
> +	return regmap_write(data->regmap, VCNL_PROXIMITY_RATE, index);
> +}
> +
>  static const struct iio_chan_spec vcnl3020_channels[] = {
>  	{
>  		.type = IIO_PROXIMITY,
> -		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +				      BIT(IIO_CHAN_INFO_SAMP_FREQ),
>  	},
>  };
>  
> @@ -185,13 +271,44 @@ static int vcnl3020_read_raw(struct iio_dev *indio_dev,
>  		if (rc)
>  			return rc;
>  		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		rc = vcnl3020_read_proxy_samp_freq(data, val, val2);
> +		if (rc < 0)
> +			return rc;
> +		return IIO_VAL_INT_PLUS_MICRO;
>  	default:
>  		return -EINVAL;
>  	}
>  }
>  
> +static int vcnl3020_write_raw(struct iio_dev *indio_dev,
> +			      struct iio_chan_spec const *chan,
> +			      int val, int val2, long mask)
> +{
> +	int rc;
> +	struct vcnl3020_data *data = iio_priv(indio_dev);
> +
> +	rc = iio_device_claim_direct_mode(indio_dev);
> +	if (rc)
> +		return rc;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:

You could simplify the flow by moving the iio_device_claim_direct_mode()
and iio_deivce_release_direct_mode() to this case statement.  That way
the default path can return directly.

> +		rc = vcnl3020_write_proxy_samp_freq(data, val, val2);
> +		goto end;
> +	default:
> +		rc = -EINVAL;
> +		goto end;
> +	}
> +
> +end:
> +	iio_device_release_direct_mode(indio_dev);
> +	return rc;
> +}
> +
>  static const struct iio_info vcnl3020_info = {
>  	.read_raw = vcnl3020_read_raw,
> +	.write_raw = vcnl3020_write_raw,
>  };
>  
>  static const struct regmap_config vcnl3020_regmap_config = {

