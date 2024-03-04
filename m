Return-Path: <linux-iio+bounces-3308-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B647A86FCED
	for <lists+linux-iio@lfdr.de>; Mon,  4 Mar 2024 10:16:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA3821C20E06
	for <lists+linux-iio@lfdr.de>; Mon,  4 Mar 2024 09:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A2E1BDD9;
	Mon,  4 Mar 2024 09:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iLLQ/xCv"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC641AAD8
	for <linux-iio@vger.kernel.org>; Mon,  4 Mar 2024 09:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709543793; cv=none; b=hH9XMRQSVfaFi0YzKrueWBfJiWZ8F5xUYGXLgnEpSd8ml0P/H7THuHlJx+I1KF+p/Va85y4qwuKPDN1DVjh4WPNiUekaEh1fVkf2zOJg+Ex9no4FpyL/mz3/trIjB1PrHeolpuJ78ONmTTpPkjmRWJHf91826SuEIbvURfbOGB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709543793; c=relaxed/simple;
	bh=8ehM2tHyV3KaIVJ+6/RnZbJFiHEQSjmxSG2WSvtlouA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=imK6f5y+4Aa56b4INf09bJ2byqL5vwfZMaPfJ38/Skm7zEI/neVrBkTLSE9XfDOZ1QctXEOaaeHToHPXYChe4XzyJP7HKni3tgQQeVS3yru95+1kQAyjr/xRbtxnCbdCRNYME0xGueHXlKUtS1Uc1HghLZBtsrQ9ibOnUvqRDog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iLLQ/xCv; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a45811c10f8so9815866b.2
        for <linux-iio@vger.kernel.org>; Mon, 04 Mar 2024 01:16:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709543790; x=1710148590; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8ehM2tHyV3KaIVJ+6/RnZbJFiHEQSjmxSG2WSvtlouA=;
        b=iLLQ/xCvPqnAM4F3sjktoQGOdLROXrNQW+j1DNX/caiEZwODJ0uOTV9avSh1A2uOiE
         7MWdlV5PkaGt4qqzfyEAUuAo+JC3LuotxQdzmRkUy0o5QZ4FTNxRGJqGAmW5aO7YSsdE
         BFgK9p/H6FWzXeOPvguKoCQjBAqb2aEIUKb1qEF/gMRUR9BaKuBpGUWo3PInJ5oFQZLf
         r+UU09+YjyJCB6OXJeLL0wIYJxGvrTrkW/OyJH6TU9KbxZ1B5g6af1Bu+rthW0TWk/gx
         Rj+13ZPibxAwgo6JfhwwwDg76ZZcUBVxkNz4eWtoqslf3eSJaQvSi0TlznUSkqYUkFYV
         XCxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709543790; x=1710148590;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8ehM2tHyV3KaIVJ+6/RnZbJFiHEQSjmxSG2WSvtlouA=;
        b=d9mELpnpQ2lymjGADnd5t4Caer8C1VdR6c9orZ7UZyYzorqnnLKHR6XaS3/t7LWD7t
         syLmQaeWuqXKM62YR8eIc/4EPViP6l/yi85GzGdguVfsOU+vKgDblsOG/23A0XIAjsiT
         p6B2LmnHL5DOKD7pAQyUbltmdywj0r2Fqw/m++4WEU7pIbLWfubJ7yXq66b2BgGd6Vnk
         rbCx6eZVVGiQuSUfOylNyzinnlNIq0atAiEZgbjjkB02ZrCCYxptqB6XleGyhZF/uffG
         zHUxWN5MX7OyRmWiH7kayYX4Xtb4wWsCnUMm069AFLwi8ByZGqHgYRrhgcGDaxXAzT1x
         DSWg==
X-Forwarded-Encrypted: i=1; AJvYcCWyv1cT8OraDGHlMjqtASSp9zWXYZqlPDRMSSvbu07nvgT/mzN8OKxa2TB75iCHIHpJL5+TrJZP0qd/5BzKqxmZ2z6gtn+AP1lw
X-Gm-Message-State: AOJu0Yxxvmnf3XH5gVa66sEtHKWT0NtmYgbyIvV5dALOADDgog/VsHAt
	4DFDkt6w5zwh+wnPs8m8seJvGzgKWJfR6Ey4foYSZiN72oUOa8Ao
