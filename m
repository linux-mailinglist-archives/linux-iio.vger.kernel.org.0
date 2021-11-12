Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3CD244EC5F
	for <lists+linux-iio@lfdr.de>; Fri, 12 Nov 2021 19:02:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235425AbhKLSEx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 12 Nov 2021 13:04:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:42890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235420AbhKLSEv (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 12 Nov 2021 13:04:51 -0500
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2066C61057;
        Fri, 12 Nov 2021 18:01:58 +0000 (UTC)
Date:   Fri, 12 Nov 2021 18:06:44 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc:     <robh+dt@kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/4] iio:filter:admv8818: add support for ADMV8818
Message-ID: <20211112180644.0ecb3768@jic23-huawei>
In-Reply-To: <20211109123127.96399-3-antoniu.miclaus@analog.com>
References: <20211109123127.96399-1-antoniu.miclaus@analog.com>
        <20211109123127.96399-3-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 9 Nov 2021 14:31:25 +0200
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> The ADMV8818-EP is a fully monolithic microwave integrated
> circuit (MMIC) that features a digitally selectable frequency of
> operation. The device features four independently controlled high-
> pass filters (HPFs) and four independently controlled low-pass
> filters (LPFs) that span the 2 GHz to 18 GHz frequency range.
> 
> Datasheet:
> https://www.analog.com/media/en/technical-documentation/data-sheets/admv8818-ep.pdf
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>

No significant comments in the actual driver from me.  Nice and clean, we just
need to figure out the ABI questions etc.

Thanks,

Jonathan

