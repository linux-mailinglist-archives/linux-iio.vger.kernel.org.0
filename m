Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B14471B0629
	for <lists+linux-iio@lfdr.de>; Mon, 20 Apr 2020 12:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726055AbgDTKEA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Apr 2020 06:04:00 -0400
Received: from ns.pmeerw.net ([84.19.176.117]:51460 "EHLO ns.pmeerw.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725773AbgDTKEA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 20 Apr 2020 06:04:00 -0400
Received: by ns.pmeerw.net (Postfix, from userid 1000)
        id CE7B8E0382; Mon, 20 Apr 2020 12:03:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pmeerw.net; s=mail;
        t=1587377038; bh=t05hrh1okFA9GHvWI5FSiVWL5i5DWdf2aWryS7zbLiQ=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=aZ0E9xDgHP9/Cx9wd4LEYFFT+7gXMf9Zb3tR1y/Ni+ypuRm0eZhqPMfZqRRcxYSUJ
         WuoNoq9WnQNhlQkt5Y2r9zf3FORI5FMx+DigGRBO31Sh41Is8YntVJzJVeSXfJZhoz
         xclfdLXduC6NC4Gnbezh90W/sY+HcbAueSyyYEvQ=
Received: from localhost (localhost [127.0.0.1])
        by ns.pmeerw.net (Postfix) with ESMTP id C19E0E0051;
        Mon, 20 Apr 2020 12:03:58 +0200 (CEST)
Date:   Mon, 20 Apr 2020 12:03:58 +0200 (CEST)
From:   Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To:     Mathieu Othacehe <m.othacehe@gmail.com>
cc:     jic23@kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/4] iio: vcnl4000: Add sampling frequency support
 for VCNL4010/20.
In-Reply-To: <20200420084210.14245-4-m.othacehe@gmail.com>
Message-ID: <alpine.DEB.2.21.2004201159300.8178@vps.pmeerw.net>
References: <20200420084210.14245-1-m.othacehe@gmail.com> <20200420084210.14245-4-m.othacehe@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 20 Apr 2020, Mathieu Othacehe wrote:

> Add sampling frequency support for ambient light and proximity data on
> VCNL4010 and VCNL4020 chips.

comments below

