Return-Path: <linux-iio+bounces-13213-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD85C9E8515
	for <lists+linux-iio@lfdr.de>; Sun,  8 Dec 2024 13:46:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7313164350
	for <lists+linux-iio@lfdr.de>; Sun,  8 Dec 2024 12:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11728146D6E;
	Sun,  8 Dec 2024 12:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qIKFqoy0"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1B745BEC;
	Sun,  8 Dec 2024 12:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733661972; cv=none; b=s8bRuVwV0VaJ3E+TKaBU8P5DVivIfUM/O9TAbpYRQ2QM6jV7lkfkhoUjwfWYBoq+zdCFzK39V9tjrmm2O3VvXAa341/ARr9xign59uZzQeNLb/CJRZv0H/dBNIXpufIbI+dWPP+V69ff6dF6GOJtOeClgY1KtMULICWCFdStlk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733661972; c=relaxed/simple;
	bh=QcUDmv/uoF7KQvylfyIF5I5B5rx8ZSi/AbRSdtD90BI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eF5q47oK1NzoK+zzxnlDsZwIHKPGzau7E1opfTFcINSXeVi3ah8MsJ3lN8ussdLY1BsysdEJe4hLBS7C9rE/jWgiAuCWTL040BT/C85tEF2eU+SocQlJR65SWLxj8BPWTGfI5HkulbP2nngJguLvLAaC7/lWUUuyLiA/0AZdeJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qIKFqoy0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1D53C4CEDF;
	Sun,  8 Dec 2024 12:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733661972;
	bh=QcUDmv/uoF7KQvylfyIF5I5B5rx8ZSi/AbRSdtD90BI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qIKFqoy0gUrzGD18A9pNlxTcVhRT7dd08D9HiHjPlwQAMj3BjxeZk7KsVrW3z0Kxa
	 jvY6zdFsXjelv8UWUBLIwbNLsKDWoB0dsiKvawx/eb5DxaMHJyv8rhk3CoFEStZz6g
	 eMjnmBBEIvBNfdAbuloAj9O2CQxsZORlrQbqUd2GxD4dZQFj46pepD5EBtH1ZLovaU
	 5JlpP5dKoDuDfB0bY+JfaXLxgVMT6NEZNk0mfQUn1c4pT8ITDK5IyKMWKp+RsQus0T
	 KvJhpD1WWNIFfflqzcDsMXkHt3TzAjSwXMakQ/ABjr6R8wDE3eMcHWcfG83xOrLc5/
	 RZyJUaNLuTktQ==
Date: Sun, 8 Dec 2024 12:46:00 +0000
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
Message-ID: <20241208124600.3eb30813@jic23-huawei>
In-Reply-To: <CAHp75VeS3W7zjzsdSLQhmo6yj6ELyGR6muT==kAdXaZ0ZktDrw@mail.gmail.com>
References: <cover.1733504533.git.u.kleine-koenig@baylibre.com>
	<CAHp75VeS3W7zjzsdSLQhmo6yj6ELyGR6muT==kAdXaZ0ZktDrw@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 7 Dec 2024 01:12:56 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Fri, Dec 6, 2024 at 7:29=E2=80=AFPM Uwe Kleine-K=C3=B6nig
> <u.kleine-koenig@baylibre.com> wrote:
> >
> > Hello,
> >
> > here comes v6 of this series. Compared to v5
> > (https://lore.kernel.org/linux-iio/20241203110019.1520071-12-u.kleine-k=
oenig@baylibre.com)
> > the following things changed:
> >
> >  - Rebased to v6.13-rc1 + 64612ec9b909. (No changes needed here.)
> >
> >  - Add Ack from Conor to patch #3
> >
> >  - Fixed how R=CC=85D=CC=85Y=CC=85 is written. This was wrong before be=
cause the overline
> >    char must be added after the character that should get the overline,
> >    not before. I got that wrong because of
> >    https://bugs.debian.org/1089108. I would expect that now this is
> >    properly shown in most browsers, MUAs and editors.
> >
> >    I guess Andy still doesn't agree to write it that way. =20
>=20
> Yeah, I prefer a solid overline which Unicode simply incapable of, but
> HTML does.
> In any case the representation in this version is much better than in
> the previous version.
> I leave this up to Jonathan, but as I said an electrical engineer in
> me is not satisfied.

Fully agree it's unsatisfying, but I think it is clear enough what
is intended to go ahead as is.

Jonathan

>=20
> > Jonathan,
> >    would you decide here please? If you agree with Andy I suggest to
> >    replace it by #RDY. Andy suggested #RDY_N which I think is too far
> >    away from the original name. If you (also) like R=CC=85D=CC=85Y=CC=
=85, just keep it as
> >    is.
> >
> >  - Fix error handling in patch #8
> >    I just pasted "return ret" to all callers of
> >    ad_sigma_delta_clear_pending_event() before. Now the error handling
> >    matches the actual needs of the context.
> >
> >  - s/irq controller's capabilities/irq controller capabilities/
> >    as suggested by Andy for patch #8 =20
>=20


