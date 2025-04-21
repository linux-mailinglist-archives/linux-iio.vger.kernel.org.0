Return-Path: <linux-iio+bounces-18404-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD7A4A94FA8
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 12:58:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B54461894112
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 10:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8ED2620CF;
	Mon, 21 Apr 2025 10:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uZeJvyXE"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94C229D0E;
	Mon, 21 Apr 2025 10:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745233086; cv=none; b=Y0iUZEbAJLyJzB1iFhqyYOPYV4bVouHP0uATJfUeMWuN5hL+IlzN3EFyn3ksXxiZaxxOkVaJlyuLzuJ/61PL1hkW36W3cpfr602w74wxFzfZ8m+nM/BkgLid+q1ngTtPVBu+tf3elsvP20w7esqsfOXVRujelcsBiZ0Eu7Rh9Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745233086; c=relaxed/simple;
	bh=VKkhvIzb4IwSA2U7CEdUKRssmYxg7WXzdqf/Ba5HC3M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u6LeyLlkr6QA6vzPZ8moauGrXKONwqh6I9iWUNk3+pADSxX9DrcEe8dz8xfYR/tNacqRaXiTKsa7tszLAWVls1xaSED877W/1OvWrhdL6o5s1IMHLP/Zl3HiCoYwBIyaghxL09sSkoSBSFT3pA90HJbuoyp9nkyRskrZylZrBjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uZeJvyXE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A2A4C4CEE4;
	Mon, 21 Apr 2025 10:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745233086;
	bh=VKkhvIzb4IwSA2U7CEdUKRssmYxg7WXzdqf/Ba5HC3M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uZeJvyXEU2BwdRvYpXcCPdupCywYhPNg5VuwQxx9Oa3nSHdOrZH1e9s5hI30VHpe0
	 fBClfxHz2qip01DZbEIb4NxXP+LQMXsrTg5mMv3yBMDoHYvJ8xaMrbY4FqYP36DW1d
	 XrDtvyidoRuEo9YLrq5+LIMKkyjktIu31IJYiesEgn6k0QRkp8R9VMxa9yLjQXi8nH
	 N1H43wQTyNKUSrOCNNjivFQVMY+OfSAZpadk14H02vOgFGSm2W+nPXgn+wQ+1n/Pbf
	 rI8QdJZXpV1PTUUx5D7o36ZqVjicrOaVUm7O+iXnpQS8Is97nKwlwouuiLAHIginf5
	 QkFO+iOAJPFFg==
Date: Mon, 21 Apr 2025 11:57:58 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Antoniu Miclaus
 <antoniu.miclaus@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Mark Brown
 <broonie@kernel.org>
Subject: Re: [PATCH] iio: amplifiers: ada4250: use DMA-safe memory for
 regmap_bulk_read()
Message-ID: <20250421115758.62c16f94@jic23-huawei>
In-Reply-To: <9cdc7053-ae22-4ad5-801c-46df7398ebf9@baylibre.com>
References: <20250418-iio-amplifiers-ada4250-simplify-data-buffer-in-init-v1-1-7e7bd6dad423@baylibre.com>
	<CAHp75Vdxdbqu6qkbuo5y4jADOH_h9Re6m8icSj3Je4hnVsha0g@mail.gmail.com>
	<ed5c4b46-0b3f-4278-ba8e-6f6977f18429@baylibre.com>
	<aAO7Lw13xrEGmZLL@smile.fi.intel.com>
	<9cdc7053-ae22-4ad5-801c-46df7398ebf9@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 19 Apr 2025 13:07:25 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 4/19/25 10:03 AM, Andy Shevchenko wrote:
> > On Fri, Apr 18, 2025 at 02:09:04PM -0500, David Lechner wrote: =20
> >> On 4/18/25 1:58 PM, Andy Shevchenko wrote: =20
> >>> =D0=BF=CA=BC=D1=8F=D1=82=D0=BD=D0=B8=D1=86=D1=8F, 18 =D0=BA=D0=B2=D1=
=96=D1=82=D0=BD=D1=8F 2025=E2=80=AF=D1=80. David Lechner <dlechner@baylibre=
.com <mailto:dlechner@baylibre.com>> =D0=BF=D0=B8=D1=88=D0=B5:
> >>>
> >>>     Use DMA-safe memory instead of stack-allocated memory for the cal=
l to
> >>>     regmap_bulk_read() in the ada4250_init() function as this could b=
e used
> >>>     directly by a SPI controller.
> >>>
> >>> Sorry, but can you elaborate more on this? If driver doesn=E2=80=99t =
override the
> >>> callbacks the regmap SPI uses spi_write_then_read() which is supposed=
 to be
> >>> dma safe.=C2=A0 =20
> >>
> >> Ah, I didn't dig that far down. Will send a new patch that just cleans=
 up the
> >> unnecessary alignment and unaligned call. =20
> >=20
> > But do you have a real life issue with that? Coincidentally we discussed
> > similar case in another driver with colleague of mine, and he insists t=
hat it
> > might be still broken (somewhere).
> >  =20
>=20
> Some drivers that use regmap with SPI implement their own read and write
> callbacks if the default one doesn't work, so maybe something like that?
>=20

I asked Mark about this long ago. Maybe the guidance has changed, but the r=
equest
if my memory is correct was to treat bulk regmap accesses with the same car=
e wrt to
DMA safety that we treat direct use of the underlying bus accessors.
(unfortunately I have no idea what thread this was in!)

The reasoning I think was that it was an implementation detail whether
regmap copied the data or not for bulk accesses.  Back then I chased through
the SPI case and couldn't find a path that didn't bounce the data (though s=
ome
paths could have been made zero copy).

Anyhow, +CC Mark as maybe I remembered that wrong or his view has
changed!

Jonathan


