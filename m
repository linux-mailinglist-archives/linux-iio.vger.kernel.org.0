Return-Path: <linux-iio+bounces-26822-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 455FDCAA4C4
	for <lists+linux-iio@lfdr.de>; Sat, 06 Dec 2025 12:04:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 31534300D728
	for <lists+linux-iio@lfdr.de>; Sat,  6 Dec 2025 11:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 500452F3611;
	Sat,  6 Dec 2025 11:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="joLMwunP"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0A7286422;
	Sat,  6 Dec 2025 11:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765019042; cv=none; b=k2l1WA5JwIWCqjFRHmjxZlHl5/43tu+sNWxD+xNkIeIR44XG3KZR1XeMZrHzZtw8rVk93wOAEu+mNm2Mx+O6mro0UJ0HqlSLjdDWugk/lT8bATiAutBjJ0mlol4SLunwY3Is/es+HbIj5klUh0SafONBdSEq/g1VIW/5dtwsd2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765019042; c=relaxed/simple;
	bh=S+gE0d70l6VsPaGwoSM79COySGokrUyXP9ilj98vBbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m+Q4bq3oD8jAkrQcCydRyDEmF4PxgKUDpng783rdhKNVMXwrNH2M1QYCLad9oT4rAtWhzh44+o9wT1NzoIV62H9mqYXOBmtW8D7+64cP5oDDNvl0Cdd1tXGZ0OwcVDAUu1tcHsmfLwGTIshEXmQZsoXHLDJe9vby7gW3rq6cosU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=joLMwunP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DEDCC4CEF5;
	Sat,  6 Dec 2025 11:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765019041;
	bh=S+gE0d70l6VsPaGwoSM79COySGokrUyXP9ilj98vBbM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=joLMwunPCDGpLoz9EnrVnyySoS+eL2+FW2o6dS29/Uo6pd4FogUVfTk4KURxdZLF5
	 2kouAM7ljUQa6pWd6aYLa4DsFPyFT7kqdx/3B97iovNNU8pFe/hoqlFSBMNhkjlxcc
	 WL1R9quZG5XA9JY0YDBWP4IkqmCCTb+L37ONhhgY58zSowz4IxJDczBK9fA7mW/O98
	 p1N3YMfo1zZnZyKPrH/wV/LbCiqAU+OZ4d4OTdT2A3hNWLWMTBX/gG4y8qBmHhhZ+k
	 9ZjKJKBV+qdOpOWFrsIZX/A0aHH1GI0phC+92up6zBg7XT+WWafqaKCSC8+OmN6+wZ
	 p2j1Rw3VX8wSg==
Date: Sat, 6 Dec 2025 12:03:59 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Tomas Melin <tomas.melin@vaisala.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: adc: ad9467: add support for ad9211
Message-ID: <20251206-tangerine-wildebeest-of-weather-8f9211@quoll>
References: <20251204-add-ad9211-v2-0-a1561f977ee5@vaisala.com>
 <20251204-add-ad9211-v2-1-a1561f977ee5@vaisala.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251204-add-ad9211-v2-1-a1561f977ee5@vaisala.com>

On Thu, Dec 04, 2025 at 08:01:03AM +0000, Tomas Melin wrote:
> Document ad9211 variant as supported by driver. This has e.g.

Drop "as supported by driver", not relevant here. Just say that device
is not compatible with existing because of different scaling ....


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

<form letter>
This is an automated instruction, just in case, because many review
tags are being ignored. If you know the process, just skip it entirely
(please do not feel offended by me posting it here - no bad intentions
intended, no patronizing, I just want to avoid wasted efforts). If you
do not know the process, here is a short explanation:

Please add Acked-by/Reviewed-by/Tested-by tags when posting new
versions of patchset, under or above your Signed-off-by tag, unless
patch changed significantly (e.g. new properties added to the DT
bindings). Tag is "received", when provided in a message replied to you
on the mailing list. Tools like b4 can help here ('b4 trailers -u ...').
However, there's no need to repost patches *only* to add the tags. The
upstream maintainer will do that for tags received on the version they
apply.

https://elixir.bootlin.com/linux/v6.15/source/Documentation/process/submitting-patches.rst#L591
</form letter>

Best regards,
Krzysztof


