Return-Path: <linux-iio+bounces-27889-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AAB09D3879C
	for <lists+linux-iio@lfdr.de>; Fri, 16 Jan 2026 21:34:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B4B6F303D694
	for <lists+linux-iio@lfdr.de>; Fri, 16 Jan 2026 20:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3672E2EACF2;
	Fri, 16 Jan 2026 20:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fK/K5+ux"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7352857CD;
	Fri, 16 Jan 2026 20:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768595645; cv=none; b=ZEbw4rJZgck+BTjhDQC9PqnEFf9bQ9sUz+ATay7KLEQUOZrgk/UUrKURdBsOf5RkpttYC4Pn0u5k6/7PwK18uL5LbhIbLXNXOIFhs2T2+8AEjJJPVHCZJr/TZeZy4J3CJW4II5IJR3GsZQ3colStUT6x/EVX/5ApmAtQq2fh2es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768595645; c=relaxed/simple;
	bh=l4wGll9ElGNF3FNIora3eusNiEfCpoYivGXldLTtePA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kGRRQ7YanJ2xdfzLM7C3MYduCQmULmZF1SqbZ6rp9cNAwlUT3+AE4AZz8tqfqajEBasPfyHMgVevjMFSHHRTXPtjqB6GLvZgghol6cg8apvw39ELwLLMjrOEgEIxcxQ5Vj2tQQAQF/hVr0S3dN3xAbjs/ukxswpggHWfV7kdxWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fK/K5+ux; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94711C116C6;
	Fri, 16 Jan 2026 20:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768595644;
	bh=l4wGll9ElGNF3FNIora3eusNiEfCpoYivGXldLTtePA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fK/K5+ux3ztXNh3AxubM1mkNxm6y4UVv89VU0rfRjWl31toPi8SI5t9DKTg6yde0x
	 eRj52L3SH/YD3Vd7YZYn984b1ZbSNmxzdm3hWMwn2kTUc/3XPDBRgZj6P68x4mTZ+Y
	 RE6uGDplDUhViv0xkUM1vI39ifn9NBHEvy3MAxdjha2tL7b2ge6AKi7l3cJ2gGE/Lt
	 nWoRHYMWZ1oJwjk/01rT4InaYbKSZYJ2dEVTz4PPPSurAQCRiO0cOWhJBPOLkV0oU6
	 m1BxpYX8bwUPZdEC8LJRlJUCpAakLqaIE4PU4OAOLCoeCpAVbZStPSFZBWEOnu8qFz
	 /b7Ab3bKIuDAQ==
Date: Fri, 16 Jan 2026 20:33:53 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Kurt Borja <kuurtb@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Benson
 Leung <bleung@chromium.org>, Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Gwendal Grignou <gwendal@chromium.org>, Shrikant Raskar
 <raskar.shree97@gmail.com>, Per-Daniel Olsson <perdaniel.olsson@axis.com>,
 David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Guenter Roeck
 <groeck@chromium.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 chrome-platform@lists.linux.dev
Subject: Re: [PATCH v3 0/7] iio: core: Introduce cleanup.h support for mode
 locks
Message-ID: <20260116203353.59a2a00e@jic23-huawei>
In-Reply-To: <20260106-lock-impr-v3-0-1db909b192c0@gmail.com>
References: <20260106-lock-impr-v3-0-1db909b192c0@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 06 Jan 2026 03:06:55 -0500
Kurt Borja <kuurtb@gmail.com> wrote:

> Hi,
> 
> In a recent driver review discussion [1], Andy Shevchenko suggested we
> add cleanup.h support for the lock API:
> 
> 	iio_device_claim_{direct,buffer_mode}().
> 
> Which would allow some nice code simplification in many places. Some
> examples are given as patches, but the last two are the biggest
> differences.
> 
> In this version I dropped the RFC tag, as the general feeling is to go
> through with this after some modifications. Main one is the addition of
> IIO_DEV_ACQUIRE_{BUFFER,CLAIM}_MODE() wrappers to avoid drivers using
> the guard classes directly. I also added comments on the forbidden ways
> to use this API but I definitely still take suggestions on this.
> 
> For now I dropped iio_device_claim_buffer_mode() rename, as this point
> is still being discussed. My suggestion based on the RFC discussion is
> to do it, but in a separate patch (using coccinelle) and while we're at
> it rename the whole API like this:
> 
> 	iio_dev_mode_lock()
> 	iio_dev_mode_direct_trylock()
> 	iio_dev_mode_buffer_trylock()
> 	iio_dev_mode_unlock()

I'm not a huge fan of flag days though this is entirely in direct mode
so I can just do it at the start of a cycle.

Anyhow, that's a job for another day where we can bikeshed the naming
yet again.

