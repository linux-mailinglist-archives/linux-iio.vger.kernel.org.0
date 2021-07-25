Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D52DB3D4D4F
	for <lists+linux-iio@lfdr.de>; Sun, 25 Jul 2021 14:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbhGYLi7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 25 Jul 2021 07:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbhGYLi6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 25 Jul 2021 07:38:58 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4523C061757;
        Sun, 25 Jul 2021 05:19:21 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id x192so10103704ybe.0;
        Sun, 25 Jul 2021 05:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bkQVrzukn+ApNOCz4kuOqiC74G71+4kJpa7NC6+JEmg=;
        b=Zcnkq0BjZhToZQm95pojEH5LxOAHV/jxmWgkBY491S1vQN7QzJdcUyp0Gt/Dr6KOAz
         UCeQzd/hZwUC62zHkAKiERRaOY5r0c+ByHLphwuqZzIYFfMEQudDl0i6BoJoCrdSi5Z5
         rZ43Cf1M4jkIfH9vOPYNpvJf5zS+cB5eC5CZuV77rRgRmcobPBQUwc4i5dDIK5NOqxWV
         nHjrkq7bfG+8mqB+r7jTjEy4SZ6koj1ePGmBCJVyTtB8TXLMkeQwm5spc+eUNTtdTdEM
         06XOFqvp84xz7ml1mdruer2P073vwCFFoEm2MeCc7dRBX2nB75l9mVPAUCz2QtN9v2CT
         cAog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bkQVrzukn+ApNOCz4kuOqiC74G71+4kJpa7NC6+JEmg=;
        b=SQ7/arhY6/bumkkgyx7LiXxVMHqvwNv/aN+U6S110XAFWyM6Nt+JQlYvl+k3nlTW6F
         hXExqHzBSiMnMXHQ+7T29fCYnQklm+Sne850uTtREM4Oh2brMGE2xRyGeB1tGV38bqx4
         YocjsADUuOrD+NqHijTgwAIhx/yASlXOxgjR3OMrogJrW2KVUwtquL6KvoaVHixh2b3G
         1RwlrYGGRXbKMfNKaTqDScFDILTsPQpmzbmeF0EEV0kXb0veE8oG6UNpVhgA5lHuvOS5
         EJTw/t8BT0N89LR/T5FQcoYoYPh5Kvo0WBX4djVWnhzU7pwT7pFiKiKdyePQyRrZiJ10
         oenA==
X-Gm-Message-State: AOAM5329kjTiBCZ6yxFod/TFt+Z77aXl5fIUdkQuwy2qK4MEeHa2wAsr
        2ue0mOGkqy8k7t+lm73ah0xKi3J3ODMEoRWMoRw=
X-Google-Smtp-Source: ABdhPJxcajM3aPhdwuXev6H/6uEiZ63XQZm8OxtFD/75OBZcJxp+kLPJ5rG18OkGiH3AvmiU6JByIYW9IN0xVEQWJsA=
X-Received: by 2002:a5b:b48:: with SMTP id b8mr17268699ybr.179.1627215560381;
 Sun, 25 Jul 2021 05:19:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210719085840.21842-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20210719085840.21842-3-prabhakar.mahadev-lad.rj@bp.renesas.com> <20210724190601.084d43e7@jic23-huawei>
In-Reply-To: <20210724190601.084d43e7@jic23-huawei>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Sun, 25 Jul 2021 13:18:53 +0100
Message-ID: <CA+V-a8v28TuGa9Vay9wraRetEK4XZBm6BU4USZYTdFR4BkwBBQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] iio: adc: Add driver for Renesas RZ/G2L A/D converter
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh+dt@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

Thank you for the review.

