Return-Path: <linux-iio+bounces-8089-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C0A9429E0
	for <lists+linux-iio@lfdr.de>; Wed, 31 Jul 2024 11:03:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48DD928334D
	for <lists+linux-iio@lfdr.de>; Wed, 31 Jul 2024 09:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D51071A8C1F;
	Wed, 31 Jul 2024 09:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F8PhhiJn"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B5E1A8C1A;
	Wed, 31 Jul 2024 09:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722416599; cv=none; b=CMV+uDdqL08BuB/cKZrcYvRML33tszDVm3cZwba7igfhKmVQjWI3ACsViRdD6w4+nYotwBavPpmJXZqwBnW6HZD4qkylmFZ8DbJx1sgmzOSJejVOjvyWHKEl2PKTN1epxNtmNu+UzaXGEMus0OfLBVdJNfv0OQZVL5URNs8OYMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722416599; c=relaxed/simple;
	bh=PbnpjxzZUgWhez3rYqbFM1+yNwv02Wmdr67+IMH/5bQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nHJGi5zgCOG74X9rYtDErf+eKZCVwptKLB+Y/23BOopM00Np/Z8gb3zfqCzp5CihojGBhBUytldUd6oMrC8g7AxC4QsXAryE8Jiya2vKVI1Vs4ubUjM+3VD7c0b4p1p27Yigu9AkpqkzxHDpk4bMjaNKPs0rV7nug4wtAT33L+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F8PhhiJn; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5a1337cfbb5so9194619a12.3;
        Wed, 31 Jul 2024 02:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722416596; x=1723021396; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PbnpjxzZUgWhez3rYqbFM1+yNwv02Wmdr67+IMH/5bQ=;
        b=F8PhhiJnXFmdvnw+UJQhLNXLuPziGnuktcwW+voRBN3LD9O2FacU/ch8iX+5a7Z/Gq
         rDYB8ShHOXp6uwt8uarnN0HfZL8kI3PX54FtvvdJM+HJ3XYWlZFqMTEyuQ1aUQmd7uZ9
         AdNyxzXuPuclXoJmCU+seKbUKABU4ItJCmwXZz4KZo7odc61Nba0Wl52u8eiuxkDUn76
         ZxAR3N8eSBGRB9/WeYXi5BLh3sc1d+HsgmhGil8VNNSZJldA6dt6eGGd5nj4DX1a/+Yl
         1LthtOg3EZrIB/7vgqX3hLNNFkSduu/SaEHUdeqgVagPomDUjoNYKSW07JApNV5QL4xM
         pIxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722416596; x=1723021396;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PbnpjxzZUgWhez3rYqbFM1+yNwv02Wmdr67+IMH/5bQ=;
        b=Gy0+fpNz/gSNHR6iwCH68E7agGylPt2XvNJhYZxnahW9yyJOpdEvU1z2Vol1S/99tD
         CQj9Iup1X5o2LenW7bQ7udbz1CE7Nj8LVkfbnpLiG+9enrq9Nn/FiApOsuK5vRC0dp4O
         pT5BK7zykB+1lPD8C9vrfRlJ3UBzEivygvb2fa0u8cPR5qha106tGPk2ag9BHpb6PZdT
         t73rL+/LaVzEWApkTkSCX0oHF9OzBbFD0Km+J/jTkmUtam2PpC9nx9L2hUIcJYAfUQPj
         ahl97WsUPJSEKRABBE5wiC5m1L8hhJScnzrW15iurqfDWrK8Qckc7S65CoBkXAc/z+Wh
         Kn8g==
X-Forwarded-Encrypted: i=1; AJvYcCWsD39fpB+b5Z31uF7pw5Jl88vCl59RrrDRrCbKjdGAccIkS8shP5rz5P0Pbl+WHvUnjm/YNaFPkXzVBbHbUUy+yuJqg7VogsF6J/H/P7h3TTIAjW3ICZ+sx4hXWiEHg6pN/nOFSAMLp37sk5qH9VD58Py7LdKuv9i8gJyNKMk3Mp4/Hw==
X-Gm-Message-State: AOJu0YyaS+NXAAElBp9UaI0QOMK/ZHng+KlUD4gfZaWeWHZn2MmAGe72
	55TINJDxveEKHEHdfWArz5+ZrvnRCJEZLuURpoEscjUbpiUBMdCE
