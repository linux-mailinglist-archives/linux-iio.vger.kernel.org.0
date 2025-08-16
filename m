Return-Path: <linux-iio+bounces-22788-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22646B28CC7
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 12:19:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3125AC8481
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 10:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA7523CF12;
	Sat, 16 Aug 2025 10:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kg/DGjvS"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038B01BC3F;
	Sat, 16 Aug 2025 10:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755339544; cv=none; b=HKWsTpNkEulkGz7TZqpUA+ZtsrWxFFRuMtYj3Iyutm4zNNRt+CqsfWSAtk0Zn4rpmH3befdXyOGzBLnPKq2pJx/pEXoIldScn4Amng5Eav6Yi3o3YCULNEw+pdAawWtykcU6eeJUHcGFJzBWgeMSr/b93KJjq7hU+uGxLCrAHXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755339544; c=relaxed/simple;
	bh=5NWhecVS2/AkV4nKyydh9LzhF8tYLJWu8T8ZtYaFAiA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cje8/BoV/HjtOqsIePsp4G/lnkAqriH1Tv0l5aVIGd0uM7nEPQZ1fWPlF7lan/LQDRNwlN8X6r+rG9otQmGiGWbIzgZ/bHOpYn4JFrzAI6EddspEkJkq4vDgbd93LgAh6DPqwiuphhrFX8MPmMDD6kE9b/nyfzoTr83vjTo9YNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kg/DGjvS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8E2AC4CEEF;
	Sat, 16 Aug 2025 10:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755339543;
	bh=5NWhecVS2/AkV4nKyydh9LzhF8tYLJWu8T8ZtYaFAiA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Kg/DGjvSRSjvpuL0i6KsABAKxqcwW4z/YYtBF3zbY75FotPoVzg8EwTSc8wG7/79P
	 jLMW4wKnfjbpuslmQe5nDGlDhy6uF1fAOJqiuR4XN9mAq0afZmc8bWkxduIm9wXrw1
	 NLKs8wKDFS1VKMW3wWT9tCOgHhfPkucD+5BkhdPjMTfImgnCfI7t/APrkrFAt8BBR3
	 Ej9iNb6TMpCNwAFrI4y6jR+7RVhFvGv/SfSZ+BgbrdVtoyAEOJjgBB49qlSIy9sCA/
	 0aqG7AbFogRNahMEL4J2Ka0tq0lffLWVo/EGnixaSw0VDam3/Milt9x4JASefUss3w
	 cGn2IxGo7a9hQ==
Date: Sat, 16 Aug 2025 11:18:55 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Yusuf Alper Bilgin <y.alperbilgin@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Liam Beguin <liambeguin@gmail.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/3] Add LTC2495 support
Message-ID: <20250816111855.7e934f4d@jic23-huawei>
In-Reply-To: <20250815-ltc2495-v4-0-2d04e6005468@gmail.com>
References: <20250815-ltc2495-v4-0-2d04e6005468@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 Aug 2025 12:02:01 +0200
Yusuf Alper Bilgin <y.alperbilgin@gmail.com> wrote:

> Hi All,
> 
> This is the v4 of the patch series to add support for the LTC2495 ADC
> and to enable the internal temperature channel for the LTC2495 and
> LTC2499.
> 
> Thanks to Andy Shevchenko for his helpful reviews on earlier versions,
> and to David Lechner and Krzysztof Kozlowski for their feedbacks on
> v3. This version addresses all feedback from v3.
> 
> Best Regards,
> 
> Alper

Hi Alper,

A small process thing.  Wait a little longer between versions
as it tends to save time for both the submitter and reviewers.

At least a few days is appropriate typically and for first versions
I'd generally advise a week. Many reviewers only get to the list
once a week or so (some less than that!)

Thanks,

Jonathan

> 
> Signed-off-by: Yusuf Alper Bilgin <y.alperbilgin@gmail.com>
> ---
> Changes in v4:
>   - Removed the verbose formula derivation comment from `read_raw`.
>   - Reworked the temperature channel definition to omit the redundant
>     `.address` and `.channel` fields.
>   - Moved I2C-specific bit definitions from the shared header into
>     `ltc2497.c` and removed the pre-combined command macro.
>   - Simplified I2C logic to check the channel type instead of a
>     non-standard address.
>   - Combined the basic device support (#2) and temperature sensor feature (#3)
>     patches into a single patch (#2).
>   - Link to v3: https://lore.kernel.org/r/20250814-ltc2495-v3-0-c2a6cecd6b99@gmail.com
> 
> Changes in v3:
>   - Used the standard `kelvin_to_celsius()` helper instead of a custom
>     define.
>   - Corrected macro definition style.
>   - Renamed `LTC2497_CHANNELS` and `LTC_T_CHAN` for clarity.
>   - Combined all struct layout optimizations into a single patch.
>   - Link to v2: https://lore.kernel.org/r/20250813-ltc2495-v2-0-bbaf20f6ba07@gmail.com
> 
> Changes in v2:
>   - Rewrote all commit messages to use the imperative mood.
>   - Added a justification for the new compatible string to the device
>     tree binding commit message.
>   - Removed all unrelated whitespace and formatting changes.
>   - Removed redundant explicit `false` initializers from structs.
>   - Replaced the magic number for Kelvin conversion with a define.
>   - Improved comments for defines and temperature scaling constants.
>   - Renamed confusing macros and struct fields to be more descriptive.
>   - Replaced dynamic channel allocation with a static array approach
>     using a shared macro to improve readability.
>   - Optimized data structure layouts based on pahole output to remove
>     memory holes.
>   - Link to v1: https://lore.kernel.org/r/20250812-ltc2495-v1-0-7bf4c6feec2e@gmail.com
> ---
> Implementation Notes
>  - checkpatch warning: The new static array approach uses a shared macro
>    for the common channels (`LTC2497_CHANNELS`), which triggers a
>    checkpatch.pl warning: "Macros with complex values should be enclosed
>    in parentheses". However, this will cause a compilitaion error, as an
>    initializer list cannot be parenthesized.
>  - uV to mV conversion: I could not find a standard macro, so a manual
>    division is used for now. This could be a point of future
>    improvement.
> 
> ---
> Yusuf Alper Bilgin (3):
>       dt-bindings: iio: adc: ltc2497: add lltc,ltc2495 bindings
>       iio: adc: ltc2497: add support for LTC2495
>       iio: adc: ltc2497: reorder struct members to fix memory holes
> 
>  .../devicetree/bindings/iio/adc/lltc,ltc2497.yaml  |   3 +
>  drivers/iio/adc/ltc2497-core.c                     | 132 ++++++++++++++-------
>  drivers/iio/adc/ltc2497.c                          |  39 +++++-
>  drivers/iio/adc/ltc2497.h                          |  19 ++-
>  4 files changed, 147 insertions(+), 46 deletions(-)
> ---
> base-commit: acbbb5a20971089064ca6b271dd251e629be8d4d
> change-id: 20250811-ltc2495-572817c13fd3
> 
> Best regards,


