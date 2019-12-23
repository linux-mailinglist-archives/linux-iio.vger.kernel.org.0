Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E90EC1298BC
	for <lists+linux-iio@lfdr.de>; Mon, 23 Dec 2019 17:32:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbfLWQc0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Dec 2019 11:32:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:34018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726717AbfLWQc0 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 23 Dec 2019 11:32:26 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74B8D20663;
        Mon, 23 Dec 2019 16:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577118745;
        bh=PFvEgt3srr1NtIwxzQMtNPFZXRRCNqxnjx55LtcL2TU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kixRMpswSNvcA7Q7Od//63B9lPU6hGe3nA6OT+IGyrz2LgtpZlMfrzz12FYwhZZLm
         a/CS0jF+PjnSTmb1l5Unn+8HXq590aTgCiN5BNVJntSf3UhF7pp9/VXCUC50S9mhH0
         8RgbMOyBTU9cDnVU8hZM9Omx8FeSHozU+1KwZsYc=
Date:   Mon, 23 Dec 2019 16:32:22 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matt Ranostay <matt.ranostay@konsulko.com>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: chemical: atlas-ph-sensor: rename atlas-ph-sensor
 to atlas-sensor
Message-ID: <20191223163222.6039c888@archlinux>
In-Reply-To: <20191216000045.30482-1-matt.ranostay@konsulko.com>
References: <20191216000045.30482-1-matt.ranostay@konsulko.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 15 Dec 2019 16:00:45 -0800
Matt Ranostay <matt.ranostay@konsulko.com> wrote:

> Since the orginal scope of the driver was to only support
> the pH product from Atlas it has evolved to other sensors.
> 
> Rename the file, driver name, and regmap to atlas-sensor which
> reflects this, although keep CONFIG_ATLAS_PH_SENSOR to not cause
> regressions with current configurations.
> 
> Signed-off-by: Matt Ranostay <matt.ranostay@konsulko.com>
Seems reasonable.

Applied,

Thanks,

Jonathan

> ---
>  drivers/iio/chemical/Makefile                          |  2 +-
>  .../iio/chemical/{atlas-ph-sensor.c => atlas-sensor.c} | 10 +++++-----
>  2 files changed, 6 insertions(+), 6 deletions(-)
>  rename drivers/iio/chemical/{atlas-ph-sensor.c => atlas-sensor.c} (98%)
> 
> diff --git a/drivers/iio/chemical/Makefile b/drivers/iio/chemical/Makefile
> index f97270bc4034..33d3a595dda9 100644
> --- a/drivers/iio/chemical/Makefile
> +++ b/drivers/iio/chemical/Makefile
> @@ -4,7 +4,7 @@
>  #
>  
>  # When adding new entries keep the list in alphabetical order
> -obj-$(CONFIG_ATLAS_PH_SENSOR)	+= atlas-ph-sensor.o
> +obj-$(CONFIG_ATLAS_PH_SENSOR)	+= atlas-sensor.o
>  obj-$(CONFIG_BME680) += bme680_core.o
>  obj-$(CONFIG_BME680_I2C) += bme680_i2c.o
>  obj-$(CONFIG_BME680_SPI) += bme680_spi.o
> diff --git a/drivers/iio/chemical/atlas-ph-sensor.c b/drivers/iio/chemical/atlas-sensor.c
> similarity index 98%
> rename from drivers/iio/chemical/atlas-ph-sensor.c
> rename to drivers/iio/chemical/atlas-sensor.c
> index 6c175eb1c7a7..8cd76d828646 100644
> --- a/drivers/iio/chemical/atlas-ph-sensor.c
> +++ b/drivers/iio/chemical/atlas-sensor.c
> @@ -1,8 +1,8 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  /*
> - * atlas-ph-sensor.c - Support for Atlas Scientific OEM pH-SM sensor
> + * atlas-sensor.c - Support for Atlas Scientific OEM SM sensors
>   *
> - * Copyright (C) 2015-2018 Matt Ranostay
> + * Copyright (C) 2015-2019 Konsulko Group
>   * Author: Matt Ranostay <matt.ranostay@konsulko.com>
>   */
>  
> @@ -25,8 +25,8 @@
>  #include <linux/iio/triggered_buffer.h>
>  #include <linux/pm_runtime.h>
>  
> -#define ATLAS_REGMAP_NAME	"atlas_ph_regmap"
> -#define ATLAS_DRV_NAME		"atlas_ph"
> +#define ATLAS_REGMAP_NAME	"atlas_regmap"
> +#define ATLAS_DRV_NAME		"atlas"
>  
>  #define ATLAS_REG_DEV_TYPE		0x00
>  #define ATLAS_REG_DEV_VERSION		0x01
> @@ -681,5 +681,5 @@ static struct i2c_driver atlas_driver = {
>  module_i2c_driver(atlas_driver);
>  
>  MODULE_AUTHOR("Matt Ranostay <matt.ranostay@konsulko.com>");
> -MODULE_DESCRIPTION("Atlas Scientific pH-SM sensor");
> +MODULE_DESCRIPTION("Atlas Scientific SM sensors");
>  MODULE_LICENSE("GPL");

