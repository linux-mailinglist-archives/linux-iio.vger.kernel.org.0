Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE994408A5
	for <lists+linux-iio@lfdr.de>; Sat, 30 Oct 2021 13:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231613AbhJ3L73 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 30 Oct 2021 07:59:29 -0400
Received: from www381.your-server.de ([78.46.137.84]:51736 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbhJ3L73 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 30 Oct 2021 07:59:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=epjfHhOY3oHGqItc3I30Oys2YR6N1rCTkfdaJmRf0TA=; b=XW1peIlgVVmm/lD5Xt1H4+E5Ei
        oM+vTCPTxApsebgiooXNpg6Hnuhm5x8EWk21fyS1mpG2ph4WOzFc76W5s0kIkw/S4mCuAMEmWSiqs
        3e17LBKNaFnF3lT1QqG76+1vNlf3xAW0u4TtKHQ+FsTcDAKAOwhI3w0gqwDxs5CmhYSSC4ScEr7wo
        00ENJ72FqKAmfTGJdt6032fPrzJN/u9ThYvT0YywIf51cmKyLs3gjiaB2cTwzwBWLoJqHXCTGMS0X
        dkIMTjQNjNeqtvURj/v/tX3jMl6EFs2faDGMavWhpP2Xo38fGVilHidoppbdshHBM99KTH+p1WmJ2
        eGLIw2+g==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1mgmym-0008k4-MM; Sat, 30 Oct 2021 13:56:56 +0200
Received: from [82.135.83.71] (helo=[192.168.178.20])
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1mgmym-000Hpt-EZ; Sat, 30 Oct 2021 13:56:56 +0200
Subject: Re: [PATCH 3/5] iio: proximity: Add SX9324 support
To:     Gwendal Grignou <gwendal@chromium.org>, jic23@kernel.org,
        swboyd@chromium.org
Cc:     andy.shevchenko@gmail.com, linux-iio@vger.kernel.org
References: <20211030111827.1494139-1-gwendal@chromium.org>
 <20211030111827.1494139-4-gwendal@chromium.org>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <078743fa-785f-9415-8195-7a2b0c4cd8de@metafoo.de>
Date:   Sat, 30 Oct 2021 13:56:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211030111827.1494139-4-gwendal@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.3/26338/Sat Oct 30 10:21:41 2021)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 10/30/21 1:18 PM, Gwendal Grignou wrote:
> [...]
Driver looks really great! Just a few small comments.
> diff --git a/drivers/iio/proximity/Kconfig b/drivers/iio/proximity/Kconfig
> index 7c7203ca3ac63..aaddf97f9b219 100644
> --- a/drivers/iio/proximity/Kconfig
> +++ b/drivers/iio/proximity/Kconfig
> @@ -112,11 +112,15 @@ config SRF04
>   	  To compile this driver as a module, choose M here: the
>   	  module will be called srf04.
>   
> +config SX_COMMON
> +	tristate
> +
>   config SX9310
>   	tristate "SX9310/SX9311 Semtech proximity sensor"
>   	select IIO_BUFFER
>   	select IIO_TRIGGERED_BUFFER
>   	select REGMAP_I2C
> +	select SX_COMMON

This part belongs int the previous patch. Same with the Makefile update 
for the common code.

>   	depends on I2C
>   	help
>   	  Say Y here to build a driver for Semtech's SX9310/SX9311 capacitive
> [...]
> diff --git a/drivers/iio/proximity/sx9324.c b/drivers/iio/proximity/sx9324.c
> new file mode 100644
> index 0000000000000..41d9c950c5abd
> --- /dev/null
> +++ b/drivers/iio/proximity/sx9324.c
> @@ -0,0 +1,931 @@
> [...]
> +
> +#include <linux/acpi.h>
> +#include <linux/bitfield.h>
> +#include <linux/delay.h>
> +#include <linux/i2c.h>
> +#include <linux/irq.h>
> +#include <linux/gpio/consumer.h>
No GPIOs in this driver.
> +#include <linux/kernel.h>
> +#include <linux/log2.h>
> +#include <linux/module.h>
> +#include <linux/pm.h>
> +#include <linux/regmap.h>
> +#include <linux/slab.h>
> [..]
> +
> +static const char * const sx9324_cs_pin_usage[] = { "HZ", "MI", "DS", "GD" };
> +
> +static ssize_t sx9324_phase_configuration_show(struct device *dev,
> +					       struct device_attribute *attr,
> +					       char *buf)
> +{
> +	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct sx_common_data *data = iio_priv(indio_dev);
> +	unsigned int val;
> +	int i, ret, pin_idx;
> +	size_t len = 0;
> +
> +	ret = regmap_read(data->regmap, SX9324_REG_AFE_PH0 + this_attr->address, &val);
> +
> +	for (i = 0; i < SX9324_NUM_PINS; i++) {
> +		pin_idx = (val & SX9324_REG_AFE_PH0_PIN_MASK(i)) >> (2 * i);
> +		len += scnprintf(buf + len, PAGE_SIZE - len, "%s,",
> +				 sx9324_cs_pin_usage[pin_idx]);
> +	}
> +	buf[len - 1] = '\n';
> +	return len;
> +}

