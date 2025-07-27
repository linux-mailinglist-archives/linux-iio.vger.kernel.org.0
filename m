Return-Path: <linux-iio+bounces-22061-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D1D6B130C8
	for <lists+linux-iio@lfdr.de>; Sun, 27 Jul 2025 18:53:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41DD21786E8
	for <lists+linux-iio@lfdr.de>; Sun, 27 Jul 2025 16:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C32C72185B8;
	Sun, 27 Jul 2025 16:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K1D9qJlw"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8315FDDA9
	for <linux-iio@vger.kernel.org>; Sun, 27 Jul 2025 16:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753635189; cv=none; b=pZ5yStaeZDyB2GfveDFRtdv1dUBSgieWk5XfqvTouEsqtmT5nNFX2gCXiTOAwaahSOaB+P2nBMo8C6JUbZssmhu4hYxPUCuN/YkXbQv6nFq6jfxWR48UQ5ik88pW9V5Wz4qRPIsfS0J3rizjyB4AHbQTBrFcOwfPfk7Z0vF1TNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753635189; c=relaxed/simple;
	bh=nEKGES25I+b0lftuct4CDI6klEfiomM1NvcT1dlmkM0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GaO19zHXp4mc4M1p+7NI5SPSOWSGU6K+7b7SW2wAaRB1tpvMeTSWKILM3Nesgyxn9mNV1q2IB178PZNPdngMjM/f+L1NIMAkFt1i++JIIcSZmgLnvArLtZJAWmyB7EOcTrPxQ9pP2Ws9WTLdL6zlIAqh6JNsLOKK5oqJy6elAZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K1D9qJlw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81CA9C4CEEB;
	Sun, 27 Jul 2025 16:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753635188;
	bh=nEKGES25I+b0lftuct4CDI6klEfiomM1NvcT1dlmkM0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=K1D9qJlwuSSR0TDjBDmXdTeQIQCK95LgxnH1hx+9fH7Pl9Bpsyo+G0fMolU0Y6RH0
	 DTh6UHXb0Ao2LOIAO6FhXbXdw7WaZLDspLp40X4D50U+QlgoCARtUkr1tNyXAGLwk9
	 +5gqlbZ/xeZchSEpo1v0QsAG3djPHe9hIU/BYBZrBC5f5iQJ9jq5+LhEuDzuzzfFhK
	 /hWhcQYmzjZEIqa6TrgQFERN54RXW2Fze8iFc72TThOrPN2WIMLZK9NKO8rFhJeHg0
	 8BW/MpV8ANVlvGm3ygCN2QNJQb0GQ2feD6iYk7IlrYJ/ejQvm8akNRtpF6GoO7VGdI
	 BqpWohNgGw62Q==
Date: Sun, 27 Jul 2025 17:53:02 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Sean Nyekjaer <sean@geanix.com>
Cc: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>, Jonathan
 Cameron <Jonathan.Cameron@huawei.com>, David Lechner
 <dlechner@baylibre.com>, "linux-iio@vger.kernel.org"
 <linux-iio@vger.kernel.org>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [BUG] iio: imu: inv_icm42600: read temperature, Invalid
 Argument
Message-ID: <20250727175302.7cb89b57@jic23-huawei>
In-Reply-To: <w5ury5pubvk5iavcnu5yc44mp5lplsrvxyet4vwliv3mu3m5y4@sbfiyiy3loov>
References: <unmlpvhl47vjdx7qqdaabhevhj3loydft4ytwxwsgefcyhbzup@zkqulwwfg37o>
	<FR3P281MB1757FE243D78E8F78DA6C576CE4FA@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
	<20250708113508.000027fb@huawei.com>
	<FR3P281MB1757E1352768510879500A3CCE4EA@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
	<20250713144632.0cd2e88f@jic23-huawei>
	<w5ury5pubvk5iavcnu5yc44mp5lplsrvxyet4vwliv3mu3m5y4@sbfiyiy3loov>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 14 Jul 2025 05:29:00 +0000
Sean Nyekjaer <sean@geanix.com> wrote:

> On Sun, Jul 13, 2025 at 02:46:32PM +0100, Jonathan Cameron wrote:
> > On Tue, 8 Jul 2025 12:21:39 +0000
> > Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com> wrote:
> >  =20
> > > >
> > > >________________________________________
> > > >From:=C2=A0Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > >Sent:=C2=A0Tuesday, July 8, 2025 12:35
> > > >To:=C2=A0Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
> > > >Cc:=C2=A0Sean Nyekjaer <sean@geanix.com>; Jonathan Cameron <jic23@ke=
rnel.org>; David Lechner <dlechner@baylibre.com>; linux-iio@vger.kernel.org=
 <linux-iio@vger.kernel.org>; Andy Shevchenko <andy@kernel.org>
> > > >Subject:=C2=A0Re: [BUG] iio: imu: inv_icm42600: read temperature, In=
valid Argument
> > > >=C2=A0
> > > >This Message Is From an External Sender
> > > >This message came from outside your organization.
> > > >=C2=A0
> > > >On Mon, 7 Jul 2025 18:13:33 +0000
> > > >Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com> wrote:
> > > > =20
> > > >> >Hi,
> > > >> >
> > > >> >I'm having some weird issues with reading the temperature of the =
icm42605.
> > > >> >Kernel version: 6.16.0-rc5
> > > >> >
> > > >> ># cat /sys/bus/iio/devices/iio:device2/name
> > > >> >icm42605-accel
> > > >> >
> > > >> >When reading the temperature I get:
> > > >> ># cat /sys/bus/iio/devices/iio:device2/in_temp_raw
> > > >> >cat: read error: Invalid argument
> > > >> >
> > > >> >But if I read from the accelerometer first, I will go better:
> > > >> ># cat /sys/bus/iio/devices/iio:device2/in_accel_x_raw
> > > >> >-378
> > > >> ># cat /sys/bus/iio/devices/iio:device2/in_temp_raw
> > > >> >600
> > > >> >
> > > >> >Then after "some" time, I re-read the temperature I recieve
> > > >> >"Invalid argument" again.
> > > >> >
> > > >> >I have traced the -EINVAL to inv_icm42600_temp_read() because I r=
eceive
> > > >> >INV_ICM42600_DATA_INVALID.
> > > >> >
> > > >> >Register dump diff:
> > > >> >--- invalid-read
> > > >> >+++ ok-read
> > > >> >@@ -10,14 +10,14 @@
> > > >> > 0x1a =3D 0x00000010
> > > >> > 0x1b =3D 0x00000000
> > > >> > 0x1c =3D 0x00000000
> > > >> >-0x1d =3D 0x00000080
> > > >> >-0x1e =3D 0x00000000
> > > >> >-0x1f =3D 0x00000080
> > > >> >-0x20 =3D 0x00000000
> > > >> >-0x21 =3D 0x00000080
> > > >> >-0x22 =3D 0x00000000
> > > >> >-0x23 =3D 0x00000080
> > > >> >-0x24 =3D 0x00000000
> > > >> >+0x1d =3D 0x00000002
> > > >> >+0x1e =3D 0x00000038
> > > >> >+0x1f =3D 0x000000fe
> > > >> >+0x20 =3D 0x00000085
> > > >> >+0x21 =3D 0x000000fe
> > > >> >+0x22 =3D 0x000000df
> > > >> >+0x23 =3D 0x000000f8
> > > >> >+0x24 =3D 0x0000003a
> > > >> > 0x25 =3D 0x00000080
> > > >> > 0x26 =3D 0x00000000
> > > >> > 0x27 =3D 0x00000080
> > > >> >@@ -26,7 +26,7 @@
> > > >> > 0x2a =3D 0x00000000
> > > >> > 0x2b =3D 0x00000000
> > > >> > 0x2c =3D 0x00000000
> > > >> >-0x2d =3D 0x00000000
> > > >> >+0x2d =3D 0x00000008
> > > >> > 0x2e =3D 0x00000000
> > > >> > 0x2f =3D 0x00000000
> > > >> > 0x30 =3D 0x000000ff
> > > >> >@@ -59,11 +59,11 @@
> > > >> > 0x4b =3D 0x00000000
> > > >> > 0x4c =3D 0x00000032
> > > >> > 0x4d =3D 0x00000099
> > > >> >-0x4e =3D 0x00000000
> > > >> >+0x4e =3D 0x00000002
> > > >> > 0x4f =3D 0x00000009
> > > >> > 0x50 =3D 0x00000009
> > > >> > 0x51 =3D 0x00000016
> > > >> >-0x52 =3D 0x00000000
> > > >> >+0x52 =3D 0x00000060
> > > >> > 0x53 =3D 0x0000000d
> > > >> > 0x54 =3D 0x00000031
> > > >> > 0x55 =3D 0x00000000
> > > >> >
> > > >> >Will the iio core retry a read? If the -EINVAL is returned,
> > > >> >inv_icm42600_accel_read_raw() is call once more.
> > > >> >
> > > >> >One more thing...
> > > >> >When I'm removing the module, the kernel prints this:
> > > >> >inv-icm42600-i2c 1-0068: Runtime PM usage count underflow!
> > > >> >
> > > >> >I will continue investigate this
> > > >> >Br,
> > > >> >Sean =20
> > > >>
> > > >> Hello Sean,
> > > >>
> > > >> this is expected behavior since the temperature returned is not th=
e external
> > > >> temperature but the temperature of the mechanical component (MEMS)=
. It will
> > > >> only work if the chip is on, meaning accelerometer and/or gyroscop=
e is on.
> > > >>
> > > >> That's why you can get temperature after reading accel data since =
it is
> > > >> turning the chip. But after a short while autosuspend is putting t=
he chip
> > > >> back off and you cannot read temperature anymore.
> > > >>
> > > >> You need to turn one sensor continuously on with a buffer, and the=
n you can
> > > >> read temperature all the time since the chip is running.
> > > >>
> > > >> Temperature data are here only to do temperature compensation of t=
he accel
> > > >> and gyro data. =20
> > > >
> > > >That is rather non-intuitive behavior.  Could we make a read of the =
temperature
> > > >channel turn on one of the components?  Given expected use case it s=
houldn't commonly
> > > >happen but if not too horrendous to implement it would be better to =
avoid the error
> > > >seen here. =20
> > >
> > > Hello Jonathan,
> > >
> > > the problem here is which sensor to turn on? Accel or gyro, or accel+=
gyro?
> > > And the temperature reported will be completely different if it is ac=
cel
> > > and/or gyro running, since gyro is heating much more than accel.
> > >
> > > This is not a classical temperature sensor, but an internal one for m=
easuring
> > > temperature of the mechanical part while running. The usual use case =
on our
> > > side is polling the temperature at low frequency (10Hz, 20Hz) while a=
ccel
> > > and/or gyro are running to do temperature compensation on the data re=
ad.
> > >
> > > We generally want to avoid temperature data in the FIFO because repor=
ting
> > > temperature at high frequency is not useful, and it is consuming spac=
e in
> > > the FIFO. We prefer to have more space in the FIFO for accel and gyro=
 data
> > > and do polling of temperature.
> > >
> > > Temperature reporting while the chip is off makes absolutely no sense=
 that's
> > > why it is not supported by the chip, even if it can be non-intuitive.
> > >
> > > Perhaps we can use another error returning code rather than invalid v=
alue?
> > > Otherwise, tell me what you think is the best to do. =20
> >=20
> > Maybe indicate it is a temporary situation that userspace can resolve
> > by reporting -EBUSY?  I'm not sure what the best path forward here is.
> >=20
> > Your explanation seems reasonable to me.  Sean, do you still believe
> > we need to make a change here? =20
>=20
> I think -EBUSY would be better, returning -EINVAL required me to read the=
 driver,
> and apply some debug printk's to see where it originated from.
>=20
> Returning -EBUSY and add a comment about the "issue" in
> inv_icm42600_temp_read(), would be a help.

Anyone want to spin a patch?  I'm marking this thread closed in patchwork
in the meantime.

Thanks,

Jonathan

>=20
> /Sean
>=20
> >=20
> > Jonathan
> >  =20
> > >
> > > Thanks,
> > > JB
> > > =20
> > > > =20
> > > >>
> > > >> Thanks,
> > > >> JB =20
> > > >
> > > > =20
> >  =20
>=20