On Sat, Jul 24, 2021 at 7:03 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Mon, 19 Jul 2021 09:58:38 +0100
> Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
>
> > Add ADC driver support for Renesas RZ/G2L A/D converter in SW
> > trigger mode.
> >
> > A/D Converter block is a successive approximation analog-to-digital
> > converter with a 12-bit accuracy and supports a maximum of 8 input
> > channels.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
>
> Hi Lad,
>
> A few additional comments inline.
>
> Thanks,
>
> Jonathan
>
> > ---
> >  MAINTAINERS                 |   8 +
> >  drivers/iio/adc/Kconfig     |  10 +
> >  drivers/iio/adc/Makefile    |   1 +
> >  drivers/iio/adc/rzg2l_adc.c | 545 ++++++++++++++++++++++++++++++++++++
> >  4 files changed, 564 insertions(+)
> >  create mode 100644 drivers/iio/adc/rzg2l_adc.c
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 6c8be735cc91..6a52f9f4604c 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -15839,6 +15839,14 @@ L:   linux-renesas-soc@vger.kernel.org
> >  S:   Maintained
> >  F:   drivers/phy/renesas/phy-rcar-gen3-usb*.c
> >
> > +RENESAS RZ/G2L A/D DRIVER
> > +M:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > +L:   linux-iio@vger.kernel.org
> > +L:   linux-renesas-soc@vger.kernel.org
> > +S:   Supported
> > +F:   Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml
> > +F:   drivers/iio/adc/rzg2l_adc.c
> > +
> >  RESET CONTROLLER FRAMEWORK
> >  M:   Philipp Zabel <p.zabel@pengutronix.de>
> >  S:   Maintained
> > diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> > index db0c8fb60515..af168e1c9fdb 100644
> > --- a/drivers/iio/adc/Kconfig
> > +++ b/drivers/iio/adc/Kconfig
> > @@ -887,6 +887,16 @@ config ROCKCHIP_SARADC
> >         To compile this driver as a module, choose M here: the
> >         module will be called rockchip_saradc.
> >
> > +config RZG2L_ADC
> > +     tristate "Renesas RZ/G2L ADC driver"
> > +     depends on ARCH_R9A07G044 || COMPILE_TEST
> > +     help
> > +       Say yes here to build support for the ADC found in Renesas
> > +       RZ/G2L family.
> > +
> > +       To compile this driver as a module, choose M here: the
> > +       module will be called rzg2l_adc.
> > +
> >  config SC27XX_ADC
> >       tristate "Spreadtrum SC27xx series PMICs ADC"
> >       depends on MFD_SC27XX_PMIC || COMPILE_TEST
> > diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> > index f70d877c555a..d68550f493e3 100644
> > --- a/drivers/iio/adc/Makefile
> > +++ b/drivers/iio/adc/Makefile
> > @@ -82,6 +82,7 @@ obj-$(CONFIG_QCOM_PM8XXX_XOADC) += qcom-pm8xxx-xoadc.o
> >  obj-$(CONFIG_RCAR_GYRO_ADC) += rcar-gyroadc.o
> >  obj-$(CONFIG_RN5T618_ADC) += rn5t618-adc.o
> >  obj-$(CONFIG_ROCKCHIP_SARADC) += rockchip_saradc.o
> > +obj-$(CONFIG_RZG2L_ADC) += rzg2l_adc.o
> >  obj-$(CONFIG_SC27XX_ADC) += sc27xx_adc.o
> >  obj-$(CONFIG_SPEAR_ADC) += spear_adc.o
> >  obj-$(CONFIG_STX104) += stx104.o
> > diff --git a/drivers/iio/adc/rzg2l_adc.c b/drivers/iio/adc/rzg2l_adc.c
> > new file mode 100644
> > index 000000000000..033cdec9e976
> > --- /dev/null
> > +++ b/drivers/iio/adc/rzg2l_adc.c
> > @@ -0,0 +1,545 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * RZ/G2L A/D Converter driver
> > + *
> > + *  Copyright (c) 2021 Renesas Electronics Europe GmbH
> > + *
> > + * Author: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > + */
> > +
> > +#include <linux/clk.h>
> > +#include <linux/completion.h>
> > +#include <linux/delay.h>
> > +#include <linux/iio/iio.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/io.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/of_device.h>
>
> Add mod_devicetable.h and drop the of specific headers
> as nothing in them used directly as far as I can tell.
>
OK.

