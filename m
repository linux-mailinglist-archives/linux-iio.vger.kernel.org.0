Return-Path: <linux-iio+bounces-5224-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5058D8CD713
	for <lists+linux-iio@lfdr.de>; Thu, 23 May 2024 17:31:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C059A1F21F41
	for <lists+linux-iio@lfdr.de>; Thu, 23 May 2024 15:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDCFC14287;
	Thu, 23 May 2024 15:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B0u3tzJ+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1897E10A22;
	Thu, 23 May 2024 15:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716478250; cv=none; b=RjGFqbnMvG86Zaah15x65HJUhN8XqiKsjGyO7+1tLC1W+/7WzTTt/Oq1TmQ6PMFojadz2mObS46qODa8H3cbbR567WnQa5qkYYexTII1rH8qQu5R9hG+kkZCSzUDad/mEGCsnBiQYwj2+pp5XzQvNVNsTxljrOwXWPZi6GN7hdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716478250; c=relaxed/simple;
	bh=p4leqlSbvV4n9s+nxM6Epxfl0MIAt/4Z4Qkdhp5RFCE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bVXwqdqPAww0GRmFSRGaAGL1NAgnfsYfviiVNDAII3zcX3aajwIwaSwyRXg/D2CftqqyAC4rln+r6PsqK0r6ivvNIqFG+Bvm/kwWRNCYan8Z+85X1YuGI1HmMJ+9q+FqbfqpTxGEvTs+C3IusRlOvRsvWdC/11G/gmM32pLFw3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B0u3tzJ+; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a5a0013d551so650205766b.2;
        Thu, 23 May 2024 08:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716478247; x=1717083047; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=p4leqlSbvV4n9s+nxM6Epxfl0MIAt/4Z4Qkdhp5RFCE=;
        b=B0u3tzJ+AwQoHS5GnQr2jxzLldx98sZhS06P9f6jJJK6mL9Jj3pJkxLoe6Xijp0zQh
         ERjUGaMXb39Hn3m407f/5UzHmcCZewVMRCpiftGXaudPM4IdVq+SvwHfnuoLgqeS4tL6
         igl8aJlu+eYbJD/ZDelhfwSRBMxPi5HxZbyVOr1igXZDBmxLf1f7VJBd6YiNhddexmrj
         IaiiurAxHRr2P0tiYwu8Up5adYNwsuLkBE2iQLtU7qyl12i1XPbLviWBaXBPrX2TzDyr
         INBknTyHqCLqqhq/grREV7lrUEq2af7Hi7eT2tLkCe093hDQvUWkb54dvgqL/UUaDNs+
         u2Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716478247; x=1717083047;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p4leqlSbvV4n9s+nxM6Epxfl0MIAt/4Z4Qkdhp5RFCE=;
        b=cz72SlSWRlRjaVyufEpouKaShBumrBvVtjZJ0uzSkGr7m3Dgt4FpyeYlxerLJ4zw2T
         xhK3KQcrVNyU4f+C5yjPdrQE0Dd00d1Yj16WSvGXs1eY2g+kylfZkWRQJhbA2VbV0Osf
         nGux1jDjoPLUQU6nqaN+d/dzyFJiEOl3eC/7sKNpcSKysc5x6TyjMjy4MtViEk6Z/6S/
         KV/Z7i6190wB2lPo8A+yEXAh8WN7WaLvP0IRVLZaTFKVm10TSBf+9jGv+ZKTm/UXUTwu
         lhWB3suAVeaKIcOnowAj58WNdRk36mHCuU2FEK+CNh5YZCOsXZ9XtsAbn0LdPRTxllFP
         A84g==
X-Forwarded-Encrypted: i=1; AJvYcCWDaBtSzjkxrrHx38UdhN1s+uCKZ4f8NekSJ0SG1Wc9XZh9TRdyIPOC/UhVgiwrLLyrHjIfGL2w2W6tA2WR9RzRWv81gd2aCvQSykvIqnDLHvhDME7S74bhEvGX2BpH56cN9gmBlkaFc842GbZYPAKH3TY+W0ex8hshP5toEBXklDcUgI55vKIWEvqou1qiOsUit2ej0MLr73a6D17azA==
X-Gm-Message-State: AOJu0Yxql8WSqwf1nl9Xw0DY25P4NQsLL5sqZ80dJa6veU9mTVonJFQ8
	g5E6avRKbhYii66gyoTML2Tq4QT/dT9wNWp5U7+xVyRAJmviFmzq
