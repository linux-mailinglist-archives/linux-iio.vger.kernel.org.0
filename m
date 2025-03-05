Return-Path: <linux-iio+bounces-16417-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE6CA4FF3F
	for <lists+linux-iio@lfdr.de>; Wed,  5 Mar 2025 14:00:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A623316924F
	for <lists+linux-iio@lfdr.de>; Wed,  5 Mar 2025 13:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E2922459C5;
	Wed,  5 Mar 2025 13:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EP2n4+y2"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96D01E531;
	Wed,  5 Mar 2025 13:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741179632; cv=none; b=WZNamCM/I6/ooV6DfKX30JDIkqiuBqvFqNl40EqfzAXIgbzfsbQ6ViV7PugLYS+1EO7VQYGOsHFHWCvNZXSq+GcojhJKDOqfwYH7c9MQxOHAcv9+vJuLotJ9Jx3+/X+MR+xVbLSnw/VIHV74ORwGYNb1csD5CU5JU58cG9ItHhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741179632; c=relaxed/simple;
	bh=CGxNrwrJ/7w+lrFYd7rIJRRXjnZsn89/CuKNM7OkM3s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q9voSnIwx4PXabroFR9PdfkgWNlfThx71VGtX7NuZaqYZet9dinf84xibfNt+jUFxtdZvBNPeHTULq2UqDqksZWVXYhoXMj7SoKXrMsckwcGCSffEv6fRf2wMldUU4+beZmGkfcVGiyibVfXl3ObdkaCg07ME5YURr0en2QA170=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EP2n4+y2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E836DC4CEE7;
	Wed,  5 Mar 2025 13:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741179632;
	bh=CGxNrwrJ/7w+lrFYd7rIJRRXjnZsn89/CuKNM7OkM3s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EP2n4+y2C1tZto3KAGAQwvOqYFJhi6RgUpMXAJhopRbxwTF5nGiPdPZf3a3zLBpC4
	 4kaVTVMBeIxli7zErFRQDkulWI5bazRHpjcSo91gcmXvZGR2F+hpArnhJ8EQPIvuKe
	 CLqP1n/F+97HRGlZKuN53tMUEPWvUUSKdD5VxJF9ks7WtebcBtxf2Yv5+JIk/VaZMW
	 N/OC36dU++um0aF68U5ynCiJBZmP/1/zW8saNKB/wyssDzS7nDd2kph7QOWQPXuJyh
	 4lX/SvCDj679HKbmd1MOv3fDZ9JFibxx57yZNoyKcmHgknmM1XuCTtUn2Ga1QNlgfR
	 QNiNgekVD2Ebg==
Date: Wed, 5 Mar 2025 13:00:20 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>, Antoniu Miclaus
 <antoniu.miclaus@analog.com>, robh@kernel.org, conor+dt@kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 14/14] Documentation: ABI: testing: ad4080 docs
Message-ID: <20250305130020.7e78f3a6@jic23-huawei>
In-Reply-To: <d1af7490-5d91-4b30-a86f-8df3a8d17af7@baylibre.com>
References: <20250220135429.8615-1-antoniu.miclaus@analog.com>
	<20250220135429.8615-15-antoniu.miclaus@analog.com>
	<8f588f4b88d122815df694660d19672e8ccd3d70.camel@gmail.com>
	<fd3ba169-c5e0-4405-961f-d7c11c68dffb@baylibre.com>
	<3f4bb345c1d76e7521d8bdbf4b4552e727c7dc1c.camel@gmail.com>
	<d1af7490-5d91-4b30-a86f-8df3a8d17af7@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 25 Feb 2025 09:26:56 -0600
David Lechner <dlechner@baylibre.com> wrote:

> On 2/25/25 3:16 AM, Nuno S=C3=A1 wrote:
> > On Thu, 2025-02-20 at 12:27 -0600, David Lechner wrote: =20
> >> On 2/20/25 8:53 AM, Nuno S=C3=A1 wrote: =20
> >>> On Thu, 2025-02-20 at 15:54 +0200, Antoniu Miclaus wrote: =20
>=20
> ...
>=20
> >>>> +
> >>>> +What:		/sys/bus/iio/devices/iio:deviceX/sinc_dec_rate
> >>>> +Date:		February 2025
> >>>> +KernelVersion:
> >>>> +Contact:	linux-iio@vger.kernel.org
> >>>> +Description:
> >>>> +		Set the filter=E2=80=99s decimation rate.
> >>>> +
> >>>> +What:		/sys/bus/iio/devices/iio:deviceX/sinc_dec_rate_available
> >>>> +Date:		February 2025
> >>>> +KernelVersion:
> >>>> +Contact:	linux-iio@vger.kernel.org
> >>>> +Description:
> >>>> +		Return the available filter's decimation rates.
> >>>> +
> >>>> + =20
> >>>
> >>> I'm not yet convinced we need the dec_rate custom attr. I'll add more
> >>> comments
> >>> in the driver. =20
> >>
> >> If we do need it, in another driver recently we concluded that
> >> decimation rate is the same as oversampling ratio and there is
> >> already a standard attribute for oversampling ratio, so we used
> >> that.
> >> =20
> >=20
> > Yeah, in theory decimation is about averaging samples. Makes sense to m=
e even
> > though I never thought about using the oversampling ratio attr. I was b=
iased by
> > the IMUs drivers where we configure the dec_rate as part of the sampling
> > frequency attr since these filters directly affect the chip ODR.=C2=A0
> >=20
> > Out of curiosity, how did you handled this in the other driver? I would=
 be
> > tempted to only allow reading the sampling frequency attribute which me=
ans that
> > the oversampling ratio attr is the one we can write (which then directl=
y affects
> > sampling frequency).
> >=20
> > - Nuno S=C3=A1 =20
>=20
> The other driver is still under review:
>=20
> https://lore.kernel.org/linux-iio/2c3ce1701545e435238605342397e45657a0fb2=
a.1739368121.git.Jonathan.Santos@analog.com/
>=20
> It is modifying an existing driver, so in that case, we still have to pre=
serve
> writing to sampling_frequency even if that isn't the ideal way to set it =
up.

It's pretty rare from what I recall to see a device sophisticated enough to=
 do
over sampling that doesn't also support a sequencer that will allow configu=
ring
the sampling frequency at a given oversampling ratio (by adding space, or m=
ore
settling time if a mux is involved which looks the same as space to softwar=
e).

I guess there is always a first and to me in that case oversampling is the =
natural
control rather than sampling frequency.

Jonathan
Jonathan



