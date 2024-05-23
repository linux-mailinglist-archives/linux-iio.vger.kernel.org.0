Return-Path: <linux-iio+bounces-5210-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4478CD218
	for <lists+linux-iio@lfdr.de>; Thu, 23 May 2024 14:16:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 098D31F22A9E
	for <lists+linux-iio@lfdr.de>; Thu, 23 May 2024 12:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B375414885A;
	Thu, 23 May 2024 12:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A3eykaOw"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3493E1411F5;
	Thu, 23 May 2024 12:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716466541; cv=none; b=ZuWDInFae3ddTfpfQcc+R/yGCdFBBLbuJG6BTIlbRRC3hGnW7LMaPRICbky4vzRAPKjr1Vt873YkxFJ+UYCOeNUXFI5F4COpb1pRcbYATRodDLzWmFTKwfc8ECKlKzWV40RGq4wkwtgiQAQ5gB4I50KYAtIg81oIoAV2I2U5fhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716466541; c=relaxed/simple;
	bh=zcxuAOD4i6pHaaLAt7XTmOC0aa1iB+GpCJJwi6anzis=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ux8SrmpaVo2GgZ1aRwA/Uqx6YyzaCiLhk/v8L1v78a/nGfQxSQECsOkhASyqOY11Tq0Uc+RkCEteVzYy8odZKcE+E+OSZUQiGPyF8MSy0yqtGp6d1tnG5+9VEjKwubdJz0t0hU/IBs68oXNFYDD5lMs2w6472i6g856N8xQg4GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A3eykaOw; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-572af0b12b8so11270388a12.2;
        Thu, 23 May 2024 05:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716466537; x=1717071337; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zcxuAOD4i6pHaaLAt7XTmOC0aa1iB+GpCJJwi6anzis=;
        b=A3eykaOw+2FISrhlCDMILe9dvGFxonuCy2avXlMoUohJ2dHtmAoY+5btSDwmmrkZN6
         A7JPEmkGfoorhXt7cu9fBwXR5qUf56iclhHQT+zIHVdx7IEsL0T33GQtFopP38rg3AEd
         n+droqWzCk5eUTYpgjJuoPh+GqbJMV0c9HjZSLmKxm5IA+6gHwnbjSW9WCIX/2MSIAGN
         LLt3iOP/9Lx54rLH+HSLkAOfbswR7RmMMhRsvdSNq6JPQJFtWrO6kb1PUWt1NcT1FoBi
         Bs2oFnEeaqV6FmAomASpk7ZULwImbM8FxeN7f/0OtCZo+mDaBkf3vu8TvcGZhOOYlNV1
         Bjww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716466537; x=1717071337;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zcxuAOD4i6pHaaLAt7XTmOC0aa1iB+GpCJJwi6anzis=;
        b=EvUA9nnUQtGcLDLCg/mhMpHzOldwoNXpQG5JZ+D6qqzhNdxJEPeWaf2/R8xVYPtYds
         AR5dMcNUgv2OCumk9WViaoH7hAlLIzSP2kljUestdptx/icbiJ4rGHTi7RMmFKed6IFl
         +ynWZpVIgGbdJiHKeogBGYIQx+PhOI6nGJjgmwd+sNXjwadqqGkiGhovhAxSuUTwEd88
         caILaI8MyXP8uwMOuerQvfK89gegeaJjTf0ilAKKl7MNjiwpoETbRoctuuCSI911A42q
         hOfqM4fRmZUTp5o31ZWPddgo5Tqad6A10QtvLNF8p4729lyhU+7dV8utG3AhKBuujTL1
         cfvA==
X-Forwarded-Encrypted: i=1; AJvYcCUEhBYK84ViQ93QdtZpPEAc3qobsxbPXxYOPLNQ1cHNd7iR3rG+j+7h0Wplhsy1eCzJgfJ2+ZDMabwAHNgT3xLw3YfqduvV1rBUcTF0jLK6582cK7Pv3/7iEF0fajawaEiFnjtJ9BCkqjxmM0wk2AyJwhvSp1t7Nn8r1wcHuJ9OWkGkSJ+U2QpBJpkTIaGYnv9y8rgYP/sH3fvIviVJrQ==
X-Gm-Message-State: AOJu0YxwuD6j7FVrsByxoCx+MkSqAjPLWu4GCns8xokOfZqGqNGIN37F
	XTA2kzczZRVfQISoujSPBrfjwJD0La4l0GICjNlENue7qGehZKy6
