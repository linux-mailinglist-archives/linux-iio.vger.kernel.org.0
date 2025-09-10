Return-Path: <linux-iio+bounces-23950-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 309A5B51F01
	for <lists+linux-iio@lfdr.de>; Wed, 10 Sep 2025 19:32:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0964A00D24
	for <lists+linux-iio@lfdr.de>; Wed, 10 Sep 2025 17:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 533EF327A03;
	Wed, 10 Sep 2025 17:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ONO7d7uE"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0692F32C8B;
	Wed, 10 Sep 2025 17:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757525544; cv=none; b=FAqX5L0aXBOE8sp+rkeoVsKHCWzFv7SqxCh4D5pvMgSIgQhKmjwRkqxgSz2o8ZnHYJA+IzvY5HhDlsJypIEEBHhWee8h/TE0ncK45QxK5Chs3qYrSxoLA15Qn3LJSwt2RXf0QFB+fC7nDPg1HOhOP2HOd8QPfS83D2cyKfhv8XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757525544; c=relaxed/simple;
	bh=9XkabxRTENCZclA4TOSDenM8JnZkN+VrWPTUmA4Vlp0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mu2IswW+8l6sx9XU1nDtbdGpc8tsbYPHqyqIvfUWrKrGNm4rC+6iRKf9josjd1Q/u5m1pwj8TfyUtV7E+gPLy+6QzGbhc4Gl2qGVrszfjaq0w0dUmfgRwUGEuK6yZb4D/PRG0Da5hGYIiAk2OpGWquuFRF/bZnhC6sKYq4NQYV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ONO7d7uE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E379C4CEEB;
	Wed, 10 Sep 2025 17:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757525542;
	bh=9XkabxRTENCZclA4TOSDenM8JnZkN+VrWPTUmA4Vlp0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ONO7d7uEG03HpDLJ1lGUMGp+orrrL8g5XTSvu7j+SjrVZN3FKclDquFBeR7y1LXpa
	 jDHBBLupglR+D4Tcw7lLInKTUfiRv8IUsJWnCkFbllG+L5FhdATzki/FK+f4OKJI7r
	 6idy8fppb6xWEhnSTWt1Z5mjP29DKqoiH0HoJJyTVXSI3M3BTX0n8/cxSzjvW0VfMp
	 GQ6P1dWZ8avD5IzEURWLnTmWxZBTvD1ATD3A7/ySJvo+sZq9nGwqNI0qzb9rrQL86H
	 IgTphc5eYXGBg4Q5AUcypVwCc/5JnRRvnolr8fIXBw1BIWV/NChFhdf47s8Ba8o4f+
	 hT5/QISnEl9ZA==
Date: Wed, 10 Sep 2025 18:32:12 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 robh@kernel.org, conor+dt@kernel.org, krzk+dt@kernel.org,
 linux-iio@vger.kernel.org, s32@nxp.com, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, chester62515@gmail.com, mbrugger@suse.com,
 ghennadi.procopciuc@oss.nxp.com
Subject: Re: [PATCH v2 2/2] iio: adc: Add the NXP SAR ADC support for the
 s32g2/3 platforms
Message-ID: <20250910183212.6640e662@jic23-huawei>
In-Reply-To: <20250910155759.75380-3-daniel.lezcano@linaro.org>
References: <20250910155759.75380-1-daniel.lezcano@linaro.org>
	<20250910155759.75380-3-daniel.lezcano@linaro.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Sep 2025 17:57:56 +0200
Daniel Lezcano <daniel.lezcano@linaro.org> wrote:

> From: Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>
> 
> The NXP S32G2 and S32G3 platforms integrate a successive approximation
> register (SAR) ADC. Two instances are available, each providing 8
> multiplexed input channels with 12-bit resolution. The conversion rate
> is up to 1 Msps depending on the configuration and sampling window.
> 
> The SAR ADC supports raw, buffer, and trigger modes. It can operate
> in both single-shot and continuous conversion modes, with optional
> hardware triggering through the cross-trigger unit (CTU) or external
> events. An internal prescaler allows adjusting the sampling clock,
> while per-channel programmable sampling times provide fine-grained
> trade-offs between accuracy and latency. Automatic calibration is
> performed at probe time to minimize offset and gain errors.
> 
> The driver is derived from the BSP implementation and has been partly
> rewritten to comply with upstream requirements. For this reason, all
> contributors are listed as co-developers, while the author refers to
> the initial BSP driver file creator.
> 
> All modes have been validated on the S32G274-RDB2 platform using an
> externally generated square wave captured by the ADC. Tests covered
> buffered streaming via IIO, trigger synchronization, and accuracy
> verification against a precision laboratory signal source.
> 
> Co-developed-by: Alexandru-Catalin Ionita <alexandru-catalin.ionita@nxp.com>
> Signed-off-by: Alexandru-Catalin Ionita <alexandru-catalin.ionita@nxp.com>
> Co-developed-by: Ciprian Costea <ciprianmarian.costea@nxp.com>
> Signed-off-by: Ciprian Costea <ciprianmarian.costea@nxp.com>
> Co-developed-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
> Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
> Signed-off-by: Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>
> Co-developed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Hi Daniel,

