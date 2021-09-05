Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 153FF400FD2
	for <lists+linux-iio@lfdr.de>; Sun,  5 Sep 2021 15:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237898AbhIENLW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Sep 2021 09:11:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:36030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237863AbhIENLU (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 5 Sep 2021 09:11:20 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A52160F45;
        Sun,  5 Sep 2021 13:10:10 +0000 (UTC)
Date:   Sun, 5 Sep 2021 14:13:32 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, bcousson@baylibre.com,
        Tony Lindgren <tony@atomide.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-omap@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Ryan Barnett <ryan.barnett@collins.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Jason Reeder <jreeder@ti.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 26/46] mfd: ti_am335x_tscadc: Use FIELD_PREP() when
 relevant in the header
Message-ID: <20210905141332.26788852@jic23-huawei>
In-Reply-To: <20210902215144.507243-27-miquel.raynal@bootlin.com>
References: <20210902215144.507243-1-miquel.raynal@bootlin.com>
        <20210902215144.507243-27-miquel.raynal@bootlin.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu,  2 Sep 2021 23:51:24 +0200
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> Use the FIELD_PREP() macro when relevant. Sometimes reorder the lines to
> be able to use the relevant bitmask.
> 
> Mind the s/%d/%ld/ change in a log due to the type change following the
> use of FIELD_PREP() in the header.
> 
> Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
What you have here is fine, but I would take it a step further and push the
FIELD_PREP() calls directly inline in the code.  There is little advantage
beyond saving a few characters in

STEPENB(3)

rather than

FIELD_PREP(STEPENB_MASK, 3)

