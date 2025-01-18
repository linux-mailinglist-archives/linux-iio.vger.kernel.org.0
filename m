Return-Path: <linux-iio+bounces-14453-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3AA4A15D9A
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jan 2025 16:17:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 116BB1885A0A
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jan 2025 15:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5749F18FDC8;
	Sat, 18 Jan 2025 15:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WWqapLBP"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FDABEEA9;
	Sat, 18 Jan 2025 15:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737213464; cv=none; b=J3I/MFyMf/FPi4Fka+06qohd7KAjT8fCyqAyPDje24Hof0i637M9l0Z571gPVNRcwou5MVf3v8+XLBN++xsnRogDCn8aFgkw6I+NQLkgbXgdH/C+gEmrg5/mOvg5T+gx1reudW9VxOxf/i3pNTzkdQB+49UZ8vDjFhMDpg46Dvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737213464; c=relaxed/simple;
	bh=cH063n9K43HGxK+oE//9zQOjPqBkgojZ44cD3KPfjpo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ngKi63jMPfg4ER0bpdncWPQYFw3PgjmFnKt/BbVyRG7M+aUhXsqteYh8t67avxHQvy4MqE1UkEwIOWZAG6KuzA7p4wWvQqgPAUSbwOQQnCmT9872f84915DfLT9ZrQ4ahcDOwRFZeuUVfrAi42EJB4rxWlYglsMci+hqPm8ZAkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WWqapLBP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8AE6C4CED1;
	Sat, 18 Jan 2025 15:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737213463;
	bh=cH063n9K43HGxK+oE//9zQOjPqBkgojZ44cD3KPfjpo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WWqapLBPu0jFwnLqjZ84qyBSDB+B6hh1gU5TCrkc84weEDtk9zAs9x+8/lh5IbdPH
	 448lLI8aTFlQrvQp1LRBe1CVu3TJMjBaVtB4gQvo7NExMRxvpUgvoff0jPnVgGhNlJ
	 cHe56VO52N0f8uXtvsJA9yGyyFHC+6DmpczdnRoG/Xv5kD0Rf6zbiVzQJlAa/EhEcv
	 ROTX/my8BEupr1R8qsadLumHNiIffVkVpM5Ca1dzsFEKg4TFNoKCR5AFDcsuR/2okE
	 1D4OnQfgHR7/zaU8K0TUVbDt4t4vugWimm9RB5yZ6WdvWdU7iOYUdwbO7MoTI1hjl7
	 SdmNzd2G3295A==
Date: Sat, 18 Jan 2025 15:17:35 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Dumitru Ceclan <mitrutzceclan@gmail.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>, Michael Walle
 <michael@walle.cc>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Uwe
 =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>, Guillaume
 Ranquet <granquet@baylibre.com>
Subject: Re: [PATCH v4 0/2] iio: adc: ad7173: fix non-const info struct
Message-ID: <20250118151735.560fdb03@jic23-huawei>
In-Reply-To: <20250113-iio-adc-ad7313-fix-non-const-info-struct-v4-0-b63be3ecac4a@baylibre.com>
References: <20250113-iio-adc-ad7313-fix-non-const-info-struct-v4-0-b63be3ecac4a@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 13 Jan 2025 15:43:17 -0600
David Lechner <dlechner@baylibre.com> wrote:

> While working ad7124, Uwe pointed out a bug in the ad7173 driver.
> static struct ad_sigma_delta_info ad7173_sigma_delta_info was not const
> and was being modified during driver probe, which could lead to race
> conditions if two instances of the driver were probed at the same time.
> 
> The fix from v2 has already been picked up, so these are the remaining
> patches that can now be applied since the fix has made it's way back
> into the iio/togreg branch.
Looks good to me, so I've applied it to the testing branch of iio.git
to get some build coverage etc.
> 
> Guillaume, since there were significant changes in this revision, it
> would be nice if you could test again.
I'm happy to rebase until after rc1 so plenty of time for this.

Jonathan

> 
> ---
> Changes in v4:
> - Replaced patch that removes irq_line field with a different approach
>   that still looks up the IRQ by name.
> - Link to v3: https://lore.kernel.org/r/20250110-iio-adc-ad7313-fix-non-const-info-struct-v3-0-41e1c9cdd1a7@baylibre.com
> 
> Changes in v3:
> - Dropped first patch that was already applied.
> - Fixed compile error due to spurious rebasing artifact.
> - Rebased on top of latest iio tree and resolved conflicts.
> - Link to v2: https://lore.kernel.org/r/20241127-iio-adc-ad7313-fix-non-const-info-struct-v2-0-b6d7022b7466@baylibre.com
> 
> Changes in v2:
> - Fixed chip name in a few places.
> - Add new simpler patch for "fix" that gets backported.
> - Rebase other patches on this and incorporate feedback.
> - Link to v1: https://lore.kernel.org/r/20241122-iio-adc-ad7313-fix-non-const-info-struct-v1-0-d05c02324b73@baylibre.com
> 
> ---
> David Lechner (2):
>       iio: adc: ad7173: move fwnode_irq_get_byname() call site
>       iio: adc: ad7173: don't make copy of ad_sigma_delta_info struct
> 
>  drivers/iio/adc/ad7173.c               | 489 +++++++++++++++++----------------
>  drivers/iio/adc/ad_sigma_delta.c       |  11 +-
>  include/linux/iio/adc/ad_sigma_delta.h |   4 +-
>  3 files changed, 266 insertions(+), 238 deletions(-)
> ---
> base-commit: 56ea2bb4297338aa1c185696b287d384ec27c0d4
> change-id: 20241122-iio-adc-ad7313-fix-non-const-info-struct-92e59b91ee2e
> 
> Best regards,


