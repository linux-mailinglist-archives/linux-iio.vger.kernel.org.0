Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2201F479DE8
	for <lists+linux-iio@lfdr.de>; Sat, 18 Dec 2021 23:08:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbhLRWI5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Dec 2021 17:08:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbhLRWI5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 18 Dec 2021 17:08:57 -0500
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E857C061574
        for <linux-iio@vger.kernel.org>; Sat, 18 Dec 2021 14:08:56 -0800 (PST)
Received: by mail-ua1-x936.google.com with SMTP id 107so10863281uaj.10
        for <linux-iio@vger.kernel.org>; Sat, 18 Dec 2021 14:08:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=SEY3im4az5TBb2kST6Os9Da4LJEKaNhJT8QmxLpdhqY=;
        b=kxvIYReXp2ThW3+z/vSqCHYsRVWhcjZfDdxntpEC7Eh9xWSOeSDDQmx80IpNlrqSFr
         S1cPFoqt1iaBWAhmzcrQLuWXgnRfM/TNx+ea1K9adNS79/UvRs2qKuthJ2P9oqNWNTuV
         MDEKqrmY+CQeNNjjctx7ZxXHW/i1pn2AKMGkG1LmEVK8jjf4m2xAa1KaZkHuLAkUU/bS
         2YKWPlOyK5A/IRQlT3nfst7SEByGbn19E9Aui9ffwqwlQwJBEfikTx8ZXCfpeeCt2XzW
         hnvQwGYxWXF5zlPWBMZvA30BVQStgQW0tTvkAEVlODgNlMnJLm2VFRLQdZWwoWiLaHBH
         4A7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=SEY3im4az5TBb2kST6Os9Da4LJEKaNhJT8QmxLpdhqY=;
        b=sMRw1LJ4sqbmvO6f6yQSluV7th7Od8zSgmkBt43IBOOMgzrOn3xv6dUPpY3kJcmcmI
         87XRF81WMZm3yriHg7Tq2ZixqZY0BMVYK1sxgGQIvpM7nJllaROysTOHUbYC89MEHRnT
         Qs14EyiiEpRQiKpRRhSxv3hAn/+jWkHBQNCYGIYHKLOzmMxUHb+O2iKYA3EHKs2KfX5S
         gQAxelcLlXOGEBMJLwlFmTI84TY9JdUR4SzOJzDj5y756Y1KTWOZhcRrgi56kOUqLkh4
         7wlyk586Qfwy9ys8WsJSEcSXQ+6sqkv07AzHx5R7ipnR5RW0mqJyFbviBG5VbuZIwz/F
         R64A==
X-Gm-Message-State: AOAM532zy3dpswKld1JFMDj4tmmM5YpAYd83taYFUC4kincVT6zvJyoc
        zXOe52pEfCZVl+0656Ey+AU=
X-Google-Smtp-Source: ABdhPJxwMnTzjwutARxB+W6WLFmqVl5iIhe/x3cMIBeRnYO/SxQYHAbhfDnY2G5jXXN+D7R87iAVwg==
X-Received: by 2002:a67:3085:: with SMTP id w127mr1320526vsw.72.1639865335240;
        Sat, 18 Dec 2021 14:08:55 -0800 (PST)
Received: from marsc.168.1.7 ([2804:30c:b14:b100:c080:51c0:2de2:c68a])
        by smtp.gmail.com with ESMTPSA id x34sm1603020uac.12.2021.12.18.14.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Dec 2021 14:08:54 -0800 (PST)
Date:   Sat, 18 Dec 2021 19:08:45 -0300
From:   Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Nuno Sa <Nuno.Sa@analog.com>,
        lars@metafoo.de, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 17/17] iio:adc:ad7280a: Move out of staging
Message-ID: <Yb5b7Z65EYib8xLv@marsc.168.1.7>
References: <20211205202710.2847005-1-jic23@kernel.org>
 <20211205202710.2847005-18-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211205202710.2847005-18-jic23@kernel.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Driver looks overall good.
I tested patches 1, 5, 6, 7, 8, 10, 12, 14 and 17 on qemu with the provided ad7280a
device emulation. All seem to work well (regarding device emulation limitations).

My only concern is about providing consistent settings for using custom alert
register configuration.

Besides that, I'd like to suggest two more improvements for those willing to
look at this driver after it's out of staging.
1) Think it would be worth making a mask to setting cell balance register (0x14)
values, so
		st->cb_mask[devaddr] |= 1 << (ch + 2);
would get a bit more readable.
2) Max delay values are based on ratings for 85°C max. This device may operate
in temperatures up to 105°C, but with slightly higher max delay values.
So I guess providing some configuration to operate safely in higher temperatures
would be something to do.

I'll save the reviewed-by tag for when the issue with alert register
configurations gets solved.

It's almost done.

