Return-Path: <linux-iio+bounces-21601-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F8EB0313E
	for <lists+linux-iio@lfdr.de>; Sun, 13 Jul 2025 15:46:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFF8B189B9F0
	for <lists+linux-iio@lfdr.de>; Sun, 13 Jul 2025 13:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC7F155C97;
	Sun, 13 Jul 2025 13:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fgbBbcKe"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0EB2E371F
	for <linux-iio@vger.kernel.org>; Sun, 13 Jul 2025 13:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752414400; cv=none; b=hl01mwTyvA/BULMTJKD9fxq1sgZxPQ56XvNEPXOEwL+ROL5PRSj/xi6ztDk3GMHf5VpexVKPr88DTpo+1DYzj0woeCS7R4eFonMIPQdD7f5XEVnajp7tqdau0iBCKJjQDiXFsJdH0tL/sAVTSF+MzME65PLBOCpa0jwji4nD/DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752414400; c=relaxed/simple;
	bh=/tmFEAvTwinCLsVcfPeX5AR4/9CaR/edzXCujVbx0V0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r5WkEj99OzsruTqKIEjFkfJxEo07+oHM9MHJO95OHIagLXb64CcV4EIq2rxuEmZmDwwUhsNy4ZofHSPlIMjTyHHghKEBNgVwgeSkx+WEnjUeiWdYlLo2STrOh6xv+dtDLiYiiH3OHQ8IeHWYU9ze/E1ark8xFlGWOn8HZs64JJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fgbBbcKe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 318A0C4CEE3;
	Sun, 13 Jul 2025 13:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752414398;
	bh=/tmFEAvTwinCLsVcfPeX5AR4/9CaR/edzXCujVbx0V0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fgbBbcKe71fzBGbJZOwGP4XOoFA8zrSV4WIiIRhxTImlJ89qxcP0J3/0etzoUk/Wz
	 81yKflJOE3D6Ve7Y+cBjPJBsNoxLCuFuIPy49Y+6VA0+Cwpzu3lOQLaFXtXuzrdwoh
	 Lg6iNtRjIM4L/qkZ0s5rkGBX4ITnm6FVVVk+OGdJja+AR5z4iKzLuURWsb9WfBW4ao
	 hRmvFlG4eUm0d+stWRUHjqMyYIGuXC6IfyPNGQ5NhF585cRnf2I1z/eb8Ak8nMJxyU
	 vh6j4/cRA14EvhbMdzsrDrsRhfG+AAgM+ID5Jui+JCdul+L7iDgsXE7TiH08aCc/2s
	 LLJbfIEHMAySw==
Date: Sun, 13 Jul 2025 14:46:32 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Sean Nyekjaer
 <sean@geanix.com>, David Lechner <dlechner@baylibre.com>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Andy Shevchenko
 <andy@kernel.org>
Subject: Re: [BUG] iio: imu: inv_icm42600: read temperature, Invalid
 Argument
Message-ID: <20250713144632.0cd2e88f@jic23-huawei>
In-Reply-To: <FR3P281MB1757E1352768510879500A3CCE4EA@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References: <unmlpvhl47vjdx7qqdaabhevhj3loydft4ytwxwsgefcyhbzup@zkqulwwfg37o>
	<FR3P281MB1757FE243D78E8F78DA6C576CE4FA@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
	<20250708113508.000027fb@huawei.com>
	<FR3P281MB1757E1352768510879500A3CCE4EA@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 8 Jul 2025 12:21:39 +0000
Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com> wrote:

