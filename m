Return-Path: <linux-iio+bounces-16868-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E01A630F8
	for <lists+linux-iio@lfdr.de>; Sat, 15 Mar 2025 18:48:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01C9518971A2
	for <lists+linux-iio@lfdr.de>; Sat, 15 Mar 2025 17:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 864E21F8AE5;
	Sat, 15 Mar 2025 17:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oE4kavjt"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DCD18DB14;
	Sat, 15 Mar 2025 17:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742060877; cv=none; b=jiFWAnzfj3NMRbeHUW1rVaHas4BVtPEeylaYZC3Bzx97kQ3Zf1EbsD4SgrOV1r5Oer+Ld+ZJH6I4AoFPMiXR4cNHBsiqaGh/OOqX43kVJDpWUGP04JvJ8qDSepYiuW3w+JEq5GkzkPNZgAig0Ii9wGK8nqL9Qjj8ScnnEYpNZrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742060877; c=relaxed/simple;
	bh=5JcVLbTAfvdAAzD+f9XCdLsTARviBsr51NEvF2ZBT4w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fn2DYYm2VY3rEN02o3N1oncrDwHvwdSHznBvG3wr4yv0HTVwNQbZlEeJD81GtRkrT+n/ar//nSxAUvd767E+cnxTDV7WT0mMk38T7mo0lPOOFmFfu/nF4UcdzgaWknPGTYT9pVzC7Sem6Rgu+PvMrIJvBHRIVTgwYRQ/OVhRVT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oE4kavjt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4518DC4CEE5;
	Sat, 15 Mar 2025 17:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742060876;
	bh=5JcVLbTAfvdAAzD+f9XCdLsTARviBsr51NEvF2ZBT4w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oE4kavjtxZGhFWL+eth3gk0lSDDcMRwwgBvIzctVbLo0hOU/j7GiaY1X3XXoYjDp/
	 l9bhDePHbBDp40JvXM6lkSfkK13E78RVrI8rWqAo8kzrnOJH1NM+Wh4WKwiM1l/dyZ
	 pwwdlCnRZAWAr/i+FfElU4uFUK4UhLfiXP2eMCQs4t2JiA3aFYhksl2IR/nDU7Z9W7
	 MhWcpkI0R2yQITRbYgREW23IW5OX9xHyEqdpCUFRXvK52sOTWcfNLIihN0PZMjVq02
	 NGjuhKTBBeRrNWT4/dr9RYGajd/fg56ePY5Kq7T/1G+ueo0AsUoFK1ZKfzJO/3X8dn
	 ahauXHmEU5SgQ==
Date: Sat, 15 Mar 2025 17:47:49 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v3 11/15] iio: accel: adxl345: add g-range configuration
Message-ID: <20250315174749.179f4033@jic23-huawei>
In-Reply-To: <CAFXKEHYNAL2vRgBo6H8JRHemvGj2vT30y01T_0-jhY-hkumyMA@mail.gmail.com>
References: <20250220104234.40958-1-l.rubusch@gmail.com>
	<20250220104234.40958-12-l.rubusch@gmail.com>
	<20250304134033.656e4a6a@jic23-huawei>
	<CAFXKEHYNAL2vRgBo6H8JRHemvGj2vT30y01T_0-jhY-hkumyMA@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 13 Mar 2025 17:47:08 +0100
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> On Tue, Mar 4, 2025 at 2:40=E2=80=AFPM Jonathan Cameron <jic23@kernel.org=
> wrote:
> >
> > On Thu, 20 Feb 2025 10:42:30 +0000
> > Lothar Rubusch <l.rubusch@gmail.com> wrote:
> > =20
> > > Introduce means to configure and work with the available g-ranges
> > > keeping the precision of 13 digits.
> > >
> > > This is in preparation for the activity/inactivity feature. =20
> >
> > I'm not really following why adding range control is anything
> > much to do with that. Mostly we do this to improve accuracy for
> > low accelerations.
> > =20
>=20
> As you probably saw the connection comes a bit over the link in
> adjusting the activity/inactivity
> parameters (times and threshold) by a given range in the follow up patche=
s.
>=20
> If the question is rather why at all adding this g-range control. My
> idea was that adjusting i.e. lowering precision, less odr, etc might
> also help adjusting power consumption. In other words
> from a user perspective I assume there is more configuration
> possibility. I did not pretend to tune
> the implementation for lowest possible power consumption, though. It
> was just an idea.
>=20
> [Also, I was curious about implementing it here. My patch here is
> rather meant as a proposal,
> if you strongly oppose the idea, pls let me know.]

Control is fine (and lots of drivers do it). It was just that comment
that had me confused. To me this is a mostly unrelated feature.

It used to be the case when I last regularly used multirange accelerometers
that they had approximately matched the quality of the ADC with that of
the sensor.  So normal reason to reduce range was that it actually gave
you better accuracy as long as you didn't saturate. Mind you, for
the applications I had with sensors on sprinters shoes, all accelerometers
used to saturate even on the highest range setting! Not sure if the
reducing range for noise improvements is true on this particular sensor.

Jonathan


