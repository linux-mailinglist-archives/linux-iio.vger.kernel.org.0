Return-Path: <linux-iio+bounces-12248-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB569C89C8
	for <lists+linux-iio@lfdr.de>; Thu, 14 Nov 2024 13:21:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5AF31F23EC8
	for <lists+linux-iio@lfdr.de>; Thu, 14 Nov 2024 12:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 550871F9A82;
	Thu, 14 Nov 2024 12:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J0X3j0xX"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383531F80CC;
	Thu, 14 Nov 2024 12:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731586902; cv=none; b=jn+lPCeTBy6qtuMq26LsZaD2gVg+XEyTstwncGZ/QPkSvJPYIZpfvP14Gekybe9qh6D2k8jIX9md7blyDrzuSD3ihIcJKDJsmqiRASEd3TLm/gfxjh8Jxw7zCvISsNaiC4pUBhVeseVk8+JpGX0IMNIflF+qa7nZd4FEsrtkNdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731586902; c=relaxed/simple;
	bh=qhLjRTwMSiK1gN/1gAQwpbV/O+5iNG+GVRk0YMFjoLc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=USIisy56SCWaiQMIrSjUuBuVqVqPyJHhp71nsrmoonkUXZf3q1axlCrngSxO6mBDULRaHN0tA3GeMxDR9JPKalj2/Wjvh1DCHFz2ar3AvCSq9vrVttYFxdzQZsfESXyUUa+ccQB3OwiTmJfsz8Ae3urJFXMx2Cfv6unYa591lEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J0X3j0xX; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-37d49a7207cso348021f8f.0;
        Thu, 14 Nov 2024 04:21:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731586898; x=1732191698; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GLjOREoOQmBlhC3DKhm0mq2e1vDsIIepitbl2vA1L6A=;
        b=J0X3j0xXruw3EuwJKg+nvKpC42Pr6EA4XwDRFHAbmg1UI4d1xTHZdhfPuKW/FdWFgz
         pQKqT3dbm8aunHqEOwco8O3F32h8o4t27rPUOkUbPCv/w2FilxXDbMC1pbjPEUjR1QVi
         TxciM6k4BrKkTZQcqSjpW/lztrUVrk/AHYaepcYAFSi2oMQuSAg9A6FY63PM1nrcC+SP
         /YCaQ+WoGNNarojPvSCKH2NfSjERyAO/1OZItzfKTDdwuYUVlBsE1REtdVx27tDXAMY6
         dEjowK6Uw7IDuh2Oh+AEOE5O/EyNW0/wKt1pey7I62mLvFkLVdLKMSgn6jghBL42DlLd
         ImlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731586898; x=1732191698;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GLjOREoOQmBlhC3DKhm0mq2e1vDsIIepitbl2vA1L6A=;
        b=g5TXj/VROBYDL3wWCB8Jty326NSFIqis7kJG5wj33RGp7r/G1l756NktNDS1tLIjHL
         9A/xK/Ygd9FoItyG1O2gvZ+uB2xvPasDLf1/Ye86COBQ+KyZvLRHl5tCNb6FuffUZUsc
         b4ir970Smyr0FtCUsUzZXQUXuYuO9lpO4BDrgfgFvKB/dzFcK0po/QIjKvNJrLf1KpnE
         WAwpRQg6N0erf1ciicXFqdJWukt65f/TRNEoTHzg6covAN1n2outChdWb8cq9EGgp52w
         AmEVTKeXDcUZZN1PSnOaNG6RQmCGrA6c18VKtTEn47jJZkUBvG3tVcRz9Z3Y+ZuhQEJE
         3bTA==
X-Forwarded-Encrypted: i=1; AJvYcCVFtdcvigAD/c0GxJzbjh3PIOdraUTRPgY9IQ1Rwi5Hzl/oot55cxa3Sk4nNisD/f6OyOKkySbfwAwCWTBP@vger.kernel.org, AJvYcCVmBxFbDz86s6psxPXVsrVqWBPxGHbg2z2e8ct5ykuB81pqt/BqtGLIh8lmNF/238xAMmDIVgVH9Aw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXCPJ1lLrprIshE6c9YIOrauscrT/SU6dLnyNdN+3GYb+YzIye
	iJzftlB8xtyF4IFYEl9Ed38bpvC8hIzO64KvalbDqX9pDm9Jqwhn7aCR+1ZpBJTLaoPS
