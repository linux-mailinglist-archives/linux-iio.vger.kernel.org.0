Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F872115BD3
	for <lists+linux-iio@lfdr.de>; Sat,  7 Dec 2019 11:21:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726025AbfLGKVE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 7 Dec 2019 05:21:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:59598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725992AbfLGKVE (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 7 Dec 2019 05:21:04 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BDDB2217BA;
        Sat,  7 Dec 2019 10:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575714062;
        bh=na/ehcomn3JxTQ3kUPJyXWmELDLTDJdxJCVF33rmsrw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kGtO0NQAf046r+i197eTcivYZgSTYaWkojN4+KfmIoJlZwM9SUJ9IjvQ7sprikZtX
         dJAMemhyIsPfelyGugPorcvpRvZOwC1l4FQh5tFFqPHQOG2KDGd1ZQf9iz8J0jJ/89
         Xl44J944FNwNRcLXpNaITU+t9m3GPg1zDRXNCNcM=
Date:   Sat, 7 Dec 2019 10:20:57 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Karol Wrona <k.wrona@samsung.com>
Subject: Re: [PATCH] iio: ssp_sensors: Convert to use GPIO descriptors
Message-ID: <20191207102057.30010f1b@archlinux>
In-Reply-To: <20191202085350.77149-1-linus.walleij@linaro.org>
References: <20191202085350.77149-1-linus.walleij@linaro.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon,  2 Dec 2019 09:53:50 +0100
Linus Walleij <linus.walleij@linaro.org> wrote:

> These three GPIO lines used by the Samsung sensor hub is pretty
> straight-forward to convert to use GPIO descriptors.
> 
> Cc: Karol Wrona <k.wrona@samsung.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
This one looks very straight forward, so I've applied it.

However, if anyone else has time to take a look that would be great.

Thanks,

Jonathan

> ---
>  drivers/iio/common/ssp_sensors/ssp.h     | 14 ++++++------
>  drivers/iio/common/ssp_sensors/ssp_dev.c | 29 ++++++++----------------
>  drivers/iio/common/ssp_sensors/ssp_spi.c |  8 +++----
>  3 files changed, 20 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/iio/common/ssp_sensors/ssp.h b/drivers/iio/common/ssp_sensors/ssp.h
> index 0a381bb1ae6f..abb832795619 100644
> --- a/drivers/iio/common/ssp_sensors/ssp.h
> +++ b/drivers/iio/common/ssp_sensors/ssp.h
> @@ -7,7 +7,7 @@
>  #define __SSP_SENSORHUB_H__
>  
>  #include <linux/delay.h>
> -#include <linux/gpio.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/iio/common/ssp_sensors.h>
>  #include <linux/iio/iio.h>
>  #include <linux/spi/spi.h>
> @@ -168,9 +168,9 @@ struct ssp_sensorhub_info {
>   * @fw_dl_state:	firmware download state
>   * @comm_lock:		lock protecting the handshake
>   * @pending_lock:	lock protecting pending list and completion
> - * @mcu_reset_gpio:	mcu reset line
> - * @ap_mcu_gpio:	ap to mcu gpio line
> - * @mcu_ap_gpio:	mcu to ap gpio line
> + * @mcu_reset_gpiod:	mcu reset line
> + * @ap_mcu_gpiod:	ap to mcu gpio line
> + * @mcu_ap_gpiod:	mcu to ap gpio line
>   * @pending_list:	pending list for messages queued to be sent/read
>   * @sensor_devs:	registered IIO devices table
>   * @enable_refcount:	enable reference count for wdt (watchdog timer)
> @@ -212,9 +212,9 @@ struct ssp_data {
>  	struct mutex comm_lock;
>  	struct mutex pending_lock;
>  
> -	int mcu_reset_gpio;
> -	int ap_mcu_gpio;
> -	int mcu_ap_gpio;
> +	struct gpio_desc *mcu_reset_gpiod;
> +	struct gpio_desc *ap_mcu_gpiod;
> +	struct gpio_desc *mcu_ap_gpiod;
>  
>  	struct list_head pending_list;
>  
> diff --git a/drivers/iio/common/ssp_sensors/ssp_dev.c b/drivers/iio/common/ssp_sensors/ssp_dev.c
> index 9c70553994c6..a94dbcf491ce 100644
> --- a/drivers/iio/common/ssp_sensors/ssp_dev.c
> +++ b/drivers/iio/common/ssp_sensors/ssp_dev.c
> @@ -9,7 +9,6 @@
>  #include <linux/mfd/core.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> -#include <linux/of_gpio.h>
>  #include <linux/of_platform.h>
>  #include "ssp.h"
>  
> @@ -61,9 +60,9 @@ static const struct mfd_cell sensorhub_sensor_devs[] = {
>  
>  static void ssp_toggle_mcu_reset_gpio(struct ssp_data *data)
>  {
> -	gpio_set_value(data->mcu_reset_gpio, 0);
> +	gpiod_set_value(data->mcu_reset_gpiod, 0);
>  	usleep_range(1000, 1200);
> -	gpio_set_value(data->mcu_reset_gpio, 1);
> +	gpiod_set_value(data->mcu_reset_gpiod, 1);
>  	msleep(50);
>  }
>  
> @@ -441,7 +440,6 @@ MODULE_DEVICE_TABLE(of, ssp_of_match);
>  
>  static struct ssp_data *ssp_parse_dt(struct device *dev)
>  {
> -	int ret;
>  	struct ssp_data *data;
>  	struct device_node *node = dev->of_node;
>  	const struct of_device_id *match;
> @@ -450,26 +448,17 @@ static struct ssp_data *ssp_parse_dt(struct device *dev)
>  	if (!data)
>  		return NULL;
>  
> -	data->mcu_ap_gpio = of_get_named_gpio(node, "mcu-ap-gpios", 0);
> -	if (data->mcu_ap_gpio < 0)
> -		return NULL;
> -
> -	data->ap_mcu_gpio = of_get_named_gpio(node, "ap-mcu-gpios", 0);
> -	if (data->ap_mcu_gpio < 0)
> -		return NULL;
> -
> -	data->mcu_reset_gpio = of_get_named_gpio(node, "mcu-reset-gpios", 0);
> -	if (data->mcu_reset_gpio < 0)
> +	data->mcu_ap_gpiod = devm_gpiod_get(dev, "mcu-ap", GPIOD_IN);
> +	if (IS_ERR(data->mcu_ap_gpiod))
>  		return NULL;
>  
> -	ret = devm_gpio_request_one(dev, data->ap_mcu_gpio, GPIOF_OUT_INIT_HIGH,
> -				    "ap-mcu-gpios");
> -	if (ret)
> +	data->ap_mcu_gpiod = devm_gpiod_get(dev, "ap-mcu", GPIOD_OUT_HIGH);
> +	if (IS_ERR(data->ap_mcu_gpiod))
>  		return NULL;
>  
> -	ret = devm_gpio_request_one(dev, data->mcu_reset_gpio,
> -				    GPIOF_OUT_INIT_HIGH, "mcu-reset-gpios");
> -	if (ret)
> +	data->mcu_reset_gpiod = devm_gpiod_get(dev, "mcu-reset",
> +					       GPIOD_OUT_HIGH);
> +	if (IS_ERR(data->mcu_reset_gpiod))
>  		return NULL;
>  
>  	match = of_match_node(ssp_of_match, node);
> diff --git a/drivers/iio/common/ssp_sensors/ssp_spi.c b/drivers/iio/common/ssp_sensors/ssp_spi.c
> index 7db3d5886e3e..4864c38b8d1c 100644
> --- a/drivers/iio/common/ssp_sensors/ssp_spi.c
> +++ b/drivers/iio/common/ssp_sensors/ssp_spi.c
> @@ -155,9 +155,9 @@ static int ssp_check_lines(struct ssp_data *data, bool state)
>  {
>  	int delay_cnt = 0;
>  
> -	gpio_set_value_cansleep(data->ap_mcu_gpio, state);
> +	gpiod_set_value_cansleep(data->ap_mcu_gpiod, state);
>  
> -	while (gpio_get_value_cansleep(data->mcu_ap_gpio) != state) {
> +	while (gpiod_get_value_cansleep(data->mcu_ap_gpiod) != state) {
>  		usleep_range(3000, 3500);
>  
>  		if (data->shut_down || delay_cnt++ > 500) {
> @@ -165,7 +165,7 @@ static int ssp_check_lines(struct ssp_data *data, bool state)
>  				__func__, state);
>  
>  			if (!state)
> -				gpio_set_value_cansleep(data->ap_mcu_gpio, 1);
> +				gpiod_set_value_cansleep(data->ap_mcu_gpiod, 1);
>  
>  			return -ETIMEDOUT;
>  		}
> @@ -197,7 +197,7 @@ static int ssp_do_transfer(struct ssp_data *data, struct ssp_msg *msg,
>  
>  	status = spi_write(data->spi, msg->buffer, SSP_HEADER_SIZE);
>  	if (status < 0) {
> -		gpio_set_value_cansleep(data->ap_mcu_gpio, 1);
> +		gpiod_set_value_cansleep(data->ap_mcu_gpiod, 1);
>  		dev_err(SSP_DEV, "%s spi_write fail\n", __func__);
>  		goto _error_locked;
>  	}

