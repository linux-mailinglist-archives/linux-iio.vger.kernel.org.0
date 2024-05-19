Return-Path: <linux-iio+bounces-5102-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B0D18C94AC
	for <lists+linux-iio@lfdr.de>; Sun, 19 May 2024 14:53:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DF851C20939
	for <lists+linux-iio@lfdr.de>; Sun, 19 May 2024 12:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5357D45026;
	Sun, 19 May 2024 12:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nyHKbW8p"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04DD3DF58;
	Sun, 19 May 2024 12:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716123219; cv=none; b=EAYPilgLVVVmy3aOn2gAZY0oII5dXVEmOXSZ2dXzhrtSjjBKkSzKfCcIh9K+tOm3B2TOOHQeLNDWSt532gsfZRzZeeZQsM9ctV68sLDExtk5ieMnPFsuT8m/q3HBtnNLK7Q+cqd75EeMBsF2jOL+ytOkaveEVXKW7jVHklUOwS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716123219; c=relaxed/simple;
	bh=a6NZIhIHvgb7rtZK4CQlLQQlYPXzIPu2lLEHZPOvSeA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EqUysnZIG9QDUYFFqNp3jLohYAPOQHFiAxJwSxH6QGQXfdxkyVswcuAkY7a9BMyIbQef6Hx4nByx1z9Ogo/731NimJLxxPyaJA4O27M0c237UD615PeDJuzfcYM1QWcbS4X4RvCNiS0WuLoYFZsbC54UGUYCKdk9MCfHvsgyPRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nyHKbW8p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EE94C32781;
	Sun, 19 May 2024 12:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716123218;
	bh=a6NZIhIHvgb7rtZK4CQlLQQlYPXzIPu2lLEHZPOvSeA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nyHKbW8pT+PVhsgI5pmJ+bVUYvfv5ObuaqQlHHK42kMdQQgPYlzay++Ty4twJNJ+s
	 3DEXJd8mjAgKLAAQA4sJDOLUyw3GjKvWedVN68IJKprUkIJtnT1Fp5KnNqdOsRIt+n
	 UYKub5o7bKNpzbw7jyJ30tlP434wC2e0Zm8XfdPBskzEcq6NKQ3qm5SFm701K2VyDP
	 I2uSp4m6WvkBmsUvqShZi1hMts6LXLvPhttLGhOnvlJm58T4g0lF8Rhdi6amWh4Vc4
	 1qq7Gg9wyLA7/oQL1N4wGjgWJVQORYhAsFiqKIw4KXEDUZ3nTFZ+/Uwm3ZfciCkval
	 slTsC9Y7efuBQ==
Date: Sun, 19 May 2024 13:53:33 +0100
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
Message-ID: <20240519-abreast-haziness-096a57ef57d3@spud>
References: <20240510-dlech-mainline-spi-engine-offload-2-v2-0-8707a870c435@baylibre.com>
 <20240510-dlech-mainline-spi-engine-offload-2-v2-1-8707a870c435@baylibre.com>
 <20240513-headsman-hacking-d51fcc811695@spud>
 <CAMknhBE5XJzhdJ=PQUXiubw_CiCLcn1jihiscnQZUzDWMASPKw@mail.gmail.com>
 <20240514-aspire-ascension-449556da3615@spud>
 <CAMknhBFFpEGcMoLo5gsC11Syv+CwUM0mnq1yDMUzL1uutUtB+Q@mail.gmail.com>
 <20240516-rudder-reburial-dcf300504c0a@spud>
 <CAMknhBF_s0btus4yqPe-T=F3z7Asi9KkRGsGr7FHDFi=k4EQjw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="YiBMsFrJmwB65D0T"
Content-Disposition: inline
In-Reply-To: <CAMknhBF_s0btus4yqPe-T=F3z7Asi9KkRGsGr7FHDFi=k4EQjw@mail.gmail.com>


--YiBMsFrJmwB65D0T
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 17, 2024 at 11:51:58AM -0500, David Lechner wrote:
> On Thu, May 16, 2024 at 4:32=E2=80=AFPM Conor Dooley <conor@kernel.org> w=
rote:
> > On Tue, May 14, 2024 at 05:56:47PM -0500, David Lechner wrote:

> > > Back to "something beyond the SPI controller":
> > >
> > > Here are some examples of how I envision this would work.
> > >
> > > Let's suppose we have a SPI controller that has some sort of offload
> > > capability with a configurable trigger source. The trigger can either
> > > be an internal software trigger (i.e. writing a register of the SPI
> > > controller) or and external trigger (i.e. a input signal from a pin on
> > > the SoC). The SPI controller has a lookup table with 8 slots where it
> > > can store a series of SPI commands that can be played back by
> > > asserting the trigger (this is what provides the "offloading").
> > >
> > > So this SPI controller would have #spi-offload-cells =3D <2>; where t=
he
> > > first cell would be the index in the lookup table 0 to 7 and the
> > > second cell would be the trigger source 0 for software or 1 for
> > > hardware.
> > >
> > > Application 1: a network controller
> > >
> > > This could use two offloads, one for TX and one for RX. For TX, we use
> > > the first slot with a software trigger because the data is coming from
> > > Linux. For RX we use the second slot with a hardware trigger since
> > > data is coming from the network controller (i.e. a data ready signal
> > > that would normally be wired to a gpio for interrupt but wired to the
> > > SPI offload trigger input pin instead). So the peripheral bindings
> > > would be:
> > >
> > > #define SOFTWARE_TRIGGER 0
> > > #define HARDWARE_TRIGGER 1
> > >
> > > can@0 {
> > >     ...
> > >     spi-offloads =3D <0 SOFTWARE_TRIGGER>, <1 HARDWARE_TRIGGER>;
> > >     /* maybe we need names too? */
> > >     spi-offload-names =3D "tx", "rx";
> > > };
> > >
> > > In this case, there is nothing extra beyond the SPI controller and the
> > > network controller, so no extra bindings beyond this are needed.
> > >
> > > Application 2: an advanced ADC + FPGA
> > >
> > > This is basically the same as the ad7944 case seen already with one
> > > extra feature. In this case, the sample data also contains a CRC byte
> > > for error checking. So instead of SPI RX data going directly to DMA,
> > > the FPGA removes the CRC byte from the data stream an only the sample
> > > data goes to the DMA buffer. The CRC is checked and if bad, an
> > > interrupt is asserted.
> > >
> > > Since this is an FPGA, most everything is hardwired rather than having
> > > any kind of mux selection so #spi-offload-cells =3D <1>; for this
> > > controller.
> > >
> > > By adding spi-offloads to the peripheral node, it also extends the
> > > peripheral binding to include the additional properties needed for the
> > > extra features provided by the FPGA. In other words, we are saying
> > > this DT node now represents the ADC chip plus everything connected to
> > > the offload instance used by the ADC chip.
> >
> > It seems very strange to me that the dmas and the clock triggers are
> > going into the spi device nodes. The description is
> > | +  dmas:
> > | +    maxItems: 1
> > | +    description: RX DMA Channel for receiving a samples from the SPI=
 offload.
> > But as far as I can tell this device is in a package of its own and not
> > some IP provided by Analog that an engine on the FPGA can actually do
> > DMA to, and the actual connection of the device is "just" SPI.
> > The dmas and clock triggers etc appear to be resources belonging to the
> > controller that can "assigned" to a particular spi device. If the adc
> > gets disconnected from the system, the dmas and clock triggers are still
> > connected to the spi controller/offload engine, they don't end up n/c,
> > right? (Well maybe they would in the case of a fancy SPI device that
> > provides it's own sampling clock or w/e, but then it'd be a clock
> > provider of sorts). I'd be expecting the spi-offloads property to be
> > responsible for selecting which of the various resources belonging to
> > the controller are to be used by a device.
> > Maybe it overcomplicates the shit out of things and Rob or Mark are
> > gonna start screaming at me but w/e, looking at it from the point of
> > view of how the hardware is laid out (or at least how it is described
> > in your FPGA case above) the dma/clock properties looks like they're
> > misplaced. IOW, I don't think that adding the spi-offloads property
> > should convert a node from representing an ADC in a qfn-20 or w/e
> > to "the ADC chip plus everything connected to the offload instance
> > used by the ADC chip".
>=20
> This is the same reasoning that led me to the binding proposed in v1.
> Rob suggested that these extras (dmas/clocks) should just be
> properties directly of the SPI controller.