> ---
>  drivers/iio/filter/Kconfig    |  10 +
>  drivers/iio/filter/Makefile   |   1 +
>  drivers/iio/filter/admv8818.c | 819 ++++++++++++++++++++++++++++++++++
>  3 files changed, 830 insertions(+)
>  create mode 100644 drivers/iio/filter/admv8818.c
> 
> diff --git a/drivers/iio/filter/Kconfig b/drivers/iio/filter/Kconfig
> index e268bba43852..3ae35817ad82 100644
> --- a/drivers/iio/filter/Kconfig
> +++ b/drivers/iio/filter/Kconfig
> @@ -5,4 +5,14 @@
>  
>  menu "Filters"
>  
> +config ADMV8818
> +	tristate "Analog Devices ADMV8818 High-Pass and Low-Pass Filter"
> +	depends on SPI && COMMON_CLK && 64BIT
> +	help
> +	  Say yes here to build support for Analog Devices ADMV8818
> +	  2 GHz to 18 GHz, Digitally Tunable, High-Pass and Low-Pass Filter.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  modiule will be called admv8818.
> +
>  endmenu
> diff --git a/drivers/iio/filter/Makefile b/drivers/iio/filter/Makefile
> index cc0892c01142..55e228c0dd20 100644
> --- a/drivers/iio/filter/Makefile
> +++ b/drivers/iio/filter/Makefile
> @@ -4,3 +4,4 @@
>  #
>  
>  # When adding new entries keep the list in alphabetical order
> +obj-$(CONFIG_ADMV8818) += admv8818.o
> diff --git a/drivers/iio/filter/admv8818.c b/drivers/iio/filter/admv8818.c
> new file mode 100644
> index 000000000000..c31f4e53573e
> --- /dev/null
> +++ b/drivers/iio/filter/admv8818.c
> @@ -0,0 +1,819 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * ADMV8818 driver
> + *
> + * Copyright 2021 Analog Devices Inc.
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/clk.h>
> +#include <linux/clkdev.h>
> +#include <linux/clk-provider.h>
> +#include <linux/device.h>
> +#include <linux/iio/iio.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/mutex.h>
> +#include <linux/notifier.h>
> +#include <linux/regmap.h>
> +#include <linux/spi/spi.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/units.h>
> +
> +/* ADMV8818 Register Map */
> +#define ADMV8818_REG_SPI_CONFIG_A		0x0
> +#define ADMV8818_REG_SPI_CONFIG_B		0x1
> +#define ADMV8818_REG_CHIPTYPE			0x3
> +#define ADMV8818_REG_PRODUCT_ID_L		0x4
> +#define ADMV8818_REG_PRODUCT_ID_H		0x5
> +#define ADMV8818_REG_FAST_LATCH_POINTER		0x10
> +#define ADMV8818_REG_FAST_LATCH_STOP		0x11
> +#define ADMV8818_REG_FAST_LATCH_START		0x12
> +#define ADMV8818_REG_FAST_LATCH_DIRECTION	0x13
> +#define ADMV8818_REG_FAST_LATCH_STATE		0x14
> +#define ADMV8818_REG_WR0_SW			0x20
> +#define ADMV8818_REG_WR0_FILTER			0x21
> +#define ADMV8818_REG_WR1_SW			0x22
> +#define ADMV8818_REG_WR1_FILTER			0x23
> +#define ADMV8818_REG_WR2_SW			0x24
> +#define ADMV8818_REG_WR2_FILTER			0x25
> +#define ADMV8818_REG_WR3_SW			0x26
> +#define ADMV8818_REG_WR3_FILTER			0x27
> +#define ADMV8818_REG_WR4_SW			0x28
> +#define ADMV8818_REG_WR4_FILTER			0x29
> +#define ADMV8818_REG_LUT0_SW			0x100
> +#define ADMV8818_REG_LUT0_FILTER		0x101
> +#define ADMV8818_REG_LUT127_SW			0x1FE
> +#define ADMV8818_REG_LUT127_FILTER		0x1FF
> +
> +/* ADMV8818_REG_SPI_CONFIG_A Map */
> +#define ADMV8818_SOFTRESET_N_MSK		BIT(7)
> +#define ADMV8818_LSB_FIRST_N_MSK		BIT(6)
> +#define ADMV8818_ENDIAN_N_MSK			BIT(5)
> +#define ADMV8818_SDOACTIVE_N_MSK		BIT(4)
> +#define ADMV8818_SDOACTIVE_MSK			BIT(3)
> +#define ADMV8818_ENDIAN_MSK			BIT(2)
> +#define ADMV8818_LSBFIRST_MSK			BIT(1)
> +#define ADMV8818_SOFTRESET_MSK			BIT(0)
> +
> +/* ADMV8818_REG_SPI_CONFIG_B Map */
> +#define ADMV8818_SINGLE_INSTRUCTION_MSK		BIT(7)
> +#define ADMV8818_CSB_STALL_MSK			BIT(6)
> +#define ADMV8818_MASTER_SLAVE_RB_MSK		BIT(5)
> +#define ADMV8818_MASTER_SLAVE_TRANSFER_MSK	BIT(0)
> +
> +/* ADMV8818_REG_WR0_SW Map */
> +#define ADMV8818_SW_IN_SET_WR0_MSK		BIT(7)
> +#define ADMV8818_SW_OUT_SET_WR0_MSK		BIT(6)
> +#define ADMV8818_SW_IN_WR0_MSK			GENMASK(5, 3)
> +#define ADMV8818_SW_OUT_WR0_MSK			GENMASK(2, 0)
> +
> +/* ADMV8818_REG_WR0_FILTER Map */
> +#define ADMV8818_HPF_WR0_MSK			GENMASK(7, 4)
> +#define ADMV8818_LPF_WR0_MSK			GENMASK(3, 0)
> +
> +enum {
> +	ADMV8818_BW_FREQ,
> +	ADMV8818_CENTER_FREQ
> +};
> +
> +struct admv8818_state {
> +	struct spi_device	*spi;
> +	struct regmap		*regmap;
> +	struct clk		*clkin;
> +	struct notifier_block	nb;
> +	/* Protect against concurrent accesses to the device and data content*/
> +	struct mutex		lock;
> +	unsigned int		filter_mode;
> +	unsigned int		freq_scale;
> +	u64			cf_hz;
> +	u64			bw_hz;
> +};
> +
> +static const unsigned long long freq_range_hpf[4][2] = {
> +	{1750000000ULL, 3550000000ULL},
> +	{3400000000ULL, 7250000000ULL},
> +	{6600000000, 12000000000},
> +	{12500000000, 19900000000}
> +};
> +
> +static const unsigned long long freq_range_lpf[4][2] = {
> +	{2050000000ULL, 3850000000ULL},
> +	{3350000000ULL, 7250000000ULL},
> +	{7000000000, 13000000000},
> +	{12550000000, 18500000000}
> +};
> +
> +static const struct regmap_config admv8818_regmap_config = {
> +	.reg_bits = 16,
> +	.val_bits = 8,
> +	.read_flag_mask = 0x80,
> +	.max_register = 0x1FF,
> +};
> +
> +static const char * const admv8818_modes[] = {
> +	[0] = "auto",
> +	[1] = "bypass",
> +	[2] = "manual"
> +};
> +
> +static int __admv8818_hpf_select(struct admv8818_state *st, u64 freq)
> +{
> +	unsigned int hpf_step = 0, hpf_band = 0, i, j;
> +	u64 freq_step;
> +	int ret;
> +
> +	if (freq < freq_range_hpf[0][0])
> +		goto hpf_write;
> +
> +	if (freq > freq_range_hpf[3][1]) {
> +		hpf_step = 15;
> +		hpf_band = 4;
> +
> +		goto hpf_write;
> +	}
> +
> +	for (i = 0; i < 4; i++) {
> +		freq_step = div_u64((freq_range_hpf[i][1] -
> +			freq_range_hpf[i][0]), 15);
> +
> +		if (freq > freq_range_hpf[i][0] &&
> +		    (freq < freq_range_hpf[i][1] + freq_step)) {
> +			hpf_band = i + 1;
> +
> +			for (j = 1; j <= 16; j++) {
> +				if (freq < (freq_range_hpf[i][0] + (freq_step * j))) {
> +					hpf_step = j - 1;
> +					break;
> +				}
> +			}
> +			break;
> +		}
> +	}
> +
> +	/* Close HPF frequency gap between 12 and 12.5 GHz */
> +	if (freq >= 12000 * HZ_PER_MHZ && freq <= 12500 * HZ_PER_MHZ) {
> +		hpf_band = 3;
> +		hpf_step = 15;
> +	}
> +
> +hpf_write:
> +	ret = regmap_update_bits(st->regmap, ADMV8818_REG_WR0_SW,
> +				 ADMV8818_SW_IN_SET_WR0_MSK |
> +				 ADMV8818_SW_IN_WR0_MSK,
> +				 FIELD_PREP(ADMV8818_SW_IN_SET_WR0_MSK, 1) |
> +				 FIELD_PREP(ADMV8818_SW_IN_WR0_MSK, hpf_band));
> +	if (ret)
> +		return ret;
> +
> +	return regmap_update_bits(st->regmap, ADMV8818_REG_WR0_FILTER,
> +				  ADMV8818_HPF_WR0_MSK,
> +				  FIELD_PREP(ADMV8818_HPF_WR0_MSK, hpf_step));
> +}
> +
> +static int admv8818_hpf_select(struct admv8818_state *st, u64 freq)
> +{
> +	int ret;
> +
> +	mutex_lock(&st->lock);
> +	ret = __admv8818_hpf_select(st, freq);
> +	mutex_unlock(&st->lock);
> +
> +	return ret;
> +}
> +
> +static int __admv8818_lpf_select(struct admv8818_state *st, u64 freq)
> +{
> +	unsigned int lpf_step = 0, lpf_band = 0, i, j;
> +	u64 freq_step;
> +	int ret;
> +
> +	if (freq > freq_range_lpf[3][1])
> +		goto lpf_write;
> +
> +	if (freq < freq_range_lpf[0][0]) {
> +		lpf_band = 1;
> +
> +		goto lpf_write;
> +	}
> +
> +	for (i = 0; i < 4; i++) {
> +		if (freq > freq_range_lpf[i][0] && freq < freq_range_lpf[i][1]) {
> +			lpf_band = i + 1;
> +			freq_step = div_u64((freq_range_lpf[i][1] - freq_range_lpf[i][0]), 15);
> +
> +			for (j = 0; j <= 15; j++) {
> +				if (freq < (freq_range_lpf[i][0] + (freq_step * j))) {
> +					lpf_step = j;
> +					break;
> +				}
> +			}
> +			break;
> +		}
> +	}
> +
> +lpf_write:
> +	ret = regmap_update_bits(st->regmap, ADMV8818_REG_WR0_SW,
> +				 ADMV8818_SW_OUT_SET_WR0_MSK |
> +				 ADMV8818_SW_OUT_WR0_MSK,
> +				 FIELD_PREP(ADMV8818_SW_OUT_SET_WR0_MSK, 1) |
> +				 FIELD_PREP(ADMV8818_SW_OUT_WR0_MSK, lpf_band));
> +	if (ret)
> +		return ret;
> +
> +	return regmap_update_bits(st->regmap, ADMV8818_REG_WR0_FILTER,
> +				  ADMV8818_LPF_WR0_MSK,
> +				  FIELD_PREP(ADMV8818_LPF_WR0_MSK, lpf_step));
> +}
> +
> +static int admv8818_lpf_select(struct admv8818_state *st, u64 freq)
> +{
> +	int ret;
> +
> +	mutex_lock(&st->lock);
> +	ret = __admv8818_lpf_select(st, freq);
> +	mutex_unlock(&st->lock);
> +
> +	return ret;
> +}
> +
> +static int admv8818_filter_bypass(struct admv8818_state *st)
> +{
> +	int ret;
> +
> +	mutex_lock(&st->lock);
> +
> +	ret = regmap_update_bits(st->regmap, ADMV8818_REG_WR0_SW,
> +				 ADMV8818_SW_IN_SET_WR0_MSK |
> +				 ADMV8818_SW_IN_WR0_MSK |
> +				 ADMV8818_SW_OUT_SET_WR0_MSK |
> +				 ADMV8818_SW_OUT_WR0_MSK,
> +				 FIELD_PREP(ADMV8818_SW_IN_SET_WR0_MSK, 1) |
> +				 FIELD_PREP(ADMV8818_SW_IN_WR0_MSK, 0) |
> +				 FIELD_PREP(ADMV8818_SW_OUT_SET_WR0_MSK, 1) |
> +				 FIELD_PREP(ADMV8818_SW_OUT_WR0_MSK, 0));
> +	if (ret)
> +		goto exit;
> +
> +	ret = regmap_update_bits(st->regmap, ADMV8818_REG_WR0_FILTER,
> +				 ADMV8818_HPF_WR0_MSK |
> +				 ADMV8818_LPF_WR0_MSK,
> +				 FIELD_PREP(ADMV8818_HPF_WR0_MSK, 0) |
> +				 FIELD_PREP(ADMV8818_LPF_WR0_MSK, 0));
> +
> +exit:
> +	mutex_unlock(&st->lock);
> +
> +	return ret;
> +}
> +