X-Google-Smtp-Source: AGHT+IEUj9holAxhXcKEPVR/KuU+Q2Dlnvo7C4wCRlAJfGiTqwGbIpIO+ks0qH4d87LAzYMaKanqHQ==
X-Received: by 2002:a17:906:3d3:b0:a3d:482f:3fc4 with SMTP id c19-20020a17090603d300b00a3d482f3fc4mr5248841eja.70.1709543790015;
        Mon, 04 Mar 2024 01:16:30 -0800 (PST)
Received: from ?IPv6:2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47? (p200300f6ef1b2000944ccbc71e1c2c47.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47])
        by smtp.gmail.com with ESMTPSA id mb17-20020a170906eb1100b00a4490267ecfsm3420795ejb.221.2024.03.04.01.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 01:16:29 -0800 (PST)
Message-ID: <3a2d5d45e18b32e8db118f7d4ec4549446b02d81.camel@gmail.com>
Subject: Re: [PATCH RFC 0/8] iio: dac: support IIO backends on the output
 direction
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, Nuno Sa via B4 Relay
	 <devnull+nuno.sa.analog.com@kernel.org>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org, Lars-Peter Clausen
 <lars@metafoo.de>, Olivier Moysan <olivier.moysan@foss.st.com>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Paul Cercueil
 <paul@crapouillou.net>, Alexandru Ardelean <ardeleanalex@gmail.com>
Date: Mon, 04 Mar 2024 10:19:54 +0100
In-Reply-To: <20240303182538.36cb2318@jic23-huawei>
References: <20240216-iio-backend-axi-dds-v1-0-22aed9fb07a1@analog.com>
	 <20240303182538.36cb2318@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2024-03-03 at 18:25 +0000, Jonathan Cameron wrote:
> On Fri, 16 Feb 2024 15:10:49 +0100
> Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:
>=20
> > Hi all,
> >=20
> My first comment here isn't don't worry too much about getting it
> perfectly correct from the start.=C2=A0 Until you have half a dozen or mo=
re
> drivers using this stuff you won't have seen enough to
> get generalizations right.=C2=A0 As this stuff is all in kernel and not
> exposed to userspace, that isn't a problem.=C2=A0 We can evolve and
> improve this as we go along.=C2=A0 Userspace ABI design is much worse
> as you are stuck with your errors for ever (so never finalize that until
> you have a good number of drivers to try it with!)
>=20

Agreed. I just felt this is something that I would like some more opinions =
on as
then it is slightly more likely to get it better (not right :)) from the
beginning.

> > This RFC is mainly because I'm not getting extremely happy with the
> > direction of the API in the series. So I think it's better to have the
> > discussion now so the actual series will look better. Also note that pa=
tch
> > 2 to 5 are brought from Paul's series to bring output buffer support to
> > DMA buffers [1].
> >=20
> > So, the main API I'm speaking about is:
> > =C2=A0- iio_backend_read_phase()
> > =C2=A0- iio_backend_write_phase()
> > =C2=A0- iio_backend_read_scale()
> > =C2=A0- iio_backend_write_scale()
> > =C2=A0- iio_backend_read_frequency()
> > =C2=A0- iio_backend_write_frequency()
> >=20
> > All the above is basically ABI/attributes that belong and are supported
> > by the AXI_DAC IP core. The main things I dislike are:
> > =C2=A0* The sample_freq and tone_id in iio_backend_read|write_frequency=
().
> > =C2=A0=C2=A0 The API (like the others) should resemble the IIO read|wri=
te_raw()
> > =C2=A0=C2=A0 API and even though multiple tone waves is not something u=
nusual, it
> > =C2=A0=C2=A0 would be better to keep it local to the core. The sample_f=
req is not
> > =C2=A0=C2=A0 that bad as we can eliminate it by having a new op for set=
ting the
> > =C2=A0=C2=A0 sample_frquency.
>=20
> One of the gaps in the IIO core has always been handling multiples of the
> same attribute of a channel.=C2=A0 Sounds like this is one of those.
> We never really came up with a good solution for it there so I'm not
> surprised it's causing you pain as well.

