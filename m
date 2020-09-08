Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D20626107D
	for <lists+linux-iio@lfdr.de>; Tue,  8 Sep 2020 13:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729622AbgIHLIw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 8 Sep 2020 07:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729529AbgIHLIc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 8 Sep 2020 07:08:32 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE887C0613ED;
        Tue,  8 Sep 2020 04:08:31 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id p13so14977643ils.3;
        Tue, 08 Sep 2020 04:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DrE8JwhxXl7iuIhJqfj0qZd6Etw7Fu6kMTCwUjCso8c=;
        b=kYSalV8/Cc/bu5TfII2BE2CSs5RKyQBAb2lp+oxwzCrl8mQ5ra/dO5SXIABgvrWnbE
         NF3sc4hby/abPicYC9H6zdOf88ava438UMyI6JoDwAbVqqDKL8UUZ2SMFtlWZODqEU2G
         lvwvfeRWr+oM8xrRClrNIJHFtmb7Jq2kK7yAaq/awHiTz7IcUKw14Fnsvd3AeG7A5rPX
         mVGYPdlRP7XwK5Qovy+wS2EVFDLviCrrs7ZoA547V3f/+ZCwAYzk/eckLCIGDSGe7mID
         igx4A/fsSETx9z5lAIR0czJ12Enle2oJAzIOOLomu5Ukv2IDbH/3EwlJQUTUDOn+FvzH
         CDEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DrE8JwhxXl7iuIhJqfj0qZd6Etw7Fu6kMTCwUjCso8c=;
        b=D5llL9jMYRVcS418Ll67eP2rqm9VsKffmFV+OmTlcH7Cr2qRynF8Ytq5YA6xKo9531
         BDiIGHBlnNUZMVcikpt3r/LrPXjZR7AezsiOPWBoarl6E/u0R7s1RdRdo4absrRwMUJV
         JkAhqXvaOnwU2y0PAd7tO/QQLsnBB2HBbrFl0r9ypgsUlNHCqcuFc0qAwCNXGb+kbEER
         FuD4t2GWaYXSIHIciuvorFR7NFPkBllRKDPfe4DS/nK9kWQE8DxvJIgb8fG0lYiGqOy9
         dcseZ0505+sOhwgJny+Zb6z7n406pGzlt82WPxpE+o/YUWMUbGuQaHAkWK9JNUN+ZEna
         QTcw==
X-Gm-Message-State: AOAM533Rp0b0SIus8SzG+CRbXS9VbWahz8bCknpQK32TwfvxjkSwNCby
        pRKxEskQ56cgGjBlqQAHDUKX+3mUWUxMBwXyHUs=
X-Google-Smtp-Source: ABdhPJwf84Q87W+wWpNg9tZf/nLeWoqNiAaFo1+GMxUqvfxwsrvzwRdinzVsbS1guDUUiZQbPeJFtgL1no1+0qyVnDY=
X-Received: by 2002:a92:d188:: with SMTP id z8mr14924702ilz.292.1599563310928;
 Tue, 08 Sep 2020 04:08:30 -0700 (PDT)
MIME-Version: 1.0
References: <1598259985-12517-1-git-send-email-gene.chen.richtek@gmail.com>
 <1598259985-12517-2-git-send-email-gene.chen.richtek@gmail.com>
 <20200829181157.1b653a88@archlinux> <CAE+NS36j4a6k-JSUbjxzpfbqtE-xMW7qxUUhHPAnc_9V-Lv7LQ@mail.gmail.com>
 <20200908100712.00007a7b@Huawei.com>
In-Reply-To: <20200908100712.00007a7b@Huawei.com>
From:   Gene Chen <gene.chen.richtek@gmail.com>
Date:   Tue, 8 Sep 2020 19:08:20 +0800
Message-ID: <CAE+NS35aQ3k2auYA+bmf6kMhm192oyg8_j5j=zzK0sn_NS6HoA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] iio: adc: mt6360: Add ADC driver for MT6360
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Gene Chen <gene_chen@richtek.com>, Wilma.Wu@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com,
        benjamin.chao@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Jonathan Cameron <Jonathan.Cameron@huawei.com> =E6=96=BC 2020=E5=B9=B49=E6=
