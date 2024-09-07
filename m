Return-Path: <linux-iio+bounces-9277-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B1F2970296
	for <lists+linux-iio@lfdr.de>; Sat,  7 Sep 2024 16:03:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67D871C2168D
	for <lists+linux-iio@lfdr.de>; Sat,  7 Sep 2024 14:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA21115CD77;
	Sat,  7 Sep 2024 14:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bBtxcAdD"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724284502F;
	Sat,  7 Sep 2024 14:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725717779; cv=none; b=DaE1pUXnXLYNpu3q3JI2iCWcur6DW1ap7Z6XiogGLa4MNgMXlT+E92okRC/qg2nZsZCNQhr4V+UpRLmPjkiMG+CCMr1NKgpkHL2uN2yw5Wt72btVB4R0xrJNDhz8r5Oni7BF31t6fkVtJZ+PtC6j3/GB+nlwijv7w4OH8xon5dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725717779; c=relaxed/simple;
	bh=1nkW8OT/lgbFBao8ndgv4iUdKsjyBiMWPvtLtYaCeYo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a9hEKCMzFcTo4miPiOZedyUzv3swHW+Dta/5FZd3t3Raw/HTmBnSxNUzYmhLaKb0yboSkthpk3mJGy0bESHKngGwGbXXrCZBh59qHTWKKlRZQjXRXbPkuyROWlwDZuTIOiCWk/QA4UbCxAtUflRj4A4nVsLgnw482PYfSKENI6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bBtxcAdD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFD08C4CEC2;
	Sat,  7 Sep 2024 14:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725717779;
	bh=1nkW8OT/lgbFBao8ndgv4iUdKsjyBiMWPvtLtYaCeYo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bBtxcAdD4M561FgZyuAkl/r0qVJGmKpu9EfXCWi0YOMy7R57v1IWUuGkOEoaZJgke
	 O9JmDpF0g5Vjs3q3xj6NnqPeJlZpKWRUPAXjq7n82hB7j4CbLuA5Nf7/dTRuRfB3Ms
	 XN2BYm69VfeOh0so7vA1Md0892cGlla4zuUAwH4rgnMublrpefi+2iUZAsnhNVj67v
	 Zc2hylznUYG4bivUo5jinEYxG2Qo8oWhDiAJBoD8pWdqKjsmstJSNFA78GMc4rQ3Un
	 AvnWqlEYo+toAn7vsNqcqaWWvhiSqvlWDaBc+nEcZMNm2mgCNtW8rZLUAVV4byMJhG
	 ofca3AtfDCNyQ==