> +
> +static int admv8818_set_mode(struct iio_dev *indio_dev,
> +			     const struct iio_chan_spec *chan,
> +			     unsigned int mode)
> +{
> +	struct admv8818_state *st = iio_priv(indio_dev);
> +	int ret = 0;
> +
> +	switch (mode) {
> +	case 0:

If you do end up going this way then use an enum.

> +		if (st->filter_mode && st->clkin) {
> +			ret = clk_prepare_enable(st->clkin);
> +			if (ret)
> +				return ret;
> +
> +			ret = clk_notifier_register(st->clkin, &st->nb);
> +			if (ret)
> +				return ret;
> +		} else {
> +			return ret;
> +		}
> +
> +		break;
> +	case 1:
> +		if (st->filter_mode == 0 && st->clkin) {
> +			clk_disable_unprepare(st->clkin);
> +
> +			ret = clk_notifier_unregister(st->clkin, &st->nb);
> +			if (ret)
> +				return ret;
> +		}
> +
> +		ret = admv8818_filter_bypass(st);
> +		if (ret)
> +			return ret;
> +
> +		break;
> +	case 2:
> +		if (st->filter_mode == 0 && st->clkin) {
> +			clk_disable_unprepare(st->clkin);
> +
> +			ret = clk_notifier_unregister(st->clkin, &st->nb);
> +			if (ret)
> +				return ret;
> +		} else {
> +			return ret;
> +		}
> +
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	st->filter_mode = mode;
> +
> +	return ret;
> +}
