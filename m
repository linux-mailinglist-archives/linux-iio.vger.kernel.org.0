Return-Path: <linux-iio+bounces-5074-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E8388C7E0E
	for <lists+linux-iio@lfdr.de>; Thu, 16 May 2024 23:32:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC9CA1F21E57
	for <lists+linux-iio@lfdr.de>; Thu, 16 May 2024 21:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37425158216;
	Thu, 16 May 2024 21:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Upg+zkrO"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC76E158201;
	Thu, 16 May 2024 21:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715895159; cv=none; b=FTBM/kf0jpsho1xUmFCoUzAGk3anwfXkdzu6/+TCC0OnAX6YiOcRRXbrVWHQ09GEszbGSTlnTCDJ//r+u6nne4CzSGbkhlsOoTRycXOyf2xRa9naJaaUU2K5MpY0chC5Org6lllozmXBK3tkfd6pVwElRWjcVdOVkIVBZsrYb6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715895159; c=relaxed/simple;
	bh=6/nLKJK7PKRS4GpkLXpEnALO7ddtUV4Kb4dHjwWKrlA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OjWJe0Ug81P8gZhxaF++A7g2R7ZyeVmAUyJft9d1xGd3LFeVarb8O2LqEd1BAynIRiEp9fAZi9NfiPSQjZpED9kFqmRWp/dzdhTxvShmqQcvWA/XZpKwW1+edk170yt/DYW2Hmm3eL3RD36auUadzD/9we1BcUYg/VdG8dCDCyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Upg+zkrO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7360BC113CC;
	Thu, 16 May 2024 21:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715895158;
	bh=6/nLKJK7PKRS4GpkLXpEnALO7ddtUV4Kb4dHjwWKrlA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Upg+zkrO/L6fvgCWF1Cvrqgs9OYE1knIZYdCiLaHUl//g9bkqxsVx1vSuSA7obwrV
	 53sNajB7QzAHL4EEiMDgnWIkc2cUPr+Vk1yE7qo8T4s7LOPjAruH77sSGtt4UMhkFm
	 yf9MWCgz7rF50gOnCU00YlPh14u4uvmszic0hOhP9fKax1XRP16OAx6/h9+3iEzvCV
	 YSBJ5cS47pr7rtTQR3CR4gwWEe+AmQkeuPvoIkbZM4TGwKc0tZl0wCCEsithlA5P0c
	 hbGoeEyCpziB0rkvAWDzIzsu+jxkj9NNuPaBrbXY7MF+er1oFpaiXyHH5mlPuIUtFj
	 4WgxuKdYiRy5A==
Date: Thu, 16 May 2024 22:32:33 +0100
From: Conor Dooley <conor@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Mark Brown <broonie@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	David Jander <david@protonic.nl>,
	Martin Sperl <kernel@martin.sperl.org>, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH RFC v2 1/8] spi: dt-bindings: spi-peripheral-props: add
 spi-offloads property
Message-ID: <20240516-rudder-reburial-dcf300504c0a@spud>
References: <20240510-dlech-mainline-spi-engine-offload-2-v2-0-8707a870c435@baylibre.com>
 <20240510-dlech-mainline-spi-engine-offload-2-v2-1-8707a870c435@baylibre.com>
 <20240513-headsman-hacking-d51fcc811695@spud>
 <CAMknhBE5XJzhdJ=PQUXiubw_CiCLcn1jihiscnQZUzDWMASPKw@mail.gmail.com>
 <20240514-aspire-ascension-449556da3615@spud>
 <CAMknhBFFpEGcMoLo5gsC11Syv+CwUM0mnq1yDMUzL1uutUtB+Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="PUrxS0tHEjun6Sgc"
Content-Disposition: inline
In-Reply-To: <CAMknhBFFpEGcMoLo5gsC11Syv+CwUM0mnq1yDMUzL1uutUtB+Q@mail.gmail.com>


--PUrxS0tHEjun6Sgc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Yo,

Sorry for the delay, long reply deserved some time to sit and think
about it.

On Tue, May 14, 2024 at 05:56:47PM -0500, David Lechner wrote:
> On Tue, May 14, 2024 at 1:46=E2=80=AFPM Conor Dooley <conor@kernel.org> w=
rote:
> >
> > On Mon, May 13, 2024 at 12:06:17PM -0500, David Lechner wrote:
> > > On Mon, May 13, 2024 at 11:46=E2=80=AFAM Conor Dooley <conor@kernel.o=
rg> wrote:
> > > >
> > > > On Fri, May 10, 2024 at 07:44:24PM -0500, David Lechner wrote:
> > > > > This adds a new property to the spi-peripheral-props binding for =
use
> > > > > with peripherals connected to controllers that support offloading.
> > > > >
> > > > > Here, offloading means that the controller has the ability to per=
form
> > > > > complex SPI transactions without CPU intervention in some shape o=
r form.
> > > > >
> > > > > This property will be used to assign controller offload resources=
 to
