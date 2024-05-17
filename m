Return-Path: <linux-iio+bounces-5091-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 060FD8C8A57
	for <lists+linux-iio@lfdr.de>; Fri, 17 May 2024 18:52:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6399EB223A4
	for <lists+linux-iio@lfdr.de>; Fri, 17 May 2024 16:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F23A913D8B1;
	Fri, 17 May 2024 16:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="L4EYPxk2"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E321B13D887
	for <linux-iio@vger.kernel.org>; Fri, 17 May 2024 16:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715964734; cv=none; b=R1qUgqN9AL0+HZhmNTy5a0I3Uzt7zbzkPMt56YX3HQgkYoi20TJ9MZp0/xEXGBjBrGa8cHJjzrqDjLFMm0umXF5nrv6tJfYT2fUedxJokvtbQ0w5sbeboS2sQIeFJKj3C1GYCSIbGhtTCilT+rVxN2ZUX1Ba0ZMuNdJTVFZQ+Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715964734; c=relaxed/simple;
	bh=wCdQPm3TWk40mZIVA9NiXHxECOGHT7CZs9DpADjc9MA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QWM61Asjd4ra1eGObbCah8ux+uW/+ksP3WGAdb1ZLchySX6u1Nm6w33amOcl/NigWaFSX73m7cAnYLCcQNgfsjDHcsR+IrdodR0UhJ1mDNvXcmsJnqQnXsTwGKnJ9I/KCNdZWOFIoAbePYo8Zfx4lDn2Pzcstp5/zVZgTa/2szs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=L4EYPxk2; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2e3fa13f018so11170061fa.3
        for <linux-iio@vger.kernel.org>; Fri, 17 May 2024 09:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1715964730; x=1716569530; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TmNPF6G5eFiHm3shVWK0oE4Q5mdESrJ/689hVEQXFGs=;
        b=L4EYPxk25fQMngx0qg+btji6kM/nd91XsRHlRJ3zKwyXQhzhJZKL4d6LoWIw/bvt6P
         EiDsb1kkodVJYY8X06G1nNW8C8UVRiPHcJWatScyutvsq822vxdIJjuFP4MPTmPJjx2s
         tbKsqPA3Dp7Pl7fbjf2ELJ6InqTh03op1me+3pK+F1zZJVB/DTB8BW5ahd9qYriz77pN
         8/TUWfruIVdkExR0gKj9LFwEgez42JD/EXO2bHx7s+lOfKb+2WL7SH7HZ1V92d/HN+LU
         w49nGexhXsNnvqx9HUG7DjhjSMVQf7r225jM8i6mss9i0k1UFOSSetjiwZgvHIKwA+if
         V3gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715964730; x=1716569530;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TmNPF6G5eFiHm3shVWK0oE4Q5mdESrJ/689hVEQXFGs=;
        b=hpI0QA/taVpsjB2gSYMkEUsMEnxj7TqUmysw9EkStZ93r0RNPO3vT7Pyk114xmsN5O
         Dj+zGOWUsFfYe1Gv9yTmSMmg8wzsJzGbpw6F7w3aQXOqu5IRNKkg/BIxDHK4O8Il0dfS
         NDbOvyTY1jSs4XF4sguTLOZBMdT/iIks+Z3WT4PSK1ZwO4UyYVG5dS+1REw4k3DvLB4z
         qoj1TTKKfrmnRha94uQ7w8lu9+kTzLTdxqG4HV7tJKmtZ5Mwk0atvOfoR+2O8OAB31HD
         ZpxtEd/ytm2N12wLDsorHvBDiLZ3oYRzkMz/BFJCa0crUKKeIpw69NsF6C4+yqhsPtV3
         OCww==
X-Forwarded-Encrypted: i=1; AJvYcCWmqKzmNavdajOufJRAeMi6+IIx2M0CtsVbvNo2uadRHNfQjHNnuAF8Q2KNUC0pibJhlvU/nQsEu+Eyt8OD7d1TeqwT8VZyB+G1
X-Gm-Message-State: AOJu0YyK8yiCxqtkTEuQBN6Nwhd6xh4gAxTJ8UXKmHbUy0jDvp7lZKrm
	QcI9Wm7kVv3XM5OvnsbqN3TtYSkNGL2UGfqsVn4SiMZkGIMaN0hwHQsCFGQVme928lIcbSBS48n
	TgvXhDC2gtYV8fyQhg0X2VXu26DLZPuYD8DtZJg==
