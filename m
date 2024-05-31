Return-Path: <linux-iio+bounces-5523-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E70308D5BA3
	for <lists+linux-iio@lfdr.de>; Fri, 31 May 2024 09:39:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E0D21C20EF2
	for <lists+linux-iio@lfdr.de>; Fri, 31 May 2024 07:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B6174065;
	Fri, 31 May 2024 07:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GTe+xDqN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C053A74050;
	Fri, 31 May 2024 07:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717141163; cv=none; b=mX1i4R4l+MKkN3wR0E49TnNCjAYjVmh/K1PYzp3wXH6EmElDriFIprmX5uN3oypvZRwVDa0YhAgBJJ3S0sHjhxEe6t3rokupZ3vbsN+DclygLzSrEJGl5lQrZUUFPveqwl+u4J4AzkohVjGUTg04LxyYfCBjrlEpWHxoYT6upd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717141163; c=relaxed/simple;
	bh=9ftpAWAlMTy7FmybzWVyWQRDjCSXgA1sqhlGCsYFDak=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VxZ7uuUKJJphlsnws4qoAud1gFCczvvslw9uicJY/SqtBNPX+78dMMpqkowSDes3c81ruwft1PoI4jy33ceCKHCQtOpHXoVaVYvEbJYILOqg16Or29HCSSEaeklrXsQj5g5g7QHGfsdpMri9+rvmWVtzximdJrnHx4C0K9wJkM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GTe+xDqN; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-57a1fe63947so1209984a12.1;
        Fri, 31 May 2024 00:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717141160; x=1717745960; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9ftpAWAlMTy7FmybzWVyWQRDjCSXgA1sqhlGCsYFDak=;
        b=GTe+xDqNTCsi8xXxtZyzPRdA7q0Fyp1ICpitl95cq5ybf07p1q8GIsVXxzMvtT+tpC
         xxgzsva2mFu7X/tN2DRbAx9vuOUJe2b+rQdHRfmJevNUQQtiJwoORMcMZX5U2fSj0Pb6
         mqlY8EVbMTif4ODxLTQnzpIuGyAzUbblv5GRunnNR4R4EoD76t9An973SGSGO+f1aT1y
         OfXOSbM+huQd8fE0gPKK4Uqhxd62t27Jck0JtmKKR9+NglaP1otZv2SajzDEuvtUEcAj
         TMBCmfnEco0f039rxCoKvv/iVnGTBaobvZptZx84Io9vb8UMkzR8d0hnUwuMT30eLSNM
         juRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717141160; x=1717745960;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9ftpAWAlMTy7FmybzWVyWQRDjCSXgA1sqhlGCsYFDak=;
        b=W0+s77If+LEq4di5tO5xsbWW22QaVGBcSgZJTOFlE8qQ3IV3y90wTtgG7VDL39dNrB
         gf3pNylnW+P3UTFq4iIJD7Qt/rdKDkYshQizahHLa5Pr8K8K0X0tfS+NT2o6RHczDrT2
         nSZ5voV5fLPirTt5Sy1PRnD/34nzsFYheSQaNU4pj6VNLah3YfU29W84D6VdKxRpNmlW
         NItNHqFi0iEYSCi/Q6ZlO15CV2YjryFnYcrMk9qVSVKZVBEP86/y3/a8ArBwRbLpwdo0
         2+ntH1zg9rKT5I19n0oZpq6k49o+U8wV3ybBP7DSvRoN1MxP+T4k+9HaKtMrCKNcTlHR
         Ctmg==
X-Forwarded-Encrypted: i=1; AJvYcCUg9s0ifzUekEVKIadivVSTSN4Cg2U3f9ntrjJh/sTYcGKX2IB3wEqHrgixtjC80d18DF+t1UmcJBIlW5XbIPbP/CYkO3PQEw0DWPlOztoeTyiQkhw+BfgAh0pMT3eBoX8UIzyNY9cgb0ldqP3jAY1d0xb0YoWPuzBMEhTvi2K2Fs36ZSNMAdyVBB7vHEV8ija/36JGF9z+hoCJwt85iQ==
X-Gm-Message-State: AOJu0YxyT5RqiV+SZYdRJ5JRg86hVgN0LFMHy504ENS0UdESHZmRm/EW
	Ml3VwM0mFpYljpV0tZ2EJNsscsBBGjB3OKAR9FhCGGEwBcs4hnQ5
X-Google-Smtp-Source: AGHT+IGLxp3DxPs7x0jik+0BC2ZE83//E8Wag3AEG/kSyyrOuaEMEHJXdDOM/AMaD0q/36eXFLyohQ==
X-Received: by 2002:a17:906:4752:b0:a59:9a68:7327 with SMTP id a640c23a62f3a-a68219826b3mr76219866b.54.1717141159821;
        Fri, 31 May 2024 00:39:19 -0700 (PDT)
