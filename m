Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD9326F7A6
	for <lists+linux-iio@lfdr.de>; Fri, 18 Sep 2020 10:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbgIRIE4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 18 Sep 2020 04:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbgIRIEz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 18 Sep 2020 04:04:55 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE47EC06174A;
        Fri, 18 Sep 2020 01:04:55 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id j2so5890235ioj.7;
        Fri, 18 Sep 2020 01:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=isHcJ3zrzwSEOolO9s/LiG2XNCyu5EB1SRmS2POrm34=;
        b=Su81ia6pIxlwQBXOnK5g2OHW4d9yNkVfSNehJlxrQNH5YSpD3t764L2jnq8oHk16RV
         ZywcOyRpDXI2mjXWJiJyLG48cG1PR2y98aSNwUybSgg1qPLfZjP+2mX80nWF9xfNaAH5
         BInwumSAZhU8YTGPHQuOpW8w08vbAPyN1uLjlgsvs36qnUPOkc3PUo3YRao9H2EWWkEd
         82HohF9K9lOiH/GbxZlnm25LGxGe6Ivsnv5fpm0O8ErgmmftLdUzHoFuGblr8gY/p3Mg
         K+PrLP+Y4ozrER5TJndfdnb+ZBy63JMPSChfnZUUCGiwcl5hpzrkY8uNEPrt78Lr0M8q
         rOZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=isHcJ3zrzwSEOolO9s/LiG2XNCyu5EB1SRmS2POrm34=;
        b=ZZNmFAZLgzfoPzS3JUKRmzfQd6PYfWs/s7F77UI2hy1Y7f4NSASHbH0eJnEfgSqmdv
         BDGF0ipfek5J6Uk6JF+5DaO82KBMTl8r8zNKg3oSmbLPFU9Me5nh8wpEvYc5/1j69yuz
         fu1XryJEHvOKuOCjoI3qek9qBF8DeYT7/2oVa5Oxw9CjmQVeIiBrGD/I4IyBObDtmZwb
         t35nel3/+esA/7T6nYGlh4XK8KHkhlvy/QXDdIK+Ljwy+x5xjunzN8RBqHuVOT1Um6y2
         Nq7GmxSE7y4VTfSNPTAaKt6kjd1zmh7pwCXSgcGIaS7EbgXJ7/ywwv3jsG7Jp14nqTLS
         ZtZQ==
X-Gm-Message-State: AOAM533zjx5I+7MCHJKObJ/ai4avwGh1ew8uacAGH0nLRvOXVp+XwwfL
        +1pSJntnCfl1biyNDaagAmLLkywJhwaSpl4SSZo=
X-Google-Smtp-Source: ABdhPJz1+JtF8SaQd90mMz7vu+5uGM1paAeZyWjCpdJVmKi6xEADdoyTZXSj2qYId5uoKAb2LkGeVlYqQnpZO5cnyXM=
X-Received: by 2002:a02:9a0e:: with SMTP id b14mr30235177jal.22.1600416294851;
 Fri, 18 Sep 2020 01:04:54 -0700 (PDT)
MIME-Version: 1.0
References: <1600191369-28040-1-git-send-email-gene.chen.richtek@gmail.com>
 <1600191369-28040-4-git-send-email-gene.chen.richtek@gmail.com> <20200917185327.761f7e5a@archlinux>
In-Reply-To: <20200917185327.761f7e5a@archlinux>
From:   Gene Chen <gene.chen.richtek@gmail.com>
Date:   Fri, 18 Sep 2020 16:04:43 +0800
Message-ID: <CAE+NS35RkbHOqrFoEE2MS109hTKowZO3jmT_oTpSmCRnY-87Lg@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] iio: adc: mt6360: Add ADC driver for MT6360
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Gene Chen <gene_chen@richtek.com>, Wilma.Wu@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com,
        benjamin.chao@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Jonathan Cameron <jic23@kernel.org> =E6=96=BC 2020=E5=B9=B49=E6=9C=8818=E6=
