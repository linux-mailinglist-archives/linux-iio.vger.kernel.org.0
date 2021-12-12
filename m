Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5129C471B84
	for <lists+linux-iio@lfdr.de>; Sun, 12 Dec 2021 17:17:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231602AbhLLQRH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Sun, 12 Dec 2021 11:17:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231533AbhLLQRG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 12 Dec 2021 11:17:06 -0500
Received: from haggis.mythic-beasts.com (haggis.mythic-beasts.com [IPv6:2a00:1098:0:86:1000:0:2:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9BC8C061714
        for <linux-iio@vger.kernel.org>; Sun, 12 Dec 2021 08:17:06 -0800 (PST)
Received: from [81.101.6.87] (port=52562 helo=jic23-huawei)
        by haggis.mythic-beasts.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <jic23@jic23.retrosnub.co.uk>)
        id 1mwRX6-0006j9-Kr; Sun, 12 Dec 2021 16:17:05 +0000
Date:   Sun, 12 Dec 2021 16:22:21 +0000
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     "Kunyang =?UTF-8?B?RmFu?=(=?UTF-8?B?6IyD5Z2k5o+a?=)" 
        <Kunyang_Fan@asus.com>
Cc:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Kunyang Fan <Kunyang_Fan@aaeon.com.tw>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2] iio: adc: ti-adc081c: Partial revert of removal of
 ACPI IDs
Message-ID: <20211212162153.28810ff0@jic23-huawei>
In-Reply-To: <HK0PR04MB3074C424090A590237DC4173F66F9@HK0PR04MB3074.apcprd04.prod.outlook.com>
References: <20211205172728.2826512-1-jic23@kernel.org>
        <HK0PR04MB3074C424090A590237DC4173F66F9@HK0PR04MB3074.apcprd04.prod.outlook.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-BlackCat-Spam-Score: 19
X-Spam-Status: No, score=1.9
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 8 Dec 2021 07:36:16 +0000
Kunyang Fan(范坤揚) <Kunyang_Fan@asus.com> wrote:

> Hi Jonathan,
> 
> This patch is looked good to me, and I used our product UP-extremei11 to verify ADC ADC081C function.

Hi Kunayang,

If you could give a formal Tested-by tag that would be great.

I'm running a bit slow this this weekend so will try
to pick up outstanding patches mid week.

Thanks,

Jonathan

> 
> Thanks,
> 
> Kunyang
> 
> -----Original Message-----
> From: Jonathan Cameron <jic23@kernel.org>
> Sent: Monday, December 6, 2021 1:27 AM
> To: linux-iio@vger.kernel.org
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>; Kunyang Fan <Kunyang_Fan@aaeon.com.tw>; Andy Shevchenko <andy.shevchenko@gmail.com>
> Subject: [PATCH v2] iio: adc: ti-adc081c: Partial revert of removal of ACPI IDs
> 
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Unfortuanately a non standards compliant ACPI ID is known to be in the wild on some AAEON boards.
> 
> Partly revert the removal of these IDs so that ADC081C will again work + add a comment to that affect for future reference.
> 
> Whilst here use generic firmware properties rather than the ACPI specific handling previously found in this driver.
> 
> Reported-by: Kunyang Fan <Kunyang_Fan@aaeon.com.tw>
> Fixes: c458b7ca3fd0 ("iio:adc:ti-adc081c: Drop ACPI ids that seem very unlikely to be official.")
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> ---
> 
> Looking ideally for a tested-by for this from Kunyang Fan.
> 
> v2: Use generic firmware properties as Andy Shevchenko rightly suggested.
> I took it a bit further than strictly necessary as I don't like putting enums in the driver_data only to use them to index a table when we could just use the pointers directly.
> 
> Note this driver does have device tree binding documentation but that's a job for another day.  Or maybe later today if I get really bored this evening :)
> 
>  drivers/iio/adc/ti-adc081c.c | 22 +++++++++++++++++-----
>  1 file changed, 17 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti-adc081c.c b/drivers/iio/adc/ti-adc081c.c index 16fc608db36a..bd48b073e720 100644
> --- a/drivers/iio/adc/ti-adc081c.c
> +++ b/drivers/iio/adc/ti-adc081c.c
> @@ -19,6 +19,7 @@
>  #include <linux/i2c.h>
>  #include <linux/module.h>
>  #include <linux/mod_devicetable.h>
> +#include <linux/property.h>
> 
>  #include <linux/iio/iio.h>
>  #include <linux/iio/buffer.h>
> @@ -156,13 +157,16 @@ static int adc081c_probe(struct i2c_client *client,  {
>         struct iio_dev *iio;
>         struct adc081c *adc;
> -       struct adcxx1c_model *model;
> +       const struct adcxx1c_model *model;
>         int err;
> 
>         if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_WORD_DATA))
>                 return -EOPNOTSUPP;
> 
> -       model = &adcxx1c_models[id->driver_data];
> +       if (dev_fwnode(&client->dev))
> +               model = device_get_match_data(&client->dev);
> +       else
> +               model = &adcxx1c_models[id->driver_data];
> 
>         iio = devm_iio_device_alloc(&client->dev, sizeof(*adc));
>         if (!iio)
> @@ -210,10 +214,17 @@ static const struct i2c_device_id adc081c_id[] = {  };  MODULE_DEVICE_TABLE(i2c, adc081c_id);
> 
> +static const struct acpi_device_id adc081c_acpi_match[] = {
> +       /* Used on some AAEON boards */
> +       { "ADC081C", (kernel_ulong_t)&adcxx1c_models[ADC081C] },
> +       { }
> +};
> +MODULE_DEVICE_TABLE(acpi, adc081c_acpi_match);
> +
>  static const struct of_device_id adc081c_of_match[] = {
> -       { .compatible = "ti,adc081c" },
> -       { .compatible = "ti,adc101c" },
> -       { .compatible = "ti,adc121c" },
> +       { .compatible = "ti,adc081c", .data = &adcxx1c_models[ADC081C] },
> +       { .compatible = "ti,adc101c", .data = &adcxx1c_models[ADC101C] },
> +       { .compatible = "ti,adc121c", .data = &adcxx1c_models[ADC121C] },
>         { }
>  };
>  MODULE_DEVICE_TABLE(of, adc081c_of_match); @@ -222,6 +233,7 @@ static struct i2c_driver adc081c_driver = {
>         .driver = {
>                 .name = "adc081c",
>                 .of_match_table = adc081c_of_match,
> +               .acpi_match_table = adc081c_acpi_match,
>         },
>         .probe = adc081c_probe,
>         .id_table = adc081c_id,
> --
> 2.34.1
> 
> <p></p>
> 
> ===================================================================================================================================
> This email and any attachments to it contain confidential information and are intended solely for the use of the individual to whom it is addressed.If you are not the intended recipient or receive it accidentally, please immediately notify the sender by e-mail and delete the message and any attachments from your computer system, and destroy all hard copies. If any, please be advised that any unauthorized disclosure, copying, distribution or any action taken or omitted in reliance on this, is illegal and prohibited. Furthermore, any views or opinions expressed are solely those of the author and do not represent those of ASUSTeK. Thank you for your cooperation.
> ===================================================================================================================================

