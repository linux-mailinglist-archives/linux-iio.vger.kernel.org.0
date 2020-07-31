Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54EF8234899
	for <lists+linux-iio@lfdr.de>; Fri, 31 Jul 2020 17:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbgGaPpT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 31 Jul 2020 11:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387504AbgGaPpP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 31 Jul 2020 11:45:15 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1485C061756
        for <linux-iio@vger.kernel.org>; Fri, 31 Jul 2020 08:45:14 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id n2so22665698edr.5
        for <linux-iio@vger.kernel.org>; Fri, 31 Jul 2020 08:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N7m+/JdShBAl8ZFhgGbxzIHmxleILf3IO0zdQ2ETCdA=;
        b=Y7vF9niFn53UM3USo/9vLjcOj3BjbGGNGcNZNOYb+jWP9BM9+uecOaBedA8idf7Yui
         Hncnfb6i0gcHFVCXqNFQ448xEQCg5ICDMd/gOnxaiLb4RFVL+ZLzDss9P04b5XiIK7XP
         yT2lx/QZnv49aDXAMrILcUSTqjxhxDIfA+/cE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N7m+/JdShBAl8ZFhgGbxzIHmxleILf3IO0zdQ2ETCdA=;
        b=pW7LyAKTqtN5+7kG9ZA/qO+BcBhngkIXflwu7S/yV2ioksWSBuYcxl3wVpKB0xMU2t
         y5lK8bVN/bUy/Q6jpf9mRQ85ZA07iNWmFP4V01+/oHrbf7ypKTH79vUfsd6li+zrudVc
         x5dDLxAi0VasL3O1d+15XiJrvEQE1aAKvtFoI8kwdGkfEb0h6ujWIi6fLSoNAWY+octR
         aWQScwT7MaI5j2IKXPXDcbHogdrqahGft18RKIQGG/+yD2KES1vH97xJPIhj+YmV1trp
         SLUauiu6T+D16Rku4iexvS8hLHN3jcjV5ldJaXn8ugOzVXAs7gRlFxxMA8K8ApmivbOi
         nnFg==
X-Gm-Message-State: AOAM532aqE4yWYpCOIW1GQX1twJ5FCyFAJCkNkCtCG27Yk34E860Eh1+
        PkdTZAPnySEnVZQ8Ev5OM6ZUE04teJw=
X-Google-Smtp-Source: ABdhPJxelhd3MBTCwr+OiM21Z5gP9Yh+kiKhmhjmHxg5BK9k9Z1mTU7JJi3ferXslxIPf/gxA7Fiig==
X-Received: by 2002:a05:6402:1591:: with SMTP id c17mr871132edv.240.1596210313088;
        Fri, 31 Jul 2020 08:45:13 -0700 (PDT)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com. [209.85.128.47])
        by smtp.gmail.com with ESMTPSA id sb3sm9676867ejb.113.2020.07.31.08.45.11
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jul 2020 08:45:11 -0700 (PDT)
Received: by mail-wm1-f47.google.com with SMTP id p14so8921835wmg.1
        for <linux-iio@vger.kernel.org>; Fri, 31 Jul 2020 08:45:11 -0700 (PDT)
X-Received: by 2002:a1c:e908:: with SMTP id q8mr4627256wmc.59.1596210310707;
 Fri, 31 Jul 2020 08:45:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200728151258.1222876-1-campello@chromium.org>
 <20200728230520.2011240-1-campello@chromium.org> <20200728170317.v2.7.Iecaa50e469918a385b3e5dab375e442540ea2ad4@changeid>
 <159598461271.1360974.15436404116157938506@swboyd.mtv.corp.google.com> <CAHp75Vc_3VYAkVcTCAXzqxqFnpQ4Qi=iPSFW_sUjYGO=o6YMtA@mail.gmail.com>
In-Reply-To: <CAHp75Vc_3VYAkVcTCAXzqxqFnpQ4Qi=iPSFW_sUjYGO=o6YMtA@mail.gmail.com>
From:   Daniel Campello <campello@chromium.org>
Date:   Fri, 31 Jul 2020 09:44:34 -0600
X-Gmail-Original-Message-ID: <CAHcu+VaKGNxAY_OQ4oS5NtkoDLGkv2x_VrQhZ7OvEFAnNbYZeg@mail.gmail.com>
Message-ID: <CAHcu+VaKGNxAY_OQ4oS5NtkoDLGkv2x_VrQhZ7OvEFAnNbYZeg@mail.gmail.com>
Subject: Re: [PATCH v2 07/14] iio: sx9310: Use long instead of int for channel bitmaps
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Stephen Boyd <swboyd@chromium.org>,
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

On Wed, Jul 29, 2020 at 1:00 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Wed, Jul 29, 2020 at 4:03 AM Stephen Boyd <swboyd@chromium.org> wrote:
> > Quoting Daniel Campello (2020-07-28 16:05:13)
> > > Uses for_each_set_bit() macro to loop over channel bitmaps.
>
> ...
>
> > > +       unsigned long chan_prox_stat;
> >
> > This can be DECLARE_BITMAP(chan_prox_stat, SX9310_NUM_CHANNELS)
>
> > > +       unsigned long chan_read;
> > > +       unsigned long chan_event;
> >
> > Same for these?
All of these are eventually used by regmap_update_bits() which expects
unsigned int. I believe the extra complexity is not worth it given the
number of channels.
>
> ...
>
> > > +       prox_changed = (data->chan_prox_stat ^ val) & data->chan_event;
> >
> > I was expecting:
> >
> >
> >         bitmap_xor(&prox_changed, &data->chan_prox_stat, &val, SX9310_NUM_CHANNELS);
> >         bitmap_and(&prox_changed, &data->chan_event, SX9310_NUM_CHANNELS);
>
> I agree with this. On a small number of channels (up to 32) it will be
> reduced to simple operations, but will leave a possibility to have
> more with easy redefine.
>
> (though _and() above misses one argument AFAICT)
>
> ...
>
> > > +       unsigned long channels = 0;
> >
> > Use DECLARE_BITMAP(channels, SX9310_NUM_CHANNELS)?
>
>
> --
> With Best Regards,
> Andy Shevchenko
