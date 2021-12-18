Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5AB5479CB5
	for <lists+linux-iio@lfdr.de>; Sat, 18 Dec 2021 22:07:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234215AbhLRVHD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Dec 2021 16:07:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231240AbhLRVHD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 18 Dec 2021 16:07:03 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1AE8C061574
        for <linux-iio@vger.kernel.org>; Sat, 18 Dec 2021 13:07:02 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id m25so6147399qtq.13
        for <linux-iio@vger.kernel.org>; Sat, 18 Dec 2021 13:07:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ou54/+Dqs8F726Z0giyOIh4yMPSRzHP+fXAIu0CkFCI=;
        b=D7Elut0nWUkDkV8HljibbUvQ0MMFx4lK3+T6f3jjYNActH8fVdrsDd7haUHIiD9okE
         hW6IYnq6gS3L0iyazNd5uotXWUxZYMxrKQUX1hqj5x7lmcR0T7mQzoXeRICwCaqpmNn7
         7D552J1H/m9qAsfmX4XfNVCcb21sHwqbjsLnLo/vvImVd+8TiQwMVyecXqaPo+tYzc1L
         uNwalcGkGUH+OMMSlh476l/q+xY1gMp1ZWk1ZkQB2NrYK7k3swJvEuhQxoa6TZ4JUd8l
         c591NrEpoiwEANY95jRcFAJYUR5wtgfT80pj7WMTSWuWdGgLiFH1D7aY9UW7Pwqam5xC
         KZOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ou54/+Dqs8F726Z0giyOIh4yMPSRzHP+fXAIu0CkFCI=;
        b=ZnJ6E8TvWsvxlKg4768z8x66/FwVuVwiQtOBCLn9ClAENxvBffj1FL9p7BW1DM4d+S
         rp3VllMUVfEHG/pqxEfn/yGVROfb58zOSF+LyddnRPqVmKgf2GVgbSDW6zA4vnXbzn6B
         ePehlJVh8gLeGP7WZAR4STQZfOqVc/43Y9tyQa6ct1MG/Il2ncJY355A4y/erZu2A6DF
         a42v/cl2Zeo+K5DQvhqdjAoDPpWCLHewIfJI8P9s8c6cZhmEalrx16hwysj/ushAC+jK
         8eVrbjxyvCAqTfCKotrGN+KKdEmf1sOChPRAjmbZrYg1nzop70dHH1i8KebdlpDD1/G/
         YuYw==
X-Gm-Message-State: AOAM531wxuuMlRyfvegCK3+BMh4CuvKaqbqJ+Tn1FX6zzZHxfNXZO3MX
        fEgx7iMOz+DtpUINLvzok/WtZBkr2HI=
X-Google-Smtp-Source: ABdhPJxZsGN2+gftTNUFMoF76VBXnALXWyQ6dflEXmBFYKVUhHHHPJS+P3emNC7vYN4yq+CZrC4jgQ==
X-Received: by 2002:ac8:7d46:: with SMTP id h6mr3169246qtb.379.1639861621935;
        Sat, 18 Dec 2021 13:07:01 -0800 (PST)
Received: from marsc.168.1.7 ([2804:30c:b14:b100:c080:51c0:2de2:c68a])
        by smtp.gmail.com with ESMTPSA id l9sm7566451qkj.37.2021.12.18.13.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Dec 2021 13:07:01 -0800 (PST)
Date:   Sat, 18 Dec 2021 18:06:58 -0300
From:   Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Nuno Sa <Nuno.Sa@analog.com>,
        lars@metafoo.de, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 14/17] staging:iio:adc:ad7280a: Use device properties
 to replace platform data.
Message-ID: <Yb5NcvGuaauOHBXe@marsc.168.1.7>
References: <20211205202710.2847005-1-jic23@kernel.org>
 <20211205202710.2847005-15-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211205202710.2847005-15-jic23@kernel.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Removing AUX channels from alert detection is a bit tricky.
According to a note from datasheet page 27:
To remove AUX5 or AUX5 and AUX3 from the alert detection, conversions on
three auxiliary ADC input channels only must be selected in the control register.

We can check the AUX alert configuration and write to control register HB at
probe but it would not last for long since every other device read sets D15:D14
to 0x00 again. Can't think of any reasonable way to ensure only AUX1,3,5 without
keeping ctrl_hb again. However, AUX selection should not bother if we drop AUX
alert removal support for now.

Few other bits and thoughts inline.

