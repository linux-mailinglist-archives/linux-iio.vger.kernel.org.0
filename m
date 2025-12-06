Return-Path: <linux-iio+bounces-26863-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EB93ACAADE0
	for <lists+linux-iio@lfdr.de>; Sat, 06 Dec 2025 22:12:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B1F71306DC86
	for <lists+linux-iio@lfdr.de>; Sat,  6 Dec 2025 21:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A3F71D61A3;
	Sat,  6 Dec 2025 21:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YdqKhu/y"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC45BEEB3
	for <linux-iio@vger.kernel.org>; Sat,  6 Dec 2025 21:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765055532; cv=none; b=p/3Vncsk4kLZElH+F/ggrKUfhRFq8NRw08j1P7nOpyYue+iPvp84bXjrOfbkGjv7ESjDRWHXD+OLNMQiReVQ9TTQD2YW94qlf4lmHVuB3P7Go4MASLz60gz/0+DH8BxqDRZNhIkKw1aXXXvdMTEPL9OuWwrprTUEVcXDtlKR3cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765055532; c=relaxed/simple;
	bh=GNeY4N9ACHOU9NkcbRs8lWFh1xGNHjREvqWuWwpvhM0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G0TT4dnaEDicJgWaqFgRchRNlbTNTvDeyObkTcsdXx3nXZuyvpvPCACPB/i06SM+5zEvKtGdB/o/DyYlZrgcBBd4MStJHSGYOshFc+I1iMJwnKh/SFV30gXvTLJZtZ6hWbdESfzfSMyHQzn0KeNT+giLE/TzscU9fruY/ZWXpL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YdqKhu/y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09AEFC4CEF5;
	Sat,  6 Dec 2025 21:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765055531;
	bh=GNeY4N9ACHOU9NkcbRs8lWFh1xGNHjREvqWuWwpvhM0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YdqKhu/yfUIsDBWLm7J93uE3fCGJyi5UawvdpTUvkow2SM+nDhPZVrM3Pp6/I+nEn
	 jS4GD42vTxia0LZEUJmjvsypjvqmBlGYrbEJYsCtAobSV34oF6AiKNX7rM/ySY/4AL
	 wCoGQN3jkCZ8vOe8GzKWVMaXnak4gmI9u+cM58vpR2INwzmfT3OLBCuMX2+FbOcJl7
	 vLINdrGf+R6xYQT107k/KztgCy72e94oCXjAnKydWKDJoPeYTbd8R4zfFMHDhaIiAG
	 8dqk6wbzpExyT+NiMoyKJDHM0aK8ZJ4vN2jdrYcyibyNu6mW4dw9MF4yJCcOmIgV7Z
	 AXl+FH5rDCccg==
Date: Sat, 6 Dec 2025 21:12:04 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org, David Lechner
 <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH 2/6] iio: buffer-dma: Use the cleanup.h API
Message-ID: <20251206211204.3b486324@jic23-huawei>
In-Reply-To: <aTBkHIq-SL26fABN@smile.fi.intel.com>
References: <20251203-iio-dmabuf-improvs-v1-0-0e4907ce7322@analog.com>
	<20251203-iio-dmabuf-improvs-v1-2-0e4907ce7322@analog.com>
	<aTBkHIq-SL26fABN@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 3 Dec 2025 18:23:56 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Wed, Dec 03, 2025 at 03:11:37PM +0000, Nuno S=C3=A1 via B4 Relay wrote:
>=20
> > Make use of the cleanup.h API for locks and memory allocation in order
> > to simplify some code paths. =20
>=20
> ...
>=20
> > -	struct iio_dma_buffer_block *block;
> > -
> > -	block =3D kzalloc(sizeof(*block), GFP_KERNEL);
> > +	struct iio_dma_buffer_block *block __free(kfree) =3D kzalloc(sizeof(*=
block), GFP_KERNEL);
> >  	if (!block)
> >  		return NULL; =20
>=20
> In another thread I believe you referred to the 80 rule.
> Follow it then :-)
>=20
> 	struct iio_dma_buffer_block *block __free(kfree) =3D
> 		kzalloc(sizeof(*block), GFP_KERNEL);

This one is so common I will argue the shorter line form is better.

The other cases you have in some of these patches like the final
one are fine.

Rest of series looks fine to me but open question from Andy
on patch 3 and maybe a trivial patch description change for
that "it WARN() anyway" discussion.

Jonathan

>=20
>=20


