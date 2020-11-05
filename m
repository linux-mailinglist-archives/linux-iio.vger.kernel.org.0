Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B1932A80C4
	for <lists+linux-iio@lfdr.de>; Thu,  5 Nov 2020 15:23:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730660AbgKEOXV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 5 Nov 2020 09:23:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728371AbgKEOXU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 5 Nov 2020 09:23:20 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B931C0613CF
        for <linux-iio@vger.kernel.org>; Thu,  5 Nov 2020 06:23:20 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id d24so1745211ljg.10
        for <linux-iio@vger.kernel.org>; Thu, 05 Nov 2020 06:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nZtCz5kIlO/Y2YjkYz/rLI2FJkl9sXpZBq7XPHG3z5Q=;
        b=a/Dja0Gu1k/wMFbBQi7iA5qVdofmT9o9hL8Mj6GNDlklEsZ0SSwL8C+86N/VGHsjdL
         qFNqlokGznvLeCZkbdDdDT5lQ3m+A9GInhvqOw5Ol2GDKNYAgr1C/q+ChTFww77VSZq0
         WulGl4O261TIa2YG2YVpqSTNjWYmtF0SlcHd4zjUMxQ2CShlIIwoKlaS/DDm1Mv2SKPO
         Lo38Bd10C6lBbpMEYXTKUvuEkmVG3lFp4E3b3Q2lBrKATb4QV5oAg5vUFuwbth27meCw
         AwbAfO0X8jNCw1wGBvujYAw4atad/NW6wRmLPMbiVqZg+oyqbvJxZfNtu8IKxt7AqwLX
         BTAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nZtCz5kIlO/Y2YjkYz/rLI2FJkl9sXpZBq7XPHG3z5Q=;
        b=QCFekw8X3SZ1t23GJuDKEn5NYKLaxq+np6OS0SW5hlQIdE57G4I6KLnYI96jlQ9SUz
         xcn/F04/X9mYhxvgdShR4q2OSofnh+lSJO2UPfhsz62h5vU4NVuEiNE6gcplX2UZUKDF
         Pa50+o7jcs3lI2Jzx6dUI9M0VF4GgS2qYrqJD2HsHt6y6MWiL8OCZwd+UlsT5T49bSwK
         RIoBZ1S1H8FP3NIOHi8ax5rDX6FHvq7hcT6ViysPEshT48hizskkLL7hP3LPrHFpNCYo
         0KjuP525mAR9gnM7unqzoXt3GL42X3+fJ6W/pI8uUqhGRldgsHK4TxBbBMFOIQXIDqtS
         jgSg==
X-Gm-Message-State: AOAM533jsW+YA8dNRzApF/HStTJgE0hRiqzE34KN3hStgIBnxyS0+s/s
        CfspN0dLkxE45KU0jS/VpoacVJQy79GCcZhkqGMRMS7UNF4Iyw==
X-Google-Smtp-Source: ABdhPJzexGnima3brfKnT7oZjInkDYNnSyaPt6iAxo9bDn9aqWPpWdGTkRqzK7AH33LMVebB17PQnBuOANtY4GWxLAE=
X-Received: by 2002:a05:651c:1205:: with SMTP id i5mr1065190lja.283.1604586198587;
 Thu, 05 Nov 2020 06:23:18 -0800 (PST)
MIME-Version: 1.0
References: <20201026175340.19570-1-andriy.shevchenko@linux.intel.com>
 <20201029150444.28f4e18d@archlinux> <CAHp75VfzV=VY5R1oVx+2mtbdNj97rJCh6tqeUnzYt=MDGpCsfQ@mail.gmail.com>
In-Reply-To: <CAHp75VfzV=VY5R1oVx+2mtbdNj97rJCh6tqeUnzYt=MDGpCsfQ@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 5 Nov 2020 15:23:07 +0100
Message-ID: <CACRpkdYG4Z6vaKp9woULPz0CKyTCr6ZocfvRm4gxw2JktStggg@mail.gmail.com>
Subject: Re: [PATCH v1] iio: gyro: mpu3050: Use get_unaligned_leXX()
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Oct 29, 2020 at 6:10 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Thu, Oct 29, 2020 at 5:05 PM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > On Mon, 26 Oct 2020 19:53:40 +0200
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> >
> > > This makes the driver code slightly easier to read.
> > >
> > > Cc: Linus Walleij <linus.walleij@linaro.org>
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >
> > What you have is good, but could we do better?
> >
> > Why not use an __le64 to grab the whole thing, convert it to a local
> > cpu endian u64 then use FIELD_GET or similar to pull out the right bits.
> > Would be fairly self documenting as well which is always nice.
> >
> > Or am I missing something?
>
> My laziness. I shared this as a leftover from a big series of
> converting a lot of drivers to get_unligned_.eXX(). If you consider
> this is not good enough, just don't apply (no hard feelings :-) I will
> drop it from my local branches.

I would suggest to apply it anyways because the kernel will look
better after than before this patch.

Possibly Jonathan could just slip in a TODO comment for this?

Yours,
Linus Walleij
