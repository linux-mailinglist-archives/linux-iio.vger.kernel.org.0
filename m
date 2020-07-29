Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30D802319F4
	for <lists+linux-iio@lfdr.de>; Wed, 29 Jul 2020 09:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbgG2HAf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 29 Jul 2020 03:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbgG2HAe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 29 Jul 2020 03:00:34 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBE6BC061794;
        Wed, 29 Jul 2020 00:00:34 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id p3so13756961pgh.3;
        Wed, 29 Jul 2020 00:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ydyx9gtyvmjZ7DrRhj6TptEXl3PlUz8eNLH76DjhVhI=;
        b=PqL8pV7jeLa+Sx/5vyatxOYMcI8YgDyaPSfT5MHX228lN5/+6lKwG/nCn2BCAf1eHV
         tL85v+PZL0W83EI+HbLt6LVl59AXxCDymxMcjfHJPAhiq+l42/0ZParzgfyo79k+jx/e
         n7W/n870mX62FNWZqSq8yFxzEYBj1IBARrjO7LG+DScnKlvaqT7AGRz3BsoDtvwp17d6
         CxShQ3Vc/Bx29wGE48leAtbphv3tAWhSX47vD0FzVoIk/oXScDdYKODO2JSSd3XJhqrT
         vtJ+TAGRkKN7V5gJ3J70A39jfZSuzNB33ZQWyCOkFQPAGHMIRUSH35Vgv7ouKvJuP3oM
         e36A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ydyx9gtyvmjZ7DrRhj6TptEXl3PlUz8eNLH76DjhVhI=;
        b=Ozjs9AiQxBstWy/TaBuQn13QQ+w94jFQ5hIXGy/Uuj4rY+LL2KM1Lip+SsM2VzKKOp
         1h9Vbhsgs/gTrlqJk4vIVWnS3sKb+6fd0b0nVplG4cDd36cxGfNqgyDg3yU0c14hOyE8
         z0uFsMCOzcG87SQBMdIDk46wWeBHrUBrKHCeR0cXrgd9/rrF8lS4sIb1HR82+Ct3TG++
         fCT0PfYNW3+Qq7NSSqtRMp65NEKprJfXEtV2dJtoXu1AVUawhNQb0VNUzvlhzGWqUKzz
         EiJFU07YZqwSEWjRjM9/M5nJr/+JIxjvj5Tuqz2zmMlbxSZDk5Zy2bPqlx1vWsDCHCI6
         7j/A==
X-Gm-Message-State: AOAM530uHfJWttqCDTT5DMzv5ZFb0cPrU+ZBU8Idz2ptmUoKyyEtCYpE
        g5gffOcSuY8r8Y6sLO3Dnz1YIyHhtjU6dULkdZ0=
X-Google-Smtp-Source: ABdhPJzBMOmiIIjC3eY9ECf9YCG3ZIfdKn8E7fsAp6Hs/425acmqVQ4MsWmW7EpO1KaETDSiv6QBEGWthO77dNs+MNc=
X-Received: by 2002:a63:924b:: with SMTP id s11mr27118530pgn.74.1596006034356;
 Wed, 29 Jul 2020 00:00:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200728151258.1222876-1-campello@chromium.org>
 <20200728230520.2011240-1-campello@chromium.org> <20200728170317.v2.7.Iecaa50e469918a385b3e5dab375e442540ea2ad4@changeid>
 <159598461271.1360974.15436404116157938506@swboyd.mtv.corp.google.com>
In-Reply-To: <159598461271.1360974.15436404116157938506@swboyd.mtv.corp.google.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 29 Jul 2020 10:00:16 +0300
Message-ID: <CAHp75Vc_3VYAkVcTCAXzqxqFnpQ4Qi=iPSFW_sUjYGO=o6YMtA@mail.gmail.com>
Subject: Re: [PATCH v2 07/14] iio: sx9310: Use long instead of int for channel bitmaps
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Daniel Campello <campello@chromium.org>,
        LKML <devicetree@vger.kernel.org>,
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

On Wed, Jul 29, 2020 at 4:03 AM Stephen Boyd <swboyd@chromium.org> wrote:
> Quoting Daniel Campello (2020-07-28 16:05:13)
> > Uses for_each_set_bit() macro to loop over channel bitmaps.

...

> > +       unsigned long chan_prox_stat;
>
> This can be DECLARE_BITMAP(chan_prox_stat, SX9310_NUM_CHANNELS)

> > +       unsigned long chan_read;
> > +       unsigned long chan_event;
>
> Same for these?

...

> > +       prox_changed = (data->chan_prox_stat ^ val) & data->chan_event;
>
> I was expecting:
>
>
>         bitmap_xor(&prox_changed, &data->chan_prox_stat, &val, SX9310_NUM_CHANNELS);
>         bitmap_and(&prox_changed, &data->chan_event, SX9310_NUM_CHANNELS);

I agree with this. On a small number of channels (up to 32) it will be
reduced to simple operations, but will leave a possibility to have
more with easy redefine.

(though _and() above misses one argument AFAICT)

...

> > +       unsigned long channels = 0;
>
> Use DECLARE_BITMAP(channels, SX9310_NUM_CHANNELS)?


-- 
With Best Regards,
Andy Shevchenko
