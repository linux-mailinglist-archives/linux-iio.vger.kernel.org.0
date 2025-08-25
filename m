Return-Path: <linux-iio+bounces-23194-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B716B33B41
	for <lists+linux-iio@lfdr.de>; Mon, 25 Aug 2025 11:39:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22A6516A05B
	for <lists+linux-iio@lfdr.de>; Mon, 25 Aug 2025 09:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17AAB2C21EE;
	Mon, 25 Aug 2025 09:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JgP5Wkuf"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C319726C3BF;
	Mon, 25 Aug 2025 09:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756114737; cv=none; b=bl4jFodYlBhaOB8xYCNlfE4YpRIILXk9lUa357oVkx5itQ/Wm4QgvN+U/jGeT2625vsyXWj9OBsvH21ETG6k2xweEUbmqL+2HQhRq4kfJKk5ANi80/LOKGfbEIbS5H6gJyx00bHlGWCMyh3X6Ys4lvZNsuT0DU8syowgRSTTzyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756114737; c=relaxed/simple;
	bh=uJgF2RC+DbSwy0YAE6IxGmBI3CvombRV+sHa3B7iq5o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eOJRFL0YguYLGc9i2nkinChSdCotOrAWu751j2VRdFhxy6RG1AHXOd9fxaSx1aeFnqkFvjLjHN4YrCtouMYjYBZhCFWnwLnGn/7bFdXxiXJQZb4koa/kCcbbnB7Ow81FfwoJbWLbNpM0vJHzMrHNyOI0MyA/gU9Hmm4hRUBtXIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JgP5Wkuf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2DFDC4CEED;
	Mon, 25 Aug 2025 09:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756114737;
	bh=uJgF2RC+DbSwy0YAE6IxGmBI3CvombRV+sHa3B7iq5o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JgP5WkufRu9ChnOV4wsjx7La8k09On9YKV0y/E1OBzoFAzqcIreS1uJW13AXp50pj
	 KOmWdR/Ss+qqINCwaV9w7Anh6g1w/S3uTTQsC8gXaEX3InPKxALFOUEXwKYbYH0dY6
	 GQcE4kQzGqFMCHLuEHr2Naq/Q6vKwqQEXN7jrh3Xn0aujgLKWp3sPt+vTrHOeYumo1
	 oMYrc3BvWtILETvI0rD1+fWrsz2eYXcOn6Qj04M1EDVkJR3hkZBZVnzSg2Rbcf2KMz
	 0aPVCxeHeJyH55MLZl/Y58GtwOs5LHU/CdpxSfTTVRTMZEGgdq3mhXElQ/JxytYY3Z
	 kgWVCZ6pmoPbw==
Date: Mon, 25 Aug 2025 10:38:47 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Ben Collins <bcollins@watter.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Andrew Hepp <andrew.hepp@ahepp.dev>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski
 <krzysztof.kozlowski@linaro.org>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v8 0/5] iio: mcp9600: Features and improvements
Message-ID: <20250825103740.31ed77c8@jic23-huawei>
In-Reply-To: <20250822-upstream-changes-v8-0-40bb1739e3e2@watter.com>
References: <20250822-upstream-changes-v8-0-40bb1739e3e2@watter.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 22 Aug 2025 09:23:49 -0400
Ben Collins <bcollins@watter.com> wrote:

Series applied with that unnecessary include that David pointed out dropped.

Applied to the togreg branch of iio.git but initially pushed out as testing
to give 0-day a few days to poke at it.

Thanks,

Jonathan


> ChangeLog:
> v7 -> v8:
>   - Style changes in dt-bindings example
>   - Simplify some return value checks
>   - Move assignment to where it's checked
>   - Speeling
> 
> v6 -> v7:
>   - Separate out the mcp9600 IIR series into its own series as there is
>     a lot of conversation around implementation (removed related
>     comments from this changelog).
> 
> v5 -> v6:
>   - Fix accidental typo added in dt-bindings: IRQ_TYPE_EDGE_RISIN
>   - Correct some constraints in dt-bindings
>   - Reverse if/then for mcp9601 vs mcp9600 constraints in dt-bindings
>   - Updates to changelog for patch 2/6 (dt-bindings mcp9600)
>   - Cleanup tabs that were converted to spaces
>   - Split thermocouple-type default to separate patch
> 
> v4 -> v5:
>   - None
> 
> v3 -> v4:
>   - Based on feedback from David Lechner <dlechner@baylibre.com>
>     * Allow fallback compatible in dt-bindings for mcp9601.
>   - Based on feedback from Jonathan Cameron <jic23@kernel.org>
>     * Be explicit in patch description for fixed width changes.
>     * Check chip_info for NULL to quiet warnings from kernel-test-robot
>     * Remove "and similar" for long description of MCP9600.
>   - Set default 3 for thermocouple in dt-binding
>   - Rework open/short circuit in dt-bindings
> 
> v2 -> v3:
>   - Improve changelogs in each patch
>   - Based on feedback from Andy Shevchenko <andy.shevchenko@gmail.com>
>     * Set register offsets to fixed width
>     * Fix typos
>     * Future-proof Kconfig changes
>     * Convert to using chip_info paradigm
>     * Verbiage: dt -> firmware description
>     * Use proper specifiers and drop castings
>     * Fix register offset to be fixed-width
>     * u8 for cfg var
>     * Fix % type for u32 to be %u
>     * Make blank lines consistent between case statements
> 
> v1 -> v2:
>   - Break into individual patches
> 
> v1:
>   - Initial patch to enable IIR and thermocouple-type
>   - Recognize mcp9601
> 
> Signed-off-by: Ben Collins <bcollins@watter.com>
> ---
> - Link to v7: https://lore.kernel.org/r/20250819-upstream-changes-v7-0-88a33aa78f6a@watter.com
> 
> ---
> Ben Collins (5):
>       dt-bindings: iio: mcp9600: Set default 3 for thermocouple-type
>       dt-bindings: iio: mcp9600: Add microchip,mcp9601 and add constraints
>       iio: mcp9600: White space and fixed width cleanup
>       iio: mcp9600: Recognize chip id for mcp9601
>       iio: mcp9600: Add support for thermocouple-type
> 
>  .../iio/temperature/microchip,mcp9600.yaml         |  57 +++++++-
>  drivers/iio/temperature/Kconfig                    |   8 +-
>  drivers/iio/temperature/mcp9600.c                  | 151 +++++++++++++++++----
>  3 files changed, 187 insertions(+), 29 deletions(-)
> ---
> base-commit: c17b750b3ad9f45f2b6f7e6f7f4679844244f0b9
> change-id: 20250819-upstream-changes-c89af86743fa
> 
> Best regards,


