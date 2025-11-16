Return-Path: <linux-iio+bounces-26261-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 47CD3C61815
	for <lists+linux-iio@lfdr.de>; Sun, 16 Nov 2025 17:07:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 741AA347A98
	for <lists+linux-iio@lfdr.de>; Sun, 16 Nov 2025 16:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B23A30C37C;
	Sun, 16 Nov 2025 16:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZlK0R4UJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7A623B63C;
	Sun, 16 Nov 2025 16:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763309231; cv=none; b=pdsAWUMO23J8NmoKO1oihu0v0CGMMraowS/jLcRURcBnlYlAoL2fLdv5+ocOvaG8iIWQqZ4lACHx4CmOkkekxy6M7wm0HcDEoryts7ZULNdnt5mWQAvacAwhbkaSVHtu3gLZNu3t97+yvSBd8he9zHD5zbRk+id0UqzYLCt0/38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763309231; c=relaxed/simple;
	bh=K878iBaE7XGaGTb7BzsrZT/a4sezd5ePLe4yGR05mB4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WuFGpJW0ySXoYwnX6XqEegAeVwBxEG8fTIKq9PohM21Nw+MBSFuEOJMht0XZuV3TJHYH5oOd3aNsbmn9jFP45fL1jKYco0AFpntzhiRWym33jLO9IfbHhcLZt0pbMf8V7+Bnwo7I38YOqEOMy3a0zhDWOl+sqyF8sbMQxhNfBjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZlK0R4UJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7D0FC116B1;
	Sun, 16 Nov 2025 16:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763309230;
	bh=K878iBaE7XGaGTb7BzsrZT/a4sezd5ePLe4yGR05mB4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZlK0R4UJfyKCja7bxyS531MemiftOHawEJGY+tk+SubZxqKSIODrDDt0ISBXbq8ug
	 F6eP5aQ3jgxgpFg9GCGegG9+wc3eymwcLCDZvLF3MRQS1icUfu6pQQfPapGDd6wza3
	 dDWmqjwW6IgouuHXcHMWBREdEQz9Ha77vlKY6C7V4WQZd4hOGXXg9pLsyWKVEi76on
	 qVTmFabTv8EId1L1+KqCK0GaVhFn36EgR/iVZ9c+s7EjoaIR/Q+TLXVO5PU5kZJnhO
	 /a44Z2K6okEAmclDEuJ/AE6DBm+QlhtR3FXJOukMgYoimy5EsguQK62kFPPVUu7FDm
	 656cl3wMXPnLQ==
Date: Sun, 16 Nov 2025 16:07:02 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: rodrigo.alencar@analog.com, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-doc@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 1/3] iio: frequency: adf41513: driver implementation
Message-ID: <20251116160702.1ac24a54@jic23-huawei>
In-Reply-To: <aRIVt5zpWmlBVjyh@smile.fi.intel.com>
References: <20251110-adf41513-iio-driver-v1-0-2df8be0fdc6e@analog.com>
	<20251110-adf41513-iio-driver-v1-1-2df8be0fdc6e@analog.com>
	<aRITLaJir-2IoclU@smile.fi.intel.com>
	<aRIVt5zpWmlBVjyh@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 10 Nov 2025 18:41:27 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Mon, Nov 10, 2025 at 06:30:38PM +0200, Andy Shevchenko wrote:
> > On Mon, Nov 10, 2025 at 03:44:44PM +0000, Rodrigo Alencar via B4 Relay =
wrote: =20
>=20
> ...
>=20
> > In any case, I stopped my review here, you have more than enough to fix.
> > Please, come next time with a tag from one whose name is in the MAINTAI=
NERS.
> > From now on it will be my requirement as a reviewer of IIO subsystem. =
=20
>=20
> And to be more clear on this requirement (for all submissions from @analo=
g.com
> and related): A name from approximately below list I want to see as Rb.
>=20
> 	Antoniu Miclaus <antoniu.miclaus@analog.com>
> 	Marcelo Schmitt <marcelo.schmitt@analog.com>
> 	Michael Hennerich <michael.hennerich@analog.com>
>         Nuno S=C3=A1 <nuno.sa@analog.com>
>=20
> (those people seems experienced and I have heard of / from).
>=20

=46rom Nuno's mail seems that in general Analog actually have a better
process for this than many (which is excellent to hear btw!)
RB tags that come before being posted to the list only really have
meaning if we know and have built up trust with the reviewers.
This is different to ones on the list where we can see what the
feedback was that has been acted on.

I'll note that ADI sometimes works with external companies, so
there are various other people who would work as well. Given
that may change over time I'll not call them out explicitly but
you can probably figure out who I mean.  I have no idea if they
also help with pre submission reviews though.

Note that Andy's request here is specific to Analog given they
have the folk to do it.  I don't want this sort of requirement
to apply to folk working for other companies who have a much
smaller presence in IIO!  (just for the record, as Andy was very
clear this was a request specific to Analog).

Jonathan

p.s. Bad luck Rodrigo for being the submitter who triggered this!
Looking forward to v2 - I'll probably not add more noise by
reviewing this version.


