Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E489C260E52
	for <lists+linux-iio@lfdr.de>; Tue,  8 Sep 2020 11:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728562AbgIHJIu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Tue, 8 Sep 2020 05:08:50 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2780 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728490AbgIHJIt (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 8 Sep 2020 05:08:49 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 98026CC5F8DCFCC28E86;
        Tue,  8 Sep 2020 10:08:47 +0100 (IST)
Received: from localhost (10.52.124.38) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1913.5; Tue, 8 Sep 2020
 10:08:46 +0100
Date:   Tue, 8 Sep 2020 10:07:12 +0100
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
Message-ID: <20200908100712.00007a7b@Huawei.com>
In-Reply-To: <CAE+NS36j4a6k-JSUbjxzpfbqtE-xMW7qxUUhHPAnc_9V-Lv7LQ@mail.gmail.com>
References: <1598259985-12517-1-git-send-email-gene.chen.richtek@gmail.com>
        <1598259985-12517-2-git-send-email-gene.chen.richtek@gmail.com>
        <20200829181157.1b653a88@archlinux>
        <CAE+NS36j4a6k-JSUbjxzpfbqtE-xMW7qxUUhHPAnc_9V-Lv7LQ@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.52.124.38]
X-ClientProxiedBy: lhreml709-chm.china.huawei.com (10.201.108.58) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 8 Sep 2020 14:17:42 +0800
Gene Chen <gene.chen.richtek@gmail.com> wrote:

> Jonathan Cameron <jic23@kernel.org> 於 2020年8月30日 週日 上午1:12寫道：
> >
> > On Mon, 24 Aug 2020 17:06:24 +0800
> > Gene Chen <gene.chen.richtek@gmail.com> wrote:
> >  
> > > From: Gene Chen <gene_chen@richtek.com>
> > >
> > > Add MT6360 ADC driver include Charger Current, Voltage, and
> > > Temperature.
> > >
> > > Signed-off-by: Gene Chen <gene_chen@richtek.com>  
> > Hi Gene,
> >
> > A few comments inline.  The big one centres on why we can't
> > expose the channels as _raw, _offset and _scale?
> >  
> 
> I think i have 3 reason for use real value,
> ADC is used to get real value rather than raw data which is not meaningful.
> And I can decide which formula needs apply according to different condition.
> Also the junction temperature channel _scale is floating point 1.05
> which is not easy to express.

See below.

