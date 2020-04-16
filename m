Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBEF41ABF50
	for <lists+linux-iio@lfdr.de>; Thu, 16 Apr 2020 13:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633553AbgDPLdY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 16 Apr 2020 07:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2633529AbgDPLdQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 Apr 2020 07:33:16 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9708AC061A0C
        for <linux-iio@vger.kernel.org>; Thu, 16 Apr 2020 04:33:15 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id 198so5319074lfo.7
        for <linux-iio@vger.kernel.org>; Thu, 16 Apr 2020 04:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dZXyKWWyETrlLsP8MP/5ANSEwhcD1vRzeNbXaoZ1FlQ=;
        b=ZtnbFjIXjubeS6JcX+8DoYi/vy15QVyxl7cKN0GWBZRYUB0ZLKg6xjCzrG3JXlwILO
         uDLuVQ9pj6WJG6c+onVOPCtQhVn9f6PJh2D53fGRj0SEO+7L5LVsjO9nQq8jJYAJjhsY
         yWsl14a+KuSDynhsGbFfEUjc0z4KC3E3uXnPdOfpXL6v4b0c8w9gwaiRj/ASZP5nr5fD
         TNFEFiM7ZN7q0Akzkk7Mv9FiV9UfWiOt1oFblgSCSkN9PHFN+ofYqolkieMRulp2te1N
         GGAfjIS2TyTq7TYVuxtpbrSgd8PSVgqqRUn8xtiRalg4QNJnUo4U6qkRR9P+uOAHvqCY
         +fog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dZXyKWWyETrlLsP8MP/5ANSEwhcD1vRzeNbXaoZ1FlQ=;
        b=j4WnRNlf3YKiCEIagkTzHxhIyWFCu2qesygHKepoR6Z2HVldWzd3+HdT7v8KydukBd
         Ali6RsvWCzEGc0V1FqL19Jdpk1DDN8my/cl0qu3sgDl7qt57/9u1B3KKL2k2f6m93whY
         lPTZVzYJV+LW497trYXjx6tw2NgIwq4pg9u9+mW3GknoYMaDSF7ov+ZURUVOf17ralWG
         MoMwY5VzPUcKtxKBjYVmcuccw9MCEZIOcNdBe1grFx+b3v5FUoMrxJHQiRD/JPw6CCav
         3BuUQmESfbqaISqMjiENGFUcjktaeP6sAK5//vPLq05rlOiREg132OQcn/orPmNA9A89
         0o8A==
X-Gm-Message-State: AGi0PuaXiOj8CF6bmnPw4mo5riVJd1wdeanU5nJqrRV7hDSGiuTHhkaK
        vQqTYUH9UPSYfDqCXTpQuXZ5xlnTmhRMk8kmP+WJkg==
X-Google-Smtp-Source: APiQypIkVbWK0Y/NjP6SU5E5L6VATrX3t+lUaZZYekHGYc+ikfyuybV0BXu40Puubowf7WnD35eo+JaAfoRr1FC2kTk=
X-Received: by 2002:ac2:5c4e:: with SMTP id s14mr5882671lfp.77.1587036794076;
 Thu, 16 Apr 2020 04:33:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200414222713.32660-1-digetx@gmail.com>
In-Reply-To: <20200414222713.32660-1-digetx@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 16 Apr 2020 13:33:03 +0200
Message-ID: <CACRpkdY_J8e127etFFYkoxLDDkc334Xgg8ZbapdU36oGsaZ08g@mail.gmail.com>
Subject: Re: [PATCH v1] iio: magnetometer: ak8974: Silence deferred-probe error
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Dmitry,

thanks for your patch!

On Wed, Apr 15, 2020 at 12:27 AM Dmitry Osipenko <digetx@gmail.com> wrote:

> It's not uncommon that voltage regulator becomes available later during
> kernel's boot process, in this case there is no need to print a noisy
> error message. This patch moves the message about unavailable regulator
> to the debug level in a case of the deferred-probe error and also amends
> the message with error code.
>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/iio/magnetometer/ak8974.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iio/magnetometer/ak8974.c b/drivers/iio/magnetometer/ak8974.c
> index d32996702110..cc3861f97d42 100644
> --- a/drivers/iio/magnetometer/ak8974.c
> +++ b/drivers/iio/magnetometer/ak8974.c
> @@ -718,6 +718,7 @@ static const struct regmap_config ak8974_regmap_config = {
>  static int ak8974_probe(struct i2c_client *i2c,
>                         const struct i2c_device_id *id)
>  {
> +       const char *level = KERN_ERR;
>         struct iio_dev *indio_dev;
>         struct ak8974 *ak8974;
>         unsigned long irq_trig;
> @@ -746,7 +747,11 @@ static int ak8974_probe(struct i2c_client *i2c,
>                                       ARRAY_SIZE(ak8974->regs),
>                                       ak8974->regs);
>         if (ret < 0) {
> -               dev_err(&i2c->dev, "cannot get regulators\n");
> +               if (ret == -EPROBE_DEFER)
> +                       level = KERN_DEBUG;
> +
> +               dev_printk(level, &i2c->dev, "cannot get regulators: %d\n",

This misses some important aspects of dev_dbg(), notably this:

#if defined(CONFIG_DYNAMIC_DEBUG)
#define dev_dbg(dev, fmt, ...)                                          \
        dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
#elif defined(DEBUG)
#define dev_dbg(dev, fmt, ...)                                          \
        dev_printk(KERN_DEBUG, dev, dev_fmt(fmt), ##__VA_ARGS__)
#else
#define dev_dbg(dev, fmt, ...)                                          \
({                                                                      \
        if (0)                                                          \
                dev_printk(KERN_DEBUG, dev, dev_fmt(fmt), ##__VA_ARGS__); \
})
#endif

If DEBUG is not defined the entire dev_dbg() message is enclodes in if (0)
and compiled out of the kernel, saving space. The above does not
fulfil that.

Yours,
Linus Walleij