X-Google-Smtp-Source: AGHT+IFc0PcZnindC0CNOM4kMam3gZvP2VwaE74Pn0IMDie8VokywzDhv8M5Y/LxXFVwwr6ZZvVs1Q==
X-Received: by 2002:a50:d794:0:b0:578:4ab9:544e with SMTP id 4fb4d7f45d1cf-5784ab954bamr1301129a12.30.1716478247112;
        Thu, 23 May 2024 08:30:47 -0700 (PDT)
Received: from ?IPv6:2001:a61:35f9:9001:40df:88bb:5090:7ab6? ([2001:a61:35f9:9001:40df:88bb:5090:7ab6])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a1787c686sm1944815866b.47.2024.05.23.08.30.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 08:30:46 -0700 (PDT)
Message-ID: <61147de8e3761c5d3c000ee5ea0d9d146da89602.camel@gmail.com>
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
Date: Thu, 23 May 2024 17:30:45 +0200
In-Reply-To: <3fad2e61-c3e4-4bb1-bbea-101d5d0f91ee@baylibre.com>
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
	 <59df2cc3-5a62-45be-a0aa-5bbff13c2ae4@baylibre.com>
	 <35de37c08331a8384aa9ebde3a9be5fec6fc418e.camel@gmail.com>
	 <3fad2e61-c3e4-4bb1-bbea-101d5d0f91ee@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1 (3.52.1-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-05-23 at 10:09 -0500, David Lechner wrote:
> On 5/23/24 9:57 AM, Nuno S=C3=A1 wrote:
> > On Thu, 2024-05-23 at 09:28 -0500, David Lechner wrote:
> > > On 5/22/24 1:24 PM, Conor Dooley wrote:
> > > > On Tue, May 21, 2024 at 09:54:39AM -0500, David Lechner wrote:
> > > > > On Sun, May 19, 2024 at 7:53=E2=80=AFAM Conor Dooley <conor@kerne=
l.org> wrote:
> > > > > >=20
> > > > > > On Fri, May 17, 2024 at 11:51:58AM -0500, David Lechner wrote:
> > > > > > > On Thu, May 16, 2024 at 4:32=E2=80=AFPM Conor Dooley <conor@k=
ernel.org> wrote:
> > > > > > > > On Tue, May 14, 2024 at 05:56:47PM -0500, David Lechner wro=
te:
> > > > > >=20
> > >=20
> >=20
> > ...
> >=20
> > >=20
> > > controller:
> > > #spi-offload-cells =3D <2>: /* 1st cell =3D offload instance
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 * 2nd cell =3D trigger provider */
> > >=20
> >=20
> > What about things like DMA? I'm mentioning it a lot because it's way mo=
re complex
> > having it on the controller (from a SW perspective). But from an HW poi=
nt of
> > view,
> > it's always very similar (if not the same) as your case A.
> >=20
>=20
> If we had a setup where there was more than one place that, e.g. the
> RX stream from the offload could be piped, then I would add a 3rd
> cell to describe that. If the hardware is fixed and the RX stream
> always goes to a specific DMA channel, then it doesn't seem like we
> need to describe that in the SPI controller node because the hardware
> is fixed.
>=20

Well, yes, still the DMA channel is connected on the controller and not the
peripheral. Same deal as we discussed on the IIO backends stuff. But there,=
 since
it's all IIO it was easy to make the DMA a property of the backend device. =
That said,
I can surely see having the property in the peripheral.

Another thing that came to mind for the trigger case. What about an additio=
nal spi
interface for configuring/setting the trigger rate? Sounds generic and then=
 we would
not really need the trigger on the peripheral right (did not checked the CR=
C issue
you mentioned so not sure if it's somehow trigger related)?

Hmm but sometimes there's other things than rate/period (like offset) to ca=
re about
so maybe not doable... Bah!

- Nuno S=C3=A1

