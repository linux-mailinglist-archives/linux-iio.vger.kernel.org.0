Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 140A839670D
	for <lists+linux-iio@lfdr.de>; Mon, 31 May 2021 19:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233807AbhEaRaJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 31 May 2021 13:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233626AbhEaR3s (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 31 May 2021 13:29:48 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1F4BC074B08;
        Mon, 31 May 2021 09:12:42 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id x73so2105620pfc.8;
        Mon, 31 May 2021 09:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Apfl3pQ8nQgztr3WxkN6DUZE1thmd0c4lMpK0SCHd94=;
        b=ty7beSHcjccOQHLVzWp6b+FnzBvSrI/fgio6cNe2xUH4E8LnUj/jJiVnsu2hHIZUfG
         d724W2fZI4wdcMPLKyuKXvRMdKLdv/rbrLaBuZAtGK2VaPelJyroeYADQNtLqxLaAtqV
         nXYVvtKVEsdkNPC1ThLCXEWKFcl22JOhOoKlds7CasdSv46y3kV8SebhtbWo2j2AdIWi
         79hDFwjhjGMVhZaOaD07o5iYOrOV2Mto/jEHbKzmVeZKDidVRXwLV2cEf/g6Q12Awlz+
         7FL7PlMa6fQD6fecBliJDgvZ9CfVOv41VI5wJSgF0D8VkZtIrD8D66K7mEXrq799a1N5
         CoiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Apfl3pQ8nQgztr3WxkN6DUZE1thmd0c4lMpK0SCHd94=;
        b=Drs8vpJcdndx1cK1yHIg4ODWI0p8llDQyBdF64xp48DotNw2r2Jdq3XO3AfacB/jS/
         X3gXt+gkTsk7DyDm1vePBY1OfwwK89VxzEPxX9EYrNTvO/2rckFOwXOxeUWGakNnQ91x
         rrHETu+Zz9KzTaJuB5AsQ+2f5D7z5cXa1Fws8FyfU7ALc4KQmx/fYU2jrJeoL2S6+8yj
         kenQAVn5kOh/ry27C6Z9pMFlfG1vxrGO5PHTxYDQfa/R47C2k6f7V031AskV5YcJuXvo
         3K/YnhEdZoSMKcPOHfndfPXwnAmU1Q5NLQyQUjAveS9443IRsKpLZoKo5IQ5+MtYnesx
         WKVg==
X-Gm-Message-State: AOAM530K1HPjXa1c9eQrsNj1TGCKvDzbGVzq+tbcfZZ6kjfLqTGkPgwf
        F7EZ5TEWPSDELHZiDzlq8Hbe0CBpIL875evA11GkWk1O07MU6A==
X-Google-Smtp-Source: ABdhPJwncaqMfQaYCoMEV9r4L/fqbnmsKHZ6pVuvF//FbsW4MHmVpJHz9OPikT1I/BJmK2n6GCNzm5HI6bI9cRUtTJQ=
X-Received: by 2002:a63:b243:: with SMTP id t3mr23510852pgo.253.1622477562070;
 Mon, 31 May 2021 09:12:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210528172959.15663-1-anand.ashok.dumbre@xilinx.com> <20210528172959.15663-3-anand.ashok.dumbre@xilinx.com>
In-Reply-To: <20210528172959.15663-3-anand.ashok.dumbre@xilinx.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Mon, 31 May 2021 19:12:30 +0300
Message-ID: <CA+U=DspgdgRUb5VEVo-BWBg76rKYPYk9qNkk+nXKw0E19y2mSg@mail.gmail.com>
Subject: Re: [PATCH v5 2/4] iio: adc: Add Xilinx AMS driver
To:     Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>, git-dev@xilinx.com,
        Michal Simek <michal.simek@xilinx.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        devicetree <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Manish Narani <manish.narani@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

(()

On Fri, May 28, 2021 at 8:31 PM Anand Ashok Dumbre
<anand.ashok.dumbre@xilinx.com> wrote:
>
> The AMS includes an ADC as well as on-chip sensors that can be used to
> sample external voltages and monitor on-die operating conditions, such
> as temperature and supply voltage levels. The AMS has two SYSMON blocks.
> PL-SYSMON block is capable of monitoring off chip voltage and
> temperature.
> PL-SYSMON block has DRP, JTAG and I2C interface to enable monitoring
> from external master. Out of these interface currently only DRP is
> supported.
> Other block PS-SYSMON is memory mapped to PS.
> The AMS can use internal channels to monitor voltage and temperature as
> well as one primary and up to 16 auxiliary channels for measuring
> external voltages.
> The voltage and temperature monitoring channels also have event
> capability which allows to generate an interrupt when their value falls
> below or raises above a set threshold.
>
> Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> Signed-off-by: Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
> ---
>  drivers/iio/adc/Kconfig      |   13 +
>  drivers/iio/adc/Makefile     |    1 +
>  drivers/iio/adc/xilinx-ams.c | 1341 ++++++++++++++++++++++++++++++++++
>  3 files changed, 1355 insertions(+)
>  create mode 100644 drivers/iio/adc/xilinx-ams.c
>
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index c7946c439612..c011ab30ec9a 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -1256,4 +1256,17 @@ config XILINX_XADC
>           The driver can also be build as a module. If so, the module will be called
>           xilinx-xadc.
>
> +config XILINX_AMS
> +       tristate "Xilinx AMS driver"
> +       depends on ARCH_ZYNQMP || COMPILE_TEST
> +       depends on HAS_IOMEM
> +       help
> +         Say yes here to have support for the Xilinx AMS.
> +
> +         The driver supports Voltage and Temperature monitoring on Xilinx Ultrascale
> +         devices.
> +
> +         The driver can also be built as a module. If so, the module will be called
> +         xilinx-ams.
> +
>  endmenu
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index a226657d19c0..99e031f44479 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -112,4 +112,5 @@ obj-$(CONFIG_VF610_ADC) += vf610_adc.o
>  obj-$(CONFIG_VIPERBOARD_ADC) += viperboard_adc.o
>  xilinx-xadc-y := xilinx-xadc-core.o xilinx-xadc-events.o
>  obj-$(CONFIG_XILINX_XADC) += xilinx-xadc.o
> +obj-$(CONFIG_XILINX_AMS) += xilinx-ams.o
>  obj-$(CONFIG_SD_ADC_MODULATOR) += sd_adc_modulator.o
> diff --git a/drivers/iio/adc/xilinx-ams.c b/drivers/iio/adc/xilinx-ams.c
> new file mode 100644
> index 000000000000..0c84f7a9fc80
> --- /dev/null
> +++ b/drivers/iio/adc/xilinx-ams.c
> @@ -0,0 +1,1341 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Xilinx AMS driver
> + *
> + *  Copyright (C) 2017-2018 Xilinx, Inc.

2021 ?  :p

> + *
> + *  Manish Narani <mnarani@xilinx.com>
> + *  Rajnikant Bhojani <rajnikant.bhojani@xilinx.com>
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/iopoll.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of_address.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +
> +#include <linux/iio/events.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +
> +static const unsigned int AMS_UNMASK_TIMEOUT_MS = 500;
> +
> +/* AMS registers definitions */
> +#define AMS_ISR_0                      0x010
> +#define AMS_ISR_1                      0x014
> +#define AMS_IER_0                      0x020
> +#define AMS_IER_1                      0x024
> +#define AMS_IDR_0                      0x028
> +#define AMS_IDR_1                      0x02c
> +#define AMS_PS_CSTS                    0x040
> +#define AMS_PL_CSTS                    0x044
> +
> +#define AMS_VCC_PSPLL0                 0x060
> +#define AMS_VCC_PSPLL3                 0x06C
> +#define AMS_VCCINT                     0x078
> +#define AMS_VCCBRAM                    0x07C
> +#define AMS_VCCAUX                     0x080
> +#define AMS_PSDDRPLL                   0x084
> +#define AMS_PSINTFPDDR                 0x09C
> +
> +#define AMS_VCC_PSPLL0_CH              48
> +#define AMS_VCC_PSPLL3_CH              51
> +#define AMS_VCCINT_CH                  54
> +#define AMS_VCCBRAM_CH                 55
> +#define AMS_VCCAUX_CH                  56
> +#define AMS_PSDDRPLL_CH                        57
> +#define AMS_PSINTFPDDR_CH              63
> +
> +#define AMS_REG_CONFIG0                        0x100
> +#define AMS_REG_CONFIG1                        0x104
> +#define AMS_REG_CONFIG3                        0x10C
> +#define AMS_REG_SEQ_CH0                        0x120
> +#define AMS_REG_SEQ_CH1                        0x124
> +#define AMS_REG_SEQ_CH2                        0x118
> +
> +#define AMS_TEMP                       0x000
> +#define AMS_SUPPLY1                    0x004
> +#define AMS_SUPPLY2                    0x008
> +#define AMS_VP_VN                      0x00c
> +#define AMS_VREFP                      0x010
> +#define AMS_VREFN                      0x014
> +#define AMS_SUPPLY3                    0x018
> +#define AMS_SUPPLY4                    0x034
> +#define AMS_SUPPLY5                    0x038
> +#define AMS_SUPPLY6                    0x03c
> +#define AMS_SUPPLY7                    0x200
> +#define AMS_SUPPLY8                    0x204
> +#define AMS_SUPPLY9                    0x208
> +#define AMS_SUPPLY10                   0x20c
> +#define AMS_VCCAMS                     0x210
> +#define AMS_TEMP_REMOTE                        0x214
> +
> +#define AMS_REG_VAUX(x)                        (0x40 + 4*(x))
> +
> +#define AMS_PS_RESET_VALUE             0xFFFF
> +#define AMS_PL_RESET_VALUE             0xFFFF
> +
> +#define AMS_CONF0_CHANNEL_NUM_MASK     GENMASK(6, 0)
> +
> +#define AMS_CONF1_SEQ_MASK             GENMASK(15, 12)
> +#define AMS_CONF1_SEQ_DEFAULT          (0 << 12)
> +#define AMS_CONF1_SEQ_CONTINUOUS       (2 << 12)
> +#define AMS_CONF1_SEQ_SINGLE_CHANNEL   (3 << 12)
> +
> +#define AMS_REG_SEQ0_MASK              0xFFFF
> +#define AMS_REG_SEQ2_MASK              0x003F
> +#define AMS_REG_SEQ1_MASK              0xFFFF
> +#define AMS_REG_SEQ2_MASK_SHIFT                16
> +#define AMS_REG_SEQ1_MASK_SHIFT                22
> +
> +#define AMS_REGCFG1_ALARM_MASK         0xF0F
> +#define AMS_REGCFG3_ALARM_MASK         0x3F
> +
> +#define AMS_ALARM_TEMP                 0x140
> +#define AMS_ALARM_SUPPLY1              0x144
> +#define AMS_ALARM_SUPPLY2              0x148
> +#define AMS_ALARM_SUPPLY3              0x160
> +#define AMS_ALARM_SUPPLY4              0x164
> +#define AMS_ALARM_SUPPLY5              0x168
> +#define AMS_ALARM_SUPPLY6              0x16c
> +#define AMS_ALARM_SUPPLY7              0x180
> +#define AMS_ALARM_SUPPLY8              0x184
> +#define AMS_ALARM_SUPPLY9              0x188
> +#define AMS_ALARM_SUPPLY10             0x18c
> +#define AMS_ALARM_VCCAMS               0x190
> +#define AMS_ALARM_TEMP_REMOTE          0x194
> +#define AMS_ALARM_THRESHOLD_OFF_10     0x10
> +#define AMS_ALARM_THRESHOLD_OFF_20     0x20
> +
> +#define AMS_ALARM_THR_DIRECT_MASK      0x01
> +#define AMS_ALARM_THR_MIN              0x0000
> +#define AMS_ALARM_THR_MAX              0xffff
> +
> +#define AMS_NO_OF_ALARMS               32
> +#define AMS_PL_ALARM_START             16
> +#define AMS_ISR0_ALARM_MASK            0xFFFFFFFFU
> +#define AMS_ISR1_ALARM_MASK            0xE000001FU
> +#define AMS_ISR1_EOC_MASK              0x00000008U
> +#define AMS_ISR1_INTR_MASK_SHIFT       32
> +#define AMS_ISR0_ALARM_2_TO_0_MASK     0x07
> +#define AMS_ISR0_ALARM_6_TO_3_MASK     0x78
> +#define AMS_ISR0_ALARM_12_TO_7_MASK    0x3F
> +#define AMS_CONF1_ALARM_2_TO_0_SHIFT   1
> +#define AMS_CONF1_ALARM_6_TO_3_SHIFT   5
> +#define AMS_CONF3_ALARM_12_TO_7_SHIFT  8
> +
> +#define AMS_PS_CSTS_PS_READY           0x08010000U
> +#define AMS_PL_CSTS_ACCESS_MASK                0x00000001U
> +
> +#define AMS_PL_MAX_FIXED_CHANNEL       10
> +#define AMS_PL_MAX_EXT_CHANNEL         20
> +
> +#define AMS_INIT_TIMEOUT_US            10000
> +
> +/*
> + * Following scale and offset value is derived from
> + * UG580 (v1.7) December 20, 2016
> + */
> +#define AMS_SUPPLY_SCALE_1VOLT         1000
> +#define AMS_SUPPLY_SCALE_3VOLT         3000
> +#define AMS_SUPPLY_SCALE_6VOLT         6000
> +#define AMS_SUPPLY_SCALE_DIV_BIT       16
> +
> +#define AMS_TEMP_SCALE                 509314
> +#define AMS_TEMP_SCALE_DIV_BIT         16
> +#define AMS_TEMP_OFFSET                        -((280230L << 16) / 509314)
> +
> +enum ams_alarm_bit {
> +       AMS_ALARM_BIT_TEMP,
> +       AMS_ALARM_BIT_SUPPLY1,
> +       AMS_ALARM_BIT_SUPPLY2,
> +       AMS_ALARM_BIT_SUPPLY3,
> +       AMS_ALARM_BIT_SUPPLY4,
> +       AMS_ALARM_BIT_SUPPLY5,
> +       AMS_ALARM_BIT_SUPPLY6,
> +       AMS_ALARM_BIT_RESERVED,
> +       AMS_ALARM_BIT_SUPPLY7,
> +       AMS_ALARM_BIT_SUPPLY8,
> +       AMS_ALARM_BIT_SUPPLY9,
> +       AMS_ALARM_BIT_SUPPLY10,
> +       AMS_ALARM_BIT_VCCAMS,
> +       AMS_ALARM_BIT_TEMP_REMOTE
> +};
> +
> +enum ams_seq {
> +       AMS_SEQ_VCC_PSPLL,
> +       AMS_SEQ_VCC_PSBATT,
> +       AMS_SEQ_VCCINT,
> +       AMS_SEQ_VCCBRAM,
> +       AMS_SEQ_VCCAUX,
> +       AMS_SEQ_PSDDRPLL,
> +       AMS_SEQ_INTDDR
> +};
> +
> +enum ams_ps_pl_seq {
> +       AMS_SEQ_CALIB,
> +       AMS_SEQ_RSVD_1,
> +       AMS_SEQ_RSVD_2,
> +       AMS_SEQ_TEST,
> +       AMS_SEQ_RSVD_4,
> +       AMS_SEQ_SUPPLY4,
> +       AMS_SEQ_SUPPLY5,
> +       AMS_SEQ_SUPPLY6,
> +       AMS_SEQ_TEMP,
> +       AMS_SEQ_SUPPLY2,
> +       AMS_SEQ_SUPPLY1,
> +       AMS_SEQ_VP_VN,
> +       AMS_SEQ_VREFP,
> +       AMS_SEQ_VREFN,
> +       AMS_SEQ_SUPPLY3,
> +       AMS_SEQ_CURRENT_MON,
> +       AMS_SEQ_SUPPLY7,
> +       AMS_SEQ_SUPPLY8,
> +       AMS_SEQ_SUPPLY9,
> +       AMS_SEQ_SUPPLY10,
> +       AMS_SEQ_VCCAMS,
> +       AMS_SEQ_TEMP_REMOTE,
> +       AMS_SEQ_MAX
> +};
> +
> +#define AMS_SEQ(x)             (AMS_SEQ_MAX + (x))
> +#define AMS_VAUX_SEQ(x)                (AMS_SEQ_MAX + (x))
> +
> +#define AMS_PS_SEQ_MAX         AMS_SEQ_MAX
> +#define PS_SEQ(x)              (x)
> +#define PL_SEQ(x)              (AMS_PS_SEQ_MAX + (x))
> +
> +#define AMS_CHAN_TEMP(_scan_index, _addr) { \
> +       .type = IIO_TEMP, \
> +       .indexed = 1, \
> +       .address = (_addr), \
> +       .info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | \
> +               BIT(IIO_CHAN_INFO_SCALE) | \
> +               BIT(IIO_CHAN_INFO_OFFSET), \
> +       .info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ), \
> +       .event_spec = ams_temp_events, \
> +       .num_event_specs = ARRAY_SIZE(ams_temp_events), \
> +       .scan_index = (_scan_index), \
> +       .scan_type = { \
> +               .sign = 'u', \
> +               .realbits = 12, \
> +               .storagebits = 16, \
> +               .shift = 4, \
> +               .endianness = IIO_CPU, \
> +       }, \
> +}
> +
> +#define AMS_CHAN_VOLTAGE(_scan_index, _addr, _alarm) { \
> +       .type = IIO_VOLTAGE, \
> +       .indexed = 1, \
> +       .address = (_addr), \
> +       .info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | \
> +               BIT(IIO_CHAN_INFO_SCALE), \
> +       .info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ), \
> +       .event_spec = (_alarm) ? ams_voltage_events : NULL, \
> +       .num_event_specs = (_alarm) ? ARRAY_SIZE(ams_voltage_events) : 0, \
> +       .scan_index = (_scan_index), \
> +       .scan_type = { \
> +               .realbits = 10, \
> +               .storagebits = 16, \
> +               .shift = 6, \
> +               .endianness = IIO_CPU, \
> +       }, \
> +}
> +
> +#define AMS_PS_CHAN_TEMP(_scan_index, _addr) \
> +       AMS_CHAN_TEMP(PS_SEQ(_scan_index), _addr)
> +#define AMS_PS_CHAN_VOLTAGE(_scan_index, _addr) \
> +       AMS_CHAN_VOLTAGE(PS_SEQ(_scan_index), _addr, true)
> +
> +#define AMS_PL_CHAN_TEMP(_scan_index, _addr) \
> +       AMS_CHAN_TEMP(PL_SEQ(_scan_index), _addr)
> +#define AMS_PL_CHAN_VOLTAGE(_scan_index, _addr, _alarm) \
> +       AMS_CHAN_VOLTAGE(PL_SEQ(_scan_index), _addr, _alarm)
> +#define AMS_PL_AUX_CHAN_VOLTAGE(_auxno) \
> +       AMS_CHAN_VOLTAGE(PL_SEQ(AMS_VAUX_SEQ(_auxno)), \
> +                       AMS_REG_VAUX(_auxno), false)
> +#define AMS_CTRL_CHAN_VOLTAGE(_scan_index, _addr) \
> +       AMS_CHAN_VOLTAGE(PL_SEQ(AMS_VAUX_SEQ(AMS_SEQ(_scan_index))), \
> +                       _addr, false)
> +
> +struct ams {
> +       void __iomem *base;
> +       void __iomem *ps_base;
> +       void __iomem *pl_base;
> +       struct clk *clk;
> +       struct device *dev;
> +       struct mutex lock;
> +       unsigned int alarm_mask;
> +       unsigned int masked_alarm;
> +       u64 intr_mask;
> +       int irq;
> +       struct delayed_work ams_unmask_work;
> +};
> +
> +static inline void ams_ps_update_reg(struct ams *ams, unsigned int offset,
> +                                    u32 mask, u32 data)
> +{
> +       u32 val;
> +
> +       val = readl(ams->ps_base + offset);
> +       writel((val & ~mask) | (data & mask), ams->ps_base + offset);
> +}
> +
> +static inline void ams_pl_update_reg(struct ams *ams, unsigned int offset,
> +                                        u32 mask, u32 data)
> +{
> +       u32 val;
> +
> +       val = readl(ams->pl_base + offset);
> +       writel((val & ~mask) | (data & mask), ams->pl_base + offset);
> +}
> +
> +static void ams_update_intrmask(struct ams *ams, u64 mask, u64 val)
> +{
> +       ams->intr_mask &= ~mask;
> +       ams->intr_mask |= (val & mask);
> +
> +       writel(~(ams->intr_mask | ams->masked_alarm), ams->base + AMS_IER_0);
> +       writel(~(ams->intr_mask >> AMS_ISR1_INTR_MASK_SHIFT),
> +                       ams->base + AMS_IER_1);
> +       writel(ams->intr_mask | ams->masked_alarm, ams->base + AMS_IDR_0);
> +       writel(ams->intr_mask >> AMS_ISR1_INTR_MASK_SHIFT,
> +                       ams->base + AMS_IDR_1);
> +}
> +
> +static void ams_disable_all_alarms(struct ams *ams)
> +{
> +       /* disable PS module alarm */
> +       if (ams->ps_base) {
> +               ams_ps_update_reg(ams, AMS_REG_CONFIG1, AMS_REGCFG1_ALARM_MASK,
> +                                 AMS_REGCFG1_ALARM_MASK);
> +               ams_ps_update_reg(ams, AMS_REG_CONFIG3, AMS_REGCFG3_ALARM_MASK,
> +                                 AMS_REGCFG3_ALARM_MASK);
> +       }
> +
> +       /* disable PL module alarm */
> +       if (ams->pl_base) {
> +               ams_pl_update_reg(ams, AMS_REG_CONFIG1,
> +                                   AMS_REGCFG1_ALARM_MASK,
> +                                   AMS_REGCFG1_ALARM_MASK);
> +               ams_pl_update_reg(ams, AMS_REG_CONFIG3,
> +                                   AMS_REGCFG3_ALARM_MASK,
> +                                   AMS_REGCFG3_ALARM_MASK);
> +       }
> +}
> +
> +static void ams_update_alarm(struct ams *ams, unsigned long alarm_mask)
> +{
> +       u32 cfg;
> +       unsigned long pl_alarm_mask;
> +
> +       if (ams->ps_base) {
> +               /* Configuring PS alarm enable */
> +               cfg = ~((alarm_mask & AMS_ISR0_ALARM_2_TO_0_MASK) <<
> +                              AMS_CONF1_ALARM_2_TO_0_SHIFT);
> +               cfg &= ~((alarm_mask & AMS_ISR0_ALARM_6_TO_3_MASK) <<
> +                               AMS_CONF1_ALARM_6_TO_3_SHIFT);
> +               ams_ps_update_reg(ams, AMS_REG_CONFIG1, AMS_REGCFG1_ALARM_MASK,
> +                                 cfg);
> +
> +               cfg = ~((alarm_mask >> AMS_CONF3_ALARM_12_TO_7_SHIFT) &
> +                               AMS_ISR0_ALARM_12_TO_7_MASK);
> +               ams_ps_update_reg(ams, AMS_REG_CONFIG3, AMS_REGCFG3_ALARM_MASK,
> +                                 cfg);
> +       }
> +
> +       if (ams->pl_base) {
> +               pl_alarm_mask = (alarm_mask >> AMS_PL_ALARM_START);
> +               /* Configuring PL alarm enable */
> +               cfg = ~((pl_alarm_mask & AMS_ISR0_ALARM_2_TO_0_MASK) <<
> +                              AMS_CONF1_ALARM_2_TO_0_SHIFT);
> +               cfg &= ~((pl_alarm_mask & AMS_ISR0_ALARM_6_TO_3_MASK) <<
> +                               AMS_CONF1_ALARM_6_TO_3_SHIFT);
> +               ams_pl_update_reg(ams, AMS_REG_CONFIG1,
> +                               AMS_REGCFG1_ALARM_MASK, cfg);
> +
> +               cfg = ~((pl_alarm_mask >> AMS_CONF3_ALARM_12_TO_7_SHIFT) &
> +                               AMS_ISR0_ALARM_12_TO_7_MASK);
> +               ams_pl_update_reg(ams, AMS_REG_CONFIG3,
> +                               AMS_REGCFG3_ALARM_MASK, cfg);
> +       }
> +
> +       mutex_lock(&ams->lock);
> +       ams_update_intrmask(ams, AMS_ISR0_ALARM_MASK, ~alarm_mask);
> +       mutex_unlock(&ams->lock);
> +}
> +
> +static void ams_enable_channel_sequence(struct iio_dev *indio_dev)
> +{
> +       int i;
> +       unsigned long long scan_mask;
> +       struct ams *ams = iio_priv(indio_dev);
> +
> +       /*
> +        * Enable channel sequence. First 22 bits of scan_mask represent
> +        * PS channels, and next remaining bits represent PL channels.
> +        */
> +
> +       /* Run calibration of PS & PL as part of the sequence */
> +       scan_mask = 0x1 | BIT(AMS_PS_SEQ_MAX);
> +       for (i = 0; i < indio_dev->num_channels; i++)
> +               scan_mask |= BIT(indio_dev->channels[i].scan_index);
> +
> +       if (ams->ps_base) {
> +               /* put sysmon in a soft reset to change the sequence */
> +               ams_ps_update_reg(ams, AMS_REG_CONFIG1, AMS_CONF1_SEQ_MASK,
> +                                 AMS_CONF1_SEQ_DEFAULT);
> +
> +               /* configure basic channels */
> +               writel(scan_mask & AMS_REG_SEQ0_MASK,
> +                               ams->ps_base + AMS_REG_SEQ_CH0);
> +               writel(AMS_REG_SEQ2_MASK &
> +                       (scan_mask >> AMS_REG_SEQ2_MASK_SHIFT),
> +                       ams->ps_base + AMS_REG_SEQ_CH2);
> +
> +               /* set continuous sequence mode */
> +               ams_ps_update_reg(ams, AMS_REG_CONFIG1, AMS_CONF1_SEQ_MASK,
> +                                 AMS_CONF1_SEQ_CONTINUOUS);
> +       }
> +
> +       if (ams->pl_base) {
> +               /* put sysmon in a soft reset to change the sequence */
> +               ams_pl_update_reg(ams, AMS_REG_CONFIG1, AMS_CONF1_SEQ_MASK,
> +                                   AMS_CONF1_SEQ_DEFAULT);
> +
> +               /* configure basic channels */
> +               scan_mask = scan_mask >> AMS_PS_SEQ_MAX;
> +               writel(scan_mask & AMS_REG_SEQ0_MASK,
> +                               ams->pl_base + AMS_REG_SEQ_CH0);
> +               writel(AMS_REG_SEQ2_MASK &
> +                               (scan_mask >> AMS_REG_SEQ2_MASK_SHIFT),
> +                               ams->pl_base + AMS_REG_SEQ_CH2);
> +               writel(AMS_REG_SEQ1_MASK &
> +                               (scan_mask >> AMS_REG_SEQ1_MASK_SHIFT),
> +                               ams->pl_base + AMS_REG_SEQ_CH1);
> +
> +               /* set continuous sequence mode */
> +               ams_pl_update_reg(ams, AMS_REG_CONFIG1, AMS_CONF1_SEQ_MASK,
> +                               AMS_CONF1_SEQ_CONTINUOUS);
> +       }
> +}
> +
> +static int ams_init_device(struct ams *ams)
> +{
> +       u32 reg;
> +       int ret;
> +
> +       /* reset AMS */
> +       if (ams->ps_base) {
> +               writel(AMS_PS_RESET_VALUE, ams->ps_base + AMS_VP_VN);
> +
> +               ret = readl_poll_timeout(ams->base + AMS_PS_CSTS, reg,
> +                                        (reg & AMS_PS_CSTS_PS_READY) ==
> +                                        AMS_PS_CSTS_PS_READY, 0,
> +                                        AMS_INIT_TIMEOUT_US);
> +               if (ret)
> +                       return ret;
> +
> +               /* put sysmon in a default state */
> +               ams_ps_update_reg(ams, AMS_REG_CONFIG1, AMS_CONF1_SEQ_MASK,
> +                                 AMS_CONF1_SEQ_DEFAULT);
> +       }
> +
> +       if (ams->pl_base) {
> +               writel(AMS_PL_RESET_VALUE, ams->pl_base + AMS_VP_VN);
> +
> +               ret = readl_poll_timeout(ams->base + AMS_PL_CSTS, reg,
> +                                        (reg & AMS_PL_CSTS_ACCESS_MASK) ==
> +                                        AMS_PL_CSTS_ACCESS_MASK, 0,
> +                                        AMS_INIT_TIMEOUT_US);
> +               if (ret)
> +                       return ret;
> +
> +               /* put sysmon in a default state */
> +               ams_pl_update_reg(ams, AMS_REG_CONFIG1, AMS_CONF1_SEQ_MASK,
> +                                   AMS_CONF1_SEQ_DEFAULT);
> +       }
> +
> +       ams_disable_all_alarms(ams);
> +
> +       /* Disable interrupt */
> +       ams_update_intrmask(ams, ~0, ~0);
> +
> +       /* Clear any pending interrupt */
> +       writel(AMS_ISR0_ALARM_MASK, ams->base + AMS_ISR_0);
> +       writel(AMS_ISR1_ALARM_MASK, ams->base + AMS_ISR_1);
> +
> +       return 0;
> +}
> +
> +static int ams_enable_single_channel(struct ams *ams, unsigned int offset)
> +{
> +       u8 channel_num = 0;
> +
> +       switch (offset) {
> +       case AMS_VCC_PSPLL0:
> +               channel_num = AMS_VCC_PSPLL0_CH;
> +               break;
> +       case AMS_VCC_PSPLL3:
> +               channel_num = AMS_VCC_PSPLL3_CH;
> +               break;
> +       case AMS_VCCINT:
> +               channel_num = AMS_VCCINT_CH;
> +               break;
> +       case AMS_VCCBRAM:
> +               channel_num = AMS_VCCBRAM_CH;
> +               break;
> +       case AMS_VCCAUX:
> +               channel_num = AMS_VCCAUX_CH;
> +               break;
> +       case AMS_PSDDRPLL:
> +               channel_num = AMS_PSDDRPLL_CH;
> +               break;
> +       case AMS_PSINTFPDDR:
> +               channel_num = AMS_PSINTFPDDR_CH;
> +               break;
> +       default:
> +               return -EINVAL;
> +       }
> +
> +       /* set single channel, sequencer off mode */
> +       ams_ps_update_reg(ams, AMS_REG_CONFIG1, AMS_CONF1_SEQ_MASK,
> +                       AMS_CONF1_SEQ_SINGLE_CHANNEL);
> +
> +       /* write the channel number */
> +       ams_ps_update_reg(ams, AMS_REG_CONFIG0, AMS_CONF0_CHANNEL_NUM_MASK,
> +                       channel_num);
> +       return 0;
> +}
> +
> +static int ams_read_vcc_reg(struct ams *ams, unsigned int offset, u32 *data)
> +{
> +       u32 reg;
> +       int ret;
> +
> +       ret = ams_enable_single_channel(ams, offset);
> +       if (ret)
> +               return ret;
> +
> +       ret = readl_poll_timeout(ams->base + AMS_ISR_1, reg,
> +                                (reg & AMS_ISR1_EOC_MASK) == AMS_ISR1_EOC_MASK,
> +                                0, AMS_INIT_TIMEOUT_US);
> +       if (ret)
> +               return ret;
> +
> +       *data = readl(ams->base + offset);
> +
> +       return 0;
> +}
> +
> +static int ams_read_raw(struct iio_dev *indio_dev,
> +                       struct iio_chan_spec const *chan,
> +                       int *val, int *val2, long mask)
> +{
> +       struct ams *ams = iio_priv(indio_dev);
> +       int ret;
> +
> +       switch (mask) {
> +       case IIO_CHAN_INFO_RAW:
> +               mutex_lock(&ams->lock);
> +               if (chan->scan_index >= (AMS_PS_SEQ_MAX * 3)) {
> +                       ret = ams_read_vcc_reg(ams, chan->address, val);
> +                       if (ret) {
> +                               mutex_unlock(&ams->lock);
> +                               return -EINVAL;
> +                       }
> +                       ams_enable_channel_sequence(indio_dev);
> +               } else if (chan->scan_index >= AMS_PS_SEQ_MAX)
> +                       *val = readl(ams->pl_base + chan->address);
> +               else
> +                       *val = readl(ams->ps_base + chan->address);
> +               mutex_unlock(&ams->lock);
> +
> +               return IIO_VAL_INT;
> +       case IIO_CHAN_INFO_SCALE:
> +               switch (chan->type) {
> +               case IIO_VOLTAGE:
> +                       switch (chan->address) {
> +                       case AMS_SUPPLY1:
> +                       case AMS_SUPPLY2:
> +                       case AMS_SUPPLY3:
> +                       case AMS_SUPPLY4:
> +                               *val = AMS_SUPPLY_SCALE_3VOLT;
> +                               break;
> +                       case AMS_SUPPLY5:
> +                       case AMS_SUPPLY6:
> +                               if (chan->scan_index < AMS_PS_SEQ_MAX)
> +                                       *val = AMS_SUPPLY_SCALE_6VOLT;
> +                               else
> +                                       *val = AMS_SUPPLY_SCALE_3VOLT;
> +                               break;
> +                       case AMS_SUPPLY7:
> +                       case AMS_SUPPLY8:
> +                               *val = AMS_SUPPLY_SCALE_6VOLT;
> +                               break;
> +                       case AMS_SUPPLY9:
> +                       case AMS_SUPPLY10:
> +                               if (chan->scan_index < AMS_PS_SEQ_MAX)
> +                                       *val = AMS_SUPPLY_SCALE_3VOLT;
> +                               else
> +                                       *val = AMS_SUPPLY_SCALE_6VOLT;
> +                               break;
> +                       case AMS_VCC_PSPLL0:
> +                       case AMS_VCC_PSPLL3:
> +                       case AMS_VCCINT:
> +                       case AMS_VCCBRAM:
> +                       case AMS_VCCAUX:
> +                       case AMS_PSDDRPLL:
> +                       case AMS_PSINTFPDDR:
> +                               *val = AMS_SUPPLY_SCALE_3VOLT;
> +                               break;
> +                       default:
> +                               *val = AMS_SUPPLY_SCALE_1VOLT;
> +                               break;
> +                       }
> +                       *val2 = AMS_SUPPLY_SCALE_DIV_BIT;
> +                       return IIO_VAL_FRACTIONAL_LOG2;
> +               case IIO_TEMP:
> +                       *val = AMS_TEMP_SCALE;
> +                       *val2 = AMS_TEMP_SCALE_DIV_BIT;
> +                       return IIO_VAL_FRACTIONAL_LOG2;
> +               default:
> +                       return -EINVAL;
> +               }
> +       case IIO_CHAN_INFO_OFFSET:
> +               /* Only the temperature channel has an offset */
> +               *val = AMS_TEMP_OFFSET;
> +               return IIO_VAL_INT;
> +       }
> +
> +       return -EINVAL;
> +}
> +
> +static int ams_get_alarm_offset(int scan_index, enum iio_event_direction dir)
> +{
> +       int offset = 0;
> +
> +       if (scan_index >= AMS_PS_SEQ_MAX)
> +               scan_index -= AMS_PS_SEQ_MAX;
> +
> +       if (dir == IIO_EV_DIR_FALLING) {
> +               if (scan_index < AMS_SEQ_SUPPLY7)
> +                       offset = AMS_ALARM_THRESHOLD_OFF_10;
> +               else
> +                       offset = AMS_ALARM_THRESHOLD_OFF_20;
> +       }
> +
> +       switch (scan_index) {
> +       case AMS_SEQ_TEMP:
> +               return AMS_ALARM_TEMP + offset;
> +       case AMS_SEQ_SUPPLY1:
> +               return AMS_ALARM_SUPPLY1 + offset;
> +       case AMS_SEQ_SUPPLY2:
> +               return AMS_ALARM_SUPPLY2 + offset;
> +       case AMS_SEQ_SUPPLY3:
> +               return AMS_ALARM_SUPPLY3 + offset;
> +       case AMS_SEQ_SUPPLY4:
> +               return AMS_ALARM_SUPPLY4 + offset;
> +       case AMS_SEQ_SUPPLY5:
> +               return AMS_ALARM_SUPPLY5 + offset;
> +       case AMS_SEQ_SUPPLY6:
> +               return AMS_ALARM_SUPPLY6 + offset;
> +       case AMS_SEQ_SUPPLY7:
> +               return AMS_ALARM_SUPPLY7 + offset;
> +       case AMS_SEQ_SUPPLY8:
> +               return AMS_ALARM_SUPPLY8 + offset;
> +       case AMS_SEQ_SUPPLY9:
> +               return AMS_ALARM_SUPPLY9 + offset;
> +       case AMS_SEQ_SUPPLY10:
> +               return AMS_ALARM_SUPPLY10 + offset;
> +       case AMS_SEQ_VCCAMS:
> +               return AMS_ALARM_VCCAMS + offset;
> +       case AMS_SEQ_TEMP_REMOTE:
> +               return AMS_ALARM_TEMP_REMOTE + offset;
> +       }
> +
> +       return 0;
> +}
> +
> +static const struct iio_chan_spec *ams_event_to_channel(
> +               struct iio_dev *indio_dev, u32 event)
> +{
> +       int scan_index = 0, i;
> +
> +       if (event >= AMS_PL_ALARM_START) {
> +               event -= AMS_PL_ALARM_START;
> +               scan_index = AMS_PS_SEQ_MAX;
> +       }
> +
> +       switch (event) {
> +       case AMS_ALARM_BIT_TEMP:
> +               scan_index += AMS_SEQ_TEMP;
> +               break;
> +       case AMS_ALARM_BIT_SUPPLY1:
> +               scan_index += AMS_SEQ_SUPPLY1;
> +               break;
> +       case AMS_ALARM_BIT_SUPPLY2:
> +               scan_index += AMS_SEQ_SUPPLY2;
> +               break;
> +       case AMS_ALARM_BIT_SUPPLY3:
> +               scan_index += AMS_SEQ_SUPPLY3;
> +               break;
> +       case AMS_ALARM_BIT_SUPPLY4:
> +               scan_index += AMS_SEQ_SUPPLY4;
> +               break;
> +       case AMS_ALARM_BIT_SUPPLY5:
> +               scan_index += AMS_SEQ_SUPPLY5;
> +               break;
> +       case AMS_ALARM_BIT_SUPPLY6:
> +               scan_index += AMS_SEQ_SUPPLY6;
> +               break;
> +       case AMS_ALARM_BIT_SUPPLY7:
> +               scan_index += AMS_SEQ_SUPPLY7;
> +               break;
> +       case AMS_ALARM_BIT_SUPPLY8:
> +               scan_index += AMS_SEQ_SUPPLY8;
> +               break;
> +       case AMS_ALARM_BIT_SUPPLY9:
> +               scan_index += AMS_SEQ_SUPPLY9;
> +               break;
> +       case AMS_ALARM_BIT_SUPPLY10:
> +               scan_index += AMS_SEQ_SUPPLY10;
> +               break;
> +       case AMS_ALARM_BIT_VCCAMS:
> +               scan_index += AMS_SEQ_VCCAMS;
> +               break;
> +       case AMS_ALARM_BIT_TEMP_REMOTE:
> +               scan_index += AMS_SEQ_TEMP_REMOTE;
> +               break;
> +       }
> +
> +       for (i = 0; i < indio_dev->num_channels; i++)
> +               if (indio_dev->channels[i].scan_index == scan_index)
> +                       break;
> +
> +       return &indio_dev->channels[i];
> +}
> +
> +static int ams_get_alarm_mask(int scan_index)
> +{
> +       int bit = 0;
> +
> +       if (scan_index >= AMS_PS_SEQ_MAX) {
> +               bit = AMS_PL_ALARM_START;
> +               scan_index -= AMS_PS_SEQ_MAX;
> +       }
> +
> +       switch (scan_index) {
> +       case AMS_SEQ_TEMP:
> +               return BIT(AMS_ALARM_BIT_TEMP + bit);

an alternative here would be to use a "map" here;
something like:

struct ams_seq_bit_map {
      int seq;
      int bit;
 };

then define a table:
static struct ams_seq_bit_map ams_seq_bit_map[] = {
 {  AMS_SEQ_TEMP,  AMS_ALARM_BIT_TEMP }
};

then a use a search function:

for (i = 0; i < ARRAY_SIZE(ams_seq_bit_map); i++) {
       if (ams_seq_bit_map[i].seq == scan_index)
          return ams_seq_bit_map[i].bit;
}

and vice-versa;

this makes things easier to extend; if a mapping is to be added, then
the table gets a new entry and done;

> +       case AMS_SEQ_SUPPLY1:
> +               return BIT(AMS_ALARM_BIT_SUPPLY1 + bit);
> +       case AMS_SEQ_SUPPLY2:
> +               return BIT(AMS_ALARM_BIT_SUPPLY2 + bit);
> +       case AMS_SEQ_SUPPLY3:
> +               return BIT(AMS_ALARM_BIT_SUPPLY3 + bit);
> +       case AMS_SEQ_SUPPLY4:
> +               return BIT(AMS_ALARM_BIT_SUPPLY4 + bit);
> +       case AMS_SEQ_SUPPLY5:
> +               return BIT(AMS_ALARM_BIT_SUPPLY5 + bit);
> +       case AMS_SEQ_SUPPLY6:
> +               return BIT(AMS_ALARM_BIT_SUPPLY6 + bit);
> +       case AMS_SEQ_SUPPLY7:
> +               return BIT(AMS_ALARM_BIT_SUPPLY7 + bit);
> +       case AMS_SEQ_SUPPLY8:
> +               return BIT(AMS_ALARM_BIT_SUPPLY8 + bit);
> +       case AMS_SEQ_SUPPLY9:
> +               return BIT(AMS_ALARM_BIT_SUPPLY9 + bit);
> +       case AMS_SEQ_SUPPLY10:
> +               return BIT(AMS_ALARM_BIT_SUPPLY10 + bit);
> +       case AMS_SEQ_VCCAMS:
> +               return BIT(AMS_ALARM_BIT_VCCAMS + bit);
> +       case AMS_SEQ_TEMP_REMOTE:
> +               return BIT(AMS_ALARM_BIT_TEMP_REMOTE + bit);
> +       }
> +
> +       return 0;
> +}
> +
> +static int ams_read_event_config(struct iio_dev *indio_dev,
> +                                const struct iio_chan_spec *chan,
> +                                enum iio_event_type type,
> +                                enum iio_event_direction dir)
> +{
> +       struct ams *ams = iio_priv(indio_dev);
> +
> +       return (ams->alarm_mask & ams_get_alarm_mask(chan->scan_index)) ? 1 : 0;
> +}
> +
> +static int ams_write_event_config(struct iio_dev *indio_dev,
> +                                 const struct iio_chan_spec *chan,
> +                                 enum iio_event_type type,
> +                                 enum iio_event_direction dir,
> +                                 int state)
> +{
> +       struct ams *ams = iio_priv(indio_dev);
> +       unsigned int alarm;
> +
> +       alarm = ams_get_alarm_mask(chan->scan_index);
> +
> +       mutex_lock(&ams->lock);
> +
> +       if (state)
> +               ams->alarm_mask |= alarm;
> +       else
> +               ams->alarm_mask &= ~alarm;
> +
> +       ams_update_alarm(ams, ams->alarm_mask);
> +
> +       mutex_unlock(&ams->lock);
> +
> +       return 0;
> +}
> +
> +static int ams_read_event_value(struct iio_dev *indio_dev,
> +                               const struct iio_chan_spec *chan,
> +                               enum iio_event_type type,
> +                               enum iio_event_direction dir,
> +                               enum iio_event_info info, int *val, int *val2)
> +{
> +       struct ams *ams = iio_priv(indio_dev);
> +       unsigned int offset = ams_get_alarm_offset(chan->scan_index, dir);
> +
> +       mutex_lock(&ams->lock);
> +
> +       if (chan->scan_index >= AMS_PS_SEQ_MAX)
> +               *val = readl(ams->pl_base + offset);
> +       else
> +               *val = readl(ams->ps_base + offset);
> +
> +       mutex_unlock(&ams->lock);
> +
> +       return IIO_VAL_INT;
> +}
> +
> +static int ams_write_event_value(struct iio_dev *indio_dev,
> +                                const struct iio_chan_spec *chan,
> +                                enum iio_event_type type,
> +                                enum iio_event_direction dir,
> +                                enum iio_event_info info, int val, int val2)
> +{
> +       struct ams *ams = iio_priv(indio_dev);
> +       unsigned int offset;
> +
> +       mutex_lock(&ams->lock);
> +
> +       /* Set temperature channel threshold to direct threshold */
> +       if (chan->type == IIO_TEMP) {
> +               offset = ams_get_alarm_offset(chan->scan_index,
> +                                             IIO_EV_DIR_FALLING);
> +
> +               if (chan->scan_index >= AMS_PS_SEQ_MAX)
> +                       ams_pl_update_reg(ams, offset,
> +                                           AMS_ALARM_THR_DIRECT_MASK,
> +                                           AMS_ALARM_THR_DIRECT_MASK);
> +               else
> +                       ams_ps_update_reg(ams, offset,
> +                                         AMS_ALARM_THR_DIRECT_MASK,
> +                                         AMS_ALARM_THR_DIRECT_MASK);
> +       }
> +
> +       offset = ams_get_alarm_offset(chan->scan_index, dir);
> +       if (chan->scan_index >= AMS_PS_SEQ_MAX)
> +               writel(val, ams->pl_base + offset);
> +       else
> +               writel(val, ams->ps_base + offset);
> +
> +       mutex_unlock(&ams->lock);
> +
> +       return 0;
> +}
> +
> +static void ams_handle_event(struct iio_dev *indio_dev, u32 event)
> +{
> +       const struct iio_chan_spec *chan;
> +
> +       chan = ams_event_to_channel(indio_dev, event);
> +
> +       if (chan->type == IIO_TEMP) {
> +               /*
> +                * The temperature channel only supports over-temperature
> +                * events
> +                */
> +               iio_push_event(indio_dev,
> +                              IIO_UNMOD_EVENT_CODE(chan->type, chan->channel,
> +                                                   IIO_EV_TYPE_THRESH,
> +                                                   IIO_EV_DIR_RISING),
> +                       iio_get_time_ns(indio_dev));
> +       } else {
> +               /*
> +                * For other channels we don't know whether it is a upper or
> +                * lower threshold event. Userspace will have to check the
> +                * channel value if it wants to know.
> +                */
> +               iio_push_event(indio_dev,
> +                              IIO_UNMOD_EVENT_CODE(chan->type, chan->channel,
> +                                                   IIO_EV_TYPE_THRESH,
> +                                                   IIO_EV_DIR_EITHER),
> +                       iio_get_time_ns(indio_dev));
> +       }
> +}
> +
> +static void ams_handle_events(struct iio_dev *indio_dev, unsigned long events)
> +{
> +       unsigned int bit;
> +
> +       for_each_set_bit(bit, &events, AMS_NO_OF_ALARMS)
> +               ams_handle_event(indio_dev, bit);
> +}
> +
> +/**
> + * ams_unmask_worker - ams alarm interrupt unmask worker
> + * @work :             work to be done
> + *
> + * The ZynqMP threshold interrupts are level sensitive. Since we can't make the
> + * threshold condition go way from within the interrupt handler, this means as
> + * soon as a threshold condition is present we would enter the interrupt handler
> + * again and again. To work around this we mask all active threshold interrupts
> + * in the interrupt handler and start a timer. In this timer we poll the
> + * interrupt status and only if the interrupt is inactive we unmask it again.
> + */
> +static void ams_unmask_worker(struct work_struct *work)
> +{
> +       struct ams *ams = container_of(work, struct ams, ams_unmask_work.work);
> +       unsigned int status, unmask;
> +
> +       mutex_lock(&ams->lock);
> +
> +       status = readl(ams->base + AMS_ISR_0);
> +
> +       /* Clear those bits which are not active anymore */
> +       unmask = (ams->masked_alarm ^ status) & ams->masked_alarm;
> +
> +       /* clear status of disabled alarm */
> +       unmask |= ams->intr_mask;
> +
> +       ams->masked_alarm &= status;
> +
> +       /* Also clear those which are masked out anyway */
> +       ams->masked_alarm &= ~ams->intr_mask;
> +
> +       /* Clear the interrupts before we unmask them */
> +       writel(unmask, ams->base + AMS_ISR_0);
> +
> +       ams_update_intrmask(ams, 0, 0);
> +
> +       mutex_unlock(&ams->lock);
> +
> +       /* if still pending some alarm re-trigger the timer */
> +       if (ams->masked_alarm)
> +               schedule_delayed_work(&ams->ams_unmask_work,
> +                                     msecs_to_jiffies(AMS_UNMASK_TIMEOUT_MS));
> +}
> +
> +static irqreturn_t ams_irq(int irq, void *data)
> +{
> +       struct iio_dev *indio_dev = data;
> +       struct ams *ams = iio_priv(indio_dev);
> +       u32 isr0;
> +
> +       isr0 = readl(ams->base + AMS_ISR_0);
> +
> +       /* only process alarms that are not masked */
> +       isr0 &= ~((ams->intr_mask & AMS_ISR0_ALARM_MASK) | ams->masked_alarm);
> +
> +       if (!isr0)
> +               return IRQ_NONE;
> +
> +       /* clear interrupt */
> +       writel(isr0, ams->base + AMS_ISR_0);
> +
> +       /* Mask the alarm interrupts until cleared */
> +       ams->masked_alarm |= isr0;
> +       ams_update_intrmask(ams, 0, 0);
> +
> +       ams_handle_events(indio_dev, isr0);
> +
> +       schedule_delayed_work(&ams->ams_unmask_work,
> +                             msecs_to_jiffies(AMS_UNMASK_TIMEOUT_MS));
> +
> +       return IRQ_HANDLED;
> +}
> +
> +static const struct iio_event_spec ams_temp_events[] = {
> +       {
> +               .type = IIO_EV_TYPE_THRESH,
> +               .dir = IIO_EV_DIR_RISING,
> +               .mask_separate = BIT(IIO_EV_INFO_ENABLE) |
> +                               BIT(IIO_EV_INFO_VALUE),
> +       },
> +};
> +
> +static const struct iio_event_spec ams_voltage_events[] = {
> +       {
> +               .type = IIO_EV_TYPE_THRESH,
> +               .dir = IIO_EV_DIR_RISING,
> +               .mask_separate = BIT(IIO_EV_INFO_VALUE),
> +       },
> +       {
> +               .type = IIO_EV_TYPE_THRESH,
> +               .dir = IIO_EV_DIR_FALLING,
> +               .mask_separate = BIT(IIO_EV_INFO_VALUE),
> +       },
> +       {
> +               .type = IIO_EV_TYPE_THRESH,
> +               .dir = IIO_EV_DIR_EITHER,
> +               .mask_separate = BIT(IIO_EV_INFO_ENABLE),
> +       },
> +};
> +
> +static const struct iio_chan_spec ams_ps_channels[] = {
> +       AMS_PS_CHAN_TEMP(AMS_SEQ_TEMP, AMS_TEMP),
> +       AMS_PS_CHAN_TEMP(AMS_SEQ_TEMP_REMOTE, AMS_TEMP_REMOTE),
> +       AMS_PS_CHAN_VOLTAGE(AMS_SEQ_SUPPLY1, AMS_SUPPLY1),
> +       AMS_PS_CHAN_VOLTAGE(AMS_SEQ_SUPPLY2, AMS_SUPPLY2),
> +       AMS_PS_CHAN_VOLTAGE(AMS_SEQ_SUPPLY3, AMS_SUPPLY3),
> +       AMS_PS_CHAN_VOLTAGE(AMS_SEQ_SUPPLY4, AMS_SUPPLY4),
> +       AMS_PS_CHAN_VOLTAGE(AMS_SEQ_SUPPLY5, AMS_SUPPLY5),
> +       AMS_PS_CHAN_VOLTAGE(AMS_SEQ_SUPPLY6, AMS_SUPPLY6),
> +       AMS_PS_CHAN_VOLTAGE(AMS_SEQ_SUPPLY7, AMS_SUPPLY7),
> +       AMS_PS_CHAN_VOLTAGE(AMS_SEQ_SUPPLY8, AMS_SUPPLY8),
> +       AMS_PS_CHAN_VOLTAGE(AMS_SEQ_SUPPLY9, AMS_SUPPLY9),
> +       AMS_PS_CHAN_VOLTAGE(AMS_SEQ_SUPPLY10, AMS_SUPPLY10),
> +       AMS_PS_CHAN_VOLTAGE(AMS_SEQ_VCCAMS, AMS_VCCAMS),
> +};
> +
> +static const struct iio_chan_spec ams_pl_channels[] = {
> +       AMS_PL_CHAN_TEMP(AMS_SEQ_TEMP, AMS_TEMP),
> +       AMS_PL_CHAN_VOLTAGE(AMS_SEQ_SUPPLY1, AMS_SUPPLY1, true),
> +       AMS_PL_CHAN_VOLTAGE(AMS_SEQ_SUPPLY2, AMS_SUPPLY2, true),
> +       AMS_PL_CHAN_VOLTAGE(AMS_SEQ_VREFP, AMS_VREFP, false),
> +       AMS_PL_CHAN_VOLTAGE(AMS_SEQ_VREFN, AMS_VREFN, false),
> +       AMS_PL_CHAN_VOLTAGE(AMS_SEQ_SUPPLY3, AMS_SUPPLY3, true),
> +       AMS_PL_CHAN_VOLTAGE(AMS_SEQ_SUPPLY4, AMS_SUPPLY4, true),
> +       AMS_PL_CHAN_VOLTAGE(AMS_SEQ_SUPPLY5, AMS_SUPPLY5, true),
> +       AMS_PL_CHAN_VOLTAGE(AMS_SEQ_SUPPLY6, AMS_SUPPLY6, true),
> +       AMS_PL_CHAN_VOLTAGE(AMS_SEQ_VCCAMS, AMS_VCCAMS, true),
> +       AMS_PL_CHAN_VOLTAGE(AMS_SEQ_VP_VN, AMS_VP_VN, false),
> +       AMS_PL_CHAN_VOLTAGE(AMS_SEQ_SUPPLY7, AMS_SUPPLY7, true),
> +       AMS_PL_CHAN_VOLTAGE(AMS_SEQ_SUPPLY8, AMS_SUPPLY8, true),
> +       AMS_PL_CHAN_VOLTAGE(AMS_SEQ_SUPPLY9, AMS_SUPPLY9, true),
> +       AMS_PL_CHAN_VOLTAGE(AMS_SEQ_SUPPLY10, AMS_SUPPLY10, true),
> +       AMS_PL_AUX_CHAN_VOLTAGE(0),
> +       AMS_PL_AUX_CHAN_VOLTAGE(1),
> +       AMS_PL_AUX_CHAN_VOLTAGE(2),
> +       AMS_PL_AUX_CHAN_VOLTAGE(3),
> +       AMS_PL_AUX_CHAN_VOLTAGE(4),
> +       AMS_PL_AUX_CHAN_VOLTAGE(5),
> +       AMS_PL_AUX_CHAN_VOLTAGE(6),
> +       AMS_PL_AUX_CHAN_VOLTAGE(7),
> +       AMS_PL_AUX_CHAN_VOLTAGE(8),
> +       AMS_PL_AUX_CHAN_VOLTAGE(9),
> +       AMS_PL_AUX_CHAN_VOLTAGE(10),
> +       AMS_PL_AUX_CHAN_VOLTAGE(11),
> +       AMS_PL_AUX_CHAN_VOLTAGE(12),
> +       AMS_PL_AUX_CHAN_VOLTAGE(13),
> +       AMS_PL_AUX_CHAN_VOLTAGE(14),
> +       AMS_PL_AUX_CHAN_VOLTAGE(15),
> +};
> +
> +static const struct iio_chan_spec ams_ctrl_channels[] = {
> +       AMS_CTRL_CHAN_VOLTAGE(AMS_SEQ_VCC_PSPLL, AMS_VCC_PSPLL0),
> +       AMS_CTRL_CHAN_VOLTAGE(AMS_SEQ_VCC_PSBATT, AMS_VCC_PSPLL3),
> +       AMS_CTRL_CHAN_VOLTAGE(AMS_SEQ_VCCINT, AMS_VCCINT),
> +       AMS_CTRL_CHAN_VOLTAGE(AMS_SEQ_VCCBRAM, AMS_VCCBRAM),
> +       AMS_CTRL_CHAN_VOLTAGE(AMS_SEQ_VCCAUX, AMS_VCCAUX),
> +       AMS_CTRL_CHAN_VOLTAGE(AMS_SEQ_PSDDRPLL, AMS_PSDDRPLL),
> +       AMS_CTRL_CHAN_VOLTAGE(AMS_SEQ_INTDDR, AMS_PSINTFPDDR),
> +};
> +
> +static int ams_get_ext_chan(struct device_node *chan_node,
> +                           struct iio_chan_spec *channels, int num_channels)
> +{
> +       struct device_node *child;
> +       unsigned int reg;
> +       int ret;
> +
> +       for_each_child_of_node(chan_node, child) {
> +               ret = of_property_read_u32(child, "reg", &reg);
> +               if (ret || reg > (AMS_PL_MAX_EXT_CHANNEL + 30))
> +                       continue;
> +
> +               memcpy(&channels[num_channels], &ams_pl_channels[reg +
> +                      AMS_PL_MAX_FIXED_CHANNEL - 30], sizeof(*channels));
> +
> +               if (of_property_read_bool(child,
> +                                         "xlnx,bipolar"))
> +                       channels[num_channels].scan_type.sign = 's';
> +
> +               num_channels++;
> +       }
> +
> +       return num_channels;
> +}
> +
> +static int ams_init_module(struct iio_dev *indio_dev, struct device_node *np,
> +                          struct iio_chan_spec *channels)
> +{
> +       struct ams *ams = iio_priv(indio_dev);
> +       struct device_node *chan_node;
> +       int num_channels = 0;
> +
> +       if (of_device_is_compatible(np, "xlnx,zynqmp-ams-ps")) {
> +               ams->ps_base = of_iomap(np, 0);
> +               if (!ams->ps_base)
> +                       return -ENXIO;
> +
> +               /* add PS channels to iio device channels */
> +               memcpy(channels + num_channels, ams_ps_channels,
> +                      sizeof(ams_ps_channels));
> +               num_channels += ARRAY_SIZE(ams_ps_channels);
> +       } else if (of_device_is_compatible(np, "xlnx,zynqmp-ams-pl")) {
> +               ams->pl_base = of_iomap(np, 0);
> +               if (!ams->pl_base)
> +                       return -ENXIO;
> +
> +               /* Copy only first 10 fix channels */
> +               memcpy(channels + num_channels, ams_pl_channels,
> +                      AMS_PL_MAX_FIXED_CHANNEL * sizeof(*channels));
> +               num_channels += AMS_PL_MAX_FIXED_CHANNEL;
> +
> +               chan_node = of_get_child_by_name(np, "xlnx,ext-channels");
> +               if (chan_node)
> +                       num_channels = ams_get_ext_chan(chan_node, channels,
> +                                                       num_channels);
> +
> +               of_node_put(chan_node);
> +       } else if (of_device_is_compatible(np, "xlnx,zynqmp-ams")) {
> +               /* add AMS channels to iio device channels */
> +               memcpy(channels + num_channels, ams_ctrl_channels,
> +                               sizeof(ams_ctrl_channels));
> +               num_channels += ARRAY_SIZE(ams_ctrl_channels);
> +       } else {
> +               return -EINVAL;
> +       }
> +
> +       return num_channels;
> +}
> +
> +static int ams_parse_dt(struct iio_dev *indio_dev, struct platform_device *pdev)
> +{
> +       struct ams *ams = iio_priv(indio_dev);
> +       struct iio_chan_spec *ams_channels, *dev_channels;
> +       struct device_node *child_node = NULL, *np = pdev->dev.of_node;
> +       int ret, vol_ch_cnt = 0, temp_ch_cnt = 0, i, rising_off, falling_off;
> +       unsigned int num_channels = 0;
> +
> +       /* Initialize buffer for channel specification */
> +       ams_channels = kzalloc(sizeof(ams_ps_channels) +
> +                              sizeof(ams_pl_channels) +
> +                              sizeof(ams_ctrl_channels), GFP_KERNEL);
> +       if (!ams_channels)
> +               return -ENOMEM;

maybe an idea here, would be to just do `devm_kzalloc()` here and use
a single "dev_channels" variable;
in the end this "indio_dev->num_channels = num_channels" assignment
would limit the number of IIO channels to what would actually be used;

i'll admit, this would allocate a bit more memory than needed;
technically the wasted space wouldn't be too much; and would be within
acceptable limits;

but if the intent is to allocate exactly the amount needed, then the
"sprintf()" technique can be used here;
i.e.:

ret = sprintf(NULL, "format_string")
if (ret < 0)
   return ret;

s = malloc(ret)

ret = sprintf(s, "format_string")

so, essentially, a function would be implemented that can take a NULL
channel pointer, which would return the number of channels that would
be configured if the pointer would be non-NULL;



> +
> +       if (of_device_is_available(np)) {
> +               ret = ams_init_module(indio_dev, np, ams_channels);
> +               if (ret < 0)
> +                       goto err;
> +
> +               num_channels += ret;
> +       }
> +
> +       for_each_child_of_node(np, child_node) {
> +               if (of_device_is_available(child_node)) {
> +                       ret = ams_init_module(indio_dev, child_node,
> +                                             ams_channels + num_channels);
> +                       if (ret < 0)
> +                               goto err;
> +
> +                       num_channels += ret;
> +               }
> +       }
> +
> +       for (i = 0; i < num_channels; i++) {
> +               if (ams_channels[i].type == IIO_VOLTAGE)
> +                       ams_channels[i].channel = vol_ch_cnt++;
> +               else
> +                       ams_channels[i].channel = temp_ch_cnt++;
> +
> +               if (ams_channels[i].scan_index < (AMS_PS_SEQ_MAX * 3)) {
> +                       /* set threshold to max and min for each channel */
> +                       falling_off = ams_get_alarm_offset(
> +                                       ams_channels[i].scan_index,
> +                                       IIO_EV_DIR_FALLING);
> +                       rising_off = ams_get_alarm_offset(
> +                                       ams_channels[i].scan_index,
> +                                       IIO_EV_DIR_RISING);
> +                       if (ams_channels[i].scan_index >= AMS_PS_SEQ_MAX) {
> +                               writel(AMS_ALARM_THR_MIN,
> +                                               ams->pl_base + falling_off);
> +                               writel(AMS_ALARM_THR_MAX,
> +                                               ams->pl_base + rising_off);
> +                       } else {
> +                               writel(AMS_ALARM_THR_MIN,
> +                                               ams->ps_base + falling_off);
> +                               writel(AMS_ALARM_THR_MAX,
> +                                               ams->ps_base + rising_off);
> +                       }
> +               }
> +       }
> +
> +       dev_channels = devm_kzalloc(&pdev->dev, sizeof(*dev_channels) *
> +                                   num_channels, GFP_KERNEL);
> +       if (!dev_channels) {
> +               ret = -ENOMEM;
> +               goto err;
> +       }
> +
> +       memcpy(dev_channels, ams_channels,
> +              sizeof(*ams_channels) * num_channels);
> +       indio_dev->channels = dev_channels;
> +       indio_dev->num_channels = num_channels;
> +
> +       ret = 0;
> +err:
> +       kfree(ams_channels);
> +
> +       return ret;
> +}
> +
> +static const struct iio_info iio_ams_info = {
> +       .read_raw = &ams_read_raw,
> +       .read_event_config = &ams_read_event_config,
> +       .write_event_config = &ams_write_event_config,
> +       .read_event_value = &ams_read_event_value,
> +       .write_event_value = &ams_write_event_value,
> +};
> +
> +static const struct of_device_id ams_of_match_table[] = {
> +       { .compatible = "xlnx,zynqmp-ams" },
> +       { }
> +};
> +MODULE_DEVICE_TABLE(of, ams_of_match_table);
> +
> +static int ams_probe(struct platform_device *pdev)
> +{
> +       struct iio_dev *indio_dev;
> +       struct ams *ams;
> +       struct resource *res;
> +       int ret;
> +
> +       if (!pdev->dev.of_node)
> +               return -ENODEV;
> +
> +       indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*ams));
> +       if (!indio_dev)
> +               return -ENOMEM;
> +
> +       ams = iio_priv(indio_dev);
> +       mutex_init(&ams->lock);
> +
> +       indio_dev->dev.parent = &pdev->dev;
> +       indio_dev->dev.of_node = pdev->dev.of_node;

