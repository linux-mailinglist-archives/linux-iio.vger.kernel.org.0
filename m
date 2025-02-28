Return-Path: <linux-iio+bounces-16167-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 907C7A491F7
	for <lists+linux-iio@lfdr.de>; Fri, 28 Feb 2025 08:12:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E65053AF757
	for <lists+linux-iio@lfdr.de>; Fri, 28 Feb 2025 07:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A471C68A6;
	Fri, 28 Feb 2025 07:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bvYiBbdr"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151F41C5F06;
	Fri, 28 Feb 2025 07:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740726771; cv=none; b=eZ6b43e2MHGOkYjUrUR1GfKrMQq5F2oc90d0SZKOKVTJuVQWURNhEJcTF4z1+WnIsTMoszS8qy7Kfa4QLmGa+MOjOCtVj3S3etYgbW2dUBgy9cFD4S/jYq0zkbMbnGTQ/B1E42L2SK1a9w9eork/Z7LRsHclb8G+WsnTmiuKr58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740726771; c=relaxed/simple;
	bh=B1Q46ttF8lYPWjeLQXV9vNGr7Fd7t6cb+jd/PpzUtWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B31eCtGHN4HyePQ8k1jer3uywpwQdX10jVCHIwwoyRX8/Nhj014+imhBdOVkRMkdTCvMU04HdVQWuHCC5cpAuGTC6x5Xz3Nxa/n0FewhZ/MSNVu5rwdyiNRuuBl8W53CpC2t9WR+1VVAKM3R7ApTnrDQTb6AGshp//aoXHokxuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bvYiBbdr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90BA6C4CED6;
	Fri, 28 Feb 2025 07:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740726769;
	bh=B1Q46ttF8lYPWjeLQXV9vNGr7Fd7t6cb+jd/PpzUtWY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bvYiBbdrnpHdo5niUdfJzGpbQ3Azt0wac4XurFhPrFNIchpGYZ38RDJEqY55WTHTf
	 IKTkesrRyKkz0wx2uf3gJiceqWl5OSxQ5Hap14d2gamiy4R7Kx1iIPAwupxS2e1jzB
	 V1wcU7y59aoqowzgW7Pj5IIVB+sEXrS69OjiW3Wvr0F9wdqUYjKmFvDFLLxHnhEGQM
	 IxAjJGN6zpfDzT1C2I6qxmJXJl/d3otnIhGwsRuTZg3Ifza1Avw5S1Jt3e4kuwnWbh
	 2G8Ajnjz9IDeHzgi7VrFR1cAQd/aFwlSQDKdi6o2EeT4iqo5TAGwSf+FETr5gsuor8
	 yC823rBcXJ1fA==
Date: Fri, 28 Feb 2025 08:12:45 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: David Jander <david@protonic.nl>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
	Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	linux-doc@vger.kernel.org, Nuno Sa <nuno.sa@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, Oleksij Rempel <o.rempel@pengutronix.de>
Subject: Re: [RFC PATCH 7/7] dt-bindings: motion: Add motion-simple-pwm
 bindings
Message-ID: <20250228-wonderful-python-of-resistance-d5b662@krzk-bin>
References: <20250227162823.3585810-1-david@protonic.nl>
 <20250227162823.3585810-8-david@protonic.nl>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250227162823.3585810-8-david@protonic.nl>

On Thu, Feb 27, 2025 at 05:28:23PM +0100, David Jander wrote:
> Add device-tree bindings for simple Linux Motion Control devices that
> are based on 1 or 2 PWM outputs.
> 
> Signed-off-by: David Jander <david@protonic.nl>
> ---
>  .../bindings/motion/motion-simple-pwm.yaml    | 55 +++++++++++++++++++
>  1 file changed, 55 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/motion/motion-simple-pwm.yaml
> 
> diff --git a/Documentation/devicetree/bindings/motion/motion-simple-pwm.yaml b/Documentation/devicetree/bindings/motion/motion-simple-pwm.yaml
> new file mode 100644
> index 000000000000..409e3aef6f3f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/motion/motion-simple-pwm.yaml
> @@ -0,0 +1,55 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/motion/motion-simple-pwm.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Simple PWM based motor controller
> +
> +maintainers:
> +  - David Jander <david@protonic>
> +
> +description: |

Do not need '|' unless you need to preserve formatting.

> +   Simple motor control device based on 1 or 2 PWM outputs

Your schema does not allow 1. Test it.

> +
> +properties:
> +  compatible:
> +    enum:
> +      - motion-simple-pwm
> +
> +  pwms:
> +    maxItems: 2

List and describe items instead.

> +
> +  pwm-names:
> +    maxItems: 2

List items instead.

> +
> +  motion,pwm-inverted:
> +    $ref: /schemas/types.yaml#/definitions/flag

And PWM flag does not work?

Anyway, there is no "motion" company.

> +    description:
> +      If present, this flag indicates that the PWM signal should be inverted.
> +      The duty-cycle will be scaled from 100% down to 0% instead 0% to 100%.
> +
> +required:
> +  - compatible
> +  - pwms
> +
> +allOf:
> +  - $ref: /schemas/motion/common.yaml#
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    // This example shows how to use the TI DRV8873 or similar motor controllers
> +    // with this driver
> +    motion-simple-pwm0 {

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

e.g. motor {

Best regards,
Krzysztof


