Return-Path: <linux-iio+bounces-7587-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED7A5930530
	for <lists+linux-iio@lfdr.de>; Sat, 13 Jul 2024 12:37:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86828283B45
	for <lists+linux-iio@lfdr.de>; Sat, 13 Jul 2024 10:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53FED54757;
	Sat, 13 Jul 2024 10:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TzwtEP3o"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083513BBE1;
	Sat, 13 Jul 2024 10:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720867014; cv=none; b=m583j3BS5a9Ehut5FzvkLx7o2frvEtH6I7WcAWyWTneEeyviwqjICViV++1zxbbvpbT+Rlk13d4tRXjrpZARQ0iwnoR8sZdmrRKYD+vzvNOMTqHSaXp0olBmUg/Qk3ZxKXUcvimsTzT8nDl0RT4gUM2PEsVYRm41zUSA/p5037U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720867014; c=relaxed/simple;
	bh=gN98ES3fF03D4wlGhI/C7LubmUn7fkJk0Jap9JMj3MA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HjtZdiKC/9E4IOrbf+2N2A7sA0ykK9A2x5qf9kpba5lgZQcBvQ9By5QGoMrXB7u+xLZhuaGumggYaGLX7hNwDk233RTz4wTketY8fJqWqS+LVlvOdJiVFmx7z1I47+f8UAvcbEY0O4BMs+kqJdQahzPzfdgyZGnNA0rvrFYfYrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TzwtEP3o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10F23C32781;
	Sat, 13 Jul 2024 10:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720867013;
	bh=gN98ES3fF03D4wlGhI/C7LubmUn7fkJk0Jap9JMj3MA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TzwtEP3o9pUnkpDmEJ9aKdduN3lofW70OPtCg9MmkyHMHMh1x0uvtpnWWfDrsp7pV
	 IT03Vwvd55zHJ7H5pbENBx72DfScLUS5bzflgnZ0tHH4eNdyet4ZosHdxovvycLP4M
	 pLquq2EMS53c2skax39hyxqmMEqwb/U5nycXgsS7be5/p375wmeomim05448dh6io/
	 SjpwepQhTu8BnF9Ddy1sn6OQz8fde4TWyhhjxnqSWZlRZ4/EzrF4QrlGni9RHAE0UK
	 dfnfy91dNCbgaqsLxNQAI9ItQuHVk+H9s2K3pghf8aBCxWZVWRt6QWKZJ1caVDETZF
	 TMx9JYNm2Aesg==
Date: Sat, 13 Jul 2024 11:36:44 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Marius.Cristea@microchip.com, matteomartelli3@gmail.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, lars@metafoo.de, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: adc: add support for pac1921
Message-ID: <20240713113644.464aa6d0@jic23-huawei>
In-Reply-To: <20240712-octopus-coerce-52c52e9cfb41@spud>
References: <20240704-iio-pac1921-v2-0-0deb95a48409@gmail.com>
	<20240704-iio-pac1921-v2-2-0deb95a48409@gmail.com>
	<20240707160442.6bab64c9@jic23-huawei>
	<668bec2a8b23a_6e037017@njaxe.notmuch>
	<88a54c736e0c39ead34dbde53c813526484d767d.camel@microchip.com>
	<668f84e2f3e10_2b423707a@njaxe.notmuch>
	<ea72561a1ab953d3f2a99272c24cf5124c0c72ec.camel@microchip.com>
	<20240712-octopus-coerce-52c52e9cfb41@spud>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 12 Jul 2024 18:02:54 +0100
Conor Dooley <conor@kernel.org> wrote:

> On Fri, Jul 12, 2024 at 02:41:51PM +0000, Marius.Cristea@microchip.com wr=
ote:
> > Hi Matteo,
> >=20
> >=20
> > On Thu, 2024-07-11 at 09:08 +0200, Matteo Martelli wrote: =20
> > > EXTERNAL EMAIL: Do not click links or open attachments unless you
> > > know the content is safe
> > >=20
> > > Hi Marius,
> > >=20
> > > Marius.Cristea@ wrote: =20
> > > > > I think that the OUT pin might not be used at all in many use
> > > > > cases
> > > > > so I would
> > > > > leave the OUT pin setting as fixed for now and maybe extend it in
> > > > > the
> > > > > future
> > > > > when more use cases arise. I am open to reconsider this though.
> > > > >  =20
> > > >=20
> > > > The OUT functionality could be set from the device tree. =20
> > >=20
> > > I think this should to be controlled during runtime since it's a
> > > configuration
> > > that changes the device operation mode and so also what measurements
> > > are
> > > exposed to the user. An additional DT property could be useful but I
> > > am not
> > > sure it would fit in the DT scope.
> > > Anyway I will leave this for future extensions.
> > >  =20
> >=20
> > I think there are 2 different things here. Setting the configuration at
> > startup by hard-coding things at probe time or taken those from device
> > tree (we can add multiple properties here, as long those properties are
> > documented into the dt-binding file) and the user controlled part at
> > runtime.
> > Because there is no standard interface to change the functionality, it
> > will be easy to startup from the device tree and let the user to do
> > some minor adjustments and not hardcode configuration.

