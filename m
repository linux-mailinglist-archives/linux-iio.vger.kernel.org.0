Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24B87115BF3
	for <lists+linux-iio@lfdr.de>; Sat,  7 Dec 2019 12:09:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726106AbfLGLJJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 7 Dec 2019 06:09:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:44172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726025AbfLGLJJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 7 Dec 2019 06:09:09 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D6ADA24673;
        Sat,  7 Dec 2019 11:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575716947;
        bh=oLGz9Hbn7E3xRHBRJ9e+gY09nePF5V/0ahYI1LllQdo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Y/xrYuJ+fLJeN7nkkF6Bju4TbdXY0LdE/DkfeEB2gOhf/QngC75dD0/FaE243ZKcA
         jeMnA7CGfzV7QjLONAJrnZZw6I5mdSCs2kzakYw5YdHjPxIV+VasrMCit2WIg0aHUL
         wzsBWE9ncwIxlPjxXNUwCfujefOYCyqZJFt8dS4A=
Date:   Sat, 7 Dec 2019 11:09:03 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH v3 1/2] iio: adc: ti-ads1025: Get rid of legacy platform
 data
Message-ID: <20191207110903.5a37f59c@archlinux>
In-Reply-To: <20191205174637.47610-1-andriy.shevchenko@linux.intel.com>
References: <20191205174637.47610-1-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu,  5 Dec 2019 19:46:36 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Platform data is a legacy interface to supply device properties
> to the driver. In this case we even don't have in-kernel users
> for it. Just remove it for good.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reverted previous version.  Please do reply to your own thread when
you do this as sometimes I forget to check if there is a newer version.

Also, whilst reverting I noticed the part number is wrong in the patch
description so fixed that up whilst applying this.

Applied.

J
> ---
> v2: no changes
>  drivers/iio/adc/ti-ads1015.c          | 18 ++++++++----------
>  include/Kbuild                        |  1 -
>  include/linux/platform_data/ads1015.h | 23 -----------------------
>  3 files changed, 8 insertions(+), 34 deletions(-)
>  delete mode 100644 include/linux/platform_data/ads1015.h
> 
> diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
> index a550b132cfb7..3b123b4f0b99 100644
> --- a/drivers/iio/adc/ti-ads1015.c
> +++ b/drivers/iio/adc/ti-ads1015.c
> @@ -21,8 +21,6 @@
>  #include <linux/mutex.h>
>  #include <linux/delay.h>
>  
> -#include <linux/platform_data/ads1015.h>
> -
>  #include <linux/iio/iio.h>
>  #include <linux/iio/types.h>
>  #include <linux/iio/sysfs.h>
> @@ -33,6 +31,8 @@
>  
>  #define ADS1015_DRV_NAME "ads1015"
>  
> +#define ADS1015_CHANNELS 8
> +
>  #define ADS1015_CONV_REG	0x00
>  #define ADS1015_CFG_REG		0x01
>  #define ADS1015_LO_THRESH_REG	0x02
> @@ -219,6 +219,12 @@ static const struct iio_event_spec ads1015_events[] = {
>  	.datasheet_name = "AIN"#_chan"-AIN"#_chan2,		\
>  }
>  
> +struct ads1015_channel_data {
> +	bool enabled;
> +	unsigned int pga;
> +	unsigned int data_rate;
> +};
> +
>  struct ads1015_thresh_data {
>  	unsigned int comp_queue;
>  	int high_thresh;
> @@ -903,14 +909,6 @@ static void ads1015_get_channels_config(struct i2c_client *client)
>  
>  	struct iio_dev *indio_dev = i2c_get_clientdata(client);
>  	struct ads1015_data *data = iio_priv(indio_dev);
> -	struct ads1015_platform_data *pdata = dev_get_platdata(&client->dev);
> -
> -	/* prefer platform data */
> -	if (pdata) {
> -		memcpy(data->channel_data, pdata->channel_data,
> -		       sizeof(data->channel_data));
> -		return;
> -	}
>  
>  #ifdef CONFIG_OF
>  	if (!ads1015_get_channels_config_of(client))
> diff --git a/include/Kbuild b/include/Kbuild
> index ffba79483cc5..498821e5d9ed 100644
> --- a/include/Kbuild
> +++ b/include/Kbuild
> @@ -443,7 +443,6 @@ header-test-			+= linux/platform_data/ad7793.h
>  header-test-			+= linux/platform_data/ad7887.h
>  header-test-			+= linux/platform_data/adau17x1.h
>  header-test-			+= linux/platform_data/adp8870.h
> -header-test-			+= linux/platform_data/ads1015.h
>  header-test-			+= linux/platform_data/ads7828.h
>  header-test-			+= linux/platform_data/apds990x.h
>  header-test-			+= linux/platform_data/arm-ux500-pm.h
> diff --git a/include/linux/platform_data/ads1015.h b/include/linux/platform_data/ads1015.h
> deleted file mode 100644
> index 4cc9ffcafcbf..000000000000
> --- a/include/linux/platform_data/ads1015.h
> +++ /dev/null
> @@ -1,23 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-or-later */
> -/*
> - * Platform Data for ADS1015 12-bit 4-input ADC
> - * (C) Copyright 2010
> - * Dirk Eibach, Guntermann & Drunck GmbH <eibach@gdsys.de>
> - */
> -
> -#ifndef LINUX_ADS1015_H
> -#define LINUX_ADS1015_H
> -
> -#define ADS1015_CHANNELS 8
> -
> -struct ads1015_channel_data {
> -	bool enabled;
> -	unsigned int pga;
> -	unsigned int data_rate;
> -};
> -
> -struct ads1015_platform_data {
> -	struct ads1015_channel_data channel_data[ADS1015_CHANNELS];
> -};
> -
> -#endif /* LINUX_ADS1015_H */

