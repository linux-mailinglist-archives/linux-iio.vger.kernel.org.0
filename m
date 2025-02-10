Return-Path: <linux-iio+bounces-15295-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D77A2F866
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2025 20:16:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4972F188A76F
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2025 19:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1723C25743F;
	Mon, 10 Feb 2025 19:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RHDgd4Cz"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C985125E468
	for <linux-iio@vger.kernel.org>; Mon, 10 Feb 2025 19:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739214969; cv=none; b=UKZtphZcafEixISsJkMA0AhN6kNBNrZ2i+bvz+olwnZUTG/m7/GVDOO94dImadJs/DMA8G3wXreZmiDFDdcgjunCoOL3o9YwhRkE3kSg0EvTz40NUgBXbOcm1afPxM03BEM9KhOhN2j+s/d/isPHiucti86NPeVTSQIw1uqOZm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739214969; c=relaxed/simple;
	bh=cqvFHN77Mdxc2zgUmX8KgPSZu4vO0lf9k4ft83JXc1w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TkdepjUnGPWAV7p6UZFPURG1/O/1/Un/NefEUDE9Jfq4wNZROJSTK1jZVS5ahtr428oyxkep9O6CrfXxDXASiMkLv4ZhJUTlWDLWg2dj/0lo17GTUwqjzGOk29Wk/DqYzKwWdaSmuSMtuTuR9gVtblPDrqmTgQ9UvlYIobGDCSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RHDgd4Cz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E9B9C4CEE8;
	Mon, 10 Feb 2025 19:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739214969;
	bh=cqvFHN77Mdxc2zgUmX8KgPSZu4vO0lf9k4ft83JXc1w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RHDgd4CzCBoV0A9kMepxNMcdU2UK15Dt//+5QaelAlq+pxjWau7raHncuMjqIX3xK
	 wnJjPqNBBGQxpKYPP83DyLdyqZtjhQlx6TfsMzgLdCUzdm0Ff0uMyQ8gfhCoNfDxKV
	 R5ftcrOjGD3L1DAlw1J4/iOz9jkZs65jO6k38WBfkRkxQaUPZGpVxoNWndu82dmJmm
	 6JcWKiCOosZJotIzmPn0bEtIHe2QWhNuwgOWrn4waBb/mvtKO+8XsQg1rTw0KOkT3D
	 1X623ebgE9TJCDYKxwfZ+NzWFAnCXaguPpLz71T67z76MVVV2+wgdWjBIzbDsT4XK4
	 gEAVFvQcXASeg==
Date: Mon, 10 Feb 2025 19:16:02 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>
Subject: Re: [PATCH] iio: adc: ad7124: Really disable all channels at probe
 time
Message-ID: <20250210191602.61041466@jic23-huawei>
In-Reply-To: <ujesqicqo6h2kwqsizryvtu2f37ug3ckhy5y4mek4mf4rtke66@ifb3wnefkjcj>
References: <20250204115023.265813-2-u.kleine-koenig@baylibre.com>
	<20250208151824.6433a876@jic23-huawei>
	<ujesqicqo6h2kwqsizryvtu2f37ug3ckhy5y4mek4mf4rtke66@ifb3wnefkjcj>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 10 Feb 2025 18:18:06 +0100
Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com> wrote:

> Hello Jonathan,
>=20
> On Sat, Feb 08, 2025 at 03:18:24PM +0000, Jonathan Cameron wrote:
> > On Tue,  4 Feb 2025 12:50:23 +0100
> > Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com> wrote:
> >  =20
> > > If one or more of the 16 channels are enabled and the driver is not
> > > aware of that, unexpected things happen because different channels are
> > > used than intended. To prevent that, all channels should be disabled =
at
> > > probe time. In Commit 4be339af334c ("iio: adc: ad7124: Disable all
> > > channels at probe time") I intended do that, however only the channels
> > > that are potentially used by the driver and not all channels are
> > > disabled since then. So disable all 16 channels and not only the used
> > > ones.
> > >=20
> > > Also fix the same issue in the .disable_all() callback.
> > >=20
> > > Fixes: 4be339af334c ("iio: adc: ad7124: Disable all channels at probe=
 time")
> > > Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com> =
=20
> >=20
> > I've applied this on the togreg branch of iio.git but you may need
> > to do a manual backport of the fix to get it on 6.14 once that's
> > released. =20
>=20
> hmm,
>=20
> 	$ git fetch git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git =
togreg
> 	From https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio
> 	 * branch                      togreg     -> FETCH_HEAD
>=20
> 	$ git log --oneline v6.14-rc1..FETCH_HEAD -- drivers/iio/adc/ad7124.c
> 	cf67879bd428 iio: adc: ad7124: Micro-optimize channel disabling
>=20
> the commit is not there. Did I understand something wrong?

Ah. I normally remember to say that tree initially goes out as testing for
0-day to take a first look.  Mind you I messed up one push last night so
may not even have made it there :(

It's on the togreg branch now.



>=20
> Best regards
> Uwe


