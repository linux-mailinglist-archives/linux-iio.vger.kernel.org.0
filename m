Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B392C4000D5
	for <lists+linux-iio@lfdr.de>; Fri,  3 Sep 2021 15:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348889AbhICN5z (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 3 Sep 2021 09:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347765AbhICN5z (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 3 Sep 2021 09:57:55 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A92C061760
        for <linux-iio@vger.kernel.org>; Fri,  3 Sep 2021 06:56:55 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id t190so5819331qke.7
        for <linux-iio@vger.kernel.org>; Fri, 03 Sep 2021 06:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q2X4nwUe8mYHMGoeC9p2a/q4AU1Of4/9r5BuWQNLjMM=;
        b=WVAQwR5nQjRZNGqJMfwXUR1CgAKXImetNQpTcRffgVKyuNhp4CqS6CcfJb5oOyyUqM
         lMk+NYKA/9dy3Dy24t45MQYP9OdrQea19rhqf5/FXgTgYaLudrP9ONH/C+JINlBV1Bzt
         ZeIsGXgfO2yr1RdRl3xgOwS0Nko4o4LrQ5NY+nvdbpS7hopwqVu9zdDp+sxv7RtxAWGX
         Q0G+2Z4NflRQ/Lf5ygv7mivjv9SMCIBYU9DihXFGEOzWaK+saPVafHjDW/7YVfhyUpIa
         v9e6EAV0BBS1OA0l8IXSCR14fta3o1MMdSowpEQt8Ux5cb21M7s28b8JvoTdIBubTUkN
         1PIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q2X4nwUe8mYHMGoeC9p2a/q4AU1Of4/9r5BuWQNLjMM=;
        b=ZwznRdxg2Ctrp7cAU9Gz8/0vGBNpSbwihyWeMhxcz+5XdwYHwxagH0RQVMfMa5Uvqb
         RAXIf1PFVSBpxwNGGiLGTb+hopGqN7iW7fcf0XJyL7q13ExONEwupxboBiIRempJBXCx
         Uel3UhK9MHKdS7KjPo18Rob5ryuHY/3EeylW5rq6y9IoFZUJ3ADQrlXLNDuSO5gMPGCl
         DutaSreIzDhV1kxi2n6luBfB14wVq/4gnHlbSh1mHOrxDe+8ymp0EoKfj4u4l90APyd9
         8bGMYGEj58Hrs7h7xWgk97msKMHZ6Jh4izu0+O5olR1jXsBbxXImYZ87MNGRoUgKwLEa
         BZUw==
X-Gm-Message-State: AOAM530O403CF4S4TGSFXLN5+3cmhsHV8Y4wlQbfv17Z0koBWs/7Ovc3
        Ly2YSK4GFlOb8v0uwASWlYsFUg+/Ep3shL8tgT0Vog==
X-Google-Smtp-Source: ABdhPJwZ7OFJaODOSEHsW4z7JCVDHi49qbydfcwvs9W3soe4e6TMwMIrNKgcW7Ah4Nu3/brYnjvgGRDT4S+ICDoZ2LM=
X-Received: by 2002:a37:ab0d:: with SMTP id u13mr783559qke.521.1630677414467;
 Fri, 03 Sep 2021 06:56:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210903072917.45769-1-aardelean@deviqon.com> <20210903072917.45769-2-aardelean@deviqon.com>
 <YTIlv9MR2wG9AzSe@smile.fi.intel.com>
In-Reply-To: <YTIlv9MR2wG9AzSe@smile.fi.intel.com>
From:   Alexandru Ardelean <aardelean@deviqon.com>
Date:   Fri, 3 Sep 2021 16:56:43 +0300
Message-ID: <CAASAkoa0D7++CW6ua0_-9LWxhtchG_dKDOih6Ho2NH2gGdtvrQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] iio: inkern: introduce devm_iio_map_array_register()
 short-hand function
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-doc@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        hdegoede@redhat.com, wens@csie.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 3 Sept 2021 at 16:40, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Fri, Sep 03, 2021 at 10:29:13AM +0300, Alexandru Ardelean wrote:
> > This change introduces a device-managed variant to the
> > iio_map_array_register() function. It's a simple implementation of calling
> > iio_map_array_register() and registering a callback to
> > iio_map_array_unregister() with the devm_add_action_or_reset().
> >
> > The function uses an explicit 'dev' parameter to bind the unwinding to. It
> > could have been implemented to implicitly use the parent of the IIO device,
> > however it shouldn't be too expensive to callers to just specify to which
> > device object to bind this unwind call.
> > It would make the API a bit more flexible.
>
> AFAIU this dev pointer is kinda discussable thing. What scenario do you expect
> (have in mind) when it shouldn't use parent?

So, this brings me back to an older discussion about devm_ when I
thought about making some devm_ function that implicitly takes uses
the parent of the IIO device.

Jonathan mentioned that if we go that route, maybe we should prefix it
with iiom_ .
But we weren't sure at the time if that makes sense.
The idea was to bind the management of the unwinding to either the
parent of the IIO device, or the IIO device itself (indio_dev->dev).

We kind of concluded that it may probably not be a good to hide
anything and make standard a devm_ function with an explicit 'dev'
object parameter.

I found a recent mention here (while searching for iiom_  on linux-iio):
https://lore.kernel.org/linux-iio/20210313192150.74c0a91b@archlinux/


>
> --
> With Best Regards,
> Andy Shevchenko
>
>
