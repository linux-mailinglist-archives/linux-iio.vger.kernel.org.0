Return-Path: <linux-iio+bounces-24051-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6048B5612E
	for <lists+linux-iio@lfdr.de>; Sat, 13 Sep 2025 15:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E4203B690D
	for <lists+linux-iio@lfdr.de>; Sat, 13 Sep 2025 13:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AF482ED16C;
	Sat, 13 Sep 2025 13:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SIzo6vQe"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04384285C8A;
	Sat, 13 Sep 2025 13:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757770821; cv=none; b=HHashdE1mnjEBSj3teWAPrWG/Nf6WZxPD9crHNngaTqKB15P94gJqe7pteqlhAkKvf+r0Hm4XQ8yA/bZvvufkaafLQWUdzC0VhYi56M5+kP2XbCzWLrVCU6Glws28Va12dnI0Dty2SOIDLwC9kzBHeoW+k+kKArfcrhWyjJk/Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757770821; c=relaxed/simple;
	bh=ZK8t2/Y5dzh3AWLi1X5IfyysOrLe0hKSX2Zyd0kpKBE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JVlLIz4xpG8GgJjHpZjTk9aBRaZI3ybqdAHZr/MqJwP7G4tCEuhOpt4YLbmSkJ10bKqisfcsHL0fSL+CI+mAhTofPfVcMiX3LrTzuDi7Fi8AL7zKut659VNC589SPV3qUKiNgbKv8vyROUNK8I7dIEh/E924gTzM2TCcPVjGzrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SIzo6vQe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1245C4CEEB;
	Sat, 13 Sep 2025 13:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757770820;
	bh=ZK8t2/Y5dzh3AWLi1X5IfyysOrLe0hKSX2Zyd0kpKBE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SIzo6vQequ/wa+aUPevcqNvHcU0EqBzT5ZMgvNV8S3q46kVtZmAvXtx/c3RoC+Oi/
	 HZF4jnbhFGucBPwGTWgTJu8qGxQ96e7C0zQQ1XbkNuNoizYQc3b/pkjBi0sZKqRBLI
	 fcKzizYls8e+XojntHya39vGt9W8ChD2EI81ajNSe9JkgwwJ3Xx+HWA6GOAlsGUGJN
	 n3CNu0tcQz1/LO1Q9MCt4TGZCXdhU2c32UzRvscJrONKlaR+gvtoVtvLeqxXiWDQJ/
	 AY8LJpEtJQjDOHa2fzkxUzYQ+uBjJr2tmxLtLaiLacego1o0frI3/odq3XpglqD0lt
	 g/9phX51xlXow==
Date: Sat, 13 Sep 2025 14:40:12 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: David Lechner <dlechner@baylibre.com>, Andy Shevchenko
 <andy.shevchenko@gmail.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/6] iio: adc: ad7124: use guard(mutex) to simplify
 return paths
Message-ID: <20250913144012.0e6befcb@jic23-huawei>
In-Reply-To: <aMRhfvi88aoWRZao@smile.fi.intel.com>
References: <20250911-iio-adc-ad7124-add-filter-support-v2-0-b09f492416c7@baylibre.com>
	<20250911-iio-adc-ad7124-add-filter-support-v2-3-b09f492416c7@baylibre.com>
	<CAHp75VdVUOxkKhiheujAK0gjk_GXGqQ0g=LhNDjZr-Of1gH=sQ@mail.gmail.com>
	<d5e53a9c-418c-4c33-bbf4-b7d49d523cf2@baylibre.com>
	<aMRVKZGPv4PwR8-o@smile.fi.intel.com>
	<6dee1849-45f0-47c8-b29e-8057dee44b6a@baylibre.com>
	<aMRhfvi88aoWRZao@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 12 Sep 2025 21:07:58 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Fri, Sep 12, 2025 at 12:41:08PM -0500, David Lechner wrote:
> > On 9/12/25 12:15 PM, Andy Shevchenko wrote: =20
> > > On Fri, Sep 12, 2025 at 09:19:36AM -0500, David Lechner wrote: =20
> > >> On 9/11/25 11:39 PM, Andy Shevchenko wrote: =20
> > >>> On Fri, Sep 12, 2025 at 12:42=E2=80=AFAM David Lechner <dlechner@ba=
ylibre.com> wrote: =20
> > >>>>
> > >>>> Use guard(mutex) in a couple of functions to allow direct returns.=
 This
> > >>>> simplifies the code a bit and will make later changes easier. =20
> > >>>
> > >>> From this and the patch it's unclear if cleanup.h was already there=
 or
> > >>> not. If not, this patch misses it, if yes, the commit message should
> > >>> be different. =20
> > >>
> > >> cleanup.h is already there. I'm not sure what would need to be diffe=
rent
> > >> in the commit message though. =20
> > >=20
> > > I expect something like "finish converting the driver to use guard()(=
)..." =20
> >=20
> > cleanup.h was previously included for __free(), so the guard() stuff
> > is all new. =20
>=20
> Okay, then something like "Cover the lock handling using guard()()..."
> The point I'm trying to make is that "Use $FOO API/etc" without new header
> being included either:
> 1) missing inclusion (proxying);
> 2) start using of a new API from the library/header that we already use f=
or
> another API, but without mentioning that.
>=20
I went with the far from subtle solution of adding a line to the commit log
that says

cleanup.h is already included for prior use of __free()

Seemed like that would be enough for Andy's request and so I added
his tag (as given to the cover letter).

Jonathan




