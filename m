Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42FB53317D3
	for <lists+linux-iio@lfdr.de>; Mon,  8 Mar 2021 20:55:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbhCHTy0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Mar 2021 14:54:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:53398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231570AbhCHTyN (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 8 Mar 2021 14:54:13 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E03206525F;
        Mon,  8 Mar 2021 19:54:11 +0000 (UTC)
Date:   Mon, 8 Mar 2021 19:54:08 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     <Eugen.Hristev@microchip.com>
Cc:     <robh+dt@kernel.org>, <Ludovic.Desroches@microchip.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] iio: adc: at91-sama5d2: add support for sama7g5
 device
Message-ID: <20210308195408.48aea2a5@archlinux>
In-Reply-To: <fb4ea798-f239-699a-5f8a-33978fc270f6@microchip.com>
References: <20210301143256.16502-1-eugen.hristev@microchip.com>
        <20210301143256.16502-5-eugen.hristev@microchip.com>
        <20210306173017.0d3144c9@archlinux>
        <fb4ea798-f239-699a-5f8a-33978fc270f6@microchip.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 8 Mar 2021 13:27:48 +0000
<Eugen.Hristev@microchip.com> wrote:

> On 06.03.2021 19:30, Jonathan Cameron wrote:
> > On Mon, 1 Mar 2021 16:32:56 +0200
> > Eugen Hristev <eugen.hristev@microchip.com> wrote:
> >   
> >> Add support to sama7g5 ADC which is similar with sama5d2/sam9x60 device.
> >> Differences are highlighted by compatible.
> >> Main differences include 16 channels instead of 12 and missing
> >> resistive touchscreen.
> >>
> >> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>  
> > 
> > Hi Eugen,
> > 
> > What tends to end up cleaner than the many scattered places you have
> > had to bolt in part support here, is to use a per device type constant
> > structure.  That structure can contain register addresses where that
> > is all the differs between parts, and callbacks for more complex cases.
> > 
> > Along the lines of
> > 
> > static const struct sam5d2_chip_info sam5d2_inf {
> >          .eoc_register = 0x33,
> >          .max_chan_idx = bob,
> >          .ccr = bob_function,
> > ...
> > };
> > 
> > Then you can just put a pointer to this in the match_data and look that
> > up in probe  
> 
> Hi Jonathan,
> 
> 
> Could you have a look a little at this driver though:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/watchdog/sama5d4_wdt.c
> 
> The specific support for 'sam9x60' was added by me, and the driver does 
> not look so bad after all, having if/else clauses nearly everywhere, and 
> getting that 'sam9x60_supported' bit from the compatible string comparison.
> 
> That's the reason why I tried to have this ADC driver in a similar fashion.
> 
> I like your approach as well, I guess it's just a matter of preference. 
> I will start to change things to implement it as you suggested if you 
> don't say otherwise.

It works, but starts to go wrong once we get to a 3rd type and experience
says there will probably be a 3rd type sooner or later.

Once you hit that then the if / else everywhere begins to get really ugly.
I think I'd prefer to take the long term view and wrap it all up in a structure.

thanks,

Jonathan

