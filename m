Return-Path: <linux-iio+bounces-22856-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EBA2B2902C
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 21:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 381234E02A5
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 19:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA0A1FBE80;
	Sat, 16 Aug 2025 19:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RZfr9Kv+"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE44450F2;
	Sat, 16 Aug 2025 19:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755371339; cv=none; b=edVtGSzpsAkEDw8/To0QEb5jdLOgxUPEtRKS/7+/c9boqxktWKz8ZBnYk8YIzs//sOghnOT2x63dpBbMIdL2jS5sFQe25vwGkLXNIQ3fq2sL55GGU1w+E4jzB1pS3Q5UIgpPc5PeyrS0wnMgIoL02fiqjv3FpWh8PLl7I7/Wm8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755371339; c=relaxed/simple;
	bh=AVGPw+w9ewcE0ACguMpjCuUVw8+OlHhBQDQTiqYvydE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OUxbzQSOSzC50GNl2A+8SrT+Er4y+hNqnfgC2GDQFodP8qu9olzkWTEE3JfTZ8XOdB1YAcYJj1ogoLn6vi36VJeFdjX/r53/Ac1zSggCuS6zwiygHp0FMMkjEYsLOh61c5Ek2B6ZP1YEDVrIKmbcH6hpAgMQ/9GY1fYsWD8/ZoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RZfr9Kv+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A2E5C4CEEF;
	Sat, 16 Aug 2025 19:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755371338;
	bh=AVGPw+w9ewcE0ACguMpjCuUVw8+OlHhBQDQTiqYvydE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RZfr9Kv+eY96nmJ66lq40LhnRMwb6kUO+tOXvYUG+nhiLvhRAfRsPXqubZv+TMTPV
	 tTKraLQHmOuLaSBWoEq62ejsj+hU8EP3LjFp1dDXlk1me/YRyoLdw1nYQkNupLzkbr
	 fSwxb6LcI91Um7AFkFH6L6WTZRrzC2cbe3hfCKsyfG08pe1y3clpCyTb+KE3LRSXEK
	 EclWHn0Th2eaQQeGvG716Ep7U6+87CKvGgTT/A/3qQHrhs7uVKUolpeOhLCTsJLg2N
	 CPcWG6iDHe1eBVVv1wE8cJ10LVL2yJIHgIBrLWl607k4BDRGpC76DGWMtih57SB7K1
	 ZVJFSwIun9oBA==
Date: Sat, 16 Aug 2025 20:08:52 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: <robh@kernel.org>, <conor+dt@kernel.org>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH v4 4/5] iio: adc: add ade9000 support
Message-ID: <20250816200852.560cd552@jic23-huawei>
In-Reply-To: <20250815095713.9830-5-antoniu.miclaus@analog.com>
References: <20250815095713.9830-1-antoniu.miclaus@analog.com>
	<20250815095713.9830-5-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 15 Aug 2025 09:56:37 +0000
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Add driver support for the ade9000. highly accurate,
> fully integrated, multiphase energy and power quality
> monitoring device.
Short wrap. Aim for 75 chars, so something like:

Add driver support for the ade9000. highly accurate, fully integrated,
multiphase energy and power quality monitoring device.

>=20
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>

Hi Antoniu

I don't normally ask for detailed documentation files for a given
device - though often ADI drivers do now come with them which is great.
In this case there is enough 'unusual' use of ABI I would definitely like
such a document.  That way we can clearly lay out the meaning of
things like _offset and the _sampling_frequency stuff below and spot
any oddities more easily than reading a 2000+ line code patch.


Various other comments inline.

Jonathan

> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index 1c6ca5fd4b6d..e3ef416a3b5b 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -46,6 +46,7 @@ obj-$(CONFIG_AD7944) +=3D ad7944.o
>  obj-$(CONFIG_AD7949) +=3D ad7949.o
>  obj-$(CONFIG_AD799X) +=3D ad799x.o
>  obj-$(CONFIG_AD9467) +=3D ad9467.o
> +obj-$(CONFIG_ADE9000) +=3D ade9000.o
>  obj-$(CONFIG_ADI_AXI_ADC) +=3D adi-axi-adc.o
>  obj-$(CONFIG_ASPEED_ADC) +=3D aspeed_adc.o
>  obj-$(CONFIG_AT91_ADC) +=3D at91_adc.o
> diff --git a/drivers/iio/adc/ade9000.c b/drivers/iio/adc/ade9000.c
> new file mode 100644
> index 000000000000..1961feb68b49
> --- /dev/null
> +++ b/drivers/iio/adc/ade9000.c
> @@ -0,0 +1,2051 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/**
> + * ADE9000 driver
> + *
> + * Copyright 2025 Analog Devices Inc.
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/clk.h>
> +#include <linux/clk-provider.h>
> +#include <linux/completion.h>
> +#include <linux/delay.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/interrupt.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/kfifo_buf.h>
> +#include <linux/iio/events.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/interrupt.h>
> +#include <linux/minmax.h>
> +#include <linux/module.h>
> +#include <linux/property.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/spi/spi.h>
> +#include <linux/unaligned.h>
> +
> +/* Address of ADE9000 registers */
> +#define ADE9000_REG_AIGAIN		0x000
> +#define ADE9000_REG_AVGAIN		0x00B
> +#define ADE9000_REG_AIRMSOS		0x00C
> +#define ADE9000_REG_AVRMSOS		0x00D
> +#define ADE9000_REG_APGAIN		0x00E
> +#define ADE9000_REG_AWATTOS		0x00F
> +#define ADE9000_REG_AVAROS		0x010
> +#define ADE9000_REG_AFVAROS		0x012
> +#define ADE9000_REG_CONFIG0		0x060
> +#define ADE9000_REG_DICOEFF		0x072
> +#define ADE9000_REG_AI_PCF		0x20A
> +#define ADE9000_REG_AV_PCF		0x20B
> +#define ADE9000_REG_AIRMS		0x20C
> +#define ADE9000_REG_AVRMS		0x20D
> +#define ADE9000_REG_AWATT		0x210
> +#define ADE9000_REG_AVAR		0x211
> +#define ADE9000_REG_AVA			0x212
> +#define ADE9000_REG_AFVAR		0x214
> +#define ADE9000_REG_APF			0x216
> +#define ADE9000_REG_BI_PCF		0x22A
> +#define ADE9000_REG_BV_PCF		0x22B
> +#define ADE9000_REG_BIRMS		0x22C
> +#define ADE9000_REG_BVRMS		0x22D
> +#define ADE9000_REG_CI_PCF		0x24A
> +#define ADE9000_REG_CV_PCF		0x24B
> +#define ADE9000_REG_CIRMS		0x24C
> +#define ADE9000_REG_CVRMS		0x24D
> +#define ADE9000_REG_AWATT_ACC		0x2E5
> +#define ADE9000_REG_AWATTHR_LO		0x2E6
> +#define ADE9000_REG_AVAHR_LO		0x2FA
> +#define ADE9000_REG_AFVARHR_LO		0x30E
> +#define ADE9000_REG_BWATTHR_LO		0x322
> +#define ADE9000_REG_BVAHR_LO		0x336
> +#define ADE9000_REG_BFVARHR_LO		0x34A
> +#define ADE9000_REG_CWATTHR_LO		0x35E
> +#define ADE9000_REG_CVAHR_LO		0x372
> +#define ADE9000_REG_CFVARHR_LO		0x386
> +#define ADE9000_REG_STATUS0		0x402
> +#define ADE9000_REG_STATUS1		0x403
> +#define ADE9000_REG_MASK0		0x405
> +#define ADE9000_REG_MASK1		0x406
> +#define ADE9000_REG_EVENT_MASK		0x407
> +#define ADE9000_REG_VLEVEL		0x40F
> +#define ADE9000_REG_DIP_LVL		0x410
> +#define ADE9000_REG_DIPA		0x411
> +#define ADE9000_REG_DIPB		0x412
> +#define ADE9000_REG_DIPC		0x413
> +#define ADE9000_REG_SWELL_LVL		0x414
> +#define ADE9000_REG_SWELLA		0x415
> +#define ADE9000_REG_SWELLB		0x416
> +#define ADE9000_REG_SWELLC		0x417
> +#define ADE9000_REG_APERIOD		0x418
> +#define ADE9000_REG_BPERIOD		0x419
> +#define ADE9000_REG_CPERIOD		0x41A
> +#define ADE9000_REG_RUN			0x480
> +#define ADE9000_REG_CONFIG1		0x481
> +#define ADE9000_REG_ACCMODE		0x492
> +#define ADE9000_REG_CONFIG3		0x493
> +#define ADE9000_REG_ZXTOUT		0x498
> +#define ADE9000_REG_ZX_LP_SEL		0x49A
> +#define ADE9000_REG_WFB_CFG		0x4A0
> +#define ADE9000_REG_WFB_PG_IRQEN	0x4A1
> +#define ADE9000_REG_WFB_TRG_CFG		0x4A2
> +#define ADE9000_REG_WFB_TRG_STAT	0x4A3
> +#define ADE9000_REG_CONFIG2		0x4AF
> +#define ADE9000_REG_EP_CFG		0x4B0
> +#define ADE9000_REG_EGY_TIME		0x4B2
> +#define ADE9000_REG_PGA_GAIN		0x4B9
> +#define ADE9000_REG_VERSION		0x4FE
> +#define ADE9000_REG_WF_BUFF		0x800
> +#define ADE9000_REG_WF_HALF_BUFF	0xC00
> +
> +#define ADE9000_REG_ADDR_MASK		GENMASK(15, 4)
> +#define ADE9000_REG_READ_BIT_MASK	BIT(3)
> +#define ADE9000_RX_DEPTH		6
> +#define ADE9000_TX_DEPTH		10
> +
> +#define ADE9000_WF_CAP_EN_MASK		BIT(4)
> +#define ADE9000_WF_CAP_SEL_MASK		BIT(5)
> +#define ADE9000_WF_MODE_MASK		GENMASK(7, 6)
> +#define ADE9000_WF_SRC_MASK		GENMASK(9, 8)
> +#define ADE9000_WF_IN_EN_MASK		BIT(12)
> +
> +/* External reference selection bit in CONFIG1 */
> +#define ADE9000_EXT_REF_MASK		BIT(15)
> +
> +/*
> + * Configuration registers
> + */
> +#define ADE9000_PGA_GAIN		0x0000
> +
> +/* Default configuration */
> +
> +#define ADE9000_CONFIG0			0x00000000
> +
> +/* CF3/ZX pin outputs Zero crossing, CF4 =3D DREADY */
> +#define ADE9000_CONFIG1			0x000E
> +
> +/* Default High pass corner frequency of 1.25Hz */
> +#define ADE9000_CONFIG2			0x0A00
> +
> +/* Peak and overcurrent detection disabled */
> +#define ADE9000_CONFIG3			0x0000
> +
> +/*
> + * 50Hz operation, 3P4W Wye configuration, signed accumulation
> + * Clear bit 8 i.e. ACCMODE=3D0x00xx for 50Hz operation
> + * ACCMODE=3D0x0x9x for 3Wire delta when phase B is used as reference
> + */
> +#define ADE9000_ACCMODE			0x0000
> +#define ADE9000_ACCMODE_60HZ		0x0100
> +
> +/*Line period and zero crossing obtained from VA */
> +#define ADE9000_ZX_LP_SEL		0x0000
> +
> +/* Interrupt mask values for initialization */
> +#define ADE9000_MASK0_EGYRDY_INT_EN	BIT(0)
> +#define ADE9000_MASK1_ALL_INT_DIS	0x00000000
> +
> +/* Events disabled */

