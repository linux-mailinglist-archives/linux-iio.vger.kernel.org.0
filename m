Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C480E1C2E3A
	for <lists+linux-iio@lfdr.de>; Sun,  3 May 2020 19:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728997AbgECRUF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 3 May 2020 13:20:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:48514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728859AbgECRUF (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 3 May 2020 13:20:05 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 760E3206A5;
        Sun,  3 May 2020 17:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588526404;
        bh=pDottKMNnrqLrwSAt7oXmpd18av3ewiA/EaQNbK61kc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qdZtVGFrRb3ohgknISGb/OAjSB2B0GbvURwANQ85KskwRZxYYLCBtTfsk6cJzq/RM
         +Tp5LxtZfyDOLo/WacXYrs7JOLqLGiQRNqTeHGiTnxy8LWiJpO7fw2NMs/iinyu/kb
         AqVFxDfMhh5LQwvUKGqOL1uVAEmzSw0GrVQ5ARn4=
Date:   Sun, 3 May 2020 18:19:58 +0100
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
Message-ID: <20200503181959.369161a4@archlinux>
In-Reply-To: <20200503122926.1fcc73fa@archlinux>
References: <20200413082445.17324-1-nuno.sa@analog.com>
        <20200413082445.17324-6-nuno.sa@analog.com>
        <2418ed60-8407-0c99-bf5d-1afc3964de2b@metafoo.de>
        <20200502184010.134eb8b5@archlinux>
        <67202bd8-e0a5-be53-13c6-e01a25e2a85b@metafoo.de>
        <df0f04296fafccfcf18b08b213bae20ff69c2384.camel@gmail.com>
        <20200503094751.633feda1@archlinux>
        <c7c6c4af-826a-d52a-3969-4ccccbff12e9@metafoo.de>
        <231ac29f177774eeb32b0ed907516173af0f97eb.camel@gmail.com>
        <20200503122926.1fcc73fa@archlinux>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 3 May 2020 12:29:26 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Sun, 03 May 2020 13:07:01 +0200
> Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
>=20
> > On Sun, 2020-05-03 at 11:07 +0200, Lars-Peter Clausen wrote: =20
> > > On 5/3/20 10:47 AM, Jonathan Cameron wrote:   =20
> > > > On Sat, 02 May 2020 21:52:18 +0200
> > > > Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
> > > >    =20
> > > > > On Sat, 2020-05-02 at 20:01 +0200, Lars-Peter Clausen wrote:   =20
> > > > > > On 5/2/20 7:40 PM, Jonathan Cameron wrote:   =20
> > > > > > > On Mon, 27 Apr 2020 20:06:07 +0200
> > > > > > > Lars-Peter Clausen <lars@metafoo.de> wrote:
> > > > > > >       =20
> > > > > > > > On 4/13/20 10:24 AM, Nuno S=C3=A1 wrote:   =20
> > > > > > > > > [...]
> > > > > > > > > +static irqreturn_t adis16475_trigger_handler(int irq,
> > > > > > > > > void *p)
> > > > > > > > > +{
> > > > > > > > > [...]
> > > > > > > > > +	__be16 data[ADIS16475_MAX_SCAN_DATA], *buffer;
> > > > > > > > > [...]
> > > > > > > > > +
> > > > > > > > > +	iio_push_to_buffers_with_timestamp(indio_dev, data, pf-=
   =20
> > > > > > > > > > timestamp);   =20
> > > > > > > > If the timestamp is enabled the IIO core might insert
> > > > > > > > padding
> > > > > > > > between
> > > > > > > > the data channels and the timestamp. If that happens this
> > > > > > > > will
> > > > > > > > disclose
> > > > > > > > kernel stack memory to userspace.
> > > > > > > >=20
> > > > > > > > This needs either a memset(data, 0x00, sizeof(data)) or
> > > > > > > > maybe put
> > > > > > > > data
> > > > > > > > into the state struct and kzalloc it.   =20
> > > > > > > Good spot. Could simply do __be16 data[ADI..] =3D {0}; rather
> > > > > > > than
> > > > > > > explicit
> > > > > > > memset, but some form of zeroization is needed.
> > > > > > >=20
> > > > > > > I've fixed up the applied patch with the above approach.   =20
> > > > > > There is actually another issue. The stack data is not
> > > > > > necessarily
> > > > > > aligned to 64 bit, which causes issues if we try to put the 64-
> > > > > > bit   =20
> > > > > Oh, this is actually more problematic. Yes, since we have an
> > > > > array of
> > > > > u16, that is not guaranteed to be 64bit aligned. Doing a quick
> > > > > search
> > > > > of `iio_push_to_buffers_with_timestamp()` users and I could
> > > > > quickly
> > > > > find 4/5 drivers with the same problem. I guess the API should
> > > > > clearly
> > > > > state that `data` needs to be __at least__ 64 bits aligned (maybe
> > > > > a
> > > > > future patch). Or we could even check the address and guarantee
> > > > > that it
> > > > > is properly aligned before continuing (though Im guessing this
> > > > > will
> > > > > break a lot of users...)   =20
> > > > > > timestamp in it. I think data should really be in the state
> > > > > > struct.   =20
> > > > > Yes, with a proper __aligned(8) attribute... Or couldn't we just
> > > > > use
> > > > > __aligned(8) on the stack variable?   =20
> > > > Forcing alignment on the stack isn't terribly reliable, which is
> > > > why
> > > > we never do that for dma safe buffers.
> > > >=20
> > > > Probably better to just move it to the state structure.
> > > > I'll fix it up to do that. Please sanity check what will shortly
> > > > be in the testing branch.
> > > >=20
> > > > The moment Lars mentioned this I groaned. As you've noted a few
> > > > other
> > > > drivers have the same problem + the ABI doesn't clearly state
> > > > or check this.
> > > >=20
> > > > We should certainly fix all the drivers that suffer this problem
> > > > first then we can think about adding a runtime check.   =20
> > >=20
> > > It looks like it is actually quite a few drivers, maybe we should
> > > switch    =20
> >=20
> > Yeps, not surprised...
> >  =20
> > > to put_unaligned(). We probably got lucky in most cases and the
> > > buffer   =20
> >=20
> > This would keep us from having to fix all the users (just need to fix
> > the memory leakage you mention on the next email) to use a properly
> > aligned buffer. And later on, if we want, we can always add an
> > `aligned` variant of `iio_push_to_buffers_with_timestamp()` were we
> > check for alignment... =20
>=20
> I'd rather scrub the existing set to fix this.  The reason being
> to make the point they were broken.  Fixing up with an unaligned
> write in the core is not 'obvious' to people looking at whether
> to pick up patches for individual drivers.
>=20
> Unlikely to be too much extra over making sure we don't leak kernel
> data.   If we move them to the iio_priv structure we will avoid that
> anyway due to that being kzalloc ed in the first place.  We may
> leak previous timestamps or read values, but we don't care about that.
>=20
> It's been there a while, so no 'super hurry' to fix these up but
> we should do it over next few months.

It's also worth noticing that there is some care needed.
Some devices don't need to zero because there is no padding.
Some devices are using the core demux, so the timestamp is always
in the same place, hence can be nicely refactored to an explicit
structure, either on the stack or heap.

Anyhow, from the first few I looked at I suspect they are all going
to have slightly different optimal solutions.

Take a look at the kxsd9 patch I'll send in a minute.  For that one
I think the cleanest thing is to leave the variable on the stack
but use an explicit structure to ensure the alignment is correct.

I'll look to do a few of these at a time over the next few weeks
as each one needs fairly careful review.

Jonathan

>=20
> Jonathan
>=20
> >=20
> > - Nuno S=C3=A1
> >  =20
>=20

