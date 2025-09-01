Return-Path: <linux-iio+bounces-23625-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F14B3EF5A
	for <lists+linux-iio@lfdr.de>; Mon,  1 Sep 2025 22:17:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3E871769C1
	for <lists+linux-iio@lfdr.de>; Mon,  1 Sep 2025 20:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC8EC26B760;
	Mon,  1 Sep 2025 20:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lqMGrIjp"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80916223DF0;
	Mon,  1 Sep 2025 20:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756757849; cv=none; b=JFUrHSQ3KhIRXO/tvK6hs2yJLSs32IeePGZWWx2CLdWMymn6e3edgqlvbUKlcHwWYOkIWLZwH/EC1IKn5yk8hxxWHmpzgth5W7per8fte64B+ixcy7O0iCOs19EeZj1QHFEMWaTpWhtkCAFPLbbk71NRSZQJSnfC78GpK5aC8lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756757849; c=relaxed/simple;
	bh=RKwQXF/H4mM8TexV6zQanbTgwCRsx0sgE9ekNciWRT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AF4lNwS77g1c7Myvz3A1ghERzbT/QjXM2Ym3Ro9xUZnz2ZLl7VsXQLv2jwbhKqk2lgqGlgNcfNbAJfDc0Qn6gaEsoDvWQDLQPYu3p9NOdtyLtNaBIyULBaAdr/GorimxQMxXdHM7eN84AMZyK1adMuFZELiSBe25OYgI3nGMuMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lqMGrIjp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3401C4CEF0;
	Mon,  1 Sep 2025 20:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756757848;
	bh=RKwQXF/H4mM8TexV6zQanbTgwCRsx0sgE9ekNciWRT8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lqMGrIjpRvDAbgkTbKP5pEBdNsuyFf9b3EEawpxGbDJoYeDrjjVcUlPWfuH2hUYUf
	 5znz48aCKZv8ivOxXP6bQertUxs6gBfUBSoHSBeTOS+XeyLgS2cwYX2Kv41LxLr11B
	 VK7BKtboG075hNa7IlSEo4EAQUwgqKTjveQ42axI+0//sLPEOovjWUG82HHTJ5wgHF
	 Ab24J7B6HuQy/lnLtYWk1JwQvqP9JiWEx1XqmN6GPOZA1AFeSrvqcnC38ANsnAnni8
	 BRQstalGfue+e5EghVd9YjKiAA0tYe2hJkhQ2Xx4tl/fhQMyPmR9fgSlsOJF4Cz71V
	 DSnGyMJB4Wpqw==
Date: Mon, 1 Sep 2025 15:17:27 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v2 4/5] dt-bindings: iio: adc: samsung,exynos: Drop
 S3C2410
Message-ID: <175675784648.271916.11996666409097079918.robh@kernel.org>
References: <20250830-s3c-cleanup-adc-v2-0-4f8299343d32@linaro.org>
 <20250830-s3c-cleanup-adc-v2-4-4f8299343d32@linaro.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250830-s3c-cleanup-adc-v2-4-4f8299343d32@linaro.org>


On Sat, 30 Aug 2025 18:48:33 +0200, Krzysztof Kozlowski wrote:
> Samsung S3C24xx family of SoCs was removed the Linux kernel in the
> commit 61b7f8920b17 ("ARM: s3c: remove all s3c24xx support"), in January
> 2023.  There are no in-kernel users of remaining S3C24xx compatibles.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml | 4 ----
>  1 file changed, 4 deletions(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


