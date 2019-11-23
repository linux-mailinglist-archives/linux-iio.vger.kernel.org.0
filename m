Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6174107E5D
	for <lists+linux-iio@lfdr.de>; Sat, 23 Nov 2019 13:30:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbfKWMaP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 23 Nov 2019 07:30:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:58538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726451AbfKWMaO (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 23 Nov 2019 07:30:14 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 871AA20714;
        Sat, 23 Nov 2019 12:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574512213;
        bh=CKhcwg5Ek23yg+2W9RJwWNFy+LajIa7vcF+12ue9zg8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eWZCzu2Ke4/H1gyMXjNo1/ZOpUIFyk7G7WDYnHVp7AKi96NUyuSNeyKaWkGl3RU3L
         WCza1GDGHkHL0ZDCwGXdVQ5x2SAUn1Rlv3jATeh/BJHESfxUNjQ0YLcAYFCBzprW6y
         KjcA2emwJl/pFHYoWjXqqeS0mXzLidtIeRjX0+eA=
Date:   Sat, 23 Nov 2019 12:30:08 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andrea Merello <andrea.merello@gmail.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Colin Ian King <colin.king@canonical.com>,
        Patrick Havelange <patrick.havelange@essensium.com>,
        Matt Weber <matthew.weber@rockwellcollins.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Chuhong Yuan <hslester96@gmail.com>,
        Daniel Gomez <dagmcr@gmail.com>, linux-iio@vger.kernel.org
Subject: Re: [v3 1/9] iio: max31856: add option for setting mains filter
 rejection frequency
Message-ID: <20191123123008.11110aac@archlinux>
In-Reply-To: <20191120144756.28424-2-andrea.merello@gmail.com>
References: <20191111153517.13862-1-andrea.merello@gmail.com>
        <20191120144756.28424-1-andrea.merello@gmail.com>
        <20191120144756.28424-2-andrea.merello@gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 20 Nov 2019 15:47:48 +0100
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
> Cc: Hartmut Knaack <knaack.h@gmx.de>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
> Cc: Colin Ian King <colin.king@canonical.com>
> Cc: Patrick Havelange <patrick.havelange@essensium.com>
> Cc: Matt Weber <matthew.weber@rockwellcollins.com>
> Cc: Matt Ranostay <matt.ranostay@konsulko.com>
> Cc: Chuhong Yuan <hslester96@gmail.com>
> Cc: Daniel Gomez <dagmcr@gmail.com>
> Cc: linux-iio@vger.kernel.org
> Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
> Reviewed-by: Matt Ranostay <matt.ranostay@konsulko.com>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/temperature/max31856.c | 50 ++++++++++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
> 
> diff --git a/drivers/iio/temperature/max31856.c b/drivers/iio/temperature/max31856.c
> index 73ed550e3fc9..d97ba9ee1598 100644
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
> @@ -249,12 +256,54 @@ static ssize_t show_fault_oc(struct device *dev,
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
> +static IIO_DEVICE_ATTR(in_temp_filter_notch_center_frequency, 0644,
> +		       show_filter, set_filter, 0);
>  
>  static struct attribute *max31856_attributes[] = {
>  	&iio_dev_attr_fault_ovuv.dev_attr.attr,
>  	&iio_dev_attr_fault_oc.dev_attr.attr,
> +	&iio_dev_attr_in_temp_filter_notch_center_frequency.dev_attr.attr,
>  	NULL,
>  };
>  
> @@ -280,6 +329,7 @@ static int max31856_probe(struct spi_device *spi)
>  
>  	data = iio_priv(indio_dev);
>  	data->spi = spi;
> +	data->filter_50hz = false;
>  
>  	spi_set_drvdata(spi, indio_dev);
>  

