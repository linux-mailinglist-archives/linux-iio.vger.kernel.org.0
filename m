Return-Path: <linux-iio+bounces-5161-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B22378CB0C8
	for <lists+linux-iio@lfdr.de>; Tue, 21 May 2024 16:55:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25A8CB22C7D
	for <lists+linux-iio@lfdr.de>; Tue, 21 May 2024 14:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B894E142E65;
	Tue, 21 May 2024 14:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="15jF+70K"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0BBC1E87C
	for <linux-iio@vger.kernel.org>; Tue, 21 May 2024 14:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716303295; cv=none; b=PRFmqZIXUPTRiS6Jm/or5IibI4CGfGTmfvzHeqIQhPshjVIMDrTj+VHgKOM7f+wE5deuaHK43/RdxQKUq6xEEr6NoFle5BF94yAYbyXoUJS3WsF281XhXPR1D5mqojQAh6GoAlwtdF2782ThTSMj7bqPrYG9jrAMO/EmJwY85OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716303295; c=relaxed/simple;
	bh=HExgP0UYmWHiIsG1bF7bZ/RKwazxb3rDDOvRb04YALU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HgF12w6TlUQSyDQvmBK5L8hKb5qGmtm3LUjnBSihTJp0PBRd9oGFpMsbV5wcUQs/Ldq1f0UQQFE+5q4Q81/BzqjTiP5l8vJPh3OTWFxuzjgcovMFn9KHEQumr1lWf8AWV3h++Y013EomUFzZXRRIagy4OgSlEUxfHH+dgOW0auQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=15jF+70K; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2e716e3030aso35060761fa.2
        for <linux-iio@vger.kernel.org>; Tue, 21 May 2024 07:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1716303291; x=1716908091; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UFu95vOoj5bW2XTxghArbd4qSupe0m5MmILzZ30l7Aw=;
        b=15jF+70KSeCvYTvP8SJ/CYiNXtKpONI1YdvEx/HTJlhKzjovqGoQo64XPrFZiF7sOD
         dKegC9zl0ibkZdQRb2IFT/b4A9ha4i3luzcAljZLF6mFDtVgbB2cCZtt5qPh9wPUrYvX
         osoUmApFOQmRfhszXyJ6FOv1EOixUWGehiiYAPf+hRmNkTfvx0/xva1UmnZ/IgHkk44U
         AmXyPBnG32+/nJPrEVgcYiRQHJIkDKZAaGSydV90Wm/6YkRfStNYdC8HVHzeqXnM4MCu
         2pavInw/OWIIGMMXmA3xAMpXWAViCV52aBUMoQpjShFTygsR1AGnrWzWG6aj4tNdC79n
         ScWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716303291; x=1716908091;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UFu95vOoj5bW2XTxghArbd4qSupe0m5MmILzZ30l7Aw=;
        b=GR9ojxDhU4v0/aT2tZfuI0ZaCwfoCZMm9JYhQzdD2Wa+TpDAgr826wfuLaS1xJBwGS
         DMKOU+u9RHr4N9TjWDU1U9xOiS4HPmLrXYNYkT8j8/LVoBvCPnvg7N7JbkckDAsoP6Ss
         B+NBve/uWLTIlAfSFF6IrtlF3wm1oN+E+jqbxS9e5VXakRwJFzc3irKEvRepvhPjfy2Q
         WQjbJkxVr1yggOLJHQJ758TLJQJWNCWSbteGH5ml6ZFLkKJmYaNChcroQ5prlj868hW6
         IJltPIsE5NcEKWXts1tV9QPnqYB5qg3RI7Wbly1+rmCm5g7rw/L/0afPtSdodf5pBsLP
         4f/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXlx/kUAaJE9s3BeBvTxHQul1ZC7cp4LrHtQ/1RaPsLyOU5v1FQnH+eEj/2TV+mh99erf4NsT+D2cwzs3IDsuBo/38tQyhimWqu
X-Gm-Message-State: AOJu0Yx++Nvhnpht5+P/j1V0wVtfV8HyN4Syve/4UJ+BDJWiJKQCphTU
	miqRqs9u9XVjKoo1iQOyGpdpTC6iucGkhz0RgZiMCRHvelaa2zFxf9lBWu1FtvnICBiFc1CIJd0
	ImtVP573AvZFpazhcYJrSbLq5g9d9nfd30ZpIgA==
