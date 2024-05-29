Return-Path: <linux-iio+bounces-5427-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBACC8D30BF
	for <lists+linux-iio@lfdr.de>; Wed, 29 May 2024 10:17:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A073F28C631
	for <lists+linux-iio@lfdr.de>; Wed, 29 May 2024 08:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7333917B509;
	Wed, 29 May 2024 08:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bPZ01eCK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF281C230C;
	Wed, 29 May 2024 08:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716970063; cv=none; b=VMEO29SaF0KLhQD8xSmekrOzvN0xcHxjN3O9+2lOpktEfB3G4C+nqgAM2hy+BpUXa10KcFKMi/uweyS0+FIwUgDT4fzj/B5uSeP+Q8f/PMNsxAAEu50rTdFKx2clqyaosp4tuUAH7hYAfd/nHfPOWhjFxnKuVs/st7UPVH+jcoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716970063; c=relaxed/simple;
	bh=DbJRWGPwaHoF/f0oYgnmbX2wUVOjF64ReE/qreCyuIU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aiOBjp+7zE76ofq1FkBBBYwuPdi8ICVLOhcDRLelnuvOEGkXE9oIDCUgPF7VBJ7Hg8PETwk2mZqu2sAowybEt0xLkxoRs+/HFdQ7tcV/4M8uTr+c/v7L01lJjC69GJt2Uzsf/v4OIgonOUV7iMzz1bpWGLr+/SZnnTklvtFODqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bPZ01eCK; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a621cb07d8fso198611266b.2;
        Wed, 29 May 2024 01:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716970059; x=1717574859; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HbmeazO7vBjxMc5Hy7I+L4x41EIeSvLatAytZpScfhg=;
        b=bPZ01eCKH15ajaTmR/JTkekuP+X5ZdNjtVs8Q9Go/d10/Pj6DsobpOjhoaxrAm2Dp3
         XHD/gKOCkszW+cOK+MlUp7IigyAVKIGMmFUQCIpMBzkrVEx5bkqP/H1Rsmmhz32eEOTr
         c5f9ym5yjAx4/T/cS+TzV0zAAj/s27EE/prmQU2Rw9Bu0c1z52wPU4gBajgoJjW/Ts3p
         dbqOHOvxnL7r58xuMjMaMJM8xRz8em8SiXYXnOOfDRbzOuJhO1oCaCPPY1STo2GGlNso
         TxhQMeeWhfraQK2v00gu7tY7INJRL8MNC9Vpd5LWTlcZGPoXRYtlyErghnpUilJUbOuB
         vTyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716970059; x=1717574859;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HbmeazO7vBjxMc5Hy7I+L4x41EIeSvLatAytZpScfhg=;
        b=W61DHUKUDb6b51Eq2R1wSom/94rjWVPC/gcZTDcuPa+yfaS90VBActjTWd6dsfB9xo
         yveRfHFjIjsiG1gy1X6S0Rye86dWeJNMNX6KZawe2XaiT5+cqXpL8sX9Pk/g4k2u9sOC
         Oh99Asu5VIADYVZww5AangCzSSrDuMiN9g9uXXvoPtINCANIXO6Ru7FAy7ZQPteq0D8W
         GHmjRaMxhXQfvngoJnsDYE8cXgwcEukR3kFskTGf3C+mI0laMO3xHC1S0lK2r8sCnzkS
         HUpaIzxMGy/39QA4PUbxFfGRYn85M1v+UGQwmB3zH1bTaEEgs230jOo/prWzTiaRkGtj
         T2ww==
X-Forwarded-Encrypted: i=1; AJvYcCVpMtNrf8Md4P00t+ojUpvjTck0RPSnWCChzYcLQ8nBovfjXKN06NP728ffKeZcARzmBbQCBYWXQx2FEx5K19PTsVAHtghxcuix/UgC1pUuIBu/204rcPcjxq/k8GwfcJ+9sSW9G3OWxHj3U7nqpSJItV9e48SC309fxOLGLuJ+PF9ACpQOK7UEI2sn6y3xo8BNlivz6O0VQgQ6P09USQ==
X-Gm-Message-State: AOJu0YzV5fhv/csKLql4/UnrfFWSpsRpjJjHGHleyh++vSSOLl9K+jSS
	dSdUVbTkLBwXrvM/GIdnfToP67arzRaPQknq1zGD8CiKeEQGGjzP
X-Google-Smtp-Source: AGHT+IFqLe66tCV8uvRY+ijnQhAQ1SPt9jaw31+gWnFWDuxF2+A75aWbBMXHZGoyyrJJ5W1q23KhdA==
X-Received: by 2002:a17:906:fa17:b0:a63:d926:7f34 with SMTP id a640c23a62f3a-a63d9268961mr112902166b.26.1716970059221;
        Wed, 29 May 2024 01:07:39 -0700 (PDT)
