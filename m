Return-Path: <linux-iio+bounces-27824-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C96AD24608
	for <lists+linux-iio@lfdr.de>; Thu, 15 Jan 2026 13:04:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ED0D43049199
	for <lists+linux-iio@lfdr.de>; Thu, 15 Jan 2026 12:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A57E938A715;
	Thu, 15 Jan 2026 12:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J4BZ5x1R"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07442361DA9
	for <linux-iio@vger.kernel.org>; Thu, 15 Jan 2026 12:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768478638; cv=none; b=VaAaI1SYiO7hi0dROSOneTvd4fwykDwW+kPNFEVU1rHLspO19L6xbJQCI99RCNSHwreSB1YskLT6gTX4U6gKz7PWR0ClhH8fuR5wJ8zJFsL025Jka1v94viVbBtaZSld5LiwDPh2q14mcF8ui0RVTZFOtlgBsUCEMfEQwqDtMJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768478638; c=relaxed/simple;
	bh=v3RvmxHVsO2ozpqio30cO7yMCQjGcC9YRe8I4rw9Q3M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dWpSYRGA3f38hlIxuWfguRvOxhh9breovOmlcXFz9j5koI4MNHuTUhzdnVIaI6oWl/yigNfxw6WlPKaEIXceNSzQbinctO8XVCjwio4PzyFCCbSjbShJK9KttsP9d895IYWY+tIaaUAPla6rZuH985n0KDtQtnBVp7wg6UaVlL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J4BZ5x1R; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4801d24d91bso1288415e9.2
        for <linux-iio@vger.kernel.org>; Thu, 15 Jan 2026 04:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768478635; x=1769083435; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=v3RvmxHVsO2ozpqio30cO7yMCQjGcC9YRe8I4rw9Q3M=;
        b=J4BZ5x1RzIwKvyf2JPk7mUyKX1TFOcU7KwGFJktChruy1pxKTC5fHnxC2mp19375av
         LeGY6Y5dHAmLieUdvW5h8P6ll7y0+uUwe+RcN+2BGEZx3/VyJOCHjSaYuUMNzZq0jY7x
         FKsVc/AGyZayH1voYicnEAj3MWVCOAYWBvbWFImaJ/VJuglfHd6jL1KxTxEobs5/9m2M
         6CTL/0A/XND8d6TWJYRSFCPDcS3/KK3YjWfiRgq+KSzBK4NJzCV5YYzUfC9jwGIrmaS8
         Jocxml9VmPGMYGjAjf98n+lqolBy1raB0PqTmgEvy5J/2QW4pIiPE2WhnUMDQbFYPclf
         /aig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768478635; x=1769083435;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v3RvmxHVsO2ozpqio30cO7yMCQjGcC9YRe8I4rw9Q3M=;
        b=mMZgq+AhH9xJD4q90Ddt0FtGQB2wxYwM7XPBzbgsAylHHF/1vRrLkJWEEaWRkLmODR
         /lRsbxqodiPh5uWzBMnDHgkA/wCSS4OGqKiP5iV1T9bLj/r33cfvxeFm0N9nX5HwsRZv
         eQLk4R/LznWwptcGnimw68d7SYlDLKaH0NKPPArfSqGua9JlGiqHKruCvjMoWv5UEr8m
         jLKXl1nEfpF92gXyBBnCGWOCByfDR+yHc8+sKd984AA8R/d/VnecyFilVRHm1wcdpmrm
         4cyrOfEe+XlVJmrjs51+Dt1EbldxNgYfQ29DSbz+mzniMusa4+amJ+VvFVwQGN7SDbbT
         nnFQ==
X-Gm-Message-State: AOJu0Yygww7KuJkN00dKz7mgT1OhGvgkbhcg2awOeRZeYx4hOpThJ323
	HpVIf/Log2qUK0oL3ZWRufzc7xpWUCFIBCU9fJtB5pA2b/0pcGLQsFSj08ni1Q==
