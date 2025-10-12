Return-Path: <linux-iio+bounces-24995-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C1278BD08F6
	for <lists+linux-iio@lfdr.de>; Sun, 12 Oct 2025 19:52:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 943FD4E44E0
	for <lists+linux-iio@lfdr.de>; Sun, 12 Oct 2025 17:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCF212ED16C;
	Sun, 12 Oct 2025 17:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JNeDVYcs"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BECE2C187;
	Sun, 12 Oct 2025 17:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760291546; cv=none; b=G/oyW7e2DVN63XGfRUb1/t34Yjbn3y9vaUnZI8EiE9O5aSlIrpS8Jo2NNc7raKU1kq5brCZ5NA4JVyWCMYgn3VBjtNDb0LnTM8q+mNjnF/bLxTRp93tJYlZQ8/bsz9OgnRAy4vRx7WrinCihc5sr+amghXhcrZoG5N6dca2vL6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760291546; c=relaxed/simple;
	bh=Kq7+TXsEp9MxTBtUIkkyGyKxLT5bS9KsBzxp+fFgEiM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WuCC3z2cu3cc1GCXjHCTu4vZJKESO3PDGd/wqBxoLVklYE7F0b9Vo5+X+a9rcP/vepb79hX//ZHKX518QS6yTt/kOfvX4ZkhcegvuMjZj89Hh7U7lYP2kjQKuDPQevmol9WYpRz93Q95kDayZw6fs4UQelqH981GMNBIA/fj0cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JNeDVYcs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 999C0C4CEE7;
	Sun, 12 Oct 2025 17:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760291546;
	bh=Kq7+TXsEp9MxTBtUIkkyGyKxLT5bS9KsBzxp+fFgEiM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JNeDVYcsLucu374qwIc98ky1coLXZn5eQ/oTPuVR2GsUY7LJ2777lIl+m9Xhvai55
	 8S565gVpx4K7tE+6XFtSVzcXpnGZd7lEJ9GDVGulPhuViFu/c9HtikUiIgPa3K/q+5
	 iA6RnsK1i6rz9fquGpxvX+MLSVW0coPh5IfvPsQsPOgXiT/6FXwKeEVjwAfphocVWH
	 n+iBt9oooIfpnAzmhf5BCoXPpoRNbZiU08E6xoDDLW9yTUOkBNnF3reHnbAjs7zMkF
	 eaHkWx3UfZ8D3FIwahVha+A51KkPQB49qHVHybpEz1bIjXw0QEEP/SlS3Q7YJlPlGC
	 TCvU2hARt/qpw==
Date: Sun, 12 Oct 2025 18:52:16 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Shuhao Fu <sfual@cse.ust.hk>, Chen-Yu Tsai <wens@csie.org>, Jernej
 Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>,
 David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: Fix pm runtime clean-up in sun4i_gpadc_probe
Message-ID: <20251012185216.6268c201@jic23-huawei>
In-Reply-To: <CAHp75VdKLoCyYHZsEpkmXNJQ5QSpA_crrWR+MS4-=xmn=g9azw@mail.gmail.com>
References: <aOaWpVGZSCY6kN-6@homelab>
	<CAHp75VdKLoCyYHZsEpkmXNJQ5QSpA_crrWR+MS4-=xmn=g9azw@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 8 Oct 2025 19:57:47 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Wed, Oct 8, 2025 at 7:52=E2=80=AFPM Shuhao Fu <sfual@cse.ust.hk> wrote:
> >
> > In `sun4i_gpadc_probe`, in case of thermal register failure, the runtime
> > PM usage counter would not be decreased, resulting in a possible
> > inconsistency of runtime PM state.
> >
> > Fixes: b0a242894f11 ("iio: adc: sun4i-gpadc-iio: register in the therma=
l after registering in pm") =20
>=20
> This might fix this problem, but it doesn't fix the whole mess in the
> probe with devm/non-devm ordering.
>=20

Mostly this looks simple to fix.  Starting with devm_iio_map_register() ins=
tead
of the non devm version.
Then devm_pm_runtime_enable().  However, I have no idea why we need a pm_ru=
ntime_put()
in the exit path.  Maybe it's messing with the parent power?  There isn't a=
 matching
get.

Anyone have this hardware to hand for testing if we try to fix this up full=
y?

Jonathan