these 2 assignments can be removed;
they are assigned in iio_device_alloc() and  iio_device_register()

> +       indio_dev->name = "xilinx-ams";
> +
> +       indio_dev->info = &iio_ams_info;
> +       indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +       res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ams-base");
> +       ams->base = devm_ioremap_resource(&pdev->dev, res);
> +       if (IS_ERR(ams->base))
> +               return PTR_ERR(ams->base);
> +
> +       ams->clk = devm_clk_get(&pdev->dev, NULL);
> +       if (IS_ERR(ams->clk))
> +               return PTR_ERR(ams->clk);
> +       clk_prepare_enable(ams->clk);

[1]
a better idea is to use a devm_add_action_or_reset() hook to call
clk_disable_unprepare() here

> +
> +       INIT_DELAYED_WORK(&ams->ams_unmask_work, ams_unmask_worker);

[2]
a devm_add_action_or_reset() can be registered/setup here to call
cancel_delayed_work()

> +
> +       ret = ams_init_device(ams);
> +       if (ret) {
> +               dev_err(&pdev->dev, "failed to initialize AMS\n");
> +               goto err_probe;
> +       }
> +
> +       ret = ams_parse_dt(indio_dev, pdev);
> +       if (ret) {
> +               dev_err(&pdev->dev, "failure in parsing DT\n");
> +               goto err_probe;
> +       }
> +
> +       ams_enable_channel_sequence(indio_dev);
> +
> +       ams->irq = platform_get_irq_byname(pdev, "ams-irq");
> +       ret = request_irq(ams->irq, &ams_irq, 0, "ams-irq", indio_dev);