X-Google-Smtp-Source: AGHT+IGk4m9yO+qkTyZG6r+mscXD08GHV8YL9cPQJy7zv9k9jOYUBtHN2HK5OGbYXkk8TGu5fZn71A==
X-Received: by 2002:a50:baa9:0:b0:57c:7471:a0dd with SMTP id 4fb4d7f45d1cf-5b0206ce157mr8358031a12.12.1722416595478;
        Wed, 31 Jul 2024 02:03:15 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1c:c500:ee59:d953:f148:40ba? (p200300f6ef1cc500ee59d953f14840ba.dip0.t-ipconnect.de. [2003:f6:ef1c:c500:ee59:d953:f148:40ba])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ac63590e7esm8381855a12.36.2024.07.31.02.03.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 02:03:15 -0700 (PDT)
Message-ID: <f6c9f7730541a6a97e4ce0005bb4cf600973e691.camel@gmail.com>
Subject: Re: [PATCH RFC 2/5] iio: adc: ad4030: add driver for ad4030-24
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, Esteban Blanc <eblanc@baylibre.com>
Cc: baylibre-upstreaming@groups.io, Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>
Date: Wed, 31 Jul 2024 11:07:14 +0200
In-Reply-To: <20240728160408.4b810505@jic23-huawei>
References: <20240627-eblanc-ad4630_v1-v1-0-fdc0610c23b0@baylibre.com>
	 <20240627-eblanc-ad4630_v1-v1-2-fdc0610c23b0@baylibre.com>
	 <0036d44542f8cf45c91c867f0ddd7b45d1904d6b.camel@gmail.com>
	 <D2ZIG2NK223D.J9VK1MWOICE3@baylibre.com>
	 <20240728160408.4b810505@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2024-07-28 at 16:04 +0100, Jonathan Cameron wrote:
> One quick comment form me inline.
>=20
> The short version is non power of 2 storage is not an option because
> it is a major ABI change and we aren't paying the cost of complexity
> that brings to userspace for a very small number of drivers where
> there is any real advantage to packing them tighter.
>=20
> >=20
> > > So, from the datasheet, figure 39 we have something like a multiplexe=
r
> > > where we
> > > can have:
> > >=20
> > > - averaged data;
> > > - normal differential;
> > > - test pattern (btw, useful to have it in debugfs - but can come late=
r);
> > > - 8 common mode bits;
> > >=20
> > > While the average, normal and test pattern are really mutual exclusiv=
e,
> > > the
> > > common mode voltage is different in the way that it's appended to
> > > differential
> > > sample. Making it kind of an aggregated thingy. Thus I guess it can m=
ake
> > > sense
> > > for us to see them as different channels from a SW perspective (even =
more
> > > since
> > > gain and offset only apply to the differential data). But there are a
> > > couple of
> > > things I don't like (have concerns):
> > >=20
> > > * You're pushing the CM channels into the end. So when we a 2 channel
> > > device
> > > we'll have:
> > >=20
> > > =C2=A0in_voltage0 - diff
> > > =C2=A0in_voltage1 - diff
> > > =C2=A0in_voltage2 - CM associated with chan0
> > > =C2=A0in_voltage0 - CM associated with chan1
> > >=20
> > > I think we could make it so the CM channel comes right after the chan=
nel
> > > where
> > > it's data belongs too. So for example, odd channels would be CM chann=
els
> > > (and
> > > labels could also make sense).=C2=A0=20
> >=20
> > I must agree with you it would make more sense.
> >=20
> > > Other thing that came to mind is if we could somehow use differential=
 =3D
> > > true
> > > here. Having something like:
> > >=20
> > > in_voltage1_in_voltage0_raw - diff data
> > > ...
> > > And the only thing for CM would be:
> > >=20
> > > in_voltage1_raw
> > > in_voltage1_scale
> > >=20
> > > (not sure if the above is doable with ext_info - maybe only with
> > > device_attrs)
> > >=20
> > > The downside of the above is that we don't have a way to separate the=
 scan
> > > elements. Meaning that we don't have a way to specify the scan_type f=
or
> > > both the
> > > common mode and differential voltage. That said, I wonder if it is th=
at
> > > useful
> > > to buffer the common mode stuff? Alternatively, we could just have th=
e
> > > scan_type
> > > for the diff data and apps really wanting the CM voltage could still
> > > access the
> > > raw data. Not pretty, I know...=C2=A0=20
> >=20
> > At the moment the way I "separate" them is by looking at the
> > `active_scan_mask`. If the user asked for differential channel only, I =
put
> > the
> > chip in differential only mode. If all the channels are asked, I put
> > the chip in differential + common mode. This way there is no need to
> > separate anything in differential mode. See below for an example where
> > this started.
> >=20
> > > However, even if we go with the two separate channels there's one thi=
ng
> > > that
> > > concerns me. Right now we have diff data with 32 for storage bits and=
 CM
