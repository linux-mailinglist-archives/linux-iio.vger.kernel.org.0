Return-Path: <linux-iio+bounces-10212-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26811991956
	for <lists+linux-iio@lfdr.de>; Sat,  5 Oct 2024 20:15:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0DB21F229EA
	for <lists+linux-iio@lfdr.de>; Sat,  5 Oct 2024 18:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 898BB158DA0;
	Sat,  5 Oct 2024 18:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sCjmzIh5"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B451798C;
	Sat,  5 Oct 2024 18:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728152133; cv=none; b=awJ1nIdmJxFy/TtBojhxqkOZ/dYBXK+vh4NQoN1IDo8Av3QeO0RKh/K5DKFNCeImsWAtAuenjNvza2aQ/r8tdQWgaI9IYzbdyXtGxX3bJHTR2S6K2opVuarqt+AefMi7dGT5zddgzkhf9nh7CjuSeG9i7XqZ8y0nbbngTbAqr2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728152133; c=relaxed/simple;
	bh=qAgZOPN9/dTABPQLItOCzbUsdyRIzcEXxe0YDfCPPT8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t2m/OLDNOzh+Y6VT2HtmVkC4QolrMjMaHsg9EtxrQPrFYVrgy3WhRpokLWZhnXjxSj9oA0ZunZC93ZvnOPsRlERpglVZIoi1Bh5UHrUEVGySrH2eyXXu0CavjXl+mvI1We48N/f0NFfmLAEC/ViosrKSKKnf3gyBR3j32tEfS/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sCjmzIh5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFDE8C4CEC7;
	Sat,  5 Oct 2024 18:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728152132;
	bh=qAgZOPN9/dTABPQLItOCzbUsdyRIzcEXxe0YDfCPPT8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sCjmzIh5++SY2jr3gzV7oNKsob7SBbN4GOOn8xW1aSMaCkH2nkxvUZYDZZqfJIDM4
	 Zch4fdeC7tY6zX9etvtD/w2JqChcBOy8gkzdYu6Np6TD8FIOQyjPDeofmUWAGO40t4
	 IXJ2d15rkMMcsLaIXGM5iELNwcIbW/ZquG7d1lp154E9IpGFSMjqRhqF9jRuMi0erF
	 6/4ICw6EnqRvmm48CrjE9L2tFg309AzzhRyAObmUNv1Q95eZ5JA16tQrs30OgLbxOy
	 ljn+4oPVPJi0LM/vd4bsCtwPKicDrToPCbkR8buTp9ZAuvifRkFYuEqJ+OvAd2g1+d
	 bI8KeQi8Oy36w==
Date: Sat, 5 Oct 2024 19:15:08 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Abhash jha <abhashkumarjha123@gmail.com>
Cc: linux-iio@vger.kernel.org, lars@metafoo.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] iio: light: vl6180: Add support for Continuous Mode
Message-ID: <20241005191508.16150a9d@jic23-huawei>
In-Reply-To: <CAG=0RqJNJNg9yydeKfpo87P6sYd5n6Xi0MoLz0OFQrXPgb8cFA@mail.gmail.com>
References: <20241004150148.14033-1-abhashkumarjha123@gmail.com>
	<20241004150148.14033-4-abhashkumarjha123@gmail.com>
	<20241005175932.00438b0f@jic23-huawei>
	<CAG=0RqJNJNg9yydeKfpo87P6sYd5n6Xi0MoLz0OFQrXPgb8cFA@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Sat, 5 Oct 2024 22:42:43 +0530
Abhash jha <abhashkumarjha123@gmail.com> wrote:

> > Hi Abhash,
> >
> > Some comments below.
> > =20
> Hi Jonathan,
> I will do the fixes and send a v3.
>=20
> I have a question though:
> The device has a 8 x 16-bit HW-buffer.
> I want to implement the HW buffer support. Where in this driver should
> I read the hardware buffer?

If it were a fifo there are lots of examples in tree, but those tend
to 'empty' on read. From your description I'm not sure this one does.

> How is that exposed to userspace? Is it even exposed?
> There is no buffer-full interrupt, It just has the latest 16 range
> measurements and
> latest 8 ALS measurements.

Ah. Can we tell if the data is new vs data we have already read?
=46rom a quick glance looks like you can clear it, so maybe we can use that
though we'll have to be careful about races.  Do we have to stop
continuous mode to clear it? Sort of looks like that's the case from
the description of the clear not occuring until a start_stop write.

However we'll have to dead reckon the timing without an interrupt.
That should be fine, as just configure it to max say 3/4 of the
time to fill it.

>=20
> There is also a SYSTEM_HISTORY_CTRL register, which configures the HW buf=
fer,
> like setting which data to capture (ALS/RANGE) as well as turning the
> buffer on/off.
> Where should all this configuration be done?
> Should it be default or have some sysfs attribute associated with it?

So if it were a conventional fifo it would  mostly be hidden behind the
software fifo and just act as an optimization of the data capture.
A few things are exposed though as can make a difference to how you configu=
re
the device such as the size of the hardware fifo and the hwfifo threshold
(affects latency of data capture).  However sounds like you don't have
that here.

So challenging feature to support.
>=20
> Thanks,
> Abhash


