Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53128CCF40
	for <lists+linux-iio@lfdr.de>; Sun,  6 Oct 2019 09:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726256AbfJFHya (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 6 Oct 2019 03:54:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:40374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726207AbfJFHy3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 6 Oct 2019 03:54:29 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4636D2133F;
        Sun,  6 Oct 2019 07:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570348469;
        bh=vsNgu0i+S9qxhjw/xY2gvjEFnsBJW6nSPSSKS3btldU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GplkEyNHqr0+cWJCaNXx/qlEHvSvglfR6iQqCCiTIs/uZrtjEB2RWHSzlKwgydUA3
         SULLKe4Wq8vztXQyJdSTTR4zoJV6C/0OEMbS5p1nX/ztPz1+uzKRzo2WeLShhMcZgW
         k1E8q10kCWWaWBuJwHuHbM7AvlqjJch7RYGdZMys=
Date:   Sun, 6 Oct 2019 08:54:23 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andrea Merello <andrea.merello@gmail.com>
Cc:     patrick.havelange@essensium.com,
        paresh.chaudhary@rockwellcollins.com, pmeerw@pmeerw.net,
        lars@metafoo.de, knaack.h@gmx.de,
        matthew.weber@rockwellcollins.com, colin.king@canonical.com,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/3] iio: max31856: add option for setting mains filter
 rejection frequency
Message-ID: <20191006085423.68bcecfd@archlinux>
In-Reply-To: <20190923121714.13672-2-andrea.merello@gmail.com>
References: <20190923121714.13672-1-andrea.merello@gmail.com>
        <20190923121714.13672-2-andrea.merello@gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 23 Sep 2019 14:17:12 +0200
Andrea Merello <andrea.merello@gmail.com> wrote:

> This sensor has an embedded notch filter for reducing interferences caused
> by the power mains. This filter can be tuned to reject either 50Hz or 60Hz
> (and harmonics).
> 
> Currently the said setting is left alone (the sensor defaults to 60Hz).
> This patch introduces a IIO attribute that allows the user to set the said
> filter to the desired frequency.
> 
> NOTE: this has been intentionally not tied to any DT property to allow
> the configuration of this setting from userspace, e.g. with a GUI or by
> reading a configuration file, or maybe reading a GPIO tied to a physical
> switch or accessing some device that can autodetect the line frequency.
> 
> Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
This one is not something that can be expect to be known from the setup
of the device as it will depend on local mains frequency.

So fine, to have it as a userspace control, but the name is too generic.
We already have a number of filter attributes and we should try to
work out how to bring it inline with them.

in_X_filter_low_pass_3db_frequency
in_X_filter_high_pass_3db_frequency

So would,
in_X_filter_notch_center_frequency work?
( I suppose we should use the American spelling ;)

This kind of ignores the harmonics aspect but at least documents the
main frequency being blocked.

There is a slight complexity that we have devices that have dual
notchfilters (50 and 60Hz) and ones where you can turn it off entirely.

I suppose no value would count as off and we could perhaps use a list
for both on at the same time (though that's a bit horrible).

> ---
>  drivers/iio/temperature/max31856.c | 49 ++++++++++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
> 
> diff --git a/drivers/iio/temperature/max31856.c b/drivers/iio/temperature/max31856.c
> index 73ed550e3fc9..d12613f7ba3c 100644
> --- a/drivers/iio/temperature/max31856.c
> +++ b/drivers/iio/temperature/max31856.c
> @@ -23,6 +23,7 @@
>  #define MAX31856_CR0_1SHOT         BIT(6)
>  #define MAX31856_CR0_OCFAULT       BIT(4)
>  #define MAX31856_CR0_OCFAULT_MASK  GENMASK(5, 4)
> +#define MAX31856_CR0_FILTER_50HZ   BIT(0)
>  #define MAX31856_TC_TYPE_MASK      GENMASK(3, 0)
>  #define MAX31856_FAULT_OVUV        BIT(1)
>  #define MAX31856_FAULT_OPEN        BIT(0)
> @@ -63,6 +64,7 @@ static const struct iio_chan_spec max31856_channels[] = {
>  struct max31856_data {
>  	struct spi_device *spi;
>  	u32 thermocouple_type;
> +	bool filter_50hz;
>  };
>  
>  static int max31856_read(struct max31856_data *data, u8 reg,
> @@ -123,6 +125,11 @@ static int max31856_init(struct max31856_data *data)
>  	reg_cr0_val &= ~MAX31856_CR0_1SHOT;
>  	reg_cr0_val |= MAX31856_CR0_AUTOCONVERT;
>  
> +	if (data->filter_50hz)
> +		reg_cr0_val |= MAX31856_CR0_FILTER_50HZ;
> +	else
> +		reg_cr0_val &= ~MAX31856_CR0_FILTER_50HZ;
> +
>  	return max31856_write(data, MAX31856_CR0_REG, reg_cr0_val);
>  }
>  
> @@ -249,12 +256,53 @@ static ssize_t show_fault_oc(struct device *dev,
>  	return show_fault(dev, MAX31856_FAULT_OPEN, buf);
>  }
>  
> +static ssize_t show_filter(struct device *dev,
> +			   struct device_attribute *attr,
> +			   char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct max31856_data *data = iio_priv(indio_dev);
> +
> +	return sprintf(buf, "%d\n", data->filter_50hz ? 50 : 60);
> +}
> +
> +static ssize_t set_filter(struct device *dev,
> +			  struct device_attribute *attr,
> +			  const char *buf,
> +			  size_t len)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct max31856_data *data = iio_priv(indio_dev);
> +	unsigned int freq;
> +	int ret;
> +
> +	ret = kstrtouint(buf, 10, &freq);
> +	if (ret)
> +		return ret;
> +
> +	switch (freq) {
> +	case 50:
> +		data->filter_50hz = true;
> +		break;
> +	case 60:
> +		data->filter_50hz = false;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	max31856_init(data);
> +	return len;
> +}
> +
>  static IIO_DEVICE_ATTR(fault_ovuv, 0444, show_fault_ovuv, NULL, 0);
>  static IIO_DEVICE_ATTR(fault_oc, 0444, show_fault_oc, NULL, 0);
> +static IIO_DEVICE_ATTR(filter, 0644, show_filter, set_filter, 0);
>  
>  static struct attribute *max31856_attributes[] = {
>  	&iio_dev_attr_fault_ovuv.dev_attr.attr,
>  	&iio_dev_attr_fault_oc.dev_attr.attr,
> +	&iio_dev_attr_filter.dev_attr.attr,
>  	NULL,
>  };
>  
> @@ -280,6 +328,7 @@ static int max31856_probe(struct spi_device *spi)
>  
>  	data = iio_priv(indio_dev);
>  	data->spi = spi;
> +	data->filter_50hz = false;
>  
>  	spi_set_drvdata(spi, indio_dev);
>  

