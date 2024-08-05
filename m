Return-Path: <linux-iio+bounces-8247-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C231994788C
	for <lists+linux-iio@lfdr.de>; Mon,  5 Aug 2024 11:38:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E43FE1C213C8
	for <lists+linux-iio@lfdr.de>; Mon,  5 Aug 2024 09:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C5215443C;
	Mon,  5 Aug 2024 09:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="pehdjkfk"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA5D153BD9
	for <linux-iio@vger.kernel.org>; Mon,  5 Aug 2024 09:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722850717; cv=none; b=g7KKymwx2cfakB97EffCBckKCvLJKOYhKv2J3Okm1OcG4Y+F/j5Gs8CXNC3Ph9/hxOPxEUXqgJTKOCf1JRww3syN5FUUiv/LNy5Rn79eOLxMwGBB5oEeIdXKiRoNqPHZ0si5Wn/raGSN/zNzsnUnBLXcBoZxR/fOpOPtCHDLi6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722850717; c=relaxed/simple;
	bh=VanrcmjgxaYXK5ChUWK6OquabXhDphNQ4MS4dg5YVWU=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=n6ywLTXyOxvgwSDn7l1ix0/n+mRoUiEievW7UzOUV66HkNuEP79FhYSObShqWVbsL1ARJSl6uqwA0gnEUv2R3bIMmvc4YK1tDgLY78YD4KK298OD4ZoHT9yp1s0dGka7QdFlIqVjx9KT7KL92IEJeYbf0QEu2hF6neqsD3ecuQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=pehdjkfk; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2f16767830dso26235311fa.0
        for <linux-iio@vger.kernel.org>; Mon, 05 Aug 2024 02:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722850713; x=1723455513; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xc2/V1ma9Q8M3b2xyCs1uMw1iLPbi+N6eUPIeXJxkoI=;
        b=pehdjkfkxxd41vxMdttk95LRZtLHN634V4nO0QNa4Utejdu6hNVnx3VXQnA/UrvHHO
         LL4N5kw/csnlrwnMf+WJ8wG1k7ESOgHcIb7/EzUw5QHMElQak1jAj+ua79UYspq4jeHQ
         NgFQH1T6eQ921hw7FqC+o6hEf0tefuLJeqb4swa4VFtnSokeC3VYtjMPLW7jpSJ5CwIt
         Cs1ww9nWeMbFhBRK9wx4tLQMbXawMg3kVLkg2FQzaHAHj00dv1KBYlFP0/bTqqqPUbqr
         ZOhcoshPdHU35TnBlOHxq79/6+Dld1bRrwnQquynyuHIe9HqWrZhowBHe0R1eaMYJDlR
         tYzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722850713; x=1723455513;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Xc2/V1ma9Q8M3b2xyCs1uMw1iLPbi+N6eUPIeXJxkoI=;
        b=kLwLwzLzl3UTjScucTAG3MqEOSm/5FhkJB4UoNy5FM8gO4JD8UhjbzC91XsvEQSGBZ
         mbqycafxCq+llmhC2mC5Z5OPSiMVChM6hkxOFxLp73CgPrMfjKBiwysJgqABKjF65R8P
         h1RL+bUnHIH6fMQB7T95QltZ18FO1qotxajXpo0S5SgXuMqBM9TRWt8XQdlr/GJmdqqk
         u5gxcZ8ahEidTkeuEyOyK30QY2I1/k0PcCnhXOdSnfPyTJFBu2GVDR/vse/oIDpgh7jp
         lKKVSWkMjsuJEvfB8a0jPihDkfQNr237ZZEXykEa3RJz7DoKLfILsxswpl80BdxthcAW
         v/AA==
X-Forwarded-Encrypted: i=1; AJvYcCVyNAVHZZrp0Mwv3pLV59cIgjsHF1FfQQq/zBPKuUOpf+q877KpRW86C6mo12bai9tSzdkXhoG9MXKfuXEDNr0TcBm2fZJyDAOt
X-Gm-Message-State: AOJu0Yw1q12kknCGqqfFg/sf3Syp5zuTvuxNkDUlqTINq36Ks0gk1B9+
	PNyUtxZ7tNtMt+WIwIdHUvw7Cmr+CCKBKURHA2AtGGdH1aXJno6+b2Gna0olJA0=