> 
> Signed-off-by: Mathieu Othacehe <m.othacehe@gmail.com>
> ---
>  drivers/iio/light/vcnl4000.c | 191 ++++++++++++++++++++++++++++++++++-
>  1 file changed, 190 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
> index 73a3627d12b8..3f9d63858b51 100644
> --- a/drivers/iio/light/vcnl4000.c
> +++ b/drivers/iio/light/vcnl4000.c
> @@ -88,6 +88,24 @@
>  #define VCNL4010_INT_DRDY \
>  	(BIT(VCNL4010_INT_PROXIMITY) | BIT(VCNL4010_INT_ALS))
>  
> +#define VCNL4010_ALS_SAMPLING_FREQUENCY_AVAILABLE \
> +	"1 2 3 4 5 6 8 10"
> +#define VCNL4010_PROXIMITY_SAMPLING_FREQUENCY_AVAILABLE  \
> +	"1.95 3.90 7.81 16.62 31.25 62.5 125 250"
> +
> +static const int vcnl4010_als_sampling_frequency[] = {
> +	1, 2, 3, 4, 5, 6, 8, 10};
> +
> +static const int vcnl4010_prox_sampling_frequency[][2] = {
> +	{1, 950000},
> +	{3, 906250},
> +	{7, 812500},
> +	{16, 625000},
> +	{31, 250000},
> +	{62, 500000},
> +	{125, 0},
> +	{250, 0}
> +};
>  
>  #define VCNL4000_SLEEP_DELAY_MS	2000 /* before we enter pm_runtime_suspend */
>  
> @@ -393,6 +411,50 @@ static int vcnl4200_measure_proximity(struct vcnl4000_data *data, int *val)
>  	return vcnl4200_measure(data, &data->vcnl4200_ps, val);
>  }
>  
> +static int vcnl4010_read_proxy_samp_freq(struct vcnl4000_data *data, int *val,
> +					 int *val2)
> +{
> +	int ret;
> +
> +	mutex_lock(&data->vcnl4000_lock);

what is the mutex protecting?

vcnl4010_prox_sampling_frequency is read only, so no need to have that 
under mutex

> +
> +	ret = i2c_smbus_read_byte_data(data->client, VCNL4010_PROX_RATE);
> +	if (ret < 0)
> +		goto end;
> +
> +	if (ret >= ARRAY_SIZE(vcnl4010_prox_sampling_frequency))
> +		return -EINVAL;
> +
> +	*val = vcnl4010_prox_sampling_frequency[ret][0];
> +	*val2 = vcnl4010_prox_sampling_frequency[ret][1];
> +end:
> +	mutex_unlock(&data->vcnl4000_lock);
> +
> +	return ret;
> +}
> +
> +static int vcnl4010_read_als_samp_freq(struct vcnl4000_data *data, int *val)
> +{
> +	int ret;
> +	int index, mask = 0x70;
> +
> +	mutex_lock(&data->vcnl4000_lock);

mutx use, same question

> +
> +	ret = i2c_smbus_read_byte_data(data->client, VCNL4010_ALS_PARAM);
> +	if (ret < 0)
> +		goto end;
> +
> +	index = (ret & mask) >> 4;
> +	if (index < 0 || index >= ARRAY_SIZE(vcnl4010_als_sampling_frequency))
> +		return -EINVAL;
> +
> +	*val = vcnl4010_als_sampling_frequency[index];
> +end:
> +	mutex_unlock(&data->vcnl4000_lock);
> +
> +	return ret;
> +}
> +
>  static int vcnl4010_in_periodic_mode(struct vcnl4000_data *data)
>  {
>  	int ret;
> @@ -493,11 +555,119 @@ static int vcnl4010_read_raw(struct iio_dev *indio_dev,
>  
>  		iio_device_release_direct_mode(indio_dev);
>  		return ret;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		switch (chan->type) {
> +		case IIO_PROXIMITY:
> +			ret = vcnl4010_read_proxy_samp_freq(data, val, val2);
> +			if (ret < 0)
> +				return ret;
> +			return IIO_VAL_INT_PLUS_MICRO;
> +		case IIO_LIGHT:
> +			ret = vcnl4010_read_als_samp_freq(data, val);
> +			if (ret < 0)
> +				return ret;
> +			return IIO_VAL_INT;
> +		default:
> +			return -EINVAL;
> +		}
>  	default:
>  		return -EINVAL;
>  	}
>  }
>  
> +static int vcnl4010_write_proxy_samp_freq(struct vcnl4000_data *data, int val,
> +					  int val2)
> +{
> +	int ret;
> +	int i;
> +	int len = ARRAY_SIZE(vcnl4010_prox_sampling_frequency);

maybe const int len

> +
> +	for (i = 0; i < len; i++) {
> +		if (val <= vcnl4010_prox_sampling_frequency[i][0])
> +			break;
> +	}
> +
> +	if (i == len)
> +		return -EINVAL;
> +
> +	mutex_lock(&data->vcnl4000_lock);
> +	ret = i2c_smbus_write_byte_data(data->client, VCNL4010_PROX_RATE, i);
> +	mutex_unlock(&data->vcnl4000_lock);
> +
> +	return ret;
> +}
> +
> +static int vcnl4010_write_als_samp_freq(struct vcnl4000_data *data, int val)
> +{
> +	int ret;
> +	int i;
> +	int param;
> +	int mask = 0x70;

use #define, GENMASK()

> +	int len = ARRAY_SIZE(vcnl4010_als_sampling_frequency);
> +
> +	for (i = 0; i < len; i++) {
> +		if (val <= vcnl4010_als_sampling_frequency[i])
> +			break;
> +	}
> +
> +	if (i == len)
> +		return -EINVAL;
> +
> +	mutex_lock(&data->vcnl4000_lock);
> +
> +	ret = i2c_smbus_read_byte_data(data->client, VCNL4010_ALS_PARAM);
> +	if (ret < 0)
> +		goto end;
> +
> +	param = (ret & ~mask) | (i << 4);
> +	ret = i2c_smbus_write_byte_data(data->client, VCNL4010_ALS_PARAM,
> +					param);
> +end:
> +	mutex_unlock(&data->vcnl4000_lock);
> +
> +	return ret;
> +}
> +
> +static int vcnl4010_write_raw(struct iio_dev *indio_dev,
> +			      struct iio_chan_spec const *chan,
> +			      int val, int val2, long mask)
> +{
> +	int ret;
> +	struct vcnl4000_data *data = iio_priv(indio_dev);
> +
> +	ret = iio_device_claim_direct_mode(indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	/* Protect against event capture. */
> +	if (vcnl4010_in_periodic_mode(data)) {
> +		ret = -EBUSY;
> +		goto end;
> +	}
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		switch (chan->type) {
> +		case IIO_PROXIMITY:
> +			ret = vcnl4010_write_proxy_samp_freq(data, val, val2);
> +			goto end;
> +		case IIO_LIGHT:
> +			ret = vcnl4010_write_als_samp_freq(data, val);
> +			goto end;
> +		default:
> +			ret = -EINVAL;
> +			goto end;
> +		}
> +	default:
> +		ret = -EINVAL;
> +		goto end;
> +	}
> +
> +end:
> +	iio_device_release_direct_mode(indio_dev);
> +	return ret;
> +}
> +
>  static int vcnl4010_read_event(struct iio_dev *indio_dev,
>  			       const struct iio_chan_spec *chan,
>  			       enum iio_event_type type,
> @@ -710,27 +880,46 @@ static const struct iio_chan_spec vcnl4010_channels[] = {
>  		.type = IIO_LIGHT,
>  		.scan_index = -1,
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +			BIT(IIO_CHAN_INFO_SAMP_FREQ) |
>  			BIT(IIO_CHAN_INFO_SCALE),
>  	}, {
>  		.type = IIO_PROXIMITY,
>  		.scan_index = 0,
> -		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +			BIT(IIO_CHAN_INFO_SAMP_FREQ),
>  		.event_spec = vcnl4000_event_spec,
>  		.num_event_specs = ARRAY_SIZE(vcnl4000_event_spec),
>  		.ext_info = vcnl4000_ext_info,
>  	},
>  };
>  
> +static IIO_CONST_ATTR(in_illuminance_sampling_frequency_available,
> +		      VCNL4010_ALS_SAMPLING_FREQUENCY_AVAILABLE);
> +static IIO_CONST_ATTR(in_proximity_sampling_frequency_available,
> +		      VCNL4010_PROXIMITY_SAMPLING_FREQUENCY_AVAILABLE);
> +
> +static struct attribute *vcnl4010_attributes[] = {
> +	&iio_const_attr_in_illuminance_sampling_frequency_available.dev_attr.attr,
> +	&iio_const_attr_in_proximity_sampling_frequency_available.dev_attr.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group vcnl4010_attribute_group = {
> +	.attrs = vcnl4010_attributes
> +};
> +
>  static const struct iio_info vcnl4000_info = {
>  	.read_raw = vcnl4000_read_raw,
>  };
>  
>  static const struct iio_info vcnl4010_info = {
>  	.read_raw = vcnl4010_read_raw,
> +	.write_raw = vcnl4010_write_raw,
>  	.read_event_value = vcnl4010_read_event,
>  	.write_event_value = vcnl4010_write_event,
>  	.read_event_config = vcnl4010_read_event_config,
>  	.write_event_config = vcnl4010_write_event_config,
> +	.attrs    = &vcnl4010_attribute_group,
>  };
>  
>  static const struct vcnl4000_chip_spec vcnl4000_chip_spec_cfg[] = {
> 

-- 

Peter Meerwald-Stadler
Mobile: +43 664 24 44 418
