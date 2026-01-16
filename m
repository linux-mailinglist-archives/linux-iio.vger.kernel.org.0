Return-Path: <linux-iio+bounces-27890-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D6BD387A5
	for <lists+linux-iio@lfdr.de>; Fri, 16 Jan 2026 21:37:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EDEE9301C3D1
	for <lists+linux-iio@lfdr.de>; Fri, 16 Jan 2026 20:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A76ED296BB7;
	Fri, 16 Jan 2026 20:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y508tOdq"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A02442049;
	Fri, 16 Jan 2026 20:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768595730; cv=none; b=ZKLlGmKUEx1QOI025yq/oqSUZZ7JztmUDvkpPb8qT0jud2MH2+XbOwtVTgidnrLUtQMCiE34ONHw1nFHlkrkY7u/pCmGYKQD/ZvLAjq+lKF3OmWU4FwJKPe4Du9ZUkCp8ZhUz8gsEte+vTJxPKAxgq0fk3igUA14qCdcGGHRJbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768595730; c=relaxed/simple;
	bh=bB9vhob0Ii7TYdl4QD+Yt3SCrCayaX44axiIdrHDPDA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fEtnYyqTLotAf/jOohxx0wXqvKymgVSfzY/7chXZ9PvMKVLQyEL0W3D09t2s8Jqs6dpLdSl+9EPjQyooPdRFff5LJ1AZBCp85ZXDjBtusPvQdqbD3PBeILS3E8X9GadGdggvYvpe5koqOI7R0Jw97HA2Yvu/GATXdlnmHJYlNGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y508tOdq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88312C116C6;
	Fri, 16 Jan 2026 20:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768595730;
	bh=bB9vhob0Ii7TYdl4QD+Yt3SCrCayaX44axiIdrHDPDA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Y508tOdqRLFa1DE6j0h4TCgpUJ7IKXWNFaeOuLID4WDN8WF55e3lMKPW3ij4RIhLG
	 Wy5SjTmCX31gkcFAmBCARhIYc6vvYObL3xYgl0C3snt54RRVs1LnLngNVJH/GWZklo
	 9QHoS3jDS9Iq7rHJSCNmoARQYRm1v4SCb25WZPVHdsK8K8jUHm9E3IICN2X21QymNa
	 8MGo4h0EP8dgdqlzducvxDIjG7Zhv/X8qoT+KQ0E4Fw36eed/WdjjKvqEFtvsTN4Lc
	 OPYAIwYP7t9zG0FWLYcXJ6ipGFhi0hBsfQRwE8pL6hOqrhRCOf832mEvcIwMVLJIg0
	 tllTbox0fkOrg==
Date: Fri, 16 Jan 2026 20:35:23 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Francesco Lavra <flavra@baylibre.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] iio: imu: st_lsm6dsx: set buffer sampling frequency
 for accelerometer only
Message-ID: <20260116203523.07c46e10@jic23-huawei>
In-Reply-To: <bb80803ccd2d3d920f7a53b578ac09093bf29074.camel@baylibre.com>
References: <20260109181528.154127-1-flavra@baylibre.com>
	<20260109181528.154127-2-flavra@baylibre.com>
	<20260111161857.4f8b4c35@jic23-huawei>
	<2ba028f8a6239c821da80ff487b9df5536e58169.camel@baylibre.com>
	<20260116180341.6c0556cd@jic23-huawei>
	<bb80803ccd2d3d920f7a53b578ac09093bf29074.camel@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 16 Jan 2026 20:06:46 +0100
Francesco Lavra <flavra@baylibre.com> wrote:

> On Fri, 2026-01-16 at 18:03 +0000, Jonathan Cameron wrote:
> > On Mon, 12 Jan 2026 18:10:32 +0100
> > Francesco Lavra <flavra@baylibre.com> wrote:
> >  =20
> > > On Sun, 2026-01-11 at 16:18 +0000, Jonathan Cameron wrote: =20
> > > > On Fri,=C2=A0 9 Jan 2026 19:15:26 +0100
> > > > Francesco Lavra <flavra@baylibre.com> wrote:
> > > > =C2=A0  =20
> > > > > The st_lsm6dsx_hwfifo_odr_store() function, which is called when
> > > > > userspace
> > > > > writes the buffer sampling frequency sysfs attribute, calls
> > > > > st_lsm6dsx_check_odr(), which accesses the odr_table array at ind=
ex
> > > > > `sensor->id`; since this array is only 2 entries long, an access
> > > > > for
> > > > > any
> > > > > sensor type other than accelerometer or gyroscope is an out-of-
> > > > > bounds
> > > > > access.
> > > > >=20
> > > > > To prevent userspace from triggering an out-of-bounds array acces=
s,
> > > > > and
> > > > > to
> > > > > support the only use case for which FIFO sampling frequency values
> > > > > different from the sensor sampling frequency may be needed (which
> > > > > is
> > > > > for
> > > > > keeping FIFO data rate low while sampling acceleration data at hi=
gh
> > > > > rates
> > > > > for accurate event detection), do not create the buffer sampling
> > > > > frequency
> > > > > attribute for sensor types other than the accelerometer.=C2=A0  =
=20
> > > >=20
> > > > I'm not following why we need to drop this attribute for the
> > > > gyroscope.
> > > > Perhaps lay out what the combinations of controls are and the
> > > > attributes
> > > > we end up with.=C2=A0  =20
> > >=20
> > > It's not like we need to drop this attribute, it's just that I don't
> > > see a
> > > need for it. The only reason I added this attribute was to be able to
> > > control (e.g. lower) the rate of data coming from the sensor while
> > > maintaining a high accuracy for event detection; and accurate event
> > > detection requires a high sampling rate for the accelerometer. =20
> >=20
> > Ok. So key here is for accelerations we are looking at impacts as a
> > typical
> > use case, whereas gyroscope tends to be slow orientation change stuff.
> > That sounds a bit usecase specific. If someone is using these to detect
> > shaft rotation
> > issues they are going to care about sampling rates on the gyro as well,
> > or is there something inherent in the gyroscope events (i.e. maybe there
> > aren't any gyro events?) that makes this not relevant? =20
>=20
> All the events supported by this driver (motion detection and tap
> detection) use acceleration data only.
> Some chip variants (e.g LSM6DSV) have more advanced features such as
> configurable finite state machines that can take inputs from both the
> accelerometer and the gyroscope and generate event interrupts; but I don't
> think these events would map cleanly to standard IIO event types.
>=20
Doh! The fact we don't support gyro events was the detail I was completely =
missing ;(

Please add that to the patch description.

Thanks

Jonathan



