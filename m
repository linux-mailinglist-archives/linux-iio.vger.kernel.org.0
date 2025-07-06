Return-Path: <linux-iio+bounces-21376-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9523AFA424
	for <lists+linux-iio@lfdr.de>; Sun,  6 Jul 2025 11:48:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 807FA189A4AE
	for <lists+linux-iio@lfdr.de>; Sun,  6 Jul 2025 09:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 046581F4C99;
	Sun,  6 Jul 2025 09:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YF83uNm6"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44281D7E42;
	Sun,  6 Jul 2025 09:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751795300; cv=none; b=twC0XWB4LRfbjW8+4xbSrf4t/6m70JS+MVFsclDre1Xr/SOurwNCM3Uu9Qd0qDnxhIccIWePin01ErgIeJ6PWM8us+aNGjDW9g+DQcSPsI3e0JKfVM12AclINGQA9c0Gi8rkubwCsZqEGYWDXomR0Bz3Dfr/QejaZ3aQAPRTVEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751795300; c=relaxed/simple;
	bh=jZ+WCVb6SZNpUQreyV776dIYUC75xlQiGdLowlz7Gcs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dhIQ341NyQ6IDofYR2OQ4kG3CYJgf9RwY98sogKY3GIDXVtdq+hUrqMx8gneFLT0GO8kfnC6fxZI0yycbn9AFNmd28FxzxtZve29+nmyKNxsF7IDtT7WxQh3L6qV5I4Fd+MOE+LYPMqc6nFeJdAtYPp4OVymVRJM2xs6EhHSeRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YF83uNm6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B194DC4CEED;
	Sun,  6 Jul 2025 09:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751795299;
	bh=jZ+WCVb6SZNpUQreyV776dIYUC75xlQiGdLowlz7Gcs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YF83uNm6Qe4hYTxIAlXzJdy6xlO6RjhCjXOfXW7H+5YSA0A309fMzjLdMt3Rhqeo7
	 Q2fm4D7yavDZm03GwLdhpP4SJPpRQv0EjjE1CibUKwg48qPKI7UC28UB7pm7lRKI+9
	 YdGFq0tVIxTg0w/sl7KhiT9TD0NLvHHAB0m8gRNVKii4h5jCIrdB0fHww46fsqZl4w
	 LJYTSMI1s9ugaa4ZkBKZ61imv2+Bz5tvtnHP6eSNBS4OUoREtq6T2Weq72wha7DFBj
	 qwtQwM6A3dzQQ9dOtwEJLqsFlRRgKwi8s31r1Hd8VDaTPb2s1CtN3kxJOmS0WShUtR
	 GoMDJclV1MO8A==
Date: Sun, 6 Jul 2025 10:48:11 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>
Cc: David Lechner <dlechner@baylibre.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad7124: drop use of chip info array
Message-ID: <20250706104811.0bdbb26d@jic23-huawei>
In-Reply-To: <iqs5ktvnz7rkskwgnsdanhezfztdzckcr3e34afk5ece7ap7e6@my2rms6gcrkb>
References: <20250628-iio-const-data-5-v1-1-9e56c2f77979@baylibre.com>
	<20250629182531.6666f690@jic23-huawei>
	<pmqc36lr7filq6gu6bplg62qb4bx7cc7nx3ylsjuczv52cdlxr@2bdgzwobw3mv>
	<20250701183751.5701fb7e@jic23-huawei>
	<iqs5ktvnz7rkskwgnsdanhezfztdzckcr3e34afk5ece7ap7e6@my2rms6gcrkb>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 2 Jul 2025 08:56:54 +0200
Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com> wrote:

> Hello Jonathan,
>=20
> On Tue, Jul 01, 2025 at 06:37:51PM +0100, Jonathan Cameron wrote:
> > On Mon, 30 Jun 2025 10:15:14 +0200
> > Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com> wrote:
> >  =20
> > > [...]
> > > The patch looks fine for me. I remember having considered creating su=
ch
> > > a patch, too.
> > >=20
> > > Acked-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com> =20
> > Applied.  Thanks =20
>=20
> Huh, I'm surprised. Did you address "Current title kind of sounds like
> you stopped using any chip info at all!" while applying?
Good point. I forgot my own feedback.  I'll tweak it and push out again.

>=20
> Best regards
> Uwe