X-Google-Smtp-Source: AGHT+IFS9Ft0EoIz0VlwIapR9sXl52MMV7WEPmPelNL+KUv2EBj6/ZXCD2VQaLcdCFFMGfRjctDBXg==
X-Received: by 2002:a50:d69b:0:b0:574:ffb1:eb52 with SMTP id 4fb4d7f45d1cf-57832c56a14mr2748835a12.34.1716466537042;
        Thu, 23 May 2024 05:15:37 -0700 (PDT)
Received: from ?IPv6:2001:a61:35f9:9001:40df:88bb:5090:7ab6? ([2001:a61:35f9:9001:40df:88bb:5090:7ab6])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5733c2cb54csm19728143a12.60.2024.05.23.05.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 05:15:36 -0700 (PDT)
Message-ID: <5ad0b5782434eaf4cf565cffb0e4c14b7414ae38.camel@gmail.com>
Subject: Re: [PATCH RFC v2 1/8] spi: dt-bindings: spi-peripheral-props: add
 spi-offloads property
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Conor Dooley <conor@kernel.org>, David Lechner <dlechner@baylibre.com>
Cc: Mark Brown <broonie@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,  Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>, Michael Hennerich <Michael.Hennerich@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, David Jander <david@protonic.nl>,
 Martin Sperl <kernel@martin.sperl.org>, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org
