Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8689262916
	for <lists+linux-iio@lfdr.de>; Wed,  9 Sep 2020 09:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728214AbgIIHj1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 9 Sep 2020 03:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726226AbgIIHj1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 9 Sep 2020 03:39:27 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3015C061573;
        Wed,  9 Sep 2020 00:39:26 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id h4so2143970ioe.5;
        Wed, 09 Sep 2020 00:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QkWL6JtC5f5oIKRtZMCFsFJKgKn4ty8jlN8V4It2/eo=;
        b=YWKKNeloegJWOySJX6eLi5BTpvHzDFpoMPU3y2wuQyVu2F0X48r74BlOo0BbUXGk/y
         XY73Svt+A20tTUVyBnW/yHzK/IHzJ1jJhj8pO0QJJapTlbcZx1g47B67kQ/bH+eQHyky
         4/wbkL452HQeNLfF61Vmhjyydg9GECV6pvHV29V1xGR1QsN22Donlry5vN9Pa3AWV7XY
         euXey5wLW6SfFcFNGsNMGsthEG0rRpue0Sb84C4iywq8X8N6sgwryxxW6CqIGmXCBEkS
         Z5Pt1EB44dRXogESy1hJ7ZacCzYJlyBOEqhQWSyL3YCy3xT2aFLIuuKvkLcK15ZsTr1+
         dwhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QkWL6JtC5f5oIKRtZMCFsFJKgKn4ty8jlN8V4It2/eo=;
        b=Ld+Mh7S+M+D+JtZHHN36xdqJ1FcatM2OHrSaNmbd3NB+d/yMuvn5Y9k0YyD74l+4RF
         WZpBm44yNqn8gMX7cViqq3G32FF+JHanRmdwaoDiuiklGxPF7VpBoKJ80Lw75uhU7HJ1
         yvH8sOMsXtudvJ/919eZSxpODfDoiALCR3r9XfpnT2THP4rMJujhr10loiMU+3RJUgRA
         fYVAnGOsMyWymoXYnWVDbAfKsOeT+a6eSpz3epPnQ93gQMnSkS2VmQeIWGSVLc3PrY7G
         sMA/BRLaNSfVG6Lj0Pdp6G+gpvWnRZRqBtYGNkjLzd8TNFJNBAUe7xeRli/E4Ga21pXh
         0OqQ==
X-Gm-Message-State: AOAM5331XPJdFMawh1oMkhNp8i+vwuXSdw6hFboaXJPBK/Cv0pO4yNw4
        sTqH3UYLV3TC1FA2qQRkRVD+OY6bJmC2sbwLCN9fEcea
X-Google-Smtp-Source: ABdhPJwlIRjmrS1RANFLr1xwxZM2Fj5r47GuF4Lcr/QLNJAUUD1OB9UDgnrD/2e928jaj3gjrX0yrbxVAu9S8eq+4eo=
X-Received: by 2002:a02:9a0e:: with SMTP id b14mr2970008jal.22.1599637166116;
 Wed, 09 Sep 2020 00:39:26 -0700 (PDT)
MIME-Version: 1.0
References: <1598259985-12517-1-git-send-email-gene.chen.richtek@gmail.com>
 <1598259985-12517-2-git-send-email-gene.chen.richtek@gmail.com>
 <20200829181157.1b653a88@archlinux> <CAE+NS36j4a6k-JSUbjxzpfbqtE-xMW7qxUUhHPAnc_9V-Lv7LQ@mail.gmail.com>
 <20200908100712.00007a7b@Huawei.com> <CAE+NS35aQ3k2auYA+bmf6kMhm192oyg8_j5j=zzK0sn_NS6HoA@mail.gmail.com>
 <20200908135830.00007b13@Huawei.com>
