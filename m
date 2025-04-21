Return-Path: <linux-iio+bounces-18415-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B461A95032
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 13:29:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD20F18932B0
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 11:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59085263F3E;
	Mon, 21 Apr 2025 11:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u0TKfOF+"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085DF1A304A;
	Mon, 21 Apr 2025 11:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745234980; cv=none; b=f27TDgragX4IIdwnxtkEb+eUO1/AVdjrdu4HQKDJJjzi+L+g3/NinRFIre35N7e4PcZCensJpLWF14W6PnlmXqy3xZWhGYT9vWDdvYcphoc+/Odhl/esXlXKyQxPY4MyxmkesI6MlPFbhdGJ0QMbC8iplRwjVnJm63+InO0zz5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745234980; c=relaxed/simple;
	bh=g5IvzHyEJg5MHCLERVymxwn0g2pW11ccDaWhsGQE7kE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yxrqm/244ZDdjOtCShzCjMah80m3mFVaROfdZKnt+Ob+uA0C29vIXAazABhQdH9AR07QvHq2iGT8Os5MWwUYMrlxBwOLN9q1d5aoM218Lpcs+JklDNpIClR5GXFwN4VJa05hOE6KKJ4/jjbZHuxU36HaAnVTPHq/tQV+/KRYE9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u0TKfOF+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDD13C4CEE4;
	Mon, 21 Apr 2025 11:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745234979;
	bh=g5IvzHyEJg5MHCLERVymxwn0g2pW11ccDaWhsGQE7kE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=u0TKfOF+fxMGqlQVJA2CLpPDaabn7VmWlNQrMUCMxBmfZ1cZE8RSso7EAyM29LgfU
	 QUd4Tx5aV+r3I6watOS31IKNsx3mCcc/NFQsxuLyjYclgb1DLpXBoL6jybQwXKuXA9
	 XG1v1574R5zrmGxpCiPIHGfPRhEnJGhb5YxMYh4LNpRuf5V7vXTYgd7jiImuFwNVoV
	 YlLju64pSHY/1JVfD6dZErCoM8PT/154ONUd2W/oNjItqpvEnM5I02K4nATDP6L/sB
	 zYQSYNrzaxFO6vajRMreGx4Yi/eqYmTanGyvDNgpgtkOiuRLPG409RjfqEApvDigqc
	 mDfAOUcZIUDGw==
Date: Mon, 21 Apr 2025 12:29:31 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Gabriel Shahrouzi <gshahrouzi@gmail.com>
Cc: gregkh@linuxfoundation.org, lars@metafoo.de, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
 Michael.Hennerich@analog.com, sonic.zhang@analog.com, vapier@gentoo.org,
 skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH v3 0/5] staging: iio: adc: ad7816: Fix channel handling
Message-ID: <20250421122931.13202ca9@jic23-huawei>
In-Reply-To: <cover.1745007964.git.gshahrouzi@gmail.com>
References: <cover.1745007964.git.gshahrouzi@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 18 Apr 2025 16:47:34 -0400
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

Hi Gabriel,

Whilst I appreciate the enthusiasm. Generally slow down a little!
If there is a fundamental issue like an accidental sending of the wrong
version then please reply to the thread cover letter to say that.
Otherwise, even in the presence of build bot reports, it is good
for any non trivial series to wait a little for reviews to come in.
Ideally a week, but a few days can be fine if you already have a lot
of feedback from reviewers.

IIO is moderately high traffic and whilst we are good at hitting
the button to mark a thread read, it still takes some time!

Jonathan

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


