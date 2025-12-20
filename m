Return-Path: <linux-iio+bounces-27258-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BF78CD2C1B
	for <lists+linux-iio@lfdr.de>; Sat, 20 Dec 2025 10:21:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6928E3013564
	for <lists+linux-iio@lfdr.de>; Sat, 20 Dec 2025 09:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A16C22FFDF9;
	Sat, 20 Dec 2025 09:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dqqswYzE"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FAA0156678;
	Sat, 20 Dec 2025 09:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766222489; cv=none; b=Y9SiGmpMhKfa/N7Ad8zaPItvWkMwyNbHNFXRhvUxFWb8RJtRXzhpY3QsMkLT1rSj85dJ5HqH4f9t3EZZayhaE1eAEOneYHScBIgFBk43g8AFoZXG2dJH8ih4Ny+FOazn+j5q6bsEgavoQ6wOZsKFChVyzGjknYlkpCtSzCxGTYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766222489; c=relaxed/simple;
	bh=A5E7SDuf7s71s7Xpwhh1fIjfwD+NEhAu730QEr/YR9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mK7dSkvJTUBD6/U67zzf7Wy6mP8vDhMxBXBKz8nCupyc3yJRA6DBig0LLauvGOAWJKO1IEeXv1LjVpo2oY//IQzPByT4a3iuHBJpZ5NyeVYeQFkC6XIncDTmgAIvXRN+6Ngop4TDWEjahstuWaYqt2m3JCkodT63ZnvblmdHq30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dqqswYzE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02E60C4CEF5;
	Sat, 20 Dec 2025 09:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766222488;
	bh=A5E7SDuf7s71s7Xpwhh1fIjfwD+NEhAu730QEr/YR9M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dqqswYzEb0SJWK5KIEnkChjiHjGZsCWbXgmOh+tu2STfrQPnvDqeT5Mqc52UhQ2zS
	 3nwJiXD7eyexOzfNlqS8mQFREpSwQfQUBIY382JOyat0qcPlwAQ8Iu+su90fnBHQEe
	 3crbxb8FkZhV/V32s/1hy+BmWze1Tc6uQo50/wOH21l7QD/kOm1t3NQrzE5/GTIWuD
	 8Ui7bqiMXrBurxqpYoV/nqA36DO056HpMRhcrQxlNq250pYvo7ereGLVjlbEa5aTtj
	 CVtY4UypiNIqYcr0rXnjCLCrnPF/ysuNSxJfswIWpsGk4+6HlRIdU2XfbcDoivCiF/
	 VRsK+rODWXuvg==
Date: Sat, 20 Dec 2025 10:21:25 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Rodrigo Alencar <rodrigo.alencar@analog.com>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v2 1/6] dt-bindings: iio: frequency: add adf41513
Message-ID: <20251220-bouncy-perky-tarantula-d9b3be@quoll>
References: <20251219-adf41513-iio-driver-v2-0-be29a83d5793@analog.com>
 <20251219-adf41513-iio-driver-v2-1-be29a83d5793@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251219-adf41513-iio-driver-v2-1-be29a83d5793@analog.com>

On Fri, Dec 19, 2025 at 12:34:48PM +0000, Rodrigo Alencar wrote:
> dt-bindings for ADF41513, an ultralow noise PLL frequency synthesizer that
> can be used to implement local oscillators (LOs) as high as 26.5 GHz.
> Most properties refer to existing PLL driver properties (e.g. ADF4350).

What is "existing PLL driver"? I know about motor drivers, but can you
drive PLL?

And how is ADF4350 related to this binding. I do not see ADF4350
compatible here at all. Describe hardware, a real one.


> 
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
> ---
>  .../bindings/iio/frequency/adi,adf41513.yaml       | 246 +++++++++++++++++++++
>  MAINTAINERS                                        |   7 +
>  2 files changed, 253 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/frequency/adi,adf41513.yaml b/Documentation/devicetree/bindings/iio/frequency/adi,adf41513.yaml
> new file mode 100644
> index 000000000000..01ceb2a7d21b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/frequency/adi,adf41513.yaml
> @@ -0,0 +1,246 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/frequency/adi,adf41513.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices ADF41513 PLL Frequency Synthesizer
> +
> +maintainers:
> +  - Rodrigo Alencar <rodrigo.alencar@analog.com>
> +
> +description:
> +  The ADF41513 is an ultralow noise frequency synthesizer that can be used to
> +  implement local oscillators (LOs) as high as 26.5 GHz in the upconversion and
> +  downconversion sections of wireless receivers and transmitters. The ADF41510
> +  supports frequencies up to 10 GHz.
> +
> +  https://www.analog.com/en/products/adf41513.html
> +  https://www.analog.com/en/products/adf41510.html
> +
> +$ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,adf41510
> +      - adi,adf41513
> +
> +  reg:
> +    maxItems: 1
> +
> +  spi-max-frequency:
> +    maximum: 25000000
> +
> +  clocks:
> +    maxItems: 1
> +    description: Clock that provides the reference input frequency.
> +
> +  avdd1-supply:
> +    description: PFD and Up and Down Digital Driver Power Supply (3.3 V)
> +
> +  avdd2-supply:
> +    description: RF Buffer and Prescaler Power Supply (3.3 V)
> +
> +  avdd3-supply:
> +    description: N Divider Power Supply (3.3 V)
> +
> +  avdd4-supply:
> +    description: R Divider and Lock Detector Power Supply (3.3 V)
> +
> +  avdd5-supply:
> +    description: Sigma-Delta Modulator and SPI Power Supply (3.3 V)
> +
> +  vp-supply:
> +    description: Charge Pump Power Supply (3.3 V)
> +
> +  enable-gpios:
> +    description:
> +      GPIO that controls the chip enable pin. A logic low on this pin
> +      powers down the device and puts the charge pump output into
> +      three-state mode.
> +    maxItems: 1
> +
> +  lock-detect-gpios:
> +    description:
> +      GPIO for lock detect functionality. When configured for digital lock
> +      detect, this pin will output a logic high when the PLL is locked.
> +    maxItems: 1
> +
> +  adi,power-up-frequency:

Nothing improved.

You ignored comments, did not bother to respond to them and then sent
the same.

NAK

Best regards,
Krzysztof