Various feedback inline.  I got a bit side tracked in the v1
timescale by the dma buffer discussion so sorry this is only on v2.


Jonathan

> ---
>  drivers/iio/adc/Kconfig       |   13 +
>  drivers/iio/adc/Makefile      |    1 +
>  drivers/iio/adc/nxp-sar-adc.c | 1026 +++++++++++++++++++++++++++++++++
>  3 files changed, 1040 insertions(+)
>  create mode 100644 drivers/iio/adc/nxp-sar-adc.c
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 6de2abad0197..4c2473a1fa20 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -1168,6 +1168,19 @@ config NPCM_ADC
>  	  This driver can also be built as a module. If so, the module
>  	  will be called npcm_adc.
>  
> +config NXP_SAR_ADC
> +	tristate "NXP S32G SAR-ADC driver"
> +	depends on ARCH_S32 || COMPILE_TEST
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
> +	select IIO_SYSFS_TRIGGER

Why?  Should work fine with the hrtimer trigger if someone preferred that
or as a client of many device specific triggers.

Shouldn't be any need to select a specific trigger.

> +	help
> +	  Say yes here to build support for S32G platforms
> +	  analog-to-digital converter.
> +
> +	  This driver can also be built as a module. If so, the module will be
> +	  called nxp_sar_adc.
> +

> diff --git a/drivers/iio/adc/nxp-sar-adc.c b/drivers/iio/adc/nxp-sar-adc.c
> new file mode 100644
> index 000000000000..421ce42ad9ec
> --- /dev/null
> +++ b/drivers/iio/adc/nxp-sar-adc.c
> @@ -0,0 +1,1026 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * NXP SAR-ADC driver (adapted from Freescale Vybrid vf610 ADC driver
> + * by Fugang Duan <B38611@freescale.com>)
> + *
> + * Copyright 2013 Freescale Semiconductor, Inc.
> + * Copyright 2017, 2020-2025 NXP
> + * Copyright 2025, Linaro Ltd
> + */
> +#include <linux/bitops.h>
> +#include <linux/circ_buf.h>
> +#include <linux/cleanup.h>
> +#include <linux/clk.h>
> +#include <linux/completion.h>
> +#include <linux/delay.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/dmaengine.h>
> +#include <linux/interrupt.h>
> +#include <linux/iopoll.h>
> +#include <linux/math64.h>
> +#include <linux/module.h>
> +#include <linux/of.h>

Why of.h?  Probably want mod_devicetable.h instead.
Most of the time a modern driver shouldn't need to use
of specific interfaces. Instead use property.h or subsystem
specific firmware queries.

> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/spinlock.h>
> +#include <linux/types.h>
> +#include <linux/units.h>
> +
> +#include <linux/iio/iio.h>
> +#include <linux/iio/triggered_buffer.h>
> +#include <linux/iio/trigger_consumer.h>
> +
> +/* This will be the driver name the kernel reports */
> +#define DRIVER_NAME "nxp-sar-adc"
> +
> +/* SAR ADC registers */
> +#define REG_ADC_CDR(__base, __channel)	(((__base) + 0x100) + ((__channel) * 0x4))
Avoid generic names for defines by prefixing with something appropriate
eg NXP_SADC_CDR_REG(__channel)

> +
> +#define REG_ADC_CDR_CDATA_MASK		GENMASK(11, 0)
> +#define REG_ADC_CDR_VALID		BIT(19)
> +
> +/* Main Configuration Register */
> +#define REG_ADC_MCR(__base)		((__base) + 0x00)

I'm not really convinced these macros help over just having
readl(info->regs + NXP_SADC_MCR_REG);