Date: Sat, 7 Sep 2024 15:02:50 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Angelo Dureghello <adureghello@baylibre.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Olivier Moysan <olivier.moysan@foss.st.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dlechner@baylibre.com
Subject: Re: [PATCH RFC 2/8] iio: backend: extend features
Message-ID: <20240907150250.40ba72f5@jic23-huawei>
In-Reply-To: <f2568dd151efc2da76659fea4300fa7b3610d1e1.camel@gmail.com>
References: <20240829-wip-bl-ad3552r-axi-v0-v1-0-b6da6015327a@baylibre.com>
	<20240829-wip-bl-ad3552r-axi-v0-v1-2-b6da6015327a@baylibre.com>
	<20240831122313.4d993260@jic23-huawei>
	<0fbe1321-cc67-4ade-8cbb-cbbaa40d2ca1@baylibre.com>
	<20240903201157.5352ec04@jic23-huawei>
	<4826097d-b575-4895-9335-f587bbf3bc89@baylibre.com>
	<f2568dd151efc2da76659fea4300fa7b3610d1e1.camel@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 05 Sep 2024 12:28:51 +0200
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Wed, 2024-09-04 at 14:01 +0200, Angelo Dureghello wrote:
> > Hi Jonathan,
> >=20
> > On 03/09/24 9:11 PM, Jonathan Cameron wrote: =20
> > > On Mon, 2 Sep 2024 16:03:22 +0200
> > > Angelo Dureghello <adureghello@baylibre.com> wrote:
> > >  =20
> > > > Hi Jonathan,
> > > >=20
> > > > thanks for the feedbacks,
> > > >=20
> > > > On 31/08/24 1:23 PM, Jonathan Cameron wrote: =20
> > > > > On Thu, 29 Aug 2024 14:32:00 +0200
> > > > > Angelo Dureghello <adureghello@baylibre.com> wrote:
> > > > > =C2=A0  =20
> > > > > > From: Angelo Dureghello <adureghello@baylibre.com>
> > > > > >=20
> > > > > > Extend backend features with new calls needed later on this
> > > > > > patchset from axi version of ad3552r.
> > > > > >=20
> > > > > > A bus type property has been added to the devicetree to
> > > > > > inform the backend about the type of bus (interface) in use
> > > > > > bu the IP.
> > > > > >=20
> > > > > > The follwoing calls are added:
> > > > > >=20
> > > > > > iio_backend_ext_sync_enable
> > > > > > 	enable synchronize channels on external trigger
> > > > > > iio_backend_ext_sync_disable
> > > > > > 	disable synchronize channels on external trigger
> > > > > > iio_backend_ddr_enable
> > > > > > 	enable ddr bus transfer
> > > > > > iio_backend_ddr_disable
> > > > > > 	disable ddr bus transfer
> > > > > > iio_backend_set_bus_mode
> > > > > > 	select the type of bus, so that specific read / write
> > > > > > 	operations are performed accordingly
> > > > > > iio_backend_buffer_enable
> > > > > > 	enable buffer
> > > > > > iio_backend_buffer_disable
> > > > > > 	disable buffer
> > > > > > iio_backend_data_transfer_addr
> > > > > > 	define the target register address where the DAC sample
> > > > > > 	will be written.
> > > > > > iio_backend_bus_reg_read
> > > > > > 	generic bus read, bus-type dependent
> > > > > > iio_backend_bus_read_write
> > > > > > 	generic bus write, bus-type dependent
> > > > > >=20
> > > > > > Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> > > > > > ---
> > > > > > =C2=A0=C2=A0 drivers/iio/industrialio-backend.c | 151
> > > > > > +++++++++++++++++++++++++++++++++++++
> > > > > > =C2=A0=C2=A0 include/linux/iio/backend.h=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 24 ++++++
> > > > > > =C2=A0=C2=A0 2 files changed, 175 insertions(+)
> > > > > >=20
> > > > > > diff --git a/drivers/iio/industrialio-backend.c
> > > > > > b/drivers/iio/industrialio-backend.c
> > > > > > index a52a6b61c8b5..1f60c8626be7 100644
> > > > > > --- a/drivers/iio/industrialio-backend.c
> > > > > > +++ b/drivers/iio/industrialio-backend.c
> > > > > > @@ -718,6 +718,157 @@ static int __devm_iio_backend_get(struct =
device
> > > > > > *dev, struct iio_backend *back)
> > > > > > =C2=A0=C2=A0=C2=A0	return 0;
> > > > > > =C2=A0=C2=A0 } =20
> > > > > =C2=A0  =20
> > > > > > +
> > > > > > +/**
> > > > > > + * iio_backend_buffer_enable - Enable data buffering =20
> > > > > Data buffering is a very vague term.=C2=A0 Perhaps some more deta=
il on what
> > > > > this means? =20
> > > > for this DAC IP, it is the dma buffer where i write the samples,
> > > > for other non-dac frontends may be something different, so i kept it
> > > > generic. Not sure what a proper name may be, maybe
> > > >=20
> > > > "Enable optional data buffer" ? =20
> > > How do you 'enable' a buffer?=C2=A0 Enable writing into it maybe? =20
> >=20
> > for the current case, this is done using the custom register
> > of the AXI IP, enabling a "stream".
> >=20
> > return regmap_set_bits(st->regmap, AXI_DAC_REG_CUSTOM_CTRL,
> > =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AXI_DAC_STREAM_ENABLE);
> >=20
> > Functionally, looks like dma data is processed (sent over qspi)
> > when the stream is enabled.
> >=20
> > Maybe a name as "stream_enable" would me more appropriate ?
> > "Stream" seems less generic btw.
> >  =20

Ok. Maybe "enable buffer filling" or something like that?

>=20
> Yes, stream enable is very specific for this usecase. This is basically
> connected to typical IIO buffering. So maybe we could either:
>=20
> 1) Embed struct iio_buffer_setup_ops in the backend ops struct;
> 2) Or just define directly the ones we need now in backend ops.
Structurally whatever makes sense - I was just quibbling over the
documentation ;)

> =20
> > > >  =20
> > > > > > + * @back: Backend device
> > > > > > + *
> > > > > > + * RETURNS:
> > > > > > + * 0 on success, negative error number on failure.
> > > > > > + */
> > > > > > +int iio_backend_buffer_enable(struct iio_backend *back)
> > > > > > +{
> > > > > > +	return iio_backend_op_call(back, buffer_enable);
> > > > > > +}
> > > > > > +EXPORT_SYMBOL_NS_GPL(iio_backend_buffer_enable, IIO_BACKEND);
> > > > > > +
> > > > > > +/**
> > > > > > +/**
> > > > > > + * iio_backend_bus_reg_read - Read from the interface bus
> > > > > > + * @back: Backend device
> > > > > > + * @reg: Register valule
> > > > > > + * @val: Pointer to register value
> > > > > > + * @size: Size, in bytes
> > > > > > + *
> > > > > > + * A backend may operate on a specific interface with a relate=
d bus.
> > > > > > + * Read from the interface bus. =20
> > > > > So this is effectively routing control plane data through the off=
loaded
> > > > > bus?=C2=A0 That sounds a lot more like a conventional bus than II=
O backend.
> > > > > Perhaps it should be presented as that with the IIO device attach=
ed
> > > > > to that bus? I don't fully understand what is wired up here.
> > > > > =C2=A0  =20
> > > > Mainly, an IP may include a bus as 16bit parallel, or LVDS, or simi=
lar
> > > > to QSPI as in my case (ad3552r). =20
> > > ok.
> > >=20
> > > If this is a bus used for both control and dataplane, then we should =
really
> > > be presenting it as a bus (+ offload) similar to do for spi + offload.
> > >  =20
>=20
> Yes, indeed. In this case we also use the axi-dac core for controlling the
> frontend device (accessing it's register) which is fairly weird. But not =
sure
> how we can do it differently. For the spi_engine that is really a spi con=
troller
> with the extra offloading capability. For this one, it's now "acting" as =
a spi
> controller but in the future it may also "act" as a parallel controller (=
the
> axi-adc already is in works for that with the ad7606 series).
>=20
> I was also very skeptical when I first saw these new functions but I'm not
> really sure how to do it differently. I mean, it also does not make much =
sense
> to have an additional bus driver as the register maps are the same. Not s=
ure if
> turning it in a MFD device, helps...

Hmm. A given adi-axi-adc interface is going to be one of (or something else)
1) SPI(ish) controller + offloads like this one.
2) Parallel bus - data only
3) Parallel bus with control.

Maybe we argue these are tightly coupled enough that we don't care but it
feels like a direction that might bite us in the long run, particularly
if we end up dt bindings that are hard to work with if we change
how this fits together - imagine an SPI engine with a mode that does work
for this + an SPI offload engine that works with that.
Then the binding here will be hard to deal with.


>=20
> FWIW, I still don't fully understand why can't we have this supported by =
the
> spi_engine core. My guess is that we need features from the axi-dac (for =
the
> dataplane) so we are incorporating the controlplane on it instead of going
> spi_engine + axi-dac.
>=20
> Also want to leave a quick note about LVDS (that was mentioned). That int=
erface
> is typically only used for data so I'm not seeing any special handling li=
ke this
> for that interface.
Makes sense.  I'm a bit surprised that the parallel bus being used for cont=
rol
is on the list given that is also a bit messy to do (need some signalling t=
hat
direction is changing or a lot of wires).

Jonathan

>=20
> - Nuno S=C3=A1
> > >  =20