=9C=888=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=885:08=E5=AF=AB=E9=81=
=93=EF=BC=9A
>
> On Tue, 8 Sep 2020 14:17:42 +0800
> Gene Chen <gene.chen.richtek@gmail.com> wrote:
>
> > Jonathan Cameron <jic23@kernel.org> =E6=96=BC 2020=E5=B9=B48=E6=9C=8830=
=E6=97=A5 =E9=80=B1=E6=97=A5 =E4=B8=8A=E5=8D=881:12=E5=AF=AB=E9=81=93=EF=BC=
=9A
> > >
> > > On Mon, 24 Aug 2020 17:06:24 +0800
> > > Gene Chen <gene.chen.richtek@gmail.com> wrote:
> > >
> > > > From: Gene Chen <gene_chen@richtek.com>
> > > >
> > > > Add MT6360 ADC driver include Charger Current, Voltage, and
> > > > Temperature.
> > > >
> > > > Signed-off-by: Gene Chen <gene_chen@richtek.com>
> > > Hi Gene,
> > >
> > > A few comments inline.  The big one centres on why we can't
> > > expose the channels as _raw, _offset and _scale?
> > >
> >
> > I think i have 3 reason for use real value,
> > ADC is used to get real value rather than raw data which is not meaning=
ful.
> > And I can decide which formula needs apply according to different condi=
tion.
> > Also the junction temperature channel _scale is floating point 1.05
> > which is not easy to express.
>
> See below.
>
> >
> > > Thanks,
> > >
> > > Jonathan
> > >
> > > > ---
> > > >  drivers/iio/adc/Kconfig      |  11 ++
> > > >  drivers/iio/adc/Makefile     |   1 +
> > > >  drivers/iio/adc/mt6360-adc.c | 366 +++++++++++++++++++++++++++++++=
++++++++++++
> > > >  3 files changed, 378 insertions(+)
> > > >  create mode 100644 drivers/iio/adc/mt6360-adc.c
> > > >
> > > > diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> > > > index 66d9cc0..07dcea7 100644
> > > > --- a/drivers/iio/adc/Kconfig
> > > > +++ b/drivers/iio/adc/Kconfig
> > > > @@ -703,6 +703,17 @@ config MCP3911
> > > >         This driver can also be built as a module. If so, the modul=
e will be
> > > >         called mcp3911.
> > > >
> > > > +config MEDIATEK_MT6360_ADC
> > > > +     tristate "Mediatek MT6360 ADC Part"
> > > > +     depends on MFD_MT6360
> > > > +     select IIO_BUFFER
> > > > +     select IIO_TRIGGERED_BUFFER
> > > > +     help
> > > > +       Say Y here to enable MT6360 ADC Part.
> > > > +       Integrated for System Monitoring include
> > > > +       Charger and Battery Current, Voltage and
> > > > +       Temperature
> > > > +
> > > >  config MEDIATEK_MT6577_AUXADC
> > > >       tristate "MediaTek AUXADC driver"
> > > >       depends on ARCH_MEDIATEK || COMPILE_TEST
> > > > diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> > > > index 90f94ad..5fca90a 100644
> > > > --- a/drivers/iio/adc/Makefile
> > > > +++ b/drivers/iio/adc/Makefile
> > > > @@ -65,6 +65,7 @@ obj-$(CONFIG_MAX9611) +=3D max9611.o
> > > >  obj-$(CONFIG_MCP320X) +=3D mcp320x.o
> > > >  obj-$(CONFIG_MCP3422) +=3D mcp3422.o
> > > >  obj-$(CONFIG_MCP3911) +=3D mcp3911.o
> > > > +obj-$(CONFIG_MEDIATEK_MT6360_ADC) +=3D mt6360-adc.o
> > > >  obj-$(CONFIG_MEDIATEK_MT6577_AUXADC) +=3D mt6577_auxadc.o
> > > >  obj-$(CONFIG_MEN_Z188_ADC) +=3D men_z188_adc.o
> > > >  obj-$(CONFIG_MESON_SARADC) +=3D meson_saradc.o
> > > > diff --git a/drivers/iio/adc/mt6360-adc.c b/drivers/iio/adc/mt6360-=
adc.c
> > > > new file mode 100644
> > > > index 0000000..5eed812
> > > > --- /dev/null
> > > > +++ b/drivers/iio/adc/mt6360-adc.c
> > > > @@ -0,0 +1,366 @@
> > > > +// SPDX-License-Identifier: GPL-2.0
> > > > +/*
> > > > + * Copyright (c) 2020 MediaTek Inc.
> > > > + *
> > > > + * Author: Gene Chen <gene_chen@richtek.com>
> > > > + */
> > > > +
> > > > +#include <linux/completion.h>
> > > > +#include <linux/interrupt.h>
> > > > +#include <linux/iio/buffer.h>
> > > > +#include <linux/iio/iio.h>
> > > > +#include <linux/iio/trigger_consumer.h>
> > > > +#include <linux/iio/triggered_buffer.h>
> > > > +#include <linux/irq.h>
> > > > +#include <linux/kernel.h>
> > > > +#include <linux/ktime.h>
> > > > +#include <linux/module.h>
> > > > +#include <linux/mutex.h>
> > > > +#include <linux/platform_device.h>
> > > > +#include <linux/regmap.h>
> > > > +
> > > > +#define MT6360_REG_PMUCHGCTRL3       0x313
> > > > +#define MT6360_REG_PMUADCCFG 0x356
> > > > +#define MT6360_REG_PMUADCRPT1        0x35A
> > > > +
> > > > +/* PMUCHGCTRL3 0x313 */
> > > > +#define MT6360_AICR_MASK     0xFC
> > > > +#define MT6360_AICR_SHFT     2
> > > > +#define MT6360_AICR_400MA    0x6
> > > > +/* PMUADCCFG 0x356 */
> > > > +#define MT6360_ADCEN_MASK    0x8000
> > > > +/* PMUADCRPT1 0x35A */
> > > > +#define MT6360_PREFERCH_MASK 0xF0
> > > > +#define MT6360_PREFERCH_SHFT 4
> > > > +#define MT6360_RPTCH_MASK    0x0F
> > > > +
> > > > +enum {
> > > > +     MT6360_CHAN_USBID =3D 0,
> > > > +     MT6360_CHAN_VBUSDIV5,
> > > > +     MT6360_CHAN_VBUSDIV2,
> > > > +     MT6360_CHAN_VSYS,
> > > > +     MT6360_CHAN_VBAT,
> > > > +     MT6360_CHAN_IBUS,
> > > > +     MT6360_CHAN_IBAT,
> > > > +     MT6360_CHAN_CHG_VDDP,
> > > > +     MT6360_CHAN_TEMP_JC,
> > > > +     MT6360_CHAN_VREF_TS,
> > > > +     MT6360_CHAN_TS,
> > > > +     MT6360_CHAN_MAX,
> > > > +};
> > > > +
> > > > +struct mt6360_adc_data {
> > > > +     struct device *dev;
> > > > +     struct regmap *regmap;
> > > > +     struct completion adc_complete;
> > > > +     struct mutex adc_lock;
> > > > +     ktime_t last_off_timestamps[MT6360_CHAN_MAX];
> > > > +     int irq;
> > > > +};
> > > > +
> > > > +static inline int mt6360_adc_val_converter(int val, int multiplier=
, int offset, int divisor)
> > > > +{
> > > > +     return ((val * multiplier) + offset) / divisor;
> > >
> > > Why could we not report these values to userspace or consumer drivers=
 and let
> > > them deal with the conversion if they actually needed it?
> > > Mapping this to
> > >
> > > (val + new_offset) * multiplier would be a little messy, but not too =
bad.
> > >
> > > The advantage would be that we would then be providing the data neede=
d
> > > to get real units for values read from the buffers without having to
> > > do all the maths in kernel (without access to floating point).
> > >
> > >
> >
> > As above, if I use formula "(val + new_offset) * multiplier",
> > the junction temperature channel multiplier will be floating point
> > 1.05, i don't know how to express.
>
> As Andy mentioned, we do this all over the place.
> IIO_VAL_INT_PLUS_MICRO
>
> The key is that we want to push the burden of doing this maths to the use=
r
> not the source.

ACK.
Can I keep IIO_CHAN_INFO_PROCESSED function be reserved for user in
kernel space?

>
> Often what is actually of interest is whether a temperature passed a thre=
shold.
> In that case, you can transform the threshold into the units of the ADC (=
so the
> reverse directly to you would do with processed data) and only have to do=
 the
> maths once per change of the threshold instead of for every sample.
>
> There are helper functions to do the maths for you, should you actually
> need SI units.
>

ACK

> >
> > > > +}
> > > > +
> > > > +static int mt6360_adc_convert_processed_val(struct mt6360_adc_data=
 *info, int chan_idx, int *val)
