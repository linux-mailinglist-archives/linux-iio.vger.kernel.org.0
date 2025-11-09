Return-Path: <linux-iio+bounces-26101-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC34C442F8
	for <lists+linux-iio@lfdr.de>; Sun, 09 Nov 2025 18:00:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E62263B0E03
	for <lists+linux-iio@lfdr.de>; Sun,  9 Nov 2025 17:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C4F2F6912;
	Sun,  9 Nov 2025 17:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EIgjYpcz"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856B734D3A9;
	Sun,  9 Nov 2025 17:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762707640; cv=none; b=PCDk0dg7t0+9bQfzZGb5Zh9JGpKBNcj9cp1U7inU9Moltx1b94847FJ8RXfu1dGsVJCeBYaqoe6/rasX/8QoT0eL0PoH07s4/lHZu8HoFTGztlVaFH592JEyg+HDwG5pUYC9TbHUjlgY/525Qqa4+oXl2YKgsmCEl7OX9on+Xvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762707640; c=relaxed/simple;
	bh=/YTzYEC+/7A1yssydEpBLvFuXa5TokqzNj5SqgQkNMo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oIv5S8/2dbDNdhLBbw8HqTwQ5CGgrs7jWfNcyvQn0pjwb+JNB3QN7IaYkI30h+7asa2EchUyADDh2j1AckswVU0/580xuhWeeUBU6fUGMRKAD6x3GACkMSc4FSceKeAbxrftTVr8jhlly5EcwMaP1Tc1ZJFLIoNeX4JxIC4iRH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EIgjYpcz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B82FC4CEF7;
	Sun,  9 Nov 2025 17:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762707640;
	bh=/YTzYEC+/7A1yssydEpBLvFuXa5TokqzNj5SqgQkNMo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EIgjYpczUOJ/qkpiyiaObxa/4HwzMUGSj/DKg/EDJY1bXoIX3RaGcEIACjwzpLhDU
	 OO+QHIEIaLofhMLq2t4CS3ec98r6oyFiOEjSIC3z1KAThmfRyJLWcDNre7NGFWCGVA
	 e1NJ2Y3/C+HueHWreW0A6XfygPU76invrZXlXEc7OO1oMicZsLP14Z94fxKDyo/nLU
	 hkYFboDAHp32P2w3BaLCM4MOi2C3vpMQF9+t783kIgTnSC52fong2/QUEF15oKLWQ0
	 9yyUDa9OvYsw0py629P+lAxAAwfF8WfnVAnFZ6Hnycns9D1oW85mremLgPymNpVtTc
	 sW0bzB5r9W43w==
Date: Sun, 9 Nov 2025 17:00:32 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Hans Verkuil
 <hverkuil+cisco@kernel.org>, "linux-iio@vger.kernel.org"
 <linux-iio@vger.kernel.org>, "chrome-platform@lists.linux.dev"
 <chrome-platform@lists.linux.dev>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-media@vger.kernel.org"
 <linux-media@vger.kernel.org>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Benson Leung <bleung@chromium.org>,
 Guenter Roeck <groeck@chromium.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
Subject: Re: [PATCH v2 2/6] units: Add 32- and 64-bit signed values of
 =?UTF-8?B?z4A=?=
Message-ID: <20251109170032.2763ae5b@jic23-huawei>
In-Reply-To: <CAHp75VexvdYyjt1GkbfqOotkFpLeb=io6outJ5dpRqBv2qPNng@mail.gmail.com>
References: <20251107201005.3156118-1-andriy.shevchenko@linux.intel.com>
	<20251107201005.3156118-3-andriy.shevchenko@linux.intel.com>
	<fb4aafc1-dbfb-4533-b368-5d26e24acdf1@baylibre.com>
	<CAHp75VexvdYyjt1GkbfqOotkFpLeb=io6outJ5dpRqBv2qPNng@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 8 Nov 2025 21:02:54 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> =D0=BF=CA=BC=D1=8F=D1=82=D0=BD=D0=B8=D1=86=D1=8F, 7 =D0=BB=D0=B8=D1=81=D1=
=82=D0=BE=D0=BF=D0=B0=D0=B4=D0=B0 2025=E2=80=AF=D1=80. David Lechner <dlech=
ner@baylibre.com> =D0=BF=D0=B8=D1=88=D0=B5:
>=20
> > On 11/7/25 2:03 PM, Andy Shevchenko wrote: =20
> > > There are a few drivers that want to have these values, and
> > > one more known to come soon. Let's define the values for them.
> > > =20
>=20
>=20
>=20
>=20
>=20
> > > @@ -21,6 +21,12 @@
> > >  #define PICO 1000000000000ULL
> > >  #define FEMTO        1000000000000000ULL
> > >
> > > +/* Value of =CF=80 * 10=E2=81=B8 (fits s32 or signed int) */
> > > +#define PI   314159265 =20
> >
> > It isn't clear to me at all in the other patches that e.g.
> > DIV_ROUND_UP(PI, 1000) would be =CF=80 =E2=9C=95 10=E2=81=B4 (rounded t=
o nearest
> > integer, of course).
> >
> > Calling these PI_E8 and PI_E18 or PI_x10_8 and PI_x10_18
> > would help to clear that up. =20
>=20
>=20
>=20
> This will be an awful and ugly name(s). I fully disagree on such a
> proposal. The power is chosen to fit the type with maximum precision, no
> need to explain this in the name.
With no indicate of the multiplier we have to check it every time wwe
use it which isn't ideal either.

So I agree with David that we have to indicate this somewhere. Maybe hold t=
he
multiplier in a separate define
#define PI_MUL
#define PI_MUL_LL

Then compute the divisions by (PI_MUL) / KILO or something along those line=
s?
>=20
> > =20
> > > +
> > > +/* Value of =CF=80 * 10=C2=B9=E2=81=B8 (fits s64 or signed long long=
) */
> > > +#define PI_LL        3141592653589793238LL
> > > +
> > >  /* Hz based multipliers */
> > >  #define NANOHZ_PER_HZ                1000000000UL
> > >  #define MICROHZ_PER_HZ               1000000UL =20
> >
> > =20