X-Gm-Gg: AY/fxX60nh6CQBjfx6sQDxtjtOs0M37SJoeJLCDcxkFux8ZeWNrQ86ORR+Q0cNscJQl
	P5cd9Xqr4cueCJZLnnS/j+NFVbvHk32F5vbGpkqC48JsI0dv64bcq1Ox/DaygE+o7OtQm5oFM27
	WrSWRApVj1Ipej5uizJI0Ufa9vyZrZLSO5ooMwKRklfreyknLFHdGvkIhTnX5nSGbH4h34t3+Ug
	RG+0ij04qwdUx9fhlCzJGZ1CgEYDMfZPicEbLEXA785CJGF1r+CrBpCptxRKByEZBiXXFXDpw6l
	T+f3a+AqHFaWSON6iCBqKIO4Y//6EYcMn6bJTU+kIzqf93pJ5YBTLKE2DCScc2ELVcCATfXy/5x
	AQvLSmkhBUUP16Bu0w7nYQIE+/1P9/QW4F15pO7/WpCt4aiZWgI8yCw8L5GA/frbtjouw6qzFJS
	p0+Rk4gCsF5XYEPYVwxng=
X-Received: by 2002:a05:600c:a03:b0:46e:761b:e7ff with SMTP id 5b1f17b1804b1-47ee3373036mr66744745e9.28.1768478635204;
        Thu, 15 Jan 2026 04:03:55 -0800 (PST)
Received: from [192.168.1.187] ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-434af6d90aasm5428219f8f.29.2026.01.15.04.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 04:03:54 -0800 (PST)
Message-ID: <5896ab55e0d23d235908f9f592c8a7975428dc54.camel@gmail.com>
Subject: Re: [PATCH v3 0/4] iio: adc: ad9467: Support alternative backends
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Tomas Melin <tomas.melin@vaisala.com>, Michael Hennerich	
 <Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>, Lars-Peter
 Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>, David
 Lechner	 <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>,
 Olivier Moysan	 <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 15 Jan 2026 12:04:37 +0000
In-Reply-To: <7ac7033a-2273-4556-a605-1ea0200665a9@vaisala.com>
References: 
	<20260114-b4-ad9467-optional-backend-v3-0-d2c84979d010@vaisala.com>
	 <0ad12e16e3fffb4b72a460d7f2b2e627a781b93b.camel@gmail.com>
	 <7ac7033a-2273-4556-a605-1ea0200665a9@vaisala.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-01-14 at 17:32 +0200, Tomas Melin wrote:
> Hi Nuno,
>=20
> On 14/01/2026 15:32, Nuno S=C3=A1 wrote:
> > On Wed, 2026-01-14 at 10:45 +0000, Tomas Melin wrote:
> > > To facilitate backends with different set of features, add support
> > > for defining capabilites provided by the backend. These capabilites
> > > typically extend beyond a single operation and are therefore not
> > > directly linked to if a single function call is implemented or not.
> > > Furthermore, the capabilites determine if a certain set of operations
> > > should be attempted, or skipped by the frontend. This way
> > > the frontend driver can work with a minimalistic set of features and
> > > still have the device in fully functional state.
> > >=20
> > > Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>
> > > ---
> >=20
> > Hi Tomas,
> >=20
> > > Changes in v3:
> > > - Reduce set of capabilities to only include calibration. The other
> > > =C2=A0 ones propsed in V2 can be seen as subset of calibration, or si=
ngle
> > > =C2=A0 operation failing with opnotsupported
> >=20
> > As stated in my patch comment. Using opnotsupported for buffers defeats
> > the CAPS idea.
> Please check my other reply, to me adding cap for a 1:1 mapping of a
> operation seems like duplicating the information. But of course, this
> can be viewed from different angles and it is also possible to look at
> it like that.
>=20
> >=20
> >=20
> > But more importantly, how are your usecase supposed to work with this
> > series? I'm not seeing any new backend being added as part of the serie=
s.
> > Point is, if we are adding all of this, I would expect your usecase to
> > have fully upstream support. If I'm not missing nothing, we would at le=
ast
> > need a dummy backend providing stubs for enable()/disable()
> My usecase adds simplistic backend support and registers to the
> framework via an related driver. So that use case works with that
> approach. I think it is better to assume there is always some entity
> that can take on the role of being backend, rather than adding a dummy
> backend. Adding the capabilities are defining role here, as having that

Well, I would argue your backend is exactly that. A dummy one :)

> allows for customer integrations with backends that differ but are of no
> interest for the mainline.
>=20

It would still be nice to have this usecase fully supported upstream=C2=A0
(having a black box backend).=C2=A0

What I have in mind would be really to do the same as regulators do. If you=
 call
regulator_get() then the consumer really assumes a regulator must exist. Bu=
t if it
is something the kernel does not control we get a dummy one with very limit=
ed
functionality/stubs. If you call regulator_get_optional(), then the regulat=
or is
really optional and might not physically exist. Seems very similar to what =
you have.

- Nuno S=C3=A1

