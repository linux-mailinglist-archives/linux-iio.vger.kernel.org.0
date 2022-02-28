Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58B8B4C6709
	for <lists+linux-iio@lfdr.de>; Mon, 28 Feb 2022 11:20:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbiB1KVD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 28 Feb 2022 05:21:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiB1KVD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 28 Feb 2022 05:21:03 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85AA451E4B
        for <linux-iio@vger.kernel.org>; Mon, 28 Feb 2022 02:20:24 -0800 (PST)
Received: from fraeml710-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4K6bvh0JPHz67y8L;
        Mon, 28 Feb 2022 18:19:12 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml710-chm.china.huawei.com (10.206.15.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 28 Feb 2022 11:20:22 +0100
Received: from localhost (10.47.74.66) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Mon, 28 Feb
 2022 10:20:21 +0000
Date:   Mon, 28 Feb 2022 10:20:21 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     "Sicelo A. Mhlongo" <absicsz@gmail.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        <linux-iio@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 1/2] iio: accel: add support for LIS302DL variant
Message-ID: <20220228102021.00001de1@Huawei.com>
In-Reply-To: <Yhv8+py8uAj2j6FX@tp440p.steeds.sam>
References: <Yhv8+py8uAj2j6FX@tp440p.steeds.sam>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.74.66]
X-ClientProxiedBy: lhreml718-chm.china.huawei.com (10.201.108.69) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 28 Feb 2022 00:36:42 +0200
"Sicelo A. Mhlongo" <absicsz@gmail.com> wrote:

> Add support for STMicroelectronics LIS302DL accelerometer to the st_accel
> framework.
> 
> https://www.st.com/resource/en/datasheet/lis302dl.pdf
> 
> Signed-off-by: Sicelo A. Mhlongo <absicsz@gmail.com>
> ---
>  drivers/iio/accel/st_accel.h      | 2 ++
>  drivers/iio/accel/st_accel_core.c | 1 +
>  drivers/iio/accel/st_accel_i2c.c  | 5 +++++
>  3 files changed, 8 insertions(+)
> 
> diff --git a/drivers/iio/accel/st_accel.h b/drivers/iio/accel/st_accel.h
> index 8750dea56fcb..15f4b7944362 100644
> --- a/drivers/iio/accel/st_accel.h
> +++ b/drivers/iio/accel/st_accel.h
> @@ -37,6 +37,7 @@ enum st_accel_type {
>  	LIS2DE12,
>  	LIS2HH12,
>  	ST_ACCEL_MAX,

Think about what ST_ACCEL_MAX is for...

You'll want to be above that.

However, more interestingly nothing actually uses this enum, so
you could post a precursor patch that gets rid of it entirely.

Jonathan

> +	LIS302DL,
>  };
>  
>  #define H3LIS331DL_ACCEL_DEV_NAME	"h3lis331dl_accel"
> @@ -61,6 +62,7 @@ enum st_accel_type {
>  #define LIS3DE_ACCEL_DEV_NAME		"lis3de"
>  #define LIS2DE12_ACCEL_DEV_NAME		"lis2de12"
>  #define LIS2HH12_ACCEL_DEV_NAME		"lis2hh12"
> +#define LIS302DL_ACCEL_DEV_NAME		"lis302dl"
>  
>  #ifdef CONFIG_IIO_BUFFER
>  int st_accel_allocate_ring(struct iio_dev *indio_dev);
> diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
> index 31ea19d0ba71..2a353c51c84a 100644
> --- a/drivers/iio/accel/st_accel_core.c
> +++ b/drivers/iio/accel/st_accel_core.c
> @@ -444,6 +444,7 @@ static const struct st_sensor_settings st_accel_sensors_settings[] = {
>  		.wai_addr = ST_SENSORS_DEFAULT_WAI_ADDRESS,
>  		.sensors_supported = {
>  			[0] = LIS331DL_ACCEL_DEV_NAME,
> +			[1] = LIS302DL_ACCEL_DEV_NAME,
>  		},
>  		.ch = (struct iio_chan_spec *)st_accel_8bit_channels,
>  		.odr = {
> diff --git a/drivers/iio/accel/st_accel_i2c.c b/drivers/iio/accel/st_accel_i2c.c
> index c0ce78eebad9..086e8af89e18 100644
> --- a/drivers/iio/accel/st_accel_i2c.c
> +++ b/drivers/iio/accel/st_accel_i2c.c
> @@ -107,6 +107,10 @@ static const struct of_device_id st_accel_of_match[] = {
>  		.compatible = "st,lis2hh12",
>  		.data = LIS2HH12_ACCEL_DEV_NAME,
>  	},
> +	{
> +		.compatible = "st,lis302dl",
> +		.data = LIS302DL_ACCEL_DEV_NAME,
> +	},
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, st_accel_of_match);
> @@ -142,6 +146,7 @@ static const struct i2c_device_id st_accel_id_table[] = {
>  	{ LIS3DE_ACCEL_DEV_NAME },
>  	{ LIS2DE12_ACCEL_DEV_NAME },
>  	{ LIS2HH12_ACCEL_DEV_NAME },
> +	{ LIS302DL_ACCEL_DEV_NAME },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(i2c, st_accel_id_table);