So these are default values?  is it useful to have defines if they
are just going to go in an array that says what they are and
where you can add any necessary comments if you can't build them up
from defines that are self explanatory.

> +#define ADE9000_EVENT_DISABLE		0x00000000
> +
> +/*
> + * Assuming Vnom=3D1/2 of full scale.
> + * Refer to Technical reference manual for detailed calculations.
> + */
> +#define ADE9000_VLEVEL			0x0022EA28
> +
> +/* Set DICOEFF=3D 0xFFFFE000 when integrator is enabled */
> +#define ADE9000_DICOEFF			0x00000000
> +
> +/* DSP ON */
> +#define ADE9000_RUN_ON			0xFFFFFFFF
> +
> +/*
> + * Energy Accumulation Settings
> + * Enable energy accumulation, accumulate samples at 8ksps
> + * latch energy accumulation after EGYRDY
> + * If accumulation is changed to half line cycle mode, change EGY_TIME
> + */
> +#define ADE9000_EP_CFG			0x0011
> +
> +/* Accumulate 4000 samples */
> +#define ADE9000_EGY_TIME		7999
> +
> +/*
> + * Constant Definitions
> + * ADE9000 FDSP: 8000sps, ADE9000 FDSP: 4000sps
> + */
> +#define ADE9000_FDSP			4000
> +#define ADE9000_DEFAULT_CLK_FREQ_HZ	24576000
> +#define ADE9000_WFB_CFG			0x03E9
> +#define ADE9000_WFB_PAGE_SIZE		128
> +#define ADE9000_WFB_NR_OF_PAGES		16
> +#define ADE9000_WFB_MAX_CHANNELS	8
> +#define ADE9000_WFB_BYTES_IN_SAMPLE	4
> +#define ADE9000_WFB_SAMPLES_IN_PAGE	\
> +	(ADE9000_WFB_PAGE_SIZE / ADE9000_WFB_MAX_CHANNELS)
> +#define ADE9000_WFB_MAX_SAMPLES_CHAN	\
> +	(ADE9000_WFB_SAMPLES_IN_PAGE * ADE9000_WFB_NR_OF_PAGES)
> +#define ADE9000_WFB_FULL_BUFF_NR_SAMPLES \
> +	(ADE9000_WFB_PAGE_SIZE * ADE9000_WFB_NR_OF_PAGES)
> +#define ADE9000_WFB_FULL_BUFF_SIZE	\
> +	(ADE9000_WFB_FULL_BUFF_NR_SAMPLES * ADE9000_WFB_BYTES_IN_SAMPLE)
> +
> +#define ADE9000_SWRST_BIT		BIT(0)
> +
> +/* Status and Mask register bits*/
> +#define ADE9000_ST0_WFB_TRIG_BIT	BIT(16)
> +#define ADE9000_ST0_PAGE_FULL_BIT	BIT(17)
> +#define ADE9000_ST0_EGYRDY		BIT(0)
> +
> +#define ADE9000_ST1_ZXTOVA_BIT		BIT(6)
> +#define ADE9000_ST1_ZXTOVB_BIT		BIT(7)
> +#define ADE9000_ST1_ZXTOVC_BIT		BIT(8)
> +#define ADE9000_ST1_ZXVA_BIT		BIT(9)
> +#define ADE9000_ST1_ZXVB_BIT		BIT(10)
> +#define ADE9000_ST1_ZXVC_BIT		BIT(11)
> +#define ADE9000_ST1_ZXIA_BIT		BIT(13)
> +#define ADE9000_ST1_ZXIB_BIT		BIT(14)
> +#define ADE9000_ST1_ZXIC_BIT		BIT(15)
> +#define ADE9000_ST1_RSTDONE_BIT		BIT(16)
> +#define ADE9000_ST1_SEQERR_BIT		BIT(18)
> +#define ADE9000_ST1_SWELLA_BIT		BIT(20)
> +#define ADE9000_ST1_SWELLB_BIT		BIT(21)
> +#define ADE9000_ST1_SWELLC_BIT		BIT(22)
> +#define ADE9000_ST1_DIPA_BIT		BIT(23)
> +#define ADE9000_ST1_DIPB_BIT		BIT(24)
> +#define ADE9000_ST1_DIPC_BIT		BIT(25)
> +#define ADE9000_ST1_ERROR0_BIT		BIT(28)
> +#define ADE9000_ST1_ERROR1_BIT		BIT(29)
> +#define ADE9000_ST1_ERROR2_BIT		BIT(30)
> +#define ADE9000_ST1_ERROR3_BIT		BIT(31)
> +#define ADE9000_ST_ERROR \
> +	(ADE9000_ST1_ERROR0 | \
> +	 ADE9000_ST1_ERROR1 | \
> +	 ADE9000_ST1_ERROR2 | \
> +	 ADE9000_ST1_ERROR3)

Combine in pairs on each line. Won't much affect readability
but will result in me scrolling a tiny bit less which I like.

> +#define ADE9000_ST1_CROSSING_FIRST	6
> +#define ADE9000_ST1_CROSSING_DEPTH	25
> +
> +#define ADE9000_WFB_TRG_DIP_BIT		BIT(0)
> +#define ADE9000_WFB_TRG_SWELL_BIT	BIT(1)
> +#define ADE9000_WFB_TRG_ZXIA_BIT	BIT(3)
> +#define ADE9000_WFB_TRG_ZXIB_BIT	BIT(4)
> +#define ADE9000_WFB_TRG_ZXIC_BIT	BIT(5)
> +#define ADE9000_WFB_TRG_ZXVA_BIT	BIT(6)
> +#define ADE9000_WFB_TRG_ZXVB_BIT	BIT(7)
> +#define ADE9000_WFB_TRG_ZXVC_BIT	BIT(8)
> +
> +/* Stop when waveform buffer is full */
> +#define ADE9000_WFB_FULL_MODE		0x0
> +/* Continuous fill=E2=80=94stop only on enabled trigger events */
> +#define ADE9000_WFB_EN_TRIG_MODE	0x1
> +/* Continuous filling=E2=80=94center capture around enabled trigger even=
ts */
> +#define ADE9000_WFB_C_EN_TRIG_MODE	0x2
> +/* Continuous fill=E2=80=94used as streaming mode for continuous data ou=
tput */
> +#define ADE9000_WFB_STREAMING_MODE	0x3
> +
> +#define ADE9000_LAST_PAGE_BIT		BIT(15)
> +#define ADE9000_MIDDLE_PAGE_BIT		BIT(7)
> +
> +/*
> + * Full scale Codes referred from Datasheet.Respective digital codes are
Space after full stop.

> + * produced when ADC inputs are at full scale. Do not Change.

Generally no one should ever change random defines in a file.
Not sure we need to state it for these ones!

> + */
> +#define ADE9000_RMS_FULL_SCALE_CODES	52866837
> +#define ADE9000_WATT_FULL_SCALE_CODES	20694066
> +#define ADE9000_PCF_FULL_SCALE_CODES	74770000
> +
> +/* Phase and channel definitions */
> +#define ADE9000_PHASE_A_NR		0
> +#define ADE9000_PHASE_B_NR		1
> +#define ADE9000_PHASE_C_NR		2
> +
> +#define ADE9000_SCAN_POS_IA		BIT(0)
> +#define ADE9000_SCAN_POS_VA		BIT(1)
> +#define ADE9000_SCAN_POS_IB		BIT(2)
> +#define ADE9000_SCAN_POS_VB		BIT(3)
> +#define ADE9000_SCAN_POS_IC		BIT(4)
> +#define ADE9000_SCAN_POS_VC		BIT(5)
> +#define ADE9000_SCAN_POS_ALL \
> +	(ADE9000_SCAN_POS_IA | \
> +	 ADE9000_SCAN_POS_VA | \
> +	 ADE9000_SCAN_POS_IB | \
> +	 ADE9000_SCAN_POS_VB | \
> +	 ADE9000_SCAN_POS_IC | \
> +	 ADE9000_SCAN_POS_VC)

seems reasonable to combine a few of these on smaller number of lines.
Maybe just build this up where it is used as there only seems to be one pla=
ce

>
> +#define ADE9000_ADDR_ADJUST(addr, chan)					\
> +	(((chan) =3D=3D 0 ? 0 : (chan) =3D=3D 1 ? 2 : 4) << 4 | (addr))
> +
> +struct ade9000_state {
> +	struct completion reset_completion;
> +	u8 wf_src;
> +	u32 wfb_trg;
> +	u8 wfb_nr_activ_chan;
> +	u32 wfb_nr_samples;
> +	struct spi_device *spi;
> +	struct clk *clkin;
> +	struct clk_hw clkout_hw;
> +	struct spi_transfer xfer[2];
> +	struct spi_message spi_msg;
> +	struct regmap *regmap;
> +	union{
> +		u8 byte[ADE9000_WFB_FULL_BUFF_SIZE];
> +		__be32 word[ADE9000_WFB_FULL_BUFF_NR_SAMPLES];
> +	} rx_buff __aligned(IIO_DMA_MINALIGN);
> +	u8 tx_buff[2] __aligned(IIO_DMA_MINALIGN);
> +	u8 tx[ADE9000_TX_DEPTH] __aligned(IIO_DMA_MINALIGN);
> +	u8 rx[ADE9000_RX_DEPTH] __aligned(IIO_DMA_MINALIGN);

Given all these buffers, I'd expect some locking around accessing
them.  Also it's rare you need to force tx and rx buffers to different lines
as software tends not to access one whilst DMA might be going on to the oth=
er.
Hence you'll see most drivers only force the alignment of which ever one co=
mes
first.

> +};
> +
> +static unsigned long ade9000_clkout_recalc_rate(struct clk_hw *hw,
> +						unsigned long parent_rate)
> +{
> +	/* CLKOUT provides the same frequency as the crystal/external clock */
> +	return parent_rate ? parent_rate : ADE9000_DEFAULT_CLK_FREQ_HZ;
> +}
> +
> +static const struct clk_ops ade9000_clkout_ops =3D {
> +	.recalc_rate =3D ade9000_clkout_recalc_rate,
> +};
> +
> +static const struct iio_event_spec ade9000_events[] =3D {
> +	{
> +		.type =3D IIO_EV_TYPE_MAG,
> +		.dir =3D IIO_EV_DIR_NONE,
> +		.mask_shared_by_all =3D BIT(IIO_EV_INFO_ENABLE),
> +	},
> +	{
> +		.type =3D IIO_EV_TYPE_CHANGE,
> +		.dir =3D IIO_EV_DIR_NONE,
> +		.mask_shared_by_all =3D BIT(IIO_EV_INFO_ENABLE),
I have no idea what some of these are.  Add some comments
and ideally a documentation file that relates the attributes
to what they are called in the datasheet.

> +	},
> +	{
> +		.type =3D IIO_EV_TYPE_THRESH,
> +		.dir =3D IIO_EV_DIR_NONE,
> +		.mask_separate =3D BIT(IIO_EV_INFO_ENABLE),
> +		.mask_shared_by_all =3D BIT(IIO_EV_INFO_VALUE),
> +	},
> +	{
> +		.type =3D IIO_EV_TYPE_THRESH,
> +		.dir =3D IIO_EV_DIR_EITHER,
> +		.mask_separate =3D BIT(IIO_EV_INFO_ENABLE),
> +	},
> +	{
> +		.type =3D IIO_EV_TYPE_THRESH,
> +		.dir =3D IIO_EV_DIR_RISING, /* for swell */
> +		.mask_separate =3D BIT(IIO_EV_INFO_ENABLE),
> +		.mask_shared_by_all =3D BIT(IIO_EV_INFO_VALUE),
> +	},
> +	{
> +		.type =3D IIO_EV_TYPE_THRESH,
> +		.dir =3D IIO_EV_DIR_FALLING, /* for dip */
> +		.mask_separate =3D BIT(IIO_EV_INFO_ENABLE),
> +		.mask_shared_by_all =3D BIT(IIO_EV_INFO_VALUE),
> +	},
> +};
> +
> +static const char * const ade9000_filter_type_items[] =3D {
> +	"sinc4", "sinc4+iir",
Next patch documents sinc4+lp


In general please carefully check the driver ABI when testing against
the docs. There are a few things like this in here and I may not have
caught them all.

> +};

