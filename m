Return-Path: <linux-iio+bounces-529-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A708006A2
	for <lists+linux-iio@lfdr.de>; Fri,  1 Dec 2023 10:14:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2C121C209FD
	for <lists+linux-iio@lfdr.de>; Fri,  1 Dec 2023 09:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 166D11CAB8;
	Fri,  1 Dec 2023 09:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GDjT5o0q"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC08B194;
	Fri,  1 Dec 2023 01:14:10 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2c9afe6e21fso25378011fa.0;
        Fri, 01 Dec 2023 01:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701422049; x=1702026849; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LJuFOgiVO7LDpcAHWQzERNBo1i1LSIVcGAkRUEULNvw=;
        b=GDjT5o0qGDXrr/BVCkoHltSJM/wsh4G3dzXpFn6MC9Wr5ZWhYXrpLhBdDZ13yQ3/Y9
         nGScBbMhmnl6mOUopajfyTmIWqbbMezZdEhT2j19WbSlV+L/JtZNZiJ8WimhoBtgTEeU
         JPXrQTE4fHdp1L2xkHr2Qi7s+OaQ0v3ZUVJoXI2s7HkegrxucfkChFHo49lZSR/on05o
         LxhtMHHic88ujDKbQlnoiW24uPa8rc7VF30rc1ddPF3YlZ3GY50/SKaGS2nCGfLJhzQq
         nfd189dBrAdjQSWhDCdehezke0gUO7G904KtFtpc+y7stgC5hP9vSbrRhxQI09XPeSxu
         WNlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701422049; x=1702026849;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LJuFOgiVO7LDpcAHWQzERNBo1i1LSIVcGAkRUEULNvw=;
        b=Q7PKUUKvpqXXxY7ebi4KJKzbOr+Ju8XZ2cd2cBh21lNWyT/6wzQce/GAYDQiCE4YFF
         bi0NBpEMz3c0u/EpiuYvcHNP2mnMWyi/KxFl5pwUnFRC8C2HlPBaSDiJU2eesaA3bCxz
         +R+BjMA1oImix4vrZH2NmGC88RWJNAMew5Osc6EluLCT7OX0GOnK8Ow/Q2LD6w6kRMpV
         wLiPbzVulw+DFv7d9MUsvIoXi1Is3MRNnuTNSKDDnBsFYZ5QGKgqcbF8rOJ9WnE1xVdP
         taA0nw8f7f32/EayF+iR7/Xflw8H6c7nTA/SzdohNRiHR/iOEOo0KwkdjjKQyZ1G+SUq
         AlgA==
X-Gm-Message-State: AOJu0Yzvyob6+xy83OdjRdZ9WypWQxLKrAJz76sLTpI8CBRf0ZhEFOoJ
	7RPIIGP8ds2hyn600lG1eeA+APxbn93VMIvE
X-Google-Smtp-Source: AGHT+IF6VrKAEFWor1ZpOLJPZ2guiIvAE4LplEqw8HbHagnQx5gTjp6/Rk136Tv88C1JsjkXDeEP/A==
X-Received: by 2002:a2e:901a:0:b0:2c9:d863:2c12 with SMTP id h26-20020a2e901a000000b002c9d8632c12mr596841ljg.59.1701422048983;
        Fri, 01 Dec 2023 01:14:08 -0800 (PST)
Received: from ?IPv6:2001:a61:3456:4e01:6ae:b55a:bd1d:57fc? ([2001:a61:3456:4e01:6ae:b55a:bd1d:57fc])
        by smtp.gmail.com with ESMTPSA id o17-20020a5d4751000000b00332f82265b7sm3681185wrs.20.2023.12.01.01.14.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 01:14:08 -0800 (PST)
Message-ID: <265446de947bf8100aa96fb3799005b113251fc7.camel@gmail.com>
Subject: Re: [PATCH 00/12] iio: add new backend framework
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, nuno.sa@analog.com
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-iio@vger.kernel.org, Olivier MOYSAN <olivier.moysan@foss.st.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Rob Herring <robh+dt@kernel.org>, Frank Rowand
 <frowand.list@gmail.com>, Jonathan Cameron <jic23@kernel.org>, Lars-Peter
 Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>
Date: Fri, 01 Dec 2023 10:14:08 +0100
In-Reply-To: <0afd52940147b14db33d4712368c5dcc9ee90882.camel@gmail.com>
References: <20231121-dev-iio-backend-v1-0-6a3d542eba35@analog.com>
	 <CAMknhBH0pF_+z_JqWGscELBmAEDyxLAtgQ-j3=6P2MeFXnzhWQ@mail.gmail.com>
	 <0afd52940147b14db33d4712368c5dcc9ee90882.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2023-12-01 at 09:41 +0100, Nuno S=C3=A1 wrote:
> On Thu, 2023-11-30 at 17:54 -0600, David Lechner wrote:
> > On Tue, Nov 21, 2023 at 4:17=E2=80=AFAM Nuno Sa via B4 Relay
> > <devnull+nuno.sa.analog.com@kernel.org> wrote:
> > >=20
> > > Hi all,
> > >=20
> > > This is a Framework to handle complex IIO aggregate devices.
> > >=20
> > > The typical architecture is to have one device as the frontend device=
 which
> > > can be "linked" against one or multiple backend devices. All the IIO =
and
> > > userspace interface is expected to be registers/managed by the fronte=
nd
> > > device which will callback into the backends when needed (to get/set
> > > some configuration that it does not directly control).
> > >=20
> > > The basic framework interface is pretty simple:
> > > =C2=A0- Backends should register themselves with @devm_iio_backend_re=
gister()
> > > =C2=A0- Frontend devices should get backends with @devm_iio_backend_g=
et()
> > >=20
> > > (typical provider - consumer stuff)
> > >=20
> >=20
> > The "typical provider - consumer stuff" seems pretty straight forward
> > for finding and connecting two different devices, but the definition
> > of what is a frontend and what is a backend seems a bit nebulous. It
> > would be nice to seem some example devicetree to be able to get a
> > better picture of how this will be used in practices (links to the the
> > hardware docs for those examples would be nice too).
> >=20
> > In addition to the backend ops given in this series, what are some
> > other expected ops that could be added in the future? Do we need some
> > kind of spec to say "I need a backend with feature X and feature Y" or
> > "I need a backend with compatible string" rather than just "I need a
> > generic backend"?

To also reply to this one, I also have somewhere a comment about it (I thin=
k in the
code itself). For now, I'm thinking in this to serve all kinds of IIO devic=
es in a
generic way which means, yes, the ops structure can grow badly. I'm not so =
sure if
that will actually happen in practise but if it does we can always play som=
e OOP
games and leave the backend with the generic stuff (like .enable()/.disable=
() and so
on) and extend it (for example: having a converters thing that would have o=
ps more
suitable for ADCs/DACs). Anyways, for now I think that would be overcomplic=
ating
things. It's in kernel interfaces so we can always change things.


- Nuno S=C3=A1

