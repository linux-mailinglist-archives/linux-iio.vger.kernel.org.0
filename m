Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 087633C9311
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jul 2021 23:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235706AbhGNV3R (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 14 Jul 2021 17:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235700AbhGNV3Q (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 14 Jul 2021 17:29:16 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2A1CC06175F;
        Wed, 14 Jul 2021 14:26:23 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id r135so5609166ybc.0;
        Wed, 14 Jul 2021 14:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IQvq/4g5zJ5N2Fa1yyLOw5KvTWr7oHjVZDvr0VDoybQ=;
        b=EbyNoo+0zalUlPsiW9uSVkCj1s8FEZm2a8m8njb7BelIYzJ1XTq6Ecnt2ik2BBJUZD
         RLyjRpH4kmVhJiq/alMz/7BssYBh764kE/9/JIOL3PpS1HsTBnJFBncOt3rQb2xVbc/l
         DTUNQEPcXiJJAaP147hcaPYeUtfewMQc5zQPj09fzkA27DDnrk944ayc0bKjytoy+iym
         hKON0WoWf2AxlbPYlkMBFh2bLaafVzyr8pzm5LpeeQbbB6YgFByus6prtT1JxMbt2t4Y
         vnLfdHbzWSaKh3HcJG7lwdfBBSculkH81pggahZr2ER5ZEgyOmguAMNjRS2j6jCZ+K6Z
         Qplg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IQvq/4g5zJ5N2Fa1yyLOw5KvTWr7oHjVZDvr0VDoybQ=;
        b=YY2+BL1IXFVv+l8hWmSmUtMgv2Gm+vGr0DV1eGGTx1xRBFnlT58oGlx7WgwzpYcuoF
         VQEiaaEc8d6hHm6qvG7FJTSDA5MO7U45y+CnLUc4oWmseDBNKnTfNiwZxxDLL4X4+9PN
         NmyxHd5dcJaqKLAu98RFw2T8H90zYxcmBPgn/PXh7BMEucZ6S3eEgtLefnmoaVM63VKc
         yRln9ZVzI4lZVOe0xKfb3pOb2/jPb2GTxdfrhay2Ze39qig2p4x46w2IKzJ4JFL+WitO
         INoQN1xT/OGLHMbl3yw5Co+8zOtGgOcqgkswsqNqd1Cim76voZOYkEIWupCYihMgXvQ3
         Uvhw==
X-Gm-Message-State: AOAM531vI+jtc6I1kPQD3OKhQe5BOeKsxCrYbynJfZYXp9jRHX/QhQgQ
        WT6ogMNMhbhE27uwTTpBnDNbQTqZMABXhBVHc6k=
X-Google-Smtp-Source: ABdhPJxuyPy1e7245R+vn3bw4cFnnSPv5O0Jrrws6ORx0AmgxyUR36YOi2mcUaY+X1EP0OcklgZqREpeIZ8a4k8/24w=
X-Received: by 2002:a5b:b48:: with SMTP id b8mr15843145ybr.179.1626297982886;
 Wed, 14 Jul 2021 14:26:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210629220328.13366-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20210629220328.13366-3-prabhakar.mahadev-lad.rj@bp.renesas.com> <CA+U=Dso8yntv3M0fRLSCbdXJOjwCqo4Pcx024gL4c5=Tg9zq8w@mail.gmail.com>
In-Reply-To: <CA+U=Dso8yntv3M0fRLSCbdXJOjwCqo4Pcx024gL4c5=Tg9zq8w@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Wed, 14 Jul 2021 22:25:56 +0100
Message-ID: <CA+V-a8sa8X1tcBu0bguDBg4Rad-FwEGjrt+Db=4==vsYdDbrrA@mail.gmail.com>
Subject: Re: [PATCH 2/2] iio: adc: Add driver for Renesas RZ/G2L A/D converter
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

HI Alexandru,

Thank you for the review.

On Thu, Jul 1, 2021 at 11:28 AM Alexandru Ardelean
<ardeleanalex@gmail.com> wrote:
>
> On Wed, Jun 30, 2021 at 1:07 AM Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> >
> > Add ADC driver support for Renesas RZ/G2L A/D converter in SW
> > trigger mode.
> >
> > A/D Converter block is a successive approximation analog-to-digital
> > converter with a 12-bit accuracy and supports a maximum of 8 input
> > channels.
>
> Hey,
>
> Some comments inline.
>
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
> > ---
> >  MAINTAINERS                 |   8 +
> >  drivers/iio/adc/Kconfig     |  10 +
> >  drivers/iio/adc/Makefile    |   1 +
> >  drivers/iio/adc/rzg2l_adc.c | 489 ++++++++++++++++++++++++++++++++++++
> >  4 files changed, 508 insertions(+)
> >  create mode 100644 drivers/iio/adc/rzg2l_adc.c
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 81e1edeceae4..bee4c3847e01 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -15622,6 +15622,14 @@ L:     linux-renesas-soc@vger.kernel.org
> >  S:     Maintained
> >  F:     drivers/phy/renesas/phy-rcar-gen3-usb*.c
> >
> > +RENESAS RZ/G2L A/D DRIVER
> > +M:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > +L:     linux-iio@vger.kernel.org
> > +L:     linux-renesas-soc@vger.kernel.org
> > +S:     Supported
> > +F:     Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml
> > +F:     drivers/iio/adc/rzg2l_adc.c
> > +
> >  RESET CONTROLLER FRAMEWORK
> >  M:     Philipp Zabel <p.zabel@pengutronix.de>
> >  S:     Maintained
> > diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> > index c7946c439612..9408cbf97acc 100644
> > --- a/drivers/iio/adc/Kconfig
> > +++ b/drivers/iio/adc/Kconfig
> > @@ -887,6 +887,16 @@ config ROCKCHIP_SARADC
> >           To compile this driver as a module, choose M here: the
> >           module will be called rockchip_saradc.
> >
> > +config RZG2L_ADC
> > +       tristate "Renesas RZ/G2L ADC driver"
> > +       depends on ARCH_R9A07G044 || COMPILE_TEST
> > +       help
> > +         Say yes here to build support for the ADC found in Renesas
> > +         RZ/G2L family.
> > +
> > +         To compile this driver as a module, choose M here: the
> > +         module will be called rzg2l_adc.
> > +
> >  config SC27XX_ADC
> >         tristate "Spreadtrum SC27xx series PMICs ADC"
> >         depends on MFD_SC27XX_PMIC || COMPILE_TEST
> > diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> > index a226657d19c0..d92bcc9c5fbb 100644
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
> > index 000000000000..1c58eb8ae1ec
> > --- /dev/null
> > +++ b/drivers/iio/adc/rzg2l_adc.c
> > @@ -0,0 +1,489 @@
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
> > +#include <linux/platform_device.h>
> > +#include <linux/reset.h>
> > +
> > +#define ADM(n)                 ((n) * 0x4)
> > +#define ADM0_ADCE              BIT(0)
> > +#define ADM0_ADBSY             BIT(1)
> > +#define ADM0_PWDWNB            BIT(2)
> > +#define ADM0_SRESB             BIT(15)
> > +#define ADM1_TRG               BIT(0)
> > +#define ADM1_MS                        BIT(2)
> > +#define ADM1_BS                        BIT(4)
> > +#define ADM1_EGA_CLEAR         ~GENMASK(13, 12)
> > +#define ADM2_CHSEL_CLEAR       ~GENMASK(7, 0)
> > +#define ADM3_ADSMP             0x578
> > +#define ADM3_ADCMP             (0xe << 16)
> > +#define ADM3_ADIL_CLEAR                ~GENMASK(31, 24)
> > +
> > +#define ADINT                  0x20
> > +#define ADINT_CH_CLEAR         ~GENMASK(7, 0)
> > +#define ADINT_CSEEN            BIT(16)
> > +#define ADINT_INTS             BIT(31)
> > +#define ADSTS                  0x24
> > +#define ADINT_INTST_MASK       GENMASK(7, 0)
> > +#define ADSTS_CSEST            BIT(16)
> > +#define ADIVC                  0x28
> > +#define ADIVC_DIVADC_CLEAR     ~GENMASK(8, 0)
> > +#define ADIVC_DIVADC_4         0x4
> > +#define ADFIL                  0x2c
> > +#define ADCR(n)                        (0x30 + ((n) * 0x4))
> > +#define ADCR_AD_MASK           GENMASK(11, 0)
> > +
> > +#define ADC_MAX_CHANNELS       8
> > +#define ADC_CHN_MASK           0x7
> > +#define ADC_TIMEOUT            usecs_to_jiffies(1 * 4)
> > +
> > +enum trigger_mode {
> > +       SW_TRIGGER = 0,
> > +       SYNC_TRIGGER,
> > +       ASYNC_TRIGGER,
> > +};
>
> this enum could also be removed [for now] given that only SW_TRIGGER
> is supported;
>
OK will do.

> > +
> > +struct rzg2l_adc_data {
> > +       const struct iio_chan_spec *channels;
> > +       u8 num_channels;
> > +       u8 trigger;
> > +};
> > +
> > +struct rzg2l_adc {
> > +       void __iomem *base;
> > +       struct clk *pclk;
> > +       struct clk *adclk;
> > +       struct reset_control *presetn;
> > +       struct reset_control *adrstn;
> > +       struct completion completion;
> > +       const struct rzg2l_adc_data *data;
> > +       bool adc_disabled; /* protected with mlock mutex from indio_dev */
>
> this adc_disabled flag looks a bit weird;
> it seems to guard against this driver being removed to prevent some reads.
> technically, this should be protected by IIO core;
> so the flag itself (or how it is being used) looks like it doesn't do much;
>
Agreed will drop that.

> > +       u16 last_val[ADC_MAX_CHANNELS];
> > +};
> > +
> > +static unsigned int rzg2l_adc_readl(struct rzg2l_adc *adc, u32 reg)
> > +{
> > +       return readl(adc->base + reg);
> > +}
> > +
> > +static void rzg2l_adc_writel(struct rzg2l_adc *adc, unsigned int reg, u32 val)
> > +{
> > +       writel(val, adc->base + reg);
> > +}
> > +
> > +static int rzg2l_adc_adclk(struct rzg2l_adc *adc, bool prepare)
> > +{
> > +       if (prepare)
> > +               return clk_prepare_enable(adc->adclk);
> > +
> > +       clk_disable_unprepare(adc->adclk);
> > +       return 0;
> > +}
> > +
> > +static void rzg2l_adc_pwr(struct rzg2l_adc *adc, bool on)
> > +{
> > +       u32 reg;
> > +
> > +       reg = rzg2l_adc_readl(adc, ADM(0));
> > +       if (on)
> > +               reg |= ADM0_PWDWNB;
> > +       else
> > +               reg &= ~ADM0_PWDWNB;
> > +       rzg2l_adc_writel(adc, ADM(0), reg);
> > +       udelay(2);
> > +}
> > +
> > +static void rzg2l_adc_conversion(struct rzg2l_adc *adc, bool start)
> > +{
> > +       int timeout = 5;
> > +       u32 reg;
> > +
> > +       /* stop A/D conversion */
> > +       reg = rzg2l_adc_readl(adc, ADM(0));
> > +       if (start)
> > +               reg |= ADM0_ADCE;
> > +       else
> > +               reg &= ~ADM0_ADCE;
> > +       rzg2l_adc_writel(adc, ADM(0), reg);
> > +
> > +       if (start)
> > +               return;
> > +
> > +       do {
> > +               usleep_range(100, 200);
> > +               reg = rzg2l_adc_readl(adc, ADM(0));
> > +               timeout--;
> > +               if (!timeout) {
> > +                       pr_err("%s stopping ADC timed out\n", __func__);
> > +                       break;
> > +               }
> > +       } while (((reg & ADM0_ADBSY) || (reg & ADM0_ADCE)));
> > +}
> > +
> > +static int rzg2l_adc_read_raw(struct iio_dev *indio_dev,
> > +                             struct iio_chan_spec const *chan,
> > +                             int *val, int *val2, long mask)
> > +{
> > +       struct rzg2l_adc *adc = iio_priv(indio_dev);
> > +       u32 reg;
> > +       int ret;
> > +       u8 ch;
> > +
> > +       switch (mask) {
> > +       case IIO_CHAN_INFO_RAW:
> > +               mutex_lock(&indio_dev->mlock);
>
> [1]
> acquiring indio_dev->mlock directly is discouraged;
> this lock is reserved for IIO core logic and will be moved into an
> iio_dev_opaque struct eventually;
> driver state locks should be defined in struct rzg2l_adc and managed
> by the driver to protect it's own internal state;
>
Agreed will add driver state lock in struct rzg2l_adc
>
> > +
> > +               if (adc->adc_disabled) {
> > +                       mutex_unlock(&indio_dev->mlock);
> > +                       return -EBUSY;
> > +               }
> > +
> > +               if (rzg2l_adc_readl(adc, ADM(0)) & ADM0_ADBSY) {
> > +                       mutex_unlock(&indio_dev->mlock);
> > +                       return -EBUSY;
> > +               }
> > +
> > +               ch = chan->channel & ADC_CHN_MASK;
> > +               /* SW trigger */
> > +               reg = rzg2l_adc_readl(adc, ADM(1));
> > +               reg &= ADM1_EGA_CLEAR;
> > +               reg &= ~ADM1_BS;
> > +               reg |= ADM1_MS;
> > +               reg &= ~ADM1_TRG;
> > +               rzg2l_adc_writel(adc, ADM(1), reg);
> > +
> > +               /* select channel */
> > +               reg = rzg2l_adc_readl(adc, ADM(2));
> > +               reg &= ADM2_CHSEL_CLEAR;
> > +               reg |= BIT(ch);
> > +               rzg2l_adc_writel(adc, ADM(2), reg);
> > +
> > +               reg = rzg2l_adc_readl(adc, ADM(3));
> > +               reg &= ADM3_ADIL_CLEAR;
> > +               reg |= ADM3_ADCMP;
> > +               reg |= ADM3_ADSMP;
> > +               rzg2l_adc_writel(adc, ADM(3), reg);
> > +
> > +               reg = rzg2l_adc_readl(adc, ADIVC);
> > +               reg &= ADIVC_DIVADC_CLEAR;
> > +               reg |= ADIVC_DIVADC_4;
> > +               rzg2l_adc_writel(adc, ADIVC, reg);
> > +
> > +               reg = rzg2l_adc_readl(adc, ADINT);
> > +               reg &= ~ADINT_INTS;
> > +               reg &= ADINT_CH_CLEAR;
> > +               reg |= ADINT_CSEEN;
> > +               reg |= BIT(ch);
> > +               rzg2l_adc_writel(adc, ADINT, reg);
> > +
> > +               rzg2l_adc_pwr(adc, true);
>
> should all this clock & power management be done in this read function?
> it looks like an awful lot just to perform a single read
> maybe some PM suspend/resume hooks would be a better idea for these;
>
Agreed that would make the code much cleaner.

> > +
> > +               ret = rzg2l_adc_adclk(adc, true);
> > +               if (ret) {
> > +                       rzg2l_adc_pwr(adc, false);
> > +                       mutex_unlock(&indio_dev->mlock);
> > +                       return -EINVAL;
> > +               }
> > +
> > +               reinit_completion(&adc->completion);
> > +
> > +               rzg2l_adc_conversion(adc, true);
> > +
> > +               if (!wait_for_completion_timeout(&adc->completion, ADC_TIMEOUT)) {
> > +                       reg &= ADINT_CH_CLEAR;
> > +                       rzg2l_adc_writel(adc, ADINT, reg);
> > +                       rzg2l_adc_conversion(adc, false);
> > +                       rzg2l_adc_adclk(adc, false);
> > +                       rzg2l_adc_pwr(adc, false);
> > +                       mutex_unlock(&indio_dev->mlock);
> > +                       return -ETIMEDOUT;
> > +               }
> > +
> > +               *val = adc->last_val[ch];
> > +               rzg2l_adc_conversion(adc, false);
> > +               rzg2l_adc_adclk(adc, false);
> > +               rzg2l_adc_pwr(adc, false);
> > +               mutex_unlock(&indio_dev->mlock);
> > +               return IIO_VAL_INT;
> > +
> > +       default:
> > +               return -EINVAL;
> > +       }
> > +}
> > +
> > +static irqreturn_t rzg2l_adc_isr(int irq, void *dev_id)
> > +{
> > +       struct rzg2l_adc *adc = (struct rzg2l_adc *)dev_id;
> > +       u8 intst;
> > +       u32 reg;
> > +       u8 i;
> > +
> > +       reg = rzg2l_adc_readl(adc, ADSTS);
> > +       if (reg & ADSTS_CSEST) {
> > +               rzg2l_adc_writel(adc, ADSTS, reg);
> > +               return IRQ_HANDLED;
> > +       }
> > +
> > +       intst = reg & ADINT_INTST_MASK;
> > +       if (!intst)
> > +               return IRQ_HANDLED;
> > +
> > +       for (i = 0; i < ADC_MAX_CHANNELS; i++) {
> > +               if (intst & BIT(i))
> > +                       adc->last_val[i] = rzg2l_adc_readl(adc, ADCR(i)) & ADCR_AD_MASK;
> > +       }
> > +
> > +       rzg2l_adc_writel(adc, ADSTS, reg);
> > +
> > +       complete(&adc->completion);
> > +
> > +       return IRQ_HANDLED;
> > +}
> > +
> > +static const struct iio_info rzg2l_adc_iio_info = {
> > +       .read_raw = rzg2l_adc_read_raw,
> > +};
> > +
> > +static const char * const rzg2l_adc_channel_name[] = {
> > +       "adc0",
> > +       "adc1",
> > +       "adc2",
> > +       "adc3",
> > +       "adc4",
> > +       "adc5",
> > +       "adc6",
> > +       "adc7",
> > +};
> > +
> > +static int rzg2l_adc_parse_of(struct platform_device *pdev, struct rzg2l_adc *adc)
> > +{
> > +       struct device_node *node = pdev->dev.of_node;
> > +       struct iio_chan_spec *chan_array;
> > +       u8 channels[ADC_MAX_CHANNELS];
> > +       struct rzg2l_adc_data *data;
> > +       int num_channels;
> > +       int ret;
> > +       u8 i;
> > +
> > +       data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
> > +       if (!data)
> > +               return -ENOMEM;
> > +
> > +       num_channels = of_property_count_u8_elems(node, "renesas-rzg2l,adc-channels");
> > +       if (num_channels <= 0 || num_channels > ADC_MAX_CHANNELS)
> > +               return -EINVAL;
> > +
> > +       ret = of_property_read_u8_array(node, "renesas-rzg2l,adc-channels",
> > +                                       channels, num_channels);
> > +       if (ret)
> > +               return ret;
> > +
> > +       chan_array = devm_kcalloc(&pdev->dev, num_channels, sizeof(*chan_array),
> > +                                 GFP_KERNEL);
> > +       if (!chan_array)
> > +               return -ENOMEM;
> > +
> > +       for (i = 0; i < num_channels; i++) {
> > +               chan_array[i].type = IIO_VOLTAGE;
> > +               chan_array[i].indexed = 1;
> > +               chan_array[i].channel = channels[i];
> > +               chan_array[i].info_mask_separate = BIT(IIO_CHAN_INFO_RAW);
> > +               chan_array[i].info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE);
> > +               chan_array[i].datasheet_name = rzg2l_adc_channel_name[i];
> > +       }
> > +
> > +       ret = of_property_read_u8(node, "renesas-rzg2l,adc-trigger-mode",
> > +                                 &data->trigger);
> > +       if (ret)
> > +               data->trigger = SW_TRIGGER;
> > +
> > +       /* we support SW_TRIGGER as of now */
> > +       if (data->trigger != SW_TRIGGER)
> > +               return -EINVAL;
>
> it would be an idea to remove this data->trigger field and the DT read
> for this property and add it when it's supported;
> typically these triggers don't get configured via DT;
>
Agreed will drop this.

> > +
> > +       data->num_channels = num_channels;
> > +       data->channels = chan_array;
> > +       adc->data = data;
> > +
> > +       return 0;
> > +}
> > +
> > +static int rzg2l_adc_sw_reset(struct rzg2l_adc *adc)
> > +{
> > +       int timeout = 5;
> > +       u32 val;
> > +
> > +       val = rzg2l_adc_readl(adc, ADM(0));
> > +       val |= ADM0_SRESB;
> > +       rzg2l_adc_writel(adc, ADM(0), val);
> > +
> > +       while (!(rzg2l_adc_readl(adc, ADM(0)) & ADM0_SRESB)) {
> > +               if (!timeout)
> > +                       return -EINVAL;
>
> maybe -EBUSY is a bit better error code;
>
> > +               timeout--;
> > +               usleep_range(100, 200);
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +static int rzg2l_adc_probe(struct platform_device *pdev)
> > +{
> > +       struct iio_dev *indio_dev;
> > +       struct rzg2l_adc *adc;
> > +       int ret;
> > +       int irq;
> > +
> > +       indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*adc));
> > +       if (!indio_dev) {
> > +               dev_err(&pdev->dev, "failed allocating iio device\n");
>
> this message can be removed;
> looks like log spam;
> and if it happens, the system will be in a pretty bad state anyway
>
OK will drop this.

> > +               return -ENOMEM;
> > +       }
> > +
> > +       adc = iio_priv(indio_dev);
> > +       if (!adc)
> > +               return -ENOMEM;
>
> this check is redundant;
> if indio_dev is non-NULL then iio_priv() will be good as well;
>
> > +
> > +       ret = rzg2l_adc_parse_of(pdev, adc);
> > +       if (ret)
> > +               return -ENOMEM;
> > +
> > +       adc->base = devm_platform_ioremap_resource(pdev, 0);
> > +       if (IS_ERR(adc->base)) {
> > +               dev_err(&pdev->dev, "missing mem resource");
>
> this message can be removed;
> looks like log-spam
>
Will drop.

> > +               return PTR_ERR(adc->base);
> > +       }
> > +
> > +       irq = platform_get_irq(pdev, 0);
> > +       if (irq < 0) {
> > +               dev_err(&pdev->dev, "no irq resource\n");
> > +               return irq;
> > +       }
> > +
> > +       adc->pclk = devm_clk_get(&pdev->dev, "pclk");
> > +       if (IS_ERR(adc->pclk)) {
> > +               dev_err(&pdev->dev, "Failed to get pclk");
> > +               return PTR_ERR(adc->pclk);
> > +       }
> > +
> > +       adc->adclk = devm_clk_get(&pdev->dev, "adclk");
> > +       if (IS_ERR(adc->adclk)) {
> > +               dev_err(&pdev->dev, "Failed to get adclk");
> > +               return PTR_ERR(adc->adclk);
> > +       }
> > +
> > +       adc->adrstn = devm_reset_control_get_exclusive(&pdev->dev, "adrst-n");
> > +       if (IS_ERR(adc->adrstn)) {
> > +               dev_err(&pdev->dev, "failed to get adrstn\n");
> > +               return PTR_ERR(adc->adrstn);
> > +       }
> > +
> > +       adc->presetn = devm_reset_control_get_exclusive(&pdev->dev, "presetn");
> > +       if (IS_ERR(adc->presetn)) {
> > +               dev_err(&pdev->dev, "failed to get presetn\n");
> > +               return PTR_ERR(adc->presetn);
> > +       }
> > +
> > +       ret = reset_control_deassert(adc->adrstn);
> > +       if (ret)
> > +               return ret;
> > +
> > +       ret = reset_control_deassert(adc->presetn);
> > +       if (ret)
> > +               goto assert_adrstn;
> > +
> > +       ret = clk_prepare_enable(adc->pclk);
> > +       if (ret)
> > +               goto assert_presetn;
> > +
> > +       ret = rzg2l_adc_sw_reset(adc);
> > +       if (ret)
> > +               goto unprepare_pclk;
> > +
> > +       init_completion(&adc->completion);
> > +
> > +       platform_set_drvdata(pdev, indio_dev);
> > +
> > +       ret = devm_request_irq(&pdev->dev, irq, rzg2l_adc_isr,
> > +                              0, dev_name(&pdev->dev), adc);
> > +       if (ret < 0)
> > +               goto unprepare_pclk;
> > +
> > +       adc->adc_disabled = false;
> > +       indio_dev->name = dev_name(&pdev->dev);
>
> indio_dev->name  should be the part-name;
> since this driver supports a single part, this can be:
>
>   indio_dev->name = "rzg2l-adc";
>
OK

> > +       indio_dev->dev.parent = &pdev->dev;
> > +       indio_dev->dev.of_node = pdev->dev.of_node;
>
>
> The 2 assignments above can be removed in the mainline driver.
> They should be done in devm_iio_device_alloc() and iio_device_register()
>
Agreed will drop this.

>
> > +       indio_dev->info = &rzg2l_adc_iio_info;
> > +       indio_dev->modes = INDIO_DIRECT_MODE;
> > +       indio_dev->channels = adc->data->channels;
> > +       indio_dev->num_channels = adc->data->num_channels;
> > +
> > +       ret = iio_device_register(indio_dev);
> > +       if (ret)
> > +               goto unprepare_pclk;
> > +
> > +       return 0;
> > +
> > +unprepare_pclk:
> > +       clk_disable_unprepare(adc->pclk);
> > +assert_presetn:
> > +       reset_control_assert(adc->presetn);
> > +assert_adrstn:
> > +       reset_control_assert(adc->adrstn);
> > +       return ret;
> > +}
> > +
> > +static int rzg2l_adc_remove(struct platform_device *pdev)
> > +{
> > +       struct iio_dev *indio_dev = platform_get_drvdata(pdev);
> > +       struct rzg2l_adc *adc = iio_priv(indio_dev);
> > +
> > +       mutex_lock(&indio_dev->mlock);
> > +       adc->adc_disabled = true;
> > +       mutex_unlock(&indio_dev->mlock);
> > +
> > +       iio_device_unregister(indio_dev);
> > +
> > +       clk_disable_unprepare(adc->pclk);
> > +       reset_control_assert(adc->presetn);
> > +       reset_control_assert(adc->adrstn);
> > +
> > +       return 0;
> > +}
> > +
> > +static const struct of_device_id rzg2l_adc_match[] = {
> > +       {
> > +               .compatible = "renesas,rzg2l-adc",
> > +       },
> > +       {},
>
> comma can be removed;
> since this is a null terminator
>
OK.

Cheers,
Prabhakar

> > +};
> > +MODULE_DEVICE_TABLE(of, rzg2l_adc_match);
> > +
> > +static struct platform_driver rzg2l_adc_driver = {
> > +       .probe          = rzg2l_adc_probe,
> > +       .remove         = rzg2l_adc_remove,
> > +       .driver         = {
> > +               .name   = "rzg2l-adc",
> > +               .of_match_table = rzg2l_adc_match,
> > +       },
> > +};
> > +
> > +module_platform_driver(rzg2l_adc_driver);
> > +
> > +MODULE_AUTHOR("Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>");
> > +MODULE_DESCRIPTION("Renesas RZ/G2L ADC driver");
> > +MODULE_LICENSE("GPL v2");
> > --
> > 2.17.1
> >