Received: from nsa.fritz.box ([2001:a61:35f9:9001:40df:88bb:5090:7ab6])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6418ee2286sm53672966b.17.2024.05.29.01.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 01:07:38 -0700 (PDT)
Message-ID: <10991373cb9603803df63d8236c475807f6dde68.camel@gmail.com>
Subject: Re: [PATCH RFC v2 1/8] spi: dt-bindings: spi-peripheral-props: add
 spi-offloads property
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Conor Dooley <conor@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, Mark Brown <broonie@kernel.org>, 
 Jonathan Cameron
	 <jic23@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Nuno
 =?ISO-8859-1?Q?S=E1?=
	 <nuno.sa@analog.com>, Michael Hennerich <Michael.Hennerich@analog.com>, 
 Lars-Peter Clausen
	 <lars@metafoo.de>, David Jander <david@protonic.nl>, Martin Sperl
	 <kernel@martin.sperl.org>, linux-spi@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org
Date: Wed, 29 May 2024 10:07:37 +0200
In-Reply-To: <20240526-peculiar-panama-badda4f02336@spud>
References: <20240513-headsman-hacking-d51fcc811695@spud>
	 <CAMknhBE5XJzhdJ=PQUXiubw_CiCLcn1jihiscnQZUzDWMASPKw@mail.gmail.com>
	 <20240514-aspire-ascension-449556da3615@spud>
	 <CAMknhBFFpEGcMoLo5gsC11Syv+CwUM0mnq1yDMUzL1uutUtB+Q@mail.gmail.com>
	 <20240516-rudder-reburial-dcf300504c0a@spud>
	 <CAMknhBF_s0btus4yqPe-T=F3z7Asi9KkRGsGr7FHDFi=k4EQjw@mail.gmail.com>
	 <20240519-abreast-haziness-096a57ef57d3@spud>
	 <CAMknhBHvEse2FyDoBXR1PvymGpSGq8dotKfm+8XH+0+k+xKtQw@mail.gmail.com>
	 <20240522-gullible-ibuprofen-cf9111c25f6f@spud>
	 <5ad0b5782434eaf4cf565cffb0e4c14b7414ae38.camel@gmail.com>
	 <20240526-peculiar-panama-badda4f02336@spud>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1 (3.52.1-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2024-05-26 at 18:35 +0100, Conor Dooley wrote:
> On Thu, May 23, 2024 at 02:15:35PM +0200, Nuno S=C3=A1 wrote:
> > On Wed, 2024-05-22 at 19:24 +0100, Conor Dooley wrote:
>=20
> > >=20
> > > To remind myself, "Application 2" featured an offload engine designed
> > > specifically to work with a particular data format that would strip a
> > > CRC byte and check the validity of the data stream.
> > >=20
> >=20
> > I think the data manipulation is not really a property of the engine. T=
ypically
> > data
> > going out of the offload engine goes into another "data reorder" block =
that is
> > pure
> > HW.
> >=20
> > > I think you're right something like that is a stretch to say that tha=
t
> > > is a feature of the SPI controller - but I still don't believe that
> > > modelling it as part of the ADC is correct. I don't fully understand =
the
> > > io-backends and how they work yet, but the features you describe ther=
e
> > > seem like something that should/could be modelled as one, with its ow=
n
> > > node and compatible etc. Describing custom RTL stuff ain't always
> > > strightforward, but the stuff from Analog is versioned and documented
> > > etc so it shouldn't be quite that hard.
> > >=20
> >=20
> > Putting this in io-backends is likely a stretch but one thing to add is=
 that the
> > peripheral is always (I think) kind of the consumer of the resources.
>=20
> Could you explain you think why making some additional processing done to
> the data an io-backend is a stretch? Where else can this RTL be
> represented? hint: it's not part of the ADC, just like how if you have
> some custom RTL that does video processing that is not part of the
> camera!

Maybe we are speaking about two different things... I do agree with the vid=
eo
processing example you gave but for this case I'm not sure there#s any data
manipulation involved. i mean, there is but nothing controlled by SW at thi=
s point.
Or maybe there's already a future usecase that I'm not aware about (maybe t=
he CRC
stuff David mentioned).

I'm more focusing on where the trigger (PWMS in this particular case but co=
uld be
something else) and the DMA properties belong. I do agree that, Hardware wi=
se, the
trigger is a property of the offload engine even though intrinsically conne=
cted with
the peripheral.

The DMA is also directly connected to the offload but I'm not sure if in th=
is case we
should say it's a property of it? It's an external block that we do not con=
trol at
all and the data is to be consumed by users of the peripheral.

>=20
> > Taking the
> > trigger (PWM) as an example and even when it is directly connected with=
 the
> > offload
> > block, the peripheral still needs to know about it. Think of sampling
> > frequency...
> > The period of the trigger signal is strictly connected with the samplin=
g
> > frequency of
> > the peripheral for example. So I see 2 things:
> >=20
> > 1) Enabling/Disabling the trigger could be easily done from the periphe=
ral even
> > with
> > the resource in the spi engine. I think David already has some code in =
the series
> > that would make this trivial and so having the property in the spi cont=
roller
> > brings
> > no added complexity.
> >=20
> > 2) Controlling things like the trigger period/sample_rate. This could b=
e harder
> > to do
> > over SPI (or making it generic enough) so we would still need to have t=
he same
> > property on the peripheral (even if not directly connected to it). I ki=
nd of
> > agree
> > with David that having the property both in the peripheral and controll=
er is a
> > bit
> > weird.
>=20
> Can you explain what you mean by "same property on the peripheral"? I
> would expect a peripheral to state its trigger period (just like how it
> states the max frequency) and for the trigger period not to appear in
> the controller.
>=20