> > > data
> > > with 8 storage bits which means the sample will be 40 bits and in rea=
lity
> > > we
> > > just have 32. Sure, now we have SW buffering so we can make it work b=
ut
> > > the
> > > ultimate goal is to support HW buffering where we won't be able to to=
uch
> > > the
> > > sample and thus we can't lie about the sample size. Could you run any=
 test
> > > with
> > > this approach on a HW buffer setup?=C2=A0=C2=A0=20
> >=20
> > Let's take AD4630-24 in diff+cm mode as an example. We would have 4
> > channels:
> > - Ch0 diff with 24 bits of realbits and 24 bits of storagebits
> > - Ch0 cm with 8 bits of realbits and 8 bits of storagebits
> > - Ch1 diff with 24 bits of realbits and 24 bits of storagebits
> > - Ch1 cm with 8 bits of realbits and 8 bits of storagebits
> > ChX diff realbits + ChX cm realbits =3D 32 bits which is one sample as =
sent
> > by the chip.
> >=20
> > The problem I faced when trying to do this in this series is that IIO
> > doesn't
> > seem to like 24 storagebits and the data would get garbled. In diff onl=
y
> > mode with the same channel setup (selecting only Ch0 diff and Ch1 diff)
> > the data is also garbled. I used iio-oscilloscope software to test this
> > setup.
> > Here is the output with iio_readdev:
> > ```
> > # iio_readdev -s 1 ad4630-24 voltage0
> > WARNING: High-speed mode not enabled
> > Unable to refill buffer: Invalid argument (22)
> > ```
> >=20
> > I think this is happening when computing the padding to align ch1 diff.
> > In `iio_compute_scan_bytes` this line `bytes =3D ALIGN(bytes, length);`
> > will be invoked with bytes =3D 3 and length =3D 3 when selecting ch0 di=
ff
> > and ch1 diff (AD4630-24 in differential mode). The output is 5. As
> > specified in linux/align.h:
> > > @a is a power of 2=C2=A0=20
> > In our case `a` is `length`, and 3 is not a power of 2.
> >=20
> > It works fine with Ch0/1 diff with 24 realbits and 32 storagebits with =
8
> > bits shift.
> >=20
> > Intrestingly, a similar setup works great on AD4630-16:
> > - Ch0 diff with 16 bits of realbits and 16 bits of storagebits
> > - Ch0 cm with 8 bits of realbits and 8 bits of storagebits
> > - Ch1 diff with 16 bits of realbits and 16 bits of storagebits
> > - Ch1 cm with 8 bits of realbits and 8 bits of storagebits
> >=20
> > In `iio_compute_scan_bytes` we will have ALIGN(3, 2) which will output
> > 4, everything is fine. The output of iio-oscilloscope is as expected,
> > a clean sinewave and iio_readdev does not throw an error.
> >=20
> > All this to say that at the moment, I'm not sure how I will be able to
> > put the CM byte in a separate channel for AD4630-24 without buffering i=
t.
> > It would be useful to return a "packed" buffer.
>=20
> Whilst it might be useful to allow non power of 2 storage formats,
> that's a break of the IIO userspace ABI so that isn't an approach to
> consider. You must shuffle the data in the driver.

Yeah, I do agree the breakage is really not the way to go...

OTOH, I'm seeing more and more of these devices with kind of multiplexed
data/channels in one sample (like cm and diff in this case) and while in SW
buffering we can workaround it in the driver, for HW buffering things may b=
e not
that "simple".

Not sure what we can do about it but one concept that came to mind when I w=
as
giving some thinking about this was kind of a virtual scan element that wou=
ld
essentially map/link to a (physical) scan element (so virtual_scan + scan =
=3D
storage_size of the real scan element). Kind of a basic idea for now and I'=
m not
really sure how much work would this be or even how could we expose this to
userspace without breaking current ABI (basically if it's doable at all :))=
.

The only other option I see for these kind of devices (if there's nothing w=
e can
do in HW for shuffling data) is to expose a different channel setup that do=
es
not "lie" about the sample size. And it's up to userspace to parse the samp=
le
data. Far from pretty though...

- Nuno S=C3=A1

