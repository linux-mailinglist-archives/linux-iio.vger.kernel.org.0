Return-Path: <linux-iio+bounces-14171-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80DD2A0A8BA
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 12:41:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D435E166F76
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 11:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D96901AF0CA;
	Sun, 12 Jan 2025 11:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WHFDd5/w"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F7F1AB530;
	Sun, 12 Jan 2025 11:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736682070; cv=none; b=kBAA4incBFLYULEJ50lFIJIpLmmJkhFysgg97MkoZVIPUybCbFAvjMqaZ8q32ekOnmeQgWYkx14jWqElu9E/YLx3WeHX+Q2aOnrNXTJ8QDnDRNBp8cb60Q//KegRvVja1A1WB4oEuwl1kfzxswOsPSpR6wKhoKtIFNNfRU12z80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736682070; c=relaxed/simple;
	bh=7x0HpjDvT7LYxsTCtcNlBe9PYXSjCm9SMrzTlR3cTH0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JGgr0cy5dM9qbYPGFL0otOPxovJm8xzPr8N0a60V6glp842ekjH1lJ8iepAtld8zlgZbkbrUTWUXLaroCkvWn1cLCrgBZVZCV/S+Uv/vtfeigSUopPFP4MeYCC91MTS37XS3qQpa8u715qnKV5vmxO/EajvnHNcdO5Kf+qfOVcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WHFDd5/w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9795CC4CEDF;
	Sun, 12 Jan 2025 11:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736682070;
	bh=7x0HpjDvT7LYxsTCtcNlBe9PYXSjCm9SMrzTlR3cTH0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WHFDd5/wMmBq/IKFl9DGvG42pmCr3CURoFsmC9VrvSLZ2MBeQqv9ELRlR8kug/5IT
	 uV0CBRagMOBncORyb9j5RX99JpgAFoe77y9LoRP9xR5hIJteRH5iyVWJld27sZIwk4
	 lVXaQ1BCzTo6rgOydEkxseUtALZz9a9ZpRPdSd9GOw/xoVOKFZ3FDOyqBXQexUrK1+
	 tjdeSv9m6u8z2NNrmSsw4wipFrNxLQdMx6jVeEbg71I6mJ1rk4z/oyDRp+nCOFVt2K
	 A8QzGKFmzh/20IVlHzDaHEalTGoIT52j2hgTx405jZOxZZ0XhZTtps58PvCydeo7my
	 MYDCBeRcHaS5w==
Date: Sun, 12 Jan 2025 11:41:01 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Julien Stephan <jstephan@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 David Lechner <dlechner@baylibre.com>, Jonathan Corbet <corbet@lwn.net>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 4/5] iio: adc: ad7380: add alert support
Message-ID: <20250112114101.63e8e726@jic23-huawei>
In-Reply-To: <20250107-ad7380-add-alert-support-v3-4-bce10afd656b@baylibre.com>
References: <20250107-ad7380-add-alert-support-v3-0-bce10afd656b@baylibre.com>
	<20250107-ad7380-add-alert-support-v3-4-bce10afd656b@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 07 Jan 2025 09:48:28 +0100
Julien Stephan <jstephan@baylibre.com> wrote:

> The alert functionality is an out of range indicator and can be used as
> an early indicator of an out of bounds conversion result.
> 
> ALERT_LOW_THRESHOLD and ALERT_HIGH_THRESHOLD registers are common to all
> channels.
> 
> When using 1 SDO line (only mode supported by the driver right now), i.e
> data outputs only on SDOA, SDOB (or SDOD for 4 channels variants) is
> used as an alert pin. The alert pin is updated at the end of the
> conversion (set to low if an alert occurs) and is cleared on a falling
> edge of CS.
> 
> The ALERT register contains information about the exact alert status:
> channel and direction. ALERT register can be accessed using debugfs if
> enabled.
> 
> User can set high/low thresholds and enable alert detection using the
> regular iio events attributes:
> 
>   events/in_thresh_falling_value events/in_thresh_rising_value
>   events/thresh_either_en
> 
> In most use cases, user will hardwire the alert pin to trigger a shutdown.
> 
> In theory, we could generate userspace IIO events for alerts, but this
> is not implemented yet for several reasons [1]. This can be implemented
> later if a real use case actually requires it.
> 
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> 
> [1] https://lore.kernel.org/all/4be16272-5197-4fa1-918c-c4cdfcaee02e@baylibre.com/

Hmm. This does end up odd in that userspace is configuring event
related stuff and not getting an event.

If we can fix that later I'd like to do so, but we can move forwards
with this odd bit of ABI in the meantime.  Even then we'd need to support
the case where it's not wired to the host but is really controlling
an external cut off.


I've got nothing else to add to David's review.

Jonathan