> > > > > each peripheral that needs them. What these resources are will be
> > > > > defined by each specific controller binding.
> > > > >
> > > > > Signed-off-by: David Lechner <dlechner@baylibre.com>
> > > > > ---
> > > > >
> > > > > v2 changes:
> > > > >
> > > > > In v1, instead of generic SPI bindings, there were only controlle=
r-
> > > > > specific bindings, so this is a new patch.
> > > > >
> > > > > In the previous version I also had an offloads object node that d=
escribed
> > > > > what the offload capabilities were but it was suggested that this=
 was
> > > > > not necessary/overcomplicated. So I've gone to the other extreme =
and
> > > > > made it perhaps over-simplified now by requiring all information =
about
> > > > > how each offload is used to be encoded in a single u32.
> > > >
> > > > The property is a u32-array, so I guess, not a single u32?
> > >
> > > It is an array to handle cases where a peripheral might need more than
> > > one offload. But the idea was it put everything about each individual
> > > offload in a single u32. e.g. 0x0101 could be offload 1 with hardware
> > > trigger 1 and 0x0201 could be offload 1 with hardware trigger 2. Then
> > > a peripheral could have spi-offloads =3D <0x0101>, <0x0201>; if it
> > > needed to select between both triggers at runtime.
> > >
> > > >
> > > > > We could of course consider using #spi-offload-cells instead for
> > > > > allowing encoding multiple parameters for each offload instance i=
f that
> > > > > would be preferable.
> > > >
> > > > A -cells property was my gut reaction to what you'd written here and
> > > > seems especially appropriate if there's any likelihood of some futu=
re
> > > > device using some external resources for spi-offloading.
> > > > However, -cells properties go in providers, not consumers, so it wo=
uldn't
> > > > end up in spi-periph-props.yaml, but rather in the controller bindi=
ng,
> > > > and instead there'd be a cell array type property in here. I think =
you
> > > > know that though and I'm interpreting what's been written rather th=
an
> > > > what you meant.
> > >
> > > Indeed you guess correctly. So the next question is if it should be
> > > the kind of #-cells that implies a phandle like most providers or
> > > without phandles like #address-cells?
> >
> > I'm trying to understand if the offload could ever refer to something
> > beyond the controller that you'd need the phandle for. I think it would
> > be really helpful to see an example dt of a non-trivial example for how
> > this would work. The example in the ad7944 patch has a stub controller
> > node & the clocks/dmas in the peripheral node so it is difficult to
> > reason about the spi-offloads property there.
>=20
> The fully implemented and tested version of the .dts corresponding to
> the hardware pictured in the cover letter can be found at [1].
>=20
> [1]: https://github.com/dlech/linux/blob/axi-spi-engine-offload-v2/arch/a=
rm/boot/dts/xilinx/zynq-zed-adv7511-ad7986.dts

Unfortunately this is a trivial example, so there's not much to be
gained in new information from the example in the bindings :/ Your
examples below are good though, which makes up for that and more.

> To be clear though, the idea that I am proposing here is that if there
> is something beyond the SPI controller directly connected to the
> offload, then we would add those things in the peripheral node along
> with the spi-offloads property that specifies the offload those other
> things are connected to.
>=20
> Tangent on phandle vs. no phandle:

Yeah, I think not having a phandle makes sense based on what you've
said.

