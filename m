Return-Path: <linux-iio+bounces-8088-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D69289429A4
	for <lists+linux-iio@lfdr.de>; Wed, 31 Jul 2024 10:52:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 935C82815CB
	for <lists+linux-iio@lfdr.de>; Wed, 31 Jul 2024 08:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31CF71A8BF7;
	Wed, 31 Jul 2024 08:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ULfTVI0K"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F981A8BF0;
	Wed, 31 Jul 2024 08:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722415949; cv=none; b=QXHE1ERX8B9QE4/jmNxHPkEIlbVNbcxYxHMdUQP6ahTIb1W3/1Wlk+wQGk8yPSSIF5nhZ3W7v/KaRAKabINRqsq0pyyrfNdmcYgth+FdcnzywQ7laoXjUYXl9PrsbjKlfY1fEpKfPWB7d5rey5C5Ei+sMzwvZuEFiORVBKTybFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722415949; c=relaxed/simple;
	bh=9rZ1LR2MHfwElzYHe5xKBRdAftswcYFgbJGTICHn+lM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YUqDMTS3s0GcrU+jnYsMhVpprHLKJy2Dedk+EqNgyOBTA3hCc601WFAgjGiFwP2vJ20Vlufc/k2QnM2liIgSqFga9wpZSSX50bo/VQZlPsABuLmvFZi6rLVzNLMIJpSh9beymbgA+0e6Fc0n0yV+p4b89LiZX5FnoNLE0dH7mPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ULfTVI0K; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5a108354819so8302277a12.0;
        Wed, 31 Jul 2024 01:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722415943; x=1723020743; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YCgRqVhVvGH1xLiWUEDQJCc52pKSLqaPWPojVI4DuFo=;
        b=ULfTVI0Kt2vLG93idkfA5MD35L8/qTYtF44GeX72nKbQp+3tbf4owNtNzwPFbW/KGy
         FmdYevdmQ8V70GOJkgSgbnE55inV/D1t0DbDL9GzCVCR8Ka/zyOlL05LKpCR9Goe5aAe
         F4CzA3wuGslYvjaAE8bpRGwXu+daE5G+4DVsZQ8/YkBQXx4c/WeB28xbONmo6zHwdgzK
         j1T6vBetx3k0w92kFbmSocoMb0157vMMEwdmUoZfIGH7RnhwAb224we2DM5pZHWGXf33
         SxIxqOj4QnnArfxdrcIBiykVyS//I8NyZugpieC7TdUN9ctOcUmk6BuVaSy8ogTbdIJf
         0Y1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722415943; x=1723020743;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YCgRqVhVvGH1xLiWUEDQJCc52pKSLqaPWPojVI4DuFo=;
        b=LlbDI+tUJ2meHIfyG6pr3gJtamqFaYPT0T4i43IOoXwjD+94P/AEyfaqSNmq7nlCN/
         3Y+V4h6ihFVgF7yiX73fUus+VZAn9JsbvBWIoGtAXDOHA/Tk0LNq4QerOe34TbtStrs2
         AmYx4eHk16e6d3VUZujuStb1PvF4cmCJo05HfxrzmkDC5jBWCj1aCNu3qJ/3Jr4ndc62
         HeoZ4okljUBq8DzUE76wMnK8iLySfIXSiLqhLdmD/fTkKqn7Cg0lpTc+ei3WQH3MglbC
         H4rw65CeSS/j3yYRVWpMpvI9SLxTORM1qJhO+SL+0SMNTaWNbnKA08H30n+C4R13EVSN
         7IrA==
