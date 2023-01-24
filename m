Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84AC9679474
	for <lists+linux-iio@lfdr.de>; Tue, 24 Jan 2023 10:44:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232776AbjAXJo4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 24 Jan 2023 04:44:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232388AbjAXJoz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 24 Jan 2023 04:44:55 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 824BC9008;
        Tue, 24 Jan 2023 01:44:54 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4P1MVz2ZVpz6J9lw;
        Tue, 24 Jan 2023 17:44:11 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 24 Jan
 2023 09:44:51 +0000
Date:   Tue, 24 Jan 2023 09:44:50 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Barry Song <baohua@kernel.org>
Subject: Re: [PATCH 11/12] staging: iio: accel: adis16203: Move out of
 staging
Message-ID: <20230124094450.0000272b@Huawei.com>
In-Reply-To: <20230123211758.563383-12-jic23@kernel.org>
References: <20230123211758.563383-1-jic23@kernel.org>
        <20230123211758.563383-12-jic23@kernel.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 23 Jan 2023 21:17:57 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> The main blocker of this driver moving previously was non standard
> ABI for the 180 degree offset channel. Now support for that channel
> has been dropped, this simple driver can move out of staging.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
I forgot my own rules of posting graduations with move detection turned off.
I'm going to be doing a v2 anyway to fix the issues Rob's bot and
Krysztof pointed out in the binding so will hopefully remember to
turn move detection off for that.

> ---
>  drivers/iio/accel/Kconfig                   | 12 ++++++++++++
>  drivers/iio/accel/Makefile                  |  1 +
>  drivers/{staging => }/iio/accel/adis16203.c |  0
>  drivers/staging/iio/accel/Kconfig           | 12 ------------
>  drivers/staging/iio/accel/Makefile          |  1 -
>  5 files changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
> index b6b45d359f28..88d4b18bd5e8 100644
> --- a/drivers/iio/accel/Kconfig
> +++ b/drivers/iio/accel/Kconfig
> @@ -18,6 +18,18 @@ config ADIS16201
>  	  To compile this driver as a module, say M here: the module will
>  	  be called adis16201.
>  
> +config ADIS16203
> +	tristate "Analog Devices ADIS16203 Programmable 360 Degrees Inclinometer"
> +	depends on SPI
> +	select IIO_ADIS_LIB
> +	select IIO_ADIS_LIB_BUFFER if IIO_BUFFER
> +	help
> +	  Say Y here to build support for Analog Devices adis16203 Programmable
> +	  360 Degrees Inclinometer.
> +
> +	  To compile this driver as a module, say M here: the module will be
> +	  called adis16203.
> +
>  config ADIS16209
>  	tristate "Analog Devices ADIS16209 Dual-Axis Digital Inclinometer and Accelerometer"
>  	depends on SPI
> diff --git a/drivers/iio/accel/Makefile b/drivers/iio/accel/Makefile
> index 311ead9c3ef1..b6f0cee52659 100644
> --- a/drivers/iio/accel/Makefile
> +++ b/drivers/iio/accel/Makefile
> @@ -5,6 +5,7 @@
>  
>  # When adding new entries keep the list in alphabetical order
>  obj-$(CONFIG_ADIS16201) += adis16201.o
> +obj-$(CONFIG_ADIS16203) += adis16203.o
>  obj-$(CONFIG_ADIS16209) += adis16209.o
>  obj-$(CONFIG_ADXL313) += adxl313_core.o
>  obj-$(CONFIG_ADXL313_I2C) += adxl313_i2c.o
> diff --git a/drivers/staging/iio/accel/adis16203.c b/drivers/iio/accel/adis16203.c
> similarity index 100%
> rename from drivers/staging/iio/accel/adis16203.c
> rename to drivers/iio/accel/adis16203.c
> diff --git a/drivers/staging/iio/accel/Kconfig b/drivers/staging/iio/accel/Kconfig
> index 3318997a7009..3769af8719f3 100644
> --- a/drivers/staging/iio/accel/Kconfig
> +++ b/drivers/staging/iio/accel/Kconfig
> @@ -4,18 +4,6 @@
>  #
>  menu "Accelerometers"
>  
> -config ADIS16203
> -	tristate "Analog Devices ADIS16203 Programmable 360 Degrees Inclinometer"
> -	depends on SPI
> -	select IIO_ADIS_LIB
> -	select IIO_ADIS_LIB_BUFFER if IIO_BUFFER
> -	help
> -	  Say Y here to build support for Analog Devices adis16203 Programmable
> -	  360 Degrees Inclinometer.
> -
> -	  To compile this driver as a module, say M here: the module will be
> -	  called adis16203.
> -
>  config ADIS16240
>  	tristate "Analog Devices ADIS16240 Programmable Impact Sensor and Recorder"
>  	depends on SPI
> diff --git a/drivers/staging/iio/accel/Makefile b/drivers/staging/iio/accel/Makefile
> index 094cc9be35bd..b0beec471814 100644
> --- a/drivers/staging/iio/accel/Makefile
> +++ b/drivers/staging/iio/accel/Makefile
> @@ -3,5 +3,4 @@
>  # Makefile for industrial I/O accelerometer drivers
>  #
>  
> -obj-$(CONFIG_ADIS16203) += adis16203.o
>  obj-$(CONFIG_ADIS16240) += adis16240.o

