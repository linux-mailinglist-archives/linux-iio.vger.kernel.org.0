Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63F381C2AC4
	for <lists+linux-iio@lfdr.de>; Sun,  3 May 2020 10:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727797AbgECIr4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 3 May 2020 04:47:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:37750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726802AbgECIr4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 3 May 2020 04:47:56 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14AA8206EB;
        Sun,  3 May 2020 08:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588495675;
        bh=Mekv0zEZz4WYXSghQvhaFFTrZhYWclrU+we/dK81jQQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=B5KNgEFjIOt7+Pb+lKh28rVcv6YSSPz75wpg+d0B4AugCYZJEt2O5io/gObypylFy
         Dxy8a4ZYe2Bq3entAztN55zFzig7OPOwmNC7p1yBgPiP3506JrimJLCa+iMIVU6rp7
         eG//uwb1/EoZVVjhSNl0yVsuFPtahj8WYUpd70GM=
Date:   Sun, 3 May 2020 09:47:51 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexandru Ardelean <alexandru.Ardelean@analog.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: Re: [PATCH v5 5/6] iio: imu: Add support for adis16475
Message-ID: <20200503094751.633feda1@archlinux>
In-Reply-To: <df0f04296fafccfcf18b08b213bae20ff69c2384.camel@gmail.com>
References: <20200413082445.17324-1-nuno.sa@analog.com>
        <20200413082445.17324-6-nuno.sa@analog.com>
        <2418ed60-8407-0c99-bf5d-1afc3964de2b@metafoo.de>
        <20200502184010.134eb8b5@archlinux>
        <67202bd8-e0a5-be53-13c6-e01a25e2a85b@metafoo.de>
        <df0f04296fafccfcf18b08b213bae20ff69c2384.camel@gmail.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 02 May 2020 21:52:18 +0200
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Sat, 2020-05-02 at 20:01 +0200, Lars-Peter Clausen wrote:
> > On 5/2/20 7:40 PM, Jonathan Cameron wrote: =20
> > > On Mon, 27 Apr 2020 20:06:07 +0200
> > > Lars-Peter Clausen <lars@metafoo.de> wrote:
> > >  =20
> > > > On 4/13/20 10:24 AM, Nuno S=C3=A1 wrote: =20
> > > > > [...]
> > > > > +static irqreturn_t adis16475_trigger_handler(int irq, void *p)
> > > > > +{
> > > > > [...]
> > > > > +	__be16 data[ADIS16475_MAX_SCAN_DATA], *buffer;
> > > > > [...]
> > > > > +
> > > > > +	iio_push_to_buffers_with_timestamp(indio_dev, data, pf- =20
> > > > > >timestamp); =20
> > > > If the timestamp is enabled the IIO core might insert padding
> > > > between
> > > > the data channels and the timestamp. If that happens this will
> > > > disclose
> > > > kernel stack memory to userspace.
> > > >=20
> > > > This needs either a memset(data, 0x00, sizeof(data)) or maybe put
> > > > data
> > > > into the state struct and kzalloc it. =20
> > > Good spot. Could simply do __be16 data[ADI..] =3D {0}; rather than
> > > explicit
> > > memset, but some form of zeroization is needed.
> > >=20
> > > I've fixed up the applied patch with the above approach. =20
> > There is actually another issue. The stack data is not necessarily=20
> > aligned to 64 bit, which causes issues if we try to put the 64-bit  =20
>=20
> Oh, this is actually more problematic. Yes, since we have an array of
> u16, that is not guaranteed to be 64bit aligned. Doing a quick search
> of `iio_push_to_buffers_with_timestamp()` users and I could quickly
> find 4/5 drivers with the same problem. I guess the API should clearly
> state that `data` needs to be __at least__ 64 bits aligned (maybe a
> future patch). Or we could even check the address and guarantee that it
> is properly aligned before continuing (though Im guessing this will
> break a lot of users...)
> > timestamp in it. I think data should really be in the state struct. =20
>=20
> Yes, with a proper __aligned(8) attribute... Or couldn't we just use
> __aligned(8) on the stack variable?

Forcing alignment on the stack isn't terribly reliable, which is why
we never do that for dma safe buffers.

Probably better to just move it to the state structure.=20
I'll fix it up to do that. Please sanity check what will shortly
be in the testing branch.

The moment Lars mentioned this I groaned. As you've noted a few other
drivers have the same problem + the ABI doesn't clearly state
or check this.=20

We should certainly fix all the drivers that suffer this problem
first then we can think about adding a runtime check.

Jonathan
>=20
> - Nuno S=C3=A1
>=20
>=20

