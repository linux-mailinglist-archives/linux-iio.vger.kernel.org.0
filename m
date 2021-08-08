Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D179D3E3B40
	for <lists+linux-iio@lfdr.de>; Sun,  8 Aug 2021 18:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbhHHQCt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 8 Aug 2021 12:02:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:37436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231450AbhHHQCt (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 8 Aug 2021 12:02:49 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 51FA660EE9;
        Sun,  8 Aug 2021 16:02:29 +0000 (UTC)
Date:   Sun, 8 Aug 2021 17:05:18 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Navin Sankar Velliangiri <navin@linumiz.com>
Cc:     lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        ardeleanalex@gmail.com
Subject: Re: [PATCH v3 1/2] iio: temperature: Add MAX31865 RTD Support
Message-ID: <20210808170518.7ebfa604@jic23-huawei>
In-Reply-To: <20210804154254.241118-1-navin@linumiz.com>
References: <20210804154254.241118-1-navin@linumiz.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed,  4 Aug 2021 21:12:53 +0530
Navin Sankar Velliangiri <navin@linumiz.com> wrote:

> This patch adds support for Maxim MAX31865 RTD temperature
> sensor support.
> 
> More information can be found in:
> https://datasheets.maximintegrated.com/en/ds/MAX31865.pdf
> 
> Signed-off-by: Navin Sankar Velliangiri <navin@linumiz.com>
> 
Hi Navin,

A few follow up comments around the ABI.

Thanks,

Jonathan

> ---
> 
> Note:
> Changes in v2:
> 	-> removed unnecessary header #include <linux/util_macros.h>
> 	-> implemented mutex to protect the device state
> 	-> Added __cacheline_aligned buffer to hold the raw temperature data
> 	-> implemented separate function to enable_bias() & disable_bias()
> 	-> call max31865_init() func when updating the filter
> 	-> Added ABI documentation for reference & testing
> 	-> dropped spi_set_drvdata()  
> 
> Changes in v3:
> 	-> Moved buf[2] __cacheline_aligned to last element of struct  
> 	max31865_data
> 	-> get_unaligned_be16 is used to express the raw temp data
> 	-> Added in_temp_filter_notch_frequency_avail to check available  
> 	frequency
> 	-> removed mutex lock & unlock in max31865_probe() func  
> ---
>  .../sysfs-bus-iio-temperature-max31865        |  20 +
>  drivers/iio/temperature/Kconfig               |  10 +
>  drivers/iio/temperature/Makefile              |   1 +
>  drivers/iio/temperature/max31865.c            | 355 ++++++++++++++++++
>  4 files changed, 386 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-temperature-max31865
>  create mode 100644 drivers/iio/temperature/max31865.c
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-temperature-max31865 b/Documentation/ABI/testing/sysfs-bus-iio-temperature-max31865
> new file mode 100644
> index 000000000000..368655539627
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-temperature-max31865
> @@ -0,0 +1,20 @@
> +What:		/sys/bus/iio/devices/iio:deviceX/fault_ovuv
> +KernelVersion:	5.11
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Overvoltage or Undervoltage Input fault. The internal circuitry
> +		is protected from excessive voltages applied to the thermocouple
> +		cables at FORCE+, FORCE2, RTDIN+ & RTDIN-. This circuitry turn
> +		off when the input voltage is negative or greater than VDD.
> +
> +		Reading returns '1' if input voltage is negative or greater
> +		than VDD, otherwise '0'.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_temp_filter_notch_frequency

As mentioned below, also needs to include documentation for _available
Ideally we'll make this part of the core ABI and move this to the main docs.

> +KernelVersion:	5.11
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Notch frequency in Hz for a noise rejection filter. Used i.e for
> +		line noise rejection.
> +
> +		Valid notch filter values are 50 Hz and 60 Hz.

...

> diff --git a/drivers/iio/temperature/max31865.c b/drivers/iio/temperature/max31865.c
> new file mode 100644
> index 000000000000..dfeba8f3f6e4
> --- /dev/null
> +++ b/drivers/iio/temperature/max31865.c
> @@ -0,0 +1,355 @@

...

> +static ssize_t show_fault_ovuv(struct device *dev,
> +			      struct device_attribute *attr,
> +			      char *buf)
> +{
> +	return show_fault(dev, MAX31865_FAULT_OVUV, buf);
> +}
> +
> +static ssize_t show_filter(struct device *dev,
> +			   struct device_attribute *attr,
> +			   char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct max31865_data *data = iio_priv(indio_dev);
> +
> +	return sprintf(buf, "%d\n", data->filter_50hz ? 50 : 60);
> +}
> +
> +static ssize_t show_avail_notch_frequency(struct device *dev,
> +					  struct device_attribute *attr,
> +					  char *buf)
> +{
> +	return snprintf(buf, 12, "50 Hz\n60 Hz");

That's not the format of _available. Check the documentation for existing
_available attributes.  It should be a simple

"50 60\n"

I would prefer to see this added to the IIO core rather than done
as a custom attribute.  If you really don't want to do that for
some reason then fair enough and I'll add it to the todo list
(which is unfortunately mostly in my head or on random bits of paper,
so whether anything gets done is fairly random...)


> +}
> +
> +static ssize_t set_filter(struct device *dev,
> +			  struct device_attribute *attr,
> +			  const char *buf,
> +			  size_t len)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct max31865_data *data = iio_priv(indio_dev);
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
> +	mutex_lock(&data->lock);
> +	ret = max31865_init(data);
> +	mutex_unlock(&data->lock);
> +	if (ret)
> +		return ret;
> +
> +	return len;
> +}
> +
> +static IIO_DEVICE_ATTR(fault_ovuv, 0444, show_fault_ovuv, NULL, 0);
> +static IIO_DEVICE_ATTR(in_temp_filter_notch_frequency_avail, 0444,
> +		     show_avail_notch_frequency, NULL, 0);
> +static IIO_DEVICE_ATTR(in_temp_filter_notch_frequency, 0644,
> +		    show_filter, set_filter, 0);
> +
> +static struct attribute *max31865_attributes[] = {
> +	&iio_dev_attr_fault_ovuv.dev_attr.attr,
> +	&iio_dev_attr_in_temp_filter_notch_frequency_avail.dev_attr.attr,

No documentation for this new ABI element.  The _avail bits need
to be explicitly documented as well as what they refer to.
Also check the naming against existing attributes.
Should be _available
(I got this wrong in previous review - sorry about that!)


> +	&iio_dev_attr_in_temp_filter_notch_frequency.dev_attr.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group max31865_group = {
> +	.attrs = max31865_attributes,
> +};
> +
> +static const struct iio_info max31865_info = {
> +	.read_raw = max31865_read_raw,
> +	.attrs = &max31865_group,
> +};
> +

...
