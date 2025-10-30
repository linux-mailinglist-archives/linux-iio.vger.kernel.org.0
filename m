Return-Path: <linux-iio+bounces-25667-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 71BE0C1FD53
	for <lists+linux-iio@lfdr.de>; Thu, 30 Oct 2025 12:32:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 38A304EACD1
	for <lists+linux-iio@lfdr.de>; Thu, 30 Oct 2025 11:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C8C2E7F08;
	Thu, 30 Oct 2025 11:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="avHiK9ad"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF80B2E7182
	for <linux-iio@vger.kernel.org>; Thu, 30 Oct 2025 11:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761823825; cv=none; b=n7Z6tehc41aEVJO8v/FkTNJ436wlYIwJMZe+xLrOqsdzVZXMLf44Oynp6laZJHOQr/1ZeuiAlOVD3+bobVOQ5RpY5z18uafH+1XyxZAIih9rVjNZ9LCK0/db1FaCLrSs79ixptcSUef/gxLJpCX9Tp7qQfx+x/1BPziA61Gn3Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761823825; c=relaxed/simple;
	bh=4uA8/LSk51CL/xWdnxtTQ8rqPvqegWlSzlDh/g8t3tg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=E7viqwJFc/NWtNnAZXduxLaPuoCd3fTyGHyi+EsxmnsoUV0TpER3/Z2P639FB/Akoa7/mxQHqpyGUWcRU+LKkFH3puyiSyeFMh3LHZJLTVKyyG+6eyj546YRn3MEt92qymzGTGSjZxJ9XweMV3/9JBW+L8+e1RPxGH+bTTtpPy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=avHiK9ad; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4711810948aso7185915e9.2
        for <linux-iio@vger.kernel.org>; Thu, 30 Oct 2025 04:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761823821; x=1762428621; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=K2qKS73IWJ8+zq351GS6CPlwYR91jDvtL1Q7uQRB4zs=;
        b=avHiK9adneFUSMetft1tBDDUZD4q5DSAEoOlHz743KEu7E+Oz2DEkMHOXcD1D4VkkY
         koQdnmjeeJwbwRqcGFE8RXNmHI+ymNWRqDbyskoj4y+7K8NrLOxk4Sz7cApIsjlZdeWi
         g900sLTqqlfDq2K/Q6joI3CaBorSg7bbcUEMMhORepwTR1BkupXh1NrShpWfWTWO6hXU
         3TbGo/gfY7Zgib1lZh/RcmuLljSLoeztKR5D4St1UBaMAUuKe6y1u7cDZhb1xtiLdcEn
         emGKrr4lof/VnwayDLVHFvny8NE0SHhWYUSe4gHXR8Y+NBnveKPIPu4xwyWm27x5tAvj
         7gyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761823821; x=1762428621;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K2qKS73IWJ8+zq351GS6CPlwYR91jDvtL1Q7uQRB4zs=;
        b=tDq9gcrZOmmhdF0jeDu5RpmGrKFneLw1gifuXJy7seYrE4XCRqVIFNGHZiJ6MnU51U
         g5klsQvIw2HRiYPGqCsvq8RxI6QKfIv10gcPg84J92SFzIZ1FBcl2+x7KfExuRPQn4m9
         uBjjICj3L+r9ZORoRQQ4N2CuWBSb3w79FIvT9/rE3b+0hNDDc/m56JGSY5/o968nUsuR
         g3Oh9H5A09jFRXV7J4YM0Eu+Axt2woOklVMNcFlJvdbbT2vAW6V7k2azQD7klzQX6pTk
         H6BVonVLMVa068J+sFTmCqS57QLxdJ8DCzZoxlRVf47NQHXD6wgFnbUFOG8rmkRd6x4r
         AYvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWoIuETT0xWg6vi1RTIaXaBJOCd475LeF5RGg6++6LXjA+BceBkviwDRFA7SKODcEykrEUTedA8g6k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPYD58Y7AXliuYxpLJyY6JY9gWrEkFnJI0Oh4zKKjUzze1yvJF
	BQk6og5YDgneV5dgebZlM4OAHBne7KUn5M147pXVBvrylianhkuzMvv/