X-Google-Smtp-Source: AGHT+IFVYmMUhLQ6uaPUa1tT2O2q12IsuqvOx5rRrQ77BaVSBIev0JbPofsiRzB0pPiPWLa8XkOqvpKobu3A2sNzKhE=
X-Received: by 2002:a2e:95cc:0:b0:2e7:b29:c0a9 with SMTP id
 38308e7fff4ca-2e70b29c0e8mr88170311fa.30.1716303290827; Tue, 21 May 2024
 07:54:50 -0700 (PDT)
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
 <20240516-rudder-reburial-dcf300504c0a@spud> <CAMknhBF_s0btus4yqPe-T=F3z7Asi9KkRGsGr7FHDFi=k4EQjw@mail.gmail.com>
 <20240519-abreast-haziness-096a57ef57d3@spud>
In-Reply-To: <20240519-abreast-haziness-096a57ef57d3@spud>
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 21 May 2024 09:54:39 -0500
Message-ID: <CAMknhBHvEse2FyDoBXR1PvymGpSGq8dotKfm+8XH+0+k+xKtQw@mail.gmail.com>
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

On Sun, May 19, 2024 at 7:53=E2=80=AFAM Conor Dooley <conor@kernel.org> wro=
te:
>
> On Fri, May 17, 2024 at 11:51:58AM -0500, David Lechner wrote:
> > On Thu, May 16, 2024 at 4:32=E2=80=AFPM Conor Dooley <conor@kernel.org>=
 wrote:
> > > On Tue, May 14, 2024 at 05:56:47PM -0500, David Lechner wrote:
>
> > > > Back to "something beyond the SPI controller":
> > > >
> > > > Here are some examples of how I envision this would work.
> > > >
> > > > Let's suppose we have a SPI controller that has some sort of offloa=
d
> > > > capability with a configurable trigger source. The trigger can eith=
er
> > > > be an internal software trigger (i.e. writing a register of the SPI
> > > > controller) or and external trigger (i.e. a input signal from a pin=
 on
> > > > the SoC). The SPI controller has a lookup table with 8 slots where =
it
> > > > can store a series of SPI commands that can be played back by
> > > > asserting the trigger (this is what provides the "offloading").
> > > >
> > > > So this SPI controller would have #spi-offload-cells =3D <2>; where=
 the