> > +#include <linux/platform_device.h>
> > +#include <linux/pm_runtime.h>
> > +#include <linux/reset.h>
> > +
> > +#define DRIVER_NAME          "rzg2l-adc"
> > +
> > +#define RZG2L_ADM(n)                 ((n) * 0x4)
> > +#define RZG2L_ADM0_ADCE                      BIT(0)
> > +#define RZG2L_ADM0_ADBSY             BIT(1)
> > +#define RZG2L_ADM0_PWDWNB            BIT(2)
> > +#define RZG2L_ADM0_SRESB             BIT(15)
> > +#define RZG2L_ADM1_TRG                       BIT(0)
> > +#define RZG2L_ADM1_MS                        BIT(2)
> > +#define RZG2L_ADM1_BS                        BIT(4)
> > +#define RZG2L_ADM1_EGA_CLEAR         ~GENMASK(13, 12)
> > +#define RZG2L_ADM2_CHSEL_CLEAR               ~GENMASK(7, 0)
>
> I'd rather see these defined as _MASK and the
> inversion made explicit inline.
>
OK will use them as _MASK's and invert inline when required.

> > +#define RZG2L_ADM3_ADSMP             0x578
> > +#define RZG2L_ADM3_ADCMP             (0xe << 16)
> > +#define RZG2L_ADM3_ADIL_CLEAR                ~GENMASK(31, 24)
> > +
> > +#define RZG2L_ADINT                  0x20
> > +#define RZG2L_ADINT_CH_CLEAR         ~GENMASK(7, 0)
> > +#define RZG2L_ADINT_CSEEN            BIT(16)
> > +#define RZG2L_ADINT_INTS             BIT(31)
> > +#define RZG2L_ADSTS                  0x24
> > +#define RZG2L_ADINT_INTST_MASK               GENMASK(7, 0)
> > +#define RZG2L_ADSTS_CSEST            BIT(16)
> > +#define RZG2L_ADIVC                  0x28
> > +#define RZG2L_ADIVC_DIVADC_CLEAR     ~GENMASK(8, 0)
> > +#define RZG2L_ADIVC_DIVADC_4         0x4
>
> Perhaps adopt the _MASK and FIELD_PREP() approach to setting
> particular values.  That way it is obvious at the call site that
> DVADC_4 is a value within the DIVADC_MASK covered field.
>
Agreed will change that.

