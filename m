Return-Path: <linux-iio+bounces-5522-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B83408D5B91
	for <lists+linux-iio@lfdr.de>; Fri, 31 May 2024 09:33:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAFA91C2101B
	for <lists+linux-iio@lfdr.de>; Fri, 31 May 2024 07:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 684A574057;
	Fri, 31 May 2024 07:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f8NEfzpx"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93981482D7;
	Fri, 31 May 2024 07:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717140829; cv=none; b=r2jTUuEZWgfR1bGOVKVZ6Hin/NrEVgJmir7lBJ4x1UVgD3UfLAHOFIrqjfLi0n8g9zKSV0HLjhNPmFkIP32wFGAYez0CeSfNYbCjdrUAxMxlIUDNqOMr8opgDOI2XayT8zXXQ3iziRGvivxEMBZUmfvKjHHEizEcwQ3+Chn9n9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717140829; c=relaxed/simple;
	bh=upVR2zdmOmV2PjDOyS4rb5HI5f6pXw6b1JkflcVTmhI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RF4GAZU0+hiEcjzvFFu7FP46+n56UiPRoVDhAUJFW55h05VZWB2/FqpRiKoOJY87b0zzy9HAjybsQajgv6/oOUKieqno5O40AvbzXnnG3Bj2V6pW/hr78s9lLlS42uzNOsi7Ofe6QPOLCLKY5c8hZr2viO1F8OCrkHNYM569GGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f8NEfzpx; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a626919d19dso327024766b.0;
        Fri, 31 May 2024 00:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717140826; x=1717745626; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=upVR2zdmOmV2PjDOyS4rb5HI5f6pXw6b1JkflcVTmhI=;
        b=f8NEfzpxPO83Qrn8VZObY0aS9qP9MrP7LktgKq7kYVZAe4MnIwnUMJipqFpS4D4j8z
         8PxuQjl7WBJM6ezaXIFcdj3CUH2bSk4/lSP07TZX0VXdLBUODg85iIBfageUjVrnpxU5
         AsM02n1Vhh+EtvRl7SsOMgG9rOj51BAkO1XOMzC+T2u4NSbFxebek77+XpDX8MQs/+w/
         QwN36sKXgR8I+JGViM8z7wk1ux+cRsc2NBREDlLWxEy4sISld21MLfKcT1hPxOj83QxL
         GbzaIwaa0idmT8jSPZf4u10ZOzCZkq1UQC8eZJdxuFUhyq6uTqXwrRWtQW9wiK4TNZPf
         msQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717140826; x=1717745626;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=upVR2zdmOmV2PjDOyS4rb5HI5f6pXw6b1JkflcVTmhI=;
        b=nWIDASzTLh/+8/XJxXSGbCEl2WDxyRj3JNLNYiZgKX8DM+BeK2bcUaB40NEb9SP0NO
         iOnEbhwYH+1ID3eiYkpm7raj2AeWbd7eoPOdl3e/rBiM6d+1ZjBOIdr0q+VxuU1yLkhP
         VfzGHqrtISYemOAzb5UhPh6ZwFlvK3v7LjMBKlC9UOr59CVJyaAjq3KAQpz7SiIn+3EC
         OiC+7pdrTDOo1n7PApmmUU6LnvihosDa3W6pahxvahw3wG9k3d/BrnevValJ0/uPqh12
         LPTVhay7L8J1iZ3/pK51h/4mmHp4rn/zXPNLRZNlC4eo8OikVjf5MUDjd+qjsvNofw5K
         WcdQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXaurMbBsXJ4gfwBJzSNsNdQ3LrzcI84k8RzkB/EQ177y2rvY4SEdOqLUBqUt2rleOoAzvMlmpPuUYK0ex/illDFsvkQGPCK11mED1v4YPmQeYW0L0CZrHXVFQG+lC2jgnKKX8e8oNldXUdcOzSjv4LPTvOHPaJ7PWNHFTJnYQmNXWQCooH1uGaG8FlR1OPhPA5VOT4tzGqpUN/0cJBA==
X-Gm-Message-State: AOJu0Yz+J1N8Fya9zaVL9hZsQfYwRvZ20lNDcUTj9PeKcTBc1kmWbaVR
	mJ2aBQLzt3ZiTtiL7hBp5P9fotCN+s9TNFNn7V0PGeUbOUjHcMRR
