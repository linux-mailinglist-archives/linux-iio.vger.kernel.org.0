Return-Path: <linux-iio+bounces-5189-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0678CC648
	for <lists+linux-iio@lfdr.de>; Wed, 22 May 2024 20:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 282D3B2153B
	for <lists+linux-iio@lfdr.de>; Wed, 22 May 2024 18:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E356145B32;
	Wed, 22 May 2024 18:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pzG3MJlu"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A000D51E;
	Wed, 22 May 2024 18:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716402303; cv=none; b=sClsAI0gWnnoqJf2Y9pTlBwjarBpVajQqjQHRQ2+/vNrByN+guWqo5jZ9TWwMLBBB/Si+pmlIkTkX0a1jRqqJDewb/GmUNRaPI0KUO+soWa7t8ddkY3ya5zaiTaKvst/Pgsva9J6WShnwdFioOIB1RPH+8/qeNmVWdueDdFvWcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716402303; c=relaxed/simple;
	bh=Shqy5OL7xRWo7Q5gC8OQsX+tNunueyzgF0SSparBp0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R0NyPk7HDAqwY6nvijvirlnLO55RtSo56plPD32orRCi88lDUao8i1+q/bJo6Sn8uC7M0YA1gkemGEPxpTNIOFADXUMD50SL91+LYoDUPpRckAzYHZ5Hnlviy0Npb+Vbq8rFa8cdD88UZ69mjMf14RiM2JjmNFFhma28FuKNX2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pzG3MJlu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A0CAC32781;
	Wed, 22 May 2024 18:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716402302;
	bh=Shqy5OL7xRWo7Q5gC8OQsX+tNunueyzgF0SSparBp0o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pzG3MJlu1g+Oi8vvIuR0OIJMKSOJCL/2AKuhReyNmzZxGuN9rvErd+BciVsuiyWjU
	 kc84Q4pO9H2ayk+Qhr1JnQHTH/5uFKW+5nHZrRXAJ9mBJnQ7KCIJHiHAs2PuSra2DO
	 petLyG6UfebGju6/SKI6l5DBcWgpAjUy+SY/Eb1VQYP5X03EsZANmZ9IZY+E6j1q7X
	 qYQ/YFBhuJreRf7M6758HTbjyxhPzQPJUmkdEvSxUiMgQWonO4uCkN8u1ocUp9YhDU
	 Mfuc5C9W0xXjqd/m/cMeoRjrYR6gqQkdnK7wftGKuzFLUbWc2MLJBsWnGovryFJtyK
	 PGX4LfWdBZGbA==
Date: Wed, 22 May 2024 19:24:57 +0100
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
Message-ID: <20240522-gullible-ibuprofen-cf9111c25f6f@spud>
References: <20240510-dlech-mainline-spi-engine-offload-2-v2-0-8707a870c435@baylibre.com>
 <20240510-dlech-mainline-spi-engine-offload-2-v2-1-8707a870c435@baylibre.com>
 <20240513-headsman-hacking-d51fcc811695@spud>
 <CAMknhBE5XJzhdJ=PQUXiubw_CiCLcn1jihiscnQZUzDWMASPKw@mail.gmail.com>
 <20240514-aspire-ascension-449556da3615@spud>
 <CAMknhBFFpEGcMoLo5gsC11Syv+CwUM0mnq1yDMUzL1uutUtB+Q@mail.gmail.com>
 <20240516-rudder-reburial-dcf300504c0a@spud>
 <CAMknhBF_s0btus4yqPe-T=F3z7Asi9KkRGsGr7FHDFi=k4EQjw@mail.gmail.com>
 <20240519-abreast-haziness-096a57ef57d3@spud>
 <CAMknhBHvEse2FyDoBXR1PvymGpSGq8dotKfm+8XH+0+k+xKtQw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tCE84TRCfzbvxkUd"
Content-Disposition: inline
In-Reply-To: <CAMknhBHvEse2FyDoBXR1PvymGpSGq8dotKfm+8XH+0+k+xKtQw@mail.gmail.com>


