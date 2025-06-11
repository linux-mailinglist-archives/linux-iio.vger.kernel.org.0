Return-Path: <linux-iio+bounces-20438-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 822E4AD5989
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 17:05:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA8CD7A82D0
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 15:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B1D1A08DF;
	Wed, 11 Jun 2025 15:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MnW4DKiv"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3939118E050;
	Wed, 11 Jun 2025 15:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749654306; cv=none; b=ERIE6K5SA7VpBkusSsg22Sow3DfMar9d96Ozdm8MOsbE/+8pCDoXiY5Z/tH0gI0ThfgVHGmpf3NVxdMXRohKTwpOXuQoWJbJwfMNyFAmUlQzdFG4g5jwYQdg+wjlMrZbNb09GFVvTVZOofYN1t8uzI5zGxHOEugJ+w+bf+CVO9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749654306; c=relaxed/simple;
	bh=9X9Q/RhMKwwi6qKd5W24bBYHVqHopn2qZZeEIeV6ZZA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UitDn5vqiniWzHdIm30/m7moyayJpKFEQn5QqY9NORzJvdazIx4IZzrtGg9pY8K53fppWKoiyReL0zXmWO7RvPJV1jOVnAozODQTtAxWJAPV1eMK1NbOtwMoaRWA6chvhjdc/yHzWyDZhmB4Zn/ya2y6nNNfggGroPv6RQJ9L5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MnW4DKiv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8559DC4CEEE;
	Wed, 11 Jun 2025 15:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749654305;
	bh=9X9Q/RhMKwwi6qKd5W24bBYHVqHopn2qZZeEIeV6ZZA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MnW4DKivwv3OFb7ctyoJsXRBJlbtA+4iTU9ZztWWNmtG57J8OQPxI/4qGQhCxJkmE
	 I1AQN4RudaWY4B85sEOTT5c2+Uxry0CIKZa5LkfRuf5a/x6G49uQsIUsSywoJ0OMAf
	 1JcwY6hjsWEBaAPXMI0Bp112l7PHtqPrr21DTibfLmvYbZRz8KnUJRQL5nOLma5f5E
	 ti+fK3DECr80CFTqFCYO1T6F0T4aDbltJGsD0zc7QYvHiJ+4PYnHDqlVrUrV1wuCZv
	 ae68fcjKjHKPHW4tfDBeMEJ8mOI9a3T8d2KpfaI1LRqyrgobuZlKjxUhHTpaBWKnbe
	 Ub8zFBd/FvVng==
Date: Wed, 11 Jun 2025 16:04:57 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 corbet@lwn.net, lucas.p.stankus@gmail.com, lars@metafoo.de,
 Michael.Hennerich@analog.com, bagasdotme@gmail.com,
 linux-iio@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 03/11] iio: accel: adxl313: make use of regmap cache
Message-ID: <20250611160457.4d83df4e@jic23-huawei>
In-Reply-To: <CAFXKEHY5SmtTrxy-8AWxGNqkPUAZjitgYDg2pR7acTAt-tFWdQ@mail.gmail.com>
References: <20250601172139.59156-1-l.rubusch@gmail.com>
	<20250601172139.59156-4-l.rubusch@gmail.com>
	<20250608162215.0d1789d0@jic23-huawei>
	<20250608163812.4a1a93df@jic23-huawei>
	<CAFXKEHY5SmtTrxy-8AWxGNqkPUAZjitgYDg2pR7acTAt-tFWdQ@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 11 Jun 2025 15:48:25 +0200
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> On Sun, Jun 8, 2025 at 5:38=E2=80=AFPM Jonathan Cameron <jic23@kernel.org=
> wrote:
> >
> > On Sun, 8 Jun 2025 16:22:15 +0100
> > Jonathan Cameron <jic23@kernel.org> wrote:
> > =20
> > > On Sun,  1 Jun 2025 17:21:31 +0000
> > > Lothar Rubusch <l.rubusch@gmail.com> wrote:
> > > =20
> > > > Setup regmap cache to cache register configuration. This is a prepa=
ratory
> > > > step for follow up patches. Using cached settings will help at iner=
rupt
> > > > handling, to generate activity and inactivity events. =20
> > >
> > > The regmap cache will reduce traffic to the device for things like re=
ading
> > > back sampling frequency, so no need to justify this patch with 'futur=
e'
> > > stuff.  Justify it with current.   I've applied with the description =
of
> > > simply
> > >
> > > "Setup regmap cache to cache register configuration, reducing bus tra=
ffic
> > > for repeated accesses to non volatile registers."
> > > =20
> > Dropped again.  The is_volatile should include all volatile registers
> > not just ones we happen to be using so far.
> > =20
>=20
> I see among the patches, REG_INT_SOURCE is added later. For a v5 then
> I'll prepare a patch which sets up all registers - including
> REG_INT_SOURCE right away. Correct?
>=20
Yes + any others that we aren't using at all yet.

