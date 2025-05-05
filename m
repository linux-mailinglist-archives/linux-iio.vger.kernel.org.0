Return-Path: <linux-iio+bounces-19112-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0562DAA97A2
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 17:39:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D8733AB7EE
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 15:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44D625DD0F;
	Mon,  5 May 2025 15:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pmG2ckEM"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858251C1AB4;
	Mon,  5 May 2025 15:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746459570; cv=none; b=ZYnQJgWU1uSAODc6bJEyNqHqgQsSAcGpX11RzDjHQEqXUnHNA0h3v55bP6H2syJgBAFrR+mPbAWVjPE/7QPDLDB55jCoJbP4VR+/FzZT33PYB69ylmY0fSON3P+L5rdYadpTjVSwfDsaq9iVAiV7WSRs6k8sHWQ8if9Mtc8UC6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746459570; c=relaxed/simple;
	bh=wYgReB0pK+wMXRVJVUn5r+S1n4tF9TC5TUM2pA3f6Bg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JeT6YmhZjMpAAnInoXKoPT6Yce5QMCJ4zvVKHq3+Ov2FEtxhpXvdlsaLzWFlfflq3wqg8cg+8LeCZevlEH8RQRXCU0NioiVwCiyTYOOvL+/R1w3pKaE8y7DS9el9kIuABGtLFE9GDyQOchk1Z5mViY/C9gEGYx+clE/1YTekEm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pmG2ckEM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4AB4C4CEEE;
	Mon,  5 May 2025 15:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746459569;
	bh=wYgReB0pK+wMXRVJVUn5r+S1n4tF9TC5TUM2pA3f6Bg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pmG2ckEMe0MIc2b3MMqlTKYd5PwE1XL3jIIJdZczp5fNBtnqoAGn5UfjwJd0P98wx
	 KU9uIbtKm4htraYh6sw/8lz4Z9rPsmX74ebZa1s9XXzLOJgDc4Im2VmKjD73f2lOkH
	 idmrrjPtJaLXcMm5SRWjR8m23ldn+JGZl6MCsp8F46U1WbTedYcgLVQXjXC/wdDNGm
	 2qfsxHEEX3cxO37zCNivxi/VDY/S7xV1kbd9CBx8q/eSx+5B2ji0XRwvBk6IjfPNIq
	 E7ftEWB0u9+KCsWhgg6V8M2nzcfR03HiPS0InXNWbFZ3zJ0QEOQyvQ1pDtvx8siYkV
	 B9VFiGrz/N0TQ==
Date: Mon, 5 May 2025 16:39:19 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
 <andy@kernel.org>, <nuno.sa@analog.com>, <Michael.Hennerich@analog.com>,
 <marcelo.schmitt@analog.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
 <conor+dt@kernel.org>, <marcelo.schmitt1@gmail.com>,
 <linus.walleij@linaro.org>, <brgl@bgdev.pl>, <lgirdwood@gmail.com>,
 <broonie@kernel.org>, <jonath4nns@gmail.com>, <dlechner@baylibre.com>
Subject: Re: [PATCH v6 02/11] dt-bindings: iio: adc: ad7768-1: add
 trigger-sources property
Message-ID: <20250505163919.6d805db2@jic23-huawei>
In-Reply-To: <128de2793d6d5424ad152c394faf1d51f0d56e0b.1745605382.git.Jonathan.Santos@analog.com>
References: <cover.1745605382.git.Jonathan.Santos@analog.com>
	<128de2793d6d5424ad152c394faf1d51f0d56e0b.1745605382.git.Jonathan.Santos@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 27 Apr 2025 21:12:16 -0300
Jonathan Santos <Jonathan.Santos@analog.com> wrote:

> In addition to GPIO synchronization, The AD7768-1 also supports
> synchronization over SPI, which use is recommended when the GPIO
> cannot provide a pulse synchronous with the base MCLK signal. It
> consists of looping back the SYNC_OUT to the SYNC_IN pin and send
> a command via SPI to trigger the synchronization.
> 
> Introduce the 'trigger-sources' property to enable SPI-based
> synchronization via SYNC_OUT pin, along with additional optional
> entries for GPIO3 and DRDY pins.
> 
> Also create #trigger-source-cells property to differentiate the trigger
> sources provided by the ADC. To improve readability, create a
> adi,ad7768-1.h header with the macros for the cell values.
> 
> While at it, add description to the interrupts property.
> 
> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>