X-Google-Smtp-Source: AGHT+IG+3UsPHUtMCRzvR9f7I4JA+MpHdvVRvgfwtyVmBmUsAlmk4WcxA4fg1b2fKeSx5lO4y/iJ5vJuwZ8FcMI7MOY=
X-Received: by 2002:a2e:b0db:0:b0:2d6:dba1:6d37 with SMTP id
 38308e7fff4ca-2e51fd2d389mr141339221fa.11.1715964729777; Fri, 17 May 2024
 09:52:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240510-dlech-mainline-spi-engine-offload-2-v2-0-8707a870c435@baylibre.com>
 <20240510-dlech-mainline-spi-engine-offload-2-v2-1-8707a870c435@baylibre.com>
 <20240513-headsman-hacking-d51fcc811695@spud> <CAMknhBE5XJzhdJ=PQUXiubw_CiCLcn1jihiscnQZUzDWMASPKw@mail.gmail.com>
 <20240514-aspire-ascension-449556da3615@spud> <CAMknhBFFpEGcMoLo5gsC11Syv+CwUM0mnq1yDMUzL1uutUtB+Q@mail.gmail.com>
 <20240516-rudder-reburial-dcf300504c0a@spud>
In-Reply-To: <20240516-rudder-reburial-dcf300504c0a@spud>
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 17 May 2024 11:51:58 -0500
Message-ID: <CAMknhBF_s0btus4yqPe-T=F3z7Asi9KkRGsGr7FHDFi=k4EQjw@mail.gmail.com>
Subject: Re: [PATCH RFC v2 1/8] spi: dt-bindings: spi-peripheral-props: add
 spi-offloads property
To: Conor Dooley <conor@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, 
	David Jander <david@protonic.nl>, Martin Sperl <kernel@martin.sperl.org>, linux-spi@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 16, 2024 at 4:32=E2=80=AFPM Conor Dooley <conor@kernel.org> wro=
te:
>
> Yo,
>
> Sorry for the delay, long reply deserved some time to sit and think
> about it.
>
> On Tue, May 14, 2024 at 05:56:47PM -0500, David Lechner wrote:
> > On Tue, May 14, 2024 at 1:46=E2=80=AFPM Conor Dooley <conor@kernel.org>=
 wrote:
> > >
> > > On Mon, May 13, 2024 at 12:06:17PM -0500, David Lechner wrote:
> > > > On Mon, May 13, 2024 at 11:46=E2=80=AFAM Conor Dooley <conor@kernel=
.org> wrote:
> > > > >
> > > > > On Fri, May 10, 2024 at 07:44:24PM -0500, David Lechner wrote:
> > > > > > This adds a new property to the spi-peripheral-props binding fo=
r use
> > > > > > with peripherals connected to controllers that support offloadi=
ng.
> > > > > >
> > > > > > Here, offloading means that the controller has the ability to p=
erform
> > > > > > complex SPI transactions without CPU intervention in some shape=
 or form.
> > > > > >
> > > > > > This property will be used to assign controller offload resourc=
es to
> > > > > > each peripheral that needs them. What these resources are will =
be
> > > > > > defined by each specific controller binding.
> > > > > >
> > > > > > Signed-off-by: David Lechner <dlechner@baylibre.com>
> > > > > > ---
> > > > > >
> > > > > > v2 changes:
> > > > > >
> > > > > > In v1, instead of generic SPI bindings, there were only control=
ler-
> > > > > > specific bindings, so this is a new patch.
> > > > > >
> > > > > > In the previous version I also had an offloads object node that=
 described
> > > > > > what the offload capabilities were but it was suggested that th=
is was
> > > > > > not necessary/overcomplicated. So I've gone to the other extrem=
e and
> > > > > > made it perhaps over-simplified now by requiring all informatio=
n about
> > > > > > how each offload is used to be encoded in a single u32.
> > > > >
> > > > > The property is a u32-array, so I guess, not a single u32?
> > > >
> > > > It is an array to handle cases where a peripheral might need more t=
han
> > > > one offload. But the idea was it put everything about each individu=
al
> > > > offload in a single u32. e.g. 0x0101 could be offload 1 with hardwa=
re
> > > > trigger 1 and 0x0201 could be offload 1 with hardware trigger 2. Th=
en
> > > > a peripheral could have spi-offloads =3D <0x0101>, <0x0201>; if it
> > > > needed to select between both triggers at runtime.
> > > >
> > > > >
> > > > > > We could of course consider using #spi-offload-cells instead fo=
r
> > > > > > allowing encoding multiple parameters for each offload instance=
 if that