> +
> +#define REG_ADC_MCR_PWDN		BIT(0)
> +#define REG_ADC_MCR_ACKO		BIT(5)
> +#define REG_ADC_MCR_ADCLKSEL		BIT(8)
> +#define REG_ADC_MCR_TSAMP_MASK		GENMASK(10, 9)
> +#define REG_ADC_MCR_NRSMPL_MASK		GENMASK(12, 11)
> +#define REG_ADC_MCR_AVGEN		BIT(13)
> +#define REG_ADC_MCR_CALSTART		BIT(14)
> +#define REG_ADC_MCR_NSTART		BIT(24)
> +#define REG_ADC_MCR_MODE		BIT(29)
> +#define REG_ADC_MCR_OWREN		BIT(31)
> +
> +/* Main Status Register */
> +#define REG_ADC_MSR(__base)		((__base) + 0x04)
> +
> +#define REG_ADC_MSR_CALBUSY		BIT(29)
> +#define REG_ADC_MSR_CALFAIL		BIT(30)
> +
> +/* Interrupt Status Register */
> +#define REG_ADC_ISR(__base)		((__base) + 0x10)
> +
> +#define REG_ADC_ISR_ECH			BIT(0)
> +
> +/*  Channel Pending Register */
> +#define REG_ADC_CEOCFR0(__base)		((__base) + 0x14)
> +#define REG_ADC_CEOCFR1(__base)		((__base) + 0x18)
> +
> +#define REG_ADC_EOC_CH(c)		BIT((c) % 32)
> +
> +/* Interrupt Mask Register */
> +#define REG_ADC_IMR(__base)		((__base) + 0x20)
> +
> +/* Channel Interrupt Mask Register */
> +#define REG_ADC_CIMR0(__base)		((__base) + 0x24)
> +#define REG_ADC_CIMR1(__base)		((__base) + 0x28)
> +
> +/* DMA Setting Register */
> +#define REG_ADC_DMAE(__base)		((__base) + 0x40)
> +
> +#define REG_ADC_DMAE_DMAEN		BIT(0)
> +#define REG_ADC_DMAE_DCLR		BIT(1)
> +
> +/* DMA Control register */
> +#define REG_ADC_DMAR0(__base)		((__base) + 0x44)
> +#define REG_ADC_DMAR1(__base)		((__base) + 0x48)
> +
> +/* Conversion Timing Register */
> +#define REG_ADC_CTR0(__base)		((__base) + 0x94)
> +#define REG_ADC_CTR1(__base)		((__base) + 0x98)
> +
> +#define REG_ADC_CTR_INPSAMP_MIN		8
> +#define REG_ADC_CTR_INPSAMP_MAX		0xFF
> +
> +/* Normal Conversion Mask Register */
> +#define REG_ADC_NCMR0(__base)		((__base) + 0xa4)
> +#define REG_ADC_NCMR1(__base)		((__base) + 0xa8)
> +
> +/* Normal Conversion Mask Register field define */
> +#define REG_ADC_CH_MASK			GENMASK(7, 0)
> +
> +/* Other field define */
> +#define NXP_SAR_ADC_CONV_TIMEOUT_MS	100
> +#define NXP_SAR_ADC_CAL_TIMEOUT_US	(100 * USEC_PER_MSEC)
> +#define NXP_SAR_ADC_WAIT_US		(2 * USEC_PER_MSEC)
> +#define NXP_SAR_ADC_RESOLUTION		12
> +
> +/* Duration of conversion phases */
> +#define NXP_SAR_ADC_TPT			2
> +#define NXP_SAR_ADC_DP			2
> +#define NXP_SAR_ADC_CT			((NXP_SAR_ADC_RESOLUTION + 2) * 4)
> +#define NXP_SAR_ADC_CONV_TIME		(NXP_SAR_ADC_TPT + NXP_SAR_ADC_CT + NXP_SAR_ADC_DP)
> +
> +#define NXP_SAR_ADC_NR_CHANNELS	8
> +
> +#define NXP_SAR_ADC_IIO_BUFF_SZ		(NXP_SAR_ADC_NR_CHANNELS + (sizeof(u64) / sizeof(u16)))

IIO_DECLARE_BUFFER_WITH_TS() should handle this and is less reliant on
everything being round numbers than this is.