On 12/05, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Convert all the device specific info that was previously in platform data
> over to generic firmware query interfaces.
> 
> dt-bindings to follow shortly.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/staging/iio/adc/ad7280a.c | 100 +++++++++++++++++++++++++-----
>  drivers/staging/iio/adc/ad7280a.h |  31 ---------
>  2 files changed, 86 insertions(+), 45 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
> index acaae1b33986..0806238debe3 100644
> --- a/drivers/staging/iio/adc/ad7280a.c
> +++ b/drivers/staging/iio/adc/ad7280a.c
> @@ -23,8 +23,6 @@
>  #include <linux/iio/events.h>
>  #include <linux/iio/iio.h>
>  
> -#include "ad7280a.h"
> -
>  /* Registers */
>  
>  #define AD7280A_CELL_VOLTAGE_1_REG		0x0  /* D11 to D0, Read only */
> @@ -81,6 +79,11 @@
>  #define AD7280A_AUX_ADC_UNDERVOLTAGE_REG	0x12 /* D7 to D0, Read/write */
>  
>  #define AD7280A_ALERT_REG			0x13 /* D7 to D0, Read/write */
> +#define   AD7280A_ALERT_REMOVE_MSK			GENMASK(3, 0)
> +#define     AD7280A_ALERT_REMOVE_AUX5			BIT(0)
> +#define     AD7280A_ALERT_REMOVE_AUX4_AUX5		BIT(1)
typo, according to datasheet this bit disables AUX5 and AUX3 so it would be
#define     AD7280A_ALERT_REMOVE_AUX3_AUX5		BIT(1)

