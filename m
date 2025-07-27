Return-Path: <linux-iio+bounces-22043-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D5AB12FAA
	for <lists+linux-iio@lfdr.de>; Sun, 27 Jul 2025 15:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCC6E7A137D
	for <lists+linux-iio@lfdr.de>; Sun, 27 Jul 2025 13:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBFD7202963;
	Sun, 27 Jul 2025 13:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mLHePozj"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A6A11185;
	Sun, 27 Jul 2025 13:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753621948; cv=none; b=R50RwRiTM8862p31WDEGoDKupaQBjAm6vWMuH3+9Jmx96/QHHlHGv+7yRN/QF9px+tnKii3IjEbijbOi8DX0pFtB03t+ta5fGUEHR4JqqIozbeRF8yiszAwvG+0mf5x7vJLSq2SRq6pPqH3Fy13sm+4OJLct+N7fCotPaiClEQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753621948; c=relaxed/simple;
	bh=ISfxmyXu3POhbKCDLt7yo/hOLdlMw5IXiQdiNy0b5OU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pWKQ6v7lIINFcIxf59K9s+z7hEhritOkiimsq/Jc8iFCS5YD+FRCrsSVjayeLyapmMr7olOhlxASPx4XSp4pUnUuJBfIcBx4n3vLqceDDyKuX4vYWtGaiK3LQjWVm/79equY9r5vBzH7RxWHwF/t7uky5HRXNyrHkXmmxtJ2Dww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mLHePozj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 091FBC4CEEB;
	Sun, 27 Jul 2025 13:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753621948;
	bh=ISfxmyXu3POhbKCDLt7yo/hOLdlMw5IXiQdiNy0b5OU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mLHePozjnyLse2SvoUDzIzs6n+KXpLopc81cFZHM0P7vKoqjljYNPZGakCmOyq8mo
	 68cFZXQSTqDqAoas8T7P4io83hxEKvmYth1WmqspwjRHfamSiFtewu054apeqf3zJU
	 NmydhUAVlcaJaR8DHpUGiudapysWWltlYZk5qBN/Af1w18M47+Y8hCwnLzgE6KLhE1
	 KqGiNz+P778kOTZZOxMs/4RJFcx9nVzpaVfDU/oGm2B4po62jN4SuceLicqbJBW2Hz
	 ekM0zLi3EZ4UTjp0d/aMeYySIowtoRGh0guvK76wSp9Ao42iF0p0tE5Vgiwcyn5Nvv
	 szKCQiukHsIOw==
Date: Sun, 27 Jul 2025 14:12:21 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Akshay Jindal <akshayaj.lkd@gmail.com>, anshulusr@gmail.com,
 nuno.sa@analog.com, andy@kernel.org, shuah@kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: light: ltr390: Add sysfs attribute to report
 data freshness
Message-ID: <20250727141221.40e1824e@jic23-huawei>
In-Reply-To: <7e70075d-f91f-4ea8-b5e5-ccec6fba425d@baylibre.com>
References: <20250721195419.526920-1-akshayaj.lkd@gmail.com>
	<a88e1a8e-d29c-41e7-b3cd-5db965a055df@baylibre.com>
	<CAE3SzaTG-re2HPRAcPWuo2YmM9mxLWndpN_SQOAZg7MP_B3xDg@mail.gmail.com>
	<8f924da6-c5f6-4f88-9cb1-3e7e1aae491b@baylibre.com>
	<20250724133933.220d00e4@jic23-huawei>
	<CAE3SzaQcsuHihe2-7VTnXAKYab03Cyu1kAPsA2-E4d1kQzCCNQ@mail.gmail.com>
	<7e70075d-f91f-4ea8-b5e5-ccec6fba425d@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 24 Jul 2025 12:41:48 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 7/24/25 11:55 AM, Akshay Jindal wrote:
> > On Thu, Jul 24, 2025 at 6:09=E2=80=AFPM Jonathan Cameron <jic23@kernel.=
org> wrote: =20
> >> Agreed.  Is the interrupt wired on this board?  If it is and you
> >> want to do filtering with the knowledge that the data is fresh then
> >> add a data ready trigger and buffered capture support.
> >> It's a much bigger job, but it is standard ABI and as such of more
> >> general use.
> >>
> >> Jonathan
> >> =20
> > Yes, the interrupt is wired in and enabled.
> >=20
> > For LTR390, data_freshness is not the same as data-ready.
> > Here the sensor does not support a data-ready interrupt.
> > It only supports threshold violation interrupts where thresholds are
> > configurable.
> > LTR390 datasheet Pg 17:
> > https://optoelectronics.liteon.com/upload/download/DS86-2015-0004/LTR-3=
90UV_Final_%20DS_V1%201.pdf
> >=20
> > Correct me, if I am wrong, but as per my understanding, trigger based i=
nterrupts
> > are more appropriate where the application requires storing multiple sa=
mples
> > in a buffer at specific time intervals, provided the sensor supports
> > data-ready interrupts.
> >  =20
>=20
> Interrupts works just as well for single samples when devices have a
> data ready signal. But you are right, that doesn't help us here
> since the interrupt is just for threshold alerts.
>=20

Yeah.  I got thrown by the adfruit docs that say the interrupt can serve
this purpose. Clearly not from the datasheet.

Jonathan

