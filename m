Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F85412989A
	for <lists+linux-iio@lfdr.de>; Mon, 23 Dec 2019 17:14:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbfLWQOk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Dec 2019 11:14:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:55194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726749AbfLWQOk (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 23 Dec 2019 11:14:40 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5AADE20709;
        Mon, 23 Dec 2019 16:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577117679;
        bh=sc1NAXSXSTffUS5HwSa7S53Ep6lge3m1oJYvquuFRQ4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bMT3wctX0ioP3qP19H9TMxcwKAy6SzVyVvquvysKXW5+TxE1pfpGNZSEWagc4sljT
         U6gT+3jHQ4ZHFM50jEnqQms1YZj8HmB2gqDDt7KcF0Rlkcwx4A6XxKdwmGFWFp8chB
         ZaZwNsXghdQpN/lRsz1tDMiXDfi8GgsOh8ERqNy8=
Date:   Mon, 23 Dec 2019 16:14:35 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH v1 3/3] iio: st_lsm6dsx: Make use of device properties
Message-ID: <20191223161435.336dd7e1@archlinux>
In-Reply-To: <20191216181925.927-3-andriy.shevchenko@linux.intel.com>
References: <20191216181925.927-1-andriy.shevchenko@linux.intel.com>
        <20191216181925.927-3-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 16 Dec 2019 20:19:25 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Device property API allows to gather device resources from different sources,
> such as ACPI. Convert the drivers to unleash the power of device property API.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Looks good to me.  I'd ideally like Lorenzo of someone else to give it
a sanity check.  However, I confident enough to add it to the branch
that gets pushed out for build tests in the meantime.

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 26 ++++++++++----------
>  1 file changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> index a7d40c02ce6b..2b01155d1f32 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -54,6 +54,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/irq.h>
>  #include <linux/pm.h>
> +#include <linux/property.h>
>  #include <linux/regmap.h>
>  #include <linux/bitfield.h>
>  
> @@ -1826,14 +1827,14 @@ static const struct iio_info st_lsm6dsx_gyro_info = {
>  	.hwfifo_set_watermark = st_lsm6dsx_set_watermark,
>  };
>  
> -static int st_lsm6dsx_of_get_drdy_pin(struct st_lsm6dsx_hw *hw, int *drdy_pin)
> +static int st_lsm6dsx_get_drdy_pin(struct st_lsm6dsx_hw *hw, int *drdy_pin)
>  {
> -	struct device_node *np = hw->dev->of_node;
> +	struct device *dev = hw->dev;
>  
> -	if (!np)
> +	if (!dev_fwnode(dev))
>  		return -EINVAL;
>  
> -	return of_property_read_u32(np, "st,drdy-int-pin", drdy_pin);
> +	return device_property_read_u32(dev, "st,drdy-int-pin", drdy_pin);
>  }
>  
>  static int
> @@ -1842,7 +1843,7 @@ st_lsm6dsx_get_drdy_reg(struct st_lsm6dsx_hw *hw,
>  {
>  	int err = 0, drdy_pin;
>  
> -	if (st_lsm6dsx_of_get_drdy_pin(hw, &drdy_pin) < 0) {
> +	if (st_lsm6dsx_get_drdy_pin(hw, &drdy_pin) < 0) {
>  		struct st_sensors_platform_data *pdata;
>  		struct device *dev = hw->dev;
>  
> @@ -1871,15 +1872,15 @@ st_lsm6dsx_get_drdy_reg(struct st_lsm6dsx_hw *hw,
>  static int st_lsm6dsx_init_shub(struct st_lsm6dsx_hw *hw)
>  {
>  	const struct st_lsm6dsx_shub_settings *hub_settings;
> -	struct device_node *np = hw->dev->of_node;
>  	struct st_sensors_platform_data *pdata;
> +	struct device *dev = hw->dev;
>  	unsigned int data;
>  	int err = 0;
>  
>  	hub_settings = &hw->settings->shub_settings;
>  
> -	pdata = (struct st_sensors_platform_data *)hw->dev->platform_data;
> -	if ((np && of_property_read_bool(np, "st,pullups")) ||
> +	pdata = (struct st_sensors_platform_data *)dev->platform_data;
> +	if ((dev_fwnode(dev) && device_property_read_bool(dev, "st,pullups")) ||
>  	    (pdata && pdata->pullups)) {
>  		err = st_lsm6dsx_set_page(hw, true);
>  		if (err < 0)
> @@ -2157,9 +2158,9 @@ static irqreturn_t st_lsm6dsx_handler_thread(int irq, void *private)
>  
>  static int st_lsm6dsx_irq_setup(struct st_lsm6dsx_hw *hw)
>  {
> -	struct device_node *np = hw->dev->of_node;
>  	struct st_sensors_platform_data *pdata;
>  	const struct st_lsm6dsx_reg *reg;
> +	struct device *dev = hw->dev;
>  	unsigned long irq_type;
>  	bool irq_active_low;
>  	int err;
> @@ -2187,8 +2188,8 @@ static int st_lsm6dsx_irq_setup(struct st_lsm6dsx_hw *hw)
>  	if (err < 0)
>  		return err;
>  
> -	pdata = (struct st_sensors_platform_data *)hw->dev->platform_data;
> -	if ((np && of_property_read_bool(np, "drive-open-drain")) ||
> +	pdata = (struct st_sensors_platform_data *)dev->platform_data;
> +	if ((dev_fwnode(dev) && device_property_read_bool(dev, "drive-open-drain")) ||
>  	    (pdata && pdata->open_drain)) {
>  		reg = &hw->settings->irq_config.od;
>  		err = regmap_update_bits(hw->regmap, reg->addr, reg->mask,
> @@ -2218,7 +2219,6 @@ int st_lsm6dsx_probe(struct device *dev, int irq, int hw_id,
>  {
>  	struct st_sensors_platform_data *pdata = dev->platform_data;
>  	const struct st_lsm6dsx_shub_settings *hub_settings;
> -	struct device_node *np = dev->of_node;
>  	struct st_lsm6dsx_hw *hw;
>  	const char *name = NULL;
>  	int i, err;
> @@ -2281,7 +2281,7 @@ int st_lsm6dsx_probe(struct device *dev, int irq, int hw_id,
>  			return err;
>  	}
>  
> -	if ((np && of_property_read_bool(np, "wakeup-source")) ||
> +	if ((dev_fwnode(dev) && device_property_read_bool(dev, "wakeup-source")) ||
>  	    (pdata && pdata->wakeup_source))
>  		device_init_wakeup(dev, true);
>  

