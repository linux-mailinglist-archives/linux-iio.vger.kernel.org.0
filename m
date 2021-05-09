Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BE2D377632
	for <lists+linux-iio@lfdr.de>; Sun,  9 May 2021 12:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbhEIKTa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 9 May 2021 06:19:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:39370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229555AbhEIKTa (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 9 May 2021 06:19:30 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C23F61400;
        Sun,  9 May 2021 10:18:25 +0000 (UTC)
Date:   Sun, 9 May 2021 11:19:25 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Nuno Sa <nuno.sa@analog.com>
Subject: Re: [PATCH] iio: core: return ENODEV if ioctl is unknown
Message-ID: <20210509111925.52f3f4e3@jic23-huawei>
In-Reply-To: <CACRpkdaK6AMVUC+B7JW3y28nNeAYHAS9UjC40KfShZNrHLD7rQ@mail.gmail.com>
References: <20210503144350.7496-1-aardelean@deviqon.com>
        <20210508161643.5990ec15@jic23-huawei>
        <CACRpkdaK6AMVUC+B7JW3y28nNeAYHAS9UjC40KfShZNrHLD7rQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 8 May 2021 20:21:08 +0200
Linus Walleij <linus.walleij@linaro.org> wrote:

> On Sat, May 8, 2021 at 5:15 PM Jonathan Cameron <jic23@kernel.org> wrote:
> > On Mon,  3 May 2021 17:43:50 +0300 Alexandru Ardelean <aardelean@deviqon.com> wrote:
> >  
> > > When the ioctl() mechanism was introduced in IIO core to centralize the
> > > registration of all ioctls in one place via commit 8dedcc3eee3ac ("iio:
> > > core: centralize ioctl() calls to the main chardev"), the return code was
> > > changed from ENODEV to EINVAL, when the ioctl code isn't known.
> > >
> > > This was done by accident.
> > >
> > > This change reverts back to the old behavior, where if the ioctl() code
> > > isn't known, ENODEV is returned (vs EINVAL).
> > >
> > > This was brought into perspective by this patch:
> > >   https://lore.kernel.org/linux-iio/20210428150815.136150-1-paul@crapouillou.net/
> > >
> > > Fixes: 8dedcc3eee3ac ("iio: core: centralize ioctl() calls to the main chardev")
> > > Cc: Linus Walleij <linus.walleij@linaro.org>
> > > Cc: Paul Cercueil <paul@crapouillou.net>
> > > Cc: Nuno Sa <nuno.sa@analog.com>
> > > Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>  
> >
> > This is going to be a little messy to apply as lots of churn in that file.
> > What I've done for now is pulled the fixes-togreg branch forwards onto
> > current staging/staging-linus but I'll do that again after
> > staging/staging-linus moves onto an rc1 or similar base.  
> 
> This is starting to become a recurring problem is it not?

This particular one isn't a result of the path IIO patches take,
but rather my jumping the gun on getting these out there before
there is an rc1 release.  So would have been in the same position
but referring to Linus' tree rather than Greg's if things went
directly.

> 
> Have you considered the option to start to send your pull
> requests to Linus (Torvalds) directly?
> 
> I suppose the current scheme is used because IIO changes
> can affect drivers/staging/ but at this point that thing is
> so much smaller than the stuff in drivers/iio proper that
> I start to question if it's worth it.

I guess the perfectionist in me wants to clear the remaining
stuff out of staging before changing the structure that has
worked well (and become very comfortable!). Perhaps you are
right that I shouldn't wait quite as long as that will take.

> 
> Unless you really like to base your work on Gregs tree for
> some reason or other, that is.

Definitely appreciate Greg's help (and patience), but no
particularly strong reason to waste his time dealing with my
mess ups. Hopefully they'll reduce now IIO trees are going directly
into linux-next though.

> 
> Yours,
> Linus Walleij