There is a quirk here.  If out is wired to an ADC on the SoC for some reason
then indeed it should be runtime configurable.  If it's wired to some
types of analog circuitry or a separate thermal monitoring micro controller
then it 'might' belong in DT because that 'wiring' is not discoverable.
However, this usecase isn't one anyone has 'yet' asked for so for now
we have no reason to provide a binding for it.  Also if this wiring
is the case, we would probably not provide a userspace interface to control
the pin (smoke might be the result).

If it's wired to an ADC on the linux running SoC then this is definitely
a userspace control thing and we've lots of examples on how to do
that in tree.

> >=20
> >  =20
> > > ... =20
> > > > > > > ---
> > > > > > > =C2=A0.../ABI/testing/sysfs-bus-iio-adc-pac1921=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 45 +
> > > > > > > =C2=A0MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 7 +
> > > > > > > =C2=A0drivers/iio/adc/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 10 +
> > > > > > > =C2=A0drivers/iio/adc/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 1 +
> > > > > > > =C2=A0drivers/iio/adc/pac1921.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 1038
> > > > > > > ++++++++++++++++++++
> > > > > > > =C2=A05 files changed, 1101 insertions(+)
> > > > > > >=20
> > > > > > > diff --git a/Documentation/ABI/testing/sysfs-bus-iio-adc-
> > > > > > > pac1921
> > > > > > > b/Documentation/ABI/testing/sysfs-bus-iio-adc-pac1921
> > > > > > > new file mode 100644
> > > > > > > index 000000000000..4a32e2d4207b
> > > > > > > --- /dev/null
> > > > > > > +++ b/Documentation/ABI/testing/sysfs-bus-iio-adc-pac1921 =20
> > > > > > Quite a bit of custom ABI in here.
> > > > > >=20
> > > > > > Rule of thumb is that custom ABI is more or less pointless ABI
> > > > > > for
> > > > > > 99% of users
> > > > > > because standard userspace won't use it.=C2=A0 So keep that in =
mind
> > > > > > when
> > > > > > defining it.
> > > > > >  =20
> > > > > > > @@ -0,0 +1,45 @@
> > > > > > > +What:
> > > > > > > /sys/bus/iio/devices/iio:deviceX/resolution_bits
> > > > > > > +KernelVersion:=C2=A0=C2=A0=C2=A0=C2=A0 6.10
> > > > > > > +Contact:=C2=A0=C2=A0 linux-iio@vger.kernel.org
> > > > > > > +Description:
> > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 ADC measurement resolution. Can be either 11 bits
> > > > > > > or
> > > > > > > 14 bits
> > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 (default). The driver sets the same resolution
> > > > > > > for
> > > > > > > both VBUS and
> > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 VSENSE measurements even if the hardware could be
> > > > > > > configured to
> > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 measure VBUS and VSENSE with different
> > > > > > > resolutions.
> > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 This attribute affects the integration time: with
> > > > > > > 14
> > > > > > > bits
> > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 resolution the integration time is increased by a
> > > > > > > factor of
> > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 1.9 (the driver considers a factor of 2). See
> > > > > > > Table
> > > > > > > 4-5 in
> > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 device datasheet for details. =20
> > > > > >=20
> > > > > > Is the integration time ever high enough that it matters?
> > > > > > People tend not to do power measurement 'quickly'.
> > > > > >=20
> > > > > > If we are doing it quickly then you'll probably want to be
> > > > > > providing buffered
> > > > > > support and that does allow you to 'read' the resolution for a
> > > > > > part
> > > > > > where
> > > > > > it changes for some other reason.=C2=A0=C2=A0 I haven't yet und=
erstood
> > > > > > this
> > > > > > case. =20
> > > > >=20
> > > > > I will remove this control and fix the resolution bits to 14
> > > > > (highest
> > > > > value),
> > > > > same as the HW default. =20
> > > >=20
> > > > The resolution could be set from the device tree. As default it
> > > > could
> > > > be 14 bits like into the hardware. The user could add
> > > > "microchip,low_resolution_voltage" into the device tree in order to
> > > > use
> > > > only 11 bits for voltage samples. =20
> > >=20
> > > I think this should be controlled during runtime since it does not
> > > depend on
> > > the HW design but more on the user preferences about measurements
> > > precision.
> > > As Jonathan pointed out, since custom ABIs should be avoided when
> > > possible, I
> > > will leave it out from now until it becomes necessary and fix the
> > > resolution to
> > > 14 bits, as the HW default.
> > >  =20
> >=20
> > Set the configuration from the device tree, will avoid custom ABI. The
> > device tree could be changed also at runtime. =20
>=20
> Custom ABI in devicetree is not a replacement for custom ABI in userspace.
> If things are fixed by the hardware and non-discoverable, then sure add
> devicetree properties - but if it is things like "the user wants 11-bit
> mode", then that does not sound suitable for a devicetree property at
> all.

