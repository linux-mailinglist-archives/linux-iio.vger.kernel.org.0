Return-Path: <linux-iio+bounces-19892-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40EDBAC3502
	for <lists+linux-iio@lfdr.de>; Sun, 25 May 2025 15:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DE9716E659
	for <lists+linux-iio@lfdr.de>; Sun, 25 May 2025 13:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2114C1F3FF8;
	Sun, 25 May 2025 13:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ia+oqTs1"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14AA1E871;
	Sun, 25 May 2025 13:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748180947; cv=none; b=Epyjj9BRxujkiMRTx9uSPQp6Cdapr00nYDbA3oehEckusmUcdDBKqGF5Fm6Vj1xNk4QW1ybF8MkJcWzgQDqqS/MwCXKRo/iPO7uoThXC1igve1jTI9Rc/9mLR7VLFfYSSEqzsT1g3+Ky3vWcsh/oB8/1s7qU5SI8bb1mDnkb+Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748180947; c=relaxed/simple;
	bh=rI+A3aNRVcmASwIyloEtyNFIQE/GKPdjaYJH0ywF1LA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=McyE1DvwfCqThrtCzzkrUosOqlvr2wAPko/u0xzxLWP0353J5yGLSB5K6MUG/KgaTRuUPsq7KBY4W4cG+HmCYdOTfOQ8ZS4djB5lTUBnu4dml1JZAyoruJLJ2pMto+/y5nunzlMTNZxUKjxIxgQA26Bt3PcAJGziy9ZlQ/uLfi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ia+oqTs1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A991C4CEEA;
	Sun, 25 May 2025 13:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748180947;
	bh=rI+A3aNRVcmASwIyloEtyNFIQE/GKPdjaYJH0ywF1LA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ia+oqTs1pM9d0jft5HGckaPrJY1ebd3O8za5OXCaWVkKH9Z05eJAqUvGgjuoswfce
	 MVj3vd87MaLcM79/gb5vTfygj/UPEu8Cjq7w1czM1vCzIYC5GEtgLhgw5Y1j0yfhj2
	 pDrj7A9m2ZfqFoUxjr3eSvcGz0RwXkLVEofHPQd1oqwYDR6DlUtMktAugJfKjVEicF
	 14VLGjOwgdH/t5YmMZC8VIRG0LhyFnyxKLflUud6slct1w/4XMdDVSLvtu8Go7XqtS
	 GEvXvAjDRbkChlv1q0gSKEYdxxKfnJcXiR1LL/LPZXsmNXR/APEQEJrJ7Tz1O4fb5a
	 jgYUivMW1hJ+w==
Date: Sun, 25 May 2025 14:48:59 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Angelo Dureghello <adureghello@baylibre.com>, Lars-Peter Clausen	
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Nuno
 Sa	 <nuno.sa@analog.com>, David Lechner	 <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] iio: dac: adi-axi-dac: fix for wrong bus read
Message-ID: <20250525144859.4827acb8@jic23-huawei>
In-Reply-To: <a0a926291e2975572cfc1499eef930b0c762591f.camel@gmail.com>
References: <20250523-ad3552r-fix-bus-read-v3-0-310e726dd964@baylibre.com>
	<a0a926291e2975572cfc1499eef930b0c762591f.camel@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 23 May 2025 14:36:50 +0100
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Fri, 2025-05-23 at 11:00 +0200, Angelo Dureghello wrote:
> > This patchset is intended to fix a random wrong chip ID read, or a
> > scratchpad test mismatch, tests done in the ad3552r-hs driver probe. The
> > bus "read" operation must always check for busy flag before reading.
> >=20
> > First patch fixes the wrong bus read occurence, second patch reorganizes
> > a bit the busy-wait polling code.
> >=20
> > NOTE: due to ongoing changes in adi-axi-dac.c, this patch is intended t=
o be
> > applied after the linked "ramp generator" patch.
> >=20
> > Link:
> > https://lore.kernel.org/linux-iio/20250408-wip-bl-ad3552r-fixes-v4-0-b3=
3c0264bd78@baylibre.com
> > Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> > --- =20
>=20
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
Applied patch 2 - though note I'll be rebasing on rc1 once that is out so f=
or
now this will only appear as testing.

>=20
> > Changes in v3:
> > - fix axi_dac_wait_bus_free(), 0 must be checked on poll, not -1. Somew=
ay
> > =C2=A0 failed testing it here initially.
> > - Link to v2:
> > https://lore.kernel.org/r/20250409-ad3552r-fix-bus-read-v2-0-34d3b21e8c=
a0@baylibre.com
> >=20
> > Changes in v2:
> > - invert patch order, fix first.
> > - Link to v1:
> > https://lore.kernel.org/r/20250408-ad3552r-fix-bus-read-v1-0-37add66aeb=
08@baylibre.com
> >=20
> > ---
> > Angelo Dureghello (2):
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: dac: adi-axi-dac: fix bus read
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: dac: adi-axi-dac: use unique bus fr=
ee check
> >=20
> > =C2=A0drivers/iio/dac/adi-axi-dac.c | 40 +++++++++++++++++++++++++-----=
----------
> > =C2=A01 file changed, 25 insertions(+), 15 deletions(-)
> > ---
> > base-commit: 6fb85f14853ddde06d57030c753168402bf69cd9
> > change-id: 20250408-ad3552r-fix-bus-read-1522622fbd2b
> >=20
> > Best regards, =20