Date: Thu, 23 May 2024 14:15:35 +0200
In-Reply-To: <20240522-gullible-ibuprofen-cf9111c25f6f@spud>
References: 
	<20240510-dlech-mainline-spi-engine-offload-2-v2-0-8707a870c435@baylibre.com>
	 <20240510-dlech-mainline-spi-engine-offload-2-v2-1-8707a870c435@baylibre.com>
	 <20240513-headsman-hacking-d51fcc811695@spud>
	 <CAMknhBE5XJzhdJ=PQUXiubw_CiCLcn1jihiscnQZUzDWMASPKw@mail.gmail.com>
	 <20240514-aspire-ascension-449556da3615@spud>
	 <CAMknhBFFpEGcMoLo5gsC11Syv+CwUM0mnq1yDMUzL1uutUtB+Q@mail.gmail.com>
	 <20240516-rudder-reburial-dcf300504c0a@spud>
	 <CAMknhBF_s0btus4yqPe-T=F3z7Asi9KkRGsGr7FHDFi=k4EQjw@mail.gmail.com>
	 <20240519-abreast-haziness-096a57ef57d3@spud>
	 <CAMknhBHvEse2FyDoBXR1PvymGpSGq8dotKfm+8XH+0+k+xKtQw@mail.gmail.com>
	 <20240522-gullible-ibuprofen-cf9111c25f6f@spud>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1 (3.52.1-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-05-22 at 19:24 +0100, Conor Dooley wrote:
> On Tue, May 21, 2024 at 09:54:39AM -0500, David Lechner wrote:
> > On Sun, May 19, 2024 at 7:53=E2=80=AFAM Conor Dooley <conor@kernel.org>=
 wrote:
> > >=20
> > > On Fri, May 17, 2024 at 11:51:58AM -0500, David Lechner wrote:
> > > > On Thu, May 16, 2024 at 4:32=E2=80=AFPM Conor Dooley <conor@kernel.=
org> wrote:
> > > > > On Tue, May 14, 2024 at 05:56:47PM -0500, David Lechner wrote:
> > >=20
> > > > > > Back to "something beyond the SPI controller":
> > > > > >=20
> > > > > > Here are some examples of how I envision this would work.
> > > > > >=20
> > > > > > Let's suppose we have a SPI controller that has some sort of of=
fload
> > > > > > capability with a configurable trigger source. The trigger can =
either
> > > > > > be an internal software trigger (i.e. writing a register of the=
 SPI
> > > > > > controller) or and external trigger (i.e. a input signal from a=
 pin on
> > > > > > the SoC). The SPI controller has a lookup table with 8 slots wh=
ere it
> > > > > > can store a series of SPI commands that can be played back by
> > > > > > asserting the trigger (this is what provides the "offloading").
> > > > > >=20
> > > > > > So this SPI controller would have #spi-offload-cells =3D <2>; w=
here the
> > > > > > first cell would be the index in the lookup table 0 to 7 and th=
e
> > > > > > second cell would be the trigger source 0 for software or 1 for
> > > > > > hardware.
> > > > > >=20
> > > > > > Application 1: a network controller
> > > > > >=20
> > > > > > This could use two offloads, one for TX and one for RX. For TX,=
 we use
> > > > > > the first slot with a software trigger because the data is comi=
ng from
> > > > > > Linux. For RX we use the second slot with a hardware trigger si=
nce
> > > > > > data is coming from the network controller (i.e. a data ready s=
ignal
> > > > > > that would normally be wired to a gpio for interrupt but wired =
to the
> > > > > > SPI offload trigger input pin instead). So the peripheral bindi=
ngs
> > > > > > would be:
> > > > > >=20
> > > > > > #define SOFTWARE_TRIGGER 0
> > > > > > #define HARDWARE_TRIGGER 1
> > > > > >=20
> > > > > > can@0 {
> > > > > > =C2=A0=C2=A0=C2=A0 ...
> > > > > > =C2=A0=C2=A0=C2=A0 spi-offloads =3D <0 SOFTWARE_TRIGGER>, <1 HA=
RDWARE_TRIGGER>;
> > > > > > =C2=A0=C2=A0=C2=A0 /* maybe we need names too? */
> > > > > > =C2=A0=C2=A0=C2=A0 spi-offload-names =3D "tx", "rx";
> > > > > > };
> > > > > >=20
> > > > > > In this case, there is nothing extra beyond the SPI controller =
and the
> > > > > > network controller, so no extra bindings beyond this are needed=
.
> > > > > >=20
> > > > > > Application 2: an advanced ADC + FPGA
> > > > > >=20
> > > > > > This is basically the same as the ad7944 case seen already with=
 one
> > > > > > extra feature. In this case, the sample data also contains a CR=
C byte
> > > > > > for error checking. So instead of SPI RX data going directly to=
 DMA,
> > > > > > the FPGA removes the CRC byte from the data stream an only the =
sample
> > > > > > data goes to the DMA buffer. The CRC is checked and if bad, an
> > > > > > interrupt is asserted.
> > > > > >=20
> > > > > > Since this is an FPGA, most everything is hardwired rather than=
 having
> > > > > > any kind of mux selection so #spi-offload-cells =3D <1>; for th=
is
> > > > > > controller.
> > > > > >=20
> > > > > > By adding spi-offloads to the peripheral node, it also extends =
the
> > > > > > peripheral binding to include the additional properties needed =
for the
> > > > > > extra features provided by the FPGA. In other words, we are say=
ing
> > > > > > this DT node now represents the ADC chip plus everything connec=
ted to
> > > > > > the offload instance used by the ADC chip.
> > > > >=20
> > > > > It seems very strange to me that the dmas and the clock triggers =
are
> > > > > going into the spi device nodes. The description is
> > > > > > +=C2=A0 dmas:
> > > > > > +=C2=A0=C2=A0=C2=A0 maxItems: 1
> > > > > > +=C2=A0=C2=A0=C2=A0 description: RX DMA Channel for receiving a=
 samples from the SPI
> > > > > > offload.
> > > > > But as far as I can tell this device is in a package of its own a=
nd not
> > > > > some IP provided by Analog that an engine on the FPGA can actuall=
y do
> > > > > DMA to, and the actual connection of the device is "just" SPI.
> > > > > The dmas and clock triggers etc appear to be resources belonging =
to the
> > > > > controller that can "assigned" to a particular spi device. If the=
 adc
> > > > > gets disconnected from the system, the dmas and clock triggers ar=
e still
> > > > > connected to the spi controller/offload engine, they don't end up=
 n/c,
> > > > > right? (Well maybe they would in the case of a fancy SPI device t=
hat
> > > > > provides it's own sampling clock or w/e, but then it'd be a clock
> > > > > provider of sorts). I'd be expecting the spi-offloads property to=
 be
> > > > > responsible for selecting which of the various resources belongin=
g to
> > > > > the controller are to be used by a device.
> > > > > Maybe it overcomplicates the shit out of things and Rob or Mark a=
re
> > > > > gonna start screaming at me but w/e, looking at it from the point=
 of
> > > > > view of how the hardware is laid out (or at least how it is descr=
ibed
> > > > > in your FPGA case above) the dma/clock properties looks like they=
're
> > > > > misplaced. IOW, I don't think that adding the spi-offloads proper=
ty
> > > > > should convert a node from representing an ADC in a qfn-20 or w/e
> > > > > to "the ADC chip plus everything connected to the offload instanc=
e
> > > > > used by the ADC chip".
> > > >=20
> > > > This is the same reasoning that led me to the binding proposed in v=
1.
> > > > Rob suggested that these extras (dmas/clocks) should just be
> > > > properties directly of the SPI controller.
> > >=20
> > > > But the issue I have with
> > > > that is that since this is an FPGA, these properties are not fixed.
> > >=20
> > > I don't think whether or not we're talking about an FPGA or an ASIC
> > > matters at all here to be honest. In my view the main thing that FPGA
> > > impact in terms of bindings is the number of properties required to
> > > represent the configurability of a particular IP. Sure, you're gonna
> > > have to change the dts around in a way you'll never have to with an
> > > ASIC, but the description of individual devices or relations between
> > > them doesn't change.
> > >=20
> > > > Maybe there are more clocks or no clocks or interrupts or something=
 we
> > > > didn't think of yet.
> > >=20
> > > This could happen with a new generation of an ASIC and is not specifi=
c
> > > to an FPGA IP core. Even with FPGA IP, while there may be lots of
> > > different configuration parameters, they are known & limited - you ca=
n
> > > look at the IP's documentation (or failing that, the HDL) to figure o=
ut
> > > what the points of variability are. It's not particularly difficult t=
o
> > > account for there being a configurable number of clocks or interrupts=
.
> > > For "something we didn't think of yet" to be a factor, someone has to
> > > think of it and add it to the IP core, and which point we can absolut=
ely
> > > change the bindings and software to account for the revised IP.
> > >=20
> > > > So it doesn't really seem possible to write a
> > > > binding for the SPI controller node to cover all of these cases.
> > >=20
> > > I dunno, I don't think your concerns about numbers of clocks (or any
> > > other such property) are unique to this particular use-case.
> > >=20
> > > > These
> > > > extras are included in the FPGA bitstream only for a specific type =
of
> > > > peripheral, not for general use of the SPI controller with any type=
 of
