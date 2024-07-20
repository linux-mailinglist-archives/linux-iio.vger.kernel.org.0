Return-Path: <linux-iio+bounces-7742-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F25BB938187
	for <lists+linux-iio@lfdr.de>; Sat, 20 Jul 2024 15:44:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9627D1F2160A
	for <lists+linux-iio@lfdr.de>; Sat, 20 Jul 2024 13:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 203B012F596;
	Sat, 20 Jul 2024 13:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rx+5z6yS"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2C01E49E;
	Sat, 20 Jul 2024 13:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721483073; cv=none; b=HQwig32Dn041kX1tqqXRi6ASG4mBBXygpajOqkErKDxfv8ZO6zU6k0BrTdWv+qgl72WhdrB7HouFZFbujvP6ht0xCgMiDGwN5eK2LS86W11AcULCaUKt3BL0kDawA5fW5JLs/dpuQ7waejk+Hr57rIB/znlfirLOd34C3VeP0Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721483073; c=relaxed/simple;
	bh=0nxBhjhzC0uWC9PKc/Bn7F0qrzMq0kb4Mt0s139r7Aw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=emmCrmA4JnKgjO9untdJOAwHaqiz9yycD6PiYqX3oNt4Ge2w70E3xA7bLhz8deLEBr6CJig26ho98GaNqZumhSlRuNIm7iOQYwleIrvqoazV3thPQWT2dSdBzKksiBufTV0I7f9Ixeg+NqOVqC2MvLVt5pjMSQ4mrL1JXhzMvQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rx+5z6yS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86276C2BD10;
	Sat, 20 Jul 2024 13:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721483073;
	bh=0nxBhjhzC0uWC9PKc/Bn7F0qrzMq0kb4Mt0s139r7Aw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rx+5z6ySLP6i+RX9XKA1QzRV7SiokyhgspUhKJLu6rDgtGG9AM9JUMAioQFrAc/Fa
	 /auAnfD/DWqHl/qYZ8hbCxpJuz9dVXo6pbvUNUhzok0tz9JazQUfqriiymLE4iPnv6
	 Ef1yIBmeHXud4IkDZ1HgBNEFEfNsHLzH7eN/n97ZLPyttD78nbDBgOqilhywr9zJu0
	 qwxDKLYrIf8DeTQOSXYI7LlljNQxCo7FChAJdWz1lkptgv+aislFHXFppubddY2eUK
	 hTGpz96R+iJFKPQu2jBOLpGrSbiy2KCaGrcRIlbiUFU9h1jDXl9ANGtkGJYzfQGBsV
	 lR1jt8i0bBYdA==
Date: Sat, 20 Jul 2024 14:44:25 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Alisa-Dariana Roman <alisadariana@gmail.com>, Alisa-Dariana Roman
 <alisa.roman@analog.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Michael Hennerich <michael.hennerich@analog.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v7 4/4] iio: adc: ad7192: Add clock provider
Message-ID: <20240720144425.0770a412@jic23-huawei>
In-Reply-To: <5cf5e7d388813fca604b7fc5bdb3bb7296255217.camel@gmail.com>
References: <20240717212535.8348-1-alisa.roman@analog.com>
	<20240717212535.8348-5-alisa.roman@analog.com>
	<5cf5e7d388813fca604b7fc5bdb3bb7296255217.camel@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 18 Jul 2024 16:11:29 +0200
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Thu, 2024-07-18 at 00:25 +0300, Alisa-Dariana Roman wrote:
> > Internal clock of AD719X devices can be made available on MCLK2 pin. Add
> > clock provider to support this functionality when clock cells property
> > is present.
> >=20
> > Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
> > --- =20
>=20
> minor thing below you may consider if a re-spin is needed...
>=20
> Reviewed-by: Nuno Sa <nuno.sa@analog.com>

> > +static int ad7192_register_clk_provider(struct ad7192_state *st)
> > +{
> > +	struct device *dev =3D &st->sd.spi->dev;
> > +	struct clk_init_data init =3D {};
> > +	int ret;
> > +
> > +	if (!device_property_present(dev, "#clock-cells"))
> > +		return 0;
> > +
> > +	if (!IS_ENABLED(CONFIG_COMMON_CLK))
> > +		return 0;
> >  =20
>=20
> nit: This could be the first test to do. No point in calling
> device_property_present() if CONFIG_COMMON_CLK is disabled. FWIW, the com=
piler should
> be smart enough to sort things out but it would still be better (for read=
ability) to
> have this first.
>=20
Tweaked whilst applying.

Compiler probably can't figure it out as won't have enough visibility of the
implementation of device_property_present() to know it doesn't have side ef=
fects
deep in one of the indirect function calls that can generate.

Jonathan


> - Nuno S=C3=A1
>=20
>=20