> > > > first cell would be the index in the lookup table 0 to 7 and the
> > > > second cell would be the trigger source 0 for software or 1 for
> > > > hardware.
> > > >
> > > > Application 1: a network controller
> > > >
> > > > This could use two offloads, one for TX and one for RX. For TX, we =
use
> > > > the first slot with a software trigger because the data is coming f=
rom
> > > > Linux. For RX we use the second slot with a hardware trigger since
> > > > data is coming from the network controller (i.e. a data ready signa=
l
> > > > that would normally be wired to a gpio for interrupt but wired to t=
he
> > > > SPI offload trigger input pin instead). So the peripheral bindings
> > > > would be:
> > > >
> > > > #define SOFTWARE_TRIGGER 0
> > > > #define HARDWARE_TRIGGER 1
> > > >
> > > > can@0 {
> > > >     ...
> > > >     spi-offloads =3D <0 SOFTWARE_TRIGGER>, <1 HARDWARE_TRIGGER>;
> > > >     /* maybe we need names too? */
> > > >     spi-offload-names =3D "tx", "rx";
> > > > };
> > > >
> > > > In this case, there is nothing extra beyond the SPI controller and =
the
> > > > network controller, so no extra bindings beyond this are needed.
> > > >
> > > > Application 2: an advanced ADC + FPGA
> > > >
> > > > This is basically the same as the ad7944 case seen already with one
> > > > extra feature. In this case, the sample data also contains a CRC by=
te
> > > > for error checking. So instead of SPI RX data going directly to DMA=
,
> > > > the FPGA removes the CRC byte from the data stream an only the samp=
le
> > > > data goes to the DMA buffer. The CRC is checked and if bad, an
> > > > interrupt is asserted.
> > > >
> > > > Since this is an FPGA, most everything is hardwired rather than hav=
ing
> > > > any kind of mux selection so #spi-offload-cells =3D <1>; for this
> > > > controller.
> > > >
> > > > By adding spi-offloads to the peripheral node, it also extends the
> > > > peripheral binding to include the additional properties needed for =
the
> > > > extra features provided by the FPGA. In other words, we are saying
> > > > this DT node now represents the ADC chip plus everything connected =
to
> > > > the offload instance used by the ADC chip.
> > >
> > > It seems very strange to me that the dmas and the clock triggers are
> > > going into the spi device nodes. The description is
> > > | +  dmas:
> > > | +    maxItems: 1
> > > | +    description: RX DMA Channel for receiving a samples from the S=
PI offload.
> > > But as far as I can tell this device is in a package of its own and n=
ot
> > > some IP provided by Analog that an engine on the FPGA can actually do
> > > DMA to, and the actual connection of the device is "just" SPI.
> > > The dmas and clock triggers etc appear to be resources belonging to t=
he
> > > controller that can "assigned" to a particular spi device. If the adc
> > > gets disconnected from the system, the dmas and clock triggers are st=
ill
> > > connected to the spi controller/offload engine, they don't end up n/c=
,
> > > right? (Well maybe they would in the case of a fancy SPI device that
> > > provides it's own sampling clock or w/e, but then it'd be a clock
> > > provider of sorts). I'd be expecting the spi-offloads property to be
> > > responsible for selecting which of the various resources belonging to
> > > the controller are to be used by a device.
> > > Maybe it overcomplicates the shit out of things and Rob or Mark are
> > > gonna start screaming at me but w/e, looking at it from the point of
> > > view of how the hardware is laid out (or at least how it is described
> > > in your FPGA case above) the dma/clock properties looks like they're
> > > misplaced. IOW, I don't think that adding the spi-offloads property
> > > should convert a node from representing an ADC in a qfn-20 or w/e
> > > to "the ADC chip plus everything connected to the offload instance
> > > used by the ADC chip".
> >
> > This is the same reasoning that led me to the binding proposed in v1.
> > Rob suggested that these extras (dmas/clocks) should just be
> > properties directly of the SPI controller.
>
> > But the issue I have with
> > that is that since this is an FPGA, these properties are not fixed.
>
> I don't think whether or not we're talking about an FPGA or an ASIC
> matters at all here to be honest. In my view the main thing that FPGA
> impact in terms of bindings is the number of properties required to
> represent the configurability of a particular IP. Sure, you're gonna
> have to change the dts around in a way you'll never have to with an
> ASIC, but the description of individual devices or relations between
> them doesn't change.
>
> > Maybe there are more clocks or no clocks or interrupts or something we
> > didn't think of yet.
>
> This could happen with a new generation of an ASIC and is not specific
> to an FPGA IP core. Even with FPGA IP, while there may be lots of
> different configuration parameters, they are known & limited - you can
> look at the IP's documentation (or failing that, the HDL) to figure out
> what the points of variability are. It's not particularly difficult to
> account for there being a configurable number of clocks or interrupts.
> For "something we didn't think of yet" to be a factor, someone has to
> think of it and add it to the IP core, and which point we can absolutely
> change the bindings and software to account for the revised IP.
>
> > So it doesn't really seem possible to write a
> > binding for the SPI controller node to cover all of these cases.
>
> I dunno, I don't think your concerns about numbers of clocks (or any
> other such property) are unique to this particular use-case.
>
> > These
> > extras are included in the FPGA bitstream only for a specific type of
> > peripheral, not for general use of the SPI controller with any type of
> > peripheral.
>
> I accept that, but what I was trying to get across was that you could
> configure the FPGA with a bitstream that contains these extra resources
> and then connect a peripheral device that does not make use of them at
> all.

Sure, in this case the peripheral has no spi-offloads property and the
SPI controller acts as a typical SPI controller.

> Or you could connect a range of different peripherals that do use
> them.

OK, you've got me thinking about something I hadn't really thought about ye=
t.

> Whether or not the resources are there and how they are connected
> in the FPGA bitstream is not a property of the device connected to the
> SPI controller, only whether or not you use them is.
>

Even when those things are connected directly to a specific peripheral
device? Or not connected to the offload?

Here is another potential ADC trigger case to consider.

+-------------------------------+   +------------------+
|                               |   |                  |
|  SOC/FPGA                     |   |  ADC             |
|  +---------------------+      |   |                  |
|  | AXI SPI Engine      |      |   |                  |
|  |             SPI Bus =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D SPI Bus      =
    |
|  |                     |      |   |                  |
|  |  +---------------+  |  < < < < < BUSY             |
|  |  | Offload 0     |  | v    |   |                  |
|  |  |               |  | v  > > > > CNV              |
|  |  |    TRIGGER IN < < <   ^ |   |                  |
|  |  +---------------+  |    ^ |   +------------------+
|  +---------------------+    ^ |
|  | AXI PWM             |    ^ |
|  |                 CH0 >  > ^ |
|  +---------------------+      |
|                               |
+-------------------------------+

