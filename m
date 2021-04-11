Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DDFA35B67E
	for <lists+linux-iio@lfdr.de>; Sun, 11 Apr 2021 20:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235430AbhDKSJD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 11 Apr 2021 14:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235284AbhDKSJD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 11 Apr 2021 14:09:03 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2156C061574;
        Sun, 11 Apr 2021 11:08:46 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id 20so1181805pll.7;
        Sun, 11 Apr 2021 11:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sKrFE3t8TymorDM/FfsdzwawymvWqmwx1sIu4YG7cVs=;
        b=fueG1Y8/2Yr9KdyvSKOCYPAheKlJvITdTvpIskmGqbimfv7ytSU6s0liRdzUeClvjN
         gGse5CjBNj4VYGp7Vy00DrVqsw4BZEIQ1NKKo4w8R5VsEkRgbuu9eQ2wPQgwRhGYppM1
         vEpnK260WKIVWv36rTFIUiJFYN6v3e1XRsnxPaMxNdlVsS4tibokZbzmRoY/4prkjmez
         VF5mIpPFhhNhp94akiywjXUAL7WJfNapps3Y4Ck6jhREda2rEx0Q/bp8Ifk9PDfrBNFB
         zXNvga9WBJLEP6ZhXSWBq3c2mqpIiPI2sgKKKtctb4Hh03orq8KPWejKXvDe7zHDUK6b
         +mIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sKrFE3t8TymorDM/FfsdzwawymvWqmwx1sIu4YG7cVs=;
        b=Z8IoC3fWlL8l4ogg1B/b0fzaniOmM4BjdRkpWQtECXfNST8nKjzMeDomTcG0O5TWpU
         Xtz2MiXXc6FteDPv5wgkdAAo1yhQevHuEWHmgtaOKUbe1XTGNlJb7QZLK3wFH9AXqSzi
         7oOnzqiKf/V4GPOc9pnQ5ndozGA0GT+u7om2c6M90N6brcmh6KU7OvyUXnTVTMxEa4Rq
         tWZtrk7ysOzpKCM4T5pwRTj7unkAlIV7ChfKtfSfO8XXnrD+0Gf4WQzFRXFnIeREPvLT
         tsI7p5LpERGlED7RYTGQl6ifCEfUMDi3kKonwzN9E573ZwYtFxfAxH+zzT2yXqR34Yxh
         lMMQ==
X-Gm-Message-State: AOAM532x9F6ivQRSWch4ae3GieGVUotIme2e1N/kYgODs/gyNdy+r+Qf
        /gsbgmyn/104ufmj48HdQjCAsWfXQZOzWjd885E=
X-Google-Smtp-Source: ABdhPJyT6O/qHsDNw4Rz7aqr1S1sh7Q8GP/FR5YMLxJoHYB4d1n2KREa+irqyorif/EklfYTiKqvXUkgLdWB/cuVndo=
X-Received: by 2002:a17:90a:156:: with SMTP id z22mr26089612pje.181.1618164525827;
 Sun, 11 Apr 2021 11:08:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210407182147.77221-1-puranjay12@gmail.com> <20210407182147.77221-3-puranjay12@gmail.com>
 <20210411155420.318e866e@jic23-huawei> <CAHp75VcQYLRJ-p4CWJyk3h0=nL=TqwEFAxkO+z1Nbg8=3Fchyg@mail.gmail.com>
In-Reply-To: <CAHp75VcQYLRJ-p4CWJyk3h0=nL=TqwEFAxkO+z1Nbg8=3Fchyg@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 11 Apr 2021 21:08:29 +0300
Message-ID: <CAHp75VfN5J747w6o=A2eng+9SV_2L-NH28O=sGRuxGz_oxPh-Q@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] iio: temperature: add driver support for ti tmp117
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Puranjay Mohan <puranjay12@gmail.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        devicetree <devicetree@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Apr 11, 2021 at 9:07 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Sun, Apr 11, 2021 at 5:53 PM Jonathan Cameron <jic23@kernel.org> wrote:
> > On Wed,  7 Apr 2021 23:51:47 +0530
> > Puranjay Mohan <puranjay12@gmail.com> wrote:

> Good point, but better is to use clamp_t(s16, ...) rather than explicit casting.

Sorry, I meant clamp_t(int, ...) of course, otherwise it will give wrong values.

> I always consider explicit casting in C (and esp. in Linux kernel) is
> a red flag. Should be really rarely needed.



-- 
With Best Regards,
Andy Shevchenko
