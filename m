Return-Path: <linux-iio+bounces-24053-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D92F4B56135
	for <lists+linux-iio@lfdr.de>; Sat, 13 Sep 2025 15:44:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E48C1BC4ED8
	for <lists+linux-iio@lfdr.de>; Sat, 13 Sep 2025 13:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 304272EF64C;
	Sat, 13 Sep 2025 13:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ljCZ9mbr"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE0A1D554;
	Sat, 13 Sep 2025 13:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757771045; cv=none; b=DC3Quak/sKLT7/ItVXeR8lSnhlmtNdJAnaGQWTpmKm36FmLimf+R8/LxWyxd+7flbZuqZrgml8K7xirZl53Mqtvy+ZGniLDBL/8454dhJkKP/2hLkIMvcwTqUQRkBuW6rO1GUCgpNXT6eqAKC/i7zs5HA9n8ULMdiSTniNWQF9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757771045; c=relaxed/simple;
	bh=WoV8h+Wfw2GS7rHcWmWDG/yi9bb/+cUk4UN8ni6/wm0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=snRMHyYpiNt1vJWIn4nD6xmXqZKSpQ0bFC6HclwMtKTkW/CYArTzeY2sH71c/Kjgp3q63lqqGTODa8jEasqZvkWCfpdRov79E2yjRxE6yEpXDuyia9LNhWYrOtfPUdPK8u9pqH8mC7CYxybPf4Gz85J8xJDRQi/swS43oel5+R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ljCZ9mbr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB1B2C4CEEB;
	Sat, 13 Sep 2025 13:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757771044;
	bh=WoV8h+Wfw2GS7rHcWmWDG/yi9bb/+cUk4UN8ni6/wm0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ljCZ9mbrbejuTrhAGQIZtYzsBFRxi0JQzuIUKGonHkxB9/FrNPfoYPV/7lhFOiWdP
	 r14GnuPN1GHp79DNh6v4DtVkQgW1P4Cc06hsJFO7MjvMKAsk0Rc1l8WBeKrywKc/wR
	 clNB95OK3nX2zgT8G0Ws5+q4PXVFWKS33aIZevVQF8Zskyukr0yDJ01LF5jYCdqhCV
	 sbrjAK6/zEcAcObmi0oXwoaESXH/iA2+UM/ZwALUNCUgazV+mqGlERb86fbuzDwivx
	 tlE6kGdgsm13Q7cmMwFqRX5NkfIzDg11F8uOpXipLfpm9pmCAeWL2Xaxc8hoaL7jfk
	 tfBk/KClv82Kw==
Date: Sat, 13 Sep 2025 14:43:56 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] iio: adc: ad7124: add filter support
Message-ID: <20250913144356.13d8b9a0@jic23-huawei>
In-Reply-To: <CAHp75VdtVPzVxSLH=i+Hpze=mkTBvW_PVnhy-OT6xX47pGZdSg@mail.gmail.com>
References: <20250911-iio-adc-ad7124-add-filter-support-v2-0-b09f492416c7@baylibre.com>
	<CAHp75VdtVPzVxSLH=i+Hpze=mkTBvW_PVnhy-OT6xX47pGZdSg@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 12 Sep 2025 07:50:39 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Fri, Sep 12, 2025 at 12:42=E2=80=AFAM David Lechner <dlechner@baylibre=
.com> wrote:
> >
> > The AD7124 family of chips supports a number of different filter modes.
> > This series eventually gets around to adding support for selecting the
> > filter mode at runtime after first doing some cleanups to the existing
> > code.
> >
> > The first 3 patches are just updating things to use newer APIs.
> >
> > The 4th patch is addressing a shortcoming in the driver where the
> > sampling_frequency attributes were being limited to an integer value.
> >
> > The 5th patch is the one that finally adds support for filter_type
> > and filter_type_available attributes.
> >
> > And the last patch documents one new filter_type that was used that we
> > haven't seen before.
> >
> > This applies on top of "[PATCH v4] iio: adc: ad7124: fix sample rate for
> > multi-channel use" =20
>=20
> For non-commented patches
> Reviewed-by: Andy Shevchenko <andy@kernel.org>
>=20

There was a bit of fuzz on patch 6 but resolution looks good to me.
So applied whole series to the togreg branch of iio.git which I'll briefly
push out as testing.=20

