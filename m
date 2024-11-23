Return-Path: <linux-iio+bounces-12527-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14CA19D6975
	for <lists+linux-iio@lfdr.de>; Sat, 23 Nov 2024 15:40:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83A8C1616BC
	for <lists+linux-iio@lfdr.de>; Sat, 23 Nov 2024 14:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7353208D0;
	Sat, 23 Nov 2024 14:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NatNFwUu"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FFD2566A;
	Sat, 23 Nov 2024 14:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732372821; cv=none; b=YHy0/QY0YMS3NSsz+9xxWMxz+dzRCL6CqD/geTnFrs73R0bYOo6KJeMCtjz+WpbMiF3vETlJX7znFMs44ZOlDdKY8gjPo1nVtAg3dS0rXVWQMVdVh43wcqUyl2ZX/rikDx0bs+HyGTcP1Dq88BBr8ylqrGxlqfelqV/OsxP9qUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732372821; c=relaxed/simple;
	bh=pzNGUf+6z/1XgHhq8qeQF67X0+VudCkDC0u/GMsWE/M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UXPyKX1u6k2JvQaOgQBzza22hWbm6TMJjz5D/0BGYtbwrUW0cmEsx62EK5+lBB2Ocq2C8shCSWNFf7EBbRH1t9G1JmLvRzaQoNoplgTh6LcWron5N2cKb0Oq+rR0bLr0LT7dAtLip2QE/hePBWrt8nvz9P/1FYnLs/YwTrvZRqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NatNFwUu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35FB6C4CECD;
	Sat, 23 Nov 2024 14:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732372821;
	bh=pzNGUf+6z/1XgHhq8qeQF67X0+VudCkDC0u/GMsWE/M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NatNFwUuhkd8QXIVCUMLkkgfZGT0pXlHMRq7Z1IgGtHoNA3YbFJuwWNJ27WDlIdlL
	 jrmXxEnatm1TjpnPl47ryyMpQcJwpYFqL9oDz/i2HNkYLKNgLohHdFIjNp4PL36hme
	 BVj8Kpl4FXh9hCqgO75Df3RIf6lmbYPgTsvrjD43B5UFOaTKKr29/x/qhi+jH9MATQ
	 gpox1EzJx7Nt+LkQki80jOrxZ70ZDkg4wuHwakOPFbqjNgm/sD27xkvxj8J2i4ftdR
	 pD5wYd7Qf+ek6k3bdYglrb8P1iMSuhkecL8H12m767ULYpVh+dcHovQjPpJlYwOWmY
	 Xie2/AQD89Kjg==
Date: Sat, 23 Nov 2024 14:40:10 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Aren <aren@peacevolution.org>
Cc: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>,
 Andy Shevchenko <andy.shevchenko@gmail.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai
 <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland
 <samuel@sholland.org>, Kaustabh Chakraborty <kauschluss@disroot.org>,
 =?UTF-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <trabarni@gmail.com>, Ondrej Jirman
 <megi@xff.cz>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, Dragan Simic <dsimic@manjaro.org>,
 phone-devel@vger.kernel.org
Subject: Re: [PATCH v4 4/6] iio: light: stk3310: use dev_err_probe where
 possible
Message-ID: <20241123144010.38871d3c@jic23-huawei>
In-Reply-To: <6jwurbs27slfpsredvpxfgwjkurkqvfmzccaxnfgtuh4aks3c6@ciapprv3wsex>
References: <20241102195037.3013934-3-aren@peacevolution.org>
	<20241102195037.3013934-11-aren@peacevolution.org>
	<ZyiIcDaANjxwtCz-@smile.fi.intel.com>
	<m7x526sv5krgt4t2whn5ykyktoz5u7ihsxv3qa5yue3ucbk6lb@37spwsmlcylm>
	<ZzEPACoblmcQD9yu@surfacebook.localdomain>
	<xubjmxig4luag27ifnmqmv3x3bvzhwczwvw34kw6tssaa2d24t@ysnqh5e3g7sz>
	<ZzHSE9Nrf4YySJrq@smile.fi.intel.com>
	<4ibd5tgpt3uzbmouqdiiv5pvfxebo5qsmgn3xh6rlb73qevatv@cajznxqnlca3>
	<6jwurbs27slfpsredvpxfgwjkurkqvfmzccaxnfgtuh4aks3c6@ciapprv3wsex>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 12 Nov 2024 18:11:37 -0500
