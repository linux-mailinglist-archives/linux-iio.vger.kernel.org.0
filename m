Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 575882568B2
	for <lists+linux-iio@lfdr.de>; Sat, 29 Aug 2020 17:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728303AbgH2Pdk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 29 Aug 2020 11:33:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:47378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728196AbgH2Pdk (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 29 Aug 2020 11:33:40 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C0FC20791;
        Sat, 29 Aug 2020 15:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598715219;
        bh=eRIQ3RsS8QokfA8Kzvr1LjY4Cf5uyuC9QpA4TQetVy0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kA7bgoAX66sTvWabu8HGdci4RWthUM4T2ggmCMDHB/Y1LFAy44HMfRnxybnfp2sST
         J8xxkos9h/aATTZ8bkeG9SFHwsg2LGoWhXNA/LOHem90uIzENe4IiWdkZYTtczIsov
         BFwS4Ukr6GgC/DAE0SLebIHo+J4CB2SV//NGmNSg=
Date:   Sat, 29 Aug 2020 16:33:35 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, kgene@kernel.org,
        Sergiu Cuciurean <sergiu.cuciurean@analog.com>
Subject: Re: [PATCH] iio: adc: exynos_adc: Replace indio_dev->mlock with own
 device lock
Message-ID: <20200829163335.3a9c420c@archlinux>
In-Reply-To: <CA+U=Dsoo6YABe5ODLp+eFNPGFDjk5ZeQEceGkqjxXcVEhLWubw@mail.gmail.com>
References: <20200826132203.236748-1-alexandru.ardelean@analog.com>
        <20200827065625.GB17964@kozik-lap>
        <CA+U=Dsoo6YABe5ODLp+eFNPGFDjk5ZeQEceGkqjxXcVEhLWubw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 27 Aug 2020 11:53:44 +0300
Alexandru Ardelean <ardeleanalex@gmail.com> wrote:

> On Thu, Aug 27, 2020 at 9:57 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >
> > On Wed, Aug 26, 2020 at 04:22:03PM +0300, Alexandru Ardelean wrote:  
> > > From: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> > >
> > > As part of the general cleanup of indio_dev->mlock, this change replaces
> > > it with a local lock, to protect potential concurrent access to the
> > > completion callback during a conversion.  
> >
> > I don't know the bigger picture (and no links here for general cleanup)
> > but I assume it is part of wider work and that mlock is unwanted. In
> > such case:
> >
> > Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> >
> > If it is part of some bigger work, please put a link to lore.kernel.org
> > under separators ---, so everyone can get the context.  
> 
> Will keep that in mind.
> I am not sure if there is a lore.kernel.org link that's easy to find
> for a discussion on this topic, maybe I can describe it here and use
> the link [from this later].
> 
> This was something that popped up during reviews we got from Jonathan
> [or others], saying "please don't use indio_dev->mlock, that is an IIO
> framework lock, and an IIO driver should not use it".

Shortest one is the docs for that lock say don't use it directly in
a driver :)

https://elixir.bootlin.com/linux/latest/source/include/linux/iio/iio.h#L495

> Reasons include [and some may be repeated a bit]:
> - this could cause a deadlock if the IIO framework holds this lock and
> an IIO driver also tries to get a hold of this lock
> - similar to the previous point, this mlock is taken by
> iio_device_claim_direct_mode() and released by
> iio_device_release_direct_mode() ; which means that mlock aims to
> become more of an IIO framework lock, than a general usage lock;
> - this wasn't policed/reviewed intensely in the older driver [a few
> years ago], but has become a point in recent reviews;
> - if we want to develop/enhance the IIO framework, some elements like
> this need to be taken care of, as more drivers get added and more
> complexity gets added;

One side note here is we want to make all this [INTERN] state in 
struct iio_dev opaque to drivers.  It'll take a while as the boundary
gets crossed in various drivers.

> - there is an element of fairness [obviously], where someone writing a
> new IIO driver, takes an older one as example, and gets hit on the
> review; the person feels they did a good job in mimicking the old
> driver; their feeling is correct; the IIO framework should provide
> good references and/or cleanup existing drivers;
> - same as the previous point, we don't want to keep telling people
> writing new IIO drivers [and starting out with IIO] to "not use mlock
> [because it was copied from an old driver]"; it's more/needless review
> work

Good explanation.

Thanks,

Jonathan

> 
> 
> >
> >
> > Best regards,
> > Krzysztof
> >  
> > >
> > > Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> > > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> > > ---
> > >  drivers/iio/adc/exynos_adc.c | 12 ++++++++----
> > >  1 file changed, 8 insertions(+), 4 deletions(-)
> > >  

