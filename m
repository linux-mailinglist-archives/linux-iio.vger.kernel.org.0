Return-Path: <linux-iio+bounces-26894-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6080BCAB6EA
	for <lists+linux-iio@lfdr.de>; Sun, 07 Dec 2025 16:48:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A7B7301099E
	for <lists+linux-iio@lfdr.de>; Sun,  7 Dec 2025 15:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF21C2F6912;
	Sun,  7 Dec 2025 15:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RkP85f3C"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2EE25DB12;
	Sun,  7 Dec 2025 15:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765122472; cv=none; b=Jg4XN2gms+WKYLKHGKDZElFY6/iOuM8FC+1O6cFkkCIyQmzRLVdbHefi+zHQcEAipqTnD/9jDL5XZIrg72EjUyECr50GnuTnrz21nXJ5Q42ugwWq3XCMPVywu1nt6WM8v14E2dFqq34mK+LzgmjGe6gBFX8dfH2fwwrSlSuXdx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765122472; c=relaxed/simple;
	bh=wjsoYS7nFJBNfjKw0P0blFLrfAAqhgLQYWfsuzAx060=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TifgwdFP7//Bxk1AkjodaTrZutxJfPH2ejR7CWAigXnfANm0ctXJxwjNqzpDOi+4ndERmerFR3aUfvHcLddsz2bId/HBGc0zGjYRfnUsE4NZqHx/KXZcAXbp+9gclvjPXEGU8qCXdA7O21Bb5L0i3vJFX6wn0TZgT4pDLValoZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RkP85f3C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75117C4CEFB;
	Sun,  7 Dec 2025 15:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765122471;
	bh=wjsoYS7nFJBNfjKw0P0blFLrfAAqhgLQYWfsuzAx060=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RkP85f3CYv8Qe6j2kSc9n59aniCpojQ4RxxJ5gKerim5cqmOge5t2mOk8bEW4EsrB
	 H29TmZxr11QL8z0n43TZRYwGHimmFyhBzO985Ee66d8/1pDIucmmANwJXlemvys9S2
	 JuPp+6SEIsTgnTC3wjL2P3ZyXKMWruPkJlqijzj4rxIPkaLW24aE3XK9z3a8V8u18i
	 XJtWeaPQN5nlFHpxKv4mFJrYAhn4c1MVS7qXvroYt+W7VJ/ahau71aotr8i74u+VIc
	 VWFifphEFK711STAqE2cix8MwXO1MRgm1q5rXcvwhAqISCMdNtVgEZ8b5L+tzb8lsQ
	 7ayVvM0rmbjHw==
Date: Sun, 7 Dec 2025 15:47:41 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Shrikant <raskar.shree97@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, heiko@sntech.de,
 neil.armstrong@linaro.org, skhan@linuxfoundation.org,
 david.hunter.linux@gmail.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] iio: proximity: rfd77402: Add interrupt handling
 support
Message-ID: <20251207154741.592890f5@jic23-huawei>
In-Reply-To: <CAHc1_P5pgBGiHpyNBGMf8yDKZttVG0XoC0Bb5mWCeGyKbc6q7Q@mail.gmail.com>
References: <20251126031440.30065-1-raskar.shree97@gmail.com>
	<20251126031440.30065-4-raskar.shree97@gmail.com>
	<aSatqG9UEqkH0Glw@smile.fi.intel.com>
	<CAHc1_P5pgBGiHpyNBGMf8yDKZttVG0XoC0Bb5mWCeGyKbc6q7Q@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 28 Nov 2025 21:36:43 +0530
Shrikant <raskar.shree97@gmail.com> wrote:

> On Wed, Nov 26, 2025 at 1:05=E2=80=AFPM Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> >
> > On Wed, Nov 26, 2025 at 08:44:40AM +0530, Shrikant Raskar wrote: =20
> > > Add interrupt handling support to enable event-driven data acquisition
> > > instead of continuous polling. This improves responsiveness, reduces
> > > CPU overhead, and supports low-power operation by allowing the system
> > > to remain idle until an interrupt occurs. =20
> >
> > ...
...

> Thank you for the detailed feedback. I will update the code as per
> feedback and will share the v2 of the patch.

Hi Shrikant

Small process points in the interests of efficiency.
1. Crop to only the stuff that is relevant...
2. Skip replying at all if you accept all feedback. It's noise.
   The place for that and thanks is in the change log below the --- in the
   next version of the patch (thus no extra emails for people to scroll thr=
ough!)

Thanks

Jonathan


>=20
> Regards,
> Shrikant