On 12/05, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> This is a rather unusual device (in IIO anyway).  However, it has
> a near to standard userspace ABI.
> 
> Note the work to move this out of staging was done against a minimal
> QEMU model, which doesn't model all the features of the device.
> I have no intention to upstream the QEMU model as it was developed
> just to enable this driver cleanup, but am happy to share it on request.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/iio/adc/Kconfig           |   11 +
>  drivers/iio/adc/Makefile          |    1 +
>  drivers/iio/adc/ad7280a.c         | 1116 +++++++++++++++++++++++++++++
>  drivers/staging/iio/adc/Kconfig   |   11 -
>  drivers/staging/iio/adc/Makefile  |    1 -
>  drivers/staging/iio/adc/ad7280a.c | 1116 -----------------------------
>  6 files changed, 1128 insertions(+), 1128 deletions(-)
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 8bf5b62a73f4..e7906653be87 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -64,6 +64,17 @@ config AD7266
>  	  To compile this driver as a module, choose M here: the module will be
>  	  called ad7266.
>  
> +config AD7280
> +	tristate "Analog Devices AD7280A Lithium Ion Battery Monitoring System"
> +	depends on SPI
> +	select CRC8
> +	help
> +	  Say yes here to build support for Analog Devices AD7280A
> +	  Lithium Ion Battery Monitoring System.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called ad7280a
> +
>  config AD7291
>  	tristate "Analog Devices AD7291 ADC driver"
>  	depends on I2C
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index d3f53549720c..e8f8c5b0b6f7 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -10,6 +10,7 @@ obj-$(CONFIG_AD7091R5) += ad7091r5.o ad7091r-base.o
>  obj-$(CONFIG_AD7124) += ad7124.o
>  obj-$(CONFIG_AD7192) += ad7192.o
>  obj-$(CONFIG_AD7266) += ad7266.o
> +obj-$(CONFIG_AD7280) += ad7280a.o
>  obj-$(CONFIG_AD7291) += ad7291.o
>  obj-$(CONFIG_AD7292) += ad7292.o
>  obj-$(CONFIG_AD7298) += ad7298.o
> diff --git a/drivers/iio/adc/ad7280a.c b/drivers/iio/adc/ad7280a.c
> new file mode 100644
> index 000000000000..0806238debe3
> --- /dev/null
> +++ b/drivers/iio/adc/ad7280a.c
> @@ -0,0 +1,1116 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * AD7280A Lithium Ion Battery Monitoring System
> + *
> + * Copyright 2011 Analog Devices Inc.
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/crc8.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/mutex.h>
> +#include <linux/slab.h>
> +#include <linux/sysfs.h>
> +#include <linux/spi/spi.h>
> +
> +#include <linux/iio/events.h>
> +#include <linux/iio/iio.h>
> +
> +/* Registers */
> +
> +#define AD7280A_CELL_VOLTAGE_1_REG		0x0  /* D11 to D0, Read only */
> +#define AD7280A_CELL_VOLTAGE_2_REG		0x1  /* D11 to D0, Read only */
> +#define AD7280A_CELL_VOLTAGE_3_REG		0x2  /* D11 to D0, Read only */
> +#define AD7280A_CELL_VOLTAGE_4_REG		0x3  /* D11 to D0, Read only */
> +#define AD7280A_CELL_VOLTAGE_5_REG		0x4  /* D11 to D0, Read only */
> +#define AD7280A_CELL_VOLTAGE_6_REG		0x5  /* D11 to D0, Read only */
> +#define AD7280A_AUX_ADC_1_REG			0x6  /* D11 to D0, Read only */
> +#define AD7280A_AUX_ADC_2_REG			0x7  /* D11 to D0, Read only */
> +#define AD7280A_AUX_ADC_3_REG			0x8  /* D11 to D0, Read only */
> +#define AD7280A_AUX_ADC_4_REG			0x9  /* D11 to D0, Read only */
> +#define AD7280A_AUX_ADC_5_REG			0xA  /* D11 to D0, Read only */
> +#define AD7280A_AUX_ADC_6_REG			0xB  /* D11 to D0, Read only */
> +#define AD7280A_SELF_TEST_REG			0xC  /* D11 to D0, Read only */
> +
> +#define AD7280A_CTRL_HB_REG			0xD  /* D15 to D8, Read/write */
> +#define   AD7280A_CTRL_HB_CONV_INPUT_MSK		GENMASK(7, 6)
> +#define     AD7280A_CTRL_HB_CONV_INPUT_ALL			0
> +#define     AD7280A_CTRL_HB_CONV_INPUT_6CELL_AUX1_3_4		1
> +#define     AD7280A_CTRL_HB_CONV_INPUT_6CELL			2
> +#define     AD7280A_CTRL_HB_CONV_INPUT_SELF_TEST		3
> +#define   AD7280A_CTRL_HB_CONV_RREAD_MSK		GENMASK(5, 4)
> +#define     AD7280A_CTRL_HB_CONV_RREAD_ALL			0
> +#define     AD7280A_CTRL_HB_CONV_RREAD_6CELL_AUX1_3_4		1
> +#define     AD7280A_CTRL_HB_CONV_RREAD_6CELL			2
> +#define     AD7280A_CTRL_HB_CONV_RREAD_NO		        3
> +#define   AD7280A_CTRL_HB_CONV_START_MSK		BIT(3)
> +#define     AD7280A_CTRL_HB_CONV_START_CNVST			0
> +#define     AD7280A_CTRL_HB_CONV_START_CS			1
> +#define   AD7280A_CTRL_HB_CONV_AVG_MSK			GENMASK(2, 1)
> +#define     AD7280A_CTRL_HB_CONV_AVG_DIS			0
> +#define     AD7280A_CTRL_HB_CONV_AVG_2				1
> +#define     AD7280A_CTRL_HB_CONV_AVG_4			        2
> +#define     AD7280A_CTRL_HB_CONV_AVG_8			        3
> +#define   AD7280A_CTRL_HB_PWRDN_SW			BIT(0)
> +
> +#define AD7280A_CTRL_LB_REG			0xE  /* D7 to D0, Read/write */
> +#define   AD7280A_CTRL_LB_SWRST_MSK			BIT(7)
> +#define   AD7280A_CTRL_LB_ACQ_TIME_MSK			GENMASK(6, 5)
> +#define     AD7280A_CTRL_LB_ACQ_TIME_400ns			0
> +#define     AD7280A_CTRL_LB_ACQ_TIME_800ns			1
> +#define     AD7280A_CTRL_LB_ACQ_TIME_1200ns			2
> +#define     AD7280A_CTRL_LB_ACQ_TIME_1600ns			3
> +#define   AD7280A_CTRL_LB_MUST_SET			BIT(4)
> +#define   AD7280A_CTRL_LB_THERMISTOR_MSK		BIT(3)
> +#define   AD7280A_CTRL_LB_LOCK_DEV_ADDR_MSK		BIT(2)
> +#define   AD7280A_CTRL_LB_INC_DEV_ADDR_MSK		BIT(1)
> +#define   AD7280A_CTRL_LB_DAISY_CHAIN_RB_MSK		BIT(0)
> +
> +#define AD7280A_CELL_OVERVOLTAGE_REG		0xF  /* D7 to D0, Read/write */
> +#define AD7280A_CELL_UNDERVOLTAGE_REG		0x10 /* D7 to D0, Read/write */
> +#define AD7280A_AUX_ADC_OVERVOLTAGE_REG		0x11 /* D7 to D0, Read/write */
> +#define AD7280A_AUX_ADC_UNDERVOLTAGE_REG	0x12 /* D7 to D0, Read/write */
> +
> +#define AD7280A_ALERT_REG			0x13 /* D7 to D0, Read/write */
> +#define   AD7280A_ALERT_REMOVE_MSK			GENMASK(3, 0)
> +#define     AD7280A_ALERT_REMOVE_AUX5			BIT(0)
> +#define     AD7280A_ALERT_REMOVE_AUX4_AUX5		BIT(1)
> +#define     AD7280A_ALERT_REMOVE_VIN5			BIT(2)
> +#define     AD7280A_ALERT_REMOVE_VIN4_VIN5		BIT(3)
> +#define   AD7280A_ALERT_GEN_STATIC_HIGH			BIT(6)
> +#define   AD7280A_ALERT_RELAY_SIG_CHAIN_DOWN		(BIT(7) | BIT(6))
> +
> +#define AD7280A_CELL_BALANCE_REG		0x14 /* D7 to D0, Read/write */
> +#define AD7280A_CB1_TIMER_REG			0x15 /* D7 to D0, Read/write */
> +#define  AD7280A_CB_TIMER_VAL_MSK			GENMASK(7, 3)
> +#define AD7280A_CB2_TIMER_REG			0x16 /* D7 to D0, Read/write */
> +#define AD7280A_CB3_TIMER_REG			0x17 /* D7 to D0, Read/write */
> +#define AD7280A_CB4_TIMER_REG			0x18 /* D7 to D0, Read/write */
> +#define AD7280A_CB5_TIMER_REG			0x19 /* D7 to D0, Read/write */
> +#define AD7280A_CB6_TIMER_REG			0x1A /* D7 to D0, Read/write */
> +#define AD7280A_PD_TIMER_REG			0x1B /* D7 to D0, Read/write */
> +#define AD7280A_READ_REG			0x1C /* D7 to D0, Read/write */
> +#define   AD7280A_READ_ADDR_MSK				GENMASK(7, 2)
> +#define AD7280A_CNVST_CTRL_REG			0x1D /* D7 to D0, Read/write */
> +
> +/* Transfer fields */
> +#define AD7280A_TRANS_WRITE_DEVADDR_MSK		GENMASK(31, 27)
> +#define AD7280A_TRANS_WRITE_ADDR_MSK		GENMASK(26, 21)
> +#define AD7280A_TRANS_WRITE_VAL_MSK		GENMASK(20, 13)
> +#define AD7280A_TRANS_WRITE_ALL_MSK		BIT(12)
> +#define AD7280A_TRANS_WRITE_CRC_MSK		GENMASK(10, 3)
> +#define AD7280A_TRANS_WRITE_RES_PATTERN		0x2
> +
> +/* Layouts differ for channel vs other registers */
> +#define AD7280A_TRANS_READ_DEVADDR_MSK		GENMASK(31, 27)
> +#define AD7280A_TRANS_READ_CONV_CHANADDR_MSK	GENMASK(26, 23)
> +#define AD7280A_TRANS_READ_CONV_DATA_MSK	GENMASK(22, 11)
> +#define AD7280A_TRANS_READ_REG_REGADDR_MSK	GENMASK(26, 21)
> +#define AD7280A_TRANS_READ_REG_DATA_MSK		GENMASK(20, 13)
> +#define AD7280A_TRANS_READ_WRITE_ACK_MSK	BIT(10)
> +#define AD7280A_TRANS_READ_CRC_MSK		GENMASK(9, 2)
> +
> +/* Magic value used to indicate this special case */
> +#define AD7280A_ALL_CELLS				(0xAD << 16)
> +
> +#define AD7280A_MAX_SPI_CLK_HZ		700000 /* < 1MHz */
> +#define AD7280A_MAX_CHAIN		8
> +#define AD7280A_CELLS_PER_DEV		6
> +#define AD7280A_BITS			12
> +#define AD7280A_NUM_CH			(AD7280A_AUX_ADC_6_REG - \
> +					AD7280A_CELL_VOLTAGE_1_REG + 1)
> +
> +#define AD7280A_CALC_VOLTAGE_CHAN_NUM(d, c) (((d) * AD7280A_CELLS_PER_DEV) + \
> +					     (c))
> +#define AD7280A_CALC_TEMP_CHAN_NUM(d, c)    (((d) * AD7280A_CELLS_PER_DEV) + \
> +					     (c) - AD7280A_CELLS_PER_DEV)
> +
> +#define AD7280A_DEVADDR_MASTER		0
> +#define AD7280A_DEVADDR_ALL		0x1F
> +
> +static const unsigned short ad7280a_n_avg[4] = {1, 2, 4, 8};
> +static const unsigned short ad7280a_t_acq_ns[4] = {465, 1010, 1460, 1890};
> +
> +/* 5-bit device address is sent LSB first */
> +static unsigned int ad7280a_devaddr(unsigned int addr)
> +{
> +	return ((addr & 0x1) << 4) |
> +	       ((addr & 0x2) << 2) |
> +	       (addr & 0x4) |
> +	       ((addr & 0x8) >> 2) |
> +	       ((addr & 0x10) >> 4);
> +}
> +
> +/*
> + * During a read a valid write is mandatory.
> + * So writing to the highest available address (Address 0x1F) and setting the
> + * address all parts bit to 0 is recommended.
> + * So the TXVAL is AD7280A_DEVADDR_ALL + CRC
> + */
> +#define AD7280A_READ_TXVAL	0xF800030A
> +
> +/*
> + * AD7280 CRC
> + *
> + * P(x) = x^8 + x^5 + x^3 + x^2 + x^1 + x^0 = 0b100101111 => 0x2F
> + */
> +#define POLYNOM		0x2F
> +
> +struct ad7280_state {
> +	struct spi_device		*spi;
> +	struct iio_chan_spec		*channels;
> +	unsigned int			chain_last_alert_ignore;
> +	bool				thermistor_term_en;
> +	int				slave_num;
> +	int				scan_cnt;
> +	int				readback_delay_us;
> +	unsigned char			crc_tab[CRC8_TABLE_SIZE];
> +	u8				oversampling_ratio;
> +	u8				acquisition_time;
> +	unsigned char			ctrl_lb;
> +	unsigned char			cell_threshhigh;
> +	unsigned char			cell_threshlow;
> +	unsigned char			aux_threshhigh;
> +	unsigned char			aux_threshlow;
> +	unsigned char			cb_mask[AD7280A_MAX_CHAIN];
> +	struct mutex			lock; /* protect sensor state */
> +
> +	__be32				tx ____cacheline_aligned;
> +	__be32				rx;
> +};
> +
> +static unsigned char ad7280_calc_crc8(unsigned char *crc_tab, unsigned int val)
> +{
> +	unsigned char crc;
> +
> +	crc = crc_tab[val >> 16 & 0xFF];
> +	crc = crc_tab[crc ^ (val >> 8 & 0xFF)];
> +
> +	return crc ^ (val & 0xFF);
> +}
> +
> +static int ad7280_check_crc(struct ad7280_state *st, unsigned int val)
> +{
> +	unsigned char crc = ad7280_calc_crc8(st->crc_tab, val >> 10);
> +
> +	if (crc != ((val >> 2) & 0xFF))
> +		return -EIO;
> +
> +	return 0;
> +}
> +
> +/*
> + * After initiating a conversion sequence we need to wait until the conversion
> + * is done. The delay is typically in the range of 15..30us however depending on
> + * the number of devices in the daisy chain, the number of averages taken,
> + * conversion delays and acquisition time options it may take up to 250us, in
> + * this case we better sleep instead of busy wait.
> + */
> +
> +static void ad7280_delay(struct ad7280_state *st)
> +{
> +	if (st->readback_delay_us < 50)
> +		udelay(st->readback_delay_us);
> +	else
> +		usleep_range(250, 500);
> +}
> +
> +static int __ad7280_read32(struct ad7280_state *st, unsigned int *val)
> +{
> +	int ret;
> +	struct spi_transfer t = {
> +		.tx_buf	= &st->tx,
> +		.rx_buf = &st->rx,
> +		.len = sizeof(st->tx),
> +	};
> +
> +	st->tx = cpu_to_be32(AD7280A_READ_TXVAL);
> +
> +	ret = spi_sync_transfer(st->spi, &t, 1);
> +	if (ret)
> +		return ret;
> +
> +	*val = be32_to_cpu(st->rx);
> +
> +	return 0;
> +}
> +
> +static int ad7280_write(struct ad7280_state *st, unsigned int devaddr,
> +			unsigned int addr, bool all, unsigned int val)
> +{
> +	unsigned int reg = FIELD_PREP(AD7280A_TRANS_WRITE_DEVADDR_MSK, devaddr) |
> +		FIELD_PREP(AD7280A_TRANS_WRITE_ADDR_MSK, addr) |
> +		FIELD_PREP(AD7280A_TRANS_WRITE_VAL_MSK, val) |
> +		FIELD_PREP(AD7280A_TRANS_WRITE_ALL_MSK, all);
> +
> +	reg |= FIELD_PREP(AD7280A_TRANS_WRITE_CRC_MSK,
> +			ad7280_calc_crc8(st->crc_tab, reg >> 11));
> +	/* Reserved b010 pattern not included crc calc */
> +	reg |= AD7280A_TRANS_WRITE_RES_PATTERN;
> +
> +	st->tx = cpu_to_be32(reg);
> +
> +	return spi_write(st->spi, &st->tx, sizeof(st->tx));
> +}
> +
> +static int ad7280_read_reg(struct ad7280_state *st, unsigned int devaddr,
> +			   unsigned int addr)
> +{
> +	int ret;
> +	unsigned int tmp;
> +
> +	/* turns off the read operation on all parts */
> +	ret = ad7280_write(st, AD7280A_DEVADDR_MASTER, AD7280A_CTRL_HB_REG, 1,
> +			   FIELD_PREP(AD7280A_CTRL_HB_CONV_INPUT_MSK,
> +				      AD7280A_CTRL_HB_CONV_INPUT_ALL) |
> +			   FIELD_PREP(AD7280A_CTRL_HB_CONV_RREAD_MSK,
> +				      AD7280A_CTRL_HB_CONV_RREAD_NO) |
> +			   FIELD_PREP(AD7280A_CTRL_HB_CONV_AVG_MSK,
> +				      st->oversampling_ratio));
> +	if (ret)
> +		return ret;
> +
> +	/* turns on the read operation on the addressed part */
> +	ret = ad7280_write(st, devaddr, AD7280A_CTRL_HB_REG, 0,
> +			   FIELD_PREP(AD7280A_CTRL_HB_CONV_INPUT_MSK,
> +				      AD7280A_CTRL_HB_CONV_INPUT_ALL) |
> +			   FIELD_PREP(AD7280A_CTRL_HB_CONV_RREAD_MSK,
> +				      AD7280A_CTRL_HB_CONV_RREAD_ALL) |
> +			   FIELD_PREP(AD7280A_CTRL_HB_CONV_AVG_MSK,
> +				      st->oversampling_ratio));
> +	if (ret)
> +		return ret;
> +
> +	/* Set register address on the part to be read from */
> +	ret = ad7280_write(st, devaddr, AD7280A_READ_REG, 0,
> +			   FIELD_PREP(AD7280A_READ_ADDR_MSK, addr));
> +	if (ret)
> +		return ret;
> +
> +	ret = __ad7280_read32(st, &tmp);
> +	if (ret)
> +		return ret;
> +
> +	if (ad7280_check_crc(st, tmp))
> +		return -EIO;
> +
> +	if ((FIELD_GET(AD7280A_TRANS_READ_DEVADDR_MSK, tmp) != devaddr) ||
> +	    (FIELD_GET(AD7280A_TRANS_READ_REG_REGADDR_MSK, tmp) != addr))
> +		return -EFAULT;
> +
> +	return FIELD_GET(AD7280A_TRANS_READ_REG_DATA_MSK, tmp);
> +}
> +
> +static int ad7280_read_channel(struct ad7280_state *st, unsigned int devaddr,
> +			       unsigned int addr)
> +{
> +	int ret;
> +	unsigned int tmp;
> +
> +	ret = ad7280_write(st, devaddr, AD7280A_READ_REG, 0,
> +			   FIELD_PREP(AD7280A_READ_ADDR_MSK, addr));
> +	if (ret)
> +		return ret;
> +
> +	ret = ad7280_write(st, AD7280A_DEVADDR_MASTER, AD7280A_CTRL_HB_REG, 1,
> +			   FIELD_PREP(AD7280A_CTRL_HB_CONV_INPUT_MSK,
> +				      AD7280A_CTRL_HB_CONV_INPUT_ALL) |
> +			   FIELD_PREP(AD7280A_CTRL_HB_CONV_RREAD_MSK,
> +				      AD7280A_CTRL_HB_CONV_RREAD_NO) |
> +			   FIELD_PREP(AD7280A_CTRL_HB_CONV_AVG_MSK,
> +				      st->oversampling_ratio));
> +	if (ret)
> +		return ret;
> +
> +	ret = ad7280_write(st, devaddr, AD7280A_CTRL_HB_REG, 0,
> +			   FIELD_PREP(AD7280A_CTRL_HB_CONV_INPUT_MSK,
> +				      AD7280A_CTRL_HB_CONV_INPUT_ALL) |
> +			   FIELD_PREP(AD7280A_CTRL_HB_CONV_RREAD_MSK,
> +				      AD7280A_CTRL_HB_CONV_RREAD_ALL) |
> +			   FIELD_PREP(AD7280A_CTRL_HB_CONV_START_MSK,
> +				      AD7280A_CTRL_HB_CONV_START_CS) |
> +			   FIELD_PREP(AD7280A_CTRL_HB_CONV_AVG_MSK,
> +				      st->oversampling_ratio));
> +	if (ret)
> +		return ret;
> +
> +	ad7280_delay(st);
> +
> +	ret = __ad7280_read32(st, &tmp);
> +	if (ret)
> +		return ret;
> +
> +	if (ad7280_check_crc(st, tmp))
> +		return -EIO;
> +
> +	if ((FIELD_GET(AD7280A_TRANS_READ_DEVADDR_MSK, tmp) != devaddr) ||
> +	    (FIELD_GET(AD7280A_TRANS_READ_CONV_CHANADDR_MSK, tmp) != addr))
> +		return -EFAULT;
> +
> +	return FIELD_GET(AD7280A_TRANS_READ_CONV_DATA_MSK, tmp);
> +}
> +
> +static int ad7280_read_all_channels(struct ad7280_state *st, unsigned int cnt,
> +				    unsigned int *array)
> +{
> +	int i, ret;
> +	unsigned int tmp, sum = 0;
> +
> +	ret = ad7280_write(st, AD7280A_DEVADDR_MASTER, AD7280A_READ_REG, 1,
> +			   AD7280A_CELL_VOLTAGE_1_REG << 2);
> +	if (ret)
> +		return ret;
> +
> +	ret = ad7280_write(st, AD7280A_DEVADDR_MASTER, AD7280A_CTRL_HB_REG, 1,
> +			   FIELD_PREP(AD7280A_CTRL_HB_CONV_INPUT_MSK,
> +				      AD7280A_CTRL_HB_CONV_INPUT_ALL) |
> +			   FIELD_PREP(AD7280A_CTRL_HB_CONV_RREAD_MSK,
> +				      AD7280A_CTRL_HB_CONV_RREAD_ALL) |
> +			   FIELD_PREP(AD7280A_CTRL_HB_CONV_START_MSK,
> +				      AD7280A_CTRL_HB_CONV_START_CS) |
> +			   FIELD_PREP(AD7280A_CTRL_HB_CONV_AVG_MSK,
> +				      st->oversampling_ratio));
> +	if (ret)
> +		return ret;
> +
> +	ad7280_delay(st);
> +
> +	for (i = 0; i < cnt; i++) {
> +		ret = __ad7280_read32(st, &tmp);
> +		if (ret)
> +			return ret;
> +
> +		if (ad7280_check_crc(st, tmp))
> +			return -EIO;
> +
> +		if (array)
> +			array[i] = tmp;
> +		/* only sum cell voltages */
> +		if (FIELD_GET(AD7280A_TRANS_READ_CONV_CHANADDR_MSK, tmp) <=
> +		    AD7280A_CELL_VOLTAGE_6_REG)
> +			sum += FIELD_GET(AD7280A_TRANS_READ_CONV_DATA_MSK, tmp);
> +	}
> +
> +	return sum;
> +}
> +
> +static void ad7280_sw_power_down(void *data)
> +{
> +	struct ad7280_state *st = data;
> +
> +	ad7280_write(st, AD7280A_DEVADDR_MASTER, AD7280A_CTRL_HB_REG, 1,
> +		     AD7280A_CTRL_HB_PWRDN_SW |
> +		     FIELD_PREP(AD7280A_CTRL_HB_CONV_AVG_MSK, st->oversampling_ratio));
> +}
> +
> +static int ad7280_chain_setup(struct ad7280_state *st)
> +{
> +	unsigned int val, n;
> +	int ret;
> +
> +	ret = ad7280_write(st, AD7280A_DEVADDR_MASTER, AD7280A_CTRL_LB_REG, 1,
> +			   FIELD_PREP(AD7280A_CTRL_LB_DAISY_CHAIN_RB_MSK, 1) |
> +			   FIELD_PREP(AD7280A_CTRL_LB_LOCK_DEV_ADDR_MSK, 1) |
> +			   AD7280A_CTRL_LB_MUST_SET |
> +			   FIELD_PREP(AD7280A_CTRL_LB_SWRST_MSK, 1) |
> +			   st->ctrl_lb);
> +	if (ret)
> +		return ret;
> +
> +	ret = ad7280_write(st, AD7280A_DEVADDR_MASTER, AD7280A_CTRL_LB_REG, 1,
> +			   FIELD_PREP(AD7280A_CTRL_LB_DAISY_CHAIN_RB_MSK, 1) |
> +			   FIELD_PREP(AD7280A_CTRL_LB_LOCK_DEV_ADDR_MSK, 1) |
> +			   AD7280A_CTRL_LB_MUST_SET |
> +			   FIELD_PREP(AD7280A_CTRL_LB_SWRST_MSK, 0) |
> +			   st->ctrl_lb);
> +	if (ret)
> +		goto error_power_down;
> +
> +	ret = ad7280_write(st, AD7280A_DEVADDR_MASTER, AD7280A_READ_REG, 1,
> +			   FIELD_PREP(AD7280A_READ_ADDR_MSK, AD7280A_CTRL_LB_REG));
> +	if (ret)
> +		goto error_power_down;
> +
> +	for (n = 0; n <= AD7280A_MAX_CHAIN; n++) {
> +		ret = __ad7280_read32(st, &val);
> +		if (ret)
> +			goto error_power_down;
> +
> +		if (val == 0)
> +			return n - 1;
> +
> +		if (ad7280_check_crc(st, val)) {
> +			ret = -EIO;
> +			goto error_power_down;
> +		}
> +
> +		if (n != ad7280a_devaddr(FIELD_GET(AD7280A_TRANS_READ_DEVADDR_MSK, val))) {
> +			ret = -EIO;
> +			goto error_power_down;
> +		}
> +	}
> +	ret = -EFAULT;
> +
> +error_power_down:
> +	ad7280_write(st, AD7280A_DEVADDR_MASTER, AD7280A_CTRL_HB_REG, 1,
> +		     AD7280A_CTRL_HB_PWRDN_SW |
> +		     FIELD_PREP(AD7280A_CTRL_HB_CONV_AVG_MSK, st->oversampling_ratio));
> +
> +	return ret;
> +}
> +
> +static ssize_t ad7280_show_balance_sw(struct iio_dev *indio_dev,
> +				      uintptr_t private,
> +				      const struct iio_chan_spec *chan, char *buf)
> +{
> +	struct ad7280_state *st = iio_priv(indio_dev);
> +
> +	return sysfs_emit(buf, "%d\n",
> +			  !!(st->cb_mask[chan->address >> 8] &
> +			  (1 << ((chan->address & 0xFF) + 2))));
> +}
> +
> +static ssize_t ad7280_store_balance_sw(struct iio_dev *indio_dev,
> +				       uintptr_t private,
> +				       const struct iio_chan_spec *chan,
> +				       const char *buf, size_t len)
> +{
> +	struct ad7280_state *st = iio_priv(indio_dev);
> +	unsigned int devaddr, ch;
> +	bool readin;
> +	int ret;
> +
> +	ret = strtobool(buf, &readin);
> +	if (ret)
> +		return ret;
> +
> +	devaddr = chan->address >> 8;
> +	ch = chan->address & 0xFF;
> +
> +	mutex_lock(&st->lock);
> +	if (readin)
> +		st->cb_mask[devaddr] |= 1 << (ch + 2);
> +	else
> +		st->cb_mask[devaddr] &= ~(1 << (ch + 2));
> +
> +	ret = ad7280_write(st, devaddr, AD7280A_CELL_BALANCE_REG,
> +			   0, st->cb_mask[devaddr]);
> +	mutex_unlock(&st->lock);
> +
> +	return ret ? ret : len;
> +}
> +
> +static ssize_t ad7280_show_balance_timer(struct iio_dev *indio_dev,
> +					 uintptr_t private,
> +					 const struct iio_chan_spec *chan,
> +					 char *buf)
> +{
> +	struct ad7280_state *st = iio_priv(indio_dev);
> +	unsigned int msecs;
> +	int ret;
> +
> +	mutex_lock(&st->lock);
> +	ret = ad7280_read_reg(st, chan->address >> 8,
> +			      (chan->address & 0xFF) + AD7280A_CB1_TIMER_REG);
> +	mutex_unlock(&st->lock);
> +
> +	if (ret < 0)
> +		return ret;
> +
> +	msecs = FIELD_GET(AD7280A_CB_TIMER_VAL_MSK, ret) * 71500;
> +
> +	return sysfs_emit(buf, "%u.%u\n", msecs / 1000, msecs % 1000);
> +}
> +
> +static ssize_t ad7280_store_balance_timer(struct iio_dev *indio_dev,
> +					  uintptr_t private,
> +					  const struct iio_chan_spec *chan,
> +					  const char *buf, size_t len)
> +{
> +	struct ad7280_state *st = iio_priv(indio_dev);
> +	int val, val2;
> +	int ret;
> +
> +	ret = iio_str_to_fixpoint(buf, 1000, &val, &val2);
> +	if (ret)
> +		return ret;
> +
> +	val = val * 1000 + val2;
> +	val /= 71500;
> +
> +	if (val > 31)
> +		return -EINVAL;
> +
> +	mutex_lock(&st->lock);
> +	ret = ad7280_write(st, chan->address >> 8,
> +			   (chan->address & 0xFF) + AD7280A_CB1_TIMER_REG, 0,
> +			   FIELD_PREP(AD7280A_CB_TIMER_VAL_MSK, val));
> +	mutex_unlock(&st->lock);
> +
> +	return ret ? ret : len;
> +}
> +
> +static const struct iio_chan_spec_ext_info ad7280_cell_ext_info[] = {
> +	{
> +		.name = "balance_switch_en",
> +		.read = ad7280_show_balance_sw,
> +		.write = ad7280_store_balance_sw,
> +		.shared = IIO_SEPARATE,
> +	}, {
> +		.name = "balance_switch_timer",
> +		.read = ad7280_show_balance_timer,
> +		.write = ad7280_store_balance_timer,
> +		.shared = IIO_SEPARATE,
> +	},
> +	{}
> +};
> +
> +static const struct iio_event_spec ad7280_events[] = {
> +	{
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_RISING,
> +		.mask_shared_by_type = BIT(IIO_EV_INFO_VALUE),
> +	}, {
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_FALLING,
> +		.mask_shared_by_type = BIT(IIO_EV_INFO_VALUE),
> +	},
> +};
> +
> +static void ad7280_voltage_channel_init(struct iio_chan_spec *chan, int i,
> +					bool irq_present)
> +{
> +	chan->type = IIO_VOLTAGE;
> +	chan->differential = 1;
> +	chan->channel = i;
> +	chan->channel2 = chan->channel + 1;
> +	if (irq_present) {
> +		chan->event_spec = ad7280_events;
> +		chan->num_event_specs = ARRAY_SIZE(ad7280_events);
> +	}
> +	chan->ext_info = ad7280_cell_ext_info;
> +}
> +
> +static void ad7280_temp_channel_init(struct iio_chan_spec *chan, int i,
> +				     bool irq_present)
> +{
> +	chan->type = IIO_TEMP;
> +	chan->channel = i;
> +	if (irq_present) {
> +		chan->event_spec = ad7280_events;
> +		chan->num_event_specs = ARRAY_SIZE(ad7280_events);
> +	}
> +}
> +
> +static void ad7280_common_fields_init(struct iio_chan_spec *chan, int addr,
> +				      int cnt)
> +{
> +	chan->indexed = 1;
> +	chan->info_mask_separate = BIT(IIO_CHAN_INFO_RAW);
> +	chan->info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE);
> +	chan->info_mask_shared_by_all = BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO);
> +	chan->address = addr;
> +	chan->scan_index = cnt;
> +	chan->scan_type.sign = 'u';
> +	chan->scan_type.realbits = 12;
> +	chan->scan_type.storagebits = 32;
> +}
> +
> +static void ad7280_total_voltage_channel_init(struct iio_chan_spec *chan,
> +					      int cnt, int dev)
> +{
> +	chan->type = IIO_VOLTAGE;
> +	chan->differential = 1;
> +	chan->channel = 0;
> +	chan->channel2 = dev * AD7280A_CELLS_PER_DEV;
> +	chan->address = AD7280A_ALL_CELLS;
> +	chan->indexed = 1;
> +	chan->info_mask_separate = BIT(IIO_CHAN_INFO_RAW);
> +	chan->info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE);
> +	chan->scan_index = cnt;
> +	chan->scan_type.sign = 'u';
> +	chan->scan_type.realbits = 32;
> +	chan->scan_type.storagebits = 32;
> +}
> +
> +static void ad7280_init_dev_channels(struct ad7280_state *st, int dev, int *cnt,
> +				     bool irq_present)
> +{
> +	int addr, ch, i;
> +	struct iio_chan_spec *chan;
> +
> +	for (ch = AD7280A_CELL_VOLTAGE_1_REG; ch <= AD7280A_AUX_ADC_6_REG; ch++) {
> +		chan = &st->channels[*cnt];
> +
> +		if (ch < AD7280A_AUX_ADC_1_REG) {
> +			i = AD7280A_CALC_VOLTAGE_CHAN_NUM(dev, ch);
> +			ad7280_voltage_channel_init(chan, i, irq_present);
> +		} else {
> +			i = AD7280A_CALC_TEMP_CHAN_NUM(dev, ch);
> +			ad7280_temp_channel_init(chan, i, irq_present);
> +		}
> +
> +		addr = ad7280a_devaddr(dev) << 8 | ch;
> +		ad7280_common_fields_init(chan, addr, *cnt);
> +
> +		(*cnt)++;
> +	}
> +}
> +
> +static int ad7280_channel_init(struct ad7280_state *st, bool irq_present)
> +{
> +	int dev, cnt = 0;
> +
> +	st->channels = devm_kcalloc(&st->spi->dev, (st->slave_num + 1) * 12 + 1,
> +				    sizeof(*st->channels), GFP_KERNEL);
> +	if (!st->channels)
> +		return -ENOMEM;
> +
> +	for (dev = 0; dev <= st->slave_num; dev++)
> +		ad7280_init_dev_channels(st, dev, &cnt, irq_present);
> +
> +	ad7280_total_voltage_channel_init(&st->channels[cnt], cnt, dev);
> +
> +	return cnt + 1;
> +}
> +
> +static int ad7280a_read_thresh(struct iio_dev *indio_dev,
> +			       const struct iio_chan_spec *chan,
> +			       enum iio_event_type type,
> +			       enum iio_event_direction dir,
> +			       enum iio_event_info info, int *val, int *val2)
> +{
> +	struct ad7280_state *st = iio_priv(indio_dev);
> +
> +	switch (chan->type) {
> +	case IIO_VOLTAGE:
> +		switch (dir) {
> +		case IIO_EV_DIR_RISING:
> +			*val = 1000 + (st->cell_threshhigh * 1568L) / 100;
> +			return IIO_VAL_INT;
> +		case IIO_EV_DIR_FALLING:
> +			*val = 1000 + (st->cell_threshlow * 1568L) / 100;
> +			return IIO_VAL_INT;
> +		default:
> +			return -EINVAL;
> +		}
> +		break;
> +	case IIO_TEMP:
> +		switch (dir) {
> +		case IIO_EV_DIR_RISING:
> +			*val = ((st->aux_threshhigh) * 196L) / 10;
> +			return IIO_VAL_INT;
> +		case IIO_EV_DIR_FALLING:
> +			*val = (st->aux_threshlow * 196L) / 10;
> +			return IIO_VAL_INT;
> +		default:
> +			return -EINVAL;
> +		}
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ad7280a_write_thresh(struct iio_dev *indio_dev,
> +				const struct iio_chan_spec *chan,
> +				enum iio_event_type type,
> +				enum iio_event_direction dir,
> +				enum iio_event_info info,
> +				int val, int val2)
> +{
> +	struct ad7280_state *st = iio_priv(indio_dev);
> +	unsigned int addr;
> +	long value;
> +	int ret;
> +
> +	if (val2 != 0)
> +		return -EINVAL;
> +
> +	mutex_lock(&st->lock);
> +	switch (chan->type) {
> +	case IIO_VOLTAGE:
> +		value = ((val - 1000) * 100) / 1568; /* LSB 15.68mV */
> +		value = clamp(value, 0L, 0xFFL);
> +		switch (dir) {
> +		case IIO_EV_DIR_RISING:
> +			addr = AD7280A_CELL_OVERVOLTAGE_REG;
> +			st->cell_threshhigh = value;
> +			break;
> +		case IIO_EV_DIR_FALLING:
> +			addr = AD7280A_CELL_UNDERVOLTAGE_REG;
> +			st->cell_threshlow = value;
> +			break;
> +		default:
> +			ret = -EINVAL;
> +			goto err_unlock;
> +		}
> +		break;
> +	case IIO_TEMP:
> +		value = (val * 10) / 196; /* LSB 19.6mV */
> +		value = clamp(value, 0L, 0xFFL);
> +		switch (dir) {
> +		case IIO_EV_DIR_RISING:
> +			addr = AD7280A_AUX_ADC_OVERVOLTAGE_REG;
> +			st->aux_threshhigh = val;
> +			break;
> +		case IIO_EV_DIR_FALLING:
> +			addr = AD7280A_AUX_ADC_UNDERVOLTAGE_REG;
> +			st->aux_threshlow = val;
> +			break;
> +		default:
> +			ret = -EINVAL;
> +			goto err_unlock;
> +		}
> +		break;
> +	default:
> +		ret = -EINVAL;
> +		goto err_unlock;
> +	}
> +
> +	ret = ad7280_write(st, AD7280A_DEVADDR_MASTER, addr, 1, val);
> +err_unlock:
> +	mutex_unlock(&st->lock);
> +
> +	return ret;
> +}
> +
> +static irqreturn_t ad7280_event_handler(int irq, void *private)
> +{
> +	struct iio_dev *indio_dev = private;
> +	struct ad7280_state *st = iio_priv(indio_dev);
> +	unsigned int *channels;
> +	int i, ret;
> +
> +	channels = kcalloc(st->scan_cnt, sizeof(*channels), GFP_KERNEL);
> +	if (!channels)
> +		return IRQ_HANDLED;
> +
> +	ret = ad7280_read_all_channels(st, st->scan_cnt, channels);
> +	if (ret < 0)
> +		goto out;
> +
> +	for (i = 0; i < st->scan_cnt; i++) {
> +		unsigned int val;
> +
> +		val = FIELD_GET(AD7280A_TRANS_READ_CONV_DATA_MSK, channels[i]);
> +		if (FIELD_GET(AD7280A_TRANS_READ_CONV_CHANADDR_MSK, channels[i])
> +			<= AD7280A_CELL_VOLTAGE_6_REG) {
> +			if (val >= st->cell_threshhigh) {
> +				u64 tmp = IIO_EVENT_CODE(IIO_VOLTAGE, 1, 0,
> +							 IIO_EV_DIR_RISING,
> +							 IIO_EV_TYPE_THRESH,
> +							 0, 0, 0);
> +				iio_push_event(indio_dev, tmp,
> +					       iio_get_time_ns(indio_dev));
> +			} else if (val <= st->cell_threshlow) {
> +				u64 tmp = IIO_EVENT_CODE(IIO_VOLTAGE, 1, 0,
> +							 IIO_EV_DIR_FALLING,
> +							 IIO_EV_TYPE_THRESH,
> +							 0, 0, 0);
> +				iio_push_event(indio_dev, tmp,
> +					       iio_get_time_ns(indio_dev));
> +			}
> +		} else {
> +			if (val >= st->aux_threshhigh) {
> +				u64 tmp = IIO_UNMOD_EVENT_CODE(IIO_TEMP, 0,
> +							IIO_EV_TYPE_THRESH,
> +							IIO_EV_DIR_RISING);
> +				iio_push_event(indio_dev, tmp,
> +					       iio_get_time_ns(indio_dev));
> +			} else if (val <= st->aux_threshlow) {
> +				u64 tmp = IIO_UNMOD_EVENT_CODE(IIO_TEMP, 0,
> +							IIO_EV_TYPE_THRESH,
> +							IIO_EV_DIR_FALLING);
> +				iio_push_event(indio_dev, tmp,
> +					       iio_get_time_ns(indio_dev));
> +			}
> +		}
> +	}
> +
> +out:
> +	kfree(channels);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static void ad7280_update_delay(struct ad7280_state *st)
> +{
> +	/*
> +	 * Total Conversion Time = ((tACQ + tCONV) *
> +	 *			   (Number of Conversions per Part)) −
> +	 *			   tACQ + ((N - 1) * tDELAY)
> +	 *
> +	 * Readback Delay = Total Conversion Time + tWAIT
> +	 */
> +
> +	st->readback_delay_us =
> +		((ad7280a_t_acq_ns[st->acquisition_time & 0x3] + 695) *
> +			(AD7280A_NUM_CH * ad7280a_n_avg[st->oversampling_ratio & 0x3])) -
> +		ad7280a_t_acq_ns[st->acquisition_time & 0x3] + st->slave_num * 250;
> +
> +	/* Convert to usecs */
> +	st->readback_delay_us = DIV_ROUND_UP(st->readback_delay_us, 1000);
> +	st->readback_delay_us += 5; /* Add tWAIT */
> +}
> +
> +static int ad7280_read_raw(struct iio_dev *indio_dev,
> +			   struct iio_chan_spec const *chan,
> +			   int *val,
> +			   int *val2,
> +			   long m)
> +{
> +	struct ad7280_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (m) {
> +	case IIO_CHAN_INFO_RAW:
> +		mutex_lock(&st->lock);
> +		if (chan->address == AD7280A_ALL_CELLS)
> +			ret = ad7280_read_all_channels(st, st->scan_cnt, NULL);
> +		else
> +			ret = ad7280_read_channel(st, chan->address >> 8,
> +						  chan->address & 0xFF);
> +		mutex_unlock(&st->lock);
> +
> +		if (ret < 0)
> +			return ret;
> +
> +		*val = ret;
> +
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		if ((chan->address & 0xFF) <= AD7280A_CELL_VOLTAGE_6_REG)
> +			*val = 4000;
> +		else
> +			*val = 5000;
> +
> +		*val2 = AD7280A_BITS;
> +		return IIO_VAL_FRACTIONAL_LOG2;
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		*val = ad7280a_n_avg[st->oversampling_ratio];
> +		return IIO_VAL_INT;
> +	}
> +	return -EINVAL;
> +}
> +
> +static int ad7280_write_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int val, int val2, long mask)
> +{
> +	struct ad7280_state *st = iio_priv(indio_dev);
> +	int i;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		if (val2 != 0)
> +			return -EINVAL;
> +		for (i = 0; i < ARRAY_SIZE(ad7280a_n_avg); i++) {
> +			if (val == ad7280a_n_avg[i]) {
> +				st->oversampling_ratio = i;
> +				ad7280_update_delay(st);
> +				return 0;
> +			}
> +		}
> +		return -EINVAL;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static const struct iio_info ad7280_info = {
> +	.read_raw = ad7280_read_raw,
> +	.write_raw = ad7280_write_raw,
> +	.read_event_value = &ad7280a_read_thresh,
> +	.write_event_value = &ad7280a_write_thresh,
> +};
> +
> +static const struct iio_info ad7280_info_no_irq = {
> +	.read_event_value = &ad7280a_read_thresh,
> +	.write_event_value = &ad7280a_write_thresh,
> +};
> +
> +static int ad7280_probe(struct spi_device *spi)
> +{
> +	struct device *dev = &spi->dev;
> +	struct ad7280_state *st;
> +	int ret;
> +	struct iio_dev *indio_dev;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st = iio_priv(indio_dev);
> +	spi_set_drvdata(spi, indio_dev);
> +	st->spi = spi;
> +	mutex_init(&st->lock);
> +
> +	st->thermistor_term_en =
> +		device_property_read_bool(dev, "adi,thermistor-termination");
> +
> +	if (device_property_present(dev, "adi,acquistion-time-ns")) {
> +		u32 val;
> +
> +		ret = device_property_read_u32(dev, "adi,acquisition-time-ns", &val);
> +		if (ret)
> +			return ret;
> +
> +		switch (val) {
> +		case 400:
> +			st->acquisition_time = AD7280A_CTRL_LB_ACQ_TIME_400ns;
> +			break;
> +		case 800:
> +			st->acquisition_time = AD7280A_CTRL_LB_ACQ_TIME_800ns;
> +			break;
> +		case 1200:
> +			st->acquisition_time = AD7280A_CTRL_LB_ACQ_TIME_1200ns;
> +			break;
> +		case 1600:
> +			st->acquisition_time = AD7280A_CTRL_LB_ACQ_TIME_1600ns;
> +			break;
> +		default:
> +			dev_err(dev, "Firmware provided acquisition time is invalid\n");
> +			return -EINVAL;
> +		}
> +	} else {
> +		st->acquisition_time = AD7280A_CTRL_LB_ACQ_TIME_400ns;
> +	}
> +
> +	/* Alert masks are intended for when particular inputs are not wired up */
> +	if (device_property_present(dev, "adi,voltage-alert-last-chan")) {
> +		u8 val;
> +
> +		ret = device_property_read_u8(dev, "adi,voltage-alert-last-chan", &val);
> +		if (ret)
> +			return ret;
> +
> +		switch (val) {
> +		case 3:
> +			st->chain_last_alert_ignore |= AD7280A_ALERT_REMOVE_VIN4_VIN5;
> +			break;
> +		case 4:
> +			st->chain_last_alert_ignore |= AD7280A_ALERT_REMOVE_VIN5;
> +			break;
> +		case 5:
> +			break;
> +		default:
> +			dev_err(dev,
> +				"Firmware provided last voltage alert channel invalid\n");
> +			break;
> +		}
> +	}
> +	if (device_property_present(dev, "adi,temp-alert-last-chan")) {
> +		u8 val;
> +
> +		ret = device_property_read_u8(dev, "adi,temp-alert-last-chan", &val);
> +		if (ret)
> +			return ret;
> +
> +		switch (val) {
> +		case 3:
> +			st->chain_last_alert_ignore |= AD7280A_ALERT_REMOVE_AUX4_AUX5;
> +			break;
> +		case 4:
> +			st->chain_last_alert_ignore |= AD7280A_ALERT_REMOVE_AUX5;
> +			break;
> +		case 5:
> +			break;
> +		default:
> +			dev_err(dev,
> +				"Firmware provided last temp alert channel invalid\n");
> +			break;
> +		}
> +	}
> +	crc8_populate_msb(st->crc_tab, POLYNOM);
> +
> +	st->spi->max_speed_hz = AD7280A_MAX_SPI_CLK_HZ;
> +	st->spi->mode = SPI_MODE_1;
> +	spi_setup(st->spi);
> +
> +	st->ctrl_lb = FIELD_PREP(AD7280A_CTRL_LB_ACQ_TIME_MSK, st->acquisition_time) |
> +		FIELD_PREP(AD7280A_CTRL_LB_THERMISTOR_MSK, st->thermistor_term_en);
> +	st->oversampling_ratio = 0; /* No oversampling */
> +
> +	ret = ad7280_chain_setup(st);
> +	if (ret < 0)
> +		return ret;
> +
> +	st->slave_num = ret;
> +	st->scan_cnt = (st->slave_num + 1) * AD7280A_NUM_CH;
> +	st->cell_threshhigh = 0xFF;
> +	st->aux_threshhigh = 0xFF;
> +
> +	ret = devm_add_action_or_reset(dev, ad7280_sw_power_down, st);
> +	if (ret)
> +		return ret;
> +
> +	ad7280_update_delay(st);
> +
> +	indio_dev->name = spi_get_device_id(spi)->name;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	ret = ad7280_channel_init(st, spi->irq > 0);
> +	if (ret < 0)
> +		return ret;
> +
> +	indio_dev->num_channels = ret;
> +	indio_dev->channels = st->channels;
> +	if (spi->irq > 0) {
> +		ret = ad7280_write(st, AD7280A_DEVADDR_MASTER,
> +				   AD7280A_ALERT_REG, 1,
> +				   AD7280A_ALERT_RELAY_SIG_CHAIN_DOWN);
> +		if (ret)
> +			return ret;
> +
> +		ret = ad7280_write(st, ad7280a_devaddr(st->slave_num),
> +				   AD7280A_ALERT_REG, 0,
> +				   AD7280A_ALERT_GEN_STATIC_HIGH |
> +				   FIELD_PREP(AD7280A_ALERT_REMOVE_MSK,
> +					      st->chain_last_alert_ignore));
> +		if (ret)
> +			return ret;
> +
> +		ret = devm_request_threaded_irq(dev, spi->irq,
> +						NULL,
> +						ad7280_event_handler,
> +						IRQF_TRIGGER_FALLING |
> +						IRQF_ONESHOT,
> +						indio_dev->name,
> +						indio_dev);
> +		if (ret)
> +			return ret;
> +
> +		indio_dev->info = &ad7280_info;
> +	} else {
> +		indio_dev->info = &ad7280_info_no_irq;
> +	}
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}
> +
> +static const struct spi_device_id ad7280_id[] = {
> +	{"ad7280a", 0},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(spi, ad7280_id);
> +
> +static struct spi_driver ad7280_driver = {
> +	.driver = {
> +		.name	= "ad7280",
> +	},
> +	.probe		= ad7280_probe,
> +	.id_table	= ad7280_id,
> +};
> +module_spi_driver(ad7280_driver);
> +
> +MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
> +MODULE_DESCRIPTION("Analog Devices AD7280A");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/staging/iio/adc/Kconfig b/drivers/staging/iio/adc/Kconfig
> index b25f41053fac..2f0d6cf048d2 100644
> --- a/drivers/staging/iio/adc/Kconfig
> +++ b/drivers/staging/iio/adc/Kconfig
> @@ -15,15 +15,4 @@ config AD7816
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called ad7816.
>  
> -config AD7280
> -	tristate "Analog Devices AD7280A Lithium Ion Battery Monitoring System"
> -	depends on SPI
> -	select CRC8
> -	help
> -	  Say yes here to build support for Analog Devices AD7280A
> -	  Lithium Ion Battery Monitoring System.
> -
> -	  To compile this driver as a module, choose M here: the
> -	  module will be called ad7280a
> -
>  endmenu
> diff --git a/drivers/staging/iio/adc/Makefile b/drivers/staging/iio/adc/Makefile
> index 6436a62b6278..1e2a94c4db84 100644
> --- a/drivers/staging/iio/adc/Makefile
> +++ b/drivers/staging/iio/adc/Makefile
> @@ -4,4 +4,3 @@
>  #
>  
>  obj-$(CONFIG_AD7816) += ad7816.o
> -obj-$(CONFIG_AD7280) += ad7280a.o
> diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
> deleted file mode 100644
> index 0806238debe3..000000000000
> --- a/drivers/staging/iio/adc/ad7280a.c
> +++ /dev/null
> @@ -1,1116 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * AD7280A Lithium Ion Battery Monitoring System
> - *
> - * Copyright 2011 Analog Devices Inc.
> - */
> -
> -#include <linux/bitfield.h>
> -#include <linux/bits.h>
> -#include <linux/crc8.h>
> -#include <linux/delay.h>
> -#include <linux/device.h>
> -#include <linux/err.h>
> -#include <linux/interrupt.h>
> -#include <linux/kernel.h>
> -#include <linux/module.h>
> -#include <linux/mod_devicetable.h>
> -#include <linux/mutex.h>
> -#include <linux/slab.h>
> -#include <linux/sysfs.h>
> -#include <linux/spi/spi.h>
> -
> -#include <linux/iio/events.h>
> -#include <linux/iio/iio.h>
> -
> -/* Registers */
> -
> -#define AD7280A_CELL_VOLTAGE_1_REG		0x0  /* D11 to D0, Read only */
> -#define AD7280A_CELL_VOLTAGE_2_REG		0x1  /* D11 to D0, Read only */
> -#define AD7280A_CELL_VOLTAGE_3_REG		0x2  /* D11 to D0, Read only */
> -#define AD7280A_CELL_VOLTAGE_4_REG		0x3  /* D11 to D0, Read only */
> -#define AD7280A_CELL_VOLTAGE_5_REG		0x4  /* D11 to D0, Read only */
> -#define AD7280A_CELL_VOLTAGE_6_REG		0x5  /* D11 to D0, Read only */
> -#define AD7280A_AUX_ADC_1_REG			0x6  /* D11 to D0, Read only */
> -#define AD7280A_AUX_ADC_2_REG			0x7  /* D11 to D0, Read only */
> -#define AD7280A_AUX_ADC_3_REG			0x8  /* D11 to D0, Read only */
> -#define AD7280A_AUX_ADC_4_REG			0x9  /* D11 to D0, Read only */
> -#define AD7280A_AUX_ADC_5_REG			0xA  /* D11 to D0, Read only */
> -#define AD7280A_AUX_ADC_6_REG			0xB  /* D11 to D0, Read only */
> -#define AD7280A_SELF_TEST_REG			0xC  /* D11 to D0, Read only */
> -
> -#define AD7280A_CTRL_HB_REG			0xD  /* D15 to D8, Read/write */
> -#define   AD7280A_CTRL_HB_CONV_INPUT_MSK		GENMASK(7, 6)
> -#define     AD7280A_CTRL_HB_CONV_INPUT_ALL			0
> -#define     AD7280A_CTRL_HB_CONV_INPUT_6CELL_AUX1_3_4		1
> -#define     AD7280A_CTRL_HB_CONV_INPUT_6CELL			2
> -#define     AD7280A_CTRL_HB_CONV_INPUT_SELF_TEST		3
> -#define   AD7280A_CTRL_HB_CONV_RREAD_MSK		GENMASK(5, 4)
> -#define     AD7280A_CTRL_HB_CONV_RREAD_ALL			0
> -#define     AD7280A_CTRL_HB_CONV_RREAD_6CELL_AUX1_3_4		1
> -#define     AD7280A_CTRL_HB_CONV_RREAD_6CELL			2
> -#define     AD7280A_CTRL_HB_CONV_RREAD_NO		        3
> -#define   AD7280A_CTRL_HB_CONV_START_MSK		BIT(3)
> -#define     AD7280A_CTRL_HB_CONV_START_CNVST			0
> -#define     AD7280A_CTRL_HB_CONV_START_CS			1
> -#define   AD7280A_CTRL_HB_CONV_AVG_MSK			GENMASK(2, 1)
> -#define     AD7280A_CTRL_HB_CONV_AVG_DIS			0
> -#define     AD7280A_CTRL_HB_CONV_AVG_2				1
> -#define     AD7280A_CTRL_HB_CONV_AVG_4			        2
> -#define     AD7280A_CTRL_HB_CONV_AVG_8			        3
> -#define   AD7280A_CTRL_HB_PWRDN_SW			BIT(0)
> -
> -#define AD7280A_CTRL_LB_REG			0xE  /* D7 to D0, Read/write */
> -#define   AD7280A_CTRL_LB_SWRST_MSK			BIT(7)
> -#define   AD7280A_CTRL_LB_ACQ_TIME_MSK			GENMASK(6, 5)
> -#define     AD7280A_CTRL_LB_ACQ_TIME_400ns			0
> -#define     AD7280A_CTRL_LB_ACQ_TIME_800ns			1
> -#define     AD7280A_CTRL_LB_ACQ_TIME_1200ns			2
> -#define     AD7280A_CTRL_LB_ACQ_TIME_1600ns			3
> -#define   AD7280A_CTRL_LB_MUST_SET			BIT(4)
> -#define   AD7280A_CTRL_LB_THERMISTOR_MSK		BIT(3)
> -#define   AD7280A_CTRL_LB_LOCK_DEV_ADDR_MSK		BIT(2)
> -#define   AD7280A_CTRL_LB_INC_DEV_ADDR_MSK		BIT(1)
> -#define   AD7280A_CTRL_LB_DAISY_CHAIN_RB_MSK		BIT(0)
> -
> -#define AD7280A_CELL_OVERVOLTAGE_REG		0xF  /* D7 to D0, Read/write */
> -#define AD7280A_CELL_UNDERVOLTAGE_REG		0x10 /* D7 to D0, Read/write */
> -#define AD7280A_AUX_ADC_OVERVOLTAGE_REG		0x11 /* D7 to D0, Read/write */
> -#define AD7280A_AUX_ADC_UNDERVOLTAGE_REG	0x12 /* D7 to D0, Read/write */
> -
> -#define AD7280A_ALERT_REG			0x13 /* D7 to D0, Read/write */
> -#define   AD7280A_ALERT_REMOVE_MSK			GENMASK(3, 0)
> -#define     AD7280A_ALERT_REMOVE_AUX5			BIT(0)
> -#define     AD7280A_ALERT_REMOVE_AUX4_AUX5		BIT(1)
> -#define     AD7280A_ALERT_REMOVE_VIN5			BIT(2)
> -#define     AD7280A_ALERT_REMOVE_VIN4_VIN5		BIT(3)
> -#define   AD7280A_ALERT_GEN_STATIC_HIGH			BIT(6)
> -#define   AD7280A_ALERT_RELAY_SIG_CHAIN_DOWN		(BIT(7) | BIT(6))
> -
> -#define AD7280A_CELL_BALANCE_REG		0x14 /* D7 to D0, Read/write */
> -#define AD7280A_CB1_TIMER_REG			0x15 /* D7 to D0, Read/write */
> -#define  AD7280A_CB_TIMER_VAL_MSK			GENMASK(7, 3)
> -#define AD7280A_CB2_TIMER_REG			0x16 /* D7 to D0, Read/write */
> -#define AD7280A_CB3_TIMER_REG			0x17 /* D7 to D0, Read/write */
> -#define AD7280A_CB4_TIMER_REG			0x18 /* D7 to D0, Read/write */
> -#define AD7280A_CB5_TIMER_REG			0x19 /* D7 to D0, Read/write */
> -#define AD7280A_CB6_TIMER_REG			0x1A /* D7 to D0, Read/write */
> -#define AD7280A_PD_TIMER_REG			0x1B /* D7 to D0, Read/write */
> -#define AD7280A_READ_REG			0x1C /* D7 to D0, Read/write */
> -#define   AD7280A_READ_ADDR_MSK				GENMASK(7, 2)
> -#define AD7280A_CNVST_CTRL_REG			0x1D /* D7 to D0, Read/write */
> -
> -/* Transfer fields */
> -#define AD7280A_TRANS_WRITE_DEVADDR_MSK		GENMASK(31, 27)
> -#define AD7280A_TRANS_WRITE_ADDR_MSK		GENMASK(26, 21)
> -#define AD7280A_TRANS_WRITE_VAL_MSK		GENMASK(20, 13)
> -#define AD7280A_TRANS_WRITE_ALL_MSK		BIT(12)
> -#define AD7280A_TRANS_WRITE_CRC_MSK		GENMASK(10, 3)
> -#define AD7280A_TRANS_WRITE_RES_PATTERN		0x2
> -
> -/* Layouts differ for channel vs other registers */
> -#define AD7280A_TRANS_READ_DEVADDR_MSK		GENMASK(31, 27)
> -#define AD7280A_TRANS_READ_CONV_CHANADDR_MSK	GENMASK(26, 23)
> -#define AD7280A_TRANS_READ_CONV_DATA_MSK	GENMASK(22, 11)
> -#define AD7280A_TRANS_READ_REG_REGADDR_MSK	GENMASK(26, 21)
> -#define AD7280A_TRANS_READ_REG_DATA_MSK		GENMASK(20, 13)
> -#define AD7280A_TRANS_READ_WRITE_ACK_MSK	BIT(10)
> -#define AD7280A_TRANS_READ_CRC_MSK		GENMASK(9, 2)
> -
> -/* Magic value used to indicate this special case */
> -#define AD7280A_ALL_CELLS				(0xAD << 16)
> -
> -#define AD7280A_MAX_SPI_CLK_HZ		700000 /* < 1MHz */
> -#define AD7280A_MAX_CHAIN		8
> -#define AD7280A_CELLS_PER_DEV		6
> -#define AD7280A_BITS			12
> -#define AD7280A_NUM_CH			(AD7280A_AUX_ADC_6_REG - \
> -					AD7280A_CELL_VOLTAGE_1_REG + 1)
> -
> -#define AD7280A_CALC_VOLTAGE_CHAN_NUM(d, c) (((d) * AD7280A_CELLS_PER_DEV) + \
> -					     (c))
> -#define AD7280A_CALC_TEMP_CHAN_NUM(d, c)    (((d) * AD7280A_CELLS_PER_DEV) + \
> -					     (c) - AD7280A_CELLS_PER_DEV)
> -
> -#define AD7280A_DEVADDR_MASTER		0
> -#define AD7280A_DEVADDR_ALL		0x1F
> -
> -static const unsigned short ad7280a_n_avg[4] = {1, 2, 4, 8};
> -static const unsigned short ad7280a_t_acq_ns[4] = {465, 1010, 1460, 1890};
> -
> -/* 5-bit device address is sent LSB first */
> -static unsigned int ad7280a_devaddr(unsigned int addr)
> -{
> -	return ((addr & 0x1) << 4) |
> -	       ((addr & 0x2) << 2) |
> -	       (addr & 0x4) |
> -	       ((addr & 0x8) >> 2) |
> -	       ((addr & 0x10) >> 4);
> -}
> -
> -/*
> - * During a read a valid write is mandatory.
> - * So writing to the highest available address (Address 0x1F) and setting the
> - * address all parts bit to 0 is recommended.
> - * So the TXVAL is AD7280A_DEVADDR_ALL + CRC
> - */
> -#define AD7280A_READ_TXVAL	0xF800030A
> -
> -/*
> - * AD7280 CRC
> - *
> - * P(x) = x^8 + x^5 + x^3 + x^2 + x^1 + x^0 = 0b100101111 => 0x2F
> - */
> -#define POLYNOM		0x2F
> -
> -struct ad7280_state {
> -	struct spi_device		*spi;
> -	struct iio_chan_spec		*channels;
> -	unsigned int			chain_last_alert_ignore;
> -	bool				thermistor_term_en;
> -	int				slave_num;
> -	int				scan_cnt;
> -	int				readback_delay_us;
> -	unsigned char			crc_tab[CRC8_TABLE_SIZE];
> -	u8				oversampling_ratio;
> -	u8				acquisition_time;
> -	unsigned char			ctrl_lb;
> -	unsigned char			cell_threshhigh;
> -	unsigned char			cell_threshlow;
> -	unsigned char			aux_threshhigh;
> -	unsigned char			aux_threshlow;
> -	unsigned char			cb_mask[AD7280A_MAX_CHAIN];
> -	struct mutex			lock; /* protect sensor state */
> -
> -	__be32				tx ____cacheline_aligned;
> -	__be32				rx;
> -};
> -
> -static unsigned char ad7280_calc_crc8(unsigned char *crc_tab, unsigned int val)
> -{
> -	unsigned char crc;
> -
> -	crc = crc_tab[val >> 16 & 0xFF];
> -	crc = crc_tab[crc ^ (val >> 8 & 0xFF)];
> -
> -	return crc ^ (val & 0xFF);
> -}
> -
> -static int ad7280_check_crc(struct ad7280_state *st, unsigned int val)
> -{
> -	unsigned char crc = ad7280_calc_crc8(st->crc_tab, val >> 10);
> -
> -	if (crc != ((val >> 2) & 0xFF))
> -		return -EIO;
> -
> -	return 0;
> -}
> -
> -/*
> - * After initiating a conversion sequence we need to wait until the conversion
> - * is done. The delay is typically in the range of 15..30us however depending on
> - * the number of devices in the daisy chain, the number of averages taken,
> - * conversion delays and acquisition time options it may take up to 250us, in
> - * this case we better sleep instead of busy wait.
> - */
> -
> -static void ad7280_delay(struct ad7280_state *st)
> -{
> -	if (st->readback_delay_us < 50)
> -		udelay(st->readback_delay_us);
> -	else
> -		usleep_range(250, 500);
> -}
> -
> -static int __ad7280_read32(struct ad7280_state *st, unsigned int *val)
> -{
> -	int ret;
> -	struct spi_transfer t = {
> -		.tx_buf	= &st->tx,
> -		.rx_buf = &st->rx,
> -		.len = sizeof(st->tx),
> -	};
> -
> -	st->tx = cpu_to_be32(AD7280A_READ_TXVAL);
> -
> -	ret = spi_sync_transfer(st->spi, &t, 1);
> -	if (ret)
> -		return ret;
> -
> -	*val = be32_to_cpu(st->rx);
> -
> -	return 0;
> -}
> -
> -static int ad7280_write(struct ad7280_state *st, unsigned int devaddr,
> -			unsigned int addr, bool all, unsigned int val)
> -{
> -	unsigned int reg = FIELD_PREP(AD7280A_TRANS_WRITE_DEVADDR_MSK, devaddr) |
> -		FIELD_PREP(AD7280A_TRANS_WRITE_ADDR_MSK, addr) |
> -		FIELD_PREP(AD7280A_TRANS_WRITE_VAL_MSK, val) |
> -		FIELD_PREP(AD7280A_TRANS_WRITE_ALL_MSK, all);
> -
> -	reg |= FIELD_PREP(AD7280A_TRANS_WRITE_CRC_MSK,
> -			ad7280_calc_crc8(st->crc_tab, reg >> 11));
> -	/* Reserved b010 pattern not included crc calc */
> -	reg |= AD7280A_TRANS_WRITE_RES_PATTERN;
> -
> -	st->tx = cpu_to_be32(reg);
> -
> -	return spi_write(st->spi, &st->tx, sizeof(st->tx));
> -}
> -
> -static int ad7280_read_reg(struct ad7280_state *st, unsigned int devaddr,
> -			   unsigned int addr)
> -{
> -	int ret;
> -	unsigned int tmp;
> -
> -	/* turns off the read operation on all parts */
> -	ret = ad7280_write(st, AD7280A_DEVADDR_MASTER, AD7280A_CTRL_HB_REG, 1,
> -			   FIELD_PREP(AD7280A_CTRL_HB_CONV_INPUT_MSK,
> -				      AD7280A_CTRL_HB_CONV_INPUT_ALL) |
> -			   FIELD_PREP(AD7280A_CTRL_HB_CONV_RREAD_MSK,
> -				      AD7280A_CTRL_HB_CONV_RREAD_NO) |
> -			   FIELD_PREP(AD7280A_CTRL_HB_CONV_AVG_MSK,
> -				      st->oversampling_ratio));
> -	if (ret)
> -		return ret;
> -
> -	/* turns on the read operation on the addressed part */
> -	ret = ad7280_write(st, devaddr, AD7280A_CTRL_HB_REG, 0,
> -			   FIELD_PREP(AD7280A_CTRL_HB_CONV_INPUT_MSK,
> -				      AD7280A_CTRL_HB_CONV_INPUT_ALL) |
> -			   FIELD_PREP(AD7280A_CTRL_HB_CONV_RREAD_MSK,
> -				      AD7280A_CTRL_HB_CONV_RREAD_ALL) |
> -			   FIELD_PREP(AD7280A_CTRL_HB_CONV_AVG_MSK,
> -				      st->oversampling_ratio));
> -	if (ret)
> -		return ret;
> -
> -	/* Set register address on the part to be read from */
> -	ret = ad7280_write(st, devaddr, AD7280A_READ_REG, 0,
> -			   FIELD_PREP(AD7280A_READ_ADDR_MSK, addr));
> -	if (ret)
> -		return ret;
> -
> -	ret = __ad7280_read32(st, &tmp);
> -	if (ret)
> -		return ret;
> -
> -	if (ad7280_check_crc(st, tmp))
> -		return -EIO;
> -
> -	if ((FIELD_GET(AD7280A_TRANS_READ_DEVADDR_MSK, tmp) != devaddr) ||
> -	    (FIELD_GET(AD7280A_TRANS_READ_REG_REGADDR_MSK, tmp) != addr))
> -		return -EFAULT;
> -
> -	return FIELD_GET(AD7280A_TRANS_READ_REG_DATA_MSK, tmp);
> -}
> -
> -static int ad7280_read_channel(struct ad7280_state *st, unsigned int devaddr,
> -			       unsigned int addr)
> -{
> -	int ret;
> -	unsigned int tmp;
> -
> -	ret = ad7280_write(st, devaddr, AD7280A_READ_REG, 0,
> -			   FIELD_PREP(AD7280A_READ_ADDR_MSK, addr));
> -	if (ret)
> -		return ret;
> -
> -	ret = ad7280_write(st, AD7280A_DEVADDR_MASTER, AD7280A_CTRL_HB_REG, 1,
> -			   FIELD_PREP(AD7280A_CTRL_HB_CONV_INPUT_MSK,
> -				      AD7280A_CTRL_HB_CONV_INPUT_ALL) |
> -			   FIELD_PREP(AD7280A_CTRL_HB_CONV_RREAD_MSK,
> -				      AD7280A_CTRL_HB_CONV_RREAD_NO) |
> -			   FIELD_PREP(AD7280A_CTRL_HB_CONV_AVG_MSK,
> -				      st->oversampling_ratio));
> -	if (ret)
> -		return ret;
> -
> -	ret = ad7280_write(st, devaddr, AD7280A_CTRL_HB_REG, 0,
> -			   FIELD_PREP(AD7280A_CTRL_HB_CONV_INPUT_MSK,
> -				      AD7280A_CTRL_HB_CONV_INPUT_ALL) |
> -			   FIELD_PREP(AD7280A_CTRL_HB_CONV_RREAD_MSK,
> -				      AD7280A_CTRL_HB_CONV_RREAD_ALL) |
> -			   FIELD_PREP(AD7280A_CTRL_HB_CONV_START_MSK,
> -				      AD7280A_CTRL_HB_CONV_START_CS) |
> -			   FIELD_PREP(AD7280A_CTRL_HB_CONV_AVG_MSK,
> -				      st->oversampling_ratio));
> -	if (ret)
> -		return ret;
> -
> -	ad7280_delay(st);
> -
> -	ret = __ad7280_read32(st, &tmp);
> -	if (ret)
> -		return ret;
> -
> -	if (ad7280_check_crc(st, tmp))
> -		return -EIO;
> -
> -	if ((FIELD_GET(AD7280A_TRANS_READ_DEVADDR_MSK, tmp) != devaddr) ||
> -	    (FIELD_GET(AD7280A_TRANS_READ_CONV_CHANADDR_MSK, tmp) != addr))
> -		return -EFAULT;
> -
> -	return FIELD_GET(AD7280A_TRANS_READ_CONV_DATA_MSK, tmp);
> -}
> -
> -static int ad7280_read_all_channels(struct ad7280_state *st, unsigned int cnt,
> -				    unsigned int *array)
> -{
> -	int i, ret;
> -	unsigned int tmp, sum = 0;
> -
> -	ret = ad7280_write(st, AD7280A_DEVADDR_MASTER, AD7280A_READ_REG, 1,
> -			   AD7280A_CELL_VOLTAGE_1_REG << 2);
> -	if (ret)
> -		return ret;
> -
> -	ret = ad7280_write(st, AD7280A_DEVADDR_MASTER, AD7280A_CTRL_HB_REG, 1,
> -			   FIELD_PREP(AD7280A_CTRL_HB_CONV_INPUT_MSK,
> -				      AD7280A_CTRL_HB_CONV_INPUT_ALL) |
> -			   FIELD_PREP(AD7280A_CTRL_HB_CONV_RREAD_MSK,
> -				      AD7280A_CTRL_HB_CONV_RREAD_ALL) |
> -			   FIELD_PREP(AD7280A_CTRL_HB_CONV_START_MSK,
> -				      AD7280A_CTRL_HB_CONV_START_CS) |
> -			   FIELD_PREP(AD7280A_CTRL_HB_CONV_AVG_MSK,
> -				      st->oversampling_ratio));
> -	if (ret)
> -		return ret;
> -
> -	ad7280_delay(st);
> -
> -	for (i = 0; i < cnt; i++) {
> -		ret = __ad7280_read32(st, &tmp);
> -		if (ret)
> -			return ret;
> -
> -		if (ad7280_check_crc(st, tmp))
> -			return -EIO;
> -
> -		if (array)
> -			array[i] = tmp;
> -		/* only sum cell voltages */
> -		if (FIELD_GET(AD7280A_TRANS_READ_CONV_CHANADDR_MSK, tmp) <=
> -		    AD7280A_CELL_VOLTAGE_6_REG)
> -			sum += FIELD_GET(AD7280A_TRANS_READ_CONV_DATA_MSK, tmp);
> -	}
> -
> -	return sum;
> -}
> -
> -static void ad7280_sw_power_down(void *data)
> -{
> -	struct ad7280_state *st = data;
> -
> -	ad7280_write(st, AD7280A_DEVADDR_MASTER, AD7280A_CTRL_HB_REG, 1,
> -		     AD7280A_CTRL_HB_PWRDN_SW |
> -		     FIELD_PREP(AD7280A_CTRL_HB_CONV_AVG_MSK, st->oversampling_ratio));
> -}
> -
> -static int ad7280_chain_setup(struct ad7280_state *st)
> -{
> -	unsigned int val, n;
> -	int ret;
> -
> -	ret = ad7280_write(st, AD7280A_DEVADDR_MASTER, AD7280A_CTRL_LB_REG, 1,
> -			   FIELD_PREP(AD7280A_CTRL_LB_DAISY_CHAIN_RB_MSK, 1) |
> -			   FIELD_PREP(AD7280A_CTRL_LB_LOCK_DEV_ADDR_MSK, 1) |
> -			   AD7280A_CTRL_LB_MUST_SET |
> -			   FIELD_PREP(AD7280A_CTRL_LB_SWRST_MSK, 1) |
> -			   st->ctrl_lb);
> -	if (ret)
> -		return ret;
> -
> -	ret = ad7280_write(st, AD7280A_DEVADDR_MASTER, AD7280A_CTRL_LB_REG, 1,
> -			   FIELD_PREP(AD7280A_CTRL_LB_DAISY_CHAIN_RB_MSK, 1) |
> -			   FIELD_PREP(AD7280A_CTRL_LB_LOCK_DEV_ADDR_MSK, 1) |
> -			   AD7280A_CTRL_LB_MUST_SET |
> -			   FIELD_PREP(AD7280A_CTRL_LB_SWRST_MSK, 0) |
> -			   st->ctrl_lb);
> -	if (ret)
> -		goto error_power_down;
> -
> -	ret = ad7280_write(st, AD7280A_DEVADDR_MASTER, AD7280A_READ_REG, 1,
> -			   FIELD_PREP(AD7280A_READ_ADDR_MSK, AD7280A_CTRL_LB_REG));
> -	if (ret)
> -		goto error_power_down;
> -
> -	for (n = 0; n <= AD7280A_MAX_CHAIN; n++) {
> -		ret = __ad7280_read32(st, &val);
> -		if (ret)
> -			goto error_power_down;
> -
> -		if (val == 0)
> -			return n - 1;
> -
> -		if (ad7280_check_crc(st, val)) {
> -			ret = -EIO;
> -			goto error_power_down;
> -		}
> -
> -		if (n != ad7280a_devaddr(FIELD_GET(AD7280A_TRANS_READ_DEVADDR_MSK, val))) {
> -			ret = -EIO;
> -			goto error_power_down;
> -		}
> -	}
> -	ret = -EFAULT;
> -
> -error_power_down:
> -	ad7280_write(st, AD7280A_DEVADDR_MASTER, AD7280A_CTRL_HB_REG, 1,
> -		     AD7280A_CTRL_HB_PWRDN_SW |
> -		     FIELD_PREP(AD7280A_CTRL_HB_CONV_AVG_MSK, st->oversampling_ratio));
> -
> -	return ret;
> -}
> -
> -static ssize_t ad7280_show_balance_sw(struct iio_dev *indio_dev,
> -				      uintptr_t private,
> -				      const struct iio_chan_spec *chan, char *buf)
> -{
> -	struct ad7280_state *st = iio_priv(indio_dev);
> -
> -	return sysfs_emit(buf, "%d\n",
> -			  !!(st->cb_mask[chan->address >> 8] &
> -			  (1 << ((chan->address & 0xFF) + 2))));
> -}
> -
> -static ssize_t ad7280_store_balance_sw(struct iio_dev *indio_dev,
> -				       uintptr_t private,
> -				       const struct iio_chan_spec *chan,
> -				       const char *buf, size_t len)
> -{
> -	struct ad7280_state *st = iio_priv(indio_dev);
> -	unsigned int devaddr, ch;
> -	bool readin;
> -	int ret;
> -
> -	ret = strtobool(buf, &readin);
> -	if (ret)
> -		return ret;
> -
> -	devaddr = chan->address >> 8;
> -	ch = chan->address & 0xFF;
> -
> -	mutex_lock(&st->lock);
> -	if (readin)
> -		st->cb_mask[devaddr] |= 1 << (ch + 2);
> -	else
> -		st->cb_mask[devaddr] &= ~(1 << (ch + 2));
> -
> -	ret = ad7280_write(st, devaddr, AD7280A_CELL_BALANCE_REG,
> -			   0, st->cb_mask[devaddr]);
> -	mutex_unlock(&st->lock);
> -
> -	return ret ? ret : len;
> -}
> -
> -static ssize_t ad7280_show_balance_timer(struct iio_dev *indio_dev,
> -					 uintptr_t private,
> -					 const struct iio_chan_spec *chan,
> -					 char *buf)
> -{
> -	struct ad7280_state *st = iio_priv(indio_dev);
> -	unsigned int msecs;
> -	int ret;
> -
> -	mutex_lock(&st->lock);
> -	ret = ad7280_read_reg(st, chan->address >> 8,
> -			      (chan->address & 0xFF) + AD7280A_CB1_TIMER_REG);
> -	mutex_unlock(&st->lock);
> -
> -	if (ret < 0)
> -		return ret;
> -
> -	msecs = FIELD_GET(AD7280A_CB_TIMER_VAL_MSK, ret) * 71500;
> -
> -	return sysfs_emit(buf, "%u.%u\n", msecs / 1000, msecs % 1000);
> -}
> -
> -static ssize_t ad7280_store_balance_timer(struct iio_dev *indio_dev,
> -					  uintptr_t private,
> -					  const struct iio_chan_spec *chan,
> -					  const char *buf, size_t len)
> -{
> -	struct ad7280_state *st = iio_priv(indio_dev);
> -	int val, val2;
> -	int ret;
> -
> -	ret = iio_str_to_fixpoint(buf, 1000, &val, &val2);
> -	if (ret)
> -		return ret;
> -
> -	val = val * 1000 + val2;
> -	val /= 71500;
> -
> -	if (val > 31)
> -		return -EINVAL;
> -
> -	mutex_lock(&st->lock);
> -	ret = ad7280_write(st, chan->address >> 8,
> -			   (chan->address & 0xFF) + AD7280A_CB1_TIMER_REG, 0,
> -			   FIELD_PREP(AD7280A_CB_TIMER_VAL_MSK, val));
> -	mutex_unlock(&st->lock);
> -
> -	return ret ? ret : len;
> -}
> -
> -static const struct iio_chan_spec_ext_info ad7280_cell_ext_info[] = {
> -	{
> -		.name = "balance_switch_en",
> -		.read = ad7280_show_balance_sw,
> -		.write = ad7280_store_balance_sw,
> -		.shared = IIO_SEPARATE,
> -	}, {
> -		.name = "balance_switch_timer",
> -		.read = ad7280_show_balance_timer,
> -		.write = ad7280_store_balance_timer,
> -		.shared = IIO_SEPARATE,
> -	},
> -	{}
> -};
> -
> -static const struct iio_event_spec ad7280_events[] = {
> -	{
> -		.type = IIO_EV_TYPE_THRESH,
> -		.dir = IIO_EV_DIR_RISING,
> -		.mask_shared_by_type = BIT(IIO_EV_INFO_VALUE),
> -	}, {
> -		.type = IIO_EV_TYPE_THRESH,
> -		.dir = IIO_EV_DIR_FALLING,
> -		.mask_shared_by_type = BIT(IIO_EV_INFO_VALUE),
> -	},
> -};
> -
> -static void ad7280_voltage_channel_init(struct iio_chan_spec *chan, int i,
> -					bool irq_present)
> -{
> -	chan->type = IIO_VOLTAGE;
> -	chan->differential = 1;
> -	chan->channel = i;
> -	chan->channel2 = chan->channel + 1;
> -	if (irq_present) {
> -		chan->event_spec = ad7280_events;
> -		chan->num_event_specs = ARRAY_SIZE(ad7280_events);
> -	}
> -	chan->ext_info = ad7280_cell_ext_info;
> -}
> -
> -static void ad7280_temp_channel_init(struct iio_chan_spec *chan, int i,
> -				     bool irq_present)
> -{
> -	chan->type = IIO_TEMP;
> -	chan->channel = i;
> -	if (irq_present) {
> -		chan->event_spec = ad7280_events;
> -		chan->num_event_specs = ARRAY_SIZE(ad7280_events);
> -	}
> -}
> -
> -static void ad7280_common_fields_init(struct iio_chan_spec *chan, int addr,
> -				      int cnt)
> -{
> -	chan->indexed = 1;
> -	chan->info_mask_separate = BIT(IIO_CHAN_INFO_RAW);
> -	chan->info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE);
> -	chan->info_mask_shared_by_all = BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO);
> -	chan->address = addr;
> -	chan->scan_index = cnt;
> -	chan->scan_type.sign = 'u';
> -	chan->scan_type.realbits = 12;
> -	chan->scan_type.storagebits = 32;
> -}
> -
> -static void ad7280_total_voltage_channel_init(struct iio_chan_spec *chan,
> -					      int cnt, int dev)
> -{
> -	chan->type = IIO_VOLTAGE;
> -	chan->differential = 1;
> -	chan->channel = 0;
> -	chan->channel2 = dev * AD7280A_CELLS_PER_DEV;
> -	chan->address = AD7280A_ALL_CELLS;
> -	chan->indexed = 1;
> -	chan->info_mask_separate = BIT(IIO_CHAN_INFO_RAW);
> -	chan->info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE);
> -	chan->scan_index = cnt;
> -	chan->scan_type.sign = 'u';
> -	chan->scan_type.realbits = 32;
> -	chan->scan_type.storagebits = 32;
> -}
> -
> -static void ad7280_init_dev_channels(struct ad7280_state *st, int dev, int *cnt,
> -				     bool irq_present)
> -{
> -	int addr, ch, i;
> -	struct iio_chan_spec *chan;
> -
> -	for (ch = AD7280A_CELL_VOLTAGE_1_REG; ch <= AD7280A_AUX_ADC_6_REG; ch++) {
> -		chan = &st->channels[*cnt];
> -
> -		if (ch < AD7280A_AUX_ADC_1_REG) {
> -			i = AD7280A_CALC_VOLTAGE_CHAN_NUM(dev, ch);
> -			ad7280_voltage_channel_init(chan, i, irq_present);
> -		} else {
> -			i = AD7280A_CALC_TEMP_CHAN_NUM(dev, ch);
> -			ad7280_temp_channel_init(chan, i, irq_present);
> -		}
> -
> -		addr = ad7280a_devaddr(dev) << 8 | ch;
> -		ad7280_common_fields_init(chan, addr, *cnt);
> -
> -		(*cnt)++;
> -	}
> -}
> -
> -static int ad7280_channel_init(struct ad7280_state *st, bool irq_present)
> -{
> -	int dev, cnt = 0;
> -
> -	st->channels = devm_kcalloc(&st->spi->dev, (st->slave_num + 1) * 12 + 1,
> -				    sizeof(*st->channels), GFP_KERNEL);
> -	if (!st->channels)
> -		return -ENOMEM;
> -
> -	for (dev = 0; dev <= st->slave_num; dev++)
> -		ad7280_init_dev_channels(st, dev, &cnt, irq_present);
> -
> -	ad7280_total_voltage_channel_init(&st->channels[cnt], cnt, dev);
> -
> -	return cnt + 1;
> -}
> -
> -static int ad7280a_read_thresh(struct iio_dev *indio_dev,
> -			       const struct iio_chan_spec *chan,
> -			       enum iio_event_type type,
> -			       enum iio_event_direction dir,
> -			       enum iio_event_info info, int *val, int *val2)
> -{
> -	struct ad7280_state *st = iio_priv(indio_dev);
> -
> -	switch (chan->type) {
> -	case IIO_VOLTAGE:
> -		switch (dir) {
> -		case IIO_EV_DIR_RISING:
> -			*val = 1000 + (st->cell_threshhigh * 1568L) / 100;
> -			return IIO_VAL_INT;
> -		case IIO_EV_DIR_FALLING:
> -			*val = 1000 + (st->cell_threshlow * 1568L) / 100;
> -			return IIO_VAL_INT;
> -		default:
> -			return -EINVAL;
> -		}
> -		break;
> -	case IIO_TEMP:
> -		switch (dir) {
> -		case IIO_EV_DIR_RISING:
> -			*val = ((st->aux_threshhigh) * 196L) / 10;
> -			return IIO_VAL_INT;
> -		case IIO_EV_DIR_FALLING:
> -			*val = (st->aux_threshlow * 196L) / 10;
> -			return IIO_VAL_INT;
> -		default:
> -			return -EINVAL;
> -		}
> -		break;
> -	default:
> -		return -EINVAL;
> -	}
> -}
> -
> -static int ad7280a_write_thresh(struct iio_dev *indio_dev,
> -				const struct iio_chan_spec *chan,
> -				enum iio_event_type type,
> -				enum iio_event_direction dir,
> -				enum iio_event_info info,
> -				int val, int val2)
> -{
> -	struct ad7280_state *st = iio_priv(indio_dev);
> -	unsigned int addr;
> -	long value;
> -	int ret;
> -
> -	if (val2 != 0)
> -		return -EINVAL;
> -
> -	mutex_lock(&st->lock);
> -	switch (chan->type) {
> -	case IIO_VOLTAGE:
> -		value = ((val - 1000) * 100) / 1568; /* LSB 15.68mV */
> -		value = clamp(value, 0L, 0xFFL);
> -		switch (dir) {
> -		case IIO_EV_DIR_RISING:
> -			addr = AD7280A_CELL_OVERVOLTAGE_REG;
> -			st->cell_threshhigh = value;
> -			break;
> -		case IIO_EV_DIR_FALLING:
> -			addr = AD7280A_CELL_UNDERVOLTAGE_REG;
> -			st->cell_threshlow = value;
> -			break;
> -		default:
> -			ret = -EINVAL;
> -			goto err_unlock;
> -		}
> -		break;
> -	case IIO_TEMP:
> -		value = (val * 10) / 196; /* LSB 19.6mV */
> -		value = clamp(value, 0L, 0xFFL);
> -		switch (dir) {
> -		case IIO_EV_DIR_RISING:
> -			addr = AD7280A_AUX_ADC_OVERVOLTAGE_REG;
> -			st->aux_threshhigh = val;
> -			break;
> -		case IIO_EV_DIR_FALLING:
> -			addr = AD7280A_AUX_ADC_UNDERVOLTAGE_REG;
> -			st->aux_threshlow = val;
> -			break;
> -		default:
> -			ret = -EINVAL;
> -			goto err_unlock;
> -		}
> -		break;
> -	default:
> -		ret = -EINVAL;
> -		goto err_unlock;
> -	}
> -
> -	ret = ad7280_write(st, AD7280A_DEVADDR_MASTER, addr, 1, val);
> -err_unlock:
> -	mutex_unlock(&st->lock);
> -
> -	return ret;
> -}
> -
> -static irqreturn_t ad7280_event_handler(int irq, void *private)
> -{
> -	struct iio_dev *indio_dev = private;
> -	struct ad7280_state *st = iio_priv(indio_dev);
> -	unsigned int *channels;
> -	int i, ret;
> -
> -	channels = kcalloc(st->scan_cnt, sizeof(*channels), GFP_KERNEL);
> -	if (!channels)
> -		return IRQ_HANDLED;
> -
> -	ret = ad7280_read_all_channels(st, st->scan_cnt, channels);
> -	if (ret < 0)
> -		goto out;
> -
> -	for (i = 0; i < st->scan_cnt; i++) {
> -		unsigned int val;
> -
> -		val = FIELD_GET(AD7280A_TRANS_READ_CONV_DATA_MSK, channels[i]);
> -		if (FIELD_GET(AD7280A_TRANS_READ_CONV_CHANADDR_MSK, channels[i])
> -			<= AD7280A_CELL_VOLTAGE_6_REG) {
> -			if (val >= st->cell_threshhigh) {
> -				u64 tmp = IIO_EVENT_CODE(IIO_VOLTAGE, 1, 0,
> -							 IIO_EV_DIR_RISING,
> -							 IIO_EV_TYPE_THRESH,
> -							 0, 0, 0);
> -				iio_push_event(indio_dev, tmp,
> -					       iio_get_time_ns(indio_dev));
> -			} else if (val <= st->cell_threshlow) {
> -				u64 tmp = IIO_EVENT_CODE(IIO_VOLTAGE, 1, 0,
> -							 IIO_EV_DIR_FALLING,
> -							 IIO_EV_TYPE_THRESH,
> -							 0, 0, 0);
> -				iio_push_event(indio_dev, tmp,
> -					       iio_get_time_ns(indio_dev));
> -			}
> -		} else {
> -			if (val >= st->aux_threshhigh) {
> -				u64 tmp = IIO_UNMOD_EVENT_CODE(IIO_TEMP, 0,
> -							IIO_EV_TYPE_THRESH,
> -							IIO_EV_DIR_RISING);
> -				iio_push_event(indio_dev, tmp,
> -					       iio_get_time_ns(indio_dev));
> -			} else if (val <= st->aux_threshlow) {
> -				u64 tmp = IIO_UNMOD_EVENT_CODE(IIO_TEMP, 0,
> -							IIO_EV_TYPE_THRESH,
> -							IIO_EV_DIR_FALLING);
> -				iio_push_event(indio_dev, tmp,
> -					       iio_get_time_ns(indio_dev));
> -			}
> -		}
> -	}
> -
> -out:
> -	kfree(channels);
> -
> -	return IRQ_HANDLED;
> -}
> -
> -static void ad7280_update_delay(struct ad7280_state *st)
> -{
> -	/*
> -	 * Total Conversion Time = ((tACQ + tCONV) *
> -	 *			   (Number of Conversions per Part)) −
> -	 *			   tACQ + ((N - 1) * tDELAY)
> -	 *
> -	 * Readback Delay = Total Conversion Time + tWAIT
> -	 */
> -
> -	st->readback_delay_us =
> -		((ad7280a_t_acq_ns[st->acquisition_time & 0x3] + 695) *
> -			(AD7280A_NUM_CH * ad7280a_n_avg[st->oversampling_ratio & 0x3])) -
> -		ad7280a_t_acq_ns[st->acquisition_time & 0x3] + st->slave_num * 250;
> -
> -	/* Convert to usecs */
> -	st->readback_delay_us = DIV_ROUND_UP(st->readback_delay_us, 1000);
> -	st->readback_delay_us += 5; /* Add tWAIT */
> -}
> -
> -static int ad7280_read_raw(struct iio_dev *indio_dev,
> -			   struct iio_chan_spec const *chan,
> -			   int *val,
> -			   int *val2,
> -			   long m)
> -{
> -	struct ad7280_state *st = iio_priv(indio_dev);
> -	int ret;
> -
> -	switch (m) {
> -	case IIO_CHAN_INFO_RAW:
> -		mutex_lock(&st->lock);
> -		if (chan->address == AD7280A_ALL_CELLS)
> -			ret = ad7280_read_all_channels(st, st->scan_cnt, NULL);
> -		else
> -			ret = ad7280_read_channel(st, chan->address >> 8,
> -						  chan->address & 0xFF);
> -		mutex_unlock(&st->lock);
> -
> -		if (ret < 0)
> -			return ret;
> -
> -		*val = ret;
> -
> -		return IIO_VAL_INT;
> -	case IIO_CHAN_INFO_SCALE:
> -		if ((chan->address & 0xFF) <= AD7280A_CELL_VOLTAGE_6_REG)
> -			*val = 4000;
> -		else
> -			*val = 5000;
> -
> -		*val2 = AD7280A_BITS;
> -		return IIO_VAL_FRACTIONAL_LOG2;
> -	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> -		*val = ad7280a_n_avg[st->oversampling_ratio];
> -		return IIO_VAL_INT;
> -	}
> -	return -EINVAL;
> -}
> -
> -static int ad7280_write_raw(struct iio_dev *indio_dev,
> -			    struct iio_chan_spec const *chan,
> -			    int val, int val2, long mask)
> -{
> -	struct ad7280_state *st = iio_priv(indio_dev);
> -	int i;
> -
> -	switch (mask) {
> -	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> -		if (val2 != 0)
> -			return -EINVAL;
> -		for (i = 0; i < ARRAY_SIZE(ad7280a_n_avg); i++) {
> -			if (val == ad7280a_n_avg[i]) {
> -				st->oversampling_ratio = i;
> -				ad7280_update_delay(st);
> -				return 0;
> -			}
> -		}
> -		return -EINVAL;
> -	default:
> -		return -EINVAL;
> -	}
> -}
> -
> -static const struct iio_info ad7280_info = {
> -	.read_raw = ad7280_read_raw,
> -	.write_raw = ad7280_write_raw,
> -	.read_event_value = &ad7280a_read_thresh,
> -	.write_event_value = &ad7280a_write_thresh,
> -};
> -
> -static const struct iio_info ad7280_info_no_irq = {
> -	.read_event_value = &ad7280a_read_thresh,
> -	.write_event_value = &ad7280a_write_thresh,
> -};
> -
> -static int ad7280_probe(struct spi_device *spi)
> -{
> -	struct device *dev = &spi->dev;
> -	struct ad7280_state *st;
> -	int ret;
> -	struct iio_dev *indio_dev;
> -
> -	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
> -	if (!indio_dev)
> -		return -ENOMEM;
> -
> -	st = iio_priv(indio_dev);
> -	spi_set_drvdata(spi, indio_dev);
> -	st->spi = spi;
> -	mutex_init(&st->lock);
> -
> -	st->thermistor_term_en =
> -		device_property_read_bool(dev, "adi,thermistor-termination");
> -
> -	if (device_property_present(dev, "adi,acquistion-time-ns")) {
> -		u32 val;
> -
> -		ret = device_property_read_u32(dev, "adi,acquisition-time-ns", &val);
> -		if (ret)
> -			return ret;
> -
> -		switch (val) {
> -		case 400:
> -			st->acquisition_time = AD7280A_CTRL_LB_ACQ_TIME_400ns;
> -			break;
> -		case 800:
> -			st->acquisition_time = AD7280A_CTRL_LB_ACQ_TIME_800ns;
> -			break;
> -		case 1200:
> -			st->acquisition_time = AD7280A_CTRL_LB_ACQ_TIME_1200ns;
> -			break;
> -		case 1600:
> -			st->acquisition_time = AD7280A_CTRL_LB_ACQ_TIME_1600ns;
> -			break;
> -		default:
> -			dev_err(dev, "Firmware provided acquisition time is invalid\n");
> -			return -EINVAL;
> -		}
> -	} else {
> -		st->acquisition_time = AD7280A_CTRL_LB_ACQ_TIME_400ns;
> -	}
> -
> -	/* Alert masks are intended for when particular inputs are not wired up */
> -	if (device_property_present(dev, "adi,voltage-alert-last-chan")) {
> -		u8 val;
> -
> -		ret = device_property_read_u8(dev, "adi,voltage-alert-last-chan", &val);
> -		if (ret)
> -			return ret;
> -
> -		switch (val) {
> -		case 3:
> -			st->chain_last_alert_ignore |= AD7280A_ALERT_REMOVE_VIN4_VIN5;
> -			break;
> -		case 4:
> -			st->chain_last_alert_ignore |= AD7280A_ALERT_REMOVE_VIN5;
> -			break;
> -		case 5:
> -			break;
> -		default:
> -			dev_err(dev,
> -				"Firmware provided last voltage alert channel invalid\n");
> -			break;
> -		}
> -	}
> -	if (device_property_present(dev, "adi,temp-alert-last-chan")) {
> -		u8 val;
> -
> -		ret = device_property_read_u8(dev, "adi,temp-alert-last-chan", &val);
> -		if (ret)
> -			return ret;
> -
> -		switch (val) {
> -		case 3:
> -			st->chain_last_alert_ignore |= AD7280A_ALERT_REMOVE_AUX4_AUX5;
> -			break;
> -		case 4:
> -			st->chain_last_alert_ignore |= AD7280A_ALERT_REMOVE_AUX5;
> -			break;
> -		case 5:
> -			break;
> -		default:
> -			dev_err(dev,
> -				"Firmware provided last temp alert channel invalid\n");
> -			break;
> -		}
> -	}
> -	crc8_populate_msb(st->crc_tab, POLYNOM);
> -
> -	st->spi->max_speed_hz = AD7280A_MAX_SPI_CLK_HZ;
> -	st->spi->mode = SPI_MODE_1;
> -	spi_setup(st->spi);
> -
> -	st->ctrl_lb = FIELD_PREP(AD7280A_CTRL_LB_ACQ_TIME_MSK, st->acquisition_time) |
> -		FIELD_PREP(AD7280A_CTRL_LB_THERMISTOR_MSK, st->thermistor_term_en);
> -	st->oversampling_ratio = 0; /* No oversampling */
> -
> -	ret = ad7280_chain_setup(st);
> -	if (ret < 0)
> -		return ret;
> -
> -	st->slave_num = ret;
> -	st->scan_cnt = (st->slave_num + 1) * AD7280A_NUM_CH;
> -	st->cell_threshhigh = 0xFF;
> -	st->aux_threshhigh = 0xFF;
> -
> -	ret = devm_add_action_or_reset(dev, ad7280_sw_power_down, st);
> -	if (ret)
> -		return ret;
> -
> -	ad7280_update_delay(st);
> -
> -	indio_dev->name = spi_get_device_id(spi)->name;
> -	indio_dev->modes = INDIO_DIRECT_MODE;
> -
> -	ret = ad7280_channel_init(st, spi->irq > 0);
> -	if (ret < 0)
> -		return ret;
> -
> -	indio_dev->num_channels = ret;
> -	indio_dev->channels = st->channels;
> -	if (spi->irq > 0) {
> -		ret = ad7280_write(st, AD7280A_DEVADDR_MASTER,
> -				   AD7280A_ALERT_REG, 1,
> -				   AD7280A_ALERT_RELAY_SIG_CHAIN_DOWN);
> -		if (ret)
> -			return ret;
> -
> -		ret = ad7280_write(st, ad7280a_devaddr(st->slave_num),
> -				   AD7280A_ALERT_REG, 0,
> -				   AD7280A_ALERT_GEN_STATIC_HIGH |
> -				   FIELD_PREP(AD7280A_ALERT_REMOVE_MSK,
> -					      st->chain_last_alert_ignore));
> -		if (ret)
> -			return ret;
> -
> -		ret = devm_request_threaded_irq(dev, spi->irq,
> -						NULL,
> -						ad7280_event_handler,
> -						IRQF_TRIGGER_FALLING |
> -						IRQF_ONESHOT,
> -						indio_dev->name,
> -						indio_dev);
> -		if (ret)
> -			return ret;
> -
> -		indio_dev->info = &ad7280_info;
> -	} else {
> -		indio_dev->info = &ad7280_info_no_irq;
> -	}
> -
> -	return devm_iio_device_register(dev, indio_dev);
> -}
> -
> -static const struct spi_device_id ad7280_id[] = {
> -	{"ad7280a", 0},
> -	{}
> -};
> -MODULE_DEVICE_TABLE(spi, ad7280_id);
> -
> -static struct spi_driver ad7280_driver = {
> -	.driver = {
> -		.name	= "ad7280",
> -	},
> -	.probe		= ad7280_probe,
> -	.id_table	= ad7280_id,
> -};
> -module_spi_driver(ad7280_driver);
> -
> -MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
> -MODULE_DESCRIPTION("Analog Devices AD7280A");
> -MODULE_LICENSE("GPL v2");
> -- 
> 2.34.1
> 
