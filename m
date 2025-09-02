Return-Path: <linux-iio+bounces-23659-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60065B40C9C
	for <lists+linux-iio@lfdr.de>; Tue,  2 Sep 2025 19:57:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F256B483610
	for <lists+linux-iio@lfdr.de>; Tue,  2 Sep 2025 17:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AFAF3469EE;
	Tue,  2 Sep 2025 17:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PegOE8K1"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD72343D91;
	Tue,  2 Sep 2025 17:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756835849; cv=none; b=TERWLIksg/hkrejQN/fDjuSh0EUJZCHrQ85VufV/CgzAFCeK3VYRd9FO52ou4Y5//aLRmiKGfoBUd8aHsuP4k01EByubrOKlQ+J4oT2CxwtbotyIFzaMBNXD/QHioKmIH6njFtmEL+sK4sPtm8d0IOjroLRR38MD00qF1EGpUHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756835849; c=relaxed/simple;
	bh=w2TaguzTGaTCkEaynjoXVEUablUoBEM80qHQFI4vqXw=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=K8P8Eu2iY68v9ZDMonXvF215IcMsGul9tRATy8JKF2QIyT6QiGnEUW4j2VHc373wsfbomQYXV4uMbaZKfqKGrwTrX+k8KLt4gu5lKab9IheZ5Nee1Vpl8YJlieTgyu70u8N1HTZcya3Cou0oLNlWLBHY9BYZTFfdfiJ45+0lOT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PegOE8K1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9DE6C4CEED;
	Tue,  2 Sep 2025 17:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756835848;
	bh=w2TaguzTGaTCkEaynjoXVEUablUoBEM80qHQFI4vqXw=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=PegOE8K1FFFnUEW3RvH9zUZ81+KCXtJfzp67UXeFcF7n4UOVnupqIRdJ4HOM0zaAh
	 iRnl+ZEDMjE09ghkLttjRCjhvrc/d8l9g12cQbKh22MxwWlBxEdZwM/mB2TRUMykOp
	 TM82HFWPugOuE3Ge13DBAbUSX7PUg4QouumzJS2TFzuxiCNlfufNJZLxPLYK4AO3pZ
	 CsM6CBeSkwfFmXl0r5o0CjoiW2UQPgsfd9wTQhYg5kaRXkw5/oY72j7fU06TwPWZz6
	 hA5+SAjtaOssKAvEbNoqCJQxOwtn/YvtnnTby/j4YZEo6mWNqjDkJKF+QLGc5E5u6A
	 mpENE/CZT/tAg==
Date: Tue, 02 Sep 2025 12:57:27 -0500
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
 Ramona Alexandra Nechita <ramona.nechita@analog.com>, 
 David Lechner <dlechner@baylibre.com>, 
 Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, 
 Marcelo Schmitt <marcelo.schmitt@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, 
 Antoniu Miclaus <antoniu.miclaus@analog.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org, 
 Hans de Goede <hansg@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>, 
 Tobias Sperling <tobias.sperling@softing.com>, 
 Conor Dooley <conor+dt@kernel.org>, Trevor Gamblin <tgamblin@baylibre.com>, 
 devicetree@vger.kernel.org, Esteban Blanc <eblanc@baylibre.com>, 
 linux-gpio@vger.kernel.org
To: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <77c36ecaf5992ebcabf6ce862bf2a6ec72d9f606.1756813980.git.mazziesaccount@gmail.com>
References: <cover.1756813980.git.mazziesaccount@gmail.com>
 <77c36ecaf5992ebcabf6ce862bf2a6ec72d9f606.1756813980.git.mazziesaccount@gmail.com>
Message-Id: <175683578289.936608.3477668195039989719.robh@kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: iio: adc: ROHM BD79112 ADC/GPIO


On Tue, 02 Sep 2025 15:23:54 +0300, Matti Vaittinen wrote:
> The ROHM BD79112 is an ADC/GPIO with 32 channels. The channel inputs can
> be used as ADC or GPIO. Using the GPIOs as IRQ sources isn't supported.
> 
> The ADC is 12-bit, supporting input voltages up to 5.7V, and separate I/O
> voltage supply. Maximum SPI clock rate is 20 MHz (10 MHz with
> daisy-chain configuration) and maximum sampling rate is 1MSPS.
> 
> Add a device tree binding document for the ROHM BD79112.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> ---
>  .../bindings/iio/adc/rohm,bd79112.yaml        | 118 ++++++++++++++++++
>  1 file changed, 118 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/rohm,bd79112.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/rohm,bd79112.example.dtb: adc@0 (rohm,bd79112): '#gpio-cells' is a dependency of 'gpio-controller'
	from schema $id: http://devicetree.org/schemas/gpio/gpio.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/77c36ecaf5992ebcabf6ce862bf2a6ec72d9f606.1756813980.git.mazziesaccount@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


