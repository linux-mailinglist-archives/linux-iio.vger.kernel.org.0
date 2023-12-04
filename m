Return-Path: <linux-iio+bounces-594-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CD9E5803925
	for <lists+linux-iio@lfdr.de>; Mon,  4 Dec 2023 16:48:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42D44B20B61
	for <lists+linux-iio@lfdr.de>; Mon,  4 Dec 2023 15:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B931D2CCD1;
	Mon,  4 Dec 2023 15:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IDHjTb+M"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741582C18A;
	Mon,  4 Dec 2023 15:48:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B83D7C433C7;
	Mon,  4 Dec 2023 15:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701704899;
	bh=poIexEtWzDjxIb1louewjCxKLfMDPcfvONt+RHDyPS8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IDHjTb+Meoe/ODMChOrhxVq7/CpZfckhLACFK6WmeArBYCsQNFST8sC6kaV9/2SQO
	 FEdGFDlofC0rZT+vLAeDmtsNsO4wkrl+ubR84YHihD3ZN/0fLAYCpRFROxr9V3co1I
	 M+YmhGDG1pRLPvEV2PTKafIQVNL0wfF453vkY93QXMEQ/s0CsD3g7n5I3pR7ZpcTfQ
	 3JO9MNyvO/HrW7GXbPOEhlyuSVw1JxICG3ECvApZCwAFdulwm01TlBRA6AuYIb+3Kp
	 6hDvq8P7kAtT27BnrwLEqoKuUMDFehZo2FPt83kTgbuYi+3jexJgCK8qdgIEJ7+Oj7
	 JoA6TfyYbIKKA==
Date: Mon, 4 Dec 2023 15:48:10 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, nuno.sa@analog.com,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-iio@vger.kernel.org, Olivier MOYSAN <olivier.moysan@foss.st.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Rob Herring <robh+dt@kernel.org>, Frank Rowand
 <frowand.list@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>
Subject: Re: [PATCH 10/12] iio: adc: ad9467: convert to backend framework
Message-ID: <20231204154810.3f2f3f83@jic23-huawei>
In-Reply-To: <026fa80d29054750937cd077b7f4f689de4e18f2.camel@gmail.com>
References: <20231121-dev-iio-backend-v1-0-6a3d542eba35@analog.com>
	<20231121-dev-iio-backend-v1-10-6a3d542eba35@analog.com>
	<CAMknhBFbLju8UQJ7Uz85kHKrbK4mzt=wTRdnp40+PwWCJa5dsA@mail.gmail.com>
	<026fa80d29054750937cd077b7f4f689de4e18f2.camel@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 01 Dec 2023 10:08:27 +0100
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Thu, 2023-11-30 at 17:30 -0600, David Lechner wrote:
> > On Tue, Nov 21, 2023 at 4:17=E2=80=AFAM Nuno Sa via B4 Relay
> > <devnull+nuno.sa.analog.com@kernel.org> wrote: =20
> > >=20
> > > From: Nuno Sa <nuno.sa@analog.com>
> > >=20
> > > Convert the driver to use the new IIO backend framework. The device
> > > functionality is expected to be the same (meaning no added or removed
> > > features). =20
> >=20
> > Missing a devicetree bindings patch before this one?
> >  =20
> > >=20
> > > Also note this patch effectively breaks ABI and that's needed so we c=
an
> > > properly support this device and add needed features making use of the
> > > new IIO framework. =20
> >=20
> > Can you be more specific about what is actually breaking?
> >  =20
> > >=20
> > > Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> > > ---
> > > =C2=A0drivers/iio/adc/Kconfig=C2=A0 |=C2=A0=C2=A0 2 +-
> > > =C2=A0drivers/iio/adc/ad9467.c | 256 +++++++++++++++++++++++++++++---=
---------------
> > > =C2=A02 files changed, 157 insertions(+), 101 deletions(-)
> > >=20
> > > diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> > > index 1e2b7a2c67c6..af56df63beff 100644
> > > --- a/drivers/iio/adc/Kconfig
> > > +++ b/drivers/iio/adc/Kconfig
> > > @@ -275,7 +275,7 @@ config AD799X
> > > =C2=A0config AD9467
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tristate "Analog Devices A=
D9467 High Speed ADC driver"
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 depends on SPI
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 depends on ADI_AXI_ADC
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select IIO_BACKEND
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 help
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Say yes here t=
o build support for Analog Devices:
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * AD9467 16-Bi=
t, 200 MSPS/250 MSPS Analog-to-Digital Converter
> > > diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
> > > index 5db5690ccee8..8b0402e73ace 100644
> > > --- a/drivers/iio/adc/ad9467.c
> > > +++ b/drivers/iio/adc/ad9467.c =20
> >=20
> > <snip>
> >  =20
> > > +static int ad9467_buffer_get(struct iio_dev *indio_dev) =20
> >=20
> > perhaps a more descriptive name: ad9467_buffer_setup_optional?
> >  =20
>=20
> Hmm, no strong feeling. So yeah, can do as you suggest. Even though, now =
that I'm
> thinking, I'm not so sure if this is just some legacy thing we had in ADI=
 tree. I
> wonder if it actually makes sense for a device like with no buffering sup=
port?!
> =20
> > > +{
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct device *dev =3D indio_de=
v->dev.parent;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const char *dma_name;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!device_property_present(de=
v, "dmas"))
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 return 0;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (device_property_read_string=
(dev, "dma-names", &dma_name))
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 dma_name =3D "rx";
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return devm_iio_dmaengine_buffe=
r_setup(dev, indio_dev, dma_name); =20
> >=20
> > The device tree bindings for "adi,ad9467" don't include dma properties
> > (nor should they). Perhaps the DMA lookup should be a callback to the
> > backend? Or something similar to the SPI Engine offload that we are
> > working on?
> >  =20
>=20
> Oh yes, I need to update the bindings. In the link I sent you we can see =
my thoughts
> on this. In theory, hardwarewise, it would actually make sense for the DM=
A to be on
> the backend device because that's where the connection is in HW. However,=
 since we
> want to have the IIO interface in the frontend, it would be hard to do th=
at without
> hacking devm_iio_dmaengine_buffer_setup().=C2=A0I mean, lifetime wise it =
would be far from
> wise to have the DMA buffer associated to a completely different device t=
han the IIO
> parent device. I mean, one way could just be export iio_dmaengine_buffer_=
free() and
> iio_dmaengine_buffer_alloc() so we can actually control the lifetime of t=
he buffer
> from the frontend device. If Jonathan is fine with this, I'm on board for=
 it....

It is going to be fiddly but I'd kind of expect the front end to be using a=
 more
abstracted interface to tell the backend to start grabbing data.  Maybe tha=
t ends
up being so slim it's just these interfaces and it's not sensible to wrap i=
t though.

The argument for the IIO device (you control) being associated with the ana=
log/digital front end is that
is what happens with a consumer interface today. We think of the analog com=
ponents (consuming device)
using the sevice of the ADC it is consuming to measure their state.

You can flip the whole thing and make the data grabbing engine the IIO devi=
ce but
I guess that's just not how we did it and I'm sure I had many good reasons =
at the time
(one of them being that it needed to work for other cases such as a touchsc=
reen driver
consuming the IIO device)  I that case it's the touchscreen driver that is =
responsible
for data scaling etc not the ADC. =20

In my head, data acquisition is a service - what is interesting is what is =
being measured
and so I put the IIO device as near that as possible.

Jonathan


