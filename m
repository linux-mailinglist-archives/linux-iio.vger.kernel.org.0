Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54B941AEEC0
	for <lists+linux-iio@lfdr.de>; Sat, 18 Apr 2020 16:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726020AbgDROhf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Apr 2020 10:37:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:47302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725903AbgDROhf (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 Apr 2020 10:37:35 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1FED42070B;
        Sat, 18 Apr 2020 14:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587220654;
        bh=DsthRMTgouW7iFiF8BqnKI1i0lCywyw08im5vXB242Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HeGRS4z/sL8oHL8Ki2MutJmZjXyHlPdU0J+dXt4th6BXT/k4jFt36w6CDdpVhCrce
         qDL+bw5GxuharKFZXSPHI1F6c2rscInq6066uueWlcmFJ5xWBSdQg6xOauuqtJVsfG
         bWPv7xI52wLkOyh9p3jQXUbhN8Y+cyvSW7FzXJJA=
Date:   Sat, 18 Apr 2020 15:37:30 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v1] iio: magnetometer: ak8974: Silence deferred-probe
 error
Message-ID: <20200418153730.1e1d01ef@archlinux>
In-Reply-To: <26f96265-c699-66aa-ec70-becd868bb795@gmail.com>
References: <20200414222713.32660-1-digetx@gmail.com>
        <CACRpkdY_J8e127etFFYkoxLDDkc334Xgg8ZbapdU36oGsaZ08g@mail.gmail.com>
        <e08c487c-5c2a-3172-7c9c-0e7d2cd51769@gmail.com>
        <CACRpkdbMF4=-g2ic_SKgOkd6kfgKJqZ2UxCRaoXJjq0EiEn+pw@mail.gmail.com>
        <26f96265-c699-66aa-ec70-becd868bb795@gmail.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 16 Apr 2020 20:35:56 +0300
Dmitry Osipenko <digetx@gmail.com> wrote:

> 16.04.2020 19:51, Linus Walleij =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > On Thu, Apr 16, 2020 at 4:45 PM Dmitry Osipenko <digetx@gmail.com> wrot=
e: =20
> >> 16.04.2020 14:33, Linus Walleij =D0=BF=D0=B8=D1=88=D0=B5=D1=82: =20
> >  =20
> >>> This misses some important aspects of dev_dbg(), notably this:
> >>>
> >>> #if defined(CONFIG_DYNAMIC_DEBUG)
> >>> #define dev_dbg(dev, fmt, ...)                                       =
   \
> >>>         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
> >>> #elif defined(DEBUG)
> >>> #define dev_dbg(dev, fmt, ...)                                       =
   \
> >>>         dev_printk(KERN_DEBUG, dev, dev_fmt(fmt), ##__VA_ARGS__)
> >>> #else
> >>> #define dev_dbg(dev, fmt, ...)                                       =
   \
> >>> ({                                                                   =
   \
> >>>         if (0)                                                       =
   \
> >>>                 dev_printk(KERN_DEBUG, dev, dev_fmt(fmt), ##__VA_ARGS=
__); \
> >>> })
> >>> #endif
> >>>
> >>> If DEBUG is not defined the entire dev_dbg() message is enclodes in i=
f (0)
> >>> and compiled out of the kernel, saving space. The above does not
> >>> fulfil that. =20
> >>
> >> Hello Linus,
> >>
> >> After some recent discussions in regards to the EPROBE_DEFER handling,
> >> Thierry Reding suggested the form which is used in my patch and we
> >> started to use it recently in the Tegra DRM driver [1]. The reason is
> >> that we don't want to miss any deferred-probe messages under any
> >> circumstances, for example like in a case of a disabled DYNAMIC_DEBUG.=
 =20
> >=20
> > I have a hard time to accept this reasoning.
> >=20
> > Who doesn't feel that way about their subsystem? If you don't want
> > to miss the message under any circumstances then use dev_info().
> > Don't override the default behaviour of dev_dbg().
> >  =20
> >> The debug messages are usually disabled in a release-build and when not
> >> a very experienced person hands you KMSG for diagnosing a problem, the
> >> KMSG is pretty much useless if error is hidden silently. =20
> >=20
> > So use dev_info().
> >  =20
> >> By moving the message to a debug level, we reduce the noise in the KMSG
> >> because usually people look for a bold-red error messages. Secondly, we
> >> don't introduce an additional overhead to the kernel size since the sa=
me
> >> text is reused for all error conditions. =20
> >=20
> > dev_info() is not supposed to be an error message, it is supposed to
> > be information, so use that. =20
>=20
> Okay, I'll make a v2. Thank you for the review.

Ah I commented on this in v2 - now I see why you did it :)
Nope to dev_info. That will often spam normal logs and as Andy pointed
out for v2 that can be dozens of entries on a sophisticated board.  Much
better to stick to dev_dbg but I'd like to see it done explicitly in the
form you mention with the if / else

Thanks,

Jonathan