> > > > > > would be preferable.
> > > > >
> > > > > A -cells property was my gut reaction to what you'd written here =
and
> > > > > seems especially appropriate if there's any likelihood of some fu=
ture
> > > > > device using some external resources for spi-offloading.
> > > > > However, -cells properties go in providers, not consumers, so it =
wouldn't
> > > > > end up in spi-periph-props.yaml, but rather in the controller bin=
ding,
> > > > > and instead there'd be a cell array type property in here. I thin=
k you
> > > > > know that though and I'm interpreting what's been written rather =
than
> > > > > what you meant.
> > > >
> > > > Indeed you guess correctly. So the next question is if it should be
> > > > the kind of #-cells that implies a phandle like most providers or
> > > > without phandles like #address-cells?
> > >
> > > I'm trying to understand if the offload could ever refer to something
> > > beyond the controller that you'd need the phandle for. I think it wou=
ld
> > > be really helpful to see an example dt of a non-trivial example for h=
ow
> > > this would work. The example in the ad7944 patch has a stub controlle=
r
> > > node & the clocks/dmas in the peripheral node so it is difficult to
> > > reason about the spi-offloads property there.
> >
> > The fully implemented and tested version of the .dts corresponding to
> > the hardware pictured in the cover letter can be found at [1].
> >
> > [1]: https://github.com/dlech/linux/blob/axi-spi-engine-offload-v2/arch=
/arm/boot/dts/xilinx/zynq-zed-adv7511-ad7986.dts
>
> Unfortunately this is a trivial example, so there's not much to be
> gained in new information from the example in the bindings :/ Your
> examples below are good though, which makes up for that and more.
>
> > To be clear though, the idea that I am proposing here is that if there
> > is something beyond the SPI controller directly connected to the
> > offload, then we would add those things in the peripheral node along
> > with the spi-offloads property that specifies the offload those other
> > things are connected to.
> >
> > Tangent on phandle vs. no phandle:
>
> Yeah, I think not having a phandle makes sense based on what you've
> said.
>
> > Back to "something beyond the SPI controller":
> >
> > Here are some examples of how I envision this would work.
> >
> > Let's suppose we have a SPI controller that has some sort of offload
> > capability with a configurable trigger source. The trigger can either
> > be an internal software trigger (i.e. writing a register of the SPI
> > controller) or and external trigger (i.e. a input signal from a pin on
> > the SoC). The SPI controller has a lookup table with 8 slots where it
> > can store a series of SPI commands that can be played back by
> > asserting the trigger (this is what provides the "offloading").
> >
> > So this SPI controller would have #spi-offload-cells =3D <2>; where the
> > first cell would be the index in the lookup table 0 to 7 and the
> > second cell would be the trigger source 0 for software or 1 for
> > hardware.
> >
> > Application 1: a network controller
> >
> > This could use two offloads, one for TX and one for RX. For TX, we use
> > the first slot with a software trigger because the data is coming from
> > Linux. For RX we use the second slot with a hardware trigger since
> > data is coming from the network controller (i.e. a data ready signal
> > that would normally be wired to a gpio for interrupt but wired to the
> > SPI offload trigger input pin instead). So the peripheral bindings
> > would be:
> >
> > #define SOFTWARE_TRIGGER 0
> > #define HARDWARE_TRIGGER 1
> >
> > can@0 {
> >     ...
> >     spi-offloads =3D <0 SOFTWARE_TRIGGER>, <1 HARDWARE_TRIGGER>;
> >     /* maybe we need names too? */
> >     spi-offload-names =3D "tx", "rx";
> > };
> >
> > In this case, there is nothing extra beyond the SPI controller and the
> > network controller, so no extra bindings beyond this are needed.
> >
> > Application 2: an advanced ADC + FPGA
> >
> > This is basically the same as the ad7944 case seen already with one
> > extra feature. In this case, the sample data also contains a CRC byte
> > for error checking. So instead of SPI RX data going directly to DMA,
> > the FPGA removes the CRC byte from the data stream an only the sample
> > data goes to the DMA buffer. The CRC is checked and if bad, an
> > interrupt is asserted.
> >
> > Since this is an FPGA, most everything is hardwired rather than having
> > any kind of mux selection so #spi-offload-cells =3D <1>; for this
> > controller.
> >
> > By adding spi-offloads to the peripheral node, it also extends the
> > peripheral binding to include the additional properties needed for the
> > extra features provided by the FPGA. In other words, we are saying
> > this DT node now represents the ADC chip plus everything connected to
> > the offload instance used by the ADC chip.
>
> It seems very strange to me that the dmas and the clock triggers are
> going into the spi device nodes. The description is
> | +  dmas:
> | +    maxItems: 1
> | +    description: RX DMA Channel for receiving a samples from the SPI o=
ffload.
> But as far as I can tell this device is in a package of its own and not
> some IP provided by Analog that an engine on the FPGA can actually do
> DMA to, and the actual connection of the device is "just" SPI.
> The dmas and clock triggers etc appear to be resources belonging to the
> controller that can "assigned" to a particular spi device. If the adc
> gets disconnected from the system, the dmas and clock triggers are still
> connected to the spi controller/offload engine, they don't end up n/c,
> right? (Well maybe they would in the case of a fancy SPI device that
> provides it's own sampling clock or w/e, but then it'd be a clock
> provider of sorts). I'd be expecting the spi-offloads property to be
> responsible for selecting which of the various resources belonging to
> the controller are to be used by a device.
> Maybe it overcomplicates the shit out of things and Rob or Mark are
> gonna start screaming at me but w/e, looking at it from the point of
> view of how the hardware is laid out (or at least how it is described
> in your FPGA case above) the dma/clock properties looks like they're
> misplaced. IOW, I don't think that adding the spi-offloads property
> should convert a node from representing an ADC in a qfn-20 or w/e
> to "the ADC chip plus everything connected to the offload instance
> used by the ADC chip".

