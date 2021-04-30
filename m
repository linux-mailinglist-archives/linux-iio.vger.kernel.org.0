Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2518636FEC1
	for <lists+linux-iio@lfdr.de>; Fri, 30 Apr 2021 18:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbhD3QjZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 30 Apr 2021 12:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbhD3QjZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 30 Apr 2021 12:39:25 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67B9CC06174A;
        Fri, 30 Apr 2021 09:38:35 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id g7-20020a9d5f870000b02902a5831ad705so1738545oti.10;
        Fri, 30 Apr 2021 09:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gBfuH2BsHbm4HXtMuE4mf++nb7jjsYUmOtPWGImC4Hw=;
        b=sql0shj/1sh7uIVPnYr8PBsMY6oC63lj+2z7XSZqsUPwfxIwuRj+Nk+a4xwZgUbmY9
         1lLXu3nCPHn6K2QHW1TsZ1a0vHaP5vSrL19S53NBC9Ik51ozovt/ViVNF0o60ZDcICuc
         ww5TNjvusYYjcoMq+jFTjBUaTl3ifXrsvugyncjBVhKF82Ab9qmomUs8cevWqxQLA5To
         2byEuwfhjblQjLFJb+FYksznUo7iNJ6SF+IYQ+Wj81gSr3gMzG54iQz2ki3oMkOy77NS
         C6FFrBL4q3CLs1MuWc71RDhnpAC4/7REaFBXcS0yP7ehRRYZqzobmKvvDXjr2+Iuoffz
         nx8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=gBfuH2BsHbm4HXtMuE4mf++nb7jjsYUmOtPWGImC4Hw=;
        b=nGWVE5S90u9OKpmfPnkTufzLRPNdhtUur/0yliwa2uTet/9121jjT1xbv2RV06CzpX
         D0Uzp+t7SMVtcOlxbspC8vFi6nzCsmFSMxab+j8iX2agIqltqfEKJWwqN5tqjv7BEFNx
         BexfLpc5wSvAMLiMdwjvR+MTQT+ESTOw765CqEBG4O/+K4g9aorp6ZivKusktnd24W7v
         xrB6G5+JI6hKT8lGWVwacjBxwocpgz5gjsBlm7zdFpa+upKIhP9WPihpukcXQiq1aW49
         21Z+B38hvFMIn9d39NH7c/zEjlyTwhFDv95SiOY2NZxPexh32qgnGbtQ5cLF6B9QApcH
         2yVA==
X-Gm-Message-State: AOAM533y7j0Ks6bBd2B9SrvpDZuUEsHyFaPV4O06yAP5P9JKPTfKBo+I
        9h0QE0YqB0ssdXf3TDs7KUg=
X-Google-Smtp-Source: ABdhPJzj4Qbp8t5VyC3OP9wEamRZqm+jh2IE9Fn8FVIOSeFwPRMZsklW5fgbAt4uwwBsBxTBTuOvNQ==
X-Received: by 2002:a05:6830:a:: with SMTP id c10mr4252055otp.21.1619800714337;
        Fri, 30 Apr 2021 09:38:34 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a10sm774192otl.15.2021.04.30.09.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 09:38:33 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 30 Apr 2021 09:38:31 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Ivan Mikhaylov <i.mikhaylov@yadro.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH 4/4] hwmon: vcnl3020: add hwmon driver for intrusion
 sensor
Message-ID: <20210430163831.GA3163069@roeck-us.net>
References: <20210430152419.261757-1-i.mikhaylov@yadro.com>
 <20210430152419.261757-5-i.mikhaylov@yadro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210430152419.261757-5-i.mikhaylov@yadro.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Apr 30, 2021 at 06:24:19PM +0300, Ivan Mikhaylov wrote:
> Intrusion status detection via Interrupt Status Register.
> 
> Signed-off-by: Ivan Mikhaylov <i.mikhaylov@yadro.com>

I think this should, if at all, be handled using the
iio->hwmon bridge (or, in other words, require a solution
which is not chip specific).

I am also not sure if "proximity" is really appropriate to use
for intrusion detection in the sense of hardware monitoring.
This would require a proximity sensor within a chassis, which
would be both overkill and unlikely to happen in the real world.
"Intrusion", in hardware monitoring context, means "someone
opened the chassis", not "someone got [too] close".

