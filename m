Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEE2B2E072D
	for <lists+linux-iio@lfdr.de>; Tue, 22 Dec 2020 09:28:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725807AbgLVI2N (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 22 Dec 2020 03:28:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbgLVI2N (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 22 Dec 2020 03:28:13 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52247C0613D3;
        Tue, 22 Dec 2020 00:27:33 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id w17so4659256ilj.8;
        Tue, 22 Dec 2020 00:27:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aRmoErS+ka4tH6a+sixLNCPmnNApWCjl3PXrq7L/Zk4=;
        b=UprR7eMZZUiukPckR5jepEqcC8XO/pplDnF5T4ENH9GKZiDfzLFBBuSbfFSkG+JAeJ
         pKl0qm3KacRRGgWMiR96a5Fy1Xe17EgH2hb1j8ZOdDCEknmLUPgzQr2B/x0CUoUTjibb
         SEXob64/oCfxVWdWBkaB5E3cuYcW9j8fuPOZiHou1Ce/D35uRtetjtrJWpLGf4Bt1+hD
         mYxJmVvzh15oqMMVzHIaB2eV3VK3CkaxqMbSkP0MVMBMNntcGjFOETt/bchd5fL5KlMa
         t17wCCOcwMueRbpFfgNKhBwySO0H1GKrZwQljIWEH0+R0B2pKPepFmkMJoaZmqrvGo42
         7iAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aRmoErS+ka4tH6a+sixLNCPmnNApWCjl3PXrq7L/Zk4=;
        b=XRBkW/ouQlO4MATvt0jyEmcVFzDDyOJxUU4FAg6TApL7iDaBlEEMrVFdZ6JMBVDLAP
         JSwYfp+Nqr26yasUBeciSSpZJOj0yP/f9Q3ZObNqTr1L3ZkaMNgeHhVlx+iB31+A3QL6
         X16z0iyRIkt130JqKkBsktPfkb4RUqRuo7rJ3gpVxDCKvk8g1crpKpcgpiDOWnZ9KPBb
         FAZKDQ/oddpTCxjNVxAr0o3FlJC8wQ0LLJsnX7a/a+hA3MZRru10tsSp7JaSf/F8/7x5
         7mBcwpHO5/7M19/NCXybC6wkiPg2r3KgfvJoqYF9qF6286LDuWbGs2JCOTYy31Lh7EB5
         jl/Q==
X-Gm-Message-State: AOAM5329uGIYXltnNMglZkevwKoHcpQpNLZcQXyFjQqddFoj/3T4iOPB
        fAsG/Rg7hAt87uCoFduQPJyJmTwBcF02eGfS0H2Q1PlqCTSwjA==
X-Google-Smtp-Source: ABdhPJw2m5txx1BLqhQ5ulFKznQctQ4P/fipYiCSuX2zcPvjfNisR2vIX2PKnFsdmMNI6Y5HYmUtcfr4RP91WsWJehk=
X-Received: by 2002:a05:6e02:96f:: with SMTP id q15mr19645593ilt.292.1608625652615;
 Tue, 22 Dec 2020 00:27:32 -0800 (PST)
MIME-Version: 1.0
References: <20201221151551.52511-1-alexandru.ardelean@analog.com>
 <CAHp75Ve6GHU50WO3Ygmfz8GU=22jpLi+JeDoA3TiY8bp76T09A@mail.gmail.com> <CA+U=Dsont-N2Ev3bbO+O_v23OAx11MhkLYsHJjAisNyu4kO2Bw@mail.gmail.com>
In-Reply-To: <CA+U=Dsont-N2Ev3bbO+O_v23OAx11MhkLYsHJjAisNyu4kO2Bw@mail.gmail.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Tue, 22 Dec 2020 10:27:21 +0200
Message-ID: <CA+U=DsoOa7PfSXNBfVimrd6f0kTKfORgnd2g_Po1+eXiy2cW3g@mail.gmail.com>
Subject: Re: [PATCH v4] iio: Handle enumerated properties with gaps
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Dec 22, 2020 at 9:21 AM Alexandru Ardelean
<ardeleanalex@gmail.com> wrote:
>
> On Mon, Dec 21, 2020 at 8:02 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> >
> > On Mon, Dec 21, 2020 at 5:11 PM Alexandru Ardelean
> > <alexandru.ardelean@analog.com> wrote:
> > >
> > > From: Lars-Peter Clausen <lars@metafoo.de>
> > >
> > > Some enums might have gaps or reserved values in the middle of their value
> > > range. E.g. consider a 2-bit enum where the values 0, 1 and 3 have a
> > > meaning, but 2 is a reserved value and can not be used.
> > >
> > > Add support for such enums to the IIO enum helper functions. A reserved
> > > values is marked by setting its entry in the items array to NULL rather
> > > than the normal descriptive string value.
> >
> > ...
> >
> > > I tried a few shots at working with 'lib/string.c', and that went
> > > slow. The __sysfs_match_string_with_gaps() approach has stalled.
> > > https://lore.kernel.org/linux-iio/20190422140251.8960-1-alexandru.ardelean@analog.com/
> >
> > Hmm... If you are not going to push that forward, perhaps better is to  provide
> > iio_sysfs_match_string() and if we need it in the future for other
> > users, it would be easier to find and export. Also it will be a matter
> > of one line change in the caller.
>
> That can work as well.
> Maybe add the __sysfs_match_string_with_gaps() here directly?

Maybe I can try again to address __sysfs_match_string() in lib/string.c
But I don't want to touch 'match_string()' ; that is way too spread out.

>
> >
> > --
> > With Best Regards,
> > Andy Shevchenko