--tCE84TRCfzbvxkUd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2024 at 09:54:39AM -0500, David Lechner wrote:
> On Sun, May 19, 2024 at 7:53=E2=80=AFAM Conor Dooley <conor@kernel.org> w=
rote:
> >
> > On Fri, May 17, 2024 at 11:51:58AM -0500, David Lechner wrote:
> > > On Thu, May 16, 2024 at 4:32=E2=80=AFPM Conor Dooley <conor@kernel.or=
g> wrote:
> > > > On Tue, May 14, 2024 at 05:56:47PM -0500, David Lechner wrote:
> >
> > > > > Back to "something beyond the SPI controller":
> > > > >
> > > > > Here are some examples of how I envision this would work.
> > > > >
> > > > > Let's suppose we have a SPI controller that has some sort of offl=
oad
> > > > > capability with a configurable trigger source. The trigger can ei=
ther
> > > > > be an internal software trigger (i.e. writing a register of the S=
PI
> > > > > controller) or and external trigger (i.e. a input signal from a p=
in on
> > > > > the SoC). The SPI controller has a lookup table with 8 slots wher=
e it
> > > > > can store a series of SPI commands that can be played back by
> > > > > asserting the trigger (this is what provides the "offloading").
> > > > >
> > > > > So this SPI controller would have #spi-offload-cells =3D <2>; whe=
re the
> > > > > first cell would be the index in the lookup table 0 to 7 and the
> > > > > second cell would be the trigger source 0 for software or 1 for
> > > > > hardware.
> > > > >
> > > > > Application 1: a network controller
> > > > >
> > > > > This could use two offloads, one for TX and one for RX. For TX, w=
e use
> > > > > the first slot with a software trigger because the data is coming=
 from
> > > > > Linux. For RX we use the second slot with a hardware trigger since
> > > > > data is coming from the network controller (i.e. a data ready sig=
nal
> > > > > that would normally be wired to a gpio for interrupt but wired to=
 the
> > > > > SPI offload trigger input pin instead). So the peripheral bindings
> > > > > would be:
> > > > >
> > > > > #define SOFTWARE_TRIGGER 0
> > > > > #define HARDWARE_TRIGGER 1
> > > > >
> > > > > can@0 {
> > > > >     ...
> > > > >     spi-offloads =3D <0 SOFTWARE_TRIGGER>, <1 HARDWARE_TRIGGER>;
> > > > >     /* maybe we need names too? */
> > > > >     spi-offload-names =3D "tx", "rx";
> > > > > };
> > > > >
> > > > > In this case, there is nothing extra beyond the SPI controller an=
d the
> > > > > network controller, so no extra bindings beyond this are needed.
> > > > >
> > > > > Application 2: an advanced ADC + FPGA
> > > > >
> > > > > This is basically the same as the ad7944 case seen already with o=
ne
> > > > > extra feature. In this case, the sample data also contains a CRC =
byte
> > > > > for error checking. So instead of SPI RX data going directly to D=
MA,
> > > > > the FPGA removes the CRC byte from the data stream an only the sa=
mple
> > > > > data goes to the DMA buffer. The CRC is checked and if bad, an
> > > > > interrupt is asserted.
> > > > >
> > > > > Since this is an FPGA, most everything is hardwired rather than h=
aving
> > > > > any kind of mux selection so #spi-offload-cells =3D <1>; for this
> > > > > controller.
> > > > >
> > > > > By adding spi-offloads to the peripheral node, it also extends the
> > > > > peripheral binding to include the additional properties needed fo=
r the
> > > > > extra features provided by the FPGA. In other words, we are saying
> > > > > this DT node now represents the ADC chip plus everything connecte=
d to
> > > > > the offload instance used by the ADC chip.
> > > >
> > > > It seems very strange to me that the dmas and the clock triggers are
> > > > going into the spi device nodes. The description is
> > > > | +  dmas:
> > > > | +    maxItems: 1
> > > > | +    description: RX DMA Channel for receiving a samples from the=
 SPI offload.
> > > > But as far as I can tell this device is in a package of its own and=
 not
> > > > some IP provided by Analog that an engine on the FPGA can actually =
do
> > > > DMA to, and the actual connection of the device is "just" SPI.
> > > > The dmas and clock triggers etc appear to be resources belonging to=
 the
