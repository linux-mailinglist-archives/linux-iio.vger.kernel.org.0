Return-Path: <linux-iio+bounces-26060-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 215A7C43E93
	for <lists+linux-iio@lfdr.de>; Sun, 09 Nov 2025 14:32:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DA13C4E3058
	for <lists+linux-iio@lfdr.de>; Sun,  9 Nov 2025 13:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A52BA2F90E9;
	Sun,  9 Nov 2025 13:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X/9ggVnY"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0C42EBBA2;
	Sun,  9 Nov 2025 13:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762695130; cv=none; b=YohrbmjemdQkpxbBC9RYB9faMoZm9U+tTLmCtwrEeZgaoPozQRFc7hbI06rAIbtG+bcnss0WKxGjUd2AGLd4DpC/5NQAc/1o6OhagdBDYqAl7wRkD+fGzth8Mzf5MnU6XFZxfmSdQT7FAHJXVkZaeYFpiectVUFVw3WEncL4QVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762695130; c=relaxed/simple;
	bh=lLXWl0iKe8puYu/gNDI3xLALjlKpRvHj5srs/b9wr/k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uIEpmApn+VhRcLYCz6M4dlY+BNSjlmmrr1wQZIkNytDmCEK0t/OEIRHMq0sEzmfr6xZ6vDa6f33BPQV/ZW4Gsfij3CojTkTADJ+g2kgef4g8Pp+KEkMU5rYJwIMQT28qpI0N5rS0peS4N1Qf9yc9eE6/cZR7jxE1zjkCSWJizZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X/9ggVnY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28E65C4CEFB;
	Sun,  9 Nov 2025 13:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762695125;
	bh=lLXWl0iKe8puYu/gNDI3xLALjlKpRvHj5srs/b9wr/k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=X/9ggVnYiygB6K2t7fGG6P8QUPihNSSKyN2nvAUbFdiRC2AVsbEevBl5dNxi53BFe
	 L/Fh7Qv6fg56DbJRXUbS4trOeRpt1uafs6eTUfin+rvqUy0H0aXkjn5YusJSh1nUx3
	 vCgqgRChHRKNJdfVqLX3jluUyHE9Y1OivPvogXYv/fqpWQefnhW9LjSkXdM+Cz0sDQ
	 AtID+GUps9+5WXMOYSHlVxbfjjeHjBT/BaZxdFeL2rr7jRp2Ngbyp2c8NucAqTD9qd
	 K1YYFt2d5/hnfUE38ctNpzeDBPZYpjUZqYT/V5qhyU8Z60ovEU6+4AoI5qhq/cuJ/o
	 /lntp/Dco4jhg==
Date: Sun, 9 Nov 2025 13:31:56 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Francesco Lavra <flavra@baylibre.com>, Andy Shevchenko
 <andy.shevchenko@gmail.com>, Andy Shevchenko <andriy.shevchenko@intel.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/9] iio: imu: st_lsm6dsx: remove event_threshold field
 from hw struct
Message-ID: <20251109133156.31198e67@jic23-huawei>
In-Reply-To: <798a41fa-eda6-4f27-955c-82fdb61c2083@baylibre.com>
References: <20251030072752.349633-1-flavra@baylibre.com>
	<20251030072752.349633-7-flavra@baylibre.com>
	<aQMbb6BUBHQUXX9y@smile.fi.intel.com>
	<32a7741bc568243c8a19d691b922d9a8c2cba429.camel@baylibre.com>
	<aQNs8VVoStUJ6YHB@smile.fi.intel.com>
	<20251102112958.435688d5@jic23-huawei>
	<CAHp75Ve2+eU2X30EvC8dOuhEo3XZBwFrUH60itEYdYdGM7HvOA@mail.gmail.com>
	<25732d2be08156b4f55e97f5306d1fd080255ae7.camel@baylibre.com>
	<798a41fa-eda6-4f27-955c-82fdb61c2083@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 3 Nov 2025 08:53:44 -0600
David Lechner <dlechner@baylibre.com> wrote:

> On 11/3/25 3:34 AM, Francesco Lavra wrote:
> > On Sun, 2025-11-02 at 15:45 +0200, Andy Shevchenko wrote: =20
> >> On Sun, Nov 2, 2025 at 1:30=E2=80=AFPM Jonathan Cameron <jic23@kernel.=
org> wrote: =20
> >>> On Thu, 30 Oct 2025 15:49:37 +0200
> >>> Andy Shevchenko <andriy.shevchenko@intel.com> wrote: =20
> >>>> On Thu, Oct 30, 2025 at 12:10:08PM +0100, Francesco Lavra wrote: =20
> >>>>> On Thu, 2025-10-30 at 10:01 +0200, Andy Shevchenko wrote: =20
> >>>>>> On Thu, Oct 30, 2025 at 08:27:49AM +0100, Francesco Lavra wrote: =
=20
> >>
> >> ...
> >> =20
> >>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *val =3D (data & reg->mask)=
 >> __ffs(reg->mask); =20
> >>>>>>
> >>>>>> Seems like yet another candidate for field_get() macro. =20
> >>>>>
> >>>>> FIELD_GET() can only be used with compile-time constant masks.
> >>>>> And apparently this is the case with u8_get_bits() too, because you
> >>>>> get a
> >>>>> "bad bitfield mask" compiler error if you try to use u8_get_bits().=
 =20
> >>>>
> >>>> We are talking about different things.
> >>>> Here are the pointers to what I'm talking:
> >>>>
> >>>> - git grep -n -w 'field_get'
> >>>> -
> >>>> https://lore.kernel.org/linux-gpio/cover.1761588465.git.geert+renesa=
s@glider.be/
> >>>> =20
> >>> True that it will be a usecase for that, but given plan is to merge
> >>> that through
> >>> a different tree in next merge window, it's not available for us yet.=
=C2=A0
> >>> Hence would
> >>> be a follow up patch next cycle. =20
> >>
> >> Yes, but we can still define them here. Dunno either with #under or
> >> under (namespaced) names, but still possible to use now. =20
> >=20
> > OK, I will define an ST_LSM6DSX_FIELD_GET() macro. =20
>=20
> The macro should be named exactly `field_get()`, otherwise we will
> have to rename all of the callers later after the series adding it
> to linux/bitfield.h is merged. And it should have an
> `#undef field_get` just like the other patches that series. Then
> later, we only need to remove the #undef and #def lines and not
> change the rest of the code.

Carrying undefs for reasons we can't see in this code is for me something I=
'd
consider problematic.

For a case like this where we have just once instance I'd just prefer
either not using the macros, or namespacing them then replacing next cycle.
If there are loads of uses, then maybe on the undef nastiness.
These tend not to be common in drivers though and so far I've not seen
a case where the undef is worth doing (except maybe in the series adding
these new helpers where it is a very temporary thing)

Jonathan

