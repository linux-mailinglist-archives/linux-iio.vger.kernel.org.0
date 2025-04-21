Return-Path: <linux-iio+bounces-18416-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB73A95035
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 13:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE0B67A5B91
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 11:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 036712571D7;
	Mon, 21 Apr 2025 11:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VA6xH5/P"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0382638AD;
	Mon, 21 Apr 2025 11:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745235095; cv=none; b=H49cV9dgH1bdecewGY5jYUdfIW0PTXYHE683hVeRVvCGS9n8EXCn8f0lveKFw/z50EgWpIvC5WrpHIK7nO664OzbrotFMEKPlTiSg0HNNAcw6s1VhjyXFsDKKC73Ea4UW2HOfGJW/j388mBNhaQIOxcWBb6kwpCW40yl3ByejkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745235095; c=relaxed/simple;
	bh=1O9KwH7WliC3LvEb+NaISfKBpCkiOxL3kwp37UrNbUU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O9oN9lK/VvTCbd4k/GFEOVXDBmaJIj629axd8dcziff/fyErKK/4jWWxyebiMEbRkXNJmpY6hjCh/YsOm7BhPyRBiRBAWSrgFC0GHUWY78SNm3py25i20+wnY1blL1mzwuHujEsp1xTy4Sl7dt3vFioIK/Yt8JiTBiWp3TxxF+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VA6xH5/P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D335C4CEE4;
	Mon, 21 Apr 2025 11:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745235095;
	bh=1O9KwH7WliC3LvEb+NaISfKBpCkiOxL3kwp37UrNbUU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VA6xH5/Psm+YhbIqE+M1JHe/ftbZfFgv6tIknQRs8X4S8tkAr2J1oMkcpJANorb4z
	 MqtEqG7g1YcXI4aIJJGsbxgzDqbc15Ax8eUygrMk1iJPJCoHyoc4rMpz1p4ORsQ/V4
	 wr2i8Yh6l589y1ockSD/fCGyrLPj8FsCnTwzkzus0fTXr+O/aue9B3snST5vR3TKnV
	 zV+TCNbNVjkj7E8W0o4kPzD6CP+0bHDGGkjhCPnABgewY9f1k6ctLE6y3gBzcUD4xa
	 4cpLt+/sN83KaE8rh9S9O5byW/0g/m6JNDtgqpm7QaGb4pWptVHzwMc/LPsSSEgXa/
	 ttyLcli0ea5gA==
Date: Mon, 21 Apr 2025 12:31:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Gabriel Shahrouzi <gshahrouzi@gmail.com>
Cc: gregkh@linuxfoundation.org, lars@metafoo.de, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
 Michael.Hennerich@analog.com, sonic.zhang@analog.com, vapier@gentoo.org,
 skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH v5 0/5] staging: iio: adc: ad7816: Fix channel handling
 and refactor
Message-ID: <20250421123127.3a5a7d65@jic23-huawei>
In-Reply-To: <20250420014910.849934-1-gshahrouzi@gmail.com>
References: <20250420014910.849934-1-gshahrouzi@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 19 Apr 2025 21:49:05 -0400
Gabriel Shahrouzi <gshahrouzi@gmail.com> wrote:

> The original patch combined a functional fix (allowing channel 7) with
> several refactoring steps (introducing chip_info, renaming structs,
> improving validation). As requested, these have now been separated.
> 
> The series proceeds as follows:
> 1. Fix: Allow diagnostic channel 7 for all device variants.
> 2. Refactor: Rename the main state structure for clarity before introducing
>    the new chip_info struct.
> 3. Refactor: Introduce struct ad7816_chip_info to hold static per-variant
>    data, update ID tables to store pointers, and switch to using
>    device_get_match_data() for firmware-independent identification.
>    This removes the old enum/id mechanism.
> 4. Refactor: Add has_busy_pin to chip_info and use this flag to
>    determine BUSY pin handling, replacing pointer comparisons.
> 5. Refactor: Simplify channel validation logic using 
>    chip_info->max_channels, removing strcmp() checks.
> 
> Regarding the 'fixes' tag: I've applied it only to the first commit
> containing the core fix, primarily to make backporting easier. Is this
> the standard practice, or should the tag typically be applied to
> subsequent commits that build upon or are related to the fix as well?
> 
> Changes in v5:
> 	- Use correct patch version.
Generally I wouldn't resend for this. Instead a single email in
reply to the messed up version saying it is infact v4 would have
done the job.

Alternatively a quick reply to that thread to say it was messed
up and please look for v5 would have worked to make a reader
move on directly to the newer version


Jonathan

> Changes in v4:
> 	- Include missing bracket for condtional statement.
> Chainges in v3:
> 	- Split the patch into smaller patches. Make the fix first
> 	  followed by clean up.
> 	- Include missing channel for channel selection.
> 	- Address specific feedback regarding enums vs. chip_info data.
> 	- Use device_get_match_data() for device identification.
> 	- Move BUSY pin capability check into chip_info data.
> 	- Simplify channel validation using chip_info data.
> Changes in v2:
>         - Refactor by adding chip_info struct which simplifies
>           conditional logic.
> 
> Gabriel Shahrouzi (5):
>   staging: iio: adc: ad7816: Allow channel 7 for all devices
>   staging: iio: adc: ad7816: Rename state structure
>   staging: iio: adc: ad7816: Introduce chip_info and use pointer
>     matching
>   staging: iio: adc: ad7816: Use chip_info for device capabilities
>   staging: iio: adc: ad7816: Simplify channel validation using chip_info
> 
>  drivers/staging/iio/adc/ad7816.c | 94 ++++++++++++++++++--------------
>  1 file changed, 54 insertions(+), 40 deletions(-)
> 


