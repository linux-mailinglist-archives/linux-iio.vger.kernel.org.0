Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 324274BA86F
	for <lists+linux-iio@lfdr.de>; Thu, 17 Feb 2022 19:36:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244367AbiBQSgC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Thu, 17 Feb 2022 13:36:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244767AbiBQSfs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 17 Feb 2022 13:35:48 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 887A29FDA;
        Thu, 17 Feb 2022 10:33:38 -0800 (PST)
Received: from fraeml743-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4K03N919FLz67Q1L;
        Fri, 18 Feb 2022 02:32:41 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml743-chm.china.huawei.com (10.206.15.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 17 Feb 2022 19:33:36 +0100
Received: from localhost (10.202.226.41) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Thu, 17 Feb
 2022 18:33:35 +0000
Date:   Thu, 17 Feb 2022 18:33:33 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     chegbeli <ciprian.hegbeli@analog.com>
CC:     <jic23@kernel.org>, <robh+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] iio: meter: add ADE9078 driver
Message-ID: <20220217183333.000047fa@Huawei.com>
In-Reply-To: <20220217135140.5658-4-ciprian.hegbeli@analog.com>
References: <20220217135140.5658-1-ciprian.hegbeli@analog.com>
        <20220217135140.5658-4-ciprian.hegbeli@analog.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.226.41]
X-ClientProxiedBy: lhreml723-chm.china.huawei.com (10.201.108.74) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 17 Feb 2022 15:51:40 +0200
chegbeli <ciprian.hegbeli@analog.com> wrote:

> The ADE9078 is a highly accurate, fully integrated energy metering
> device. It allows the monitoring of three independent phases
> simultaneously, by using seven high performances ADCs and a flexible
> DSP core for a fixed fundamental signal frequency of either 50Hz or
> 60Hz.
> 
> Datasheet:
> www.analog.com/media/en/technical-documentation/data-sheets/ADE9078.pdf
> 
> Signed-off-by: chegbeli <ciprian.hegbeli@analog.com>

Hi Ciprian

I took a very quick end of day look so probably missed some stuff I'll
pick up on in v2.  Biggest issue is new ABI without docs. Various
other comments inline. Plus as already observed, please use full name
in from and SoB as they form part of the Developer Certificate of Origin.

Thanks,

Jonathan

> ---
>  MAINTAINERS                 |    8 +
>  drivers/iio/meter/Kconfig   |   13 +
>  drivers/iio/meter/Makefile  |    2 +
>  drivers/iio/meter/ade9078.c | 1666 +++++++++++++++++++++++++++++++++++
>  4 files changed, 1689 insertions(+)
>  create mode 100644 drivers/iio/meter/ade9078.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a2c8699e9e41..72fac9f4f837 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1101,6 +1101,14 @@ L:	linux-media@vger.kernel.org
>  S:	Maintained
>  F:	drivers/media/i2c/ad9389b*
>  
> +ANALOG DEVICES INC ADE9078 DRIVER
> +M:	Ciprian Hegbeli <ciprian.hegbeli@analog.com>
> +L:	linux-iio@vger.kernel.org
> +S:	Supported
> +W:	https://ez.analog.com/linux-software-drivers
> +F:	Documentation/devicetree/bindings/iio/meter/adi,ade9078.yaml
> +F:	drivers/iio/meter/ade9078.c
> +
>  ANALOG DEVICES INC ADGS1408 DRIVER
>  M:	Mircea Caprioru <mircea.caprioru@analog.com>
>  S:	Supported
> diff --git a/drivers/iio/meter/Kconfig b/drivers/iio/meter/Kconfig
> index d1c91eed5283..b46e93af1052 100644
> --- a/drivers/iio/meter/Kconfig
> +++ b/drivers/iio/meter/Kconfig
> @@ -6,4 +6,17 @@
>  
>  menu "Active energy metering"
>  
> +config ADE9078
> +	tristate "Analog Devices ADE9078 Poly Phase Multifunction Energy Metering IC Driver"
> +	depends on SPI
> +	select REGMAP_SPI
> +	select IIO_BUFFER
> +	select IIO_KFIFO_BUF
> +	help
> +	  Support driver for the ADE9078Poly Phase Multifunction Energy Meter,
> +	  select y to build the driver.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called ade9078
> +
>  endmenu
> diff --git a/drivers/iio/meter/Makefile b/drivers/iio/meter/Makefile
> index c27cba44fc0b..866b7f7dc703 100644
> --- a/drivers/iio/meter/Makefile
> +++ b/drivers/iio/meter/Makefile
> @@ -3,3 +3,5 @@
>  # Makefile for enrgy metering drivers
>  #
>  # When adding new entries keep the list in alphabetical order
> +
> +obj-$(CONFIG_ADE9078) += ade9078.o
> diff --git a/drivers/iio/meter/ade9078.c b/drivers/iio/meter/ade9078.c
> new file mode 100644
> index 000000000000..cfcb093e4c27
> --- /dev/null
> +++ b/drivers/iio/meter/ade9078.c
> @@ -0,0 +1,1666 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * ADE9078 driver
> + *
> + * Copyright 2021 Analog Devices Inc.
> + */
> +
> +#include <asm/unaligned.h>

Preference to put asm includes after the linux ones.

> +#include <linux/bitfield.h>
> +#include <linux/delay.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/kfifo_buf.h>
> +#include <linux/iio/events.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/of_irq.h>
> +#include <linux/regmap.h>
> +#include <linux/spi/spi.h>
> +
> +/* Address of ADE90XX registers */
> +#define	ADE9078_REG_AIGAIN		0x000
> +#define	ADE9078_REG_AVGAIN		0x00B
> +#define	ADE9078_REG_AIRMSOS		0x00C
> +#define	ADE9078_REG_AVRMSOS		0x00D
> +#define	ADE9078_REG_APGAIN		0x00E
> +#define	ADE9078_REG_AWATTOS		0x00F
> +#define	ADE9078_REG_AVAROS		0x010
> +#define	ADE9078_REG_AFVAROS		0x012
> +#define	ADE9078_REG_CONFIG0		0x060
> +#define	ADE9078_REG_DICOEFF		0x072
> +#define	ADE9078_REG_AI_PCF		0x20A
> +#define	ADE9078_REG_AV_PCF		0x20B
> +#define	ADE9078_REG_AIRMS		0x20C
> +#define	ADE9078_REG_AVRMS		0x20D
> +#define	ADE9078_REG_AWATT		0x210
> +#define	ADE9078_REG_AVAR		0x211
> +#define	ADE9078_REG_AVA			0x212
> +#define ADE9078_REG_AFVAR		0x214
> +#define	ADE9078_REG_APF			0x216
> +#define	ADE9078_REG_BI_PCF		0x22A
> +#define	ADE9078_REG_BV_PCF		0x22B
> +#define	ADE9078_REG_BIRMS		0x22C
> +#define	ADE9078_REG_BVRMS		0x22D
> +#define	ADE9078_REG_CI_PCF		0x24A
> +#define	ADE9078_REG_CV_PCF		0x24B
> +#define	ADE9078_REG_CIRMS		0x24C
> +#define	ADE9078_REG_CVRMS		0x24D
> +#define	ADE9078_REG_AWATT_ACC		0x2E5
> +#define	ADE9078_REG_STATUS0		0x402
> +#define	ADE9078_REG_STATUS1		0x403
> +#define	ADE9078_REG_MASK0		0x405
> +#define	ADE9078_REG_MASK1		0x406
> +#define	ADE9078_REG_EVENT_MASK		0x407
> +#define	ADE9078_REG_VLEVEL		0x40F
> +#define	ADE9078_REG_RUN			0x480
> +#define ADE9078_REG_CONFIG1		0x481
> +#define	ADE9078_REG_ACCMODE		0x492
> +#define	ADE9078_REG_CONFIG3		0x493
> +#define	ADE9078_REG_ZX_LP_SEL		0x49A
> +#define	ADE9078_REG_WFB_CFG		0x4A0
> +#define	ADE9078_REG_WFB_PG_IRQEN	0x4A1
> +#define	ADE9078_REG_WFB_TRG_CFG		0x4A2
> +#define	ADE9078_REG_WFB_TRG_STAT	0x4A3
> +#define	ADE9078_REG_CONFIG2		0x4AF
> +#define	ADE9078_REG_EP_CFG		0x4B0
> +#define	ADE9078_REG_EGY_TIME		0x4B2
> +#define	ADE9078_REG_PGA_GAIN		0x4B9
> +#define	ADE9078_REG_VERSION		0x4FE
> +#define ADE9078_REG_WF_BUFF		0x800
> +
> +#define ADE9078_REG_ADDR_MASK		GENMASK(15, 4)
> +#define ADE9078_REG_READ_BIT_MASK	BIT(3)
> +#define ADE9078_RX_DEPTH		6
> +#define ADE9078_TX_DEPTH		10
> +
> +#define ADE9078_WF_CAP_EN_MASK		BIT(4)
> +#define ADE9078_WF_CAP_SEL_MASK		BIT(5)
> +#define ADE9078_WF_MODE_MASK		GENMASK(7, 6)
> +#define ADE9078_WF_SRC_MASK		GENMASK(9, 8)
> +#define ADE9078_WF_IN_EN_MASK		BIT(12)
> +
> +/*
> + * Configuration registers
> + * PGA@0x0000. Gain of all channels=1
> + */
> +#define ADE9078_PGA_GAIN		0x0000
> +
> +/* Default configuration */
> +#define ADE9078_CONFIG0			0x00000000
> +
> +/* CF3/ZX pin outputs Zero crossing */
> +#define ADE9078_CONFIG1			0x0002

This looks like it could be better expressed in terms
of defines for the fields contained in this register.
Same for many of the ones that follow.

