Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8248C2FB3E9
	for <lists+linux-iio@lfdr.de>; Tue, 19 Jan 2021 09:22:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727131AbhASIUy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 Jan 2021 03:20:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729385AbhASIUB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 Jan 2021 03:20:01 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3450C061573;
        Tue, 19 Jan 2021 00:19:02 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id d81so22751210iof.3;
        Tue, 19 Jan 2021 00:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7Ep6XAHClFQb77kqS1Nifo4aUTiAKOUGwzILPlIr1hA=;
        b=Rn7uo4cSY3JpCIEMoejHXTtIjakE7pfu4I7upjctGZz9EXgmHwiFpr96D4oJ2olA+4
         U50wsb1sW0pXP9tdBNOdpy3BHNXNGdBQOBHeVyGLJsci5ZGVBkWwUvUlYDhnp1Us71vQ
         7rPEq0rs1F9CYmWMhOThTgeVLIu3FmxDfV0Y9/1PVFtQKpLsWr2quGFswwIoITDtwADA
         75o0FPk4Vd5uYDDy+Ufa8WJp4luO2p6jKX+Ki1LTqkY4dXylTOHlQ3DjJNdJcpZC6SBx
         UWtbcgs1GgzTFavl18L3/48whMddlwFFmCp67f7qRk4uCF0gE9FixAf5cZJQAvaEtDSy
         YZRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7Ep6XAHClFQb77kqS1Nifo4aUTiAKOUGwzILPlIr1hA=;
        b=JnILsFI/mbxNIyo1OigjvvfDX15f/cyGOPUYeWRVFdiq0V9UuIxCiEXT8p0WlkSBU3
         PTal6P5gUixGbVWe4Min+vwWGtBNJpQx+ZD16L8ULPMC98UQGZduyvHWbSyWTX7ooYQr
         7lZyYO/4Y2ZJS26Robe9YysLPZIZ2jsiqA8KPQrQ5uax4MHE9FjWKhCB1Z5sDAEZs8BA
         otSJmhzCdmkskrmWKTdDIbG9j/KP3KS2x//NzUmd/nHAwMNc5H2B8DSokeFy8YiQbird
         g2j49YsctTxE9KMEVYZXgxFUvv+dciaJIXA34ag1e93qtE7BxBXIWI8syQrTyMeaxI1B
         o+kQ==
X-Gm-Message-State: AOAM533WWHuoD+zEltbn9DamFM5OIVTUpKcrBp8IjKl417pTrH76QUcH
        ExBTu6s+kIV1AM2CzDtMwKqP550e4HE6kjjz7oI=
X-Google-Smtp-Source: ABdhPJyIMMKKNy7bzSz/uP19d5A0u0p/zkwkPfdazyf1maW4tylmjwMcqy6KkwET7wCxA2uTUGBlkbJwWRZaOmKWrSc=
X-Received: by 2002:a92:5e04:: with SMTP id s4mr2500931ilb.100.1611044342303;
 Tue, 19 Jan 2021 00:19:02 -0800 (PST)
MIME-Version: 1.0
References: <20201203095342.73591-1-alexandru.ardelean@analog.com>
 <CAHp75VffjpFyh0G3F6v0j5tXrURA2pCtWsSztC7KejhBFuLTvw@mail.gmail.com>
 <CA+U=DsoNHebsuGDhGnJOwFbkYtGY+1Gs_mhCssH+FYk3Y05eZA@mail.gmail.com>
 <CAHp75VcxZd1xW+ayi_km3zCYKV3aC1VRJ5bwyVpevZkvgg_ipw@mail.gmail.com>
 <CA+U=DspEg=XpOUKqtammKqOoLXoXEDKWQHqSauM1xna_Y+eqjA@mail.gmail.com> <20201213143140.58af94a0@archlinux>
In-Reply-To: <20201213143140.58af94a0@archlinux>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Tue, 19 Jan 2021 10:18:50 +0200
Message-ID: <CA+U=Dsr6zT3fQES4V+p_u2fFy5J4uRH1k6Zss6aJebfC=Aa2WA@mail.gmail.com>
Subject: Re: [PATCH v2] iio: core: register chardev only if needed
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Bastien Nocera <hadess@hadess.net>,
        Hans de Goede <hdegoede@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Dec 13, 2020 at 4:31 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Wed, 9 Dec 2020 17:55:22 +0200
> Alexandru Ardelean <ardeleanalex@gmail.com> wrote:
>
> > On Wed, Dec 9, 2020 at 5:53 PM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > >
> > > On Wed, Dec 9, 2020 at 5:45 PM Alexandru Ardelean
> > > <ardeleanalex@gmail.com> wrote:
> > > > On Wed, Dec 9, 2020 at 5:37 PM Andy Shevchenko
> > > > <andy.shevchenko@gmail.com> wrote:
> > > > > On Thu, Dec 3, 2020 at 11:55 AM Alexandru Ardelean
> > > > > <alexandru.ardelean@analog.com> wrote:
> > >
> > > ...
> > >
> > > > > Are you sure there is no user space application that doesn't rely on
> > > > > character device to be always present?
> > > >
> > > > Nope.
> > > > I'm not sure.
> > > > I'm also not completely sure how Jonathan feels about this patch being
> > > > added now [so late].
> > > >
> > > > Though, technically if the chardev was already there, without all the
> > > > control in place [to enable IIO buffers and other stuff through the
> > > > chardev] then it's technically just a "marker" file.
> > > > Which arguably is a lot to have (i.e. chardev that should be unusable).
> > > >
> > > > If it is usable with no control in place for buffers or other stuff
> > > > (i.e. I missed something), then I also don't know.
> > > >
> > > > So, this patch on it's own can still be interpreted as an RFC.
> > > > See:
> > > > https://lore.kernel.org/linux-iio/20201121180246.772ad299@archlinux/
> > >
> > > Don't take me wrong, I'm not against a good change (I doesn't like
> > > dangling files), but it might break some use cases.
> >
> > Yeah I know.
> > But how else do you know if a dangling file might break some use cases?
> >
> > The worst that would happen is that we get a report and create a Fixes
> > tag and we know.
> > But if we don't try it, we're stuck with it, and will never know.
> >
> It's definitely a high risk change.  I'd 'hope' it's not a problem
> but we should do a bit more due diligence.
>
> I hope we can assume the ADI software is all fine with dropping this.
> Bastien can you see any issues with dropping chrdev for IIO devices
> that don't actually support using it for anything (sysfs interface only).
>
> What other stacks are people aware of that we should enquire about?

Hey,

Any more thoughts on this?

Thanks
Alex

>
> Thanks,
>
> Jonathan
> > >
> > > --
> > > With Best Regards,
> > > Andy Shevchenko
>
