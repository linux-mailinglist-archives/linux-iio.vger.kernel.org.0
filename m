Return-Path: <linux-iio+bounces-7640-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6892932ECC
	for <lists+linux-iio@lfdr.de>; Tue, 16 Jul 2024 19:00:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F39AC1C2246B
	for <lists+linux-iio@lfdr.de>; Tue, 16 Jul 2024 17:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 134B319DF80;
	Tue, 16 Jul 2024 17:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h5c1hqR6"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF8012B7F;
	Tue, 16 Jul 2024 17:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721149212; cv=none; b=qEXIyEP5gBmNUdvSjzsZqgyv+CbyZR1erNX2Aw0PuLC8VQz4hmWcpVw2BkqtVVwu4UQw9Z/w91qvitqobA8Ca84olVV42FVgfhLW7cdKfu69JX5bGSRIoL+ufP9MCOHsuO4IcwFsPtveAaNmUZvT8QdfxvDeWjb3lw2oNntRmqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721149212; c=relaxed/simple;
	bh=sAD7lS47r/gd6n42i7U6IFrQNXMKogyHlRfzfc24w4g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q1v/2NVk2dr+xOan1eDa9uevDI32TzR8OJRzwCY/1E2wHZm0ZMYVzmn6ispxZkDhaeEo8B3gEk4ZMDoxBSlTpchEmPYPeCgL4OCPrrnHSzXKYDjdswAvIRhDZOSrH6PaGatiDQTiuc9xPGSKz41Fo0G8VS+i8CwX2sihpg6Lpa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h5c1hqR6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D80FDC116B1;
	Tue, 16 Jul 2024 17:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721149212;
	bh=sAD7lS47r/gd6n42i7U6IFrQNXMKogyHlRfzfc24w4g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=h5c1hqR6g1bDVxhbWkBLjJKujIOAQx98JN7UvHNTU+pyvpCARzraCWmPJtHsjhxXN
	 l8kh1c4vg92SFXiqQm1omrIxuqwzXLZ7qw0t8JshU7LUCLE/0IWQIOWf7FTDbEPUb4
	 P9Yb3fKakuWjwf0tcOfy6esRNNyo1WzIs71kDNNQVFzkkyiHekToJXFhy+JHGpLtZl
	 2px9phGNgMMNZisKUBbxRRagMlk8HUhYTTRKX/Ky9qAOE5rME3eJUflbyyQdGB2m5I
	 2F1NY0AEfdlRksv/PXece95F22gPAYeQM4j9dOnNL5W6zKpqlWhiLG86SAlA29Rxcg
	 tdYBOgDVOJSSA==
Date: Tue, 16 Jul 2024 18:00:04 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: <Marius.Cristea@microchip.com>
Cc: <matteomartelli3@gmail.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <robh@kernel.org>, <lars@metafoo.de>,
 <linux-kernel@vger.kernel.org>, <krzk+dt@kernel.org>,
 <Jonathan.Cameron@Huawei.com>, <conor+dt@kernel.org>
Subject: Re: [PATCH v2 2/2] iio: adc: add support for pac1921
Message-ID: <20240716180004.606006d0@jic23-huawei>
In-Reply-To: <483de34b3a74a2981fac89a8232e3ef2448f57ef.camel@microchip.com>
References: <20240704-iio-pac1921-v2-0-0deb95a48409@gmail.com>
	<20240704-iio-pac1921-v2-2-0deb95a48409@gmail.com>
	<20240707160442.6bab64c9@jic23-huawei>
	<668bec2a8b23a_6e037017@njaxe.notmuch>
	<20240708173439.000070b4@Huawei.com>
	<668cf2f3ece62_1f6ba37012@njaxe.notmuch>
	<20240713112153.3576fc2a@jic23-huawei>
	<66963b764ac3c_706370bd@njaxe.notmuch>
	<483de34b3a74a2981fac89a8232e3ef2448f57ef.camel@microchip.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 16 Jul 2024 11:19:53 +0000
<Marius.Cristea@microchip.com> wrote:

> Hi Matteo,
>=20
> On Tue, 2024-07-16 at 11:20 +0200, Matteo Martelli wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you
> > know the content is safe
> >=20
> > Jonathan Cameron wrote: =20
> > > On Tue, 09 Jul 2024 10:21:07 +0200
> > > Matteo Martelli <matteomartelli3@gmail.com> wrote:
> > >  =20
> > > > Jonathan Cameron wrote:
> > > > ... =20
> > > > > > I could add the shunt-resistor controls to allow calibration
> > > > > > as Marius
> > > > > > suggested, but that's also a custom ABI, what are your
> > > > > > thoughts on this? =20
> > > > >=20
> > > > > This would actually be a generalization of existing device
> > > > > specific ABI
> > > > > that has been through review in the past.
> > > > > See Documentation/ABI/testing/sysfs-bus-iio-adc-pac1934
> > > > > for example (similar in other places).
> > > > > So if you want to do this move that ABI up a level to cover
> > > > > multiple devices
> > > > > (removing the entries in specific files as you do so).
> > > > >  =20
> > > > I would do this in a separate commit, would you prefer it in this
> > > > same patch
> > > > set or in another separate patch? =20
> > >=20
> > > Separate commit in this series as otherwise it's not obvious why we
> > > are
> > > doing it. In theory should be before this patch as then what you
> > > use here
> > > is already documented, but I don't care that much on the order.
> > >  =20
> > Just a few more questions about this point.
> >=20
> > * I see 3 other drivers exposing the shunt resistor attribute:
> > ina2xx, max9611
> > and pac1934. While the unit for first two is in Ohms, for the latter
> > it's in
> > micro-Ohms. What should be the unit for the generalized ABI? I would
> > guess Ohms =20
>=20
> For measuring current the usual "scale" is part of miliOhms in order to
> reduce the power dissipation. As a rule of thumb 0.1 miliOhms is a
> usual value for shunt resistors. I think the "correct" way is to setup
> the  value in sub units of Ohms. Like the current is in miliAmps and
> the voltage is in miliVolts.

