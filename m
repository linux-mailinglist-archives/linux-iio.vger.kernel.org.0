Return-Path: <linux-iio+bounces-20091-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB92AC9C34
	for <lists+linux-iio@lfdr.de>; Sat, 31 May 2025 20:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98B874A015A
	for <lists+linux-iio@lfdr.de>; Sat, 31 May 2025 18:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1218517C210;
	Sat, 31 May 2025 18:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bT4ygHzN"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C212D645;
	Sat, 31 May 2025 18:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748715056; cv=none; b=ZWOaUxAIGyGuchzaIaLMZtFAUlVDA2a8ybUyqWgRBADXM+Sv6oyNeqnWNbSgiSqO6sbciEgEJ5OdZdRMW/kGc7uV7+rHUUDjBMTZ7TgbyA1OxFbsYhVFc6uZsE2I+xCVtdcNAnzfwtj+eteW23XvshAutYjh7Mv9iOQjA4uYN3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748715056; c=relaxed/simple;
	bh=mS1Lvfy2nfkIP5mFEJ2h9xPRBq06wENgzWEf99Ck0dU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pV9js7usnUFXf7iT0yOlPhoUgiTASEDeIYaEmWelraxnOhx7IUl5+wAM5NgvoHnyyc0diawXSw30zKhnvovMHLxCAdMaT4c7pVXzZ8TZFBwbWgbVFYYH8MpZQkQDOP8G5wWdhXuBjilg7eSXjOoZ6+l17JgC9Hs2CCuoTZQcpaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bT4ygHzN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8BCDC4CEE3;
	Sat, 31 May 2025 18:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748715056;
	bh=mS1Lvfy2nfkIP5mFEJ2h9xPRBq06wENgzWEf99Ck0dU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bT4ygHzN2iM3I01ie0wSBuqioju/k9v4hJnQbNVFO/l4QuEtu0Z2eCGZaXIE4+A78
	 MBJ0XzR+8sl6j4DbUrLhhgJttzDAa1E/GJ3RSsJ8J+4wOyu1ENQ0pgg/hGlwCZxikC
	 m9E5rboLG29T7o5r3PyCestWNK3jKsXmGLXMZAln6J2C1dXmNLpVeefWYlVsZKww1P
	 5HwSeF7YNvv9SHXzWW0OYF0uybjLI2feMes4j45R1A0y7wwwrS57AW3dj15CO56dk2
	 k+vTWrlFqEr+SMxfPerVlYBXBgwalHOpxIai2seotW85KgSxXBfD82mrqufyfospJ/
	 Y3wOrpfefy9Hw==
Date: Sat, 31 May 2025 19:10:48 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Gyeyoung Baek <gye976@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 0/9] iio: Introduce new timestamp grabbing APIs
Message-ID: <20250531191048.176b40af@jic23-huawei>
In-Reply-To: <20250519-timestamp-v1-0-fcb4f6c2721c@gmail.com>
References: <20250519-timestamp-v1-0-fcb4f6c2721c@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 May 2025 23:25:52 +0900
Gyeyoung Baek <gye976@gmail.com> wrote:

> Support automatic timestamp grabbing by passing `true` to the `timestamp_enabled` parameter of `iio_triggered_buffer_setup_new()`.
> So consumer drivers don't need to set `iio_pollfunc_store_time()` as either the tophalf or bottomhalf manually.
> 
> For this, triggers must indicate whether they will call `poll()`, `poll_nested()`, or both before
> calling `iio_trigger_register()`. This is necessary because the consumer's handler does not know
> in advance which trigger will be attached.
> 
> Once `iio_trigger_attach_poll_func()` is called, a timestamp is grabbed in either the
> tophalf or bottomhalf based on the trigger's type (POLL or POLL_NESTED). If the trigger
> supports both (e.g., at91-sama5d2-adc.c), it is treated as POLL_NESTED since the consumer's
> tophalf is not invoked in poll_nested(), but the bottomhalf always is.
> 
> If the attached trigger supports timestamp grabbing itself, the consumer does not need to handle it.
> Instead, the consumer's `poll_func` pointer is passed to the trigger, which can then store the
> timestamp directly into consumer. Trigger drivers can pass timestamp values to consumers in a consistent
> interface using the new API `iio_trigger_store_time()`.

This trigger grabbing timestamps thing seems to me to a potential future
optimization.  I'm not seeing why we need it for the fundamental thing we
are addressing here and it is making the patch set more confusing for me
at least.

> 
> Tested on qemu, with dummy and trig-sysfs drivers tweaked for testing.
> 
> Signed-off-by: Gyeyoung Baek <gye976@gmail.com>
> ---
> Gyeyoung Baek (9):
>       iio: buffer: Fix checkpatch.pl warning
>       iio: consumer: Define timestamp-related structures and constants
>       iio: consumer: Add new APIs of triggered_buffer_setup() family
>       iio: consumer: Add new API iio_poll_func_register()
>       iio: consumer: Add new API iio_pollfunc_get_timestamp()
>       iio: trigger: Define timetamp-related structures and constants
>       iio: trigger: Add new API iio_trigger_attach_timestamp()
>       iio: trigger: Add new API iio_trigger_store_time()
>       iio: rpr0521: Use new timestamp-related APIs
> 
>  drivers/iio/buffer/industrialio-triggered-buffer.c |  84 ++++++++++++-
>  drivers/iio/industrialio-trigger.c                 | 135 ++++++++++++++++++++-
>  drivers/iio/light/rpr0521.c                        |  22 +---
>  include/linux/iio/trigger.h                        |  16 ++-
>  include/linux/iio/trigger_consumer.h               |  23 ++++
>  include/linux/iio/triggered_buffer.h               |  25 ++++
>  6 files changed, 283 insertions(+), 22 deletions(-)
> ---
> base-commit: 43a9eee06bf8a8535d8709b29379bec8cafcab56
> change-id: 20250518-timestamp-a899e78e07e3
> 
> Best regards,


