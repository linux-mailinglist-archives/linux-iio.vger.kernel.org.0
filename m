Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9721F188C
	for <lists+linux-iio@lfdr.de>; Mon,  8 Jun 2020 14:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729694AbgFHMMf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Jun 2020 08:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729666AbgFHMMc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 Jun 2020 08:12:32 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2219C08C5C3
        for <linux-iio@vger.kernel.org>; Mon,  8 Jun 2020 05:12:31 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id w15so10020154lfe.11
        for <linux-iio@vger.kernel.org>; Mon, 08 Jun 2020 05:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TBN6LwR1xQ7giOqILnPE//JlJlIgyTPuIyOhAD+Fs0g=;
        b=DfM0dsqO0f/Qnck/+Ah62rrhJWnxesv6sNiGtGlrUMkIZe0uxoX3qyYJ/QidMJamvz
         L6Bnwt3S8/SXA6KWjuV0bzahAGv1Sl1x5CS5ZEehyidgKzWz4cs/2fohftpz4t03IhmP
         CIv70QYr+yH0TB6vG8xKqYy3fw6Phyc4Ob7FxTujExXWYnwYzNFN5dt5DjZOB2jtHVyi
         pScpc+vtrc/434ZaGx0d5mEXfZ/lyQGuLIT9J5uRdtiXT2AiODcOPqwI9F21ZHqEftmT
         +8AxS85z10y6qTHVnRXGdeaO6dgqPm/WflvEoPVFPCoCi/JhDSoY89tbNu6R2JazK7tp
         A7tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TBN6LwR1xQ7giOqILnPE//JlJlIgyTPuIyOhAD+Fs0g=;
        b=ZO82EiyA2KaCdCBA5L35A/TKvK1aD+QaF3+eTghPJpxzU6aKsTFRJo5wB4XVZwYVcg
         Vpgc8riDa1Say+xkLSUKEY1sv4ZLMT1JJsdJ0gVLZJcHf3tsSrGHJH8cK17mreaMou78
         0aqm8H6aw/b7hV9PgOmm/YPfETvQWNLTTRhlgcu4gCGzPZUWetvIapopQzCycBxVYUfx
         7aSde6+sCSG2GHr/9ZX37dEPUmfzCPkbc2er4HiIqbaj4z+v+xOvZUfF1QwFyzXYQt0l
         C9hgSTkR95e0YMUB7c59X+ynziOk2Uu5KRQVTqZdaLnsFzWaAVBARRYGCOevpzKXEMyU
         NAvQ==
X-Gm-Message-State: AOAM530sZkL7maCYrgYUjBgzQfGB3PRhhxHqabfemxzonIDmquIY471B
        CYTef9jGCV/TkUE2CWJs5sx3vkZ18z4MkKd1A5oPBA==
X-Google-Smtp-Source: ABdhPJxmk7CcERIdwxefncHfN7iBpWg2VOzmqMraSrfW9OEJJz2SzxogXSAbo+g1hJ04P05NhatbtFCl4F1ofn3LcNs=
X-Received: by 2002:a19:c8cb:: with SMTP id y194mr12833236lff.89.1591618349925;
 Mon, 08 Jun 2020 05:12:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200526104717.3181-1-dinghao.liu@zju.edu.cn> <CACRpkdZi=UaGES_bupj_fQB+sPj5zOvONdCn7_Rs_j9mcukAAQ@mail.gmail.com>
 <20200531150000.20d1ec61@archlinux>
In-Reply-To: <20200531150000.20d1ec61@archlinux>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 8 Jun 2020 14:12:18 +0200
Message-ID: <CACRpkdZy0Pip1ii0g+PYpnkO21e6=J0ZXzudEgvEycCbmWYJxA@mail.gmail.com>
Subject: Re: [PATCH] [v2] iio: magnetometer: ak8974: Fix runtime PM imbalance
 on error
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Dinghao Liu <dinghao.liu@zju.edu.cn>, Kangjie Lu <kjlu@umn.edu>,
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

Hi Jonathan,

sorry for missing this :(

On Sun, May 31, 2020 at 4:00 PM Jonathan Cameron <jic23@kernel.org> wrote:
> On Tue, 26 May 2020 13:13:56 +0200
> Linus Walleij <linus.walleij@linaro.org> wrote:
>
> > On Tue, May 26, 2020 at 12:47 PM Dinghao Liu <dinghao.liu@zju.edu.cn> wrote:
> >
> > > When devm_regmap_init_i2c() returns an error code, a pairing
> > > runtime PM usage counter decrement is needed to keep the
> > > counter balanced. For error paths after ak8974_set_power(),
> > > ak8974_detect() and ak8974_reset(), things are the same.
> > >
> > > However, When iio_triggered_buffer_setup() returns an error
> > > code, there will be two PM usgae counter decrements.
> > >
> > > Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
> > > ---
> > >
> > > Changelog:
> > >
> > > v2: - Change 3 goto targets from "power_off" to
> > >       "disabel_pm". Remove unused lable "power_off".
> > >       Move 3 PM runtime related calls to the end of
> > >       the function.
> >
> > Thanks for fixing this Dinghao!
> > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>
> Could I have a fixes tag for this one?

It's been  there since the beginning so:
Fixes: 7c94a8b2ee8c ("iio: magn: add a driver for AK8974")

Yours,
Linus Walleij
