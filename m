Return-Path: <linux-iio+bounces-22137-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 859B1B15316
	for <lists+linux-iio@lfdr.de>; Tue, 29 Jul 2025 20:47:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D712D18888C2
	for <lists+linux-iio@lfdr.de>; Tue, 29 Jul 2025 18:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C835C237180;
	Tue, 29 Jul 2025 18:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hAKWEh6g"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4E62AE8D;
	Tue, 29 Jul 2025 18:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753814869; cv=none; b=Z69Kbg0TQpTPWUwJTnM7asCfna2072vW6R0wKNfso1DoOTuEoU8/0ldkAo0wzqYbDiRRnY55Tqinka8XXYt+kO00rnY99UeOivpIjpiqF29SupJyRNz+9uHDjQ0cWg/TANpY/vGUt9WsVCkQfWnL34zUUOG4ygYjEJ4wW0MvmeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753814869; c=relaxed/simple;
	bh=JghpAhHm1OQNRidbFV6VitScuVePnsf11Vnj7jlZXvw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cdtm+vOAyykuTWl2uWMMszRFPjqVxGrH71ol+7wASdmiY0WFE5OmizYloK61kjsSg1lfpqSnG1N4gQzlDnUL2pLYMfMHM/mldnrWfiH827qrVRis5Fnc/tRb7L9PxFbMwtSyj8WHijVOPb0F+SKNpzBUtQgX/QxzWVweox3vBuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hAKWEh6g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAB08C4CEEF;
	Tue, 29 Jul 2025 18:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753814869;
	bh=JghpAhHm1OQNRidbFV6VitScuVePnsf11Vnj7jlZXvw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hAKWEh6gVwizDL/2GNGxynqRRPfgD2An5GzMku1mB474X6+VRdaw/H7F8yxkJXTgC
	 vU/l8rlxOeHJi5yKH0cF5FZWnHevITLSRsBwu1TdlsNdFek/pqDFUTYX4ctDO3VwYi
	 0C6oTeCEelCrD/h+Jmi73HYXe75n+lzClEOxWXlDAekgrvboDDA81GC8MN1VGPY48M
	 emUeyPcIdt+ofdjf/PGs3daXo8bGBkTnwrhzNwInTkee8klfxkZFbzGVsccDvo2CdV
	 b1K85BQmjfMmSgVEDodQBptYgV0fgVwomATENBdLoyTPH5Ho6Of02BRwsvzWTp7rcn
	 PT8srhb0TCLVw==
Date: Tue, 29 Jul 2025 19:47:38 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Dixit Parmar <dixitparmar19@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: magnetometer: add support for Infineon TLV493D
 3D Magentic sensor
Message-ID: <20250729194738.52aa3268@jic23-huawei>
In-Reply-To: <aIg_SClXq0pO69iH@dixit>
References: <20250726-tlv493d-sensor-v6_16-rc5-v1-0-deac027e6f32@gmail.com>
	<20250726-tlv493d-sensor-v6_16-rc5-v1-1-deac027e6f32@gmail.com>
	<141967ee-22f4-4b15-a8da-e8cef25828b4@baylibre.com>
	<aIg_SClXq0pO69iH@dixit>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 29 Jul 2025 08:56:00 +0530
Dixit Parmar <dixitparmar19@gmail.com> wrote:

> On Sat, Jul 26, 2025 at 03:44:03PM -0500, David Lechner wrote:
> > On 7/26/25 4:37 AM, Dixit Parmar wrote: =20
> > > The Infineon TLV493D is a Low-Power 3D Magnetic Sensor. The Sensor
> > > applications includes joysticks, control elements (white goods,
> > > multifunction knops), or electric meters (anti tampering) and any
> > > other application that requires accurate angular measurements at
> > > low power consumptions.
> > >=20
> > > The Sensor is configured over I2C, and as part of Sensor measurement
> > > data it provides 3-Axis magnetic fields and temperature core measurem=
ent.
> > >=20
> > > The driver supports raw value read and buffered input via external tr=
igger
> > > to allow streaming values with the same sensing timestamp.
> > >=20
> > > The device can be configured in to different operating modes by optio=
nal
> > > device-tree "mode" property. Also, the temperature sensing part requi=
res
> > > raw offset captured at 25=C2=B0C and that can be specified by "temp-o=
ffset"
> > > optional device-tree property.
> > >=20
> > > While sensor has interrupt pin multiplexed with I2C SCL pin. But for =
bus
> > > configurations interrupt(INT) is not recommended, unless timing const=
raints
> > > between I2C data transfers and interrupt pulses are monitored and ali=
gned.
> > >=20
> > > The Sensor's I2C register map and mode information is described in pr=
oduct
> > > User Manual[1].
> > >=20
> > > Datasheet: https://www.infineon.com/assets/row/public/documents/24/49=
/infineon-tlv493d-a1b6-datasheet-en.pdf
> > > [1] https://www.mouser.com/pdfDocs/Infineon-TLV493D-A1B6_3DMagnetic-U=
serManual-v01_03-EN.pdf
> > >=20
> > > Signed-off-by: Dixit Parmar <dixitparmar19@gmail.com>

Picking out one question for a quick answer...
> > > +			return ret;
> > > +		}
> > > +		/* Return raw values for requested channel */
> > > +		switch (chan->address) {
> > > +		case AXIS_X:
> > > +			*val =3D x;
> > > +			return IIO_VAL_INT;
> > > +		case AXIS_Y:
> > > +			*val =3D y;
> > > +			return IIO_VAL_INT;
> > > +		case AXIS_Z:
> > > +			*val =3D z;
> > > +			return IIO_VAL_INT;
> > > +		case TEMPERATURE:
> > > +			*val =3D t;
> > > +			return IIO_VAL_INT;
> > > +		default:
> > > +			return -EINVAL;
> > > +		}
> > > +	case IIO_CHAN_INFO_SCALE:
> > > +		switch (chan->type) {
> > > +		case IIO_MAGN:
> > > +			/*
> > > +			 * Magnetic field scale: 0.0098 mTesla (i.e. 9.8 =C2=B5T)
> > > +			 * Expressed as fractional: 98/10 =3D 9.8 =C2=B5T.
> > > +			 */
> > > +			*val =3D 98;
> > > +			*val2 =3D 10; =20
> >=20
> > We use SI units, so this needs to be gauss, not tesela.
> >  =20
> Sure, Is there any documentation/reference this details are mentioned?

Documentation/ABI/testing/sysfs-bus-iio

https://elixir.bootlin.com/linux/v6.16/source/Documentation/ABI/testing/sys=
fs-bus-iio#L342
is the specific entry for magnetic fields.=20

Otherwise a small process thing - where you are agreeing with review
feedback, no need to put it in your reply.  Much better to just fix
it and have it in the change log for the next version.  That will let
you crop away much more of the thread, so we can focus in on questions.

Jonathan