> > > > controller that can "assigned" to a particular spi device. If the a=
dc
> > > > gets disconnected from the system, the dmas and clock triggers are =
still
> > > > connected to the spi controller/offload engine, they don't end up n=
/c,
> > > > right? (Well maybe they would in the case of a fancy SPI device that
> > > > provides it's own sampling clock or w/e, but then it'd be a clock
> > > > provider of sorts). I'd be expecting the spi-offloads property to be
> > > > responsible for selecting which of the various resources belonging =
to
> > > > the controller are to be used by a device.
> > > > Maybe it overcomplicates the shit out of things and Rob or Mark are
> > > > gonna start screaming at me but w/e, looking at it from the point of
> > > > view of how the hardware is laid out (or at least how it is describ=
ed
> > > > in your FPGA case above) the dma/clock properties looks like they're
> > > > misplaced. IOW, I don't think that adding the spi-offloads property
> > > > should convert a node from representing an ADC in a qfn-20 or w/e
> > > > to "the ADC chip plus everything connected to the offload instance
> > > > used by the ADC chip".
> > >
> > > This is the same reasoning that led me to the binding proposed in v1.
> > > Rob suggested that these extras (dmas/clocks) should just be
> > > properties directly of the SPI controller.
> >
> > > But the issue I have with
> > > that is that since this is an FPGA, these properties are not fixed.
> >
> > I don't think whether or not we're talking about an FPGA or an ASIC
> > matters at all here to be honest. In my view the main thing that FPGA
> > impact in terms of bindings is the number of properties required to
> > represent the configurability of a particular IP. Sure, you're gonna
> > have to change the dts around in a way you'll never have to with an
> > ASIC, but the description of individual devices or relations between
> > them doesn't change.
> >
> > > Maybe there are more clocks or no clocks or interrupts or something we
> > > didn't think of yet.
> >
> > This could happen with a new generation of an ASIC and is not specific
> > to an FPGA IP core. Even with FPGA IP, while there may be lots of
> > different configuration parameters, they are known & limited - you can
> > look at the IP's documentation (or failing that, the HDL) to figure out
> > what the points of variability are. It's not particularly difficult to
> > account for there being a configurable number of clocks or interrupts.
> > For "something we didn't think of yet" to be a factor, someone has to
> > think of it and add it to the IP core, and which point we can absolutely
> > change the bindings and software to account for the revised IP.
> >
> > > So it doesn't really seem possible to write a
> > > binding for the SPI controller node to cover all of these cases.
> >
> > I dunno, I don't think your concerns about numbers of clocks (or any
> > other such property) are unique to this particular use-case.
> >
> > > These
> > > extras are included in the FPGA bitstream only for a specific type of
> > > peripheral, not for general use of the SPI controller with any type of
> > > peripheral.
> >
> > I accept that, but what I was trying to get across was that you could
> > configure the FPGA with a bitstream that contains these extra resources
> > and then connect a peripheral device that does not make use of them at
> > all.
>=20
> Sure, in this case the peripheral has no spi-offloads property and the
> SPI controller acts as a typical SPI controller.
>=20
> > Or you could connect a range of different peripherals that do use
> > them.
>=20
> OK, you've got me thinking about something I hadn't really thought about =
yet.
>=20
> > Whether or not the resources are there and how they are connected
> > in the FPGA bitstream is not a property of the device connected to the
> > SPI controller, only whether or not you use them is.
> >
>=20
> Even when those things are connected directly to a specific peripheral
> device? Or not connected to the offload?
>=20
> Here is another potential ADC trigger case to consider.
>=20
> +-------------------------------+   +------------------+
> |                               |   |                  |
> |  SOC/FPGA                     |   |  ADC             |
> |  +---------------------+      |   |                  |
> |  | AXI SPI Engine      |      |   |                  |
> |  |             SPI Bus =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D SPI Bus    =
      |