I do like unifying the unlock though.

Patch 5 never made the list for some reason.
https://lore.kernel.org/all/20260106-lock-impr-v3-0-1db909b192c0@gmail.com/#r

(I thought I'd accidentally deleted it!)

Thanks

Jonathan


> 
> Let me know what you think and thanks for taking a look!
> 
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> ---
> v3:
> 
>   - Reword commit message of patch 1: infallible -> unconditional.
> 
>   - Drop "*strongly*" in __iio_dev_mode_lock() kernel-doc and be a bit
>     more clear on the function's intention.
> 
>   - Keep comment about inline functions and sparse markings, but drop
>     the __cond_acquires() part, as the new implementation makes it
>     unnecessary.
> 
>   - Implement iio_device_release_*() as macros around
>     __iio_dev_mode_unlock().
> 
>   - Rename iio_device_claim_buffer_mode() ->
>     iio_device_try_claim_buffer_mode() to avoid silently breaking
>     out-of-tree drivers.
> 
>   - Drop the `_` argument prefix in new macros, as there are no name
>     conflicts.
> 
>   - Drop "dummy" from IIO_DEV_ACQUIRE_DIRECT_MODE kernel-doc, as the
>     `claim` variable does store the error value.
> 
>   - Drop IIO_DEV_ACQUIRE_BUFFER_MODE() until a driver actually needs it.
> 
>   - Rename IIO_DEV_ACQUIRE_ERR() -> IIO_DEV_ACQUIRE_FAILED() to make the
>     name more clear.
> 
>   - Rename IIO_DEV_GUARD_ANY_MODE() -> IIO_DEV_GUARD_CURRENT_MODE() to
>     make the name more clear.
> 
>   - Add missing . in iio_device_release_direct() kernel-doc.
> 
>   NOTE: Andy suggested __iio_dev_mode_*() be exported into the IIO_CORE
>         namespace. However, this cannot be done because these functions
> 	need to be called inline, so Sparse can see the __acquires() and
> 	__releases() tags.
> 
>   Happy new year to everyone :)
> 
> v2: https://lore.kernel.org/r/20251211-lock-impr-v2-0-6fb47bdaaf24@gmail.com
> 
>   - Add __iio_dev_mode_lock() (formerly iio_device_claim()) in the first
>     patch.
> 
>   - Added comments to make sure __iio_dev_mode_lock() is not used by
>     drivers to protect internal state, or in general.
> 
>   - Add patch which re-implements iio_device_claim_direct() using
>     __iio_dev_mode_lock().
> 
>   - Match iio_device_claim_buffer_mode() semantics by reimplementing it
>     in the same way as iio_device_claim_direct().
> 
>   - Guard classes now are prefixed with __priv__ to make sure drivers
>     don't use them directly.
> 
>   - Add IIO_DEV_ACQUIRE_{BUFFER,DIRECT}_MODE() documented wrappers
> 
>   - Avoid any function renames (for now).
> 
>   - Rename dummy variable `claim` instead of `busy` on vcnl4000 patch.
> 
>   - Avoid scoped guard in max30102.
> 
>   - Keep using iio_trigger_validate_own_device() insted of
>     iio_trigger_using_own() in opt4060.
> 
> v1: https://lore.kernel.org/r/20251203-lock-impr-v1-0-b4a1fd639423@gmail.com
> 
> ---
> Kurt Borja (7):
>       iio: core: Add and export __iio_dev_mode_lock()
>       iio: core: Refactor iio_device_claim_direct() implementation
>       iio: core: Match iio_device_claim_*() semantics and implementation
>       iio: core: Add cleanup.h support for iio_device_claim_*()
>       iio: light: vcnl4000: Use IIO cleanup helpers
>       iio: health: max30102: Use IIO cleanup helpers
>       iio: light: opt4060: Use IIO cleanup helpers
> 
>  drivers/iio/adc/ade9000.c                          |   2 +-
>  .../common/cros_ec_sensors/cros_ec_sensors_core.c  |   5 +-
>  drivers/iio/health/max30100.c                      |   8 +-
>  drivers/iio/health/max30102.c                      |  33 ++---
>  drivers/iio/industrialio-core.c                    |  86 +++---------
>  drivers/iio/light/opt4060.c                        |  52 +++-----
>  drivers/iio/light/vcnl4000.c                       |  49 +++----
>  include/linux/iio/iio.h                            | 145 +++++++++++++++++++--
>  8 files changed, 196 insertions(+), 184 deletions(-)
> ---
> base-commit: fb2f4eb29a258145b0336601f00509cab6e93e7c
> change-id: 20251130-lock-impr-6f22748c15e8
> 


