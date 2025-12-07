Return-Path: <linux-iio+bounces-26901-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC0ACAB735
	for <lists+linux-iio@lfdr.de>; Sun, 07 Dec 2025 17:02:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B87E93012249
	for <lists+linux-iio@lfdr.de>; Sun,  7 Dec 2025 16:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA952FABE7;
	Sun,  7 Dec 2025 16:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m51BFHVj"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD65B2FA0DF
	for <linux-iio@vger.kernel.org>; Sun,  7 Dec 2025 16:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765123256; cv=none; b=qs3vEdQdrl2UVG4/6STU3pFBKrlr6yuYwfxNOfn8Jes074T9REx4hUE7tsdHKYFz7rQfKFu5XseqClQDOICDOh7IIACtA7XP+yvFkfE83zc6CuHU1U/6f7bLmET2WbUSVzlx05lsL064GH6+rxA+z52WsWzm0Ah+B2t8K+xx+Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765123256; c=relaxed/simple;
	bh=ONfJbGREEVhf0xPpAs1SAV4Q3KV7qHQ5RDVEi5NK7LQ=;
	h=Content-Type:Date:Message-Id:Subject:From:To:Cc:Mime-Version:
	 References:In-Reply-To; b=PfwX5fv1/9XDJb4SNp99oteNB9yNNtEdPtlveFHCsoZJWzcA2HoB0Xs6ftdClfAnfUNOOjhftPEpNCwLEplb+VoMdgc1903AjIEDDcTuN4awA/zv8PSmHVu9VG0zAZK6+XUOGOPBhMdCWca+CyF9qN/wczsxFx2EUZzxvVRP/CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m51BFHVj; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-5dfcfbcbcc0so1305133137.2
        for <linux-iio@vger.kernel.org>; Sun, 07 Dec 2025 08:00:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765123253; x=1765728053; darn=vger.kernel.org;
        h=in-reply-to:references:mime-version:content-transfer-encoding:cc:to
         :from:subject:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C05hxMdhSejZs7B3U82wBg7N+6ftUEeKG49qP2la0+o=;
        b=m51BFHVjcxWxxWaWXE9VNwsmrJ0XOXnd4K/UBmyvijA8Syk7SA3sp8e9C8f14tkAPF
         zWcf9N29RsgE3aP8dJipjLImg807++3pmk503XBEIKBi6JV7dmcUf/1i2w2zB/6HDVGo
         0bxOid7eJgCu30m0EZ74mmSGMKdWYTFF/6xR1zMvf7YhFqejQFKIn+4VgmN6cKhc/EdC
         BuqKg+zXEUZMHUHRKXAN3U+MHM+CmkxS5LM4jdm/BpF98JY+mv3+FARdZcWlLAXmyS+8
         ESedRyP0IK6Gt6iUH8HHYrmZwzjTIkYIyCli3jElMwMYnGFM4kH9DP0JjIaFi1JloOLv
         yBUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765123253; x=1765728053;
        h=in-reply-to:references:mime-version:content-transfer-encoding:cc:to
         :from:subject:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C05hxMdhSejZs7B3U82wBg7N+6ftUEeKG49qP2la0+o=;
        b=NT54/UHFTgkfiIg1zelOFnizHjL+lCpHVZrU0aWxXpJNXaQ6GZnc7dkykEFjoo46d0
         PNteaHakUshRiVRvfA+TPe2aeqMFlMqNc7MC9khnThoG39HI2Q7aQVJ6x/p4pnyyE6Re
         FwOzbSe6qiUdE+3WrjjPh1/bbL/nKitJztNqsFWceQPCXKGsnqK7LQ4j3uQ0cIzi9JiN
         H36KhdBNCBuw1GyqAEh/HFEdw/vWngQ6e+VF6w1uIq4dHNPdx6tVeECwywtKuwDXUB0k
         6ETIkZyAs/rK4DGkEm3WG+RpzX1lPfHW5qKiHCgAS1mm6mvrPcC34ujLUg2+WHbMCY2L
         1K5w==
X-Forwarded-Encrypted: i=1; AJvYcCUESnNHssQBg8xgGlyaNIHQW4HyWjIAt9vmdGrdtZpHEKJjMuTw8XBO+KITywte72OPFqU2C1Jnznc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYrdtMfDdYsh7A2BXJWeU24gKvjjgR7/UETxdfOEF7A9qGhzQh
	LIdwtqP65qxfBrXN8q98un+2OJEbiHy2s/3Tnf/MeeMcH6SLV5OtK5uR
X-Gm-Gg: ASbGncvYhFrKTP/3cvCEFyohU1+sxNPxQYdceKMm//VGfbfoRZgX0O5PmF1UMQGx8mg
	daDNRzhDhXGD7CKvEu81Al80gMZ605ys22LlnmXDKsLFBh/w35Zode0qL18J87C8aQcVZWCvxJO
	mq/Ul5RIwXICywveIR8LxXkgSJYAFmQPHKagtg+9p4KCxMdN9obmYy/dKLSx/Z7TeqiDzEeVvOd
	1z03Zd6pJNGImSlSUNdRxx8r/3VbVE844dYFU/qCJW8cPqKNYGVZdJEms4bQjien3iC43EF0jrp
	zlnZXQt/kLGuwkPSQwmXFz5j925oo1V/Pwlkj572B29O+gCM/7pVqGHjXShhRghIf81nNhMJb/5
	L1cWsH/OnkkFYR73e0UR8H3Jg700RMfcN78fNuo0PV+Co2DhZtlyvvjd2J1CVuz3HMIOG5Qnk/D
	XzfhTtZMfTX95ujQ==
