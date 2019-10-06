Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 962F8CCF43
	for <lists+linux-iio@lfdr.de>; Sun,  6 Oct 2019 09:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbfJFH6c (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 6 Oct 2019 03:58:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:41018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726207AbfJFH6c (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 6 Oct 2019 03:58:32 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A89C720867;
        Sun,  6 Oct 2019 07:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570348710;
        bh=LtWGKWmrbxol4URDUwRdP4zKAC3Ul2iUzlVJySsf8aw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nVEIwGsfWxhQ1SgfBEGY9r/IcxP1l2fRQzY+0TpYXfynJktHKu7yCP+o97rpcqpeO
         Ihd5o0as30mXz5my03RY4MjS7fIiGqqlQ2zTmP7NIHREXbwp7C0oWdLfzRi2x1DEZj
         RfZIm7OhG3MjwfBPSEYti5KAJlXr7HWAkjL8yJKg=
Date:   Sun, 6 Oct 2019 08:58:25 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andrea Merello <andrea.merello@gmail.com>
Cc:     patrick.havelange@essensium.com,
        paresh.chaudhary@rockwellcollins.com, pmeerw@pmeerw.net,
        lars@metafoo.de, knaack.h@gmx.de,
        matthew.weber@rockwellcollins.com, colin.king@canonical.com,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 3/3] iio: max31856: add support for runtime-configuring
 the thermocouple type
Message-ID: <20191006085825.1efc1d7a@archlinux>
In-Reply-To: <20190923121714.13672-4-andrea.merello@gmail.com>
References: <20190923121714.13672-1-andrea.merello@gmail.com>
        <20190923121714.13672-4-andrea.merello@gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 23 Sep 2019 14:17:14 +0200
Andrea Merello <andrea.merello@gmail.com> wrote:

> The sensor support various thermocouple types (e.g. J, K, N, ...). The
> driver allows to configure this parameter using a DT property.
> 
> This is useful when i.e. the thermocouple is physically tied to the sensor
> and it is usually not removed, or when it is at least known in advace

advance

> which sensor will be connected to the circuit.
> 
> However, if the user can randomly connect any kind of thermocouples (i.e.
> the device exposes a connector, and the user is free to connect its own
> sensors), it would be more appropriate to provide a mechanism to
> dynamically switch from one thermocouple type to another. This can be i.e.
> handled in userspace by a GUI, a configuration file or a program that
> detects the thermocouple type by reading a GPIO, or a eeprom on the probe,
> or whatever.
> 
> This patch adds a IIO attribute that can be used to override, at run-time,
> the DT-provided setting (which serves as default).
> 
> Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
For now this is device specific ABI so you need to have an entry in
Documentation/ABI/testing/sysfs-bus-iio-max31856

Or we could consider this generic enough to put it in a file
covering other thermocouple to digital sensors.

Thanks,

Jonathan

> ---
>  drivers/iio/temperature/max31856.c | 44 ++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 
> diff --git a/drivers/iio/temperature/max31856.c b/drivers/iio/temperature/max31856.c
> index 8b2e0102fa5c..588e791c79a3 100644
> --- a/drivers/iio/temperature/max31856.c
> +++ b/drivers/iio/temperature/max31856.c
> @@ -6,6 +6,7 @@
>   * Copyright (C) 2018-2019 Rockwell Collins
>   */
>  
> +#include <linux/ctype.h>
>  #include <linux/module.h>
>  #include <linux/init.h>
>  #include <linux/err.h>
> @@ -70,6 +71,10 @@ struct max31856_data {
>  	int averaging;
>  };
>  
> +const char max31856_tc_types[] = {
> +	'B', 'E', 'J', 'K', 'N', 'R', 'S', 'T'
> +};
> +
>  static int max31856_read(struct max31856_data *data, u8 reg,
>  			 u8 val[], unsigned int read_size)
>  {
> @@ -336,16 +341,55 @@ static ssize_t set_averaging(struct device *dev,
>  	return len;
>  }
>  
> +static ssize_t show_tc_type(struct device *dev,
> +			    struct device_attribute *attr,
> +			    char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct max31856_data *data = iio_priv(indio_dev);
> +
> +	return sprintf(buf, "%c\n", max31856_tc_types[data->thermocouple_type]);
> +}
> +
> +static ssize_t set_tc_type(struct device *dev,
> +			   struct device_attribute *attr,
> +			   const char *buf,
> +			   size_t len)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct max31856_data *data = iio_priv(indio_dev);
> +	char tmp;
> +	int tc_type = -1;
> +	int i;
> +
> +	if (sscanf(buf, "%c\n", &tmp) != 1)
> +		return -EINVAL;
> +
> +	for (i = 0; i < ARRAY_SIZE(max31856_tc_types); i++) {
> +		if (max31856_tc_types[i] == toupper(tmp)) {
> +			tc_type = i;
> +			break;
> +		}
> +	}
> +	if (tc_type < 0)
> +		return -EINVAL;
> +	data->thermocouple_type = tc_type;
> +	max31856_init(data);
> +	return len;
> +}
> +
>  static IIO_DEVICE_ATTR(fault_ovuv, 0444, show_fault_ovuv, NULL, 0);
>  static IIO_DEVICE_ATTR(fault_oc, 0444, show_fault_oc, NULL, 0);
>  static IIO_DEVICE_ATTR(filter, 0644, show_filter, set_filter, 0);
>  static IIO_DEVICE_ATTR(averaging, 0644, show_averaging, set_averaging, 0);
> +static IIO_DEVICE_ATTR(thermocouple_type, 0644, show_tc_type, set_tc_type, 0);
>  
>  static struct attribute *max31856_attributes[] = {
>  	&iio_dev_attr_fault_ovuv.dev_attr.attr,
>  	&iio_dev_attr_fault_oc.dev_attr.attr,
>  	&iio_dev_attr_filter.dev_attr.attr,
>  	&iio_dev_attr_averaging.dev_attr.attr,
> +	&iio_dev_attr_thermocouple_type.dev_attr.attr,
>  	NULL,
>  };
>  

