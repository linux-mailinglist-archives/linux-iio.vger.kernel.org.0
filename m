Return-Path: <linux-iio+bounces-20067-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46CA5AC9B76
	for <lists+linux-iio@lfdr.de>; Sat, 31 May 2025 17:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBFFB1897FE6
	for <lists+linux-iio@lfdr.de>; Sat, 31 May 2025 15:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B45A23D294;
	Sat, 31 May 2025 15:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eFgV0h6j"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB8011185;
	Sat, 31 May 2025 15:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748704352; cv=none; b=PKhORr0D6HJzLDF7oOPIa79JQCeCHZzRnqvJHEJ5TcePdHDY10n5CzYxDO2MRIlYKqZqn3KGxQccjOOAiKbRYNuHS/4aPN3fH/IrTkabCiBViJLU0hycmJMymsrlcijtVhL4Q0ZCD41YHIfqLaK7l5AtPtTjG/DGrL1C1tIyiHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748704352; c=relaxed/simple;
	bh=a/CYO3EFHzzYEb/19ljV50AWmmdfszpreES9zq3QWTk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uVP9wWQB4Kuz4kR5hFOOU2FyYL67HlCQjed2s0StoifEMw5BhZ6mtP8QT8UmIF4OH9ZEqHqZwWnbe+75BGc32xZU5RI0yzUa4tPRAFr6jQTGqzjM0ykum9n+RvBv+N4mAAEXwaQARUCxTNXEyvzElltHFbAiskSoecKMjhid4x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eFgV0h6j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F3FAC4CEE3;
	Sat, 31 May 2025 15:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748704352;
	bh=a/CYO3EFHzzYEb/19ljV50AWmmdfszpreES9zq3QWTk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eFgV0h6jx3RLbFFKtVT34IJ34cVcSLqGfjbcJffl9lFMn4DFd0KqlOASUUHC42vj/
	 dCxibdSYzWoygv/myAsin7K5ECjOkBFNIzjkk4NT8RQPNflhBMYVnPZ7OR0Y+zUmsm
	 4RA9VMdwvs1rWC8ZNbL5L2IZgVnHgrV0Bx3NGuiqqGgrYcfF91UNAF8urwoPBLl4in
	 JEw68aeeUIggCe8OlvdQS0o2IkTC5y/iKxu0kyDQUs+91c+H1vYV2JXq19GkI9BbNa
	 pHryHHjelNMHkimyQv5yvX0ovQdqGmzFk1KRTJ3+5s/gUovtE4MKPAXG/X9LGFJX97
	 dpTSU5t+2parw==
Date: Sat, 31 May 2025 16:12:25 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Waqar Hameed <waqar.hameed@axis.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Haibo Chen <haibo.chen@nxp.com>,
 <kernel@axis.com>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/4] iio: Clean up macro definitions
Message-ID: <20250531161225.5c9658e9@jic23-huawei>
In-Reply-To: <cover.1748356671.git.waqar.hameed@axis.com>
References: <cover.1748356671.git.waqar.hameed@axis.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 27 May 2025 16:45:41 +0200
Waqar Hameed <waqar.hameed@axis.com> wrote:

> Currently there are a bunch of drivers using macro definitions for
> string literals that are only used once. There seem to be a "style
> guide" to not do this, and this is often mentioned during the reviews
> (if caught). And since developers most often look at other drivers for
> inspiration (or just trying to figure out the "style guide") when
> writing a new one, it is desirable to have some consistency.
> 
> In this patch series we identify the drivers that have macro definitions
> for string literals that are only used once. The most common one is the
> driver name. These can be identified by
> 
>   rgrep -A 10 "\.driver" drivers/iio/ | grep "\.name" | grep -v '"'
> 
> And then count the number of occurrences of the particular macro
> definition (e.g. with `grep -c`). Most drivers use these macro
> definitions for `.name` in `struct device_driver` and `indio_dev->name`
> (which could be justified with a macro definition). However, the ones
> with only one occurrence are identified and removed in this patch
> series.
> 
> There are also drivers that have a mixture, e.g. macro definition for
> `indio_dev->name` but in-line string literal for `.name` in `struct
> device_driver`). The following have therefore not been touched (but
> should maybe use the macro definition for both places):
> 
>   drivers/iio/accel/stk8ba50.c
>   drivers/iio/accel/mma7660.c
>   drivers/iio/humidity/am2315.c
>   drivers/iio/light/stk3310.c
> 
> Likewise, there are drivers that only use `KBUILD_MODNAME` in one place.
> These have also been left for the same reasons.
> 
> Finally, while cleaning up these ones, other similar macro definitions
> could be identified with the same "style guide" issue: macro definitions
> for IRQ name and `regmap` name. There are even unused macro definitions.
> All of these are also addressed in this patch series.

Thanks for tidying all these up!
Applied to the testing branch of iio.git which will be rebased on rc1
once available.

Jonathan

> 
> Waqar Hameed (4):
>   iio: Remove single use of macro definition for driver name
>   iio: Remove single use of macro definition for IRQ name
>   iio: Remove single use of macro definition for regmap name
>   iio: Remove unused macro definition for driver and IRQ name
> 
>  drivers/iio/accel/bma180.c             | 3 ---
>  drivers/iio/accel/bmc150-accel-core.c  | 5 +----
>  drivers/iio/accel/kxcjk-1013.c         | 7 ++-----
>  drivers/iio/accel/mma9551.c            | 6 ++----
>  drivers/iio/accel/mma9553.c            | 7 ++-----
>  drivers/iio/accel/mxc4005.c            | 6 ++----
>  drivers/iio/accel/mxc6255.c            | 3 +--
>  drivers/iio/accel/sca3300.c            | 4 +---
>  drivers/iio/accel/stk8312.c            | 3 +--
>  drivers/iio/accel/stk8ba50.c           | 3 +--
>  drivers/iio/adc/hi8435.c               | 4 +---
>  drivers/iio/adc/max9611.c              | 4 +---
>  drivers/iio/adc/vf610_adc.c            | 5 +----
>  drivers/iio/chemical/atlas-sensor.c    | 3 +--
>  drivers/iio/dac/max517.c               | 4 +---
>  drivers/iio/dac/mcp4725.c              | 4 +---
>  drivers/iio/gyro/bmg160_core.c         | 4 +---
>  drivers/iio/health/max30100.c          | 3 +--
>  drivers/iio/health/max30102.c          | 3 +--
>  drivers/iio/humidity/dht11.c           | 4 +---
>  drivers/iio/imu/kmx61.c                | 7 ++-----
>  drivers/iio/light/adux1020.c           | 3 +--
>  drivers/iio/light/apds9160.c           | 4 +---
>  drivers/iio/light/apds9300.c           | 3 +--
>  drivers/iio/light/apds9960.c           | 3 +--
>  drivers/iio/light/jsa1212.c            | 3 +--
>  drivers/iio/light/ltr501.c             | 8 ++------
>  drivers/iio/light/rpr0521.c            | 6 ++----
>  drivers/iio/light/stk3310.c            | 6 ++----
>  drivers/iio/light/vcnl4035.c           | 6 ++----
>  drivers/iio/magnetometer/bmc150_magn.c | 5 +----
>  drivers/iio/magnetometer/mmc35240.c    | 3 +--
>  drivers/iio/proximity/sx9500.c         | 3 +--
>  drivers/iio/resolver/ad2s1200.c        | 3 +--
>  34 files changed, 42 insertions(+), 106 deletions(-)
> 
> 
> base-commit: 914873bc7df913db988284876c16257e6ab772c6


