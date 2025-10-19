Return-Path: <linux-iio+bounces-25265-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAD68BEE113
	for <lists+linux-iio@lfdr.de>; Sun, 19 Oct 2025 10:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D4EA3AC3BB
	for <lists+linux-iio@lfdr.de>; Sun, 19 Oct 2025 08:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2103D242D9B;
	Sun, 19 Oct 2025 08:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YQvv/Is0"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFCA5A930;
	Sun, 19 Oct 2025 08:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760863736; cv=none; b=WA8H7f1Vbb4ueQ4OTlwtuQgjcPDKZeZAF7sGIcTERccbK+l7uwoL1q1lk/96ucltyTOvnnzj4634MentWJkl7lbk0YPceN43oCymXTqgkslt60y6IuR+BLgRmcM8mSe87IXaKH6qrUQZDCjmTtp0FD48hEFLgHLu4ROEm4A8Be0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760863736; c=relaxed/simple;
	bh=rs7ILBWWDaHVFHhFR6/j1ZRqcnL3VjLz0/Wuu11GHBk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A244wOJBESt4buW3HSAySbleA8MCQPVirCA0SQGV8pq2Wd/oMujhx35Z01m+vIznKvCd1OSyHI1DQ/OIfq5W8fg3X0hUtTIlt631VW2n2AWXiGbJakoFuMWNxmqfpgHj2p6uTt4i02/Kp+5kKaouANshBbrR+pT2gPgoEtEJkBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YQvv/Is0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78843C4CEE7;
	Sun, 19 Oct 2025 08:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760863736;
	bh=rs7ILBWWDaHVFHhFR6/j1ZRqcnL3VjLz0/Wuu11GHBk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YQvv/Is055c1LhfGFXsCLLRCr5WQKAX1y7RFVsdH15mYJHJ42K3Aij0Tw+kRA7iJM
	 edsHAyfCG1/XcFraBevIavyqoCxsWjS85TFaWVpQuh4vgP6cxjQI4P6U07fDMiZZg/
	 54RR2DXzZHHXO38r+DhGCfCyZtpWbH6FpXain0/mfHGmFyAOX+DAZ4x+MChO266Ezl
	 d0uuG+u7cuqIusH85he/DJJr3BCwaLBDprMNeGYb/AzwSF38rvAaujChBIlgRJXsBG
	 /ZYkmCMgSfgpZJn8lQ4YNylI3kK9CFRuogc7Up3PIgR51D88Pzlqob90JjWQ9nkgw8
	 6qtDlAixwrNjA==
Date: Sun, 19 Oct 2025 09:48:49 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Dimitri Fedrau via B4 Relay
 <devnull+dimitri.fedrau.liebherr.com@kernel.org>
Cc: dimitri.fedrau@liebherr.com, Javier Carrasco
 <javier.carrasco.cruz@gmail.com>, Li peiyu <579lpy@gmail.com>, David
 Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Dimitri Fedrau
 <dima.fedrau@gmail.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Chris Lesiak
 <chris.lesiak@licorbio.com>
Subject: Re: [PATCH v4 0/2] iio: humditiy: hdc3020: fix units
Message-ID: <20251019094849.0b904e2c@jic23-huawei>
In-Reply-To: <20251016-hdc3020-units-fix-v4-0-2d9e9f33c7b1@liebherr.com>
References: <20251016-hdc3020-units-fix-v4-0-2d9e9f33c7b1@liebherr.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 16 Oct 2025 07:20:37 +0200
Dimitri Fedrau via B4 Relay <devnull+dimitri.fedrau.liebherr.com@kernel.org> wrote:

> Fix units to milli degree celsius and milli percent for temperature
> respectively relative humidity measurements and thresholds.
> 
> Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
Hi Dimitri,

I think this covers the last bits of feedback so I'll queue it up in the
fixes-togreg branch of iio.git.  I'll probably not send a pull request
for that for a few more days though so there is still time for additional
feedback.

Also marked for stable.

Thanks

Jonathan

> ---
> Changes in v4:
> - Add explicit formula into comments of hdc3020_thresh_get_temp and
>   hdc3020_thresh_get_hum
> - Add explicit division by 5 into calculations in hdc3020_thresh_get_temp
>   and hdc3020_thresh_get_hum
> - Link to v3: https://lore.kernel.org/r/20251013-hdc3020-units-fix-v3-0-b21fab32b882@liebherr.com
> 
> Changes in v3:
> - Fix verbose comment for define HDC3020_THRESH_FRACTION (Javier)
> - Embed prescale into define HDC3020_THRESH_FRACTION to make the division
>   by 5 calculation in threshold calculations explicit. (Andy)
> - Add resulting units into comments again in hdc3020_thresh_get_temp and
>   hdc3020_thresh_get_hum (Andy)
> - Link to v2: https://lore.kernel.org/r/20250901-hdc3020-units-fix-v2-0-082038a15917@liebherr.com
> 
> Changes in v2:
> - Added explanation what is wrong at the moment into commit msg
> - Added define HDC3020_THRESH_FRACTION and comment at the beginning of the
>   code.
> - Use MILLI for instead of hardcoded 1000.
> - Link to v1: https://lore.kernel.org/r/20250821-hdc3020-units-fix-v1-0-6ab0bc353c5e@liebherr.com
> 
> ---
> Dimitri Fedrau (2):
>       iio: humditiy: hdc3020: fix units for temperature and humidity measurement
>       iio: humditiy: hdc3020: fix units for thresholds and hysteresis
> 
>  drivers/iio/humidity/hdc3020.c | 73 +++++++++++++++++++++++++-----------------
>  1 file changed, 43 insertions(+), 30 deletions(-)
> ---
> base-commit: 875e7d357a7f2e77a7f3fc4759d0aa0872c33027
> change-id: 20250820-hdc3020-units-fix-91edbb8ccd07
> 
> Best regards,