This is the same reasoning that led me to the binding proposed in v1.
Rob suggested that these extras (dmas/clocks) should just be
properties directly of the SPI controller. But the issue I have with
that is that since this is an FPGA, these properties are not fixed.
Maybe there are more clocks or no clocks or interrupts or something we
didn't think of yet. So it doesn't really seem possible to write a
binding for the SPI controller node to cover all of these cases. These
extras are included in the FPGA bitstream only for a specific type of
peripheral, not for general use of the SPI controller with any type of
peripheral.

Another idea I had was to perhaps use the recently added IIO backend
framework for the "extras". The idea there is that we are creating a
"composite" IIO device that consists of the ADC chip (frontend) plus
these extra hardware trigger and hardware buffer functions provided by
the FPGA (backend).

offload_backend: adc0-backend {
    /* http://analogdevicesinc.github.io/hdl/projects/pulsar_adc/index.html=
 */
    compatible =3D "adi,pulsar-adc-offload";
    #io-backend-cells =3D <0>;
    dmas =3D <&dma 0>;
    dma-names =3D "rx";
    clocks =3D <&trigger_clock>;
};

spi {
    ...
    adc@0 {
        ...
        spi-offloads =3D <0>;
        io-backends =3D <&offload_backend>;
    };
};

While this could be a solution for IIO devices, this wouldn't solve
the issue in general though for SPI offloads used with non-IIO
peripherals. So I don't think it is the right thing to do here. But, I
think this idea of a "composite" device helps explain why we are
pushing for putting the "extras" with the peripheral node rather than
the controller node, at least for the specific case of the AXI SPI
Engine controller.

>
> > adc@0 {
> >     ...
> >     spi-offloads =3D <0>;
> >     dmas =3D <&dma 0>; /* channel receiving split out sample data */
> >     dma-names =3D "rx";
> >     interrupts =3D <&intc 99>; /* interrupt for bad CRC */
> >     interrupt-names =3D "crc";
> > };
> >
> > >
> > > > Asking because I got pushback on
> > > > v1 for using a phandle with offloads (although in that case, the
> > > > phandle was for the offload instance itself instead for the SPI
> > > > controller, so maybe this is different in this case?).
> > >
> > > Do you have a link to this v1 pushback?
> >
> > Hmm... maybe that was from some internal review before v1 that I was
> > remembering and confusing with the resistance of different aspects you
> > mention below.
> >
> > > I had looked at the v1's binding
> > > comments and didn't see that type of property being resisted - althou=
gh
> > > I did see some resistance to the spi peripheral node containing any o=
f
> > > the information about the offloads it had been assigned and instead
> > > doing that mapping in the controller so that the cs was sufficient. I
> > > don't think that'd work with the scenario you describe above though
> > > where there could be two different triggers per device tho.
> >
> > I think most of the objection was to having an offloads object node
> > with offload@ subnodes in the SPI controller node along side the
> > peripheral nodes.
>
> I dunno, that was my reading of Rob's comments at least. I know he had
> more than one objection though, so maybe we're just looking at different
> portions of it - I did note that you removed the offload@ though.
>
> Cheers,
> Conor.

