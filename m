Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97F24262C0B
	for <lists+linux-iio@lfdr.de>; Wed,  9 Sep 2020 11:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730206AbgIIJge convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Wed, 9 Sep 2020 05:36:34 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2798 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727935AbgIIJgc (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 9 Sep 2020 05:36:32 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 6539D172FAA4D308D3D8;
        Wed,  9 Sep 2020 10:36:27 +0100 (IST)
Received: from localhost (10.52.122.51) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1913.5; Wed, 9 Sep 2020
 10:36:26 +0100
Date:   Wed, 9 Sep 2020 10:34:52 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Gene Chen <gene.chen.richtek@gmail.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>, <knaack.h@gmx.de>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        "Gene Chen" <gene_chen@richtek.com>, <Wilma.Wu@mediatek.com>,
        <shufan_lee@richtek.com>, <cy_huang@richtek.com>,
        <benjamin.chao@mediatek.com>
Subject: Re: [PATCH v3 1/2] iio: adc: mt6360: Add ADC driver for MT6360
Message-ID: <20200909103452.000074dd@Huawei.com>
In-Reply-To: <CAE+NS35ucEjeewBRaW7ha1pcisz-VQBK8VJgK_DdB5vWy7Q53Q@mail.gmail.com>
References: <1598259985-12517-1-git-send-email-gene.chen.richtek@gmail.com>
        <1598259985-12517-2-git-send-email-gene.chen.richtek@gmail.com>
        <20200829181157.1b653a88@archlinux>
        <CAE+NS36j4a6k-JSUbjxzpfbqtE-xMW7qxUUhHPAnc_9V-Lv7LQ@mail.gmail.com>
        <20200908100712.00007a7b@Huawei.com>
        <CAE+NS35aQ3k2auYA+bmf6kMhm192oyg8_j5j=zzK0sn_NS6HoA@mail.gmail.com>
        <20200908135830.00007b13@Huawei.com>
        <CAE+NS35ucEjeewBRaW7ha1pcisz-VQBK8VJgK_DdB5vWy7Q53Q@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.52.122.51]
X-ClientProxiedBy: lhreml709-chm.china.huawei.com (10.201.108.58) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 9 Sep 2020 07:39:14 +0800
Gene Chen <gene.chen.richtek@gmail.com> wrote:

> Jonathan Cameron <Jonathan.Cameron@huawei.com> 於 2020年9月8日 週二 下午9:00寫道：
> >
> > ...
> >  
> > > > > > > +#include <linux/completion.h>
> > > > > > > +#include <linux/interrupt.h>
> > > > > > > +#include <linux/iio/buffer.h>
> > > > > > > +#include <linux/iio/iio.h>
> > > > > > > +#include <linux/iio/trigger_consumer.h>
> > > > > > > +#include <linux/iio/triggered_buffer.h>
> > > > > > > +#include <linux/irq.h>
> > > > > > > +#include <linux/kernel.h>
> > > > > > > +#include <linux/ktime.h>
> > > > > > > +#include <linux/module.h>
> > > > > > > +#include <linux/mutex.h>
> > > > > > > +#include <linux/platform_device.h>
> > > > > > > +#include <linux/regmap.h>
> > > > > > > +
> > > > > > > +#define MT6360_REG_PMUCHGCTRL3       0x313
> > > > > > > +#define MT6360_REG_PMUADCCFG 0x356
> > > > > > > +#define MT6360_REG_PMUADCRPT1        0x35A
> > > > > > > +
> > > > > > > +/* PMUCHGCTRL3 0x313 */
> > > > > > > +#define MT6360_AICR_MASK     0xFC
> > > > > > > +#define MT6360_AICR_SHFT     2
> > > > > > > +#define MT6360_AICR_400MA    0x6
> > > > > > > +/* PMUADCCFG 0x356 */
> > > > > > > +#define MT6360_ADCEN_MASK    0x8000
> > > > > > > +/* PMUADCRPT1 0x35A */
> > > > > > > +#define MT6360_PREFERCH_MASK 0xF0
> > > > > > > +#define MT6360_PREFERCH_SHFT 4
> > > > > > > +#define MT6360_RPTCH_MASK    0x0F
> > > > > > > +
> > > > > > > +enum {
> > > > > > > +     MT6360_CHAN_USBID = 0,
> > > > > > > +     MT6360_CHAN_VBUSDIV5,
> > > > > > > +     MT6360_CHAN_VBUSDIV2,
> > > > > > > +     MT6360_CHAN_VSYS,
> > > > > > > +     MT6360_CHAN_VBAT,
> > > > > > > +     MT6360_CHAN_IBUS,
> > > > > > > +     MT6360_CHAN_IBAT,
> > > > > > > +     MT6360_CHAN_CHG_VDDP,
> > > > > > > +     MT6360_CHAN_TEMP_JC,
> > > > > > > +     MT6360_CHAN_VREF_TS,
> > > > > > > +     MT6360_CHAN_TS,
> > > > > > > +     MT6360_CHAN_MAX,
> > > > > > > +};
> > > > > > > +
> > > > > > > +struct mt6360_adc_data {
> > > > > > > +     struct device *dev;
> > > > > > > +     struct regmap *regmap;
> > > > > > > +     struct completion adc_complete;
> > > > > > > +     struct mutex adc_lock;
> > > > > > > +     ktime_t last_off_timestamps[MT6360_CHAN_MAX];
> > > > > > > +     int irq;
> > > > > > > +};
> > > > > > > +
> > > > > > > +static inline int mt6360_adc_val_converter(int val, int multiplier, int offset, int divisor)
> > > > > > > +{
> > > > > > > +     return ((val * multiplier) + offset) / divisor;  
> > > > > >
> > > > > > Why could we not report these values to userspace or consumer drivers and let
> > > > > > them deal with the conversion if they actually needed it?
> > > > > > Mapping this to
> > > > > >
> > > > > > (val + new_offset) * multiplier would be a little messy, but not too bad.
> > > > > >
> > > > > > The advantage would be that we would then be providing the data needed
> > > > > > to get real units for values read from the buffers without having to
> > > > > > do all the maths in kernel (without access to floating point).
> > > > > >
> > > > > >  
> > > > >
> > > > > As above, if I use formula "(val + new_offset) * multiplier",
> > > > > the junction temperature channel multiplier will be floating point
> > > > > 1.05, i don't know how to express.  
> > > >
> > > > As Andy mentioned, we do this all over the place.
> > > > IIO_VAL_INT_PLUS_MICRO
> > > >
> > > > The key is that we want to push the burden of doing this maths to the user
> > > > not the source.  
> > >
> > > ACK.
> > > Can I keep IIO_CHAN_INFO_PROCESSED function be reserved for user in
> > > kernel space?
> > >  
> >
> > No. We have utility functions that will apply the multiplier as needed so
> > there is no significant advantage in doing this and it won't be consistent
> > with the majority of other drivers.
> >  
> 
> ACK, I will remove IIO_CHAN_INFO_PROCESSED.
> 
> > > >
> > > > Often what is actually of interest is whether a temperature passed a threshold.
> > > > In that case, you can transform the threshold into the units of the ADC (so the
> > > > reverse directly to you would do with processed data) and only have to do the
> > > > maths once per change of the threshold instead of for every sample.
> > > >
> > > > There are helper functions to do the maths for you, should you actually
> > > > need SI units.
> > > >  
> > >
> > > ACK
> > >  
> > > > >  
> > > > > > > +}
> > > > > > > +
> > > > > > > +static int mt6360_adc_convert_processed_val(struct mt6360_adc_data *info, int chan_idx, int *val)
> > > > > > > +{
> > > > > > > +     unsigned int regval = 0;
> > > > > > > +     const struct converter {
> > > > > > > +             int multiplier;
> > > > > > > +             int offset;
> > > > > > > +             int divisor;
> > > > > > > +     } adc_converter[MT6360_CHAN_MAX] = {
> > > > > > > +             { 1250, 0, 1}, /* USBID */
> > > > > > > +             { 6250, 0, 1}, /* VBUSDIV5 */
> > > > > > > +             { 2500, 0, 1}, /* VBUSDIV2 */
> > > > > > > +             { 1250, 0, 1}, /* VSYS */
> > > > > > > +             { 1250, 0, 1}, /* VBAT */
> > > > > > > +             { 2500, 0, 1}, /* IBUS */
> > > > > > > +             { 2500, 0, 1}, /* IBAT */
> > > > > > > +             { 1250, 0, 1}, /* CHG_VDDP */
> > > > > > > +             { 105, -8000, 100}, /* TEMP_JC */
> > > > > > > +             { 1250, 0, 1}, /* VREF_TS */
> > > > > > > +             { 1250, 0, 1}, /* TS */
> > > > > > > +     }, sp_ibus_adc_converter = { 1900, 0, 1 }, *sel_converter;
> > > > > > > +     int ret;
> > > > > > > +
> > > > > > > +     sel_converter = adc_converter + chan_idx;
> > > > > > > +     if (chan_idx == MT6360_CHAN_IBUS) {
> > > > > > > +             /* ibus chan will be affected by aicr config */
> > > > > > > +             /* if aicr < 400, apply the special ibus converter */
> > > > > > > +             ret = regmap_read(info->regmap, MT6360_REG_PMUCHGCTRL3, &regval);
> > > > > > > +             if (ret)
> > > > > > > +                     return ret;
> > > > > > > +
> > > > > > > +             regval = (regval & MT6360_AICR_MASK) >> MT6360_AICR_SHFT;
> > > > > > > +             if (regval < MT6360_AICR_400MA)
> > > > > > > +                     sel_converter = &sp_ibus_adc_converter;
> > > > > > > +     }
> > > > > > > +
> > > > > > > +     *val = mt6360_adc_val_converter(*val, sel_converter->multiplier, sel_converter->offset,
> > > > > > > +                                     sel_converter->divisor);
> > > > > > > +
> > > > > > > +     return 0;
> > > > > > > +}
> > > > > > > +
> > > > > > > +static int mt6360_adc_read_processed(struct mt6360_adc_data *mad, int channel, int *val)
> > > > > > > +{
> > > > > > > +     u16 adc_enable;
> > > > > > > +     u8 rpt[3];
> > > > > > > +     ktime_t start_t, predict_end_t;
> > > > > > > +     long timeout;
> > > > > > > +     int value, ret;
> > > > > > > +
> > > > > > > +     mutex_lock(&mad->adc_lock);
> > > > > > > +
> > > > > > > +     /* select preferred channel that we want */
> > > > > > > +     ret = regmap_update_bits(mad->regmap, MT6360_REG_PMUADCRPT1, MT6360_PREFERCH_MASK,
> > > > > > > +                              channel << MT6360_PREFERCH_SHFT);
> > > > > > > +     if (ret)
> > > > > > > +             goto out_adc;
> > > > > > > +
> > > > > > > +     /* enable adc channel we want and adc_en */
> > > > > > > +     adc_enable = MT6360_ADCEN_MASK | BIT(channel);
> > > > > > > +     adc_enable = cpu_to_be16(adc_enable);  
> > > > > >
> > > > > > Use a local be16 to store that. It will make it a little clearer
> > > > > > that we are doing something 'unusual' here.  Perhaps a comment on
> > > > > > why this odd code exists would also help?
> > > > > >  
> > > > >
> > > > > ACK
> > > > >  
> > > > > > > +     ret = regmap_raw_write(mad->regmap, MT6360_REG_PMUADCCFG, (void *)&adc_enable, sizeof(u16));
> > > > > > > +     if (ret)
> > > > > > > +             goto out_adc;
> > > > > > > +
> > > > > > > +     start_t = ktime_get();
> > > > > > > +     predict_end_t = ktime_add_ms(mad->last_off_timestamps[channel], 50);
> > > > > > > +
> > > > > > > +     if (ktime_after(start_t, predict_end_t))
> > > > > > > +             predict_end_t = ktime_add_ms(start_t, 25);
> > > > > > > +     else
> > > > > > > +             predict_end_t = ktime_add_ms(start_t, 75);
> > > > > > > +
> > > > > > > +     enable_irq(mad->irq);
> > > > > > > +adc_retry:
> > > > > > > +     reinit_completion(&mad->adc_complete);
> > > > > > > +
> > > > > > > +     /* wait for conversion to complete */
> > > > > > > +     timeout = wait_for_completion_timeout(&mad->adc_complete, msecs_to_jiffies(200));
> > > > > > > +     if (timeout == 0) {
> > > > > > > +             ret = -ETIMEDOUT;
> > > > > > > +             goto out_adc_conv;
> > > > > > > +     } else if (timeout < 0) {
> > > > > > > +             ret = -EINTR;
> > > > > > > +             goto out_adc_conv;
> > > > > > > +     }
> > > > > > > +
> > > > > > > +     ret = regmap_raw_read(mad->regmap, MT6360_REG_PMUADCRPT1, rpt, sizeof(rpt));
> > > > > > > +     if (ret)
> > > > > > > +             goto out_adc_conv;
> > > > > > > +
> > > > > > > +     /* check the current reported channel */
> > > > > > > +     if ((rpt[0] & MT6360_RPTCH_MASK) != channel) {
> > > > > > > +             dev_dbg(mad->dev, "not wanted channel report [%02x]\n", rpt[0]);  
> > > > > >
> > > > > > This and the one below feel like error messages rather than debug ones.
> > > > > >  
> > > > >
> > > > > We have two function "battery zero current voltage(ZCV)" and "TypeC
> > > > > OTP" will auto run ADC at background.
> > > > > ZCV_EN will run VBAT_ADC when TA plug in, TypeC OTP will run TS_ADC
> > > > > when TypeC attach.
> > > > > We need to check report channel for ADC report data match is our desire channel.  
> > > >
> > > > So there is firmware messing with it underneath?  Oh goody.
> > > > Add a comment explaining this.
> > > >  
> > >
> > > ACK, I try to write a comment as below
> > >
> > >         /*
> > >          * There are two functions, ZCV and TypeC OTP, running ADC
> > > VBAT and TS in background,
> > >          * and ADC samples are taken on a fixed frequency no matter
> > > read the previous one or not.
> > >          * To avoid conflict need set minimum time threshold after
> > > enable ADC and check report
> > >          * channel is the same.
> > >          * The worst case is run the same ADC twice and background
> > > function is also running,
> > >          * ADC conversion sequence is desire channel before start ADC,
> > > background ADC, desire
> > >          * channel after start ADC. So the minimum correct data is
> > > three times of typical
> > >          * conversion time.
> > >          */  
> >
> > Looks good.
> >  
> 
> ACK
> 
> > >  
> > > > >  
> > > > > > > +             goto adc_retry;
> > > > > > > +     }
> > > > > > > +
> > > > > > > +     if (!ktime_after(ktime_get(), predict_end_t)) {
> > > > > > > +             dev_dbg(mad->dev, "time is not after one adc_conv_t\n");  
> > > > > >
> > > > > > Does this actually happen? If feels like we are being a bit over protective
> > > > > > here.  I'd definitely like to see a comment saying why this protection
> > > > > > might be needed.
> > > > > >  
> > > > >
> > > > > When ADC_EN and MT6360_CHANx_EN is enable, the channel x will keep
> > > > > running again and again
> > > > > I supposed to get immediate data which is generated after I start it.  
> > > >
> > > > Just to check my understanding.
> > > >
> > > > This is an edge triggered interrupt and it triggers every time a new sample
> > > > is taken.  Those samples are taken on a fixed frequency irrespective of whether
> > > > we have read the previous one?
> > > >  
> > >
> > > Yes.
> > > I use LEVEL_LOW trigger in latest review MFD patch.  
> >
> > I'm not sure I follow that comment.  How can you do that if it's a repeating
> > edge trigger?
> >  
> 
> I implement "struct regmap_irq_chip" handle_post_irq ops,
> In the end of handle irq, I set the re-trigger bit which will pull irq
> high to low again if irq pin is low.
> 
> -static int mt6360_pmu_handle_post_irq(void *irq_drv_data)
> -{
> -       struct mt6360_pmu_info *mpi = irq_drv_data;
> -
> -       return regmap_update_bits(mpi->regmap,
> -               MT6360_PMU_IRQ_SET, MT6360_IRQ_RETRIG, MT6360_IRQ_RETRIG);
> -}
> -

Ah understood I think.

> 
> > >  
> > > > >
> > > > > When I disable ADC_CHANx_EN, the H/W logical ADC is still running.
> > > > > If I run the same ADC immediately, I may get the old result about this channel.
> > > > > MT6360 ADC typical conversation time is about 25ms.
> > > > > So We need ignore which irq trigger below 25ms.  
> > > >
> > > > Normal trick for this sort of case is to just not use the interrupt.
> > > > Just read after 25+delta msecs and you are guaranteed to get the right answer.
> > > >
> > > >  
> > >
> > > ACK, I will try to use polling
> > > Is the pseudocode correct?
> > >
> > > mdelay(predict_end_t);
> > > while (true) {
> > >     read adc event is occured
> > >     check report channel is the same
> > >     if the same, read report ADC data and break while loop
> > >     else msleep(per ADC conversion time)
> > > }  
> >
> > Looks correct to me.  We should 'know' the event has happened but
> > still need to check the channel is the expected one.
> >  
> 
> There is a comment in our internal discuss.
> If I use msleep as polling interval, the worst case will cause
> additional wait time nearly one polling interval.
> Can I keep using interrupt for saving time?

You could but it is complicating the code to deal with frankly stupid
hardware design which I'm not that keen on.

If it ends up clean enough with a lot comments on why the odd parts
are there, then maybe it will be fine.

Jonathan

> 
> > ...
> >  


