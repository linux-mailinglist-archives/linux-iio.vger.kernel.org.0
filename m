Return-Path: <linux-iio+bounces-24050-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BC2CDB5612C
	for <lists+linux-iio@lfdr.de>; Sat, 13 Sep 2025 15:37:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 745D64E1278
	for <lists+linux-iio@lfdr.de>; Sat, 13 Sep 2025 13:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784172EBB81;
	Sat, 13 Sep 2025 13:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DpSN/zUM"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B35134BD;
	Sat, 13 Sep 2025 13:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757770664; cv=none; b=gUDhxn2RpKbaWDJEW6W7nzpHV4/ejsOe0sCdg+ljh8dzcdShmb/pVjRN6kE4ctlcu6yhr37ojHHzYIPciS16elMrsTzHVFXYXmkPNxzWPyJJg2E6s+AH98LfMqHQcTM+KaCLfGkcUPtUkPXt8kaVpa5TfzfA1rKYjDcXdb6/KkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757770664; c=relaxed/simple;
	bh=XRpWYlvYZXNuae9oCQoPaR2UYC98Agqeom8LCI6MJzg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kbYYERwj3WkceYEKYM49LMCaQwAJ+lDg9447BfYv+Iw3fuz8PyKHKgdC7gW7agew1rsjRSYiuzbv5Lw9pTyTqvLrNV7r2LCxVFf2T5KYHopV8sB/n6PGx2pvzLyRQBSEEszlpMFSGjaLDNkG1WQNTMhN92AykkgCMAcFlFgntl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DpSN/zUM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B208C4CEEB;
	Sat, 13 Sep 2025 13:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757770664;
	bh=XRpWYlvYZXNuae9oCQoPaR2UYC98Agqeom8LCI6MJzg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DpSN/zUMdfTtdNiNMue4hx0+vNslJghcxWCkmn7p9Lqtc3pjFSJldrRrLuhRW2RxX
	 k7rVFLjEWiDxGJJD50EbgYN38c3nC7kZfrYx7/CP9a78pzoKEtP+WgBLcKxIh1hXom
	 2zfHalCYNGVBLf53SQgj2zuFbm2sdkKSqUKTL1em7F7MYRVo4CbBsRG23UwlNePm/v
	 ovWrKSbKXIfju1xTlUD60988VbNkGDxqpvUbgY07ger64/gKXipDN8RjBenHh2hxnT
	 PPJtdCWQx2bg2lkfwvGbkYMPk/7y79gdlLc1yqJs4RVCLuhkvSOgT2ZDK7UnDFOsKh
	 2Y0PMJVOp/X+g==
Date: Sat, 13 Sep 2025 14:37:34 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] iio: adc: ad7124: fix sample rate for multi-channel
 use
Message-ID: <20250913143734.5cbad7e5@jic23-huawei>
In-Reply-To: <20250910-iio-adc-ad7124-fix-samp-freq-for-multi-channel-v4-1-8ca624c6114c@baylibre.com>
References: <20250910-iio-adc-ad7124-fix-samp-freq-for-multi-channel-v4-1-8ca624c6114c@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Sep 2025 12:33:29 -0500
David Lechner <dlechner@baylibre.com> wrote:

> Change how the FS[10:0] field of the FILTER register is calculated to
> get consistent sample rates when only one channel is enabled vs when
> multiple channels are enabled in a buffered read.
> 
> By default, the AD7124 allows larger sampling frequencies when only one
> channel is enabled. It assumes that you will discard the first sample or
> so to allow for settling time and then no additional settling time is
> needed between samples because there is no multiplexing due to only one
> channel being enabled. The conversion formula to convert between the
> sampling frequency and the FS[10:0] field is:
> 
>     fADC = fCLK / (FS[10:0] x 32)
> 
> which is what the driver has been using.
> 
> On the other hand, when multiple channels are enabled, there is
> additional settling time needed when switching between channels so the
> calculation to convert between becomes:
> 
>     fADC = fCLK / (FS[10:0] x 32 x N)
> 
> where N depends on if SINGLE_CYCLE is set, the selected filter type and,
> in some cases, the power mode.
> 
> The FILTER register has a SINGLE_CYCLE bit that can be set to force the
> single channel case to use the same timing as the multi-channel case.
> 
> Before this change, the first formula was always used, so if all of the
> in_voltageY_sampling_frequency attributes were set to 10 Hz, then doing
> a buffered read with 1 channel enabled would result in the requested
> sampling frequency of 10 Hz. But when more than one channel was
> enabled, the actual sampling frequency would be 2.5 Hz per channel,
> which is 1/4 of the requested frequency.
> 
> After this change, the SINGLE_CYCLE flag is now always enabled and the
> multi-channel formula is now always used. This causes the sampling
> frequency to be consistent regardless of the number of channels enabled.
> 
> For now, we are hard-coding N = 4 since the driver doesn't yet support
> other filter types other than the default sinc4 filter.
> 
> The AD7124_FILTER_FS define is moved while we are touching this to
> keep the bit fields in descending order to be consistent with the rest
> of the file.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
Applied to the togreg branch of iio.git and pushed out as testing for all
the normal reasons.

