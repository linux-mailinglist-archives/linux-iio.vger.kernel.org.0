Return-Path: <linux-iio+bounces-22427-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E34DB1E282
	for <lists+linux-iio@lfdr.de>; Fri,  8 Aug 2025 08:52:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D83E73B7BBE
	for <lists+linux-iio@lfdr.de>; Fri,  8 Aug 2025 06:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23D5F217701;
	Fri,  8 Aug 2025 06:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bULo9tj2"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9ED31A2381;
	Fri,  8 Aug 2025 06:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754635939; cv=none; b=EvzWwfG7LcSnIbG+6qytnf2awWfktSvWCHFqn8WMgutbUSP0BJxsLZdqCiho2u/1uydHN5yAhX/jZuLe8WXAFQgPhIiwmyOnaRS5t49i6Z9EjnkL6Cc3OjIF4CWRgA7gMNKPzMHNpPOMFwbvmIvg6IXBV1fO8H1mUDZrO91cPVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754635939; c=relaxed/simple;
	bh=7oU9aLqla/lEJ92TBUwaGjzVxRAbc+mfOnAF/l64+CA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A32sPrn/t48O8GoZ2HdTn0hNxL769nNAdPIoXGYdwEY4vbqi/CeMYZTL+h3jEvJLQrtmUU0iRzvGRAOFiGyZJx2onTmquQgkiuhsTkuPIjj/thnFFTSIou2ldG0dTCPpyyNUGD9cljv8Bj7I3LT3d8W++RGLF1YVIriPJ38GDAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bULo9tj2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C109DC4CEED;
	Fri,  8 Aug 2025 06:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754635939;
	bh=7oU9aLqla/lEJ92TBUwaGjzVxRAbc+mfOnAF/l64+CA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bULo9tj2TZjIuq07/isqp7GkOo2z7okULrTAExW3AZFG3HD297WOh0AHkx89hgczH
	 vtT0VH6cHx55Rb3V3hZEbb5iMeCEeGhkMw5HbX8lFrmBhRL1r2w9p3ddU6K10Zl8uf
	 LtcdOm/Hn/SJUMuK/p2CMcK+pRuSXdmBgbdm99mD/3NI4sEQQ4akXaJ/GeVZPctnjW
	 gBUAk3lqAOSu9j6jJJiuFPJvElNIf6MDoSHI3Z4ujUsD6vbrvnbS4A6pmv/68hjmAL
	 zfSr+Djlo4OEP9t/dDXMfZG5zC51D9setZKlQH5O4WrJPP/k6dMhFELTLlxKqghoxH
	 /4MgGKdhWwRpA==
Date: Fri, 8 Aug 2025 08:52:16 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Ioana Risteiu <Ioana.Risteiu@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Ramona Nechita <ramona.nechita@analog.com>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] dt-bindings: iio: adc: add IIO backend support
Message-ID: <20250808-caribou-of-beautiful-control-f4aab8@kuoka>
References: <20250806192502.10120-1-Ioana.Risteiu@analog.com>
 <20250806192502.10120-3-Ioana.Risteiu@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250806192502.10120-3-Ioana.Risteiu@analog.com>

On Wed, Aug 06, 2025 at 10:24:59PM +0300, Ioana Risteiu wrote:
> Add the generic io-backends property to the AD7779 binding to enable
> support for the IIO backend framework.
> 
> Also add the adi,num-lanes property to set the number of lanes used by
> AD7779.
> 
> Signed-off-by: Ioana Risteiu <Ioana.Risteiu@analog.com>
> ---
>  .../bindings/iio/adc/adi,ad7779.yaml          | 34 ++++++++++++++++++-
>  1 file changed, 33 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7779.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7779.yaml
> index 044f92f39cfa..4205ac29c824 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7779.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7779.yaml
> @@ -80,11 +80,27 @@ properties:
>    reset-gpios:
>      maxItems: 1
>  
> +  io-backends:
> +    maxItems: 1
> +
> +  adi,num-lanes:

I see @Rob already reviewed one other binding with adi,num-lanes instead
of asking to re-use PCI num-lanes property, so I guess this is fine.


> +    description: |

Drop |

> +      Number of lanes on which the data is sent on the output when the data
> +      output interface is used.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [1, 2, 4]
> +    default: 4
> +
>  required:
>    - compatible
>    - reg
>    - clocks
> -  - interrupts
> +
> +oneOf:
> +  - required:
> +      - interrupts
> +  - required:
> +      - io-backends
>  
>  unevaluatedProperties: false
>  
> @@ -107,4 +123,20 @@ examples:
>            clocks = <&adc_clk>;
>          };
>      };
> +
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        adc@0 {
> +          compatible = "adi,ad7779";
> +          reg = <0>;
> +          start-gpios = <&gpio0 87 GPIO_ACTIVE_LOW>;
> +          reset-gpios = <&gpio0 93 GPIO_ACTIVE_LOW>;
> +          clocks = <&adc_clk>;
> +          io-backends = <&iio_backend>;

Make it complete if you add completely new example - num-lanes.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


