Return-Path: <linux-iio+bounces-1461-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE5FD826527
	for <lists+linux-iio@lfdr.de>; Sun,  7 Jan 2024 17:41:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D716D1C2158B
	for <lists+linux-iio@lfdr.de>; Sun,  7 Jan 2024 16:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B35BE12B7D;
	Sun,  7 Jan 2024 16:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M7s4k1B6"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8040F13ADF
	for <linux-iio@vger.kernel.org>; Sun,  7 Jan 2024 16:41:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88AF6C433C8;
	Sun,  7 Jan 2024 16:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704645674;
	bh=mZNFQ/WLUqzvjDcpDH4tkwX+QPz7fYvWvEEk0fD/iow=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=M7s4k1B6zK4Jh3KJzyQA4vWsoN2ohlEF9aQzB1NdbyxWaTGr388+LlSeCGe9IJrQD
	 4IVNL3a7SU+NbQa6ReCnK5Vr36qpR+idWq6lqfYi1hmsjR9AJpN9r+Z4zCuc+PzDCV
	 3IPowWvEITkKXd8odGKL7aB4rzP9oZDsCWClPtRWFjr3QN79XqRUAgwkyVo7BpZ30n
	 HcDttauiqgf41MZEszpiuw562agjFL13GSoC0yCUnbwGEuvChGSev1nzNQugG6mMlw
	 Vp1WvXnFgJ9LPJ1wFY3theitwWHmfPgyIzK0x0oZcgWLgQGD/RSlbSAJKW93nMWp2I
	 TVxAin+ee+IAw==
Date: Sun, 7 Jan 2024 16:41:07 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-iio@vger.kernel.org, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 00/24] IIO: Clean up ACPI_PTR() usage.
Message-ID: <20240107164107.5bebe84a@jic23-huawei>
In-Reply-To: <CAHp75Veup_8sxqk3_sc-_5kmPA295eCcRzD4-GZ9QCWuOFA=mQ@mail.gmail.com>
References: <20231231183514.566609-1-jic23@kernel.org>
	<CAHp75Veup_8sxqk3_sc-_5kmPA295eCcRzD4-GZ9QCWuOFA=mQ@mail.gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 2 Jan 2024 01:48:07 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Sun, Dec 31, 2023 at 8:35=E2=80=AFPM Jonathan Cameron <jic23@kernel.or=
g> wrote:
> >
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > Many of these patches touch ancient drivers so the authors have long
> > moved on to other things. As such I'd appreciate it if anyone has time
> > to take a look!
> >
> > The initial part of this series deals with cases where unused variable
> > warnings are generated with !CONFIG_ACPI but they most date back long
> > enough to predate this being reported by lkp in general and the lkp folk
> > have gotten push back not to push out such reports due to the high level
> > of noise. I think some of these were reported to me directly on my
> > Huawei.com account but aren't on lore.kernel.org. If I can easily
> > track down appropriate closes tags I will add them when applying.
> >
> > The last few patches are for drivers that did have the right protections
> > but where the usage was so trivial I'm not convinced they took the best
> > approach. In the interests of not leaving cases of what I consider an
> > undesirable pattern around for people to copy I have dropped the ACPI_P=
TR()
> > usage and config guards from those as well.
> >
> > There are 3 remaining cases of ACPI_PTR() in IIO. In each of those there
> > is a significant chunk of ACPI specific handling so the relevant guards
> > are there anyway and the complexity is more easily justified. I have
> > not intent to touch those at this time. =20
>=20
> Long awaited series, thanks for doing it!
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> (with some individual nit-picks that you may fix whilst applying)

Thanks. Mostly so I can forget about this series, I've made the tweaks
and applied the lot to the togreg branch of iio.git which will get rebased
on rc1 in a few weeks time.  Happy to add more tags etc or indeed drop
any problematic patches if I get any more feedback in the meantime!

>=20
> Side note: We now have: array_size.h, container_of.h, hex.h,
> kstrtox.h, sprintf.h.
> You may start considering replacing "proxy" headers such as kernel.h
> in the code.

Hmm. That's more of a nice to have than this set where it's about
getting 0-day to stop pestering me :)=20

Worth doing at some point though, perhaps as part of more substantial
driver clean ups.

Thanks,

