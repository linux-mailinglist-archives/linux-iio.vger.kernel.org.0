Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC58526403E
	for <lists+linux-iio@lfdr.de>; Thu, 10 Sep 2020 10:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbgIJIlA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Sep 2020 04:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729521AbgIJIOk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 10 Sep 2020 04:14:40 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43EAAC061573;
        Thu, 10 Sep 2020 01:14:27 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id b6so6111434iof.6;
        Thu, 10 Sep 2020 01:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4W7KaGDy6RWjlD6SLW/CX4e+SHKTLtZg4h+gGuaptAo=;
        b=fY5I3g4S01h5L9qzdVcjRopodFGALWmB26f88OXHjC9D7PL/qPcuJkdtGOmNlyBySG
         R76C/KJt6dK5iwYnD+UkkC61pNR0Ib9pBEiONr09zxmLxvaX4If+04UmGUl5TyH6iYbG
         XrAQY1uWSvnuy/KVfaG89LRXhTojivLssoB3Cpw1pGjPBHSyXeYyC7xNZgBpJuBlwk7k
         TK2fN4oAWG5ZBj4/XoamcJNoesauGAtTTpHrOes8maBK+dY4E4h9Fn0cGuOJ+4Jnc2T/
         jx8ffOlVAACEiFwUDa6OCIaKYaaUev1Br//mrtzoIC49xlviW9MJk0Q9wtUi2QYu/8h1
         +rfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4W7KaGDy6RWjlD6SLW/CX4e+SHKTLtZg4h+gGuaptAo=;
        b=iSsCuP7cyopvxo5q5DEuPgZqImXcUjYqvAG/Wkp/lLeT6ObbwKjWO3XljWv54OHFcI
         h///097B/Ey2kHN5HGlP9t9wN6aCPLW88/yzF8g3ZRdxl3Z9+mFLlCOLHnbkAl6Be4xs
         qm2+A7GfoBsOOzBodP58zvQwPAJxRWFqZxS9FZVKC7qrMWuBxXHVscj1IVCApJaqx507
         E91S7Ty/F8mJzoqQBwWhNLJIbGIc1LBtUT545msadcfuKQ5MBdBo7X4tT1oGFYscqPtO
         3gRcKBFwmQig0+KOzsCSnWeReEZzeBhozCdcei/ISssDHiTWYu1duBcDj3b1EtqMohCN
         oUPQ==
X-Gm-Message-State: AOAM533QJxee+F4huC5j6PkAM1cknBGBS9XP0nDvkiARyJ4VCa9mTcjM
        1NjvalJPGb26pTpIziWLjXuwpyyyhdKx2t+iBgA=
X-Google-Smtp-Source: ABdhPJzORbDVrgbo02weP0KrqMKHyMK0xAZQc7+2pVlPCFuOiIkSD3zYL/NzVCiPismNPn2qSwB9M2By3Sy7US0ZdEE=
X-Received: by 2002:a02:cdc5:: with SMTP id m5mr7503412jap.15.1599725666490;
 Thu, 10 Sep 2020 01:14:26 -0700 (PDT)
MIME-Version: 1.0
References: <1598259985-12517-1-git-send-email-gene.chen.richtek@gmail.com>
 <1598259985-12517-2-git-send-email-gene.chen.richtek@gmail.com>
 <20200829181157.1b653a88@archlinux> <CAE+NS36j4a6k-JSUbjxzpfbqtE-xMW7qxUUhHPAnc_9V-Lv7LQ@mail.gmail.com>
 <20200908100712.00007a7b@Huawei.com> <CAE+NS35aQ3k2auYA+bmf6kMhm192oyg8_j5j=zzK0sn_NS6HoA@mail.gmail.com>
 <20200908135830.00007b13@Huawei.com> <CAE+NS35ucEjeewBRaW7ha1pcisz-VQBK8VJgK_DdB5vWy7Q53Q@mail.gmail.com>
In-Reply-To: <CAE+NS35ucEjeewBRaW7ha1pcisz-VQBK8VJgK_DdB5vWy7Q53Q@mail.gmail.com>
From:   Gene Chen <gene.chen.richtek@gmail.com>
Date:   Thu, 10 Sep 2020 08:14:15 +0800
Message-ID: <CAE+NS36S2c3zbVR8xPqGuO7ofZMpOfmzA48-FSsu1rPV3maUAQ@mail.gmail.com>
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

