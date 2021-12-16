Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2AFA47781D
	for <lists+linux-iio@lfdr.de>; Thu, 16 Dec 2021 17:18:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239453AbhLPQSR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 16 Dec 2021 11:18:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239477AbhLPQSP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 Dec 2021 11:18:15 -0500
Received: from balrog.mythic-beasts.com (balrog.mythic-beasts.com [IPv6:2a00:1098:0:82:1000:0:2:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55E2DC06175D;
        Thu, 16 Dec 2021 08:18:14 -0800 (PST)
Received: from [81.101.6.87] (port=48034 helo=jic23-huawei)
        by balrog.mythic-beasts.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <jic23@jic23.retrosnub.co.uk>)
        id 1mxtSG-0007hN-HJ; Thu, 16 Dec 2021 16:18:08 +0000
Date:   Thu, 16 Dec 2021 16:23:27 +0000
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     robh+dt@kernel.org, lars@metafoo.de, swboyd@chromium.org,
        andy.shevchenko@gmail.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 4/4] iio: sx9360: Add dt-binding support
Message-ID: <20211216162318.65247294@jic23-huawei>
In-Reply-To: <20211213024057.3824985-5-gwendal@chromium.org>
References: <20211213024057.3824985-1-gwendal@chromium.org>
        <20211213024057.3824985-5-gwendal@chromium.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BlackCat-Spam-Score: 4
X-Spam-Status: No, score=0.4
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 12 Dec 2021 18:40:57 -0800
Gwendal Grignou <gwendal@chromium.org> wrote:

> Add support to configure sx9360 from dt-binding, to match device
> hardware setup.
> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
This and patch 3 look fine to me, so mostly just a question of
modifier vs label for the reference channel.

Thanks,

Jonathan