> +
> +#define NXP_PAGE_SIZE			SZ_4K
> +#define NXP_SAR_ADC_DMA_SAMPLE_SZ	DMA_SLAVE_BUSWIDTH_4_BYTES
> +#define NXP_SAR_ADC_DMA_BUFF_SZ		(NXP_PAGE_SIZE * NXP_SAR_ADC_DMA_SAMPLE_SZ)
> +#define NXP_SAR_ADC_DMA_SAMPLE_CNT	(NXP_SAR_ADC_DMA_BUFF_SZ / NXP_SAR_ADC_DMA_SAMPLE_SZ)
> +
> +struct nxp_sar_adc {
> +	void __iomem *regs;
> +	phys_addr_t regs_phys;
> +	struct clk *clk;
> +
> +	u16 value;
> +	u32 vref_mV;
> +	u8 current_channel;
> +	u8 channels_used;
> +
> +	struct completion completion;
> +
> +	u16 buffer[NXP_SAR_ADC_IIO_BUFF_SZ];
> +	u16 buffered_chan[NXP_SAR_ADC_NR_CHANNELS];

Perhaps documentation for these two as their relationship isn't entirely obvious from
the names.

> +
> +	struct circ_buf dma_buf;
> +	struct dma_chan	*dma_chan;
> +	struct dma_slave_config dma_config;
> +	dma_addr_t rx_dma_buf;
> +	dma_cookie_t cookie;
> +
> +	/* Protect circular buffers access. */
> +	spinlock_t lock;
> +
> +	/*
> +	 * Save and restore context
Single line comment format preferred.
> +	 */
> +	u32 inpsamp;
> +	u32 pwdn;
> +};

> +
> +static const struct iio_chan_spec nxp_sar_adc_iio_channels[] = {
> +	ADC_CHAN(0, IIO_VOLTAGE),
> +	ADC_CHAN(1, IIO_VOLTAGE),
> +	ADC_CHAN(2, IIO_VOLTAGE),
> +	ADC_CHAN(3, IIO_VOLTAGE),
> +	ADC_CHAN(4, IIO_VOLTAGE),
> +	ADC_CHAN(5, IIO_VOLTAGE),
> +	ADC_CHAN(6, IIO_VOLTAGE),
> +	ADC_CHAN(7, IIO_VOLTAGE),
> +	IIO_CHAN_SOFT_TIMESTAMP(32),

Whilst we only insist on monotonic numbering, putting it all the way down
at 32 seems excessive. Why not 8?  Perhaps a comment if this is to avoid
moving it for some future feature.

> +};
> +
> +static void nxp_sar_adc_irq_cfg(struct nxp_sar_adc *info, bool enable)
> +{
> +	if (enable)
> +		writel(REG_ADC_ISR_ECH, REG_ADC_IMR(info->regs));
> +	else
> +		writel(0, REG_ADC_IMR(info->regs));
> +}
> +
> +static bool __nxp_sar_adc_enable(struct nxp_sar_adc *info, bool enable)
Similar to comments below.  I'd avoid the __ prefix for helper functions.
Often a bit of adjusting of the name is better.
nxp_sar_adc_set_enabled() perhaps here?

> +{
> +	u32 mcr;
> +	bool pwdn;
> +
> +	mcr = readl(REG_ADC_MCR(info->regs));
> +
> +	/*
> +	 * Return the current state
> +	 */
> +	pwdn = mcr & REG_ADC_MCR_PWDN;
> +
> +	if (enable)
> +		mcr &= ~REG_ADC_MCR_PWDN;
> +	else
> +		mcr |= REG_ADC_MCR_PWDN;
> +
> +	writel(mcr, REG_ADC_MCR(info->regs));
> +
> +	/*
> +	 * Ensure there are at least three cycles between the
> +	 * configuration of NCMR and the setting of NSTART
> +	 */
> +	if (enable)
> +		ndelay(div64_u64(NSEC_PER_SEC, clk_get_rate(info->clk) * 3U));
> +
> +	return pwdn;
> +}

> +
> +static int nxp_sar_adc_calibration(struct nxp_sar_adc *info)
> +{
> +	int ret;
> +
> +	/*
> +	 * Calibration works only if the adc is powered up
> +	 */

Where they fit under 80 chars, stick to single line comments.

> +	nxp_sar_adc_enable(info);
> +
> +	/*
> +	 * The calibration operation starts
> +	 */
> +	nxp_sar_adc_calibration_start(info->regs);
> +
> +	ret = nxp_sar_adc_calibration_wait(info->regs);
> +
> +	/*
> +	 * Calibration works only if the adc is powered up. However
> +	 * the calibration is called from the probe function where the
> +	 * iio is not enabled, so we disable after the calibration
> +	 */
> +	nxp_sar_adc_disable(info);
> +
> +	return ret;
> +}

