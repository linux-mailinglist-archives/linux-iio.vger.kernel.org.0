Return-Path: <linux-iio+bounces-25797-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E98A8C28E24
	for <lists+linux-iio@lfdr.de>; Sun, 02 Nov 2025 12:30:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9FB62341B54
	for <lists+linux-iio@lfdr.de>; Sun,  2 Nov 2025 11:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC8092C3278;
	Sun,  2 Nov 2025 11:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H746CUpj"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D172C3259;
	Sun,  2 Nov 2025 11:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762083005; cv=none; b=aEL8tWFfTtQDSu4VD3dIx9ppQcuGUYBDqm8miGmDPvWoVO6bOFuL4+x9bWdjapet3PX5LQxZZTozitfYQI4pVRmR7X3y4pE0SzlN0AkVZx3e7gJh4j9osR7L1eBJLoA/1lJIK2jNYkkNE6aosSslib75uQfMkOwhyuUSF/+Y12I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762083005; c=relaxed/simple;
	bh=o+GIszrgK37gDRUExY+iIcETWxl95C9JAng0v3yrITQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LRzNJ6RTJiX6QjkW2TvsUWl7WVXZvbY/2t9ZiWy6Df6Ymb2LwS4vXgbodaQp7JHnO5GpoX+hJoZ/TunhVnO+7gX9gGzTBVhaei5PklhaSq/WdRK1wRDEnpVrcMkoyNTO/TqrnFnIfHwrUJtunAHYFValBjsTh7onjXcjiBFC3rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H746CUpj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B834C4CEF7;
	Sun,  2 Nov 2025 11:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762083005;
	bh=o+GIszrgK37gDRUExY+iIcETWxl95C9JAng0v3yrITQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=H746CUpjmYe8ZpQJgEprAJbzrvwO4cC7da0pnt+zPl1GC+voycWuzzUeA36DyqFh7
	 uUKEeIXuZDPjFE+Ck+h+uq7Q/99EGMOGa47HIbRxtbhVO/wkawimJrhXlTgXQPNQ6o
	 Rhgrhoc6IUZv9Cl02sqvo607YTz4IAfRwucpj5q6s2kxLQJfShZbCOC+VJYtO3EW3U
	 rC66wln/oIneDKHrloYrt+Dgw+7fL8jwEhvyucP9mg6ULU7+JaSUYGuW975S7AnhV/
	 r4nWhZWREaY1v6uSp/QukAEeUgBA5Alg+5aSRmI3kB29Fzsj5iElRGAiG3xqoxXQDV
	 cDi+r8074rtSA==
Date: Sun, 2 Nov 2025 11:29:58 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Francesco Lavra <flavra@baylibre.com>, Lorenzo Bianconi
 <lorenzo@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/9] iio: imu: st_lsm6dsx: remove event_threshold field
 from hw struct
Message-ID: <20251102112958.435688d5@jic23-huawei>
In-Reply-To: <aQNs8VVoStUJ6YHB@smile.fi.intel.com>
References: <20251030072752.349633-1-flavra@baylibre.com>
	<20251030072752.349633-7-flavra@baylibre.com>
	<aQMbb6BUBHQUXX9y@smile.fi.intel.com>
	<32a7741bc568243c8a19d691b922d9a8c2cba429.camel@baylibre.com>
	<aQNs8VVoStUJ6YHB@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 30 Oct 2025 15:49:37 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Thu, Oct 30, 2025 at 12:10:08PM +0100, Francesco Lavra wrote:
> > On Thu, 2025-10-30 at 10:01 +0200, Andy Shevchenko wrote: =20
> > > On Thu, Oct 30, 2025 at 08:27:49AM +0100, Francesco Lavra wrote: =20
>=20
> ...
>=20
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0*val =3D (data & reg->ma=
sk) >> __ffs(reg->mask); =20
> > >=20
> > > Seems like yet another candidate for field_get() macro. =20
> >=20
> > FIELD_GET() can only be used with compile-time constant masks.
> > And apparently this is the case with u8_get_bits() too, because you get=
 a
> > "bad bitfield mask" compiler error if you try to use u8_get_bits(). =20
>=20
> We are talking about different things.
> Here are the pointers to what I'm talking:
>=20
> - git grep -n -w 'field_get'
> - https://lore.kernel.org/linux-gpio/cover.1761588465.git.geert+renesas@g=
lider.be/
>=20
True that it will be a usecase for that, but given plan is to merge that th=
rough
a different tree in next merge window, it's not available for us yet.  Henc=
e would
be a follow up patch next cycle.

Jonathan



