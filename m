Return-Path: <linux-iio+bounces-12298-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 691589CDA02
	for <lists+linux-iio@lfdr.de>; Fri, 15 Nov 2024 08:39:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20469282B66
	for <lists+linux-iio@lfdr.de>; Fri, 15 Nov 2024 07:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E42CC188917;
	Fri, 15 Nov 2024 07:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b6UwGWPk"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C6E185B68;
	Fri, 15 Nov 2024 07:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731656385; cv=none; b=Wq6wZNuENv5pFrtg0aHktDF/tREpAIHbyCrAqtA7saiT9t7oc0nisruPyXLHZ/Btackzna4s7D6p7RgtQvaeD4FRLL8T5C5lsK377Ut8aC9s/7XOjG1j84Tdrz2TIqnWlQWvxDBDDkrqg/f31ieUBFOokL02sQ1wLu7KUmpatPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731656385; c=relaxed/simple;
	bh=eH19wIIM4cpxNwTLYT10HiMNgoD11ZBuSgwSdu+FriA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Q+zg4oA/tgkBc+k9jRHj4Qun/hAq8XvMuOsU1dvqoLDkiNvsiXxOHSteD50u721g7+KIW86QprS3tPY72prfl0Usoq4myqRDD+2LUT1eEbV447jn3PPQYC/C9zV78m2aDAw7jMljas/DtBOrr1Uo8LGKPoNGxzK2Qs2TJ71r06M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b6UwGWPk; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-431481433bdso3116505e9.3;
        Thu, 14 Nov 2024 23:39:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731656382; x=1732261182; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HAgmDy/oXRgQTGAgFIge+cgX1/PDJf6qQ6XWMqmqQBE=;
        b=b6UwGWPkCM1JKpKk9gRQ0TiqZHNLLXY+MMMYZR/JkBq11m1uJfFbFtgcijjjlHgKux
         lR7wBiOeiM6orYi292Fv0+3nEZWhSN3IDWiRLteaeetdxOwF4H6fEEOHKyo4gK9ZpkB6
         2DOuXBP26A3ssWBqM6nBPN3F6W7dBbdAqK2TxcDGzhOcM57UFkwh6ro+wk0PZ0lodCmj
         s/Lyx8ASJOS1K3csFIcmuxjuMQXDkizAFSNf37mdJk/HIQpF4dgLCLN1nMWW5k4RlXV0
         T6MhSCtpON5WpO5AKbRaHVgVCfbu5KPvTbF88lGV9Q52bg6d2YqGBLTgHVEN7wcd8hwe
         l61A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731656382; x=1732261182;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HAgmDy/oXRgQTGAgFIge+cgX1/PDJf6qQ6XWMqmqQBE=;
        b=s7STtNqi4/NU1u9eWIRqXbcXgjgaan4OXItuHx4u5XQDlca9uJhon0i6Re+brhRr0K
         oBZ+gzvaXhn8e816/R3WpMyzbWztwiZTzZxZdpZDskkkoFJYBZRZfX7yduIp5FKdGpb7
         qUsucAf6FCe8g/rB5ru2LDHSyMDc4zRceL93zjJA3t/gbM2jLynXR3RldugXus75NDw/
         tKSp9GWvBCJCHZlqhJFSHmSnzOZixfrIZ3m4rmCzcHTt3rKewqWrcBvz0+9ucbMHReFV
         4i0BRXKYTmyCuq2V1r75Ru91KaqrJtnbe2Dh40iyQyqrIiRNvFEgJLEnNWCSxa75XiCD
         uuag==
X-Forwarded-Encrypted: i=1; AJvYcCXVNh/M7xOZPkw7j/YifgEb4FYNCh9SXqMiz5uuqL89sV12m6gF3/6l9ycd6UMnSgaeT+u0GUsCE1s=@vger.kernel.org, AJvYcCXaBvEcpG9mSBzCZBAlZoqCJXEEJubLsXntDIDC1KtrKPoUjungBSwCSJqnwaStkJ56SsR92ySabcC9FEwm@vger.kernel.org
X-Gm-Message-State: AOJu0Yz92mQs3oCZfQlnXVw9R0ugDVyK0Qa3IimJKMKu+v10gqvNO64q
	Uo/prGJqQmfLJozwJxyae08bRJ5PzQDS7orSM2UrGAqonClKQeWS
