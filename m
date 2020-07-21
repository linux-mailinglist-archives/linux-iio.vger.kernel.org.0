Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB4E228921
	for <lists+linux-iio@lfdr.de>; Tue, 21 Jul 2020 21:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730250AbgGUT3G (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 21 Jul 2020 15:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729171AbgGUT3G (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Jul 2020 15:29:06 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8052C061794;
        Tue, 21 Jul 2020 12:29:05 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id w17so10674036ply.11;
        Tue, 21 Jul 2020 12:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=62ADtBFBhYcqBVR6Gt91xol/T5WTzsilk8v+olTZ/u4=;
        b=uPoRI6dPcH7lfcbfKHIbIv4yuwrI87QxMF6Nw7ID1lmREq/NbtC2uisUx/IF5Mk5HH
         tRsfLSoD+27L/2AyGJI2YL7KUQEdkJ/9bZbDTn6KRL9NMx2QKe9RTSeTxCIpdRVcIULs
         Wj2s1sQRMQcgkU0U7O7L85z6/63HYkKQOCFPrbOrGRQIcITgMoPEdHx94S0vetZvcEVp
         DO1odYJ3Dcds8JKOJUIIAX9OmoTYDG5S6pvXwlkP8Y+cmySKaVv5sGa8QWxWlOz2iRo1
         mVZRxiUkjUncXjz9R/IDl/zCavvndKt3Mv8ZVhi4dmWRkGBXeIARa0ztIAwmS67Jehzm
         Gl6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=62ADtBFBhYcqBVR6Gt91xol/T5WTzsilk8v+olTZ/u4=;
        b=IexVSx63YokFreZbOSxEnjdal7Lce1FtJX9svWJplrZ8D2s4JDzD62OUbW0SS7YCS1
         Qo5g1tvMwW8v05Ny7GX+swTCTh/ngV18tWIrImbd8t9nH8UAH4cV6KjNTu/E/30701ku
         tgCG9sWhJ4Ya+DzLEIbg7LJoW9lc0GBKQJmBGIAtPIk1Tlt0onyJyhpoObkoMR0OGuha
         3WgeXT6oA/iQtdhH7xaX/PABPgic+fNYi44DafX5wOCuH5lAvOfyOD4bP+9AX6OGHAUD
         OuDEUkItmHo/ambAjvvcTG/60dkaZduuPExh9yeqFcuDAdj5zZYHpg1gpAUjy38Zob5t
         vAqw==
X-Gm-Message-State: AOAM533LYsoF4HKE9gYwiT25vQQapZUyi+cBrG+Amb+F3dJjPyJdLjse
        Vx3ds9+31Lo46Lvxbre+rBxIfCvSDqP4WcgxGHoXYF10
X-Google-Smtp-Source: ABdhPJyeir2Od8+wU7HtiWqWxVS4QRSScuYupOa3OpwEVMcucaTqRg57rJZu9sx8CkLzSuDg/wzDllSvMGL3q32E8C0=
X-Received: by 2002:a17:90a:a393:: with SMTP id x19mr6527601pjp.228.1595359745442;
 Tue, 21 Jul 2020 12:29:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200716072737.9535-1-cristian.pop@analog.com>
In-Reply-To: <20200716072737.9535-1-cristian.pop@analog.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 21 Jul 2020 22:28:49 +0300
Message-ID: <CAHp75VfoykNS5kqNt=0t4nHJS_+p5R2DUYKB02H3TCMQPNOisg@mail.gmail.com>
Subject: Re: [RFC PATCH] one-bit-adc-dac: Add initial version of one bit ADC, DAC
To:     Cristian Pop <cristian.pop@analog.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Jul 16, 2020 at 10:27 AM Cristian Pop <cristian.pop@analog.com> wrote:
>
> Implementation for 1-bit ADC (comparator) and a 1-bit DAC (switch)

...

> +struct one_bit_adc_dac_state {

> +       struct platform_device  *pdev;

Wouldn't 'struct device *dev;' be enough?

> +       struct gpio_descs       *in_gpio_descs;
> +       struct gpio_descs       *out_gpio_descs;
> +};

...

> +{
> +       struct one_bit_adc_dac_state *st = iio_priv(indio_dev);
> +       int in_num_ch = 0, out_num_ch = 0;
> +       int channel = chan->channel;

> +       if (st->in_gpio_descs)
> +               in_num_ch = st->in_gpio_descs->ndescs;
> +
> +       if (st->out_gpio_descs)
> +               out_num_ch = st->out_gpio_descs->ndescs;

I'm wondering if you need these conditionals. Is it even possible you
have ndescs > 0 and no descriptors?

> +       switch (info) {
> +       case IIO_CHAN_INFO_RAW:
> +               if (channel < in_num_ch) {

> +                       *val = gpiod_get_value_cansleep(
> +                               st->in_gpio_descs->desc[channel]);

Strange indentation...

> +               } else {
> +                       channel -= in_num_ch;

> +                       *val = gpiod_get_value_cansleep(
> +                               st->out_gpio_descs->desc[channel]);

Ditto.

> +               }
> +               return IIO_VAL_INT;
> +       default:
> +               return -EINVAL;
> +       }
> +}
> +
> +static int one_bit_adc_dac_write_raw(struct iio_dev *indio_dev,
> +                           struct iio_chan_spec const *chan,
> +                           int val,
> +                           int val2,
> +                           long info)
> +{

Same comments as per previous function above.

> +}

...

> +       ret = device_property_read_string_array(&st->pdev->dev,
> +                                       propname,
> +                                       gpio_names,
> +                                       num_ch);

> +       if (ret < 0)

if (ret)

> +               return ret;

...

> +       channels = devm_kcalloc(indio_dev->dev.parent, (in_num_ch + out_num_ch),

Extra parentheses.

> +                               sizeof(struct iio_chan_spec), GFP_KERNEL);

sizeof(*channels) ?

> +       if (!channels)
> +               return -ENOMEM;

...

> +static const struct of_device_id one_bit_adc_dac_dt_match[] = {
> +       { .compatible = "adi,one-bit-adc-dac" },

> +       {},

No comma here!

> +};

> +

Unnecessary blank line.

> +MODULE_DEVICE_TABLE(of, one_bit_adc_dac_dt_match);

...

> +

Ditto.

> +module_platform_driver(one_bit_adc_dac_driver);

-- 
With Best Regards,
Andy Shevchenko
