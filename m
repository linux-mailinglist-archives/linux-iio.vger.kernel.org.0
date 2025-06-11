Return-Path: <linux-iio+bounces-20451-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD3DCAD5B8A
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 18:13:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE98C3A5EAE
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 16:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD411E47BA;
	Wed, 11 Jun 2025 16:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EG1JcfRq"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5401DF73C;
	Wed, 11 Jun 2025 16:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749658370; cv=none; b=Q7S1YYHibA8vGMh9nA+ul911wYb9h64OZZv2EyVKhGqsRpvG4+OXUDkY7JfMQ+r7hnjj+qSnBRV15DWsuowsQ8/WFiieqgHl+jfWVe99thJHgVKwcbIY69bLun7Cx8oOld/CiaSnCw785M7Ega6eCHHjpOxetf3KRteVbDfBC18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749658370; c=relaxed/simple;
	bh=c7580VFEVaIrkP10tSaLkEKRkoibaOLPCDVANW0F3Lc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FhyuVUgq3CpOn0G9N3A7/2ReZkJNaRvpD2K4ZirIcPXZ3dJ4iQvpoHJ5s85pkGWH6BlyEQPOeR77TXSRvltHC0tdgqSVgIPwavxqxLLKDnXfIddOqJYPRtWOl/W1KYJflLFogZzg1XGOg/WGE8+BIUkPPyaTiws6SAja69KKxic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EG1JcfRq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54D37C4CEE3;
	Wed, 11 Jun 2025 16:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749658369;
	bh=c7580VFEVaIrkP10tSaLkEKRkoibaOLPCDVANW0F3Lc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EG1JcfRq6q3wNE33n9fOaw3EvH1Uu1AIiDQYfIYb4zbz21O5nbckx6gtToYpYtUbp
	 7FRwdg4JXS2UExrtTAtRNHW+ZRHBeci9PcNZP6sjepoJp3/gkOKufpcoCyA0aHbcbI
	 uRs4RoH22od68UFbItKBsnIuVA6Ed28gbH4fXIXUrDn2qMYVLDpmLDXcJbIqVy59cu
	 KbZYEr9KqZmX/FDjcqGrCWEL3LAVrIpdk2sYa1O7vDOj6m/H9+T+FFeZJW/9/8SAU0
	 eNJlY4Z0qIU6xJwQW3lgB/Cy5x0FvpFkNJNaPvl0jMaSaPeQDt5AlzIyJGuq24BjlU
	 aLglAsW8xa7dg==
Date: Wed, 11 Jun 2025 17:12:41 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: <Marius.Cristea@microchip.com>
Cc: <dlechner@baylibre.com>, <nuno.sa@analog.com>, <broonie@kernel.org>,
 <linux-iio@vger.kernel.org>, <robh@kernel.org>,
 <linux-kernel@vger.kernel.org>, <andy@kernel.org>, <krzk+dt@kernel.org>,
 <conor+dt@kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] iio: adc: adding support for PAC194X
Message-ID: <20250611171241.2c5c9319@jic23-huawei>
In-Reply-To: <a2d9c24e2f72378d445b40d24bd808f29b87d122.camel@microchip.com>
References: <20250606093929.100118-1-marius.cristea@microchip.com>
	<20250606093929.100118-3-marius.cristea@microchip.com>
	<20250607162721.0142ba42@jic23-huawei>
	<a2d9c24e2f72378d445b40d24bd808f29b87d122.camel@microchip.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 10 Jun 2025 15:58:13 +0000
<Marius.Cristea@microchip.com> wrote:

> On Sat, 2025-06-07 at 16:27 +0100, Jonathan Cameron wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you
> > know the content is safe
> >=20
> > On Fri, 6 Jun 2025 12:39:29 +0300
> > <marius.cristea@microchip.com> wrote:
> >  =20
> > > From: Marius Cristea <marius.cristea@microchip.com>
> > >=20
> > > This is the iio driver for Microchip PAC194X and PAC195X series of
> > > Power Monitors with Accumulator. The PAC194X family supports 9V
> > > Full-Scale Range and the PAC195X supports 32V Full-Scale Range.
> > >=20
> > > There are two versions of the PAC194X/5X: the PAC194X/5X-1 devices
> > > are for high-side current sensing and the PAC194X/5X-2 devices are
> > > for low-side current sensing or floating VBUS applications. The
> > > PAC194X/5X-1 is named shortly PAC194X/5X.
> > >=20
> > > Signed-off-by: Marius Cristea <marius.cristea@microchip.com> =20
> > Hi Marius,
> >=20
> > I entirely agree with David on this wanting splitting up into
> > a base driver + patches that add features to that in order to
> > make it easier to review.=C2=A0 That also potentially allows me to pick=
 up