> +
> +static int sar_read_raw(struct iio_dev *indio_dev, struct iio_chan_spec const *chan,
> +			int *val, int *val2, long mask)
> +{
> +	struct nxp_sar_adc *info = iio_priv(indio_dev);
> +	u32 inpsamp;
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		if (!iio_device_claim_direct(indio_dev))
> +			return -EBUSY;
> +
> +		info->current_channel = chan->channel;
> +		nxp_sar_adc_channels_enable(info, BIT(chan->channel));
> +		nxp_sar_adc_irq_cfg(info, true);
> +		nxp_sar_adc_enable(info);
> +
> +		reinit_completion(&info->completion);
> +		ret = nxp_sar_adc_start_conversion(info, true);
> +		if (ret < 0)
> +			goto out_iio_chan_info_raw;
> +
> +		ret = wait_for_completion_interruptible_timeout
> +			(&info->completion,
> +			msecs_to_jiffies(NXP_SAR_ADC_CONV_TIMEOUT_MS));
> +
> +		nxp_sar_adc_channels_disable(info, BIT(chan->channel));
> +		nxp_sar_adc_irq_cfg(info, false);
> +		nxp_sar_adc_stop_conversion(info);
> +		nxp_sar_adc_disable(info);
> +
> +		if (ret == 0) {
> +			ret = -ETIMEDOUT;
> +			goto out_iio_chan_info_raw;

I'm not a bit fan of gotos within case statements as I find them hard
to read.  Please factor out the bit that does the work here so that
we can do direct returns in a new function and just call
iio_device_release_direct() before checking that return value.

> +		}
> +
> +		if (ret < 0)
> +			goto out_iio_chan_info_raw;
> +
> +		*val = info->value;
> +		ret = IIO_VAL_INT;
> +
> +out_iio_chan_info_raw:
> +		iio_device_release_direct(indio_dev);
> +		return ret;
> +
> +	case IIO_CHAN_INFO_SCALE:
> +		*val = info->vref_mV;
> +		*val2 = NXP_SAR_ADC_RESOLUTION;
> +		return IIO_VAL_FRACTIONAL_LOG2;
> +
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		inpsamp = nxp_sar_adc_conversion_timing_get(info);
> +		*val = clk_get_rate(info->clk) / (inpsamp + NXP_SAR_ADC_CONV_TIME);
> +		return IIO_VAL_INT;
> +
> +	default:
> +		break;

return -EINVAL here. and avoid breaks.


> +	}
> +
> +	return -EINVAL;
> +}

> +static void nxp_sar_adc_dma_cb(void *data)
> +{
> +	struct nxp_sar_adc *info = iio_priv((struct iio_dev *)data);

iio_priv(data)
is fine. void * casts don't need to be explicit (see the C spec for
more on that).