> +#define ADE9000_CURRENT_CHANNEL(num) {					\
> +	.type =3D IIO_CURRENT,						\
> +	.channel =3D num,							\
> +	.address =3D ADE9000_ADDR_ADJUST(ADE9000_REG_AI_PCF, num),	\
> +	.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |			\
> +			      BIT(IIO_CHAN_INFO_SCALE) |		\
> +			      BIT(IIO_CHAN_INFO_HARDWAREGAIN),		\
> +	.event_spec =3D &ade9000_events[0],				\
> +	.num_event_specs =3D 1,						\
> +	.scan_index =3D num,						\
> +	.indexed =3D 1,							\
> +	.scan_type =3D {							\
> +		.sign =3D 's',						\
> +		.realbits =3D 32,						\
> +		.storagebits =3D 32,					\
> +		.endianness =3D IIO_BE,					\
> +	},								\
> +}
> +
> +#define ADE9000_VOLTAGE_CHANNEL(num) {					\
> +	.type =3D IIO_VOLTAGE,						\
> +	.channel =3D num,							\
> +	.address =3D ADE9000_ADDR_ADJUST(ADE9000_REG_AV_PCF, num),	\
> +	.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |			\
> +			      BIT(IIO_CHAN_INFO_SCALE) |		\
> +			      BIT(IIO_CHAN_INFO_CALIBSCALE) |		\
> +			      BIT(IIO_CHAN_INFO_HARDWAREGAIN) |		\
> +			      BIT(IIO_CHAN_INFO_SAMP_FREQ),		\
> +	.info_mask_shared_by_all =3D BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
> +	.event_spec =3D ade9000_events,					\
> +	.num_event_specs =3D ARRAY_SIZE(ade9000_events),			\
> +	.scan_index =3D num + 1,						\

Add a comment on why + 1 here.

> +	.indexed =3D 1,							\
> +	.scan_type =3D {							\
> +		.sign =3D 's',						\
> +		.realbits =3D 32,						\
> +		.storagebits =3D 32,					\
> +		.endianness =3D IIO_BE,					\
> +	},								\
> +	.ext_info =3D ade9000_ext_info,					\
> +}
> +
> +#define ADE9000_CURRENT_RMS_CHANNEL(num) {				\
As below. Maybe rename macro to include ALTCURRENT

> +	.type =3D IIO_ALTCURRENT,						\
> +	.channel =3D num,							\
> +	.address =3D ADE9000_ADDR_ADJUST(ADE9000_REG_AIRMS, num),		\
> +	.channel2 =3D IIO_MOD_RMS,					\
> +	.modified =3D 1,							\
> +	.indexed =3D 1,							\
> +	.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),			\
> +	.scan_index =3D -1						\
> +}
> +
> +#define ADE9000_ALTVOLTAGE_RMS_CHANNEL(num) {				\
> +	.type =3D IIO_ALTVOLTAGE,						\
> +	.channel =3D num,							\
> +	.address =3D ADE9000_ADDR_ADJUST(ADE9000_REG_AVRMS, num),		\
> +	.channel2 =3D IIO_MOD_RMS,					\
> +	.modified =3D 1,							\
> +	.indexed =3D 1,							\
> +	.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |			\
> +			      BIT(IIO_CHAN_INFO_SCALE) |		\
> +			      BIT(IIO_CHAN_INFO_OFFSET),		\
> +	.scan_index =3D -1						\
> +}
> +
> +#define ADE9000_POWER_ACTIVE_CHANNEL(num) {				\
> +	.type =3D IIO_POWER,						\
> +	.channel =3D num,							\
> +	.address =3D ADE9000_ADDR_ADJUST(ADE9000_REG_AWATT, num),		\
> +	.channel2 =3D IIO_MOD_ACTIVE,					\
> +	.modified =3D 1,							\
> +	.indexed =3D 1,							\
> +	.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |			\
> +			      BIT(IIO_CHAN_INFO_SCALE) |		\
> +			      BIT(IIO_CHAN_INFO_OFFSET) |		\
> +			      BIT(IIO_CHAN_INFO_HARDWAREGAIN) |		\
> +			      BIT(IIO_CHAN_INFO_POWERFACTOR),		\
> +	.scan_index =3D -1						\
> +}
> +
> +#define ADE9000_POWER_REACTIVE_CHANNEL(num) {				\
> +	.type =3D IIO_POWER,						\
> +	.channel =3D num,							\
> +	.address =3D ADE9000_ADDR_ADJUST(ADE9000_REG_AVAR, num),		\
> +	.channel2 =3D IIO_MOD_REACTIVE,					\
> +	.modified =3D 1,							\
> +	.indexed =3D 1,							\
> +	.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |			\
> +			      BIT(IIO_CHAN_INFO_SCALE) |		\
> +			      BIT(IIO_CHAN_INFO_OFFSET) |		\
> +			      BIT(IIO_CHAN_INFO_POWERFACTOR),		\
Seems like we should only have one power factor given (as you documented)
it is the ratio of active to apparent power. The docs you gave
only have in_powerY_powerfactor but this will be

in_powerY_reactive_powerfactor

Maybe we need a pseudo channel for this given we don't have an unmodified
power channel.  Or we just put it on one modified power channel only?

Doesn't make much sense on the reactive channel though!


> +	.scan_index =3D -1						\
> +}
> +
> +#define ADE9000_POWER_APPARENT_CHANNEL(num) {				\
> +	.type =3D IIO_POWER,						\
> +	.channel =3D num,							\
> +	.address =3D ADE9000_ADDR_ADJUST(ADE9000_REG_AVA, num),		\
> +	.channel2 =3D IIO_MOD_APPARENT,					\
> +	.modified =3D 1,							\
> +	.indexed =3D 1,							\
> +	.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |			\
> +			      BIT(IIO_CHAN_INFO_SCALE) |		\
> +			      BIT(IIO_CHAN_INFO_POWERFACTOR),		\
> +	.scan_index =3D -1						\
> +}
> +
> + #define ADE9000_ENERGY_ACTIVE_CHANNEL(num, addr) {			\
> +	.type =3D IIO_ENERGY,						\
> +	.channel =3D num,							\
> +	.address =3D addr,						\
> +	.channel2 =3D IIO_MOD_ACTIVE,					\
> +	.modified =3D 1,							\
> +	.indexed =3D 1,							\
> +	.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),			\
> +	.scan_index =3D -1						\
> +}
> +
> +#define ADE9000_ENERGY_APPARENT_CHANNEL(num, addr) {			\
> +	.type =3D IIO_ENERGY,						\
> +	.channel =3D num,							\
> +	.address =3D addr,						\
> +	.channel2 =3D IIO_MOD_APPARENT,					\
> +	.modified =3D 1,							\
> +	.indexed =3D 1,							\
> +	.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),			\
> +	.scan_index =3D -1						\
> +}
> +
> +#define ADE9000_ENERGY_REACTIVE_CHANNEL(num, addr) {			\
> +	.type =3D IIO_ENERGY,						\
> +	.channel =3D num,							\
> +	.address =3D addr,						\
> +	.channel2 =3D IIO_MOD_REACTIVE,					\
> +	.modified =3D 1,							\
> +	.indexed =3D 1,							\
> +	.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),			\
> +	.scan_index =3D -1						\
> +}
> +

Add some comments on these. Shouldn't be necessary to dive into the regisers
to figure it out.

> +#define ADE9000_ALTVOLTAGE_ACCMODE_CHANNEL() {				\
> +	.type =3D IIO_ALTVOLTAGE,						\
> +	.channel =3D 0,							\
> +	.address =3D ADE9000_REG_ACCMODE,					\
> +	.indexed =3D 1,							\
> +	.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),			\
> +	.info_mask_shared_by_all =3D BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
> +	.scan_index =3D -1						\
> +}
> +
> +/* IIO channels of the ade9000 for each phase individually */

What is this for?  Maybe I'm missing where it is used.

