Return-Path: <linux-iio+bounces-8855-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7DC963AE1
	for <lists+linux-iio@lfdr.de>; Thu, 29 Aug 2024 08:09:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A063F1F2159E
	for <lists+linux-iio@lfdr.de>; Thu, 29 Aug 2024 06:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5328915575B;
	Thu, 29 Aug 2024 06:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M+RRpYkY"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0764415358F;
	Thu, 29 Aug 2024 06:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724911572; cv=none; b=bBmPNZJFsENxfrgFzHFA28gXFvn/SGJNpyI0d5KApSEKcz8KKkA4e+yT09ZcO8HQjthUh34r5CbmaCsW2SEWpotaYh0C+122JyZ0vQW5Cs35s7F3esZ8v0t3ZHMo/RpiOimxadhmGtv4z2JtnEOHjWaULpy1OfLKj1pYFwFR7kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724911572; c=relaxed/simple;
	bh=KlJJ1rANOOQ3bwMv2N14jrYpMJK7qqWAydxM+4Q7g3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PBXvFrRDLp+wAOOfeXk351apXNL4teT58VoUw8Rq2sHm13iZx6FB4KDdIhFR8JsBCVQvN781xco4G+lcocqvDkyZSA85YcZ8dksS4NnSQjJfeqG+G/gzgRuyBn2X6fc6ATv4/ujFlcUodjGlRf4ag+7fMDZhRn/Gt7h17PWkQiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M+RRpYkY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70E9AC4CEC1;
	Thu, 29 Aug 2024 06:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724911571;
	bh=KlJJ1rANOOQ3bwMv2N14jrYpMJK7qqWAydxM+4Q7g3s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M+RRpYkY5l0FEJMDXFwo4yQHpoAwkWnq2eowmDzFKB4mfWJfuDfhWwxsByWhbBjVf
	 WjuyuYLeKqsXSi4U06J6uq2K2LFAqNyz6O/UvZKLdggvb2AuGTBnYkqoWXD2xhdabY
	 7qPab+CWnZJDMRac5DUrzDzi5FfxTw+rXx2SUsoI19A5eJy9mamk2ybWBGhqjgXYlC
	 aJFdaImXELaiws82swaFnjVv0ZRQTjwKwTll+wKSm6DROamlDSRiiK/LoQ/T7s70Qy
	 gRtH5nI99VPbWFEVUS+mLkLX41lwyjdoH37Uj1JHL0o7CVGR1CwjKSmQ6FjkQPyN1E
	 44sy5rL6Fublw==
Date: Thu, 29 Aug 2024 08:06:07 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, andriy.shevchenko@linux.intel.com, ang.iglesiasg@gmail.com, 
	linus.walleij@linaro.org, biju.das.jz@bp.renesas.com, javier.carrasco.cruz@gmail.com, 
	semen.protsenko@linaro.org, 579lpy@gmail.com, ak@it-klinger.de, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, christophe.jaillet@wanadoo.fr
Subject: Re: [PATCH v4 5/7] dt-bindings: iio: pressure: bmp085: Add
 interrupts for BMP3xx and BMP5xx devices
Message-ID: <fzdd26t5kjtwhvxxjq7k7ilbmx7i5r6phcygv5nlq2ajntlqht@pkt3kmr2hv6s>
References: <20240828205128.92145-1-vassilisamir@gmail.com>
 <20240828205128.92145-6-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240828205128.92145-6-vassilisamir@gmail.com>

On Wed, Aug 28, 2024 at 10:51:25PM +0200, Vasileios Amoiridis wrote:
> Add interrupt options for BMP3xx and BMP5xx devices as well.
> 
> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> ---
>  .../bindings/iio/pressure/bmp085.yaml         | 22 ++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml b/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml
> index 6fda887ee9d4..edf5901c6c87 100644
> --- a/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml
> +++ b/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml
> @@ -48,14 +48,34 @@ properties:
>  
>    interrupts:
>      description:
> -      interrupt mapping for IRQ (BMP085 only)
> +      interrupt mapping for IRQ. Supported in BMP085, BMP3xx, BMP5xx
>      maxItems: 1
>  
> +  drive-open-drain:
> +    description:
> +      set if the interrupt pin should be configured as open drain.
> +      If not set, defaults to push-pull configuration.

I don't think you implemented my comment.

> +
>  required:
>    - compatible
>    - vddd-supply
>    - vdda-supply
>  
> +allOf:
> +  - if:

not:

> +      properties:
> +        compatible:
> +          enum:
> +            - bosch,bmp085
> +            - bosch,bmp380
> +            - bosch,bmp580
> +    then:
> +      properties:
> +        interrupts: true
> +    else:

so no need for else:.


Best regards,
Krzysztof


