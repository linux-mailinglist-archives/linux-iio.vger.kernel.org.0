Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFD3E2B2E24
	for <lists+linux-iio@lfdr.de>; Sat, 14 Nov 2020 16:40:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbgKNPjW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 14 Nov 2020 10:39:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:49648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726958AbgKNPjW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 14 Nov 2020 10:39:22 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A94942225E;
        Sat, 14 Nov 2020 15:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605368361;
        bh=STshc61V5bYzeDB80bIyHdOaIN0BlTRmt3m+znRG2JQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nfSU+mjfZsU2GNL1m+AymnypnRYxM4B8qrFDLCxqxt9Dhx5V2dahQVqLFZZXyI3Hc
         kdB2FdMnPhFEr7LE8uj8TqamsNG8MXt+eVE4O3S6aweHuLM8IjREepKtoiEsPP7sp1
         b1P8hpXr8Y8+WSDkjb3SYuuRu4qvXUm/l8jDFI3k=
Date:   Sat, 14 Nov 2020 15:39:17 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/1] iio: industrialio-trigger: Use 'gnu_printf' format
 notation
Message-ID: <20201114153917.29ca0af3@archlinux>
In-Reply-To: <20201102113723.GM4127@dell>
References: <20201102111725.1048562-1-lee.jones@linaro.org>
        <6b5807c1-08af-2633-3352-bd7ae084cbe2@metafoo.de>
        <20201102113723.GM4127@dell>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 2 Nov 2020 11:37:23 +0000
Lee Jones <lee.jones@linaro.org> wrote:

> On Mon, 02 Nov 2020, Lars-Peter Clausen wrote:
>=20
> > On 11/2/20 12:17 PM, Lee Jones wrote: =20
> > > Fixes the following W=3D1 kernel build warning(s):
> > >=20
> > >   drivers/iio/industrialio-trigger.c: In function =E2=80=98iio_alloc_=
pollfunc=E2=80=99:
> > >   drivers/iio/industrialio-trigger.c:338:2: warning: function =E2=80=
=98iio_alloc_pollfunc=E2=80=99 might be a candidate for =E2=80=98gnu_printf=
=E2=80=99 format attribute [-Wsuggest-attribute=3Dformat] =20
> >=20
> > Jonathan already sent a similar patch. See
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3Dcd7798cbd28044a3026619e36993160ba8fa118d
> > <https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/com=
mit/?id=3Dcd7798cbd28044a3026619e36993160ba8fa118d> =20
>=20
> So adding this to the prototype also squashes the warning?
I'm not seeing the warning any more so I guess so?

J

>=20
> > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > > ---
> > >   drivers/iio/industrialio-trigger.c | 1 +
> > >   1 file changed, 1 insertion(+)
> > >=20
> > > diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industr=
ialio-trigger.c
> > > index 583bb51f65a75..1d65c83439d84 100644
> > > --- a/drivers/iio/industrialio-trigger.c
> > > +++ b/drivers/iio/industrialio-trigger.c
> > > @@ -320,6 +320,7 @@ irqreturn_t iio_pollfunc_store_time(int irq, void=
 *p)
> > >   }
> > >   EXPORT_SYMBOL(iio_pollfunc_store_time);
> > > +__printf(5, 6)
> > >   struct iio_poll_func
> > >   *iio_alloc_pollfunc(irqreturn_t (*h)(int irq, void *p),
> > >   		    irqreturn_t (*thread)(int irq, void *p), =20
> >=20
> >  =20
>=20

