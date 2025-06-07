Return-Path: <linux-iio+bounces-20309-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78216AD0EBB
	for <lists+linux-iio@lfdr.de>; Sat,  7 Jun 2025 19:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4640716B8C6
	for <lists+linux-iio@lfdr.de>; Sat,  7 Jun 2025 17:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D8D61FBCAD;
	Sat,  7 Jun 2025 17:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NJyIdpgF"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13AD9145B25;
	Sat,  7 Jun 2025 17:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749317303; cv=none; b=BsgXVtw3bCPSET9DCzlanqPIYhzqMeOnc1HMwOk9qrzXfyQTE9ssRF+1arbOkvQ146Z9e+/JGFGl8HO/TIO+7w1IPbv/M2w1Ffh80WL9YPb1o6sarcEBxU1IDT6dAnCMltNoO9mPxDqaKmVjYN5BaTbjICPjmO5GB/qmc4taNE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749317303; c=relaxed/simple;
	bh=zcW8Ah4pk0RKjOf2CypjgBn3ovLpAVh61mn0fSqxeio=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=te1hILuz8KjNPVcWeVVXg0GS+gMgIK87i+N7AYTMzg0ayPU+w2FDtOdtQAKzIR6zW6jYJZF5Jke/QhyX6JWaonZrmpSM37tLMHycnAt2YSMcIOZCitCzLHb4hJ2Fk5KmY7OpECCkwsfUpNbvXuV2gjlTpznd9NZdChzlsv96fas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NJyIdpgF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 200ECC4CEE4;
	Sat,  7 Jun 2025 17:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749317302;
	bh=zcW8Ah4pk0RKjOf2CypjgBn3ovLpAVh61mn0fSqxeio=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NJyIdpgFKHPiCWidf5SwPOwwLt8dqh3iZ7MnlVubLaxZeJieLLIcParncfWN+3I0Q
	 4Q3YkCRIjPvYMrphIaHvWgbFHXFdpNroF4jv0aNANh3SZ85oASaPjCs908SEwmuRiV
	 2I2K1JeDewHod9cIRi9zJQoCTHaU1n4rTTanp5+uQn4C/nEuOS5DYwkEr2xe44YnG3
	 41gRWxSwPkFHuh8yY1+dh4wZVLBPfN2NTgt+hIzMIuKbYTyq7i+fssikTmytoJj8KR
	 DfqqXQETjUx5VXd8fphhoQogJj+06UlBUgUrCnNgWwiSk9fMESPpgeE8StQfHtColY
	 l6xtlcwNsZ5EQ==
Date: Sat, 7 Jun 2025 18:28:13 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: <Victor.Duicu@microchip.com>
Cc: <Jonathan.Cameron@huawei.com>, <dlechner@baylibre.com>,
 <nuno.sa@analog.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <robh@kernel.org>, <andy@kernel.org>,
 <krzk+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
 <Marius.Cristea@microchip.com>, <conor+dt@kernel.org>
Subject: Re: [PATCH v2 2/2] iio: temperature: add support for MCP998X
Message-ID: <20250607182813.64230171@jic23-huawei>
In-Reply-To: <e5756eaf53fb5a702274cc707fcdf6196773fc65.camel@microchip.com>
References: <20250529093628.15042-1-victor.duicu@microchip.com>
	<20250529093628.15042-3-victor.duicu@microchip.com>
	<20250530175351.000039cb@huawei.com>
	<e5756eaf53fb5a702274cc707fcdf6196773fc65.camel@microchip.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 2 Jun 2025 14:49:29 +0000
<Victor.Duicu@microchip.com> wrote:

> On Fri, 2025-05-30 at 17:53 +0100, Jonathan Cameron wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you
> > know the content is safe
> >=20
> > On Thu, 29 May 2025 12:36:28 +0300
> > victor.duicu@microchip.com=C2=A0wrote:
> >  =20
> > > From: Victor Duicu <victor.duicu@microchip.com>
> > >=20
> > > This is the driver for Microchip MCP998X/33 and MCP998XD/33D
> > > Multichannel Automotive Temperature Monitor Family.
> > >=20
> > > Signed-off-by: Victor Duicu <victor.duicu@microchip.com> =20
> > Hi Victor,
> >  =20
> Hi Jonathan,
>=20
> ...
>=20
> >  =20
> > > +
> > > +What:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 /sys/bus/iio/devices/iio:deviceX/in_beta1
> > > +KernelVersion:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 6.17
> > > +Contact:=C2=A0=C2=A0=C2=A0=C2=A0 linux-iio@vger.kernel.org
> > > +Description:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 This attribute controls the value of beta correction
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 for channel 1. =20
> >=20
> > Is this something that we'd normally expect to manually update? What
> > is
> > it a characteristic of?=C2=A0 If it is expected to the be related to the
> > diodes attached, that's a problem for firmware/dt, not sysfs
> > interfaces.
> >  =20
>=20
> Beta is a characteristic of the diode/transistor placed on the setup.
> Different diodes require different betas.
> So yes, beta value should be in devicetree.
>=20
> ...
> > >=20
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 priv->iio_chan[iio_idx++] =3D (struct
> > > iio_chan_spec)MCP9982_CHAN(reg_nr, reg_nr,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0
> > > MCP9982_INT_VALUE_ADDR(reg_nr)); =20
> >=20
> > Seems very likely that the (struct iio_chan_spec) should be in the
> > macro definition.
> >  =20
>=20
> In version 1 the macro used to define the channels was:
>=20
> >  =20
> #define MCP9982_CHAN(index, si, __address) ({ \
> 	struct iio_chan_spec __chan =3D { \
> 		.type =3D IIO_TEMP, \
> 		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW), \
> 		.info_mask_shared_by_all_available =3D
> BIT(IIO_CHAN_INFO_SAMP_FREQ), \
> 		.info_mask_shared_by_all =3D
> BIT(IIO_CHAN_INFO_SAMP_FREQ), \
> 		.channel =3D index, \
> 		.address =3D __address, \
> 		.scan_index =3D si, \
> 		.scan_type =3D { \
> 			.sign =3D 'u', \
> 			.realbits =3D 8, \
> 			.storagebits =3D 8, \
> 			.endianness =3D IIO_CPU \
> 		}, \
> 		.indexed =3D 1, \
> 	}; \
> 	__chan; \
> })
>=20
> which contains struct iio_chan_spec inside.
> Andy suggested to use compound literal, so I switched to version 2.
> I still use a macro because most of the parameters are common among the
> channels.

I think we can add the (struct iio_chan_spec) to the macro definition.=20

>=20
> With Kind Regards,
> Victor Duicu