> +#define     AD7280A_ALERT_REMOVE_VIN5			BIT(2)
> +#define     AD7280A_ALERT_REMOVE_VIN4_VIN5		BIT(3)
>  #define   AD7280A_ALERT_GEN_STATIC_HIGH			BIT(6)
>  #define   AD7280A_ALERT_RELAY_SIG_CHAIN_DOWN		(BIT(7) | BIT(6))
>  
> @@ -163,6 +166,8 @@ static unsigned int ad7280a_devaddr(unsigned int addr)
>  struct ad7280_state {
>  	struct spi_device		*spi;
>  	struct iio_chan_spec		*channels;
> +	unsigned int			chain_last_alert_ignore;
> +	bool				thermistor_term_en;
>  	int				slave_num;
>  	int				scan_cnt;
>  	int				readback_delay_us;
> @@ -932,14 +937,8 @@ static const struct iio_info ad7280_info_no_irq = {
>  	.write_event_value = &ad7280a_write_thresh,
>  };
>  
> -static const struct ad7280_platform_data ad7793_default_pdata = {
> -	.acquisition_time = AD7280A_ACQ_TIME_400ns,
> -	.thermistor_term_en = true,
> -};
> -
>  static int ad7280_probe(struct spi_device *spi)
>  {
> -	const struct ad7280_platform_data *pdata = dev_get_platdata(&spi->dev);
>  	struct device *dev = &spi->dev;
>  	struct ad7280_state *st;
>  	int ret;
> @@ -954,17 +953,90 @@ static int ad7280_probe(struct spi_device *spi)
>  	st->spi = spi;
>  	mutex_init(&st->lock);
>  
> -	if (!pdata)
> -		pdata = &ad7793_default_pdata;
> +	st->thermistor_term_en =
> +		device_property_read_bool(dev, "adi,thermistor-termination");
> +
> +	if (device_property_present(dev, "adi,acquistion-time-ns")) {
typo, adi,acquistion-time-ns -> adi,acquisition-time-ns

> +		u32 val;
> +
> +		ret = device_property_read_u32(dev, "adi,acquisition-time-ns", &val);
> +		if (ret)
> +			return ret;
> +
> +		switch (val) {
> +		case 400:
> +			st->acquisition_time = AD7280A_CTRL_LB_ACQ_TIME_400ns;
> +			break;
> +		case 800:
> +			st->acquisition_time = AD7280A_CTRL_LB_ACQ_TIME_800ns;
> +			break;
> +		case 1200:
> +			st->acquisition_time = AD7280A_CTRL_LB_ACQ_TIME_1200ns;
> +			break;
> +		case 1600:
> +			st->acquisition_time = AD7280A_CTRL_LB_ACQ_TIME_1600ns;
> +			break;
> +		default:
> +			dev_err(dev, "Firmware provided acquisition time is invalid\n");
> +			return -EINVAL;
> +		}
> +	} else {
> +		st->acquisition_time = AD7280A_CTRL_LB_ACQ_TIME_400ns;
> +	}
> +
> +	/* Alert masks are intended for when particular inputs are not wired up */
> +	if (device_property_present(dev, "adi,voltage-alert-last-chan")) {
> +		u8 val;
>  
> +		ret = device_property_read_u8(dev, "adi,voltage-alert-last-chan", &val);
I added some extra configuration to the ad7280a qemu emulation stuff to test
cases where we would have voltage and temperature channels removed from alert
generation. On my setup, these device_property_read_u8 reads gave me zeros all
the time while the u32 reads gave me the expected values.
Not sure if this is something with qemu or even some misconfiguration from my side.
Would be good if someone else could check it out.

> +		if (ret)
> +			return ret;
> +
> +		switch (val) {
> +		case 3:
> +			st->chain_last_alert_ignore |= AD7280A_ALERT_REMOVE_VIN4_VIN5;
> +			break;
> +		case 4:
> +			st->chain_last_alert_ignore |= AD7280A_ALERT_REMOVE_VIN5;
> +			break;
> +		case 5:
> +			break;
> +		default:
> +			dev_err(dev,
> +				"Firmware provided last voltage alert channel invalid\n");
> +			break;
> +		}
> +	}
> +	if (device_property_present(dev, "adi,temp-alert-last-chan")) {
> +		u8 val;
> +
> +		ret = device_property_read_u8(dev, "adi,temp-alert-last-chan", &val);
> +		if (ret)
> +			return ret;
> +
> +		switch (val) {
> +		case 3:
> +			st->chain_last_alert_ignore |= AD7280A_ALERT_REMOVE_AUX4_AUX5;
> +			break;
> +		case 4:
> +			st->chain_last_alert_ignore |= AD7280A_ALERT_REMOVE_AUX5;
> +			break;
> +		case 5:
> +			break;
> +		default:
> +			dev_err(dev,
> +				"Firmware provided last temp alert channel invalid\n");
> +			break;
> +		}
> +	}
>  	crc8_populate_msb(st->crc_tab, POLYNOM);
>  
>  	st->spi->max_speed_hz = AD7280A_MAX_SPI_CLK_HZ;
>  	st->spi->mode = SPI_MODE_1;
>  	spi_setup(st->spi);
>  
> -	st->ctrl_lb = FIELD_PREP(AD7280A_CTRL_LB_ACQ_TIME_MSK, pdata->acquisition_time) |
> -		FIELD_PREP(AD7280A_CTRL_LB_THERMISTOR_MSK, pdata->thermistor_term_en);
> +	st->ctrl_lb = FIELD_PREP(AD7280A_CTRL_LB_ACQ_TIME_MSK, st->acquisition_time) |
> +		FIELD_PREP(AD7280A_CTRL_LB_THERMISTOR_MSK, st->thermistor_term_en);
>  	st->oversampling_ratio = 0; /* No oversampling */
>  
>  	ret = ad7280_chain_setup(st);
> @@ -975,7 +1047,6 @@ static int ad7280_probe(struct spi_device *spi)
>  	st->scan_cnt = (st->slave_num + 1) * AD7280A_NUM_CH;
>  	st->cell_threshhigh = 0xFF;
>  	st->aux_threshhigh = 0xFF;
> -	st->acquisition_time = pdata->acquisition_time;
>  
>  	ret = devm_add_action_or_reset(dev, ad7280_sw_power_down, st);
>  	if (ret)
> @@ -1002,7 +1073,8 @@ static int ad7280_probe(struct spi_device *spi)
>  		ret = ad7280_write(st, ad7280a_devaddr(st->slave_num),
>  				   AD7280A_ALERT_REG, 0,
>  				   AD7280A_ALERT_GEN_STATIC_HIGH |
> -				   (pdata->chain_last_alert_ignore & 0xF));
> +				   FIELD_PREP(AD7280A_ALERT_REMOVE_MSK,
> +					      st->chain_last_alert_ignore));
>  		if (ret)
>  			return ret;
>  
> diff --git a/drivers/staging/iio/adc/ad7280a.h b/drivers/staging/iio/adc/ad7280a.h
> deleted file mode 100644
> index 99297789a46d..000000000000
> --- a/drivers/staging/iio/adc/ad7280a.h
> +++ /dev/null
> @@ -1,31 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -/*
> - * AD7280A Lithium Ion Battery Monitoring System
> - *
> - * Copyright 2011 Analog Devices Inc.
> - */
> -
> -#ifndef IIO_ADC_AD7280_H_
> -#define IIO_ADC_AD7280_H_
> -
> -/*
> - * TODO: struct ad7280_platform_data needs to go into include/linux/iio
> - */
> -
> -#define AD7280A_ACQ_TIME_400ns			0
> -#define AD7280A_ACQ_TIME_800ns			1
> -#define AD7280A_ACQ_TIME_1200ns			2
> -#define AD7280A_ACQ_TIME_1600ns			3
> -
> -#define AD7280A_ALERT_REMOVE_VIN5		BIT(2)
> -#define AD7280A_ALERT_REMOVE_VIN4_VIN5		BIT(3)
> -#define AD7280A_ALERT_REMOVE_AUX5		BIT(0)
> -#define AD7280A_ALERT_REMOVE_AUX4_AUX5		BIT(1)
> -
> -struct ad7280_platform_data {
> -	unsigned int		acquisition_time;
> -	unsigned int		chain_last_alert_ignore;
> -	bool			thermistor_term_en;
> -};
> -
> -#endif /* IIO_ADC_AD7280_H_ */
> -- 
> 2.34.1
> 
