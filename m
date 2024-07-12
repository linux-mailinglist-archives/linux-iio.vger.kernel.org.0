Return-Path: <linux-iio+bounces-7543-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEAF892FA9D
	for <lists+linux-iio@lfdr.de>; Fri, 12 Jul 2024 14:48:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 718E51F21802
	for <lists+linux-iio@lfdr.de>; Fri, 12 Jul 2024 12:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7151A16F293;
	Fri, 12 Jul 2024 12:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ll9xEbdL"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2658313A86D;
	Fri, 12 Jul 2024 12:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720788487; cv=none; b=VO+zl09BpS8Vp1qS5srk7bz+qlwecRg7ZGXMOvgv8leX8mL8NVJQi1QZ6PWRAoaZXWBY8+NgevZwR9GrAUSfYzoRjtwLrJkmksIlaPeD/FvO+RvpJnrKfNSBMJNMqg6LITEWrN0PN0Vl9x2R3/zTycGQxxh0vjFXEGCGAdB3izs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720788487; c=relaxed/simple;
	bh=46Q0ZvCymXTxS+vBDw0PBnbHl7pEy8ma/fSI/DbxI/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fbnGP/IWHFRI+c6gm+tam7k7MbKOqrAjo1DQ9rL/THJZZYS9E78+oH4fCURZWUmYpfnv7MhJbtgO2LX9wekAsMr0JklPJX/klzwlLRpNqI04PQaGTfPiS6TvZLGpivyqkvjBDaqQT7DpwpO1+Y5FLcWIww7gq7xVdnrz5ybZwIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ll9xEbdL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93573C32782;
	Fri, 12 Jul 2024 12:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720788486;
	bh=46Q0ZvCymXTxS+vBDw0PBnbHl7pEy8ma/fSI/DbxI/E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ll9xEbdLdzajib1VDz8l2rm/aHWCaDtTEulfWEWYQo7/KnF4Mk0LulGREBZDriOj7
	 tqdtVLmtASSy0wxOJLX/7osVKGWtSsDYnWMRUKg2rsPo4F/3YWwcK8oeTYu1XjNeNJ
	 xQUFOOnydeP2jhi2uxXNjafUlDT1q9aUPAlgnP08yDZvZS6SnFn4H78djC3UTtkIBW
	 Hra2xHCFt+jWrD5PEt3XcAZl7KuDqXEOQ+jQjwlb4+SpaoESHVIsfZuQfdDCG9c0Os
	 DiVXJLkFJ4BcPQLUNfNWFFzbiuhMwVaaMWmt2x8MDMtnqpLsqQ25Mz/29H/IJivVDs
	 enAwf8KeDJvow==
Date: Fri, 12 Jul 2024 06:48:05 -0600
From: Rob Herring <robh@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, krzk+dt@kernel.org,
	conor+dt@kernel.org, andriy.shevchenko@linux.intel.com,
	ang.iglesiasg@gmail.com, linus.walleij@linaro.org,
	biju.das.jz@bp.renesas.com, javier.carrasco.cruz@gmail.com,
	semen.protsenko@linaro.org, 579lpy@gmail.com, ak@it-klinger.de,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 08/10] dt-bindings: iio: pressure: bmp085: Add
 interrupts for BMP3xx and BMP5xx devices
Message-ID: <20240712124805.GA461461-robh@kernel.org>
References: <20240711211558.106327-1-vassilisamir@gmail.com>
 <20240711211558.106327-9-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240711211558.106327-9-vassilisamir@gmail.com>

On Thu, Jul 11, 2024 at 11:15:56PM +0200, Vasileios Amoiridis wrote:
> Add interrupt options for BMP3xx and BMP5xx devices as well.
> 
> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> ---
>  .../devicetree/bindings/iio/pressure/bmp085.yaml    | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml b/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml
> index 6fda887ee9d4..f06f119963bc 100644
> --- a/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml
> +++ b/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml
> @@ -48,9 +48,20 @@ properties:
>  
>    interrupts:
>      description:
> -      interrupt mapping for IRQ (BMP085 only)
> +      interrupt mapping for IRQ. Supported in BMP085, BMP3xx, BMP5xx
>      maxItems: 1
>  
> +  interrupt-names:
> +    maxItems: 1
> +    items:
> +      enum:
> +        - DRDY
> +
> +  int-open-drain:

Use the existing 'drive-open-drain' property.

> +    desription:
> +      set if the interrupt pin should be configured as open drain.
> +      If not set, defaults to push-pull configuration.
> +
>  required:
>    - compatible
>    - vddd-supply
> -- 
> 2.25.1
> 

