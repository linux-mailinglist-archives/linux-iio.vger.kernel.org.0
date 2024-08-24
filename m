Return-Path: <linux-iio+bounces-8744-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1264395DC96
	for <lists+linux-iio@lfdr.de>; Sat, 24 Aug 2024 09:46:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C02AB21B10
	for <lists+linux-iio@lfdr.de>; Sat, 24 Aug 2024 07:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513AA14D6F7;
	Sat, 24 Aug 2024 07:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sL7DQqzW"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C279C148;
	Sat, 24 Aug 2024 07:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724485554; cv=none; b=uSyReJNmUyvNs8Ed/pDMAX41BNdel2teXfYQSTVwz3Mv/jmQzz7UWjABPpjtMlRx3dN3Grfa7t0z5DH0bkrMIpVlTt0IB68lItr75ihxtUYgznLu5BwCT+E0+KOdPHhnC6TnmcUIPRR5zCH/My8/I3VijVvCwOqDqAxTBStLkOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724485554; c=relaxed/simple;
	bh=3i+w+N44tXAoUHTzClQeQQDm1brA3WjcnohPesbmGfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FaF2VUYM4Dri75EVLx0PMMRz1U3+NFbykQOuriclSAjpbWddl4Le8yRbIiUKDsepzaMKMUNfrdiSSeF719iucQNUeXVuMVgMOasYbQINOY8c5d21dGLJe8IiQcyhqD3CtaUo9Q137lmEl1C38UXOw150dtINuRbgNnZBG32lL4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sL7DQqzW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D095EC4AF0C;
	Sat, 24 Aug 2024 07:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724485553;
	bh=3i+w+N44tXAoUHTzClQeQQDm1brA3WjcnohPesbmGfU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sL7DQqzWNFrTkJbhu2SGHKXye9qjNiTpEGS0NMry2XydER/N4Mbl61VNP7WFIyp6L
	 BGm5L4f9DPDJpSzLrVJ2S8r8yzh+sFU2U30YcfQQVR7p0KoAl+mqIIM4FQCfqSIkdA
	 QMyg6yS/wvPB6eCfEHTSvHyh2MGTyIFzApcFrjtC6j3cI57H+6gcHXROfsxC50bQca
	 5Y02uIQjgP4jJWIexvQrUFNcmhRQBDsdrVE5VKgTaBJPOyDlsJ9NzgG+Qhw/dV6gCx
	 rzzT+5i98zoiCLQqpr3xLHvLgfRpGnZKu9WyfzgCnx00KW0eNrlDs/2Ge6W4zdzyaH
	 Qxi1vSJBWIgzg==
Date: Sat, 24 Aug 2024 09:45:43 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, andriy.shevchenko@linux.intel.com, ang.iglesiasg@gmail.com, 
	linus.walleij@linaro.org, biju.das.jz@bp.renesas.com, javier.carrasco.cruz@gmail.com, 
	semen.protsenko@linaro.org, 579lpy@gmail.com, ak@it-klinger.de, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/7] dt-bindings: iio: pressure: bmp085: Add
 interrupts for BMP3xx and BMP5xx devices
Message-ID: <7eqtnkkgnyskkmecv7dtiyzd6invdl7xa56cih6fbuuu2jrprx@s4jpi4ls6dxn>
References: <20240823181714.64545-1-vassilisamir@gmail.com>
 <20240823181714.64545-6-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240823181714.64545-6-vassilisamir@gmail.com>

On Fri, Aug 23, 2024 at 08:17:12PM +0200, Vasileios Amoiridis wrote:
> Add interrupt options for BMP3xx and BMP5xx devices as well.
> 
> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> ---
>  Documentation/devicetree/bindings/iio/pressure/bmp085.yaml | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml b/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml
> index 6fda887ee9d4..eb1e1ab3dd18 100644
> --- a/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml
> +++ b/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml
> @@ -48,9 +48,14 @@ properties:
>  
>    interrupts:
>      description:
> -      interrupt mapping for IRQ (BMP085 only)
> +      interrupt mapping for IRQ. Supported in BMP085, BMP3xx, BMP5xx

Supported by driver or device?
If the latter, this should be constrained per device variant in
allOf:if:then:.


>      maxItems: 1
>  
> +  drive-open-drain:

Missing type, unless some other core schema defined it? But then I
actually wonder if we need it.  Maybe this should be interrupt flag?
Just like GPIO has such.

Best regards,
Krzysztof


