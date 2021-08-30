Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 371993FB5E7
	for <lists+linux-iio@lfdr.de>; Mon, 30 Aug 2021 14:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233621AbhH3MUd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Aug 2021 08:20:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:51556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237375AbhH3MTj (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 30 Aug 2021 08:19:39 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D77EB610FB;
        Mon, 30 Aug 2021 12:18:42 +0000 (UTC)
Date:   Mon, 30 Aug 2021 13:21:53 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Eugen Hristev <eugen.hristev@microchip.com>
Cc:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <nicolas.ferre@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <ludovic.desroches@microchip.com>
Subject: Re: [PATCH v2 04/10] iio: adc: at91-sama5d2_adc: convert to
 platform specific data structures
Message-ID: <20210830132153.78f8dac5@jic23-huawei>
In-Reply-To: <20210824115441.681253-5-eugen.hristev@microchip.com>
References: <20210824115441.681253-1-eugen.hristev@microchip.com>
        <20210824115441.681253-5-eugen.hristev@microchip.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 24 Aug 2021 14:54:35 +0300
Eugen Hristev <eugen.hristev@microchip.com> wrote:

> Convert the driver to platform specific structures. This means:
> - create a register layout struct that will hold offsets for registers
> - create a platform struct that will hold platform information (number of
> channels, indexes for different channels and pointer to layout struct)
> - convert specific macros that are platform dependent into platform variables
> 
> This step is in fact a no-op, but allows the driver to be more flexible
> and for future enhancement including adding new platforms that are partly
> compatible with the current driver and differ slightly in register layout
> or capabilities for example.
> 
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> ---
>  drivers/iio/adc/at91-sama5d2_adc.c | 410 +++++++++++++++++------------
>  1 file changed, 247 insertions(+), 163 deletions(-)
> 
> diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
> index 9d71dcffcf93..8ede18b8d789 100644
> --- a/drivers/iio/adc/at91-sama5d2_adc.c
> +++ b/drivers/iio/adc/at91-sama5d2_adc.c
> @@ -27,8 +27,9 @@
>  #include <linux/pinctrl/consumer.h>
>  #include <linux/regulator/consumer.h>
>  
> +struct at91_adc_reg_layout {
>  /* Control Register */
> -#define AT91_SAMA5D2_CR		0x00
> +	u16				CR;
>  /* Software Reset */
>  #define	AT91_SAMA5D2_CR_SWRST		BIT(0)
>  /* Start Conversion */
> @@ -39,7 +40,7 @@
>  #define	AT91_SAMA5D2_CR_CMPRST		BIT(4)
>  
>  /* Mode Register */
> -#define AT91_SAMA5D2_MR		0x04
> +	u16				MR;
>  /* Trigger Selection */
>  #define	AT91_SAMA5D2_MR_TRGSEL(v)	((v) << 1)
>  /* ADTRG */
> @@ -82,19 +83,19 @@
>  #define	AT91_SAMA5D2_MR_USEQ		BIT(31)
>  
>  /* Channel Sequence Register 1 */
> -#define AT91_SAMA5D2_SEQR1	0x08
> +	u16				SEQR1;
>  /* Channel Sequence Register 2 */
> -#define AT91_SAMA5D2_SEQR2	0x0c
> +	u16				SEQR2;
>  /* Channel Enable Register */
> -#define AT91_SAMA5D2_CHER	0x10
> +	u16				CHER;
>  /* Channel Disable Register */
> -#define AT91_SAMA5D2_CHDR	0x14
> +	u16				CHDR;
>  /* Channel Status Register */
> -#define AT91_SAMA5D2_CHSR	0x18
> +	u16				CHSR;
>  /* Last Converted Data Register */
> -#define AT91_SAMA5D2_LCDR	0x20
> +	u16				LCDR;
>  /* Interrupt Enable Register */
> -#define AT91_SAMA5D2_IER	0x24
> +	u16				IER;
>  /* Interrupt Enable Register - TS X measurement ready */
>  #define AT91_SAMA5D2_IER_XRDY   BIT(20)
>  /* Interrupt Enable Register - TS Y measurement ready */
> @@ -109,22 +110,23 @@
>  #define AT91_SAMA5D2_IER_PEN    BIT(29)
>  /* Interrupt Enable Register - No pen detect */
>  #define AT91_SAMA5D2_IER_NOPEN  BIT(30)
> +
>  /* Interrupt Disable Register */
> -#define AT91_SAMA5D2_IDR	0x28
> +	u16				IDR;
>  /* Interrupt Mask Register */
> -#define AT91_SAMA5D2_IMR	0x2c
> +	u16				IMR;
>  /* Interrupt Status Register */
> -#define AT91_SAMA5D2_ISR	0x30
> +	u16				ISR;
>  /* Interrupt Status Register - Pen touching sense status */
>  #define AT91_SAMA5D2_ISR_PENS   BIT(31)
>  /* Last Channel Trigger Mode Register */
> -#define AT91_SAMA5D2_LCTMR	0x34
> +	u16				LCTMR;
>  /* Last Channel Compare Window Register */
> -#define AT91_SAMA5D2_LCCWR	0x38
> +	u16				LCCWR;
>  /* Overrun Status Register */
> -#define AT91_SAMA5D2_OVER	0x3c
> +	u16				OVER;
>  /* Extended Mode Register */
> -#define AT91_SAMA5D2_EMR	0x40
> +	u16				EMR;
>  /* Extended Mode Register - Oversampling rate */
>  #define AT91_SAMA5D2_EMR_OSR(V)			((V) << 16)
>  #define AT91_SAMA5D2_EMR_OSR_MASK		GENMASK(17, 16)
> @@ -134,22 +136,22 @@
>  
>  /* Extended Mode Register - Averaging on single trigger event */
>  #define AT91_SAMA5D2_EMR_ASTE(V)		((V) << 20)
> +
>  /* Compare Window Register */
> -#define AT91_SAMA5D2_CWR	0x44
> +	u16				CWR;
>  /* Channel Gain Register */
> -#define AT91_SAMA5D2_CGR	0x48
> -
> +	u16				CGR;
>  /* Channel Offset Register */
> -#define AT91_SAMA5D2_COR	0x4c
> +	u16				COR;
>  #define AT91_SAMA5D2_COR_DIFF_OFFSET	16
>  
>  /* Analog Control Register */
> -#define AT91_SAMA5D2_ACR	0x94
> +	u16				ACR;
>  /* Analog Control Register - Pen detect sensitivity mask */
>  #define AT91_SAMA5D2_ACR_PENDETSENS_MASK        GENMASK(1, 0)
>  
>  /* Touchscreen Mode Register */
> -#define AT91_SAMA5D2_TSMR	0xb0
> +	u16				TSMR;
>  /* Touchscreen Mode Register - No touch mode */
>  #define AT91_SAMA5D2_TSMR_TSMODE_NONE           0
>  /* Touchscreen Mode Register - 4 wire screen, no pressure measurement */
> @@ -178,13 +180,13 @@
>  #define AT91_SAMA5D2_TSMR_PENDET_ENA            BIT(24)
>  
>  /* Touchscreen X Position Register */
> -#define AT91_SAMA5D2_XPOSR	0xb4
> +	u16				XPOSR;
>  /* Touchscreen Y Position Register */
> -#define AT91_SAMA5D2_YPOSR	0xb8
> +	u16				YPOSR;
>  /* Touchscreen Pressure Register */
> -#define AT91_SAMA5D2_PRESSR	0xbc
> +	u16				PRESSR;
>  /* Trigger Register */
> -#define AT91_SAMA5D2_TRGR	0xc0
> +	u16				TRGR;
>  /* Mask for TRGMOD field of TRGR register */
>  #define AT91_SAMA5D2_TRGR_TRGMOD_MASK GENMASK(2, 0)
>  /* No trigger, only software trigger can start conversions */
> @@ -203,30 +205,52 @@
>  #define AT91_SAMA5D2_TRGR_TRGPER(x)             ((x) << 16)
>  
>  /* Correction Select Register */
> -#define AT91_SAMA5D2_COSR	0xd0
> +	u16				COSR;
>  /* Correction Value Register */
> -#define AT91_SAMA5D2_CVR	0xd4
> +	u16				CVR;
>  /* Channel Error Correction Register */
> -#define AT91_SAMA5D2_CECR	0xd8
> +	u16				CECR;
>  /* Write Protection Mode Register */
> -#define AT91_SAMA5D2_WPMR	0xe4
> +	u16				WPMR;
>  /* Write Protection Status Register */
> -#define AT91_SAMA5D2_WPSR	0xe8
> +	u16				WPSR;
>  /* Version Register */
> -#define AT91_SAMA5D2_VERSION	0xfc
> -
> -#define AT91_SAMA5D2_HW_TRIG_CNT 3
> -#define AT91_SAMA5D2_SINGLE_CHAN_CNT 12
> -#define AT91_SAMA5D2_DIFF_CHAN_CNT 6
> -
> -#define AT91_SAMA5D2_TIMESTAMP_CHAN_IDX (AT91_SAMA5D2_SINGLE_CHAN_CNT + \
> -					 AT91_SAMA5D2_DIFF_CHAN_CNT + 1)
> +	u16				VERSION;
> +};
>  
> -#define AT91_SAMA5D2_TOUCH_X_CHAN_IDX (AT91_SAMA5D2_SINGLE_CHAN_CNT + \
> -					 AT91_SAMA5D2_DIFF_CHAN_CNT * 2)
> -#define AT91_SAMA5D2_TOUCH_Y_CHAN_IDX   (AT91_SAMA5D2_TOUCH_X_CHAN_IDX + 1)
> -#define AT91_SAMA5D2_TOUCH_P_CHAN_IDX   (AT91_SAMA5D2_TOUCH_Y_CHAN_IDX + 1)
> -#define AT91_SAMA5D2_MAX_CHAN_IDX	AT91_SAMA5D2_TOUCH_P_CHAN_IDX
> +static const struct at91_adc_reg_layout sama5d2_layout = {
> +	.CR =			0x00,
> +	.MR =			0x04,
> +	.SEQR1 =		0x08,
> +	.SEQR2 =		0x0c,
> +	.CHER =			0x10,
> +	.CHDR =			0x14,
> +	.CHSR =			0x18,
> +	.LCDR =			0x20,
> +	.IER =			0x24,
> +	.IDR =			0x28,
> +	.IMR =			0x2c,
> +	.ISR =			0x30,
> +	.LCTMR =		0x34,
> +	.LCCWR =		0x38,
> +	.OVER =			0x3c,
> +	.EMR =			0x40,
> +	.CWR =			0x44,
> +	.CGR =			0x48,
> +	.COR =			0x4c,
> +	.ACR =			0x94,
> +	.TSMR =			0xb0,
> +	.XPOSR =		0xb4,
> +	.YPOSR =		0xb8,
> +	.PRESSR =		0xbc,
> +	.TRGR =			0xc0,
> +	.COSR =			0xd0,
> +	.CVR =			0xd4,
> +	.CECR =			0xd8,
> +	.WPMR =			0xe4,
> +	.WPSR =			0xe8,
> +	.VERSION =		0xfc,
> +};
>  
>  #define AT91_SAMA5D2_TOUCH_SAMPLE_PERIOD_US          2000    /* 2ms */
>  #define AT91_SAMA5D2_TOUCH_PEN_DETECT_DEBOUNCE_US    200
> @@ -235,18 +259,6 @@
>  
>  #define AT91_SAMA5D2_MAX_POS_BITS			12
>  
> -/*
> - * Maximum number of bytes to hold conversion from all channels
> - * without the timestamp.
> - */
> -#define AT91_BUFFER_MAX_CONVERSION_BYTES ((AT91_SAMA5D2_SINGLE_CHAN_CNT + \
> -					 AT91_SAMA5D2_DIFF_CHAN_CNT) * 2)
> -
> -/* This total must also include the timestamp */
> -#define AT91_BUFFER_MAX_BYTES (AT91_BUFFER_MAX_CONVERSION_BYTES + 8)
> -
> -#define AT91_BUFFER_MAX_HWORDS (AT91_BUFFER_MAX_BYTES / 2)
> -
>  #define AT91_HWFIFO_MAX_SIZE_STR	"128"
>  #define AT91_HWFIFO_MAX_SIZE		128
>  
> @@ -255,12 +267,12 @@
>  #define AT91_OSR_4SAMPLES		4
>  #define AT91_OSR_16SAMPLES		16
>  
> -#define AT91_SAMA5D2_CHAN_SINGLE(num, addr)				\
> +#define AT91_SAMA5D2_CHAN_SINGLE(index, num, addr)			\
>  	{								\
>  		.type = IIO_VOLTAGE,					\
>  		.channel = num,						\
>  		.address = addr,					\
> -		.scan_index = num,					\
> +		.scan_index = index,					\
>  		.scan_type = {						\
>  			.sign = 'u',					\
>  			.realbits = 14,					\
> @@ -274,14 +286,14 @@
>  		.indexed = 1,						\
>  	}
>  
> -#define AT91_SAMA5D2_CHAN_DIFF(num, num2, addr)				\
> +#define AT91_SAMA5D2_CHAN_DIFF(index, num, num2, addr)			\
>  	{								\
>  		.type = IIO_VOLTAGE,					\
>  		.differential = 1,					\
>  		.channel = num,						\
>  		.channel2 = num2,					\
>  		.address = addr,					\
> -		.scan_index = num + AT91_SAMA5D2_SINGLE_CHAN_CNT,	\
> +		.scan_index = index,					\
>  		.scan_type = {						\
>  			.sign = 's',					\
>  			.realbits = 14,					\
> @@ -328,13 +340,48 @@
>  		.datasheet_name = name,					\
>  	}
>  
> -#define at91_adc_readl(st, reg)		readl_relaxed(st->base + reg)
> -#define at91_adc_writel(st, reg, val)	writel_relaxed(val, st->base + reg)
> +#define at91_adc_readl(st, reg)						\
> +	readl_relaxed((st)->base + (st)->soc_info.platform->layout->reg)
I was a bit in two minds about whether this should be in capitals to make it clear
macro magic is going on, or whether lowercase is fine.  In the end I couldn't make
up my mind so will accept it like this! :)


Jonathan
