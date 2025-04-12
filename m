Return-Path: <linux-iio+bounces-18012-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E84A86D4B
	for <lists+linux-iio@lfdr.de>; Sat, 12 Apr 2025 15:26:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF45244500A
	for <lists+linux-iio@lfdr.de>; Sat, 12 Apr 2025 13:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF1051E7C10;
	Sat, 12 Apr 2025 13:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UmjGC+SV"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A62413AD1C;
	Sat, 12 Apr 2025 13:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744464377; cv=none; b=M1kcxkL/DxmazrGpCPymp7daDHRzAKOq6w49qbDY5foQOYRNs0zHC0EUKFUJlzrcdq7Z7p4OjuBYVnRuxbh5DC0BFGvlvqYCJr+/G1o18osIYmZi00c48a5KLeBxBsp+dvyNl1UY0O2i23LlffVQWspOorL7AcXcpW0XKkHJFMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744464377; c=relaxed/simple;
	bh=1ALYRoSS13OMdV42CmJZDGrcuxFhf+AdPHTEVZVQj1w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W3Fqduyuno8Gu6DV675nkHVAKjemU7zwT/W1/2dIbFP9t5SqyhEtVo4VEhTqZhoxH4b1/qYQHA0T/g8Kg1Jh6YmP07UzvWU+Kc69FDI66Or8LqUP3HxkeJeUWPrL7F0KxumFoNAl3fKfClXXaE2cCNj6unshoxboAvm+I9jaiwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UmjGC+SV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA9CFC4CEE3;
	Sat, 12 Apr 2025 13:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744464376;
	bh=1ALYRoSS13OMdV42CmJZDGrcuxFhf+AdPHTEVZVQj1w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UmjGC+SVrPZXCioxg+ooNogCzyH8KJb68+7bvldVTrKNG5l078qhhnOxjNOmVb91k
	 KWC0nvj5d66ngb+smsKNsbLLI6suFk2j17tEw1F+20344M4WMjpos0HBXk5LC8UWq1
	 6Fa1YvbZnulVM5cbbkwFvIl5q7w3gPuIKvGSUc2qnlmvO8bvUvxcDzmPeEc4xSrHQx
	 hFeB0lzsJZ+YO9vCUOtRGCDK0eowoCxmxE6LXVxWe4TrUsBUMXSKKuikGS59d006mq
	 u9pckEfFMG8Wu36R7kicT+YPq4KKH77QMtc0Z+R7Pg/cq3ZbvbsKi4B17FODJJB8B4
	 KGGJSot5+EMsA==
Date: Sat, 12 Apr 2025 14:26:06 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Olivier Moysan <olivier.moysan@foss.st.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Fabrice Gasnier
 <fabrice.gasnier@foss.st.com>, <linux-iio@vger.kernel.org>,
 <linux-stm32@st-md-mailman.stormreply.com>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] iio: adc: stm32: add oversampling support
Message-ID: <20250412142606.66673634@jic23-huawei>
In-Reply-To: <20250410135836.2091238-1-olivier.moysan@foss.st.com>
References: <20250410135836.2091238-1-olivier.moysan@foss.st.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Apr 2025 15:58:35 +0200
Olivier Moysan <olivier.moysan@foss.st.com> wrote:

> Add oversampling support for STM32H7, STM32MP15 & STM32MP13.
> STM32F4 ADC has no oversampling feature.
> 
> The current support of the oversampling feature aims at increasing
> the data SNR, without changing the data resolution.
> As the oversampling by itself increases data resolution,
> a right shift is applied to keep initial resolution.
> Only the oversampling ratio corresponding to a power of two are
> supported here, to get a direct link between right shift and
> oversampling ratio. (2exp(n) ratio <=> n right shift)
I rewrapped this description to 75 chars  (which is roughly the maximum
we should see in a commit message).

In general I'd prefer to keep comments in code to 80 char, but in this
particular case I left the formatting you have alone as it was really fiddly
to get it looking nice at a shorter length.

I had applied this but then noticed....

> 
> The oversampling ratio is shared by all channels, whatever channel type.
> (e.g. single ended or differential).
> 
> Oversampling can be configured using IIO ABI:
> - oversampling_ratio_available
> - oversampling_ratio
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
This SoB sequence isn't right.  What was Fabrice's role
in this patch?   Either I'd expect the from to be set to Fabrice
(on basis Olivier was posting some work of Fabrice) or
a Co-developed-by for Fabrice to indicate it was joint work
and Olivier was the one posting it.