> +static const struct iio_chan_spec ade9000_a_channels[] =3D {
> +	ADE9000_CURRENT_CHANNEL(ADE9000_PHASE_A_NR),
> +	ADE9000_VOLTAGE_CHANNEL(ADE9000_PHASE_A_NR),
> +	ADE9000_CURRENT_RMS_CHANNEL(ADE9000_PHASE_A_NR),
> +	ADE9000_ALTVOLTAGE_RMS_CHANNEL(ADE9000_PHASE_A_NR),
> +	ADE9000_POWER_ACTIVE_CHANNEL(ADE9000_PHASE_A_NR),
> +	ADE9000_POWER_REACTIVE_CHANNEL(ADE9000_PHASE_A_NR),
> +	ADE9000_POWER_APPARENT_CHANNEL(ADE9000_PHASE_A_NR),
> +	ADE9000_ENERGY_ACTIVE_CHANNEL(ADE9000_PHASE_A_NR, ADE9000_REG_AWATTHR_L=
O),
> +	ADE9000_ENERGY_APPARENT_CHANNEL(ADE9000_PHASE_A_NR, ADE9000_REG_AVAHR_L=
O),
> +	ADE9000_ENERGY_REACTIVE_CHANNEL(ADE9000_PHASE_A_NR, ADE9000_REG_AFVARHR=
_LO),
> +};
> +
> +static const struct iio_chan_spec ade9000_b_channels[] =3D {
> +	ADE9000_CURRENT_CHANNEL(ADE9000_PHASE_B_NR),
> +	ADE9000_VOLTAGE_CHANNEL(ADE9000_PHASE_B_NR),
> +	ADE9000_CURRENT_RMS_CHANNEL(ADE9000_PHASE_B_NR),
> +	ADE9000_ALTVOLTAGE_RMS_CHANNEL(ADE9000_PHASE_B_NR),
> +	ADE9000_POWER_ACTIVE_CHANNEL(ADE9000_PHASE_B_NR),
> +	ADE9000_POWER_REACTIVE_CHANNEL(ADE9000_PHASE_B_NR),
> +	ADE9000_POWER_APPARENT_CHANNEL(ADE9000_PHASE_B_NR),
> +	ADE9000_ENERGY_ACTIVE_CHANNEL(ADE9000_PHASE_B_NR, ADE9000_REG_BWATTHR_L=
O),
> +	ADE9000_ENERGY_APPARENT_CHANNEL(ADE9000_PHASE_B_NR, ADE9000_REG_BVAHR_L=
O),
> +	ADE9000_ENERGY_REACTIVE_CHANNEL(ADE9000_PHASE_B_NR, ADE9000_REG_BFVARHR=
_LO),
> +};
> +
> +static const struct iio_chan_spec ade9000_c_channels[] =3D {
> +	ADE9000_CURRENT_CHANNEL(ADE9000_PHASE_C_NR),
> +	ADE9000_VOLTAGE_CHANNEL(ADE9000_PHASE_C_NR),
> +	ADE9000_CURRENT_RMS_CHANNEL(ADE9000_PHASE_C_NR),
> +	ADE9000_ALTVOLTAGE_RMS_CHANNEL(ADE9000_PHASE_C_NR),
> +	ADE9000_POWER_ACTIVE_CHANNEL(ADE9000_PHASE_C_NR),
> +	ADE9000_POWER_REACTIVE_CHANNEL(ADE9000_PHASE_C_NR),
> +	ADE9000_POWER_APPARENT_CHANNEL(ADE9000_PHASE_C_NR),
> +	ADE9000_ENERGY_ACTIVE_CHANNEL(ADE9000_PHASE_C_NR, ADE9000_REG_CWATTHR_L=
O),
> +	ADE9000_ENERGY_APPARENT_CHANNEL(ADE9000_PHASE_C_NR, ADE9000_REG_CVAHR_L=
O),
> +	ADE9000_ENERGY_REACTIVE_CHANNEL(ADE9000_PHASE_C_NR, ADE9000_REG_CFVARHR=
_LO),
> +};
> +
> +static const struct iio_chan_spec ade9000_channels[] =3D {
> +	/* Phase A channels */
> +	ADE9000_CURRENT_CHANNEL(ADE9000_PHASE_A_NR),
> +	ADE9000_VOLTAGE_CHANNEL(ADE9000_PHASE_A_NR),
> +	ADE9000_CURRENT_RMS_CHANNEL(ADE9000_PHASE_A_NR),

Probably rename ALTCURRENT

> +	ADE9000_ALTVOLTAGE_RMS_CHANNEL(ADE9000_PHASE_A_NR),
> +	ADE9000_POWER_ACTIVE_CHANNEL(ADE9000_PHASE_A_NR),
> +	ADE9000_POWER_REACTIVE_CHANNEL(ADE9000_PHASE_A_NR),
> +	ADE9000_POWER_APPARENT_CHANNEL(ADE9000_PHASE_A_NR),
> +	ADE9000_ENERGY_ACTIVE_CHANNEL(ADE9000_PHASE_A_NR, ADE9000_REG_AWATTHR_L=
O),
> +	ADE9000_ENERGY_APPARENT_CHANNEL(ADE9000_PHASE_A_NR, ADE9000_REG_AVAHR_L=
O),
> +	ADE9000_ENERGY_REACTIVE_CHANNEL(ADE9000_PHASE_A_NR, ADE9000_REG_AFVARHR=
_LO),
> +	/* Phase B channels */
> +	ADE9000_CURRENT_CHANNEL(ADE9000_PHASE_B_NR),
> +	ADE9000_VOLTAGE_CHANNEL(ADE9000_PHASE_B_NR),
> +	ADE9000_CURRENT_RMS_CHANNEL(ADE9000_PHASE_B_NR),
> +	ADE9000_ALTVOLTAGE_RMS_CHANNEL(ADE9000_PHASE_B_NR),
> +	ADE9000_POWER_ACTIVE_CHANNEL(ADE9000_PHASE_B_NR),
> +	ADE9000_POWER_REACTIVE_CHANNEL(ADE9000_PHASE_B_NR),
> +	ADE9000_POWER_APPARENT_CHANNEL(ADE9000_PHASE_B_NR),
> +	ADE9000_ENERGY_ACTIVE_CHANNEL(ADE9000_PHASE_B_NR, ADE9000_REG_BWATTHR_L=
O),
> +	ADE9000_ENERGY_APPARENT_CHANNEL(ADE9000_PHASE_B_NR, ADE9000_REG_BVAHR_L=
O),
> +	ADE9000_ENERGY_REACTIVE_CHANNEL(ADE9000_PHASE_B_NR, ADE9000_REG_BFVARHR=
_LO),
> +	/* Phase C channels */
> +	ADE9000_CURRENT_CHANNEL(ADE9000_PHASE_C_NR),
> +	ADE9000_VOLTAGE_CHANNEL(ADE9000_PHASE_C_NR),
> +	ADE9000_CURRENT_RMS_CHANNEL(ADE9000_PHASE_C_NR),
> +	ADE9000_ALTVOLTAGE_RMS_CHANNEL(ADE9000_PHASE_C_NR),
> +	ADE9000_POWER_ACTIVE_CHANNEL(ADE9000_PHASE_C_NR),
> +	ADE9000_POWER_REACTIVE_CHANNEL(ADE9000_PHASE_C_NR),
> +	ADE9000_POWER_APPARENT_CHANNEL(ADE9000_PHASE_C_NR),
> +	ADE9000_ENERGY_ACTIVE_CHANNEL(ADE9000_PHASE_C_NR, ADE9000_REG_CWATTHR_L=
O),
> +	ADE9000_ENERGY_APPARENT_CHANNEL(ADE9000_PHASE_C_NR, ADE9000_REG_CVAHR_L=
O),
> +	ADE9000_ENERGY_REACTIVE_CHANNEL(ADE9000_PHASE_C_NR, ADE9000_REG_CFVARHR=
_LO),
> +	/* Additional channel */

For what?  Maybe better to give info where you define the macro.
however, for once use channel macros you can just put the data inline.

> +	ADE9000_ALTVOLTAGE_ACCMODE_CHANNEL(),
> +};

> +static int ade9000_spi_write_reg(void *context, unsigned int reg,
> +				 unsigned int val)
> +{
> +	struct ade9000_state *st =3D context;
> +	u16 addr;
> +	int ret =3D 0;
> +	struct spi_transfer xfer[] =3D {
> +		{
> +			.tx_buf =3D st->tx,
> +		},
> +	};
> +
> +	addr =3D FIELD_PREP(ADE9000_REG_ADDR_MASK, reg);
> +
> +	put_unaligned_be16(addr, st->tx);
> +	put_unaligned_be32(val, &st->tx[2]);

Move this into the else below.  It is confusing to fill with
one thing and then ovewrite it in just one of the two legs of the if / else

> +
> +	if (reg > ADE9000_REG_RUN && reg < ADE9000_REG_VERSION) {
> +		put_unaligned_be16(val, &st->tx[2]);
> +		xfer[0].len =3D 4;
> +	} else {
> +		xfer[0].len =3D 6;
> +	}
> +
> +	ret =3D spi_sync_transfer(st->spi, xfer, ARRAY_SIZE(xfer));

spi_write() to drop a bunch of boilerplate here.

> +	if (ret) {
> +		dev_err(&st->spi->dev, "problem when writing register 0x%x\n",
> +			reg);
> +	}
> +
> +	return ret;
> +}
> +
> +static int ade9000_spi_read_reg(void *context, unsigned int reg,
> +				unsigned int *val)
> +{
> +	struct ade9000_state *st =3D context;
> +	u16 addr;
> +	int ret =3D 0;
> +	struct spi_transfer xfer[] =3D {
> +		{
> +			.tx_buf =3D st->tx,
> +			.len =3D 2,
> +		},
> +		{
> +			.rx_buf =3D st->rx,
> +		},
> +	};
> +
> +	addr =3D FIELD_PREP(ADE9000_REG_ADDR_MASK, reg) |
> +	       ADE9000_REG_READ_BIT_MASK;
> +
> +	put_unaligned_be16(addr, st->tx);
> +
> +	if (reg > ADE9000_REG_RUN && reg < ADE9000_REG_VERSION)
> +		xfer[1].len =3D 4;
> +	else
> +		xfer[1].len =3D 6;

So CRC after the data (the datasheet is very vague on what bus transfers
actuall look like)?  If so, why not check it?
If not, can we get away with just not reading it and save some bus cycles?

> +
> +	ret =3D spi_sync_transfer(st->spi, xfer, ARRAY_SIZE(xfer));

Maybe use spi_write_then_read() here as the sizes are not particularly larg=
e.



> +	if (ret) {
> +		dev_err(&st->spi->dev, "error reading register 0x%x\n",
> +			reg);
> +		return ret;
> +	}
> +
> +	if (reg > ADE9000_REG_RUN && reg < ADE9000_REG_VERSION)
> +		*val =3D get_unaligned_be16(st->rx);
> +	else
> +		*val =3D get_unaligned_be32(st->rx);
> +
> +	return 0;
> +}

> +
> +static int ade9000_configure_scan(struct iio_dev *indio_dev, u32 wfb_add=
r)
> +{
> +	struct ade9000_state *st =3D iio_priv(indio_dev);
> +	u16 addr;
> +
> +	addr =3D FIELD_PREP(ADE9000_REG_ADDR_MASK, wfb_addr) |
> +	       ADE9000_REG_READ_BIT_MASK;
> +
> +	put_unaligned_be16(addr, st->tx_buff);
> +
> +	st->xfer[0].tx_buf =3D &st->tx_buff[0];
> +	st->xfer[0].len =3D 2;
> +
> +	st->xfer[1].rx_buf =3D &st->rx_buff.byte[0];

As it's just the start that you want to point at.
	=3D st->rx_buf.byte;

> +
> +	/* Always use streaming mode */
> +	st->xfer[1].len =3D (st->wfb_nr_samples / 2) * 4;
> +
> +	spi_message_init_with_transfers(&st->spi_msg, st->xfer, 2);

ARRAY_SIZE(st->xfer) probably appropriate

> +	return 0;
> +}
> +
> +static int ade9000_iio_push_streaming(struct iio_dev *indio_dev)
> +{
> +	struct ade9000_state *st =3D iio_priv(indio_dev);
> +	u32 current_page;
=09
	u32 current_page, i;

> +	int ret;
> +	u32 i;
> +
> +	ret =3D spi_sync(st->spi, &st->spi_msg);
> +	if (ret) {
> +		dev_err(&st->spi->dev, "SPI fail in trigger handler\n");
> +		return ret;
> +	}
> +
> +	for (i =3D 0; i < st->wfb_nr_samples / 2; i +=3D st->wfb_nr_activ_chan)

Why /2 on the number of samples?  Anything we can use to show why it is 2?

> +		iio_push_to_buffers(indio_dev, &st->rx_buff.word[i]);
> +
> +	ret =3D regmap_read(st->regmap, ADE9000_REG_WFB_PG_IRQEN, &current_page=
);
> +	if (ret) {
> +		dev_err(&st->spi->dev, "IRQ0 WFB read fail\n");
> +		return ret;
> +	}
> +
> +	if (current_page & ADE9000_MIDDLE_PAGE_BIT) {
> +		ret =3D regmap_write(st->regmap, ADE9000_REG_WFB_PG_IRQEN,
> +				   ADE9000_LAST_PAGE_BIT);
> +		if (ret) {
> +			dev_err(&st->spi->dev, "IRQ0 WFB write fail\n");
> +			return ret;
> +		}
> +
> +		ret =3D ade9000_configure_scan(indio_dev,
> +					     ADE9000_REG_WF_HALF_BUFF);
> +		if (ret)
> +			return ret;
> +	} else {
> +		ret =3D regmap_write(st->regmap, ADE9000_REG_WFB_PG_IRQEN,
> +				   ADE9000_MIDDLE_PAGE_BIT);
> +		if (ret) {
> +			dev_err(&st->spi->dev,
> +				"IRQ0 WFB write fail");
> +			return IRQ_HANDLED;
> +		}
> +
> +		ret =3D ade9000_configure_scan(indio_dev,
> +					     ADE9000_REG_WF_BUFF);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int ade9000_iio_push_buffer(struct iio_dev *indio_dev)
> +{
> +	struct ade9000_state *st =3D iio_priv(indio_dev);
> +	int ret;
> +	u32 i;
> +
> +	ret =3D spi_sync(st->spi, &st->spi_msg);
> +	if (ret) {
> +		dev_err(&st->spi->dev, "SPI fail in trigger handler\n");
> +		return ret;
> +	}
> +
> +	for (i =3D 0; i < st->wfb_nr_samples; i +=3D st->wfb_nr_activ_chan)
> +		iio_push_to_buffers(indio_dev, &st->rx_buff.word[i]);
> +
> +	return 0;
> +}
> +
> +static irqreturn_t ade9000_irq0_thread(int irq, void *data)
> +{
> +	struct iio_dev *indio_dev =3D data;
> +	struct ade9000_state *st =3D iio_priv(indio_dev);
> +	s64 timestamp =3D iio_get_time_ns(indio_dev);
> +	u32 handled_irq =3D 0;
> +	u32 interrupts;
> +	u32 status;

	u32 interrupts, status;

> +	int ret;
> +
> +	ret =3D regmap_read(st->regmap, ADE9000_REG_STATUS0, &status);
> +	if (ret) {
> +		dev_err(&st->spi->dev, "IRQ0 read status fail\n");
> +		return IRQ_HANDLED;
> +	}
> +
> +	ret =3D regmap_read(st->regmap, ADE9000_REG_MASK0, &interrupts);
> +	if (ret) {
> +		dev_err(&st->spi->dev, "IRQ0 read mask fail\n");
> +		return IRQ_HANDLED;
> +	}
> +
> +	if ((status & ADE9000_ST0_PAGE_FULL_BIT) &&
> +	    (interrupts & ADE9000_ST0_PAGE_FULL_BIT)) {
> +		/* Always use streaming mode */
> +		ret =3D ade9000_iio_push_streaming(indio_dev);
> +		if (ret) {
> +			dev_err(&st->spi->dev, "IRQ0 IIO push fail\n");
> +			return IRQ_HANDLED;
> +		}
> +
> +		handled_irq |=3D ADE9000_ST0_PAGE_FULL_BIT;
> +	}
> +
> +	if ((status & ADE9000_ST0_WFB_TRIG_BIT) &&
> +	    (interrupts & ADE9000_ST0_WFB_TRIG_BIT)) {
> +		ret =3D regmap_update_bits(st->regmap, ADE9000_REG_WFB_CFG,
> +					 ADE9000_WF_CAP_EN_MASK, 0);
> +		if (ret) {
> +			dev_err(&st->spi->dev, "IRQ0 WFB fail\n");
> +			return IRQ_HANDLED;
> +		}
> +
> +		if (iio_buffer_enabled(indio_dev)) {
> +			ret =3D ade9000_iio_push_buffer(indio_dev);
> +			if (ret) {
> +				dev_err(&st->spi->dev, "IRQ0 IIO push fail @ WFB TRIG\n");
> +				return IRQ_HANDLED;
> +			}
> +		}
> +
> +		handled_irq |=3D ADE9000_ST0_WFB_TRIG_BIT;
> +	}
> +
> +	if ((status & ADE9000_ST0_EGYRDY) &&
> +	    (interrupts & ADE9000_ST0_EGYRDY)) {
> +		iio_push_event(indio_dev,
> +			       IIO_UNMOD_EVENT_CODE(IIO_ENERGY,
> +						    ADE9000_ST0_EGYRDY,
> +						    IIO_EV_TYPE_MAG,
> +						    IIO_EV_DIR_NONE),
> +			       timestamp);
> +
> +		handled_irq |=3D ADE9000_ST0_EGYRDY;
> +	}
> +
> +	ret =3D regmap_write(st->regmap, ADE9000_REG_STATUS0, handled_irq);
> +	if (ret)
> +		dev_err(&st->spi->dev, "IRQ0 write status fail\n");
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t ade9000_irq1_thread(int irq, void *data)
> +{
> +	struct iio_dev *indio_dev =3D data;
> +	struct ade9000_state *st =3D iio_priv(indio_dev);
> +	unsigned int bit =3D ADE9000_ST1_CROSSING_FIRST;
> +	s64 timestamp =3D iio_get_time_ns(indio_dev);
> +	u32 handled_irq =3D 0;
> +	u32 interrupts;
> +	u32 result;
> +	u32 status;
> +	u32 tmp;

Combine declarations if all not setting the value
	u32 interrupts, result, status, tmp;
just to save us some lines with out significant loss of readability.

> +	unsigned long interrupt_bits;
> +	int ret;
> +
> +	if (!completion_done(&st->reset_completion)) {
> +		ret =3D regmap_read(st->regmap, ADE9000_REG_STATUS1, &result);
> +		if (ret)
> +			return ret;
> +
> +		if (result & ADE9000_ST1_RSTDONE_BIT)
> +			complete(&st->reset_completion);
> +		else
> +			dev_err(&st->spi->dev, "Error testing reset done\n");
> +
> +		return IRQ_HANDLED;
> +	}
> +
> +	ret =3D regmap_read(st->regmap, ADE9000_REG_STATUS1, &status);
> +	if (ret)
> +		return IRQ_HANDLED;
> +
> +	ret =3D regmap_read(st->regmap, ADE9000_REG_MASK1, &interrupts);
> +	if (ret) {
> +		dev_err(&st->spi->dev, "IRQ1 read status fail\n");

Not sure why this one gets a print and the status that it is talking about
just before it doesn't.  Be consistent on this.

> +		return IRQ_HANDLED;
> +	}
> +
> +	interrupt_bits =3D interrupts;
> +	for_each_set_bit_from(bit, &interrupt_bits,
> +			      ADE9000_ST1_CROSSING_DEPTH){
> +		tmp =3D status & BIT(bit);
> +
> +		switch (tmp) {
> +		case ADE9000_ST1_ZXVA_BIT:
> +			iio_push_event(indio_dev,
> +				       IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE,
> +							    ADE9000_ST1_ZXVA_BIT,
> +							    IIO_EV_TYPE_THRESH,
> +							    IIO_EV_DIR_EITHER),
> +				       timestamp);
> +			handled_irq |=3D ADE9000_ST1_ZXVA_BIT;
> +			break;
> +		case ADE9000_ST1_ZXTOVA_BIT:
> +			iio_push_event(indio_dev,
> +				       IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE,
> +							    ADE9000_ST1_ZXTOVA_BIT,
> +							    IIO_EV_TYPE_THRESH,
> +							    IIO_EV_DIR_EITHER),
> +				       timestamp);
> +			handled_irq |=3D ADE9000_ST1_ZXTOVA_BIT;
> +			break;
> +		case ADE9000_ST1_ZXIA_BIT:
> +			iio_push_event(indio_dev,
> +				       IIO_UNMOD_EVENT_CODE(IIO_CURRENT,
> +							    ADE9000_ST1_ZXIA_BIT,
> +							    IIO_EV_TYPE_THRESH,
> +							    IIO_EV_DIR_EITHER),
> +				       timestamp);
> +			handled_irq |=3D ADE9000_ST1_ZXIA_BIT;
> +			break;
> +		case ADE9000_ST1_ZXVB_BIT:
> +			iio_push_event(indio_dev,
> +				       IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE,
> +							    ADE9000_ST1_ZXVB_BIT,
> +							    IIO_EV_TYPE_THRESH,
> +							    IIO_EV_DIR_EITHER),
> +				       timestamp);
> +			handled_irq |=3D ADE9000_ST1_ZXVB_BIT;
> +			break;
> +		case ADE9000_ST1_ZXTOVB_BIT:
> +			iio_push_event(indio_dev,
> +				       IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE,
> +							    ADE9000_ST1_ZXTOVB_BIT,
> +							    IIO_EV_TYPE_THRESH,
> +							    IIO_EV_DIR_EITHER),
> +				       timestamp);
> +			handled_irq |=3D ADE9000_ST1_ZXTOVB_BIT;
> +			break;
> +		case ADE9000_ST1_ZXIB_BIT:
> +			iio_push_event(indio_dev,
> +				       IIO_UNMOD_EVENT_CODE(IIO_CURRENT,
> +							    ADE9000_ST1_ZXIB_BIT,
> +							    IIO_EV_TYPE_THRESH,
> +							    IIO_EV_DIR_EITHER),
> +				       timestamp);
> +			handled_irq |=3D ADE9000_ST1_ZXIB_BIT;
> +			break;
> +		case ADE9000_ST1_ZXVC_BIT:
> +			iio_push_event(indio_dev,
> +				       IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE,
> +							    ADE9000_ST1_ZXVC_BIT,
> +							    IIO_EV_TYPE_THRESH,
> +							    IIO_EV_DIR_EITHER),
> +				       timestamp);
> +			handled_irq |=3D ADE9000_ST1_ZXVC_BIT;
> +			break;
> +		case ADE9000_ST1_ZXTOVC_BIT:
> +			iio_push_event(indio_dev,
> +				       IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE,
> +							    ADE9000_ST1_ZXTOVC_BIT,
> +							    IIO_EV_TYPE_THRESH,
> +							    IIO_EV_DIR_EITHER),
> +				       timestamp);
> +			handled_irq |=3D ADE9000_ST1_ZXTOVC_BIT;
> +			break;
> +		case ADE9000_ST1_ZXIC_BIT:
> +			iio_push_event(indio_dev,
> +				       IIO_UNMOD_EVENT_CODE(IIO_CURRENT,
> +							    ADE9000_ST1_ZXIC_BIT,
> +							    IIO_EV_TYPE_THRESH,
> +							    IIO_EV_DIR_EITHER),
> +				       timestamp);
> +			handled_irq |=3D ADE9000_ST1_ZXIC_BIT;
> +			break;
> +		case ADE9000_ST1_SWELLA_BIT:
> +			iio_push_event(indio_dev,
> +				       IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE,
> +							    ADE9000_ST1_SWELLA_BIT >> 20,
> +							    IIO_EV_TYPE_THRESH,
> +							    IIO_EV_DIR_RISING),
> +				       timestamp);
> +			handled_irq |=3D ADE9000_ST1_SWELLA_BIT;
> +			break;
> +		case ADE9000_ST1_SWELLB_BIT:
> +			iio_push_event(indio_dev,
> +				       IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE,
> +							    ADE9000_ST1_SWELLB_BIT >> 20,
> +							    IIO_EV_TYPE_THRESH,
> +							    IIO_EV_DIR_RISING),
> +				       timestamp);
> +			handled_irq |=3D ADE9000_ST1_SWELLB_BIT;
> +			break;
> +		case ADE9000_ST1_SWELLC_BIT:
> +			iio_push_event(indio_dev,
> +				       IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE,
> +							    ADE9000_ST1_SWELLC_BIT >> 20,
> +							    IIO_EV_TYPE_THRESH,
> +							    IIO_EV_DIR_RISING),
> +				       timestamp);
> +			handled_irq |=3D ADE9000_ST1_SWELLC_BIT;
> +			break;
> +		case ADE9000_ST1_DIPA_BIT:
> +			iio_push_event(indio_dev,
> +				       IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE,
> +							    ADE9000_ST1_DIPA_BIT >> 20,
> +							    IIO_EV_TYPE_THRESH,
> +							    IIO_EV_DIR_FALLING),
> +				       timestamp);
> +			handled_irq |=3D ADE9000_ST1_DIPA_BIT;
> +			break;
> +		case ADE9000_ST1_DIPB_BIT:
> +			iio_push_event(indio_dev,
> +				       IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE,
> +							    ADE9000_ST1_DIPB_BIT >> 20,
> +							    IIO_EV_TYPE_THRESH,
> +							    IIO_EV_DIR_FALLING),
> +				       timestamp);
> +			handled_irq |=3D ADE9000_ST1_DIPB_BIT;
> +			break;
> +		case ADE9000_ST1_DIPC_BIT:
> +			iio_push_event(indio_dev,
> +				       IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE,
> +							    ADE9000_ST1_DIPC_BIT >> 20,
> +							    IIO_EV_TYPE_THRESH,
> +							    IIO_EV_DIR_FALLING),
> +				       timestamp);
> +			handled_irq |=3D ADE9000_ST1_DIPC_BIT;
> +			break;
> +		case ADE9000_ST1_SEQERR_BIT:
> +			iio_push_event(indio_dev,
> +				       IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE,
> +							    ADE9000_ST1_SEQERR_BIT >> 12,
> +							    IIO_EV_TYPE_CHANGE,
> +							    IIO_EV_DIR_NONE),

