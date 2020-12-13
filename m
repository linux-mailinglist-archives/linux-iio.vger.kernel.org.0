Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79E582D8EF7
	for <lists+linux-iio@lfdr.de>; Sun, 13 Dec 2020 18:13:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbgLMRNW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 13 Dec 2020 12:13:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:36330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726472AbgLMRNW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 13 Dec 2020 12:13:22 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E3D52313B;
        Sun, 13 Dec 2020 17:12:40 +0000 (UTC)
Date:   Sun, 13 Dec 2020 17:12:37 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] iio:pressure:ms5637: introduce hardware
 differentiation
Message-ID: <20201213171237.4dfe58f5@archlinux>
In-Reply-To: <20201209234857.1521453-3-alexandre.belloni@bootlin.com>
References: <20201209234857.1521453-1-alexandre.belloni@bootlin.com>
        <20201209234857.1521453-3-alexandre.belloni@bootlin.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 10 Dec 2020 00:48:53 +0100
Alexandre Belloni <alexandre.belloni@bootlin.com> wrote:

> Some sensors in the ms58xx family have a different PROM length and a
> different number of available resolution. introduce struct ms_tp_hw_data to

Introduce

> handle those differences.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>  .../iio/common/ms_sensors/ms_sensors_i2c.h    | 11 ++++++
>  drivers/iio/pressure/ms5637.c                 | 35 +++++++++++++++----
>  2 files changed, 40 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/common/ms_sensors/ms_sensors_i2c.h b/drivers/iio/common/ms_sensors/ms_sensors_i2c.h
> index bad09c80e47a..f4a88148c113 100644
> --- a/drivers/iio/common/ms_sensors/ms_sensors_i2c.h
> +++ b/drivers/iio/common/ms_sensors/ms_sensors_i2c.h
> @@ -25,6 +25,16 @@ struct ms_ht_dev {
>  	u8 res_index;
>  };
>  
> +/**
> + * struct ms_hw_data - Temperature/Pressure sensor hardware data
> + * @prom_len:		number of words in the PROM
> + * @max_res_index:	maximum sensor resolution index
> + */
> +struct ms_tp_hw_data {
> +	u8 prom_len;
> +	u8 max_res_index;
> +};
> +
>  /**
>   * struct ms_tp_dev - Temperature/Pressure sensor device structure
>   * @client:	i2c client
> @@ -36,6 +46,7 @@ struct ms_ht_dev {
>  struct ms_tp_dev {
>  	struct i2c_client *client;
>  	struct mutex lock;
> +	const struct ms_tp_hw_data *hw;
>  	u16 prom[MS_SENSORS_TP_PROM_WORDS_NB + 1];
>  	u8 res_index;
>  };
> diff --git a/drivers/iio/pressure/ms5637.c b/drivers/iio/pressure/ms5637.c
> index 7c3f0ccd917c..351bfdb24fb4 100644
> --- a/drivers/iio/pressure/ms5637.c
> +++ b/drivers/iio/pressure/ms5637.c
> @@ -30,6 +30,11 @@
>  
>  #include "../common/ms_sensors/ms_sensors_i2c.h"
>  
> +struct ms_tp_data {
> +	const char *name;
> +	const struct ms_tp_hw_data *hw;
> +};
> +
>  static const int ms5637_samp_freq[6] = { 960, 480, 240, 120, 60, 30 };
>  /* String copy of the above const for readability purpose */
>  static const char ms5637_show_samp_freq[] = "960 480 240 120 60 30";
> @@ -128,6 +133,7 @@ static const struct iio_info ms5637_info = {
>  
>  static int ms5637_probe(struct i2c_client *client)
>  {
> +	const struct ms_tp_data *data = device_get_match_data(&client->dev);

As a follow up to the earlier fun with greybus etc, have to jump through
some hoops to have a fallback here if we have a firmware type that can't
do get_match_data driver/base/sw_node.c is the one greybus is using.

We have drivers that don't do this because frankly I didn't know about it
until a month or two ago.  However, I'm not keen to introduce any
more.

Thanks,

Jonathan

>  	struct ms_tp_dev *dev_data;
>  	struct iio_dev *indio_dev;
>  	int ret;
> @@ -147,11 +153,12 @@ static int ms5637_probe(struct i2c_client *client)
>  
>  	dev_data = iio_priv(indio_dev);
>  	dev_data->client = client;
> -	dev_data->res_index = 5;
> +	dev_data->res_index = data->hw->max_res_index;
> +	dev_data->hw = data->hw;
>  	mutex_init(&dev_data->lock);
>  
>  	indio_dev->info = &ms5637_info;
> -	indio_dev->name = device_get_match_data(&client->dev);
> +	indio_dev->name = data->name;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  	indio_dev->channels = ms5637_channels;
>  	indio_dev->num_channels = ARRAY_SIZE(ms5637_channels);
> @@ -169,11 +176,27 @@ static int ms5637_probe(struct i2c_client *client)
>  	return devm_iio_device_register(&client->dev, indio_dev);
>  }
>  
> +static const struct ms_tp_hw_data ms5637_hw_data  = {
> +	.prom_len = 7,
> +	.max_res_index = 5
> +};
> +
> +static const struct ms_tp_data ms5637_data = { .name = "ms5637", .hw = &ms5637_hw_data };
> +
> +static const struct ms_tp_data ms5805_data = { .name = "ms5805", .hw = &ms5637_hw_data };
> +
> +static const struct ms_tp_data ms5837_data = { .name = "ms5837", .hw = &ms5637_hw_data };
> +
> +static const struct ms_tp_data ms8607_data = {
> +	.name = "ms8607-temppressure",
> +	.hw = &ms5637_hw_data,
> +};
> +
>  static const struct of_device_id ms5637_of_match[] = {
> -	{ .compatible = "meas,ms5637", .data = "ms5637" },
> -	{ .compatible = "meas,ms5805", .data = "ms5805" },
> -	{ .compatible = "meas,ms5837", .data = "ms5837" },
> -	{ .compatible = "meas,ms8607-temppressure", .data = "ms8607-temppressure" },
> +	{ .compatible = "meas,ms5637", .data = &ms5637_data },
> +	{ .compatible = "meas,ms5805", .data = &ms5805_data },
> +	{ .compatible = "meas,ms5837", .data = &ms5837_data },
> +	{ .compatible = "meas,ms8607-temppressure", .data = &ms8607_data },
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(of, ms5637_of_match);