> +	struct iio_dev *indio_dev = data;
> +	struct dma_tx_state state;
> +	struct circ_buf *dma_buf;
> +	struct device *dev_dma;
> +	u32 *dma_samples;
> +	s64 timestamp;
> +	int idx, ret;
> +
> +	guard(spinlock_irqsave)(&info->lock);
> +
> +	dma_buf = &info->dma_buf;
> +	dma_samples = (u32 *)dma_buf->buf;
> +	dev_dma = info->dma_chan->device->dev;
> +
> +	dmaengine_tx_status(info->dma_chan, info->cookie, &state);
> +
> +	dma_sync_single_for_cpu(dev_dma, info->rx_dma_buf,
> +				NXP_SAR_ADC_DMA_BUFF_SZ, DMA_FROM_DEVICE);
> +	/* Current head position */
> +	dma_buf->head = (NXP_SAR_ADC_DMA_BUFF_SZ - state.residue) /
> +			NXP_SAR_ADC_DMA_SAMPLE_SZ;
> +
> +	/* If everything transferred, avoid an off by one error. */
> +	if (!state.residue)
> +		dma_buf->head--;
> +
> +	/* Something went wrong and nothing transferred. */
> +	if (state.residue == NXP_SAR_ADC_DMA_BUFF_SZ)
> +		goto out;
> +
> +	/* Make sure that head is multiple of info->channels_used */
> +	dma_buf->head -= dma_buf->head % info->channels_used;
> +
> +	/* dma_buf->tail != dma_buf->head condition will become false

	/*
 	 * dma_buf->tail ...

for consistency with IIO driver comments in general.


> +	 * because dma_buf->tail will be incremented with 1.
> +	 */
> +	while (dma_buf->tail != dma_buf->head) {
> +		idx = dma_buf->tail % info->channels_used;
> +		info->buffer[idx] = dma_samples[dma_buf->tail];
> +		dma_buf->tail = (dma_buf->tail + 1) % NXP_SAR_ADC_DMA_SAMPLE_CNT;
> +		if (idx != info->channels_used - 1)
> +			continue;
> +
> +		/* iio_push_to_buffers_with_timestamp should not be called

Same on multiline comment syntax.

> +		 * with dma_samples as parameter. The samples will be smashed
> +		 * if timestamp is enabled.

So, whilst not entirely there for this reason we do have:
iio_push_to_buffers_with_ts_unaligned()  which bounces the data on the
way to the buffer to avoid fiddly issues.  Perhaps doesn't have the most
helpful of names but the docs do refer to it not needing the extra space.

> +		 */
> +		timestamp = iio_get_time_ns(indio_dev);
> +		ret = iio_push_to_buffers_with_timestamp(indio_dev,

If possible use with_ts() variant.  It does some size santity checking.



> +							 info->buffer,
> +							 timestamp);
> +		if (ret < 0 && ret != -EBUSY)
> +			dev_err_ratelimited(&indio_dev->dev,
> +					    "failed to push iio buffer: %d",
> +					    ret);
> +	}
> +
> +	dma_buf->tail = dma_buf->head;
> +out:
> +	dma_sync_single_for_device(dev_dma, info->rx_dma_buf,
> +				   NXP_SAR_ADC_DMA_BUFF_SZ, DMA_FROM_DEVICE);
> +}

>
> +
> +static void __nxp_sar_adc_buffer_trigger_predisable(struct iio_dev *indio_dev)
Not sure the __ makes much sense here. Normally that indicates weird locking
rules or similar.  Maybe nxp_sar_adc_buffer_trigger_do_predisable() or something like that?
> +{
> +	struct nxp_sar_adc *info = iio_priv(indio_dev);
> +
> +	nxp_sar_adc_irq_cfg(info, false);
> +}
> +
> +static int __nxp_sar_adc_buffer_trigger_postenable(struct iio_dev *indio_dev)
> +{
> +	struct nxp_sar_adc *info = iio_priv(indio_dev);
> +
> +	nxp_sar_adc_irq_cfg(info, true);
> +
> +	return 0;
> +}
> +
> +static int nxp_sar_adc_buffer_postenable(struct iio_dev *indio_dev)
> +{
> +	struct nxp_sar_adc *info = iio_priv(indio_dev);
> +	int current_mode = iio_device_get_current_mode(indio_dev);
> +	unsigned long channel;
> +	int ret;
> +
> +	info->channels_used = 0;
> +
> +	/*
> +	 * The SAR-ADC has two groups of channels.
> +	 *
> +	 *	- Group #0:
> +	 *	* bit 0-7  : channel 0 -> channel 7
> +	 *	* bit 8-31 : reserved
> +	 *
> +	 *	- Group #32:
> +	 *	* bit 0-7  : Internal
> +	 *	* bit 8-31 : reserved
> +	 *
> +	 * The 8 channels from group #0 are used in this driver for
> +	 * ADC as described when declaring the IIO device and the
> +	 * mapping is the same. That means the active_scan_mask can be
> +	 * used directly to write the channel interrupt mask.
> +	 */
> +	nxp_sar_adc_channels_enable(info, *indio_dev->active_scan_mask);
> +
> +	for_each_set_bit(channel, indio_dev->active_scan_mask, NXP_SAR_ADC_NR_CHANNELS)
> +		info->buffered_chan[info->channels_used++] = channel;
> +
> +	nxp_sar_adc_enable(info);
> +
> +	if (current_mode == INDIO_BUFFER_SOFTWARE)
> +		ret = __nxp_sar_adc_buffer_software_postenable(indio_dev);
> +	else
> +		ret = __nxp_sar_adc_buffer_trigger_postenable(indio_dev);
> +	if (ret)
> +		goto out_postenable;
> +
> +	return 0;
> +
> +out_postenable:
> +	nxp_sar_adc_stop_conversion(info);
> +	nxp_sar_adc_disable(info);
> +	nxp_sar_adc_channels_disable(info, *indio_dev->active_scan_mask);
> +
> +	return ret;
> +}
> +
> +static int nxp_sar_adc_buffer_predisable(struct iio_dev *indio_dev)
> +{
> +	struct nxp_sar_adc *info = iio_priv(indio_dev);
> +	int currentmode = iio_device_get_current_mode(indio_dev);
> +
> +	nxp_sar_adc_stop_conversion(info);
There is an ordering difference here from what happens in the postenable
callback.  I'd normally expect to see this as an exact mirror.
If that is required, then please add some comments on why.  otherwise
move this stop_conversion after the predisable() calls.
> +
> +	if (currentmode == INDIO_BUFFER_SOFTWARE)
> +		__nxp_sar_adc_buffer_software_predisable(indio_dev);
> +	else
> +		__nxp_sar_adc_buffer_trigger_predisable(indio_dev);
> +
> +	nxp_sar_adc_channels_disable(info, *indio_dev->active_scan_mask);
> +	nxp_sar_adc_disable(info);
> +
> +	return 0;
> +}
> +
> +static irqreturn_t nxp_sar_adc_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct nxp_sar_adc *info = iio_priv(indio_dev);
> +	int ret;
> +
> +	ret = nxp_sar_adc_start_conversion(info, true);
> +	if (ret < 0)
> +		return IRQ_NONE;

