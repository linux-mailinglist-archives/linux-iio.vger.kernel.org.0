Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A05B03775CA
	for <lists+linux-iio@lfdr.de>; Sun,  9 May 2021 09:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbhEIHdO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 9 May 2021 03:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbhEIHdN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 9 May 2021 03:33:13 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AA69C061573
        for <linux-iio@vger.kernel.org>; Sun,  9 May 2021 00:32:11 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id b15so11514270pfl.4
        for <linux-iio@vger.kernel.org>; Sun, 09 May 2021 00:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B9TWgoVr8WLPFdd/xoiT/XBVoC3Jcul563FAdbsjo88=;
        b=rvGU39rHEdL628WQ5WfDo0O6i27O6REMUD6cOiBq7QB+OhY0BJadHUjAId80/tNccF
         GUfBD8H17G4U0lR1zlPMq64xaAQXQUcFSOGHSk6cuCtx+Qegj0lTzjakpIGQzWUKThR1
         /s/uMH/sVmXgzsUNvXcPB5XbZF7yfWQ01sd9jl3CJWj9T3khUNH5/HXgjiMAvSow/Yfx
         f7nU3DOwEk2vdbiysvpG2Gu7Mt0HvO+zGZN0/9mKn5RtNlqf14NaF0DnT52No/LX4HZi
         YgF23hXPV5CDjF91H2KZ1HGYkiGpE800Jw4qlZxwtEiZMS/2SEHdqStYYF4lGJEmxkC6
         dNMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B9TWgoVr8WLPFdd/xoiT/XBVoC3Jcul563FAdbsjo88=;
        b=nfI1qKAVJgAW57nWXIeVuHWhJCqZ8XKVuEcYUFU1F5BRfoHQPBr4gPtqVmyv6SQxoF
         563kx0cGaSM0swbsJCpJxn5kMFEy7WVibtO0OHgBXzUMeqBwVRyHw9Lnw7Uw//3PhvNa
         ZTLOCrqtb+9EDfUNJLJny4rhX1xEKb0ks63QSVGoJBJJ1It5QRj09aBmBdxJF9zSR+Zb
         MPzf1wFEckpFeZy3UvXmjdW13vDzsFto/SnYamWqqhBzPLFcC9XIHOpx5Va32IfF7Kwu
         g1wocnRcrzkLuB47SFT3x98UTvaraiFOrYjAXK2bOzxShuTdbBzfWdZDLZNPVBwsMvzx
         JIQw==
X-Gm-Message-State: AOAM530z08Tv7xHFgc+2pfuGPSv3cXX1f8GaySaUQ4160k0dIva9Z8NY
        DauGM9DZtk3JZ5OmBwhmdD+JfVerQZNdYbX5Omw=
X-Google-Smtp-Source: ABdhPJyl5KovJErZxTsBGfNqciT2yRrg1HXkb4Bx05jQNR5rTxI8kUQVFdlWDiJNtpkJeDck7m+wJpIvMJ3pTbuFXcg=
X-Received: by 2002:aa7:954d:0:b029:29f:d9a6:63d7 with SMTP id
 w13-20020aa7954d0000b029029fd9a663d7mr16147379pfq.58.1620545530710; Sun, 09
 May 2021 00:32:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210508182319.488551-1-jic23@kernel.org>
In-Reply-To: <20210508182319.488551-1-jic23@kernel.org>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Sun, 9 May 2021 10:31:59 +0300
Message-ID: <CA+U=DspFU3gF+_EKDMnfNn7D+MX+0GcubOjf6uBcM2ekkQtWaA@mail.gmail.com>
Subject: Re: [PATCH 0/3] iio: adc: ad7124: Fixes and devm_ for all of probe
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        alexandru.tachici@analog.com,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, May 8, 2021 at 9:24 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> I noticed an issue around regulator error handling and managed to
> hit another with my hacked together test setup.  Hence let's fix
> those two issues first then we might as well follow up by converting
> the last few bits of this driver to use device managed functions so
> we can simplify the error handling and cleanup.
>
> Testing conducted with QEMU hacking and insertion of errors at relevant
> locations in the code.

I guess the devm_ cleanup didn't catch-on much with others.
It means I'll probably resume it :)

>
> Jonathan Cameron (3):
>   iio: adc: ad7124: Fix missbalanced regulator enable / disable on
>     error.
>   iio: adc: ad7124: Fix potential overflow due to non sequential channel
>     numbers
>   iio: adc: ad7124: Use devm_ managed calls for all of probe() + drop
>     remove()
>
>  drivers/iio/adc/ad7124.c | 89 ++++++++++++++++++++--------------------
>  1 file changed, 44 insertions(+), 45 deletions(-)
>
> --
> 2.31.1
>