> > +#define RZG2L_ADFIL                  0x2c
> > +#define RZG2L_ADCR(n)                        (0x30 + ((n) * 0x4))
> > +#define RZG2L_ADCR_AD_MASK           GENMASK(11, 0)
> > +
> > +#define RZG2L_ADC_MAX_CHANNELS               8
> > +#define RZG2L_ADC_CHN_MASK           0x7
> > +#define RZG2L_ADC_TIMEOUT            usecs_to_jiffies(1 * 4)
> > +
> > +struct rzg2l_adc_data {
> > +     const struct iio_chan_spec *channels;
> > +     u8 num_channels;
> > +};
> > +
> > +struct rzg2l_adc {
> > +     void __iomem *base;
> > +     struct clk *pclk;
> > +     struct clk *adclk;
> > +     struct reset_control *presetn;
> > +     struct reset_control *adrstn;
> > +     struct completion completion;
> > +     const struct rzg2l_adc_data *data;
> > +     u16 last_val[RZG2L_ADC_MAX_CHANNELS];
> > +};
> > +
> > +static const char * const rzg2l_adc_channel_name[] = {
> > +     "adc0",
> Is it useful to expose these as labels to userspace?
> Seems unnecessary given they map directly to the channel
> numbers.
>
Exposing  them as this may vary depending on the wiring on the board,
so it  would be better for user space to know which channels are
available.

> > +     "adc1",
> > +     "adc2",
> > +     "adc3",
> > +     "adc4",
> > +     "adc5",
> > +     "adc6",
> > +     "adc7",
> > +};
> > +
> > +static unsigned int rzg2l_adc_readl(struct rzg2l_adc *adc, u32 reg)
> > +{
> > +     return readl(adc->base + reg);
> > +}
> > +
> > +static void rzg2l_adc_writel(struct rzg2l_adc *adc, unsigned int reg, u32 val)
> > +{
> > +     writel(val, adc->base + reg);
> > +}
> > +
> > +static void rzg2l_adc_pwr(struct rzg2l_adc *adc, bool on)
> > +{
> > +     u32 reg;
> > +
> > +     reg = rzg2l_adc_readl(adc, RZG2L_ADM(0));
> > +     if (on)
> > +             reg |= RZG2L_ADM0_PWDWNB;
> > +     else
> > +             reg &= ~RZG2L_ADM0_PWDWNB;
> > +     rzg2l_adc_writel(adc, RZG2L_ADM(0), reg);
> > +     udelay(2);
> > +}
> > +
> > +static void rzg2l_adc_start_stop(struct rzg2l_adc *adc, bool start)
> > +{
> > +     int timeout = 5;
> > +     u32 reg;
> > +
> > +     /* stop A/D conversion */
> > +     reg = rzg2l_adc_readl(adc, RZG2L_ADM(0));
> > +     if (start)
> > +             reg |= RZG2L_ADM0_ADCE;
> > +     else
> > +             reg &= ~RZG2L_ADM0_ADCE;
> > +     rzg2l_adc_writel(adc, RZG2L_ADM(0), reg);
> > +
> > +     if (start)
> > +             return;
> > +
> > +     do {
> > +             usleep_range(100, 200);
> > +             reg = rzg2l_adc_readl(adc, RZG2L_ADM(0));
> > +             timeout--;
> > +             if (!timeout) {
> > +                     pr_err("%s stopping ADC timed out\n", __func__);
> > +                     break;
> > +             }
> > +     } while (((reg & RZG2L_ADM0_ADBSY) || (reg & RZG2L_ADM0_ADCE)));
> > +}
> > +
> > +static void rzg2l_set_trigger(struct rzg2l_adc *adc)
> > +{
> > +     u32 reg;
> > +
> > +     /* SW trigger */
> > +     reg = rzg2l_adc_readl(adc, RZG2L_ADM(1));
> > +     reg &= RZG2L_ADM1_EGA_CLEAR;
> > +     reg &= ~RZG2L_ADM1_BS;
> > +     reg |= RZG2L_ADM1_MS;
> > +     reg &= ~RZG2L_ADM1_TRG;
> > +     rzg2l_adc_writel(adc, RZG2L_ADM(1), reg);
> > +}
> > +
> > +static int rzg2l_adc_conversion_setup(struct rzg2l_adc *adc, u8 ch)
> > +{
> > +     u32 reg;
> > +
> > +     if (rzg2l_adc_readl(adc, RZG2L_ADM(0)) & RZG2L_ADM0_ADBSY)
> > +             return -EBUSY;
> > +
> > +     rzg2l_set_trigger(adc);
> > +
> > +     /* select channel */
> > +     reg = rzg2l_adc_readl(adc, RZG2L_ADM(2));
> > +     reg &= RZG2L_ADM2_CHSEL_CLEAR;
> > +     reg |= BIT(ch);
> > +     rzg2l_adc_writel(adc, RZG2L_ADM(2), reg);
> > +
> > +     reg = rzg2l_adc_readl(adc, RZG2L_ADM(3));
> > +     reg &= RZG2L_ADM3_ADIL_CLEAR;
> > +     reg |= RZG2L_ADM3_ADCMP;
> > +     reg |= RZG2L_ADM3_ADSMP;
>
> No loss in readability in combining the two lines above and shorter
> code is always good.  Having the mask on a separate line makes
> sense but the |= pair doesn't.
>
Agreed will move to the same line.

> What is a bit unusual here is you clear some bits then write different
> ones.  That is presumably relying on the fact that the ADCCMP part
> is always set to the same value.  That seems unwise to assume from
> a long term maintainability point of view.
>
The ADIL bits have to be set to zero, so I am clearing the ADIL bits
(bit 24-bits 31) and the ADCMP/ADSMP should be set to specific values
oxe/0x578 respectively.

> > +     rzg2l_adc_writel(adc, RZG2L_ADM(3), reg);
> > +
> > +     reg = rzg2l_adc_readl(adc, RZG2L_ADIVC);
> > +     reg &= RZG2L_ADIVC_DIVADC_CLEAR;
> > +     reg |= RZG2L_ADIVC_DIVADC_4;
> > +     rzg2l_adc_writel(adc, RZG2L_ADIVC, reg);
> > +
> > +     reg = rzg2l_adc_readl(adc, RZG2L_ADINT);
> > +     reg &= ~RZG2L_ADINT_INTS;
> > +     reg &= RZG2L_ADINT_CH_CLEAR;
> > +     reg |= RZG2L_ADINT_CSEEN;
> > +     reg |= BIT(ch);
> > +     rzg2l_adc_writel(adc, RZG2L_ADINT, reg);
> > +
> > +     return 0;
> > +}
> > +
> > +static int rzg2l_adc_set_power(struct iio_dev *indio_dev, bool on)
> > +{
> > +     struct device *dev = indio_dev->dev.parent;
> > +
> > +     if (on)
> > +             return pm_runtime_resume_and_get(dev);
> > +
> > +     return pm_runtime_put_sync(dev);
> > +}
> > +
> > +static int rzg2l_adc_conversion(struct iio_dev *indio_dev, struct rzg2l_adc *adc, u8 ch)
> > +{
> > +     int ret;
> > +
> > +     ret = rzg2l_adc_set_power(indio_dev, true);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret = rzg2l_adc_conversion_setup(adc, ch);
> > +     if (ret) {
> > +             rzg2l_adc_set_power(indio_dev, false);
> > +             return ret;
> > +     }
> > +
> > +     reinit_completion(&adc->completion);
> > +
> > +     rzg2l_adc_start_stop(adc, true);
> > +
> > +     if (!wait_for_completion_timeout(&adc->completion, RZG2L_ADC_TIMEOUT)) {
> > +             rzg2l_adc_writel(adc, RZG2L_ADINT,
> > +                              rzg2l_adc_readl(adc, RZG2L_ADINT) & RZG2L_ADINT_CH_CLEAR);
> > +             rzg2l_adc_start_stop(adc, false);
> > +             rzg2l_adc_set_power(indio_dev, false);
> > +             return -ETIMEDOUT;
> > +     }
> > +
> > +     return rzg2l_adc_set_power(indio_dev, false);
> > +}
> > +
> > +static int rzg2l_adc_read_raw(struct iio_dev *indio_dev,
> > +                           struct iio_chan_spec const *chan,
> > +                           int *val, int *val2, long mask)
> > +{
> > +     struct rzg2l_adc *adc = iio_priv(indio_dev);
> > +     int ret;
> > +     u8 ch;
> > +
> > +     switch (mask) {
> > +     case IIO_CHAN_INFO_RAW:
> > +             if (chan->type != IIO_VOLTAGE)
> > +                     return -EINVAL;
> > +
> > +             ret = iio_device_claim_direct_mode(indio_dev);
> > +             if (ret)
> > +                     return ret;
> > +
> > +             ch = chan->channel & RZG2L_ADC_CHN_MASK;
> > +             ret = rzg2l_adc_conversion(indio_dev, adc, ch);
> > +             if (ret) {
> > +                     iio_device_release_direct_mode(indio_dev);
> > +                     return ret;
> > +             }
> > +             *val = adc->last_val[ch];
> > +             iio_device_release_direct_mode(indio_dev);
> > +
> > +             return IIO_VAL_INT;
> > +
> > +     default:
> > +             return -EINVAL;
> > +     }
> > +}
> > +
> > +static int rzg2l_adc_read_label(struct iio_dev *iio_dev,
> > +                             const struct iio_chan_spec *chan,
> > +                             char *label)
> > +{
> > +     if (chan->channel >= RZG2L_ADC_MAX_CHANNELS)
> > +             return -EINVAL;
> > +
> > +     return snprintf(label, PAGE_SIZE, "%s\n", rzg2l_adc_channel_name[chan->channel]);
>
> sysfs_emit()?.
>
OK

> > +}
> > +
> > +static const struct iio_info rzg2l_adc_iio_info = {
> > +     .read_raw = rzg2l_adc_read_raw,
> > +     .read_label = rzg2l_adc_read_label,
> > +};
> > +
> > +static irqreturn_t rzg2l_adc_isr(int irq, void *dev_id)
> > +{
> > +     struct rzg2l_adc *adc = (struct rzg2l_adc *)dev_id;
> > +     u8 intst;
> > +     u32 reg;
> > +     u8 i;
> > +
> > +     reg = rzg2l_adc_readl(adc, RZG2L_ADSTS);
> > +     if (reg & RZG2L_ADSTS_CSEST) {
>
> Probably good to add a brief comment on what is going on in this check.
> Perhaps even an error print if it's an error path.
>
Agreed will add a comment, this condition happens on channel selection error.

> > +             rzg2l_adc_writel(adc, RZG2L_ADSTS, reg);
> > +             return IRQ_HANDLED;
> > +     }
> > +
> > +     intst = reg & RZG2L_ADINT_INTST_MASK;
> > +     if (!intst)
>
> I'm guessing this means spurious interrupt in which case IRQ_NONE
> so the core irq code knows about it.
>
Agreed IRQ_NONE should be returned.

> > +             return IRQ_HANDLED;
> > +
> > +     for (i = 0; i < RZG2L_ADC_MAX_CHANNELS; i++) {
> > +             if (intst & BIT(i))
>
> for_each_bit_set() and make intst a long so the types are right for
> that macro
>
>
Agreed will do.

> > +                     adc->last_val[i] = rzg2l_adc_readl(adc, RZG2L_ADCR(i)) & RZG2L_ADCR_AD_MASK;
> > +     }
> > +
> > +     rzg2l_adc_writel(adc, RZG2L_ADSTS, reg);
> > +
> > +     complete(&adc->completion);
> > +
> > +     return IRQ_HANDLED;
> > +}
> > +
> > +static int rzg2l_adc_parse_of(struct platform_device *pdev, struct rzg2l_adc *adc)
> > +{
> > +     struct iio_chan_spec *chan_array;
> > +     struct fwnode_handle *fwnode;
> > +     struct rzg2l_adc_data *data;
> > +     unsigned int channel;
> > +     int num_channels;
> > +     int ret;
> > +     u8 i;
> > +
> > +     data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
> > +     if (!data)
> > +             return -ENOMEM;
> > +
> > +     num_channels = device_get_child_node_count(&pdev->dev);
> > +     if (!num_channels) {
> > +             dev_err(&pdev->dev, "no channel children\n");
> > +             return -ENODEV;
> > +     }
> > +
> > +     if (num_channels > RZG2L_ADC_MAX_CHANNELS) {
> > +             dev_err(&pdev->dev, "num of channel children out of range\n");
> > +             return -EINVAL;
> > +     }
> > +
> > +     chan_array = devm_kcalloc(&pdev->dev, num_channels, sizeof(*chan_array),
> > +                               GFP_KERNEL);
> > +     if (!chan_array)
> > +             return -ENOMEM;
> > +
> > +     i = 0;
> > +     device_for_each_child_node(&pdev->dev, fwnode) {
> > +             ret = fwnode_property_read_u32(fwnode, "reg", &channel);
> > +             if (ret)
> > +                     return ret;
> > +
> > +             if (channel >= RZG2L_ADC_MAX_CHANNELS)
> > +                     return -EINVAL;
> > +
> > +             chan_array[i].type = IIO_VOLTAGE;
> > +             chan_array[i].indexed = 1;
> > +             chan_array[i].channel = channel;
> > +             chan_array[i].info_mask_separate = BIT(IIO_CHAN_INFO_RAW);
> > +             chan_array[i].datasheet_name = rzg2l_adc_channel_name[channel];
> > +             i++;
> > +     }
> > +
> > +     data->num_channels = num_channels;
> > +     data->channels = chan_array;
> > +     adc->data = data;
> > +
> > +     return 0;
> > +}
> > +
> > +static int rzg2l_adc_sw_reset(struct rzg2l_adc *adc)
> > +{
> > +     int timeout = 5;
> > +     u32 val;
> > +
> > +     val = rzg2l_adc_readl(adc, RZG2L_ADM(0));
> > +     val |= RZG2L_ADM0_SRESB;
> > +     rzg2l_adc_writel(adc, RZG2L_ADM(0), val);
> > +
> > +     while (!(rzg2l_adc_readl(adc, RZG2L_ADM(0)) & RZG2L_ADM0_SRESB)) {
> > +             if (!timeout)
> > +                     return -EBUSY;
> > +             timeout--;
> > +             usleep_range(100, 200);
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static int rzg2l_adc_probe(struct platform_device *pdev)
> > +{
> > +     struct device *dev = &pdev->dev;
> > +     struct iio_dev *indio_dev;
> > +     struct rzg2l_adc *adc;
> > +     int ret;
> > +     int irq;
> > +
> > +     indio_dev = devm_iio_device_alloc(dev, sizeof(*adc)
> > +     if (!indio_dev)
> > +             return -ENOMEM;
> > +
> > +     adc = iio_priv(indio_dev);
> > +
> > +     ret = rzg2l_adc_parse_of(pdev, adc);
>
> *_parse_properties() or *_parse_firmware()
> as it's not of specific now.
>
OK will rename it to rzg2l_adc_parse_properties().

> > +     if (ret)
> > +             return ret;
> > +
> > +     adc->base = devm_platform_ioremap_resource(pdev, 0);
> > +     if (IS_ERR(adc->base))
> > +             return PTR_ERR(adc->base);
> > +
> > +     irq = platform_get_irq(pdev, 0);
> > +     if (irq < 0) {
> > +             dev_err(dev, "no irq resource\n");
> > +             return irq;
> > +     }
> > +
> > +     adc->pclk = devm_clk_get(dev, "pclk");
> > +     if (IS_ERR(adc->pclk)) {
> > +             dev_err(dev, "Failed to get pclk");
> > +             return PTR_ERR(adc->pclk);
> > +     }
> > +
> > +     adc->adclk = devm_clk_get(dev, "adclk");
> > +     if (IS_ERR(adc->adclk)) {
> > +             dev_err(dev, "Failed to get adclk");
> > +             return PTR_ERR(adc->adclk);
> > +     }
> > +
> > +     adc->adrstn = devm_reset_control_get_exclusive(dev, "adrst-n");
> > +     if (IS_ERR(adc->adrstn)) {
> > +             dev_err(dev, "failed to get adrstn\n");
> > +             return PTR_ERR(adc->adrstn);
> > +     }
> > +
> > +     adc->presetn = devm_reset_control_get_exclusive(dev, "presetn");
> > +     if (IS_ERR(adc->presetn)) {
> > +             dev_err(dev, "failed to get presetn\n");
> > +             return PTR_ERR(adc->presetn);
> > +     }
> > +
> > +     ret = reset_control_deassert(adc->adrstn);
> > +     if (ret)
> > +             return ret;
>
> devm_add_action_or_reset() here to make the reasserting of these part
> of the automated cleanup.
>
OK will use devm_add_action_or_reset().

> > +
> > +     ret = reset_control_deassert(adc->presetn);
> > +     if (ret)
> > +             goto assert_adrstn;
> > +
> > +     ret = clk_prepare_enable(adc->pclk);
> > +     if (ret)
> > +             goto assert_presetn;
> > +
> > +     ret = rzg2l_adc_sw_reset(adc);
> > +     if (ret)
> > +             goto unprepare_pclk;
> > +
> > +     clk_disable_unprepare(adc->pclk);
>
> As below, reorder as:
>
>         ret = rzg2l_adc_sw_reset(adc);
>         clk_disable_unprepare(adc->pclk);
>         if (ret)
>                 goto assert_preset_n;
>
Agreed.

> > +
> > +     init_completion(&adc->completion);
> > +
> > +     platform_set_drvdata(pdev, indio_dev);
> > +
> > +     ret = devm_request_irq(dev, irq, rzg2l_adc_isr,
> > +                            0, dev_name(dev), adc);
>
> Another aspect of the comment below about mixing and matching between
> devm and not.  If the order of remove is not that opposite of probe
> then there should be a comment saying why.  There are far too many
> race conditions introduced by people doing things in a different order
> without carefully considering why.
>
Agreed will completely move to devm

> > +     if (ret < 0)
> > +             goto assert_presetn;
> > +
> > +     indio_dev->name = DRIVER_NAME;
> > +     indio_dev->info = &rzg2l_adc_iio_info;
> > +     indio_dev->modes = INDIO_DIRECT_MODE;
> > +     indio_dev->channels = adc->data->channels;
> > +     indio_dev->num_channels = adc->data->num_channels;
> > +
> > +     pm_runtime_enable(dev);
> > +
> > +     ret = devm_iio_device_register(dev, indio_dev);
> > +     if (ret)
> > +             goto err_iio_device_register;
> > +
> > +     return 0;
> > +
> > +unprepare_pclk:
> > +     clk_disable_unprepare(adc->pclk);
>
> Bad sign that you have this here and not in remove..
> When you have cases like this, it's normally better to
> either factor out the relevant code into a function
> that lets you do this call whether or not there is an
> error, or to just move this up to the relevant if statements.
>
As agreed above, will alter the code.

>
> > +err_iio_device_register:
> > +     pm_runtime_disable(dev);
> > +assert_presetn:
> > +     reset_control_assert(adc->presetn);
> > +assert_adrstn:
> > +     reset_control_assert(adc->adrstn);
> > +     return ret;
> > +}
> > +
> > +static int rzg2l_adc_remove(struct platform_device *pdev)
> > +{
> > +     struct iio_dev *indio_dev = platform_get_drvdata(pdev);
> > +     struct rzg2l_adc *adc = iio_priv(indio_dev);
> > +
> > +     reset_control_assert(adc->presetn);
> > +     reset_control_assert(adc->adrstn);
> > +     pm_runtime_disable(indio_dev->dev.parent);
>
> You can't mix and match devm managed and unmanaged like this.
> The userspace interfce is still exposed after you've put the
> device into reset which is unlikely to be a good idea.
>
> One option is to use devm_add_action_or_reset() to make
> this stuff happen in the managed flow, which happens after
> remove is done.  That would let you drop remove() entirely.
>
Agreed will use devm_add_action_or_reset() and get rid of remove callback().

Cheers,
Prabhakar
>
> > +
> > +     return 0;
> > +}
> > +
> > +static const struct of_device_id rzg2l_adc_match[] = {
> > +     { .compatible = "renesas,rzg2l-adc",},
> > +     { /* sentinel */ }
> > +};
> > +MODULE_DEVICE_TABLE(of, rzg2l_adc_match);
> > +
> > +static int __maybe_unused rzg2l_adc_pm_runtime_suspend(struct device *dev)
> > +{
> > +     struct iio_dev *indio_dev = dev_get_drvdata(dev);
> > +     struct rzg2l_adc *adc = iio_priv(indio_dev);
> > +
> > +     rzg2l_adc_pwr(adc, false);
> > +     clk_disable_unprepare(adc->adclk);
> > +     clk_disable_unprepare(adc->pclk);
> > +
> > +     return 0;
> > +}
> > +
> > +static int __maybe_unused rzg2l_adc_pm_runtime_resume(struct device *dev)
> > +{
> > +     struct iio_dev *indio_dev = dev_get_drvdata(dev);
> > +     struct rzg2l_adc *adc = iio_priv(indio_dev);
> > +     int ret;
> > +
> > +     ret = clk_prepare_enable(adc->pclk);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret = clk_prepare_enable(adc->adclk);
> > +     if (ret)
> > +             return ret;
> > +
> > +     rzg2l_adc_pwr(adc, true);
> > +
> > +     return 0;
> > +}
> > +
> > +static const struct dev_pm_ops rzg2l_adc_pm_ops = {
> > +     SET_RUNTIME_PM_OPS(rzg2l_adc_pm_runtime_suspend,
> > +                        rzg2l_adc_pm_runtime_resume,
> > +                        NULL)
> > +};
> > +
> > +static struct platform_driver rzg2l_adc_driver = {
> > +     .probe          = rzg2l_adc_probe,
> > +     .remove         = rzg2l_adc_remove,
> > +     .driver         = {
> > +             .name           = DRIVER_NAME,
> > +             .of_match_table = rzg2l_adc_match,
> > +             .pm             = &rzg2l_adc_pm_ops,
> > +     },
> > +};
> > +
> > +module_platform_driver(rzg2l_adc_driver);
> > +
> > +MODULE_AUTHOR("Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>");
> > +MODULE_DESCRIPTION("Renesas RZ/G2L ADC driver");
> > +MODULE_LICENSE("GPL v2");
>