> > > > peripheral.
> > >=20
> > > I accept that, but what I was trying to get across was that you could
> > > configure the FPGA with a bitstream that contains these extra resourc=
es
> > > and then connect a peripheral device that does not make use of them a=
t
> > > all.
> >=20
> > Sure, in this case the peripheral has no spi-offloads property and the
> > SPI controller acts as a typical SPI controller.
> >=20
> > > Or you could connect a range of different peripherals that do use
> > > them.
> >=20
> > OK, you've got me thinking about something I hadn't really thought abou=
t yet.
> >=20
> > > Whether or not the resources are there and how they are connected
> > > in the FPGA bitstream is not a property of the device connected to th=
e
> > > SPI controller, only whether or not you use them is.
> > >=20
> >=20
> > Even when those things are connected directly to a specific peripheral
> > device? Or not connected to the offload?
> >=20
> > Here is another potential ADC trigger case to consider.
> >=20
> > +-------------------------------+=C2=A0=C2=A0 +------------------+
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 |
> > > =C2=A0SOC/FPGA=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
=C2=A0 |=C2=A0 ADC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |
> > > =C2=A0+---------------------+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
> > > =C2=A0| AXI SPI Engine=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
> > > =C2=A0|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 SPI Bus =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D SPI Bus=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
> > > =C2=A0|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
> > > =C2=A0|=C2=A0 +---------------+=C2=A0 |=C2=A0 < < < < < BUSY=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
> > > =C2=A0|=C2=A0 | Offload 0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 | v=C2=A0=
=C2=A0=C2=A0 |=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
> > > =C2=A0|=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 | v=C2=A0 > > > > CNV=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
> > > =C2=A0|=C2=A0 |=C2=A0=C2=A0=C2=A0 TRIGGER IN < < <=C2=A0=C2=A0 ^ |=C2=
=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
> > > =C2=A0|=C2=A0 +---------------+=C2=A0 |=C2=A0=C2=A0=C2=A0 ^ |=C2=A0=
=C2=A0 +------------------+
> > > =C2=A0+---------------------+=C2=A0=C2=A0=C2=A0 ^ |
> > > =C2=A0| AXI PWM=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 ^ |
> > > =C2=A0|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CH0 >=C2=A0 > ^ |
> > > =C2=A0+---------------------+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
> > +-------------------------------+
> >=20
> > This time, the periodic trigger (PWM) is connected to the pin on the
> > ADC that triggers a sample conversion (CNV). The ADC has a BUSY output
> > that will go high at the start of the conversion and go low at the end
> > of the conversion. The BUSY output of the ADC is wired as the hardware
> > trigger input of the offload.
> >=20
> > In this case would we still consider the PWM as part of the SPI
> > controller/offload since it can only be used in conjunction with the
> > SPI offload? It isn't connected to it at all though.
>=20
> No, in this case the ADC is a PWM consumer and the offload engine is
> not. The ADC is a "trigger" provider and the SPI offload engine is a
> trigger consumer.
>=20
> > Another case could be a self-clocked ADC. Here, the ADC has it's own
> > periodic sample trigger on the chip and the RDY output goes high
> > whenever a sample is ready to read.
> >=20
> > +-------------------------------+=C2=A0=C2=A0 +------------------+
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 |
> > > =C2=A0SOC/FPGA=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
=C2=A0 |=C2=A0 ADC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |
> > > =C2=A0+---------------------+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
> > > =C2=A0| AXI SPI Engine=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
> > > =C2=A0|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 SPI Bus =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D SPI Bus=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
> > > =C2=A0|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
> > > =C2=A0|=C2=A0 +---------------+=C2=A0 |=C2=A0 < < < < < RDY=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
> > > =C2=A0|=C2=A0 | Offload 0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 | v=C2=A0=
=C2=A0=C2=A0 |=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
> > > =C2=A0|=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 | v=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 =
|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
> > > =C2=A0|=C2=A0 |=C2=A0=C2=A0=C2=A0 TRIGGER IN < < <=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
> > > =C2=A0|=C2=A0 +---------------+=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0=C2=A0 +------------------+
> > > =C2=A0+---------------------+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
> > +-------------------------------+
> >=20
> > If both of these are valid wiring configurations for the same ADC,
> > wouldn't it make more sense to describe this in the peripheral node
> > rather than having to query the controller to see how the peripheral
> > is wired up?
>=20
> In both of these cases, the offload works in the same way, it gets a
> trigger from the ADC and acts upon it. I would expect that in this case
> the ADC driver would look for an optional pwm property in the devicetree
> and if it is present configure the ADC to use that and if absent do then
> do whatever configuration is required for self clocking. I would expect
> that both cases would be handled identically by the SPI [offload] engine
> side of things, other than inverting the polarity of the trigger. (If I
> understand correctly, you want to trigger the offload engine on a
> falling edge of BUSY but a rising edge of RDY).
>=20
>=20
> > > In fact, looking at the documentation for the "spi engine" some more,=
 I