> |  |                     |      |   |                  |
> |  |  +---------------+  |  < < < < < BUSY             |
> |  |  | Offload 0     |  | v    |   |                  |
> |  |  |               |  | v  > > > > CNV              |
> |  |  |    TRIGGER IN < < <   ^ |   |                  |
> |  |  +---------------+  |    ^ |   +------------------+
> |  +---------------------+    ^ |
> |  | AXI PWM             |    ^ |
> |  |                 CH0 >  > ^ |
> |  +---------------------+      |
> |                               |
> +-------------------------------+
>=20
> This time, the periodic trigger (PWM) is connected to the pin on the
> ADC that triggers a sample conversion (CNV). The ADC has a BUSY output
> that will go high at the start of the conversion and go low at the end
> of the conversion. The BUSY output of the ADC is wired as the hardware
> trigger input of the offload.
>=20
> In this case would we still consider the PWM as part of the SPI
> controller/offload since it can only be used in conjunction with the
> SPI offload? It isn't connected to it at all though.

No, in this case the ADC is a PWM consumer and the offload engine is
not. The ADC is a "trigger" provider and the SPI offload engine is a
trigger consumer.

> Another case could be a self-clocked ADC. Here, the ADC has it's own
> periodic sample trigger on the chip and the RDY output goes high
> whenever a sample is ready to read.
>=20
> +-------------------------------+   +------------------+
> |                               |   |                  |
> |  SOC/FPGA                     |   |  ADC             |
> |  +---------------------+      |   |                  |
> |  | AXI SPI Engine      |      |   |                  |
> |  |             SPI Bus =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D SPI Bus    =
      |
> |  |                     |      |   |                  |
> |  |  +---------------+  |  < < < < < RDY              |
> |  |  | Offload 0     |  | v    |   |                  |
> |  |  |               |  | v    |   |                  |
> |  |  |    TRIGGER IN < < <     |   |                  |
> |  |  +---------------+  |      |   +------------------+
> |  +---------------------+      |
> |                               |
> +-------------------------------+
>=20
> If both of these are valid wiring configurations for the same ADC,
> wouldn't it make more sense to describe this in the peripheral node
> rather than having to query the controller to see how the peripheral
> is wired up?

In both of these cases, the offload works in the same way, it gets a
trigger from the ADC and acts upon it. I would expect that in this case
the ADC driver would look for an optional pwm property in the devicetree
and if it is present configure the ADC to use that and if absent do then
do whatever configuration is required for self clocking. I would expect
that both cases would be handled identically by the SPI [offload] engine
side of things, other than inverting the polarity of the trigger. (If I
understand correctly, you want to trigger the offload engine on a
falling edge of BUSY but a rising edge of RDY).


> > In fact, looking at the documentation for the "spi engine" some more, I
> > am even less convinced that the right place for describing the offload =
is
> > the peripheral as I (finally?) noticed that the registers for the offlo=
ad
> > engine are mapped directly into the "spi engine"'s memory map, rather t=
han
> > it being a entirely separate IP in the FPGA fabric.
>=20
> True, but we don't use these registers, e.g., to configure the
> sampling frequency of a trigger (if it can even be done). That is done
> in a completely separate IP block with it's own registers.

Where is the binding for that IP block? I think describing that is
pretty key. goto continuation;

> > Further, what resources are available depends on what the SPI offload
> > engine IP is. If my employer decides to start shipping some SPI offload
> > IP in our catalogue that can work with ADI's ADCs, the set of offload
> > related properties or their names may well differ.
>=20
> If all of these resources were fairly generic, like the periodic
> trigger we've been discussing, then I could see the case for trying to
> accommodate this the same way we do for other common features of SPI
> controllers. But for cases like "Application 2" that I described
> previously, these resources can get very specific to a peripheral
> (like the example given of having a data processing unit that knows
> about the exact data format and CRC algorithm used by a specific ADC).
> These seems like too specific of a thing to say that a SPI controller
> "supports".

To remind myself, "Application 2" featured an offload engine designed
specifically to work with a particular data format that would strip a
CRC byte and check the validity of the data stream.

I think you're right something like that is a stretch to say that that
is a feature of the SPI controller - but I still don't believe that
modelling it as part of the ADC is correct. I don't fully understand the
io-backends and how they work yet, but the features you describe there
seem like something that should/could be modelled as one, with its own
node and compatible etc. Describing custom RTL stuff ain't always
strightforward, but the stuff from Analog is versioned and documented
etc so it shouldn't be quite that hard.