Hmm. Fun corner.  If this hardware fails to respond to a trigger
interrupt (which may be a software faked thing anyway) that doesn't
mean there was no interrupt.  So I'd print a debug message and return
IRQ_HANDLED even on error.

> +
> +	return IRQ_HANDLED;
> +}

> +
> +static int nxp_sar_adc_dma_probe(struct device *dev, struct nxp_sar_adc *info)
> +{
> +	struct device *dev_dma;
> +	int ret;
> +	u8 *rx_buf;
> +
> +	info->dma_chan = devm_dma_request_chan(dev, "rx");
> +	if (IS_ERR(info->dma_chan))
> +		return PTR_ERR(info->dma_chan);
> +
> +	dev_dma = info->dma_chan->device->dev;
> +	rx_buf = dma_alloc_coherent(dev_dma, NXP_SAR_ADC_DMA_BUFF_SZ,
> +				    &info->rx_dma_buf, GFP_KERNEL);
> +	if (!rx_buf)
> +		return -ENOMEM;
> +
> +	info->dma_buf.buf = rx_buf;
> +
> +	info->dma_config.direction = DMA_DEV_TO_MEM;
> +	info->dma_config.src_addr_width = NXP_SAR_ADC_DMA_SAMPLE_SZ;
> +	info->dma_config.src_maxburst = 1;
> +
> +	ret = devm_add_action_or_reset(dev, nxp_sar_adc_dma_remove, info);
> +	if (ret)
> +		nxp_sar_adc_dma_remove(info);

Look again at what devm_add_action_or_reset() does on failure.
This has already been called. So 
	return devm_add_action_or_reset(dev, nxp_sar_adc_dma_remove, info);
should be fine.

> +
> +	return ret;
> +}
> +
> +/*
> + * The documentation describes the reset values for the
wrap consistently to 80 chars. This first line has ended up short enough
registers. fits.
> + * registers. However some registers do not have these values after a
> + * reset. It is a not desirable situation. In some other SoC family
> + * documentation NXP recommend to not assume the default values are
> + * set and to initialize the registers conforming to the documentation
> + * reset information to prevent this situation. Assume the same rule
> + * applies here as there is a discrepancy between what is read from
> + * the registers at reset time and the documentation.
> + */
> +static void nxp_sar_adc_set_default_values(struct nxp_sar_adc *info)
> +{
> +	writel(0x00003901, REG_ADC_MCR(info->regs));
> +	writel(0x00000001, REG_ADC_MSR(info->regs));
> +	writel(0x00000014, REG_ADC_CTR0(info->regs));
> +	writel(0x00000014, REG_ADC_CTR1(info->regs));
> +	writel(0x00000000, REG_ADC_CIMR0(info->regs));
> +	writel(0x00000000, REG_ADC_CIMR1(info->regs));
> +	writel(0x00000000, REG_ADC_NCMR0(info->regs));
> +	writel(0x00000000, REG_ADC_NCMR1(info->regs));
> +}
> +
> +static int nxp_sar_adc_probe(struct platform_device *pdev)
> +{
> +	const struct nxp_sar_adc_data *data;
> +	struct nxp_sar_adc *info;
> +	struct iio_dev *indio_dev;
> +	struct resource *mem;
> +	struct device *dev = &pdev->dev;
> +	int irq;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(struct nxp_sar_adc));

