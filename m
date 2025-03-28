Return-Path: <linux-iio+bounces-17311-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C955A7469F
	for <lists+linux-iio@lfdr.de>; Fri, 28 Mar 2025 10:49:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 386747A72FA
	for <lists+linux-iio@lfdr.de>; Fri, 28 Mar 2025 09:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4A6D214233;
	Fri, 28 Mar 2025 09:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t5/GqgpS"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8291940A2;
	Fri, 28 Mar 2025 09:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743155356; cv=none; b=M0+WGstimGfwe8PMOvaQUWY0fUX+EoeE+JynTMYfomxCJuom+896waOphvclatDqt9DQqvv3a4SWtLy2w+Jl/p1RNnUFRBVjN6OZfWHnez5S2oLIRgUoC06scduTZxF2Ry5LrSlOvNYIkA9WIzkX6S12YmtxQdx8XAJ4YI5WA4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743155356; c=relaxed/simple;
	bh=olVkdtzrwYPCvjZ+beVjT3d3hxyFMUFor1QaOmihdTM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MFZ5R2/jo/X1tf/mcu/ENkP3OGiskyKxY/LQc0pKb4mOk0y0FW9hfJu/srEf5vSaBezZ5orsMbPsnfig0p6/tEFWxvl3PKM+NKE1Mz05y4+/OpXyJblujdYvqLiS5W5wi88+Rg8Uz/BeAcZ3NRIVOKeasnQ9raNLq1NrV1Ihu2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t5/GqgpS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87E3DC4CEE4;
	Fri, 28 Mar 2025 09:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743155355;
	bh=olVkdtzrwYPCvjZ+beVjT3d3hxyFMUFor1QaOmihdTM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=t5/GqgpSXm5dN7i4JJvB3uRoi5eOc7+cx1n7ZJk8aaDnAADyQnVAbF4+wTs8keM3F
	 2tYlN+4SypPqThdzaCbag2yWOpoLRdH+aEV7HyVzsiWxwP8QNrUwcM0iXM3YkySf05
	 kBxXqCBJqt9TVEqU5ecN9sLjSzvWVgGXam05uW7R4+nBPHoUgkd8zDwEnZyDfayVDy
	 V+LXzKBeCuJdRhrkpdyumi7JHRf2Hj8+Lzmo4e1/qTyk47wAKc3bBSAdEyfPPJfsel
	 P8BFRu8BobspvCQSBHC6SZdyoZpxjZ0Sa6HJN7mkXrDGaAKBp8NJWroJcnGkrsf1yn
	 JVCj4kVMRk9eQ==
Date: Fri, 28 Mar 2025 09:49:04 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Sergio Perez <sergio@pereznus.es>
Cc: Tomasz Duszynski <tduszyns@gmail.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski
 <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v6 1/2] dt-bindings: iio: light: bh1750: Add reset-gpios
 property
Message-ID: <20250328094904.06ce0c96@jic23-huawei>
In-Reply-To: <20250324135920.6802-1-sergio@pereznus.es>
References: <20250324135920.6802-1-sergio@pereznus.es>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Mar 2025 14:59:19 +0100
Sergio Perez <sergio@pereznus.es> wrote:

> Some BH1750 sensors require a hardware reset via GPIO before they can
> be properly detected on the I2C bus. Add a new reset-gpios property
> to the binding to support this functionality.
> 
> The reset-gpios property allows specifying a GPIO that will be toggled
> during driver initialization to reset the sensor.
> 
> Signed-off-by: Sergio Perez <sergio@pereznus.es>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Series applied to the testing branch of iio.git. I'll rebase that
on rc1 once available and push out as my togreg branch.

Thanks,

Jonathan

> ---
> Revision history:
> v5 => v6:
>  - Fixed include placement as commented by Krzysztof Kozlowski
> v4 => v5:
>  - Update description to reflect "active low" on reset signal as indicated by Krzysztof Kozlowski
>  - Update description to clarify what pin of sensor is used to do reset (DVI) as mentioned by Krzysztof Kozlowski
>  - Edit example to be coherent with "active low" as informed by Krzysztof Kozlowski
>  - Added necessary include on example
> v3 => v4:
>  - No changes
> v2 => v3:
>  - Split in two patches: dtbinding and code
>  - Ensure list off mantainers following instructions by Krzysztof Kozlowski
>  - Delete redundant details on description as suggested by Jonathan Cameron
>  - Added related example to existing one as suggested by Jonathan Cameron
> v1 => v2:
>  - Ensure check tests as commented by Rob Herring
>  - Fixes some whitespaces and end lines
> ---
>  Documentation/devicetree/bindings/iio/light/bh1750.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/light/bh1750.yaml b/Documentation/devicetree/bindings/iio/light/bh1750.yaml
> index 1a88b3c253d5..9df81c271411 100644
> --- a/Documentation/devicetree/bindings/iio/light/bh1750.yaml
> +++ b/Documentation/devicetree/bindings/iio/light/bh1750.yaml
> @@ -24,6 +24,10 @@ properties:
>    reg:
>      maxItems: 1
>  
> +  reset-gpios:
> +    description: GPIO connected to the DVI reset pin (active low)
> +    maxItems: 1
> +
>  required:
>    - compatible
>    - reg
> @@ -32,6 +36,7 @@ additionalProperties: false
>  
>  examples:
>    - |
> +    #include <dt-bindings/gpio/gpio.h>
>      i2c {
>        #address-cells = <1>;
>        #size-cells = <0>;
> @@ -39,6 +44,7 @@ examples:
>        light-sensor@23 {
>          compatible = "rohm,bh1750";
>          reg = <0x23>;
> +        reset-gpios = <&gpio2 17 GPIO_ACTIVE_LOW>;
>        };
>      };
>  


