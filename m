Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 684E61B2509
	for <lists+linux-iio@lfdr.de>; Tue, 21 Apr 2020 13:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728680AbgDULYi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 21 Apr 2020 07:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728621AbgDULYh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Apr 2020 07:24:37 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E6CC061A10;
        Tue, 21 Apr 2020 04:24:37 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id p25so6456936pfn.11;
        Tue, 21 Apr 2020 04:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/nyZHnIln5SMvHTDYDPunqthnn+W6+8Xnre7urXhwVU=;
        b=mOG4tZNBITuLYVAvk5EmokI/PBxfJ81UacvSZUJMUBYH+Nqx7/qNaWaep6LO11k/uo
         kobKQyu9ZvqiFH481jOR6kBhGVLqmSa3IkVbagWWdfFoNhANdRFNtJl85kv224/61Lj7
         HYYk5cSKPGNRUvcQl3ueKj0FWzNouX89mqbBwFEr8+GB7ktaafmZOAngOLHwcSHldWeJ
         mxrH/M3UGyADMvu4t/bkX+9OLJPAUMpzbmK+dRmW/PGWa77/ihr2YPN/NaSPm/urCC5U
         1z0vNCBS+ErWvgFUlJhnk/o7rSbveHP5rDWRLd6V9dy26JPmtbiVS3LnY3s+CfeTP2VG
         K9sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/nyZHnIln5SMvHTDYDPunqthnn+W6+8Xnre7urXhwVU=;
        b=Mcfk2dz30EDaFeXp3oUzfrRjpOVjUa2R4Kl3UknYdunv4HY2F7hSKntfyhJS/vuqHi
         yUHo624IfqVB1sWj1/NSz85j/hbNZjxMI2WO2JntqJJ5C6RJ2KxODObZS/Dh6Uymqnea
         DXrAUWqLudHn6qwZTKUMz8qhxkPOab1mDf2vDh8FEXn9s7IOs2NnsSU550RCg+0mxfz5
         91qgEdEeEdqEIcUaQiOx/LsdkTV1MB7ZR2SA3rmGWLr4rTQNHnmgstql6dB0fYGl9yfC
         fLMflons3jNStDrhuWmOsRTf4iKznozLYHjHN2pzUxKKkcL50QXcKdNTetgTAS29vkI/
         DChA==
X-Gm-Message-State: AGi0PubnyaEGRQrXXMNyeWl64yugmCChlZ8TowKxoAUnL3hp3XSEVnsG
        qIRSlbUXm5P2r9GvPVYmtBpOKeLtW3LLpYKNd4s=
X-Google-Smtp-Source: APiQypIVzlWfRnaxaJumLw77nPa/kSeajFst1dOacYBx6oSGxO0JU/IhLBjyOF19HfaOcTod4y++nlu4L6veLzfHZ3Y=
X-Received: by 2002:a63:1d4:: with SMTP id 203mr20189317pgb.74.1587468276844;
 Tue, 21 Apr 2020 04:24:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200421075532.19192-1-m.othacehe@gmail.com> <20200421075532.19192-3-m.othacehe@gmail.com>
In-Reply-To: <20200421075532.19192-3-m.othacehe@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 21 Apr 2020 14:24:30 +0300
Message-ID: <CAHp75Veqp=tb0Z9h2cey5DE_KpNBp3Jdmh2gLzSoo-N5CsGpvw@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] iio: vcnl4000: Add event support for VCNL4010/20.
To:     Mathieu Othacehe <m.othacehe@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Apr 21, 2020 at 10:57 AM Mathieu Othacehe <m.othacehe@gmail.com> wrote:
>
> The VCNL4010 and VCNL4020 chips are able to raise interrupts on proximity
> threshold events. Add support for threshold rising and falling events for
> those two chips.

Some nitpicks below (up to you and maintainer to address)

...

> +static bool vcnl4010_in_periodic_mode(struct vcnl4000_data *data)

Since it's boolean I would name it ..._is_in_prediodic_mode().

>  {
> +       int ret;
>
> +       ret = i2c_smbus_read_byte_data(data->client, VCNL4000_COMMAND);
> +       if (ret < 0)
> +               return false;
>

> +       return (ret & VCNL4000_SELF_TIMED_EN) > 0;

This > 0  for bitmasked values looks slightly strange. And actually if
a sign bit is included, potentially wrong.

I would rather go without any comparison, or do !!(foo & BAR).

> +}

...

> +static bool vcnl4010_thr_enabled(struct vcnl4000_data *data)

_is_thr_enabled() ?

> +{
> +       int ret;
> +
> +       ret = i2c_smbus_read_byte_data(data->client, VCNL4010_INT_CTRL);
> +       if (ret < 0)
> +               return false;
> +

> +       return (ret & VCNL4010_INT_THR_EN) > 0;

Ditto.

> +}

...

> +               ret = devm_request_threaded_irq(&client->dev, client->irq,
> +                                               NULL, vcnl4010_irq_thread,
> +                                               IRQF_TRIGGER_FALLING |

> +                                               IRQF_ONESHOT,

Isn't it by default when threaded IRQ is asked with NULL for hw handler?

> +                                               "vcnl4010_irq",
> +                                               indio_dev);


-- 
With Best Regards,
Andy Shevchenko
