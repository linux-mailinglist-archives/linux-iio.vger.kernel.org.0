Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2189622F696
	for <lists+linux-iio@lfdr.de>; Mon, 27 Jul 2020 19:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729927AbgG0R0v (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 27 Jul 2020 13:26:51 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2542 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726617AbgG0R0u (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 27 Jul 2020 13:26:50 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 0CDD76F1B6A00EEE974C;
        Mon, 27 Jul 2020 18:26:49 +0100 (IST)
Received: from localhost (10.227.96.57) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Mon, 27 Jul
 2020 18:26:48 +0100
Date:   Mon, 27 Jul 2020 18:26:47 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Darius Berghe <darius.berghe@analog.com>
CC:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <jic23@kernel.org>, <robh@kernel.org>
Subject: Re: [PATCH v3 2/3] ltc2471: ltc2461/ltc2463 compatible strings
Message-ID: <20200727182647.00002e3c@huawei.com>
In-Reply-To: <20200727135834.84093-3-darius.berghe@analog.com>
References: <20200727135834.84093-1-darius.berghe@analog.com>
        <20200727135834.84093-3-darius.berghe@analog.com>
Organization: Huawei tech. R&D (UK)  Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.227.96.57]
X-ClientProxiedBy: lhreml719-chm.china.huawei.com (10.201.108.70) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 27 Jul 2020 16:58:33 +0300
Darius Berghe <darius.berghe@analog.com> wrote:

> Add compatible strings for these devices in the existing ltc2471
> driver.
> 
> Signed-off-by: Darius Berghe <darius.berghe@analog.com>

Hi Darius,

A few additional minor comments from me.

> ---
>  drivers/iio/adc/ltc2471.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/adc/ltc2471.c b/drivers/iio/adc/ltc2471.c
> index e1c4e966524d..8c57203b1fe4 100644
> --- a/drivers/iio/adc/ltc2471.c
> +++ b/drivers/iio/adc/ltc2471.c
> @@ -1,5 +1,7 @@
>  /*
> - * Driver for Linear Technology LTC2471 and LTC2473 voltage monitors
> + * Driver for Linear Technology LTC2461, LTC2463, LTC2471 and LTC2473 voltage
> + * monitors.
> + * The LTC2463 is identical to the 2461, but reports a differential signal.
>   * The LTC2473 is identical to the 2471, but reports a differential signal.
>   *
>   * Copyright (C) 2017 Topic Embedded Products
> @@ -17,8 +19,10 @@
>  #include <linux/mod_devicetable.h>
>  
>  enum ltc2471_chips {
> +	ltc2461,
> +	ltc2463,
>  	ltc2471,
> -	ltc2473,
> +	ltc2473

Why drop the comma?  We've just added two new devices. Seems possible there
may be more in the future!

>  };
>  
>  struct ltc2471_data {
> @@ -122,7 +126,7 @@ static int ltc2471_i2c_probe(struct i2c_client *client,
>  	indio_dev->name = id->name;
>  	indio_dev->info = &ltc2471_info;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
> -	if (id->driver_data == ltc2473)
> +	if (id->driver_data == ltc2473 || id->driver_data == ltc2463)
If the only use of driver_data is going to be this check, then just set it
to 2473 for the 2463 and 2473.  It's not uncommon to do this when we have
a bunch of devices that look the same to software.

>  		indio_dev->channels = ltc2473_channel;
>  	else
>  		indio_dev->channels = ltc2471_channel;
> @@ -139,6 +143,8 @@ static int ltc2471_i2c_probe(struct i2c_client *client,
>  }
>  
>  static const struct i2c_device_id ltc2471_i2c_id[] = {
> +	{ "ltc2461", ltc2461 },
> +	{ "ltc2463", ltc2463 },
>  	{ "ltc2471", ltc2471 },
>  	{ "ltc2473", ltc2473 },
>  	{}
> @@ -146,6 +152,8 @@ static const struct i2c_device_id ltc2471_i2c_id[] = {
>  MODULE_DEVICE_TABLE(i2c, ltc2471_i2c_id);
>  
>  static const struct of_device_id ltc2471_of_match[] = {
> +	{ .compatible = "adi,ltc2461" },
> +	{ .compatible = "adi,ltc2463" },
>  	{ .compatible = "adi,ltc2471" },
>  	{ .compatible = "adi,ltc2473" },
>  	{}
> @@ -163,6 +171,6 @@ static struct i2c_driver ltc2471_i2c_driver = {
>  
>  module_i2c_driver(ltc2471_i2c_driver);
>  
> -MODULE_DESCRIPTION("LTC2471/LTC2473 ADC driver");
> +MODULE_DESCRIPTION("LTC2461/LTC2463/LTC2471/LTC2473 ADC driver");
>  MODULE_AUTHOR("Topic Embedded Products");
>  MODULE_LICENSE("GPL v2");