This time, the periodic trigger (PWM) is connected to the pin on the
ADC that triggers a sample conversion (CNV). The ADC has a BUSY output
that will go high at the start of the conversion and go low at the end
of the conversion. The BUSY output of the ADC is wired as the hardware
trigger input of the offload.

In this case would we still consider the PWM as part of the SPI
controller/offload since it can only be used in conjunction with the
SPI offload? It isn't connected to it at all though.

Another case could be a self-clocked ADC. Here, the ADC has it's own
periodic sample trigger on the chip and the RDY output goes high
whenever a sample is ready to read.

+-------------------------------+   +------------------+
|                               |   |                  |
|  SOC/FPGA                     |   |  ADC             |
|  +---------------------+      |   |                  |
|  | AXI SPI Engine      |      |   |                  |
|  |             SPI Bus =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D SPI Bus      =
    |
|  |                     |      |   |                  |
|  |  +---------------+  |  < < < < < RDY              |
|  |  | Offload 0     |  | v    |   |                  |
|  |  |               |  | v    |   |                  |
|  |  |    TRIGGER IN < < <     |   |                  |
|  |  +---------------+  |      |   +------------------+
|  +---------------------+      |
|                               |
+-------------------------------+

If both of these are valid wiring configurations for the same ADC,
wouldn't it make more sense to describe this in the peripheral node
rather than having to query the controller to see how the peripheral
is wired up?

> In fact, looking at the documentation for the "spi engine" some more, I
> am even less convinced that the right place for describing the offload is
> the peripheral as I (finally?) noticed that the registers for the offload
> engine are mapped directly into the "spi engine"'s memory map, rather tha=
n
> it being a entirely separate IP in the FPGA fabric.

True, but we don't use these registers, e.g., to configure the
sampling frequency of a trigger (if it can even be done). That is done
in a completely separate IP block with it's own registers.

>
> Further, what resources are available depends on what the SPI offload
> engine IP is. If my employer decides to start shipping some SPI offload
> IP in our catalogue that can work with ADI's ADCs, the set of offload
> related properties or their names may well differ.

If all of these resources were fairly generic, like the periodic
trigger we've been discussing, then I could see the case for trying to
accommodate this the same way we do for other common features of SPI
controllers. But for cases like "Application 2" that I described
previously, these resources can get very specific to a peripheral
(like the example given of having a data processing unit that knows
about the exact data format and CRC algorithm used by a specific ADC).
These seems like too specific of a thing to say that a SPI controller
"supports".

But, OK, let's go with the idea of putting everything related to the
offloads in the SPI controller node an see where it takes us...

spi@1000 {
    compatible =3D "adi,axi-spi-engine";
    #spi-offload-cells =3D <1>;
    /* PWM is connected to offload hardware trigger. DMA for streaming samp=
le
     * data can only handle 16-bit words. IIO hardware buffer will be CPU-
     * endian because data is streamed one word at a time. */
    spi-offload-0-capabilities =3D "pwm-trigger", "16-bit-rx-dma";

    /* pwm properties are only allowed because spi-offload-0-capabilities
     * contains "pwm-trigger" */
    pwms =3D <&pwm 0>;
    pwm-names =3D "offload-0-pwm-trigger";

    /* dma properties are only allowed because spi-offload-0-capabilities
     * contains "16-bit-rx-dma" */
    dmas =3D <&dma 0>;
    dma-names =3D "offload-0-16-bit-rx";

    ...

    adc@0 {
        compatible =3D "adi,ad7944";
        spi-offloads =3D <0>;
        ...
    };
};

spi@2000 {
    compatible =3D "not-adi,other-spi-engine";
    #spi-offload-cells =3D <1>;
    /* Clock is connected to offload hardware trigger. DMA for streaming sa=
mple
     * data can only handle one byte at a time. IIO hardware buffer will be=
 big-
     * endian because data is streamed one byte at a time. */
    spi-offload-0-capabilities =3D "clock-trigger", "8-bit-rx-dma";

    /* Clock properties are extended because spi-offload-0-capabilities con=
tains
     * "clock-trigger" and SPI controller itself has a clock */
    clocks =3D <&cpu_clock 0>, <&extra_clock 0>;
    clock-names =3D "sclk", "offload-0-pwm-trigger";

    /* DMA properties are extended because spi-offload-0-capabilities conta=
ins
     * "8-bit-rx-dma". "tx" and "rx" are for non-offload use. */
    dmas =3D <&dma1 0>, <&dma1 1>, <&dma2 0>;
    dma-names =3D "tx", "rx", "offload-0-16-bit-rx";

    ...

    adc@0 {
        compatible =3D "adi,ad7944";
        spi-offloads =3D <0>;
        ...
    };
};

