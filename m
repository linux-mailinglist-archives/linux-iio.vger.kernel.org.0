Return-Path: <linux-iio+bounces-13471-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D219F2009
	for <lists+linux-iio@lfdr.de>; Sat, 14 Dec 2024 18:15:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A20C1887F76
	for <lists+linux-iio@lfdr.de>; Sat, 14 Dec 2024 17:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86CF81A08A6;
	Sat, 14 Dec 2024 17:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f/LlHd4N"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BAD195F04;
	Sat, 14 Dec 2024 17:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734196507; cv=none; b=B4pDjGiaVFotNtQbhli+A9fAiGfd0ptBz0gjRwQQO6PZNnYLSgy0NyIDYqhkKpyiqdK7Us2P16+ztACnwKwLlt82nPHiw84hWo3Z86b8QeaAt0w7acoOqXaL7h3GdiRRmtB+s0seReWGShxTqGPk3pHL/R2MKlVWXn24LG5cnvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734196507; c=relaxed/simple;
	bh=RVkzdX+P2CC3aFC0ijyRyuo04py+Fl/2pQQDTtNsHNA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ccbXG9X4I2g8MmMVxtslScDD9pSQ6dTzZnW8fDwWKinftY03Sn0oZ/lFDzMY8DUsrHUhXPn2zVpnwQuD43Kv8VkWWfl15uPTlqOt12b//nLHfNYT3JbN6XVSISYUf1C869iwh4zpGFVKn6g3ibMRJHCIuzSf8Kf9I2pc+5BcF3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f/LlHd4N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBACCC4CED1;
	Sat, 14 Dec 2024 17:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734196506;
	bh=RVkzdX+P2CC3aFC0ijyRyuo04py+Fl/2pQQDTtNsHNA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=f/LlHd4NsMNNngwGKGNgxD7iEK4aa185ju/scyJq3vebPKsZNfl37NsQ0O45ZBkqs
	 Ju/lEU94W+6uMMwGdBE/yvSqpidBh/DOnqnEm98q6L25aCXdcE54RZGG/HiRmDoLEq
	 1zQDHv5s3aAHzdqxI3FuCNcPjMSB1pUYAMTW7XN+8mRXzSuX0JlkSnE2WgLTwOOv2M
	 pe9Wl+U/Pde+2WSi6E2fWQOw7BjD11z7gqP7jZuVJ2xiSqNa96E+oH4YqAC4TNaPcY
	 HaVbhaWk18Wa+Y/iLxuVTNCKQBm6WMzG+5i6Q9jXKYv7lptMBMtToh4zfzTX+l+C7G
	 eECI2Icz9dcgw==
Date: Sat, 14 Dec 2024 17:14:55 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>,
 Alexandru Ardelean <aardelean@baylibre.com>, Alisa-Dariana Roman
 <alisa.roman@analog.com>, Ceclan Dumitru <dumitru.ceclan@analog.com>, Conor
 Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>,
 devicetree@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org, Michael
 Hennerich <Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>,
 Renato Lui Geh <renatogeh@gmail.com>, Rob Herring <robh@kernel.org>, Trevor
 Gamblin <tgamblin@baylibre.com>
Subject: Re: [PATCH v6 00/10] iio: adc: ad7124: Various fixes
Message-ID: <20241214171455.2f9e5505@jic23-huawei>
In-Reply-To: <CAHp75Vd9bz5j5wzWEzmGQQby+s4HQNpm_Y_9evC9fxdWUucUnA@mail.gmail.com>
References: <cover.1733504533.git.u.kleine-koenig@baylibre.com>
	<20241208124427.3b90701e@jic23-huawei>
	<roit3rdw6a2wv65fpq7xuullbreyz463nch2n2xmjop3b2saoe@pbhm4kahmgsj>
	<20241211192459.430fd9d3@jic23-huawei>
	<cfw2bybkcyzis7y2xv3xxczv7qqyk2723ccb4sqearub557orn@7nqqzeuvokmz>
	<CAHp75Vd9bz5j5wzWEzmGQQby+s4HQNpm_Y_9evC9fxdWUucUnA@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 12 Dec 2024 13:44:40 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Thu, Dec 12, 2024 at 1:28=E2=80=AFPM Uwe Kleine-K=C3=B6nig
> <u.kleine-koenig@baylibre.com> wrote:
> > On Wed, Dec 11, 2024 at 07:24:59PM +0000, Jonathan Cameron wrote: =20
> > > On Mon, 9 Dec 2024 10:47:29 +0100
> > > Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com> wrote: =20
>=20
> ...
>=20
> > > A backport won't go anywhere until these are upstream.  At that point=
 if you
> > > want them, feel free to suggest backporting these and provide the cod=
e ;) =20
> >
> > I've not given up hope that you agree to backport also the rdy-gpio
> > change yet. I won't invest the work without knowing it's used in the
> > end. So I'll wait until the changes are upstream and you made up your
> > mind. Then if the need arises, I will help. =20
>=20
> AFAIK the process, any contributor may suggest a bacport of a few
> patches if the justification is good enough, I don't understand how
> Jonathan's view can be an impediment here (he may be a help, of
> course).
>=20

I could in theory object (as could any reviewer!) but on this one I
won't because I think it is justified, just not something to rush
into without some soaking time in upstream.

Thanks,

Jonathan

