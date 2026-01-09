Return-Path: <linux-iio+bounces-27570-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D364D07BC8
	for <lists+linux-iio@lfdr.de>; Fri, 09 Jan 2026 09:13:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2682D3019B54
	for <lists+linux-iio@lfdr.de>; Fri,  9 Jan 2026 08:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 051402F9984;
	Fri,  9 Jan 2026 08:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X+mStinH"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BABE31C3C08;
	Fri,  9 Jan 2026 08:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767946421; cv=none; b=A4maF9G5EhGa90DIojS31MjNV/NUNS1YrJ+2JZpAzMMLPvGPPbo0WzUdNe/Z/3xNv/1LPrT+h8BDhBPJEt3EpvJef+IXkiD1os049EEOftlgGbmpTYFt0l58Jv6OitJmcoshwUW5LsOz5CfnA4fbS/a32xORV9dKuMPm0yVGXW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767946421; c=relaxed/simple;
	bh=r/erEuy3pBZbULEjILIvyFOlJleDD18wjFOmATsVr04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JdufMOQPTppVcv4467PPK/Agp9XfCMh9KYGjQAg5qmk0Zz9/xvVnzhvNYVwwH6QXaE4XE0fIboCXYAURV772dhZm279Het0szPVMCCoL1UufoSEZBetUU67E2f6zgZxdVQ0yWXFVzOqGorvbq09YEZx9yeIZ9sK/nI8aFNF9/6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X+mStinH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D87FAC4CEF1;
	Fri,  9 Jan 2026 08:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767946421;
	bh=r/erEuy3pBZbULEjILIvyFOlJleDD18wjFOmATsVr04=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X+mStinHrLcWf09DUi/jOjLRJonG6eypOwi1snmQfvX6n0HGijXT6oI2ZXNwRMAiP
	 VS0pLHMr6jc/DbjEnfgO9qjvcFX4bYt15uxkVg4gIAfRgZTSwj063c95/OWQWKrDEo
	 ijRvrCfKG0KhKyUAX0K5WDFTtlLC/a5H9IJZgku36GZ9ukgsd8x2kZM1RY/dY8hslN
	 rER1l44AYlCPUR05KcIf5sishUxmHhByXjpEk01jsVlJ/ei9EpQNhe0PV3BmZ26qdx
	 j6HNF3GsVAfoH14fyKHbSoovGFaRu27xR2c8ESI9qCLDE/qIIOuBTH1kbLjscsxiDV
	 goZdKWNY92F/w==
Date: Fri, 9 Jan 2026 09:13:38 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Rodrigo Alencar <rodrigo.alencar@analog.com>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v3 1/6] dt-bindings: iio: frequency: add adf41513
Message-ID: <20260109-translucent-violet-smilodon-ed1917@quoll>
References: <20260108-adf41513-iio-driver-v3-0-23d1371aef48@analog.com>
 <20260108-adf41513-iio-driver-v3-1-23d1371aef48@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260108-adf41513-iio-driver-v3-1-23d1371aef48@analog.com>

On Thu, Jan 08, 2026 at 12:14:50PM +0000, Rodrigo Alencar wrote:
> +examples:
> +  - |
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        pll@0 {
> +            compatible = "adi,adf41513";
> +            reg = <0>;
> +            spi-max-frequency = <10000000>;
> +            clocks = <&ref_clk>;
> +            avdd1-supply = <&vdd_3v3>;
> +            avdd2-supply = <&vdd_3v3>;
> +            avdd3-supply = <&vdd_3v3>;
> +            avdd4-supply = <&vdd_3v3>;
> +            avdd5-supply = <&vdd_3v3>;
> +            vp-supply = <&vdd_3v3>;
> +
> +            adi,power-up-frequency-mhz = <12000>;
> +            adi,charge-pump-current-microamp = <2400>;
> +            adi,phase-detector-polarity-positive-enable;
> +        };
> +    };

One example - more complete, so the next one - is enough. They do not
differ.

> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        pll@0 {
> +            compatible = "adi,adf41513";

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof


