Return-Path: <linux-iio+bounces-22962-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC9E4B2B9FA
	for <lists+linux-iio@lfdr.de>; Tue, 19 Aug 2025 08:57:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A4E21BA0981
	for <lists+linux-iio@lfdr.de>; Tue, 19 Aug 2025 06:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2BD026E6EB;
	Tue, 19 Aug 2025 06:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YMCvZLMK"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C01052F66;
	Tue, 19 Aug 2025 06:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755586591; cv=none; b=i88PEElB8i/qmH7EI8zDfOw77Wy6CojWPKxlkzK6pA0OZSx70RxYGtYcpCh4NdtXoKf5lLyUE1DYVV/nd82MOVcWwEaNmUAs6ZF4qcL09PGJlKtPHZfbr2FfImkGZIC4vfpkMWLDLwiM77rGZdCmgtvYR5H9vm4IA26Hj9eqKXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755586591; c=relaxed/simple;
	bh=Pop2R6VXBefbnAi8c8033n6v3m0oYiVHRbQAGEwgxTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nJdiVnCmjpR7cNaT7ptP6gVjvGQ4m42MHzjp/lu1Yhkg3XiUUKLqFgtF/wH7DpQIQCkyMrFHC1AMC6j5qoFanH9cxJKsTtboqN73xr01APTl4YPF37u+KqEYn/3BjCJ1Id3SP/H285Uzv8GIisiFSHB7ebL2PD6xzqvXaBqclxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YMCvZLMK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71B57C4CEF1;
	Tue, 19 Aug 2025 06:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755586591;
	bh=Pop2R6VXBefbnAi8c8033n6v3m0oYiVHRbQAGEwgxTc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YMCvZLMKD3GjUs+j+/S0Aqum7iOlIlRxLsPuT7c2ez/x1HCjoMx/6l8b+m4RBFdRX
	 h44NGZEh+esDS4mvLFAR+qtThqFmidgpaVlJjQiSFed24pgIfsGAHSfIMNsfevKzAq
	 03XzGXnHLERbVhAMgAjzt0p9E/Wtd2+YMx32Z2xCSDe/sPT5RIwJu9sYoffZ3eKxpl
	 w7GPs/orZo2S18r2+4ch012wfQPSHkAUQC7M6ZFLoPSmYk9XHScRkzQ5a5CDnjpADn
	 +g8XaQuF1434YvciQCqxG1TuZQGiD7DFCIF48AKxF1dntu47pPyxuacBYrhu8/amDf
	 FOe+6W4kwrthA==
Date: Tue, 19 Aug 2025 08:56:28 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Ben Collins <bcollins@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Andrew Hepp <andrew.hepp@ahepp.dev>, Ben Collins <bcollins@watter.com>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] dt-bindings: iio: mcp9600: Set default 3 for
 thermocouple-type
Message-ID: <20250819-weightless-cobra-of-atheism-f8faf3@kuoka>
References: <20250818183214.380847-1-bcollins@kernel.org>
 <20250818183214.380847-2-bcollins@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250818183214.380847-2-bcollins@kernel.org>

On Mon, Aug 18, 2025 at 02:32:09PM -0400, Ben Collins wrote:
> From: Ben Collins <bcollins@watter.com>
> 
> As is already documented in this file, Type-K is the default, so make
> that explicit in the dt-bindings.
> 
> Signed-off-by: Ben Collins <bcollins@watter.com>
> ---
>  .../devicetree/bindings/iio/temperature/microchip,mcp9600.yaml   | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


