Return-Path: <linux-iio+bounces-12883-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04AB49DF2A9
	for <lists+linux-iio@lfdr.de>; Sat, 30 Nov 2024 19:43:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8DE6282978
	for <lists+linux-iio@lfdr.de>; Sat, 30 Nov 2024 18:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A54D1A4F01;
	Sat, 30 Nov 2024 18:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GC5Wm08D"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1469A8468;
	Sat, 30 Nov 2024 18:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732992196; cv=none; b=j4r/gYbH0jRj3ndZrNnIeE5yUzz6Wfk/dnBFRg+qZzKGFItewr1ES4iLfedtHAHs+o7aa8AdI1sn2tod7kQ9gjRTupvUHnCWO9qAvIgBIdtvnC15pTt5Z/p1eaEycxAId2LaLhr3QKM0ukYedERebfYPrNLipnHnOwcxjD8gsWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732992196; c=relaxed/simple;
	bh=JXAlpQNvch5uNMaFgx0arbSf6AHB+S7Y7WlYNtmd5MM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OYl/ZBUZ7xPbmPcCgLKYXRh1zajc4jM9law8yS49c1t93cdeQMEXD5VU2GSQR9GBAeR/lTP4i7QLOUOnHsUHMNNKBjaPMR6kyM6+qcc9ugZYiszboX33xJnXWrg1/Sdq3MXvBUpY4bfUOH7r19pJ0MmvjybvjLyJXa/uaZvjGZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GC5Wm08D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2D1CC4CECC;
	Sat, 30 Nov 2024 18:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732992195;
	bh=JXAlpQNvch5uNMaFgx0arbSf6AHB+S7Y7WlYNtmd5MM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GC5Wm08DWN0AiCGsNj4N0UpbZfNB4jok130V9YWi0IswJZ0WyyDLt49M5H/+tP7kl
	 J7C6n97wd3elovKn/4X7QZG+ERAZaOeAbEGLepD7dgt4Uq+9A1OHcUtdP/167XehA/
	 e/9YuPbLeBYdXNCw+U3064k0o4T1HqKs+J12LJIRLv4eFkptAx8UEK2nZY/XUwaNIN
	 o5YztwcSKNEOco0+f7sahpIiUBdfBSBlEuftSpPuQ0xuP4neX15gT+3xYj1uglo1wj
	 TONeDZ4Nygs7/n9tYTR/x8fRsgVALfVqvyCvpLGCx8h2yJHWX/rJqYdClVgPCRyrHk
	 1CTJtlqbNZtxA==
Date: Sat, 30 Nov 2024 18:43:06 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Dumitru Ceclan <mitrutzceclan@gmail.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>, Michael Walle
 <michael@walle.cc>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Uwe
 =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>, Guillaume
 Ranquet <granquet@baylibre.com>
Subject: Re: [PATCH v2 0/3] iio: adc: ad7173: fix non-const info struct
Message-ID: <20241130184306.51e5bb8c@jic23-huawei>
In-Reply-To: <20241127-iio-adc-ad7313-fix-non-const-info-struct-v2-0-b6d7022b7466@baylibre.com>
References: <20241127-iio-adc-ad7313-fix-non-const-info-struct-v2-0-b6d7022b7466@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 27 Nov 2024 14:01:52 -0600
David Lechner <dlechner@baylibre.com> wrote:

> While working ad7124, Uwe pointed out a bug in the ad7173 driver.
> static struct ad_sigma_delta_info ad7173_sigma_delta_info was not const
> and was being modified during driver probe, which could lead to race
> conditions if two instances of the driver were probed at the same time.
> 
> The actual fix part is fairly trivial but I have only compile tested it.
> Guillaume has access to ad4111 hardware, so it would be good to get a
> Tested-by from him to make sure this doesn't break anything.
> 
This is very big for a backport.  So I replied to previous version to suggest
instead duplicating the data before modifying.  That has much less code
movement and maybe a cleaner fix.  Perhaps we then cycle back to avoiding
that copy later.

Jonathan

> ---
> Changes in v2:
> - Fixed chip name in a few places.
> - Add new simpler patch for "fix" that gets backported.
> - Rebase other patches on this and incorporate feedback.
> - Link to v1: https://lore.kernel.org/r/20241122-iio-adc-ad7313-fix-non-const-info-struct-v1-0-d05c02324b73@baylibre.com
> 
> ---
> David Lechner (3):
>       iio: adc: ad7173: fix using shared static info struct
>       iio: adc: ad7173: remove special handling for irq number
>       iio: adc: ad7173: don't make copy of ad_sigma_delta_info struct
> 
>  drivers/iio/adc/ad7173.c               | 474 +++++++++++++++++----------------
>  drivers/iio/adc/ad_sigma_delta.c       |   5 +-
>  include/linux/iio/adc/ad_sigma_delta.h |   2 -
>  3 files changed, 249 insertions(+), 232 deletions(-)
> ---
> base-commit: 9dd2270ca0b38ee16094817f4a53e7ba78e31567
> change-id: 20241122-iio-adc-ad7313-fix-non-const-info-struct-92e59b91ee2e
> 
> Best regards,


