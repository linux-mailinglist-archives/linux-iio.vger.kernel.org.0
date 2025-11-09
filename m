Return-Path: <linux-iio+bounces-26061-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D0DC43E9F
	for <lists+linux-iio@lfdr.de>; Sun, 09 Nov 2025 14:33:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FCC93B3DFE
	for <lists+linux-iio@lfdr.de>; Sun,  9 Nov 2025 13:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74B222F690E;
	Sun,  9 Nov 2025 13:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T8eUPm2K"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2876D17BA6;
	Sun,  9 Nov 2025 13:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762695179; cv=none; b=mWa1KPUxdkUMaV9X7jYgRCXKxagXKn/XamiPC1niV1VuMg/CTjD2+UmPAGXXf/otF/m+2WHZ7807J4HcHuoo55cJjWZtykJ34KSzlZflITjtnSqvpYa5HfGN7CtyJ0XPuO+DtqNS0lk9M4WTb4ZCNx9vJJ7flJrpOASa7zJCFkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762695179; c=relaxed/simple;
	bh=zBgrIPb5cE5ztA5qvprLBptRrpizoXny+vEc9FLxnR0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QQCG7z+RJF/XT/aCQoX1hejiDJraEdqottYm0ibAty9Ky1k4F+YGT889wL4LTgmCpTezOTWKzMA611N0EFvTqvgSDKYlXkWiEAvlRdV6eCxOma61ToozHLHLbDLHU9YKn8+PMkvqB4ZXmDp7EbT9hmB4QRs09+uhsAJVOC/jISU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T8eUPm2K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07AD7C4CEF8;
	Sun,  9 Nov 2025 13:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762695178;
	bh=zBgrIPb5cE5ztA5qvprLBptRrpizoXny+vEc9FLxnR0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=T8eUPm2KtnyaUB+ndr1SJh9tTUDJa0NlBXr1AApL236mP7MO2hU69UPWWmts/P8QG
	 +zyAFcOAmWrXzvKNSr55GZlhv2NEL8jklvIc6E4Bp+O1CeeRey3HEGkjjrT7mmN9Le
	 yPkV1AILm6eusozxEZU7g5z1WhFnSwfiGTQ+JifueSTz2e2sivS4I7ZEnZXS4ZBzRu
	 yahduZL9iGmyr9/yvkthbgeG4lJBEuD6z9wieruOGLAFyWtmEPZui3AfnrUaj00Qtr
	 QAeRs+MFrR9MOYwKHKr2auzMJMPCJne4hCMC+KJqKs5WAJtK7vJMbNKnapw/qfy56k
	 PFxUMXQyD+yDg==
Date: Sun, 9 Nov 2025 13:32:52 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Francesco Lavra <flavra@baylibre.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/9] iio: imu: st_lsm6dsx: dynamically initialize
 iio_chan_spec data
Message-ID: <20251109133252.1ae632b5@jic23-huawei>
In-Reply-To: <87f68357d52fe6406bab42d5bfb41e4addd9d301.camel@baylibre.com>
References: <20251030072752.349633-1-flavra@baylibre.com>
	<20251030072752.349633-2-flavra@baylibre.com>
	<20251102111648.73422267@jic23-huawei>
	<87f68357d52fe6406bab42d5bfb41e4addd9d301.camel@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 03 Nov 2025 10:24:54 +0100
Francesco Lavra <flavra@baylibre.com> wrote:

> On Sun, 2025-11-02 at 11:16 +0000, Jonathan Cameron wrote:
> > On Thu, 30 Oct 2025 08:27:44 +0100
> > Francesco Lavra <flavra@baylibre.com> wrote:
> >  =20
> > > Using the ST_LSM6DSX_CHANNEL_ACC() macro as a static initializer
> > > for the iio_chan_spec struct arrays makes all sensors advertise
> > > channel event capabilities regardless of whether they actually
> > > support event generation. And if userspace tries to configure
> > > accelerometer wakeup events on a sensor device that does not
> > > support them (e.g. LSM6DS0), st_lsm6dsx_write_event() dereferences
> > > a NULL pointer when trying to write to the wakeup register.
> > > Replace usage of the ST_LSM6DSX_CHANNEL_ACC() and
> > > ST_LSM6DSX_CHANNEL() macros with dynamic allocation and
> > > initialization of struct iio_chan_spec arrays, where the
> > > st_lsm6dsx_event structure is only used for sensors that support
> > > wakeup events; besides fixing the above bug, this serves as a
> > > preliminary step for adding support for more event types.
> > >=20
> > > Signed-off-by: Francesco Lavra <flavra@baylibre.com> =20
> >=20
> > In cases where there are only a small number of options for what the
> > channel
> > arrays should contain, my normal preference would be more data over
> > moving
> > the complexity into code.=C2=A0 That is have two struct iio_chan_spec a=
rrays
> > and
> > pick between them based on availability of the interrupt.
> >=20
> > I haven't checked the whole series yet, but how many channel arrays
> > would we need to support the features you are introducing here? That is
> > how many different combinations exist in the supported chips? =20
>=20
> In the current code there are 3 struct iio_chan_spec arrays; we would need
> one more to fix the above bug, and one more to add tap event support; so a
> total of 5 arrays (each of length 4).
> As for struct iio_event_spec, the current code has one array (of length 1=
),
> and to add tap event support we would need another array (of length 2).

That sounds small enough to me that I'd prefer const data that you pick bet=
ween
rather than dynamic creation.

Jonathan

