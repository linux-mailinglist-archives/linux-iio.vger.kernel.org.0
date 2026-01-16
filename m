Return-Path: <linux-iio+bounces-27866-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B37AED38379
	for <lists+linux-iio@lfdr.de>; Fri, 16 Jan 2026 19:06:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3B0DE302651C
	for <lists+linux-iio@lfdr.de>; Fri, 16 Jan 2026 18:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E0539B496;
	Fri, 16 Jan 2026 18:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IxZnTOJR"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1A2335573;
	Fri, 16 Jan 2026 18:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768586630; cv=none; b=EBBr+oUM0MHP8uJ9UOyYkQZhNLVBkltzdZlVtHD77z762ikqMlnoC08W0l/bfwUVGAE4uGV4vM9N4tsI3cO0ANFnva1Efps8abpaG1LGWW2DMhkk85XK/n8NIRvO20QWQ/1UdhHDgdI3NBRctRA9NW/r1fxM4QH0ADLmB1SRiDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768586630; c=relaxed/simple;
	bh=TTR0f4ZKlXR4PJn/VYIMKKYy5Gy/58/TnXXuQffOpmc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XvaVH4LVXDurIqR4BW8/C2lr5x7rk+76C4F9W4WJkpftYR0Gbz3HhHj6hIAJdAw3j+NY+ixAqufvGG8naKmegm7abKexoDOqmDkAc+XYUMOsM2x3uDo7/u7K6m1p+kUc2DPnS9iqwMqa9gsoVQ/3sXwUS83Eo9QIe+pVdTXyDN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IxZnTOJR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 131C8C19422;
	Fri, 16 Jan 2026 18:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768586630;
	bh=TTR0f4ZKlXR4PJn/VYIMKKYy5Gy/58/TnXXuQffOpmc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IxZnTOJRg43nAr8UO4WKQhirSq00ECTnYsCtnCbr3xF5G9ZPLkH+teaKrrPQWjGL+
	 IRr1lyOcoXMgNiLHFvdxuIk7S+Hrsh7TUuI96MFv7tTFFQIfHGejsAPDx484OaVY4n
	 3/9+QXWbrmME2Wm6ZOGRnMZsNDudn25j5CrZNve3tQ9bFwwTA1loIEyHU6WgFB6prJ
	 S+Kou4ZS2psoymsWpZrFLMd3FqsqPFgwWpYR2+HVHdRkpfv12VBh8I/K1NUzaNMbkK
	 63QX9Ncf82G2YaI9kam8l6oSoH0AY+jfQ0qaei/yb/z0kw3L7uuvDM429BffnR7Yto
	 JOObsOW5V/J8w==
Date: Fri, 16 Jan 2026 18:03:41 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Francesco Lavra <flavra@baylibre.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] iio: imu: st_lsm6dsx: set buffer sampling frequency
 for accelerometer only
Message-ID: <20260116180341.6c0556cd@jic23-huawei>
In-Reply-To: <2ba028f8a6239c821da80ff487b9df5536e58169.camel@baylibre.com>
References: <20260109181528.154127-1-flavra@baylibre.com>
	<20260109181528.154127-2-flavra@baylibre.com>
	<20260111161857.4f8b4c35@jic23-huawei>
	<2ba028f8a6239c821da80ff487b9df5536e58169.camel@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 12 Jan 2026 18:10:32 +0100
Francesco Lavra <flavra@baylibre.com> wrote:

> On Sun, 2026-01-11 at 16:18 +0000, Jonathan Cameron wrote:
> > On Fri,=C2=A0 9 Jan 2026 19:15:26 +0100
> > Francesco Lavra <flavra@baylibre.com> wrote:
> >  =20
> > > The st_lsm6dsx_hwfifo_odr_store() function, which is called when
> > > userspace
> > > writes the buffer sampling frequency sysfs attribute, calls
> > > st_lsm6dsx_check_odr(), which accesses the odr_table array at index
> > > `sensor->id`; since this array is only 2 entries long, an access for
> > > any
> > > sensor type other than accelerometer or gyroscope is an out-of-bounds
> > > access.
> > >=20
> > > To prevent userspace from triggering an out-of-bounds array access, a=
nd
> > > to
> > > support the only use case for which FIFO sampling frequency values
> > > different from the sensor sampling frequency may be needed (which is
> > > for
> > > keeping FIFO data rate low while sampling acceleration data at high
> > > rates
> > > for accurate event detection), do not create the buffer sampling
> > > frequency
> > > attribute for sensor types other than the accelerometer. =20
> >=20
> > I'm not following why we need to drop this attribute for the gyroscope.
> > Perhaps lay out what the combinations of controls are and the attributes
> > we end up with. =20
>=20
> It's not like we need to drop this attribute, it's just that I don't see a
> need for it. The only reason I added this attribute was to be able to
> control (e.g. lower) the rate of data coming from the sensor while
> maintaining a high accuracy for event detection; and accurate event
> detection requires a high sampling rate for the accelerometer.

Ok. So key here is for accelerations we are looking at impacts as a typical
use case, whereas gyroscope tends to be slow orientation change stuff.
That sounds a bit usecase specific. If someone is using these to detect sha=
ft rotation
issues they are going to care about sampling rates on the gyro as well,
or is there something inherent in the gyroscope events (i.e. maybe there
aren't any gyro events?) that makes this not relevant?

> So the
> gyroscope is not involved here, and the attribute is only needed for the
> accelerometer.
>=20
> Before this change, we have:
> - accel IIO device with separate samp_freq and buffer/samp_freq
> - gyro IIO device with separate samp_freq and buffer/samp_freq
> - (optionally) external sensor IIO devices with separate samp_freq and
> buffer/samp_freq (and trying to set buffer/samp_freq for these triggers an
> out-of-bounds array access)
>=20
> After this change, we have the accel IIO device with separate samp_freq a=
nd
> buffer/samp_freq, while the other IIO devices have only a single samp_freq
> attribute.
>=20
> > As you note in the cover letter we can change this now with ABI issues =
as
> > it is just in my tree, so I don't mind the change, just want to
> > understand
> > it a little better than I currently do! =20
>=20
> It's not just in your tree, it has been pulled into Linus's tree for 6.19.
Bit tight to get a fix in, though I gather we are going to rc8 this time
so maybe.

Jonathan

>=20


