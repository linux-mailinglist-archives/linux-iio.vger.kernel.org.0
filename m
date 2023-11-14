Return-Path: <linux-iio+bounces-56-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 891AD7EAC56
	for <lists+linux-iio@lfdr.de>; Tue, 14 Nov 2023 10:00:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82178B20A84
	for <lists+linux-iio@lfdr.de>; Tue, 14 Nov 2023 09:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39228154AC;
	Tue, 14 Nov 2023 09:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L6Zij4Bc"
X-Original-To: linux-iio@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B90B156C9
	for <linux-iio@vger.kernel.org>; Tue, 14 Nov 2023 09:00:36 +0000 (UTC)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40E46FA
	for <linux-iio@vger.kernel.org>; Tue, 14 Nov 2023 01:00:34 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9e28724ac88so799223766b.2
        for <linux-iio@vger.kernel.org>; Tue, 14 Nov 2023 01:00:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699952433; x=1700557233; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dB1QztoHHlABhtgsxgDiVulFk4zEvh648MH/ph75YbU=;
        b=L6Zij4Bc/BwWOk9fPKnetKJgLOIoCzUnYXIAPs3Y+IPFxZy74QlQwxjh+lQ/hQiM3r
         TI6mZmaoFh8/WjDPmuOGFZFeZ/M5l49eU8XYk9PKCFAMsZH3H5k1kYvGA5Us342IY8QJ
         pUouHeuxvnlr3EQ09PrF7NkkQ7JuuoGN5anHKA36bSVwil6pF/m3QTL2uZr/gf5/uB6O
         ellrSng9Jw6fw4pBlvfxmgtHFV15to5kAB6iZ+9OJHZ9RxQuKOu8r+ZtpMNTuPGFXfug
         aXWKkmS8u7AX8m+6tFNvRZKivN49tfa7xLljieHOlHn6hLNfVA43sPEhYF4JJmBTe7Pv
         PVZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699952433; x=1700557233;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dB1QztoHHlABhtgsxgDiVulFk4zEvh648MH/ph75YbU=;
        b=FPpB9D24ftwZvy6V7Yc869Eyh6RaTn8OjskRwJQ7m6AjP88qG7FsaomBGLIPsx4EwV
         jOcN0THVlZAHJKaGc1yRCZX5Wy76gXofDKgAvQrWrwtb82wrxPcPbwavOwyeSiZRtQ5x
         Dizp04TSU6xr4TTXp1Szzoru0hA9HV6vr4bl8dwoTPlzg/fK+mnnVK8GnNIsGo2pwExz
         +sFpfgrnNWgCuYgIqQf7wLAzff9Aa4jVIb3PKx+t5+IZ82tCe4aP0wgOlAcJbaY+UmFO
         TJexeHweyOAvT5CKPB7ZxVDFj+zofnu7ZFuh918P2Zw01/a5yFHIrbqn8c5fauP9vjPA
         ieOw==
X-Gm-Message-State: AOJu0YzIztK2D1ieSUM4U07PHcp6FnHauikKMIJjjF4QSWCFWZRlHypc
	+CsvNLC4krE/QU+wXDaRgCk=
X-Google-Smtp-Source: AGHT+IEW+0uzCBNPZ78wqDp/2BvwtwXNWQvoTclBDH1RCsLE5qo+b2AapzH/PK3wM7f5Ev4qycyrPw==
X-Received: by 2002:a17:907:764f:b0:9e5:2c72:9409 with SMTP id kj15-20020a170907764f00b009e52c729409mr5914687ejc.43.1699952432314;
        Tue, 14 Nov 2023 01:00:32 -0800 (PST)
Received: from ?IPv6:2003:f6:ef1b:2000:361b:8f29:1cbf:5e69? (p200300f6ef1b2000361b8f291cbf5e69.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:361b:8f29:1cbf:5e69])
        by smtp.gmail.com with ESMTPSA id vi12-20020a170907d40c00b009e776cc92dcsm5030434ejc.181.2023.11.14.01.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 01:00:31 -0800 (PST)
