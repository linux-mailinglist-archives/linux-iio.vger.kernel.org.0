Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5589419665D
	for <lists+linux-iio@lfdr.de>; Sat, 28 Mar 2020 14:39:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbgC1NjB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 28 Mar 2020 09:39:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:41424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726045AbgC1NjB (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 28 Mar 2020 09:39:01 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5457B20723;
        Sat, 28 Mar 2020 13:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585402740;
        bh=xAFlyQu5GQ2i/oCi/YFOh4Dk91mW4Z9zh6ovMDcaCfI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NfA0Hv8t2jiov9tiUJgfQT4fgrO2qf8bB7sWT5y1ZXypRPCQner1voOHCB+lctxzV
         yDPaPB54hD8xMvGe04cB5DLjU00vESplU2UZr3XsyqdGpVGJlpC8h6rQvZblDGOYGc
         n0pQR1pxM8mIZKrfKKq//PIn5ZitzJwLWlYu965g=
Date:   Sat, 28 Mar 2020 13:38:56 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lars@metafoo.de>
Subject: Re: [PATCH v3] iio: adc: ad7793: use read_avail iio hook for scale
 available
Message-ID: <20200328133856.7fdf34e3@archlinux>
In-Reply-To: <20200322152656.41669-1-alexandru.ardelean@analog.com>
References: <20200322152656.41669-1-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 22 Mar 2020 17:26:56 +0200
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

Applied thanks.  It almost seems a shame to remove the 'educational'
potential of this one but I suppose we should be 'nice' :)

Jonathan

> ---
> 
> Changelog v2 -> v3:
> * split from series https://patchwork.kernel.org/project/linux-iio/list/?series=259659
> * moved -EINVAL return to default case
> 
>  drivers/iio/adc/ad7793.c | 55 +++++++++++++++++++++++++++-------------
>  1 file changed, 37 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7793.c b/drivers/iio/adc/ad7793.c
> index 5592ae573e6b..7005bde50a76 100644
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
> -
> -	len += sprintf(buf + len, "\n");
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
> +		*vals = (int *)st->scale_avail;
> +		*type = IIO_VAL_INT_PLUS_NANO;
> +		/* Values are stored in a 2D matrix  */
> +		*length = ARRAY_SIZE(st->scale_avail) * 2;
>  
> -	return len;
> +		return IIO_AVAIL_LIST;
> +	default:
> +		return -EINVAL;
> +	}
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

