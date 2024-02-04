Return-Path: <linux-iio+bounces-2162-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4194B848F1F
	for <lists+linux-iio@lfdr.de>; Sun,  4 Feb 2024 17:06:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5293283211
	for <lists+linux-iio@lfdr.de>; Sun,  4 Feb 2024 16:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 980E522627;
	Sun,  4 Feb 2024 16:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RvF0S5oH"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A6522611
	for <linux-iio@vger.kernel.org>; Sun,  4 Feb 2024 16:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707062796; cv=none; b=gw0YanvVJDdU4r5J1UM39Rd796/vEpTBRZIL7MnWFXI6n0AmO48t93893Ct8u6xtyy27CzZq4SPlpjWWdKqJZg3ctxslaiUEG0C8eKjV/hNXKRbmYDjHWXs4AzxRUwYfQSIXMMv12ibbe5MvwEkEwddcTihR0/pSIksYULSbUS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707062796; c=relaxed/simple;
	bh=WxaApy6Rpf/Xsb9UdTwHaJbG+WJb4vek64w46drE9SY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S8BrgMskdybjANWBJlLan+VFas1Cy6Zn0trv2hcoCZcsl2kEOiPma3+htDjxICq/G+NKCzzMoGFr3uV57JgV8OI44CtqFOJFX+SeI/VB3K7By7M67Xvx3rx67YZpdau8072degUspYiZBEHMFnPQOiVhE5ZMXVMABrL71Nb1ffo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RvF0S5oH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B019C433F1;
	Sun,  4 Feb 2024 16:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707062795;
	bh=WxaApy6Rpf/Xsb9UdTwHaJbG+WJb4vek64w46drE9SY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RvF0S5oHGAKyV6QMbWQ50p+8r0WgcXPSe1u5mdp/Kl8GEfG0JLj5ezBJ9lNVONKgM
	 tJC4mjW7wIQ6oXJewrf/th6gfLr0BksshLLv3f0Wthy5oQVtoJ/EUhX+qKf6TaA6An
	 i2a3MBiJxZazz4UZvvJVk5eBp68CL7/cvS94X8qLeR0go9cGhHSYbGzzrUEno61M7h
	 aokNQ5DSoZlEh3FC6P7rfTqDrINXXHWMKPncq33UDNkxhvgst6tb/U2XzQULAisTYr
	 qqVkxu69P9cfUZwSMeYT04Fq/4RD4ZV0rEGiHxogsn+nZPmXgMRX6FCzQUCLQPr8zh
	 ylaRhePfWsY3Q==
Date: Sun, 4 Feb 2024 16:06:21 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Peter
 Zijlstra <peterz@infradead.org>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 00/10] IIO: Use the new cleanup.h magic
Message-ID: <20240204160621.11e9241f@jic23-huawei>
In-Reply-To: <d9b960c806cb5fc598a9149b38a2f139b42e5f24.camel@gmail.com>
References: <20240128150537.44592-1-jic23@kernel.org>
	<d9b960c806cb5fc598a9149b38a2f139b42e5f24.camel@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 30 Jan 2024 15:08:39 +0100
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Sun, 2024-01-28 at 15:05 +0000, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >=20
> > The prerequisites are now in place upstream, so this series can now
> > introduce the infrastructure and apply it to a few drivers.
> >=20
> > Changes since RFC v2: Thanks to David Lechner for review
> > =C2=A0- Use unreachable() instead of misleading returns in paths we can=
't reach.
> > =C2=A0- Various minor tweaks and local variable scope reduction.
> > =C2=A0
> > A lot of the advantages of the automated cleanup added for locks and si=
milar
> > are not that useful in IIO unless we also deal with the
> > iio_device_claim_direct_mode() / iio_device_release_direct_mode()
> > calls that prevent IIO device drivers from transitioning into buffered
> > mode whilst calls are in flight + prevent sysfs reads and writes from
> > interfering with buffered capture if it is enabled.
> >=20
> > This can now be neatly done using new scoped_cond_guard() to elegantly
> > return if the attempt to claim direct mode fails.
> >=20
> > The need to always handle what happens after
> > iio_device_claim_direct_scoped() {} is a little irritating but the
> > compiler will warn if you don't do it and it's not obvious how to
> > let the compiler know the magic loop (hidden in the cleanup.h macros)
> > always runs once.=C2=A0 Example:
> >=20
> > 	iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
> > 		return 42;
> > 	}
> > 	/* Can't get here, but compiler about no return val without this */
> > 	unreachable();
> > }
> >=20
> > Jonathan Cameron (10):
> > =C2=A0 iio: locking: introduce __cleanup() based direct mode claiming
> > =C2=A0=C2=A0=C2=A0 infrastructure
> > =C2=A0 iio: dummy: Use automatic lock and direct mode cleanup.
> > =C2=A0 iio: accel: adxl367: Use automated cleanup for locks and iio dir=
ect
> > =C2=A0=C2=A0=C2=A0 mode.
> > =C2=A0 iio: imu: bmi323: Use cleanup handling for
> > =C2=A0=C2=A0=C2=A0 iio_device_claim_direct_mode()
> > =C2=A0 iio: adc: max1363: Use automatic cleanup for locks and iio mode
> > =C2=A0=C2=A0=C2=A0 claiming.
> > =C2=A0 iio: proximity: sx9360: Use automated cleanup for locks and IIO =
mode
> > =C2=A0=C2=A0=C2=A0 claiming.
> > =C2=A0 iio: proximity: sx9324: Use automated cleanup for locks and IIO =
mode
> > =C2=A0=C2=A0=C2=A0 claiming.
> > =C2=A0 iio: proximity: sx9310: Use automated cleanup for locks and IIO =
mode
> > =C2=A0=C2=A0=C2=A0 claiming.
> > =C2=A0 iio: adc: ad4130: Use automatic cleanup of locks and direct mode.
> > =C2=A0 iio: adc: ad7091r-base: Use auto cleanup of locks.
> >=20
> > =C2=A0drivers/iio/accel/adxl367.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | 297 +++++++++++----------------
> > =C2=A0drivers/iio/adc/ad4130.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 131 +++++-------
> > =C2=A0drivers/iio/adc/ad7091r-base.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 25 +--
> > =C2=A0drivers/iio/adc/max1363.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 171 +++++++--------
> > =C2=A0drivers/iio/dummy/iio_simple_dummy.c | 182 ++++++++--------
> > =C2=A0drivers/iio/imu/bmi323/bmi323_core.c |=C2=A0 78 +++----
> > =C2=A0drivers/iio/proximity/sx9310.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 114 ++++------
> > =C2=A0drivers/iio/proximity/sx9324.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 109 ++++------
> > =C2=A0drivers/iio/proximity/sx9360.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 115 ++++-------
> > =C2=A0include/linux/iio/iio.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 25 +++
> > =C2=A010 files changed, 518 insertions(+), 729 deletions(-)
> >  =20
>=20
>=20
> Just one comment that boils down to preference... So, LGTM:
>=20
> Reviewed-by: Nuno Sa <nuno.a@analog.com>
>=20
Applied to the togreg branch of iio.git and pushed out as testing for 0-day
to poke at it. I tweaked patch 2 as discussed in the thread.

Thanks!

Jonathan



