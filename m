Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADEE1270E1A
	for <lists+linux-iio@lfdr.de>; Sat, 19 Sep 2020 15:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbgISNUN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 19 Sep 2020 09:20:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:38580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726159AbgISNUN (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 19 Sep 2020 09:20:13 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2586F20888;
        Sat, 19 Sep 2020 13:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600521612;
        bh=q/fkPTtdtq6+N4dWIZ5fZ9ppXQrwFCRgHeFnseOeSFk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Fi0OaGoo265xy3RkkDaSUTKULWCQgAVYFvbsX74VsyNjcnnahpkIU1oFN9v0mAuOF
         BbldgEgSK5OleM5j2Tt6vX7qFKoshPp0oAIocf50elwS/bNJHubcI3LC7E5S2e5AVK
         Us0sm1oTStQ86YUuTbNuRsJViQmAXKmar6yuXyUM=
Date:   Sat, 19 Sep 2020 14:20:05 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Gene Chen <gene.chen.richtek@gmail.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Gene Chen <gene_chen@richtek.com>, Wilma.Wu@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com,
        benjamin.chao@mediatek.com
Subject: Re: [PATCH v4 3/3] iio: adc: mt6360: Add ADC driver for MT6360
Message-ID: <20200919142005.18e3e11f@archlinux>
In-Reply-To: <CAE+NS35RkbHOqrFoEE2MS109hTKowZO3jmT_oTpSmCRnY-87Lg@mail.gmail.com>
References: <1600191369-28040-1-git-send-email-gene.chen.richtek@gmail.com>
        <1600191369-28040-4-git-send-email-gene.chen.richtek@gmail.com>
        <20200917185327.761f7e5a@archlinux>
        <CAE+NS35RkbHOqrFoEE2MS109hTKowZO3jmT_oTpSmCRnY-87Lg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 18 Sep 2020 16:04:43 +0800
Gene Chen <gene.chen.richtek@gmail.com> wrote:

> Jonathan Cameron <jic23@kernel.org> =E6=96=BC 2020=E5=B9=B49=E6=9C=8818=
=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8A=E5=8D=881:53=E5=AF=AB=E9=81=93=EF=BC=
=9A
> >
> > On Wed, 16 Sep 2020 01:36:09 +0800
> > Gene Chen <gene.chen.richtek@gmail.com> wrote:
> > =20
> > > From: Gene Chen <gene_chen@richtek.com>
> > >
> > > Add MT6360 ADC driver include Charger Current, Voltage, and
> > > Temperature.
> > >
> > > Signed-off-by: Gene Chen <gene_chen@richtek.com> =20
> > Comments inline.

...

> > > +     if (ret)
> > > +             goto out_adc_lock;
> > > +
> > > +     start_t =3D ktime_get();
> > > +     predict_end_t =3D ktime_add_ms(mad->last_off_timestamps[channel=
], 2 * ADC_WAIT_TIME_MS);
> > > +
> > > +     if (ktime_after(start_t, predict_end_t))
> > > +             pre_wait_time =3D ADC_WAIT_TIME_MS;
> > > +     else
> > > +             pre_wait_time =3D 3 * ADC_WAIT_TIME_MS;
> > > +
> > > +     msleep(pre_wait_time);
> > > +
> > > +     while (true) {
> > > +             ret =3D regmap_raw_read(mad->regmap, MT6360_REG_PMUADCR=
PT1, rpt, sizeof(rpt));
> > > +             if (ret)
> > > +                     goto out_adc_conv;
> > > +
> > > +             /*
> > > +              * There are two functions, ZCV and TypeC OTP, running =
ADC VBAT and TS in
> > > +              * background, and ADC samples are taken on a fixed fre=
quency no matter read the
> > > +              * previous one or not.
> > > +              * To avoid conflict, We set minimum time threshold aft=
er enable ADC and
> > > +              * check report channel is the same.
> > > +              * The worst case is run the same ADC twice and backgro=
und function is also running,
> > > +              * ADC conversion sequence is desire channel before sta=
rt ADC, background ADC,
> > > +              * desire channel after start ADC.
> > > +              * So the minimum correct data is three times of typica=
l conversion time.
> > > +              */
> > > +             if ((rpt[0] & MT6360_RPTCH_MASK) =3D=3D channel)
> > > +                     break;
> > > +
> > > +             msleep(ADC_WAIT_TIME_MS);
> > > +     }
> > > +
> > > +     /* rpt[1]: ADC_HI_BYTE, rpt[2]: ADC_LOW_BYTE */
> > > +     *val =3D be16_to_cpup((__be16 *)(rpt + 1)); =20
> >
> > To be entirely safe, probably need that to be an unaligned read?
> > =20
>=20
> Maybe I can change to "*val =3D rpt[1] << 8 | rpt[2];".
> It's more abvious.

That would definitely be safe so do that.

>=20
> > > +     ret =3D IIO_VAL_INT;
> > > +
> > > +out_adc_conv:
> > > +     /* Only keep ADC enable */
> > > +     adc_enable =3D cpu_to_be16(MT6360_ADCEN_MASK);
> > > +     regmap_raw_write(mad->regmap, MT6360_REG_PMUADCCFG, (void *)&ad=
c_enable, sizeof(__be16)); =20
> >
> > sizeof(adc_enable)
> > =20
>=20
> ACK
>=20
> > > +     mad->last_off_timestamps[channel] =3D ktime_get();
> > > +     /* Config prefer channel to NO_PREFER */
> > > +     regmap_update_bits(mad->regmap, MT6360_REG_PMUADCRPT1, MT6360_P=
REFERCH_MASK,
> > > +                        MT6360_NO_PREFER << MT6360_PREFERCH_SHFT);
> > > +out_adc_lock:
> > > +     mutex_unlock(&mad->adc_lock);
> > > +
> > > +     return ret;
> > > +}
> > > +
> > > +static int mt6360_adc_read_scale(struct mt6360_adc_data *mad, int ch=
annel, int *val, int *val2)
> > > +{
> > > +     unsigned int regval;
> > > +     int ret;
> > > +
> > > +     switch (channel) {
> > > +     case MT6360_CHAN_USBID:
> > > +             fallthrough; =20
> >
> > I don't think we need fallthrough for cases
> > with nothing in them.
> > =20
>=20
> Every channel needs set " *val =3D 2500" for scale.
> Do you mean change as below?
>=20
>         switch (channel) {
>         case MT6360_CHAN_USBID:
>         case MT6360_CHAN_VSYS:
>         case MT6360_CHAN_VBAT:
>         case MT6360_CHAN_CHG_VDDP:
>         case MT6360_CHAN_VREF_TS:
>                 fallthrough;
Don't need this fallthrough.

fallthrough is only needed if something is done in the
case statement.  I believe the checker is clever enough to
assume that a set of case statements with nothing inbetween
them are deliberate.

>         case MT6360_CHAN_TS:
>                 *val =3D 1250;
>                 return IIO_VAL_INT;
>=20

...

> > > +
> > > +static irqreturn_t mt6360_adc_trigger_handler(int irq, void *p)
> > > +{
> > > +     struct iio_poll_func *pf =3D p;
> > > +     struct iio_dev *indio_dev =3D pf->indio_dev;
> > > +     struct mt6360_adc_data *mad =3D iio_priv(indio_dev);
> > > +     struct {
> > > +             u16 values[MT6360_CHAN_MAX]; =20
> >
> > There is a hole in here I think? (MT6360_CHAN_MAX is 11?)
> > If so we need to explicitly memset the structure to avoid any
> > risk of kernel data leakage to userspace.

Make sure you deal with this in v5!

> > =20
> > > +             int64_t timestamp;
> > > +     } data; =20
> >
> > I guess we know this is on a platform with 64bit alignment for int64_t's
> > (unlike x86_64 for example)
> > =20
>=20
> Do you mean change as below?
> struct {
>     u16 values[MT6360_CHAN_MAX];
>     int64_t timestamp; __aligned(8)
> } data;

You can do that, or we can rely on the fact this part is never used
on a platform where that isn't guaranteed anyway.

>=20
> > > +     int i =3D 0, bit, val, ret;
...