=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8A=E5=8D=881:53=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Wed, 16 Sep 2020 01:36:09 +0800
> Gene Chen <gene.chen.richtek@gmail.com> wrote:
>
> > From: Gene Chen <gene_chen@richtek.com>
> >
> > Add MT6360 ADC driver include Charger Current, Voltage, and
> > Temperature.
> >
> > Signed-off-by: Gene Chen <gene_chen@richtek.com>
> Comments inline.
>
> > ---
> >  drivers/iio/adc/Kconfig      |  11 ++
> >  drivers/iio/adc/Makefile     |   1 +
> >  drivers/iio/adc/mt6360-adc.c | 357 +++++++++++++++++++++++++++++++++++=
++++++++
> >  3 files changed, 369 insertions(+)
> >  create mode 100644 drivers/iio/adc/mt6360-adc.c
> >
> > diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> > index 66d9cc0..8d36b66 100644
> > --- a/drivers/iio/adc/Kconfig
> > +++ b/drivers/iio/adc/Kconfig
> > @@ -703,6 +703,17 @@ config MCP3911
> >         This driver can also be built as a module. If so, the module wi=
ll be
> >         called mcp3911.
> >
> > +config MEDIATEK_MT6360_ADC
> > +     tristate "Mediatek MT6360 ADC driver"
> > +     depends on MFD_MT6360
> > +     select IIO_BUFFER
> > +     select IIO_TRIGGERED_BUFFER
> > +     help
> > +       Say Y here to enable MT6360 ADC support.
> > +       Integrated for System Monitoring includes
> > +       is used in smartphones and tablets and supports a 11 channel
> > +       general purpose ADC.
> > +
> >  config MEDIATEK_MT6577_AUXADC
> >       tristate "MediaTek AUXADC driver"
> >       depends on ARCH_MEDIATEK || COMPILE_TEST
> > diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> > index 90f94ad..5fca90a 100644
> > --- a/drivers/iio/adc/Makefile
> > +++ b/drivers/iio/adc/Makefile
> > @@ -65,6 +65,7 @@ obj-$(CONFIG_MAX9611) +=3D max9611.o
> >  obj-$(CONFIG_MCP320X) +=3D mcp320x.o
> >  obj-$(CONFIG_MCP3422) +=3D mcp3422.o
> >  obj-$(CONFIG_MCP3911) +=3D mcp3911.o
> > +obj-$(CONFIG_MEDIATEK_MT6360_ADC) +=3D mt6360-adc.o
> >  obj-$(CONFIG_MEDIATEK_MT6577_AUXADC) +=3D mt6577_auxadc.o
> >  obj-$(CONFIG_MEN_Z188_ADC) +=3D men_z188_adc.o
> >  obj-$(CONFIG_MESON_SARADC) +=3D meson_saradc.o
> > diff --git a/drivers/iio/adc/mt6360-adc.c b/drivers/iio/adc/mt6360-adc.=
c
> > new file mode 100644
> > index 0000000..b256d0a
> > --- /dev/null
> > +++ b/drivers/iio/adc/mt6360-adc.c
> > @@ -0,0 +1,357 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +#include <linux/delay.h>
> > +#include <linux/irq.h>
> > +#include <linux/kernel.h>
> > +#include <linux/ktime.h>
> > +#include <linux/module.h>
> > +#include <linux/mutex.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/regmap.h>
> > +
> > +#include <linux/iio/buffer.h>
> > +#include <linux/iio/iio.h>
> > +#include <linux/iio/trigger_consumer.h>
> > +#include <linux/iio/triggered_buffer.h>
> > +
> > +#define MT6360_REG_PMUCHGCTRL3       0x313
> > +#define MT6360_REG_PMUADCCFG 0x356
> > +#define MT6360_REG_PMUADCIDLET       0x358
> > +#define MT6360_REG_PMUADCRPT1        0x35A
> > +
> > +/* PMUCHGCTRL3 0x313 */
> > +#define MT6360_AICR_MASK     GENMASK(7, 2)
> > +#define MT6360_AICR_SHFT     2
> > +#define MT6360_AICR_400MA    0x6
> > +/* PMUADCCFG 0x356 */
> > +#define MT6360_ADCEN_MASK    0x8000
> > +/* PMUADCRPT1 0x35A */
> > +#define MT6360_PREFERCH_MASK GENMASK(7, 4)
> > +#define MT6360_PREFERCH_SHFT 4
> > +#define MT6360_RPTCH_MASK    GENMASK(3, 0)
> > +#define MT6360_NO_PREFER     15
> > +
> > +/* Time in ms */
> > +#define ADC_WAIT_TIME_MS     25
> > +
> > +enum {
> > +     MT6360_CHAN_USBID =3D 0,
> > +     MT6360_CHAN_VBUSDIV5,
> > +     MT6360_CHAN_VBUSDIV2,
> > +     MT6360_CHAN_VSYS,
> > +     MT6360_CHAN_VBAT,
> > +     MT6360_CHAN_IBUS,
> > +     MT6360_CHAN_IBAT,
> > +     MT6360_CHAN_CHG_VDDP,
> > +     MT6360_CHAN_TEMP_JC,
> > +     MT6360_CHAN_VREF_TS,
> > +     MT6360_CHAN_TS,
> > +     MT6360_CHAN_MAX
> > +};
> > +
> > +struct mt6360_adc_data {
> > +     struct device *dev;
> > +     struct regmap *regmap;
> > +     struct mutex adc_lock;
>
> Please add a comment to document what the scope of the lock is.
>

ACK

> > +     ktime_t last_off_timestamps[MT6360_CHAN_MAX];
> > +};
> > +
> > +static int mt6360_adc_read_channel(struct mt6360_adc_data *mad, int ch=
annel, int *val)
> > +{
> > +     __be16 adc_enable;
> > +     u8 rpt[3];
> > +     ktime_t start_t, predict_end_t;
> > +     unsigned int pre_wait_time;
> > +     int ret;
> > +
> > +     mutex_lock(&mad->adc_lock);
> > +
> > +     /* Select the preferred ADC channel */
> > +     ret =3D regmap_update_bits(mad->regmap, MT6360_REG_PMUADCRPT1, MT=
6360_PREFERCH_MASK,
> > +                              channel << MT6360_PREFERCH_SHFT);
> > +     if (ret)
> > +             goto out_adc_lock;
> > +
> > +     adc_enable =3D cpu_to_be16(MT6360_ADCEN_MASK | BIT(channel));
> > +     ret =3D regmap_raw_write(mad->regmap, MT6360_REG_PMUADCCFG, (void=
 *)&adc_enable,
>
> Shouldn't be any need to cast a pointer explicitly to void *
>

ACK

> > +                            sizeof(__be16));
>
> sizeof(adc_enable) preferred.
>

ACK

> > +     if (ret)
> > +             goto out_adc_lock;
> > +
> > +     start_t =3D ktime_get();
> > +     predict_end_t =3D ktime_add_ms(mad->last_off_timestamps[channel],=
 2 * ADC_WAIT_TIME_MS);
> > +
> > +     if (ktime_after(start_t, predict_end_t))
> > +             pre_wait_time =3D ADC_WAIT_TIME_MS;
> > +     else
> > +             pre_wait_time =3D 3 * ADC_WAIT_TIME_MS;
> > +
> > +     msleep(pre_wait_time);
> > +
> > +     while (true) {
> > +             ret =3D regmap_raw_read(mad->regmap, MT6360_REG_PMUADCRPT=
1, rpt, sizeof(rpt));
> > +             if (ret)
> > +                     goto out_adc_conv;
> > +
> > +             /*
> > +              * There are two functions, ZCV and TypeC OTP, running AD=
C VBAT and TS in
> > +              * background, and ADC samples are taken on a fixed frequ=
ency no matter read the
> > +              * previous one or not.
> > +              * To avoid conflict, We set minimum time threshold after=
 enable ADC and
> > +              * check report channel is the same.
> > +              * The worst case is run the same ADC twice and backgroun=
d function is also running,
> > +              * ADC conversion sequence is desire channel before start=
 ADC, background ADC,
> > +              * desire channel after start ADC.
> > +              * So the minimum correct data is three times of typical =
conversion time.
> > +              */
> > +             if ((rpt[0] & MT6360_RPTCH_MASK) =3D=3D channel)
> > +                     break;
> > +
> > +             msleep(ADC_WAIT_TIME_MS);
> > +     }
> > +
> > +     /* rpt[1]: ADC_HI_BYTE, rpt[2]: ADC_LOW_BYTE */
> > +     *val =3D be16_to_cpup((__be16 *)(rpt + 1));
>
> To be entirely safe, probably need that to be an unaligned read?
>

Maybe I can change to "*val =3D rpt[1] << 8 | rpt[2];".
It's more abvious.

> > +     ret =3D IIO_VAL_INT;
> > +
> > +out_adc_conv:
> > +     /* Only keep ADC enable */
> > +     adc_enable =3D cpu_to_be16(MT6360_ADCEN_MASK);
> > +     regmap_raw_write(mad->regmap, MT6360_REG_PMUADCCFG, (void *)&adc_=
enable, sizeof(__be16));
>
> sizeof(adc_enable)
>

ACK

> > +     mad->last_off_timestamps[channel] =3D ktime_get();
> > +     /* Config prefer channel to NO_PREFER */
> > +     regmap_update_bits(mad->regmap, MT6360_REG_PMUADCRPT1, MT6360_PRE=
FERCH_MASK,
> > +                        MT6360_NO_PREFER << MT6360_PREFERCH_SHFT);
> > +out_adc_lock:
> > +     mutex_unlock(&mad->adc_lock);
> > +
> > +     return ret;
> > +}
> > +
> > +static int mt6360_adc_read_scale(struct mt6360_adc_data *mad, int chan=
nel, int *val, int *val2)
> > +{
> > +     unsigned int regval;
> > +     int ret;
> > +
> > +     switch (channel) {
> > +     case MT6360_CHAN_USBID:
> > +             fallthrough;
>
> I don't think we need fallthrough for cases
> with nothing in them.
>

Every channel needs set " *val =3D 2500" for scale.
Do you mean change as below?

        switch (channel) {
        case MT6360_CHAN_USBID:
        case MT6360_CHAN_VSYS:
        case MT6360_CHAN_VBAT:
        case MT6360_CHAN_CHG_VDDP:
        case MT6360_CHAN_VREF_TS:
                fallthrough;
        case MT6360_CHAN_TS:
                *val =3D 1250;
                return IIO_VAL_INT;

> > +     case MT6360_CHAN_USBID:

> > +     case MT6360_CHAN_VSYS:
> > +             fallthrough;
> > +     case MT6360_CHAN_VBAT:
> > +             fallthrough;
> > +     case MT6360_CHAN_CHG_VDDP:
> > +             fallthrough;
> > +     case MT6360_CHAN_VREF_TS:
> > +             fallthrough;
> > +     case MT6360_CHAN_TS:
> > +             *val =3D 1250;
> > +             return IIO_VAL_INT;
> > +     case MT6360_CHAN_VBUSDIV5:
> > +             *val =3D 6250;
> > +             return IIO_VAL_INT;
> > +     case MT6360_CHAN_VBUSDIV2:
> > +             fallthrough;
> > +     case MT6360_CHAN_IBUS:
> > +             fallthrough;
> > +     case MT6360_CHAN_IBAT:
> > +             *val =3D 2500;
> > +
> > +             if (channel =3D=3D MT6360_CHAN_IBUS) {
> > +                     /* IBUS will be affected by input current limit f=
or the different Ron */
> > +                     /* Check whether the config is <400mA or not */
> > +                     ret =3D regmap_read(mad->regmap, MT6360_REG_PMUCH=
GCTRL3, &regval);
> > +                     if (ret)
> > +                             return ret;
> > +
> > +                     regval =3D (regval & MT6360_AICR_MASK) >> MT6360_=
AICR_SHFT;
> > +                     if (regval < MT6360_AICR_400MA)
> > +                             *val =3D 1900;
> > +             }
> > +
> > +             return IIO_VAL_INT;
> > +     case MT6360_CHAN_TEMP_JC:
> > +             *val =3D 105;
> > +             *val2 =3D 100;
> > +             return IIO_VAL_FRACTIONAL;
> > +     }
> > +
> > +     return -EINVAL;
> > +}
> > +
> > +static int mt6360_adc_read_offset(struct mt6360_adc_data *mad, int cha=
nnel, int *val)
> > +{
> > +     *val =3D (channel =3D=3D MT6360_CHAN_TEMP_JC) ? -80 : 0;
> > +     return IIO_VAL_INT;
> > +
> > +}
> > +
> > +static int mt6360_adc_read_raw(struct iio_dev *iio_dev, const struct i=
io_chan_spec *chan,
> > +                            int *val, int *val2, long mask)
> > +{
> > +     struct mt6360_adc_data *mad =3D iio_priv(iio_dev);
> > +
> > +     switch (mask) {
> > +     case IIO_CHAN_INFO_RAW:
> > +             return mt6360_adc_read_channel(mad, chan->channel, val);
> > +     case IIO_CHAN_INFO_SCALE:
> > +             return mt6360_adc_read_scale(mad, chan->channel, val, val=
2);
> > +     case IIO_CHAN_INFO_OFFSET:
> > +             return mt6360_adc_read_offset(mad, chan->channel, val);
> > +     }
> > +
> > +     return -EINVAL;
> > +}
> > +
> > +static const struct iio_info mt6360_adc_iio_info =3D {
> > +     .read_raw =3D mt6360_adc_read_raw,
> > +};
> > +
> > +#define MT6360_ADC_CHAN(_idx, _type) {                               \
> > +     .type =3D _type,                                          \
> > +     .channel =3D MT6360_CHAN_##_idx,                          \
> > +     .scan_index =3D MT6360_CHAN_##_idx,                       \
> > +     .extend_name =3D #_idx,                                   \
> > +     .datasheet_name =3D #_idx,                                \
> > +     .scan_type =3D  {                                         \
> > +             .sign =3D 'u',                                    \
> > +             .realbits =3D 16,                                 \
> > +             .storagebits =3D 16,                              \
> > +             .endianness =3D IIO_CPU,                          \
> > +     },                                                      \
> > +     .info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |          \
>
> Docs in patch 1 need to reflect this change. Currently they have
> processed channels.
>

ACK

> > +                             BIT(IIO_CHAN_INFO_SCALE) |      \
> > +                             BIT(IIO_CHAN_INFO_OFFSET),      \
> > +}
> > +
> > +static const struct iio_chan_spec mt6360_adc_channels[] =3D {
> > +     MT6360_ADC_CHAN(USBID, IIO_VOLTAGE),
> > +     MT6360_ADC_CHAN(VBUSDIV5, IIO_VOLTAGE),
> > +     MT6360_ADC_CHAN(VBUSDIV2, IIO_VOLTAGE),
> > +     MT6360_ADC_CHAN(VSYS, IIO_VOLTAGE),
> > +     MT6360_ADC_CHAN(VBAT, IIO_VOLTAGE),
> > +     MT6360_ADC_CHAN(IBUS, IIO_CURRENT),
> > +     MT6360_ADC_CHAN(IBAT, IIO_CURRENT),
> > +     MT6360_ADC_CHAN(CHG_VDDP, IIO_VOLTAGE),
> > +     MT6360_ADC_CHAN(TEMP_JC, IIO_TEMP),
> > +     MT6360_ADC_CHAN(VREF_TS, IIO_VOLTAGE),
> > +     MT6360_ADC_CHAN(TS, IIO_VOLTAGE),
> > +     IIO_CHAN_SOFT_TIMESTAMP(MT6360_CHAN_MAX),
> > +};
> > +
> > +static irqreturn_t mt6360_adc_trigger_handler(int irq, void *p)
> > +{
> > +     struct iio_poll_func *pf =3D p;
> > +     struct iio_dev *indio_dev =3D pf->indio_dev;
> > +     struct mt6360_adc_data *mad =3D iio_priv(indio_dev);
> > +     struct {
> > +             u16 values[MT6360_CHAN_MAX];
>
> There is a hole in here I think? (MT6360_CHAN_MAX is 11?)
> If so we need to explicitly memset the structure to avoid any
> risk of kernel data leakage to userspace.
>
> > +             int64_t timestamp;
> > +     } data;
>
> I guess we know this is on a platform with 64bit alignment for int64_t's
> (unlike x86_64 for example)
>

Do you mean change as below?
struct {
    u16 values[MT6360_CHAN_MAX];
    int64_t timestamp; __aligned(8)
} data;

> > +     int i =3D 0, bit, val, ret;
> > +
> > +     for_each_set_bit(bit, indio_dev->active_scan_mask, indio_dev->mas=
klength) {
> > +             ret =3D mt6360_adc_read_channel(mad, bit, &val);
> > +             if (ret < 0) {
> > +                     dev_warn(&indio_dev->dev, "Failed to get channel =
%d conversion val\n", bit);
> > +                     goto out;
> > +             }
> > +
> > +             data.values[i++] =3D val;
> > +     }
> > +     iio_push_to_buffers_with_timestamp(indio_dev, &data, iio_get_time=
_ns(indio_dev));
> > +out:
> > +     iio_trigger_notify_done(indio_dev->trig);
> > +
> > +     return IRQ_HANDLED;
> > +}
> > +
> > +static inline int mt6360_adc_reset(struct mt6360_adc_data *info)
> > +{
> > +     __be16 adc_enable;
> > +     ktime_t all_off_time;
> > +     int i, ret;
> > +
> > +     /* Clear ADC idle wait time to 0 */
> > +     ret =3D regmap_write(info->regmap, MT6360_REG_PMUADCIDLET, 0);
> > +     if (ret)
> > +             return ret;
> > +
> > +     /* Only keep ADC enable, but keep all channels off */
> > +     adc_enable =3D cpu_to_be16(MT6360_ADCEN_MASK);
> > +     ret =3D regmap_raw_write(info->regmap, MT6360_REG_PMUADCCFG, (voi=
d *)&adc_enable,
> > +                            sizeof(__be16));
> > +     if (ret)
> > +             return ret;
> > +
> > +     /* Reset all channel off time to the current one */
> > +     all_off_time =3D ktime_get();
> > +     for (i =3D 0; i < MT6360_CHAN_MAX; i++)
> > +             info->last_off_timestamps[i] =3D all_off_time;
> > +
> > +     return 0;
> > +}
> > +
> > +static int mt6360_adc_probe(struct platform_device *pdev)
> > +{
> > +     struct mt6360_adc_data *mad;
> > +     struct regmap *regmap;
> > +     struct iio_dev *indio_dev;
> > +     int ret;
> > +
> > +     regmap =3D dev_get_regmap(pdev->dev.parent, NULL);
> > +     if (!regmap) {
> > +             dev_err(&pdev->dev, "Failed to get parent regmap\n");
> > +             return -ENODEV;
> > +     }
> > +
> > +     indio_dev =3D devm_iio_device_alloc(&pdev->dev, sizeof(*mad));
> > +     if (!indio_dev)
> > +             return -ENOMEM;
> > +
> > +     mad =3D iio_priv(indio_dev);
> > +     mad->dev =3D &pdev->dev;
> > +     mad->regmap =3D regmap;
> > +     mutex_init(&mad->adc_lock);
> > +
> > +     ret =3D mt6360_adc_reset(mad);
> > +     if (ret < 0) {
> > +             dev_err(&pdev->dev, "Failed to reset adc\n");
> > +             return ret;
> > +     }
> > +
> > +     indio_dev->name =3D dev_name(&pdev->dev);
> > +     indio_dev->dev.parent =3D &pdev->dev;
> > +     indio_dev->info =3D &mt6360_adc_iio_info;
> > +     indio_dev->modes =3D INDIO_DIRECT_MODE;
> > +     indio_dev->channels =3D mt6360_adc_channels;
> > +     indio_dev->num_channels =3D ARRAY_SIZE(mt6360_adc_channels);
> > +
> > +     ret =3D devm_iio_triggered_buffer_setup(&pdev->dev, indio_dev, NU=
LL,
> > +                                           mt6360_adc_trigger_handler,=
 NULL);
> > +     if (ret) {
> > +             dev_err(&pdev->dev, "Failed to allocate iio trigger buffe=
r\n");
> > +             return ret;
> > +     }
> > +
> > +     return devm_iio_device_register(&pdev->dev, indio_dev);
> > +}
> > +
> > +static const struct of_device_id __maybe_unused mt6360_adc_of_id[] =3D=
 {
> > +     { .compatible =3D "mediatek,mt6360-adc", },
> > +     {}
> > +};
> > +MODULE_DEVICE_TABLE(of, mt6360_adc_of_id);
> > +
> > +static struct platform_driver mt6360_adc_driver =3D {
> > +     .driver =3D {
> > +             .name =3D "mt6360-adc",
> > +             .of_match_table =3D mt6360_adc_of_id,
> > +     },
> > +     .probe =3D mt6360_adc_probe,
> > +};
> > +module_platform_driver(mt6360_adc_driver);
> > +
> > +MODULE_AUTHOR("Gene Chen <gene_chen@richtek.com>");
> > +MODULE_DESCRIPTION("MT6360 ADC Driver");
> > +MODULE_LICENSE("GPL v2");
>
