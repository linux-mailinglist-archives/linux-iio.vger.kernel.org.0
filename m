Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93D432B5D1A
	for <lists+linux-iio@lfdr.de>; Tue, 17 Nov 2020 11:41:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbgKQKli (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Nov 2020 05:41:38 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2111 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726853AbgKQKli (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Nov 2020 05:41:38 -0500
Received: from fraeml734-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Cb2W01j7Cz67DLW;
        Tue, 17 Nov 2020 18:39:24 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml734-chm.china.huawei.com (10.206.15.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Tue, 17 Nov 2020 11:41:35 +0100
Received: from localhost (10.47.31.177) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Tue, 17 Nov
 2020 10:41:34 +0000
Date:   Tue, 17 Nov 2020 10:41:26 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
CC:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <jic23@kernel.org>,
        <robh+dt@kernel.org>
Subject: Re: [PATCH 1/3] iio: adc: ad7887: convert dual-channel mode to
 DT/ACPI
Message-ID: <20201117104126.00000516@Huawei.com>
In-Reply-To: <20201117075254.4861-1-alexandru.ardelean@analog.com>
References: <20201117075254.4861-1-alexandru.ardelean@analog.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.31.177]
X-ClientProxiedBy: lhreml736-chm.china.huawei.com (10.201.108.87) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 17 Nov 2020 09:52:52 +0200
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> This change converts the configuration of the dual-channel mode from the
> old platform-data, to the device_property_present() function, which
> supports both device-tree and ACPI configuration setups.
> 
> With this change the old platform_data include of the driver can be
> removed.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Hi Alex,

I'm a bit in too minds about device_property_present()
vs device_property_read_bool() which are the same thing under the hood.

Not sure which one conveys the correct semantics here.
I don't feel strongly enough about it though to do more than raise
eyebrows (i.e. not blocking this series).

Jonathan

> ---
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

It ends up as the same thing internally but sort of feels like
device_property_read_bool() might be a better fit?

I assume device_property_present() will return true for say
adi,dual-channel-mode = <3>;
whereas in my head device_property_read_bool should at very least
print a warning on that (it doesn't :)



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

