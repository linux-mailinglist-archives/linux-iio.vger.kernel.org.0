Return-Path: <linux-iio+bounces-27867-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D63D3843E
	for <lists+linux-iio@lfdr.de>; Fri, 16 Jan 2026 19:27:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0954130AF1E4
	for <lists+linux-iio@lfdr.de>; Fri, 16 Jan 2026 18:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D67D3A0B3D;
	Fri, 16 Jan 2026 18:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P4CYF147"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E86F3A0B27;
	Fri, 16 Jan 2026 18:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768588045; cv=none; b=iyHoEuUAZXUC1rBStHTX7FbOUkdg8oS7XkRru/XHfQi8FthDlp3nac9zGTAKOFb6gHGsK4gaT5sz+64qsHdw0BzddeP2yTxe+EldOa7RJjn0BXnyG9OPcedRlUXAGDLmBCnQd58sRSrIAF2TotJtqCnAth5CxiB6vUI6Zrsp7jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768588045; c=relaxed/simple;
	bh=XaUJtlMPYF5HngWcYEwuheLzlEPLMGeAZCDJpOapo9M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EEefrWlVC+WZktEdcFnHIvUN8iYejVfT+Z5MFX05earFTlZaOPY1H3S6tJA3k1OAPFSQrrzCwE7Hoyqm4yk3dzqSXcrLz38D83YJa2Hvau0y4jwhd70hJpO8lCs8bgMGcOJbcSa4IG05H5ylPAQb22iLkrVhjLSGt6ysF9L+rs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P4CYF147; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7D85C19422;
	Fri, 16 Jan 2026 18:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768588044;
	bh=XaUJtlMPYF5HngWcYEwuheLzlEPLMGeAZCDJpOapo9M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=P4CYF147pIXXYUJAjnzG0TQ7/puM685ScCoQXj7LgVuwnyV2a1Ea/gfX8zIrR9wSm
	 96BlqAEbJCXFDnZs3uJ9yLhxYcrAC9Dk76rCPTPICxx5DBV+ZLJ+Idsz4K8UAZ4j9e
	 G6vviJGukJnQ1xC3A9LiGEB/9CR8Zi0EI1HJENe7O/NfwRdC6XHhcSB/xKgq+bMeLy
	 YRK3/u6phkoYjXcOcIY17K39z1GcmXGQshgipKOzeW68jDqOwRXgRNphbb0hPjLXJk
	 9SFulxul+O+lBtsIKf71mOKlMZ8FDtyYGwd4C6pNeBchZoU/lu2yeuNHj48n5g5xhN
	 bm5URfJQabk8A==
Date: Fri, 16 Jan 2026 18:27:16 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Francesco Lavra <flavra@baylibre.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] iio: imu: st_lsm6dsx: add support for rotation
 sensor
Message-ID: <20260116182716.2ff8925f@jic23-huawei>
In-Reply-To: <d09ca6f843f75be5c5726eeab95063ea0e7c99cc.camel@baylibre.com>
References: <20260109181528.154127-1-flavra@baylibre.com>
	<20260109181528.154127-4-flavra@baylibre.com>
	<20260111164651.56a0cf14@jic23-huawei>
	<d09ca6f843f75be5c5726eeab95063ea0e7c99cc.camel@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable


>=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0const struct st_lsm6dsx_re=
g *mux;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int err;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mux =3D &hw->settings->sf_=
settings.page_mux; =20
> >=20
> > Just to check, can you use regmaps support for paging instead of doing
> > this by hand?
> > That would avoid future problems with enabling caching or similar =20
>=20
> No, the chip has multiple register sets with overlapping addresses, and
> struct regmap_range_cfg is not usable here.

Paged addressing always has overlapping addresses, so I'm not following.
The trick this does is to map those higher pages to a fake set of addresses.
An example is the ICM42600:
https://invensense.tdk.com/wp-content/uploads/2020/04/ds-000347_icm-42688-p=
-datasheet.pdf
for a suitable datasheet (some of the newer parts have a much more complex =
scheme)

I took a look at the datasheet and seems there are multiple types of paging
going on and effectively ends up with two nested paging controls. So fair e=
nough it
doesn't fit here.

>=20
> >  =20
> > > +
> > > +static
> > > IIO_DEV_ATTR_SAMP_FREQ_AVAIL(st_lsm6dsx_sf_sampling_freq_avail);
> > > +static struct attribute *st_lsm6dsx_sf_attributes[] =3D {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0&iio_dev_attr_sampling_fre=
quency_available.dev_attr.attr,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0NULL, =20
> >=20
> > No comma as nothing should come after this.=C2=A0 Ideally would be repl=
aced
> > with
> > code using the read_avail callback and appropriate bit set in the
> > info mask avail bitmaps. =20
>=20
> The read_avail callback would require available values to be in an int
> array, with one of the available IIO_VAL_* formats, but the driver uses a
> table (similarly to other parts of the existing code) where frequency
> values are expressed in mHz (which does not match any IIO_VAL_* format) a=
nd
> are interleaved with corresponding hardware register values. So we can't
> use the existing available frequency values in a read_avail callback.

You would need to do some data mangling to create the relevant table in ord=
er
to use that callback. We can always do that later I suppose if we find
that it matters for some inkernel consumer or other reason.

Jonathan

>=20


