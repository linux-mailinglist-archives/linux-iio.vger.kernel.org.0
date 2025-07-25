Return-Path: <linux-iio+bounces-22023-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 657BBB12773
	for <lists+linux-iio@lfdr.de>; Sat, 26 Jul 2025 01:27:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 146BC5A2D1F
	for <lists+linux-iio@lfdr.de>; Fri, 25 Jul 2025 23:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12816262FD0;
	Fri, 25 Jul 2025 23:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ihiRRkKq"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD773262D14;
	Fri, 25 Jul 2025 23:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753486027; cv=none; b=gY32MRvIj5sin5nz2JTR6W8t4WKGFLrtFWNM1q4XtILA+zkszxLo2tBoCpUYP/i2nI3mHuOMv/cFkBO3xUIbCjjrazAc1stcgZ4KYHWXA1DgIdCuBPX7n/af2i9lu41nL0NKnQBD4SGyDwa0g/Ch2+SLi3UAbIrn/JzSJqNt68w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753486027; c=relaxed/simple;
	bh=1D5Cen4w32EzTcG4YKubhAFWUoYoIC6LSnVdLASv/X0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EpY8QF+If68ha+jZiTUOxJf2bFWBUqZ6yRRZrvAxkKR+jCsxRgxdC7Vkks7p2FKBcNyMaCT7EwF4BSQLjTVJDcmBitd/lgQSg0R1ayZjhXRJQNz0fN0Md05lRbmRdYR327C8V1JgFPEpUIPlmhP2yr1/l9aAfJQVRwYRVjQ5R2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ihiRRkKq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74A4AC4CEF4;
	Fri, 25 Jul 2025 23:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753486027;
	bh=1D5Cen4w32EzTcG4YKubhAFWUoYoIC6LSnVdLASv/X0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ihiRRkKqmOS5fWcijJ50OOIjmcgkrCWXXaTX4XcAV+SehMWjdHq99jRncjBz7bk6N
	 WO3A340rTt0y4zEti0YuC625hSD/Koafe7zB0X9Zjz8WdwDrNlt9X3rTQTR/pteC3P
	 /VO0mx8iPHetcr+/S1p2nrztYifXuhUTs+4mbQBWQOI0oAB9/dVNd0BqfcJieyov+1
	 b3mmki+sAsX6qvxd7cEloIlxOKyRyVYqcYmtD6p+EpLAsWHNzQk7ln7LqKLkefAHKt
	 VkWioRoeqYo5wZBK4/Iy/XlDUgXEL+hDzGzydrTWi/FGjNayvMSm05dZSeSd1I30D3
	 taQ9CVREn8jCA==
Date: Fri, 25 Jul 2025 18:27:06 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 1/4] dt-bindings: iio: adc: adi,ad7124: fix clocks
 properties
Message-ID: <175348602635.2026537.7901713448810166521.robh@kernel.org>
References: <20250724-iio-adc-ad7124-proper-clock-support-v1-0-88f35db2fcaf@baylibre.com>
 <20250724-iio-adc-ad7124-proper-clock-support-v1-1-88f35db2fcaf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250724-iio-adc-ad7124-proper-clock-support-v1-1-88f35db2fcaf@baylibre.com>


On Thu, 24 Jul 2025 18:25:22 -0500, David Lechner wrote:
> Use correct clocks properties for the AD7124 family of ADCs.
> 
> These ADCs have an internal clock along with an optional external clock
> that can be connected to the CLK pin. This pin can be wired up 3 ways:
> 1. Not connected - the internal clock is used.
> 2. Connected to an external clock (input) - the external clock is used.
> 3. Connected to the CLK pin on another ADC (output) - the internal clock
>    is used on one and the other is configured for an external clock.
> 
> The new bindings describe these 3 cases by picking one of the following:
> 1. Omit both clocks and #clock-cells properties.
> 2. Include only the clocks property with a phandle to the external clock.
> 3. Include only the #clock-cells property on the ADC providing the output.
> 
> The clock-names property is now deprecated and should not be used. The
> MCLK signal that it refers to is an internal counter in the ADC and
> therefore does not make sense as a devicetree property as it can't be
> connected to anything external to the ADC. Since there is only one
> possible external clock, the clock-names property is not needed anyway.
> Based on the implementation of the Linux driver, it looks like the
> "mclk" clock was basically being used as a control to select the power
> mode of the ADC, which is not something that should be done in the
> devicetree.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>  .../devicetree/bindings/iio/adc/adi,ad7124.yaml     | 21 ++++++++++++++++-----
>  1 file changed, 16 insertions(+), 5 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


