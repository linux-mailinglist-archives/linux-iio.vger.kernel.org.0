Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5898E918CB
	for <lists+linux-iio@lfdr.de>; Sun, 18 Aug 2019 20:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbfHRSX4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 18 Aug 2019 14:23:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:36648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726247AbfHRSX4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 18 Aug 2019 14:23:56 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9BFB72086C;
        Sun, 18 Aug 2019 18:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566152635;
        bh=QKMDxrHIlEhHw8h/Wy2lYjL72K27cV6CI3M2K/KMOUM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rP7XGQlzlFVjxZUWypcUnNzlCMmh1/937HO6NAmKEuEqBMGczq1rRPJe9sF1+I8Pl
         FWg14floeQNEEK9m5ga3OOhWXYju5CddRLoIzVInG23cFtpf+eGjJq8TRL79GvfpLc
         kR3M3mAgkcYLwOlZcz9JayctKHNZIBgVlXFG2EJM=
Date:   Sun, 18 Aug 2019 19:23:47 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mircea Caprioru <mircea.caprioru@analog.com>
Cc:     <Michael.Hennerich@analog.com>, <stefan.popa@analog.com>,
        <lars@metafoo.de>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] staging: iio: adc: ad7192: Remove platform data
Message-ID: <20190818192347.06d5c2a9@archlinux>
In-Reply-To: <20190812090034.26769-1-mircea.caprioru@analog.com>
References: <20190812090034.26769-1-mircea.caprioru@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 12 Aug 2019 12:00:34 +0300
Mircea Caprioru <mircea.caprioru@analog.com> wrote:

> This patch removes the reference voltage entry from the platform_data
> structure. This is no longer needed since the reference voltage is obtained
> from the device tree. With this we also remove the entire ad7192.h file.
> 
> The undefined reference voltage warning is promoted to an error signaling a
> problem with the device tree.
> 
> Signed-off-by: Mircea Caprioru <mircea.caprioru@analog.com>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/adc/ad7192.c | 14 ++----------
>  drivers/staging/iio/adc/ad7192.h | 37 --------------------------------
>  2 files changed, 2 insertions(+), 49 deletions(-)
>  delete mode 100644 drivers/staging/iio/adc/ad7192.h
> 
> diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
> index df06e0570f9b..81ea2639c67c 100644
> --- a/drivers/staging/iio/adc/ad7192.c
> +++ b/drivers/staging/iio/adc/ad7192.c
> @@ -25,8 +25,6 @@
>  #include <linux/iio/triggered_buffer.h>
>  #include <linux/iio/adc/ad_sigma_delta.h>
>  
> -#include "ad7192.h"
> -
>  /* Registers */
>  #define AD7192_REG_COMM		0 /* Communications Register (WO, 8-bit) */
>  #define AD7192_REG_STAT		0 /* Status Register	     (RO, 8-bit) */
> @@ -666,16 +664,10 @@ static int ad7192_channels_config(struct iio_dev *indio_dev)
>  
>  static int ad7192_probe(struct spi_device *spi)
>  {
> -	const struct ad7192_platform_data *pdata = dev_get_platdata(&spi->dev);
>  	struct ad7192_state *st;
>  	struct iio_dev *indio_dev;
>  	int ret, voltage_uv = 0;
>  
> -	if (!pdata) {
> -		dev_err(&spi->dev, "no platform data?\n");
> -		return -ENODEV;
> -	}
> -
>  	if (!spi->irq) {
>  		dev_err(&spi->dev, "no IRQ?\n");
>  		return -ENODEV;
> @@ -713,12 +705,10 @@ static int ad7192_probe(struct spi_device *spi)
>  
>  	voltage_uv = regulator_get_voltage(st->avdd);
>  
> -	if (pdata->vref_mv)
> -		st->int_vref_mv = pdata->vref_mv;
> -	else if (voltage_uv)
> +	if (voltage_uv)
>  		st->int_vref_mv = voltage_uv / 1000;
>  	else
> -		dev_warn(&spi->dev, "reference voltage undefined\n");
> +		dev_err(&spi->dev, "Device tree error, reference voltage undefined\n");
>  
>  	spi_set_drvdata(spi, indio_dev);
>  	st->devid = spi_get_device_id(spi)->driver_data;
> diff --git a/drivers/staging/iio/adc/ad7192.h b/drivers/staging/iio/adc/ad7192.h
> deleted file mode 100644
> index f3669e1df084..000000000000
> --- a/drivers/staging/iio/adc/ad7192.h
> +++ /dev/null
> @@ -1,37 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -/*
> - * AD7190 AD7192 AD7195 SPI ADC driver
> - *
> - * Copyright 2011 Analog Devices Inc.
> - */
> -#ifndef IIO_ADC_AD7192_H_
> -#define IIO_ADC_AD7192_H_
> -
> -/*
> - * TODO: struct ad7192_platform_data needs to go into include/linux/iio
> - */
> -
> -/**
> - * struct ad7192_platform_data - platform/board specific information
> - * @vref_mv:		the external reference voltage in millivolt
> - * @clock_source_sel:	[0..3]
> - *			0 External 4.92 MHz clock connected from MCLK1 to MCLK2
> - *			1 External Clock applied to MCLK2
> - *			2 Internal 4.92 MHz Clock not available at the MCLK2 pin
> - *			3 Internal 4.92 MHz Clock available at the MCLK2 pin
> - * @ext_clk_Hz:		the external clock frequency in Hz, if not set
> - *			the driver uses the internal clock (16.776 MHz)
> - * @refin2_en:		REFIN1/REFIN2 Reference Select (AD7190/2 only)
> - * @rej60_en:		50/60Hz notch filter enable
> - * @sinc3_en:		SINC3 filter enable (default SINC4)
> - * @chop_en:		CHOP mode enable
> - * @buf_en:		buffered input mode enable
> - * @unipolar_en:	unipolar mode enable
> - * @burnout_curr_en:	constant current generators on AIN(+|-) enable
> - */
> -
> -struct ad7192_platform_data {
> -	u16		vref_mv;
> -};
> -
> -#endif /* IIO_ADC_AD7192_H_ */

