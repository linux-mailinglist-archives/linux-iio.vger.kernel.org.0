Return-Path: <linux-iio+bounces-21631-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B318B035BF
	for <lists+linux-iio@lfdr.de>; Mon, 14 Jul 2025 07:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0D131890BCD
	for <lists+linux-iio@lfdr.de>; Mon, 14 Jul 2025 05:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B25601F873E;
	Mon, 14 Jul 2025 05:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="tu7FzS8Z"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-24421.protonmail.ch (mail-24421.protonmail.ch [109.224.244.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB43B1DE2A5
	for <linux-iio@vger.kernel.org>; Mon, 14 Jul 2025 05:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752470954; cv=none; b=HT7+yCE7re42YbOChzuOnN7F4QlvRqzZEo5I4aW2JO0pl9mCq36btmYxuNBjavKCYAWKS3y9siuo60Nji/Wt0N6rAxzjWgwE6jgRGRbwFFIahPFVRanDZMk/xsFltHBIJfouZ8I/JOn4q7NWaaHCd9cMtsh5rDGJpnDaNIp3bCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752470954; c=relaxed/simple;
	bh=mSnCeloYHS68JOH5vVeOnQ84bGI4KJoaCMuCwtQpfqQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qXxCV352l69b6W6OT6m20lINwZAm5U1W4lZ87jjzTAo9RuMmrueBoxUquhVewNxH7u35dFdiBkeDo8JPJzf3JzT8ioclxHYXzjGyb/GEmqYsG3HFML7kTdsC0mhKrdaC9LbtYgxDuLPCHgV21myP2iMnc4Qavl1I+c9NkvsyQhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=tu7FzS8Z; arc=none smtp.client-ip=109.224.244.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1752470947; x=1752730147;
	bh=XRybO7aiXs2ERiQfc4O9ldG8Am2UZL9/iHzNZbKyUgY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=tu7FzS8Z5w05MQ6ffY4zTZ7JG/5XqEhnBlHkoWHYTMSI7uMwnci5ilE60Urs91sMi
	 CNPfPd2PEHlDQ5dodCzUL5L4tcI9x5ymd9V74dbbCFiXVZZwgB+2pNOX08kjkztb3F
	 lbrZKaRfsHjwfLjHoSwQFLnsVxZFCMBi0IDdwiKlZQhb6btVstlKFoBBiEYMZFVVsP
	 jwhtyRn2Htf9yt1IYwGFhmQMq3kqLNmrfEQUVOB+ltSQTG5nWAVWzyR4gSQhy8x3/c
	 Xuiu/OMmNJeVnhKwb9pIftY67lRxa0j9RKWraYXczmyVv52XTJZeWBOpynLo8Rpxxf
	 DGlkCpasz2Xxw==
Date: Mon, 14 Jul 2025 05:29:00 +0000
To: Jonathan Cameron <jic23@kernel.org>
From: Sean Nyekjaer <sean@geanix.com>
Cc: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, David Lechner <dlechner@baylibre.com>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [BUG] iio: imu: inv_icm42600: read temperature, Invalid Argument
Message-ID: <w5ury5pubvk5iavcnu5yc44mp5lplsrvxyet4vwliv3mu3m5y4@sbfiyiy3loov>
In-Reply-To: <20250713144632.0cd2e88f@jic23-huawei>
References: <unmlpvhl47vjdx7qqdaabhevhj3loydft4ytwxwsgefcyhbzup@zkqulwwfg37o> <FR3P281MB1757FE243D78E8F78DA6C576CE4FA@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM> <20250708113508.000027fb@huawei.com> <FR3P281MB1757E1352768510879500A3CCE4EA@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM> <20250713144632.0cd2e88f@jic23-huawei>
Feedback-ID: 134068486:user:proton
X-Pm-Message-ID: 678549ea66b23336420eaccaa4ee1edec2a59aa4
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 13, 2025 at 02:46:32PM +0100, Jonathan Cameron wrote:
> On Tue, 8 Jul 2025 12:21:39 +0000
> Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com> wrote:
>=20
> > >
> > >________________________________________
> > >From:=C2=A0Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > >Sent:=C2=A0Tuesday, July 8, 2025 12:35
> > >To:=C2=A0Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
> > >Cc:=C2=A0Sean Nyekjaer <sean@geanix.com>; Jonathan Cameron <jic23@kern=
el.org>; David Lechner <dlechner@baylibre.com>; linux-iio@vger.kernel.org <=
linux-iio@vger.kernel.org>; Andy Shevchenko <andy@kernel.org>
> > >Subject:=C2=A0Re: [BUG] iio: imu: inv_icm42600: read temperature, Inva=
lid Argument
> > >=C2=A0
> > >This Message Is From an External Sender
> > >This message came from outside your organization.
> > >=C2=A0
> > >On Mon, 7 Jul 2025 18:13:33 +0000
> > >Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com> wrote:
> > >
> > >> >Hi,
> > >> >
> > >> >I'm having some weird issues with reading the temperature of the ic=
m42605.
> > >> >Kernel version: 6.16.0-rc5
> > >> >
> > >> ># cat /sys/bus/iio/devices/iio:device2/name
> > >> >icm42605-accel
> > >> >
> > >> >When reading the temperature I get:
> > >> ># cat /sys/bus/iio/devices/iio:device2/in_temp_raw
> > >> >cat: read error: Invalid argument
> > >> >
> > >> >But if I read from the accelerometer first, I will go better:
> > >> ># cat /sys/bus/iio/devices/iio:device2/in_accel_x_raw
> > >> >-378
> > >> ># cat /sys/bus/iio/devices/iio:device2/in_temp_raw
> > >> >600
> > >> >
> > >> >Then after "some" time, I re-read the temperature I recieve
> > >> >"Invalid argument" again.
> > >> >
> > >> >I have traced the -EINVAL to inv_icm42600_temp_read() because I rec=
eive
> > >> >INV_ICM42600_DATA_INVALID.
> > >> >
> > >> >Register dump diff:
> > >> >--- invalid-read
> > >> >+++ ok-read
> > >> >@@ -10,14 +10,14 @@
> > >> > 0x1a =3D 0x00000010
> > >> > 0x1b =3D 0x00000000
> > >> > 0x1c =3D 0x00000000
> > >> >-0x1d =3D 0x00000080
> > >> >-0x1e =3D 0x00000000
> > >> >-0x1f =3D 0x00000080
> > >> >-0x20 =3D 0x00000000
> > >> >-0x21 =3D 0x00000080
> > >> >-0x22 =3D 0x00000000
> > >> >-0x23 =3D 0x00000080
> > >> >-0x24 =3D 0x00000000
> > >> >+0x1d =3D 0x00000002
> > >> >+0x1e =3D 0x00000038
> > >> >+0x1f =3D 0x000000fe
> > >> >+0x20 =3D 0x00000085
> > >> >+0x21 =3D 0x000000fe
> > >> >+0x22 =3D 0x000000df
> > >> >+0x23 =3D 0x000000f8
> > >> >+0x24 =3D 0x0000003a
> > >> > 0x25 =3D 0x00000080
> > >> > 0x26 =3D 0x00000000
> > >> > 0x27 =3D 0x00000080
> > >> >@@ -26,7 +26,7 @@
> > >> > 0x2a =3D 0x00000000
> > >> > 0x2b =3D 0x00000000
> > >> > 0x2c =3D 0x00000000
> > >> >-0x2d =3D 0x00000000
> > >> >+0x2d =3D 0x00000008
> > >> > 0x2e =3D 0x00000000
> > >> > 0x2f =3D 0x00000000
> > >> > 0x30 =3D 0x000000ff
> > >> >@@ -59,11 +59,11 @@
> > >> > 0x4b =3D 0x00000000
> > >> > 0x4c =3D 0x00000032
> > >> > 0x4d =3D 0x00000099
> > >> >-0x4e =3D 0x00000000
> > >> >+0x4e =3D 0x00000002
> > >> > 0x4f =3D 0x00000009
> > >> > 0x50 =3D 0x00000009
> > >> > 0x51 =3D 0x00000016
> > >> >-0x52 =3D 0x00000000
> > >> >+0x52 =3D 0x00000060
> > >> > 0x53 =3D 0x0000000d
> > >> > 0x54 =3D 0x00000031
> > >> > 0x55 =3D 0x00000000
> > >> >
> > >> >Will the iio core retry a read? If the -EINVAL is returned,
> > >> >inv_icm42600_accel_read_raw() is call once more.
> > >> >
> > >> >One more thing...
> > >> >When I'm removing the module, the kernel prints this:
> > >> >inv-icm42600-i2c 1-0068: Runtime PM usage count underflow!
> > >> >
> > >> >I will continue investigate this
> > >> >Br,
> > >> >Sean
> > >>
> > >> Hello Sean,
> > >>
> > >> this is expected behavior since the temperature returned is not the =
external
> > >> temperature but the temperature of the mechanical component (MEMS). =
It will
> > >> only work if the chip is on, meaning accelerometer and/or gyroscope =
is on.
> > >>
> > >> That's why you can get temperature after reading accel data since it=
 is
> > >> turning the chip. But after a short while autosuspend is putting the=
 chip
> > >> back off and you cannot read temperature anymore.
> > >>
> > >> You need to turn one sensor continuously on with a buffer, and then =
you can
> > >> read temperature all the time since the chip is running.
> > >>
> > >> Temperature data are here only to do temperature compensation of the=
 accel
> > >> and gyro data.
> > >
> > >That is rather non-intuitive behavior.  Could we make a read of the te=
mperature
> > >channel turn on one of the components?  Given expected use case it sho=
uldn't commonly
> > >happen but if not too horrendous to implement it would be better to av=
oid the error
> > >seen here.
> >
> > Hello Jonathan,
> >
> > the problem here is which sensor to turn on? Accel or gyro, or accel+gy=
ro?
> > And the temperature reported will be completely different if it is acce=
l
> > and/or gyro running, since gyro is heating much more than accel.
> >
> > This is not a classical temperature sensor, but an internal one for mea=
suring
> > temperature of the mechanical part while running. The usual use case on=
 our
> > side is polling the temperature at low frequency (10Hz, 20Hz) while acc=
el
> > and/or gyro are running to do temperature compensation on the data read=
.
> >
> > We generally want to avoid temperature data in the FIFO because reporti=
ng
> > temperature at high frequency is not useful, and it is consuming space =
in
> > the FIFO. We prefer to have more space in the FIFO for accel and gyro d=
ata
> > and do polling of temperature.
> >
> > Temperature reporting while the chip is off makes absolutely no sense t=
hat's
> > why it is not supported by the chip, even if it can be non-intuitive.
> >
> > Perhaps we can use another error returning code rather than invalid val=
ue?
> > Otherwise, tell me what you think is the best to do.
>=20
> Maybe indicate it is a temporary situation that userspace can resolve
> by reporting -EBUSY?  I'm not sure what the best path forward here is.
>=20
> Your explanation seems reasonable to me.  Sean, do you still believe
> we need to make a change here?

I think -EBUSY would be better, returning -EINVAL required me to read the d=
river,
and apply some debug printk's to see where it originated from.

Returning -EBUSY and add a comment about the "issue" in
inv_icm42600_temp_read(), would be a help.

/Sean

>=20
> Jonathan
>=20
> >
> > Thanks,
> > JB
> >
> > >
> > >>
> > >> Thanks,
> > >> JB
> > >
> > >
>=20


