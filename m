Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE53C3FEB24
	for <lists+linux-iio@lfdr.de>; Thu,  2 Sep 2021 11:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233553AbhIBJY0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 2 Sep 2021 05:24:26 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3712 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245486AbhIBJYZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 2 Sep 2021 05:24:25 -0400
Received: from fraeml709-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4H0b5w0j5Tz67Q1W;
        Thu,  2 Sep 2021 17:21:40 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml709-chm.china.huawei.com (10.206.15.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Thu, 2 Sep 2021 11:23:23 +0200
Received: from localhost (10.52.127.69) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Thu, 2 Sep 2021
 10:23:22 +0100
Date:   Thu, 2 Sep 2021 10:23:24 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     <linux-iio@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        <Kunyang_Fan@aaeon.com.tw>
Subject: Re: [PATCH v2 2/5] iio:adc:ti-adc081c: Drop ACPI ids that seem very
 unlikely to be official.
Message-ID: <20210902102324.0000327d@Huawei.com>
In-Reply-To: <20200721171444.825099-3-jic23@kernel.org>
References: <20200721171444.825099-1-jic23@kernel.org>
        <20200721171444.825099-3-jic23@kernel.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.127.69]
X-ClientProxiedBy: lhreml715-chm.china.huawei.com (10.201.108.66) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 21 Jul 2020 18:14:41 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> We have no known users of these in the wild.
> it seems very unlikely these are real IDS having the form ADCXXXX
> as that ID is owned by Achnor Datacomm not TI.
> 
> Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Kunyang reports that ACPI ID ADC081C is out in the wild on some
AAEON boards.

I'll send out a partial revert soon to bring back that ID with appropriate
comments on where it used.

Key thing in future for these sorts of IDs is we need clarity
on who is using them before agreeing to take them. In this particular
my undestanding is the driver came first and as it worked the AAEON
firmware team used the ID.

Thanks,

Jonathan


> ---
> v1->v2
> New patch 
>  drivers/iio/adc/ti-adc081c.c | 24 +-----------------------
>  1 file changed, 1 insertion(+), 23 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti-adc081c.c b/drivers/iio/adc/ti-adc081c.c
> index 9426f70a8005..8bc04cfae465 100644
> --- a/drivers/iio/adc/ti-adc081c.c
> +++ b/drivers/iio/adc/ti-adc081c.c
> @@ -19,7 +19,6 @@
>  #include <linux/i2c.h>
>  #include <linux/module.h>
>  #include <linux/mod_devicetable.h>
> -#include <linux/acpi.h>
>  
>  #include <linux/iio/iio.h>
>  #include <linux/iio/buffer.h>
> @@ -153,17 +152,7 @@ static int adc081c_probe(struct i2c_client *client,
>  	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_WORD_DATA))
>  		return -EOPNOTSUPP;
>  
> -	if (ACPI_COMPANION(&client->dev)) {
> -		const struct acpi_device_id *ad_id;
> -
> -		ad_id = acpi_match_device(client->dev.driver->acpi_match_table,
> -					  &client->dev);
> -		if (!ad_id)
> -			return -ENODEV;
> -		model = &adcxx1c_models[ad_id->driver_data];
> -	} else {
> -		model = &adcxx1c_models[id->driver_data];
> -	}
> +	model = &adcxx1c_models[id->driver_data];
>  
>  	iio = devm_iio_device_alloc(&client->dev, sizeof(*adc));
>  	if (!iio)
> @@ -238,21 +227,10 @@ static const struct of_device_id adc081c_of_match[] = {
>  };
>  MODULE_DEVICE_TABLE(of, adc081c_of_match);
>  
> -#ifdef CONFIG_ACPI
> -static const struct acpi_device_id adc081c_acpi_match[] = {
> -	{ "ADC081C", ADC081C },
> -	{ "ADC101C", ADC101C },
> -	{ "ADC121C", ADC121C },
> -	{ }
> -};
> -MODULE_DEVICE_TABLE(acpi, adc081c_acpi_match);
> -#endif
> -
>  static struct i2c_driver adc081c_driver = {
>  	.driver = {
>  		.name = "adc081c",
>  		.of_match_table = adc081c_of_match,
> -		.acpi_match_table = ACPI_PTR(adc081c_acpi_match),
>  	},
>  	.probe = adc081c_probe,
>  	.remove = adc081c_remove,

