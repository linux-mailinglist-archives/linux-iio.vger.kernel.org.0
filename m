Return-Path: <linux-iio+bounces-7720-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 679EE938087
	for <lists+linux-iio@lfdr.de>; Sat, 20 Jul 2024 11:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DEFEB21459
	for <lists+linux-iio@lfdr.de>; Sat, 20 Jul 2024 09:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90606770EA;
	Sat, 20 Jul 2024 09:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HqpdbsPZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0AF29A2;
	Sat, 20 Jul 2024 09:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721468899; cv=none; b=E6W+VzOvcDgtXXud6PlasKu1BB0u8pWcX4ZaA+NR6VrdpVc8D7GYpnN0ekkYYbqfCfZeqwWUQTKvXub/5muOy+FzjnQ9xLOk/GgFzB2LppiJtlu0Jqw84Zh8Pp7+eJv1n5x1bq8SiVj22MLDwjwSeUhOecpcjpIvX6Y21li0UbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721468899; c=relaxed/simple;
	bh=4IKGPDVuFgKuZVzXlHbzBkSmBTT6vlW1VYxodSF1Ewg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L2NtWITqaZ8K61YxzTFjqjQoZ2eeCQbSiywDa/A25l4aTSwp/2OjzN3zHwYavcPCzJ0qKO4Ng6kw3KCv/+m3uQeV3Z9WJ/c1n0gMYHYx0iB0eLtW/+puk7Gqp+jXh8kLs10br2SsAAVPhpL8Wv/TUDNmu/kvpU19un4tPhNfNCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HqpdbsPZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A9C5C2BD10;
	Sat, 20 Jul 2024 09:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721468898;
	bh=4IKGPDVuFgKuZVzXlHbzBkSmBTT6vlW1VYxodSF1Ewg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HqpdbsPZdEN7Ru8PbvORVTYX/XbkUSJarMsG8mNokq6BouS0kCf7XQvfr8KsRRVRz
	 yzBo6W9Ep43AmDWnawKfc12tBDSWlF7z7fd24DjD7Kx2ae84EaRfZbi536CZ9pdvwm
	 rZATTzqHM4JiNueGfv8JpN1yTLKWiqG9mP/j38sXUJbNjMtB3WjOUU1voTfdGcqEzo
	 9xZdC+wlspEz/KsEI0rHpcp9tAniq5sCYSRRVKdy+ED4UXQruMC+c38JSiZi99RbCY
	 ns1mvlWZV5qSK88FkJ3X16PtE1x/6wkZxAMrCEKuOmIv9qBXq6UPnXmD6UJVxiD9z0
	 8xsK6Ir+/az8A==
Date: Sat, 20 Jul 2024 10:48:12 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Matteo Martelli <matteomartelli3@gmail.com>
Cc: Marius.Cristea@microchip.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, robh@kernel.org, lars@metafoo.de,
 linux-kernel@vger.kernel.org, krzk+dt@kernel.org,
 Jonathan.Cameron@Huawei.com, conor+dt@kernel.org
Subject: Re: [PATCH v2 2/2] iio: adc: add support for pac1921
Message-ID: <20240720104812.5d59e91a@jic23-huawei>
In-Reply-To: <6697d3b0d33f6_1fc333707f@njaxe.notmuch>
References: <20240704-iio-pac1921-v2-0-0deb95a48409@gmail.com>
	<20240704-iio-pac1921-v2-2-0deb95a48409@gmail.com>
	<20240707160442.6bab64c9@jic23-huawei>
	<668bec2a8b23a_6e037017@njaxe.notmuch>
	<20240708173439.000070b4@Huawei.com>
	<668cf2f3ece62_1f6ba37012@njaxe.notmuch>
	<20240713112153.3576fc2a@jic23-huawei>
	<66963b764ac3c_706370bd@njaxe.notmuch>
	<483de34b3a74a2981fac89a8232e3ef2448f57ef.camel@microchip.com>
	<20240716180004.606006d0@jic23-huawei>
	<6697d3b0d33f6_1fc333707f@njaxe.notmuch>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 17 Jul 2024 16:22:40 +0200
Matteo Martelli <matteomartelli3@gmail.com> wrote:

> Jonathan Cameron wrote:

Oddly I thought I'd replied to this already but my email client says not...
I guess maybe I have a stray draft on another computer. Anyhow, let's
try again!