We have IIO_ENUM, which seems like a good candidate for this.


> +
> +static ssize_t sx9324_phase_configuration_store(struct device *dev,
> +						struct device_attribute *attr,
> +						const char *buf,
> +						size_t len)
> +{
> +	return -EINVAL;
> +}
> +
> +#define IIO_DEV_ATTR_PHASE_CONFIG(_idx) \
> +IIO_DEVICE_ATTR(in_proximity_configuration##_idx, 0644, \
> +		sx9324_phase_configuration_show, \
> +		sx9324_phase_configuration_store, _idx)
> +
> +static IIO_DEV_ATTR_PHASE_CONFIG(0);
> +static IIO_DEV_ATTR_PHASE_CONFIG(1);
> +static IIO_DEV_ATTR_PHASE_CONFIG(2);
> +static IIO_DEV_ATTR_PHASE_CONFIG(3);
> +
> +/*
> + * Each entry contains the integer part (val) and the fractional part, in micro
> + * seconds. It conforms to the IIO output IIO_VAL_INT_PLUS_MICRO.
> + */
> +static const struct {
> +	int val;
> +	int val2;
> +} sx9324_samp_freq_table[] = {
> +	{1000, 0},  /* 00000: Min (no idle time) */
> +	{500, 0},  /* 00001: 2 ms */
> +	{250, 0},  /* 00010: 4 ms */
> +	{166, 666666},  /* 00011: 6 ms */
> +	{125, 0},  /* 00100: 8 ms */
> +	{100, 0},  /* 00101: 10 ms */
> +	{71, 428571},  /* 00110: 14 ms */
> +	{55, 555556},  /* 00111: 18 ms */
> +	{45, 454545},  /* 01000: 22 ms */
> +	{38, 461538},  /* 01001: 26 ms */
> +	{33, 333333},  /* 01010: 30 ms */
> +	{29, 411765},  /* 01011: 34 ms */
> +	{26, 315789},  /* 01100: 38 ms */
> +	{23, 809524},  /* 01101: 42 ms */
> +	{21, 739130},  /* 01110: 46 ms */
> +	{20, 0},  /* 01111: 50 ms */
> +	{17, 857143},  /* 10000: 56 ms */
> +	{16, 129032},  /* 10001: 62 ms */
> +	{14, 705882},  /* 10010: 68 ms */
> +	{13, 513514},  /* 10011: 74 ms */
> +	{12, 500000},  /* 10100: 80 ms */
> +	{11, 111111},  /* 10101: 90 ms */
> +	{10, 0},  /* 10110: 100 ms (Typ.) */
> +	{5, 0},  /* 10111: 200 ms */
> +	{3, 333333},  /* 11000: 300 ms */
> +	{2, 500000},  /* 11001: 400 ms */
> +	{1, 666667},  /* 11010: 600 ms */
> +	{1, 250000},  /* 11011: 800 ms */
> +	{1, 0},  /* 11100: 1 s */
> +	{0, 500000},  /* 11101: 2 s */
> +	{0, 333333},  /* 11110: 3 s */
> +	{0, 250000},  /* 11111: 4 s */
> +};
> +
> +static const unsigned int sx9324_scan_period_table[] = {
> +	2,   15,  30,  45,   60,   90,	 120,  200,
> +	400, 600, 800, 1000, 2000, 3000, 4000, 5000,
> +};
> +
> +static ssize_t sx9324_show_samp_freq_avail(struct device *dev,
> +					   struct device_attribute *attr,
> +					   char *buf)
> +{
> +	size_t len = 0;
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(sx9324_samp_freq_table); i++)
> +		len += scnprintf(buf + len, PAGE_SIZE - len, "%d.%d ",
> +				 sx9324_samp_freq_table[i].val,
> +				 sx9324_samp_freq_table[i].val2);
> +	buf[len - 1] = '\n';
> +	return len;
> +}
> +static IIO_DEV_ATTR_SAMP_FREQ_AVAIL(sx9324_show_samp_freq_avail);
Consider implementing the `read_avail`. This means you just have to 
return your table and the IIO core will handle the formatting.
> +
> [...]
> +
> +static int sx9324_set_samp_freq(struct sx_common_data *data,
> +				int val, int val2)
> +{
> +	int i, ret;
> +
> +	for (i = 0; i < ARRAY_SIZE(sx9324_samp_freq_table); i++)
> +		if (val == sx9324_samp_freq_table[i].val &&
> +		    val2 == sx9324_samp_freq_table[i].val2)
> +			break;
> +
> +	if (i == ARRAY_SIZE(sx9324_samp_freq_table))
> +		return -EINVAL;
> +
> +	mutex_lock(&data->mutex);
Does this lock here actually protect against anything? 
regmap_update_bits() has its own internal lock. Same with other locks 
around regmap calls.
> +
> +	ret = regmap_update_bits(data->regmap,
> +				 SX9324_REG_GNRL_CTRL0,
> +				 SX9324_REG_GNRL_CTRL0_SCANPERIOD_MASK, i);
> +
> +	mutex_unlock(&data->mutex);
> +
> +	return ret;
> +}
> +
>


