Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6654A115BE4
	for <lists+linux-iio@lfdr.de>; Sat,  7 Dec 2019 11:50:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbfLGKur (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 7 Dec 2019 05:50:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:38332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725992AbfLGKur (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 7 Dec 2019 05:50:47 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1337A2082E;
        Sat,  7 Dec 2019 10:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575715846;
        bh=K2Bk6X86VZ/yLR38WtOqtlsVYdS1dF/2Q8IYQAMwXis=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GAMbGIrIxxFemaHc2feLFRybfaPb0hzZ5idMGRfH+pzGfEbiwYiC333ZkE5aQCbaD
         1n8Dme5A9JJAffl93mxQg2rghKeQGukoAvvG/YV91LtCgrDfrormuhsBu0OBDkx3h5
         q3MI08lDItWQl2z0d1HSYYksA81GwQsQ1FMGK7S4=
Date:   Sat, 7 Dec 2019 10:50:41 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH v1 1/2] iio: adc: ti-ads1025: Get rid of legacy platform
 data
Message-ID: <20191207105041.7fb4a00e@archlinux>
In-Reply-To: <20191203111753.55146-1-andriy.shevchenko@linux.intel.com>
References: <20191203111753.55146-1-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue,  3 Dec 2019 13:17:52 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Platform data is a legacy interface to supply device properties
> to the driver. In this case we even don't have in-kernel users
> for it. Just remove it for good.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
In general I'm not in favour of removing platform data support just
for the sake of cleaning that up.  However, here where you are doing
other work on the probe section of the driver fair enough to tidy it up.

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> ---
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

