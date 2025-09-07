Return-Path: <linux-iio+bounces-23849-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF5C2B47AC7
	for <lists+linux-iio@lfdr.de>; Sun,  7 Sep 2025 13:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 773E13AB525
	for <lists+linux-iio@lfdr.de>; Sun,  7 Sep 2025 11:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C2DC25FA0F;
	Sun,  7 Sep 2025 11:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BfD/CFLD"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E31723C4E1;
	Sun,  7 Sep 2025 11:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757243962; cv=none; b=kblzamoeW9YCn0FxnZDLxL3Udh9wYQc8dKH9Ri6jvv6d1tENCqwXgj490+Q+adB0cfQTazqwhxnHSkvHGbI+wF8r4r6hbZbvXvYxlRnFuRGeBHab9qto19VtP3yETAlQTVrR0BoHlIIbjRX6MvkD5dJCuHgG/lFSbi18ThcKri8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757243962; c=relaxed/simple;
	bh=fDoAKMJaeYEEYbOBCIEyDcPkC1/z8ZJGDMMAkBGmph8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jIr6qNVOF7xrlUATY99w1xYFnt2OoB+3VbKDtAurj6E7FiQfpTaggWeYurknqK6UjoZeHQi0jTTcxSLZ3Lzs+yqEjGW96/7MrmRpNm3BiwFVJFUgOLtBSxJHMjc9WHxzADKwqGJqTRVN2R0nF+3gi5uRwTsdUlh6J9VkjYzejQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BfD/CFLD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FE41C4CEF0;
	Sun,  7 Sep 2025 11:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757243962;
	bh=fDoAKMJaeYEEYbOBCIEyDcPkC1/z8ZJGDMMAkBGmph8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BfD/CFLDunYFmGPb8op/nsyheiwx8oYcZErBODNLcs8ed4gZInOOLEUlag9B6lFXQ
	 InlR/1mX9GHgIz7FQk/XQ/XNFuYEivGWU/jJ1fjg5SIY4Ew8oRPlZOq0b981J+1PJZ
	 CpqX4xjlBaogA/mpe9uW2O0mkXQfot1bzI2oAFGG95UFIEGMMIOnezuskWa9Eh+BW9
	 S4ZA+uNPBDNE1yvAobUCsAz7HaatGT21eSg9jmQFFGJRbas/6cN0Y4AsdEpKewmjnp
	 6v4Pi5HYKOoUfMJL//LYmTNMHnStrQKeVVA/9i5wIIpuxic/F99F7HG0IMeh/aX9N+
	 UBxNLxpTzKrIw==
Date: Sun, 7 Sep 2025 12:19:11 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Linus
 Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>,
 Marcelo Schmitt <marcelo.schmitt@analog.com>, Javier Carrasco
 <javier.carrasco.cruz@gmail.com>, Tobias Sperling
 <tobias.sperling@softing.com>, Antoniu Miclaus
 <antoniu.miclaus@analog.com>, Trevor Gamblin <tgamblin@baylibre.com>,
 Esteban Blanc <eblanc@baylibre.com>, Ramona Alexandra Nechita
 <ramona.nechita@analog.com>, Hans de Goede <hansg@kernel.org>, Herve Codina
 <herve.codina@bootlin.com>, Alisa-Dariana Roman <alisadariana@gmail.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v3 1/3] dt-bindings: iio: adc: ROHM BD79112 ADC/GPIO
Message-ID: <20250907121911.7c2fa1cb@jic23-huawei>
In-Reply-To: <fc3cffa3b75d1fcd19df0ff794e6ad75c8c87373.1757053456.git.mazziesaccount@gmail.com>
References: <cover.1757053456.git.mazziesaccount@gmail.com>
	<fc3cffa3b75d1fcd19df0ff794e6ad75c8c87373.1757053456.git.mazziesaccount@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 5 Sep 2025 09:42:18 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

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
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

Trivial comment below.  If everything else is good on this version
it isn't worth a respin.

> +examples:
> +  - |
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        adc: adc@0 {
> +            compatible = "rohm,bd79112";
> +            reg = <0x0>;
> +
> +            spi-cpha;
> +            spi-cpol;
> +
> +            vdd-supply = <&dummyreg>;
> +            iovdd-supply = <&dummyreg>;
> +
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            gpio-controller;
> +            #gpio-cells = <2>;
> +
> +            channel@0 {
> +                reg = <0>;
> +            };
> +            channel@1 {
> +                reg = <1>;
> +            };
> +            channel@2 {
> +                reg = <2>;
> +            };
> +            channel@3 {
> +                reg = <3>;
Trivial point but I get bored scrolling.
Would a smaller set of channels allow you to provide same level
of testing / documentation?

> +            };
> +            channel@4 {
> +                reg = <4>;
> +            };
> +            channel@5 {
> +                reg = <5>;
> +            };
> +            channel@6 {
> +                reg = <6>;
> +            };
> +            channel@16 {
> +                reg = <16>;
> +            };
> +            channel@20 {
> +                reg = <20>;
> +            };
> +        };
> +    };


