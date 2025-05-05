Return-Path: <linux-iio+bounces-19094-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54AF2AA935D
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 14:38:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44A517A74D3
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 12:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0929B2505A5;
	Mon,  5 May 2025 12:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H077gSzp"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEABE248897;
	Mon,  5 May 2025 12:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746448690; cv=none; b=ieJk0/UspN9hD013uQIIyUjXWzJlcxGOXY5yvhcgVdNF7wqfSkocCxS+AwR/L4UMJqrjwMJckVuV0fFh7ZO86Y8Z+07vXGUhQYT4sS/ouhPvO0SQXX41csh7ocZvKOOtLaJ2li5/nPU3/PTiL8LOtRQCSaSPTG2FTomJVR6ha+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746448690; c=relaxed/simple;
	bh=pNKt63DAopnZz3ckHH1rNHOQ37qCZEqQN5j2J8gBEfs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ahvXR9XFIZ1KkMJ7R+Qs0tJgWc11m/Ydts1MzdAyt/1Nl85lQRfOff7LbM3kfFb749Rv1D0aOowfo94y3f92sfKfIpl1YRwPs4/9kshBXk1fiMoYRQwuHbwPtD4JzvkTiYqPJaGlDHFw79Um1zOrYIxZV7AlKAqFDYKLeNMKWwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H077gSzp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEE0EC4CEE4;
	Mon,  5 May 2025 12:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746448690;
	bh=pNKt63DAopnZz3ckHH1rNHOQ37qCZEqQN5j2J8gBEfs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=H077gSzpF+u0QZypF42hhWqjkg43DHzSf97qFTCF27gB6y5itOd83W1Cv/jaMo67/
	 Q2D+fHsonUlCEuP/8jUvEwkgSSiyuH4d8JyOYamr7XbDasCsplbPXx79b4NC+wihRN
	 li65eKU5FaRrOUNB9yk0cxYOy++PLMfW9e6qdKcDC3DMdcHI3hM7P8fBQpYUQV39t4
	 XUBruGHkiTY08Ksi91crQLagdcbJXVARkq0MZyvrloiy5ixmf2Y/ij/qZ3/5zTBuT3
	 MsVSxU72JAt4U1dSVlCESHOtd8ojdeyhj7eW7+gyk/Scz1gISXOwyVePJjzQSdhl4w
	 2Mfqpio4brH7Q==
Date: Mon, 5 May 2025 13:38:01 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Nuno Sa
 <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, David Lechner
 <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] iio: dac: adi-axi-dac: fix for wrong bus read
Message-ID: <20250505133801.372738d7@jic23-huawei>
In-Reply-To: <zca24hgtpycx3l2knyqdt3eu7mfyulzxjphsypae2jzxjgvbsu@2kslj4tcihv4>
References: <20250409-ad3552r-fix-bus-read-v2-0-34d3b21e8ca0@baylibre.com>
	<ac50109f06d7191549a91779028aca6d639998cc.camel@gmail.com>
	<zca24hgtpycx3l2knyqdt3eu7mfyulzxjphsypae2jzxjgvbsu@2kslj4tcihv4>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 5 May 2025 13:33:16 +0200
Angelo Dureghello <adureghello@baylibre.com> wrote:

> Hi Jonathan,
>=20
> asking info about this patch.
>=20
> As explained, would not do anything else here, please let me know if it c=
an
> be accepted or how to proceed.
I've queued up patch 1 as a fix.  Patch 2 will need to wait on that.

>=20
> Thanks a lot,
> angelo
>=20
> On 09.04.2025 14:57, Nuno S=C3=A1 wrote:
> > On Wed, 2025-04-09 at 11:16 +0200, Angelo Dureghello wrote: =20
> > > This patchset is intended to fix a random wrong chip ID read, or a
> > > scratchpad test mismatch, tests done in the ad3552r-hs driver probe. =
The=20
> > > bus "read" operation must always check for busy flag before reading.
> > >=20
> > > First patch reorganizes a bit the busy-wait polling code, second patch
> > > fixes the wrong bus read occurence.=20
> > >=20
> > > NOTE: due to ongoing changes in adi-axi-dac.c, this patch is intended=
 to be
> > > applied after the linked "ramp generator" patch.
> > >=20
> > > Link:
> > > https://lore.kernel.org/linux-iio/20250408-wip-bl-ad3552r-fixes-v4-0-=
b33c0264bd78@baylibre.com
> > > Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> > > --- =20
> >=20
> > LGTM,
> >=20
> > Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> >  =20
> > > Changes in v2:
> > > - invert patch order, fix first.
> > > - Link to v1:
> > > https://lore.kernel.org/r/20250408-ad3552r-fix-bus-read-v1-0-37add66a=
eb08@baylibre.com
> > >=20
> > > ---
> > > Angelo Dureghello (2):
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: dac: adi-axi-dac: fix bus read
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: dac: adi-axi-dac: use unique bus =
free check
> > >=20
> > > =C2=A0drivers/iio/dac/adi-axi-dac.c | 40 +++++++++++++++++++++++++---=
------------
> > > =C2=A01 file changed, 25 insertions(+), 15 deletions(-)
> > > ---
> > > base-commit: 6fb85f14853ddde06d57030c753168402bf69cd9
> > > change-id: 20250408-ad3552r-fix-bus-read-1522622fbd2b
> > >=20
> > > Best regards, =20
>=20