> > > am even less convinced that the right place for describing the offloa=
d is
> > > the peripheral as I (finally?) noticed that the registers for the off=
load
> > > engine are mapped directly into the "spi engine"'s memory map, rather=
 than
> > > it being a entirely separate IP in the FPGA fabric.
> >=20
> > True, but we don't use these registers, e.g., to configure the
> > sampling frequency of a trigger (if it can even be done). That is done
> > in a completely separate IP block with it's own registers.
>=20
> Where is the binding for that IP block? I think describing that is
> pretty key. goto continuation;
>=20
> > > Further, what resources are available depends on what the SPI offload
> > > engine IP is. If my employer decides to start shipping some SPI offlo=
ad
> > > IP in our catalogue that can work with ADI's ADCs, the set of offload
> > > related properties or their names may well differ.
> >=20
> > If all of these resources were fairly generic, like the periodic
> > trigger we've been discussing, then I could see the case for trying to
> > accommodate this the same way we do for other common features of SPI
> > controllers. But for cases like "Application 2" that I described
> > previously, these resources can get very specific to a peripheral
> > (like the example given of having a data processing unit that knows
> > about the exact data format and CRC algorithm used by a specific ADC).
> > These seems like too specific of a thing to say that a SPI controller
> > "supports".
>=20
> To remind myself, "Application 2" featured an offload engine designed
> specifically to work with a particular data format that would strip a
> CRC byte and check the validity of the data stream.
>=20

