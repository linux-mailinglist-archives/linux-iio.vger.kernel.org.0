Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E58213D70C2
	for <lists+linux-iio@lfdr.de>; Tue, 27 Jul 2021 10:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235881AbhG0IC4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 27 Jul 2021 04:02:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235621AbhG0ICu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 27 Jul 2021 04:02:50 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE7A0C061757;
        Tue, 27 Jul 2021 01:02:36 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id a201so19259213ybg.12;
        Tue, 27 Jul 2021 01:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m+XCL+O6ZGoZM0ZHBj2pc3ABR3ivI0OLwjzgvaNMBPU=;
        b=PkJe1pEHeQ3dYtlFZVjVy42qXUU8UV6dJDzpngGRmQQ69PVdu0bcDd6Ess1bfqyFXE
         CqQTMagOtbNWOWfhDvrGE5s0aUqFQSXXC0jlLw9pgnndaW/zbFI4w1boypnCLtxT/DgX
         8dL75dZNKWmVWx79gi6VQDAK279HoIV183jYGzb8m0H72VWaoORuQifDtXyGRllYTCnK
         Yme0RPafihA0fjx6EF/dVNBJCCfntJ7SSWzo4r3ijYIYa/ZFrLBuop0NZIsIx++n8qnp
         PS4aP5TPkgOaJU9UfPgFAJ2UUmC1lZ3qXZRzoRZrm4AhI9CwvbEzh73by0shbYeSwqg9
         pcMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m+XCL+O6ZGoZM0ZHBj2pc3ABR3ivI0OLwjzgvaNMBPU=;
        b=AQYsr7/QjYA5MSTc1rSFCSkNKjPP/n9VM2WkB6PDXLYce0jtCKTc0ixWuv/YneYn21
         LviNqgUJZ9cTkFV3aG1cZceTtgeyoKx3Chk2VBP7Hwe06Ws9Vter4pdHSJa7swSYAhLy
         Ndymj3SKXK3dncz6hJJ9xJinLI/u5SJGxv5hbe+pH1a/Ii1cUhhkXVFuGGapyoPdxiGS
         0xMfZYniur7pbCC3syhkteTejl0F8EA0yYZKMWLuq+sMUQ/hS1DKdVJG1mfUBHy+IS6q
         HETq/CLI/pv4jSNzxKrMXuQmK7spcAkmZZQBWOn3qpHL5KCZxf05I7EwYPwl+5QMUUzw
         9gRw==
X-Gm-Message-State: AOAM532LNqASbQtTaC852ZtL1cBR2ecOQNIM/cq00oXjvej3L0iSNj45
        6nMQHc45pa/S2CBe+UnSbHDwAfVW8NPyAO5dUiY=
X-Google-Smtp-Source: ABdhPJxs7G59NoEQoH+x4+/lGnCC80kbrFx4j8D/TvVTYw1cHBYH5g9AW1fYZrRgMvX1rjXGyFfwwCzZAN+L2AR618s=
X-Received: by 2002:a25:7e86:: with SMTP id z128mr29682778ybc.222.1627372956251;
 Tue, 27 Jul 2021 01:02:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210726182850.14328-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20210726182850.14328-3-prabhakar.mahadev-lad.rj@bp.renesas.com> <f23358e3e040cc8522b259669ec61a22c5439394.camel@pengutronix.de>
In-Reply-To: <f23358e3e040cc8522b259669ec61a22c5439394.camel@pengutronix.de>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Tue, 27 Jul 2021 09:02:10 +0100
Message-ID: <CA+V-a8shgfxffdOTj0cyxz36XVxGxUkq1obPJNOSc94BKUWung@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] iio: adc: Add driver for Renesas RZ/G2L A/D converter
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Magnus Damm <magnus.damm@gmail.com>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Philipp,

Thank you for the review.

