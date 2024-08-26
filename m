Return-Path: <linux-iio+bounces-8778-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C673695EC1E
	for <lists+linux-iio@lfdr.de>; Mon, 26 Aug 2024 10:37:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 574931F211F5
	for <lists+linux-iio@lfdr.de>; Mon, 26 Aug 2024 08:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7207A139CFC;
	Mon, 26 Aug 2024 08:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TJ+YLYUK"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B4673478;
	Mon, 26 Aug 2024 08:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724661412; cv=none; b=EJJigs8dIo1KXDqcnWxmdQmbTg9WL7vSU9/NpNIpCbv+J+3Qt2jvBS0Ky4voKH0ZaZGBjk6/vg5A1VY1d+nzuMerdBIu7bwTEGPGlg1HzTyOolCEvB9rE9+vQLe/5rqAeYiMzY4MAxvggQ3u7k2pOlRxVdyR34RzvqGZLAyoljA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724661412; c=relaxed/simple;
	bh=RvoSXYx5aZ9xUlAAZQxs9imiRyF//RNpaHWpP9bgIMw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z8sZJJcKDgPid/vYzKncThKU2akPFDPo8PgMkOwZLMZLxgwVbB4Lixt2exol7kCUmSEFderCEGQHbXY4PoB8te1Kp1AU1u+TPgyl22Yb+glYRpHfnyd/LD/VvmMLfVimFSNycQwbe6WR0b/hb8aIsknREB6tINxjUY5Xhe5W9ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TJ+YLYUK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E112FC568DE;
	Mon, 26 Aug 2024 08:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724661411;
	bh=RvoSXYx5aZ9xUlAAZQxs9imiRyF//RNpaHWpP9bgIMw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TJ+YLYUK1VF5e5R6djrUVifNEoPIdmNGRKzIxWWQLsCx62/FOJYAt4CbKyTV31l1G
	 Sswj5HMVez0VUYUbq5RCJNYhCEqgv+GeTWdlRLy2Y8CmqbRMwhVv4G/h/QLk3OjyE7
	 DYAaPyyQqAg9Kc915NOFvkCG2qDoLxQwim5TXf8tkCkwJfh2LWT8z5Bt8WoAw+0v9I
	 cJyvrNALHZaIHtWHHApspnQ8HXezWCq9aCYUbDKWFA4fYecz7AzyLIwqgxITsaF++i
	 zJrZoQGoWO2cODipqE4W9pUjZnkANzDCwoyjjDETHv0VxrZKz9veTfWXTPBzP+jTr1
	 4lU3LLxcryTog==
Message-ID: <cae86533-9eaa-4253-91ae-14c65b378c3c@kernel.org>
Date: Mon, 26 Aug 2024 10:36:42 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] dt-bindings: iio: adc: add ADI ad4030, ad4630 and
 ad4632
To: Esteban Blanc <eblanc@baylibre.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>,
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>,
 linux-doc@vger.kernel.org
References: <20240822-eblanc-ad4630_v1-v1-0-5c68f3327fdd@baylibre.com>
 <20240822-eblanc-ad4630_v1-v1-1-5c68f3327fdd@baylibre.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20240822-eblanc-ad4630_v1-v1-1-5c68f3327fdd@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/08/2024 14:45, Esteban Blanc wrote:
> This adds a binding specification for the Analog Devices Inc. AD4030,
> AD4630 and AD4632 families of ADCs.
> 
> - ad4030-24 is a 1 channel SAR ADC with 24 bits of precision and a
>   sampling rate of 2M samples per second
> - ad4630-16 is a 2 channels SAR ADC with 16 bits of precision and a
>   sampling rate of 2M samples per second
> - ad4630-24 is a 2 channels SAR ADC with 24 bits of precision and a
>   sampling rate of 2M samples per second
> - ad4632-16 is a 2 channels SAR ADC with 16 bits of precision and a
>   sampling rate of 500K samples per second
> - ad4632-24 is a 2 channels SAR ADC with 24 bits of precision and a
>   sampling rate of 500K samples per second
> 
> Signed-off-by: Esteban Blanc <eblanc@baylibre.com>
> ---
>  .../devicetree/bindings/iio/adc/adi,ad4030.yaml    | 113 +++++++++++++++++++++
>  MAINTAINERS                                        |   8 ++
>  2 files changed, 121 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
> new file mode 100644
> index 000000000000..7957c0c0ac7a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
> @@ -0,0 +1,113 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright 2024 Analog Devices Inc.
> +# Copyright 2024 BayLibre, SAS.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/adi,ad4030.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices AD4030 and AD4630 ADC family device driver

"device driver"? Bindings are for hardware. Explain the hardware, not
driver.

> +
> +maintainers:
> +  - Nuno Sa <nuno.sa@analog.com>
> +  - Michael Hennerich <michael.hennerich@analog.com>
> +
> +description: |
> +  Analog Devices AD4030 single channel and AD4630 dual channel precision SAR ADC
> +  family

Does not look like wrapped according to Linux coding style. Read the
coding style (not checkpatch).

> +
> +  * https://www.analog.com/media/en/technical-documentation/data-sheets/ad4030-24-4032-24.pdf
> +  * https://www.analog.com/media/en/technical-documentation/data-sheets/ad4630-24_ad4632-24.pdf
> +  * https://www.analog.com/media/en/technical-documentation/data-sheets/ad4630-16-4632-16.pdf
> +
> +properties:
> +

Drop blank line

> +  compatible:
> +    enum:
> +      - adi,ad4030-24
> +      - adi,ad4630-16
> +      - adi,ad4630-24
> +      - adi,ad4632-16
> +      - adi,ad4632-24
> +
> +  reg:
> +    maxItems: 1
> +
> +  spi-max-frequency:
> +    maximum: 100000000
> +
> +  spi-rx-bus-width:
> +    enum: [1, 2, 4]
> +
> +  vdd-5v-supply: true
> +  vdd-1v8-supply: true
> +  vio-supply: true
> +
> +  ref-supply:
> +    description:
> +      Optional External unbuffered reference. Used when refin-supply is not
> +      connected.
> +
> +  refin-supply:
> +    description:
> +      Internal buffered Reference. Used when ref-supply is not connected.
> +
> +  cnv-gpio:

Nope, there is no "gpio" property. It IS ALWAYS gpios. Look at other
examples.


> +    description:
> +      The Convert Input (CNV). It initiates the sampling conversions.
> +    maxItems: 1
> +
> +  reset-gpio:

Same problem.

> +    description:
> +      Reset Input (Active Low). Used for asynchronous device reset.
> +    maxItems: 1
> +
> +  interrupts:
> +    description:
> +      The BUSY pin is used to signal that the conversions results are available
> +      to be transferred when in SPI Clocking Mode. This nodes should be connected
> +      to an interrupt that is triggered when the BUSY line goes low.
> +    maxItems: 1
> +


> 

Best regards,
Krzysztof