I did briefly thought on supporting it at the chan_spec level.
>=20
> I'm not certain what tone ID actually is though. Some mode in which the
> FPGA is generating a fixed tone, or modulating between several rather
> than streaming from the DMA buffer?=C2=A0 Or something entirely different=
?
> (I had a google and found an ADI AXI core where it seems this is a DDS
> =C2=A0feature, so fsk modulation?)

Maybe it's poor naming (at least the ID part). This basically enables you t=
o
have two frequencies (in theory you can have more but the core only support=
s
two) in your sine wave (two tones if you think FFT). So the ABI I have (a b=
it
inspired on the ltc2688 toggle stuff where we have raw0 and raw1) is:

out_altvoltage0_frequency0
out_altvoltage0_frequency1
out_altvoltage0_scale0
out_altvoltage0_scale1
out_altvoltage0_phase0
out_altvoltage0_phase1

>=20
>=20
> I know a little on highspeed ADCs, my DAC knowledge is much more limited
> so you may need to provide more background or some reference links.
>=20
> > =C2=A0* Code duplication. Any DAC using the AXI_DAC=C2=A0 backend will =
have to define
> > =C2=A0=C2=A0 that extended_info.
>=20
> Can't it stub it out cleanly?

Maybe. But I definitely want to avoid to have backend headers in frontend c=
ode
and would also like to not "pollute" much the generic backend.h header with
specific bits from different backends. The last part, I guess we'll have
something eventually but the less the better :).

But maybe we can something without any of the above...

>=20
> >=20
> > One idea that I had was to allow to get IIO channels from the backend
> > but I then quickly started to dislike it because it would open a lot of
> > complexity. I mean, if we allow backends to define whatever they
> > want, that might quickly get nasty.
> >=20
> > I guess the above comes from (maybe naive) this idea that we should be
> > capable to replace a backend and the IIO frontend should still work
> > without any change to the code. But given how the backends are tightly
> > coupled to the frontend (at least on ADI usecases) I think that
> > changing the backend is a very unlikely usecase. And if it happens it
> > definitely means different HW and userspace ABI so devicetree might mak=
e
> > sense (maybe even a new compatible).
>=20
> It's a dream we should strive for, but until we actually have multiple
> backend implementations for a given front end it's going to be tricky.
> + I'd still expect some info transfer along the lines of 'use options
> a, b, c' to be passed to the frontend.
>=20

Agreed!

> >=20
> > So yes, I think it's definitely possible to have something generic wher=
e
> > the backend could completely define a channel (even had some ideas) but
> > I think the complexity it would bring is just not worth it
> > (at least right now).=20
>=20
> Agreed.
>=20
> >=20
> > However, another idea that started to grow (that maybe is not that bad)
> > is that the IIO frontend would still define how many channels, the
> > channel type, which channel is buffered, etc... but allowing the backen=
ds
> > to extend a certain channel (the backend would be given the channel typ=
e
> > and it could then decide if it can or cannot extend it). We should be
> > careful with what we allow to extend though... For instance, in this ca=
se,
> > allowing to extend extended_info is likely not that bad because it's
> > a fairly self contained thing.
>=20
> An example that might make sense is filtering. More than possible the
> backend would do controllable digital filtering, or indeed the related
> option of oversampling and averaging.

We do have a use case for interpolation. And that one will be a funny one t=
o
bring upstream since it will effectively turn the axi_dac both a frontend a=
nd a
backend (the interpolation core sits being the DAC core). But that's a stor=
y for
another day :)

>=20
> This is definitely plausible.=C2=A0 I'd not worry about limiting what the=
 backend
> can in theory modify that much, in practice I'd expect it to remain sane
> and if it becomes a problem the front end can take a look at the result
> and reject things it doesn't like.

I did had an implementation where the extended_info was gotten from the bac=
kend
so I may give that a try in the actual series. So we can compare the outcom=
e to
this RFC and make a decision.=C2=A0

Regarding what the backend can modify, I agree with what you just said and =
if we
do notice some common rejection pattern in the future, we can always move i=
t
into the core code.

- Nuno S=C3=A1