X-Gm-Gg: ASbGncvkHRkxZlmZXa83qH6n+BYIZDxlO4hIWecLOkzOCv7BeJ26pxAH/2ZcW5VYvxj
	WHNNXkzT2ItiEnpWimMPU7VXx67jfi4BBsKKeG5go+OWXT6itC71g2adaoyVFSZoq0lYApAeNfs
	gaCL/66uL/myQnWk+qFHRjPW/UB4jL0I6+E28zMggHCAZbUdBfv7aPhi1CbbN2oYPzYd6NVAI1T
	KA2ieyI5izOL8YrRjQV3MHX1dtOw+ROlzuc/NREBW5eiKpTCCxVlbNpyYDXLdRs/5OfalxbJD4I
	xia1S8LpPTLqmIMRPIkVuWdwLG8RkJovNAIh8HuExaqfx77YtZkbQzd1/H9xeJG3v6Dk2J8/Ufm
	KLjdXZ7qA3+YBxd0K6HZzQO+wn4p07Tsi2OBK9xblOnH5B7WlNLQsQYcI0CrwXTlMV3CrejPSSU
	vA41t2KwiEpHU=
X-Google-Smtp-Source: AGHT+IFSOpkJSdg6ugWCyA5+Rww0fX360jymnHQbC2nFr3fn+6+n66mWuXI9qqpzsxPXHfdZA0PV6Q==
X-Received: by 2002:a05:600c:4e8e:b0:471:9da:5232 with SMTP id 5b1f17b1804b1-4771e333a2amr54208215e9.15.1761823820643;
        Thu, 30 Oct 2025 04:30:20 -0700 (PDT)