I think the data manipulation is not really a property of the engine. Typic=
ally data
going out of the offload engine goes into another "data reorder" block that=
 is pure
HW.

> I think you're right something like that is a stretch to say that that
> is a feature of the SPI controller - but I still don't believe that
> modelling it as part of the ADC is correct. I don't fully understand the
> io-backends and how they work yet, but the features you describe there
> seem like something that should/could be modelled as one, with its own
> node and compatible etc. Describing custom RTL stuff ain't always
> strightforward, but the stuff from Analog is versioned and documented
> etc so it shouldn't be quite that hard.
>=20

Putting this in io-backends is likely a stretch but one thing to add is tha=
t the
peripheral is always (I think) kind of the consumer of the resources. Takin=
g the
trigger (PWM) as an example and even when it is directly connected with the=
 offload
block, the peripheral still needs to know about it. Think of sampling frequ=
ency...
The period of the trigger signal is strictly connected with the sampling fr=
equency of
the peripheral for example. So I see 2 things:

1) Enabling/Disabling the trigger could be easily done from the peripheral =
even with
the resource in the spi engine. I think David already has some code in the =
series
that would make this trivial and so having the property in the spi controll=
er brings
no added complexity.

2) Controlling things like the trigger period/sample_rate. This could be ha=
rder to do
over SPI (or making it generic enough) so we would still need to have the s=
ame
property on the peripheral (even if not directly connected to it). I kind o=
f agree
with David that having the property both in the peripheral and controller i=
s a bit
weird.

And the DMA block is a complete different story. Sharing that data back wit=
h the
peripheral driver (in this case, the IIO subsystem) would be very interesti=
ng at the
very least. Note that the DMA block is not really something that is part of=
 the
controller nor the offload block. It is an external block that gets the dat=
a coming
out of the offload engine (or the data reorder block). In IIO, we already h=
ave a DMA
buffer interface so users of the peripheral can get the data without any in=
tervention
of the driver (on the data). We "just" enable buffering and then everything=
 happens
on HW and userspace can start requesting data. If we are going to attach th=
e DMA in
the controller, I have no idea how we can handle it. Moreover, the offload =
it's
really just a way of replaying the same spi transfer over and over and that=
 happens
in HW so I'm not sure how we could "integrate" that with dmaengine.

But maybe I'm overlooking things... And thinking more in how this can be do=
ne in SW
rather than what makes sense from an HW perspective.


> continuation:
> If offload engines have their own register region in the memory map,


Don't think it has it's own register region... David?

> their own resources (the RTL is gonna need at the very least a clock)
> and potentially also provide other services (like acting as an
> io-backend type device that pre-processes data) it doesn't sound like
> either the controller or peripheral nodes are the right place for these
> properties. And uh, spi-offloads gets a phandle once more...
>=20

But then it would be valid for both peripheral and controller to reference =
that
phandle right (and get the resources of interest)?

FWIW, maybe look at the below usecase. It has some block diagrams that may =
be helpful
to you:

https://wiki.analog.com/resources/eval/user-guides/ad463x/hdl

- Nuno S=C3=A1



