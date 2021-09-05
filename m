Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83CC6400EF2
	for <lists+linux-iio@lfdr.de>; Sun,  5 Sep 2021 12:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237442AbhIEKGS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Sep 2021 06:06:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:49098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233169AbhIEKGS (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 5 Sep 2021 06:06:18 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5343A60FBF;
        Sun,  5 Sep 2021 10:05:11 +0000 (UTC)
Date:   Sun, 5 Sep 2021 11:08:34 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     <Eugen.Hristev@microchip.com>
Cc:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <Nicolas.Ferre@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <Ludovic.Desroches@microchip.com>
Subject: Re: [PATCH v2 04/10] iio: adc: at91-sama5d2_adc: convert to
 platform specific data structures
Message-ID: <20210905110834.3e631307@jic23-huawei>
In-Reply-To: <6178f8b2-60d0-7189-2e0a-ae1c12419330@microchip.com>
References: <20210824115441.681253-1-eugen.hristev@microchip.com>
        <20210824115441.681253-5-eugen.hristev@microchip.com>
        <1688eb0e-5ea1-3bcc-3af0-7ba4c4601306@microchip.com>
        <20210830154408.4ffdef1a@jic23-huawei>
        <6178f8b2-60d0-7189-2e0a-ae1c12419330@microchip.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 31 Aug 2021 11:50:00 +0000
<Eugen.Hristev@microchip.com> wrote:

> On 8/30/21 5:44 PM, Jonathan Cameron wrote:
> > On Mon, 30 Aug 2021 12:31:46 +0000
> > <Eugen.Hristev@microchip.com> wrote:
> >   
> >> On 8/24/21 2:54 PM, Eugen Hristev wrote:  
> >>> Convert the driver to platform specific structures. This means:
> >>> - create a register layout struct that will hold offsets for registers
> >>> - create a platform struct that will hold platform information (number of
> >>> channels, indexes for different channels and pointer to layout struct)
> >>> - convert specific macros that are platform dependent into platform variables
> >>>
> >>> This step is in fact a no-op, but allows the driver to be more flexible
> >>> and for future enhancement including adding new platforms that are partly
> >>> compatible with the current driver and differ slightly in register layout
> >>> or capabilities for example.
> >>>
> >>> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> >>> ---
> >>>    drivers/iio/adc/at91-sama5d2_adc.c | 410 +++++++++++++++++------------
> >>>    1 file changed, 247 insertions(+), 163 deletions(-)
> >>>
> >>> diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
> >>> index 9d71dcffcf93..8ede18b8d789 100644
> >>> --- a/drivers/iio/adc/at91-sama5d2_adc.c
> >>> +++ b/drivers/iio/adc/at91-sama5d2_adc.c
> >>> @@ -27,8 +27,9 @@
> >>>    #include <linux/pinctrl/consumer.h>
> >>>    #include <linux/regulator/consumer.h>
> >>>
> >>> +struct at91_adc_reg_layout {
> >>>    /* Control Register */
> >>> -#define AT91_SAMA5D2_CR            0x00
> >>> +   u16                             CR;
> >>>    /* Software Reset */
> >>>    #define   AT91_SAMA5D2_CR_SWRST           BIT(0)
> >>>    /* Start Conversion */
> >>> @@ -39,7 +40,7 @@
> >>>    #define   AT91_SAMA5D2_CR_CMPRST          BIT(4)
> >>>
> >>>    /* Mode Register */
> >>> -#define AT91_SAMA5D2_MR            0x04
> >>> +   u16                             MR;
> >>>    /* Trigger Selection */
> >>>    #define   AT91_SAMA5D2_MR_TRGSEL(v)       ((v) << 1)
> >>>    /* ADTRG */
> >>> @@ -82,19 +83,19 @@
> >>>    #define   AT91_SAMA5D2_MR_USEQ            BIT(31)
> >>>
> >>>    /* Channel Sequence Register 1 */
> >>> -#define AT91_SAMA5D2_SEQR1 0x08
> >>> +   u16                             SEQR1;
> >>>    /* Channel Sequence Register 2 */
> >>> -#define AT91_SAMA5D2_SEQR2 0x0c
> >>> +   u16                             SEQR2;
> >>>    /* Channel Enable Register */
> >>> -#define AT91_SAMA5D2_CHER  0x10
> >>> +   u16                             CHER;
> >>>    /* Channel Disable Register */
> >>> -#define AT91_SAMA5D2_CHDR  0x14
> >>> +   u16                             CHDR;
> >>>    /* Channel Status Register */
> >>> -#define AT91_SAMA5D2_CHSR  0x18
> >>> +   u16                             CHSR;
> >>>    /* Last Converted Data Register */
> >>> -#define AT91_SAMA5D2_LCDR  0x20
> >>> +   u16                             LCDR;
> >>>    /* Interrupt Enable Register */
> >>> -#define AT91_SAMA5D2_IER   0x24
> >>> +   u16                             IER;
> >>>    /* Interrupt Enable Register - TS X measurement ready */
> >>>    #define AT91_SAMA5D2_IER_XRDY   BIT(20)
> >>>    /* Interrupt Enable Register - TS Y measurement ready */
> >>> @@ -109,22 +110,23 @@
> >>>    #define AT91_SAMA5D2_IER_PEN    BIT(29)
> >>>    /* Interrupt Enable Register - No pen detect */
> >>>    #define AT91_SAMA5D2_IER_NOPEN  BIT(30)
> >>> +
> >>>    /* Interrupt Disable Register */
> >>> -#define AT91_SAMA5D2_IDR   0x28
> >>> +   u16                             IDR;
> >>>    /* Interrupt Mask Register */
> >>> -#define AT91_SAMA5D2_IMR   0x2c
> >>> +   u16                             IMR;
> >>>    /* Interrupt Status Register */
> >>> -#define AT91_SAMA5D2_ISR   0x30
> >>> +   u16                             ISR;
> >>>    /* Interrupt Status Register - Pen touching sense status */
> >>>    #define AT91_SAMA5D2_ISR_PENS   BIT(31)
> >>>    /* Last Channel Trigger Mode Register */
> >>> -#define AT91_SAMA5D2_LCTMR 0x34
> >>> +   u16                             LCTMR;
> >>>    /* Last Channel Compare Window Register */
> >>> -#define AT91_SAMA5D2_LCCWR 0x38
> >>> +   u16                             LCCWR;
> >>>    /* Overrun Status Register */
> >>> -#define AT91_SAMA5D2_OVER  0x3c
> >>> +   u16                             OVER;
> >>>    /* Extended Mode Register */
> >>> -#define AT91_SAMA5D2_EMR   0x40
> >>> +   u16                             EMR;
> >>>    /* Extended Mode Register - Oversampling rate */
> >>>    #define AT91_SAMA5D2_EMR_OSR(V)                   ((V) << 16)
> >>>    #define AT91_SAMA5D2_EMR_OSR_MASK         GENMASK(17, 16)
> >>> @@ -134,22 +136,22 @@
> >>>
> >>>    /* Extended Mode Register - Averaging on single trigger event */
> >>>    #define AT91_SAMA5D2_EMR_ASTE(V)          ((V) << 20)
> >>> +
> >>>    /* Compare Window Register */
> >>> -#define AT91_SAMA5D2_CWR   0x44
> >>> +   u16                             CWR;
> >>>    /* Channel Gain Register */
> >>> -#define AT91_SAMA5D2_CGR   0x48
> >>> -
> >>> +   u16                             CGR;
> >>>    /* Channel Offset Register */
> >>> -#define AT91_SAMA5D2_COR   0x4c
> >>> +   u16                             COR;
> >>>    #define AT91_SAMA5D2_COR_DIFF_OFFSET      16
> >>>
> >>>    /* Analog Control Register */
> >>> -#define AT91_SAMA5D2_ACR   0x94
> >>> +   u16                             ACR;
> >>>    /* Analog Control Register - Pen detect sensitivity mask */
> >>>    #define AT91_SAMA5D2_ACR_PENDETSENS_MASK        GENMASK(1, 0)
> >>>
> >>>    /* Touchscreen Mode Register */
> >>> -#define AT91_SAMA5D2_TSMR  0xb0
> >>> +   u16                             TSMR;
> >>>    /* Touchscreen Mode Register - No touch mode */
> >>>    #define AT91_SAMA5D2_TSMR_TSMODE_NONE           0
> >>>    /* Touchscreen Mode Register - 4 wire screen, no pressure measurement */
> >>> @@ -178,13 +180,13 @@
> >>>    #define AT91_SAMA5D2_TSMR_PENDET_ENA            BIT(24)
> >>>
> >>>    /* Touchscreen X Position Register */
> >>> -#define AT91_SAMA5D2_XPOSR 0xb4
> >>> +   u16                             XPOSR;
> >>>    /* Touchscreen Y Position Register */
> >>> -#define AT91_SAMA5D2_YPOSR 0xb8
> >>> +   u16                             YPOSR;
> >>>    /* Touchscreen Pressure Register */
> >>> -#define AT91_SAMA5D2_PRESSR        0xbc
> >>> +   u16                             PRESSR;
> >>>    /* Trigger Register */
> >>> -#define AT91_SAMA5D2_TRGR  0xc0
> >>> +   u16                             TRGR;
> >>>    /* Mask for TRGMOD field of TRGR register */
> >>>    #define AT91_SAMA5D2_TRGR_TRGMOD_MASK GENMASK(2, 0)
> >>>    /* No trigger, only software trigger can start conversions */
> >>> @@ -203,30 +205,52 @@
> >>>    #define AT91_SAMA5D2_TRGR_TRGPER(x)             ((x) << 16)
> >>>
> >>>    /* Correction Select Register */
> >>> -#define AT91_SAMA5D2_COSR  0xd0
> >>> +   u16                             COSR;
> >>>    /* Correction Value Register */
> >>> -#define AT91_SAMA5D2_CVR   0xd4
> >>> +   u16                             CVR;
> >>>    /* Channel Error Correction Register */
> >>> -#define AT91_SAMA5D2_CECR  0xd8
> >>> +   u16                             CECR;
> >>>    /* Write Protection Mode Register */
> >>> -#define AT91_SAMA5D2_WPMR  0xe4
> >>> +   u16                             WPMR;
> >>>    /* Write Protection Status Register */
> >>> -#define AT91_SAMA5D2_WPSR  0xe8
> >>> +   u16                             WPSR;
> >>>    /* Version Register */
> >>> -#define AT91_SAMA5D2_VERSION       0xfc
> >>> -
> >>> -#define AT91_SAMA5D2_HW_TRIG_CNT 3
> >>> -#define AT91_SAMA5D2_SINGLE_CHAN_CNT 12
> >>> -#define AT91_SAMA5D2_DIFF_CHAN_CNT 6
> >>> -
> >>> -#define AT91_SAMA5D2_TIMESTAMP_CHAN_IDX (AT91_SAMA5D2_SINGLE_CHAN_CNT + \
> >>> -                                    AT91_SAMA5D2_DIFF_CHAN_CNT + 1)
> >>> +   u16                             VERSION;
> >>> +};
> >>>
> >>> -#define AT91_SAMA5D2_TOUCH_X_CHAN_IDX (AT91_SAMA5D2_SINGLE_CHAN_CNT + \
> >>> -                                    AT91_SAMA5D2_DIFF_CHAN_CNT * 2)  
> >>
> >> Hi Jonathan,
> >>
> >> While we are here, regarding the above line, I cannot tell why did I
> >> multiply by two the differential channel count. This makes some gaps in
> >> the number of channels when we put them all in the same table.
> >>
> >> I did not change this as it would break the ABI regarding the bindings
> >> for the touchscreen #adc-cells phandle references.  
> > 
> > Really?  Xlate is based off scan_index, not these values I think...  
> 
> I figured it out.
> 
> We have 12 single channels [0..11] then 6 differential [12, 14, 16, 18, 
> 20, 22] spaced by two, a timestamp [23], then we have the X channel 
> index at 24, Y at 25 and pressure are 26.
> 
> These are reflected in this file :
> 
> https://elixir.bootlin.com/linux/latest/source/include/dt-bindings/iio/adc/at91-sama5d2_adc.h
> 
> And the resistive touchscreen connects to the adc with these indexes.
> 
> And I realised why we have the padding/spaces.
> It was the original design of the driver, in the line which I 
> highlighted now below in the patch : (and I never changed this since 
> working on this driver, because it was a break of the ABI in channel 
> numbers ...)
> 
> 
> >   
> >>
> >> However, I am thinking if there was a reason for it or it was a slip
> >> when I initially wrote this.  
> > 
> > I've no idea :)  I can't immediately see why we'd need the padding.
> >   
> >>
> >> Do you think there is any reason to change it and tighten the holes in
> >> the indexes list ?  
> > 
> > I don't think it matters. As far as I can tell they are used mostly (possibly
> > entirely) for internal management and not exposed to any of the ABIs etc.
> > 
> > Jonathan
> >   
> >>
> >>
> >> Eugen
> >>  
> >>> -#define AT91_SAMA5D2_TOUCH_Y_CHAN_IDX   (AT91_SAMA5D2_TOUCH_X_CHAN_IDX + 1)
> >>> -#define AT91_SAMA5D2_TOUCH_P_CHAN_IDX   (AT91_SAMA5D2_TOUCH_Y_CHAN_IDX + 1)
> >>> -#define AT91_SAMA5D2_MAX_CHAN_IDX  AT91_SAMA5D2_TOUCH_P_CHAN_IDX
> >>> +static const struct at91_adc_reg_layout sama5d2_layout = {
> >>> +   .CR =                   0x00,
> >>> +   .MR =                   0x04,
> >>> +   .SEQR1 =                0x08,
> >>> +   .SEQR2 =                0x0c,
> >>> +   .CHER =                 0x10,
> >>> +   .CHDR =                 0x14,
> >>> +   .CHSR =                 0x18,
> >>> +   .LCDR =                 0x20,
> >>> +   .IER =                  0x24,
> >>> +   .IDR =                  0x28,
> >>> +   .IMR =                  0x2c,
> >>> +   .ISR =                  0x30,
> >>> +   .LCTMR =                0x34,
> >>> +   .LCCWR =                0x38,
> >>> +   .OVER =                 0x3c,
> >>> +   .EMR =                  0x40,
> >>> +   .CWR =                  0x44,
> >>> +   .CGR =                  0x48,
> >>> +   .COR =                  0x4c,
> >>> +   .ACR =                  0x94,
> >>> +   .TSMR =                 0xb0,
> >>> +   .XPOSR =                0xb4,
> >>> +   .YPOSR =                0xb8,
> >>> +   .PRESSR =               0xbc,
> >>> +   .TRGR =                 0xc0,
> >>> +   .COSR =                 0xd0,
> >>> +   .CVR =                  0xd4,
> >>> +   .CECR =                 0xd8,
> >>> +   .WPMR =                 0xe4,
> >>> +   .WPSR =                 0xe8,
> >>> +   .VERSION =              0xfc,
> >>> +};
> >>>
> >>>    #define AT91_SAMA5D2_TOUCH_SAMPLE_PERIOD_US          2000    /* 2ms */
> >>>    #define AT91_SAMA5D2_TOUCH_PEN_DETECT_DEBOUNCE_US    200
> >>> @@ -235,18 +259,6 @@
> >>>
> >>>    #define AT91_SAMA5D2_MAX_POS_BITS                 12
> >>>
> >>> -/*
> >>> - * Maximum number of bytes to hold conversion from all channels
> >>> - * without the timestamp.
> >>> - */
> >>> -#define AT91_BUFFER_MAX_CONVERSION_BYTES ((AT91_SAMA5D2_SINGLE_CHAN_CNT + \
> >>> -                                    AT91_SAMA5D2_DIFF_CHAN_CNT) * 2)
> >>> -
> >>> -/* This total must also include the timestamp */
> >>> -#define AT91_BUFFER_MAX_BYTES (AT91_BUFFER_MAX_CONVERSION_BYTES + 8)
> >>> -
> >>> -#define AT91_BUFFER_MAX_HWORDS (AT91_BUFFER_MAX_BYTES / 2)
> >>> -
> >>>    #define AT91_HWFIFO_MAX_SIZE_STR  "128"
> >>>    #define AT91_HWFIFO_MAX_SIZE              128
> >>>
> >>> @@ -255,12 +267,12 @@
> >>>    #define AT91_OSR_4SAMPLES         4
> >>>    #define AT91_OSR_16SAMPLES                16
> >>>
> >>> -#define AT91_SAMA5D2_CHAN_SINGLE(num, addr)                                \
> >>> +#define AT91_SAMA5D2_CHAN_SINGLE(index, num, addr)                 \
> >>>      {                                                               \
> >>>              .type = IIO_VOLTAGE,                                    \
> >>>              .channel = num,                                         \
> >>>              .address = addr,                                        \
> >>> -           .scan_index = num,                                      \
> >>> +           .scan_index = index,                                    \
> >>>              .scan_type = {                                          \
> >>>                      .sign = 'u',                                    \
> >>>                      .realbits = 14,                                 \
> >>> @@ -274,14 +286,14 @@
> >>>              .indexed = 1,                                           \
> >>>      }
> >>>
> >>> -#define AT91_SAMA5D2_CHAN_DIFF(num, num2, addr)                            \
> >>> +#define AT91_SAMA5D2_CHAN_DIFF(index, num, num2, addr)                     \
> >>>      {                                                               \
> >>>              .type = IIO_VOLTAGE,                                    \
> >>>              .differential = 1,                                      \
> >>>              .channel = num,                                         \
> >>>              .channel2 = num2,                                       \
> >>>              .address = addr,                                        \
> >>> -           .scan_index = num + AT91_SAMA5D2_SINGLE_CHAN_CNT,       \  
> 
> Here it is: we always added num to the single channel count, but num 
> goes incrementally in steps of two : 0, 2, 4, 6, 8, 10

Ah. That makes sense.  Of course with a separate index value passed in we could
have broken that connection but meh it doesn't matter.  The ABI has always
allowed holes in scan_index so everything should just work even it if seems
a bit inelegant!

> 
> >>> +           .scan_index = index,                                    \
> >>>              .scan_type = {                                          \
> >>>                      .sign = 's',                                    \
> >>>                      .realbits = 14,                                 \
> >>> @@ -328,13 +340,48 @@
> >>>              .datasheet_name = name,                                 \
> >>>      }
> >>>
> >>> -#define at91_adc_readl(st, reg)            readl_relaxed(st->base + reg)
> >>> -#define at91_adc_writel(st, reg, val)      writel_relaxed(val, st->base + reg)
> >>> +#define at91_adc_readl(st, reg)                                            \
> >>> +   readl_relaxed((st)->base + (st)->soc_info.platform->layout->reg)
> >>> +#define at91_adc_read_chan(st, reg)                                        \
> >>> +   readl_relaxed((st)->base + reg)
> >>> +#define at91_adc_writel(st, reg, val)                                      \
> >>> +   writel_relaxed(val, (st)->base + (st)->soc_info.platform->layout->reg)
> >>> +
> >>> +/**
> >>> + * struct at91_adc_platform - at91-sama5d2 platform information struct
> >>> + * @layout:                pointer to the reg layout struct
> >>> + * @adc_channels:  pointer to an array of channels for registering in
> >>> + *                 the iio subsystem
> >>> + * @nr_channels:   number of physical channels available
> >>> + * @touch_chan_x:  index of the touchscreen X channel
> >>> + * @touch_chan_y:  index of the touchscreen Y channel
> >>> + * @touch_chan_p:  index of the touchscreen P channel
> >>> + * @max_channels:  number of total channels
> >>> + * @hw_trig_cnt:   number of possible hardware triggers
> >>> + */
> >>> +struct at91_adc_platform {
> >>> +   const struct at91_adc_reg_layout        *layout;
> >>> +   const struct iio_chan_spec              (*adc_channels)[];
> >>> +   unsigned int                            nr_channels;
> >>> +   unsigned int                            touch_chan_x;
> >>> +   unsigned int                            touch_chan_y;
> >>> +   unsigned int                            touch_chan_p;
> >>> +   unsigned int                            max_channels;
> >>> +   unsigned int                            hw_trig_cnt;
> >>> +};
> >>>
> >>> +/**
> >>> + * struct at91_adc_soc_info - at91-sama5d2 soc information struct
> >>> + * @startup_time:  device startup time
> >>> + * @min_sample_rate:       minimum sample rate in Hz
> >>> + * @max_sample_rate:       maximum sample rate in Hz
> >>> + * @platform:              pointer to the platform structure
> >>> + */
> >>>    struct at91_adc_soc_info {
> >>>      unsigned                        startup_time;
> >>>      unsigned                        min_sample_rate;
> >>>      unsigned                        max_sample_rate;
> >>> +   const struct at91_adc_platform  *platform;
> >>>    };
> >>>
> >>>    struct at91_adc_trigger {
> >>> @@ -382,6 +429,15 @@ struct at91_adc_touch {
> >>>      struct work_struct              workq;
> >>>    };
> >>>
> >>> +/*
> >>> + * Buffer size requirements:
> >>> + * No channels * bytes_per_channel(2) + timestamp bytes (8)
> >>> + * Divided by 2 because we need half words.
> >>> + * We assume 32 channels for now, has to be increased if needed.
> >>> + * Nobody minds a buffer being too big.
> >>> + */
> >>> +#define AT91_BUFFER_MAX_HWORDS ((32 * 2 + 8) / 2)
> >>> +
> >>>    struct at91_adc_state {
> >>>      void __iomem                    *base;
> >>>      int                             irq;
> >>> @@ -437,29 +493,49 @@ static const struct at91_adc_trigger at91_adc_trigger_list[] = {
> >>>      },
> >>>    };
> >>>
> >>> -static const struct iio_chan_spec at91_adc_channels[] = {
> >>> -   AT91_SAMA5D2_CHAN_SINGLE(0, 0x50),
> >>> -   AT91_SAMA5D2_CHAN_SINGLE(1, 0x54),
> >>> -   AT91_SAMA5D2_CHAN_SINGLE(2, 0x58),
> >>> -   AT91_SAMA5D2_CHAN_SINGLE(3, 0x5c),
> >>> -   AT91_SAMA5D2_CHAN_SINGLE(4, 0x60),
> >>> -   AT91_SAMA5D2_CHAN_SINGLE(5, 0x64),
> >>> -   AT91_SAMA5D2_CHAN_SINGLE(6, 0x68),
> >>> -   AT91_SAMA5D2_CHAN_SINGLE(7, 0x6c),
> >>> -   AT91_SAMA5D2_CHAN_SINGLE(8, 0x70),
> >>> -   AT91_SAMA5D2_CHAN_SINGLE(9, 0x74),
> >>> -   AT91_SAMA5D2_CHAN_SINGLE(10, 0x78),
> >>> -   AT91_SAMA5D2_CHAN_SINGLE(11, 0x7c),
> >>> -   AT91_SAMA5D2_CHAN_DIFF(0, 1, 0x50),
> >>> -   AT91_SAMA5D2_CHAN_DIFF(2, 3, 0x58),
> >>> -   AT91_SAMA5D2_CHAN_DIFF(4, 5, 0x60),
> >>> -   AT91_SAMA5D2_CHAN_DIFF(6, 7, 0x68),
> >>> -   AT91_SAMA5D2_CHAN_DIFF(8, 9, 0x70),
> >>> -   AT91_SAMA5D2_CHAN_DIFF(10, 11, 0x78),  
> 
> you can see it here,
> 
> >>> -   IIO_CHAN_SOFT_TIMESTAMP(AT91_SAMA5D2_TIMESTAMP_CHAN_IDX),
> >>> -   AT91_SAMA5D2_CHAN_TOUCH(AT91_SAMA5D2_TOUCH_X_CHAN_IDX, "x", IIO_MOD_X),
> >>> -   AT91_SAMA5D2_CHAN_TOUCH(AT91_SAMA5D2_TOUCH_Y_CHAN_IDX, "y", IIO_MOD_Y),
> >>> -   AT91_SAMA5D2_CHAN_PRESSURE(AT91_SAMA5D2_TOUCH_P_CHAN_IDX, "pressure"),
> >>> +static const struct iio_chan_spec at91_sama5d2_adc_channels[] = {
> >>> +   AT91_SAMA5D2_CHAN_SINGLE(0, 0, 0x50),
> >>> +   AT91_SAMA5D2_CHAN_SINGLE(1, 1, 0x54),
> >>> +   AT91_SAMA5D2_CHAN_SINGLE(2, 2, 0x58),
> >>> +   AT91_SAMA5D2_CHAN_SINGLE(3, 3, 0x5c),
> >>> +   AT91_SAMA5D2_CHAN_SINGLE(4, 4, 0x60),
> >>> +   AT91_SAMA5D2_CHAN_SINGLE(5, 5, 0x64),
> >>> +   AT91_SAMA5D2_CHAN_SINGLE(6, 6, 0x68),
> >>> +   AT91_SAMA5D2_CHAN_SINGLE(7, 7, 0x6c),
> >>> +   AT91_SAMA5D2_CHAN_SINGLE(8, 8, 0x70),
> >>> +   AT91_SAMA5D2_CHAN_SINGLE(9, 9, 0x74),
> >>> +   AT91_SAMA5D2_CHAN_SINGLE(10, 10, 0x78),
> >>> +   AT91_SAMA5D2_CHAN_SINGLE(11, 11, 0x7c),
> >>> +   AT91_SAMA5D2_CHAN_DIFF(12, 0, 1, 0x50),
> >>> +   AT91_SAMA5D2_CHAN_DIFF(13, 2, 3, 0x58),
> >>> +   AT91_SAMA5D2_CHAN_DIFF(14, 4, 5, 0x60),
> >>> +   AT91_SAMA5D2_CHAN_DIFF(15, 6, 7, 0x68),
> >>> +   AT91_SAMA5D2_CHAN_DIFF(16, 8, 9, 0x70),
> >>> +   AT91_SAMA5D2_CHAN_DIFF(17, 10, 11, 0x78),
> >>> +   IIO_CHAN_SOFT_TIMESTAMP(18),
> >>> +   AT91_SAMA5D2_CHAN_TOUCH(19, "x", IIO_MOD_X),
> >>> +   AT91_SAMA5D2_CHAN_TOUCH(20, "y", IIO_MOD_Y),
> >>> +   AT91_SAMA5D2_CHAN_PRESSURE(21, "pressure"),  
> 
> And I have to come up with a new version of the patch to fix this.
> 
> It should be like this:
> 
> 
>  >>> +   AT91_SAMA5D2_CHAN_SINGLE(11, 11, 0x7c),
>  >>> +   AT91_SAMA5D2_CHAN_DIFF(12, 0, 1, 0x50),
>  >>> +   AT91_SAMA5D2_CHAN_DIFF(14, 2, 3, 0x58),
>  >>> +   AT91_SAMA5D2_CHAN_DIFF(16, 4, 5, 0x60),
>  >>> +   AT91_SAMA5D2_CHAN_DIFF(18, 6, 7, 0x68),
>  >>> +   AT91_SAMA5D2_CHAN_DIFF(20, 8, 9, 0x70),
>  >>> +   AT91_SAMA5D2_CHAN_DIFF(22, 10, 11, 0x78),
>  >>> +   IIO_CHAN_SOFT_TIMESTAMP(23),
>  >>> +   AT91_SAMA5D2_CHAN_TOUCH(24, "x", IIO_MOD_X),
>  >>> +   AT91_SAMA5D2_CHAN_TOUCH(25, "y", IIO_MOD_Y),
>  >>> +   AT91_SAMA5D2_CHAN_PRESSURE(26, "pressure"),  
> 
> 
> Sorry about this. Do you want me to resend the whole series together 
> with the fixes found by robots ?
> 
> I can redo the series, retest it, and send it tomorrow as a v3.

Please do (looks like you already did ;) 
> 
> 
> Thanks,
> Eugen
> 
> >>> +};
> >>> +  
> [snip]