> 
> Thanks for reviewing,
> Eugen
> 
> >   
> >> ---
> >>   drivers/iio/adc/at91-sama5d2_adc.c | 287 +++++++++++++++++++++++------
> >>   1 file changed, 234 insertions(+), 53 deletions(-)
> >>
> >> diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
> >> index 066d0ad644ca..d61fa32ef294 100644
> >> --- a/drivers/iio/adc/at91-sama5d2_adc.c
> >> +++ b/drivers/iio/adc/at91-sama5d2_adc.c
> >> @@ -1,9 +1,11 @@
> >>   // SPDX-License-Identifier: GPL-2.0-only
> >>   /*
> >> - * Atmel ADC driver for SAMA5D2 devices and compatible.
> >> + * Microchip ADC driver for SAMA5D2/SAMA7G5 devices and compatible.
> >>    *
> >>    * Copyright (C) 2015 Atmel,
> >> - *               2015 Ludovic Desroches <ludovic.desroches@atmel.com>
> >> + *               2015 Ludovic Desroches <ludovic.desroches@microchip.com>,
> >> + *            2021 Microchip Technology, Inc.,
> >> + *            2021 Eugen Hristev <eugen.hristev@microchip.com>
> >>    */
> >>
> >>   #include <linux/bitops.h>
> >> @@ -117,14 +119,26 @@
> >>   #define AT91_SAMA5D2_ISR     0x30
> >>   /* Interrupt Status Register - Pen touching sense status */
> >>   #define AT91_SAMA5D2_ISR_PENS   BIT(31)
> >> +
> >> +/* End of Conversion Interrupt Enable Register */
> >> +#define AT91_SAMA7G5_EOC_IER 0x34
> >> +/* End of Conversion Interrupt Disable Register */
> >> +#define AT91_SAMA7G5_EOC_IDR 0x38
> >> +/* End of Conversion Interrupt Mask Register */
> >> +#define AT91_SAMA7G5_EOC_IMR 0x3c
> >> +/* End of Conversion Interrupt Status Register */
> >> +#define AT91_SAMA7G5_EOC_ISR 0x40
> >> +
> >>   /* Last Channel Trigger Mode Register */
> >>   #define AT91_SAMA5D2_LCTMR   0x34
> >>   /* Last Channel Compare Window Register */
> >>   #define AT91_SAMA5D2_LCCWR   0x38
> >>   /* Overrun Status Register */
> >>   #define AT91_SAMA5D2_OVER    0x3c
> >> +#define AT91_SAMA7G5_OVER    0x4c
> >>   /* Extended Mode Register */
> >>   #define AT91_SAMA5D2_EMR     0x40
> >> +#define AT91_SAMA7G5_EMR     0x50
> >>   /* Extended Mode Register - Oversampling rate */
> >>   #define AT91_SAMA5D2_EMR_OSR(V)                      ((V) << 16)
> >>   #define AT91_SAMA5D2_EMR_OSR_MASK            GENMASK(17, 16)
> >> @@ -142,6 +156,9 @@
> >>   /* Channel Offset Register */
> >>   #define AT91_SAMA5D2_COR     0x4c
> >>   #define AT91_SAMA5D2_COR_DIFF_OFFSET 16
> >> +/* Channel Configuration Register */
> >> +#define AT91_SAMA7G5_CCR     0x5c
> >> +#define AT91_SAMA7G5_COR_DIFF_OFFSET 0
> >>
> >>   /* Analog Control Register */
> >>   #define AT91_SAMA5D2_ACR     0x94
> >> @@ -185,6 +202,7 @@
> >>   #define AT91_SAMA5D2_PRESSR  0xbc
> >>   /* Trigger Register */
> >>   #define AT91_SAMA5D2_TRGR    0xc0
> >> +#define AT91_SAMA7G5_TRGR    0x100
> >>   /* Mask for TRGMOD field of TRGR register */
> >>   #define AT91_SAMA5D2_TRGR_TRGMOD_MASK GENMASK(2, 0)
> >>   /* No trigger, only software trigger can start conversions */
> >> @@ -214,19 +232,26 @@
> >>   #define AT91_SAMA5D2_WPSR    0xe8
> >>   /* Version Register */
> >>   #define AT91_SAMA5D2_VERSION 0xfc
> >> +#define AT91_SAMA7G5_VERSION 0x130
> >>
> >>   #define AT91_SAMA5D2_HW_TRIG_CNT 3
> >>   #define AT91_SAMA5D2_SINGLE_CHAN_CNT 12
> >> +#define AT91_SAMA7G5_SINGLE_CHAN_CNT 16
> >>   #define AT91_SAMA5D2_DIFF_CHAN_CNT 6
> >> +#define AT91_SAMA7G5_DIFF_CHAN_CNT 8
> >>
> >>   #define AT91_SAMA5D2_TIMESTAMP_CHAN_IDX (AT91_SAMA5D2_SINGLE_CHAN_CNT + \
> >>                                         AT91_SAMA5D2_DIFF_CHAN_CNT + 1)
> >>
> >> +#define AT91_SAMA7G5_TIMESTAMP_CHAN_IDX (AT91_SAMA7G5_SINGLE_CHAN_CNT + \
> >> +                                      AT91_SAMA7G5_DIFF_CHAN_CNT + 1)
> >> +
> >>   #define AT91_SAMA5D2_TOUCH_X_CHAN_IDX (AT91_SAMA5D2_SINGLE_CHAN_CNT + \
> >>                                         AT91_SAMA5D2_DIFF_CHAN_CNT * 2)
> >>   #define AT91_SAMA5D2_TOUCH_Y_CHAN_IDX   (AT91_SAMA5D2_TOUCH_X_CHAN_IDX + 1)
> >>   #define AT91_SAMA5D2_TOUCH_P_CHAN_IDX   (AT91_SAMA5D2_TOUCH_Y_CHAN_IDX + 1)
> >>   #define AT91_SAMA5D2_MAX_CHAN_IDX    AT91_SAMA5D2_TOUCH_P_CHAN_IDX
> >> +#define AT91_SAMA7G5_MAX_CHAN_IDX    AT91_SAMA7G5_TIMESTAMP_CHAN_IDX
> >>
> >>   #define AT91_SAMA5D2_TOUCH_SAMPLE_PERIOD_US          2000    /* 2ms */
> >>   #define AT91_SAMA5D2_TOUCH_PEN_DETECT_DEBOUNCE_US    200
> >> @@ -239,8 +264,19 @@
> >>    * Maximum number of bytes to hold conversion from all channels
> >>    * without the timestamp.
> >>    */
> >> -#define AT91_BUFFER_MAX_CONVERSION_BYTES ((AT91_SAMA5D2_SINGLE_CHAN_CNT + \
> >> -                                      AT91_SAMA5D2_DIFF_CHAN_CNT) * 2)
> >> +#define AT91_SAMA5D2_BUFFER_MAX_CONVERSION_BYTES ( \
> >> +                                     (AT91_SAMA5D2_SINGLE_CHAN_CNT + \
> >> +                                     AT91_SAMA5D2_DIFF_CHAN_CNT) * 2)
> >> +
> >> +#define AT91_SAMA7G5_BUFFER_MAX_CONVERSION_BYTES ( \
> >> +                                     (AT91_SAMA7G5_SINGLE_CHAN_CNT + \
> >> +                                     AT91_SAMA7G5_DIFF_CHAN_CNT) * 2)
> >> +
> >> +#define AT91_BUFFER_MAX_CONVERSION_BYTES ( \
> >> +     (AT91_SAMA7G5_BUFFER_MAX_CONVERSION_BYTES > \
> >> +     AT91_SAMA5D2_BUFFER_MAX_CONVERSION_BYTES) ? \
> >> +     AT91_SAMA7G5_BUFFER_MAX_CONVERSION_BYTES : \
> >> +     AT91_SAMA5D2_BUFFER_MAX_CONVERSION_BYTES)
> >>
> >>   /* This total must also include the timestamp */
> >>   #define AT91_BUFFER_MAX_BYTES (AT91_BUFFER_MAX_CONVERSION_BYTES + 8)
> >> @@ -295,6 +331,27 @@
> >>                .indexed = 1,                                           \
> >>        }
> >>
> >> +#define AT91_SAMA7G5_CHAN_DIFF(num, num2, addr)                              \
> >> +     {                                                               \
> >> +             .type = IIO_VOLTAGE,                                    \
> >> +             .differential = 1,                                      \
> >> +             .channel = num,                                         \
> >> +             .channel2 = num2,                                       \
> >> +             .address = addr,                                        \
> >> +             .scan_index = num + AT91_SAMA7G5_SINGLE_CHAN_CNT,       \
> >> +             .scan_type = {                                          \
> >> +                     .sign = 's',                                    \
> >> +                     .realbits = 14,                                 \
> >> +                     .storagebits = 16,                              \
> >> +             },                                                      \
> >> +             .info_mask_separate = BIT(IIO_CHAN_INFO_RAW),           \
> >> +             .info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),   \
> >> +             .info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ)|\
> >> +                             BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),  \
> >> +             .datasheet_name = "CH"#num"-CH"#num2,                   \
> >> +             .indexed = 1,                                           \
> >> +     }
> >> +
> >>   #define AT91_SAMA5D2_CHAN_TOUCH(num, name, mod)                              \
> >>        {                                                               \
> >>                .type = IIO_POSITIONRELATIVE,                           \
> >> @@ -335,6 +392,8 @@ struct at91_adc_soc_info {
> >>        unsigned                        startup_time;
> >>        unsigned                        min_sample_rate;
> >>        unsigned                        max_sample_rate;
> >> +#define AT91_ADC_SAMA7G5(st)         ((st)->soc_info.sama7g5)
> >> +     bool                            sama7g5;
> >>   };
> >>
> >>   struct at91_adc_trigger {
> >> @@ -436,7 +495,7 @@ static const struct at91_adc_trigger at91_adc_trigger_list[] = {
> >>        },
> >>   };
> >>
> >> -static const struct iio_chan_spec at91_adc_channels[] = {
> >> +static const struct iio_chan_spec at91_sama5d2_adc_channels[] = {
> >>        AT91_SAMA5D2_CHAN_SINGLE(0, 0x50),
> >>        AT91_SAMA5D2_CHAN_SINGLE(1, 0x54),
> >>        AT91_SAMA5D2_CHAN_SINGLE(2, 0x58),
> >> @@ -461,6 +520,42 @@ static const struct iio_chan_spec at91_adc_channels[] = {
> >>        AT91_SAMA5D2_CHAN_PRESSURE(AT91_SAMA5D2_TOUCH_P_CHAN_IDX, "pressure"),
> >>   };
> >>
> >> +static const struct iio_chan_spec at91_sama7g5_adc_channels[] = {
> >> +     AT91_SAMA5D2_CHAN_SINGLE(0, 0x60),
> >> +     AT91_SAMA5D2_CHAN_SINGLE(1, 0x64),
> >> +     AT91_SAMA5D2_CHAN_SINGLE(2, 0x68),
> >> +     AT91_SAMA5D2_CHAN_SINGLE(3, 0x6c),
> >> +     AT91_SAMA5D2_CHAN_SINGLE(4, 0x70),
> >> +     AT91_SAMA5D2_CHAN_SINGLE(5, 0x74),
> >> +     AT91_SAMA5D2_CHAN_SINGLE(6, 0x78),
> >> +     AT91_SAMA5D2_CHAN_SINGLE(7, 0x7c),
> >> +     AT91_SAMA5D2_CHAN_SINGLE(8, 0x80),
> >> +     AT91_SAMA5D2_CHAN_SINGLE(9, 0x84),
> >> +     AT91_SAMA5D2_CHAN_SINGLE(10, 0x88),
> >> +     AT91_SAMA5D2_CHAN_SINGLE(11, 0x8c),
> >> +     AT91_SAMA5D2_CHAN_SINGLE(12, 0x90),
> >> +     AT91_SAMA5D2_CHAN_SINGLE(13, 0x94),
> >> +     AT91_SAMA5D2_CHAN_SINGLE(14, 0x98),
> >> +     AT91_SAMA5D2_CHAN_SINGLE(15, 0x9c),
> >> +     AT91_SAMA7G5_CHAN_DIFF(0, 1, 0x60),
> >> +     AT91_SAMA7G5_CHAN_DIFF(2, 3, 0x68),
> >> +     AT91_SAMA7G5_CHAN_DIFF(4, 5, 0x70),
> >> +     AT91_SAMA7G5_CHAN_DIFF(6, 7, 0x78),
> >> +     AT91_SAMA7G5_CHAN_DIFF(8, 9, 0x80),
> >> +     AT91_SAMA7G5_CHAN_DIFF(10, 11, 0x88),
> >> +     AT91_SAMA7G5_CHAN_DIFF(12, 13, 0x90),
> >> +     AT91_SAMA7G5_CHAN_DIFF(14, 15, 0x98),
> >> +     IIO_CHAN_SOFT_TIMESTAMP(AT91_SAMA7G5_TIMESTAMP_CHAN_IDX),
> >> +};
> >> +
> >> +static unsigned int at91_adc_max_chan_idx(struct at91_adc_state *st)
> >> +{
> >> +     if (AT91_ADC_SAMA7G5(st))
> >> +             return AT91_SAMA7G5_MAX_CHAN_IDX;
> >> +     else
> >> +             return AT91_SAMA5D2_MAX_CHAN_IDX;
> >> +}
> >> +
> >>   static int at91_adc_chan_xlate(struct iio_dev *indio_dev, int chan)
> >>   {
> >>        int i;
> >> @@ -492,6 +587,7 @@ static unsigned int at91_adc_active_scan_mask_to_reg(struct iio_dev *indio_dev)
> >>   {
> >>        u32 mask = 0;
> >>        u8 bit;
> >> +     struct at91_adc_state *st = iio_priv(indio_dev);
> >>
> >>        for_each_set_bit(bit, indio_dev->active_scan_mask,
> >>                         indio_dev->num_channels) {
> >> @@ -500,13 +596,78 @@ static unsigned int at91_adc_active_scan_mask_to_reg(struct iio_dev *indio_dev)
> >>                mask |= BIT(chan->channel);
> >>        }
> >>
> >> -     return mask & GENMASK(11, 0);
> >> +     return mask & GENMASK(at91_adc_max_chan_idx(st), 0);
> >> +}
> >> +
> >> +static void at91_adc_ccr(struct at91_adc_state *st,
> >> +                      struct iio_chan_spec const *chan)
> >> +{
> >> +     u32 ccr, cur_ccr;
> >> +
> >> +     ccr = (BIT(chan->channel) | BIT(chan->channel2));
> >> +
> >> +     if (AT91_ADC_SAMA7G5(st)) {
> >> +             cur_ccr = at91_adc_readl(st, AT91_SAMA7G5_CCR);
> >> +             ccr <<= AT91_SAMA7G5_COR_DIFF_OFFSET;
> >> +             if (chan->differential)
> >> +                     at91_adc_writel(st, AT91_SAMA7G5_CCR, cur_ccr | ccr);
> >> +             else
> >> +                     at91_adc_writel(st, AT91_SAMA7G5_CCR, cur_ccr & ~ccr);
> >> +     } else {
> >> +             cur_ccr = at91_adc_readl(st, AT91_SAMA5D2_COR);
> >> +             ccr <<= AT91_SAMA5D2_COR_DIFF_OFFSET;
> >> +             if (chan->differential)
> >> +                     at91_adc_writel(st, AT91_SAMA5D2_COR, cur_ccr | ccr);
> >> +             else
> >> +                     at91_adc_writel(st, AT91_SAMA5D2_COR, cur_ccr & ~ccr);
> >> +     }
> >> +}
> >> +
> >> +static void at91_adc_irq_status(struct at91_adc_state *st, u32 *status,
> >> +                             u32 *eoc)
> >> +{
> >> +     if (AT91_ADC_SAMA7G5(st)) {
> >> +             *status = at91_adc_readl(st, AT91_SAMA5D2_ISR);
> >> +             *eoc = at91_adc_readl(st, AT91_SAMA7G5_EOC_ISR);
> >> +     } else {
> >> +             *status = *eoc = at91_adc_readl(st, AT91_SAMA5D2_ISR);
> >> +     }
> >> +}
> >> +
> >> +static void at91_adc_irq_mask(struct at91_adc_state *st, u32 *status, u32 *eoc)
> >> +{
> >> +     if (AT91_ADC_SAMA7G5(st)) {
> >> +             *status = at91_adc_readl(st, AT91_SAMA5D2_IMR);
> >> +             *eoc = at91_adc_readl(st, AT91_SAMA7G5_EOC_IMR);
> >> +     } else {
> >> +             *status = *eoc = at91_adc_readl(st, AT91_SAMA5D2_IMR);
> >> +     }
> >> +}
> >> +
> >> +static void at91_adc_eoc_dis(struct at91_adc_state *st, unsigned int channel)
> >> +{
> >> +     if (!AT91_ADC_SAMA7G5(st))
> >> +             at91_adc_writel(st, AT91_SAMA5D2_IDR, BIT(channel));
> >> +     /* for SAMA7G5, Errata recommends not writing to EOC_IDR register */
> >> +}
> >> +
> >> +static void at91_adc_eoc_ena(struct at91_adc_state *st, unsigned int channel)
> >> +{
> >> +     if (AT91_ADC_SAMA7G5(st))
> >> +             at91_adc_writel(st, AT91_SAMA7G5_EOC_IER, BIT(channel));
> >> +     else
> >> +             at91_adc_writel(st, AT91_SAMA5D2_IER, BIT(channel));
> >>   }
> >>
> >>   static void at91_adc_config_emr(struct at91_adc_state *st)
> >>   {
> >>        /* configure the extended mode register */
> >> -     unsigned int emr = at91_adc_readl(st, AT91_SAMA5D2_EMR);
> >> +     unsigned int emr;
> >> +
> >> +     if (AT91_ADC_SAMA7G5(st))
> >> +             emr = at91_adc_readl(st, AT91_SAMA7G5_EMR);
> >> +     else
> >> +             emr = at91_adc_readl(st, AT91_SAMA5D2_EMR);
> >>
> >>        /* select oversampling per single trigger event */
> >>        emr |= AT91_SAMA5D2_EMR_ASTE(1);
> >> @@ -530,7 +691,10 @@ static void at91_adc_config_emr(struct at91_adc_state *st)
> >>                break;
> >>        }
> >>
> >> -     at91_adc_writel(st, AT91_SAMA5D2_EMR, emr);
> >> +     if (AT91_ADC_SAMA7G5(st))
> >> +             at91_adc_writel(st, AT91_SAMA7G5_EMR, emr);
> >> +     else
> >> +             at91_adc_writel(st, AT91_SAMA5D2_EMR, emr);
> >>   }
> >>
> >>   static int at91_adc_adjust_val_osr(struct at91_adc_state *st, int *val)
> >> @@ -726,7 +890,12 @@ static int at91_adc_configure_trigger(struct iio_trigger *trig, bool state)
> >>   {
> >>        struct iio_dev *indio = iio_trigger_get_drvdata(trig);
> >>        struct at91_adc_state *st = iio_priv(indio);
> >> -     u32 status = at91_adc_readl(st, AT91_SAMA5D2_TRGR);
> >> +     u32 status;
> >> +
> >> +     if (AT91_ADC_SAMA7G5(st))
> >> +             status = at91_adc_readl(st, AT91_SAMA7G5_TRGR);
> >> +     else
> >> +             status = at91_adc_readl(st, AT91_SAMA5D2_TRGR);
> >>
> >>        /* clear TRGMOD */
> >>        status &= ~AT91_SAMA5D2_TRGR_TRGMOD_MASK;
> >> @@ -735,7 +904,10 @@ static int at91_adc_configure_trigger(struct iio_trigger *trig, bool state)
> >>                status |= st->selected_trig->trgmod_value;
> >>
> >>        /* set/unset hw trigger */
> >> -     at91_adc_writel(st, AT91_SAMA5D2_TRGR, status);
> >> +     if (AT91_ADC_SAMA7G5(st))
> >> +             at91_adc_writel(st, AT91_SAMA7G5_TRGR, status);
> >> +     else
> >> +             at91_adc_writel(st, AT91_SAMA5D2_TRGR, status);
> >>
> >>        return 0;
> >>   }
> >> @@ -877,7 +1049,7 @@ static bool at91_adc_current_chan_is_touch(struct iio_dev *indio_dev)
> >>
> >>        return !!bitmap_subset(indio_dev->active_scan_mask,
> >>                               &st->touch_st.channels_bitmask,
> >> -                            AT91_SAMA5D2_MAX_CHAN_IDX + 1);
> >> +                            at91_adc_max_chan_idx(st) + 1);
> >>   }
> >>
> >>   static int at91_adc_buffer_prepare(struct iio_dev *indio_dev)
> >> @@ -905,7 +1077,6 @@ static int at91_adc_buffer_prepare(struct iio_dev *indio_dev)
> >>                         indio_dev->num_channels) {
> >>                struct iio_chan_spec const *chan =
> >>                                        at91_adc_chan_get(indio_dev, bit);
> >> -             u32 cor;
> >>
> >>                if (!chan)
> >>                        continue;
> >> @@ -914,16 +1085,7 @@ static int at91_adc_buffer_prepare(struct iio_dev *indio_dev)
> >>                    chan->type == IIO_PRESSURE)
> >>                        continue;
> >>
> >> -             cor = at91_adc_readl(st, AT91_SAMA5D2_COR);
> >> -
> >> -             if (chan->differential)
> >> -                     cor |= (BIT(chan->channel) | BIT(chan->channel2)) <<
> >> -                             AT91_SAMA5D2_COR_DIFF_OFFSET;
> >> -             else
> >> -                     cor &= ~(BIT(chan->channel) <<
> >> -                            AT91_SAMA5D2_COR_DIFF_OFFSET);
> >> -
> >> -             at91_adc_writel(st, AT91_SAMA5D2_COR, cor);
> >> +             at91_adc_ccr(st, chan);
> >>
> >>                at91_adc_writel(st, AT91_SAMA5D2_CHER, BIT(chan->channel));
> >>        }
> >> @@ -975,7 +1137,10 @@ static int at91_adc_buffer_postdisable(struct iio_dev *indio_dev)
> >>                at91_adc_writel(st, AT91_SAMA5D2_IDR, AT91_SAMA5D2_IER_DRDY);
> >>
> >>        /* read overflow register to clear possible overflow status */
> >> -     at91_adc_readl(st, AT91_SAMA5D2_OVER);
> >> +     if (AT91_ADC_SAMA7G5(st))
> >> +             at91_adc_readl(st, AT91_SAMA7G5_OVER);
> >> +     else
> >> +             at91_adc_readl(st, AT91_SAMA5D2_OVER);
> >>
> >>        /* if we are using DMA we must clear registers and end DMA */
> >>        if (st->dma_st.dma_chan)
> >> @@ -1018,13 +1183,15 @@ static void at91_adc_trigger_handler_nodma(struct iio_dev *indio_dev,
> >>        u8 bit;
> >>        u32 mask = at91_adc_active_scan_mask_to_reg(indio_dev);
> >>        unsigned int timeout = 50;
> >> +     u32 status, imr, eoc = 0, eoc_imr;
> >>
> >>        /*
> >>         * Check if the conversion is ready. If not, wait a little bit, and
> >>         * in case of timeout exit with an error.
> >>         */
> >> -     while ((at91_adc_readl(st, AT91_SAMA5D2_ISR) & mask) != mask &&
> >> -            timeout) {
> >> +     while (((eoc & mask) != mask) && timeout) {
> >> +             at91_adc_irq_status(st, &status, &eoc);
> >> +             at91_adc_irq_mask(st, &imr, &eoc_imr);
> >>                usleep_range(50, 100);
> >>                timeout--;
> >>        }
> >> @@ -1195,7 +1362,7 @@ static void at91_adc_touch_data_handler(struct iio_dev *indio_dev)
> >>        int i = 0;
> >>
> >>        for_each_set_bit(bit, indio_dev->active_scan_mask,
> >> -                      AT91_SAMA5D2_MAX_CHAN_IDX + 1) {
> >> +                      at91_adc_max_chan_idx(st) + 1) {
> >>                struct iio_chan_spec const *chan =
> >>                                         at91_adc_chan_get(indio_dev, bit);
> >>
> >> @@ -1262,12 +1429,14 @@ static irqreturn_t at91_adc_interrupt(int irq, void *private)
> >>   {
> >>        struct iio_dev *indio = private;
> >>        struct at91_adc_state *st = iio_priv(indio);
> >> -     u32 status = at91_adc_readl(st, AT91_SAMA5D2_ISR);
> >> -     u32 imr = at91_adc_readl(st, AT91_SAMA5D2_IMR);
> >> +     u32 status, eoc, imr, eoc_imr;
> >>        u32 rdy_mask = AT91_SAMA5D2_IER_XRDY | AT91_SAMA5D2_IER_YRDY |
> >>                        AT91_SAMA5D2_IER_PRDY;
> >>
> >> -     if (!(status & imr))
> >> +     at91_adc_irq_status(st, &status, &eoc);
> >> +     at91_adc_irq_mask(st, &imr, &eoc_imr);
> >> +
> >> +     if (!(status & imr) && !(eoc & eoc_imr))
> >>                return IRQ_NONE;
> >>        if (status & AT91_SAMA5D2_IER_PEN) {
> >>                /* pen detected IRQ */
> >> @@ -1309,7 +1478,6 @@ static int at91_adc_read_info_raw(struct iio_dev *indio_dev,
> >>                                  struct iio_chan_spec const *chan, int *val)
> >>   {
> >>        struct at91_adc_state *st = iio_priv(indio_dev);
> >> -     u32 cor = 0;
> >>        u16 tmp_val;
> >>        int ret;
> >>
> >> @@ -1355,13 +1523,9 @@ static int at91_adc_read_info_raw(struct iio_dev *indio_dev,
> >>
> >>        st->chan = chan;
> >>
> >> -     if (chan->differential)
> >> -             cor = (BIT(chan->channel) | BIT(chan->channel2)) <<
> >> -                   AT91_SAMA5D2_COR_DIFF_OFFSET;
> >> -
> >> -     at91_adc_writel(st, AT91_SAMA5D2_COR, cor);
> >> +     at91_adc_ccr(st, chan);
> >>        at91_adc_writel(st, AT91_SAMA5D2_CHER, BIT(chan->channel));
> >> -     at91_adc_writel(st, AT91_SAMA5D2_IER, BIT(chan->channel));
> >> +     at91_adc_eoc_ena(st, chan->channel);
> >>        at91_adc_writel(st, AT91_SAMA5D2_CR, AT91_SAMA5D2_CR_START);
> >>
> >>        ret = wait_event_interruptible_timeout(st->wq_data_available,
> >> @@ -1378,7 +1542,7 @@ static int at91_adc_read_info_raw(struct iio_dev *indio_dev,
> >>                st->conversion_done = false;
> >>        }
> >>
> >> -     at91_adc_writel(st, AT91_SAMA5D2_IDR, BIT(chan->channel));
> >> +     at91_adc_eoc_dis(st, st->chan->channel);
> >>        at91_adc_writel(st, AT91_SAMA5D2_CHDR, BIT(chan->channel));
> >>
> >>        /* Needed to ACK the DRDY interruption */
> >> @@ -1577,14 +1741,14 @@ static int at91_adc_update_scan_mode(struct iio_dev *indio_dev,
> >>        struct at91_adc_state *st = iio_priv(indio_dev);
> >>
> >>        if (bitmap_subset(scan_mask, &st->touch_st.channels_bitmask,
> >> -                       AT91_SAMA5D2_MAX_CHAN_IDX + 1))
> >> +                       at91_adc_max_chan_idx(st) + 1))
> >>                return 0;
> >>        /*
> >>         * if the new bitmap is a combination of touchscreen and regular
> >>         * channels, then we are not fine
> >>         */
> >>        if (bitmap_intersects(&st->touch_st.channels_bitmask, scan_mask,
> >> -                           AT91_SAMA5D2_MAX_CHAN_IDX + 1))
> >> +                           at91_adc_max_chan_idx(st) + 1))
> >>                return -EINVAL;
> >>        return 0;
> >>   }
> >> @@ -1594,6 +1758,8 @@ static void at91_adc_hw_init(struct iio_dev *indio_dev)
> >>        struct at91_adc_state *st = iio_priv(indio_dev);
> >>
> >>        at91_adc_writel(st, AT91_SAMA5D2_CR, AT91_SAMA5D2_CR_SWRST);
> >> +     if (AT91_ADC_SAMA7G5(st))
> >> +             at91_adc_writel(st, AT91_SAMA7G5_EOC_IDR, 0xffffffff);
> >>        at91_adc_writel(st, AT91_SAMA5D2_IDR, 0xffffffff);
> >>        /*
> >>         * Transfer field must be set to 2 according to the datasheet and
> >> @@ -1718,18 +1884,27 @@ static int at91_adc_probe(struct platform_device *pdev)
> >>        indio_dev->name = dev_name(&pdev->dev);
> >>        indio_dev->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_SOFTWARE;
> >>        indio_dev->info = &at91_adc_info;
> >> -     indio_dev->channels = at91_adc_channels;
> >> -     indio_dev->num_channels = ARRAY_SIZE(at91_adc_channels);
> >>
> >>        st = iio_priv(indio_dev);
> >>        st->indio_dev = indio_dev;
> >>
> >> -     bitmap_set(&st->touch_st.channels_bitmask,
> >> -                AT91_SAMA5D2_TOUCH_X_CHAN_IDX, 1);
> >> -     bitmap_set(&st->touch_st.channels_bitmask,
> >> -                AT91_SAMA5D2_TOUCH_Y_CHAN_IDX, 1);
> >> -     bitmap_set(&st->touch_st.channels_bitmask,
> >> -                AT91_SAMA5D2_TOUCH_P_CHAN_IDX, 1);
> >> +     st->soc_info.sama7g5 = of_device_is_compatible(pdev->dev.of_node,
> >> +                                                    "microchip,sama7g5-adc");  
> > 
> > Better to use match_data to get an enum value which is used to index
> > into a table of support part description structures.  Each of those
> > structures has all the registers etc + channel specs and callbacks
> > where needed for more complex handling.
> > 
> > Other advantage is you can introduce the structures in a precursor patch with
> > just one entry for existing behaviour.  The new device support is then added
> > in a second patch.  All we need to do then is check first patch is a noop
> > and that second much shorter patch makes sense.
> >   
> >> +
> >> +     if (AT91_ADC_SAMA7G5(st)) {
> >> +             indio_dev->channels = at91_sama7g5_adc_channels;
> >> +             indio_dev->num_channels = ARRAY_SIZE(at91_sama7g5_adc_channels);
> >> +     } else {
> >> +             indio_dev->channels = at91_sama5d2_adc_channels;
> >> +             indio_dev->num_channels = ARRAY_SIZE(at91_sama5d2_adc_channels);
> >> +
> >> +             bitmap_set(&st->touch_st.channels_bitmask,
> >> +                        AT91_SAMA5D2_TOUCH_X_CHAN_IDX, 1);
> >> +             bitmap_set(&st->touch_st.channels_bitmask,
> >> +                        AT91_SAMA5D2_TOUCH_Y_CHAN_IDX, 1);
> >> +             bitmap_set(&st->touch_st.channels_bitmask,
> >> +                        AT91_SAMA5D2_TOUCH_P_CHAN_IDX, 1);
> >> +     }
> >>
> >>        st->oversampling_ratio = AT91_OSR_1SAMPLES;
> >>
> >> @@ -1853,9 +2028,12 @@ static int at91_adc_probe(struct platform_device *pdev)
> >>                dev_info(&pdev->dev, "setting up trigger as %s\n",
> >>                         st->selected_trig->name);
> >>
> >> -     dev_info(&pdev->dev, "version: %x\n",
> >> -              readl_relaxed(st->base + AT91_SAMA5D2_VERSION));
> >> -
> >> +     if (AT91_ADC_SAMA7G5(st))  
> > 
> > We may be better off with a look up table of all the registers
> > (+ if needed some callback functions) rather than a whole bunch of
> > if statements.
> > 
> > You then just assign the right 'part number specific' structure
> > once in probe.
> >   
> >> +             dev_info(&pdev->dev, "version: %x\n",
> >> +                      at91_adc_readl(st, AT91_SAMA7G5_VERSION));
> >> +     else
> >> +             dev_info(&pdev->dev, "version: %x\n",
> >> +                      at91_adc_readl(st, AT91_SAMA5D2_VERSION));
> >>        return 0;
> >>
> >>   dma_disable:
> >> @@ -1957,6 +2135,8 @@ static SIMPLE_DEV_PM_OPS(at91_adc_pm_ops, at91_adc_suspend, at91_adc_resume);
> >>   static const struct of_device_id at91_adc_dt_match[] = {
> >>        {
> >>                .compatible = "atmel,sama5d2-adc",
> >> +     }, {
> >> +             .compatible = "microchip,sama7g5-adc",
> >>        }, {
> >>                /* sentinel */
> >>        }
> >> @@ -1967,13 +2147,14 @@ static struct platform_driver at91_adc_driver = {
> >>        .probe = at91_adc_probe,
> >>        .remove = at91_adc_remove,
> >>        .driver = {
> >> -             .name = "at91-sama5d2_adc",
> >> +             .name = "at91-sama5d2-sama7g5_adc",  
> > 
> > Please keep the driver name the same. It's common to have a name of one
> > random part a driver supports used even if there are lots of others.
> > This (or wild cards) never scales as more parts are added to a driver.
> >   
> >>                .of_match_table = at91_adc_dt_match,
> >>                .pm = &at91_adc_pm_ops,
> >>        },
> >>   };
> >>   module_platform_driver(at91_adc_driver)
> >>
> >> -MODULE_AUTHOR("Ludovic Desroches <ludovic.desroches@atmel.com>");
> >> -MODULE_DESCRIPTION("Atmel AT91 SAMA5D2 ADC");
> >> +MODULE_AUTHOR("Ludovic Desroches <ludovic.desroches@microchip.com>");
> >> +MODULE_AUTHOR("Eugen Hristev <eugen.hristev@microchip.com>");
> >> +MODULE_DESCRIPTION("Microchip AT91 SAMA5D2/SAMA7G5 ADC");
> >>   MODULE_LICENSE("GPL v2");  
> >   
> 

