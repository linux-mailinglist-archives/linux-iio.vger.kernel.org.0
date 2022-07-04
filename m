Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7430E565EB0
	for <lists+linux-iio@lfdr.de>; Mon,  4 Jul 2022 22:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbiGDUyE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 4 Jul 2022 16:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbiGDUyD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 4 Jul 2022 16:54:03 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03361B1FF;
        Mon,  4 Jul 2022 13:54:00 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id c143so10056844ybf.3;
        Mon, 04 Jul 2022 13:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yX/+5EHmJzouiASTPWEy2vcXLPBh//GiWKeXcuGIwQ8=;
        b=B3+vMtHkh7oMCAMnDoWG8DEYz2b0JCtP5ZfXbihV47SV3dWC+3OwqEGsEMwBqAFjz7
         khAxgZHq8sJMmNaICKe6NssutaTTjWLNGJBKORgb6vraCnVB5t+OtelrciWNFx45ctsy
         JvI3604+UpHWwrRhFauDs9e1foPdkNSdzNHqlHWwdWLiIR5uNgh7cOgQIAGgo+d4nbqk
         vWBgis+eV5qV8Zk/AkWLLfaslFlFZF3eEW3XKUxRruxM5WjKyLFbe1tfQJnycOJwtO/v
         olhGLIkEl+ub8ONlqXskW875SxgXQbu+BJdjC1nw7gUrRk69EDJ2IlghqhNSArZzWIXy
         kOpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yX/+5EHmJzouiASTPWEy2vcXLPBh//GiWKeXcuGIwQ8=;
        b=39Q5fdvEQpHOp7bFl7WvGKpBpO6tHw64uT1dwJNWFOEMM1r7UUfs9l0CrttZOOcsPp
         OHjZpsv1QIhQuQKzX6UbAq+hDom5LpaSO2D1nHSeCVWHGmJ+kIVtYtD7OVUpE7IOWoPA
         DxqWkyjoWH6U5Cb7HMzxAif2KgCvmOaDKUmqSO+w5YQEfAwoF6JvMxGLkWKJPly9n2Pp
         xa1dNlwNfFwv23qPxuXf/ly+HiynD8nQ2nD5uh5SwgzQY2rFHlshGn69/4kU53Pg/NKj
         nQAjZdVSbmXrL1OJ8McBVeATqHPSCmPmFHWwttkcNIyVMErBTZTqUrCfs0Z0DleXUmwN
         lTEQ==
X-Gm-Message-State: AJIora8YhalBc7qWdIbRnUeItWxXwdlGx8N899kK1uoxROkKYnifN7JZ
        rni6Jeit5DdvbiNZ6M+/zdZs+Q1w6Io6XvRGPss=
X-Google-Smtp-Source: AGRyM1vdKb73hFj3ExY6oJ2GrDF+CZ7xFkfm6isQFNTZlGTiO++q+Ae1pyvqGIbKKpGLxpNoMkavQ8hfM3hWhEKqjS4=
X-Received: by 2002:a05:6902:c4:b0:64b:4677:331b with SMTP id
 i4-20020a05690200c400b0064b4677331bmr33612017ybs.93.1656968039226; Mon, 04
 Jul 2022 13:53:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220704053901.728-1-peterwu.pub@gmail.com> <20220704053901.728-11-peterwu.pub@gmail.com>
In-Reply-To: <20220704053901.728-11-peterwu.pub@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 4 Jul 2022 22:53:22 +0200
Message-ID: <CAHp75VfFWyvO44XjRCrx=caCLK0EX5gOfF6fnydZeegFBqJrzw@mail.gmail.com>
Subject: Re: [PATCH v4 10/13] power: supply: mt6370: Add Mediatek MT6370
 charger driver
To:     ChiaEn Wu <peterwu.pub@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        "Krogerus, Heikki" <heikki.krogerus@linux.intel.com>,
        Helge Deller <deller@gmx.de>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Alice Chen <alice_chen@richtek.com>,
        cy_huang <cy_huang@richtek.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        USB <linux-usb@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>,
        szuni chen <szunichen@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Jul 4, 2022 at 7:42 AM ChiaEn Wu <peterwu.pub@gmail.com> wrote:

> Add Mediatek MT6370 charger driver.

...

> +         This driver can also be built as a module. If so the module

If so,

> +         will be called "mt6370-charger.ko".

No ".ko" part.

...

> +#define MT6370_MIVR_IBUS_TH_100_MA     100000

mA

...

> +       if (mt6370_chg_fields[fd].range) {
> +               return linear_range_get_value(mt6370_chg_fields[fd].range,
> +                                             reg_val, val);

> +       } else {

Redundant 'else'.

> +               *val = reg_val;
> +               return 0;
> +       }

...

> +               if (fd != F_VMIVR)

Why not positive conditional?

> +                       linear_range_get_selector_within(r, val, &val);
> +               else {
> +                       ret = linear_range_get_selector_high(r, val, &val, &f);
> +                       if (!ret)
> +                               val = r->max_sel;
> +               }

Checkpatch didn't complain about the absence of {} ?

...

> +       irq_num = platform_get_irq_byname(pdev, irq_name);
> +       if (irq_num >= 0) {

  if (irq_num < 0)
    return;

> +               if (en)
> +                       enable_irq(irq_num);
> +               else
> +                       disable_irq_nosync(irq_num);
> +       }

...

> +       /* Check in otg mode or not */

OTG

...

> +static int mt6370_chg_set_online(struct mt6370_priv *priv,
> +                                const union power_supply_propval *val)
> +{
> +       unsigned int pwr_rdy = !!val->intval;

Seems you are using int as boolean, do you need it specifically for
something? Otherwise use boolean here.

> +
> +       mutex_lock(&priv->attach_lock);
> +       if (pwr_rdy == !!priv->attach) {
> +               dev_err(priv->dev, "pwr_rdy is same(%d)\n", pwr_rdy);
> +               mutex_unlock(&priv->attach_lock);
> +               return 0;
> +       }
> +
> +       priv->attach = pwr_rdy;
> +       mutex_unlock(&priv->attach_lock);
> +
> +       if (!queue_work(priv->wq, &priv->bc12_work))
> +               dev_err(priv->dev, "bc12 work has already queued\n");
> +
> +       return 0;
> +}

-- 
With Best Regards,
Andy Shevchenko