Received: from nsa.fritz.box ([2001:a61:35f9:9001:40df:88bb:5090:7ab6])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a67e78db9b9sm57636966b.97.2024.05.31.00.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 00:39:19 -0700 (PDT)
Message-ID: <d8d95f957f465148f0ddb6eae87159a2394cf2e9.camel@gmail.com>
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
Date: Fri, 31 May 2024 09:39:19 +0200
In-Reply-To: <20240530-petunia-genre-2731493dbd0f@spud>
References: <20240514-aspire-ascension-449556da3615@spud>
	 <CAMknhBFFpEGcMoLo5gsC11Syv+CwUM0mnq1yDMUzL1uutUtB+Q@mail.gmail.com>
	 <20240516-rudder-reburial-dcf300504c0a@spud>
	 <CAMknhBF_s0btus4yqPe-T=F3z7Asi9KkRGsGr7FHDFi=k4EQjw@mail.gmail.com>
	 <20240519-abreast-haziness-096a57ef57d3@spud>
	 <CAMknhBHvEse2FyDoBXR1PvymGpSGq8dotKfm+8XH+0+k+xKtQw@mail.gmail.com>
	 <20240522-gullible-ibuprofen-cf9111c25f6f@spud>
	 <5ad0b5782434eaf4cf565cffb0e4c14b7414ae38.camel@gmail.com>
	 <20240526-peculiar-panama-badda4f02336@spud>
	 <10991373cb9603803df63d8236c475807f6dde68.camel@gmail.com>
	 <20240530-petunia-genre-2731493dbd0f@spud>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1 (3.52.1-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-05-30 at 20:18 +0100, Conor Dooley wrote:
> On Wed, May 29, 2024 at 10:07:37AM +0200, Nuno S=C3=A1 wrote:
> > On Sun, 2024-05-26 at 18:35 +0100, Conor Dooley wrote:
> > > On Thu, May 23, 2024 at 02:15:35PM +0200, Nuno S=C3=A1 wrote:
> > > > On Wed, 2024-05-22 at 19:24 +0100, Conor Dooley wrote:
>=20
> > > > Taking the
> > > > trigger (PWM) as an example and even when it is directly connected =
with the
> > > > offload
> > > > block, the peripheral still needs to know about it. Think of sampli=
ng
> > > > frequency...
> > > > The period of the trigger signal is strictly connected with the sam=
pling
> > > > frequency of
> > > > the peripheral for example. So I see 2 things:
> > > >=20
> > > > 1) Enabling/Disabling the trigger could be easily done from the per=
ipheral
> > > > even
> > > > with
> > > > the resource in the spi engine. I think David already has some code=
 in the
> > > > series
> > > > that would make this trivial and so having the property in the spi =
controller
> > > > brings
> > > > no added complexity.
> > > >=20
> > > > 2) Controlling things like the trigger period/sample_rate. This cou=
ld be
> > > > harder
> > > > to do
> > > > over SPI (or making it generic enough) so we would still need to ha=
ve the
> > > > same
> > > > property on the peripheral (even if not directly connected to it). =
I kind of
> > > > agree
> > > > with David that having the property both in the peripheral and cont=
roller is
> > > > a
> > > > bit
> > > > weird.
> > >=20
> > > Can you explain what you mean by "same property on the peripheral"? I
> > > would expect a peripheral to state its trigger period (just like how =
it
> > > states the max frequency) and for the trigger period not to appear in
> > > the controller.
> > >=20
> >=20
> > Just have the same 'pwms' property on both the controller and periphera=
l...
>=20
> Yeah, no... Opinion unchanged since my last message.
>=20

...

> >=20
>=20
> If only we had another user... I suppose you lads are the market leader
> in these kinds of devices. If I did happen to know if Microchip was
> working on anything similar (which I don't, I work on FPGAs not these
> kinds of devices) I couldn't even tell you. I suppose I could ask around
> and see. Do you know if TI is doing anything along these lines?
>=20

Unfortunately, no idea.

> > > Part of me says "sure, hook the DMAs up to the devices, as that's wha=
t
> > > happens for other IIO devices" but at the same time I recognise that =
the
> > > DMA isn't actually hooked up like that and the other IIO devices I se=
e
> > > like that are all actually on the SoC, rather than connected over SPI=
.
> >=20
> > Yeah, I know... But note (but again, only for ADI designs) that the DMA=
 role is
> > solely for carrying the peripheral data. It is done like this so everyt=
hing works
> > in
> > HW and there's no need for SW to deal with the samples at all. I mean, =
only the
> > userspace app touches the samples.
> >=20
> > TBH, the DMA is the bit that worries me the most as it may be overly co=
mplex to
> > share
> > buffers (using dma-buf or something else) from the spi controller back =
to
> > consumers
> > of it (IIO in this case). And I mean sharing in a way that there's no n=
eed to
> > touch
> > the buffers.
>=20
> <snip>
>=20
> > Maybe having an offload dedicated API (through spi) to get/share a DMA =
handle
> > would
> > be acceptable. Then we could add support to "import" it in the IIO core=
. Then it
> > would be up to the controller to accept or not to share the handle (in =
some cases
> > the
> > controller could really want to have the control of the DMA transfers).
>=20
> Yeah, that is about what I was thinking. I wasn't expecting the spi code
> to grow handing for dmabuf or anything like that, just a way for the
> offload consumer to say "yo, can you tell me what dma buffer I can
> use?". Unless (until?) there's some controller that wants to manage it,
> I think that'd be sufficient?

Yeah, I could see some kind of submit_request() API with some kind of compl=
etion
handler for this. But on the IIO side the DMA code is not that straight (ev=
en getting
more complex with dma-buf's) so I can't really tell how the whole thing wou=
ld look
like. But may be something to look at.

- Nuno S=C3=A1=20

