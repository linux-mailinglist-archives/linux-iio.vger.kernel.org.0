Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCE7A1AE711
	for <lists+linux-iio@lfdr.de>; Fri, 17 Apr 2020 22:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbgDQU7Q (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Apr 2020 16:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726093AbgDQU7P (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Apr 2020 16:59:15 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CD74C061A0C;
        Fri, 17 Apr 2020 13:59:15 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id n10so3876885iom.3;
        Fri, 17 Apr 2020 13:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nSsX3bbUJ1nOO1RD+htfrcSV+1mM35MncUVMYikE8Vc=;
        b=k9YWGoBeLv05KhqXY0SeQ7omYOQrJj2bvP2qZEQOtnixswHfEfNEXQ7b+DcZ7YxUJ7
         h6HBT1MgmPfa4nfblCNTuG/PsHDX15vs5OsRlcVxwFvRDtoGtFaLe3vTbWwGLmAy53OC
         vxzgilJp2U+7RJWV4AArATG971RPKoe9VA1nGNrjYOr3AdqBhEiOw+YPeYzbRDCYYRjW
         FDWOpmXGyEEHl3KyMeQYUMBykP9AYulp00tqlcnPDCZZQi2QVQn5V6wNw+rISNRBNXkz
         Hyv42sLSHDU8mEByGqgenikkLGB+GTbB1seyUhXl/XsX9Z0za8wxaxHk+3n7O1N4d8VK
         xs+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nSsX3bbUJ1nOO1RD+htfrcSV+1mM35MncUVMYikE8Vc=;
        b=QHBo5YDpszKvsyaZIMFenicBU2NCw060kLZkJagck0a5p1icpQrGKAWPgUMdDBLBN+
         mfX/ogLtAsgqb8k1b+RM3WcL9dX0boLFpTXPX48CmtrRZhtPxLHQSq2fhszcoSKYxCS5
         WvFsB5iN/Su/siPw6rEZnEiVxCKzbO/+VspGG5ltYl1KWEKlBlOS22eiFdDv5dP/s3ev
         xudhTop7S6TdL2lTBoXa53WZzEOSCsh8g5We2/fgUCykQ7+nalaFkGyk0Vx24OAQBh0/
         dshXFtsONJ7YrPqlvp77XKOQaZ1P8xVFGxpyLayoYVc+H2ODjy55WgeWIiswa0BeY1NX
         ZJfw==
X-Gm-Message-State: AGi0PuaH4uBPDeij/m2KsC5ux+sG5L0D/4/2yKzYB+gGfd+Y8D+WLd/V
        psm/A+mjgqxwWwdGMzkbnLg/tKQm1kpqv4vRz9E=
X-Google-Smtp-Source: APiQypKVOiN33pHXdR9HAj04IpYkBWToy5mE+4OFR3pMkFY7V3SzV03S4nJSgYdzFUxqSqaIapQOTUJmFBcnXYMLRe4=
X-Received: by 2002:a02:c77b:: with SMTP id k27mr5133124jao.139.1587157154423;
 Fri, 17 Apr 2020 13:59:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200417202859.35427-1-contact@artur-rojek.eu> <20200417202859.35427-3-contact@artur-rojek.eu>
In-Reply-To: <20200417202859.35427-3-contact@artur-rojek.eu>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 17 Apr 2020 23:59:03 +0300
Message-ID: <CAHp75Vcwnu8tw92nMYc_5-x_iX+FY8_OhtaJkSYNehmNUDkHGQ@mail.gmail.com>
Subject: Re: [RESEND PATCH v5 3/5] IIO: Ingenic JZ47xx: Add touchscreen mode.
To:     Artur Rojek <contact@artur-rojek.eu>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-input <linux-input@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Apr 17, 2020 at 11:21 PM Artur Rojek <contact@artur-rojek.eu> wrote:
>
> The SADC component in JZ47xx SoCs provides support for touchscreen
> operations (pen position and pen down pressure) in single-ended and
> differential modes.
>
> Of the known hardware to use this controller, GCW Zero and Anbernic RG-350
> utilize the touchscreen mode by having their joystick(s) attached to the
> X/Y positive/negative input pins.
> GCW Zero comes with a single joystick and is sufficiently handled with the
> currently implemented single-ended mode. Support for boards with two
> joysticks, where one is hooked up to Xn/Yn and the other to Xp/Yp channels
> will need to be provided in the future.
>
> The touchscreen component of SADC takes a significant time to stabilize
> after first receiving the clock and a delay of 50ms has been empirically
> proven to be a safe value before data sampling can begin.
>
> All the boards which probe this driver have the interrupt provided from
> devicetree, with no need to handle a case where the irq was not provided.

Device Tree
IRQ

...

> +               .scan_type = {
> +                       .sign = 'u',
> +                       .realbits = 12,

> +                       .storagebits = 16

It's slightly better to leave comma in such cases.

> +               },

> +               .scan_type = {
> +                       .sign = 'u',
> +                       .realbits = 12,

> +                       .storagebits = 16

Ditto.

> +               },

...

>                 .indexed = 1,
>                 .channel = INGENIC_ADC_AUX,
> +               .scan_index = -1

Ditto. You see above? Isn't it nice that you didn't touch that line?
So, perhaps next developer can leverage this subtle kind of things.

>                 .indexed = 1,
>                 .channel = INGENIC_ADC_BATTERY,
> +               .scan_index = -1

Ditto.

>                 .indexed = 1,
>                 .channel = INGENIC_ADC_AUX2,
> +               .scan_index = -1

Ditto.

...

> +static int ingenic_adc_buffer_enable(struct iio_dev *iio_dev)
> +{
> +       struct ingenic_adc *adc = iio_priv(iio_dev);
> +

> +       clk_enable(adc->clk);

Error check?

> +       /* It takes significant time for the touchscreen hw to stabilize. */
> +       msleep(50);
> +       ingenic_adc_set_config(adc, JZ_ADC_REG_CFG_TOUCH_OPS_MASK,
> +                              JZ_ADC_REG_CFG_SAMPLE_NUM(4) |
> +                              JZ_ADC_REG_CFG_PULL_UP(4));
> +       writew(80, adc->base + JZ_ADC_REG_ADWAIT);
> +       writew(2, adc->base + JZ_ADC_REG_ADSAME);

> +       writeb((u8)~JZ_ADC_IRQ_TOUCH, adc->base + JZ_ADC_REG_CTRL);

Why casting?

> +       writel(0, adc->base + JZ_ADC_REG_ADTCH);
> +       ingenic_adc_enable(adc, 2, true);
> +
> +       return 0;
> +}

> +       irq = platform_get_irq(pdev, 0);

Before it worked w/o IRQ, here is a regression you introduced.

> +       if (irq < 0) {

> +               dev_err(dev, "Failed to get irq: %d\n", irq);

Redundant message.

> +               return irq;
> +       }

-- 
With Best Regards,
Andy Shevchenko