Indeed, resolution doesn't belong in device tree as it has nothing to do
with physical wiring, but is a policy control.  I have no problem with
providing a userspace ABI, but so far I've not heard a usecase for
enabling it at all on this device.  Who runs power measurement that
needs to be a little bit faster than can be done with 14bit all the time?

We have only done resolution control on devices where that resolution is re=
ally
changing as a result of some other factor (oversampling ratio or similar)
so it's been a read only aspect of the ABI.

Note we've been round this resolution question many times and so far
the number of actual usecases that have materialised is very very small.

Jonathan


> And no, you can't just change the devicetree at runtime like that either
> as far as I understand - that's gonna cause memory leaks etc and I don't
> think can be done from userspace without out-of-tree patches anyway.
>=20
> Cheers,
> Conor.
>=20
> >  =20
> > > ... =20
> > > > > > > +What:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0
> > > > > > > /sys/bus/iio/devices/iio:devices/filters_en
> > > > > > > +KernelVersion:=C2=A0=C2=A0=C2=A0=C2=A0 6.10
> > > > > > > +Contact:=C2=A0=C2=A0 linux-iio@vger.kernel.org
> > > > > > > +Description:
> > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 Attribute to enable/disable ADC post filters.
> > > > > > > Enabled
> > > > > > > by
> > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 default.
> > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 This attribute affects the integration time: with
> > > > > > > filters
> > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 enabled the integration time is increased by 50%.
> > > > > > > See
> > > > > > > Table 4-5
> > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 in device datasheet for details. =20
> > > > > >=20
> > > > > > Do we have any idea what this filter is? Datasheet seems very
> > > > > > vague
> > > > > > indeed and from
> > > > > > a control point of view that makes this largely useless. How
> > > > > > does
> > > > > > userspace know
> > > > > > whether to turn it on?
> > > > > >=20
> > > > > > We have an existing filter ABI but with so little information
> > > > > > no
> > > > > > way to fit this in.
> > > > > > Gut feeling, leave it on all the time and drop the control
> > > > > > interface. =20
> > > > >=20
> > > > > I will remove this control and leave it on all the time as the HW
> > > > > default.
> > > > >  =20
> > > >=20
> > > > The filters could be enabled from the device tree. As default it
> > > > could
> > > > be disabled.
> > > > As a small detail here this is a post processing digital filter
> > > > that
> > > > could be enabled/disabled inside the PAC module.
> > > >  =20
> > >=20
> > > Same reasoning of the resolution_bits parameter applies here. I will
> > > fix the
> > > filters to enabled, as the HW default. If there is any particular
> > > reason to
> > > prefer the filters fixed as disabled I will change that.
> > >  =20
> > If the user can change the on/off for the filters it doesn't matter
> > what will be the default behavior. Being a single channel device, the
> > probability for the user to change the filter behavior during runtime
> > is minimal, that was the main reason for letting the user to change the
> > configuration from the device tree and not hardcode it.
> >  =20
> > > ... =20
> > > > Thanks,
> > > > Marius =20
> > >=20
> > > Thanks,
> > > Matteo =20
> >=20
> > Thanks,
> > Marius =20


