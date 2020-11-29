Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B42572C78D0
	for <lists+linux-iio@lfdr.de>; Sun, 29 Nov 2020 12:29:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725984AbgK2L2y (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 29 Nov 2020 06:28:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:58422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725867AbgK2L2y (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 29 Nov 2020 06:28:54 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B26AF2076A;
        Sun, 29 Nov 2020 11:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606649293;
        bh=rpr7q24TmcpM70fFs9oFBwjg9mnJlO+gT04e4RvSDDc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kADdZ3zbVOUFF8zPMiFbSdpnHYlZ2qWNRADxoe4wMZfd6cqIWRb4qbwant6M3LucF
         nnL2PEKphzuCoymJBeG78tQzZXqAnmyf+QG/4wBqp8fP9QCcMOm1ykTAV5c0AWqFHc
         saLrNba4IJBjUjF4B3KG4/RV1+MUUkDiBmbFsfRU=
Date:   Sun, 29 Nov 2020 11:28:09 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] iio:gyro:mpu3050 Treat otp value as a __le64 and use
 FIELD_GET() to break up
Message-ID: <20201129112809.2e8a267f@archlinux>
In-Reply-To: <CACRpkdZrSyASctLFfN-8GZRnyfEUPretCXHiD-G+z+cvsDJLww@mail.gmail.com>
References: <20201128185156.428327-1-jic23@kernel.org>
        <CACRpkdaA5yhgd4+BgFN6WeC7pmoKPj8kYabD7TtFyEieiNVZfw@mail.gmail.com>
        <CAHp75VcKOrjLBwRBZ0gi0S8tL2QK7+3i2dhABbaQaBW8O=_6iA@mail.gmail.com>
        <CACRpkdZrSyASctLFfN-8GZRnyfEUPretCXHiD-G+z+cvsDJLww@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 29 Nov 2020 02:11:01 +0100
Linus Walleij <linus.walleij@linaro.org> wrote:

> On Sun, Nov 29, 2020 at 12:18 AM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Sun, Nov 29, 2020 at 12:22 AM Linus Walleij <linus.walleij@linaro.or=
g> wrote: =20
> > > On Sat, Nov 28, 2020 at 7:54 PM Jonathan Cameron <jic23@kernel.org> w=
rote:
> > > =20
> > > > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > >
> > > > Inspired by Andy Shevchenko's proposal to use get_unaligned_leXX().
> > > >
> > > > The whole one time programable memory is treated as a single 64bit
> > > > little endian value.  Thus we can avoid a lot of messy handling
> > > > of fields overlapping byte boundaries by just loading and manipulat=
ing
> > > > it as an __le64 converted to a u64.  That lets us just use FIELD_GE=
T()
> > > > and GENMASK() to extract the values desired.
> > > >
> > > > Note only build tested.
> > > >
> > > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > > Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > > Cc: Linus Walleij <linus.walleij@linaro.org> =20
> > >
> > > Are there any specific prerequisites? linux-next?
> > >
> > > When I apply this and try to compile for an ARMv7 target I get
> > > a lot of noise and an error:
> > >
> > > In file included from <command-line>:0:0:
> > > ../drivers/iio/gyro/mpu3050-core.c: In function =E2=80=98mpu3050_hw_i=
nit=E2=80=99:
> > > ../include/linux/bits.h:36:11: warning: right shift count is negative
> > > [-Wshift-count-negative]
> > >    (~UL(0) >> (BITS_PER_LONG - 1 - (h)))) =20
> >
> > I think GENMASK_ULL() has to be used. =20
>=20
> Oh indeed. It works as long as one just try to test-compile it on a 64bit
> machine of course :D

Doh.  That's me being lazy :(

Will flip them all over to GENMASK_ULL and do a 32 bit build test.
I checked that the FIELD_GET would be fine, but forgot to look at
GENMASK.

oops.

Jonathan

>=20
> Yours,
> Linus Walleij