I don't know what this event is.  Not entirely sure on some of the others. =
 So I think
this needs some documentation so we can discuss the mapping of hardware stu=
ff to event
codes.

> +				       timestamp);
> +			handled_irq |=3D ADE9000_ST1_SEQERR_BIT;
> +			break;
> +		default:
> +			return IRQ_HANDLED;
> +		}
> +	}
> +
> +	ret =3D regmap_write(st->regmap, ADE9000_REG_STATUS1, handled_irq);
> +	if (ret)
> +		return ret;
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t ade9000_dready_thread(int irq, void *data)
> +{
> +	struct iio_dev *indio_dev =3D data;
> +
> +	/* Handle data ready interrupt from C4/EVENT/DREADY pin */
> +	if (!iio_device_claim_buffer_mode(indio_dev)) {
> +		ade9000_iio_push_buffer(indio_dev);
> +		iio_device_release_buffer_mode(indio_dev);
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int ade9000_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int *val,
> +			    int *val2,
> +			    long mask)
> +{
> +	struct ade9000_state *st =3D iio_priv(indio_dev);
> +	unsigned int reg;
> +	int measured;
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		if (chan->type =3D=3D IIO_VOLTAGE) {
> +			int period_reg;
> +			int period;
> +

This lot don't balance with the below code to write the same.
So what is this?  Looks to be the channel frequency not the sampling freque=
ncy.

We do have a sort of related definition for FSK modulation
out_altvoltage0_frequency

So this probably wants to be=20
in_altvoltag0_frequency

or something like that.

> +			switch (chan->channel) {
> +			case ADE9000_PHASE_A_NR:
> +				period_reg =3D ADE9000_REG_APERIOD;
> +				break;
> +			case ADE9000_PHASE_B_NR:
> +				period_reg =3D ADE9000_REG_BPERIOD;
> +				break;
> +			case ADE9000_PHASE_C_NR:
> +				period_reg =3D ADE9000_REG_CPERIOD;
> +				break;
> +			default:
> +				return -EINVAL;
> +			}
> +			ret =3D regmap_read(st->regmap, period_reg, &period);
> +			if (ret)
> +				return ret;
> +			*val =3D 4000 * 65536;
> +			*val2 =3D period + 1;
> +			return IIO_VAL_FRACTIONAL;
> +		}
> +
> +		ret =3D regmap_read(st->regmap, ADE9000_REG_ACCMODE, &reg);
> +		if (ret)
> +			return ret;
> +		*val =3D (reg & BIT(8)) ? 60 : 50;

That BIT(8) should have a define - i think it does have one in the write
function.

> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_RAW:
> +		if (chan->type =3D=3D IIO_ENERGY) {
> +			u32 data[2];
> +			u16 lo_reg =3D chan->address;
> +
> +			ret =3D regmap_bulk_read(st->regmap, lo_reg, data, 2);
Bulk regmap accesses should use DMA safe buffers.   In practice today they
are always bounce buffered but that's an implementation detail.

Until we have a clear statement that we can rely on that for SPI we should
not do so..

> +			if (ret)
> +				return ret;
> +
> +			*val =3D data[0];  /* Lower 32 bits */
> +			*val2 =3D data[1]; /* Upper 32 bits */
> +			return IIO_VAL_INT_64;
> +		}
> +
> +		ret =3D iio_device_claim_direct(indio_dev);
> +		if (ret)
> +			return ret;
> +
> +		ret =3D regmap_read(st->regmap, chan->address, &measured);
> +		iio_device_release_direct(indio_dev);
> +		if (ret)
> +			return ret;
> +
> +		*val =3D measured;
> +
> +		return IIO_VAL_INT;
> +
> +	case IIO_CHAN_INFO_POWERFACTOR:
> +		ret =3D iio_device_claim_direct(indio_dev);
> +		if (ret)
> +			return ret;
> +
> +		/* Map power channel to corresponding power factor register */
> +		reg =3D ADE9000_ADDR_ADJUST(ADE9000_REG_APF, chan->channel);
> +		ret =3D regmap_read(st->regmap, reg, &measured);

As Andy pointed out in another review I was reading today. regmap uses unsi=
gned integers
so measured should be unsigned int to be consistent with that.


> +		iio_device_release_direct(indio_dev);
> +		if (ret)
> +			return ret;
> +
> +		*val =3D measured;
> +
> +		return IIO_VAL_INT;
> +
> +	case IIO_CHAN_INFO_SCALE:
> +		if (chan->type =3D=3D IIO_CURRENT || chan->type =3D=3D IIO_VOLTAGE ||
> +		    chan->type =3D=3D IIO_ALTVOLTAGE) {
> +			switch (chan->address) {
> +			case ADE9000_REG_AI_PCF:
> +			case ADE9000_REG_AV_PCF:
> +			case ADE9000_REG_BI_PCF:
> +			case ADE9000_REG_BV_PCF:
> +			case ADE9000_REG_CI_PCF:
> +			case ADE9000_REG_CV_PCF:
> +				*val =3D 1;
> +				*val2 =3D ADE9000_PCF_FULL_SCALE_CODES;
> +				return IIO_VAL_FRACTIONAL;
> +			case ADE9000_REG_AIRMS:
> +			case ADE9000_REG_AVRMS:
> +			case ADE9000_REG_BIRMS:
> +			case ADE9000_REG_BVRMS:
> +			case ADE9000_REG_CIRMS:
> +			case ADE9000_REG_CVRMS:
> +				*val =3D 1;
> +				*val2 =3D ADE9000_RMS_FULL_SCALE_CODES;
> +				return IIO_VAL_FRACTIONAL;
> +			default:
> +				return -EINVAL;
> +			}
> +		} else if (chan->type =3D=3D IIO_POWER) {
> +			*val =3D 1;
> +			*val2 =3D ADE9000_WATT_FULL_SCALE_CODES;
> +			return IIO_VAL_FRACTIONAL;
> +		} else {
> +			return -EINVAL;
> +		}
> +		break;
> +	case IIO_CHAN_INFO_CALIBSCALE:
> +		ret =3D regmap_read(st->regmap, ADE9000_REG_PGA_GAIN, &reg);
> +		if (ret)
> +			return ret;
> +		*val =3D min(1 << ((reg >> (8 + chan->channel)) & 0x3), 4);

GENMASK(1, 0) for that 0x3 to make it clear this is a 2 bit field.

> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ade9000_write_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     int val,
> +			     int val2,
> +			     long mask)
> +{
> +	struct ade9000_state *st =3D iio_priv(indio_dev);
> +	u32 addr;
> +	u32 tmp;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		if (val !=3D 50 && val !=3D 60)
> +			return -EINVAL;
> +		return regmap_write(st->regmap, ADE9000_REG_ACCMODE,
> +				    (val =3D=3D 60) ? ADE9000_ACCMODE_60HZ : ADE9000_ACCMODE);

Maybe a switch (val)

Just to check as I've not read the datasheet in detail. Does this correspon=
d to the rate
at which the measurements are available?
The underlying sampling to perform the maths is 10 or 12 x higher I think? =
 If nothing
is output at that rate, then it is fine to use this.

> +	case IIO_CHAN_INFO_OFFSET:
> +		switch (chan->type) {
> +		case IIO_CURRENT:
> +			return regmap_write(st->regmap,
> +					    ADE9000_ADDR_ADJUST(ADE9000_REG_AIRMSOS,
> +								chan->channel), val);
> +		case IIO_VOLTAGE:
> +		case IIO_ALTVOLTAGE:
> +			return regmap_write(st->regmap,
> +					    ADE9000_ADDR_ADJUST(ADE9000_REG_AVRMSOS,
> +								chan->channel), val);
> +		case IIO_POWER:
> +			tmp =3D chan->address;
> +			tmp &=3D ~ADE9000_PHASE_B_POS_BIT;
> +			tmp &=3D ~ADE9000_PHASE_C_POS_BIT;
> +
> +			switch (tmp) {
> +			case ADE9000_REG_AWATTOS:
> +				return regmap_write(st->regmap,
> +						    ADE9000_ADDR_ADJUST(ADE9000_REG_AWATTOS,
> +									chan->channel), val);
> +			case ADE9000_REG_AVAR:
> +				return regmap_write(st->regmap,
> +						    ADE9000_ADDR_ADJUST(ADE9000_REG_AVAROS,
> +									chan->channel), val);

I picked this one as a random check.  It's documented as a 'correction', so=
 I'd think calibbias
rather than offset (which should be applied by userspace to the value).

It is rare for a writable IIO_CHAN_INFO_OFFSET which got me wondering what =
was going on.


> +			case ADE9000_REG_AFVAR:
> +				return regmap_write(st->regmap,
> +						    ADE9000_ADDR_ADJUST(ADE9000_REG_AFVAROS,
> +									chan->channel), val);
> +			default:
> +				return -EINVAL;
> +			}
> +		default:
> +			return -EINVAL;
> +		}
> +	case IIO_CHAN_INFO_HARDWAREGAIN:

These are documented as calibration gains.  So why is hardwaregain appropri=
ate
rather than calibscale?  Add comments + some documentation file content on =
this.

> +		switch (chan->type) {
> +		case IIO_CURRENT:
> +			return regmap_write(st->regmap,
> +					    ADE9000_ADDR_ADJUST(ADE9000_REG_AIGAIN,
> +								chan->channel), val);
> +		case IIO_VOLTAGE:
> +			return regmap_write(st->regmap,
> +					    ADE9000_ADDR_ADJUST(ADE9000_REG_AVGAIN,
> +								chan->channel), val);
> +		case IIO_POWER:
> +			return regmap_write(st->regmap,
> +					    ADE9000_ADDR_ADJUST(ADE9000_REG_APGAIN,
> +								chan->channel), val);
> +		default:
> +			return -EINVAL;
> +		}
> +	case IIO_CHAN_INFO_CALIBSCALE:
> +		if (val > 4 || val < 1 || val =3D=3D 3)
> +			return -EINVAL;
> +		addr =3D ADE9000_REG_PGA_GAIN;

A PGA gain is usually INFO_SCALE.  The idea being it should be taken into a=
ccount
when converting measurements to real values.  Why does that not apply here?

Perhaps some documentation comments on that aspect would help.


> +		/*
> +		 * PGA gain settings: 1x, 2x, 4x (3x not supported)
> +		 * Each channel uses 2 bits in PGA_GAIN register:
> +		 * - Channel 0: bits [9:8]
> +		 * - Channel 1: bits [11:10]
> +		 * - Channel 2: bits [13:12]
> +		 * Convert gain (1,2,4) to register value (0,1,2) using ilog2()
> +		 */
> +		val =3D ilog2(val) << (chan->channel * 2 + 8);
> +		tmp =3D 0x3 << (chan->channel * 2 + 8);
> +		return regmap_update_bits(st->regmap, addr, tmp, val);
> +	default:
> +		return -EINVAL;
> +	}
> +}