> ---
>  drivers/hwmon/Kconfig                  |  7 +++
>  drivers/hwmon/Makefile                 |  1 +
>  drivers/hwmon/vcnl3020-hwmon.c         | 57 ++++++++++++++++++++++
>  drivers/iio/proximity/vcnl3020.c       | 67 ++++++++++++++++++++------
>  include/linux/iio/proximity/vcnl3020.h | 26 ++++++++++
>  5 files changed, 143 insertions(+), 15 deletions(-)
>  create mode 100644 drivers/hwmon/vcnl3020-hwmon.c
>  create mode 100644 include/linux/iio/proximity/vcnl3020.h
> 
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 1ecf697d8d99..862205bbb3bf 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -1916,6 +1916,13 @@ config SENSORS_TMP513
>  	  This driver can also be built as a module. If so, the module
>  	  will be called tmp513.
>  
> +config SENSORS_VCNL3020
> +	tristate "VCNL3020"
> +	depends on I2C && VCNL3020
> +	help
> +	  If you say yes here you get support for the intrusion
> +	  sensor via VCNL3020 proximity sensor.
> +
>  config SENSORS_VEXPRESS
>  	tristate "Versatile Express"
>  	depends on VEXPRESS_CONFIG
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index 09a86c5e1d29..1d96212587aa 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -186,6 +186,7 @@ obj-$(CONFIG_SENSORS_TMP108)	+= tmp108.o
>  obj-$(CONFIG_SENSORS_TMP401)	+= tmp401.o
>  obj-$(CONFIG_SENSORS_TMP421)	+= tmp421.o
>  obj-$(CONFIG_SENSORS_TMP513)	+= tmp513.o
> +obj-$(CONFIG_SENSORS_VCNL3020)	+= vcnl3020-hwmon.o
>  obj-$(CONFIG_SENSORS_VEXPRESS)	+= vexpress-hwmon.o
>  obj-$(CONFIG_SENSORS_VIA_CPUTEMP)+= via-cputemp.o
>  obj-$(CONFIG_SENSORS_VIA686A)	+= via686a.o
> diff --git a/drivers/hwmon/vcnl3020-hwmon.c b/drivers/hwmon/vcnl3020-hwmon.c
> new file mode 100644
> index 000000000000..199bea25723b
> --- /dev/null
> +++ b/drivers/hwmon/vcnl3020-hwmon.c
> @@ -0,0 +1,57 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * vcnl3020-hwmon.c - intrusion sensor.
> + *
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/i2c.h>
> +#include <linux/hwmon.h>
> +#include <linux/hwmon-sysfs.h>
> +#include <linux/device.h>
> +#include <linux/platform_device.h>
> +#include <linux/iio/proximity/vcnl3020.h>
> +
> +static ssize_t vcnl3020_show(struct device *dev,
> +			     struct device_attribute *attr, char *buf)
> +{
> +	struct vcnl3020_data *vcnl3020_data = dev_get_drvdata(dev);
> +
> +	bool data = vcnl3020_is_thr_triggered(vcnl3020_data);
> +
> +	return sprintf(buf, "%u\n", data);
> +}
> +
> +static SENSOR_DEVICE_ATTR_2_RO(intrusion0_alarm, vcnl3020, 0, 0);
> +
> +static struct attribute *vcnl3020_attrs[] = {
> +	&sensor_dev_attr_intrusion0_alarm.dev_attr.attr,
> +	NULL
> +};
> +ATTRIBUTE_GROUPS(vcnl3020);
> +
> +static int32_t vcnl3020_hwmon_probe(struct platform_device *pdev)
> +{
> +	struct vcnl3020_data *vcnl3020_data = platform_get_drvdata(pdev);
> +	struct device *hwmon_dev;
> +
> +	hwmon_dev = devm_hwmon_device_register_with_groups(&pdev->dev,
> +							   VCNL3020_DRV,
> +							   vcnl3020_data,
> +							   vcnl3020_groups);

Please note that new drivers must register using
[devm_]hwmon_device_register_with_info().

Thanks,
Guenter

> +	return PTR_ERR_OR_ZERO(hwmon_dev);
> +}
> +
> +static struct platform_driver vcnl3020_hwmon_driver = {
> +	.probe = vcnl3020_hwmon_probe,
> +	.driver = {
> +		.name = VCNL3020_DRV_HWMON,
> +	},
> +};
> +
> +module_platform_driver(vcnl3020_hwmon_driver);
> +
> +MODULE_AUTHOR("Ivan Mikhaylov <i.mikhaylov@yadro.com>");
> +MODULE_DESCRIPTION("Intrusion sensor for VCNL3020");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/iio/proximity/vcnl3020.c b/drivers/iio/proximity/vcnl3020.c
> index bff59c7af966..67baa14cc900 100644
> --- a/drivers/iio/proximity/vcnl3020.c
> +++ b/drivers/iio/proximity/vcnl3020.c
> @@ -11,9 +11,11 @@
>  #include <linux/err.h>
>  #include <linux/delay.h>
>  #include <linux/regmap.h>
> +#include <linux/platform_device.h>
>  
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> +#include <linux/iio/proximity/vcnl3020.h>
>  
>  #define VCNL3020_PROD_ID	0x21
>  
> @@ -66,18 +68,6 @@ static const int vcnl3020_prox_sampling_frequency[][2] = {
>  	{250, 0},
>  };
>  
> -/**
> - * struct vcnl3020_data - vcnl3020 specific data.
> - * @regmap:	device register map.
> - * @dev:	vcnl3020 device.
> - * @rev:	revision id.
> - */
> -struct vcnl3020_data {
> -	struct regmap *regmap;
> -	struct device *dev;
> -	u8 rev;
> -};
> -
>  /**
>   * struct vcnl3020_property - vcnl3020 property.
>   * @name:	property name.
> @@ -330,6 +320,23 @@ static int vcnl3020_write_event(struct iio_dev *indio_dev,
>  	return rc;
>  }
>  
> +#ifdef CONFIG_SENSORS_VCNL3020
> +
> +bool vcnl3020_is_thr_triggered(struct vcnl3020_data *data)
> +{
> +	int rc;
> +	unsigned int isr;
> +
> +	rc = regmap_read(data->regmap, VCNL_ISR, &isr);
> +	if (rc)
> +		return false;
> +
> +	return !!((isr & VCNL_INT_TH_LOW) || (isr & VCNL_INT_TH_HI));
> +}
> +EXPORT_SYMBOL_GPL(vcnl3020_is_thr_triggered);
> +
> +#endif
> +
>  static int vcnl3020_config_threshold(struct iio_dev *indio_dev, bool state)
>  {
>  	struct vcnl3020_data *data = iio_priv(indio_dev);
> @@ -536,6 +543,7 @@ static int vcnl3020_probe(struct i2c_client *client)
>  	struct vcnl3020_data *data;
>  	struct iio_dev *indio_dev;
>  	struct regmap *regmap;
> +	struct platform_device *pdev;
>  	int rc;
>  
>  	regmap = devm_regmap_init_i2c(client, &vcnl3020_regmap_config);
> @@ -560,10 +568,39 @@ static int vcnl3020_probe(struct i2c_client *client)
>  	indio_dev->info = &vcnl3020_info;
>  	indio_dev->channels = vcnl3020_channels;
>  	indio_dev->num_channels = ARRAY_SIZE(vcnl3020_channels);
> -	indio_dev->name = "vcnl3020";
> +	indio_dev->name = VCNL3020_DRV;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  
> -	return devm_iio_device_register(&client->dev, indio_dev);
> +	rc = devm_iio_device_register(&client->dev, indio_dev);
> +	if (rc != 0)
> +		goto err_out;
> +
> +#ifdef CONFIG_SENSORS_VCNL3020
> +
> +	pdev = platform_device_alloc(VCNL3020_DRV_HWMON, -1);
> +	if (!pdev) {
> +		dev_err(&client->dev, "Failed to allocate %s\n",
> +			VCNL3020_DRV_HWMON);
> +		rc = -ENOMEM;
> +		goto err_out;
> +	}
> +
> +	pdev->dev.parent = &indio_dev->dev;
> +	platform_set_drvdata(pdev, data);
> +	rc = platform_device_add(pdev);
> +	if (rc != 0) {
> +		dev_err(&client->dev, "Failed to register %s: %d\n",
> +			VCNL3020_DRV_HWMON, rc);
> +		platform_device_put(pdev);
> +		pdev = NULL;
> +		goto err_out;
> +	}
> +
> +#endif
> +
> +err_out:
> +
> +	return rc;
>  }
>  
>  static const struct of_device_id vcnl3020_of_match[] = {
> @@ -576,7 +613,7 @@ MODULE_DEVICE_TABLE(of, vcnl3020_of_match);
>  
>  static struct i2c_driver vcnl3020_driver = {
>  	.driver = {
> -		.name   = "vcnl3020",
> +		.name   = VCNL3020_DRV,
>  		.of_match_table = vcnl3020_of_match,
>  	},
>  	.probe_new  = vcnl3020_probe,
> diff --git a/include/linux/iio/proximity/vcnl3020.h b/include/linux/iio/proximity/vcnl3020.h
> new file mode 100644
> index 000000000000..d99783298e6e
> --- /dev/null
> +++ b/include/linux/iio/proximity/vcnl3020.h
> @@ -0,0 +1,26 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * This file describe API for VCNL3020 proximity sensor.
> + */
> +
> +#ifndef VCNL3020_PROXIMITY_H
> +#define VCNL3020_PROXIMITY_H
> +
> +#define VCNL3020_DRV_HWMON	"vcnl3020-hwmon"
> +#define VCNL3020_DRV		"vcnl3020"
> +
> +/**
> + * struct vcnl3020_data - vcnl3020 specific data.
> + * @regmap:	device register map.
> + * @dev:	vcnl3020 device.
> + * @rev:	revision id.
> + */
> +struct vcnl3020_data {
> +	struct regmap *regmap;
> +	struct device *dev;
> +	u8 rev;
> +};
> +
> +bool vcnl3020_is_thr_triggered(struct vcnl3020_data *data);
> +
> +#endif
> -- 
> 2.26.3
> 