Just have the same 'pwms' property on both the controller and peripheral...

> I think a way that this could be modelled to reduce some software
> complexity is considering that the periodic trigger is a clock, not
> a PWM, provided you are only interested in the period. That'd give you
> an interface that was less concerned about what the provider of the
> periodic trigger is. After all, I doubt the ADC cares how you decide to
> generate the trigger, as long as the periodicity is correct.
> With the examples provided, you'd get something like:
>=20

Unfortunately that's not the case. For instance, in the design on the link =
I gave you
on the last reply we do have an averaging mode where we actually need an of=
fset
(effort for supporting that in PWM is already ongoing) between the offload =
trigger
and the peripheral conversion signal (so assuming we only care about period=
 will fail
pretty soon :)).

> pwm {
> }
>=20
> pclk {
> 	compatible =3D pwm-clock
> 	pwms =3D <&pwm 0 x>
> }
>=20
> spi {
> 	compatible =3D spi-engine
> 	clocks =3D <&clks SPI>, <&pwm>
> 	clock-names =3D "bus", "offload"
> }
>=20
> The pwm-clock driver (clk-pwm.c) doesn't implement .set_rate though, but
> maybe you don't need that or maybe it could be added if needed.
>=20
> > And the DMA block is a complete different story. Sharing that data back=
 with the
> > peripheral driver (in this case, the IIO subsystem) would be very inter=
esting at
> > the
> > very least. Note that the DMA block is not really something that is par=
t of the
> > controller nor the offload block. It is an external block that gets the=
 data
> > coming
> > out of the offload engine (or the data reorder block). In IIO, we alrea=
dy have a
> > DMA
> > buffer interface so users of the peripheral can get the data without an=
y
> > intervention
> > of the driver (on the data). We "just" enable buffering and then everyt=
hing
> > happens
> > on HW and userspace can start requesting data. If we are going to attac=
h the DMA
> > in
> > the controller, I have no idea how we can handle it. Moreover, the offl=
oad it's
> > really just a way of replaying the same spi transfer over and over and =
that
> > happens
> > in HW so I'm not sure how we could "integrate" that with dmaengine.
> >=20
> > But maybe I'm overlooking things... And thinking more in how this can b=
e done in
> > SW
> > rather than what makes sense from an HW perspective.
>=20
> I don't think you're overlooking things at all, I'm intentionally being
> a bit difficult and ignoring what may be convenient for the adc driver.
> This is being presented as a solution to a generic problem (and I think
> you're right to do that), but it feels as if the one implementation is
> all that's being considered here and I'm trying to ensure that what we
> end up with doesn't make limiting assumptions.

Yeah, I know and I do agree we need something generic enough and not someth=
ing that
only fits a couple usecases.

>=20
> Part of me says "sure, hook the DMAs up to the devices, as that's what
> happens for other IIO devices" but at the same time I recognise that the
> DMA isn't actually hooked up like that and the other IIO devices I see
> like that are all actually on the SoC, rather than connected over SPI.

Yeah, I know... But note (but again, only for ADI designs) that the DMA rol=
e is
solely for carrying the peripheral data. It is done like this so everything=
 works in
HW and there's no need for SW to deal with the samples at all. I mean, only=
 the
userspace app touches the samples.

TBH, the DMA is the bit that worries me the most as it may be overly comple=
x to share
buffers (using dma-buf or something else) from the spi controller back to c=
onsumers
of it (IIO in this case). And I mean sharing in a way that there's no need =
to touch
the buffers.

> It might be easy to do it this way right now, but be problematic for a
> future device or if someone wants to chuck away the ADI provided RTL and
> do their own thing for this device. Really it just makes me wonder if
> what's needed to describe more complex data pipelines uses an of_graph,
> just like how video pipelines are handled, rather than the implementation
> of io-backends that don't really seem to model the flow of data.
>=20

Yeah, backends is more for devices/soft-cores that extend the functionality=
 of the
device they are connected too. Like having DACs/ADCs hdl cores for connecti=
ng to high
speed controllers. Note that in some cases they also manipulate or even cre=
ate data
but since they fit in IIO, having things like the DMA property in the hdl b=
inding was
fairly straight.

Maybe having an offload dedicated API (through spi) to get/share a DMA hand=
le would
be acceptable. Then we could add support to "import" it in the IIO core. Th=
en it
would be up to the controller to accept or not to share the handle (in some=
 cases the
controller could really want to have the control of the DMA transfers).

Not familiar enough with of_graph so can't argue about it but likely is som=
ething
worth looking at.

- Nuno S=C3=A1
> >=20

