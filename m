Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C00D1B8E2A
	for <lists+linux-iio@lfdr.de>; Sun, 26 Apr 2020 11:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbgDZJSR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 26 Apr 2020 05:18:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:49030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726143AbgDZJSR (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 26 Apr 2020 05:18:17 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8054F2080C;
        Sun, 26 Apr 2020 09:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587892696;
        bh=3CoP6ogGXHk1LfA8Jc1kZHx/pSDuBXwS1LqQpBbUBjA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=g/lG9j40LiZ6Csb+ZhFUn/wOnUKjGECSwr5Vs2XwBjvxGDgabSEOIUCPypDAZ80xW
         EFqbTXWkPqBghf6O8gh8zOQG3MjNs/TV4ntCIiyoPHnt0shlFrWX9Pxr1n3DcRx3NL
         wPIY0CbcIrtURQ3623vzWZeVWbGJGRbBr+hgDXwQ=
Date:   Sun, 26 Apr 2020 10:18:12 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mathieu Othacehe <m.othacehe@gmail.com>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/4] iio: vcnl4000: Add sampling frequency support
 for VCNL4010/20.
Message-ID: <20200426101812.22a3cdec@archlinux>
In-Reply-To: <20200422130856.1722-4-m.othacehe@gmail.com>
References: <20200422130856.1722-1-m.othacehe@gmail.com>
        <20200422130856.1722-4-m.othacehe@gmail.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 22 Apr 2020 15:08:55 +0200
Mathieu Othacehe <m.othacehe@gmail.com> wrote:

> Add sampling frequency support for proximity data on VCNL4010 and VCNL4020
> chips.
> 
> Signed-off-by: Mathieu Othacehe <m.othacehe@gmail.com>
One possible suggestion inline seeing as you'll be doing a v6.
I'm not that fussed if you would rather leave it for now though.

Jonathan

> ---
>  drivers/iio/light/vcnl4000.c | 112 ++++++++++++++++++++++++++++++++++-
>  1 file changed, 111 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
> index 4041608910d0..aefb549953ad 100644
> --- a/drivers/iio/light/vcnl4000.c
> +++ b/drivers/iio/light/vcnl4000.c
> @@ -86,6 +86,19 @@
>  #define VCNL4010_INT_DRDY \
>  	(BIT(VCNL4010_INT_PROXIMITY) | BIT(VCNL4010_INT_ALS))
>  
> +#define VCNL4010_PROXIMITY_SAMPLING_FREQUENCY_AVAILABLE  \
> +	"1.95 3.90 7.81 16.62 31.25 62.5 125 250"
> +
> +static const int vcnl4010_prox_sampling_frequency[][2] = {
> +	{1, 950000},
> +	{3, 906250},
> +	{7, 812500},
> +	{16, 625000},
> +	{31, 250000},
> +	{62, 500000},
> +	{125, 0},
> +	{250, 0},
> +};

I mentioned in my (late) review for v4 that this lends itself
to using the read_avail callback.  However that can always come
as a follow up patch as there is nothing 'wrong' with what you
do here as such.

>  
>  #define VCNL4000_SLEEP_DELAY_MS	2000 /* before we enter pm_runtime_suspend */
>  
> @@ -366,6 +379,24 @@ static int vcnl4200_measure_proximity(struct vcnl4000_data *data, int *val)
>  	return vcnl4200_measure(data, &data->vcnl4200_ps, val);
>  }
>  
> +static int vcnl4010_read_proxy_samp_freq(struct vcnl4000_data *data, int *val,
> +					 int *val2)
> +{
> +	int ret;
> +
> +	ret = i2c_smbus_read_byte_data(data->client, VCNL4010_PROX_RATE);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (ret >= ARRAY_SIZE(vcnl4010_prox_sampling_frequency))
> +		return -EINVAL;
> +
> +	*val = vcnl4010_prox_sampling_frequency[ret][0];
> +	*val2 = vcnl4010_prox_sampling_frequency[ret][1];
> +
> +	return 0;
> +}
> +
>  static bool vcnl4010_is_in_periodic_mode(struct vcnl4000_data *data)
>  {
>  	int ret;
> @@ -459,11 +490,75 @@ static int vcnl4010_read_raw(struct iio_dev *indio_dev,
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
> +	const unsigned int len = ARRAY_SIZE(vcnl4010_prox_sampling_frequency);
> +	unsigned int i = len;
> +
> +	do {
> +		if (val > vcnl4010_prox_sampling_frequency[i][0])
> +			break;
> +	} while (--i);
> +
> +	if (i == len)
> +		return -EINVAL;
> +
> +	return i2c_smbus_write_byte_data(data->client, VCNL4010_PROX_RATE, i);
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
> +	if (vcnl4010_is_in_periodic_mode(data)) {
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
> @@ -668,23 +763,38 @@ static const struct iio_chan_spec vcnl4010_channels[] = {
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
> +static IIO_CONST_ATTR(in_proximity_sampling_frequency_available,
> +		      VCNL4010_PROXIMITY_SAMPLING_FREQUENCY_AVAILABLE);
> +
> +static struct attribute *vcnl4010_attributes[] = {
> +	&iio_const_attr_in_proximity_sampling_frequency_available.dev_attr.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group vcnl4010_attribute_group = {
> +	.attrs = vcnl4010_attributes,
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