[3]
devm_request_irq() can be used here

> +       if (ret < 0) {
> +               dev_err(&pdev->dev, "failed to register interrupt\n");
> +               goto err_probe;
> +       }
> +
> +       platform_set_drvdata(pdev, indio_dev);
> +
> +       ret = iio_device_register(indio_dev);
> +       if (ret)
> +               goto err_irq_free;

[4]
if [1],[2] and [3] is being implemented, all "goto err" paths can be
direct returns
and this can be   "return devm_iio_device_register(&pdev->dev, indio_dev);"

> +
> +       return 0;
> +
> +err_irq_free:
> +       free_irq(ams->irq, indio_dev);
> +
> +err_probe:
> +       cancel_delayed_work(&ams->ams_unmask_work);
> +       clk_disable_unprepare(ams->clk);
> +
> +       return ret;
> +}
> +
> +static int ams_remove(struct platform_device *pdev)

following [4], if that is implemented, the ams_remove() hook can be
removed altogether;

> +{
> +       struct iio_dev *indio_dev = platform_get_drvdata(pdev);
> +       struct ams *ams = iio_priv(indio_dev);
> +
> +       iio_device_unregister(indio_dev);
> +       free_irq(ams->irq, indio_dev);
> +       cancel_delayed_work(&ams->ams_unmask_work);
> +       clk_disable_unprepare(ams->clk);
> +
> +       return 0;
> +}
> +
> +static int __maybe_unused ams_suspend(struct device *dev)
> +{
> +       struct ams *ams = iio_priv(dev_get_drvdata(dev));
> +
> +       clk_disable_unprepare(ams->clk);
> +
> +       return 0;
> +}
> +
> +static int __maybe_unused ams_resume(struct device *dev)
> +{
> +       struct ams *ams = iio_priv(dev_get_drvdata(dev));
> +
> +       clk_prepare_enable(ams->clk);
> +
> +       return 0;
> +}
> +
> +static SIMPLE_DEV_PM_OPS(ams_pm_ops, ams_suspend, ams_resume);
> +
> +static struct platform_driver ams_driver = {
> +       .probe = ams_probe,
> +       .remove = ams_remove,
> +       .driver = {
> +               .name = "xilinx-ams",
> +               .pm = &ams_pm_ops,
> +               .of_match_table = ams_of_match_table,
> +       },
> +};
> +module_platform_driver(ams_driver);
> +
> +MODULE_LICENSE("GPL v2");
> +MODULE_AUTHOR("Xilinx, Inc.");
> --
> 2.17.1
>
