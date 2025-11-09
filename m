Return-Path: <linux-iio+bounces-26067-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A055C43F44
	for <lists+linux-iio@lfdr.de>; Sun, 09 Nov 2025 14:54:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 750A84E2884
	for <lists+linux-iio@lfdr.de>; Sun,  9 Nov 2025 13:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BA0B2FB0BD;
	Sun,  9 Nov 2025 13:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hK2di1b6"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0679E2D595A;
	Sun,  9 Nov 2025 13:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762696459; cv=none; b=h6P3qZP/0M/zgUG7xkiUHoEEVl9zsg3O0+fGJORz/f/uVcERQZ1RaOa3oLMm9JPEdFriPFjAEG4nwC49F35RGdogNHJNYo0FSKJ+lQI13RnjC8eguUGZjhLkqwdtIQaHhabW4z2UlmTMb1Yhbg9coRwskfPi3rzOX0jFw6uz8dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762696459; c=relaxed/simple;
	bh=KFkKhgYfszYArxrOuYDkMuo+8Yyuctg8d2EgwiHN4mg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jrsuGXyKWSnLgXTEbufXmWn4VdfbNzIG1l0bo0wdVySvp7w/4r9OsFoz0DZxb61kGOC4YJfPSso1YsmVcg3OhAZZ7RZhxpBtKeKIKqZQXaRBj2vaEsUAYtAOGM5AcmHCWtCSjJs+JDR1GxmeZ69RSz0N8H1vqA/9xzJ1m2LnQuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hK2di1b6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A718C4CEF7;
	Sun,  9 Nov 2025 13:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762696458;
	bh=KFkKhgYfszYArxrOuYDkMuo+8Yyuctg8d2EgwiHN4mg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hK2di1b66f2OH5pHdp4H8sX0ASPpG7ExLmFpVdnnyruiopqF0cKN6IHt4GiTaebiM
	 tt0l4Wo7E2vP7wYtx3TVJEQ3ZmnHBNlOnzFUYaT0eQxzU/ymJZvX9yuvqj51guHNBw
	 0yK7EPFcUvTPIh2oij4PREZ7kt2JSLkq58yzyPdrxFUaxSXq8fbewIJSDrwP3oSIwa
	 +hFPsEKo3YBv99v2xZE4b4kwPnbU3EBphGIxgER0SAtrnOSLl/Vywm7mvFJX0hpdJL
	 NSQZrl+8FtHPCtrRBaBfANnYcBUw9Mmm2e/Kt3MFkgTmr1hF8E6ic/bfTXUgkzaLYp
	 dFY01gw7egZWw==
Date: Sun, 9 Nov 2025 13:54:12 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Ma Ke
 <make24@iscas.ac.cn>, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 akpm@linux-foundation.org
Subject: Re: [PATCH v3] iio: trigger: Fix error handling in
 viio_trigger_alloc
Message-ID: <20251109135412.1b65f7da@jic23-huawei>
In-Reply-To: <b6d9db5e17bb3400888ee6e5934cfbe5fa2251e2.camel@gmail.com>
References: <20251107020200.6285-1-make24@iscas.ac.cn>
	<9aac9a66c02c691e073043f918fef055dca888e9.camel@gmail.com>
	<aQ3NHnL2rF0wkqeo@smile.fi.intel.com>
	<9e96f49f3903f704e16e8dde540507b10a978951.camel@gmail.com>
	<aQ44IB1b7AXun_qN@smile.fi.intel.com>
	<b6d9db5e17bb3400888ee6e5934cfbe5fa2251e2.camel@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 08 Nov 2025 10:26:21 +0000
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Fri, 2025-11-07 at 20:19 +0200, Andy Shevchenko wrote:
> > On Fri, Nov 07, 2025 at 04:48:03PM +0000, Nuno S=C3=A1 wrote: =20
> > > On Fri, 2025-11-07 at 12:42 +0200, Andy Shevchenko wrote: =20
> > > > On Fri, Nov 07, 2025 at 10:26:10AM +0000, Nuno S=C3=A1 wrote: =20
> > > > > On Fri, 2025-11-07 at 10:02 +0800, Ma Ke wrote: =20
> > > > > > viio_trigger_alloc() initializes the device with device_initial=
ize()
> > > > > > but uses kfree() directly in error paths, which bypasses the de=
vice's
> > > > > > release callback iio_trig_release(). This could lead to memory =
leaks
> > > > > > and inconsistent device state. =20
> >=20
> > ...
> >  =20
> > > > > > -free_descs:
> > > > > > -	irq_free_descs(trig->subirq_base,
> > > > > > CONFIG_IIO_CONSUMERS_PER_TRIGGER);
> > > > > > =C2=A0free_trig:
> > > > > > -	kfree(trig);
> > > > > > +	put_device(&trig->dev); =20
> > > > >=20
> > > > > Yes, device_initialize() docs do say that we should give the refe=
rence
> > > > > instead of
> > > > > freeing the device but I'm not see how that helps in here. Maybe =
initializing
> > > > > the
> > > > > device should be done only after all the resources are allocated =
so the code
> > > > > is a
> > > > > bit
> > > > > more clear... But doing it like you're doing just means that we m=
ight get
> > > > > into
> > > > > the
> > > > > release function with things that might or might not be allocated=
 which is a