Jonathan

>=20
> > Jonathan Cameron (24):
> >   iio: accel: da280: Stop using ACPI_PTR()
> >   iio: accel: kxcjk-1013: Move acpi_device_id table under ifdef
> >     CONFIG_ACPI
> >   iio: accel: mma9551: Drop ACPI_PTR() usage
> >   iio: accel: mma9553: Drop ACPI_PTR() usage
> >   iio: accel: mxc4005: Drop ACPI_PTR() usage
> >   iio: accel: mxc6255: Drop ACPI_PTR() usage
> >   iio: accel: stk8ba50: Drop ACPI_PTR() usage
> >   iio: accel: bmc150: Drop ACPI_PTR()
> >   iio: gyro: bmg160: Drop ACPI_PTR() usage
> >   iio: humidity: hts221: Drop ACPI_PTR() usage
> >   iio: imu: fxos8700: Drop ACPI_PTR() usage
> >   iio: imu: kmx61: Drop ACPI_PTR() usage
> >   iio: light: jsa1212: Drop ACPI_PTR() usage
> >   iio: light: ltr501: Drop ACPI_PTR() usage
> >   iio: light: rpr0521: Drop ACPI_PTR() usage
> >   iio: light: stk3310: Drop ACPI_PTR() usage
> >   iio: light: us5182d: Drop ACPI_PTR() usage
> >   iio: magnetometer: bmc150: Drop ACPI_PTR() usage
> >   iio: magnetometer: mmc35240: Drop ACPI_PTR() usage
> >   iio: potentiometer: max5487: Drop ACPI_PTR() usage
> >   iio: st_sensors: drop ACPI_PTR() and CONFIG_ACPI guards
> >   iio: pressure: hp206c: drop ACPI_PTR() and CONFIG_ACPI guards
> >   iio: light: max44000: drop ACPI_PTR() and CONFIG_ACPI guards
> >   iio: adc: ti-adc109s102: drop ACPI_PTR() and CONFIG_ACPI guards
> >
> >  drivers/iio/accel/bmc150-accel-i2c.c       |  2 +-
> >  drivers/iio/accel/bmc150-accel-spi.c       |  3 +-
> >  drivers/iio/accel/da280.c                  |  2 +-
> >  drivers/iio/accel/kxcjk-1013.c             | 33 +++++++++++-----------
> >  drivers/iio/accel/mma9551.c                |  4 +--
> >  drivers/iio/accel/mma9553.c                |  4 +--
> >  drivers/iio/accel/mxc4005.c                |  4 +--
> >  drivers/iio/accel/mxc6255.c                |  4 +--
> >  drivers/iio/accel/st_accel_i2c.c           |  5 +---
> >  drivers/iio/accel/stk8ba50.c               |  4 +--
> >  drivers/iio/adc/ti-adc108s102.c            |  4 +--
> >  drivers/iio/gyro/bmg160_i2c.c              |  4 +--
> >  drivers/iio/humidity/hts221_i2c.c          |  4 +--
> >  drivers/iio/imu/fxos8700_i2c.c             |  3 +-
> >  drivers/iio/imu/fxos8700_spi.c             |  3 +-
> >  drivers/iio/imu/kmx61.c                    |  2 +-
> >  drivers/iio/light/jsa1212.c                |  4 +--
> >  drivers/iio/light/ltr501.c                 |  3 +-
> >  drivers/iio/light/max44000.c               |  6 ++--
> >  drivers/iio/light/rpr0521.c                |  4 +--
> >  drivers/iio/light/stk3310.c                |  4 +--
> >  drivers/iio/light/us5182d.c                |  4 +--
> >  drivers/iio/magnetometer/bmc150_magn_i2c.c |  3 +-
> >  drivers/iio/magnetometer/bmc150_magn_spi.c |  3 +-
> >  drivers/iio/magnetometer/mmc35240.c        |  4 +--
> >  drivers/iio/potentiometer/max5487.c        |  4 +--
> >  drivers/iio/pressure/hp206c.c              |  6 ++--
> >  drivers/iio/pressure/st_pressure_i2c.c     |  5 +---
> >  28 files changed, 60 insertions(+), 75 deletions(-)
> >
> > --
> > 2.43.0
> > =20
>=20
>=20


