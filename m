Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 024F5377394
	for <lists+linux-iio@lfdr.de>; Sat,  8 May 2021 20:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbhEHSWX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 8 May 2021 14:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbhEHSWW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 8 May 2021 14:22:22 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4408C06175F
        for <linux-iio@vger.kernel.org>; Sat,  8 May 2021 11:21:20 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id b7so15687211ljr.4
        for <linux-iio@vger.kernel.org>; Sat, 08 May 2021 11:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vpLZHnBATYASHX2qyiYXjM99nZsADzAJuHz545iDnMw=;
        b=mO2WlNzoRrtDS3eRiZFmbBIjJyWzwqejoHEMnZi79SbFMnr2JnZlY/c0Qoa5dv2XAa
         rCqqL771Im0TYp8v8wom22qna9AviEv5GvP2xEN3HPrm4OirjqN/6a2+qo2xjLfRCdGS
         o6VjV+OsbreQ5X/On0x2vINCoRmDEQJXps/e0eWqOQxzd6K+xS4bVvqIEGkEfpHaMDoN
         U2a/GNhxpYXZmNStIu9c8uecnLb/XrhnvypOWIgCSiauXyjfDsmm757GhDphaPVapoGX
         GNgDiFliI2KVvv2dNk7v6quVqcNjXwP6d+vUpHr6/uA3TsgxezqthST2NFx3bYwTfJ94
         Ttng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vpLZHnBATYASHX2qyiYXjM99nZsADzAJuHz545iDnMw=;
        b=ZFnpz3aBO+yyWa0lXKoUtkPXd8yJ5DCGJjVU2wxkZPtiF1xYmpFicvuGpKcqJnZjCh
         44UrAotw+QHh/WLJOsFBzcoAU2nyIYFJ6Af/r4Tx/6m+9kcdB0mAhc8Efput7tkANBNc
         ivb0kbBmmL+ePjULqDU2J/4iGsroDRcj4YsfCeLTz+Dc1jNXr6ygmiP2jM0NuyjBDt8q
         YTjpLiKRBH/CcDXvnFx82YKj7EUDvGD1M22YD09L8BJtRAHuvoI8ytD6x0oqBxmgwe2V
         vSGerMUel5jIQcmJztTG+o4h/ArVP86y2uS0LCKlLuJB68xNx9zFF0/DpVzdE2k1rIHl
         oFUA==
X-Gm-Message-State: AOAM530cuEf7wB2QzTGWArXbrkxtfFRNnB2oE2AwRqOZZO5tiYk3PmMy
        kcU3vWrsqO11Y+E7JZF91SmdHXDv/8FKkL83CuMB+g==
X-Google-Smtp-Source: ABdhPJy9paLVPUwnbFLwB+T8DxKC5dCGEYLRFZ1EvriEcPhw9kKSXHzsqwSSsevyxFuDqZjnAxwAkqVYVAnoBEoQ1ms=
X-Received: by 2002:a2e:2e12:: with SMTP id u18mr12755146lju.200.1620498079364;
 Sat, 08 May 2021 11:21:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210503144350.7496-1-aardelean@deviqon.com> <20210508161643.5990ec15@jic23-huawei>
In-Reply-To: <20210508161643.5990ec15@jic23-huawei>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 8 May 2021 20:21:08 +0200
Message-ID: <CACRpkdaK6AMVUC+B7JW3y28nNeAYHAS9UjC40KfShZNrHLD7rQ@mail.gmail.com>
Subject: Re: [PATCH] iio: core: return ENODEV if ioctl is unknown
To:     Jonathan Cameron <jic23@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     Alexandru Ardelean <aardelean@deviqon.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Nuno Sa <nuno.sa@analog.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, May 8, 2021 at 5:15 PM Jonathan Cameron <jic23@kernel.org> wrote:
> On Mon,  3 May 2021 17:43:50 +0300 Alexandru Ardelean <aardelean@deviqon.com> wrote:
>
> > When the ioctl() mechanism was introduced in IIO core to centralize the
> > registration of all ioctls in one place via commit 8dedcc3eee3ac ("iio:
> > core: centralize ioctl() calls to the main chardev"), the return code was
> > changed from ENODEV to EINVAL, when the ioctl code isn't known.
> >
> > This was done by accident.
> >
> > This change reverts back to the old behavior, where if the ioctl() code
> > isn't known, ENODEV is returned (vs EINVAL).
> >
> > This was brought into perspective by this patch:
> >   https://lore.kernel.org/linux-iio/20210428150815.136150-1-paul@crapouillou.net/
> >
> > Fixes: 8dedcc3eee3ac ("iio: core: centralize ioctl() calls to the main chardev")
> > Cc: Linus Walleij <linus.walleij@linaro.org>
> > Cc: Paul Cercueil <paul@crapouillou.net>
> > Cc: Nuno Sa <nuno.sa@analog.com>
> > Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
>
> This is going to be a little messy to apply as lots of churn in that file.
> What I've done for now is pulled the fixes-togreg branch forwards onto
> current staging/staging-linus but I'll do that again after
> staging/staging-linus moves onto an rc1 or similar base.

This is starting to become a recurring problem is it not?

Have you considered the option to start to send your pull
requests to Linus (Torvalds) directly?

I suppose the current scheme is used because IIO changes
can affect drivers/staging/ but at this point that thing is
so much smaller than the stuff in drivers/iio proper that
I start to question if it's worth it.

Unless you really like to base your work on Gregs tree for
some reason or other, that is.

Yours,
Linus Walleij