A few things inline, but minor stuff for if you need to do a respin.

> ---
> v6 Changes:
> * Removed references to offload.
> * Changed trigger-sources-cells description. Each cell value indicates
>   a gpio line from the ADC.
> * Added adi,ad7768-1.h header with macros for the trigger source cells.
> * Removed offload trigger entry from trigger-sources.
> 
> v5 Changes:
> * Include START pin and DRDY in the trigger-sources description.
> * Fixed "#trigger-source-cells" value and description.
> * sync-in-gpios is represented in the trigger-sources property.
> 
> v4 Changes:
> * none
> 
> v3 Changes:
> * Fixed dt-bindings errors.
> * Trigger-source is set as an alternative to sync-in-gpios, so we
>   don't break the previous ABI.
> * increased maxItems from trigger-sources to 2.
> 
> v2 Changes:
> * Patch added as replacement for adi,sync-in-spi patch.
> * addressed the request for a description to interrupts property.
> ---
>  .../bindings/iio/adc/adi,ad7768-1.yaml        | 31 ++++++++++++++++++-
>  include/dt-bindings/iio/adc/adi,ad7768-1.h    | 10 ++++++
>  2 files changed, 40 insertions(+), 1 deletion(-)
>  create mode 100644 include/dt-bindings/iio/adc/adi,ad7768-1.h
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
> index 3ce59d4d065f..1f476aa15305 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
> @@ -26,7 +26,28 @@ properties:
>    clock-names:
>      const: mclk
>  
> +  trigger-sources:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    minItems: 1
> +    maxItems: 2
> +    description: |
> +      A list of phandles referencing trigger source providers. Each entry
> +      represents a trigger source for the ADC:
> +
> +        - First entry specifies the device responsible for driving the
> +          synchronization (SYNC_IN) pin, as an alternative to adi,sync-in-gpios.
> +          This can be a `gpio-trigger` or another `ad7768-1` device. If the
> +          device's own SYNC_OUT pin is internally connected to its SYNC_IN pin,
> +          reference the device itself or omit this property.
> +        - Second entry optionally defines a GPIO3 pin used as a START signal trigger.
> +
> +      Use the accompanying trigger source cell to identify the type of each entry.
> +
>    interrupts:
> +    description:
> +      Specifies the interrupt line associated with the ADC. This refers
> +      to the DRDY (Data Ready) pin, which signals when conversion results are
> +      available.

Trivial but this seems overly wordy. The only bit that matters is the datardy bit.

     DRDY (Data Ready) pin, which signals conversion results are available.

is probably enough.  Only bother if you are respining for other reasons however
as this really doesn't matter!

>      maxItems: 1
>  
>    '#address-cells':
> @@ -57,6 +78,15 @@ properties:
>    "#io-channel-cells":
>      const: 1
>  
> +  "#trigger-source-cells":
> +    description: |
> +      Cell indicates the trigger output signal: 0 = SYNC_OUT, 1 = GPIO3,
> +      2 = DRDY.
> +
> +      For better readability, macros for these values are available in
> +      dt-bindings/iio/adc/adi,ad7768-1.h.
> +    const: 1
> +
>  required:
>    - compatible
>    - reg
> @@ -65,7 +95,6 @@ required:
>    - vref-supply
>    - spi-cpol
>    - spi-cpha
> -  - adi,sync-in-gpios

Maybe worth requiring oneOf adi,sync-in-gpios or trigger-sources? 

>  
>  patternProperties:
>    "^channel@([0-9]|1[0-5])$":
> diff --git a/include/dt-bindings/iio/adc/adi,ad7768-1.h b/include/dt-bindings/iio/adc/adi,ad7768-1.h
> new file mode 100644
> index 000000000000..34d92856a50b
> --- /dev/null
> +++ b/include/dt-bindings/iio/adc/adi,ad7768-1.h
> @@ -0,0 +1,10 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> +
> +#ifndef _DT_BINDINGS_ADI_AD7768_1_H
> +#define _DT_BINDINGS_ADI_AD7768_1_H
> +
> +#define AD7768_TRIGGER_SOURCE_SYNC_OUT  0
> +#define AD7768_TRIGGER_SOURCE_GPIO3     1
> +#define AD7768_TRIGGER_SOURCE_DRDY      2
> +
> +#endif /* _DT_BINDINGS_ADI_AD7768_1_H */