> 
> > Thanks,
> >
> > Jonathan
> >  
> > > ---
> > >  drivers/iio/adc/Kconfig      |  11 ++
> > >  drivers/iio/adc/Makefile     |   1 +
> > >  drivers/iio/adc/mt6360-adc.c | 366 +++++++++++++++++++++++++++++++++++++++++++
> > >  3 files changed, 378 insertions(+)
> > >  create mode 100644 drivers/iio/adc/mt6360-adc.c
> > >
> > > diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> > > index 66d9cc0..07dcea7 100644
> > > --- a/drivers/iio/adc/Kconfig
> > > +++ b/drivers/iio/adc/Kconfig
> > > @@ -703,6 +703,17 @@ config MCP3911
> > >         This driver can also be built as a module. If so, the module will be
> > >         called mcp3911.
> > >
> > > +config MEDIATEK_MT6360_ADC
> > > +     tristate "Mediatek MT6360 ADC Part"
> > > +     depends on MFD_MT6360
> > > +     select IIO_BUFFER
> > > +     select IIO_TRIGGERED_BUFFER
> > > +     help
> > > +       Say Y here to enable MT6360 ADC Part.
> > > +       Integrated for System Monitoring include
> > > +       Charger and Battery Current, Voltage and
> > > +       Temperature
> > > +
> > >  config MEDIATEK_MT6577_AUXADC
> > >       tristate "MediaTek AUXADC driver"
> > >       depends on ARCH_MEDIATEK || COMPILE_TEST
> > > diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> > > index 90f94ad..5fca90a 100644
> > > --- a/drivers/iio/adc/Makefile
> > > +++ b/drivers/iio/adc/Makefile
> > > @@ -65,6 +65,7 @@ obj-$(CONFIG_MAX9611) += max9611.o
> > >  obj-$(CONFIG_MCP320X) += mcp320x.o
> > >  obj-$(CONFIG_MCP3422) += mcp3422.o
> > >  obj-$(CONFIG_MCP3911) += mcp3911.o
> > > +obj-$(CONFIG_MEDIATEK_MT6360_ADC) += mt6360-adc.o
> > >  obj-$(CONFIG_MEDIATEK_MT6577_AUXADC) += mt6577_auxadc.o
> > >  obj-$(CONFIG_MEN_Z188_ADC) += men_z188_adc.o
> > >  obj-$(CONFIG_MESON_SARADC) += meson_saradc.o
> > > diff --git a/drivers/iio/adc/mt6360-adc.c b/drivers/iio/adc/mt6360-adc.c
> > > new file mode 100644
> > > index 0000000..5eed812
> > > --- /dev/null
> > > +++ b/drivers/iio/adc/mt6360-adc.c
> > > @@ -0,0 +1,366 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * Copyright (c) 2020 MediaTek Inc.
> > > + *
> > > + * Author: Gene Chen <gene_chen@richtek.com>
> > > + */
> > > +
> > > +#include <linux/completion.h>
> > > +#include <linux/interrupt.h>
> > > +#include <linux/iio/buffer.h>
> > > +#include <linux/iio/iio.h>
> > > +#include <linux/iio/trigger_consumer.h>
> > > +#include <linux/iio/triggered_buffer.h>
> > > +#include <linux/irq.h>
> > > +#include <linux/kernel.h>
> > > +#include <linux/ktime.h>
> > > +#include <linux/module.h>
> > > +#include <linux/mutex.h>
> > > +#include <linux/platform_device.h>
> > > +#include <linux/regmap.h>
> > > +
> > > +#define MT6360_REG_PMUCHGCTRL3       0x313
> > > +#define MT6360_REG_PMUADCCFG 0x356
> > > +#define MT6360_REG_PMUADCRPT1        0x35A
> > > +
> > > +/* PMUCHGCTRL3 0x313 */
> > > +#define MT6360_AICR_MASK     0xFC
> > > +#define MT6360_AICR_SHFT     2
> > > +#define MT6360_AICR_400MA    0x6
> > > +/* PMUADCCFG 0x356 */
> > > +#define MT6360_ADCEN_MASK    0x8000
> > > +/* PMUADCRPT1 0x35A */
> > > +#define MT6360_PREFERCH_MASK 0xF0
> > > +#define MT6360_PREFERCH_SHFT 4
> > > +#define MT6360_RPTCH_MASK    0x0F
> > > +
> > > +enum {
> > > +     MT6360_CHAN_USBID = 0,
> > > +     MT6360_CHAN_VBUSDIV5,
> > > +     MT6360_CHAN_VBUSDIV2,
> > > +     MT6360_CHAN_VSYS,
> > > +     MT6360_CHAN_VBAT,
> > > +     MT6360_CHAN_IBUS,
> > > +     MT6360_CHAN_IBAT,
> > > +     MT6360_CHAN_CHG_VDDP,
> > > +     MT6360_CHAN_TEMP_JC,
> > > +     MT6360_CHAN_VREF_TS,
> > > +     MT6360_CHAN_TS,
> > > +     MT6360_CHAN_MAX,
> > > +};
> > > +
> > > +struct mt6360_adc_data {
> > > +     struct device *dev;
> > > +     struct regmap *regmap;
> > > +     struct completion adc_complete;
> > > +     struct mutex adc_lock;
> > > +     ktime_t last_off_timestamps[MT6360_CHAN_MAX];
> > > +     int irq;
> > > +};
> > > +
> > > +static inline int mt6360_adc_val_converter(int val, int multiplier, int offset, int divisor)
> > > +{
> > > +     return ((val * multiplier) + offset) / divisor;  
> >
> > Why could we not report these values to userspace or consumer drivers and let
> > them deal with the conversion if they actually needed it?
> > Mapping this to
> >
> > (val + new_offset) * multiplier would be a little messy, but not too bad.
> >
> > The advantage would be that we would then be providing the data needed
> > to get real units for values read from the buffers without having to
> > do all the maths in kernel (without access to floating point).
> >
> >  
> 
> As above, if I use formula "(val + new_offset) * multiplier",
> the junction temperature channel multiplier will be floating point
> 1.05, i don't know how to express.

As Andy mentioned, we do this all over the place.
IIO_VAL_INT_PLUS_MICRO

The key is that we want to push the burden of doing this maths to the user
not the source.

Often what is actually of interest is whether a temperature passed a threshold.
In that case, you can transform the threshold into the units of the ADC (so the
reverse directly to you would do with processed data) and only have to do the
maths once per change of the threshold instead of for every sample.

There are helper functions to do the maths for you, should you actually
need SI units.

> 
> > > +}
> > > +
> > > +static int mt6360_adc_convert_processed_val(struct mt6360_adc_data *info, int chan_idx, int *val)
> > > +{
> > > +     unsigned int regval = 0;
> > > +     const struct converter {
> > > +             int multiplier;
> > > +             int offset;
> > > +             int divisor;
> > > +     } adc_converter[MT6360_CHAN_MAX] = {
> > > +             { 1250, 0, 1}, /* USBID */
> > > +             { 6250, 0, 1}, /* VBUSDIV5 */
> > > +             { 2500, 0, 1}, /* VBUSDIV2 */
> > > +             { 1250, 0, 1}, /* VSYS */
> > > +             { 1250, 0, 1}, /* VBAT */
> > > +             { 2500, 0, 1}, /* IBUS */
> > > +             { 2500, 0, 1}, /* IBAT */
> > > +             { 1250, 0, 1}, /* CHG_VDDP */
> > > +             { 105, -8000, 100}, /* TEMP_JC */
> > > +             { 1250, 0, 1}, /* VREF_TS */
> > > +             { 1250, 0, 1}, /* TS */
> > > +     }, sp_ibus_adc_converter = { 1900, 0, 1 }, *sel_converter;
> > > +     int ret;
> > > +
> > > +     sel_converter = adc_converter + chan_idx;
> > > +     if (chan_idx == MT6360_CHAN_IBUS) {
> > > +             /* ibus chan will be affected by aicr config */
> > > +             /* if aicr < 400, apply the special ibus converter */
> > > +             ret = regmap_read(info->regmap, MT6360_REG_PMUCHGCTRL3, &regval);
> > > +             if (ret)
> > > +                     return ret;
> > > +
> > > +             regval = (regval & MT6360_AICR_MASK) >> MT6360_AICR_SHFT;
> > > +             if (regval < MT6360_AICR_400MA)
> > > +                     sel_converter = &sp_ibus_adc_converter;
> > > +     }
> > > +
> > > +     *val = mt6360_adc_val_converter(*val, sel_converter->multiplier, sel_converter->offset,
> > > +                                     sel_converter->divisor);
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +static int mt6360_adc_read_processed(struct mt6360_adc_data *mad, int channel, int *val)
> > > +{
> > > +     u16 adc_enable;
> > > +     u8 rpt[3];
> > > +     ktime_t start_t, predict_end_t;
> > > +     long timeout;
> > > +     int value, ret;
> > > +
> > > +     mutex_lock(&mad->adc_lock);
> > > +
> > > +     /* select preferred channel that we want */
> > > +     ret = regmap_update_bits(mad->regmap, MT6360_REG_PMUADCRPT1, MT6360_PREFERCH_MASK,
> > > +                              channel << MT6360_PREFERCH_SHFT);
> > > +     if (ret)
> > > +             goto out_adc;
> > > +
> > > +     /* enable adc channel we want and adc_en */
> > > +     adc_enable = MT6360_ADCEN_MASK | BIT(channel);
> > > +     adc_enable = cpu_to_be16(adc_enable);  
> >
> > Use a local be16 to store that. It will make it a little clearer
> > that we are doing something 'unusual' here.  Perhaps a comment on
> > why this odd code exists would also help?
> >  
> 
> ACK
> 
> > > +     ret = regmap_raw_write(mad->regmap, MT6360_REG_PMUADCCFG, (void *)&adc_enable, sizeof(u16));
> > > +     if (ret)
> > > +             goto out_adc;
> > > +
> > > +     start_t = ktime_get();
> > > +     predict_end_t = ktime_add_ms(mad->last_off_timestamps[channel], 50);
> > > +
> > > +     if (ktime_after(start_t, predict_end_t))
> > > +             predict_end_t = ktime_add_ms(start_t, 25);
> > > +     else
> > > +             predict_end_t = ktime_add_ms(start_t, 75);
> > > +
> > > +     enable_irq(mad->irq);
> > > +adc_retry:
> > > +     reinit_completion(&mad->adc_complete);
> > > +
> > > +     /* wait for conversion to complete */
> > > +     timeout = wait_for_completion_timeout(&mad->adc_complete, msecs_to_jiffies(200));
> > > +     if (timeout == 0) {
> > > +             ret = -ETIMEDOUT;
> > > +             goto out_adc_conv;
> > > +     } else if (timeout < 0) {
> > > +             ret = -EINTR;
> > > +             goto out_adc_conv;
> > > +     }
> > > +
> > > +     ret = regmap_raw_read(mad->regmap, MT6360_REG_PMUADCRPT1, rpt, sizeof(rpt));
> > > +     if (ret)
> > > +             goto out_adc_conv;
> > > +
> > > +     /* check the current reported channel */
> > > +     if ((rpt[0] & MT6360_RPTCH_MASK) != channel) {
> > > +             dev_dbg(mad->dev, "not wanted channel report [%02x]\n", rpt[0]);  
> >
> > This and the one below feel like error messages rather than debug ones.
> >  
> 
> We have two function "battery zero current voltage(ZCV)" and "TypeC
> OTP" will auto run ADC at background.
> ZCV_EN will run VBAT_ADC when TA plug in, TypeC OTP will run TS_ADC
> when TypeC attach.
> We need to check report channel for ADC report data match is our desire channel.

So there is firmware messing with it underneath?  Oh goody.
Add a comment explaining this.

> 
> > > +             goto adc_retry;
> > > +     }
> > > +
> > > +     if (!ktime_after(ktime_get(), predict_end_t)) {
> > > +             dev_dbg(mad->dev, "time is not after one adc_conv_t\n");  
> >
> > Does this actually happen? If feels like we are being a bit over protective
> > here.  I'd definitely like to see a comment saying why this protection
> > might be needed.
> >  
> 
> When ADC_EN and MT6360_CHANx_EN is enable, the channel x will keep
> running again and again
> I supposed to get immediate data which is generated after I start it.

Just to check my understanding.

This is an edge triggered interrupt and it triggers every time a new sample
is taken.  Those samples are taken on a fixed frequency irrespective of whether
we have read the previous one?

> 
> When I disable ADC_CHANx_EN, the H/W logical ADC is still running.
> If I run the same ADC immediately, I may get the old result about this channel.
> MT6360 ADC typical conversation time is about 25ms.
> So We need ignore which irq trigger below 25ms.

Normal trick for this sort of case is to just not use the interrupt.
Just read after 25+delta msecs and you are guaranteed to get the right answer.


> 
> > > +             goto adc_retry;
> > > +     }
> > > +
> > > +     value = (rpt[1] << 8) | rpt[2];
> > > +
> > > +     ret = mt6360_adc_convert_processed_val(mad, channel, &value);
> > > +     if (ret)
> > > +             goto out_adc_conv;
> > > +
> > > +     *val = value;
> > > +     ret = IIO_VAL_INT;
> > > +
> > > +out_adc_conv:
> > > +     disable_irq(mad->irq);
> > > +     adc_enable = MT6360_ADCEN_MASK;
> > > +     adc_enable = cpu_to_be16(adc_enable);
> > > +     regmap_raw_write(mad->regmap, MT6360_REG_PMUADCCFG, (void *)&adc_enable, sizeof(u16));
> > > +     mad->last_off_timestamps[channel] = ktime_get();
> > > +     /* set prefer channel to 0xf */
> > > +     regmap_update_bits(mad->regmap, MT6360_REG_PMUADCRPT1, MT6360_PREFERCH_MASK,
> > > +                        0xF << MT6360_PREFERCH_SHFT);
> > > +out_adc:
> > > +     mutex_unlock(&mad->adc_lock);
> > > +
> > > +     return ret;
> > > +}
> > > +
> > > +static int mt6360_adc_read_raw(struct iio_dev *iio_dev, const struct iio_chan_spec *chan,
> > > +                            int *val, int *val2, long mask)
> > > +{
> > > +     struct mt6360_adc_data *mad = iio_priv(iio_dev);
> > > +
> > > +     if (mask == IIO_CHAN_INFO_PROCESSED)
> > > +             return mt6360_adc_read_processed(mad, chan->channel, val);
> > > +
> > > +     return -EINVAL;
> > > +}
> > > +
> > > +static const struct iio_info mt6360_adc_iio_info = {
> > > +     .read_raw = mt6360_adc_read_raw,
> > > +};
> > > +
> > > +#define MT6360_ADC_CHAN(_idx, _type) {                               \
> > > +     .type = _type,                                          \
> > > +     .channel = MT6360_CHAN_##_idx,                          \
> > > +     .scan_index = MT6360_CHAN_##_idx,                       \
> > > +     .extend_name = #_idx,                                   \
> > > +     .datasheet_name = #_idx,                                \
> > > +     .scan_type =  {                                         \
> > > +             .sign = 's',                                    \
> > > +             .realbits = 32,                                 \
> > > +             .storagebits = 32,                              \
> > > +             .endianness = IIO_CPU,                          \
> > > +     },                                                      \
> > > +     .info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),     \
> > > +     .indexed = 1,                                           \
> > > +}
> > > +
> > > +static const struct iio_chan_spec mt6360_adc_channels[] = {
> > > +     MT6360_ADC_CHAN(USBID, IIO_VOLTAGE),
> > > +     MT6360_ADC_CHAN(VBUSDIV5, IIO_VOLTAGE),
> > > +     MT6360_ADC_CHAN(VBUSDIV2, IIO_VOLTAGE),
> > > +     MT6360_ADC_CHAN(VSYS, IIO_VOLTAGE),
> > > +     MT6360_ADC_CHAN(VBAT, IIO_VOLTAGE),
> > > +     MT6360_ADC_CHAN(IBUS, IIO_CURRENT),
> > > +     MT6360_ADC_CHAN(IBAT, IIO_CURRENT),
> > > +     MT6360_ADC_CHAN(CHG_VDDP, IIO_VOLTAGE),
> > > +     MT6360_ADC_CHAN(TEMP_JC, IIO_TEMP),
> > > +     MT6360_ADC_CHAN(VREF_TS, IIO_VOLTAGE),
> > > +     MT6360_ADC_CHAN(TS, IIO_VOLTAGE),
> > > +     IIO_CHAN_SOFT_TIMESTAMP(MT6360_CHAN_MAX),
> > > +};
> > > +
> > > +static irqreturn_t mt6360_pmu_adc_donei_handler(int irq, void *data)
> > > +{
> > > +     struct mt6360_adc_data *mad = iio_priv(data);
> > > +
> > > +     complete(&mad->adc_complete);
> > > +     return IRQ_HANDLED;
> > > +}
> > > +  
> > ...
> >  
> > > +
> > > +static int mt6360_adc_probe(struct platform_device *pdev)
> > > +{
> > > +     struct mt6360_adc_data *mad;
> > > +     struct iio_dev *indio_dev;
> > > +     int ret;
> > > +
> > > +     indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*mad));
> > > +     if (!indio_dev)
> > > +             return -ENOMEM;
> > > +
> > > +     mad = iio_priv(indio_dev);
> > > +     mad->dev = &pdev->dev;
> > > +     init_completion(&mad->adc_complete);
> > > +     mutex_init(&mad->adc_lock);
> > > +
> > > +     mad->regmap = dev_get_regmap(pdev->dev.parent, NULL);
> > > +     if (!mad->regmap) {
> > > +             dev_err(&pdev->dev, "Failed to get parent regmap\n");
> > > +             return -ENODEV;
> > > +     }
> > > +
> > > +     ret = mt6360_adc_reset(mad);
> > > +     if (ret < 0) {
> > > +             dev_err(&pdev->dev, "Failed to reset adc\n");
> > > +             return ret;
> > > +     }
> > > +
> > > +     mad->irq = platform_get_irq_byname(pdev, "adc_donei");
> > > +     if (mad->irq < 0) {
> > > +             dev_err(&pdev->dev, "Failed to get adc_done irq\n");
> > > +             return mad->irq;
> > > +     }
> > > +
> > > +     irq_set_status_flags(mad->irq, IRQ_NOAUTOEN);  
> >
> > As we are going to have a v5 anyway to clean up that endian warning,
> > please could you add a comment to explain the need for IRQ_NOAUTOEN?
> >  
> 
> Same as above "Enable ADC will run again and again until clear
> ADC__CHANx_EN bit"
> So After I get the ADC result, I disable irq in order to handle only
> oneshot data.

