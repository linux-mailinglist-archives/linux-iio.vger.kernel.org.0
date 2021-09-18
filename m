Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F674410789
	for <lists+linux-iio@lfdr.de>; Sat, 18 Sep 2021 18:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234627AbhIRQNj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Sep 2021 12:13:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:49068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231415AbhIRQNj (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 Sep 2021 12:13:39 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3BA8E6104F;
        Sat, 18 Sep 2021 16:12:09 +0000 (UTC)
Date:   Sat, 18 Sep 2021 17:15:49 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, bcousson@baylibre.com,
        Tony Lindgren <tony@atomide.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-omap@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Ryan Barnett <ryan.barnett@collins.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Jason Reeder <jreeder@ti.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v3 26/47] mfd: ti_am335x_tscadc: Use BIT(), GENMASK()
 and FIELD_PREP() when relevant
Message-ID: <20210918171549.4b08579a@jic23-huawei>
In-Reply-To: <20210915155908.476767-27-miquel.raynal@bootlin.com>
References: <20210915155908.476767-1-miquel.raynal@bootlin.com>
        <20210915155908.476767-27-miquel.raynal@bootlin.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 15 Sep 2021 17:58:47 +0200
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> Clean the ti_am335x_tscadc.h header by:
> * converting masks to GENMASK()
> * converting regular shifts to BIT()
> * using FIELD_PREP() when relevant
> 
> Sometimes reorder the lines to be able to use the relevant bitmask.
> 
> Mind the s/%d/%ld/ change in a log due to the type change following the
> use of FIELD_PREP() in the header.
> 
> Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Looks good as an independent patch. However,a comment inline that it would
have been simpler / better to move the patch dropping definitions before this
one as then you would have less to rework.

That's particularly true of the ENB() definition which you change twice
before then dropping it entirely.

