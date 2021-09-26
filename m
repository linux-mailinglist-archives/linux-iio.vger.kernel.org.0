Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB51D4189EE
	for <lists+linux-iio@lfdr.de>; Sun, 26 Sep 2021 17:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231928AbhIZPVH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Sun, 26 Sep 2021 11:21:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:38034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231913AbhIZPVH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 26 Sep 2021 11:21:07 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 36A0A61041;
        Sun, 26 Sep 2021 15:19:29 +0000 (UTC)
Date:   Sun, 26 Sep 2021 16:23:17 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Cc:     <linux-iio@vger.kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Dragos Bogdan <dragos.bogdan@analog.com>
Subject: Re: [PATCH 5/5] iio: adis16480: fix devices that do not support
 sleep mode
Message-ID: <20210926162317.57e384d3@jic23-huawei>
In-Reply-To: <20210903141423.517028-6-nuno.sa@analog.com>
References: <20210903141423.517028-1-nuno.sa@analog.com>
        <20210903141423.517028-6-nuno.sa@analog.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 3 Sep 2021 16:14:23 +0200
Nuno Sá <nuno.sa@analog.com> wrote:

> Not all devices supported by this driver support being put to sleep
> mode. For those devices, when calling 'adis16480_stop_device()' on the
> unbind path, we where actually writing in the SYNC_SCALE register.
> 
> Fixes: 80cbc848c4fa0 ("iio: imu: adis16480: Add support for ADIS16490")
> Fixes: 82e7a1b250170 ("iio: imu: adis16480: Add support for ADIS1649x family of devices")
> Signed-off-by: Nuno Sá <nuno.sa@analog.com>

Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan

> ---
>  drivers/iio/imu/adis16480.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/imu/adis16480.c b/drivers/iio/imu/adis16480.c
> index a869a6e52a16..ed129321a14d 100644
> --- a/drivers/iio/imu/adis16480.c
> +++ b/drivers/iio/imu/adis16480.c
> @@ -144,6 +144,7 @@ struct adis16480_chip_info {
>  	unsigned int max_dec_rate;
>  	const unsigned int *filter_freqs;
>  	bool has_pps_clk_mode;
> +	bool has_sleep_cnt;
>  	const struct adis_data adis_data;
>  };
>  
> @@ -939,6 +940,7 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
>  		.temp_scale = 5650, /* 5.65 milli degree Celsius */
>  		.int_clk = 2460000,
>  		.max_dec_rate = 2048,
> +		.has_sleep_cnt = true,
>  		.filter_freqs = adis16480_def_filter_freqs,
>  		.adis_data = ADIS16480_DATA(16375, &adis16485_timeouts, 0),
>  	},
> @@ -952,6 +954,7 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
>  		.temp_scale = 5650, /* 5.65 milli degree Celsius */
>  		.int_clk = 2460000,
>  		.max_dec_rate = 2048,
> +		.has_sleep_cnt = true,
>  		.filter_freqs = adis16480_def_filter_freqs,
>  		.adis_data = ADIS16480_DATA(16480, &adis16480_timeouts, 0),
>  	},
> @@ -965,6 +968,7 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
>  		.temp_scale = 5650, /* 5.65 milli degree Celsius */
>  		.int_clk = 2460000,
>  		.max_dec_rate = 2048,
> +		.has_sleep_cnt = true,
>  		.filter_freqs = adis16480_def_filter_freqs,
>  		.adis_data = ADIS16480_DATA(16485, &adis16485_timeouts, 0),
>  	},
> @@ -978,6 +982,7 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
>  		.temp_scale = 5650, /* 5.65 milli degree Celsius */
>  		.int_clk = 2460000,
>  		.max_dec_rate = 2048,
> +		.has_sleep_cnt = true,
>  		.filter_freqs = adis16480_def_filter_freqs,
>  		.adis_data = ADIS16480_DATA(16488, &adis16485_timeouts, 0),
>  	},
> @@ -1425,9 +1430,12 @@ static int adis16480_probe(struct spi_device *spi)
>  	if (ret)
>  		return ret;
>  
> -	ret = devm_add_action_or_reset(&spi->dev, adis16480_stop, indio_dev);
> -	if (ret)
> -		return ret;
> +	if (st->chip_info->has_sleep_cnt) {
> +		ret = devm_add_action_or_reset(&spi->dev, adis16480_stop,
> +					       indio_dev);
> +		if (ret)
> +			return ret;
> +	}
>  
>  	ret = adis16480_config_irq_pin(spi->dev.of_node, st);
>  	if (ret)

