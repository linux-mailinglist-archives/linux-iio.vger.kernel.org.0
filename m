Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51E8C1D68C4
	for <lists+linux-iio@lfdr.de>; Sun, 17 May 2020 18:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728033AbgEQQP3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 17 May 2020 12:15:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:34140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728010AbgEQQP3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 17 May 2020 12:15:29 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4480207DA;
        Sun, 17 May 2020 16:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589732128;
        bh=lOxMalPSboreFQo6nowy7ak59+Im6Zg68rOTJJVpKdo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GO1hXFx0ruK49r0fssOllKsIx+koTJJtlnLn298nBpcZDxskaxfrZz7wJe9NGY9W8
         SYIx87znZ8S16zXfX5WiOxay8Qvvdukq5cpS7/4H1tlZqHt5zTC6AJdmDOHoYuN7ub
         A7CWlD7vtfVgeJmlZp2LgGdBpH0MqdaGIY6+hXIQ=
Date:   Sun, 17 May 2020 17:15:23 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>,
        Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexandru Ardelean <alexandru.Ardelean@analog.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: Re: [PATCH v5 5/6] iio: imu: Add support for adis16475
Message-ID: <20200517171523.54fa6deb@archlinux>
In-Reply-To: <b7289aca-f393-faca-f512-a952a77c1e68@metafoo.de>
References: <20200413082445.17324-1-nuno.sa@analog.com>
        <20200413082445.17324-6-nuno.sa@analog.com>
        <2418ed60-8407-0c99-bf5d-1afc3964de2b@metafoo.de>
        <20200502184010.134eb8b5@archlinux>
        <67202bd8-e0a5-be53-13c6-e01a25e2a85b@metafoo.de>
        <df0f04296fafccfcf18b08b213bae20ff69c2384.camel@gmail.com>
        <20200503094751.633feda1@archlinux>
        <c7c6c4af-826a-d52a-3969-4ccccbff12e9@metafoo.de>
        <b7289aca-f393-faca-f512-a952a77c1e68@metafoo.de>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 3 May 2020 11:12:34 +0200
Lars-Peter Clausen <lars@metafoo.de> wrote:

> On 5/3/20 11:07 AM, Lars-Peter Clausen wrote:
> > On 5/3/20 10:47 AM, Jonathan Cameron wrote: =20
> >> On Sat, 02 May 2020 21:52:18 +0200
> >> Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
> >> =20
> >>> On Sat, 2020-05-02 at 20:01 +0200, Lars-Peter Clausen wrote: =20
> >>>> On 5/2/20 7:40 PM, Jonathan Cameron wrote: =20
> >>>>> On Mon, 27 Apr 2020 20:06:07 +0200
> >>>>> Lars-Peter Clausen <lars@metafoo.de> wrote: =20
> >>>>>> On 4/13/20 10:24 AM, Nuno S=C3=A1 wrote: =20
> >>>>>>> [...]
> >>>>>>> +static irqreturn_t adis16475_trigger_handler(int irq, void *p)
> >>>>>>> +{
> >>>>>>> [...]
> >>>>>>> +=C2=A0=C2=A0=C2=A0 __be16 data[ADIS16475_MAX_SCAN_DATA], *buffer;
> >>>>>>> [...]
> >>>>>>> +
> >>>>>>> +=C2=A0=C2=A0=C2=A0 iio_push_to_buffers_with_timestamp(indio_dev,=
 data, pf- =20
> >>>>>>>> timestamp); =20
> >>>>>> If the timestamp is enabled the IIO core might insert padding
> >>>>>> between
> >>>>>> the data channels and the timestamp. If that happens this will
> >>>>>> disclose
> >>>>>> kernel stack memory to userspace.
> >>>>>>
> >>>>>> This needs either a memset(data, 0x00, sizeof(data)) or maybe put
> >>>>>> data
> >>>>>> into the state struct and kzalloc it. =20
> >>>>> Good spot. Could simply do __be16 data[ADI..] =3D {0}; rather than
> >>>>> explicit
> >>>>> memset, but some form of zeroization is needed.
> >>>>>
> >>>>> I've fixed up the applied patch with the above approach. =20
> >>>> There is actually another issue. The stack data is not necessarily
> >>>> aligned to 64 bit, which causes issues if we try to put the 64-bit =
=20
> >>> Oh, this is actually more problematic. Yes, since we have an array of
> >>> u16, that is not guaranteed to be 64bit aligned. Doing a quick search
> >>> of `iio_push_to_buffers_with_timestamp()` users and I could quickly
> >>> find 4/5 drivers with the same problem. I guess the API should clearly
> >>> state that `data` needs to be __at least__ 64 bits aligned (maybe a
> >>> future patch). Or we could even check the address and guarantee that =
it
> >>> is properly aligned before continuing (though Im guessing this will
> >>> break a lot of users...) =20
> >>>> timestamp in it. I think data should really be in the state struct. =
=20
> >>> Yes, with a proper __aligned(8) attribute... Or couldn't we just use
> >>> __aligned(8) on the stack variable? =20
> >> Forcing alignment on the stack isn't terribly reliable, which is why
> >> we never do that for dma safe buffers.
> >>
> >> Probably better to just move it to the state structure.
> >> I'll fix it up to do that. Please sanity check what will shortly
> >> be in the testing branch.
> >>
> >> The moment Lars mentioned this I groaned. As you've noted a few other
> >> drivers have the same problem + the ABI doesn't clearly state
> >> or check this.
> >>
> >> We should certainly fix all the drivers that suffer this problem
> >> first then we can think about adding a runtime check. =20
> >
> > It looks like it is actually quite a few drivers, maybe we should=20
> > switch to put_unaligned(). We probably got lucky in most cases and the=
=20
> > buffer is naturally aligned to 64 bit.

Just a quick update on this.  I've been taking a deeper look and there
are some 'interesting' cases in here so the put_unaligned is attractive
unfortunately I don't think we can go that way because it would be
reasonable for consumers of the buffer to expect it to be appropriately
aligned.   We need to rework many of these anyway to fix the related
data leak.

I've done some of below and will post shortly - a few will take more
effort and probably need testing rather than just relying on review.

So far the 'interesting ones' are mpu3050 and isl29501.

J

> >
> > But the reason I noticed this is because I ran into the issue in the=20
> > wild where the timestamp ended up at the wrong offset in the buffer,=20
> > so it does happen.
> >
> > The following semantic patch finds affected drivers.
> >
> > @@
> > type T;
> > identifier buf;
> > expression N;
> > expression ts;
> > expression indio_dev;
> > @@
> > *T buf[N];
> > ...
> > *iio_push_to_buffers_with_timestamp(indio_dev, buf, ts)
> >
> > Matched files:
> >
> > --- drivers/iio/health/afe4403.c
> > --- drivers/iio/health/afe4404.c
> > --- drivers/iio/gyro/mpu3050-core.c
> > --- drivers/iio/gyro/itg3200_buffer.c
> > --- drivers/iio/chemical/ccs811.c
> > --- drivers/iio/chemical/sps30.c
> > --- drivers/iio/chemical/pms7003.c
> > --- drivers/iio/proximity/isl29501.c
> > --- drivers/iio/proximity/mb1232.c
> > --- drivers/iio/accel/kxsd9.c
> > --- drivers/iio/accel/mma8452.c
> > --- drivers/iio/accel/bmc150-accel-core.c
> > --- drivers/iio/accel/mma7455_core.c
> > --- drivers/iio/adc/ti-adc081c.c
> > --- drivers/iio/adc/ti-adc084s021.c
> > --- drivers/iio/adc/ti-ads1015.c
> > --- drivers/iio/adc/ti-ads124s08.c
> > --- drivers/iio/adc/ina2xx-adc.c
> > --- drivers/iio/adc/ti-ads8688.c
> > --- drivers/iio/adc/ti-adc0832.c
> > --- drivers/iio/adc/ti-adc12138.c
> > --- drivers/iio/adc/max1118.c
> > --- drivers/iio/adc/ad_sigma_delta.c
> > --- drivers/iio/light/si1145.c
> > --- drivers/iio/light/vcnl4035.c
> > --- drivers/iio/light/max44000.c
> > --- drivers/iio/light/rpr0521.c
> > --- drivers/iio/light/st_uvis25_core.c
> > --- drivers/iio/light/ltr501.c
> > --- drivers/iio/magnetometer/ak8974.c
> > --- drivers/iio/magnetometer/mag3110.c
> > --- drivers/iio/magnetometer/ak8975.c
> > --- drivers/iio/humidity/hdc100x.c
> > --- drivers/iio/humidity/hts221_buffer.c
> > --- drivers/iio/imu/bmi160/bmi160_core.c
> > --- drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> > --- drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> > --- drivers/iio/pressure/ms5611_core.c
> > --- drivers/iio/pressure/mpl3115.c
> > =20
> Most of these drivers also seem to have the issue that they leak stack=20
> memory. Only 11 of them clear the buffer.
>=20

