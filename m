Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 707682D4612
	for <lists+linux-iio@lfdr.de>; Wed,  9 Dec 2020 16:56:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729877AbgLIP4P (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 9 Dec 2020 10:56:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729694AbgLIP4O (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 9 Dec 2020 10:56:14 -0500
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02421C0613CF;
        Wed,  9 Dec 2020 07:55:34 -0800 (PST)
Received: by mail-io1-xd43.google.com with SMTP id i9so2111307ioo.2;
        Wed, 09 Dec 2020 07:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zstl4VMCs3G0pjLC+YkVEZlA8OjymAgEot08kHBSROY=;
        b=Ps/O8JbVjcLvhENJ6G5iO5LjxQRI9d44KSY76AZDDx4+fBxdIT+F6zb+dkcOkxFUJ+
         q24xNlQI1ClpR2xjkPa+Axetxu2YMNN1gF9+ipc3ij9aAVI8g2QITfbXy3aH0rJkLuUU
         4Qkr2fM38w0i65NJut0uIKl1FeKVsr0sSNKVXh4GjY7q0U36DZMCGaOPoPDKhmE/K3RH
         jALcnBSKnXh2cUnNB9tsLNyVjhBzc1qcCqbWsI1/XaisxY0dk3j0Mf0swJBiV6hRfEi4
         b1dHjrDNjpEfplLORoTVv4lg63jeSq22E+BT4IxEqugcLx4asOzgU56L27ZpRckP76c7
         LpTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zstl4VMCs3G0pjLC+YkVEZlA8OjymAgEot08kHBSROY=;
        b=lWsFfEiFXNaxbw85L+28SpsHkLuL2WGRyEb5JzOhGsM8sx/BMrtOT7yJVff0cdquZ9
         gMhQcKAFsP8qifHYo7JXXCoe9q2ljRvgg0vW+WTqndFa2ZQ91a+O5i1N6lKwbDXDLzbn
         eGDx23y60MR1eK7MlkVlJtjtWrF9RMAMsfWvRn9xelay9oCnp+mXRk+q+HrUDngLb95e
         hOv6udYBmwASh9aVxvmfgTIO06ir4GJSsZ5MKw0TCtYtUMEFqSFPaPmaDYsXDWB/Lf7v
         EO3EgEsEzZQeaHjvavJaveM42U3nDDFaAD0vhFAmY1Ejv2l8pUlQIwcMAbGBGCQuCLK1
         h+vQ==
X-Gm-Message-State: AOAM530tRIRNqZWjf4pDRepxPLmkKQAPi2WyDwojV59Xplha2Sbtb1kF
        c72VdnX7+JQCMQi1KNrR4UgmYZSkleDdjnlITxk=
X-Google-Smtp-Source: ABdhPJxiZHRuphbkyQLwzgeJDOAAnf7/ySDTEIkbqmrtxhI/URFIExXjE1IzV9OSURgtsO4HF/M0c94HnPIXwXiuWVQ=
X-Received: by 2002:a05:6638:5b2:: with SMTP id b18mr3900596jar.69.1607529333389;
 Wed, 09 Dec 2020 07:55:33 -0800 (PST)
MIME-Version: 1.0
References: <20201203095342.73591-1-alexandru.ardelean@analog.com>
 <CAHp75VffjpFyh0G3F6v0j5tXrURA2pCtWsSztC7KejhBFuLTvw@mail.gmail.com>
 <CA+U=DsoNHebsuGDhGnJOwFbkYtGY+1Gs_mhCssH+FYk3Y05eZA@mail.gmail.com> <CAHp75VcxZd1xW+ayi_km3zCYKV3aC1VRJ5bwyVpevZkvgg_ipw@mail.gmail.com>
In-Reply-To: <CAHp75VcxZd1xW+ayi_km3zCYKV3aC1VRJ5bwyVpevZkvgg_ipw@mail.gmail.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Wed, 9 Dec 2020 17:55:22 +0200
Message-ID: <CA+U=DspEg=XpOUKqtammKqOoLXoXEDKWQHqSauM1xna_Y+eqjA@mail.gmail.com>
Subject: Re: [PATCH v2] iio: core: register chardev only if needed
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

On Wed, Dec 9, 2020 at 5:53 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Wed, Dec 9, 2020 at 5:45 PM Alexandru Ardelean
> <ardeleanalex@gmail.com> wrote:
> > On Wed, Dec 9, 2020 at 5:37 PM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > > On Thu, Dec 3, 2020 at 11:55 AM Alexandru Ardelean
> > > <alexandru.ardelean@analog.com> wrote:
>
> ...
>
> > > Are you sure there is no user space application that doesn't rely on
> > > character device to be always present?
> >
> > Nope.
> > I'm not sure.
> > I'm also not completely sure how Jonathan feels about this patch being
> > added now [so late].
> >
> > Though, technically if the chardev was already there, without all the
> > control in place [to enable IIO buffers and other stuff through the
> > chardev] then it's technically just a "marker" file.
> > Which arguably is a lot to have (i.e. chardev that should be unusable).
> >
> > If it is usable with no control in place for buffers or other stuff
> > (i.e. I missed something), then I also don't know.
> >
> > So, this patch on it's own can still be interpreted as an RFC.
> > See:
> > https://lore.kernel.org/linux-iio/20201121180246.772ad299@archlinux/
>
> Don't take me wrong, I'm not against a good change (I doesn't like
> dangling files), but it might break some use cases.

Yeah I know.
But how else do you know if a dangling file might break some use cases?

The worst that would happen is that we get a report and create a Fixes
tag and we know.
But if we don't try it, we're stuck with it, and will never know.

>
> --
> With Best Regards,
> Andy Shevchenko
