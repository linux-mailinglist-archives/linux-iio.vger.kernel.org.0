Return-Path: <linux-iio+bounces-26848-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 34DAACAAC77
	for <lists+linux-iio@lfdr.de>; Sat, 06 Dec 2025 19:47:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DCA83304F643
	for <lists+linux-iio@lfdr.de>; Sat,  6 Dec 2025 18:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5532D27815D;
	Sat,  6 Dec 2025 18:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PZ3zjMnZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E172225775;
	Sat,  6 Dec 2025 18:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765046818; cv=none; b=qUu2D+e0BuB/9azgvs+m1mGE+EbLQRZcafCJX5/uFbeqEGpAnIv2ISg0jz2Rz3g1LwAAQp874JCN3d61+rDQAK6i87n31O4uGBMTkbsQkp/DmqchVCk/yxPbrSwledZZRnrxdLjAoLYNRio4ytDUNrKexDJqjEEhSscv896oFo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765046818; c=relaxed/simple;
	bh=OOlRetvkN7HhwzOsocOTKAHAW4VFqPkfzM0PjbhCEiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NxFo7UoqrQoiJYlGwMluHLHAglI2t7sf9wEJ1y/9K6lmoU2X3GTAo3NcIOaFTtK1c6aNmUYXgRE4RB42lqkI2yEkJOjlxxLIgH9H6G8Pnt26BXC0OAJR0z757Iv54t2qDxNbalY44xWietA8peiLbuXG8GnJsz7yK6n27Rz6bN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PZ3zjMnZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEAFBC4CEF5;
	Sat,  6 Dec 2025 18:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765046817;
	bh=OOlRetvkN7HhwzOsocOTKAHAW4VFqPkfzM0PjbhCEiQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PZ3zjMnZYFhJz+izJkLztOrPMbEFhkpogt46jyrrQsBbSAvO+LpFpmAQPXhVxd4Tl
	 hkcTYY3lTBPwpR96DVKorE97ZB+cDJPJ2QEjuOnoYeg3c8lGi6mS+u+PnVEORUUt5Y
	 FnL+L5e3j0dcn7zCbiC6PrXgng7WzYZYNAzAhvmxT1GiZwFUheDvzIZ8yaJeTnMAQl
	 FJiEU+8/jvcZkKMIMOJk0bPVIdQogaaBVSR8maV93gLAXbkFAmnBReE/UmOuqdQiRh
	 Luw8GqXGdg6NAqtrLRJGwUtpVlqS9ZPNmQxi5RfkwqwEL2hNguS2lw5Ya1DY19Eotw
	 tiPeo/uMsKmVw==
Date: Sat, 6 Dec 2025 18:46:45 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>, Kurt Borja
 <kuurtb@gmail.com>, Andy Shevchenko <andriy.shevchenko@intel.com>,
 Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Benson Leung <bleung@chromium.org>, Antoniu
 Miclaus <antoniu.miclaus@analog.com>, Gwendal Grignou
 <gwendal@chromium.org>, Shrikant Raskar <raskar.shree97@gmail.com>,
 Per-Daniel Olsson <perdaniel.olsson@axis.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Guenter Roeck <groeck@chromium.org>, Jonathan
 Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev
Subject: Re: [PATCH RFC 0/6] iio: core: Introduce cleanup.h support for mode
 locks
Message-ID: <20251206184645.51099254@jic23-huawei>
In-Reply-To: <CAHp75VdNjqZdy0+aSbBzn9CwEwHUhjwED+KRVqkdOMc_N+nX9w@mail.gmail.com>
References: <20251203-lock-impr-v1-0-b4a1fd639423@gmail.com>
	<77ca77847511e67066a150096a7af2fb84f1f25f.camel@gmail.com>
	<CAHp75VdNjqZdy0+aSbBzn9CwEwHUhjwED+KRVqkdOMc_N+nX9w@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 4 Dec 2025 17:07:28 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Thu, Dec 4, 2025 at 4:35=E2=80=AFPM Nuno S=C3=A1 <noname.nuno@gmail.co=
m> wrote:
> > On Wed, 2025-12-03 at 14:18 -0500, Kurt Borja wrote: =20
> > >
> > > In a recent driver review discussion [1], Andy Shevchenko suggested we
> > > add cleanup.h support for the lock API:
> > >
> > >       iio_device_claim_{direct,buffer_mode}(). =20
> >
> > We already went this patch and then reverted it. I guess before we did =
not had
> > ACQUIRE() and ACQUIRE_ERR() but I'm not sure that makes it much better.=
 Looking at the
> > last two patches on how we are handling the buffer mode stuff, I'm real=
ly not convinced...
> >
> > Also, I have doubts sparse can keep up with the __cleanup stuff so I'm =
not sure the
> > annotations much make sense if we go down this path. Unless we want to =
use both
> > approaches which is also questionable. =20
>=20
> This, indeed, needs a (broader) discussion and I appreciate that Kurt
> sent this RFC. Jonathan, what's your thoughts?

I was pretty heavily involved in discussions around ACQUIRE() and it's use
in CXL and runtime PM (though that's still evolving with Rafael trying
to improve the syntax a little).  As you might guess I did have this use
in mind during those discussions.

As far as I know by avoiding the for loop complexity of the previous
try we made and looking (under the hood) like guard() it should be much
easier and safer to use.  Looking at this was on my list, so I'm very happy
to see this series from Kurt exploring how it would be done.

Sparse wise there is no support for now for any of the cleanup.h magic
other than ignoring it.  That doesn't bother me that much though as these
macros create more or less hidden local variables that are hard to mess
with in incorrect ways.

So in general I'm very much in favour of this for same reasons I jumped
in last time (which turned out to be premature!)

This will be particularly useful in avoiding the need for helper functions
in otherwise simple code flows.

Jonathan



