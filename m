Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40FC03EE683
	for <lists+linux-iio@lfdr.de>; Tue, 17 Aug 2021 08:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234355AbhHQGSy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Aug 2021 02:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234233AbhHQGSy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Aug 2021 02:18:54 -0400
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F30ADC0613C1
        for <linux-iio@vger.kernel.org>; Mon, 16 Aug 2021 23:18:21 -0700 (PDT)
Received: by mail-ua1-x92e.google.com with SMTP id m39so8575571uad.9
        for <linux-iio@vger.kernel.org>; Mon, 16 Aug 2021 23:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LZJAGR1WyjyArrVWmYMYXGcGz885PHdRW+PqKe5e+TY=;
        b=DFi3kcXi+PvWxJzssbjlLt8bwPhtsnGimjnjW35mdQFk1T3ngzjDgdjAXPUb3CJDOp
         11+x9sD5FZyYf5DZM+SpviBaCeWRcFZ6dpWcRsFf3FedSUunv7cKkfZY6XDYuqFwN8gi
         LzDl5I5thKB6s8IB5uCX01Hp7Pp86Nng/ggOi4J+8QFd+TIKuQCBzLI+CGMBmailR8I8
         iVRNOZ6MtgaSe1XobiSU8R1RvATrFWPzVaeHaPgUF/joDNjBHBrAsjcZjz2OdTunWynG
         5YsS378P7wIkaNN1Ypmj8XgLN8+kBMRAc1nvVVv59Ysb+W6Gvu2tYEtvDnuOu0bBjNv/
         ulYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LZJAGR1WyjyArrVWmYMYXGcGz885PHdRW+PqKe5e+TY=;
        b=GlpCVyu7BSlVa+1NrQ1pYBz3kRxf7e86/npHrevgZKgNLvOGbTqEC6ZlOoJ4r5V4KA
         CAwgDM4KIancUwVgQJ5sqLahSoWuFAvZUPzUq3hoCHTAbkQVQZNlMLfbHM0IDEHkhK9F
         MCRL3tlXHhjKSBCpVIJEouZDBXDTVIyto+XBLMenN3TS6Xs+wRCn4WoD7sFfOrm7p54k
         cOwjnW4TBeZY4EpHCfurWyWXiX2JUYJKpRNJnDa0JwEmdDN2KgdYm/gPW5r0m9m0kQuF
         3LscrgnT4ORijAzhEZdhQpf54ynm0oEtJzTrFuVLq9O3nr274u6qHazBHyUDAsQhj8VF
         WHMQ==
X-Gm-Message-State: AOAM533tMsTjLUoCnnTfQDNcP2ZUq7f8BioiT2R08EzLSbnUwM1Szbqq
        dBT1mGxQ2iSa5rqi8EtGg18Covf7dgqn5rzXTS0GEQ==
X-Google-Smtp-Source: ABdhPJxbludAJCCDYjDmsNISUqju88UDlNFW6dyyUt6Vk3/GIP3VZTuygkzkFmWPXKCAKp2O59FbQI7Sdn3o0dAI/Lc=
X-Received: by 2002:a9f:2d88:: with SMTP id v8mr917275uaj.50.1629181101095;
 Mon, 16 Aug 2021 23:18:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210816082836.67511-1-aardelean@deviqon.com> <20210816082836.67511-2-aardelean@deviqon.com>
 <CACRpkdaYLd=R9SjqLF=j94fjbG-urHW6C6rXJ3oGnJM9W78P4g@mail.gmail.com>
In-Reply-To: <CACRpkdaYLd=R9SjqLF=j94fjbG-urHW6C6rXJ3oGnJM9W78P4g@mail.gmail.com>
From:   Alexandru Ardelean <aardelean@deviqon.com>
Date:   Tue, 17 Aug 2021 09:18:10 +0300
Message-ID: <CAASAkoYDyiY5HuWVfiCLfjtNVKWDbcCVoCfc=udSat1ngtcfVw@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] iio: st_sensors: disable regulators after device unregistration
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Denis CIOCCA <denis.ciocca@st.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 17 Aug 2021 at 01:50, Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Mon, Aug 16, 2021 at 10:30 AM Alexandru Ardelean
> <aardelean@deviqon.com> wrote:
>
> > Up until commit ea7e586bdd331 ("iio: st_sensors: move regulator retrieveal
> > to core") only the ST pressure driver seems to have had any regulator
> > disable. After that commit, the regulator handling was moved into the
> > common st_sensors logic.
> >
> > In all instances of this regulator handling, the regulators were disabled
> > before unregistering the IIO device.
> > This can cause issues where the device would be powered down and still be
> > available to userspace, allowing it to send invalid/garbage data.
> >
> > This change moves the st_sensors_power_disable() after the common probe
> > functions. These common probe functions also handle unregistering the IIO
> > device.
> >
> > Fixes: 774487611c949 ("iio: pressure-core: st: Provide support for the Vdd power supply")
> > Fixes: ea7e586bdd331 ("iio: st_sensors: move regulator retrieveal to core")
> > Cc: Lee Jones <lee.jones@linaro.org>
> > Cc: Denis CIOCCA <denis.ciocca@st.com>
> > Cc: Linus Walleij <linus.walleij@linaro.org>
> > Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
>
> That's a valid concern I suppose:
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>
> But as it now occurs last before return 0, can't we just solve
> this with a
> devm_add_action_or_reset(dev, st_sensors_power_off_action, *);
> of some kind and let devres handle it?

i think this is my fault for not CC-ing the entire series to you:

https://patchwork.kernel.org/project/linux-iio/list/?series=531879

this is part of a larger conversion to devm_ for ST sensors;

i was hoping that if i CC you on one patch, then git send-email would
CC you on the entire set;
doesn't seem to be the case;
i'll try to remember that on the next sets;
[but maybe having this written here, will help me remember]

>
> c.f
> drivers/input/touchscreen/cy8ctma140.c
>
> Yours,
> Linus Walleij