Message-ID: <93e0af8032422491a150153285f5edb58f071d0d.camel@gmail.com>
Subject: Re: [RFC PATCH 1/3] iio: addac: add new converter framework
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Olivier MOYSAN <olivier.moysan@foss.st.com>, Jonathan Cameron
	 <Jonathan.Cameron@Huawei.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Nuno Sa <nuno.sa@analog.com>, 
	linux-iio@vger.kernel.org
Date: Tue, 14 Nov 2023 10:03:29 +0100
In-Reply-To: <9767cd6e-5201-430a-a9e5-f6c2a4ad3de4@foss.st.com>
References: <20230804145342.1600136-1-nuno.sa@analog.com>
	 <20230804145342.1600136-2-nuno.sa@analog.com>
	 <20230830180234.00007437@Huawei.com>
	 <aaed9bdef386f77a4211f6010f96cfaa92e70515.camel@gmail.com>
	 <20230903115653.5bb8c0e8@jic23-huawei>
	 <08793b1b73d7789b595def9afd8652e2f36f8e28.camel@gmail.com>
	 <20230904163114.0000681c@Huawei.com>
	 <9767cd6e-5201-430a-a9e5-f6c2a4ad3de4@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2023-11-13 at 18:20 +0100, Olivier MOYSAN wrote:

Ho Olivier,

> Hi Nuno, Jonathan,
>=20
> On 9/4/23 17:31, Jonathan Cameron wrote:
> > On Mon, 04 Sep 2023 16:14:17 +0200
> > Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
> >=20
> > > On Sun, 2023-09-03 at 11:56 +0100, Jonathan Cameron wrote:
> > > > On Thu, 31 Aug 2023 11:32:54 +0200
> > > > Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
> > > > =C2=A0=C2=A0=20
> > > > > On Wed, 2023-08-30 at 18:02 +0100, Jonathan Cameron wrote:
> > > > > > On Fri, 4 Aug 2023 16:53:39 +0200
> > > > > > Nuno Sa <nuno.sa@analog.com> wrote:
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=20
> > > > > > > Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> > > > > >=20
> > > > > > Hi Nuno,
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=20
> > > > >=20
> > > > > Hi Jonathan,
> > > > >=20
> > > > > Thanks for the initial review...
> > > > > =C2=A0=C2=A0=20
> > > > > >=20
> > > > > > One general comment is that you could have stripped this back a=
 fair
> > > > > > bit
> > > > > > for ease of understanding.=C2=A0 At this stage we don't care ab=
out things
> > > > > > like debug or control of test patterns.=C2=A0 Bring those in as=
 extra
> > > > > > patches.
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=20
> > > > >=20
> > > > > Agreed... As I mentioned (I think) in the cover, I made the RFC b=
igger
> > > > > than
> > > > > needed to
> > > > > kind of showcase how we can properly configure the hdl core to su=
pport
> > > > > things
> > > > > (interface calibration) that were very hard to do with the curren=
t
> > > > > implementation.
> > > > > I'll make sure to add the minimum needed API to accommodate what =
we
> > > > > have
> > > > > right now.
> > > > > =C2=A0=C2=A0=20
> > > > > > I haven't fully gotten my head around the ordering constraints =
on
> > > > > > removal.
> > > > > > Are there other users of the component framework that have simi=
lar
> > > > > > problems?
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=20
> > > > >=20
> > > > > My understanding on the component API is that one should do all t=
he
> > > > > tear
> > > > > down in the
> > > > > .unbind() callback. As usual, I can see some drivers not really d=
oing
> > > > > that.
> > > > > =C2=A0=C2=A0=20
> > > > > > Also, I don't yet understand how a multiple front end, single
> > > > > > backend
> > > > > > setup
> > > > > > would work.=C2=A0 Or indeed single front end, multiple backend.=
..=C2=A0 Maybe
> > > > > > we
> > > > > > don't
> > > > > > need those cases, but if we want this to be useful beyond adi-a=
xi we
> > > > > > probably at least want an outline of how they work.
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=20
> > > > >=20
> > > > > Indeed we can have multiple (and we have it out of tree) backends=
 on