> >
> >________________________________________
> >From:=C2=A0Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >Sent:=C2=A0Tuesday, July 8, 2025 12:35
> >To:=C2=A0Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
> >Cc:=C2=A0Sean Nyekjaer <sean@geanix.com>; Jonathan Cameron <jic23@kernel=
.org>; David Lechner <dlechner@baylibre.com>; linux-iio@vger.kernel.org <li=
nux-iio@vger.kernel.org>; Andy Shevchenko <andy@kernel.org>
> >Subject:=C2=A0Re: [BUG] iio: imu: inv_icm42600: read temperature, Invali=
d Argument
> >=C2=A0
> >This Message Is From an External Sender
> >This message came from outside your organization.
> >=C2=A0
> >On Mon, 7 Jul 2025 18:13:33 +0000
> >Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com> wrote:
> > =20
> >> >Hi,
> >> >
> >> >I'm having some weird issues with reading the temperature of the icm4=
2605.
> >> >Kernel version: 6.16.0-rc5
> >> >
> >> ># cat /sys/bus/iio/devices/iio:device2/name
> >> >icm42605-accel
> >> >
> >> >When reading the temperature I get:
> >> ># cat /sys/bus/iio/devices/iio:device2/in_temp_raw
> >> >cat: read error: Invalid argument
> >> >
> >> >But if I read from the accelerometer first, I will go better:
> >> ># cat /sys/bus/iio/devices/iio:device2/in_accel_x_raw
> >> >-378
> >> ># cat /sys/bus/iio/devices/iio:device2/in_temp_raw
> >> >600
> >> >
> >> >Then after "some" time, I re-read the temperature I recieve
> >> >"Invalid argument" again.
> >> >
> >> >I have traced the -EINVAL to inv_icm42600_temp_read() because I recei=
ve
> >> >INV_ICM42600_DATA_INVALID.
> >> >
> >> >Register dump diff:
> >> >--- invalid-read
> >> >+++ ok-read
> >> >@@ -10,14 +10,14 @@
> >> > 0x1a =3D 0x00000010
> >> > 0x1b =3D 0x00000000
> >> > 0x1c =3D 0x00000000
> >> >-0x1d =3D 0x00000080
> >> >-0x1e =3D 0x00000000
> >> >-0x1f =3D 0x00000080
> >> >-0x20 =3D 0x00000000
> >> >-0x21 =3D 0x00000080
> >> >-0x22 =3D 0x00000000
> >> >-0x23 =3D 0x00000080
> >> >-0x24 =3D 0x00000000
> >> >+0x1d =3D 0x00000002
> >> >+0x1e =3D 0x00000038
> >> >+0x1f =3D 0x000000fe
> >> >+0x20 =3D 0x00000085
> >> >+0x21 =3D 0x000000fe
> >> >+0x22 =3D 0x000000df
> >> >+0x23 =3D 0x000000f8
> >> >+0x24 =3D 0x0000003a
> >> > 0x25 =3D 0x00000080
> >> > 0x26 =3D 0x00000000
> >> > 0x27 =3D 0x00000080
> >> >@@ -26,7 +26,7 @@
> >> > 0x2a =3D 0x00000000
> >> > 0x2b =3D 0x00000000
> >> > 0x2c =3D 0x00000000
> >> >-0x2d =3D 0x00000000
> >> >+0x2d =3D 0x00000008
> >> > 0x2e =3D 0x00000000
> >> > 0x2f =3D 0x00000000
> >> > 0x30 =3D 0x000000ff
> >> >@@ -59,11 +59,11 @@
> >> > 0x4b =3D 0x00000000
> >> > 0x4c =3D 0x00000032
> >> > 0x4d =3D 0x00000099
> >> >-0x4e =3D 0x00000000
> >> >+0x4e =3D 0x00000002
> >> > 0x4f =3D 0x00000009
> >> > 0x50 =3D 0x00000009
> >> > 0x51 =3D 0x00000016
> >> >-0x52 =3D 0x00000000
> >> >+0x52 =3D 0x00000060
> >> > 0x53 =3D 0x0000000d
> >> > 0x54 =3D 0x00000031
> >> > 0x55 =3D 0x00000000
> >> >
> >> >Will the iio core retry a read? If the -EINVAL is returned,
> >> >inv_icm42600_accel_read_raw() is call once more.
> >> >
> >> >One more thing...
> >> >When I'm removing the module, the kernel prints this:
> >> >inv-icm42600-i2c 1-0068: Runtime PM usage count underflow!
> >> >
> >> >I will continue investigate this
> >> >Br,
> >> >Sean   =20
> >>=20
> >> Hello Sean,
> >>=20
> >> this is expected behavior since the temperature returned is not the ex=
ternal
> >> temperature but the temperature of the mechanical component (MEMS). It=
 will
> >> only work if the chip is on, meaning accelerometer and/or gyroscope is=
 on.
> >>=20
> >> That's why you can get temperature after reading accel data since it is
> >> turning the chip. But after a short while autosuspend is putting the c=
hip
> >> back off and you cannot read temperature anymore.
> >>=20
> >> You need to turn one sensor continuously on with a buffer, and then yo=
u can
> >> read temperature all the time since the chip is running.
> >>=20
> >> Temperature data are here only to do temperature compensation of the a=
ccel
> >> and gyro data. =20
> >
> >That is rather non-intuitive behavior.  Could we make a read of the temp=
erature
> >channel turn on one of the components?  Given expected use case it shoul=
dn't commonly
> >happen but if not too horrendous to implement it would be better to avoi=
d the error
> >seen here. =20
>=20
> Hello Jonathan,
>=20
> the problem here is which sensor to turn on? Accel or gyro, or accel+gyro?
> And the temperature reported will be completely different if it is accel
> and/or gyro running, since gyro is heating much more than accel.
>=20
> This is not a classical temperature sensor, but an internal one for measu=
ring
> temperature of the mechanical part while running. The usual use case on o=
ur
> side is polling the temperature at low frequency (10Hz, 20Hz) while accel
> and/or gyro are running to do temperature compensation on the data read.
>=20
> We generally want to avoid temperature data in the FIFO because reporting
> temperature at high frequency is not useful, and it is consuming space in
> the FIFO. We prefer to have more space in the FIFO for accel and gyro data
> and do polling of temperature.
>=20
> Temperature reporting while the chip is off makes absolutely no sense tha=
t's
> why it is not supported by the chip, even if it can be non-intuitive.
>=20
> Perhaps we can use another error returning code rather than invalid value?
> Otherwise, tell me what you think is the best to do.

Maybe indicate it is a temporary situation that userspace can resolve
by reporting -EBUSY?  I'm not sure what the best path forward here is.

Your explanation seems reasonable to me.  Sean, do you still believe
we need to make a change here?

Jonathan

>=20
> Thanks,
> JB
>=20
> >  =20
> >>=20
> >> Thanks,
> >> JB =20
> >
> > =20