In-Reply-To: <20200908135830.00007b13@Huawei.com>
From:   Gene Chen <gene.chen.richtek@gmail.com>
Date:   Wed, 9 Sep 2020 07:39:14 +0800
Message-ID: <CAE+NS35ucEjeewBRaW7ha1pcisz-VQBK8VJgK_DdB5vWy7Q53Q@mail.gmail.com>
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
=9C=888=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=889:00=E5=AF=AB=E9=81=
=93=EF=BC=9A
>
> ...
>
> > > > > > +#include <linux/completion.h>
> > > > > > +#include <linux/interrupt.h>
> > > > > > +#include <linux/iio/buffer.h>
> > > > > > +#include <linux/iio/iio.h>
> > > > > > +#include <linux/iio/trigger_consumer.h>
> > > > > > +#include <linux/iio/triggered_buffer.h>
> > > > > > +#include <linux/irq.h>
> > > > > > +#include <linux/kernel.h>
> > > > > > +#include <linux/ktime.h>
> > > > > > +#include <linux/module.h>
> > > > > > +#include <linux/mutex.h>
> > > > > > +#include <linux/platform_device.h>
> > > > > > +#include <linux/regmap.h>
> > > > > > +
> > > > > > +#define MT6360_REG_PMUCHGCTRL3       0x313
> > > > > > +#define MT6360_REG_PMUADCCFG 0x356
> > > > > > +#define MT6360_REG_PMUADCRPT1        0x35A
> > > > > > +
> > > > > > +/* PMUCHGCTRL3 0x313 */
> > > > > > +#define MT6360_AICR_MASK     0xFC
> > > > > > +#define MT6360_AICR_SHFT     2
> > > > > > +#define MT6360_AICR_400MA    0x6
> > > > > > +/* PMUADCCFG 0x356 */
> > > > > > +#define MT6360_ADCEN_MASK    0x8000
> > > > > > +/* PMUADCRPT1 0x35A */
> > > > > > +#define MT6360_PREFERCH_MASK 0xF0
> > > > > > +#define MT6360_PREFERCH_SHFT 4
> > > > > > +#define MT6360_RPTCH_MASK    0x0F
> > > > > > +
> > > > > > +enum {
> > > > > > +     MT6360_CHAN_USBID =3D 0,
> > > > > > +     MT6360_CHAN_VBUSDIV5,
> > > > > > +     MT6360_CHAN_VBUSDIV2,
> > > > > > +     MT6360_CHAN_VSYS,
> > > > > > +     MT6360_CHAN_VBAT,
> > > > > > +     MT6360_CHAN_IBUS,
> > > > > > +     MT6360_CHAN_IBAT,
> > > > > > +     MT6360_CHAN_CHG_VDDP,
> > > > > > +     MT6360_CHAN_TEMP_JC,
> > > > > > +     MT6360_CHAN_VREF_TS,
> > > > > > +     MT6360_CHAN_TS,
> > > > > > +     MT6360_CHAN_MAX,
> > > > > > +};
> > > > > > +
> > > > > > +struct mt6360_adc_data {
> > > > > > +     struct device *dev;
> > > > > > +     struct regmap *regmap;
> > > > > > +     struct completion adc_complete;
> > > > > > +     struct mutex adc_lock;
> > > > > > +     ktime_t last_off_timestamps[MT6360_CHAN_MAX];
> > > > > > +     int irq;
> > > > > > +};
> > > > > > +
> > > > > > +static inline int mt6360_adc_val_converter(int val, int multip=
lier, int offset, int divisor)
> > > > > > +{
> > > > > > +     return ((val * multiplier) + offset) / divisor;
> > > > >
> > > > > Why could we not report these values to userspace or consumer dri=
vers and let
> > > > > them deal with the conversion if they actually needed it?
> > > > > Mapping this to
> > > > >
> > > > > (val + new_offset) * multiplier would be a little messy, but not =
too bad.
> > > > >
> > > > > The advantage would be that we would then be providing the data n=
eeded
> > > > > to get real units for values read from the buffers without having=
 to
> > > > > do all the maths in kernel (without access to floating point).
> > > > >
> > > > >
> > > >
> > > > As above, if I use formula "(val + new_offset) * multiplier",
> > > > the junction temperature channel multiplier will be floating point
> > > > 1.05, i don't know how to express.
> > >
> > > As Andy mentioned, we do this all over the place.
> > > IIO_VAL_INT_PLUS_MICRO
> > >
> > > The key is that we want to push the burden of doing this maths to the=
 user
> > > not the source.
> >
> > ACK.
> > Can I keep IIO_CHAN_INFO_PROCESSED function be reserved for user in
> > kernel space?
> >
>
> No. We have utility functions that will apply the multiplier as needed so
> there is no significant advantage in doing this and it won't be consisten=
t
> with the majority of other drivers.
>

ACK, I will remove IIO_CHAN_INFO_PROCESSED.

> > >
> > > Often what is actually of interest is whether a temperature passed a =
threshold.
> > > In that case, you can transform the threshold into the units of the A=
DC (so the
> > > reverse directly to you would do with processed data) and only have t=
o do the
> > > maths once per change of the threshold instead of for every sample.
> > >
> > > There are helper functions to do the maths for you, should you actual=
ly
> > > need SI units.
> > >
> >
> > ACK
> >
> > > >
> > > > > > +}
> > > > > > +
> > > > > > +static int mt6360_adc_convert_processed_val(struct mt6360_adc_=
data *info, int chan_idx, int *val)
> > > > > > +{
> > > > > > +     unsigned int regval =3D 0;
> > > > > > +     const struct converter {
> > > > > > +             int multiplier;
> > > > > > +             int offset;
> > > > > > +             int divisor;
> > > > > > +     } adc_converter[MT6360_CHAN_MAX] =3D {
> > > > > > +             { 1250, 0, 1}, /* USBID */
> > > > > > +             { 6250, 0, 1}, /* VBUSDIV5 */
> > > > > > +             { 2500, 0, 1}, /* VBUSDIV2 */
> > > > > > +             { 1250, 0, 1}, /* VSYS */
> > > > > > +             { 1250, 0, 1}, /* VBAT */
> > > > > > +             { 2500, 0, 1}, /* IBUS */
> > > > > > +             { 2500, 0, 1}, /* IBAT */
> > > > > > +             { 1250, 0, 1}, /* CHG_VDDP */
> > > > > > +             { 105, -8000, 100}, /* TEMP_JC */
> > > > > > +             { 1250, 0, 1}, /* VREF_TS */
> > > > > > +             { 1250, 0, 1}, /* TS */
> > > > > > +     }, sp_ibus_adc_converter =3D { 1900, 0, 1 }, *sel_convert=
er;
> > > > > > +     int ret;
> > > > > > +
> > > > > > +     sel_converter =3D adc_converter + chan_idx;
> > > > > > +     if (chan_idx =3D=3D MT6360_CHAN_IBUS) {
> > > > > > +             /* ibus chan will be affected by aicr config */
> > > > > > +             /* if aicr < 400, apply the special ibus converte=
r */
> > > > > > +             ret =3D regmap_read(info->regmap, MT6360_REG_PMUC=
HGCTRL3, &regval);
> > > > > > +             if (ret)
> > > > > > +                     return ret;
> > > > > > +
> > > > > > +             regval =3D (regval & MT6360_AICR_MASK) >> MT6360_=
AICR_SHFT;
> > > > > > +             if (regval < MT6360_AICR_400MA)
> > > > > > +                     sel_converter =3D &sp_ibus_adc_converter;
> > > > > > +     }
> > > > > > +
> > > > > > +     *val =3D mt6360_adc_val_converter(*val, sel_converter->mu=
ltiplier, sel_converter->offset,
> > > > > > +                                     sel_converter->divisor);
> > > > > > +
> > > > > > +     return 0;
> > > > > > +}
> > > > > > +
> > > > > > +static int mt6360_adc_read_processed(struct mt6360_adc_data *m=
ad, int channel, int *val)
> > > > > > +{
> > > > > > +     u16 adc_enable;
> > > > > > +     u8 rpt[3];
> > > > > > +     ktime_t start_t, predict_end_t;
> > > > > > +     long timeout;
> > > > > > +     int value, ret;
> > > > > > +
> > > > > > +     mutex_lock(&mad->adc_lock);
> > > > > > +
> > > > > > +     /* select preferred channel that we want */
> > > > > > +     ret =3D regmap_update_bits(mad->regmap, MT6360_REG_PMUADC=
RPT1, MT6360_PREFERCH_MASK,
> > > > > > +                              channel << MT6360_PREFERCH_SHFT)=
;
> > > > > > +     if (ret)
> > > > > > +             goto out_adc;
> > > > > > +
> > > > > > +     /* enable adc channel we want and adc_en */
> > > > > > +     adc_enable =3D MT6360_ADCEN_MASK | BIT(channel);
> > > > > > +     adc_enable =3D cpu_to_be16(adc_enable);
> > > > >
> > > > > Use a local be16 to store that. It will make it a little clearer
> > > > > that we are doing something 'unusual' here.  Perhaps a comment on
> > > > > why this odd code exists would also help?
> > > > >
> > > >
> > > > ACK
> > > >
> > > > > > +     ret =3D regmap_raw_write(mad->regmap, MT6360_REG_PMUADCCF=
G, (void *)&adc_enable, sizeof(u16));
> > > > > > +     if (ret)
> > > > > > +             goto out_adc;
> > > > > > +
> > > > > > +     start_t =3D ktime_get();
> > > > > > +     predict_end_t =3D ktime_add_ms(mad->last_off_timestamps[c=
hannel], 50);
> > > > > > +
> > > > > > +     if (ktime_after(start_t, predict_end_t))
> > > > > > +             predict_end_t =3D ktime_add_ms(start_t, 25);
> > > > > > +     else
> > > > > > +             predict_end_t =3D ktime_add_ms(start_t, 75);
> > > > > > +
> > > > > > +     enable_irq(mad->irq);
> > > > > > +adc_retry:
> > > > > > +     reinit_completion(&mad->adc_complete);
> > > > > > +
> > > > > > +     /* wait for conversion to complete */
> > > > > > +     timeout =3D wait_for_completion_timeout(&mad->adc_complet=
e, msecs_to_jiffies(200));
> > > > > > +     if (timeout =3D=3D 0) {
> > > > > > +             ret =3D -ETIMEDOUT;
> > > > > > +             goto out_adc_conv;
> > > > > > +     } else if (timeout < 0) {
> > > > > > +             ret =3D -EINTR;
> > > > > > +             goto out_adc_conv;
> > > > > > +     }
> > > > > > +
> > > > > > +     ret =3D regmap_raw_read(mad->regmap, MT6360_REG_PMUADCRPT=
1, rpt, sizeof(rpt));
> > > > > > +     if (ret)
> > > > > > +             goto out_adc_conv;
> > > > > > +
> > > > > > +     /* check the current reported channel */
> > > > > > +     if ((rpt[0] & MT6360_RPTCH_MASK) !=3D channel) {
> > > > > > +             dev_dbg(mad->dev, "not wanted channel report [%02=
x]\n", rpt[0]);
> > > > >
> > > > > This and the one below feel like error messages rather than debug=
 ones.
> > > > >
> > > >
> > > > We have two function "battery zero current voltage(ZCV)" and "TypeC
> > > > OTP" will auto run ADC at background.
> > > > ZCV_EN will run VBAT_ADC when TA plug in, TypeC OTP will run TS_ADC
> > > > when TypeC attach.
> > > > We need to check report channel for ADC report data match is our de=
sire channel.
> > >
> > > So there is firmware messing with it underneath?  Oh goody.
> > > Add a comment explaining this.
> > >
> >
> > ACK, I try to write a comment as below
> >
> >         /*
> >          * There are two functions, ZCV and TypeC OTP, running ADC
> > VBAT and TS in background,
> >          * and ADC samples are taken on a fixed frequency no matter
> > read the previous one or not.
> >          * To avoid conflict need set minimum time threshold after
> > enable ADC and check report
> >          * channel is the same.
> >          * The worst case is run the same ADC twice and background
> > function is also running,
> >          * ADC conversion sequence is desire channel before start ADC,
> > background ADC, desire
> >          * channel after start ADC. So the minimum correct data is
> > three times of typical
> >          * conversion time.
> >          */
>
> Looks good.
>

ACK

> >
> > > >
> > > > > > +             goto adc_retry;
> > > > > > +     }
> > > > > > +
> > > > > > +     if (!ktime_after(ktime_get(), predict_end_t)) {
> > > > > > +             dev_dbg(mad->dev, "time is not after one adc_conv=
_t\n");
> > > > >
> > > > > Does this actually happen? If feels like we are being a bit over =
protective
> > > > > here.  I'd definitely like to see a comment saying why this prote=
ction
> > > > > might be needed.
> > > > >
> > > >
> > > > When ADC_EN and MT6360_CHANx_EN is enable, the channel x will keep
> > > > running again and again
> > > > I supposed to get immediate data which is generated after I start i=
t.
> > >
> > > Just to check my understanding.
> > >
> > > This is an edge triggered interrupt and it triggers every time a new =
sample
> > > is taken.  Those samples are taken on a fixed frequency irrespective =
of whether
> > > we have read the previous one?
> > >
> >
> > Yes.
> > I use LEVEL_LOW trigger in latest review MFD patch.
>
> I'm not sure I follow that comment.  How can you do that if it's a repeat=
ing
> edge trigger?
>

I implement "struct regmap_irq_chip" handle_post_irq ops,
In the end of handle irq, I set the re-trigger bit which will pull irq
high to low again if irq pin is low.

-static int mt6360_pmu_handle_post_irq(void *irq_drv_data)
-{
-       struct mt6360_pmu_info *mpi =3D irq_drv_data;
-
-       return regmap_update_bits(mpi->regmap,
-               MT6360_PMU_IRQ_SET, MT6360_IRQ_RETRIG, MT6360_IRQ_RETRIG);
-}
-

> >
> > > >
> > > > When I disable ADC_CHANx_EN, the H/W logical ADC is still running.
> > > > If I run the same ADC immediately, I may get the old result about t=
his channel.
> > > > MT6360 ADC typical conversation time is about 25ms.
> > > > So We need ignore which irq trigger below 25ms.
> > >
> > > Normal trick for this sort of case is to just not use the interrupt.
> > > Just read after 25+delta msecs and you are guaranteed to get the righ=
t answer.
> > >
> > >
> >
> > ACK, I will try to use polling
> > Is the pseudocode correct?
> >
> > mdelay(predict_end_t);
> > while (true) {
> >     read adc event is occured
> >     check report channel is the same
> >     if the same, read report ADC data and break while loop
> >     else msleep(per ADC conversion time)
> > }
>
> Looks correct to me.  We should 'know' the event has happened but
> still need to check the channel is the expected one.
>

There is a comment in our internal discuss.
If I use msleep as polling interval, the worst case will cause
additional wait time nearly one polling interval.
Can I keep using interrupt for saving time?

> ...
>
