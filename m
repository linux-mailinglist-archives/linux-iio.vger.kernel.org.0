Return-Path: <linux-iio+bounces-27905-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D6494D39379
	for <lists+linux-iio@lfdr.de>; Sun, 18 Jan 2026 10:20:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 508553010CC8
	for <lists+linux-iio@lfdr.de>; Sun, 18 Jan 2026 09:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B8D27B35B;
	Sun, 18 Jan 2026 09:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DxzwUK9T"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58556199FB0
	for <linux-iio@vger.kernel.org>; Sun, 18 Jan 2026 09:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768728005; cv=none; b=DwRl0mdPH0ERLvy9AqgSmHkaAzIPYzPxbJkiczLAx5IO5frJkZEymAorNzAVCWaVpW51zNtu+iQpW9CwX4DJeR5BI5b4egMvDoAkP7Y2H0CdLU/PZ320lACHvejEinRKu8S45H1AlIPIR2ZoDZN+txe0QxBtZICNCMZzE5PFKaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768728005; c=relaxed/simple;
	bh=2+oBlpG5mVJXNdT53ppAPxtTD1bVFIcRQaXuzEyQKos=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eybXPzOCOpkpI8BXQY/sBF8dRQK7gGOYFkzpM6GW2paDRzcqv+rjaJH0vbE+decZ3AfLorL6BUrruu7B/wsBdXL50ObEyM9sSUsGDpeiKNREjCtDbcfyW3AR2rvUxKg5a0OwCNwFqDxxNHi/ghvv7JZHS0qjL4A1wW7y0YcoLh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DxzwUK9T; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-42fbbc3df8fso1700979f8f.2
        for <linux-iio@vger.kernel.org>; Sun, 18 Jan 2026 01:20:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768728002; x=1769332802; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2+oBlpG5mVJXNdT53ppAPxtTD1bVFIcRQaXuzEyQKos=;
        b=DxzwUK9T/AEtYmqFxsN5cTQ2ALpcBxu2EnoKPXzum1nbpgAH9kd4LVxW0ZthW79+x4
         Ns4vyZ/Bojs5J79X0SjWtYERAd74sCzdSzEtByQwX2Z/e1sje+OHZS/sjBFDkZV1EvP1
         0YKia/kOahKJSit/rCaW3f5ipsVgRnJh7xV5WwpQLX9tJGMab0LmUMCUju3GzShVUGQt
         Aq8GCtC7+WgDjnaFy+U40XTfuIQJsrDg/OwJplNfYyNIEYjvYY+jsrZhVKZcZIYNPxL2
         Ci3reulCWJwaiZ0tUURQY9Uuu84w6/BSBLCpzZU948GuUeWuSj2iNX6HdKhYDNmoPPIA
         LY5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768728002; x=1769332802;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2+oBlpG5mVJXNdT53ppAPxtTD1bVFIcRQaXuzEyQKos=;
        b=nn4uA3RUpReLukRGadarzX5DZiAa9uuCmnWoV6CqGTkj2wkv9Oge19yuzPAVd5OuVt
         PpW97ymiw+J88KCarMhmM4jAfs0RJ1GbqOcwHli206jDFzHfdcswYv3r1+vz3s9JdZOn
         iVsa1i1xW/Pa4QnljcVMJRT531YAka9k2MIcNfV9dOqeveJ45w2e8sG+4Iw1j5cyEjdp
         xVoBryCH6QDuUHkbfFxeP2UefthKnby0Y4BZhfVpX5WUPPbCyl+ELakymfPE2F6k4aV7
         /bjj4bN9aH3nsfwl6dhMwDb7+DWnIaZjqgWveG9zMfWstxHi0gFK5euvOHgAW3O+ZMkp
         SR7A==
X-Forwarded-Encrypted: i=1; AJvYcCU/+Mv1UgdljrgnQsJAqJbycSdwHrEWvGH8pbuNOlE/cs9l4ZYNjq3Ag0XpkRu6ErWYK4OV0UlbFXk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoV5q2dn4LPaqr2JwKR19G5diVmAIIAcTHCv1bBXrQ8fOnjeTX
	DxhFTq3La5nxjqCcRkBkaXdJLEEButDrri0jm1eRPGGsnWKw2UJCHehpBif1o7dJ
X-Gm-Gg: AY/fxX7HE+709OsQmswEGW4HXtYXKMeiGKIl7DdJxzmqu0lAuD+oE4YxMhhSl4LHVjo
	pzt5ls4RY+6mdSW6TMHLN239EsYTQlIdzeZV1fRgX45TDdHxVhbHWRKmYOtOH08CMXnSkfLg1OO
	BRz9eZEwk4h8jHs+7irO9XccDOCqRcOoVmpM3OTjFd7o39aO4H8hDNbR/rW285L/WgVPyZXoYTr
	B0QfC0G1o0iYTgteZxKVtdDVDT2Cxskopt/ARGAgYjLjz5chQuTaYiKEqw0m11WxN+yDhpwQdBF
	jDSAZLQ8ssaTpIETBhfpsWGzSgX7MbN6p9HaxXnJkIIGnhU2aWoNgqCKXQMdmVZDkEIsTSsiR3h
	zR8B/SsQkLGokvj0nynhox8sIoeY/8slYUKQazT5S3x3xQ4Fqv1FHbkkbcp8ndpsJPPd7qcc+Aw
	wZl71ve49NZ6+y6ALaH1iC89gGhbL66F59xEnOQuW/MGhM1IlvDPm0VWe5lhE=