continuation:
If offload engines have their own register region in the memory map,
their own resources (the RTL is gonna need at the very least a clock)
and potentially also provide other services (like acting as an
io-backend type device that pre-processes data) it doesn't sound like
either the controller or peripheral nodes are the right place for these
properties. And uh, spi-offloads gets a phandle once more...

FWIW, I did read these examples but didn't feel it was worth commenting
on them given the above. I'll comment on them if they stay "accurate".

Cheers,
Conor.

> But, OK, let's go with the idea of putting everything related to the
> offloads in the SPI controller node an see where it takes us...
>=20
> spi@1000 {
>     compatible =3D "adi,axi-spi-engine";
>     #spi-offload-cells =3D <1>;
>     /* PWM is connected to offload hardware trigger. DMA for streaming sa=
mple
>      * data can only handle 16-bit words. IIO hardware buffer will be CPU-
>      * endian because data is streamed one word at a time. */
>     spi-offload-0-capabilities =3D "pwm-trigger", "16-bit-rx-dma";
>=20
>     /* pwm properties are only allowed because spi-offload-0-capabilities
>      * contains "pwm-trigger" */
>     pwms =3D <&pwm 0>;
>     pwm-names =3D "offload-0-pwm-trigger";
>=20
>     /* dma properties are only allowed because spi-offload-0-capabilities
>      * contains "16-bit-rx-dma" */
>     dmas =3D <&dma 0>;
>     dma-names =3D "offload-0-16-bit-rx";
>=20
>     ...
>=20
>     adc@0 {
>         compatible =3D "adi,ad7944";
>         spi-offloads =3D <0>;
>         ...
>     };
> };
>=20
> spi@2000 {
>     compatible =3D "not-adi,other-spi-engine";
>     #spi-offload-cells =3D <1>;
>     /* Clock is connected to offload hardware trigger. DMA for streaming =
sample
>      * data can only handle one byte at a time. IIO hardware buffer will =
be big-
>      * endian because data is streamed one byte at a time. */
>     spi-offload-0-capabilities =3D "clock-trigger", "8-bit-rx-dma";
>=20
>     /* Clock properties are extended because spi-offload-0-capabilities c=
ontains
>      * "clock-trigger" and SPI controller itself has a clock */
>     clocks =3D <&cpu_clock 0>, <&extra_clock 0>;
>     clock-names =3D "sclk", "offload-0-pwm-trigger";
>=20
>     /* DMA properties are extended because spi-offload-0-capabilities con=
tains
>      * "8-bit-rx-dma". "tx" and "rx" are for non-offload use. */
>     dmas =3D <&dma1 0>, <&dma1 1>, <&dma2 0>;
>     dma-names =3D "tx", "rx", "offload-0-16-bit-rx";
>=20
>     ...
>=20
>     adc@0 {
>         compatible =3D "adi,ad7944";
>         spi-offloads =3D <0>;
>         ...
>     };
> };
>=20
> spi@3000 {
>     compatible =3D "adi,axi-spi-engine";
>     #spi-offload-cells =3D <1>;
>     /* Sample ready signal (~BSY) from ADC is connected to offload hardwa=
re
>      * trigger. DMA for streaming sample data can only handle 16-bit word=
s. */
>     spi-offload-0-capabilities =3D "sample-trigger", "16-bit-rx-dma";
>=20
>     /* Do we need a property to say that the sample trigger is connected =
to
>      * adc@0 so that if adc@1 tries to use it, it will fail? */
>=20
>     /* dma properties are only allowed because spi-offload-0-capabilities
>      * contains "16-bit-rx-dma" */
>     dmas =3D <&dma 0>;
>     dma-names =3D "offload-0-16-bit-rx";
>=20
>     ...
>=20
>     adc@0 {
>         compatible =3D "adi,ad7944";
>         spi-offloads =3D <0>;
>         ...
>=20
>         /* PWM connected to the conversion pin (CNV). This only makes sen=
se
>          * when offload is used with BSY signal, otherwise we would have =
CNV
>          * connected to SPI CS. */
>         pwms =3D <&pwm 0>;
>         pwm-names =3D "cnv";
>     };
> };
>=20
> spi@4000 {
>     compatible =3D "adi,axi-spi-engine";
>     #spi-offload-cells =3D <1>;
>     /* Sample ready signal (~BSY) from ADC is connected to offload hardwa=
re
>      * trigger. DMA for streaming sample data can only handle 32-bit word=
s.
>      * This also has the CRC validation that strips off the CRC byte of t=
he
>      * raw data before passing the sample to DMA. */
>     spi-offload-0-capabilities =3D "sample-trigger",
>                                  "32-bit-rx-dma-with-ad4630-crc-check";
>=20
>     /* dma properties are only allowed because spi-offload-0-capabilities
>      * contains "16-bit-rx-dma" */
>     dmas =3D <&dma 0>;
>     dma-names =3D "offload-0-16-bit-rx";
>=20
>     interrupt-parent =3D <&intc>;
>     /* First interrupt is for the SPI controller (always present), second
>      * interrupt is CRC error from the "32-bit-rx-dma-with-ad4630-crc-che=
ck"
>      * of offload 0. */
>     interrupts =3D <0 56 IRQ_TYPE_LEVEL_HIGH>, <0 58 IRQ_TYPE_LEVEL_HIGH>;
>     interrupt-names =3D "controller", "offload-0-crc-error";
>=20
>     ...
>=20
>     adc@0 {
>         compatible =3D "adi,ad4630";
>         spi-offloads =3D <0>;
>         ...
>=20
>         /* PWM connected to the conversion pin (CNV). Without offload, we=
 would
>          * have cnv-gpios instead. */
>         pwms =3D <&pwm 0>;
>         pwm-names =3D "cnv";
>     };
> };
>=20
> So this is what I came up with of how things could look (combining
> suggestions from Rob in v1 and Conor's suggestions here). I can see
> how we can make this work. But the thing I don't like about it is that
> the peripheral drivers still need to know all of the information about
> the offload capabilities and need to interact with the
> pwms/clocks/interrupts/dmas/etc. So this is just adding layers of
> indirection where all of this stuff has to go through the SPI
> controller driver.
>=20
>=20
> >
> > > Another idea I had was to perhaps use the recently added IIO backend
> > > framework for the "extras". The idea there is that we are creating a
> > > "composite" IIO device that consists of the ADC chip (frontend) plus
> > > these extra hardware trigger and hardware buffer functions provided by
> > > the FPGA (backend).
> > >
> > > offload_backend: adc0-backend {
> > >     /* http://analogdevicesinc.github.io/hdl/projects/pulsar_adc/inde=
x.html */
> > >     compatible =3D "adi,pulsar-adc-offload";
> > >     #io-backend-cells =3D <0>;
> > >     dmas =3D <&dma 0>;
> > >     dma-names =3D "rx";
> > >     clocks =3D <&trigger_clock>;
> > > };
> > >
> > > spi {
> > >     ...
> > >     adc@0 {
> > >         ...
> > >         spi-offloads =3D <0>;
> > >         io-backends =3D <&offload_backend>;
> > >     };
> > > };
> > >
> > > While this could be a solution for IIO devices, this wouldn't solve
> > > the issue in general though for SPI offloads used with non-IIO
> > > peripherals.
> >
> > Yeah, I agree that using something specific to IIO isn't really a good
> > solution.
> >
> > Cheers,
> > Conor.
> >
> > > So I don't think it is the right thing to do here. But, I
> > > think this idea of a "composite" device helps explain why we are
> > > pushing for putting the "extras" with the peripheral node rather than
> > > the controller node, at least for the specific case of the AXI SPI
> > > Engine controller.
> >

--tCE84TRCfzbvxkUd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZk44eQAKCRB4tDGHoIJi
0o/6AQD2xUt39/zHT+PM43Hq14OnATMnSe8y8hBwtSGw4K/hTQD+OWb3N3s7jthC
UtQGPT6fqgYkqE77VC6HsMIqOOc8fQE=
=FlGF
-----END PGP SIGNATURE-----

--tCE84TRCfzbvxkUd--