Anyhow, either as is (if Lee doesn't mind), or with whatever is left after
doing those drops earlier

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


> ---
>  drivers/iio/adc/ti_am335x_adc.c      |  2 +-
>  include/linux/mfd/ti_am335x_tscadc.h | 71 ++++++++++++++--------------
>  2 files changed, 37 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
> index 855cc2d64ac8..3dec115e68ee 100644
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
> index d98ec8937dd9..e6fe623bb1aa 100644
> --- a/include/linux/mfd/ti_am335x_tscadc.h
> +++ b/include/linux/mfd/ti_am335x_tscadc.h
> @@ -8,6 +8,7 @@
>  #ifndef __LINUX_TI_AM335X_TSCADC_MFD_H
>  #define __LINUX_TI_AM335X_TSCADC_MFD_H
>  
> +#include <linux/bitfield.h>
>  #include <linux/mfd/core.h>
>  #include <linux/units.h>
>  
> @@ -40,11 +41,11 @@
>  #define IRQWKUP_ENB		BIT(0)
>  
>  /* Step Enable */
> -#define STEPENB_MASK		(0x1FFFF << 0)
> -#define STEPENB(val)		((val) << 0)
> -#define ENB(val)		(1 << (val))
> -#define STPENB_STEPENB		STEPENB(0x1FFFF)
> -#define STPENB_STEPENB_TC	STEPENB(0x1FFF)
> +#define STEPENB_MASK		GENMASK(16, 0)
> +#define STEPENB(val)		FIELD_PREP(STEPENB_MASK, (val))
> +#define ENB(val)		BIT(val)
> +#define STPENB_STEPENB		STEPENB(GENMASK(16, 0))
> +#define STPENB_STEPENB_TC	STEPENB(GENMASK(12, 0))

This particular block seems a bit odd so I went to try and understand how it is used.
It isn't...  And you drop it in a later patch.

It's not very important but if you are going to drop code do it before any of it
is touched in a series as cuts down on the amount reviewers need to look at!

>  
>  /* IRQ enable */
>  #define IRQENB_HW_PEN		BIT(0)
> @@ -58,12 +59,12 @@
>  #define IRQENB_PENUP		BIT(9)
>  
>  /* Step Configuration */
> -#define STEPCONFIG_MODE_MASK	(3 << 0)
> -#define STEPCONFIG_MODE(val)	((val) << 0)
> +#define STEPCONFIG_MODE_MASK	GENMASK(1, 0)
> +#define STEPCONFIG_MODE(val)	FIELD_PREP(STEPCONFIG_MODE_MASK, (val))
>  #define STEPCONFIG_MODE_SWCNT	STEPCONFIG_MODE(1)
>  #define STEPCONFIG_MODE_HWSYNC	STEPCONFIG_MODE(2)
> -#define STEPCONFIG_AVG_MASK	(7 << 2)
> -#define STEPCONFIG_AVG(val)	((val) << 2)
> +#define STEPCONFIG_AVG_MASK	GENMASK(4, 2)
> +#define STEPCONFIG_AVG(val)	FIELD_PREP(STEPCONFIG_AVG_MASK, (val))
>  #define STEPCONFIG_AVG_16	STEPCONFIG_AVG(4)
>  #define STEPCONFIG_XPP		BIT(5)
>  #define STEPCONFIG_XNN		BIT(6)
> @@ -71,43 +72,43 @@
>  #define STEPCONFIG_YNN		BIT(8)
>  #define STEPCONFIG_XNP		BIT(9)
>  #define STEPCONFIG_YPN		BIT(10)
> -#define STEPCONFIG_RFP(val)	((val) << 12)
> -#define STEPCONFIG_RFP_VREFP	(0x3 << 12)
> -#define STEPCONFIG_INM_MASK	(0xF << 15)
> -#define STEPCONFIG_INM(val)	((val) << 15)
> +#define STEPCONFIG_RFP_VREFP	GENMASK(13, 12)
> +#define STEPCONFIG_RFP(val)	FIELD_PREP(STEPCONFIG_RFP_VREFP, (val))
> +#define STEPCONFIG_INM_MASK	GENMASK(18, 15)
> +#define STEPCONFIG_INM(val)	FIELD_PREP(STEPCONFIG_INM_MASK, (val))
>  #define STEPCONFIG_INM_ADCREFM	STEPCONFIG_INM(8)
> -#define STEPCONFIG_INP_MASK	(0xF << 19)
> -#define STEPCONFIG_INP(val)	((val) << 19)
> +#define STEPCONFIG_INP_MASK	GENMASK(22, 19)
> +#define STEPCONFIG_INP(val)	FIELD_PREP(STEPCONFIG_INP_MASK, (val))
>  #define STEPCONFIG_INP_AN4	STEPCONFIG_INP(4)
>  #define STEPCONFIG_INP_ADCREFM	STEPCONFIG_INP(8)
>  #define STEPCONFIG_FIFO1	BIT(26)
> -#define STEPCONFIG_RFM(val)	((val) << 23)
> -#define STEPCONFIG_RFM_VREFN	(0x3 << 23)
> +#define STEPCONFIG_RFM_VREFN	GENMASK(24, 23)
> +#define STEPCONFIG_RFM(val)	FIELD_PREP(STEPCONFIG_RFM_VREFN, (val))
>  
>  /* Delay register */
> -#define STEPDELAY_OPEN_MASK	(0x3FFFF << 0)
> -#define STEPDELAY_OPEN(val)	((val) << 0)
> +#define STEPDELAY_OPEN_MASK	GENMASK(17, 0)
> +#define STEPDELAY_OPEN(val)	FIELD_PREP(STEPDELAY_OPEN_MASK, (val))
>  #define STEPCONFIG_OPENDLY	STEPDELAY_OPEN(0x098)
> -#define STEPDELAY_SAMPLE_MASK	(0xFF << 24)
> -#define STEPDELAY_SAMPLE(val)	((val) << 24)
> +#define STEPDELAY_SAMPLE_MASK	GENMASK(31, 24)
> +#define STEPDELAY_SAMPLE(val)	FIELD_PREP(STEPDELAY_SAMPLE_MASK, (val))
>  #define STEPCONFIG_SAMPLEDLY	STEPDELAY_SAMPLE(0)
>  
>  /* Charge Config */
> -#define STEPCHARGE_RFP_MASK	(7 << 12)
> -#define STEPCHARGE_RFP(val)	((val) << 12)
> +#define STEPCHARGE_RFP_MASK	GENMASK(14, 12)
> +#define STEPCHARGE_RFP(val)	FIELD_PREP(STEPCHARGE_RFP_MASK, (val))
>  #define STEPCHARGE_RFP_XPUL	STEPCHARGE_RFP(1)
> -#define STEPCHARGE_INM_MASK	(0xF << 15)
> -#define STEPCHARGE_INM(val)	((val) << 15)
> +#define STEPCHARGE_INM_MASK	GENMASK(18, 15)
> +#define STEPCHARGE_INM(val)	FIELD_PREP(STEPCHARGE_INM_MASK, (val))
>  #define STEPCHARGE_INM_AN1	STEPCHARGE_INM(1)
> -#define STEPCHARGE_INP_MASK	(0xF << 19)
> -#define STEPCHARGE_INP(val)	((val) << 19)
> -#define STEPCHARGE_RFM_MASK	(3 << 23)
> -#define STEPCHARGE_RFM(val)	((val) << 23)
> +#define STEPCHARGE_INP_MASK	GENMASK(22, 19)
> +#define STEPCHARGE_INP(val)	FIELD_PREP(STEPCHARGE_INP_MASK, (val))
> +#define STEPCHARGE_RFM_MASK	GENMASK(24, 23)
> +#define STEPCHARGE_RFM(val)	FIELD_PREP(STEPCHARGE_RFM_MASK, (val))
>  #define STEPCHARGE_RFM_XNUR	STEPCHARGE_RFM(1)
>  
>  /* Charge delay */
> -#define CHARGEDLY_OPEN_MASK	(0x3FFFF << 0)
> -#define CHARGEDLY_OPEN(val)	((val) << 0)
> +#define CHARGEDLY_OPEN_MASK	GENMASK(17, 0)
> +#define CHARGEDLY_OPEN(val)	FIELD_PREP(CHARGEDLY_OPEN_MASK, (val))
>  #define CHARGEDLY_OPENDLY	CHARGEDLY_OPEN(0x400)
>  
>  /* Control register */
> @@ -115,16 +116,16 @@
>  #define CNTRLREG_STEPID		BIT(1)
>  #define CNTRLREG_STEPCONFIGWRT	BIT(2)
>  #define CNTRLREG_POWERDOWN	BIT(4)
> -#define CNTRLREG_AFE_CTRL_MASK	(3 << 5)
> -#define CNTRLREG_AFE_CTRL(val)	((val) << 5)
> +#define CNTRLREG_AFE_CTRL_MASK	GENMASK(6, 5)
> +#define CNTRLREG_AFE_CTRL(val)	FIELD_PREP(CNTRLREG_AFE_CTRL_MASK, (val))
>  #define CNTRLREG_4WIRE		CNTRLREG_AFE_CTRL(1)
>  #define CNTRLREG_5WIRE		CNTRLREG_AFE_CTRL(2)
>  #define CNTRLREG_8WIRE		CNTRLREG_AFE_CTRL(3)
>  #define CNTRLREG_TSCENB		BIT(7)
>  
>  /* FIFO READ Register */
> -#define FIFOREAD_DATA_MASK	(0xfff << 0)
> -#define FIFOREAD_CHNLID_MASK	(0xf << 16)
> +#define FIFOREAD_DATA_MASK	GENMASK(11, 0)
> +#define FIFOREAD_CHNLID_MASK	GENMASK(19, 16)
>  
>  /* DMA ENABLE/CLEAR Register */
>  #define DMA_FIFO0		BIT(0)