> ---
> Changes since v2:
> - Add include when needed.
> - Move default register constant to main patch.
> 
> No changes in v2.
> 
>  drivers/iio/proximity/sx9360.c | 85 +++++++++++++++++++++++++++++++++-
>  1 file changed, 84 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/proximity/sx9360.c b/drivers/iio/proximity/sx9360.c
> index aebfbe541e0e04..30cc6549d301e6 100644
> --- a/drivers/iio/proximity/sx9360.c
> +++ b/drivers/iio/proximity/sx9360.c
> @@ -18,6 +18,7 @@
>  #include <linux/mod_devicetable.h>
>  #include <linux/module.h>
>  #include <linux/pm.h>
> +#include <linux/property.h>
>  #include <linux/regmap.h>
>  
>  #include <linux/iio/iio.h>
> @@ -64,6 +65,7 @@
>  #define SX9360_REG_PROX_CTRL0_PHM	0x41
>  #define SX9360_REG_PROX_CTRL0_GAIN_MASK	GENMASK(5, 3)
>  #define SX9360_REG_PROX_CTRL0_GAIN_1		0x80
> +#define SX9360_REG_PROX_CTRL0_RAWFILT_MASK	GENMASK(2, 0)
>  #define SX9360_REG_PROX_CTRL0_RAWFILT_1P50	0x01
>  #define SX9360_REG_PROX_CTRL1		0x42
>  #define SX9360_REG_PROX_CTRL1_AVGNEG_THRESH_MASK	GENMASK(5, 3)
> @@ -647,6 +649,41 @@ static int sx9360_write_raw(struct iio_dev *indio_dev,
>  	return -EINVAL;
>  }
>  
> +static const struct sx_common_reg_default sx9360_default_regs[] = {
> +	{ SX9360_REG_IRQ_MSK, 0x00 },
> +	{ SX9360_REG_IRQ_CFG, 0x00 },
> +	/*
> +	 * The lower 2 bits should not be set as it enable sensors measurements.
> +	 * Turning the detection on before the configuration values are set to
> +	 * good values can cause the device to return erroneous readings.
> +	 */
> +	{ SX9360_REG_GNRL_CTRL0, 0x00 },
> +	{ SX9360_REG_GNRL_CTRL1, 0x00 },
> +	{ SX9360_REG_GNRL_CTRL2, SX9360_REG_GNRL_CTRL2_PERIOD_102MS },
> +
> +	{ SX9360_REG_AFE_CTRL1, 0x00 },
> +	{ SX9360_REG_AFE_PARAM0_PHR, SX9360_REG_AFE_PARAM0_RSVD |
> +		SX9360_REG_AFE_PARAM0_RESOLUTION_128 },
> +	{ SX9360_REG_AFE_PARAM1_PHR, SX9360_REG_AFE_PARAM1_AGAIN_PHM_6PF |
> +		SX9360_REG_AFE_PARAM1_FREQ_83_33HZ },
> +	{ SX9360_REG_AFE_PARAM0_PHM, SX9360_REG_AFE_PARAM0_RSVD |
> +		SX9360_REG_AFE_PARAM0_RESOLUTION_128 },
> +	{ SX9360_REG_AFE_PARAM1_PHM, SX9360_REG_AFE_PARAM1_AGAIN_PHM_6PF |
> +		SX9360_REG_AFE_PARAM1_FREQ_83_33HZ },
> +
> +	{ SX9360_REG_PROX_CTRL0_PHR, SX9360_REG_PROX_CTRL0_GAIN_1 |
> +		SX9360_REG_PROX_CTRL0_RAWFILT_1P50 },
> +	{ SX9360_REG_PROX_CTRL0_PHM, SX9360_REG_PROX_CTRL0_GAIN_1 |
> +		SX9360_REG_PROX_CTRL0_RAWFILT_1P50 },
> +	{ SX9360_REG_PROX_CTRL1, SX9360_REG_PROX_CTRL1_AVGNEG_THRESH_16K },
> +	{ SX9360_REG_PROX_CTRL2, SX9360_REG_PROX_CTRL2_AVGDEB_2SAMPLES |
> +		SX9360_REG_PROX_CTRL2_AVGPOS_THRESH_16K },
> +	{ SX9360_REG_PROX_CTRL3, SX9360_REG_PROX_CTRL3_AVGNEG_FILT_2 |
> +		SX9360_REG_PROX_CTRL3_AVGPOS_FILT_256 },
> +	{ SX9360_REG_PROX_CTRL4, 0x00 },
> +	{ SX9360_REG_PROX_CTRL5, SX9360_REG_PROX_CTRL5_PROXTHRESH_32 },
> +};
> +
>  /* Activate all channels and perform an initial compensation. */
>  static int sx9360_init_compensation(struct iio_dev *indio_dev)
>  {
> @@ -671,6 +708,51 @@ static int sx9360_init_compensation(struct iio_dev *indio_dev)
>  	return ret;
>  }
>  
> +static const struct sx_common_reg_default *
> +sx9360_get_default_reg(struct device *dev, int idx,
> +		       struct sx_common_reg_default *reg_def)
> +{
> +	u32 raw = 0, pos = 0;
> +	int ret;
> +
> +	memcpy(reg_def, &sx9360_default_regs[idx], sizeof(*reg_def));
> +	switch (reg_def->reg) {
> +	case SX9360_REG_AFE_PARAM0_PHR:
> +	case SX9360_REG_AFE_PARAM0_PHM:
> +		ret = device_property_read_u32(dev, "semtech,resolution", &raw);
> +		if (ret)
> +			break;
> +
> +		raw = ilog2(raw) - 3;
> +
> +		reg_def->def &= ~SX9360_REG_AFE_PARAM0_RESOLUTION_MASK;
> +		reg_def->def |= FIELD_PREP(SX9360_REG_AFE_PARAM0_RESOLUTION_MASK, raw);
> +		break;
> +	case SX9360_REG_PROX_CTRL0_PHR:
> +	case SX9360_REG_PROX_CTRL0_PHM:
> +		ret = device_property_read_u32(dev, "semtech,proxraw-strength", &raw);
> +		if (ret)
> +			break;
> +
> +		reg_def->def &= ~SX9360_REG_PROX_CTRL0_RAWFILT_MASK;
> +		reg_def->def |= FIELD_PREP(SX9360_REG_PROX_CTRL0_RAWFILT_MASK, raw);
> +		break;
> +	case SX9360_REG_PROX_CTRL3:
> +		ret = device_property_read_u32(dev, "semtech,avg-pos-strength",
> +					       &pos);
> +		if (ret)
> +			break;
> +
> +		/* Powers of 2, except for a gap between 16 and 64 */
> +		raw = clamp(ilog2(pos), 3, 11) - (pos >= 32 ? 4 : 3);
> +		reg_def->def &= ~SX9360_REG_PROX_CTRL3_AVGPOS_FILT_MASK;
> +		reg_def->def |= FIELD_PREP(SX9360_REG_PROX_CTRL3_AVGPOS_FILT_MASK, raw);
> +		break;
> +	}
> +
> +	return reg_def;
> +}
> +
>  static int sx9360_check_whoami(struct device *dev,
>  			       struct iio_dev *indio_dev)
>  {
> @@ -691,12 +773,14 @@ static const struct sx_common_chip_info sx9360_chip_info = {
>  	.mask_enable_chan = SX9360_REG_GNRL_CTRL0_PHEN_MASK,
>  	.stat_offset = 3,
>  	.num_channels = SX9360_NUM_CHANNELS,
> +	.num_default_regs = ARRAY_SIZE(sx9360_default_regs),
>  
>  	.ops = {
>  		.read_prox_data = sx9360_read_prox_data,
>  		.check_whoami = sx9360_check_whoami,
>  		.init_compensation = sx9360_init_compensation,
>  		.wait_for_sample = sx9360_wait_for_sample,
> +		.get_default_reg = sx9360_get_default_reg,
>  	},
>  
>  	.iio_channels = sx9360_channels,

