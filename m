Return-Path: <linux-iio+bounces-27571-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BE69D07CCD
	for <lists+linux-iio@lfdr.de>; Fri, 09 Jan 2026 09:26:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6FD093009843
	for <lists+linux-iio@lfdr.de>; Fri,  9 Jan 2026 08:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27DEF33E37D;
	Fri,  9 Jan 2026 08:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XcuqHzb/"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3AB2FDC26;
	Fri,  9 Jan 2026 08:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767947189; cv=none; b=e/TvYtnHDlcImrAAW4OhB/pixdQoZTBA/O08GjeWa27ijhng1EufM6ycnYR9oR8Hu/BfadQSGan3eAyPtF6aB9eKqJAl0gXoWqzp0UMxTujaK779oOJ4FTjYP3JrqZFAZvm9Zj5WBUAcjLXXHYMf8VF42TO8ALEJ+aNEfTOIwfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767947189; c=relaxed/simple;
	bh=S41Fw5AwHpEcTALcionspodRnE0KbmXoV7yIbkQ5bGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n50Vf72H4PTsFTPBcOjFGrdgZA3Ml8p/a+C4hS/dSq5h1gxHi7spg0Eigl/vnlKlJOdUWJIkRDwSiy/4KvsrDUxsomd+x1p0+82BmDzNurWRBeIWoBd6m77RUvkjnJSnS10AiK5lRCF1lHsL7l30pId9lzJqhhMbI4V4GHfBAeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XcuqHzb/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B52E9C4CEF1;
	Fri,  9 Jan 2026 08:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767947188;
	bh=S41Fw5AwHpEcTALcionspodRnE0KbmXoV7yIbkQ5bGo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XcuqHzb/TdFAHcmdDJD34QX4IgKa0qwjAc5/lOcVwk+QQI+p29kDiG6gz+aPUhSI1
	 mVQmtfbokjmVNRQrdFXnulFxkB5ZzWdB+k0LwrFcGqSLQDhUS8BCzkKSWnIarULKUT
	 ksL4oUD0GPb5/7HyC6a9s8PbO/2HCOzuDK6QI1MUvh7mVC6GN3o2BNKJ6JDj7QjB6x
	 irv407cgIodD7D3YmMZGDYaexb2rOePjq7DY4AVuTZNR7kim/0dDLUtn0/NIRD2n18
	 HUYiT++2Od7NeCqKDQ0JyrYnFG+72JLBA8iGw6wY4MN2t6BHuk38juG66/higJYNNe
	 rZjt7rII50D7A==
Date: Fri, 9 Jan 2026 09:26:25 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Janani Sunil <janani.sunil@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Alexandru Ardelean <alexandru.ardelean@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, jan.sun97@gmail.com
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: dac: Add max22007
Message-ID: <20260109-frisky-giga-ammonite-3fd8ca@quoll>
References: <20260108-max22007-dev-v2-0-2506c738784f@analog.com>
 <20260108-max22007-dev-v2-1-2506c738784f@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260108-max22007-dev-v2-1-2506c738784f@analog.com>

On Thu, Jan 08, 2026 at 01:58:23PM +0100, Janani Sunil wrote:
> +required:
> +  - compatible
> +  - reg
> +  - vdd-supply
> +  - hvdd-supply
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/iio/addac/adi,ad74413r.h>
> +
> +    vdd_reg: regulator-vdd {

This was not here, drop entire node.

> +        compatible = "regulator-fixed";
> +        regulator-name = "vdd-3v3";
> +        regulator-min-microvolt = <3300000>;
> +        regulator-max-microvolt = <3300000>;
> +        regulator-always-on;
> +    };
> +
> +    hvdd_reg: regulator-hvdd {

Same here.


With these two fixed:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof


