Return-Path: <linux-iio+bounces-14722-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AFA52A22227
	for <lists+linux-iio@lfdr.de>; Wed, 29 Jan 2025 17:51:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E6741883A1F
	for <lists+linux-iio@lfdr.de>; Wed, 29 Jan 2025 16:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65FBE1DFE31;
	Wed, 29 Jan 2025 16:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZAzRdIn6"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173281AD403;
	Wed, 29 Jan 2025 16:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738169492; cv=none; b=D/86ZSApV/9G6Nc0AgiLTc1WWFdI5ZGskMLMTQp3J/pGCqc1EAcyp9SokgemMctyGlWJmS5vITGE1qOi5wbkHGoezb4qbxzOOjBmzaejVEYxWxao7cQEy7iJBt/XdWuMAPIuxgTsjatZjYFROx2t2bLACodti8qEllNbzck3JKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738169492; c=relaxed/simple;
	bh=Tg1oBtB+g5D3u942EZXUAq8Z82CBxaiPRA6s8YUTMX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uYPUUah57oNu4+yofLoF4VJDF+UeJofeai1vcFyascDA5RGpkcU1DvDuRb+dW9xUyPH3ZwYJvabFNoUZn7NnKsi4/dXOVofV/SxCyydnyAG21mXj3CufhIWn56WwvDcxvmbvydwpEGMXN0ibRm7CkIjJZuppiPGq4+D0nZo7lSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZAzRdIn6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6678CC4CED1;
	Wed, 29 Jan 2025 16:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738169490;
	bh=Tg1oBtB+g5D3u942EZXUAq8Z82CBxaiPRA6s8YUTMX4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZAzRdIn66WKxjU6RDiDVwfGIiD4H1fxjDvTasCLlu02qH8+6N8HkGxHiZzjg1J7sd
	 wYv/TJ0rcyN6kNB6i3Y949hbbFO+7CV4q22AIzpBsl7zZdfrGc0cbL0VUiFsITYuEZ
	 sqMwNOjnd/c35ut/3Ph6rb+t5LFheW95Pg53LwnohjzEvf6X94zXEHUnRcqESos3BK
	 SZaSJNq7oVqwIwp88176R/CpoETU0XIW2EoZc0pWsWyQXaOLr2eBLngbm1GrhEeEXt
	 ifr8Hrz+d2lM9xTIpFSb6m4+jWMCCqMMIJrkeXsTOlsmkygrrYL61ha72ks4dEbnNG
	 IXsQ7uwSzaekw==
Date: Wed, 29 Jan 2025 10:51:29 -0600
From: Rob Herring <robh@kernel.org>
To: Alisa-Dariana Roman <alisadariana@gmail.com>
Cc: Alisa-Dariana Roman <alisa.roman@analog.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	David Lechner <dlechner@baylibre.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v3 1/3] dt-bindings: iio: adc: add AD7191
Message-ID: <20250129165129.GA2216595-robh@kernel.org>
References: <20250129143054.225322-1-alisa.roman@analog.com>
 <20250129143054.225322-2-alisa.roman@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250129143054.225322-2-alisa.roman@analog.com>

On Wed, Jan 29, 2025 at 04:29:02PM +0200, Alisa-Dariana Roman wrote:
> AD7191 is a pin-programmable, ultra-low noise 24-bit sigma-delta ADC
> designed for precision bridge sensor measurements. It features two
> differential analog input channels, selectable output rates,
> programmable gain, internal temperature sensor and simultaneous
> 50Hz/60Hz rejection.
> 
> Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
> ---
>  .../bindings/iio/adc/adi,ad7191.yaml          | 149 ++++++++++++++++++
>  MAINTAINERS                                   |   7 +
>  2 files changed, 156 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7191.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7191.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7191.yaml
> new file mode 100644
> index 000000000000..ac14096ba76c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7191.yaml
> @@ -0,0 +1,149 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright 2025 Analog Devices Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/adi,ad7191.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices AD7191 ADC
> +
> +maintainers:
> +  - Alisa-Dariana Roman <alisa.roman@analog.com>
> +
> +description: |
> +  Bindings for the Analog Devices AD7191 ADC device. Datasheet can be
> +  found here:
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/AD7191.pdf
> +  The device's PDOWN pin must be connected to the SPI controller's chip select
> +  pin.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ad7191
> +
> +  reg:
> +    maxItems: 1
> +
> +  spi-cpol: true
> +
> +  spi-cpha: true
> +
> +  clocks:
> +    maxItems: 1
> +    description: |

Don't need '|' if no formatting.

> +      Must be present when CLKSEL pin is tied HIGH to select external clock
> +      source (either a crystal between MCLK1 and MCLK2 pins, or a
> +      CMOS-compatible clock driving MCLK2 pin). Must be absent when CLKSEL pin
> +      is tied LOW to use the internal 4.92MHz clock.
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  avdd-supply:
> +    description: AVdd voltage supply
> +
> +  dvdd-supply:
> +    description: DVdd voltage supply
> +
> +  vref-supply:
> +    description: Vref voltage supply
> +
> +  odr-gpios:
> +    description: |

Don't need '|' if no formatting.

> +      ODR1 and ODR2 pins for output data rate selection. Should be defined if
> +      adi,odr-value is absent.
> +    minItems: 2
> +    maxItems: 2
> +
> +  adi,odr-value:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      Should be present if ODR pins are pin-strapped. Possible values:
> +      120 Hz (ODR1=0, ODR2=0)
> +      60 Hz (ODR1=0, ODR2=1)
> +      50 Hz (ODR1=1, ODR2=0)
> +      10 Hz (ODR1=1, ODR2=1)
> +      If defined, odr-gpios must be absent.
> +    enum: [120, 60, 50, 10]
> +
> +  pga-gpios:
> +    description: |

Don't need '|' if no formatting.

With those fixed,

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

> +      PGA1 and PGA2 pins for gain selection. Should be defined if adi,pga-value
> +      is absent.
> +    minItems: 2
> +    maxItems: 2