Aren <aren@peacevolution.org> wrote:

> On Tue, Nov 12, 2024 at 11:15:54AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> > Hello Andy, hello Aren,
> >=20
> > On Mon, Nov 11, 2024 at 11:44:51AM +0200, Andy Shevchenko wrote: =20
> > > On Sun, Nov 10, 2024 at 04:34:30PM -0500, Aren wrote: =20
> > > > On Sun, Nov 10, 2024 at 09:52:32PM +0200, Andy Shevchenko wrote: =20
> > > > > Sun, Nov 10, 2024 at 02:14:24PM -0500, Aren kirjoitti: =20
> > >=20
> > > You can do it differently
> > >=20
> > > #define STK3310_REGFIELD(name)							\
> > > do {										\
> > > 	data->reg_##name =3D							\
> > > 		devm_regmap_field_alloc(dev, regmap, stk3310_reg_field_##name);	\
> > > 	if (IS_ERR(data->reg_##name))						\
> > > 		return dev_err_probe(dev, PTR_ERR(data->reg_##name),		\
> > > 				     "reg field alloc failed.\n");		\
> > > } while (0)
> > >  =20
> > > > #define STK3310_REGFIELD(name) ({						\
> > > > 	data->reg_##name =3D devm_regmap_field_alloc(dev, regmap,			\
> > > > 						   stk3310_reg_field_##name);   \
> > > > 	if (IS_ERR(data->reg_##name))						\
> > > > 		return dev_err_probe(dev, PTR_ERR(data->reg_##name),		\
> > > > 				     "reg field alloc failed\n");		\
> > > > }) =20
> > >=20
> > > I am against unneeded use of GNU extensions.
> > >  =20
> > > > > > replacing "do { } while (0)" with "({ })" and deindenting could=
 make
> > > > > > enough room to clean this up the formatting of this macro thoug=
h. =20
> > > > >=20
> > > > > do {} while (0) is C standard, ({}) is not. =20
> > > >=20
> > > > ({ }) is used throughout the kernel, and is documented as such[1]. I
> > > > don't see a reason to avoid it, if it helps readability. =20
> > >=20
> > > I don't see how it makes things better here, and not everybody is fam=
iliar with
> > > the concept even if it's used in the kernel here and there. Also if a=
 tool is
> > > being used in one case it doesn't mean it's suitable for another. =20
> >=20
> > Just to throw in my subjective view here: I don't expect anyone with
> > some base level knowledge of C will have doubts about the semantics of
> > ({ ... }) and compared to that I find do { ... } while (0) less optimal,
> > because it's more verbose and when spotting the "do {" part, the
> > semantic only gets clear when you also see the "while (0)". Having said
> > that I also dislike the "do" starting on column 0, IMHO the RHS of the
> > #define should be intended. =20
>=20
> Thank you, this sums up my opinion on this better than I could have (and
> some bits I hadn't considered).
>=20
> > So if you ask me, this is not an unneeded use of an extension. The
> > extension is used to improve readabilty and I blame the C standard to
> > not support this syntax.
> >=20
> > While I'm in critics mode: I consider hiding a return in a macro bad
> > style. =20
>=20
> Yeah... probably worse than any of the formatting options here. I guess
> the proper way would be to use devm_regmap_field_bulk_alloc, but that's
> well outside the scope of this series. Perhaps it would make sense to
> move the macro definition to just before the function it's used in so
> it's at least a little easier to spot?

It's only used 8 times.  I'd just get rid of the macro - which now
has even less advantage as the change here reduces the length of the
macro.

Normally I'd argue it should be a precursor patch, but here I think it is
fine to just do it in this patch to avoid a lot of churn.

No macro, no disagreement on formatting ;)

I'm not really sure why I let this macro in to begin with. I normally
push back on this sort of thing. Must have been a low caffeine day :(

Jonathan


>=20
>  - Aren