X-Google-Smtp-Source: AGHT+IGgAa9dEEJ0rCBoImt6/gWqBzl7Rg5FAH2HrVxCHVBDYyTXw0l20bNko4rVGrRjg9Exe7MhgA==
X-Received: by 2002:a2e:8096:0:b0:2ef:3250:d0d4 with SMTP id 38308e7fff4ca-2f15ab5c7c8mr71161751fa.48.1722850712934;
        Mon, 05 Aug 2024 02:38:32 -0700 (PDT)
Received: from localhost ([2a01:e0a:448:76e0:ee2f:f911:fa95:ed58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428e6e7cce6sm130173755e9.31.2024.08.05.02.38.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Aug 2024 02:38:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 05 Aug 2024 11:38:31 +0200
Message-Id: <D37VLUMXTL0C.2ZECY6X14LUNU@baylibre.com>
From: "Esteban Blanc" <eblanc@baylibre.com>
To: "Jonathan Cameron" <jic23@kernel.org>, =?utf-8?q?Nuno_S=C3=A1?=
 <noname.nuno@gmail.com>
Cc: <baylibre-upstreaming@groups.io>, "Lars-Peter Clausen"
 <lars@metafoo.de>, "Michael Hennerich" <Michael.Hennerich@analog.com>, "Rob
 Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>, "Nuno Sa" <nuno.sa@analog.com>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "David Lechner" <dlechner@baylibre.com>
Subject: Re: [PATCH RFC 2/5] iio: adc: ad4030: add driver for ad4030-24
X-Mailer: aerc 0.17.0
References: <20240627-eblanc-ad4630_v1-v1-0-fdc0610c23b0@baylibre.com>
 <20240627-eblanc-ad4630_v1-v1-2-fdc0610c23b0@baylibre.com>
 <0036d44542f8cf45c91c867f0ddd7b45d1904d6b.camel@gmail.com>
 <D2ZIG2NK223D.J9VK1MWOICE3@baylibre.com>
 <ae7287257d6611ee27846643f48303c7e0dbb7ac.camel@gmail.com>
 <20240803105107.43233ae1@jic23-huawei>
In-Reply-To: <20240803105107.43233ae1@jic23-huawei>

On Sat Aug 3, 2024 at 11:51 AM CEST, Jonathan Cameron wrote:
> On Wed, 31 Jul 2024 10:56:22 +0200
> Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
>
> > On Fri, 2024-07-26 at 15:38 +0200, Esteban Blanc wrote:
> > > Hi Nuno,
> > >  =20
> > > > > +			struct {
> > > > > +				s32 val[AD4030_MAX_DIFF_CHANNEL_NB];
> > > > > +				u8 common[AD4030_MAX_COMMON_CHANNEL_NB]; =20
> > > >=20
> > > > Not sure common makes sense as it comes aggregated with the sample.=
 Maybe
> > > > this
> > > > could as simple as:
> > > >=20
> > > > struct {
> > > > 	s32 val;
> > > > 	u64 timestamp __aligned(8);
> > > > } rx_data ... =20
> > >=20
> > > See below my answer on channels order and storagebits.
> > >  =20
> > > > So, from the datasheet, figure 39 we have something like a multiple=
xer where
> > > > we
> > > > can have:
> > > >=20
> > > > - averaged data;
> > > > - normal differential;
> > > > - test pattern (btw, useful to have it in debugfs - but can come la=
ter);
> > > > - 8 common mode bits;
> > > >=20
> > > > While the average, normal and test pattern are really mutual exclus=
ive, the
> > > > common mode voltage is different in the way that it's appended to
> > > > differential
> > > > sample. Making it kind of an aggregated thingy. Thus I guess it can=
 make
> > > > sense
> > > > for us to see them as different channels from a SW perspective (eve=
n more
> > > > since
> > > > gain and offset only apply to the differential data). But there are=
 a couple
> > > > of
> > > > things I don't like (have concerns):
> > > >=20
> > > > * You're pushing the CM channels into the end. So when we a 2 chann=
el device
> > > > we'll have:
> > > >=20
> > > > =C2=A0in_voltage0 - diff
> > > > =C2=A0in_voltage1 - diff
> > > > =C2=A0in_voltage2 - CM associated with chan0
> > > > =C2=A0in_voltage0 - CM associated with chan1
> > > >=20
> > > > I think we could make it so the CM channel comes right after the ch=
annel
> > > > where
> > > > it's data belongs too. So for example, odd channels would be CM cha=
nnels
> > > > (and
> > > > labels could also make sense). =20
> > >=20
> > > I must agree with you it would make more sense.
> > >  =20
> > > > Other thing that came to mind is if we could somehow use differenti=
al =3D true
> > > > here. Having something like:
> > > >=20
> > > > in_voltage1_in_voltage0_raw - diff data
> > > > ...
> > > > And the only thing for CM would be:
> > > >=20
> > > > in_voltage1_raw
> > > > in_voltage1_scale
> > > >=20
> > > > (not sure if the above is doable with ext_info - maybe only with
> > > > device_attrs)
> > > >=20
> > > > The downside of the above is that we don't have a way to separate t=
he scan
> > > > elements. Meaning that we don't have a way to specify the scan_type=
 for both
> > > > the
> > > > common mode and differential voltage. That said, I wonder if it is =
that
> > > > useful
> > > > to buffer the common mode stuff? Alternatively, we could just have =
the
> > > > scan_type
> > > > for the diff data and apps really wanting the CM voltage could stil=
l access
> > > > the
> > > > raw data. Not pretty, I know... =20
> > >=20
> > > At the moment the way I "separate" them is by looking at the
> > > `active_scan_mask`. If the user asked for differential channel only, =
I put the
> > > chip in differential only mode. If all the channels are asked, I put
> > > the chip in differential + common mode. This way there is no need to
> > > separate anything in differential mode. See below for an example wher=
e
> > > this started.
> > >  =20
> > > > However, even if we go with the two separate channels there's one t=
hing that
> > > > concerns me. Right now we have diff data with 32 for storage bits a=
nd CM
> > > > data
> > > > with 8 storage bits which means the sample will be 40 bits and in r=
eality we
> > > > just have 32. Sure, now we have SW buffering so we can make it work=
 but the
> > > > ultimate goal is to support HW buffering where we won't be able to =
touch the
> > > > sample and thus we can't lie about the sample size. Could you run a=
ny test
> > > > with
> > > > this approach on a HW buffer setup?  =20
> > >=20
> > > Let's take AD4630-24 in diff+cm mode as an example. We would have 4 c=
hannels:
> > > - Ch0 diff with 24 bits of realbits and 24 bits of storagebits
> > > - Ch0 cm with 8 bits of realbits and 8 bits of storagebits
> > > - Ch1 diff with 24 bits of realbits and 24 bits of storagebits
> > > - Ch1 cm with 8 bits of realbits and 8 bits of storagebits
> > > ChX diff realbits + ChX cm realbits =3D 32 bits which is one sample a=
s sent
> > > by the chip.
> > >=20
> > > The problem I faced when trying to do this in this series is that IIO=
 doesn't
> > > seem to like 24 storagebits and the data would get garbled. In diff o=
nly
> > > mode with the same channel setup (selecting only Ch0 diff and Ch1 dif=
f)
> > > the data is also garbled. I used iio-oscilloscope software to test th=
is setup.
> > > Here is the output with iio_readdev:
> > > ```
> > > # iio_readdev -s 1 ad4630-24 voltage0
> > > WARNING: High-speed mode not enabled
> > > Unable to refill buffer: Invalid argument (22)
> > > ```
> > >=20
> > > I think this is happening when computing the padding to align ch1 dif=
f.
> > > In `iio_compute_scan_bytes` this line `bytes =3D ALIGN(bytes, length)=
;`
> > > will be invoked with bytes =3D 3 and length =3D 3 when selecting ch0 =
diff
> > > and ch1 diff (AD4630-24 in differential mode). The output is 5. As
> > > specified in linux/align.h: =20
> > > > @a is a power of 2 =20
> > > In our case `a` is `length`, and 3 is not a power of 2.
> > >=20
> > > It works fine with Ch0/1 diff with 24 realbits and 32 storagebits wit=
h 8
> > > bits shift. =20
> >=20
> > Yes, I do understand that and that we need a power of 2 for storage bit=
s. My
> > concern, as stated, is that if we have HW buffering (High speed enabled=
) CHO
> > will have a sample size of (with diff + cm) of 40 which is not really w=
hat comes
> > from HW. I wonder if it will work in that case. Maybe we can (as this o=
ften
> > happens on an FGPA) have the HW guys doing some data shuffling so thing=
s work in
> > the high speed mode as well.
>
> If it's possible to unscramble the data in an fpga, that would make our l=
ife easier
> though things may get messy if we get multiple versions of that and some
> unscramble, others don't.

At the moment the HDL I could test for this chip is unscrambling the
data, so there is nothing to do on the software side on that front.

Best regards,

--=20
Esteban "Skallwar" Blanc
BayLibre

