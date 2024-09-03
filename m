Return-Path: <linux-iio+bounces-9061-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C45EC9693C3
	for <lists+linux-iio@lfdr.de>; Tue,  3 Sep 2024 08:35:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80AAB285DC1
	for <lists+linux-iio@lfdr.de>; Tue,  3 Sep 2024 06:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC131D47D1;
	Tue,  3 Sep 2024 06:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U20Mecf9"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72424315D;
	Tue,  3 Sep 2024 06:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725345266; cv=none; b=PfO8fO5PEx6CRQN9f6DI4/GSwi0gP9r94CAGDhwuVBizny035gyJB8VtusZUTnwTydy5oJlGMtw6JkTdn8GLGHS8XZFthqFjoFJzO8MVN9fm2lhoBhx63W24ADj7+FZSuMMrCHsHnI8lG9h6eFFRlV0KWmrfZiQhJ420EvFC5zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725345266; c=relaxed/simple;
	bh=ykvQKbVww2Pw3qyF6VdYZp/tM+a7MHm/vrFWiPtbsLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g1umUX5gLGTwhvTIrwms/LmTD935D+2mk5sbRJxTlErmXD0HM6K+Oc7qk9360ROO944Ti8Aq/gbyN5RAiFapsmbIF5Qby5IrejKV91nVP91Dp7goCXuMdDZZkUF2F/GWAu6oKgq/ncG+4OvFeCnb0dckdXe5FRHjpdgP6Xi9oqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U20Mecf9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 464FCC4CEC5;
	Tue,  3 Sep 2024 06:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725345266;
	bh=ykvQKbVww2Pw3qyF6VdYZp/tM+a7MHm/vrFWiPtbsLk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U20Mecf9A0iMms5Km6GEmVgPwsX2TZKhNHZbTUlG9hoPKowpZ9q/pGcWPOqd1vuYC
	 D/KaHdf+OJVpgDqm8YgzYBSt6STVPLhPgie+3H0JtLeiVIdDWanEgrAQuvXp9ICZvA
	 2kxF56/fd+95qwf9FaPHuiaN3vD45H2w1ngMKzgxSIQYU6HqlGBfIMOpR5JmiUN2nt
	 9StK46jDWEDBvgOw8xej3/rqp3dqLLuLclZnzlwrR/QfuKC1lE+9rFcyGxk2NldIcs
	 Gxwtf8ghu3QN9RG5IsED2ei3Ags2V1/y3WVhx5HruP7gP/py+cePehAE3+VzreiEbX
	 k0ObWsWP976Zg==
Date: Tue, 3 Sep 2024 08:34:22 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, andriy.shevchenko@linux.intel.com, ang.iglesiasg@gmail.com, 
	linus.walleij@linaro.org, biju.das.jz@bp.renesas.com, javier.carrasco.cruz@gmail.com, 
	semen.protsenko@linaro.org, 579lpy@gmail.com, ak@it-klinger.de, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, christophe.jaillet@wanadoo.fr
Subject: Re: [PATCH v5 5/7] dt-bindings: iio: pressure: bmp085: Add
 interrupts for BMP3xx and BMP5xx devices
Message-ID: <mdxfwawym2tn3afsbq4jmygfkdokpleb7p2deomraqwjc6k5qu@laj4j3fw7k2x>
References: <20240902184222.24874-1-vassilisamir@gmail.com>
 <20240902184222.24874-6-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240902184222.24874-6-vassilisamir@gmail.com>

On Mon, Sep 02, 2024 at 08:42:20PM +0200, Vasileios Amoiridis wrote:
> Add interrupt options for BMP3xx and BMP5xx devices as well.
> 
> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> ---
>  .../bindings/iio/pressure/bmp085.yaml         | 22 ++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml b/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml
> index 6fda887ee9d4..20b75865e02f 100644
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
> +    type: boolean
> +
> +

Just one blank liine.

>  required:
>    - compatible
>    - vddd-supply
>    - vdda-supply
>  
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          not:
> +            enum:
> +              - bosch,bmp085
> +              - bosch,bmp380
> +              - bosch,bmp580

Are you sure you tested this patch?

Best regards,
Krzysztof