X-Google-Smtp-Source: AGHT+IG24xPelIJH9MIOfvENb2P2kpKZ5Nc99Cnb/fLNErLCYcb1yInthdpjt6lfxdDhhWfvVDr9zw==
X-Received: by 2002:a05:6000:3c4:b0:382:d8c:2dc3 with SMTP id ffacd0b85a97d-3822590f077mr1317924f8f.14.1731656381676;
        Thu, 14 Nov 2024 23:39:41 -0800 (PST)
Received: from ?IPv6:2003:f6:ef02:f400:a23c:697f:16fb:11c5? (p200300f6ef02f400a23c697f16fb11c5.dip0.t-ipconnect.de. [2003:f6:ef02:f400:a23c:697f:16fb:11c5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3821adbe7f8sm3566970f8f.59.2024.11.14.23.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 23:39:41 -0800 (PST)
Message-ID: <9073554f353273d0aa99a7aebfc5f367cfaa7c1a.camel@gmail.com>
Subject: Re: [PATCH] iio: accel: kx022a: Improve reset delay
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>, Matti Vaittinen
	 <matti.vaittinen@fi.rohmeurope.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, 	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 15 Nov 2024 08:44:04 +0100
In-Reply-To: <42461eea-3e6d-4a15-a2fc-fa154163d80a@gmail.com>
References: <ZzWfXbjaDkFnu_Jg@mva-rohm>
	 <be375e24f74997743743fadf68125e176c23e2df.camel@gmail.com>
	 <f4cf3437-87ea-4d0f-8dab-890d89f85605@gmail.com>
	 <1f315c2f3eea86fe4db48f0168660ab4b0b020f1.camel@gmail.com>
	 <1410938e-5135-434c-911e-7ba925bafd49@gmail.com>
	 <b0a9eecb7b83c29aa545ed7717e3a6c2275b5e27.camel@gmail.com>
	 <42461eea-3e6d-4a15-a2fc-fa154163d80a@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-11-15 at 08:20 +0200, Matti Vaittinen wrote:
> On 14/11/2024 14:26, Nuno S=C3=A1 wrote:
> > On Thu, 2024-11-14 at 13:30 +0200, Matti Vaittinen wrote:
> > > On 14/11/2024 12:46, Nuno S=C3=A1 wrote:
> > > > On Thu, 2024-11-14 at 11:54 +0200, Matti Vaittinen wrote:
> > > > > On 14/11/2024 11:43, Nuno S=C3=A1 wrote:
> > > > > > On Thu, 2024-11-14 at 08:57 +0200, Matti Vaittinen wrote:
> > > > > > > All the sensors supported by kx022a driver seemed to require =
some
> > > > > > > delay
> > > > > > > after software reset to be operational again. More or less a
> > > > > > > random
> > > > > > > msleep(1) was added to cause the driver to go to sleep so the
> > > > > > > sensor
> > > > > > > has
> > > > > > > time to become operational again.
> > > > > > >=20
> > > > > > > Now we have official docuumentation available:
> > > > > > > https://fscdn.rohm.com/kionix/en/document/AN010_KX022ACR-Z_Po=
wer-on_Procedure_E.pdf
> > > > > > > https://fscdn.rohm.com/kionix/en/document/TN027-Power-On-Proc=
edure.pdf
> > > > > > > https://fscdn.rohm.com/kionix/en/document/AN011_KX134ACR-LBZ_=
Power-on_Procedure_E.pdf
> > > > > > >=20
> > > > > > > stating the required time is 2 ms.
> > > > > > >=20
> > > > > > > Due to the nature of the current msleep implementation, the
> > > > > > > msleep(1)
> > > > > > > is
> > > > > > > likely to be sleeping more than 2ms already - but the value "=
1" is
> > > > > > > misleading in case someone needs to optimize the start time a=
nd
> > > > > > > change
> > > > > > > the msleep to a more accurate delay. Hence it is better for
> > > > > > > "documentation" purposes to use value which actually reflects=
 the
> > > > > > > specified 2ms wait time.
> > > > > > >=20
> > > > > > > Change the value of delay after software reset to match the
> > > > > > > specifications and add links to the power-on procedure
> > > > > > > specifications.
> > > > > > >=20
> > > > > > > Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> > > > > > > ---
> > > > > > > Sorry for not including this to the KX134ACR-LBZ series I sen=
t
> > > > > > > yesterday. It was only half an hour after I had sent the KX13=
4ACR-
> > > > > > > LBZ
> > > > > > > support when I was notified about the existence of the KX022A=
CR-Z
> > > > > > > start-up procedure specification... Hence this lone patch to =
code
> > > > > > > which
> > > > > > > I just sent a miscallaneous series for before.
> > > > > > >=20
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0drivers/iio/accel/kionix-kx022a.c | 1=
1 ++++++++---
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A01 file changed, 8 insertions(+), 3 de=
letions(-)
> > > > > > >=20
> > > > > > > diff --git a/drivers/iio/accel/kionix-kx022a.c
> > > > > > > b/drivers/iio/accel/kionix-
> > > > > > > kx022a.c
> > > > > > > index 32387819995d..ccabe2e3b130 100644
> > > > > > > --- a/drivers/iio/accel/kionix-kx022a.c
> > > > > > > +++ b/drivers/iio/accel/kionix-kx022a.c
> > > > > > > @@ -1121,10 +1121,15 @@ static int kx022a_chip_init(struct
> > > > > > > kx022a_data
> > > > > > > *data)
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0		return ret;
> > > > > > > =C2=A0=C2=A0=C2=A0=20
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0	/*
> > > > > > > -	 * I've seen I2C read failures if we poll too fast after
> > > > > > > the
> > > > > > > sensor
> > > > > > > -	 * reset. Slight delay gives I2C block the time to
> > > > > > > recover.
> > > > > > > +	 * According to the power-on procedure documents, there
> > > > > > > is
> > > > > > > (at
> > > > > > > least)
> > > > > > > +	 * 2ms delay required after the software reset. This
> > > > > > > should
> > > > > > > be
> > > > > > > same
> > > > > > > for
> > > > > > > +	 * all, KX022ACR-Z, KX132-1211, KX132ACR-LBZ and
> > > > > > > KX134ACR-
> > > > > > > LBZ.
> > > > > > > +	 *
> > > > > > > +	 *
> > > > > > > https://fscdn.rohm.com/kionix/en/document/AN010_KX022ACR-Z_Po=
wer-on_Procedure_E.pdf
> > > > > > > +	 *
> > > > > > > https://fscdn.rohm.com/kionix/en/document/TN027-Power-On-Proc=
edure.pdf
> > > > > > > +	 *
> > > > > > > https://fscdn.rohm.com/kionix/en/document/AN011_KX134ACR-LBZ_=
Power-on_Procedure_E.pdf
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0	 */
> > > > > > > -	msleep(1);
> > > > > > > +	msleep(2);
> > > > > >=20
> > > > > > msleep() is not advisable for something lower than 20ms. Maybe =
take
> > > > > > the
> > > > > > opportunity and change it to fsleep()?
> > > > >=20
> > > > > Thank you for the suggestion Nuno. I did originally consider usin=
g the
> > > > > usleep_range() since the checkpatch knows to warn about msleep wi=
th
> > > > > small times.
> > > > >=20
> > > > > However, there should be no rush to power-on the sensor at startu=
p. It
> > > > > usually does not matter if the sleep is 2 or 20 milli seconds, as=
 long
> > > > > as it is long enough. I wonder if interrupting the system with
> > > > > hrtimers
> > > > > for _all_ smallish delays (when the longer delay would not really
> > > > > hurt)
> > > >=20
> > > > That's why you have ranges of about 20% (I think) in usleep() so yo=
u
> > > > minimize
> > > > hrtimers interrupts.
> > > >=20
> > > > Other thing is boot time... Sleeping 20ms instead of 2ms is a huge
> > > > difference.
> > > > Imagine if everyone thought like this for small sleeps :)?
> > >=20
> > > I think this is interesting question. My thoughts were along the line
> > > that, even if small sleeps were extended to longer (where small sleep=
 is
> > > not a priority), the CPUs would still (especially during the boot up)
> > > have their hands full. I don't know if we might indeed end up a
> > > situation where CPUs were idling, waiting for next timer slot.
> >=20
> > My problem is not the CPU but delaying probing devices as you probe one
> > device
> > at time...
> >=20
> > >=20
> > > What comes to boot time, I doubt the CPUs run out of things to do,
> > > especially when we use the probe_type =3D PROBE_PREFER_ASYNCHRONOUS.
> >=20
> > Yeah, with this, the above does not apply. Still, spending more time in=
 a
> > worker
> > than needed (and 18ms is huge) seems a waste to me.
>=20
> This is likely to be my ignorance, but I don't know what is wasted here.=
=20
> (genuine question, not trying to be a smart-ass).

Well, AFAIK, async probing is using the async.c API which is based on worke=
rs.
If you spend (worst case scenario) 18ms more than you need in the handler (=
and
18ms is __huge__), it means that worker can't go on and do some other usefu=
l
stuff, right?

>=20
> > > > > is a the best design choice. Hence I'd rather keep the msleep whe=
n we
> > > > > don't need to guarantee delay to be short instead of defaulting t=
o
> > > > > hrtimers or even busy-loop when it is not required.
> > > > >=20
> > > > > Do you think I am mistaken?
> > > > >=20
> > > >=20
> > > > To me this is more about correctness and do what the docs tell us t=
o do
> > > > :).
> > > > Sure, here you know what you're doing and you don't care if you end=
 up
