Return-Path: <linux-iio+bounces-13815-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A76ED9FD233
	for <lists+linux-iio@lfdr.de>; Fri, 27 Dec 2024 09:45:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5107E162E79
	for <lists+linux-iio@lfdr.de>; Fri, 27 Dec 2024 08:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85D4A1531EF;
	Fri, 27 Dec 2024 08:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qWdnReCo"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C80013B792;
	Fri, 27 Dec 2024 08:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735289115; cv=none; b=pvq4eiBr+HURes0Nm2y2cDHYKndD9SI7rWQAoLfo/u0l0BhH5Vz/8pnouQXq1rm0S63txdKJPhKcdzS8tFD3ixmzw4zEAZ1mBpEmmTUVwuauntNrG/uRoCuVlvkXPbJTVyFwALnDi5iAIT22h+Br8VWzLtN++i1b/TCRALZb+Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735289115; c=relaxed/simple;
	bh=CG+D3PLeFKUojrZy89Rw11jTjHomRQ4XSvONxfB6FpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oWnyo6isExmCRcFoywmgrm6clixIm5vNhJriFjqfv1FRkQbzHzky5iYiszSMDgPjKXLOhqvqDDKVaqE5Qs3LO8j7/H8hlMUeDComXTI3gKOvSkj8vi3xyjByC6Od8+sZ2H82pmYm+V+PKxQl6d8lYMiQpe39XK/NbdbWMYr+s7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qWdnReCo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CEB1C4CED0;
	Fri, 27 Dec 2024 08:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735289114;
	bh=CG+D3PLeFKUojrZy89Rw11jTjHomRQ4XSvONxfB6FpU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qWdnReCo0icfO9xFhltGXtCftoiymV53pXSowoMb/a+UOmkfRxGVtliBus1nfUM/P
	 d3wn7J74fIcprpR/XClb0O5uI7VEwR1Cxak2jwhm8J+mG5SHKsXgfV1cjzq1pwPGEc
	 XGLKRxZfmcCatE8Qt+bHyW9o5HNDSMUtSydbOgv4hh7OcQVemu5Jeh1eZ5H2YP+5vX
	 OWxHtoJQD9sM78SI76b4jDDcvI8rAOXE4ybRI40ZwYF911HLHXKF3Kp54iI4W1YSQ3
	 WbDa+9ee17uUntwlK/cOFEMJ6glRXGD6A3LfAfJVekPhvSQkEsXyakcVzYokBoMqQn
	 H/HrGwTGcJuEQ==
Date: Fri, 27 Dec 2024 09:45:10 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
Cc: jic23@kernel.org, krzk+dt@kernel.org, 
	andriy.shevchenko@linux.intel.com, Lars-Peter Clausen <lars@metafoo.de>, 
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Emil Gedenryd <emil.gedenryd@axis.com>, Andreas Dannenberg <dannenberg@ti.com>, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: iio: light: opt3001: add compatible for
 opt3004
Message-ID: <x6rl2gmvwkn7lidilo23lxwqwwkilesymo7lxk2uygvtietemh@qhbx4lj6r7eh>
References: <20241226131736.23095-1-hardevsinh.palaniya@siliconsignals.io>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241226131736.23095-1-hardevsinh.palaniya@siliconsignals.io>

On Thu, Dec 26, 2024 at 06:47:35PM +0530, Hardevsinh Palaniya wrote:
> Add Support for OPT3004 Digital ambient light sensor (ALS) with
> increased angular IR rejection.
> 
> The OPT3004 sensor shares the same functionality and scale range as
> the OPT3001. the compatible string is added with fallback support to
> ensure compatibility.
> 
> Datasheet: https://www.ti.com/lit/gpn/opt3004
> 
> Signed-off-by: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
> ---
> 
> v1 -> v2:
> 
> - Use fallback mechanism for the OPT3004.
> - Drop 2/2 patch from the patch series[1] as per feedback.
> 
> Link[1]: https://lore.kernel.org/linux-iio/20241224061321.6048-1-hardevsinh.palaniya@siliconsignals.io/T/#t
> 
> ---
>  .../devicetree/bindings/iio/light/ti,opt3001.yaml      | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/light/ti,opt3001.yaml b/Documentation/devicetree/bindings/iio/light/ti,opt3001.yaml
> index 67ca8d08256a..56844710e79a 100644
> --- a/Documentation/devicetree/bindings/iio/light/ti,opt3001.yaml
> +++ b/Documentation/devicetree/bindings/iio/light/ti,opt3001.yaml
> @@ -15,9 +15,13 @@ description: |
>  
>  properties:
>    compatible:
> -    enum:
> -      - ti,opt3001
> -      - ti,opt3002
> +    oneOf:
> +      - enum:
> +          - ti,opt3001
> +          - ti,opt3002
> +      - items:
> +          - const: ti,opt3001
> +          - const: ti,opt3004

3004 is not the fallback.

Best regards,
Krzysztof


