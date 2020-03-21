Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC95718E314
	for <lists+linux-iio@lfdr.de>; Sat, 21 Mar 2020 17:57:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727244AbgCUQ5U (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 21 Mar 2020 12:57:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:45896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726961AbgCUQ5U (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 21 Mar 2020 12:57:20 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5AAA520732;
        Sat, 21 Mar 2020 16:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584809839;
        bh=7jXMHHcxQ7d68jYn4uXmaF7e4FZZUPFhRc7XvdSPvqs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=D25faL/NyU+1i4AjQ5GHDz/AmAmC+mWtb7FfmoVJW9uU3px8fa04ZDHiTIcGloGst
         3oC/280PDhBkEDDRNjyYLH2gVv7q2sBVTNT7reK8VT5yje5GETnDGCaS6rVD8yw+nz
         vfKxIpFWM9w2MB9MO/zWlnCIaJCq6v+3+1Na+L8A=
Date:   Sat, 21 Mar 2020 16:57:15 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lars@metafoo.de>
Subject: Re: [PATCH v2 5/5] iio: adc: ad7793: use read_avail iio hook for
 scale available
Message-ID: <20200321165715.79c9906d@archlinux>
In-Reply-To: <20200321090802.11537-5-alexandru.ardelean@analog.com>
References: <20200321090802.11537-1-alexandru.ardelean@analog.com>
        <20200321090802.11537-5-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 21 Mar 2020 11:08:02 +0200
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> This change uses the read_avail and '.info_mask_shared_by_type_available'
> modifier to set the available scale.
> Essentially, nothing changes to the driver's ABI.
> 
> The main idea for this patch is to remove the AD7793 driver from
> checkpatch's radar. There have been about ~3 attempts to fix/break the
> 'in_voltage-voltage_scale_available' attribute, because checkpatch assumed
> it to be an arithmetic operation and people were trying to change that.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
At some point it might be nice to move the sampling_frequency over as well
but clearly not remotely urgent!

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to poke at it.

Thanks,

Jonathan
 
> ---
>  drivers/iio/adc/ad7793.c | 53 +++++++++++++++++++++++++++-------------
>  1 file changed, 36 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7793.c b/drivers/iio/adc/ad7793.c
> index 5592ae573e6b..fad98f1801db 100644
> --- a/drivers/iio/adc/ad7793.c
> +++ b/drivers/iio/adc/ad7793.c
> @@ -354,29 +354,28 @@ static IIO_CONST_ATTR_SAMP_FREQ_AVAIL(
>  static IIO_CONST_ATTR_NAMED(sampling_frequency_available_ad7797,
>  	sampling_frequency_available, "123 62 50 33 17 16 12 10 8 6 4");
>  
> -static ssize_t ad7793_show_scale_available(struct device *dev,
> -			struct device_attribute *attr, char *buf)
> +static int ad7793_read_avail(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     const int **vals, int *type, int *length,
> +			     long mask)
>  {
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>  	struct ad7793_state *st = iio_priv(indio_dev);
> -	int i, len = 0;
>  
> -	for (i = 0; i < ARRAY_SIZE(st->scale_avail); i++)
> -		len += sprintf(buf + len, "%d.%09u ", st->scale_avail[i][0],
> -			       st->scale_avail[i][1]);
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
> +		*vals = (int *)st->scale_avail;
> +		*type = IIO_VAL_INT_PLUS_NANO;
> +		/* Values are stored in a 2D matrix  */
> +		*length = ARRAY_SIZE(st->scale_avail) * 2;
>  
> -	len += sprintf(buf + len, "\n");
> +		return IIO_AVAIL_LIST;
> +	}
>  
> -	return len;
> +	return -EINVAL;
>  }
>  
> -static IIO_DEVICE_ATTR_NAMED(in_m_in_scale_available,
> -		in_voltage-voltage_scale_available, S_IRUGO,
> -		ad7793_show_scale_available, NULL, 0);
> -
>  static struct attribute *ad7793_attributes[] = {
>  	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
> -	&iio_dev_attr_in_m_in_scale_available.dev_attr.attr,
>  	NULL
>  };
>  
> @@ -534,6 +533,7 @@ static const struct iio_info ad7793_info = {
>  	.read_raw = &ad7793_read_raw,
>  	.write_raw = &ad7793_write_raw,
>  	.write_raw_get_fmt = &ad7793_write_raw_get_fmt,
> +	.read_avail = ad7793_read_avail,
>  	.attrs = &ad7793_attribute_group,
>  	.validate_trigger = ad_sd_validate_trigger,
>  };
> @@ -547,7 +547,7 @@ static const struct iio_info ad7797_info = {
>  };
>  
>  #define __AD7793_CHANNEL(_si, _channel1, _channel2, _address, _bits, \
> -	_storagebits, _shift, _extend_name, _type, _mask_all) \
> +	_storagebits, _shift, _extend_name, _type, _mask_type_av, _mask_all) \
>  	{ \
>  		.type = (_type), \
>  		.differential = (_channel2 == -1 ? 0 : 1), \
> @@ -559,6 +559,7 @@ static const struct iio_info ad7797_info = {
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | \
>  			BIT(IIO_CHAN_INFO_OFFSET), \
>  		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE), \
> +		.info_mask_shared_by_type_available = (_mask_type_av), \
>  		.info_mask_shared_by_all = _mask_all, \
>  		.scan_index = (_si), \
>  		.scan_type = { \
> @@ -574,23 +575,41 @@ static const struct iio_info ad7797_info = {
>  	_storagebits, _shift) \
>  	__AD7793_CHANNEL(_si, _channel1, _channel2, _address, _bits, \
>  		_storagebits, _shift, NULL, IIO_VOLTAGE, \
> +		BIT(IIO_CHAN_INFO_SCALE), \
>  		BIT(IIO_CHAN_INFO_SAMP_FREQ))
>  
>  #define AD7793_SHORTED_CHANNEL(_si, _channel, _address, _bits, \
>  	_storagebits, _shift) \
>  	__AD7793_CHANNEL(_si, _channel, _channel, _address, _bits, \
>  		_storagebits, _shift, "shorted", IIO_VOLTAGE, \
> +		BIT(IIO_CHAN_INFO_SCALE), \
>  		BIT(IIO_CHAN_INFO_SAMP_FREQ))
>  
>  #define AD7793_TEMP_CHANNEL(_si, _address, _bits, _storagebits, _shift) \
>  	__AD7793_CHANNEL(_si, 0, -1, _address, _bits, \
>  		_storagebits, _shift, NULL, IIO_TEMP, \
> +		0, \
>  		BIT(IIO_CHAN_INFO_SAMP_FREQ))
>  
>  #define AD7793_SUPPLY_CHANNEL(_si, _channel, _address, _bits, _storagebits, \
>  	_shift) \
>  	__AD7793_CHANNEL(_si, _channel, -1, _address, _bits, \
>  		_storagebits, _shift, "supply", IIO_VOLTAGE, \
> +		0, \
> +		BIT(IIO_CHAN_INFO_SAMP_FREQ))
> +
> +#define AD7797_DIFF_CHANNEL(_si, _channel1, _channel2, _address, _bits, \
> +	_storagebits, _shift) \
> +	__AD7793_CHANNEL(_si, _channel1, _channel2, _address, _bits, \
> +		_storagebits, _shift, NULL, IIO_VOLTAGE, \
> +		0, \
> +		BIT(IIO_CHAN_INFO_SAMP_FREQ))
> +
> +#define AD7797_SHORTED_CHANNEL(_si, _channel, _address, _bits, \
> +	_storagebits, _shift) \
> +	__AD7793_CHANNEL(_si, _channel, _channel, _address, _bits, \
> +		_storagebits, _shift, "shorted", IIO_VOLTAGE, \
> +		0, \
>  		BIT(IIO_CHAN_INFO_SAMP_FREQ))
>  
>  #define DECLARE_AD7793_CHANNELS(_name, _b, _sb, _s) \
> @@ -620,8 +639,8 @@ const struct iio_chan_spec _name##_channels[] = { \
>  
>  #define DECLARE_AD7797_CHANNELS(_name, _b, _sb) \
>  const struct iio_chan_spec _name##_channels[] = { \
> -	AD7793_DIFF_CHANNEL(0, 0, 0, AD7793_CH_AIN1P_AIN1M, (_b), (_sb), 0), \
> -	AD7793_SHORTED_CHANNEL(1, 0, AD7793_CH_AIN1M_AIN1M, (_b), (_sb), 0), \
> +	AD7797_DIFF_CHANNEL(0, 0, 0, AD7793_CH_AIN1P_AIN1M, (_b), (_sb), 0), \
> +	AD7797_SHORTED_CHANNEL(1, 0, AD7793_CH_AIN1M_AIN1M, (_b), (_sb), 0), \
>  	AD7793_TEMP_CHANNEL(2, AD7793_CH_TEMP, (_b), (_sb), 0), \
>  	AD7793_SUPPLY_CHANNEL(3, 3, AD7793_CH_AVDD_MONITOR, (_b), (_sb), 0), \
>  	IIO_CHAN_SOFT_TIMESTAMP(4), \