> > > > sleeping
> > > > more than 2ms but that's not always the case and code like this all=
ows
> > > > for
> > > > legit
> > > > mistakes (if someone just copy paste this for example).
> > >=20
> > > Right. I just wonder if always requiring stricter wake-up instead of
> > > allowing things to run uninterrupted is the best role model either?
> >=20
> > Why not :)? If we just need to wait 2ms, why waiting more? I would be v=
ery
> > surprised if hrtimers are a deal breaker in here. Otherwise, we should
> > remove it
> > from the docs...
>=20
> Again I may be wrong, but I think each of the interrupts we add, require=
=20
> tiny bit of handling - which I thought is more of a waste than sleeping.
>=20

Not that it's even every likely that you're not adding a new interrupt
necessarily. That's the point of the range in usleep(). So that multiple
handlers can be done in one interrupt.

> I admit this is all hand-waving as I have no test data to back up my=20
> pondering. And, I believe you are right that this surely is not a deal=
=20
> breaker - but neither do I see adding more interrupts (when not really=
=20
> needed) as a good design.
>=20
> > > > Not a big deal anyways...
> > >=20
> > > Agree :) But I think this is a spot where I could learn a bit. I will
> > > gladly switch to the fsleep() if someone explains me relying on hrtim=
ers
> > > should be preferred also when there is no real need to wake up quicke=
r
> > > than msleep() allows.
> > >=20
> >=20
> > Personally, I think that sleeping more than needed is always a wast and=
 then
> > it
> > comes back to my correctness comment. In here you know what you're doin=
g but
> > I
> > dunno that switching to hrtimers will do any arm to the device :) and a=
llows
> > proper patterns to be copied.
>=20
> I have been thinking that handling the (hrtimer) interrupts generates=20
> more overhead (waste) than sleeping.
>=20

Put it this way... if that was true, I would assume it would be somewhere
described in the sleeping docs. More, I don't think the rule of thumb would=
 be
to use hrtirmers for things < 20ms.

- Nuno S=C3=A1

