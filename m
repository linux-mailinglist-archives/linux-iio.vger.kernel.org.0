Return-Path: <linux-iio+bounces-9600-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D28B979B00
	for <lists+linux-iio@lfdr.de>; Mon, 16 Sep 2024 08:13:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE46E284A9D
	for <lists+linux-iio@lfdr.de>; Mon, 16 Sep 2024 06:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01B1E4D59F;
	Mon, 16 Sep 2024 06:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eFmMX+2p"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAEE34F899;
	Mon, 16 Sep 2024 06:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726467175; cv=none; b=FcVtoS5rxjT6quCfvCwWr3NiXOL+J5p3Awl6q7L+2CD4HmZmoxY3mM2DN5moe5NibgkQTifl8gNLSTxgz/bZ0Hj04pm3W9zwVys5VpGVSmcPFOteh+f5C1YE3/5IQTfHqxhpogeD2+DBR15odbFGxlgJPDT0Pfuv/s32Kk/vqzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726467175; c=relaxed/simple;
	bh=kG03raZfTfZOXpPItKDnAYSmtl9F31AgE4UZXycVZhY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DCnyzSA0YI0OrJmb3upbnpFC6jgNk5Fae8B2d1rlsc4JfOgZjMC1k2utOdp1oU0js8p1UakJIE61gxbVoZcULG8V3nyf4HV1ZLGkZ6UymO14MAxnxaU96Ez9XTwrinUugxt629kUwLOxGizkQ7JMuBSiyOlhVR22QbeW0nCrzHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eFmMX+2p; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-374bfc395a5so2532284f8f.0;
        Sun, 15 Sep 2024 23:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726467147; x=1727071947; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Lva/KyfsEf9PGoYzDrXlBeymMEZiSBwCC5dgFwt7+TA=;
        b=eFmMX+2pvFklBDeiMqChKoMzBHrq0etbS//EtwoFCaRJEr1FnBBnO1NC0ZWp4QCZni
         Yt1OpH1gTvawLIPwgUfjI2sIoCnBeIEtsdm2Lls2zZNB4b10HatyfMNAPzmW+Gk+UghY
         3sJ9rHPN84JrzaPKI7eri3Cd0aqX8p6NL5Gh5NCVI7MKFXVT5VppREYJKT3KCj99eUNO
         25WUa64GNh2J4wGU3jsnhqm5yfXboTPPzAkmD2JB8SzwU0mGwJ4GXkCWdGa9CsEtyxOz
         zuHaxGNxPztzaDnJaUuJ/vs97kKYkoloBtBE0em0KogQ1ZO0GkPBwkICAdCNzJEnZ3yu
         hEbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726467147; x=1727071947;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Lva/KyfsEf9PGoYzDrXlBeymMEZiSBwCC5dgFwt7+TA=;
        b=pVDBJpJ6DVpFCml7N09NfI8ItKvmP5nP7K8omMnXdpaMszeI8dOXHNdZRY/qFkzgyb
         87fe7vBN19QFglia2qwHNZ2i6mkn6uezf+fxwvW8x4FIqtPJ1jUh8YJ6G0mQIPXIbG1d
         2fzD4cbSNY8HwaVpWOOPVlBntD8wMqkt71efmy0NmiAcKOiUsZhNsQJ8IDFXIg2aTxYB
         t2gjjQrioQ7W2gbNVy6eJisCCllZSHKhTu1Ks04GWEzoPoR1vehNuZjYQBk97cjL6HgI
         YwmbqSdV4plB43ElBE2YcEUezAKw3gkV32n7v4vA8NQuGz+B9ak5TmX1oeex/Y/1lfAW
         KFEA==
X-Forwarded-Encrypted: i=1; AJvYcCU9I9/SZxoCAYtou5NQFNou+Df28fvXfs+5fJyKCcu+Jegup4UYCIeDe250X4HPCtVpv57gtRbzHjxW@vger.kernel.org, AJvYcCVHQj4SEezFWCYI4Z5DS3pC+vKtkSyC9pUc4wU2SOqDdJ31MhP3qSNukHdtOznBkVrd9dox5Ub7ad4p@vger.kernel.org, AJvYcCVb2p7r+V7j+7aewav9mCYWLCZFwDR/gont0sjiHsge4TzfOssmpDZVRbh8MmPyg9DWQJprNL/mH8hK@vger.kernel.org, AJvYcCVzBV7cK8IQ1oLld6IiUZphjgPFRcNfcfKS3Vp2+iUfALDYIfuSlblOTWJ18WVDX7YCXKpkEOBlo3Qm0F0G@vger.kernel.org
X-Gm-Message-State: AOJu0YzkttjSPYgrIdwUfNPV5vJDUK+SJg2GNlvCzxuaPVIQN/6y0IZp
	NjQAjPBEnYgQMEW5ysv/2AoIMxBFxSuD+aGjyfEme2BTRXNIXZ4f0myLTVyu