> But the issue I have with
> that is that since this is an FPGA, these properties are not fixed.

I don't think whether or not we're talking about an FPGA or an ASIC
matters at all here to be honest. In my view the main thing that FPGA
impact in terms of bindings is the number of properties required to
represent the configurability of a particular IP. Sure, you're gonna
have to change the dts around in a way you'll never have to with an
ASIC, but the description of individual devices or relations between
them doesn't change.

> Maybe there are more clocks or no clocks or interrupts or something we
> didn't think of yet.

This could happen with a new generation of an ASIC and is not specific
to an FPGA IP core. Even with FPGA IP, while there may be lots of
different configuration parameters, they are known & limited - you can
look at the IP's documentation (or failing that, the HDL) to figure out
what the points of variability are. It's not particularly difficult to
account for there being a configurable number of clocks or interrupts.
For "something we didn't think of yet" to be a factor, someone has to
think of it and add it to the IP core, and which point we can absolutely
change the bindings and software to account for the revised IP.

> So it doesn't really seem possible to write a
> binding for the SPI controller node to cover all of these cases.

I dunno, I don't think your concerns about numbers of clocks (or any
other such property) are unique to this particular use-case.

> These
> extras are included in the FPGA bitstream only for a specific type of
> peripheral, not for general use of the SPI controller with any type of
> peripheral.

I accept that, but what I was trying to get across was that you could
configure the FPGA with a bitstream that contains these extra resources
and then connect a peripheral device that does not make use of them at
all. Or you could connect a range of different peripherals that do use
them. Whether or not the resources are there and how they are connected
in the FPGA bitstream is not a property of the device connected to the
SPI controller, only whether or not you use them is.

In fact, looking at the documentation for the "spi engine" some more, I
am even less convinced that the right place for describing the offload is
the peripheral as I (finally?) noticed that the registers for the offload
engine are mapped directly into the "spi engine"'s memory map, rather than
it being a entirely separate IP in the FPGA fabric.

Further, what resources are available depends on what the SPI offload
engine IP is. If my employer decides to start shipping some SPI offload
IP in our catalogue that can work with ADI's ADCs, the set of offload
related properties or their names may well differ.

> Another idea I had was to perhaps use the recently added IIO backend
> framework for the "extras". The idea there is that we are creating a
> "composite" IIO device that consists of the ADC chip (frontend) plus
> these extra hardware trigger and hardware buffer functions provided by
> the FPGA (backend).
>=20
> offload_backend: adc0-backend {
>     /* http://analogdevicesinc.github.io/hdl/projects/pulsar_adc/index.ht=
ml */
>     compatible =3D "adi,pulsar-adc-offload";
>     #io-backend-cells =3D <0>;
>     dmas =3D <&dma 0>;
>     dma-names =3D "rx";
>     clocks =3D <&trigger_clock>;
> };
>=20
> spi {
>     ...
>     adc@0 {
>         ...
>         spi-offloads =3D <0>;
>         io-backends =3D <&offload_backend>;
>     };
> };
>=20
> While this could be a solution for IIO devices, this wouldn't solve
> the issue in general though for SPI offloads used with non-IIO
> peripherals.

Yeah, I agree that using something specific to IIO isn't really a good
solution.

Cheers,
Conor.

> So I don't think it is the right thing to do here. But, I
> think this idea of a "composite" device helps explain why we are
> pushing for putting the "extras" with the peripheral node rather than
> the controller node, at least for the specific case of the AXI SPI
> Engine controller.


--YiBMsFrJmwB65D0T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZkn2TQAKCRB4tDGHoIJi
0vCVAQCIFVqleGOTvwajfKEdFoQaEw439hSehDqkMdChJVGlHAD+MyuwiRCNe0Se
YPMZWaHQzj6FdOyms/3MtG/eNG4r/wE=
=/qrC
-----END PGP SIGNATURE-----

--YiBMsFrJmwB65D0T--