> Back to "something beyond the SPI controller":
>=20
> Here are some examples of how I envision this would work.
>=20
> Let's suppose we have a SPI controller that has some sort of offload
> capability with a configurable trigger source. The trigger can either
> be an internal software trigger (i.e. writing a register of the SPI
> controller) or and external trigger (i.e. a input signal from a pin on
> the SoC). The SPI controller has a lookup table with 8 slots where it
> can store a series of SPI commands that can be played back by
> asserting the trigger (this is what provides the "offloading").
>=20
> So this SPI controller would have #spi-offload-cells =3D <2>; where the
> first cell would be the index in the lookup table 0 to 7 and the
> second cell would be the trigger source 0 for software or 1 for
> hardware.
>=20
> Application 1: a network controller
>=20
> This could use two offloads, one for TX and one for RX. For TX, we use
> the first slot with a software trigger because the data is coming from
> Linux. For RX we use the second slot with a hardware trigger since
> data is coming from the network controller (i.e. a data ready signal
> that would normally be wired to a gpio for interrupt but wired to the
> SPI offload trigger input pin instead). So the peripheral bindings
> would be:
>=20
> #define SOFTWARE_TRIGGER 0
> #define HARDWARE_TRIGGER 1
>=20
> can@0 {
>     ...
>     spi-offloads =3D <0 SOFTWARE_TRIGGER>, <1 HARDWARE_TRIGGER>;
>     /* maybe we need names too? */
>     spi-offload-names =3D "tx", "rx";
> };
>=20
> In this case, there is nothing extra beyond the SPI controller and the
> network controller, so no extra bindings beyond this are needed.
>=20
> Application 2: an advanced ADC + FPGA
>=20
> This is basically the same as the ad7944 case seen already with one
> extra feature. In this case, the sample data also contains a CRC byte
> for error checking. So instead of SPI RX data going directly to DMA,
> the FPGA removes the CRC byte from the data stream an only the sample
> data goes to the DMA buffer. The CRC is checked and if bad, an
> interrupt is asserted.
>=20
> Since this is an FPGA, most everything is hardwired rather than having
> any kind of mux selection so #spi-offload-cells =3D <1>; for this
> controller.
>=20
> By adding spi-offloads to the peripheral node, it also extends the
> peripheral binding to include the additional properties needed for the
> extra features provided by the FPGA. In other words, we are saying
> this DT node now represents the ADC chip plus everything connected to
> the offload instance used by the ADC chip.

It seems very strange to me that the dmas and the clock triggers are
going into the spi device nodes. The description is=20
| +  dmas:
| +    maxItems: 1
| +    description: RX DMA Channel for receiving a samples from the SPI off=
load.
But as far as I can tell this device is in a package of its own and not
some IP provided by Analog that an engine on the FPGA can actually do
DMA to, and the actual connection of the device is "just" SPI.
The dmas and clock triggers etc appear to be resources belonging to the
controller that can "assigned" to a particular spi device. If the adc
gets disconnected from the system, the dmas and clock triggers are still
connected to the spi controller/offload engine, they don't end up n/c,
right? (Well maybe they would in the case of a fancy SPI device that
provides it's own sampling clock or w/e, but then it'd be a clock
provider of sorts). I'd be expecting the spi-offloads property to be
responsible for selecting which of the various resources belonging to
the controller are to be used by a device.
Maybe it overcomplicates the shit out of things and Rob or Mark are
gonna start screaming at me but w/e, looking at it from the point of
view of how the hardware is laid out (or at least how it is described
in your FPGA case above) the dma/clock properties looks like they're
misplaced. IOW, I don't think that adding the spi-offloads property
should convert a node from representing an ADC in a qfn-20 or w/e
to "the ADC chip plus everything connected to the offload instance
used by the ADC chip".

> adc@0 {
>     ...
>     spi-offloads =3D <0>;
>     dmas =3D <&dma 0>; /* channel receiving split out sample data */
>     dma-names =3D "rx";
>     interrupts =3D <&intc 99>; /* interrupt for bad CRC */
>     interrupt-names =3D "crc";
> };
>=20
> >
> > > Asking because I got pushback on
> > > v1 for using a phandle with offloads (although in that case, the
> > > phandle was for the offload instance itself instead for the SPI
> > > controller, so maybe this is different in this case?).
> >
> > Do you have a link to this v1 pushback?
>=20
> Hmm... maybe that was from some internal review before v1 that I was
> remembering and confusing with the resistance of different aspects you
> mention below.
>=20
> > I had looked at the v1's binding
> > comments and didn't see that type of property being resisted - although
> > I did see some resistance to the spi peripheral node containing any of
> > the information about the offloads it had been assigned and instead
> > doing that mapping in the controller so that the cs was sufficient. I
> > don't think that'd work with the scenario you describe above though
> > where there could be two different triggers per device tho.
>=20
> I think most of the objection was to having an offloads object node
> with offload@ subnodes in the SPI controller node along side the
> peripheral nodes.

I dunno, that was my reading of Rob's comments at least. I know he had
more than one objection though, so maybe we're just looking at different
portions of it - I did note that you removed the offload@ though.

Cheers,
Conor.

--PUrxS0tHEjun6Sgc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZkZ7cQAKCRB4tDGHoIJi
0votAQCzjlAGpb2kXqqg1VZQ11eZbkgGcaR8LRcmlpKReyfVWQEA3MpGhoVbwRvk
FDc3e10HSjGXmu20tqkrNO2ttutoNQE=
=hdFd
-----END PGP SIGNATURE-----

--PUrxS0tHEjun6Sgc--

