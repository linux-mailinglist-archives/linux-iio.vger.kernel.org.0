Return-Path: <linux-iio+bounces-18692-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E36A9DB67
	for <lists+linux-iio@lfdr.de>; Sat, 26 Apr 2025 16:16:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E1F91BA53E1
	for <lists+linux-iio@lfdr.de>; Sat, 26 Apr 2025 14:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45D2B1F3D54;
	Sat, 26 Apr 2025 14:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="COTrvjgF"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015D6A926;
	Sat, 26 Apr 2025 14:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745676960; cv=none; b=oSCVSyNmp1fNXGteM/xH6vyXJHpgzNf9rQ5Gg91ZyPh4K7vYXvmmg74YfaPDj8PXmblmZUSKm+7zrjKZe266gglrOKOKZ6Hj2n22cyHP9wzvqfIlVNNDvFMc838nj50FXA/mO585s21W+TqpHC56sUv25I52cXMv+v8aC6gMjQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745676960; c=relaxed/simple;
	bh=gq8XinHjcqlcRZOej/1xdHnTuoPfOzXjgO/z4DEC6jQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I8TZCXpBBVt09b7wbbhBrzueK4ejkg/vJrDWkryip0x/SrNs+jNDULiPPeTb7vMQKEIpUs42p92kzkPKMvDxdDch5r1pGah7iQ1OVqGrdjwUgDYToco+bqLUbJcwOFk80hYWgXl4Yf49pMQ8PceOtBlRWNO2TF9O43kZbb8T1+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=COTrvjgF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25313C4CEE2;
	Sat, 26 Apr 2025 14:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745676959;
	bh=gq8XinHjcqlcRZOej/1xdHnTuoPfOzXjgO/z4DEC6jQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=COTrvjgFkwOTT+Swfx9KhSAoZJ28/vPDZK55Zbk6uIdUp3UuSu2Dx6ZXjunBVXBnJ
	 XrQ0tH6C1Eftu5rM1C+Oau8SUkldKc66L47wFeycHUoibteXtpKQMLOX396qezm9Qq
	 wxT6perzW+6AzX35cMy6No17sV1msV5sXpTvyYZMEeCgqftB4KPlpVIKuuMe+jkk1Y
	 TC5yrlSilYxb/VHblwCrWigvJ1N4t3VOnVtymKVWSHQNuAiu+2gsVQwKenmh0X2tOD
	 XkzVvCxgVLn9o5silT4lBPqaMcjPqcwhp2yRD4LX9blCZWT0Nzh84+4skDEwMYY78V
	 uXAIsbmVj0vQA==
Date: Sat, 26 Apr 2025 15:15:52 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Olivier Moysan <olivier.moysan@foss.st.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Fabrice Gasnier
 <fabrice.gasnier@foss.st.com>, <linux-iio@vger.kernel.org>,
 <linux-stm32@st-md-mailman.stormreply.com>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5] iio: adc: stm32: add oversampling support
Message-ID: <20250426151552.10aaee38@jic23-huawei>
In-Reply-To: <20250424151604.626758-1-olivier.moysan@foss.st.com>
References: <20250424151604.626758-1-olivier.moysan@foss.st.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Apr 2025 17:16:03 +0200
Olivier Moysan <olivier.moysan@foss.st.com> wrote:

> Add oversampling support for STM32H7, STM32MP15 & STM32MP13.
> STM32F4 ADC has no oversampling feature.
> 
> The current support of the oversampling feature aims at increasing the
> data SNR, without changing the data resolution.
> As the oversampling by itself increases data resolution, a right shift
> is applied to keep the initial resolution.
> Only the oversampling ratio corresponding to a power of two are
> supported here, to get a direct link between right shift and
> oversampling ratio. (2^n ratio <=> n right shift)
> 
> The oversampling ratio is shared by all channels, whatever channel type.
> (e.g. single ended or differential).
>
> Oversampling can be configured using IIO ABI:
> - oversampling_ratio_available
> - oversampling_ratio
>
Applied to the togreg branch of iio.git. Initially pushed out as testing
to let 0-day have a first poke at it.

Thanks,

Jonathan

