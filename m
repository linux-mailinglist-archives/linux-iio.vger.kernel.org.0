Return-Path: <linux-iio+bounces-9831-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C9C0989021
	for <lists+linux-iio@lfdr.de>; Sat, 28 Sep 2024 17:47:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EBC3281FFE
	for <lists+linux-iio@lfdr.de>; Sat, 28 Sep 2024 15:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 586472261D;
	Sat, 28 Sep 2024 15:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ci2ur5us"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD4C125DE;
	Sat, 28 Sep 2024 15:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727538435; cv=none; b=M11nnePRsOnrnyJvn8mtNcLOwD36nME5ytoxymE0p1o9bJp8V9T4sYP/9QDtVIvH7XhZ6DGzB7Kq3lkgHCHLU7+wYm//y8NoWBnnJl2sZzJ3ZXv8oFk5RhgsF0j7SQkWRLg0Y2DYljFjFvHWJkR5IAXo9uZl9bDhkATMr0F0ng8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727538435; c=relaxed/simple;
	bh=XnAhLzEL23hpoq7qkZP6v0YFARWHVEtHHAldltkiGms=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pu70VdQw/Oid6Zp6ujSw/iwPZRyUgeQ/24Ay2Q2PTUph5bqw2EKshRZbbfhQvOHjN97qePjaf6+YqbyEJmiUxUOqfrGby9OlOKzNVFpkuJPsuMF0PFkJ3SJLWE9dFiU0ACDo4RBzyyys+roXlVxmqVdxsWlddHWbwWeGMz/cgMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ci2ur5us; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C9B6C4CEC3;
	Sat, 28 Sep 2024 15:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727538434;
	bh=XnAhLzEL23hpoq7qkZP6v0YFARWHVEtHHAldltkiGms=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ci2ur5usqwY0/ePzeTQHsLM37V3uSrKQrSltpw4VY4YQMPjTDpNJwYw0xxj7jBX3A
	 GDCQYojOGgEVcSnt8SsM3Yse3Bpu/Gi2YJJCZjBR0pk7YcG/aKf3rP4YFVSbX84gj8
	 SBc2PObCauPCRrHmof3jJLBWln8N/TAxS2Ljk8Yx7C6ixwl9RlbpKcQpjj/rZ2kvY+
	 IcVEV2XKoaMjSmHz48tDA6d1KXicL7LLgkrHFd5gROaZpFTOLnb8GE06Hn/4I9hj3F
	 1eRpsDbXEDt14hJSKfrcFxCXASeIWdofeAQOiMh/fZR8macGyvn7AXw7xH3edMagn2
	 wCbTGFABpjaig==
Date: Sat, 28 Sep 2024 16:47:07 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Abhash Jha <abhashkumarjha123@gmail.com>
Cc: linux-iio@vger.kernel.org, anshulusr@gmail.com, lars@metafoo.de,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/4] Threshold event and Sampling freq support for
 LTR390
Message-ID: <20240928164707.091fa5f7@jic23-huawei>
In-Reply-To: <20240914181246.504450-1-abhashkumarjha123@gmail.com>
References: <20240914181246.504450-1-abhashkumarjha123@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 14 Sep 2024 23:42:42 +0530
Abhash Jha <abhashkumarjha123@gmail.com> wrote:

> Hello,
> 
> The first patch adds support for configuring the Sampling frequency of
> the sensor. The available values for the sampling freqeuncy are provided
> by the `read_avail` callback and they are in miliHertz.
> 
> Then the second patch adds support for suspending and resuming
> the sensor by providing the necessary callbacks. And registering
> the ops with the driver.
> 
> The third patch in the series adds support for Threshold events and interrupts.
> Exposed rising and falling threshold events for both the channels. The events
> can be configured via the write_event_config callback. The desired rising or falling
> threshold value can be written to from userspace.
> 
> The fourth patch adds support for threshold interrupt persistance.
> It triggers when the UVS/ALS data is out of thresholds for a specific number
> of consecutive measurements.
> Exposed the IIO_EV_INFO_PERIOD attribute by which userspace can set the persistance
> value in miliseconds. The persistance period should be greater than or equal
> to the sampling period.

Applied with tweaks to the testing branch of iio.git which will be rebased
on rc1 once available.

Thanks,

Jonathan

> 
> Changes in v3:
> - Replace hardcoded mask values with GENMASK()
> - Minor refactoring
> - Code formatting changes
> 
> Changes in v2:
> - Added "linux/irq.h" include to fix `-Wimplicit-function-declaration`.
> - The above error was pointed during testing by kernel-test-robot
> 
> Thanks,
> Abhash
> 
> 
> Abhash Jha (4):
>   iio: light: ltr390: Added configurable sampling frequency support
>   iio: light: ltr390: Suspend and Resume support
>   iio: light: ltr390: Interrupts and threshold event support
>   iio: light: ltr390: Add interrupt persistance support
> 
>  drivers/iio/light/ltr390.c | 361 ++++++++++++++++++++++++++++++++++++-
>  1 file changed, 357 insertions(+), 4 deletions(-)
> 