> +
> +/* Default High pass corner frequency of 1.25Hz */
> +#define ADE9078_CONFIG2			0x0A00
> +
> +/* Peak and overcurrent detection disabled */
> +#define ADE9078_CONFIG3			0x0000
> +
> +/*
> + * 50Hz operation, 3P4W Wye configuration, signed accumulation
> + * Clear bit 8 i.e. ACCMODE=0x00xx for 50Hz operation
> + * ACCMODE=0x0x9x for 3Wire delta when phase B is used as reference
> + */
> +#define ADE9078_ACCMODE			0x0000
> +
> +/*Line period and zero crossing obtained from VA */
> +#define ADE9078_ZX_LP_SEL		0x0000
> +
> +/* Disable all interrupts */
> +#define ADE9078_MASK0			0x00000000
> +
> +/* Disable all interrupts */
> +#define ADE9078_MASK1			0x00000000
> +
> +/* Events disabled */
> +#define ADE9078_EVENT_MASK		0x00000000
> +
> +/*
> + * Assuming Vnom=1/2 of full scale.
> + * Refer to Technical reference manual for detailed calculations.
> + */
> +#define ADE9078_VLEVEL			0x0022EA28
> +
> +/* Set DICOEFF= 0xFFFFE000 when integrator is enabled */
> +#define ADE9078_DICOEFF			0x00000000
> +
> +/* DSP ON */
> +#define ADE9078_RUN_ON			0xFFFFFFFF
> +
> +/*
> + * Energy Accumulation Settings
> + * Enable energy accumulation, accumulate samples at 8ksps
> + * latch energy accumulation after EGYRDY
> + * If accumulation is changed to half line cycle mode, change EGY_TIME
> + */
> +#define ADE9078_EP_CFG			0x0011
> +
> +/* Accumulate 4000 samples */
> +#define ADE9078_EGY_TIME		0x0FA0
> +
> +/*
> + * Constant Definitions
> + * ADE9000 FDSP: 8000sps, ADE9078 FDSP: 4000sps
> + */
> +#define ADE9078_FDSP			4000
> +#define ADE9078_WFB_CFG			0x0329
> +#define ADE9078_WFB_PAGE_SIZE		128
> +#define ADE9078_WFB_BYTES_IN_PAGE	4
> +#define ADE9078_WFB_PAGE_ARRAY_SIZE	\
> +	(ADE9078_WFB_PAGE_SIZE * ADE9078_WFB_BYTES_IN_PAGE)
> +#define ADE9078_WFB_FULL_BUFF_SIZE	\
> +	(ADE9078_WFB_PAGE_ARRAY_SIZE * 16)
> +#define ADE9078_WFB_FULL_BUFF_NR_SAMPLES \
> +	(ADE9078_WFB_PAGE_SIZE * 16)
> +
> +#define ADE9078_SWRST_BIT		BIT(0)
> +
> +/* Status and Mask register bits*/
> +#define ADE9078_ST0_WFB_TRIG_BIT	BIT(16)
> +#define ADE9078_ST0_PAGE_FULL_BIT	BIT(17)
> +
> +#define ADE9078_ST1_ZXTOVA_BIT		BIT(6)
> +#define ADE9078_ST1_ZXTOVB_BIT		BIT(7)
> +#define ADE9078_ST1_ZXTOVC_BIT		BIT(8)
> +#define ADE9078_ST1_ZXVA_BIT		BIT(9)
> +#define ADE9078_ST1_ZXVB_BIT		BIT(10)
> +#define ADE9078_ST1_ZXVC_BIT		BIT(11)
> +#define ADE9078_ST1_ZXIA_BIT		BIT(13)
> +#define ADE9078_ST1_ZXIB_BIT		BIT(14)
> +#define ADE9078_ST1_ZXIC_BIT		BIT(15)
> +#define ADE9078_ST1_RSTDONE_BIT		BIT(16)
> +#define ADE9078_ST1_ERROR0_BIT		BIT(28)
> +#define ADE9078_ST1_ERROR1_BIT		BIT(29)
> +#define ADE9078_ST1_ERROR2_BIT		BIT(30)
> +#define ADE9078_ST1_ERROR3_BIT		BIT(31)
> +#define ADE9078_ST_ERROR \
> +	(ADE9078_ST1_ERROR0 | \
> +	 ADE9078_ST1_ERROR1 | \
> +	 ADE9078_ST1_ERROR2 | \
> +	 ADE9078_ST1_ERROR3)
> +#define ADE9078_ST1_CROSSING_FIRST	6
> +#define ADE9078_ST1_CROSSING_DEPTH	16
> +
> +#define ADE9078_WFB_TRG_ZXIA_BIT	BIT(3)
> +#define ADE9078_WFB_TRG_ZXIB_BIT	BIT(4)
> +#define ADE9078_WFB_TRG_ZXIC_BIT	BIT(5)
> +#define ADE9078_WFB_TRG_ZXVA_BIT	BIT(6)
> +#define ADE9078_WFB_TRG_ZXVB_BIT	BIT(7)
> +#define ADE9078_WFB_TRG_ZXVC_BIT	BIT(8)
> +
> +/* Stop when waveform buffer is full */
> +#define ADE9078_WFB_FULL_MODE		0x0
> +/* Continuous fill—stop only on enabled trigger events */
> +#define ADE9078_WFB_EN_TRIG_MODE	0x1
> +/* Continuous filling—center capture around enabled trigger events */
> +#define ADE9078_WFB_C_EN_TRIG_MODE	0x2
> +/* Continuous fill—save event address of enabled trigger events */
> +#define ADE9078_WFB_SAVE_EN_TRIG_MODE	0x3
> +
> +#define ADE9078_MODE_0_1_PAGE_BIT	BIT(15)
> +#define ADE9078_MODE_2_PAGE_BIT		BIT(7)
> +
> +/*
> + * Full scale Codes referred from Datasheet.Respective digital codes are
> + * produced when ADC inputs are at full scale. Do not Change.
> + */
> +#define ADE9078_RMS_FULL_SCALE_CODES	52866837
> +#define ADE9000_WATT_FULL_SCALE_CODES	20694066
> +#define ADE9078_PCF_FULL_SCALE_CODES	74770000
> +
> +/* Phase and channel definitions */
> +#define ADE9078_PHASE_A_NR		0
> +#define ADE9078_PHASE_B_NR		2
> +#define ADE9078_PHASE_C_NR		4
> +#define ADE9078_PHASE_A_NAME		"A"
> +#define ADE9078_PHASE_B_NAME		"B"
> +#define ADE9078_PHASE_C_NAME		"C"

These will be passed into a new macro as below (once each)
so probably will be better just used inline there.

> +
> +#define ADE9078_SCAN_POS_IA		BIT(0)
> +#define ADE9078_SCAN_POS_VA		BIT(1)
> +#define ADE9078_SCAN_POS_IB		BIT(2)
> +#define ADE9078_SCAN_POS_VB		BIT(3)
> +#define ADE9078_SCAN_POS_IC		BIT(4)
> +#define ADE9078_SCAN_POS_VC		BIT(5)
> +
> +#define ADE9078_PHASE_B_POS_BIT		BIT(5)
> +#define ADE9078_PHASE_C_POS_BIT		BIT(6)
> +
> +#define ADE9078_MAX_PHASE_NR		3
> +#define AD9078_CHANNELS_PER_PHASE	9
> +
> +#define ADE9078_ADDR_ADJUST(addr, chan)					\
> +	(((chan) << 4) | (addr))
> +
> +#define ADE9078_CURRENT_CHANNEL(num, name) {				\
> +	.type = IIO_CURRENT,						\
> +	.channel = num,							\
> +	.extend_name = name,						\
> +	.address = ADE9078_ADDR_ADJUST(ADE9078_REG_AI_PCF, num),	\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |			\
> +			      BIT(IIO_CHAN_INFO_SCALE) |		\
> +			      BIT(IIO_CHAN_INFO_HARDWAREGAIN),		\
> +	.event_spec = ade9078_events,					\
> +	.num_event_specs = ARRAY_SIZE(ade9078_events),			\
> +	.scan_index = num,						\
> +	.scan_type = {							\
> +		.sign = 's',						\
> +		.realbits = 32,						\
> +		.storagebits = 32,					\
> +		.shift = 0,						\
> +		.endianness = IIO_BE,					\
> +	},								\
> +}
> +
> +#define ADE9078_VOLTAGE_CHANNEL(num, name) {				\
> +	.type = IIO_VOLTAGE,						\
> +	.channel = num,							\
> +	.extend_name = name,						\
> +	.address = ADE9078_ADDR_ADJUST(ADE9078_REG_AV_PCF, num),	\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |			\
> +			      BIT(IIO_CHAN_INFO_SCALE) |		\
> +			      BIT(IIO_CHAN_INFO_HARDWAREGAIN),		\
> +	.event_spec = ade9078_events,					\
> +	.num_event_specs = ARRAY_SIZE(ade9078_events),			\
> +	.scan_index = num + 1,						\
> +	.scan_type = {							\
> +		.sign = 's',						\
> +		.realbits = 32,						\
> +		.storagebits = 32,					\
> +		.shift = 0,						\
> +		.endianness = IIO_BE,					\
> +	},								\
> +}
> +
> +#define ADE9078_CURRENT_RMS_CHANNEL(num, name) {			\
> +	.type = IIO_CURRENT,						\
> +	.channel = num,							\
> +	.address = ADE9078_ADDR_ADJUST(ADE9078_REG_AIRMS, num),		\
> +	.extend_name = name "_rms",					\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |			\
> +			      BIT(IIO_CHAN_INFO_SCALE) |		\
> +			      BIT(IIO_CHAN_INFO_OFFSET),		\
> +	.scan_index = -1						\
> +}
> +
> +#define ADE9078_VOLTAGE_RMS_CHANNEL(num, name) {			\
> +	.type = IIO_VOLTAGE,						\
> +	.channel = num,							\
> +	.address = ADE9078_ADDR_ADJUST(ADE9078_REG_AVRMS, num),		\
> +	.extend_name = name "_rms",					\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |			\
> +			      BIT(IIO_CHAN_INFO_SCALE) |		\
> +			      BIT(IIO_CHAN_INFO_OFFSET),		\
> +	.scan_index = -1						\
> +}
> +
> +#define ADE9078_POWER_ACTIV_CHANNEL(num, name) {			\
> +	.type = IIO_POWER,						\
> +	.channel = num,							\
> +	.address = ADE9078_ADDR_ADJUST(ADE9078_REG_AWATT, num),		\
> +	.extend_name = name "_activ",					\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |			\
> +			      BIT(IIO_CHAN_INFO_SCALE) |		\
> +			      BIT(IIO_CHAN_INFO_OFFSET) |		\
> +			      BIT(IIO_CHAN_INFO_HARDWAREGAIN),		\
> +	.scan_index = -1						\
> +}
> +
> +#define ADE9078_POWER_REACTIV_CHANNEL(num, name) {			\
> +	.type = IIO_POWER,						\
> +	.channel = num,							\
> +	.address = ADE9078_ADDR_ADJUST(ADE9078_REG_AVAR, num),		\
> +	.extend_name = name "_reactiv",					\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |			\
> +			      BIT(IIO_CHAN_INFO_SCALE) |		\
> +			      BIT(IIO_CHAN_INFO_OFFSET),		\
> +	.scan_index = -1						\
> +}
> +
> +#define ADE9078_POWER_APPARENT_CHANNEL(num, name) {			\
> +	.type = IIO_POWER,						\
> +	.channel = num,							\
> +	.address = ADE9078_ADDR_ADJUST(ADE9078_REG_AVA, num),		\
> +	.extend_name = name "_apparent",				\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |			\
> +			      BIT(IIO_CHAN_INFO_SCALE),			\
> +	.scan_index = -1						\
> +}
> +
> +#define ADE9078_POWER_FUND_REACTIV_CHANNEL(num, name) {			\
> +	.type = IIO_POWER,						\
> +	.channel = num,							\
> +	.address = ADE9078_ADDR_ADJUST(ADE9078_REG_AFVAR, num),		\
> +	.extend_name = name "_fund_reactiv",				\