Gene Chen <gene.chen.richtek@gmail.com> =E6=96=BC 2020=E5=B9=B49=E6=9C=889=
=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8A=E5=8D=887:39=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> Jonathan Cameron <Jonathan.Cameron@huawei.com> =E6=96=BC 2020=E5=B9=B49=
=E6=9C=888=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=889:00=E5=AF=AB=E9=
=81=93=EF=BC=9A
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
> > > > > > > +     MT6360_CHAN_USBID =3D 0,
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
> > > > > > > +static inline int mt6360_adc_val_converter(int val, int mult=
iplier, int offset, int divisor)
> > > > > > > +{
> > > > > > > +     return ((val * multiplier) + offset) / divisor;
> > > > > >
> > > > > > Why could we not report these values to userspace or consumer d=
rivers and let
> > > > > > them deal with the conversion if they actually needed it?
> > > > > > Mapping this to
> > > > > >
> > > > > > (val + new_offset) * multiplier would be a little messy, but no=
t too bad.
> > > > > >
> > > > > > The advantage would be that we would then be providing the data=
 needed
> > > > > > to get real units for values read from the buffers without havi=
ng to
> > > > > > do all the maths in kernel (without access to floating point).
> > > > > >
> > > > > >
> > > > >
> > > > > As above, if I use formula "(val + new_offset) * multiplier",
> > > > > the junction temperature channel multiplier will be floating poin=
t
> > > > > 1.05, i don't know how to express.
> > > >
> > > > As Andy mentioned, we do this all over the place.
> > > > IIO_VAL_INT_PLUS_MICRO
> > > >
> > > > The key is that we want to push the burden of doing this maths to t=
he user
> > > > not the source.
> > >
> > > ACK.
> > > Can I keep IIO_CHAN_INFO_PROCESSED function be reserved for user in
> > > kernel space?
> > >
> >
> > No. We have utility functions that will apply the multiplier as needed =
so
> > there is no significant advantage in doing this and it won't be consist=
ent
> > with the majority of other drivers.
> >
>
> ACK, I will remove IIO_CHAN_INFO_PROCESSED.
>
> > > >
> > > > Often what is actually of interest is whether a temperature passed =
a threshold.
> > > > In that case, you can transform the threshold into the units of the=
 ADC (so the
> > > > reverse directly to you would do with processed data) and only have=
 to do the
> > > > maths once per change of the threshold instead of for every sample.
> > > >
> > > > There are helper functions to do the maths for you, should you actu=
ally
> > > > need SI units.
> > > >
> > >
> > > ACK
> > >
> > > > >
> > > > > > > +}
> > > > > > > +
> > > > > > > +static int mt6360_adc_convert_processed_val(struct mt6360_ad=
c_data *info, int chan_idx, int *val)
> > > > > > > +{
> > > > > > > +     unsigned int regval =3D 0;
> > > > > > > +     const struct converter {
> > > > > > > +             int multiplier;
> > > > > > > +             int offset;
> > > > > > > +             int divisor;
> > > > > > > +     } adc_converter[MT6360_CHAN_MAX] =3D {
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
> > > > > > > +     }, sp_ibus_adc_converter =3D { 1900, 0, 1 }, *sel_conve=
rter;
> > > > > > > +     int ret;
> > > > > > > +
> > > > > > > +     sel_converter =3D adc_converter + chan_idx;
> > > > > > > +     if (chan_idx =3D=3D MT6360_CHAN_IBUS) {
> > > > > > > +             /* ibus chan will be affected by aicr config */
> > > > > > > +             /* if aicr < 400, apply the special ibus conver=
ter */
> > > > > > > +             ret =3D regmap_read(info->regmap, MT6360_REG_PM=
UCHGCTRL3, &regval);
> > > > > > > +             if (ret)
> > > > > > > +                     return ret;
> > > > > > > +
> > > > > > > +             regval =3D (regval & MT6360_AICR_MASK) >> MT636=
0_AICR_SHFT;
> > > > > > > +             if (regval < MT6360_AICR_400MA)
> > > > > > > +                     sel_converter =3D &sp_ibus_adc_converte=
r;
> > > > > > > +     }
> > > > > > > +
> > > > > > > +     *val =3D mt6360_adc_val_converter(*val, sel_converter->=
multiplier, sel_converter->offset,
> > > > > > > +                                     sel_converter->divisor)=
;
> > > > > > > +
> > > > > > > +     return 0;
> > > > > > > +}
> > > > > > > +
> > > > > > > +static int mt6360_adc_read_processed(struct mt6360_adc_data =
*mad, int channel, int *val)
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
> > > > > > > +     ret =3D regmap_update_bits(mad->regmap, MT6360_REG_PMUA=
DCRPT1, MT6360_PREFERCH_MASK,
> > > > > > > +                              channel << MT6360_PREFERCH_SHF=
T);
> > > > > > > +     if (ret)
> > > > > > > +             goto out_adc;
> > > > > > > +
> > > > > > > +     /* enable adc channel we want and adc_en */
> > > > > > > +     adc_enable =3D MT6360_ADCEN_MASK | BIT(channel);
> > > > > > > +     adc_enable =3D cpu_to_be16(adc_enable);
> > > > > >
> > > > > > Use a local be16 to store that. It will make it a little cleare=
r
> > > > > > that we are doing something 'unusual' here.  Perhaps a comment =
on
> > > > > > why this odd code exists would also help?
> > > > > >
> > > > >
> > > > > ACK
> > > > >
> > > > > > > +     ret =3D regmap_raw_write(mad->regmap, MT6360_REG_PMUADC=
CFG, (void *)&adc_enable, sizeof(u16));
> > > > > > > +     if (ret)
> > > > > > > +             goto out_adc;
> > > > > > > +
> > > > > > > +     start_t =3D ktime_get();
> > > > > > > +     predict_end_t =3D ktime_add_ms(mad->last_off_timestamps=
[channel], 50);
> > > > > > > +
> > > > > > > +     if (ktime_after(start_t, predict_end_t))
> > > > > > > +             predict_end_t =3D ktime_add_ms(start_t, 25);
> > > > > > > +     else
> > > > > > > +             predict_end_t =3D ktime_add_ms(start_t, 75);
> > > > > > > +
> > > > > > > +     enable_irq(mad->irq);
> > > > > > > +adc_retry:
> > > > > > > +     reinit_completion(&mad->adc_complete);
> > > > > > > +
> > > > > > > +     /* wait for conversion to complete */
> > > > > > > +     timeout =3D wait_for_completion_timeout(&mad->adc_compl=
ete, msecs_to_jiffies(200));
> > > > > > > +     if (timeout =3D=3D 0) {
> > > > > > > +             ret =3D -ETIMEDOUT;
> > > > > > > +             goto out_adc_conv;
> > > > > > > +     } else if (timeout < 0) {
> > > > > > > +             ret =3D -EINTR;
> > > > > > > +             goto out_adc_conv;
> > > > > > > +     }
> > > > > > > +
> > > > > > > +     ret =3D regmap_raw_read(mad->regmap, MT6360_REG_PMUADCR=
PT1, rpt, sizeof(rpt));
> > > > > > > +     if (ret)
> > > > > > > +             goto out_adc_conv;
> > > > > > > +
> > > > > > > +     /* check the current reported channel */
> > > > > > > +     if ((rpt[0] & MT6360_RPTCH_MASK) !=3D channel) {
> > > > > > > +             dev_dbg(mad->dev, "not wanted channel report [%=
02x]\n", rpt[0]);
> > > > > >
> > > > > > This and the one below feel like error messages rather than deb=
ug ones.
> > > > > >
> > > > >
> > > > > We have two function "battery zero current voltage(ZCV)" and "Typ=
eC
> > > > > OTP" will auto run ADC at background.
> > > > > ZCV_EN will run VBAT_ADC when TA plug in, TypeC OTP will run TS_A=
DC
> > > > > when TypeC attach.
> > > > > We need to check report channel for ADC report data match is our =
desire channel.
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
> > >          * ADC conversion sequence is desire channel before start ADC=
,
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
> > > > > > > +             dev_dbg(mad->dev, "time is not after one adc_co=
nv_t\n");
> > > > > >
> > > > > > Does this actually happen? If feels like we are being a bit ove=
r protective
> > > > > > here.  I'd definitely like to see a comment saying why this pro=
tection
> > > > > > might be needed.
> > > > > >
> > > > >
> > > > > When ADC_EN and MT6360_CHANx_EN is enable, the channel x will kee=
p
> > > > > running again and again
> > > > > I supposed to get immediate data which is generated after I start=
 it.
> > > >
> > > > Just to check my understanding.
> > > >
> > > > This is an edge triggered interrupt and it triggers every time a ne=
w sample
> > > > is taken.  Those samples are taken on a fixed frequency irrespectiv=
e of whether
> > > > we have read the previous one?
> > > >
> > >
> > > Yes.
> > > I use LEVEL_LOW trigger in latest review MFD patch.
> >
> > I'm not sure I follow that comment.  How can you do that if it's a repe=
ating
> > edge trigger?
> >
>
> I implement "struct regmap_irq_chip" handle_post_irq ops,
> In the end of handle irq, I set the re-trigger bit which will pull irq
> high to low again if irq pin is low.
>
> -static int mt6360_pmu_handle_post_irq(void *irq_drv_data)
> -{
> -       struct mt6360_pmu_info *mpi =3D irq_drv_data;
> -
> -       return regmap_update_bits(mpi->regmap,
> -               MT6360_PMU_IRQ_SET, MT6360_IRQ_RETRIG, MT6360_IRQ_RETRIG)=
;
> -}
> -
>
> > >
> > > > >
> > > > > When I disable ADC_CHANx_EN, the H/W logical ADC is still running=
.
> > > > > If I run the same ADC immediately, I may get the old result about=
 this channel.
> > > > > MT6360 ADC typical conversation time is about 25ms.
> > > > > So We need ignore which irq trigger below 25ms.
> > > >
> > > > Normal trick for this sort of case is to just not use the interrupt=
.
> > > > Just read after 25+delta msecs and you are guaranteed to get the ri=
ght answer.
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
>

ACK, I will use polling only.
This is our IC limitation which will be fixed in next generation.

> > ...
> >
