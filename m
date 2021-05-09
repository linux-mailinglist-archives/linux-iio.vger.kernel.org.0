Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAE00377754
	for <lists+linux-iio@lfdr.de>; Sun,  9 May 2021 17:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbhEIPa1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 9 May 2021 11:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbhEIPa0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 9 May 2021 11:30:26 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C2DDC061573
        for <linux-iio@vger.kernel.org>; Sun,  9 May 2021 08:29:23 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id z9so19661278lfu.8
        for <linux-iio@vger.kernel.org>; Sun, 09 May 2021 08:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RfytLqDiupqOX141fLSL5xEwQRMVrqKR8ufOfjP5OyA=;
        b=Ktds/ZaQeE5yB1wDXiD5N5gvkojsmePb+JwhTjC9LepAwBxMhNer2JQfvxPn6D2I5c
         GjuoVORhoE1YlrqXe4XFQooOGPkmgIgjFbO7okAVLp05Rn9q55IV1SxGasgPvX0SPwMb
         tEkRU9phTqgpHUJngUYXdG4H7Xj7SyiYuLCykRJ+kbEPfDV7zakynUgNZn94lvF8vb69
         mB1wzSG06iyK/0bkWOdFuRw0nrNArksEN6tlC7QPafZwXvqxBW88SRKGF5U68aErubmV
         Wp3/eomuX3rqFTUx93CNgCIB7VA/H2/tBSOiTFqaeLwQwluYNEzO4jBM2eyid+jgFEd+
         vgLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RfytLqDiupqOX141fLSL5xEwQRMVrqKR8ufOfjP5OyA=;
        b=Num47Z0dHDzNlNQwOE5ZZVBKRekDNMDjt/1NWR6qGQvCAG9l5HAMFkzBAXmhV/zWIN
         JN3w3rUYuzFU03kLiRXwYFyuuXA3b0dPwaYbKy1oZVNzPr4AZtO7wRQ7sip3Cpw5dqqM
         KXU1aZGg85Vp1I5m7DmG3JsSi2rgEvdbwG8X0UNMF5oS65oVMCJE/u4ckLp9CFtfMJh3
         KtTrqo1Npmds4TCz9+r5JtEJWvs3Gu0EpB41mQ953bitOyKps7rSJWWrTfqDJbFEHnUx
         SovJ/4L4UUlY5/8DWUoSsSn1omuBI3cdCEzOqDJt8U/PBJ5+u03iiaACG5JWwYDKUxjq
         QGNw==
X-Gm-Message-State: AOAM533SFBvCK6oG/OaBDnmr4x4pA4iPX3c1tHZCPI53OEZur8E438fc
        4Vmwb8WY/E/2KWnGoPzvNBxcvTlgwFX530kS8LHvVnLMTBI=
X-Google-Smtp-Source: ABdhPJwduQTbLLBzaZ6ljrIubI2SeSOyYd8nExbkfVznc6U3Xu9stSuhqtNubx9O6xTJeH+5A/gdVoso1OHYnDxk5lY=
X-Received: by 2002:a19:b0b:: with SMTP id 11mr13534649lfl.291.1620574161920;
 Sun, 09 May 2021 08:29:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210503144350.7496-1-aardelean@deviqon.com> <20210508161643.5990ec15@jic23-huawei>
 <CACRpkdaK6AMVUC+B7JW3y28nNeAYHAS9UjC40KfShZNrHLD7rQ@mail.gmail.com> <20210509111925.52f3f4e3@jic23-huawei>
In-Reply-To: <20210509111925.52f3f4e3@jic23-huawei>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 9 May 2021 17:29:10 +0200
Message-ID: <CACRpkdZ2mC5V6PdphmtmtQKHZwPfc7mVgZ-FH3io2ihB8foA4g@mail.gmail.com>
Subject: Re: [PATCH] iio: core: return ENODEV if ioctl is unknown
To:     Jonathan Cameron <jic23@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
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

On Sun, May 9, 2021 at 12:18 PM Jonathan Cameron <jic23@kernel.org> wrote:
> On Sat, 8 May 2021 20:21:08 +0200
> Linus Walleij <linus.walleij@linaro.org> wrote:

> > Unless you really like to base your work on Gregs tree for
> > some reason or other, that is.
>
> Definitely appreciate Greg's help (and patience), but no
> particularly strong reason to waste his time dealing with my
> mess ups. Hopefully they'll reduce now IIO trees are going directly
> into linux-next though.

I'd suggest to move to sending pulls to Torvalds directly
for IIO to cut the intermediary staging tree step, since
now the subsystem is pretty large and see a bunch of
frequent fixes that need an express path to Torvalds.

Pushing through Greg per se isn't really the problem,
I think the problem is that IIO is going through the
staging tree which (I guess) isn't a high priority activity
and not expected to carry any serious critical fixes and
I guess this can cause lags.

Maybe Greg has some other branch to take in IIO
fixes and for-next but I don't really see the point.

The IIO left in the staging tree is just regular staging
business at this point, the main IIO is much more
important.

Linus 2: would pulling the IIO tree directly work for
you if Jonathan makes up his mind in favor for that?

Yours,
Linus Walleij