extend_name defines new ABI.  Needs documentation in
Documentation/ABI/testing/sysfs-bus-iio-* 

and a very strong reason why it makes sense to do it this way rather than
via modifiers or similar.

> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |			\
> +			      BIT(IIO_CHAN_INFO_SCALE) |		\
> +			      BIT(IIO_CHAN_INFO_OFFSET),		\
> +	.scan_index = -1						\
> +}
> +
> +#define ADE9078_POWER_FACTOR_CHANNEL(num, name) {			\
> +	.type = IIO_POWER,						\
> +	.channel = num,							\
> +	.address = ADE9078_ADDR_ADJUST(ADE9078_REG_APF, num),		\
> +	.extend_name = name "_factor",					\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |			\
> +			      BIT(IIO_CHAN_INFO_SCALE),			\
> +	.scan_index = -1						\
> +}
reorder the code so these defs are near the use of them.
> +
> +/*
> + * struct ade9078_state - ade9078 specific data
> + * @rst_done	flag for when reset sequence irq has been received
> + * @wf_mode	wave form buffer mode, read datasheet for more details,
> + *		retrieved from DT
> + * @wfb_trg	wave form buffer triger configuration, read datasheet for more
> + *		details, retrieved from DT
> + * @spi		spi device associated to the ade9078
> + * @tx		transmit buffer for the spi
> + * @rx		receive buffer for the spi
> + * @xfer	transfer setup used in iio buffer configuration
> + * @spi_msg	message transfer trough spi, used in iio buffer
> + *		configuration
> + * @regmap	register map pointer
> + * @indio_dev:	the IIO device
> + * @trig	iio trigger pointer, is connected to IRQ0 and IRQ1
> + * @rx_buff	receive buffer for the iio buffer trough spi, will
> + *		contain the samples from the IC wave form buffer
> + * @tx_buff	transmit buffer for the iio buffer trough spi, used
> + *		in iio	buffer configuration
> + */
> +
> +struct ade9078_state {
> +	bool rst_done;
> +	u8 wf_mode;
> +	u32 wfb_trg;
> +	struct spi_device *spi;
> +	u8 *tx;
> +	u8 *rx;
> +	struct spi_transfer xfer[2];
> +	struct spi_message spi_msg;
> +	struct regmap *regmap;
> +	struct iio_dev *indio_dev;

This is always a bad sign.  If you need to go from the state back
to the iio_dev then you should have passed the iio_dev in the first
place - in this particular case the iio_dev should be your private
data for the irq handlers, not the ade9078 state structure.


> +	union{
> +		u8 byte[ADE9078_WFB_FULL_BUFF_SIZE];
> +		__be32 word[ADE9078_WFB_FULL_BUFF_NR_SAMPLES];
> +	} rx_buff ____cacheline_aligned;
> +	u8 tx_buff[2];
> +};
> +
> +static const struct iio_event_spec ade9078_events[] = {
> +	{
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_EITHER,
> +		.mask_separate = BIT(IIO_EV_INFO_ENABLE) |
> +				 BIT(IIO_EV_INFO_VALUE),
> +	},
> +};
> +
> +/* IIO channels of the ade9078 for each phase individually */
> +static const struct iio_chan_spec ade9078_a_channels[] = {
> +	ADE9078_CURRENT_CHANNEL(ADE9078_PHASE_A_NR, ADE9078_PHASE_A_NAME),
> +	ADE9078_VOLTAGE_CHANNEL(ADE9078_PHASE_A_NR, ADE9078_PHASE_A_NAME),
> +	ADE9078_CURRENT_RMS_CHANNEL(ADE9078_PHASE_A_NR, ADE9078_PHASE_A_NAME),
> +	ADE9078_VOLTAGE_RMS_CHANNEL(ADE9078_PHASE_A_NR, ADE9078_PHASE_A_NAME),
> +	ADE9078_POWER_ACTIV_CHANNEL(ADE9078_PHASE_A_NR, ADE9078_PHASE_A_NAME),
> +	ADE9078_POWER_REACTIV_CHANNEL(ADE9078_PHASE_A_NR, ADE9078_PHASE_A_NAME),
> +	ADE9078_POWER_APPARENT_CHANNEL(ADE9078_PHASE_A_NR,
> +				       ADE9078_PHASE_A_NAME),
> +	ADE9078_POWER_FUND_REACTIV_CHANNEL(ADE9078_PHASE_A_NR,
> +					   ADE9078_PHASE_A_NAME),
> +	ADE9078_POWER_FACTOR_CHANNEL(ADE9078_PHASE_A_NR, ADE9078_PHASE_A_NAME),

These definitely look like a case for a macro defining all the channels for a phase.

> +};
> +
> +static const struct iio_chan_spec ade9078_b_channels[] = {
> +	ADE9078_CURRENT_CHANNEL(ADE9078_PHASE_B_NR, ADE9078_PHASE_B_NAME),
> +	ADE9078_VOLTAGE_CHANNEL(ADE9078_PHASE_B_NR, ADE9078_PHASE_B_NAME),
> +	ADE9078_CURRENT_RMS_CHANNEL(ADE9078_PHASE_B_NR, ADE9078_PHASE_B_NAME),
> +	ADE9078_VOLTAGE_RMS_CHANNEL(ADE9078_PHASE_B_NR, ADE9078_PHASE_B_NAME),
> +	ADE9078_POWER_ACTIV_CHANNEL(ADE9078_PHASE_B_NR, ADE9078_PHASE_B_NAME),
> +	ADE9078_POWER_REACTIV_CHANNEL(ADE9078_PHASE_B_NR, ADE9078_PHASE_B_NAME),
> +	ADE9078_POWER_APPARENT_CHANNEL(ADE9078_PHASE_B_NR,
> +				       ADE9078_PHASE_B_NAME),
> +	ADE9078_POWER_FUND_REACTIV_CHANNEL(ADE9078_PHASE_B_NR,
> +					   ADE9078_PHASE_B_NAME),
> +	ADE9078_POWER_FACTOR_CHANNEL(ADE9078_PHASE_B_NR, ADE9078_PHASE_B_NAME),
> +};
> +
> +static const struct iio_chan_spec ade9078_c_channels[] = {
> +	ADE9078_CURRENT_CHANNEL(ADE9078_PHASE_C_NR, ADE9078_PHASE_C_NAME),
> +	ADE9078_VOLTAGE_CHANNEL(ADE9078_PHASE_C_NR, ADE9078_PHASE_C_NAME),
> +	ADE9078_CURRENT_RMS_CHANNEL(ADE9078_PHASE_C_NR, ADE9078_PHASE_C_NAME),
> +	ADE9078_VOLTAGE_RMS_CHANNEL(ADE9078_PHASE_C_NR, ADE9078_PHASE_C_NAME),
> +	ADE9078_POWER_ACTIV_CHANNEL(ADE9078_PHASE_C_NR, ADE9078_PHASE_C_NAME),
> +	ADE9078_POWER_REACTIV_CHANNEL(ADE9078_PHASE_C_NR, ADE9078_PHASE_C_NAME),
> +	ADE9078_POWER_APPARENT_CHANNEL(ADE9078_PHASE_C_NR,
> +				       ADE9078_PHASE_C_NAME),
> +	ADE9078_POWER_FUND_REACTIV_CHANNEL(ADE9078_PHASE_C_NR,
> +					   ADE9078_PHASE_C_NAME),
> +	ADE9078_POWER_FACTOR_CHANNEL(ADE9078_PHASE_C_NR, ADE9078_PHASE_C_NAME),
> +};
> +
> +static const struct reg_sequence ade9078_reg_sequence[] = {
> +	{ ADE9078_REG_PGA_GAIN, ADE9078_PGA_GAIN },
> +	{ ADE9078_REG_CONFIG0, ADE9078_CONFIG0 },
> +	{ ADE9078_REG_CONFIG1, ADE9078_CONFIG1 },
> +	{ ADE9078_REG_CONFIG2, ADE9078_CONFIG2 },
> +	{ ADE9078_REG_CONFIG3, ADE9078_CONFIG3 },
> +	{ ADE9078_REG_ACCMODE, ADE9078_ACCMODE },
> +	{ ADE9078_REG_ZX_LP_SEL, ADE9078_ZX_LP_SEL },
> +	{ ADE9078_REG_MASK0, ADE9078_MASK0 },
> +	{ ADE9078_REG_MASK1, ADE9078_MASK1 },
> +	{ ADE9078_REG_EVENT_MASK, ADE9078_EVENT_MASK },
> +	{ ADE9078_REG_WFB_CFG, ADE9078_WFB_CFG },
> +	{ ADE9078_REG_VLEVEL, ADE9078_VLEVEL },
> +	{ ADE9078_REG_DICOEFF, ADE9078_DICOEFF },
> +	{ ADE9078_REG_EGY_TIME, ADE9078_EGY_TIME },
> +	{ ADE9078_REG_EP_CFG, ADE9078_EP_CFG },
> +	{ ADE9078_REG_RUN, ADE9078_RUN_ON }
> +};
> +
> +/*

As mentioned below, I don't immediately understand why this can't
be done with appropriate standard regmap.  Perhaps you could give
more details of what is missing.  I'd like to see that added to
regmap if possible.

> + * ade9078_spi_write_reg() - ade9078 write register over SPI
> + * the data format for communicating with the ade9078 over SPI
> + * is very specific and can access both 32bit and 16bit registers
> + * @context:	void pointer to the SPI device
> + * @reg:	address of the of desired register
> + * @val:	value to be written to the ade9078
> + */
> +static int ade9078_spi_write_reg(void *context,
> +				 unsigned int reg,
> +				 unsigned int val)
> +{
> +	struct device *dev = context;
> +	struct spi_device *spi = to_spi_device(dev);
> +	struct ade9078_state *st = spi_get_drvdata(spi);

> +
> +	u16 addr;
> +	int ret = 0;
> +	struct spi_transfer xfer[] = {
> +		{
> +			.tx_buf = st->tx,
> +		},
> +	};
> +
> +	addr = FIELD_PREP(ADE9078_REG_ADDR_MASK, reg);
> +
> +	put_unaligned_be16(addr, st->tx);
> +	put_unaligned_be32(val, &st->tx[2]);
> +
> +	if (reg > ADE9078_REG_RUN && reg < ADE9078_REG_VERSION) {
> +		put_unaligned_be16(val, &st->tx[2]);
> +		xfer[0].len = 4;
> +	} else {
> +		xfer[0].len = 6;
> +	}
> +
> +	ret = spi_sync_transfer(st->spi, xfer, ARRAY_SIZE(xfer));
> +	if (ret) {
> +		dev_err(&st->spi->dev, "problem when writing register 0x%x",
> +			reg);
> +	}
> +
> +	return ret;
> +}
> +
> +/*
> + * ade9078_spi_write_reg() - ade9078 read register over SPI
> + * the data format for communicating with the ade9078 over SPI
> + * is very specific and can access both 32bit and 16bit registers
> + * @context:	void pointer to the SPI device
> + * @reg:	address of the of desired register
> + * @val:	value to be read to the ade9078
> + */
> +static int ade9078_spi_read_reg(void *context,
> +				unsigned int reg,
> +				unsigned int *val)
> +{
> +	struct device *dev = context;
> +	struct spi_device *spi = to_spi_device(dev);
> +	struct ade9078_state *st = spi_get_drvdata(spi);
> +
> +	u16 addr;
> +	int ret = 0;
> +	struct spi_transfer xfer[] = {
> +		{
> +			.tx_buf = st->tx,
> +			.len = 2,
> +		},
> +		{
> +			.rx_buf = st->rx,
> +		},
> +	};
> +
> +	addr = FIELD_PREP(ADE9078_REG_ADDR_MASK, reg) |
> +	       ADE9078_REG_READ_BIT_MASK;
> +
> +	put_unaligned_be16(addr, st->tx);
> +
> +	if (reg > ADE9078_REG_RUN && reg < ADE9078_REG_VERSION)
> +		xfer[1].len = 4;
> +	else
> +		xfer[1].len = 6;

This doesn't look like a fixed length register which is expected
for regmap...  Also that len should just be the rx register which
you treat below as 16 bit and 32 bit (so 2 and 4, not 4 and 6).

Can the larger registers be treated as bulk reads of pairs of smaller ones?

> +
> +	ret = spi_sync_transfer(st->spi, xfer, ARRAY_SIZE(xfer));
> +	if (ret) {
> +		dev_err(&st->spi->dev, "problem when reading register 0x%x",
> +			reg);
> +		goto err_ret;
> +	}
> +
> +	//registers which are 16 bits
> +	if (reg > 0x480 && reg < 0x4FE)
> +		*val = get_unaligned_be16(st->rx);
> +	else
> +		*val = get_unaligned_be32(st->rx);
> +
> +err_ret:
> +	return ret;
> +}
> +
> +/*
> + * ade9078_is_volatile_reg() - list of ade9078 registers which should use
> + * caching
> + * @dev:	device data
> + * @reg:	address of the of desired register
> + */
> +static bool ade9078_is_volatile_reg(struct device *dev, unsigned int reg)
> +{
> +	switch (reg) {
> +	case ADE9078_REG_STATUS0:
> +	case ADE9078_REG_STATUS1:
> +	case ADE9078_REG_MASK0:
> +	case ADE9078_REG_MASK1:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +/*
> + * ade9078_en_wfb() - enables or disables the WFBuffer in the ADE9078
> + * @st:		ade9078 device data
> + * @state:	true for enabled; false for disabled
> + */
> +static int ade9078_en_wfb(struct ade9078_state *st, bool state)
> +{
> +	return regmap_update_bits(st->regmap, ADE9078_REG_WFB_CFG, BIT(4),
> +				  state ? BIT(4) : 0);
> +}
> +
> +/*
> + * ade9078_iio_push_buffer() - reads out the content of the waveform buffer and
> + * pushes it to the IIO buffer.
> + * @st:		ade9078 device data
> + */
> +static int ade9078_iio_push_buffer(struct ade9078_state *st)
> +{
> +	int ret;
> +	u32 i;
> +
> +	ret = spi_sync(st->spi, &st->spi_msg);
> +	if (ret) {
> +		dev_err(&st->spi->dev, "SPI fail in trigger handler");
> +		return ret;
> +	}
> +
> +	for (i = 0; i < ADE9078_WFB_FULL_BUFF_NR_SAMPLES; i++)
> +		iio_push_to_buffers(st->indio_dev, &st->rx_buff.word[i]);
> +
> +	return 0;
> +}
> +
> +/*
> + * ade9078_irq0_thread() - Thread for IRQ0. It reads Status register 0 and
> + * checks for the IRQ activation. This is configured to acquire samples in to
> + * the IC buffer and dump it in to the iio_buffer according to Stop When Buffer
> + * Is Full Mode, Stop Filling on Trigger and Capture Around Trigger from the
> + * ADE9078 Datasheet
> + */
> +static irqreturn_t ade9078_irq0_thread(int irq, void *data)
> +{
> +	struct ade9078_state *st = data;
> +	u32 handled_irq = 0;
> +	u32 interrupts;
> +	u32 status;
> +	int ret;
> +
> +	ret = regmap_read(st->regmap, ADE9078_REG_STATUS0, &status);
> +	if (ret) {
> +		dev_err(&st->spi->dev, "IRQ0 read status fail");
> +		goto irq0_done;
> +	}
> +
> +	ret = regmap_read(st->regmap, ADE9078_REG_MASK0, &interrupts);
> +	if (ret) {
> +		dev_err(&st->spi->dev, "IRQ0 read status fail");
> +		goto irq0_done;
> +	}
> +
> +	if ((status & ADE9078_ST0_PAGE_FULL_BIT) &&
> +	    (interrupts & ADE9078_ST0_PAGE_FULL_BIT)) {
> +		//Stop Filling on Trigger and Center Capture Around Trigger
> +		if (st->wf_mode) {
> +			ret = regmap_write(st->regmap, ADE9078_REG_WFB_TRG_CFG,
> +					   st->wfb_trg);
> +			if (ret) {
> +				dev_err(&st->spi->dev, "IRQ0 WFB write fail");
> +				goto irq0_done;
> +			}
> +
> +			interrupts |= ADE9078_ST0_WFB_TRIG_BIT;
> +
> +		} else {
> +			//Stop When Buffer Is Full Mode
> +			ret = ade9078_en_wfb(st, false);
> +			if (ret) {
> +				dev_err(&st->spi->dev, "IRQ0 WFB stop fail");
> +				goto irq0_done;
> +			}
> +			ret = ade9078_iio_push_buffer(st);
> +			if (ret) {
> +				dev_err(&st->spi->dev, "IRQ0 IIO push fail");
> +				goto irq0_done;
> +			}
> +		}
> +
> +		//disable Page full interrupt
> +		interrupts &= ~ADE9078_ST0_PAGE_FULL_BIT;
> +
> +		ret = regmap_write(st->regmap, ADE9078_REG_MASK0, interrupts);
> +		if (ret) {
> +			dev_err(&st->spi->dev, "IRQ0 MAKS0 write fail");
> +			goto irq0_done;
> +		}
> +
> +		handled_irq |= ADE9078_ST0_PAGE_FULL_BIT;
> +	}
> +
> +	if ((status & ADE9078_ST0_WFB_TRIG_BIT) &&
> +	    (interrupts & ADE9078_ST0_WFB_TRIG_BIT)) {
> +		//Stop Filling on Trigger and Center Capture Around Trigger
> +		ret = ade9078_en_wfb(st, false);
> +		if (ret) {
> +			dev_err(&st->spi->dev, "IRQ0 WFB fail");
> +			goto irq0_done;
> +		}
> +
> +		ret = ade9078_iio_push_buffer(st);
> +		if (ret) {
> +			dev_err(&st->spi->dev, "IRQ0 IIO push fail @ WFB TRIG");
> +			goto irq0_done;
> +		}
> +
> +		handled_irq |= ADE9078_ST0_WFB_TRIG_BIT;
> +	}
> +
> +	ret = regmap_write(st->regmap, ADE9078_REG_STATUS0, handled_irq);
> +	if (ret)
> +		dev_err(&st->spi->dev, "IRQ0 write status fail");
> +
> +irq0_done:

As below. return wherever you have a goto.  This common exit just makes
the code less readable.

> +	return IRQ_HANDLED;
> +}
> +
> +/*
> + * ade9078_irq1_thread() - Thread for IRQ1. It reads Status register 1 and
> + * checks for the IRQ activation. This thread handles the reset condition and
> + * the zero-crossing conditions for all 3 phases on Voltage and Current
> + */
> +static irqreturn_t ade9078_irq1_thread(int irq, void *data)
> +{
> +	struct ade9078_state *st = data;
> +	struct iio_dev *indio_dev = st->indio_dev;
> +	struct iio_chan_spec const *chan = indio_dev->channels;
> +	unsigned int bit = ADE9078_ST1_CROSSING_FIRST;
> +	s64 timestamp = iio_get_time_ns(indio_dev);
> +	u32 interrupts;
> +	u32 result;
> +	u32 status;
> +	u32 tmp;
> +	int ret;
> +
> +	//reset
/* reset */ etc
// isn't used for comments in IIO (or most of the rest of the kernel)

> +	if (!st->rst_done) {
> +		ret = regmap_read(st->regmap, ADE9078_REG_STATUS1, &result);
> +		if (ret)
> +			return ret;
> +
> +		if (result & ADE9078_ST1_RSTDONE_BIT)
> +			st->rst_done = true;
> +		else
> +			dev_err(&st->spi->dev, "Error testing reset done");
> +
> +		goto irq1_done;
> +	}
> +
> +	ret = regmap_read(st->regmap, ADE9078_REG_STATUS1, &status);
> +	if (ret)
> +		goto irq1_done;
> +
> +	ret = regmap_read(st->regmap, ADE9078_REG_MASK1, &interrupts);
> +	if (ret) {
> +		dev_err(&st->spi->dev, "IRQ1 read status fail");
> +		goto irq1_done;

return IRQ_HANDLED; in all these paths.  No point in going to a common
exit that doesn't do anything.

> +	}
> +
> +	//crossings
> +	for_each_set_bit_from(bit, (unsigned long *)&interrupts,
> +			      ADE9078_ST1_CROSSING_DEPTH) {
> +		tmp = status & BIT(bit);
> +
> +		switch (tmp) {
> +		case ADE9078_ST1_ZXVA_BIT:
> +		case ADE9078_ST1_ZXTOVA_BIT:
> +		case ADE9078_ST1_ZXIA_BIT:
> +			iio_push_event(indio_dev,
> +				       IIO_UNMOD_EVENT_CODE(chan->type,
> +							    ADE9078_PHASE_A_NR,
> +							    IIO_EV_TYPE_THRESH,
> +							    IIO_EV_DIR_EITHER),
> +				       timestamp);
> +			break;
> +		case ADE9078_ST1_ZXVB_BIT:
> +		case ADE9078_ST1_ZXTOVB_BIT:
> +		case ADE9078_ST1_ZXIB_BIT:
> +			iio_push_event(indio_dev,
> +				       IIO_UNMOD_EVENT_CODE(chan->type,
> +							    ADE9078_PHASE_B_NR,
> +							    IIO_EV_TYPE_THRESH,
> +							    IIO_EV_DIR_EITHER),
> +				       timestamp);
> +			break;
> +		case ADE9078_ST1_ZXVC_BIT:
> +		case ADE9078_ST1_ZXTOVC_BIT:
> +		case ADE9078_ST1_ZXIC_BIT:
> +			iio_push_event(indio_dev,
> +				       IIO_UNMOD_EVENT_CODE(chan->type,
> +							    ADE9078_PHASE_C_NR,
> +							    IIO_EV_TYPE_THRESH,
> +							    IIO_EV_DIR_EITHER),
> +				       timestamp);
> +			break;
> +		default:
> +			goto irq1_done;
> +		}
> +	}
> +
> +irq1_done:
> +	return IRQ_HANDLED;
> +}
> +
> +/*
> + * ade9078_configure_scan() - sets up the transfer parameters
> + * as well as the tx and rx buffers
> + * @indio_dev:	the IIO device
> + */
> +static int ade9078_configure_scan(struct iio_dev *indio_dev)
> +{
> +	struct ade9078_state *st = iio_priv(indio_dev);
> +	u16 addr;
> +
> +	addr = FIELD_PREP(ADE9078_REG_ADDR_MASK, ADE9078_REG_WF_BUFF) |
> +	       ADE9078_REG_READ_BIT_MASK;
> +
> +	put_unaligned_be16(addr, st->tx_buff);
> +
> +	st->xfer[0].tx_buf = &st->tx_buff[0];
> +	st->xfer[0].len = 2;
> +
> +	st->xfer[1].rx_buf = &st->rx_buff.byte[0];
> +	st->xfer[1].len = ADE9078_WFB_FULL_BUFF_SIZE;
> +
> +	spi_message_init_with_transfers(&st->spi_msg, st->xfer, 2);
> +	return 0;
> +}
> +
> +/*
> + * ade9078_read_raw() - IIO read function
> + * @indio_dev:	the IIO device
> + * @chan:	channel specs of the ade9078
> + * @val:	first half of the read value
> + * @val2:	second half of the read value
> + * @mask:	info mask of the channel
> + */
> +static int ade9078_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int *val,
> +			    int *val2,
> +			    long mask)
> +{
> +	struct ade9078_state *st = iio_priv(indio_dev);
> +	int measured;
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret = iio_device_claim_direct_mode(indio_dev);
> +		if (ret)
> +			return ret;
> +
> +		ret = regmap_read(st->regmap, chan->address, &measured);

> +
> +		iio_device_release_direct_mode(indio_dev);
> +		*val = measured;
Convention is to only set values on no error.
so

		if (ret)
			return ret;

		*val = measured;

		return IIO_VAL_INT;


> +
> +		return ret ?: IIO_VAL_INT;
> +
> +	case IIO_CHAN_INFO_SCALE:
> +		if (chan->type == IIO_CURRENT || chan->type == IIO_VOLTAGE) {
> +			switch (chan->address) {
> +			case ADE9078_REG_AI_PCF:
> +			case ADE9078_REG_AV_PCF:
> +			case ADE9078_REG_BI_PCF:
> +			case ADE9078_REG_BV_PCF:
> +			case ADE9078_REG_CI_PCF:
> +			case ADE9078_REG_CV_PCF:
> +				*val = 1;
> +				*val2 = ADE9078_PCF_FULL_SCALE_CODES;
> +				return IIO_VAL_FRACTIONAL;
> +			case ADE9078_REG_AIRMS:
> +			case ADE9078_REG_AVRMS:
> +			case ADE9078_REG_BIRMS:
> +			case ADE9078_REG_BVRMS:
> +			case ADE9078_REG_CIRMS:
> +			case ADE9078_REG_CVRMS:
> +				*val = 1;
> +				*val2 = ADE9078_RMS_FULL_SCALE_CODES;
> +				return IIO_VAL_FRACTIONAL;
> +			default:
> +				return -EINVAL;
> +			}
> +		} else if (chan->type == IIO_POWER) {
> +			*val = 1;
> +			*val2 = ADE9000_WATT_FULL_SCALE_CODES;
> +			return IIO_VAL_FRACTIONAL;
> +		} else {
> +			return -EINVAL;
> +		}
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
I don't think you can reach this.

> +}
> +
> +/*
> + * ade9078_write_raw() - IIO write function
> + * @indio_dev:	the IIO device
> + * @chan:	channel specs of the ade9078
> + * @val:	first half of the read value
> + * @val2:	second half of the read value
> + * @mask:	info mask of the channel
> + */
> +static int ade9078_write_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     int val,
> +			     int val2,
> +			     long mask)
> +{
> +	struct ade9078_state *st = iio_priv(indio_dev);
> +	u32 addr = 0xFFFFF;

If that value is used, something went wrong.  I don't think it is, so don't
assign it.

> +	u32 tmp;
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_OFFSET:
> +		switch (chan->type) {
> +		case IIO_CURRENT:
> +			addr = ADE9078_ADDR_ADJUST(ADE9078_REG_AIRMSOS,
> +						   chan->channel);
> +			break;
> +		case IIO_VOLTAGE:
> +			addr = ADE9078_ADDR_ADJUST(ADE9078_REG_AVRMSOS,
> +						   chan->channel);
> +			break;
> +		case IIO_POWER:
> +			tmp = chan->address;
> +			tmp &= ~ADE9078_PHASE_B_POS_BIT;
> +			tmp &= ~ADE9078_PHASE_C_POS_BIT;
> +
> +			switch (tmp) {
> +			case ADE9078_REG_AWATTOS:
> +				addr = ADE9078_ADDR_ADJUST(ADE9078_REG_AWATTOS,
> +							   chan->channel);
> +				break;
> +			case ADE9078_REG_AVAR:
> +				addr = ADE9078_ADDR_ADJUST(ADE9078_REG_AVAROS,
> +							   chan->channel);
> +				break;
> +			case ADE9078_REG_AFVAR:
> +				addr = ADE9078_ADDR_ADJUST(ADE9078_REG_AFVAROS,
> +							   chan->channel);
> +				break;
> +			default:
> +				return -EINVAL;
> +			}
> +
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +		break;
> +	case IIO_CHAN_INFO_HARDWAREGAIN:
> +		switch (chan->type) {
> +		case IIO_CURRENT:
> +			addr = ADE9078_ADDR_ADJUST(ADE9078_REG_AIGAIN,
> +						   chan->channel);
> +			break;
> +		case IIO_VOLTAGE:
> +			addr = ADE9078_ADDR_ADJUST(ADE9078_REG_AVGAIN,
> +						   chan->channel);
> +			break;
> +		case IIO_POWER:
> +			addr = ADE9078_ADDR_ADJUST(ADE9078_REG_APGAIN,
> +						   chan->channel);
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	ret = regmap_write(st->regmap, addr, val);
> +	return ret;

return regmap_write()

> +}
> +
> +/*
> + * ade9078_reg_access() - IIO debug register access
> + * @indio_dev:	the IIO device
> + * @reg:	register to be accessed
> + * @tx_val:	value to be transmitted
> + * @rx_val:	value to be received
> + */
> +static int ade9078_reg_access(struct iio_dev *indio_dev,
> +			      unsigned int reg,
> +			      unsigned int tx_val,
> +			      unsigned int *rx_val)
> +{
> +	struct ade9078_state *st = iio_priv(indio_dev);
> +
> +	if (rx_val)
> +		return regmap_read(st->regmap, reg, rx_val);
> +
> +	return regmap_write(st->regmap, reg, tx_val);
> +}
> +
> +/*
> + * ade9078_write_event_config() - IIO event configure to enable zero-crossing

All these function description comments should be valid kernel-doc.

> + * and zero-crossing timeout on voltage and current for each phases. These
> + * events will also influence the trigger conditions for the buffer capture.
> + */
> +static int ade9078_write_event_config(struct iio_dev *indio_dev,
> +				      const struct iio_chan_spec *chan,
> +				      enum iio_event_type type,
> +				      enum iio_event_direction dir,
> +				      int state)
> +{
> +	struct ade9078_state *st = iio_priv(indio_dev);
> +	u32 interrupts;
> +	u32 number;
> +	int ret;
> +
> +	number = chan->channel;
> +
> +	switch (number) {
> +	case ADE9078_PHASE_A_NR:

I would use a lookup on the phase into an array of structures.
The structure would then have fields for which bit to set etc
for a voltage channel and for a current channel.

That way this all becomes one bit of code and some const data
rather that 3 sets of near identical code. If you can make
this sort of thing data rather than code that is almost always
the best choice.

> +		if (chan->type == IIO_VOLTAGE) {
> +			if (state) {
> +				interrupts |= ADE9078_ST1_ZXVA_BIT;
> +				interrupts |= ADE9078_ST1_ZXTOVA_BIT;
> +				st->wfb_trg |= ADE9078_WFB_TRG_ZXVA_BIT;
> +			} else {
> +				interrupts &= ~ADE9078_ST1_ZXVA_BIT;
> +				interrupts &= ~ADE9078_ST1_ZXTOVA_BIT;
> +				st->wfb_trg &= ~ADE9078_WFB_TRG_ZXVA_BIT;
> +			}
> +		} else if (chan->type == IIO_CURRENT) {
> +			if (state) {
> +				interrupts |= ADE9078_ST1_ZXIA_BIT;
> +				st->wfb_trg |= ADE9078_WFB_TRG_ZXIA_BIT;
> +			} else {
> +				interrupts &= ~ADE9078_ST1_ZXIA_BIT;
> +				st->wfb_trg &= ~ADE9078_WFB_TRG_ZXIA_BIT;
> +			}
> +		}
> +		break;
> +	case ADE9078_PHASE_B_NR:
> +		if (chan->type == IIO_VOLTAGE) {
> +			if (state) {
> +				interrupts |= ADE9078_ST1_ZXVB_BIT;
> +				interrupts |= ADE9078_ST1_ZXTOVB_BIT;
> +				st->wfb_trg |= ADE9078_WFB_TRG_ZXVB_BIT;
> +			} else {
> +				interrupts &= ~ADE9078_ST1_ZXVB_BIT;
> +				interrupts &= ~ADE9078_ST1_ZXTOVB_BIT;
> +				st->wfb_trg &= ~ADE9078_WFB_TRG_ZXVB_BIT;
> +			}
> +		} else if (chan->type == IIO_CURRENT) {
> +			if (state) {
> +				interrupts |= ADE9078_ST1_ZXIB_BIT;
> +				st->wfb_trg |= ADE9078_WFB_TRG_ZXIB_BIT;
> +			} else {
> +				interrupts &= ~ADE9078_ST1_ZXIB_BIT;
> +				st->wfb_trg &= ~ADE9078_WFB_TRG_ZXIB_BIT;
> +			}
> +		}
> +		break;
> +	case ADE9078_PHASE_C_NR:
> +		if (chan->type == IIO_VOLTAGE) {
> +			if (state) {
> +				interrupts |= ADE9078_ST1_ZXVC_BIT;
> +				interrupts |= ADE9078_ST1_ZXTOVC_BIT;
> +				st->wfb_trg |= ADE9078_WFB_TRG_ZXVC_BIT;
> +			} else {
> +				interrupts &= ~ADE9078_ST1_ZXVC_BIT;
> +				interrupts &= ~ADE9078_ST1_ZXTOVC_BIT;
> +				st->wfb_trg &= ~ADE9078_WFB_TRG_ZXVC_BIT;
> +			}
> +		} else if (chan->type == IIO_CURRENT) {
> +			if (state) {
> +				interrupts |= ADE9078_ST1_ZXIC_BIT;
> +				st->wfb_trg |= ADE9078_WFB_TRG_ZXIC_BIT;
> +			} else {
> +				interrupts &= ~ADE9078_ST1_ZXIC_BIT;
> +				st->wfb_trg &= ~ADE9078_WFB_TRG_ZXIC_BIT;
> +			}
> +		}
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	ret = regmap_write(st->regmap, ADE9078_REG_STATUS1, GENMASK(31, 0));
> +	if (ret)
> +		return ret;
> +
> +	return regmap_update_bits(st->regmap, ADE9078_REG_MASK1, interrupts,
> +				  interrupts);
> +}
> +
> +/*
> + * ade9078_read_event_vlaue() - Outputs the result of the zero-crossing for
> + * voltage and current for each phase.
> + * Result:
> + * 0 - if crossing event not set
> + * 1 - if crossing event occurred
> + * -1 - if crossing timeout (only for Voltages)
> + */
> +static int ade9078_read_event_vlaue(struct iio_dev *indio_dev,

value?  If so, this should be reading the thresholds, not anything
about current status of events. 


> +				    const struct iio_chan_spec *chan,
> +				    enum iio_event_type type,
> +				    enum iio_event_direction dir,
> +				    enum iio_event_info info,
> +				    int *val, int *val2)
> +{
> +	struct ade9078_state *st = iio_priv(indio_dev);
> +	u32 handeled_irq = 0;

handled

> +	u32 interrupts;
> +	u32 number;
> +	u32 status;
> +	int ret;
> +
> +	ret = regmap_read(st->regmap, ADE9078_REG_STATUS1, &status);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_read(st->regmap, ADE9078_REG_MASK1, &interrupts);
> +	if (ret)
> +		return ret;
> +
> +	*val = 0;
> +	number = chan->channel;
> +	switch (number) {
> +	case ADE9078_PHASE_A_NR:
> +		if (chan->type == IIO_VOLTAGE) {
> +			if (status & ADE9078_ST1_ZXVA_BIT) {
> +				*val = 1;
> +				handeled_irq |= ADE9078_ST1_ZXVA_BIT;
> +			} else if (status & ADE9078_ST1_ZXTOVA_BIT) {
> +				*val = -1;
> +				handeled_irq |= ADE9078_ST1_ZXTOVA_BIT;
> +			}
> +			if (!(interrupts & ADE9078_ST1_ZXTOVA_BIT))
> +				*val = 0;
> +		} else if (chan->type == IIO_CURRENT) {
> +			if (status & ADE9078_ST1_ZXIA_BIT) {
> +				*val = 1;
> +				handeled_irq |= ADE9078_ST1_ZXIA_BIT;
> +			}
> +		}
> +		break;
> +	case ADE9078_PHASE_B_NR:
> +		if (chan->type == IIO_VOLTAGE) {
> +			if (status & ADE9078_ST1_ZXVB_BIT) {
> +				*val = 1;
> +				handeled_irq |= ADE9078_ST1_ZXVB_BIT;
> +			} else if (status & ADE9078_ST1_ZXTOVB_BIT) {
> +				*val = -1;
> +				handeled_irq |= ADE9078_ST1_ZXTOVB_BIT;
> +			}
> +			if (!(interrupts & ADE9078_ST1_ZXTOVB_BIT))
> +				*val = 0;
> +		} else if (chan->type == IIO_CURRENT) {
> +			if (status & ADE9078_ST1_ZXIB_BIT) {
> +				*val = 1;
> +				handeled_irq |= ADE9078_ST1_ZXIB_BIT;
> +			}
> +		}
> +		break;
> +	case ADE9078_PHASE_C_NR:
> +		if (chan->type == IIO_VOLTAGE) {
> +			if (status & ADE9078_ST1_ZXVC_BIT) {
> +				*val = 1;
> +				handeled_irq |= ADE9078_ST1_ZXVC_BIT;
> +			} else if (status & ADE9078_ST1_ZXTOVC_BIT) {
> +				*val = -1;
> +				handeled_irq |= ADE9078_ST1_ZXTOVC_BIT;
> +			}
> +			if (!(interrupts & ADE9078_ST1_ZXTOVC_BIT))
> +				*val = 0;
> +		} else if (chan->type == IIO_CURRENT) {
> +			if (status & ADE9078_ST1_ZXIC_BIT) {
> +				*val = 1;
> +				handeled_irq |= ADE9078_ST1_ZXIC_BIT;
> +			}
> +		}
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	ret = regmap_write(st->regmap, ADE9078_REG_STATUS1, handeled_irq);
Are there other bits, or is this always going to write all bits that
might be set? If it is all such bits then 
> +	if (ret)
> +		return ret;
> +
> +	return IIO_VAL_INT;
> +}
> +
> +/*
> + * ade9078_config_wfb() - reads the ade9078 node and configures the wave form
> + * buffer based on the options set. Additionally is reads the active scan mask
> + * in order to set the input data of the buffer. There are only a few available
> + * input configurations permitted by the IC, any unpermitted configuration will
> + * result in all channels being active.
> + * @indio_dev:	the IIO device

Make this valid kernel-doc.  Then check for any warnings by running the
kernel-doc build scripts.


> + */
> +static int ade9078_config_wfb(struct iio_dev *indio_dev)
> +{
> +	struct ade9078_state *st = iio_priv(indio_dev);
> +	u32 wfg_cfg_val = 0;
> +	u32 tmp;
> +	int ret;
> +
> +	bitmap_to_arr32(&wfg_cfg_val, indio_dev->active_scan_mask,
> +			indio_dev->masklength);
> +
> +	switch (wfg_cfg_val) {

Use another variable so that this becomes more readable.

> +	case ADE9078_SCAN_POS_IA | ADE9078_SCAN_POS_VA:
> +		wfg_cfg_val = 0x1;
> +		break;
> +	case ADE9078_SCAN_POS_IB | ADE9078_SCAN_POS_VB:
> +		wfg_cfg_val = 0x2;
> +		break;
> +	case ADE9078_SCAN_POS_IC | ADE9078_SCAN_POS_VC:
> +		wfg_cfg_val = 0x3;
> +		break;
> +	case ADE9078_SCAN_POS_IA:
> +		wfg_cfg_val = 0x8;
> +		break;
> +	case ADE9078_SCAN_POS_VA:
> +		wfg_cfg_val = 0x9;
> +		break;
> +	case ADE9078_SCAN_POS_IB:
> +		wfg_cfg_val = 0xA;
> +		break;
> +	case ADE9078_SCAN_POS_VB:
> +		wfg_cfg_val = 0xB;
> +		break;
> +	case ADE9078_SCAN_POS_IC:
> +		wfg_cfg_val = 0xC;
> +		break;
> +	case ADE9078_SCAN_POS_VC:
> +		wfg_cfg_val = 0xD;
> +		break;
> +	default:
> +		wfg_cfg_val = 0x0;
> +		break;
> +	}
> +
> +	ret = of_property_read_u32((&st->spi->dev)->of_node, "adi,wf-cap-sel",
> +				   &tmp);

Generic device properties form include/linux/properties.h only for new IIO drivers
unless there is a very strong reason why it won't work.


> +	if (ret) {
> +		dev_err(&st->spi->dev, "Failed to get wf-cap-sel: %d\n", ret);
> +		return ret;
> +	}
> +	wfg_cfg_val |= FIELD_PREP(ADE9078_WF_CAP_SEL_MASK, tmp);
> +
> +	ret = of_property_read_u32((&st->spi->dev)->of_node, "adi,wf-mode",
> +				   &tmp);
> +	if (ret) {
> +		dev_err(&st->spi->dev, "Failed to get wf-mode: %d\n", ret);
> +		return ret;
> +	}
> +	wfg_cfg_val |= FIELD_PREP(ADE9078_WF_MODE_MASK, tmp);
> +	st->wf_mode = tmp;
> +
> +	ret = of_property_read_u32((&st->spi->dev)->of_node, "adi,wf-src",
> +				   &tmp);
> +	if (ret) {
> +		dev_err(&st->spi->dev,
> +			"Failed to get wf-src: %d\n",
> +			ret);
> +		return ret;
> +	}
> +	wfg_cfg_val |= FIELD_PREP(ADE9078_WF_SRC_MASK, tmp);
> +
> +	ret = of_property_read_u32((&st->spi->dev)->of_node, "adi,wf-in-en",
> +				   &tmp);
> +	if (ret) {
> +		dev_err(&st->spi->dev, "Failed to get wf-in-en: %d\n", ret);
> +		return ret;
> +	}
> +	wfg_cfg_val |= FIELD_PREP(ADE9078_WF_IN_EN_MASK, tmp);
> +
> +	return regmap_write(st->regmap, ADE9078_REG_WFB_CFG, wfg_cfg_val);
> +}
> +
> +/*
> + * ade9078_wfb_interrupt_setup() - Configures the wave form buffer interrupt
> + * according to modes
> + * @st:		ade9078 device data
> + * @mode:	modes according to datasheet; values [0-2]
> + *
> + * This sets the interrupt register and other registers related to the
> + * interrupts according to mode [0-2] from the datasheet
> + */
> +static int ade9078_wfb_interrupt_setup(struct ade9078_state *st, u8 mode)
> +{
> +	int ret;
> +
> +	ret = regmap_write(st->regmap, ADE9078_REG_WFB_TRG_CFG, 0x0);
> +	if (ret)
> +		return ret;
> +
> +	if (mode == ADE9078_WFB_FULL_MODE || mode == ADE9078_WFB_EN_TRIG_MODE) {

A switch statement would be cleaner here.

> +		ret = regmap_write(st->regmap, ADE9078_REG_WFB_PG_IRQEN,
> +				   ADE9078_MODE_0_1_PAGE_BIT);
> +		if (ret)
> +			return ret;
> +	} else if (mode == ADE9078_WFB_C_EN_TRIG_MODE) {
> +		ret = regmap_write(st->regmap, ADE9078_REG_WFB_PG_IRQEN,
> +				   ADE9078_MODE_2_PAGE_BIT);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret = regmap_write(st->regmap, ADE9078_REG_STATUS0, GENMASK(31, 0));
> +	if (ret)
> +		return ret;
> +
> +	return regmap_update_bits(st->regmap, ADE9078_REG_MASK0,
> +				  ADE9078_ST0_PAGE_FULL_BIT,
> +				  ADE9078_ST0_PAGE_FULL_BIT);
> +	if (ret)

Unreachable code...

> +		return ret;
> +
> +	return 0;
> +}
> +
> +/*
> + * ade9078_buffer_preenable() - configures the waveform buffer, sets the
> + * interrupts and enables the buffer
> + * @indio_dev:	the IIO device
> + */
> +static int ade9078_buffer_preenable(struct iio_dev *indio_dev)
> +{
> +	struct ade9078_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	ret = ade9078_config_wfb(indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = ade9078_wfb_interrupt_setup(st, st->wf_mode);
> +	if (ret)
> +		return ret;
> +
> +	ret = ade9078_en_wfb(st, true);
> +	if (ret) {
> +		dev_err(&st->spi->dev, "Post-enable wfb enable fail");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * ade9078_buffer_postdisable() - after the iio is disable
> + * this will disable the ade9078 internal buffer for acquisition
> + * @indio_dev:	the IIO device
> + */
> +static int ade9078_buffer_postdisable(struct iio_dev *indio_dev)
> +{
> +	struct ade9078_state *st = iio_priv(indio_dev);
> +	u32 interrupts = 0;
> +	int ret;
> +
> +	ret = ade9078_en_wfb(st, false);
> +	if (ret) {
> +		dev_err(&st->spi->dev, "Post-disable wfb disable fail");
> +		return ret;
> +	}
> +
> +	ret = regmap_write(st->regmap, ADE9078_REG_WFB_TRG_CFG, 0x0);
> +	if (ret)
> +		return ret;
> +
> +	interrupts |= ADE9078_ST0_WFB_TRIG_BIT;
> +	interrupts |= ADE9078_ST0_PAGE_FULL_BIT;
> +
> +	return regmap_update_bits(st->regmap, ADE9078_REG_MASK0, interrupts, 0);
> +	if (ret) {
> +		dev_err(&st->spi->dev, "Post-disable update maks0 fail");
> +		return ret;
> +	}
> +
> +	ret = regmap_write(st->regmap, ADE9078_REG_STATUS0, GENMASK(31, 0));
> +	if (ret)
> +		return ret;
> +
> +	return 0;

return regmap_write()...

> +}
> +
> +/*
> + * ade9078_setup_iio_channels() - parses the phase nodes of the device-tree and
> + * creates the iio channels based on the active phases in the DT.
> + * @st:		ade9078 device data
> + */
> +static int ade9078_setup_iio_channels(struct ade9078_state *st)
> +{
> +	struct fwnode_handle *phase_node = NULL;
> +	struct device *dev = &st->spi->dev;
> +	struct iio_chan_spec *chan;
> +	u32 phase_nr;
> +	int ret;
> +
> +	chan = devm_kcalloc(dev,
> +			    ADE9078_MAX_PHASE_NR *
> +			    ARRAY_SIZE(ade9078_a_channels),
> +			    sizeof(*ade9078_a_channels), GFP_KERNEL);
> +	if (!chan) {
> +		dev_err(dev, "Unable to allocate ADE9078 channels");
> +		return -ENOMEM;
> +	}
> +	st->indio_dev->num_channels = 0;
> +	st->indio_dev->channels = chan;
> +
> +	fwnode_for_each_available_child_node(dev_fwnode(dev), phase_node) {
> +		ret = fwnode_property_read_u32(phase_node, "reg", &phase_nr);
> +		if (ret) {
> +			dev_err(dev, "Could not read channel reg : %d\n", ret);
> +			return ret;
> +		}
> +
> +		switch (phase_nr) {
> +		case ADE9078_PHASE_A_NR:
> +			memcpy(chan, ade9078_a_channels,
> +			       sizeof(ade9078_a_channels));
> +			break;
> +		case ADE9078_PHASE_B_NR:
> +			memcpy(chan, ade9078_b_channels,
> +			       sizeof(ade9078_b_channels));
> +			break;
> +		case ADE9078_PHASE_C_NR:
> +			memcpy(chan, ade9078_c_channels,
> +			       sizeof(ade9078_c_channels));
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +
> +		chan += AD9078_CHANNELS_PER_PHASE;
> +		st->indio_dev->num_channels += AD9078_CHANNELS_PER_PHASE;
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * ade9078_reset() - Reset sequence for the ADE9078, the hardware reset is
> + * optional in the DT. When no hardware reset has been declared a software
> + * reset is executed
> + * @st:		ade9078 device data
> + */
> +static int ade9078_reset(struct ade9078_state *st)
> +{
> +	struct gpio_desc *gpio_reset;
> +	int ret;
> +
> +	st->rst_done = false;
> +
> +	gpio_reset = devm_gpiod_get_optional(&st->spi->dev, "reset",
> +					     GPIOD_OUT_HIGH);
> +	if (IS_ERR(gpio_reset))
> +		return PTR_ERR(gpio_reset);
> +
> +	if (gpio_reset) {
> +		gpiod_set_value_cansleep(gpio_reset, 1);
> +		usleep_range(1, 100);
> +		gpiod_set_value_cansleep(gpio_reset, 0);
> +		msleep_interruptible(50);
> +	} else {
> +		ret = regmap_update_bits(st->regmap, ADE9078_REG_CONFIG1,
> +					 ADE9078_SWRST_BIT, ADE9078_SWRST_BIT);
> +		if (ret)
> +			return ret;
> +		usleep_range(80, 100);
> +	}
> +
> +	if (!st->rst_done)

Why EPERM?  Seems more like an IO error

> +		return -EPERM;
> +
> +	return 0;
> +}
> +
> +/*
> + * ade9078_setup() - initial register setup of the ade9078
> + * @st:		ade9078 device data
> + */
> +static int ade9078_setup(struct ade9078_state *st)
> +{
> +	int ret = 0;
The value here is never used.

Make sure you run a bunch of build tests including setting W=1 and ensuring it
is clean + run at very least sparse.  Some of those tests would warn about this.

> +
> +	ret = regmap_multi_reg_write(st->regmap, ade9078_reg_sequence,
> +				     ARRAY_SIZE(ade9078_reg_sequence));
> +	if (ret)
> +		return ret;
> +
> +	msleep_interruptible(2);
> +
> +	ret = regmap_write(st->regmap, ADE9078_REG_STATUS0, GENMASK(31, 0));
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(st->regmap, ADE9078_REG_STATUS1, GENMASK(31, 0));

return regmap_write()

> +	if (ret)
> +		return ret;
> +
> +	return ret;
> +}
> +
> +static const struct iio_buffer_setup_ops ade9078_buffer_ops = {
> +	.preenable = &ade9078_buffer_preenable,
> +	.postdisable = &ade9078_buffer_postdisable,
> +};
> +
> +static const struct iio_info ade9078_info = {
> +	.read_raw = &ade9078_read_raw,
> +	.write_raw = &ade9078_write_raw,
> +	.debugfs_reg_access = &ade9078_reg_access,
> +	.write_event_config = &ade9078_write_event_config,
> +	.read_event_value = &ade9078_read_event_vlaue,

> +};
> +
> +/*
> + * Regmap configuration
> + * The register access of the ade9078 requires a 16 bit address
> + * with the read flag on bit 3. This is not supported by default
> + * regmap functionality, thus reg_read and reg_write have been
> + * replaced with custom functions

How big would the changes needed to support this in the regmap
core be?   Superficially I can't immediately see why it won't work.
regmap appears to support setting flags in any of the address bytes
as it uses regmap_set_work_buf_flag_mask() internally and
that will set bits in any of the reg_bits/8 bytes.

> + */
> +static const struct regmap_config ade9078_regmap_config = {
> +	.reg_bits = 16,
> +	.val_bits = 32,
> +	.zero_flag_mask = true,
> +	.cache_type = REGCACHE_RBTREE,
> +	.reg_read = ade9078_spi_read_reg,
> +	.reg_write = ade9078_spi_write_reg,
> +	.volatile_reg = ade9078_is_volatile_reg,
> +};
> +
> +static int ade9078_probe(struct spi_device *spi)
> +{
> +	struct iio_dev *indio_dev;
> +	struct ade9078_state *st;
> +	unsigned long irqflags;
> +	struct regmap *regmap;
> +	int irq;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
> +	if (!indio_dev) {
> +		dev_err(&spi->dev, "Unable to allocate ADE9078 IIO");
> +		return -ENOMEM;
> +	}
> +	st = iio_priv(indio_dev);
> +	if (!st) {
> +		dev_err(&spi->dev,
> +			"Unable to allocate ADE9078 device structure");

This can't fail. So drop this check.

> +		return -ENOMEM;
> +	}
> +
> +	st->rx = devm_kcalloc(&spi->dev, ADE9078_RX_DEPTH, sizeof(*st->rx),
> +			      GFP_KERNEL);

Avoid having multiple small allocations like this by making them part of
the iio_priv() structure. 

> +	if (!st->rx)
> +		return -ENOMEM;
> +
> +	st->tx = devm_kcalloc(&spi->dev, ADE9078_TX_DEPTH, sizeof(*st->tx),
> +			      GFP_KERNEL);
> +	if (!st->tx)
> +		return -ENOMEM;
> +
> +	regmap = devm_regmap_init(&spi->dev, NULL, spi, &ade9078_regmap_config);

Probably better to pass the iio_device structure and have a pointer to
spi in there.

> +	if (IS_ERR(regmap))	{
> +		dev_err(&spi->dev, "Unable to allocate ADE9078 regmap");
> +		return PTR_ERR(regmap);
> +	}
> +	spi_set_drvdata(spi, st);

This shouldn't be needed after you've changed the passed context to provide
the iio_dev structure and you can then call iio_priv() on that.


> +
> +	irq = of_irq_get_byname((&spi->dev)->of_node, "irq0");
> +	if (irq < 0) {
> +		dev_err(&spi->dev, "Unable to find irq0");
> +		return -EINVAL;
> +	}
> +	irqflags = irq_get_trigger_type(irq);
> +	ret = devm_request_threaded_irq(&spi->dev, irq, NULL,
> +					ade9078_irq0_thread,
> +					irqflags | IRQF_ONESHOT,
> +					KBUILD_MODNAME, st);
> +	if (ret) {
> +		dev_err(&spi->dev, "Failed to request threaded irq: %d\n", ret);
> +		return ret;
> +	}
> +
> +	irq = of_irq_get_byname((&spi->dev)->of_node, "irq1");

A generic firmware properties version of irq_get_by_name is queued in
the i2c tree.  Please use that here and mention it in the
patch description / cover letter.  I'll probably have pulled it into
IIO shortly anyway.

https://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git/commit/?h=i2c/alert-for-acpi&id=ca0acb511c21738b32386ce0f85c284b351d919e

> +	if (irq < 0) {
> +		dev_err(&spi->dev, "Unable to find irq1");
> +		return -EINVAL;
> +	}

blank line after error checks like this make things more readable (slightly)

> +	irqflags = irq_get_trigger_type(irq);
> +	ret = devm_request_threaded_irq(&spi->dev, irq, NULL,
> +					ade9078_irq1_thread,
> +					irqflags | IRQF_ONESHOT,

You shouldn't need to read and then feed through the flags.
Unless something unusual is going on this will have the same
affect as just passing IRQF_ONESHOT.


> +					KBUILD_MODNAME, st);
> +	if (ret) {
> +		dev_err(&spi->dev, "Failed to request threaded irq: %d\n", ret);
> +		return ret;
> +	}
> +
> +	st->spi = spi;
> +
> +	indio_dev->dev.parent = &st->spi->dev;
> +	indio_dev->info = &ade9078_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	st->regmap = regmap;
> +	st->indio_dev = indio_dev;
> +	ade9078_setup_iio_channels(st);
> +	if (ret) {

ret = ade9078_setup_iio_channels(st);

> +		dev_err(&spi->dev, "Failed to set up IIO channels");
> +		return ret;
> +	}
> +
> +	ret = ade9078_configure_scan(indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_iio_kfifo_buffer_setup(&spi->dev, indio_dev,
> +					  INDIO_BUFFER_SOFTWARE,
> +					  &ade9078_buffer_ops);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_iio_device_register(&spi->dev, indio_dev);

Anything happening in probe after this call is usually a bad sign because
this is the point at which userspace interfaces are exposed - hence it
normally comes last to avoid any potential race condtions.

> +	if (ret) {
> +		dev_err(&spi->dev, "Unable to register IIO device");
> +		return ret;
> +	}
> +
> +	ret = ade9078_reset(st);
> +	if (ret) {
> +		dev_err(&spi->dev, "ADE9078 reset failed");
> +		return ret;
> +	}
> +
> +	ret = ade9078_setup(st);
> +	if (ret) {
> +		dev_err(&spi->dev, "Unable to setup ADE9078");
> +		return ret;
> +	}
> +
> +	return ret;
> +};
> +
> +static const struct spi_device_id ade9078_id[] = {
> +		{"ade9078", 0},
> +		{}
> +};
> +MODULE_DEVICE_TABLE(spi, ade9078_id);
> +
> +static const struct of_device_id ade9078_of_match[] = {
> +	{ .compatible = "adi,ade9078" },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, ade9078_of_match);
> +
> +static struct spi_driver ade9078_driver = {
> +		.driver = {
> +			.name = "ade9078",
> +		},
> +		.probe = ade9078_probe,
> +		.id_table = ade9078_id,
> +};
> +module_spi_driver(ade9078_driver);
> +
> +MODULE_AUTHOR("Ciprian Hegbeli <ciprian.hegbeli@analog.com>");
> +MODULE_DESCRIPTION("Analog Devices ADE9078 High Performance,Polyphase Energy Metering IC Driver");

Shorter might be good.  Could definitely drop "High Performance" without changing the useful
content in a driver description :)

> +MODULE_LICENSE("GPL v2");

