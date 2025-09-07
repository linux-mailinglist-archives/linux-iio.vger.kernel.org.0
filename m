Return-Path: <linux-iio+bounces-23845-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB011B47A8D
	for <lists+linux-iio@lfdr.de>; Sun,  7 Sep 2025 12:56:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FCB1172C47
	for <lists+linux-iio@lfdr.de>; Sun,  7 Sep 2025 10:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77FF525A331;
	Sun,  7 Sep 2025 10:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZEvy6vH9"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7182236EE;
	Sun,  7 Sep 2025 10:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757242610; cv=none; b=jNpclLXYB/orjismA0vpHIeOubjjKKOUqDusOs2Te5W6QfWJn5YcRKuWrt9q/DYMfyU01BYaoWrmtOlFiItd5CgCjgDrWbJOVCnjh1kymOCBAWRrVltA+XJWONjMiGktyF7z52U6MJTxkjcVk1ZyRZgNX0eqKfduxOcCYHWDaNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757242610; c=relaxed/simple;
	bh=YEMCvkONpXNQwt8L2SY5goheIFQ2XpilgJ3VsHsKRM4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rPbsY4KjG5+S1h+IUZQpdeiK0PjGW/jLtU7HoFn9NXNsHXfB4t00Xpb+2ygY9gqsbA2JGkyQ7T35Hebd9kDiAUzorviQzUBTFXXzQnYLbJGhTvol+ho2vPlJKNLtdzqOwcnxNP2NWTy6ecs3bDsk1FnDXbRXs8LHHdKyqesWPpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZEvy6vH9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F890C4CEF0;
	Sun,  7 Sep 2025 10:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757242609;
	bh=YEMCvkONpXNQwt8L2SY5goheIFQ2XpilgJ3VsHsKRM4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZEvy6vH9ciHb+GAQw9K9OFuug6LaBX5yGRoz/nivSMii1yBxlrZeJ4Hss2yVDUscg
	 YNIK9Rz4tWS3jDpY/GfOD2SCOdm3DmI0dXtvVeGmQClfk8E1De+LhHXE34VLQEHzpg
	 U11SWWk1xEnMfyrrt3vdqmdmCSaiG6AzvuCRdKQuRKu5wSUj/5HDifDPQGN3zfwRWW
	 Hf5ylHYnbvKBMHlZ2CVaKJ4o/j8VMQZZFaQBXhbivgUMm30LyBnqbsofA+3w3jP7YP
	 4Uja0WvXXOvFiWGn3EXIEvKORlhzrkPR9t3mzGt8zh5mqdUehj1hGI1Juk3PduCc9e
	 5FbBochy7p6fA==
Date: Sun, 7 Sep 2025 11:56:38 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Santos <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, lars@metafoo.de,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 marcelo.schmitt1@gmail.com, jonath4nns@gmail.com
Subject: Re: [PATCH v3 4/4] iio: adc: ad7768-1: add support for ADAQ776x-1
 ADC Family
Message-ID: <20250907115638.308729ef@jic23-huawei>
In-Reply-To: <aLsclc2WHsbR1jfa@smile.fi.intel.com>
References: <cover.1757001160.git.Jonathan.Santos@analog.com>
	<6228c10d731b6946a68e1c3c95643065cc81329a.1757001160.git.Jonathan.Santos@analog.com>
	<aLsclc2WHsbR1jfa@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable


> > +static void ad7768_fill_scale_tbl(struct iio_dev *dev)
> > +{
> > +	struct ad7768_state *st =3D iio_priv(dev);
> > +	const struct iio_scan_type *scan_type;
> > +	int val, val2, tmp0, tmp1, i;
> > +	struct u64_fract fract;
> > +	unsigned long n, d;
> > +	u64 tmp2;
> > +
> > +	scan_type =3D iio_get_current_scan_type(dev, &dev->channels[0]); =20
>=20
> Is it usual patter in IIO? Otherwise it can be written as
>=20
> 	scan_type =3D iio_get_current_scan_type(dev, dev->channels);

=46rom a semantic / readability point of view I'd keep it referencing
the first element.  We are querying the scan type of one specific
channel, rather than the array that is behind dev->channels.

>=20
> > +	if (scan_type->sign =3D=3D 's')
> > +		val2 =3D scan_type->realbits - 1;
> > +	else
> > +		val2 =3D scan_type->realbits; =20