X-Forwarded-Encrypted: i=1; AJvYcCUMSAjJGTj7mCeawubEpuGsnq6/FkdwvyVl8y4N3NOd5fMwmzgSlxIiABtMeSmPdUKsx8Ex24CEnL1ce+jEUQEPOopCOSosoHu/5VlY35j5zxRHrgQafYqQPtCGHxU1DqGedlHfdvYv9Q==
X-Gm-Message-State: AOJu0Yw6bHUz9Ike5Mz0Wn8f1PJqYz7RUKdnTns8lZLzK2892BU0ABSE
	Yre8gBP0ql3Sq8716x2ZbAxAL8ZorGzzF4jSnbH4lZJOECp4MmTl
X-Google-Smtp-Source: AGHT+IFEXB32MF/zDjaTaXXSZ3lHKaaN8xOrOrIvlZ3OexDxC8CPXVT80x1IHlUa898mxjpey4Bf2Q==
X-Received: by 2002:a05:6402:3595:b0:5a2:8802:8e10 with SMTP id 4fb4d7f45d1cf-5b02000c226mr9194659a12.8.1722415943182;
        Wed, 31 Jul 2024 01:52:23 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1c:c500:ee59:d953:f148:40ba? (p200300f6ef1cc500ee59d953f14840ba.dip0.t-ipconnect.de. [2003:f6:ef1c:c500:ee59:d953:f148:40ba])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ac652911a5sm8291208a12.79.2024.07.31.01.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 01:52:22 -0700 (PDT)
Message-ID: <ae7287257d6611ee27846643f48303c7e0dbb7ac.camel@gmail.com>
Subject: Re: [PATCH RFC 2/5] iio: adc: ad4030: add driver for ad4030-24
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Esteban Blanc <eblanc@baylibre.com>, baylibre-upstreaming@groups.io, 
 Lars-Peter Clausen
	 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron
	 <jic23@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Nuno Sa
	 <nuno.sa@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>
Date: Wed, 31 Jul 2024 10:56:22 +0200
In-Reply-To: <D2ZIG2NK223D.J9VK1MWOICE3@baylibre.com>
References: <20240627-eblanc-ad4630_v1-v1-0-fdc0610c23b0@baylibre.com>
	 <20240627-eblanc-ad4630_v1-v1-2-fdc0610c23b0@baylibre.com>
	 <0036d44542f8cf45c91c867f0ddd7b45d1904d6b.camel@gmail.com>
	 <D2ZIG2NK223D.J9VK1MWOICE3@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-07-26 at 15:38 +0200, Esteban Blanc wrote:
