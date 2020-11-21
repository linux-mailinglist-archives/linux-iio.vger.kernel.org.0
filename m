Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A29A12BC042
	for <lists+linux-iio@lfdr.de>; Sat, 21 Nov 2020 16:37:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727912AbgKUPg6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 21 Nov 2020 10:36:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:56660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727874AbgKUPg6 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 21 Nov 2020 10:36:58 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4DC10221F9;
        Sat, 21 Nov 2020 15:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605973017;
        bh=ZIWUXmKNqyuHZamX5Ny9BM0SvRerLjrM4kBQJUz1XLQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=O+FZ7QyqPMQK3teye/OBCmrboGKPecUAa34EiarVDt9lz1H/Cdqc8uwy4ehNMl5+X
         HcX/rIn5p08qVSyG85M0n/5K7DjkVUIgZ8AM10cMG3RP+F6BTmBwxk2NyKmoEhPH1/
         Pd47GRhtDlG6F9Uf2SjSranbeBLySqvnxH1aZEQg=
Date:   Sat, 21 Nov 2020 15:36:53 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <robh+dt@kernel.org>,
        <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2 1/4] iio: adc: ad7887: convert dual-channel mode to
 DT/ACPI
Message-ID: <20201121153653.568c7344@archlinux>
In-Reply-To: <20201119100748.57689-1-alexandru.ardelean@analog.com>
References: <20201119100748.57689-1-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 19 Nov 2020 12:07:45 +0200
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> This change converts the configuration of the dual-channel mode from the
> old platform-data, to the device_property_present() function, which
> supports both device-tree and ACPI configuration setups.
> 
> With this change the old platform_data include of the driver can be
> removed.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

Hi Alexandru,

The set looks good in general, but there is a an oddity in the driver.
If we don't provide the vref regulator, then the scale is set to reflect
the internal 2.5V reference.  Fiven the external reference only
works by overdriving the 2.5V (must be higher than that to have
an effect) I guess we could in theory clamp it to a minimum of
2.5V but anyone wiring up less than that would have built a crazy board
so we can probably ignore it.

However, as I read the datasheet in dual channel mode it should be set
to VDD not 2.5V.  Right now you could make it work in a DT file
by setting VREF==VDD regulator but that's inelegant.

If you agree with my logic, perhaps a follow up patch?

Jonathan


> ---
> 
> I'm wondering if this changeset is what was in mind here:
>  https://lore.kernel.org/linux-iio/CA+U=DsqF5tu8Be9KXeyCWD2uHvV688Nc3n=z_Xi2J6H6DFJPRQ@mail.gmail.com/T/#mbe72e4da3acea3899d0d35402ea81e52a9bc34e6
> This driver could have been simplified/reduced a whole lot more, but I'm
> not sure about it. It's a bit of patch-noise, and later
> 
> Changelog v1 -> v2:
> * dropped patch 'iio: adc: ad7887: convert driver to full DT probing'
>   not adding the device_get_match_data() logic anymore
> * added patch 'iio: adc: ad7887: remove matching code from driver'
>   hooking the chip info directly to AD7887
> * added patch 'iio: adc: ad7887: add OF match table'
>   this just adds an OF table for DT and ACPI
> 
>  drivers/iio/adc/ad7887.c             | 10 +++++-----
>  include/linux/platform_data/ad7887.h | 21 ---------------------
>  2 files changed, 5 insertions(+), 26 deletions(-)
>  delete mode 100644 include/linux/platform_data/ad7887.h
> 
> diff --git a/drivers/iio/adc/ad7887.c b/drivers/iio/adc/ad7887.c
> index 4f6f0e0e03ee..06f684c053a0 100644
> --- a/drivers/iio/adc/ad7887.c
> +++ b/drivers/iio/adc/ad7887.c
> @@ -23,8 +23,6 @@
>  #include <linux/iio/trigger_consumer.h>
>  #include <linux/iio/triggered_buffer.h>
>  
> -#include <linux/platform_data/ad7887.h>
> -
>  #define AD7887_REF_DIS		BIT(5)	/* on-chip reference disable */
>  #define AD7887_DUAL		BIT(4)	/* dual-channel mode */
>  #define AD7887_CH_AIN1		BIT(3)	/* convert on channel 1, DUAL=1 */
> @@ -241,9 +239,9 @@ static void ad7887_reg_disable(void *data)
>  
>  static int ad7887_probe(struct spi_device *spi)
>  {
> -	struct ad7887_platform_data *pdata = spi->dev.platform_data;
>  	struct ad7887_state *st;
>  	struct iio_dev *indio_dev;
> +	bool dual_mode;
>  	uint8_t mode;
>  	int ret;
>  
> @@ -286,7 +284,9 @@ static int ad7887_probe(struct spi_device *spi)
>  	mode = AD7887_PM_MODE4;
>  	if (!st->reg)
>  		mode |= AD7887_REF_DIS;
> -	if (pdata && pdata->en_dual)
> +
> +	dual_mode = device_property_present(&spi->dev, "adi,dual-channel-mode");
> +	if (dual_mode)
>  		mode |= AD7887_DUAL;
>  
>  	st->tx_cmd_buf[0] = AD7887_CH_AIN0 | mode;
> @@ -298,7 +298,7 @@ static int ad7887_probe(struct spi_device *spi)
>  	spi_message_init(&st->msg[AD7887_CH0]);
>  	spi_message_add_tail(&st->xfer[0], &st->msg[AD7887_CH0]);
>  
> -	if (pdata && pdata->en_dual) {
> +	if (dual_mode) {
>  		st->tx_cmd_buf[2] = AD7887_CH_AIN1 | mode;
>  
>  		st->xfer[1].rx_buf = &st->data[0];
> diff --git a/include/linux/platform_data/ad7887.h b/include/linux/platform_data/ad7887.h
> deleted file mode 100644
> index 9b4dca6ae70b..000000000000
> --- a/include/linux/platform_data/ad7887.h
> +++ /dev/null
> @@ -1,21 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-or-later */
> -/*
> - * AD7887 SPI ADC driver
> - *
> - * Copyright 2010 Analog Devices Inc.
> - */
> -#ifndef IIO_ADC_AD7887_H_
> -#define IIO_ADC_AD7887_H_
> -
> -/**
> - * struct ad7887_platform_data - AD7887 ADC driver platform data
> - * @en_dual: Whether to use dual channel mode. If set to true AIN1 becomes the
> - *	second input channel, and Vref is internally connected to Vdd. If set to
> - *	false the device is used in single channel mode and AIN1/Vref is used as
> - *	VREF input.
> - */
> -struct ad7887_platform_data {
> -	bool en_dual;
> -};
> -
> -#endif /* IIO_ADC_AD7887_H_ */