X-Google-Smtp-Source: AGHT+IFAntRADJj0A+Cc9AR+vsdBDax2iZ60M05lB3tpTGYieGeiP3siZAXAgF6rVx24csMg3EaVSg==
X-Received: by 2002:a05:6000:701:b0:37d:39c8:ecca with SMTP id ffacd0b85a97d-38218542e5fmr1578826f8f.55.1731586898339;
        Thu, 14 Nov 2024 04:21:38 -0800 (PST)
Received: from ?IPv6:2003:f6:ef02:f400:a23c:697f:16fb:11c5? (p200300f6ef02f400a23c697f16fb11c5.dip0.t-ipconnect.de. [2003:f6:ef02:f400:a23c:697f:16fb:11c5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3821adbebe2sm1320715f8f.61.2024.11.14.04.21.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 04:21:37 -0800 (PST)
Message-ID: <b0a9eecb7b83c29aa545ed7717e3a6c2275b5e27.camel@gmail.com>
Subject: Re: [PATCH] iio: accel: kx022a: Improve reset delay
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>, Matti Vaittinen
	 <matti.vaittinen@fi.rohmeurope.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, 	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 14 Nov 2024 13:26:01 +0100
In-Reply-To: <1410938e-5135-434c-911e-7ba925bafd49@gmail.com>
References: <ZzWfXbjaDkFnu_Jg@mva-rohm>
	 <be375e24f74997743743fadf68125e176c23e2df.camel@gmail.com>
	 <f4cf3437-87ea-4d0f-8dab-890d89f85605@gmail.com>
	 <1f315c2f3eea86fe4db48f0168660ab4b0b020f1.camel@gmail.com>
	 <1410938e-5135-434c-911e-7ba925bafd49@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-11-14 at 13:30 +0200, Matti Vaittinen wrote:
> On 14/11/2024 12:46, Nuno S=C3=A1 wrote:
> > On Thu, 2024-11-14 at 11:54 +0200, Matti Vaittinen wrote:
> > > On 14/11/2024 11:43, Nuno S=C3=A1 wrote:
> > > > On Thu, 2024-11-14 at 08:57 +0200, Matti Vaittinen wrote:
> > > > > All the sensors supported by kx022a driver seemed to require some
> > > > > delay
> > > > > after software reset to be operational again. More or less a rand=
om
> > > > > msleep(1) was added to cause the driver to go to sleep so the sen=
sor
> > > > > has
> > > > > time to become operational again.
> > > > >=20
> > > > > Now we have official docuumentation available:
> > > > > https://fscdn.rohm.com/kionix/en/document/AN010_KX022ACR-Z_Power-=
on_Procedure_E.pdf
> > > > > https://fscdn.rohm.com/kionix/en/document/TN027-Power-On-Procedur=
e.pdf
> > > > > https://fscdn.rohm.com/kionix/en/document/AN011_KX134ACR-LBZ_Powe=
r-on_Procedure_E.pdf
> > > > >=20
> > > > > stating the required time is 2 ms.
> > > > >=20
> > > > > Due to the nature of the current msleep implementation, the mslee=
p(1)
> > > > > is
> > > > > likely to be sleeping more than 2ms already - but the value "1" i=
s
> > > > > misleading in case someone needs to optimize the start time and c=
hange
> > > > > the msleep to a more accurate delay. Hence it is better for
> > > > > "documentation" purposes to use value which actually reflects the
> > > > > specified 2ms wait time.
> > > > >=20
> > > > > Change the value of delay after software reset to match the
> > > > > specifications and add links to the power-on procedure specificat=
ions.
> > > > >=20
> > > > > Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> > > > > ---
> > > > > Sorry for not including this to the KX134ACR-LBZ series I sent
> > > > > yesterday. It was only half an hour after I had sent the KX134ACR=
-LBZ
> > > > > support when I was notified about the existence of the KX022ACR-Z
> > > > > start-up procedure specification... Hence this lone patch to code
> > > > > which
> > > > > I just sent a miscallaneous series for before.
> > > > >=20
> > > > > =C2=A0=C2=A0=C2=A0drivers/iio/accel/kionix-kx022a.c | 11 ++++++++=
---
> > > > > =C2=A0=C2=A0=C2=A01 file changed, 8 insertions(+), 3 deletions(-)
> > > > >=20
> > > > > diff --git a/drivers/iio/accel/kionix-kx022a.c
> > > > > b/drivers/iio/accel/kionix-
> > > > > kx022a.c
> > > > > index 32387819995d..ccabe2e3b130 100644
> > > > > --- a/drivers/iio/accel/kionix-kx022a.c
> > > > > +++ b/drivers/iio/accel/kionix-kx022a.c
> > > > > @@ -1121,10 +1121,15 @@ static int kx022a_chip_init(struct kx022a=
_data
> > > > > *data)
> > > > > =C2=A0=C2=A0=C2=A0		return ret;
> > > > > =C2=A0=C2=A0=20
> > > > > =C2=A0=C2=A0=C2=A0	/*
> > > > > -	 * I've seen I2C read failures if we poll too fast after the
> > > > > sensor
> > > > > -	 * reset. Slight delay gives I2C block the time to recover.
> > > > > +	 * According to the power-on procedure documents, there is
> > > > > (at
> > > > > least)
> > > > > +	 * 2ms delay required after the software reset. This should
> > > > > be
> > > > > same
> > > > > for
> > > > > +	 * all, KX022ACR-Z, KX132-1211, KX132ACR-LBZ and KX134ACR-
> > > > > LBZ.
> > > > > +	 *
> > > > > +	 *
> > > > > https://fscdn.rohm.com/kionix/en/document/AN010_KX022ACR-Z_Power-=
on_Procedure_E.pdf
> > > > > +	 *
> > > > > https://fscdn.rohm.com/kionix/en/document/TN027-Power-On-Procedur=
e.pdf
> > > > > +	 *
> > > > > https://fscdn.rohm.com/kionix/en/document/AN011_KX134ACR-LBZ_Powe=
r-on_Procedure_E.pdf
> > > > > =C2=A0=C2=A0=C2=A0	 */
> > > > > -	msleep(1);
> > > > > +	msleep(2);
> > > >=20
> > > > msleep() is not advisable for something lower than 20ms. Maybe take=
 the
> > > > opportunity and change it to fsleep()?
> > >=20
> > > Thank you for the suggestion Nuno. I did originally consider using th=
e
> > > usleep_range() since the checkpatch knows to warn about msleep with
> > > small times.
> > >=20
> > > However, there should be no rush to power-on the sensor at startup. I=
t
> > > usually does not matter if the sleep is 2 or 20 milli seconds, as lon=
g
> > > as it is long enough. I wonder if interrupting the system with hrtime=
rs
> > > for _all_ smallish delays (when the longer delay would not really hur=
t)
> >=20
> > That's why you have ranges of about 20% (I think) in usleep() so you
> > minimize
> > hrtimers interrupts.
> >=20
> > Other thing is boot time... Sleeping 20ms instead of 2ms is a huge
> > difference.
> > Imagine if everyone thought like this for small sleeps :)?
>=20
> I think this is interesting question. My thoughts were along the line=20
> that, even if small sleeps were extended to longer (where small sleep is=
=20
> not a priority), the CPUs would still (especially during the boot up)=20
> have their hands full. I don't know if we might indeed end up a=20
> situation where CPUs were idling, waiting for next timer slot.

My problem is not the CPU but delaying probing devices as you probe one dev=
ice
at time...

>=20
> What comes to boot time, I doubt the CPUs run out of things to do,=20
> especially when we use the probe_type =3D PROBE_PREFER_ASYNCHRONOUS.

Yeah, with this, the above does not apply. Still, spending more time in a w=
orker
than needed (and 18ms is huge) seems a waste to me.

>=20
>=20
> > > is a the best design choice. Hence I'd rather keep the msleep when we
> > > don't need to guarantee delay to be short instead of defaulting to
> > > hrtimers or even busy-loop when it is not required.
> > >=20
> > > Do you think I am mistaken?
> > >=20
> >=20
> > To me this is more about correctness and do what the docs tell us to do=
 :).
> > Sure, here you know what you're doing and you don't care if you end up
> > sleeping
> > more than 2ms but that's not always the case and code like this allows =
for
> > legit
> > mistakes (if someone just copy paste this for example).
>=20
> Right. I just wonder if always requiring stricter wake-up instead of=20
> allowing things to run uninterrupted is the best role model either?

Why not :)? If we just need to wait 2ms, why waiting more? I would be very
surprised if hrtimers are a deal breaker in here. Otherwise, we should remo=
ve it
from the docs...
=20
>=20
> > Not a big deal anyways...
>=20
> Agree :) But I think this is a spot where I could learn a bit. I will=20
> gladly switch to the fsleep() if someone explains me relying on hrtimers=
=20
> should be preferred also when there is no real need to wake up quicker=
=20
> than msleep() allows.
>=20

Personally, I think that sleeping more than needed is always a wast and the=
n it
comes back to my correctness comment. In here you know what you're doing bu=
t I
dunno that switching to hrtimers will do any arm to the device :) and allow=
s
proper patterns to be copied.

- Nuno S=C3=A1


