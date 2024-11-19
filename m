Return-Path: <linux-iio+bounces-12395-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 976F89D21F5
	for <lists+linux-iio@lfdr.de>; Tue, 19 Nov 2024 09:57:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CF111F226AD
	for <lists+linux-iio@lfdr.de>; Tue, 19 Nov 2024 08:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E65919CD19;
	Tue, 19 Nov 2024 08:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QWT4b+ph"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA5113D8B4;
	Tue, 19 Nov 2024 08:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732006640; cv=none; b=rxLAiFMe2PnpUvdLRWadhdiZdZq8lMqnYGWBjW07KTFmz+zUNCC+yGrshFuHntIuCf/VSObtPLedQKnNuSXvst7KErn/VEsM2BfMIQFLDuf/K1Yw07xh+kAlc6EYk94S0ujICSMhhxpS4yDbECmz7DV0WKC1Fesd941m1Z/Nejs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732006640; c=relaxed/simple;
	bh=+MolPlX6Jwh/zl+N5BaAnHIR+Gnns9AKoHi6rxSsaG8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pHfH5UKnVIIPN+pX89xeqYyyBl3jdrRg9nuZfFBX3iJ7E6iPt572R+D06fc4zpeFFJo1WkffEpuM5Hif8SmtWWop8coAxp053PielEDv/T+lGeZIAhqneUUL9lO5BU16AYbdUY9CjAp6PbOqBrWhdv2rAR9s60r4weJ/1NgovMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QWT4b+ph; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-382433611d0so2064765f8f.3;
        Tue, 19 Nov 2024 00:57:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732006636; x=1732611436; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xnPRP7dw6fUZZp7489TEV5IZ7fM7ghLjDCqz5tFLNxE=;
        b=QWT4b+phrmwq5YjeL+Hd5wHuMAggS/cCbdUEODIBWTkLG1wH6+wwMeQ5aDft/CQmmn
         vXFg5CwaFTnBUVDORWTuIvndDMVUwNeuq96a6HIrgOMwA9KrxWa/qhy5qlyqh1EYDZ8a
         pjfjIzDDHx65+E2GzS78jbO83UJyG6njQ8P7Lk2HkWRG8+TEDaNE06zgXk03DFYtC6f4
         iMR9TJpjXJe6QGb34PYwfL5nMikJH1ul3YDg/N9y+HPYaACycCVQ93UYiza3SP8IhKmb
         o3UgOcqZ6GRLPrAEa03BRlqamG4LCS1kPWBk4txXilWHEcp2BeO6NE4VrRRuPRllwQg4
         naFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732006636; x=1732611436;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xnPRP7dw6fUZZp7489TEV5IZ7fM7ghLjDCqz5tFLNxE=;
        b=SWiANkUMt7xS/gHEqGIKwsujfqzMz/eJ3c7f9BCpcEZm8Y9fCK/kyuETezxV7VmLTJ
         usBD5oaG0NcNAqt1a3Y7WsYZ/RomYin9joAem2nuep9E4tg37g7Zv/WuWhMCfa1Y6Bmu
         Urweiw1rDqE3ZtrGg8vQozC3OQy3m42oHbC9sW1UL8QSs5p6AF+zJ45+PD/lWEN09ddd
         hZ4MWU3Hh1PW+MpzF2Fmg4e3Zt+fd/oJho1zvB3ujh13vhYMZ7cigS9Rj/wCS/2d99k1
         PAQg0QOUHnQ+daMnWQ58W4Pl8P0m4TDOJVWoP4aFCACfFadNOe7L5bAWxkeDk4g8RToB
         BPxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPIZ1fhq3y5QLOEZIUIw0+mV696mkaAiJxRVGEJNpmlmfG4K2aXm6CQT1lEb5yUIyGqzkD1pyHvUQ=@vger.kernel.org, AJvYcCWShijt4dJeFtL6KfZiV4xpNqUhV2Dj4plQvc10ZwCjdve2Y92SAURpmgUJ8+2Rs08g/s80P7ilZdZ4rTw5@vger.kernel.org
X-Gm-Message-State: AOJu0YxoGTStFjqv/FzqnDjJ38/g34Cxr3fy2dQuDg1OzMnWIioeZPl7
	Zz8jPjo0qP9xtmEFl3yAofC8EhtjqCRwZRx4flRTUzhADUoBy7ou
X-Google-Smtp-Source: AGHT+IEx5TrBH28Dz+VRRBjFAKYLERM+aRI6x/AvmkqlHDIEmEsUiQP7L28H11OpKnKvyphdHrkCfw==
X-Received: by 2002:a5d:6c6d:0:b0:382:3c1d:ebc9 with SMTP id ffacd0b85a97d-3823c1ded47mr10736012f8f.49.1732006635835;
        Tue, 19 Nov 2024 00:57:15 -0800 (PST)