> > > > +{
> > > > +     unsigned int regval =3D 0;
> > > > +     const struct converter {
> > > > +             int multiplier;
> > > > +             int offset;
> > > > +             int divisor;
> > > > +     } adc_converter[MT6360_CHAN_MAX] =3D {
> > > > +             { 1250, 0, 1}, /* USBID */
> > > > +             { 6250, 0, 1}, /* VBUSDIV5 */
> > > > +             { 2500, 0, 1}, /* VBUSDIV2 */
> > > > +             { 1250, 0, 1}, /* VSYS */
> > > > +             { 1250, 0, 1}, /* VBAT */
> > > > +             { 2500, 0, 1}, /* IBUS */
> > > > +             { 2500, 0, 1}, /* IBAT */
> > > > +             { 1250, 0, 1}, /* CHG_VDDP */
> > > > +             { 105, -8000, 100}, /* TEMP_JC */
> > > > +             { 1250, 0, 1}, /* VREF_TS */
> > > > +             { 1250, 0, 1}, /* TS */
> > > > +     }, sp_ibus_adc_converter =3D { 1900, 0, 1 }, *sel_converter;
> > > > +     int ret;
> > > > +
> > > > +     sel_converter =3D adc_converter + chan_idx;
> > > > +     if (chan_idx =3D=3D MT6360_CHAN_IBUS) {
> > > > +             /* ibus chan will be affected by aicr config */
> > > > +             /* if aicr < 400, apply the special ibus converter */
> > > > +             ret =3D regmap_read(info->regmap, MT6360_REG_PMUCHGCT=
RL3, &regval);
> > > > +             if (ret)
> > > > +                     return ret;
> > > > +
> > > > +             regval =3D (regval & MT6360_AICR_MASK) >> MT6360_AICR=
_SHFT;
> > > > +             if (regval < MT6360_AICR_400MA)
> > > > +                     sel_converter =3D &sp_ibus_adc_converter;
> > > > +     }
> > > > +
> > > > +     *val =3D mt6360_adc_val_converter(*val, sel_converter->multip=
lier, sel_converter->offset,
> > > > +                                     sel_converter->divisor);
> > > > +
> > > > +     return 0;
> > > > +}
> > > > +
> > > > +static int mt6360_adc_read_processed(struct mt6360_adc_data *mad, =
int channel, int *val)
> > > > +{
> > > > +     u16 adc_enable;
> > > > +     u8 rpt[3];
> > > > +     ktime_t start_t, predict_end_t;
> > > > +     long timeout;
> > > > +     int value, ret;
> > > > +
> > > > +     mutex_lock(&mad->adc_lock);
> > > > +
> > > > +     /* select preferred channel that we want */
> > > > +     ret =3D regmap_update_bits(mad->regmap, MT6360_REG_PMUADCRPT1=
, MT6360_PREFERCH_MASK,
> > > > +                              channel << MT6360_PREFERCH_SHFT);
> > > > +     if (ret)
> > > > +             goto out_adc;
> > > > +
> > > > +     /* enable adc channel we want and adc_en */
> > > > +     adc_enable =3D MT6360_ADCEN_MASK | BIT(channel);
> > > > +     adc_enable =3D cpu_to_be16(adc_enable);
> > >
> > > Use a local be16 to store that. It will make it a little clearer
> > > that we are doing something 'unusual' here.  Perhaps a comment on
> > > why this odd code exists would also help?
> > >
> >
> > ACK
> >
> > > > +     ret =3D regmap_raw_write(mad->regmap, MT6360_REG_PMUADCCFG, (=
void *)&adc_enable, sizeof(u16));
> > > > +     if (ret)
> > > > +             goto out_adc;
> > > > +
> > > > +     start_t =3D ktime_get();
> > > > +     predict_end_t =3D ktime_add_ms(mad->last_off_timestamps[chann=
el], 50);
> > > > +
> > > > +     if (ktime_after(start_t, predict_end_t))
> > > > +             predict_end_t =3D ktime_add_ms(start_t, 25);
> > > > +     else
> > > > +             predict_end_t =3D ktime_add_ms(start_t, 75);
> > > > +
> > > > +     enable_irq(mad->irq);
> > > > +adc_retry:
> > > > +     reinit_completion(&mad->adc_complete);
> > > > +
> > > > +     /* wait for conversion to complete */
> > > > +     timeout =3D wait_for_completion_timeout(&mad->adc_complete, m=
secs_to_jiffies(200));
> > > > +     if (timeout =3D=3D 0) {
> > > > +             ret =3D -ETIMEDOUT;
> > > > +             goto out_adc_conv;
> > > > +     } else if (timeout < 0) {
> > > > +             ret =3D -EINTR;
> > > > +             goto out_adc_conv;
> > > > +     }
> > > > +
> > > > +     ret =3D regmap_raw_read(mad->regmap, MT6360_REG_PMUADCRPT1, r=
pt, sizeof(rpt));
> > > > +     if (ret)
> > > > +             goto out_adc_conv;
> > > > +
> > > > +     /* check the current reported channel */
> > > > +     if ((rpt[0] & MT6360_RPTCH_MASK) !=3D channel) {
> > > > +             dev_dbg(mad->dev, "not wanted channel report [%02x]\n=
", rpt[0]);
> > >
> > > This and the one below feel like error messages rather than debug one=
s.
> > >
> >
> > We have two function "battery zero current voltage(ZCV)" and "TypeC
> > OTP" will auto run ADC at background.
> > ZCV_EN will run VBAT_ADC when TA plug in, TypeC OTP will run TS_ADC
> > when TypeC attach.
> > We need to check report channel for ADC report data match is our desire=
 channel.
>
> So there is firmware messing with it underneath?  Oh goody.
> Add a comment explaining this.
>

ACK, I try to write a comment as below

        /*
         * There are two functions, ZCV and TypeC OTP, running ADC
VBAT and TS in background,
         * and ADC samples are taken on a fixed frequency no matter
read the previous one or not.
         * To avoid conflict need set minimum time threshold after
enable ADC and check report
         * channel is the same.
         * The worst case is run the same ADC twice and background
function is also running,
         * ADC conversion sequence is desire channel before start ADC,
background ADC, desire
         * channel after start ADC. So the minimum correct data is
three times of typical
         * conversion time.
         */

> >
> > > > +             goto adc_retry;
> > > > +     }
> > > > +
> > > > +     if (!ktime_after(ktime_get(), predict_end_t)) {
> > > > +             dev_dbg(mad->dev, "time is not after one adc_conv_t\n=
");
> > >
> > > Does this actually happen? If feels like we are being a bit over prot=
ective
> > > here.  I'd definitely like to see a comment saying why this protectio=
n
> > > might be needed.
> > >
> >
> > When ADC_EN and MT6360_CHANx_EN is enable, the channel x will keep
> > running again and again
> > I supposed to get immediate data which is generated after I start it.
>
> Just to check my understanding.
>
> This is an edge triggered interrupt and it triggers every time a new samp=
le
> is taken.  Those samples are taken on a fixed frequency irrespective of w=
hether
> we have read the previous one?
>

Yes.
I use LEVEL_LOW trigger in latest review MFD patch.

> >
> > When I disable ADC_CHANx_EN, the H/W logical ADC is still running.
> > If I run the same ADC immediately, I may get the old result about this =
channel.
> > MT6360 ADC typical conversation time is about 25ms.
> > So We need ignore which irq trigger below 25ms.
>
> Normal trick for this sort of case is to just not use the interrupt.
> Just read after 25+delta msecs and you are guaranteed to get the right an=
swer.
>
>

ACK, I will try to use polling
Is the pseudocode correct?

mdelay(predict_end_t);
while (true) {
    read adc event is occured
    check report channel is the same
    if the same, read report ADC data and break while loop
    else msleep(per ADC conversion time)
}

> >
> > > > +             goto adc_retry;
> > > > +     }
> > > > +
> > > > +     value =3D (rpt[1] << 8) | rpt[2];
> > > > +
> > > > +     ret =3D mt6360_adc_convert_processed_val(mad, channel, &value=
);
> > > > +     if (ret)
> > > > +             goto out_adc_conv;
> > > > +
> > > > +     *val =3D value;
> > > > +     ret =3D IIO_VAL_INT;
> > > > +
> > > > +out_adc_conv:
> > > > +     disable_irq(mad->irq);
> > > > +     adc_enable =3D MT6360_ADCEN_MASK;
> > > > +     adc_enable =3D cpu_to_be16(adc_enable);
> > > > +     regmap_raw_write(mad->regmap, MT6360_REG_PMUADCCFG, (void *)&=
adc_enable, sizeof(u16));
> > > > +     mad->last_off_timestamps[channel] =3D ktime_get();
> > > > +     /* set prefer channel to 0xf */
> > > > +     regmap_update_bits(mad->regmap, MT6360_REG_PMUADCRPT1, MT6360=
_PREFERCH_MASK,
> > > > +                        0xF << MT6360_PREFERCH_SHFT);
> > > > +out_adc:
> > > > +     mutex_unlock(&mad->adc_lock);
> > > > +
> > > > +     return ret;
> > > > +}
> > > > +
> > > > +static int mt6360_adc_read_raw(struct iio_dev *iio_dev, const stru=
ct iio_chan_spec *chan,
> > > > +                            int *val, int *val2, long mask)
> > > > +{
> > > > +     struct mt6360_adc_data *mad =3D iio_priv(iio_dev);
> > > > +
> > > > +     if (mask =3D=3D IIO_CHAN_INFO_PROCESSED)
> > > > +             return mt6360_adc_read_processed(mad, chan->channel, =
val);
> > > > +
> > > > +     return -EINVAL;
> > > > +}
> > > > +
> > > > +static const struct iio_info mt6360_adc_iio_info =3D {
> > > > +     .read_raw =3D mt6360_adc_read_raw,
> > > > +};
> > > > +
> > > > +#define MT6360_ADC_CHAN(_idx, _type) {                            =
   \
> > > > +     .type =3D _type,                                          \
> > > > +     .channel =3D MT6360_CHAN_##_idx,                          \
> > > > +     .scan_index =3D MT6360_CHAN_##_idx,                       \
> > > > +     .extend_name =3D #_idx,                                   \
> > > > +     .datasheet_name =3D #_idx,                                \
> > > > +     .scan_type =3D  {                                         \
> > > > +             .sign =3D 's',                                    \
> > > > +             .realbits =3D 32,                                 \
> > > > +             .storagebits =3D 32,                              \
> > > > +             .endianness =3D IIO_CPU,                          \
> > > > +     },                                                      \
> > > > +     .info_mask_separate =3D BIT(IIO_CHAN_INFO_PROCESSED),     \
> > > > +     .indexed =3D 1,                                           \
> > > > +}
> > > > +
> > > > +static const struct iio_chan_spec mt6360_adc_channels[] =3D {
> > > > +     MT6360_ADC_CHAN(USBID, IIO_VOLTAGE),
> > > > +     MT6360_ADC_CHAN(VBUSDIV5, IIO_VOLTAGE),
> > > > +     MT6360_ADC_CHAN(VBUSDIV2, IIO_VOLTAGE),
> > > > +     MT6360_ADC_CHAN(VSYS, IIO_VOLTAGE),
> > > > +     MT6360_ADC_CHAN(VBAT, IIO_VOLTAGE),
> > > > +     MT6360_ADC_CHAN(IBUS, IIO_CURRENT),
> > > > +     MT6360_ADC_CHAN(IBAT, IIO_CURRENT),
> > > > +     MT6360_ADC_CHAN(CHG_VDDP, IIO_VOLTAGE),
> > > > +     MT6360_ADC_CHAN(TEMP_JC, IIO_TEMP),
> > > > +     MT6360_ADC_CHAN(VREF_TS, IIO_VOLTAGE),
> > > > +     MT6360_ADC_CHAN(TS, IIO_VOLTAGE),
> > > > +     IIO_CHAN_SOFT_TIMESTAMP(MT6360_CHAN_MAX),
> > > > +};
> > > > +
> > > > +static irqreturn_t mt6360_pmu_adc_donei_handler(int irq, void *dat=
a)
> > > > +{
> > > > +     struct mt6360_adc_data *mad =3D iio_priv(data);
> > > > +
> > > > +     complete(&mad->adc_complete);
> > > > +     return IRQ_HANDLED;
> > > > +}
> > > > +
> > > ...
> > >
> > > > +
> > > > +static int mt6360_adc_probe(struct platform_device *pdev)
> > > > +{
> > > > +     struct mt6360_adc_data *mad;
> > > > +     struct iio_dev *indio_dev;
> > > > +     int ret;
> > > > +
> > > > +     indio_dev =3D devm_iio_device_alloc(&pdev->dev, sizeof(*mad))=
;
> > > > +     if (!indio_dev)
> > > > +             return -ENOMEM;
> > > > +
> > > > +     mad =3D iio_priv(indio_dev);
> > > > +     mad->dev =3D &pdev->dev;
> > > > +     init_completion(&mad->adc_complete);
> > > > +     mutex_init(&mad->adc_lock);
> > > > +
> > > > +     mad->regmap =3D dev_get_regmap(pdev->dev.parent, NULL);
> > > > +     if (!mad->regmap) {
> > > > +             dev_err(&pdev->dev, "Failed to get parent regmap\n");
> > > > +             return -ENODEV;
> > > > +     }
> > > > +
> > > > +     ret =3D mt6360_adc_reset(mad);
> > > > +     if (ret < 0) {
> > > > +             dev_err(&pdev->dev, "Failed to reset adc\n");
> > > > +             return ret;
> > > > +     }
> > > > +
> > > > +     mad->irq =3D platform_get_irq_byname(pdev, "adc_donei");
> > > > +     if (mad->irq < 0) {
> > > > +             dev_err(&pdev->dev, "Failed to get adc_done irq\n");
> > > > +             return mad->irq;
> > > > +     }
> > > > +
> > > > +     irq_set_status_flags(mad->irq, IRQ_NOAUTOEN);
> > >
> > > As we are going to have a v5 anyway to clean up that endian warning,
> > > please could you add a comment to explain the need for IRQ_NOAUTOEN?
> > >
> >
> > Same as above "Enable ADC will run again and again until clear
> > ADC__CHANx_EN bit"
> > So After I get the ADC result, I disable irq in order to handle only
> > oneshot data.
>
> As mentioned a above I suspect you may be better off just not using
> the interrupt at all.
>

ACK, I try to fixed by polling ADC event.

> >
> > > > +     ret =3D devm_request_threaded_irq(&pdev->dev, mad->irq, NULL,=
 mt6360_pmu_adc_donei_handler, 0,
> > > > +                                     "adc_donei", indio_dev);
> > > > +     if (ret) {
> > > > +             dev_err(&pdev->dev, "Failed to register adc_done irq\=
n");
> > > > +             return ret;
> > > > +     }
> > > > +
> > > > +     indio_dev->name =3D dev_name(&pdev->dev);
> > > > +     indio_dev->dev.parent =3D &pdev->dev;
> > > > +     indio_dev->info =3D &mt6360_adc_iio_info;
> > > > +     indio_dev->modes =3D INDIO_DIRECT_MODE;
> > > > +     indio_dev->channels =3D mt6360_adc_channels;
> > > > +     indio_dev->num_channels =3D ARRAY_SIZE(mt6360_adc_channels);
> > > > +
> > > > +     ret =3D devm_iio_triggered_buffer_setup(&pdev->dev, indio_dev=
, NULL,
> > > > +                                           mt6360_adc_trigger_hand=
ler, NULL);
> > > > +     if (ret) {
> > > > +             dev_err(&pdev->dev, "Failed to allocate iio trigger b=
uffer\n");
> > > > +             return ret;
> > > > +     }
> > > > +
> > > > +     ret =3D devm_iio_device_register(&pdev->dev, indio_dev);
> > > > +     if (ret) {
> > > > +             dev_err(&pdev->dev, "Failed to register iio device\n"=
);
> > > > +             return ret;
> > > > +     }
> > > > +
> > > > +     return 0;
> > > > +}
> > > ...
>
>