X-Google-Smtp-Source: AGHT+IEcqkCYmBlKNw4xhgK9UqGESD/QlUTYSu/OQ9etZLHw8dS/y8lqY8GUiTOQaxlmE+E9Rhmp0g==
X-Received: by 2002:a17:906:4313:b0:a61:7f85:e31c with SMTP id a640c23a62f3a-a6818c46ef7mr93402066b.12.1717140825572;
        Fri, 31 May 2024 00:33:45 -0700 (PDT)
Received: from nsa.fritz.box ([2001:a61:35f9:9001:40df:88bb:5090:7ab6])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a67e78db9b9sm57197766b.97.2024.05.31.00.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 00:33:45 -0700 (PDT)
Message-ID: <32747c84d382d5c24408bcceb885659d28f20585.camel@gmail.com>
Subject: Re: [PATCH RFC v2 1/8] spi: dt-bindings: spi-peripheral-props: add
 spi-offloads property
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Conor Dooley <conor@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,  Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>, Michael Hennerich <Michael.Hennerich@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, David Jander <david@protonic.nl>,
 Martin Sperl <kernel@martin.sperl.org>, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org
Date: Fri, 31 May 2024 09:33:44 +0200
In-Reply-To: <6db8ba66-841b-4425-9dd4-9d6e7b0463bf@baylibre.com>
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
	 <10991373cb9603803df63d8236c475807f6dde68.camel@gmail.com>
	 <6db8ba66-841b-4425-9dd4-9d6e7b0463bf@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1 (3.52.1-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-05-30 at 14:24 -0500, David Lechner wrote:
> On 5/29/24 3:07 AM, Nuno S=C3=A1 wrote:
> > On Sun, 2024-05-26 at 18:35 +0100, Conor Dooley wrote:
>=20
>=20
> > > It might be easy to do it this way right now, but be problematic for =
a
> > > future device or if someone wants to chuck away the ADI provided RTL =
and
> > > do their own thing for this device. Really it just makes me wonder if
> > > what's needed to describe more complex data pipelines uses an of_grap=
h,
> > > just like how video pipelines are handled, rather than the implementa=
tion
> > > of io-backends that don't really seem to model the flow of data.
> > >=20
> >=20
> > Yeah, backends is more for devices/soft-cores that extend the functiona=
lity of
> > the
> > device they are connected too. Like having DACs/ADCs hdl cores for conn=
ecting to
> > high
> > speed controllers. Note that in some cases they also manipulate or even=
 create
> > data
> > but since they fit in IIO, having things like the DMA property in the h=
dl binding
> > was
> > fairly straight.
> >=20
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
> I could see this working for some SPI controllers, but for the AXI SPI En=
gine
> + DMA currently, the DMA has a fixed word size, so can't be used as a gen=
eric
> DMA with arbitrary SPI xfers. For example, if the HDL is compiled with a =
32-bit
> word size, then even if we are reading 16-bit sample data, the DMA is goi=
ng to
> put it in a 32-bit slot. So one could argue that this is still doing some=
 data
> manipulation similar to the CRC checker example.
>=20

Note that what I was thinking was something very trivial... Just a way to g=
et
'dma_chan' out of the spi_engine to the consumer so we could import it in t=
he IIO DMA
infrastructure... I assume it may be a sneaky way to just get around the pr=
oblem
though :).

Another way is to come up with spi like API's to submit DMA request's (pass=
ing an
handler or so for completion). I guess we would somehow also need a kind of=
 get()
function that would give consumers some kind of info/interface like spi xfe=
rs size
(as in this particular case it's the DMA who defines the src/dst width). We=
 would
likely also need some kind of spi_dma_buffer implementation in IIO (likely =
to share
some code with the current stuff; at least the userspace interface should d=
efinitely
be the same).

Anyways, the above it's just me throwing some random ideas that come to min=
d :). They
may be stupid but at the very least they could give you some betters ideas =
:).

> >=20
> > Not familiar enough with of_graph so can't argue about it but likely is=
 something
> > worth looking at.
> >=20
> > - Nuno S=C3=A1
> > > >=20
>=20
> I did try implementing something using graph bindings when I first starte=
d
> working on this, but it didn't seem to really give us any extra useful
> information. It was just describing connections (endpoints) that I though=
t
> we could just implicitly assume. After this discussion though, maybe wort=
h
> a second look. I'll have to think about it more.

Why not :)?

- Nuno S=C3=A1

