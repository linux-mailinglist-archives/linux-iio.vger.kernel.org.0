Return-Path: <linux-iio+bounces-26091-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 118F3C44243
	for <lists+linux-iio@lfdr.de>; Sun, 09 Nov 2025 17:19:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A49C54E5613
	for <lists+linux-iio@lfdr.de>; Sun,  9 Nov 2025 16:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D2C62FFF98;
	Sun,  9 Nov 2025 16:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hr/OZCxE"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3AB5C96;
	Sun,  9 Nov 2025 16:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762705182; cv=none; b=qbTlxuQqNnq1nQYBl58tJ4darI4Ma1D/Gwy2dO1ry+jBy/rHJwxwXr4cUP/sThTKPq5PSXmZQckigYCAQtEB4tIQLram4nlSTrEoeEo1q1QJi7dO6zmppVX/fQTsXFzximwFlqblv0uGslVlrhPkhdA2h04hjG62uUuKiz8jahE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762705182; c=relaxed/simple;
	bh=2ppow4A47+wHLUX6xZe/3VqgZmxAer6B1Qvbvr0/ql0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TVxEFKc4OY6P5PmiqjLx6lqCgidza4qSdmvWPnRZ8vnhbn7LoabXaXB9QOxpN1vGeRfSxW3U8P5khD+S94gY2+y2SYpfW5BU88NbtcCTK0+uSWfAc8dZ1cORMcrv9ylgnEP6H9NdoHTjxaCtV97fApnW23jCvUEGg4p9zbgUnDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hr/OZCxE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 178B4C116B1;
	Sun,  9 Nov 2025 16:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762705181;
	bh=2ppow4A47+wHLUX6xZe/3VqgZmxAer6B1Qvbvr0/ql0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Hr/OZCxE3YsxVVwJunOnlOeep56JjZbmzU/bYm5C/dTu3XSxPCzTuR3nlfqRBDUeg
	 rwd0vI/w3XiA50MpFMYcmxnFU7IRewXGxrvfClzY21i/7QOtdnNu0CBpViGpt4nxTS
	 vDb9R3IeM478CLjgOFOWbZtkpGX24wlkyXvNW8uTGCEHx+j25XRSC7uytIu8L5arB/
	 DwsI++wgRUZKziO70qX4LNFJG0OPU++LEsj0lUsVhLkv+Audt4kfRcVC3dMDAGVttc
	 jo+SsO+aTe4VRiMspY8xac3PI7u106mtTL/24WOcFaLx+iOmIHT8V6MvT2jT/oSMME
	 FrlTDKJ50U7fQ==
Date: Sun, 9 Nov 2025 16:19:33 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v4 09/12] iio: dac: ad5446: Make use of the cleanup
 helpers
Message-ID: <20251109161933.001043ce@jic23-huawei>
In-Reply-To: <aQpEjYRQTDolSIXO@smile.fi.intel.com>
References: <20251104-dev-add-ad5542-v4-0-6fe35458bf8c@analog.com>
	<20251104-dev-add-ad5542-v4-9-6fe35458bf8c@analog.com>
	<aQpEjYRQTDolSIXO@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 4 Nov 2025 20:23:09 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Tue, Nov 04, 2025 at 03:35:14PM +0000, Nuno S=C3=A1 via B4 Relay wrote:
>=20
> > Use the auto unlocking helpers from cleanup.h. Allows for some code
> > simplification.
> >=20
> > While at it, don't use the ternary operator in
> > ad5446_write_dac_powerdown() and add an helper function to write the DAC
> > code. The reason for the function was purely to avoid having to use
> > unreachable(). =20
>=20
> ...
>=20
> > +static int ad5446_write_dac_raw(struct iio_dev *indio_dev,
> > +				const struct iio_chan_spec *chan,
> > +				int val)
> > +{
> > +	struct ad5446_state *st =3D iio_priv(indio_dev); =20
>=20
> > +	if (val >=3D (1 << chan->scan_type.realbits) || val < 0)
> > +		return -EINVAL; =20
>=20
> BIT() ?
> in_range() ?
>=20
It's a code move, so I'd rather that change if made is a separate patch.
BIT() is fine, but in_range() is a bit odd when the start is 0.

Hence applied this as it stands.
> > +	val <<=3D chan->scan_type.shift;
> > +	guard(mutex)(&st->lock);
> > +
> > +	st->cached_val =3D val;
> > +	if (st->pwr_down)
> > +		return 0;
> > +
> > +	return st->chip_info->write(st, val);
> > +} =20
>=20
>=20