> +
> +static int ade9000_read_event_config(struct iio_dev *indio_dev,
> +				     const struct iio_chan_spec *chan,
> +				     enum iio_event_type type,
> +				     enum iio_event_direction dir)
> +{
> +	struct ade9000_state *st =3D iio_priv(indio_dev);
> +	u32 interrupts0, interrupts1, number;
> +	int ret;
> +
> +	ret =3D regmap_read(st->regmap, ADE9000_REG_MASK0, &interrupts0);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D regmap_read(st->regmap, ADE9000_REG_MASK1, &interrupts1);
> +	if (ret)
> +		return ret;
> +
> +	if (type =3D=3D IIO_EV_TYPE_MAG)
> +		return (interrupts0 & ADE9000_ST0_EGYRDY);

Brackets not needed.  Fix similar cases where they aren't providing
some value for readability (or correctness of course!)


> +
> +	if (type =3D=3D IIO_EV_TYPE_CHANGE)
> +		return (interrupts1 & ADE9000_ST1_SEQERR_BIT);
> +
> +	number =3D chan->channel;
> +
> +	switch (number) {
> +	case ADE9000_PHASE_A_NR:
> +		if (chan->type =3D=3D IIO_VOLTAGE) {
> +			if (dir =3D=3D IIO_EV_DIR_EITHER)
> +				return (interrupts1 & ADE9000_ST1_ZXVA_BIT);
> +			if (dir =3D=3D IIO_EV_DIR_NONE)
> +				return (interrupts1 & ADE9000_ST1_ZXTOVA_BIT);
> +			if (dir =3D=3D IIO_EV_DIR_RISING)
> +				return (interrupts1 & ADE9000_ST1_SWELLA_BIT);
> +			if (dir =3D=3D IIO_EV_DIR_FALLING)
> +				return (interrupts1 & ADE9000_ST1_DIPA_BIT);
> +		} else if (chan->type =3D=3D IIO_CURRENT) {
> +			return (interrupts1 & ADE9000_ST1_ZXIA_BIT);
> +		}
> +		break;
> +	case ADE9000_PHASE_B_NR:
> +		if (chan->type =3D=3D IIO_VOLTAGE) {
> +			if (dir =3D=3D IIO_EV_DIR_EITHER)
> +				return (interrupts1 & ADE9000_ST1_ZXVB_BIT);
> +			if (dir =3D=3D IIO_EV_DIR_NONE)
> +				return (interrupts1 & ADE9000_ST1_ZXTOVB_BIT);
> +			if (dir =3D=3D IIO_EV_DIR_RISING)
> +				return (interrupts1 & ADE9000_ST1_SWELLB_BIT);
> +			if (dir =3D=3D IIO_EV_DIR_FALLING)
> +				return (interrupts1 & ADE9000_ST1_DIPB_BIT);
> +		} else if (chan->type =3D=3D IIO_CURRENT) {
> +			return (interrupts1 & ADE9000_ST1_ZXIB_BIT);
> +		}
> +		break;
> +	case ADE9000_PHASE_C_NR:
> +		if (chan->type =3D=3D IIO_VOLTAGE) {
> +			if (dir =3D=3D IIO_EV_DIR_EITHER)
> +				return (interrupts1 & ADE9000_ST1_ZXVC_BIT);
> +			if (dir =3D=3D IIO_EV_DIR_NONE)
> +				return (interrupts1 & ADE9000_ST1_ZXTOVC_BIT);
> +			if (dir =3D=3D IIO_EV_DIR_RISING)
> +				return (interrupts1 & ADE9000_ST1_SWELLC_BIT);
> +			if (dir =3D=3D IIO_EV_DIR_FALLING)
> +				return (interrupts1 & ADE9000_ST1_DIPC_BIT);
> +		} else if (chan->type =3D=3D IIO_CURRENT) {
> +			return (interrupts1 & ADE9000_ST1_ZXIC_BIT);
> +		}
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int ade9000_write_event_config(struct iio_dev *indio_dev,
> +				      const struct iio_chan_spec *chan,
> +				      enum iio_event_type type,
> +				      enum iio_event_direction dir,
> +				      bool state)
> +{
> +	struct ade9000_state *st =3D iio_priv(indio_dev);
> +	u32 interrupts, tmp;
> +	int ret;
> +	struct irq_wfb_trig {

Might as well define that where you use it. Doesn't need a type as such.

> +		u32 irq;
> +		u32 wfb_trg;
> +	};
> +
> +	ret =3D regmap_write(st->regmap, ADE9000_REG_STATUS1, GENMASK(31, 0));

Add a comment on that.  Clearing (I assume write 1 to clear register) events
on setup is unusual.

> +	if (ret)
> +		return ret;
> +
> +	if (type =3D=3D IIO_EV_TYPE_MAG) {
> +		ret =3D regmap_update_bits(st->regmap, ADE9000_REG_STATUS0,
> +					 ADE9000_ST0_EGYRDY, ADE9000_ST0_EGYRDY);
> +		if (ret)
> +			return ret;
> +		return regmap_update_bits(st->regmap, ADE9000_REG_MASK0,
> +					 ADE9000_ST0_EGYRDY,
> +					 state ? ADE9000_ST1_SEQERR_BIT : 0);
> +	}
> +
> +	if (type =3D=3D IIO_EV_TYPE_CHANGE)
> +		return regmap_update_bits(st->regmap, ADE9000_REG_MASK1,
> +					 ADE9000_ST1_SEQERR_BIT,
> +					 state ? ADE9000_ST1_SEQERR_BIT : 0);
> +
> +	struct irq_wfb_trig trig_arr[6] =3D {

We only do declarations not at the top of scope when we are using cleanup.h=
 stuff.
Just move it into scope of if (dir =3D=3D IIO_EV_DIR_EITHER)

Also make it static const.


> +		{
> +			.irq =3D ADE9000_ST1_ZXVA_BIT,
> +			.wfb_trg =3D ADE9000_WFB_TRG_ZXVA_BIT
> +		}, {
> +			.irq =3D ADE9000_ST1_ZXIA_BIT,
> +			.wfb_trg =3D ADE9000_WFB_TRG_ZXIA_BIT
> +		}, {
> +			.irq =3D ADE9000_ST1_ZXVB_BIT,
> +			.wfb_trg =3D ADE9000_WFB_TRG_ZXVB_BIT
> +		}, {
> +			.irq =3D ADE9000_ST1_ZXIB_BIT,
> +			.wfb_trg =3D ADE9000_WFB_TRG_ZXIB_BIT
> +		}, {
> +			.irq =3D ADE9000_ST1_ZXVC_BIT,
> +			.wfb_trg =3D ADE9000_WFB_TRG_ZXVC_BIT
> +		}, {
> +			.irq =3D ADE9000_ST1_ZXIC_BIT,
> +			.wfb_trg =3D ADE9000_WFB_TRG_ZXIC_BIT
> +		},
> +	};
> +
> +	if (dir =3D=3D IIO_EV_DIR_EITHER) {
> +		if (state) {
> +			interrupts |=3D trig_arr[chan->channel * 2 + chan->type].irq;
> +			st->wfb_trg |=3D trig_arr[chan->channel * 2 + chan->type].wfb_trg;
> +		} else {
> +			interrupts &=3D ~trig_arr[chan->channel * 2 + chan->type].irq;
> +			st->wfb_trg &=3D ~trig_arr[chan->channel * 2 + chan->type].wfb_trg;
> +		}
> +	}
> +
> +	if (dir =3D=3D IIO_EV_DIR_NONE) {
> +		switch (chan->channel) {
> +		case ADE9000_PHASE_A_NR:
> +			tmp |=3D ADE9000_ST1_ZXTOVA_BIT;
> +			break;
> +		case ADE9000_PHASE_B_NR:
> +			tmp |=3D ADE9000_ST1_ZXTOVB_BIT;
> +			break;
> +		case ADE9000_PHASE_C_NR:
> +			tmp |=3D ADE9000_ST1_ZXTOVC_BIT;
> +			break;
> +		default:
> +			break;
> +		}
> +
> +		if (state)
> +			interrupts |=3D tmp;
> +		else
> +			interrupts &=3D ~tmp;
> +	} else if (dir =3D=3D IIO_EV_DIR_RISING) {
> +		switch (chan->channel) {
> +		case ADE9000_PHASE_A_NR:
> +			tmp |=3D ADE9000_ST1_SWELLA_BIT;
> +			break;
> +		case ADE9000_PHASE_B_NR:
> +			tmp |=3D ADE9000_ST1_SWELLB_BIT;
> +			break;
> +		case ADE9000_PHASE_C_NR:
> +			tmp |=3D ADE9000_ST1_SWELLC_BIT;
> +			break;
> +		default:
> +			break;
> +		}
> +
> +		if (state) {
> +			interrupts |=3D tmp;
> +			st->wfb_trg |=3D ADE9000_WFB_TRG_SWELL_BIT;
> +		} else {
> +			interrupts &=3D ~tmp;
> +			st->wfb_trg &=3D ~ADE9000_WFB_TRG_SWELL_BIT;
> +		}
> +	} else if (dir =3D=3D IIO_EV_DIR_FALLING) {
> +		switch (chan->channel) {
> +		case ADE9000_PHASE_A_NR:
> +			tmp |=3D ADE9000_ST1_DIPA_BIT;
> +			break;
> +		case ADE9000_PHASE_B_NR:
> +			tmp |=3D ADE9000_ST1_DIPB_BIT;
> +			break;
> +		case ADE9000_PHASE_C_NR:
> +			tmp |=3D ADE9000_ST1_DIPC_BIT;
> +			break;
> +		default:
> +			break;
> +		}
> +
> +		if (state) {
> +			interrupts |=3D tmp;
> +			st->wfb_trg |=3D ADE9000_WFB_TRG_DIP_BIT;
> +		} else {
> +			interrupts &=3D ~tmp;
> +			st->wfb_trg &=3D ~ADE9000_WFB_TRG_DIP_BIT;
> +		}
> +	}
> +
> +	return regmap_update_bits(st->regmap, ADE9000_REG_MASK1, interrupts,
> +				  interrupts);
> +}
> +
> +static int ade9000_write_event_value(struct iio_dev *indio_dev,
> +				     const struct iio_chan_spec *chan,
> +				     enum iio_event_type type,
> +				     enum iio_event_direction dir,
> +				     enum iio_event_info info,
> +				     int val, int val2)
> +{
> +	struct ade9000_state *st =3D iio_priv(indio_dev);
> +
> +	switch (info) {
> +	case IIO_EV_INFO_VALUE:
> +		switch (dir) {
> +		case IIO_EV_DIR_FALLING:
> +			return regmap_write(st->regmap, ADE9000_REG_DIP_LVL, val);
> +		case IIO_EV_DIR_RISING:
> +			return regmap_write(st->regmap, ADE9000_REG_SWELL_LVL, val);
> +		case IIO_EV_DIR_NONE:
> +			return regmap_write(st->regmap, ADE9000_REG_ZXTOUT, val);

This is new.  Can we have some documentation for this device
please so we can understand what these events are.  This one seems to be
an event on the absence of a zero cross for a timeout.  That's not what we'd
normally expect to see EV_DIR_NONE for.  I'm not immediately sure how we su=
pport
this.  Probably needs something new for 'not happening event' and then peri=
od to
control the timeout.   Or use the existing fault event type maybe but we'd =
need
to expand how that is used anyway, so not much help.

Where you know there is something a little unusual like this, it's well wor=
th
making that clear in the patch description.

> +		default:
> +			return -EINVAL;
> +		}
> +	default:
> +		return -EINVAL;
> +	}
> +}



> +
> +static int ade9000_buffer_postdisable(struct iio_dev *indio_dev)
> +{
> +	struct ade9000_state *st =3D iio_priv(indio_dev);
> +	u32 interrupts;
> +	int ret;
> +
> +	ret =3D regmap_update_bits(st->regmap, ADE9000_REG_WFB_CFG,
> +				 ADE9000_WF_CAP_EN_MASK, 0);
> +	if (ret) {
> +		dev_err(&st->spi->dev, "Post-disable waveform buffer disable fail\n");

Local struct device *dev probably a good idea in this function.
I'll not comment on this again (reviewing up the file) so check for
other similar places and add the local variable wherever there are multiple
accesses to if in a function.

> +		return ret;
> +	}
> +
> +	ret =3D regmap_write(st->regmap, ADE9000_REG_WFB_TRG_CFG, 0x0);
> +	if (ret)
> +		return ret;
> +
> +	interrupts =3D ADE9000_ST0_WFB_TRIG_BIT | ADE9000_ST0_PAGE_FULL_BIT;
> +
> +	return regmap_update_bits(st->regmap, ADE9000_REG_MASK0, interrupts, 0);
> +	if (ret) {
> +		dev_err(&st->spi->dev, "Post-disable update maks0 fail\n");
> +		return ret;
> +	}
> +
> +	return regmap_write(st->regmap, ADE9000_REG_STATUS0, GENMASK(31, 0));
> +}
> +
> +static int ade9000_reset(struct ade9000_state *st)
> +{
> +	struct gpio_desc *gpio_reset;
> +	int ret;
> +
> +	reinit_completion(&st->reset_completion);

I guess this is preparing for a situation where we call reset other
than just after init_completion() is done in probe?

If there is a reason this is needed today add a comment perhaps.

> +
> +	gpio_reset =3D devm_gpiod_get_optional(&st->spi->dev, "reset",
> +					     GPIOD_OUT_HIGH);

Binding says it's required and clearly it isn't, so relax the binding.

> +	if (IS_ERR(gpio_reset))
> +		return PTR_ERR(gpio_reset);
> +
> +	if (gpio_reset) {
> +		fsleep(10);
> +		gpiod_set_value_cansleep(gpio_reset, 0);
> +		fsleep(50000);
> +	} else {
> +		ret =3D regmap_update_bits(st->regmap, ADE9000_REG_CONFIG1,
> +					 ADE9000_SWRST_BIT, ADE9000_SWRST_BIT);
> +		if (ret)
> +			return ret;
> +		fsleep(90);

If you went this path, why should the completion be set?
Probably want to just return 0 here.

> +	}
> +
> +	if (!wait_for_completion_timeout(&st->reset_completion,
> +					 msecs_to_jiffies(1000))) {
> +		dev_err(&st->spi->dev, "Reset timeout after 1s\n");
> +		return -ETIMEDOUT;
> +	}
> +
> +	return 0;
> +}
> +
> +static int ade9000_setup(struct ade9000_state *st)
> +{
> +	int ret;
> +
> +	ret =3D regmap_multi_reg_write(st->regmap, ade9000_reg_sequence,
> +				     ARRAY_SIZE(ade9000_reg_sequence));
> +	if (ret) {
> +		dev_err(&st->spi->dev, "Failed to write register sequence: %d\n", ret);
> +		return ret;

Only seems to be called from probe, so can you use
		return dev_err_probe(dev, ret, ...)

Use a local variable for dev as well to simplify the various places it is u=
sed.

> +	}
> +
> +	fsleep(2000);
> +
> +	/* Clear all pending status bits by writing 1s */
> +	ret =3D regmap_write(st->regmap, ADE9000_REG_STATUS0, GENMASK(31, 0));
> +	if (ret) {
> +		dev_err(&st->spi->dev, "Failed to clear STATUS0: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret =3D regmap_write(st->regmap, ADE9000_REG_STATUS1, GENMASK(31, 0));
> +	if (ret) {
> +		dev_err(&st->spi->dev, "Failed to clear STATUS1: %d\n", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}

> +static int ade9000_setup_clkout(struct device *dev, struct ade9000_state=
 *st)
> +{
> +	struct clk_init_data clk_init =3D {};
> +	struct clk *clkout;
> +	int ret;
> +
> +	/*
> +	 * Only provide clock output when using external CMOS clock.
> +	 * When using crystal, CLKOUT is connected to crystal and shouldn't
> +	 * be used as clock provider for other devices.
> +	 */
> +	if (!device_property_present(dev, "#clock-cells") || !st->clkin)
> +		return 0;
> +
> +	if (device_property_read_string(dev, "clock-output-names", &clk_init.na=
me)) {
> +		clk_init.name =3D devm_kasprintf(dev, GFP_KERNEL, "%s-clk",
> +					       fwnode_get_name(dev_fwnode(dev)));

I'm not that familiar with generic clocks, but why is it helpful to register
a clock with a generated name?  Is there some convention of being able to u=
se
this format? If so could you point me to the doc.

I see there are a few similar examples, but the format doesn't match this in
at least the one I looked at.

> +		if (!clk_init.name)
> +			return -ENOMEM;
> +	}
> +
> +	clk_init.ops =3D &ade9000_clkout_ops;
> +	clk_init.flags =3D CLK_GET_RATE_NOCACHE;
> +	clk_init.num_parents =3D 0;
> +
> +	st->clkout_hw.init =3D &clk_init;
> +
> +	clkout =3D devm_clk_register(dev, &st->clkout_hw);
> +	if (IS_ERR(clkout))
> +		return dev_err_probe(dev, PTR_ERR(clkout), "Failed to register clkout"=
);
> +
> +	ret =3D devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get, &st->clk=
out_hw);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to add clock provider");
> +
> +	return 0;
> +}
> +
> +static int ade9000_request_irq(struct device *dev, const char *name,
> +			       irq_handler_t handler, void *dev_id)
> +{
> +	int irq, ret;
> +
> +	irq =3D fwnode_irq_get_byname(dev_fwnode(dev), name);
> +	if (irq < 0)
> +		return dev_err_probe(dev, -EINVAL, "Unable to find %s", name);
> +
> +	ret =3D devm_request_threaded_irq(dev, irq, NULL, handler,
> +					IRQF_ONESHOT, KBUILD_MODNAME, dev_id);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to request threaded irq: %d", r=
et);
> +
> +	return 0;
> +}
> +
> +static int ade9000_probe(struct spi_device *spi)
> +{
> +	struct device *dev =3D &spi->dev;
> +	struct iio_dev *indio_dev;
> +	struct ade9000_state *st;
> +	struct regmap *regmap;
> +	int ret;
> +
> +	indio_dev =3D devm_iio_device_alloc(dev, sizeof(*st));
> +	if (!indio_dev)
> +		return dev_err_probe(dev, -ENOMEM, "Unable to allocate ADE9000 IIO");
> +
> +	st =3D iio_priv(indio_dev);

> +
> +	regmap =3D devm_regmap_init(dev, NULL, st, &ade9000_regmap_config);
> +	if (IS_ERR(regmap))
> +		return dev_err_probe(dev, PTR_ERR(regmap), "Unable to allocate ADE9000=
 regmap");

I'd set st->regmap here to make it clear you are keeping it around.

> +
> +	spi_set_drvdata(spi, st);

Why?  I'm not spotting this being used.

> +
> +	ret =3D ade9000_request_irq(dev, "irq0", ade9000_irq0_thread, indio_dev=
);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D ade9000_request_irq(dev, "irq1", ade9000_irq1_thread, indio_dev=
);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D ade9000_request_irq(dev, "dready", ade9000_dready_thread, indio=
_dev);
> +	if (ret)
> +		return ret;
> +
> +	st->spi =3D spi;
> +	st->regmap =3D regmap;
> +
> +	init_completion(&st->reset_completion);

Move this before request of the relevant IRQ.  You might get a spurious one=
 otherwise
and complete before this init.=20

> +
> +	/* External CMOS clock input (optional - crystal can be used instead) */
> +	st->clkin =3D devm_clk_get_optional_enabled(dev, "clkin");
> +	if (IS_ERR(st->clkin))
> +		return dev_err_probe(dev, PTR_ERR(st->clkin), "Failed to get and enabl=
e clkin");
> +
> +	ret =3D ade9000_setup_clkout(dev, st);
> +	if (ret)
> +		return ret;
> +
> +	indio_dev->name =3D "ade9000";
> +	indio_dev->info =3D &ade9000_info;
> +	indio_dev->modes =3D INDIO_DIRECT_MODE | INDIO_BUFFER_SOFTWARE;
> +	indio_dev->setup_ops =3D &ade9000_buffer_ops;
> +
> +	ret =3D devm_regulator_get_enable(&spi->dev, "vdd");
> +	if (ret)
> +		return dev_err_probe(&spi->dev, ret,
> +				     "Failed to get and enable vdd regulator\n");
> +
> +	ret =3D devm_regulator_get_enable_optional(dev, "vref");
> +	if (ret < 0 && ret !=3D -ENODEV)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to get and enable vref regulator\n");
> +
> +	/* Configure reference selection based on vref regulator availability */
> +	if (ret !=3D -ENODEV) {
> +		ret =3D regmap_update_bits(st->regmap, ADE9000_REG_CONFIG1,
> +					 ADE9000_EXT_REF_MASK,
> +					 ADE9000_EXT_REF_MASK);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	indio_dev->channels =3D ade9000_channels;
> +	indio_dev->num_channels =3D ARRAY_SIZE(ade9000_channels);
> +
> +	ret =3D devm_iio_kfifo_buffer_setup(dev, indio_dev,
> +					  &ade9000_buffer_ops);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to setup IIO buffer");
> +
> +	ret =3D ade9000_reset(st);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D ade9000_setup(st);
> +	if (ret)
> +		return ret;
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +};
>