Received: from ?IPv6:2003:f6:ef02:f400:a23c:697f:16fb:11c5? (p200300f6ef02f400a23c697f16fb11c5.dip0.t-ipconnect.de. [2003:f6:ef02:f400:a23c:697f:16fb:11c5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432da28ce85sm186909305e9.33.2024.11.19.00.57.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 00:57:15 -0800 (PST)
Message-ID: <14a23df0e1828b72b8b03c358980fe08a12bb216.camel@gmail.com>
Subject: Re: [PATCH] iio: accel: kx022a: Improve reset delay
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>, Matti Vaittinen
	 <matti.vaittinen@fi.rohmeurope.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, 	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 19 Nov 2024 10:01:40 +0100
In-Reply-To: <fda40996-abe5-436d-a4f1-9edfa01bfb1d@gmail.com>
References: <ZzWfXbjaDkFnu_Jg@mva-rohm>
	 <be375e24f74997743743fadf68125e176c23e2df.camel@gmail.com>
	 <f4cf3437-87ea-4d0f-8dab-890d89f85605@gmail.com>
	 <1f315c2f3eea86fe4db48f0168660ab4b0b020f1.camel@gmail.com>
	 <1410938e-5135-434c-911e-7ba925bafd49@gmail.com>
	 <b0a9eecb7b83c29aa545ed7717e3a6c2275b5e27.camel@gmail.com>
	 <42461eea-3e6d-4a15-a2fc-fa154163d80a@gmail.com>
	 <9073554f353273d0aa99a7aebfc5f367cfaa7c1a.camel@gmail.com>
	 <fda40996-abe5-436d-a4f1-9edfa01bfb1d@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-11-19 at 07:55 +0200, Matti Vaittinen wrote:
> On 15/11/2024 09:44, Nuno S=C3=A1 wrote:
> > On Fri, 2024-11-15 at 08:20 +0200, Matti Vaittinen wrote:
> > > On 14/11/2024 14:26, Nuno S=C3=A1 wrote:
> > > > On Thu, 2024-11-14 at 13:30 +0200, Matti Vaittinen wrote:
> > > > > On 14/11/2024 12:46, Nuno S=C3=A1 wrote:
> > > > > > On Thu, 2024-11-14 at 11:54 +0200, Matti Vaittinen wrote:
> > > > > > > On 14/11/2024 11:43, Nuno S=C3=A1 wrote:
> > > > > > > > On Thu, 2024-11-14 at 08:57 +0200, Matti Vaittinen wrote:
> > > > > > > > > All the sensors supported by kx022a driver seemed to requ=
ire
> > > > > > > > > some
> > > > > > > > > delay
> > > > > > > > > after software reset to be operational again. More or les=
s a
> > > > > > > > > random
> > > > > > > > > msleep(1) was added to cause the driver to go to sleep so=
 the
> > > > > > > > > sensor
> > > > > > > > > has
> > > > > > > > > time to become operational again.
> > > > > > > > >=20
> > > > > > > > > Now we have official docuumentation available:
> > > > > > > > > https://fscdn.rohm.com/kionix/en/document/AN010_KX022ACR-=
Z_Power-on_Procedure_E.pdf
> > > > > > > > > https://fscdn.rohm.com/kionix/en/document/TN027-Power-On-=
Procedure.pdf
> > > > > > > > > https://fscdn.rohm.com/kionix/en/document/AN011_KX134ACR-=
LBZ_Power-on_Procedure_E.pdf
> > > > > > > > >=20
> > > > > > > > > stating the required time is 2 ms.
> > > > > > > > >=20
> > > > > > > > > Due to the nature of the current msleep implementation, t=
he
> > > > > > > > > msleep(1)
> > > > > > > > > is
> > > > > > > > > likely to be sleeping more than 2ms already - but the val=
ue
> > > > > > > > > "1" is
> > > > > > > > > misleading in case someone needs to optimize the start ti=
me
> > > > > > > > > and
> > > > > > > > > change
> > > > > > > > > the msleep to a more accurate delay. Hence it is better f=
or
> > > > > > > > > "documentation" purposes to use value which actually refl=
ects
> > > > > > > > > the
> > > > > > > > > specified 2ms wait time.
> > > > > > > > >=20
> > > > > > > > > Change the value of delay after software reset to match t=
he
> > > > > > > > > specifications and add links to the power-on procedure
> > > > > > > > > specifications.
> > > > > > > > >=20
> > > > > > > > > Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> > > > > > > > > ---
> > > > > > > > > Sorry for not including this to the KX134ACR-LBZ series I=
 sent
> > > > > > > > > yesterday. It was only half an hour after I had sent the
> > > > > > > > > KX134ACR-
> > > > > > > > > LBZ
> > > > > > > > > support when I was notified about the existence of the
> > > > > > > > > KX022ACR-Z
> > > > > > > > > start-up procedure specification... Hence this lone patch=
 to
> > > > > > > > > code
> > > > > > > > > which
> > > > > > > > > I just sent a miscallaneous series for before.
> > > > > > > > >=20
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/iio/accel/kionix-kx=
022a.c | 11 ++++++++---
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A01 file changed, 8 insertion=
s(+), 3 deletions(-)
> > > > > > > > >=20
> > > > > > > > > diff --git a/drivers/iio/accel/kionix-kx022a.c
> > > > > > > > > b/drivers/iio/accel/kionix-
> > > > > > > > > kx022a.c
> > > > > > > > > index 32387819995d..ccabe2e3b130 100644
> > > > > > > > > --- a/drivers/iio/accel/kionix-kx022a.c
> > > > > > > > > +++ b/drivers/iio/accel/kionix-kx022a.c
> > > > > > > > > @@ -1121,10 +1121,15 @@ static int kx022a_chip_init(struc=
t
> > > > > > > > > kx022a_data
> > > > > > > > > *data)
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0		return ret;
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=20
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0	/*
> > > > > > > > > -	 * I've seen I2C read failures if we poll too fast
> > > > > > > > > after
> > > > > > > > > the
> > > > > > > > > sensor
> > > > > > > > > -	 * reset. Slight delay gives I2C block the time to
> > > > > > > > > recover.
> > > > > > > > > +	 * According to the power-on procedure documents,
> > > > > > > > > there
> > > > > > > > > is
> > > > > > > > > (at
> > > > > > > > > least)
> > > > > > > > > +	 * 2ms delay required after the software reset. This
> > > > > > > > > should
> > > > > > > > > be
> > > > > > > > > same
> > > > > > > > > for
> > > > > > > > > +	 * all, KX022ACR-Z, KX132-1211, KX132ACR-LBZ and
> > > > > > > > > KX134ACR-
> > > > > > > > > LBZ.
> > > > > > > > > +	 *
> > > > > > > > > +	 *
> > > > > > > > > https://fscdn.rohm.com/kionix/en/document/AN010_KX022ACR-=
Z_Power-on_Procedure_E.pdf
> > > > > > > > > +	 *
> > > > > > > > > https://fscdn.rohm.com/kionix/en/document/TN027-Power-On-=
Procedure.pdf
> > > > > > > > > +	 *
> > > > > > > > > https://fscdn.rohm.com/kionix/en/document/AN011_KX134ACR-=
LBZ_Power-on_Procedure_E.pdf
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0	 */
> > > > > > > > > -	msleep(1);
> > > > > > > > > +	msleep(2);
> > > > > > > >=20
> > > > > > > > msleep() is not advisable for something lower than 20ms. Ma=
ybe
> > > > > > > > take
> > > > > > > > the
> > > > > > > > opportunity and change it to fsleep()?
> > > > > > >=20
> > > > > > > Thank you for the suggestion Nuno. I did originally consider =
using
> > > > > > > the
> > > > > > > usleep_range() since the checkpatch knows to warn about mslee=
p
> > > > > > > with
> > > > > > > small times.
> > > > > > >=20
> > > > > > > However, there should be no rush to power-on the sensor at
> > > > > > > startup. It
> > > > > > > usually does not matter if the sleep is 2 or 20 milli seconds=
, as
> > > > > > > long
> > > > > > > as it is long enough. I wonder if interrupting the system wit=
h
> > > > > > > hrtimers
> > > > > > > for _all_ smallish delays (when the longer delay would not re=
ally
> > > > > > > hurt)
> > > > > >=20
> > > > > > That's why you have ranges of about 20% (I think) in usleep() s=
o you
> > > > > > minimize
> > > > > > hrtimers interrupts.
> > > > > >=20
> > > > > > Other thing is boot time... Sleeping 20ms instead of 2ms is a h=
uge
> > > > > > difference.
> > > > > > Imagine if everyone thought like this for small sleeps :)?
> > > > >=20
> > > > > I think this is interesting question. My thoughts were along the =
line
> > > > > that, even if small sleeps were extended to longer (where small s=
leep
> > > > > is
> > > > > not a priority), the CPUs would still (especially during the boot=
 up)
> > > > > have their hands full. I don't know if we might indeed end up a
> > > > > situation where CPUs were idling, waiting for next timer slot.
> > > >=20
> > > > My problem is not the CPU but delaying probing devices as you probe=
 one
> > > > device
> > > > at time...
> > > >=20
> > > > >=20
> > > > > What comes to boot time, I doubt the CPUs run out of things to do=
,
> > > > > especially when we use the probe_type =3D PROBE_PREFER_ASYNCHRONO=
US.
> > > >=20
> > > > Yeah, with this, the above does not apply. Still, spending more tim=
e in
> > > > a
> > > > worker
> > > > than needed (and 18ms is huge) seems a waste to me.
> > >=20
> > > This is likely to be my ignorance, but I don't know what is wasted he=
re.
> > > (genuine question, not trying to be a smart-ass).
> >=20
> > Well, AFAIK, async probing is using the async.c API which is based on
> > workers.
>=20
> Yes.
>=20
> > If you spend (worst case scenario) 18ms more than you need in the handl=
er
> > (and
> > 18ms is __huge__), it means that worker can't go on and do some other u=
seful
> > stuff, right?
>=20
> I thought there can be more than one concurrent active work items? It=20
> would be surprizing to me if aynchronous probe would block other probes.=
=20
> Please, let me know if this is the case.

Not my point... Naturally it won't as every async schedule has it's own wor=
ker.
Still a waste of time having a thread sleeping just because.

>=20
> > > > > > > is a the best design choice. Hence I'd rather keep the msleep=
 when
> > > > > > > we
> > > > > > > don't need to guarantee delay to be short instead of defaulti=
ng to
> > > > > > > hrtimers or even busy-loop when it is not required.
> > > > > > >=20
> > > > > > > Do you think I am mistaken?
> > > > > > >=20
> > > > > >=20
> > > > > > To me this is more about correctness and do what the docs tell =
us to
> > > > > > do
> > > > > > :).
> > > > > > Sure, here you know what you're doing and you don't care if you=
 end
> > > > > > up
> > > > > > sleeping
> > > > > > more than 2ms but that's not always the case and code like this
> > > > > > allows
> > > > > > for
> > > > > > legit
> > > > > > mistakes (if someone just copy paste this for example).
> > > > >=20
> > > > > Right. I just wonder if always requiring stricter wake-up instead=
 of
> > > > > allowing things to run uninterrupted is the best role model eithe=
r?
> > > >=20
> > > > Why not :)? If we just need to wait 2ms, why waiting more? I would =
be
> > > > very
> > > > surprised if hrtimers are a deal breaker in here. Otherwise, we sho=
uld
> > > > remove it
> > > > from the docs...
> > >=20
> > > Again I may be wrong, but I think each of the interrupts we add, requ=
ire
> > > tiny bit of handling - which I thought is more of a waste than sleepi=
ng.
> > >=20
> >=20
> > Not that it's even every likely that you're not adding a new interrupt
> > necessarily. That's the point of the range in usleep(). So that multipl=
e
> > handlers can be done in one interrupt.
>=20
> This could be true. Especially if every other "thing" which needs some=
=20
> delay (but has no strict lower limit) defaults to hrtimers.
>=20
> > Put it this way... if that was true, I would assume it would be somewhe=
re
> > described in the sleeping docs. More, I don't think the rule of thumb w=
ould
> > be
> > to use hrtirmers for things < 20ms.
>=20
> This is exactly why I questioned the rule-of-thumb. I deeply dislike=20
> "rules of thumb" - when I don't understand the rationale. If we assume=
=20
> hrtimers came without a cost, then we should have no need for msleep()=
=20
> at all, right?
>=20

Well that can very well be just because hrtimers came after and no one real=
ly
cares about changing all of the existing msleep() and friends.

> Everything I read suggests the msleep() is actually lighter (but with=20
> the downside it can't guarantee short timeouts). Hence I have preferred=
=20
> it when short timeout does _not_ need to be guaranteed. (I still very=20
> much understand the checkpatch warn because one might very well assume=
=20
> msleep() could be used to sleep 1 ms).

Depends on the perspective. If you end up sleeping 18ms more than needed an=
d
adding the fact that your handler might not even need any extra IRQ...
=20
>=20
> After all this discussing, I don't really see point of switching to=20
> fsleep() - unless delaying of the (asynchronous) probe proves to be a=20
> real problem. If it does, then my assumption that the short timeout does=
=20
> not need to be guaranteed is false and this should be changed.
>=20

Sure and I was doing a suggestion anyways. I feel we're bikeshedding now so
let's agree on disagree :)

- Nuno S=C3=A1


