Return-Path: <linux-iio+bounces-22805-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6383DB28DA2
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 14:25:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5000E5E24CF
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 12:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 255402D1900;
	Sat, 16 Aug 2025 12:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EW8PHnpg"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DB9218AD4;
	Sat, 16 Aug 2025 12:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755347140; cv=none; b=EEYhHDOutMNo+fOH5MiCG3CKZiaDBTsSQwUXPsOYTZP1nrZcO+JuxCaOZmSw2c9FW78zwW0IvWRw/YShUJymn2E3OwtVbMkOV8tOWbB3gms0wOLdwUKpnjHTjVev5tUxify0uAG+m/OQxw37xD0rsfJakCELz1VtlcZcx1iS9f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755347140; c=relaxed/simple;
	bh=oY+B/69Adbi0UwVW0u+fwOZzOEl8NwITqag5KhSbxfY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OaSmsGoO/VmYtqFDIpyhB6BhwplGBMUZ0YRpq5sAXAJbGpsFo+ilibN30ojQ6Cx7uE86F0g4kflzv9Tv9xjvGUsGGke6lTC4FSzFc7bK4JKzRl0IU3yyTn4VqxDy7688E8sD51KlnZpP+fQxR1OWg+uTXPOEIbW4C/weD+8GV8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EW8PHnpg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C147FC4CEEF;
	Sat, 16 Aug 2025 12:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755347140;
	bh=oY+B/69Adbi0UwVW0u+fwOZzOEl8NwITqag5KhSbxfY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EW8PHnpg2h2sn4euvj3mYUdJzPuA6sEy5cAqQLa2eDtTahTGPTAmfRzGjci/fcUCJ
	 r02u4iVTitqa8gBM+C2YTh3JkPRN3qFLAc0spYERVOXakyjk20lJXfjr1b9Obnv8kF
	 hDHfD3uCEClcrm9wt8+ioLBAI3a93OAanoPrRqE7g4fs7LoAKo2GeY9NLG1UKpl0vx
	 GNXddeU4gZHWTC8Xah7JMwcy7i2+SgWsnZZ9U1MgCaxa5Ky6LacuRagJQqC36MD2X7
	 sbnuFZ3tDh0uS6H7YTTcJq8OS+/nQvqOH6J9s7D8WRF0YYW0njYvQbStCZ6qCATw3h
	 er1Q2m9ogyTrw==
Date: Sat, 16 Aug 2025 13:25:28 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Andy Shevchenko
 <andy.shevchenko@gmail.com>, Matti Vaittinen <mazziesaccount@gmail.com>,
 David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Marcelo Schmitt
 <marcelo.schmitt@analog.com>, Javier Carrasco
 <javier.carrasco.cruz@gmail.com>, Tobias Sperling
 <tobias.sperling@softing.com>, Antoniu Miclaus
 <antoniu.miclaus@analog.com>, Trevor Gamblin <tgamblin@baylibre.com>,
 Esteban Blanc <eblanc@baylibre.com>, Linus Walleij
 <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Matti Vaittinen
 <matti.vaittinen@fi.rohmeurope.com>
Subject: Re: [PATCH] iio: adc: bd79124: Add GPIOLIB dependency
Message-ID: <20250816132528.29180c38@jic23-huawei>
In-Reply-To: <aJyEzsbYrwwzCdcL@smile.fi.intel.com>
References: <6837249bddf358924e67566293944506206d2d62.1755076369.git.mazziesaccount@gmail.com>
	<CAMRc=Mf75cangdeg7T4E0nAhJs_BTdLyCu6GcrCL8vJzzAkFWg@mail.gmail.com>
	<CAHp75VcY9JWGH3+HmmJQQtLLTLPvaZ1RJzmPZ1wFBM+gqRiTHw@mail.gmail.com>
	<CAMRc=McL04Sk9YRmimKAALyuDJc75vSJJuZQGWOP87Jv=o7cyw@mail.gmail.com>
	<aJyEzsbYrwwzCdcL@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 13 Aug 2025 15:27:58 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Wed, Aug 13, 2025 at 02:17:44PM +0200, Bartosz Golaszewski wrote:
> > On Wed, Aug 13, 2025 at 12:07=E2=80=AFPM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote: =20
> > > On Wed, Aug 13, 2025 at 11:40=E2=80=AFAM Bartosz Golaszewski <brgl@bg=
dev.pl> wrote: =20
> > > > On Wed, 13 Aug 2025 11:16:06 +0200, Matti Vaittinen
> > > > <mazziesaccount@gmail.com> said: =20
>=20
> ...
>=20
> > > > As for the former: it seems it's
> > > > a common pattern for the headers containing the "provider" part of =
the
> > > > subystem API, you'd get the same issue with regulators or pinctrl.
> > > >
> > > > I don't have a good answer, I'd just apply this as it's not a commo=
n issue
> > > > from what I can tell. =20
> > >
> > > If the GPIO functionality is optional (not the main one), the user
> > > should be able to compile it conditionally, in such a case it's either
> > > an ifdeffery in the code, or separate module with its own stubs. =20
> >=20
> > Honestly, it makes much more sense to factor out that optional
> > functionality into its own compilation unit that can be left out
> > completely for !CONFIG_GPIOLIB with a single internal registration
> > function being stubbed within the driver. =20
>=20
> That's what I suggested under "separate module with its own stubs" above.
>=20

I agree that's the long term ideal. For now I'm going to queue this fix
up and mark it for stable.  We can tidy up and make it optional again
as a follow up.

Jonathan

