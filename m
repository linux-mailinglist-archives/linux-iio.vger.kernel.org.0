Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15C762918E2
	for <lists+linux-iio@lfdr.de>; Sun, 18 Oct 2020 20:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbgJRSdZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 18 Oct 2020 14:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbgJRSdY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 18 Oct 2020 14:33:24 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F69C061755;
        Sun, 18 Oct 2020 11:33:24 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id t4so1225053plq.13;
        Sun, 18 Oct 2020 11:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0SrAGDyFK2BtNvaUQ65CcmVzLfIt/f5Hvduu3nRwUdw=;
        b=VB2Ag15GmAzpJXuXh/iym02MciTot9l2fl+pc6XM5bOK7OPRdiykb7AKYo9fIUnRP7
         hOWMciGEd1qdenktWa0UyCr0Kv/wSy6LjWPGLt+a+F5xN9pI8MXwvUhXasGbLmmJzExL
         cMFPu0rd/1lehBji8g7bez6LDDQ8lNS4Dlumq7aUwdkhpsIB137fEoTbYR0uThA/IclT
         EvWIMYTXSyoVVR8zDfrj0C2g3SsWj0imX5MF0nbeXA/z2XsEcg8PF2Zofp2kK332ljDp
         5K3w/TntEfYGYI0PfLG4/HPNCSE7wDQSdeLNzOVfTmBs1FyL7nj8QcdHRYCWprALypao
         Vpyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0SrAGDyFK2BtNvaUQ65CcmVzLfIt/f5Hvduu3nRwUdw=;
        b=SLWxDGy6O+8e6oqkYeDboT/YfEiIvVqbmUf3l1xYp6RUA6LuNjpMpoGK6+RGYMQI3j
         lOU0WfQ4AvcdwIoktDo+zYIWQyxFJAAHMjKWRCL4+YBbCzX494nyWpdIwXxDS/c0KvBS
         vfSs1Jdk7/AVSg2CIxgD2bqQIyk3DXJiIf55xxFQZqdMo22GgbyDTo6ATFvIDvoPYED7
         Pm89BAklBYFaMR2iqhuewmLxuXI+rgy6oU20oTutJY5G2DTwHux4udGX7069UXarH/im
         iICPzo8o4vbxeKxhsW3g87wAN1UKHlHxsMz7yfXLjSA0mErKqdP/n+YJHYQKqlbZbVuY
         8icg==
X-Gm-Message-State: AOAM5338GLrxk/ljCr4ytMSHDsbnRkWzqQPZTT6YRZp+e9cZVHU8Axzj
        4Bvh9gf747fqkogPh9MIjgoCZhif2bSuTJMd5kw=
X-Google-Smtp-Source: ABdhPJypeDUZ9reAGTE+LRn4S1EdN7M3XMYdbpqrqhgMlq3vVZ/xmPqYOcYlt663OzGWlvWpihVjCdE36fP7laIhiLA=
X-Received: by 2002:a17:90a:be11:: with SMTP id a17mr13500911pjs.181.1603046003874;
 Sun, 18 Oct 2020 11:33:23 -0700 (PDT)
MIME-Version: 1.0
References: <20201018171545.3190476-1-fparent@baylibre.com> <CAHp75VfJUhA3WmmirctmrieQfZKSNerFa=nwPmBYvffXUTRp9A@mail.gmail.com>
In-Reply-To: <CAHp75VfJUhA3WmmirctmrieQfZKSNerFa=nwPmBYvffXUTRp9A@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 18 Oct 2020 21:33:08 +0300
Message-ID: <CAHp75VdFw5jy10QSOFbJVyObqEmiaavFM=BFd92kw1AH4rMxqw@mail.gmail.com>
Subject: Re: [PATCH v2] iio: adc: mediatek: fix unset field
To:     Fabien Parent <fparent@baylibre.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>, chun-hung.wu@mediatek.com,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Lars-Peter Clausen <lars@metafoo.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Oct 18, 2020 at 9:31 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Sun, Oct 18, 2020 at 8:16 PM Fabien Parent <fparent@baylibre.com> wrote:
> >
> > dev_comp field is used in a couple of places but it is never set. This
> > results in kernel oops when dereferencing a NULL pointer. Set the
> > `dev_comp` field correctly in the probe function.
> >
> > Fixes: 6d97024dce23 ("iio: adc: mediatek: mt6577-auxadc, add mt6765 support")
> >
> > Signed-off-by: Fabien Parent <fparent@baylibre.com>
>
> Shouldn't be a blank line in the tag block.
>
> I think Jonathan can fix it, but be more careful in the future.

One more serious issue, you forgot to add tags you have gotten in the
previous round.

-- 
With Best Regards,
Andy Shevchenko
