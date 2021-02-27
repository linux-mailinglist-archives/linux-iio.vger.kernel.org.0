Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C32FE326DBA
	for <lists+linux-iio@lfdr.de>; Sat, 27 Feb 2021 17:09:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbhB0QJe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 27 Feb 2021 11:09:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:55360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229999AbhB0QJ2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 27 Feb 2021 11:09:28 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D191764EC6;
        Sat, 27 Feb 2021 16:08:44 +0000 (UTC)
Date:   Sat, 27 Feb 2021 16:08:39 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Ivan Mikhaylov <i.mikhaylov@yadro.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] iio: proximity: vcnl3020: add proximity rate
Message-ID: <20210227160839.1928b0e1@archlinux>
In-Reply-To: <20210225201444.12983-2-i.mikhaylov@yadro.com>
References: <20210225201444.12983-1-i.mikhaylov@yadro.com>
        <20210225201444.12983-2-i.mikhaylov@yadro.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 25 Feb 2021 23:14:44 +0300
Ivan Mikhaylov <i.mikhaylov@yadro.com> wrote:

> Add the proximity rate optional option and handling of it for
> vishay vcnl3020.
> 
> Signed-off-by: Ivan Mikhaylov <i.mikhaylov@yadro.com>

Applied to the togreg branch of iio.git and pushed out as testing for the
autobuilders to see if we missed anything.

Thanks,

Jonathan

> ---
>  drivers/iio/proximity/vcnl3020.c | 97 +++++++++++++++++++++++++++++++-
>  1 file changed, 96 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/proximity/vcnl3020.c b/drivers/iio/proximity/vcnl3020.c
> index 37264f801ad0..43817f6b3086 100644
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
> @@ -165,10 +176,51 @@ static int vcnl3020_measure_proximity(struct vcnl3020_data *data, int *val)
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
> +			index = i;
> +			break;
> +		}
> +	}
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
> +		.info_mask_separate_available = BIT(IIO_CHAN_INFO_SAMP_FREQ),
>  	},
>  };
>  
> @@ -185,6 +237,47 @@ static int vcnl3020_read_raw(struct iio_dev *indio_dev,
>  		if (rc)
>  			return rc;
>  		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		rc = vcnl3020_read_proxy_samp_freq(data, val, val2);
> +		if (rc < 0)
> +			return rc;
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int vcnl3020_write_raw(struct iio_dev *indio_dev,
> +			      struct iio_chan_spec const *chan,
> +			      int val, int val2, long mask)
> +{
> +	int rc;
> +	struct vcnl3020_data *data = iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		rc = iio_device_claim_direct_mode(indio_dev);
> +		if (rc)
> +			return rc;
> +		rc = vcnl3020_write_proxy_samp_freq(data, val, val2);
> +		iio_device_release_direct_mode(indio_dev);
> +		return rc;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int vcnl3020_read_avail(struct iio_dev *indio_dev,
> +			       struct iio_chan_spec const *chan,
> +			       const int **vals, int *type, int *length,
> +			       long mask)
> +{
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		*vals = (int *)vcnl3020_prox_sampling_frequency;
> +		*type = IIO_VAL_INT_PLUS_MICRO;
> +		*length = 2 * ARRAY_SIZE(vcnl3020_prox_sampling_frequency);
> +		return IIO_AVAIL_LIST;
>  	default:
>  		return -EINVAL;
>  	}
> @@ -192,6 +285,8 @@ static int vcnl3020_read_raw(struct iio_dev *indio_dev,
>  
>  static const struct iio_info vcnl3020_info = {
>  	.read_raw = vcnl3020_read_raw,
> +	.write_raw = vcnl3020_write_raw,
> +	.read_avail = vcnl3020_read_avail,
>  };
>  
>  static const struct regmap_config vcnl3020_regmap_config = {

