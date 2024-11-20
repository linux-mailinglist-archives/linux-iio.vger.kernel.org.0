Return-Path: <linux-iio+bounces-12419-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D389D351C
	for <lists+linux-iio@lfdr.de>; Wed, 20 Nov 2024 09:14:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1645F282DC1
	for <lists+linux-iio@lfdr.de>; Wed, 20 Nov 2024 08:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6063D16F831;
	Wed, 20 Nov 2024 08:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BMhZmW39"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F351607AC;
	Wed, 20 Nov 2024 08:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732090492; cv=none; b=etiIws4xhSA5pZyAlVy34ZdG3aabba0cW/8lx6A7Fu590S3M9RMv6SsZtbeqhRHbARsSYfxMefj9AocXV48j5k+RGVE42Rb0FjmBRCENnPdv0Kxk3t0LkCzpDOsyMRNqr/756dkRks9gKUoWf5ZtH2q8QeORNHoTcjzO1KDGtG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732090492; c=relaxed/simple;
	bh=Pa5Yk/HnUg5MvoN8XrOEvIq+CxCgif9sO1+RXnFkcJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SXscmVNXffgY0JUSCLHkXIGFvNXPH3ysxRHN6DjpuKfkfnyx/vNmcvlTimasgdolCuMeb1fn6I+BuCYKg28IzqD6sRQv9DgT2q1VXd7d3DPXyfLuSxmR8hZY7UFUDqgEvKsrXfpCDzHSyNTMC1Agkhg2U4YFdu74CTbI0Wb1O5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BMhZmW39; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7C35C4CED0;
	Wed, 20 Nov 2024 08:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732090491;
	bh=Pa5Yk/HnUg5MvoN8XrOEvIq+CxCgif9sO1+RXnFkcJs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BMhZmW39NqRKgsEWAhiU1mubH/U8UbcXZXtVyLN3LXyosLAQNCt9mOXNgQeImwiZs
	 LgOhnWDMOiGIfjxjaeJ8RTEziWWFvIPsatgRPoL7M9R8tykr67pmS13jKgRUi/XLkC
	 1ajCYkr++DcReFij4XyBQyAKA2sCH3LmdIM550tOXx2CbtpMOrEMgDSu/Rci5F85p6
	 mVSy8GXiseCyL/rrNm67eK0xe9RlU6CAfNc5JfXf7fo5+BiXwwKaBzBj7+iY/ryo3Q
	 58IQaDLU5fUehx21Boa8V+R5jKltJQSS28oF61gD5vTWYoSnuWUdvn5fZ32i5KUF4X
	 zxE/fVchoJlTQ==
Date: Wed, 20 Nov 2024 09:14:47 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	marcelo.schmitt1@gmail.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] dt-bindings: iio: adc: adi,ad4000: Add PulSAR
Message-ID: <5kz6ghe56yiprlvhyduv7olcrajvejyvulcpjav6doiyvr6dcl@6qlt4nebp4gb>
References: <cover.1732020224.git.marcelo.schmitt@analog.com>
 <dd7fd54585e1230d2da86b5e3d4ed770256b0af2.1732020224.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dd7fd54585e1230d2da86b5e3d4ed770256b0af2.1732020224.git.marcelo.schmitt@analog.com>

On Tue, Nov 19, 2024 at 09:53:40AM -0300, Marcelo Schmitt wrote:
> Extend the AD4000 series device tree documentation to also describe
> PulSAR devices.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---
> No changes from v2 -> v3.
> 
>  .../bindings/iio/adc/adi,ad4000.yaml          | 71 +++++++++++++++++++
>  1 file changed, 71 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4000.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4000.yaml
> index e413a9d8d2a2..4dbb3d2876f9 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad4000.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4000.yaml
> @@ -19,6 +19,20 @@ description: |
>      https://www.analog.com/media/en/technical-documentation/data-sheets/ad4020-4021-4022.pdf
>      https://www.analog.com/media/en/technical-documentation/data-sheets/adaq4001.pdf
>      https://www.analog.com/media/en/technical-documentation/data-sheets/adaq4003.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7685.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7686.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7687.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7688.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7690.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7691.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7693.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7942.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7946.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7980.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7982.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7983.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7984.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7988-1_7988-5.pdf
>  
>  $ref: /schemas/spi/spi-peripheral-props.yaml#
>  
> @@ -63,6 +77,37 @@ properties:
>  
>        - const: adi,adaq4003
>  
> +      - const: adi,ad7946

All such cases are just one enum. That's the preferred syntax.


> +      - items:
> +          - enum:
> +              - adi,ad7942
> +          - const: adi,ad7946
> +
> +      - const: adi,ad7983
> +      - items:
> +          - enum:
> +              - adi,ad7980
> +              - adi,ad7988-5
> +              - adi,ad7686
> +              - adi,ad7685

Keep alphabetical order.

> +              - adi,ad7988-1
> +          - const: adi,ad7983
> +
> +      - const: adi,ad7688
> +      - items:
> +          - enum:
> +              - adi,ad7693
> +              - adi,ad7687
> +          - const: adi,ad7688
> +
> +      - const: adi,ad7984
> +      - items:
> +          - enum:
> +              - adi,ad7982
> +              - adi,ad7690
> +              - adi,ad7691
> +          - const: adi,ad7984
> +
>    reg:
>      maxItems: 1
>  
> @@ -133,6 +178,32 @@ required:
>    - ref-supply
>  
>  allOf:
> +  # Single-channel PulSAR devices have SDI either tied to VIO, GND, or host CS.
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - adi,ad7685

Why do you need this? It's fallback is already here.

> +              - adi,ad7686
> +              - adi,ad7687
> +              - adi,ad7688
> +              - adi,ad7690
> +              - adi,ad7691
> +              - adi,ad7693
> +              - adi,ad7942
> +              - adi,ad7946
> +              - adi,ad7980
> +              - adi,ad7982
> +              - adi,ad7983
> +              - adi,ad7984
> +              - adi,ad7988-1
> +              - adi,ad7988-5

Best regards,
Krzysztof