X-Received: by 2002:a05:6000:4026:b0:432:c39d:102d with SMTP id ffacd0b85a97d-43569919c94mr8503587f8f.0.1768728001370;
        Sun, 18 Jan 2026 01:20:01 -0800 (PST)
Received: from ?IPv6:2001:818:ea56:d000:94c4:fb0e:28f:2a8d? ([2001:818:ea56:d000:94c4:fb0e:28f:2a8d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4356992681esm15890096f8f.11.2026.01.18.01.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 01:20:00 -0800 (PST)
Message-ID: <acc10955a646b13da7ff191149b8f62181fbac5c.camel@gmail.com>
Subject: Re: [PATCH v3 0/4] iio: adc: ad9467: Support alternative backends
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Tomas Melin <tomas.melin@vaisala.com>, Michael Hennerich	
 <Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>, Lars-Peter
 Clausen <lars@metafoo.de>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>,  Olivier Moysan <olivier.moysan@foss.st.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sun, 18 Jan 2026 09:21:05 +0000
In-Reply-To: <20260116183724.18063cec@jic23-huawei>
References: 
	<20260114-b4-ad9467-optional-backend-v3-0-d2c84979d010@vaisala.com>
		<0ad12e16e3fffb4b72a460d7f2b2e627a781b93b.camel@gmail.com>
		<7ac7033a-2273-4556-a605-1ea0200665a9@vaisala.com>
		<5896ab55e0d23d235908f9f592c8a7975428dc54.camel@gmail.com>
		<41cac06c-8db2-4a52-854f-659606d89121@vaisala.com>
		<931160a27cfcfbf55d75bf9662442988c266343f.camel@gmail.com>
	 <20260116183724.18063cec@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-01-16 at 18:37 +0000, Jonathan Cameron wrote:
> On Fri, 16 Jan 2026 13:31:39 +0000
> Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
>=20
> > On Thu, 2026-01-15 at 15:30 +0200, Tomas Melin wrote:
> > > Hi,
> > >=20
> > > On 15/01/2026 14:04, Nuno S=C3=A1 wrote:=C2=A0=20
> > > > On Wed, 2026-01-14 at 17:32 +0200, Tomas Melin wrote:=C2=A0=20
> > > > > Hi Nuno,
> > > > >=20
> > > > > On 14/01/2026 15:32, Nuno S=C3=A1 wrote:=C2=A0=20
> > > =C2=A0=20
> > > > > >=20
> > > > > > But more importantly, how are your usecase supposed to work wit=
h this
> > > > > > series? I'm not seeing any new backend being added as part of t=
he series.
> > > > > > Point is, if we are adding all of this, I would expect your use=
case to
> > > > > > have fully upstream support. If I'm not missing nothing, we wou=
ld at
> > > > > > least
> > > > > > need a dummy backend providing stubs for enable()/disable()=C2=
=A0=20
> > > > > My usecase adds simplistic backend support and registers to the
> > > > > framework via an related driver. So that use case works with that
> > > > > approach. I think it is better to assume there is always some ent=
ity
> > > > > that can take on the role of being backend, rather than adding a =
dummy
> > > > > backend. Adding the capabilities are defining role here, as havin=
g that=C2=A0=20
> > > >=20
> > > > Well, I would argue your backend is exactly that. A dummy one :)=C2=
=A0=20
> > >=20
> > > It's kindof ;)=C2=A0 But on general level it handles the stuff a back=
end
> > > needs to do, just does not have most of the operations or capabilitie=
s
> > > available. OTOH having the backend defined means that if some of the
> > > capabilites would be added, there is a natural place to add it.
> > > =C2=A0=20
> >=20
> > But there's nothing you can control from Linux right?
> >=20
> > > > =C2=A0=20
> > > > > allows for customer integrations with backends that differ but ar=
e of no
> > > > > interest for the mainline.
> > > > > =C2=A0=20
> > > >=20
> > > > It would still be nice to have this usecase fully supported upstrea=
m=C2=A0
> > > > (having a black box backend).=C2=A0
> > > >=20
> > > > What I have in mind would be really to do the same as regulators do=
. If you
> > > > call
> > > > regulator_get() then the consumer really assumes a regulator must e=
xist. But
> > > > if it
> > > > is something the kernel does not control we get a dummy one with ve=
ry limited
> > > > functionality/stubs. If you call regulator_get_optional(), then the=
 regulator
> > > > is
> > > > really optional and might not physically exist. Seems very similar =
to what
> > > > you have.=C2=A0=20
> > >=20
> > > There could perhaps be use for a backend like this too. Is the idea s=
uch
> > > that one would still need to define a "iio-backend-simple" node or su=
ch
> > > to device tree which would then provide the backend link and compatib=
le?
> > > =C2=A0=20
> >=20
> > My idea would be to automatically define one if we fail to find it. Nat=
urally if
> > we
> > ever add an optional() get the dummy could not be added. See how regula=
tor_get()
> > handles it. That's basically what I have in mind.
> >=20
> It's an interesting idea, but I'd like some input from DT folk on this.
> The fake regulators thing is kind of legacy from lots of drivers gaining =
the
> power handling later and it being boring / too late to add all the fixed =
regs
> to DT.=C2=A0 This is a much less common case and I find it a little unlik=
ely there
> is nothing useful to know about where the data is going - so how useful
> is an autocreated backend?
>=20

Not really that useful. This was just something I thought of to have the fu=
ll usecase
supported in Linux. But, if we can add an explicit fixed/dummy (whatever na=
me fits
best) backend with a proper compatible that would be preferable, yes.

- Nuno S=C3=A1