> Hi Nuno,
>=20
> > > +			struct {
> > > +				s32 val[AD4030_MAX_DIFF_CHANNEL_NB];
> > > +				u8 common[AD4030_MAX_COMMON_CHANNEL_NB];
> >=20
> > Not sure common makes sense as it comes aggregated with the sample. May=
be
> > this
> > could as simple as:
> >=20
> > struct {
> > 	s32 val;
> > 	u64 timestamp __aligned(8);
> > } rx_data ...
>=20
> See below my answer on channels order and storagebits.
>=20
> > So, from the datasheet, figure 39 we have something like a multiplexer =
where
> > we
> > can have:
> >=20
> > - averaged data;
> > - normal differential;
> > - test pattern (btw, useful to have it in debugfs - but can come later)=
;
> > - 8 common mode bits;
> >=20
> > While the average, normal and test pattern are really mutual exclusive,=
 the
> > common mode voltage is different in the way that it's appended to
> > differential
> > sample. Making it kind of an aggregated thingy. Thus I guess it can mak=
e
> > sense
> > for us to see them as different channels from a SW perspective (even mo=
re
> > since
> > gain and offset only apply to the differential data). But there are a c=
ouple
> > of
> > things I don't like (have concerns):
> >=20
> > * You're pushing the CM channels into the end. So when we a 2 channel d=
evice
> > we'll have:
> >=20
> > =C2=A0in_voltage0 - diff
> > =C2=A0in_voltage1 - diff
> > =C2=A0in_voltage2 - CM associated with chan0
> > =C2=A0in_voltage0 - CM associated with chan1
> >=20
> > I think we could make it so the CM channel comes right after the channe=
l
> > where
> > it's data belongs too. So for example, odd channels would be CM channel=
s
> > (and
> > labels could also make sense).
>=20
> I must agree with you it would make more sense.
>=20
> > Other thing that came to mind is if we could somehow use differential =
=3D true
> > here. Having something like:
> >=20
> > in_voltage1_in_voltage0_raw - diff data
> > ...
> > And the only thing for CM would be:
> >=20
> > in_voltage1_raw
> > in_voltage1_scale
> >=20
> > (not sure if the above is doable with ext_info - maybe only with
> > device_attrs)
> >=20
> > The downside of the above is that we don't have a way to separate the s=
can
> > elements. Meaning that we don't have a way to specify the scan_type for=
 both
> > the
> > common mode and differential voltage. That said, I wonder if it is that
> > useful
> > to buffer the common mode stuff? Alternatively, we could just have the
> > scan_type
> > for the diff data and apps really wanting the CM voltage could still ac=
cess
> > the
> > raw data. Not pretty, I know...
>=20
> At the moment the way I "separate" them is by looking at the
> `active_scan_mask`. If the user asked for differential channel only, I pu=
t the
> chip in differential only mode. If all the channels are asked, I put
> the chip in differential + common mode. This way there is no need to
> separate anything in differential mode. See below for an example where
> this started.
>=20
> > However, even if we go with the two separate channels there's one thing=
 that
> > concerns me. Right now we have diff data with 32 for storage bits and C=
M
> > data
> > with 8 storage bits which means the sample will be 40 bits and in reali=
ty we
> > just have 32. Sure, now we have SW buffering so we can make it work but=
 the
> > ultimate goal is to support HW buffering where we won't be able to touc=
h the
> > sample and thus we can't lie about the sample size. Could you run any t=
est
> > with
> > this approach on a HW buffer setup?=20
>=20
> Let's take AD4630-24 in diff+cm mode as an example. We would have 4 chann=
els:
> - Ch0 diff with 24 bits of realbits and 24 bits of storagebits
> - Ch0 cm with 8 bits of realbits and 8 bits of storagebits
> - Ch1 diff with 24 bits of realbits and 24 bits of storagebits
> - Ch1 cm with 8 bits of realbits and 8 bits of storagebits
> ChX diff realbits + ChX cm realbits =3D 32 bits which is one sample as se=
nt
> by the chip.
>=20
> The problem I faced when trying to do this in this series is that IIO doe=
sn't
> seem to like 24 storagebits and the data would get garbled. In diff only
> mode with the same channel setup (selecting only Ch0 diff and Ch1 diff)
> the data is also garbled. I used iio-oscilloscope software to test this s=
etup.
> Here is the output with iio_readdev:
> ```
> # iio_readdev -s 1 ad4630-24 voltage0
> WARNING: High-speed mode not enabled
> Unable to refill buffer: Invalid argument (22)
> ```
>=20
> I think this is happening when computing the padding to align ch1 diff.
> In `iio_compute_scan_bytes` this line `bytes =3D ALIGN(bytes, length);`
> will be invoked with bytes =3D 3 and length =3D 3 when selecting ch0 diff
> and ch1 diff (AD4630-24 in differential mode). The output is 5. As
> specified in linux/align.h:
> > @a is a power of 2
> In our case `a` is `length`, and 3 is not a power of 2.
>=20
> It works fine with Ch0/1 diff with 24 realbits and 32 storagebits with 8
> bits shift.

Yes, I do understand that and that we need a power of 2 for storage bits. M=
y
concern, as stated, is that if we have HW buffering (High speed enabled) CH=
O
will have a sample size of (with diff + cm) of 40 which is not really what =
comes
from HW. I wonder if it will work in that case. Maybe we can (as this often
happens on an FGPA) have the HW guys doing some data shuffling so things wo=
rk in
the high speed mode as well.

- Nuno S=C3=A1