Received: from [10.5.0.2] ([91.250.240.53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4771904fc1bsm64161175e9.11.2025.10.30.04.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 04:30:20 -0700 (PDT)
Message-ID: <1a95bd186bf1b5b3e2d3b3808069dba6649bafd1.camel@gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: iio: dac: Document AD5446 and
 similar devices
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>, Nuno
 =?ISO-8859-1?Q?S=E1?=	 <nuno.sa@analog.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>,  David Lechner <dlechner@baylibre.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski	 <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, 	linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org
Date: Thu, 30 Oct 2025 11:30:55 +0000
In-Reply-To: <20251027150136.6cfd3774@jic23-huawei>
References: <20251023-ad5446-bindings-v2-0-27fab9891e86@analog.com>
		<20251023-ad5446-bindings-v2-1-27fab9891e86@analog.com>
		<20251023180831.000026ca@huawei.com>
		<ffb2512aad9bec33b0fe27035f88e79636362645.camel@gmail.com>
	 <20251027150136.6cfd3774@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-10-27 at 15:01 +0000, Jonathan Cameron wrote:
> On Mon, 27 Oct 2025 14:48:50 +0000
> Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
>=20
> > On Thu, 2025-10-23 at 18:08 +0100, Jonathan Cameron wrote:
> > > On Thu, 23 Oct 2025 14:01:37 +0300
> > > Nuno S=C3=A1 <nuno.sa@analog.com> wrote:
> > > =C2=A0=20
> > > > Add device tree binding documentation for the Analog Devices AD5446
> > > > family of Digital-to-Analog Converters and compatible devices from
> > > > Texas Instruments. There's both SPI and I2C interfaces and feature
> > > > resolutions ranging from 8-bit to 16-bit.
> > > >=20
> > > > The binding covers 29 compatible devices including the AD5446 serie=
s,
> > > > AD5600 series, AD5620/5640/5660 variants with different voltage ran=
ges,
> > > > and TI DAC081s101/DAC101s101/DAC121s101 devices.
> > > >=20
> > > > Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>=C2=A0=20
> > > Hi Nuno,
> > >=20
> > > Thanks for filling in this missing doc.=C2=A0 I wonder what else is o=
ld
> > > enough that we still don't have docs? Guess I should check when
> > > I'm next bored enough (so that's not happening any time soon ;)=C2=A0=
=20
> >=20
> > Yeah, wouldn't be surprised if there's some more ADI old stuff hanging =
around.
> > This caught my attention since I saw that out of tree patch adding supp=
ort for a
> > new device (with no real reason for not being in tree).
> >=20
> > > =C2=A0=20
> > > > ---
> > > > =C2=A0.../devicetree/bindings/iio/dac/adi,ad5446.yaml=C2=A0=C2=A0=
=C2=A0 | 138
> > > > +++++++++++++++++++++
> > > > =C2=A0MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 8 ++
> > > > =C2=A02 files changed, 146 insertions(+)
> > > >=20
> > > > diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5446.y=
aml
> > > > b/Documentation/devicetree/bindings/iio/dac/adi,ad5446.yaml
> > > > new file mode 100644
> > > > index 000000000000..90fc8ca053fe
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5446.yaml
> > > > @@ -0,0 +1,138 @@
> > > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/iio/dac/adi,ad5446.yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: Analog Devices AD5446 and similar DACs
> > > > +
> > > > +maintainers:
> > > > +=C2=A0 - Michael Hennerich <michael.hennerich@analog.com>
> > > > +=C2=A0 - Nuno S=C3=A1 <nuno.sa@analog.com>
> > > > +
> > > > +description: |=C2=A0=20
> > >=20
> > > Trivial but don't need the | as hardly matters if these get formatted
> > > differently.=C2=A0=20
> >=20
> > Sure.
> >=20
> > > =C2=A0=20
> > > > +=C2=A0 Digital to Analog Converter devices supporting both SPI and=
 I2C
> > > > interfaces.
> > > > +=C2=A0 These devices feature a range of resolutions from 8-bit to =
16-bit.=C2=A0=20
> > >=20
> > > ...
> > > =C2=A0=20
> > > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > > index 940889b158eb..dae04c308975 100644
> > > > --- a/MAINTAINERS
> > > > +++ b/MAINTAINERS
> > > > @@ -440,6 +440,14 @@ W:	http://wiki.analog.com/AD5398
> > > > =C2=A0W:	https://ez.analog.com/linux-software-drivers
> > > > =C2=A0F:	drivers/regulator/ad5398.c
> > > > =C2=A0
> > > > +AD5456	DAC DRIVER=C2=A0=20
> > > Tab seems odd here.=20
> > >=20
> > > Hmm. For a lot of ADI drivers we have entries that would look like
> > > ANALOG DEVICES INC AD5456 DAC DRIVER
> > >=20
> > > Any reason for formatting it like this?=C2=A0=20
> >=20
> > Ok, time to come clean :)
> >=20
> > Bindings were AI generated and then I just cleaned the obvious problems=
 (clearly
> > I did not payed too much attention to the boilerplate stuff - lesson le=
arned).
>=20
> I'd hold off on doing anything much with AI on kernel code for now.
> A clear policy might come out of the maintainers summit in December.
> If you are curious, various threads on: https://lore.kernel.org/ksummit/

Right, I did saw some threads regarding some patches being automatically se=
nt
(I think the AUTOSEL stuff for stable) by AI. Not completely the same here =
as I still
reviewed it and changed things (more like co-developed thing :)).
=20
>=20
> DT bindings get picked up by various projects so they may have their own
> policy long run.
>=20

I see, it's kind of handy (for bindings not so complicated) as it can come =
up with maybe
50/60% of the whole thing. But sure, I will refrain from using it until we =
have a clear
policy in place.

BTW, writing covers and commit messages would be fine, right?

- Nuno S=C3=A1

> J
>=20
> >=20
> > - Nuno S=C3=A1
> >=20
> > > =C2=A0=20
> > > > +M:	Michael Hennerich <michael.hennerich@analog.com>
> > > > +M:	Nuno S=C3=A1 <nuno.sa@analog.com>
> > > > +L:	linux-iio@vger.kernel.org
> > > > +S:	Supported
> > > > +W:	https://ez.analog.com/linux-software-drivers
> > > > +F:	Documentation/devicetree/bindings/iio/dac/adi,ad5446.yaml
> > > > +
> > > > =C2=A0AD714X CAPACITANCE TOUCH SENSOR DRIVER (AD7142/3/7/8/7A)
> > > > =C2=A0M:	Michael Hennerich <michael.hennerich@analog.com>
> > > > =C2=A0S:	Supported
> > > > =C2=A0=20