> > > >=20
> > > > * If for instance the generalized ABI unit is going to be Ohms,
> > > > should I still
> > > > remove the entry from the pac1934 even though it would not be fully
> > > > compliant
> > > > with the generalized ABI?
> > > >=20
> > > > * To cover the current exposed attributes, the "What" fields would
> > > > look like:
> > > > from max9611:
> > > > What:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /sys/.../iio:=
deviceX/in_current_shunt_resistor
> > > > What:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /sys/.../iio:=
deviceX/in_power_shunt_resistor
> > > > from ina2xx:
> > > > What:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /sys/.../iio:=
deviceX/in_shunt_resistor
> > > > from pac1934:
> > > > What:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /sys/.../iio:=
deviceX/in_shunt_resistorY =20
> >=20
> > This one is a bit odd in that it describes it if it were a measurable
> > channel in of itself but we probably couldn't figure out a better way
> > to scope it to a specific channel.
> >  =20
> > > > Does this look correct? I think that for the first two drivers the
> > > > shunt_resistor can be considered as a channel info property, shared
> > > > by type for
> > > > max9611 case and shared by direction for ina2xx case (maybe better =
to
> > > > remove
> > > > "in_" from the What field if the type is not specified?). =20
> >=20
> > Keep it consistent.  It's valid to provide the in_ and in general
> > over restrict channel attributes, even if not strictly necessary.
> >  =20
> > > > What seems odd to me is the pac1934 case, since it doesn't fit in t=
he
> > > > format
> > > > <type>[Y_]shunt_resistor referred in many other attributes (where I
> > > > assume
> > > > <type> is actually [dir_][type_]?).
> > > > Doesn't it look like pac1934 is exposing additional input channels,
> > > > that are
> > > > also writeable? Maybe such case would more clear if the shunt
> > > > resistor would be
> > > > an info property of specific channels? For example:
> > > > in_currentY_shunt_resistor,
> > > > in_powerY_shunt_resistor and in_engergyY_shunt_resitor. =20
> >  =20
> > > >    =20
> > >=20
> > > I don't think it will be a good idea to duplicate the same information
> > > into multiple attributes like: in_currentY_shunt_resistor,
> > > in_powerY_shunt_resistor and in_engergyY_shunt_resitor.
> > >=20
> > > The pac1934 device could be viewed like 4 devices that have only one
> > > measurement hardware. Changing the shunt for a hardware channel will
> > > impact multiple software measurements for that particular channel. =20
> > Yup. You've  =20
>=20
> Sorry Jonathan, is there anything missing in this sentence? Looks like
> unintentionally truncated: You've ...

Bad editing of my reply!. Ignore that.

>=20
> > >=20
> > > For example "sampling_frequency" is only one property per device and
> > > not one property per channel. =20
> >=20
> > Not necessarily.  If it varies per channel it is
> > in_voltageX_sampling_frequency etc
> > That is rare, but we have specific text to cover it in the ABI docs.
> >=20
> > What:		/sys/bus/iio/devices/iio:deviceX/in_voltageX_sampling_frequency
> > What:		/sys/bus/iio/devices/iio:deviceX/in_powerY_sampling_frequency
> > What:		/sys/bus/iio/devices/iio:deviceX/in_currentZ_sampling_frequency
> > KernelVersion:	5.20
> > Contact:	linux-iio@vger.kernel.org
> > Description:
> > 		Some devices have separate controls of sampling frequency for
> > 		individual channels. If multiple channels are enabled in a scan,
> > 		then the sampling_frequency of the scan may be computed from the
> > 		per channel sampling frequencies.
> >  =20
> > >=20
> > > Also I'm not felling comfortable to remove the [dir_] from the name,
> > > because this value is dependent of the hardware and we can't have a
> > > "available" properties for it. =20
> > Removing the dir is unnecessary.  Just leave that in place.
> > Note we can't change existing ABI of drivers for this sort of thing
> > that wasn't standardized (as we can't argue they break ABI) so
> > they are stuck as they stand.
> >=20
> > Unfortunately the most consistent path is probably to treat it as a
> > normal attribute, even if that generates a bunch of silly duplication
> > if there is more than one shunt_resistance.
> > I agree it's ugly but it's not the only case of this sort of duplicatio=
n.
> > It happens for that sampling_frequency case in a few corners were there=
 is
> > on channel that is sampled different from all the others.
> >=20
> > So I think
> > in_powerY_shut_resistor and in_energyY_shunt_resistor is
> > most consistent with existing 'standard' ABI.
> >=20
> > This is one where I didn't do a great job in review unfortunately
> > so the one with the index on the end got through.
> >=20
> > I'm not hugely worried about this mess though as runtime shunt resistor
> > calibration is not that common.  If people want good measurements they
> > tend to build their circuit with good components / PCB tracks etc.
> >  =20
>=20
> From your comments I get that in_shunt_resistorY should be added in the
> generalized ABI (as in the example above) since it is already used and ca=
n't be
> changed. Is this correct?
No. for the one that isn't compliant with our generalization, just leave
it where it is in a per device doc.

>=20
> I am still not sure whether in_currentY_shunt_resistor,
> in_powerY_shunt_resistor and in_energyY_shunt_resistor, should be added o=
r not
> until a new driver using it comes through.

Ah. I wasn't paying attention to what was needed here. If you don't need th=
em
then no need to define them.

>=20
> Regarding pac1921, would it be more clear to expose a single in_shunt_res=
istor
> (keeping [dir_] for consistency as you suggested) as it is for ina2xx or
> in_current_shunt_resistor plus in_power_shunt_resistor as it is for max96=
11? I
> agree that just exposing it once would be more clear for the user, so I w=
ould
> go for the first case but maybe I am missing something.
It's an interesting question.  Is it obvious enough that the shut resistor
affects both current and power measurements?

I think it is and in general shunt resistor tuning is fairly uncommon
thing so just in_current_shunt_resistor sounds fine to me.

Jonathan

>=20
> >=20
> > Thanks,
> >=20
> > Jonathan
> >  =20
>=20
> Thanks,
> Matteo

