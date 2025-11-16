Return-Path: <linux-iio+bounces-26258-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B69CC61775
	for <lists+linux-iio@lfdr.de>; Sun, 16 Nov 2025 16:28:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 24E144E7ECA
	for <lists+linux-iio@lfdr.de>; Sun, 16 Nov 2025 15:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E199830BBBD;
	Sun, 16 Nov 2025 15:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LLVRpGFG"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9830D47A6B;
	Sun, 16 Nov 2025 15:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763306891; cv=none; b=EnYeb2U7Pzem7sQtcTuDtFmNFfffJwj2m+40ElKQ9+bmFqCXPFW7UkaNcKpuBObOflECtmTpLxjdsKd2v4Rs4YK6vR2ZZ2V5kFTncm6R4zM/KStHkOB9WQv9IUWCYAMwZYvCjce6V/dFEixLMbbrHftGoNkP4LgzzGQVY+duOPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763306891; c=relaxed/simple;
	bh=eHDKPrX7KRnWZm+OR8f7bl05/2O+uD/lofEyZXDDCkM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FLaiHn/QYm5TVLP1ZGlzlNg3BXJixv/ot4FRcR1qkn4kVKzyJ6iAz/bDclT9TXernPv641GeC5mOKwhqj1axOQTThRY2raVTsVrqY4PyQpjCT40GiGb7PGmkPD7OWuDPxjZChkN/n/SRl+2vwajyCU4ZvTb+S0RueEWZLIzkS9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LLVRpGFG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52883C116D0;
	Sun, 16 Nov 2025 15:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763306888;
	bh=eHDKPrX7KRnWZm+OR8f7bl05/2O+uD/lofEyZXDDCkM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LLVRpGFGBGHIyUGHW6HaCMFTOEErZVn7BgmUm9twE0JOAk2v4oO7bHr/6Sudh4eGC
	 J4y8Ei9wx6WbMjFJ1WG29kRJaLIaPc+KYhGL2mLUDDn3cjqvKcViXehFlmZbM7Odx0
	 uS1K/wlSWPJ8N3WPUmcPd1hStkhqVzapN0NupN094AcjZYXtNhMCuXRtVCexdwB5p8
	 XKPw16bUyt6JBVOPdhrP1gXzSjjdTdroBoaq/B4LVO4HEnMj3IsnoB/pb5+szfHmWs
	 z3b4ktS7ZKq+brkkJSq3++slXdh6yngcF8djfEIZU0TOjOMEOZnadAlnA74Ib6zK+I
	 KFKAuSSslaF8Q==
Date: Sun, 16 Nov 2025 15:28:00 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Shi Hao <i.shihao.999@gmail.com>, Michael.Hennerich@analog.com,
 lars@metafoo.de, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: iio: adt7316: replace sprintf() with
 sysfs_emit()
Message-ID: <20251116152800.4c1849cc@jic23-huawei>
In-Reply-To: <CAHp75VdY7W8EgOfKuxtTALj777aVatxV5dqsxm688JTy=iVW2Q@mail.gmail.com>
References: <20251116101620.25277-1-i.shihao.999@gmail.com>
	<CAHp75VdY7W8EgOfKuxtTALj777aVatxV5dqsxm688JTy=iVW2Q@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 16 Nov 2025 13:08:07 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Sun, Nov 16, 2025 at 12:16=E2=80=AFPM Shi Hao <i.shihao.999@gmail.com>=
 wrote:
> >
> > Convert several sprintf() calls to sysfs_emit() in the
> > sysfs show functions, as it is the preferred helper and
> > prevents potential buffer overruns.
> >
> > No functional changes intended. =20
>=20
> I briefly looked at it and see no issues,
> Reviewed-by: Andy Shevchenko <andy@kernel.org>
>=20

Applied, but I will note that this driver is a long way from suitable
for moving out of staging and I would be surprised if more than
one or two of the lines changed in this patch make it through the
necessary refactors (should anyone actually have another go at
doing them).  Anyhow, I still think this is worth taking just to
reduce the noise of remaining instances of this.

I'd have deleted this long ago except I actually have one somewhere
and it one of the supported parts was still listed as suitable for
new designs when I checked not long ago.

ADI folk, I would like to hear if we should just delete this one.

Thanks,

Jonathan