X-Google-Smtp-Source: AGHT+IFvMMi8SeriD8ofLkkikPJ/IRwJH9eX2CR7z1bizsi4e0heB2zUKTRYwSBWyo5tPo+Bc0Pzbw==
X-Received: by 2002:a05:6102:f93:b0:5db:3bbf:8e62 with SMTP id ada2fe7eead31-5e52c96d23cmr1323197137.1.1765123253190;
        Sun, 07 Dec 2025 08:00:53 -0800 (PST)
Received: from localhost ([2800:bf0:82:3d2:875c:6c76:e06b:3095])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5e510cd624csm4396150137.13.2025.12.07.08.00.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Dec 2025 08:00:52 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Sun, 07 Dec 2025 11:00:50 -0500
Message-Id: <DES3YYXIH4ML.1K5X4KDG273HD@gmail.com>
Subject: Re: [PATCH RFC 0/6] iio: core: Introduce cleanup.h support for mode
 locks
From: "Kurt Borja" <kuurtb@gmail.com>
To: "Jonathan Cameron" <jic23@kernel.org>, "Andy Shevchenko"
 <andy.shevchenko@gmail.com>
Cc: =?utf-8?q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>, "Kurt Borja"
 <kuurtb@gmail.com>, "Andy Shevchenko" <andriy.shevchenko@intel.com>,
 "Lars-Peter Clausen" <lars@metafoo.de>, "Michael Hennerich"
 <Michael.Hennerich@analog.com>, "Benson Leung" <bleung@chromium.org>,
 "Antoniu Miclaus" <antoniu.miclaus@analog.com>, "Gwendal Grignou"
 <gwendal@chromium.org>, "Shrikant Raskar" <raskar.shree97@gmail.com>,
 "Per-Daniel Olsson" <perdaniel.olsson@axis.com>, "David Lechner"
 <dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 "Andy Shevchenko" <andy@kernel.org>, "Guenter Roeck" <groeck@chromium.org>,
 "Jonathan Cameron" <Jonathan.Cameron@huawei.com>,
 <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <chrome-platform@lists.linux.dev>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251203-lock-impr-v1-0-b4a1fd639423@gmail.com>
 <77ca77847511e67066a150096a7af2fb84f1f25f.camel@gmail.com>
 <CAHp75VdNjqZdy0+aSbBzn9CwEwHUhjwED+KRVqkdOMc_N+nX9w@mail.gmail.com>
 <20251206184645.51099254@jic23-huawei>
In-Reply-To: <20251206184645.51099254@jic23-huawei>

On Sat Dec 6, 2025 at 1:46 PM -05, Jonathan Cameron wrote:
> On Thu, 4 Dec 2025 17:07:28 +0200
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>
>> On Thu, Dec 4, 2025 at 4:35=E2=80=AFPM Nuno S=C3=A1 <noname.nuno@gmail.c=
om> wrote:
>> > On Wed, 2025-12-03 at 14:18 -0500, Kurt Borja wrote: =20
>> > >
>> > > In a recent driver review discussion [1], Andy Shevchenko suggested =
we
>> > > add cleanup.h support for the lock API:
>> > >
>> > >       iio_device_claim_{direct,buffer_mode}(). =20
>> >
>> > We already went this patch and then reverted it. I guess before we did=
 not had
>> > ACQUIRE() and ACQUIRE_ERR() but I'm not sure that makes it much better=
. Looking at the
>> > last two patches on how we are handling the buffer mode stuff, I'm rea=
lly not convinced...
>> >
>> > Also, I have doubts sparse can keep up with the __cleanup stuff so I'm=
 not sure the
>> > annotations much make sense if we go down this path. Unless we want to=
 use both
>> > approaches which is also questionable. =20
>>=20
>> This, indeed, needs a (broader) discussion and I appreciate that Kurt
>> sent this RFC. Jonathan, what's your thoughts?
>
> I was pretty heavily involved in discussions around ACQUIRE() and it's us=
e
> in CXL and runtime PM (though that's still evolving with Rafael trying
> to improve the syntax a little).  As you might guess I did have this use
> in mind during those discussions.
>
> As far as I know by avoiding the for loop complexity of the previous
> try we made and looking (under the hood) like guard() it should be much
> easier and safer to use.  Looking at this was on my list, so I'm very hap=
py
> to see this series from Kurt exploring how it would be done.
>
> Sparse wise there is no support for now for any of the cleanup.h magic
> other than ignoring it.  That doesn't bother me that much though as these
> macros create more or less hidden local variables that are hard to mess
> with in incorrect ways.
>
> So in general I'm very much in favour of this for same reasons I jumped
> in last time (which turned out to be premature!)
>
> This will be particularly useful in avoiding the need for helper function=
s
> in otherwise simple code flows.

Good to hear!

Next version, after we agree on the naming approach, I'll drop the RFC
and thake all suggestions for the next version.

Thank you all for your suggestions and comments :)

>
> Jonathan


--=20
 ~ Kurt


