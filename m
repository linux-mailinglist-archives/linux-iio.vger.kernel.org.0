Return-Path: <linux-iio+bounces-26847-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F0BA1CAAC6E
	for <lists+linux-iio@lfdr.de>; Sat, 06 Dec 2025 19:43:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D2B30300723E
	for <lists+linux-iio@lfdr.de>; Sat,  6 Dec 2025 18:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE262C21DF;
	Sat,  6 Dec 2025 18:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="REbDX2gA"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC5E2F9DAE;
	Sat,  6 Dec 2025 18:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765046625; cv=none; b=up0rC63VPa2AL4pKrYYF4ZwXZ+5lJ5/kj7Ci3ET9YOgvMNs34sQUSRStJ+VmTtrpOT/r/IMEX2tU/dyyGJtHh+cmA9Rx7XUn6k+wr4EDm3I5ywDr1IDqzag053pEoN6XVdDhZmAjwyvWkeikOVO8yYrM9Ae/YAH5MiVY1qeZW1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765046625; c=relaxed/simple;
	bh=oks7WzQ+nn6y7hpQRrGQghwi4ztP/0lpa+gM+6MZl88=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qm0XRYkEAiAluJRGROvRdKGdbfHgojHbMtRk8xCcipTtqGW2e08Vjps+/m5r+tcxwzLhHpCk6QFUlXmG0ORhkS/woo2VAWTR814DkKfhZYNSEf6UMwyiS7XZr9WaghaFD5ZaTKtuvne4eLAUp+TlUpVKXmEgLqZP9uScDa2dqrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=REbDX2gA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADCFDC4CEF5;
	Sat,  6 Dec 2025 18:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765046625;
	bh=oks7WzQ+nn6y7hpQRrGQghwi4ztP/0lpa+gM+6MZl88=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=REbDX2gA2QRwk9JRlBSoidd6CO0YewN73hgOMoodhC7D8+BfHlIsvf6cWkRZDjUYo
	 /lgPardJ8nNujrlxvKMK06zHY7CR1/E1rQxMQ6yu+FsofkH7nKUWOJ816vxaBpTZVK
	 HVaGYJHY9gZdn3PByUom6WKjwVbOw4I33iHMXoX1xY2XNYGyQ7pLf9JzUjhFe7tipf
	 EnZU2Xeha2w+QHSJSEsbdLH6A9Gz+8phswwIND7pM7axKSCOc4j/zn+A4hUz3JwKoj
	 aUToG4XB6bvX0JPyCSH0iq1JXzQIy3s2/3Tz6y5BHIOAc0avNBwvL5mzlVmxIqXqpp
	 z6qAE1b7SmyCQ==
Date: Sat, 6 Dec 2025 18:43:32 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Kurt Borja <kuurtb@gmail.com>, David Lechner <dlechner@baylibre.com>,
 Andy Shevchenko <andriy.shevchenko@intel.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Benson
 Leung <bleung@chromium.org>, Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Gwendal Grignou <gwendal@chromium.org>, Shrikant Raskar
 <raskar.shree97@gmail.com>, Per-Daniel Olsson <perdaniel.olsson@axis.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Guenter Roeck <groeck@chromium.org>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev
Subject: Re: [PATCH RFC 3/6] iio: core: Add cleanup.h support for
 iio_device_claim_*()
Message-ID: <20251206184332.426cc30f@jic23-huawei>
In-Reply-To: <CAHp75VfpG4PAG6rC5aFYAPLgnOZZzfJcGP6bMzKPMkMjpuymoQ@mail.gmail.com>
References: <20251203-lock-impr-v1-0-b4a1fd639423@gmail.com>
	<20251203-lock-impr-v1-3-b4a1fd639423@gmail.com>
	<3b80f8f3-c435-49f8-8c55-42568215bf0b@baylibre.com>
	<bf1c82f7-da25-47b6-846d-9f8427ee5790@baylibre.com>
	<DEPLQT84HBAO.2GAY5BHP05HNL@gmail.com>
	<CAHp75VfpG4PAG6rC5aFYAPLgnOZZzfJcGP6bMzKPMkMjpuymoQ@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 4 Dec 2025 19:36:28 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Thu, Dec 4, 2025 at 7:18=E2=80=AFPM Kurt Borja <kuurtb@gmail.com> wrot=
e:
> > On Wed Dec 3, 2025 at 5:34 PM -05, David Lechner wrote: =20
> > > On 12/3/25 3:50 PM, David Lechner wrote: =20
> > >> On 12/3/25 1:18 PM, Kurt Borja wrote: =20
>=20
> ...
>=20
> > > When I made the comments about keeping "mode" in the name, I forgot
> > > that DEFINE_GUARD_COND() only extends a DEFINE_GUARD(). So I understa=
nd
> > > if we need to make names that fit a certain pattern rather than what
> > > I suggested.
> > >
> > > Still would be nice to have:
> > >
> > > iio_device_claim_mode()
> > > iio_device_claim_mode_direct()
> > > iio_device_claim_mode_buffer()
> > > iio_device_release_mode()
> > >
> > > Just really annoying to rename iio_device_{claim,release}_direct()
> > > everywhere since we just did that. We could keep both names around
> > > for a while though to avoid the churn. =20

Definitely. Possibly indefinitely. I don't want a rename just to make
this facility easier to use as people won't see what is under the
ACQUIRE() anyway if we end up doing something like Rafael has done for
runtime PM where you don't call ACQUIRE() directly but use a runtime pm
specific macro (not sure if that will make this cycle or not, was
still being discussed when I went on holiday).

https://lore.kernel.org/all/3400866.aeNJFYEL58@rafael.j.wysocki/


> >
> > If we rename iio_device_claim_direct() (which is huge), maybe we can
> > pick shorter names and more descriptive names while at it? I was
> > thinking something like:
> >
> >         iio_mode_lock()
> >         iio_mode_lock_direct()
> >         iio_mode_lock_buffer()
> >         iio_mode_unlock() =20
>=20
> The device context is important, so at least iio_dev_mode_lock() (and so =
on).

If we are bringing lock into the name do we need to make it explicit which =
can fail?
Given you can't use them in the wrong place, maybe not.

iio_mode_lock_try_direct() or maybe iio_mode_lock_direct_try()?

This was less relevant when they all could fail.  Maybe we don't need to
bother given how rarely used the unconditional ones are.

I did like the claiming of mode terminology because it made it a little
more clear that we were taking a lock that was there for a purpose rather t=
han
a normal lock.  Also the fact it's a lock is an implementation detail I'd
rather not back into the ABI.

Maybe it's worth something inspired by Rafael's patch linked above?

#define IIO_DEV_ACQUIRE_DIRECT_MODE(_dev, _var) \
	ACQUIRE(iio_device_claim_direct, _var)(_dev);
#define IIO_DEV_ACQUIRE_BUFFER_MODE(_dev, _var) \
	ACQUIRE(iio_device_claim_buffer, _var)(_dev);

For the two more complex ones and fine using guard() for the rare
any mode variant.

Then we can have whatever naming we like for the helpers under
the hood as no one will ever use them directly.

Hohum. Hardest problems in computer science etc, coherency and naming. :)


>=20
> > Shorter names will also keep lines short when using guards. =20
>=20
>=20


