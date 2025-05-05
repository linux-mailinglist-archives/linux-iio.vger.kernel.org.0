Return-Path: <linux-iio+bounces-19104-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18220AA9712
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 17:14:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1004A16DD29
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 15:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F38B4C85;
	Mon,  5 May 2025 15:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="soRzzs7g"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A75625CC5F;
	Mon,  5 May 2025 15:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746458050; cv=none; b=UkZkRaRtTC4ypmjjzoytz10XC5k7ipe00LyKZkhaj0wvNpqNeNFyVQmdAEBpc+j3Kq3Po1DbdaYiebsOiZiCAHKH+IOCqXRfFy8FqhGewSDLv7ubyWoqcLEUmn5lkZ+19itOeKXO/kSpFbWZzg94kTbzvd7ng1yuuGRtxTd9BEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746458050; c=relaxed/simple;
	bh=fOWCYB261CKY3DGII2XxD4+KR0IwD6lIj2iPQ/x+u2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tA83j0ChnrVBiqJbHerBmunmxFPKzpySVVy5z9CHUTjCagCsfD1DL5r2+a4WmjVLC4exciZ+bcEjEK9AKIsZPbyc/I/Cq5yyZFuluLheWlYNpSXGf/34O1nnXABwKLWoqfCNkqAjaf7+CXB+uTylIjhsYRIcgcJY85rzWk8xsgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=soRzzs7g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC174C4CEE4;
	Mon,  5 May 2025 15:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746458049;
	bh=fOWCYB261CKY3DGII2XxD4+KR0IwD6lIj2iPQ/x+u2Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=soRzzs7g9IvNtjxqENbCb3reytQbYdGYBCy3jeIiULTpPPD7idv8FZKgGe4cvFehl
	 d1j8CwPvz5jrw88vd881eCTy704qPKs2EiuH6Pzo2DomYy2c1s5sy6EkYIjijbzvpy
	 hXSsa/f6/7mqz2SD61ck0GIv4bAagyqhK3EKd6B7UtA/6Y+B0QdPb+B1cdFqi4Tvym
	 p/DI9FkMMHml7NgIYSi4yIbwzjTFrGl3AQURQQAwdLY3aeSglM7ZC6d6JSe1A0841r
	 lS6KniAEoXNBuPWTz30OFDyl2tOVsGMADvvmRu4E3O3jyxqWKxpF9N4MYskGVdAhGJ
	 l/YWygzrz+f0g==
Date: Mon, 5 May 2025 16:14:02 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad7606: explicit timestamp alignment
Message-ID: <20250505161402.48da1ba7@jic23-huawei>
In-Reply-To: <efe160b5-5d91-4892-a0d6-ef73116fe071@baylibre.com>
References: <20250428-iio-adc-ad7606-fix-buffer-alignment-v1-1-88dfc57e5df0@baylibre.com>
	<d7f00a8c9d4da6f780c1ec067be2702fa0e60ea1.camel@gmail.com>
	<20250504155544.60fe3464@jic23-huawei>
	<efe160b5-5d91-4892-a0d6-ef73116fe071@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 5 May 2025 08:57:29 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 5/4/25 9:55 AM, Jonathan Cameron wrote:
> > On Tue, 29 Apr 2025 14:01:54 +0100
> > Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
> >  =20
> >> On Mon, 2025-04-28 at 21:17 -0500, David Lechner wrote: =20
> >>> Use struct with aligned_s64 timestamp to make timestamp alignment
> >>> explicit. Technically, what we have works because for all known
> >>> architectures, IIO_DMA_MINALIGN is a multiple of __alignof__(s64).
> >>> But this way, we don't have to make people read the comments to know
> >>> why there are extra elements in each buffer.
> >>>
> >>> ---   =20
> >>
> >> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com> =20
> > Applied to the togreg branch of iio.git and pushed out as testing
> > for all the normal reasons.
> >  =20
> Not sure how we all managed to this, but this is missing:
>=20
> Signed-off-by: David Lechner <dlechner@baylibre.com>
>=20

Oops.=20
Added.