sizeof(*info) preferred given you then get it back via iio_priv() so it
is easier if a reader doesn't need to check the types match.

> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	info = iio_priv(indio_dev);
> +
> +	data = device_get_match_data(dev);
> +
> +	info->vref_mV = data->vref_mV;
> +
> +	info->regs = devm_platform_get_and_ioremap_resource(pdev, 0, &mem);
> +	if (IS_ERR(info->regs))
> +		return dev_err_probe(dev, PTR_ERR(info->regs),
> +				     "failed to get and remap resource");
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0)
> +		return irq;
> +
> +	ret = devm_request_irq(dev, irq, nxp_sar_adc_isr, 0,
> +			       dev_name(dev), indio_dev);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "failed requesting irq, irq = %d\n", irq);
> +
> +	info->regs_phys = mem->start;
> +	spin_lock_init(&info->lock);
> +
> +	info->clk = devm_clk_get_enabled(dev, "adc");
> +	if (IS_ERR(info->clk))
> +		return dev_err_probe(dev, PTR_ERR(info->clk),
> +				     "failed to get the clock\n");
> +
> +	platform_set_drvdata(pdev, indio_dev);
> +
> +	init_completion(&info->completion);
> +
> +	indio_dev->name = dev_name(dev);

This should be the 'part number'.  That is a little ill defined
for a SoC integrated ADC, but generally not what we get from dev_name()
on the platform_device.

> +	indio_dev->info = &nxp_sar_adc_iio_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_SOFTWARE;
> +	indio_dev->channels = nxp_sar_adc_iio_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(nxp_sar_adc_iio_channels);
> +
> +	nxp_sar_adc_set_default_values(info);
> +
> +	ret = nxp_sar_adc_calibration(info);
> +	if (ret) {
> +		dev_err(dev, "Calibration failed: %d\n", ret);
> +		return ret;
		return dev_err_probe(dev, ret, "Calibration failed\n");

Whilst we don't get the deferred probe debugging in this case the dev_err_probe()
does some pretty printing and saves a few lines of code, so it is fine to
use it everywhere in probe() or code just called from probe()

> +	}
> +
> +	ret = nxp_sar_adc_dma_probe(dev, info);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to initialize the dma\n");
> +
> +	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
> +					      &iio_pollfunc_store_time,
> +					      &nxp_sar_adc_trigger_handler,
> +					      &iio_triggered_buffer_setup_ops);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "Couldn't initialise the buffer\n");
> +
> +	ret = devm_iio_device_register(dev, indio_dev);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Couldn't register the device\n");
> +
> +	return 0;
> +}
> +
> +static void nxp_sar_adc_remove(struct platform_device *pdev)
> +{
> +	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
> +	struct nxp_sar_adc *info = iio_priv(indio_dev);
> +
> +	nxp_sar_adc_stop_conversion(info);
> +	nxp_sar_adc_channels_disable(info, REG_ADC_CH_MASK);
> +	nxp_sar_adc_dma_channels_disable(info, REG_ADC_CH_MASK);
> +	nxp_sar_adc_dma_cfg(info, false);
> +	nxp_sar_adc_disable(info);
> +	dmaengine_terminate_sync(info->dma_chan);
> +}

> +
> +static struct platform_driver nxp_sar_adc_driver = {
> +	.probe          = nxp_sar_adc_probe,
Completely trivial feedback.

I'd not do this aligning as to my eyes having the nested = under
the other ones is actively misleading.  A single space the = is
to me easier to read and less likely to lead to churn in the long
run.  I don't mind careful alignment for closely related values
like lists of register addresses but don't see a strong advantage
to doing it here.


> +	.remove         = nxp_sar_adc_remove,
> +	.driver         = {
> +		.name   = DRIVER_NAME,

This pattern is one of those things that is completely trivial but
makes no sense to me. I'd rather see the string directly here.

> +		.of_match_table = nxp_sar_adc_match,
> +		.pm     = pm_ptr(&nxp_sar_adc_pm_ops),
> +	},
> +};
> +module_platform_driver(nxp_sar_adc_driver);
> +
> +MODULE_AUTHOR("NXP");
> +MODULE_DESCRIPTION("NXP SAR-ADC driver");
> +MODULE_LICENSE("GPL");