The milli thing is historical curiosity (we were trying to maintain
interface compatibility with hwmon briefly many years ago - it rapidly
proved impractical). For almost all remotely recent units we have
gone with the SI base unit.

This is an corner of ABI so if things were consistent I'd say copy
the others, but failing that ohms for the reason you give.
Copy the in_resistance_raw value


>=20
>=20
> > as /sys/bus/iio/devices/iio:deviceX/in_resistance_raw.
> >=20
> > * If for instance the generalized ABI unit is going to be Ohms,
> > should I still
> > remove the entry from the pac1934 even though it would not be fully
> > compliant
> > with the generalized ABI?
> >=20
> > * To cover the current exposed attributes, the "What" fields would
> > look like:
> > from max9611:
> > What:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /sys/.../iio:devi=
ceX/in_current_shunt_resistor
> > What:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /sys/.../iio:devi=
ceX/in_power_shunt_resistor
> > from ina2xx:
> > What:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /sys/.../iio:devi=
ceX/in_shunt_resistor
> > from pac1934:
> > What:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /sys/.../iio:devi=
ceX/in_shunt_resistorY

This one is a bit odd in that it describes it if it were a measurable
channel in of itself but we probably couldn't figure out a better way
to scope it to a specific channel.

> > Does this look correct? I think that for the first two drivers the
> > shunt_resistor can be considered as a channel info property, shared
> > by type for
> > max9611 case and shared by direction for ina2xx case (maybe better to
> > remove
> > "in_" from the What field if the type is not specified?).

Keep it consistent.  It's valid to provide the in_ and in general
over restrict channel attributes, even if not strictly necessary.

> > What seems odd to me is the pac1934 case, since it doesn't fit in the
> > format
> > <type>[Y_]shunt_resistor referred in many other attributes (where I
> > assume
> > <type> is actually [dir_][type_]?).
> > Doesn't it look like pac1934 is exposing additional input channels,
> > that are
> > also writeable? Maybe such case would more clear if the shunt
> > resistor would be
> > an info property of specific channels? For example:
> > in_currentY_shunt_resistor,
> > in_powerY_shunt_resistor and in_engergyY_shunt_resitor.



> >  =20
>=20
> I don't think it will be a good idea to duplicate the same information
> into multiple attributes like: in_currentY_shunt_resistor,
> in_powerY_shunt_resistor and in_engergyY_shunt_resitor.
>=20
> The pac1934 device could be viewed like 4 devices that have only one
> measurement hardware. Changing the shunt for a hardware channel will
> impact multiple software measurements for that particular channel.
Yup. You've=20
>=20
> For example "sampling_frequency" is only one property per device and
> not one property per channel.

Not necessarily.  If it varies per channel it is
in_voltageX_sampling_frequency etc
That is rare, but we have specific text to cover it in the ABI docs.

What:		/sys/bus/iio/devices/iio:deviceX/in_voltageX_sampling_frequency
What:		/sys/bus/iio/devices/iio:deviceX/in_powerY_sampling_frequency
What:		/sys/bus/iio/devices/iio:deviceX/in_currentZ_sampling_frequency
KernelVersion:	5.20
Contact:	linux-iio@vger.kernel.org
Description:
		Some devices have separate controls of sampling frequency for
		individual channels. If multiple channels are enabled in a scan,
		then the sampling_frequency of the scan may be computed from the
		per channel sampling frequencies.

>=20
> Also I'm not felling comfortable to remove the [dir_] from the name,
> because this value is dependent of the hardware and we can't have a
> "available" properties for it.
Removing the dir is unnecessary.  Just leave that in place.
Note we can't change existing ABI of drivers for this sort of thing
that wasn't standardized (as we can't argue they break ABI) so
they are stuck as they stand.

Unfortunately the most consistent path is probably to treat it as a
normal attribute, even if that generates a bunch of silly duplication
if there is more than one shunt_resistance.
I agree it's ugly but it's not the only case of this sort of duplication.
It happens for that sampling_frequency case in a few corners were there is
on channel that is sampled different from all the others.

So I think
in_powerY_shut_resistor and in_energyY_shunt_resistor is
most consistent with existing 'standard' ABI.

This is one where I didn't do a great job in review unfortunately
so the one with the index on the end got through.

I'm not hugely worried about this mess though as runtime shunt resistor
calibration is not that common.  If people want good measurements they
tend to build their circuit with good components / PCB tracks etc.

>=20
>=20
>=20
> > * I would go for a simple and generic description such as:
> > "The value of current sense resistor in Ohms." like it is in
> > Documentation/devicetree/bindings/hwmon/hwmon-common.yaml. Should it
> > include
> > any additional detail?
That sounds good.  It is permissible when generalizing ABI like this
to include any particular quirks of the ones you are generalizing.
I doubt there are any here though.

> >=20
> > * I am assuming the generalized API would have Date and KernelVersion
> > of
> > today even though the original attributes are older.
> >=20
> > * Should this ABI be inserted at any particular place of
> > Documentation/ABI/testing/sysfs-bus-iio or just appended at its end?
End is fine for this one.  We've never attempted to assign an order to that
file so grouping only occurs if there are related attributes and I don't
see this as closely related to much else.

Thanks,

Jonathan

> >=20
> > Thanks,
> > Matteo
> >  =20
>=20