On Tue, Jul 27, 2021 at 8:13 AM Philipp Zabel <p.zabel@pengutronix.de> wrote:
>
> Hi Prabhakar,
>
> On Mon, 2021-07-26 at 19:28 +0100, Lad Prabhakar wrote:
> > Add ADC driver support for Renesas RZ/G2L A/D converter in SW
> > trigger mode.
> >
> > A/D Converter block is a successive approximation analog-to-digital
> > converter with a 12-bit accuracy and supports a maximum of 8 input
> > channels.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
> > ---
> >  MAINTAINERS                 |   8 +
> >  drivers/iio/adc/Kconfig     |  10 +
> >  drivers/iio/adc/Makefile    |   1 +
> >  drivers/iio/adc/rzg2l_adc.c | 595 ++++++++++++++++++++++++++++++++++++
> >  4 files changed, 614 insertions(+)
> >  create mode 100644 drivers/iio/adc/rzg2l_adc.c
> >
> [...]
> > diff --git a/drivers/iio/adc/rzg2l_adc.c b/drivers/iio/adc/rzg2l_adc.c
> > new file mode 100644
> > index 000000000000..d05a3208ff9d
> > --- /dev/null
> > +++ b/drivers/iio/adc/rzg2l_adc.c
> > @@ -0,0 +1,595 @@
> [...]
> > +static void rzg2l_adc_pm_runtime_disable(void *data)
> > +{
> > +     struct iio_dev *indio_dev = data;
> > +
> > +     pm_runtime_disable(indio_dev->dev.parent);
> > +}
> > +
> > +static void rzg2l_adc_reset_assert(void *data)
> > +{
> > +     struct reset_control *reset = data;
> > +
> > +     reset_control_assert(reset);
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
> > +     indio_dev = devm_iio_device_alloc(dev, sizeof(*adc));
> > +     if (!indio_dev)
> > +             return -ENOMEM;
> > +
> > +     adc = iio_priv(indio_dev);
> > +
> > +     ret = rzg2l_adc_parse_properties(pdev, adc);
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
>
> I'd request the "presetn" control up here, so if that fails we don't
> touch the "adrst-n" reset line.
>
Ok will move the devm_reset_control_get_exclusive() call for presetn here.

> > +     ret = devm_add_action_or_reset(&pdev->dev,
> > +                                    rzg2l_adc_reset_assert, adc->adrstn);
> > +     if (ret) {
> > +             dev_err(&pdev->dev, "failed to register adrstn assert devm action, %d\n",
> > +                     ret);
> > +             return ret;
> > +     }
>
> This is the wrong way around. Installing devres actions should be done
> after the thing they are supposed to revert in case of error. You should
> move this down below the reset_control_deassert(adc->adrstn).
>
Ouch my understanding was, there won't be any harm in asserting the
reset line. Agree with will move this below
reset_control_deassert(adc->adrstn).

> > +
> > +     adc->presetn = devm_reset_control_get_exclusive(dev, "presetn");
> > +     if (IS_ERR(adc->presetn)) {
> > +             dev_err(dev, "failed to get presetn\n");
> > +             return PTR_ERR(adc->presetn);
> > +     }
> > +
> > +     ret = devm_add_action_or_reset(&pdev->dev,
> > +                                    rzg2l_adc_reset_assert, adc->presetn);
> > +     if (ret) {
> > +             dev_err(&pdev->dev, "failed to register presetn assert devm action, %d\n",
> > +                     ret);
> > +             return ret;
> > +     }
>
> Same as above, this belongs after the presetn deassert below.
>
Agreed.

> > +
> > +     ret = reset_control_deassert(adc->adrstn);
> > +     if (ret) {
> > +             dev_err(&pdev->dev, "failed to deassert adrstn pin, %d\n", ret);
> > +             return ret;
> > +     }
>
> Here is the place to install the adrstn assert action.
>
Agreed will move the devres action here.

> > +     ret = reset_control_deassert(adc->presetn);
> > +     if (ret) {
> > +             dev_err(&pdev->dev, "failed to deassert presetn pin, %d\n", ret);
> > +             return ret;
> > +     }
>
> And here is the place to install the presetn assert action.
>
Agreed will move the devres action here.

Cheers,
Prabhakar

> regards
> Philipp