X-Google-Smtp-Source: AGHT+IHOXqiCL9qQdNNHr+2CY3MEOq0BovshayP9ph5h9sL9TrB4vZwpd0uR93BBpfL59n/t2BZUJQ==
X-Received: by 2002:adf:f651:0:b0:374:c25a:f580 with SMTP id ffacd0b85a97d-378c27a925emr7789801f8f.14.1726467145736;
        Sun, 15 Sep 2024 23:12:25 -0700 (PDT)
Received: from nsa.fritz.box ([2001:a61:341e:1201:c434:b5b1:98a6:efed])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e780e029sm6136040f8f.116.2024.09.15.23.12.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Sep 2024 23:12:25 -0700 (PDT)
Message-ID: <2b319d9453f4fe8842e4c306d9e2071ad031c0e7.camel@gmail.com>
Subject: Re: [PATCH 4/6] iio: adc: ad4030: add support for ad4630-24 and
 ad4630-16
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Esteban Blanc <eblanc@baylibre.com>, Lars-Peter Clausen
 <lars@metafoo.de>,  Michael Hennerich <Michael.Hennerich@analog.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>, Jonathan Corbet
 <corbet@lwn.net>,  linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>, 
 linux-doc@vger.kernel.org
Date: Mon, 16 Sep 2024 08:12:24 +0200
In-Reply-To: <20240914122529.14759e63@jic23-huawei>
References: <20240822-eblanc-ad4630_v1-v1-0-5c68f3327fdd@baylibre.com>
	 <20240822-eblanc-ad4630_v1-v1-4-5c68f3327fdd@baylibre.com>
	 <20240826102748.4be0b642@jic23-huawei>
	 <D452E2M75XCM.13OQGAPJ7JJ4A@baylibre.com>
	 <0a4e7fe39cf36774b28c86f6baab5ef8c20e3d6b.camel@gmail.com>
	 <D4567LFFTYJQ.2YC5OODKOVPNB@baylibre.com>
	 <84961c1f857dfc8498c41ac97235a037111ed6d5.camel@gmail.com>
	 <20240914122529.14759e63@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2024-09-14 at 12:25 +0100, Jonathan Cameron wrote:
> On Fri, 13 Sep 2024 15:46:17 +0200
> Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
>=20
> > On Fri, 2024-09-13 at 12:55 +0000, Esteban Blanc wrote:
> > > On Fri Sep 13, 2024 at 10:18 AM UTC, Nuno S=C3=A1 wrote:=C2=A0=20
> > > > On Fri, 2024-09-13 at 09:55 +0000, Esteban Blanc wrote:=C2=A0=20
> > > > > On Mon Aug 26, 2024 at 9:27 AM UTC, Jonathan Cameron wrote:=C2=A0=
=20
> > > > > > On Thu, 22 Aug 2024 14:45:20 +0200
> > > > > > Esteban Blanc <eblanc@baylibre.com> wrote:=C2=A0=20
> > > > > > > +static const unsigned long ad4630_channel_masks[] =3D {
> > > > > > > +	/* Differential only */
> > > > > > > +	BIT(0) | BIT(2),
> > > > > > > +	/* Differential with common byte */
> > > > > > > +	GENMASK(3, 0),=C2=A0=20
> > > > > > The packing of data isn't going to be good. How bad to shuffle
> > > > > > to put the two small channels next to each other?
> > > > > > Seems like it means you will want to combine your deinterleave
> > > > > > and channel specific handling above, which is a bit fiddly but
> > > > > > not much worse than current code.=C2=A0=20
> > > > >=20
> > > > > I can do it since that was what I had done in the RFC in the firs=
t place.
> > > > > Nuno asked for in this email
> > > > > https://lore.kernel.org/r/0036d44542f8cf45c91c867f0ddd7b45d1904d6=
b.camel@gmail.com/
> > > > > :
> > > > > =C2=A0=20
> > > > > > > > * You're pushing the CM channels into the end. So when we a=
 2 channel
> > > > > > > > device
> > > > > > > > we'll have:=C2=A0=20
> > > > > =C2=A0=20
> > > > > > > > in_voltage0 - diff
> > > > > > > > in_voltage1 - diff
> > > > > > > > in_voltage2 - CM associated with chan0
> > > > > > > > in_voltage0 - CM associated with chan1
> > > > > > > >=20
> > > > > > > > I think we could make it so the CM channel comes right afte=
r the
> > > > > > > > channel
> > > > > > > > where
> > > > > > > > it's data belongs too. So for example, odd channels would b=
e CM
> > > > > > > > channels
> > > > > > > > (and
> > > > > > > > labels could also make sense).=C2=A0=20
> > > > >=20
> > > > > So that's what I did here :D
> > > > >=20
> > > > > For the software side off things here it doesn't change a lot of =
things
> > > > > since we have to manipulate the data anyway, putting the extra by=
te at the
> > > > > end or in between is no extra work.
> > > > > For the offload engine however, it should be easier to ask for 24=
 bits
> > > > > then 8 bits for each channel as it would return two u32 per "hard=
ware
> > > > > channel".
> > > > >=20
> > > > > In order to avoid having two different layouts, I was kind of sol=
d by
> > > > > Nuno's idea of having the CM in between each diff channel.
> > > > > =C2=A0=20
> > > >=20
> > > > Tbh, I was not even thinking about the layout when I proposed the
> > > > arrangement.
> > > > Just
> > > > made sense to me (from a logical point of view) to have them togeth=
er as they
> > > > relate
> > > > to the same physical channel. FWIW, we're also speaking bytes in he=
re so not
> > > > sure
> > > > if
> > > > it's that important (or bad).=C2=A0=20
> > >=20
> > > The best we can do (if we managed to do it HDL wise) is to reorder th=
e
> > > data to get both CM byte in a single u32 after the 2 u32 of both diff
> > > channel. That would be 3 u32 instead of 4.
>=20
> Entirely up to you. :)
> > > =C2=A0=20
> >=20
> > We are starting to see more and more devices that do stuff like this. H=
ave one
> > physical channel that reflects in more than one IIO channel. For SW buf=
fering
> > it's
> > not really a big deal but for HW buffering it's not ideal.=20
> >=20
> > I feel that at some point we should think about having a way to map a c=
hannel
> > scan
> > element (being kind of a virtual scan element) into the storage_bits of=
 another
> > one.
> > So in this case, one sample (for one channel) would be the 32bits and t=
hings
> > should
> > work the same either in SW or HW buffering.
> >=20
> > That said, it's probably easier said than done in practice :)
>=20
> Yeah. That could get ugly fast + All existing userspace will fail to hand=
le it
> so I'm not keen. Maybe it's doable if we assume the 'virtual channels' ar=
e all
> meta data we don't mind loosing with existing software stacks and define
> a non overlapping ABI to identify the metadata.=C2=A0 Still smells bad to=
 me so
> I'll take quite a bit of convincing!

Naturally it would have to be done in a way that drivers not defining the "=
special"
scan elements would not be affected.

>=20
> Adding something to clearly 'associate' multiple related channels would b=
e fine
> as that wouldn't change the data interpretation, just provide more info o=
n top.
> Kind of a structured _label=20
>=20
> Maybe a _channelgroup attribute?=C2=A0=C2=A0 Would be const and all the c=
hannels with
> the same index would reflect that they were measured on same 'thing'.
> Typically thing might be a pin or differential pair, but we might be meas=
uring
> different types of signals - e.g. current and power.
>=20

Sounds reasonable but I think the tricky part is always to have a sane way =
of saying
that multiple scan elements relate to just one storage_bits so we could say=
 something
like (taking this as example):

scan0: //diff channel which describing the physical HW in terms of real siz=
e
 .storage_bits =3D 32
 .real_bits =3D 24
 .shift =3D 8

scan1: //CM data
 //.storage - relates to scan0 so should add nothing to the sample size if =
both
enabled
 .real_bits =3D 8

Likely not what you meant but one thing I took from your '_channelgroup' id=
ea was to
have something similar to extended_info maybe with a small top level descri=
ption and
then an array of channels (that would form the group/aggregated channel). O=
nly on the
top level description we would be allowed to define the size of the scan el=
ement (in
case of buffering). Still seems tricky to me :).

Anyways, Right now, I have no time for something like this but eventually w=
ould like
to try something. But if someone wants to propose something sooner, please =
:)

- Nuno S=C3=A1=20