> > > > > one
> > > > > frontend.
> > > > > Think on an ADC/DAC with fairly complex data path with more than =
one
> > > > > channel/interface (CMOS, LVDS, etc). Typically, in those case, ea=
ch of
> > > > > the
> > > > > interface
> > > > > will be connected to an instance of the hdl core (the backend).
> > > >=20
> > > > That might work out for your case, but not the stm32 one where I th=
ink
> > > > we can
> > > > end
> > > > up with interleaved data from two front ends in the same buffer...
> > > > =C2=A0=C2=A0=20
> > >=20
> > > Not sure I'm following this one. But wouldn't that be something speci=
fic
> > > for
> > > each system (through devicetree)? I haven't tried but I think the sam=
e
> > > backend
> > > could be used in different frontend devices (using the component API)=
.
> > > That is
> > > not really a usecase for me but definitely something that could be
> > > supported (if
> > > we need to start doing things like keep enable/disable counters and s=
o on)
> > > if it
> > > is a usecase for stm32.
> >=20
> > If we are going to support both usecases, we just need to figure out wh=
at
> > composite
> > devices with N-M backend - frontend look like and make sure that doesn'=
t
> > cause problems.=C2=A0 I'd expect the separation between backend instanc=
es might
> > reflect data storage on capture but then again that might end up like t=
he
> > many
> > IIO devices for many buffers mess we had before the multiple buffer sup=
port
> > was added.
> >=20
>=20
> The stm32 dfsdm interleaved use case is not a problem as it is possible=
=20
> to associate several backends to a frontend.
> I did some experiments based on converter framework, and did not=20
> identified blocking points regarding dfsdm use cases.
>=20
> Some limitations where discussed in [1], about generic bindings support.
> The preferred solution was to extend converter_frontend_add_matches() to=
=20
> parse also child nodes. I have added converters_get_from_fwnode() API=20
> and adapted converter_frontend_add_matches() to test this approach.
> With this changes and an additional api to support channel attributes=20
> read, the framework fulfills all the needs for dfsdm.
>=20
> So, I feel comfortable to drop my previous "backend framework" proposal,=
=20
> and move to the current proposal.
>=20
> If we go further in converter framework adaption, I will push these updat=
es.
>=20

I hope you didn't had too much trouble with those patches. The reason I'm s=
aying
this is because, after some thought, I'm strongly considering in moving to
normal OF/ACPI lookup. 3 mains reasons for it:

1) That "hack/rule" for a driver to provide a .remove() callback (in order =
to
devm_*) is really non obvious and might even be prune to subtle bugs (that =
I'm
not seeing now :)). But my main argument is that it can become hard to main=
tain
it (depending on how much people starts to use the framework).

2) From the discussion we had about the limitations you pointed in your lin=
k, I
started to realize that it might get harder to scale the framework. Yes, we
found a fairly easy way of doing it but still took more code to do it when
compared to a typical lookup.

3) This is the most important together with 1). You mentioned something lik=
e
cascaded designs and I just found an usercase in ADI out of tree drivers. W=
e
have a design where we have something like:

                   ------------------------------------------
                   |		FPGA			    |
--------------     |  -------------    -------------------  |
|DAC Frontend| ->  |  |DAC Backend| -> |DAC Interpolation|  |
--------------     |  -------------    -------------------  |
                   |					    |
                   ------------------------------------------

In the above design we kind of have a cascaded thing where the DAC backend =
is
both a frontend and a backend and the Intrerpolation stuff just serves as
backend to the DAC core. So, ideally the DAC frontend should not have to kn=
ow a
thing about the interpolation... I realized that having this with the compo=
nent
framework is far from straight because we would need two components/aggrega=
te
devices to accomplish this (DAC Front + DAC Back) and (DAC Back + DAC Inter=
p)
and I think we would need some extra care regarding one of the components g=
oing
away (not sure though). One way to make it simple would be to not "respect"=
 the
HW configuration and just have one aggregate device with 1 Frontend + 2 Bac=
kends
and so the frontend would need to "know" about the interpolation core. Agai=
n, I
think that with OF/ACPI this setup with be fairly straight to get and "resp=
ect".

Anyways, all the above makes me feel that component might not be the best c=
hoice
(even though I was eager to use it :))=20

I'll also get to work on this again and I might just use an industrialio-
backend.c file in the base dir as you had in your RFC. From a quick look on=
 your
series, I'm no sure how much code I will reuse but we can see later if a Co=
-
authored-by tag makes sense or not.

Let me know if there's something you don't agree or if there's any concern =
on
your side.

- Nuno S=C3=A1
> > >=20