spi@3000 {
    compatible =3D "adi,axi-spi-engine";
    #spi-offload-cells =3D <1>;
    /* Sample ready signal (~BSY) from ADC is connected to offload hardware
     * trigger. DMA for streaming sample data can only handle 16-bit words.=
 */
    spi-offload-0-capabilities =3D "sample-trigger", "16-bit-rx-dma";

    /* Do we need a property to say that the sample trigger is connected to
     * adc@0 so that if adc@1 tries to use it, it will fail? */

    /* dma properties are only allowed because spi-offload-0-capabilities
     * contains "16-bit-rx-dma" */
    dmas =3D <&dma 0>;
    dma-names =3D "offload-0-16-bit-rx";

    ...

    adc@0 {
        compatible =3D "adi,ad7944";
        spi-offloads =3D <0>;
        ...

        /* PWM connected to the conversion pin (CNV). This only makes sense
         * when offload is used with BSY signal, otherwise we would have CN=
V
         * connected to SPI CS. */
        pwms =3D <&pwm 0>;
        pwm-names =3D "cnv";
    };
};

spi@4000 {
    compatible =3D "adi,axi-spi-engine";
    #spi-offload-cells =3D <1>;
    /* Sample ready signal (~BSY) from ADC is connected to offload hardware
     * trigger. DMA for streaming sample data can only handle 32-bit words.
     * This also has the CRC validation that strips off the CRC byte of the
     * raw data before passing the sample to DMA. */
    spi-offload-0-capabilities =3D "sample-trigger",
                                 "32-bit-rx-dma-with-ad4630-crc-check";

    /* dma properties are only allowed because spi-offload-0-capabilities
     * contains "16-bit-rx-dma" */
    dmas =3D <&dma 0>;
    dma-names =3D "offload-0-16-bit-rx";

    interrupt-parent =3D <&intc>;
    /* First interrupt is for the SPI controller (always present), second
     * interrupt is CRC error from the "32-bit-rx-dma-with-ad4630-crc-check=
"
     * of offload 0. */
    interrupts =3D <0 56 IRQ_TYPE_LEVEL_HIGH>, <0 58 IRQ_TYPE_LEVEL_HIGH>;
    interrupt-names =3D "controller", "offload-0-crc-error";

    ...

    adc@0 {
        compatible =3D "adi,ad4630";
        spi-offloads =3D <0>;
        ...

        /* PWM connected to the conversion pin (CNV). Without offload, we w=
ould
         * have cnv-gpios instead. */
        pwms =3D <&pwm 0>;
        pwm-names =3D "cnv";
    };
};

So this is what I came up with of how things could look (combining
suggestions from Rob in v1 and Conor's suggestions here). I can see
how we can make this work. But the thing I don't like about it is that
the peripheral drivers still need to know all of the information about
the offload capabilities and need to interact with the
pwms/clocks/interrupts/dmas/etc. So this is just adding layers of
indirection where all of this stuff has to go through the SPI
controller driver.


>
> > Another idea I had was to perhaps use the recently added IIO backend
> > framework for the "extras". The idea there is that we are creating a
> > "composite" IIO device that consists of the ADC chip (frontend) plus
> > these extra hardware trigger and hardware buffer functions provided by
> > the FPGA (backend).
> >
> > offload_backend: adc0-backend {
> >     /* http://analogdevicesinc.github.io/hdl/projects/pulsar_adc/index.=
html */
> >     compatible =3D "adi,pulsar-adc-offload";
> >     #io-backend-cells =3D <0>;
> >     dmas =3D <&dma 0>;
> >     dma-names =3D "rx";
> >     clocks =3D <&trigger_clock>;
> > };
> >
> > spi {
> >     ...
> >     adc@0 {
> >         ...
> >         spi-offloads =3D <0>;
> >         io-backends =3D <&offload_backend>;
> >     };
> > };
> >
> > While this could be a solution for IIO devices, this wouldn't solve
> > the issue in general though for SPI offloads used with non-IIO
> > peripherals.
>
> Yeah, I agree that using something specific to IIO isn't really a good
> solution.
>
> Cheers,
> Conor.
>
> > So I don't think it is the right thing to do here. But, I
> > think this idea of a "composite" device helps explain why we are
> > pushing for putting the "extras" with the peripheral node rather than
> > the controller node, at least for the specific case of the AXI SPI
> > Engine controller.
>

