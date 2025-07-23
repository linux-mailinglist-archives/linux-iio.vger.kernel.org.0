Return-Path: <linux-iio+bounces-21893-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3B87B0EC23
	for <lists+linux-iio@lfdr.de>; Wed, 23 Jul 2025 09:42:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CF341AA78CD
	for <lists+linux-iio@lfdr.de>; Wed, 23 Jul 2025 07:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CFBF27702E;
	Wed, 23 Jul 2025 07:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dUW962WO"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E46248F5F;
	Wed, 23 Jul 2025 07:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753256542; cv=none; b=kIPA8ECiTR2T/ZbkxcKuv+gunGKgC0K0YQlevCYgkojjNQTlIkygVkzjnRQ4gJTEQ/R+jKvX3knm8uTga/V/hUMqpGSO4FgV9quZ6vrHFLeNOjflJM4lgSIoVAhdN2916UceusO3cojV/8Ke/gqTEBJkqHiM7XHxFzz040xHGpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753256542; c=relaxed/simple;
	bh=fYh2NB4GUoqzaRVlaz/dvGLqiathfR8O8zqZOjCaDRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=slwO2oDnTzwXVRHeaMu5PL50qyDF4MzNVeuDFlMzTAQ+1WGsa2dj6gQFyHZ473KJlMe9e0X3SoUWofcExJX0qvkunQOe1XKRP+4yycLrdefZebxPM19WzBv+hFO3/Z5Mwa/Mt4FQuieKVSgScZFpsJFqBxJ+5rwYhWBvHGfOvCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dUW962WO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25A78C4CEE7;
	Wed, 23 Jul 2025 07:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753256538;
	bh=fYh2NB4GUoqzaRVlaz/dvGLqiathfR8O8zqZOjCaDRo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dUW962WOw9nxieE72WyF/Yus+q+umq2odPt2oyw0iM1A7fwa09VWCK+HgAINsLxfm
	 4YyFn6tk1wLrFdpYoTtfFn6rGQ+/f2RslTqft+ne0kRbuPLyO0Uy2f8phKammS3vnA
	 KkmlRCluerSgbYsDUjnOfYyOo0kXEcb8RmxffmqO/FCKPKIJMrKVGbHR92AGtRGDRf
	 L65KJkOXNIqEVcH8tB9/2VSIwZ65prnYCxwtbJw8W5n0RERvyIHCXw9sHKse/xjhTN
	 8Uhw9gYdJuATIypdsx1w+TY0YgFzGgmHBrcC/UrIbSZD9eT5LIPcC+HHpzmIx4n4Zl
	 3iK/XMnPmBKrA==
Date: Wed, 23 Jul 2025 09:42:16 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Sanjay Suthar <sanjaysuthar661996@gmail.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-iio@vger.kernel.org, netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-amlogic@lists.infradead.org, ribalda@kernel.org, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, neil.armstrong@linaro.org, 
	khilman@baylibre.com, jbrunet@baylibre.com, martin.blumenstingl@googlemail.com
Subject: Re: [PATCH v3] dt-bindings: cleanup: fix duplicated 'is is' in YAML
 docs
Message-ID: <20250723-foamy-glaring-tench-561fe2@kuoka>
References: <20250722170513.5854-1-sanjaysuthar661996@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250722170513.5854-1-sanjaysuthar661996@gmail.com>

On Tue, Jul 22, 2025 at 10:35:13PM +0530, Sanjay Suthar wrote:
> Fix minor grammatical issues by removing duplicated "is" in two devicetree
> binding documents:
> 
> - net/amlogic,meson-dwmac.yaml
> - iio/dac/ti,dac7612.yaml
> 
> Signed-off-by: Sanjay Suthar <sanjaysuthar661996@gmail.com>
> ---
> Changes since V2:
> - Corrected the subject line
> - link to v2 : https://lore.kernel.org/linux-iio/20250720182627.39384-1-sanjaysuthar661996@gmail.com/T/#u

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