If you don't want to go that far this is still an improvement so
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/iio/adc/ti_am335x_adc.c      |  2 +-
>  include/linux/mfd/ti_am335x_tscadc.h | 31 ++++++++++++++--------------
>  2 files changed, 17 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
> index e946903b0993..54c410b6ca07 100644
> --- a/drivers/iio/adc/ti_am335x_adc.c
> +++ b/drivers/iio/adc/ti_am335x_adc.c
> @@ -126,7 +126,7 @@ static void tiadc_step_config(struct iio_dev *indio_dev)
>  		chan = adc_dev->channel_line[i];
>  
>  		if (adc_dev->step_avg[i] > STEPCONFIG_AVG_16) {
> -			dev_warn(dev, "chan %d step_avg truncating to %d\n",
> +			dev_warn(dev, "chan %d step_avg truncating to %ld\n",
>  				 chan, STEPCONFIG_AVG_16);
>  			adc_dev->step_avg[i] = STEPCONFIG_AVG_16;
>  		}
> diff --git a/include/linux/mfd/ti_am335x_tscadc.h b/include/linux/mfd/ti_am335x_tscadc.h
> index 4de16fc3d74f..29095c0dc6d8 100644
> --- a/include/linux/mfd/ti_am335x_tscadc.h
> +++ b/include/linux/mfd/ti_am335x_tscadc.h
> @@ -8,6 +8,7 @@
>  #ifndef __LINUX_TI_AM335X_TSCADC_MFD_H
>  #define __LINUX_TI_AM335X_TSCADC_MFD_H
>  
> +#include <linux/bitfield.h>
>  #include <linux/mfd/core.h>
>  
>  #define REG_RAWIRQSTATUS	0x024
> @@ -40,7 +41,7 @@
>  
>  /* Step Enable */
>  #define STEPENB_MASK		GENMASK(16, 0)
> -#define STEPENB(val)		((val) << 0)
> +#define STEPENB(val)		FIELD_PREP(STEPENB_MASK, (val))

My inclination with these is to drop the macro entirely and
just use FIELD_PREP(STEPENB_MASK, xxx) inline directly.
There is no loss of clarity in doing so and it gets you to a state
where you only have one macro per field which is nice for checking
purposes.

>  #define ENB(val)		BIT(val)
>  #define STPENB_STEPENB		STEPENB(GENMASK(16, 0))
>  #define STPENB_STEPENB_TC	STEPENB(GENMASK(12, 0))
> @@ -58,11 +59,11 @@
>  
>  /* Step Configuration */
>  #define STEPCONFIG_MODE_MASK	GENMASK(1, 0)
> -#define STEPCONFIG_MODE(val)	((val) << 0)
> +#define STEPCONFIG_MODE(val)	FIELD_PREP(STEPCONFIG_MODE_MASK, (val))
>  #define STEPCONFIG_MODE_SWCNT	STEPCONFIG_MODE(1)
>  #define STEPCONFIG_MODE_HWSYNC	STEPCONFIG_MODE(2)
>  #define STEPCONFIG_AVG_MASK	GENMASK(4, 2)
> -#define STEPCONFIG_AVG(val)	((val) << 2)
> +#define STEPCONFIG_AVG(val)	FIELD_PREP(STEPCONFIG_AVG_MASK, (val))
>  #define STEPCONFIG_AVG_16	STEPCONFIG_AVG(4)
>  #define STEPCONFIG_XPP		BIT(5)
>  #define STEPCONFIG_XNN		BIT(6)
> @@ -70,43 +71,43 @@
>  #define STEPCONFIG_YNN		BIT(8)
>  #define STEPCONFIG_XNP		BIT(9)
>  #define STEPCONFIG_YPN		BIT(10)
> -#define STEPCONFIG_RFP(val)	((val) << 12)
>  #define STEPCONFIG_RFP_VREFP	GENMASK(13, 12)
> +#define STEPCONFIG_RFP(val)	FIELD_PREP(STEPCONFIG_RFP_VREFP, (val))
>  #define STEPCONFIG_INM_MASK	GENMASK(18, 15)
> -#define STEPCONFIG_INM(val)	((val) << 15)
> +#define STEPCONFIG_INM(val)	FIELD_PREP(STEPCONFIG_INM_MASK, (val))
>  #define STEPCONFIG_INM_ADCREFM	STEPCONFIG_INM(8)
>  #define STEPCONFIG_INP_MASK	GENMASK(22, 19)
> -#define STEPCONFIG_INP(val)	((val) << 19)
> +#define STEPCONFIG_INP(val)	FIELD_PREP(STEPCONFIG_INP_MASK, (val))
>  #define STEPCONFIG_INP_AN4	STEPCONFIG_INP(4)
>  #define STEPCONFIG_INP_ADCREFM	STEPCONFIG_INP(8)
>  #define STEPCONFIG_FIFO1	BIT(26)
> -#define STEPCONFIG_RFM(val)	((val) << 23)
>  #define STEPCONFIG_RFM_VREFN	GENMASK(24, 23)
> +#define STEPCONFIG_RFM(val)	FIELD_PREP(STEPCONFIG_RFM_VREFN, (val))
>  
>  /* Delay register */
>  #define STEPDELAY_OPEN_MASK	GENMASK(17, 0)
> -#define STEPDELAY_OPEN(val)	((val) << 0)
> +#define STEPDELAY_OPEN(val)	FIELD_PREP(STEPDELAY_OPEN_MASK, (val))
>  #define STEPCONFIG_OPENDLY	STEPDELAY_OPEN(0x098)
>  #define STEPDELAY_SAMPLE_MASK	GENMASK(31, 24)
> -#define STEPDELAY_SAMPLE(val)	((val) << 24)
> +#define STEPDELAY_SAMPLE(val)	FIELD_PREP(STEPDELAY_SAMPLE_MASK, (val))
>  #define STEPCONFIG_SAMPLEDLY	STEPDELAY_SAMPLE(0)
>  
>  /* Charge Config */
>  #define STEPCHARGE_RFP_MASK	GENMASK(14, 12)
> -#define STEPCHARGE_RFP(val)	((val) << 12)
> +#define STEPCHARGE_RFP(val)	FIELD_PREP(STEPCHARGE_RFP_MASK, (val))
>  #define STEPCHARGE_RFP_XPUL	STEPCHARGE_RFP(1)
>  #define STEPCHARGE_INM_MASK	GENMASK(18, 15)
> -#define STEPCHARGE_INM(val)	((val) << 15)
> +#define STEPCHARGE_INM(val)	FIELD_PREP(STEPCHARGE_INM_MASK, (val))
>  #define STEPCHARGE_INM_AN1	STEPCHARGE_INM(1)
>  #define STEPCHARGE_INP_MASK	GENMASK(22, 19)
> -#define STEPCHARGE_INP(val)	((val) << 19)
> +#define STEPCHARGE_INP(val)	FIELD_PREP(STEPCHARGE_INP_MASK, (val))
>  #define STEPCHARGE_RFM_MASK	GENMASK(24, 23)
> -#define STEPCHARGE_RFM(val)	((val) << 23)
> +#define STEPCHARGE_RFM(val)	FIELD_PREP(STEPCHARGE_RFM_MASK, (val))
>  #define STEPCHARGE_RFM_XNUR	STEPCHARGE_RFM(1)
>  
>  /* Charge delay */
>  #define CHARGEDLY_OPEN_MASK	GENMASK(17, 0)
> -#define CHARGEDLY_OPEN(val)	((val) << 0)
> +#define CHARGEDLY_OPEN(val)	FIELD_PREP(CHARGEDLY_OPEN_MASK, (val))
>  #define CHARGEDLY_OPENDLY	CHARGEDLY_OPEN(0x400)
>  
>  /* Control register */
> @@ -115,7 +116,7 @@
>  #define CNTRLREG_STEPCONFIGWRT	BIT(2)
>  #define CNTRLREG_POWERDOWN	BIT(4)
>  #define CNTRLREG_AFE_CTRL_MASK	GENMASK(6, 5)
> -#define CNTRLREG_AFE_CTRL(val)	((val) << 5)
> +#define CNTRLREG_AFE_CTRL(val)	FIELD_PREP(CNTRLREG_AFE_CTRL_MASK, (val))
>  #define CNTRLREG_4WIRE		CNTRLREG_AFE_CTRL(1)
>  #define CNTRLREG_5WIRE		CNTRLREG_AFE_CTRL(2)
>  #define CNTRLREG_8WIRE		CNTRLREG_AFE_CTRL(3)