> > > > > pattern
> > > > > I would prefer to avoid. =20
> > > >=20
> > > > The put_device() here is the correct (and must) thing to do indepen=
dently on
> > > > the preferences. The problem is that device_initialise() and follow=
ed calls
> > > > may do much more than just some initialisation. =20
> > >=20
> > > Well, I would argue against that (at least in the context the functio=
n is now
> > > implemented). To me, the right thing to do would be to move the device
> > > initialization
> > > code to this point:
> > >=20
> > > https://elixir.bootlin.com/linux/v6.17.7/source/drivers/iio/industria=
lio-trigger.c#L594
> > >=20
> > > trig->dev.parent =3D parent;
> > > trig->dev.type =3D &iio_trig_type;
> > > trig->dev.bus =3D &iio_bus_type;
> > > device_initialize(&trig->dev);
> > >=20
> > > Then we would not even need to think about put_device(). Like it is, =
using it,
> > > it's
> > > just prone to errors (I did mentioned a couple of things this patch i=
ntroduced If
> > > I'm
> > > not overseeing it) or we do need to have lots of care in the release =
function to
> > > make
> > > sure we don't mess up. To me that's a bad sign on how the code is arc=
hitectured.=20
> > >=20
> > > FWIW, the pattern you find for example in SPI is the natural one for =
me:
> > >=20
> > > You have a spi_alloc_device() [1] that initialises struct device righ=
t in the
> > > end.
> > > Above it, kfree() as usual. Then the callers, will indeed use put_dev=
ice() in
> > > their
> > > error paths.
> > >=20
> > > So the pattern to me is to do device_initialize() after all resources=
 of your
> > > device
> > > are allocated. So that after that point put_device() does not get you=
 into some
> > > odd
> > > handling in the release callback. =20
> >=20
> > Sure, this can be another approach. Whatever you, folks, prefer. But at=
 least
> > the mutex_destroy() (separate) patch can be issued and accepted indepen=
dently.
> >  =20
>=20
> Sure, agreed on that.
>=20
> > The bottom line is:
> > 1) the current code has an issue;
> > 2) the proposed fix has its own flaws;
> > 3) but the idea in the current approach at least small (if implemented
> > correctly) and makes sure that any new allocations won't be forgotten in
> > the error patch, nor in the ->release() callback.
> >  =20
> > > [1]: https://elixir.bootlin.com/linux/v6.17.7/source/drivers/spi/spi.=
c#L568 =20
>=20
> FWIW and unless I'm missing something there's nothing fundamentally wrong=
 in the
> current code (i.e any real bug). That said, I would ack a change that mov=
ed the
> device initialization code to it's natural place (at least in the way I s=
ee it).
Agreed.  I think this is simpler change. The other one that's be be happy w=
ith
would be to adjust the release to always work so we only have a put_device()
in here and no other error cleanup. Which means a flag or using whether the
irq_chip is set to split the two things currently under the single conditio=
n.

Jonathan

>=20
> - Nuno S=C3=A1


