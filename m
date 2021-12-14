Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D37834749DF
	for <lists+linux-iio@lfdr.de>; Tue, 14 Dec 2021 18:41:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231962AbhLNRli (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 14 Dec 2021 12:41:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231876AbhLNRli (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 14 Dec 2021 12:41:38 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37A04C061574
        for <linux-iio@vger.kernel.org>; Tue, 14 Dec 2021 09:41:38 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id kj6so2654613qvb.2
        for <linux-iio@vger.kernel.org>; Tue, 14 Dec 2021 09:41:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=c/qMGpmvLMj2Fhu4kW1Weu2TqSl7PAh+OcksLlSzIuc=;
        b=h8K3Tldn3NOtAKCq3MeQ2zJ2CphuA89NOhW2x7QOD6K46Qh1cc4mbk+Zb722s7bXkx
         nrzqgZiKgU+clLhzQrrNfNzqNQVx51WQI7dArViSolVjpLNda2c958I/kgl3pENJHvJo
         pLrLC7tWUK5s97izhP0n/YZsBqlPkl1NznuzXFKH0NQvmYgvfQTCOQUUlf/nryZsBXvR
         3UUF2ofuU4E8tlhISbQWs2Ybbv4sCaXPD6oBlufKwEZyas5tP7s/Ofvy9WEb5YHoOa06
         sSljlhYEP4+wnGxQjUfJ5IZh3rFCW5R/6GCqo6em0PMFXf3w+DH1Qfbq7wXVTQkggVm2
         B2Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=c/qMGpmvLMj2Fhu4kW1Weu2TqSl7PAh+OcksLlSzIuc=;
        b=ZoxZxwJRAzzl/L07e2HJTyjYokk78YY9hrVYOvcVClsSffJTbKHK/sH4FYY789Oycx
         qtjIr+7qTviEnWi+aFnoYO6/ALLAxKUs3Vh4RiL4NeGPdG6wosPqSrwdfzTC0qnK+n/P
         i5ihNjvxhIN08YEZlW774xELZ48OOu/DgD4Kno1t8RfVcJ3JG/Fqlvf/FzHtFKHDvSgz
         3RZq1lX5Wja85iosfi4inKlwvxU0Bp7Xfp6QJU667f3c52cEL8eOGRDcuTB/T25KsgAJ
         sHMj2fKwTnHtSJLpjyNDcwsf3thwra1qRH1XhEQHplMHvcuJ6JM5vjrBQjxTFBqsV6O8
         l1kQ==
X-Gm-Message-State: AOAM531oGsrHKfjmmv7R9YschB+svibtRQry149EkaYij+bikpya1dJM
        sFZdXMkb/odWmi00dO36LdE=
X-Google-Smtp-Source: ABdhPJwBh2oEzLAt78JoETpnDexfhmlo2y+46LEARGPv+N3UIyDcDMHHbGvA5xAOJdWnykJ4rtJ9bA==
X-Received: by 2002:a05:6214:763:: with SMTP id f3mr6859008qvz.49.1639503697329;
        Tue, 14 Dec 2021 09:41:37 -0800 (PST)
Received: from marsc.168.1.7 ([2804:30c:b14:b100:c080:51c0:2de2:c68a])
        by smtp.gmail.com with ESMTPSA id x25sm288663qkf.91.2021.12.14.09.41.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 09:41:36 -0800 (PST)
Date:   Tue, 14 Dec 2021 14:41:32 -0300
From:   Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Nuno Sa <Nuno.Sa@analog.com>,
        lars@metafoo.de, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 06/17] staging:iio:adc:ad7280a: Switch to standard
 event control
Message-ID: <YbjXTPr3vjcCreAC@marsc.168.1.7>
References: <20211205202710.2847005-1-jic23@kernel.org>
 <20211205202710.2847005-7-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211205202710.2847005-7-jic23@kernel.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Neat, though some bits can be improved after moving out of staging.

On 12/05, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> This driver had a slightly non standard events ABI but there seems
> to be no reason for not doing it with the core support for rising and
> falling events on the two types of channels.
> 
> In theory the events on different daisy chained chips could be at
> different levels, but the driver has never supported this and it doesn't
> seem likely to be used so let us ignore that option.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>

> ---
>  drivers/staging/iio/adc/ad7280a.c | 198 ++++++++++++++----------------
>  1 file changed, 95 insertions(+), 103 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
> index 158a792c0bf8..0aeca39388cf 100644
> --- a/drivers/staging/iio/adc/ad7280a.c
> +++ b/drivers/staging/iio/adc/ad7280a.c
> @@ -551,18 +551,34 @@ static const struct attribute_group ad7280_attrs_group = {
>  	.attrs = ad7280_attributes,
>  };
>  
> +static const struct iio_event_spec ad7280_events[] = {
> +	{
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_RISING,
> +		.mask_shared_by_type = BIT(IIO_EV_INFO_VALUE),
> +	}, {
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_FALLING,
> +		.mask_shared_by_type = BIT(IIO_EV_INFO_VALUE),
> +	},
> +};
> +
>  static void ad7280_voltage_channel_init(struct iio_chan_spec *chan, int i)
>  {
>  	chan->type = IIO_VOLTAGE;
>  	chan->differential = 1;
>  	chan->channel = i;
>  	chan->channel2 = chan->channel + 1;
> +	chan->event_spec = ad7280_events;
> +	chan->num_event_specs = ARRAY_SIZE(ad7280_events);
>  }
>  
>  static void ad7280_temp_channel_init(struct iio_chan_spec *chan, int i)
>  {
>  	chan->type = IIO_TEMP;
>  	chan->channel = i;
> +	chan->event_spec = ad7280_events;
> +	chan->num_event_specs = ARRAY_SIZE(ad7280_events);
>  }
>  
>  static void ad7280_common_fields_init(struct iio_chan_spec *chan, int addr,
> @@ -732,88 +748,105 @@ static int ad7280_attr_init(struct ad7280_state *st)
>  	return 0;
>  }
>  
> -static ssize_t ad7280_read_channel_config(struct device *dev,
> -					  struct device_attribute *attr,
> -					  char *buf)
> +static int ad7280a_read_thresh(struct iio_dev *indio_dev,
> +			       const struct iio_chan_spec *chan,
> +			       enum iio_event_type type,
> +			       enum iio_event_direction dir,
> +			       enum iio_event_info info, int *val, int *val2)
>  {
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>  	struct ad7280_state *st = iio_priv(indio_dev);
> -	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
> -	unsigned int val;
>  
> -	switch (this_attr->address) {
> -	case AD7280A_CELL_OVERVOLTAGE_REG:
> -		val = 1000 + (st->cell_threshhigh * 1568) / 100;
> -		break;
> -	case AD7280A_CELL_UNDERVOLTAGE_REG:
> -		val = 1000 + (st->cell_threshlow * 1568) / 100;
> -		break;
> -	case AD7280A_AUX_ADC_OVERVOLTAGE_REG:
> -		val = (st->aux_threshhigh * 196) / 10;
> +	switch (chan->type) {
> +	case IIO_VOLTAGE:
> +		switch (dir) {
> +		case IIO_EV_DIR_RISING:
> +			*val = 1000 + (st->cell_threshhigh * 1568L) / 100;
Shouldn't the range multiplier for voltage threshhold be 1562L?
This of course has nothing to do with this patch and should make no practical
difference so can be changed after moving out of staging.

> +			return IIO_VAL_INT;
> +		case IIO_EV_DIR_FALLING:
> +			*val = 1000 + (st->cell_threshlow * 1568L) / 100;
> +			return IIO_VAL_INT;
> +		default:
> +			return -EINVAL;
> +		}
>  		break;
> -	case AD7280A_AUX_ADC_UNDERVOLTAGE_REG:
> -		val = (st->aux_threshlow * 196) / 10;
> +	case IIO_TEMP:
> +		switch (dir) {
> +		case IIO_EV_DIR_RISING:
> +			*val = ((st->aux_threshhigh) * 196L) / 10;
> +			return IIO_VAL_INT;
> +		case IIO_EV_DIR_FALLING:
> +			*val = (st->aux_threshlow * 196L) / 10;
> +			return IIO_VAL_INT;
> +		default:
> +			return -EINVAL;
> +		}
>  		break;
>  	default:
>  		return -EINVAL;
>  	}
> -
> -	return sprintf(buf, "%u\n", val);
>  }
>  
> -static ssize_t ad7280_write_channel_config(struct device *dev,
> -					   struct device_attribute *attr,
> -					   const char *buf,
> -					   size_t len)
> +static int ad7280a_write_thresh(struct iio_dev *indio_dev,
> +				const struct iio_chan_spec *chan,
> +				enum iio_event_type type,
> +				enum iio_event_direction dir,
> +				enum iio_event_info info,
> +				int val, int val2)
>  {
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>  	struct ad7280_state *st = iio_priv(indio_dev);
> -	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
> -
> -	long val;
> +	unsigned int addr;
> +	long value;
>  	int ret;
>  
> -	ret = kstrtol(buf, 10, &val);
> -	if (ret)
> -		return ret;
> -
> -	switch (this_attr->address) {
> -	case AD7280A_CELL_OVERVOLTAGE_REG:
> -	case AD7280A_CELL_UNDERVOLTAGE_REG:
> -		val = ((val - 1000) * 100) / 1568; /* LSB 15.68mV */
> -		break;
> -	case AD7280A_AUX_ADC_OVERVOLTAGE_REG:
> -	case AD7280A_AUX_ADC_UNDERVOLTAGE_REG:
> -		val = (val * 10) / 196; /* LSB 19.6mV */
> -		break;
> -	default:
> -		return -EFAULT;
> -	}
> -
> -	val = clamp(val, 0L, 0xFFL);
> +	if (val2 != 0)
> +		return -EINVAL;
>  
>  	mutex_lock(&st->lock);
> -	switch (this_attr->address) {
> -	case AD7280A_CELL_OVERVOLTAGE_REG:
> -		st->cell_threshhigh = val;
> -		break;
> -	case AD7280A_CELL_UNDERVOLTAGE_REG:
> -		st->cell_threshlow = val;
> -		break;
> -	case AD7280A_AUX_ADC_OVERVOLTAGE_REG:
> -		st->aux_threshhigh = val;
> +	switch (chan->type) {
> +	case IIO_VOLTAGE:
> +		value = ((val - 1000) * 100) / 1568; /* LSB 15.68mV */
> +		value = clamp(value, 0L, 0xFFL);
> +		switch (dir) {
> +		case IIO_EV_DIR_RISING:
> +			addr = AD7280A_CELL_OVERVOLTAGE_REG;
> +			st->cell_threshhigh = value;
> +			break;
> +		case IIO_EV_DIR_FALLING:
> +			addr = AD7280A_CELL_UNDERVOLTAGE_REG;
> +			st->cell_threshlow = value;
> +			break;
> +		default:
> +			ret = -EINVAL;
> +			goto err_unlock;
> +		}
>  		break;
> -	case AD7280A_AUX_ADC_UNDERVOLTAGE_REG:
> -		st->aux_threshlow = val;
> +	case IIO_TEMP:
> +		value = (val * 10) / 196; /* LSB 19.6mV */
> +		value = clamp(value, 0L, 0xFFL);
> +		switch (dir) {
> +		case IIO_EV_DIR_RISING:
> +			addr = AD7280A_AUX_ADC_OVERVOLTAGE_REG;
> +			st->aux_threshhigh = val;
> +			break;
> +		case IIO_EV_DIR_FALLING:
> +			addr = AD7280A_AUX_ADC_UNDERVOLTAGE_REG;
> +			st->aux_threshlow = val;
> +			break;
> +		default:
> +			ret = -EINVAL;
> +			goto err_unlock;
> +		}
>  		break;
> +	default:
> +		ret = -EINVAL;
> +		goto err_unlock;
>  	}
>  
> -	ret = ad7280_write(st, AD7280A_DEVADDR_MASTER,
> -			   this_attr->address, 1, val);
> -
> +	ret = ad7280_write(st, AD7280A_DEVADDR_MASTER, addr, 1, val);
Can't ad7280_state end up with inconsistent threshold value if device write
fails for some reason?
Should work well on normal operation so I guess there's no need to change it
before graduation.

> +err_unlock:
>  	mutex_unlock(&st->lock);
>  
> -	return ret ? ret : len;
> +	return ret;
>  }
>  
>  static irqreturn_t ad7280_event_handler(int irq, void *private)
> @@ -875,48 +908,6 @@ static irqreturn_t ad7280_event_handler(int irq, void *private)
>  	return IRQ_HANDLED;
>  }
>  
> -/* Note: No need to fix checkpatch warning that reads:
> - *	CHECK: spaces preferred around that '-' (ctx:VxV)
> - * The function argument is stringified and doesn't need a fix
> - */
> -static IIO_DEVICE_ATTR_NAMED(in_thresh_low_value,
> -			     in_voltage-voltage_thresh_low_value,
> -			     0644,
> -			     ad7280_read_channel_config,
> -			     ad7280_write_channel_config,
> -			     AD7280A_CELL_UNDERVOLTAGE_REG);
> -
> -static IIO_DEVICE_ATTR_NAMED(in_thresh_high_value,
> -			     in_voltage-voltage_thresh_high_value,
> -			     0644,
> -			     ad7280_read_channel_config,
> -			     ad7280_write_channel_config,
> -			     AD7280A_CELL_OVERVOLTAGE_REG);
> -
> -static IIO_DEVICE_ATTR(in_temp_thresh_low_value,
> -		       0644,
> -		       ad7280_read_channel_config,
> -		       ad7280_write_channel_config,
> -		       AD7280A_AUX_ADC_UNDERVOLTAGE_REG);
> -
> -static IIO_DEVICE_ATTR(in_temp_thresh_high_value,
> -		       0644,
> -		       ad7280_read_channel_config,
> -		       ad7280_write_channel_config,
> -		       AD7280A_AUX_ADC_OVERVOLTAGE_REG);
> -
> -static struct attribute *ad7280_event_attributes[] = {
> -	&iio_dev_attr_in_thresh_low_value.dev_attr.attr,
> -	&iio_dev_attr_in_thresh_high_value.dev_attr.attr,
> -	&iio_dev_attr_in_temp_thresh_low_value.dev_attr.attr,
> -	&iio_dev_attr_in_temp_thresh_high_value.dev_attr.attr,
> -	NULL,
> -};
> -
> -static const struct attribute_group ad7280_event_attrs_group = {
> -	.attrs = ad7280_event_attributes,
> -};
> -
>  static int ad7280_read_raw(struct iio_dev *indio_dev,
>  			   struct iio_chan_spec const *chan,
>  			   int *val,
> @@ -956,7 +947,8 @@ static int ad7280_read_raw(struct iio_dev *indio_dev,
>  
>  static const struct iio_info ad7280_info = {
>  	.read_raw = ad7280_read_raw,
> -	.event_attrs = &ad7280_event_attrs_group,
> +	.read_event_value = &ad7280a_read_thresh,
> +	.write_event_value = &ad7280a_write_thresh,
>  	.attrs = &ad7280_attrs_group,
>  };
>  
> -- 
> 2.34.1
> 
