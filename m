Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 629DD2C86D3
	for <lists+linux-iio@lfdr.de>; Mon, 30 Nov 2020 15:34:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbgK3OcO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Nov 2020 09:32:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726685AbgK3OcN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 30 Nov 2020 09:32:13 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEFDDC0613CF
        for <linux-iio@vger.kernel.org>; Mon, 30 Nov 2020 06:31:33 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id p6so6575929plr.7
        for <linux-iio@vger.kernel.org>; Mon, 30 Nov 2020 06:31:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v45nJ9iIo4SqVQ1u7wfefNv2KMk6oqIg198lnNn66U0=;
        b=Wrv/osBSbNXpMU3Ydy3vkwNmVuWUoodosSASZjLBn934mD3dKMA7VPW+JQ16bpDOMg
         sbMCPRCmsnNuASm4tLMva3VzugjdKfExDI/4FGsDd+swflbfTVk4fuueHkS8RbC8jzD5
         bcsvajsQbtQn3qdGSBSM//dGCl9rKRtqul3n9VVyWlTMv4T80r6UFTBQRkwHxHHG+ZKD
         LqXIIsiWjIusUotzWgMA8sBe670q9OmsH7/cuSUazIbgWspy2Nk1oji34sWnhdyUsQ4o
         ZmvgPMMgB4w+O3ujNxDoLuL0x/fYxJ9+07+4xMSRe8baWHpAu+qN/GYBAe31dDDbRt4P
         Esmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v45nJ9iIo4SqVQ1u7wfefNv2KMk6oqIg198lnNn66U0=;
        b=RR0voPr0Fr745S0SDrGLyJuvg25Lu2oOdSeF1O9N8uFofMGK6LZdT0+3leGJFJV6+V
         Og9t2NIRQf1j7uHtKUZfiNc7/yvslh/n09UKe2CaiuuxwXo6iDVQ0IuINcOHz8mywQ/6
         RWBorT0cNdIDgl9lOPmDXQxKkc2Y1T5Zom42JFNKjLEFH9aXq7dY/x3JtjQZ6VqfjRqX
         7bxxf3dDvs7i/ivQDsQgqeSTsAX9J+crQZM1bUpsF6QX1JrMJoUk3ICepIR3X/21A134
         yhAvni95jfhvXvmWuK/NRBCIJcIw/Irjc2Hq08lFij60uOWsdLaZ+xkrzkoR6eKIVVWM
         lhzQ==
X-Gm-Message-State: AOAM530LmG7HKouQXY57Arl/BkL/Z4Q0J5CAuSRwGsSH6smZbGrmpbmk
        Ec0O4gaLfmT6SxTCkcsw88gQ83fXZbYH/xd8P8o=
X-Google-Smtp-Source: ABdhPJwwM8D44i5HmmKt3eq9EewUs9YF8LjEDRXSLc2ce7i4ldy5qGRXfwRG1EXe1+1yrwit8DDnL+9DV3ckRBTZg2w=
X-Received: by 2002:a17:90b:a17:: with SMTP id gg23mr8953801pjb.129.1606746693252;
 Mon, 30 Nov 2020 06:31:33 -0800 (PST)
MIME-Version: 1.0
References: <20201130141954.339805-1-hdegoede@redhat.com>
In-Reply-To: <20201130141954.339805-1-hdegoede@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 30 Nov 2020 16:32:21 +0200
Message-ID: <CAHp75Vd2Jhep0z7i3_5jnvsnMN2zyudCRM6YNy_neCd6_ydSvw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] iio: accel: bmc150: Removed unused
 bmc150_accel_dat irq member
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Andy Shevchenko <andy@infradead.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jeremy Cline <jeremy@jcline.org>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Nov 30, 2020 at 4:20 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> The bmc150_accel_dat struct irq member is only ever used inside
> bmc150_accel_core_probe, drop it and just use the function argument
> directly.

FWIW, for all three
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/iio/accel/bmc150-accel-core.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
> index 48435865fdaf..088716d55855 100644
> --- a/drivers/iio/accel/bmc150-accel-core.c
> +++ b/drivers/iio/accel/bmc150-accel-core.c
> @@ -183,7 +183,6 @@ enum bmc150_accel_trigger_id {
>
>  struct bmc150_accel_data {
>         struct regmap *regmap;
> -       int irq;
>         struct bmc150_accel_interrupt interrupts[BMC150_ACCEL_INTERRUPTS];
>         struct bmc150_accel_trigger triggers[BMC150_ACCEL_TRIGGERS];
>         struct mutex mutex;
> @@ -1568,7 +1567,6 @@ int bmc150_accel_core_probe(struct device *dev, struct regmap *regmap, int irq,
>
>         data = iio_priv(indio_dev);
>         dev_set_drvdata(dev, indio_dev);
> -       data->irq = irq;
>
>         data->regmap = regmap;
>
> @@ -1599,9 +1597,8 @@ int bmc150_accel_core_probe(struct device *dev, struct regmap *regmap, int irq,
>                 return ret;
>         }
>
> -       if (data->irq > 0) {
> -               ret = devm_request_threaded_irq(
> -                                               dev, data->irq,
> +       if (irq > 0) {
> +               ret = devm_request_threaded_irq(dev, irq,
>                                                 bmc150_accel_irq_handler,
>                                                 bmc150_accel_irq_thread_handler,
>                                                 IRQF_TRIGGER_RISING,
> --
> 2.28.0
>


-- 
With Best Regards,
Andy Shevchenko