> Then it should be added the following line:
> bool adxl313_is_volatile_reg(struct device *dev, unsigned int reg)
> {
>     switch (reg) {
>     case ADXL313_REG_DATA_AXIS(0):
>     case ADXL313_REG_DATA_AXIS(1):
>     case ADXL313_REG_DATA_AXIS(2):
>     case ADXL313_REG_DATA_AXIS(3):
>     case ADXL313_REG_DATA_AXIS(4):
>     case ADXL313_REG_DATA_AXIS(5):
>     case ADXL313_REG_FIFO_STATUS:
> +    case ADXL313_REG_INT_SOURCE:
>         return true;
>     default:
>         return false;
>     }
> }
>=20
> > You added debug accesses in previous patch which will not take the vola=
tile
> > nature into account unless the register is in that switch statement. =20
>=20
> This is not quite clear to me. What am I missing here?
>=20
> When I try to find iio drivers using "debugfs" and having a
> "volatile_reg" called specification (using either ranges or by a
> function), I could only identify the following drivers:
> ./drivers/iio/accel/msa311.c
> ./drivers/iio/adc/ad7380.c
> ./drivers/iio/adc/ina2xx-adc.c
> ./drivers/iio/imu/bno055/bno055.c
> ./drivers/iio/light/gp2ap020a00f.c

It only matters if regcache is involved.  If you don't mark
all the registers volatile + provide debugfs access to them
then only the first read will reach the device.  The result
of that will be stored in cache and served up for future
use of the debug interface (rather than the updated value).

>=20
> I tried to find if there is a special declaration of debug registers
> in the volatile_reg list, but could not find any.
>=20
> Most interesting here was:
> ./drivers/iio/adc/ad7380.c
>=20
> It seems to claim a kind of a "direct" access specifier. Should I use
> similar calls to `iio_device_claim_direct()` and
> `iio_device_release_direct()` here?

Generally we only do that if simply accessing the register is enough
to break comms if done incorrectly. That's normally only on devices
where a mode switch is involved where a device transitions from
register access mode to streaming mode and we don't want a simple
debug read to flip it back again (as that would be a major state
change and rather defeat the point of debug access).

Note sure if that's true for that particular part or not though
(I didn't look).

>=20
>  999
> 1000 static int ad7380_debugfs_reg_access(struct iio_dev *indio_dev,
> u32 reg,
> 1001                                      u32 writeval, u32 *readval)
> 1002 {
> 1003         struct ad7380_state *st =3D iio_priv(indio_dev);
> 1004         int ret;
> 1005
> 1006         if (!iio_device_claim_direct(indio_dev))
> 1007                 return -EBUSY;
> 1008
> 1009         if (readval)
> 1010                 ret =3D regmap_read(st->regmap, reg, readval);
> 1011         else
> 1012                 ret =3D regmap_write(st->regmap, reg, writeval);
> 1013
> 1014         iio_device_release_direct(indio_dev);
> 1015
> 1016         return ret;
> 1017 }
> 1018
>=20
> >
> > Put the all in from the start.
> > =20
>=20
> I guess, in the ADXL313 I'm doing the same approach as for the
> ADXL345. If it's wrong / incomplete here, it will need to be fixed in
> the ADXL345 as well. Or did I understand something wrong?

No there is generally no need to prevent debug access just because
buffered mode is in use.  It is possible for someone foolishly
misusing the write to break things of course, but if we remove
the foot gun then the debug interfaces aren't useful in what is
normally our most high performance mode and one we may well be in
when we want to poke the state.

I'm not personally a big fan of any debug interfaces at all in
production drivers, but we've had them a long time so that ship
sailed.

Jonathan


