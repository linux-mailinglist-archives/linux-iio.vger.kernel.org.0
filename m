Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78D7F23148C
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jul 2020 23:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729322AbgG1VYN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Jul 2020 17:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729243AbgG1VYJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Jul 2020 17:24:09 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64E4DC0619D4
        for <linux-iio@vger.kernel.org>; Tue, 28 Jul 2020 14:24:09 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id g11so10340321ejr.0
        for <linux-iio@vger.kernel.org>; Tue, 28 Jul 2020 14:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A40P7qvWDr7hSDOUUBLZppAbSNbGdWqbtbvvJ8/dneg=;
        b=l6hUntl9Y1jAFAvRM3OZ07jD1ncrYLjRRWnW80nV17Xay1+XqKIYJY8f4s7XOS7gvf
         LBoRYt9/GuIYjVwqGCaSfSzZRvzCBPQtJSGB3HyLhDgUeQLBCkzsPt5zUnFzQLQxBuOF
         i7m583btWK9pCPqDWcZPEummRV7tcoi+UVTBc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A40P7qvWDr7hSDOUUBLZppAbSNbGdWqbtbvvJ8/dneg=;
        b=WLdfTJ6IBJofFNTwfaKFq+kP/MhGJzul+BGGWXz3Ttz/vF0HyLRwA+5DezV5Hebcro
         2w78lGEZRhNyoHg+IydGTa19k1U9bfqrXqzhyREZg1cuHuElirDRN/V4+kgQpgYgu4Cb
         oVrAEhacLWGay85pV5vVcn0HI5YDLPe9yKmGiqncsUweWuwA79iqh+/LkgecMoYt23g/
         LcxJiz3bEuOLlbhwCrSwTNqTUL85gZDthHppkykEGe/ljwbdEIJQ9jKap1RkaKOggjaL
         yzKtD2hRyt22pNIiETmn+Aws5bt4JvE4NoulPfGNSlPTO2Ti0gLheUF6qk2UXUXhNNan
         FVwA==
X-Gm-Message-State: AOAM530g0DdiHifvecQfOsjb8f3RYznPica1e7Sm5qIYL3qeKI3A0uQw
        1ENuMa5DRVzti+PGdy/Sqt+wiiuvWwc=
X-Google-Smtp-Source: ABdhPJz+aIB3zR2stR2YAPj+I7vRbMi5v5U3X0XrU4GP1acXNfYnSrdKygaPj43hOf3QYn0mLE/ZGA==
X-Received: by 2002:a17:906:7787:: with SMTP id s7mr12336483ejm.533.1595971447124;
        Tue, 28 Jul 2020 14:24:07 -0700 (PDT)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com. [209.85.221.42])
        by smtp.gmail.com with ESMTPSA id p1sm6237811ejz.50.2020.07.28.14.24.06
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jul 2020 14:24:06 -0700 (PDT)
Received: by mail-wr1-f42.google.com with SMTP id r12so19585549wrj.13
        for <linux-iio@vger.kernel.org>; Tue, 28 Jul 2020 14:24:06 -0700 (PDT)
X-Received: by 2002:a5d:6641:: with SMTP id f1mr26569681wrw.307.1595971445556;
 Tue, 28 Jul 2020 14:24:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200724183954.1.I2e29ae25368ba8a72a9e44121cfbc36ead8ecc6b@changeid>
 <20200728151258.1222876-1-campello@chromium.org> <20200728091057.10.Ibe84fae61cd914c116e6d59ffeb644f1cbecd601@changeid>
 <159596523705.1360974.7169089810545711557@swboyd.mtv.corp.google.com>
In-Reply-To: <159596523705.1360974.7169089810545711557@swboyd.mtv.corp.google.com>
From:   Daniel Campello <campello@chromium.org>
Date:   Tue, 28 Jul 2020 15:23:29 -0600
X-Gmail-Original-Message-ID: <CAHcu+VbYrbWStNNaidDygY=d4f6F5tXUxWtsuH0x3oVeELGWVA@mail.gmail.com>
Message-ID: <CAHcu+VbYrbWStNNaidDygY=d4f6F5tXUxWtsuH0x3oVeELGWVA@mail.gmail.com>
Subject: Re: [PATCH 10/15] iio: sx9310: Simplify error return handling
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     LKML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Enrico Granata <egranata@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Jul 28, 2020 at 1:40 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Daniel Campello (2020-07-28 08:12:53)
> > @@ -368,13 +368,13 @@ static int sx9310_wait_for_sample(struct sx9310_data *data)
> >  static int sx9310_read_proximity(struct sx9310_data *data,
> >                                  const struct iio_chan_spec *chan, int *val)
> >  {
> > -       int ret = 0;
> > +       int ret;
> >         __be16 rawval;
> >
> >         mutex_lock(&data->mutex);
> >
> >         ret = sx9310_get_read_channel(data, chan->channel);
> > -       if (ret < 0)
> > +       if (ret)
> >                 goto out;
> >
> >         if (data->client->irq) {
> > @@ -394,11 +394,11 @@ static int sx9310_read_proximity(struct sx9310_data *data,
> >
> >         mutex_lock(&data->mutex);
> >
> > -       if (ret < 0)
> > +       if (ret)
> >                 goto out_disable_irq;
>
> Why is this condition checked after grabbing the mutex? Shouldn't it be
> checked before grabbing the mutex? Or is that supposed to be a
> mutex_unlock()?
We acquire the lock before jumping to out_disable_irq which is before
a mutex_unlock()
>
> >
> >         ret = sx9310_read_prox_data(data, chan, &rawval);
> > -       if (ret < 0)
> > +       if (ret)
> >                 goto out_disable_irq;
> >
> >         *val = sign_extend32(be16_to_cpu(rawval),