As mentioned a above I suspect you may be better off just not using
the interrupt at all.

> 
> > > +     ret = devm_request_threaded_irq(&pdev->dev, mad->irq, NULL, mt6360_pmu_adc_donei_handler, 0,
> > > +                                     "adc_donei", indio_dev);
> > > +     if (ret) {
> > > +             dev_err(&pdev->dev, "Failed to register adc_done irq\n");
> > > +             return ret;
> > > +     }
> > > +
> > > +     indio_dev->name = dev_name(&pdev->dev);
> > > +     indio_dev->dev.parent = &pdev->dev;
> > > +     indio_dev->info = &mt6360_adc_iio_info;
> > > +     indio_dev->modes = INDIO_DIRECT_MODE;
> > > +     indio_dev->channels = mt6360_adc_channels;
> > > +     indio_dev->num_channels = ARRAY_SIZE(mt6360_adc_channels);
> > > +
> > > +     ret = devm_iio_triggered_buffer_setup(&pdev->dev, indio_dev, NULL,
> > > +                                           mt6360_adc_trigger_handler, NULL);
> > > +     if (ret) {
> > > +             dev_err(&pdev->dev, "Failed to allocate iio trigger buffer\n");
> > > +             return ret;
> > > +     }
> > > +
> > > +     ret = devm_iio_device_register(&pdev->dev, indio_dev);
> > > +     if (ret) {
> > > +             dev_err(&pdev->dev, "Failed to register iio device\n");
> > > +             return ret;
> > > +     }
> > > +
> > > +     return 0;
> > > +}  
> > ...  