> > the basic support whilst any more controversial parts are still under
> > discussion.
> >=20
> > Jonathan =20
>=20
> I will try to make it smaller and build on that.
>=20
> >  =20
> > > diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> > > index 09ae6edb2650..ee47d880babf 100644
> > > --- a/drivers/iio/adc/Makefile
> > > +++ b/drivers/iio/adc/Makefile
> > > @@ -103,6 +103,7 @@ obj-$(CONFIG_NCT7201) +=3D nct7201.o
> > > =C2=A0obj-$(CONFIG_NPCM_ADC) +=3D npcm_adc.o
> > > =C2=A0obj-$(CONFIG_PAC1921) +=3D pac1921.o
> > > =C2=A0obj-$(CONFIG_PAC1934) +=3D pac1934.o
> > > +obj-$(CONFIG_PAC1944) +=3D pac1944.o
> > > =C2=A0obj-$(CONFIG_PALMAS_GPADC) +=3D palmas_gpadc.o
> > > =C2=A0obj-$(CONFIG_QCOM_PM8XXX_XOADC) +=3D qcom-pm8xxx-xoadc.o
> > > =C2=A0obj-$(CONFIG_QCOM_SPMI_ADC5) +=3D qcom-spmi-adc5.o
> > > diff --git a/drivers/iio/adc/pac1944.c b/drivers/iio/adc/pac1944.c
> > > new file mode 100644
> > > index 000000000000..ce09334b076a
> > > --- /dev/null
> > > +++ b/drivers/iio/adc/pac1944.c
> > > @@ -0,0 +1,2841 @@ =20
> >=20
> >  =20
> > > +/* Available Sample Modes */
> > > +static const char * const pac1944_frequency_avail[] =3D {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 "1024_ADAP",
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 "256_ADAP", =20
> >=20
> > This adaptive mode shouldn't be controlled via this standard
> > ABI.=C2=A0 That needs to be considered separately.
> >  =20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 "64_ADAP",
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 "8_ADAP",
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 "1024",
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 "256",
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 "64",
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 "8", =20
> > This does not look even close to ABI complaint.
> >=20
> > The numbers cases are fine. The others not really. =20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 "single_shot_1x", =20
> >=20
> > That has nothing directly to do with the sampling frequency.
> > Some others look suspicious.=C2=A0 I'd stick to normal
> > sampling_frequency handling and have the discussion about the other
> > modes in here at a later date.
> >  =20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 "single_shot_8x",
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 "fast",
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 "burst",
> > > +}; =20
>=20
> The adaptive mode is used to lower the power consumption of the device
> and keep the "same" calculation into the driver. I will try to look
> over an ABI to put the device into a low power mode and in this way I
> could change the frequency to ADAPTIVE.

We deliberately don't support 'mode' type switches for power saving in
the ABI. They are just too varied for userspace to 'generically'
know when to turn them on. Snag here is that it is a straight
trade off between a clever algorithm which will introduce some error
and straight forward sampling at high frequency. I don't currently
have a good idea on how we'd control that.  If we also had
a dataready trigger involved (rather than accumulating etc) then
maybe we'd do it via trigger selection, but that's not appropriate
here given this is about driving the accumulators, not a dataready
style readback of data (if we did that, we could just accumulate
in user space instead of the device - a very different thing!).


>=20
> The "single_shot_1x" and "single_shot_8x" is a special case when the
> user could take only one measurement and that measurement could be
> triggered/synched.

8x seems to be about oversampling - but on a single trigger.
In that sense it is a bit unusual.  Looks like we could only do
it effectively on an external IIO trigger? e.g. hrtimer or something
like that?

single shot 1x looks like a similar mode to use only on an external
trigger (or a sysfs read).  Can we just enable that only if we aren't
using this devices own trigger?

fast vs burst is an open question but taking just say fast
that ends up being just another sampling frequency, be it one that
changes with number of enabled channels.



>=20
> > >=20
> > >  =20
> ...
>=20
> >=20
> >=20
> >=20
> >=20
> >  =20
> > > +static struct attribute *pac1944_power_acc_attr[] =3D {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 &iio_dev_attr_in_energy1_raw.dev_attr.attr,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 &iio_dev_attr_in_energy2_raw.dev_attr.attr,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 &iio_dev_attr_in_energy3_raw.dev_attr.attr,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 &iio_dev_attr_in_energy4_raw.dev_attr.attr,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 &iio_dev_attr_in_energy1_scale.dev_attr.att=
r,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 &iio_dev_attr_in_energy2_scale.dev_attr.att=
r,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 &iio_dev_attr_in_energy3_scale.dev_attr.att=
r,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 &iio_dev_attr_in_energy4_scale.dev_attr.att=
r, =20
> >=20
> > These look like standard read_raw / info_mask based attributes will
> > work.
> > So do that, not custom attributes that are both harder to review and
> > don't work with in kernel consumers (which we may well see for a
> > power
> > monitoring chip).
> >  =20
>=20
> Because the device could support different modes of operation for the
> same accumulator, but only one at a time. I was trying to add to the
> sysfs only the mode that was set from the device tree.

Create the iio_chan_spec dynamically instead of the attributes added.

Jonathan


>=20
> >=20
> >  =20


