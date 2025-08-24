Return-Path: <linux-iio+bounces-23179-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D7E1B32F57
	for <lists+linux-iio@lfdr.de>; Sun, 24 Aug 2025 13:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAAB2205AF8
	for <lists+linux-iio@lfdr.de>; Sun, 24 Aug 2025 11:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D4B2D5432;
	Sun, 24 Aug 2025 11:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Loerx6e1"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8E22C327D;
	Sun, 24 Aug 2025 11:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756034426; cv=none; b=Sp3huwp1hGBx/UM1spkm9+VlY1JqT2edoGJcY75gGJubctbiRsPvL3AdFF1ZcP65wnfhlSTQl6417teVJoeIh/Trd8LMvHK82eM1vHBOgANI2gQHX0F97lZ5N2hte4QWIJgiJDxZ6VL192wSusoNBJrL9HDhUE4UTtB9Z3qZgP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756034426; c=relaxed/simple;
	bh=+OkOBQx3yRrZpTiq/fQPXgpZZZmpP5pqcfVE/IglG0g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FGHH+aKvcL3kSrwtil60OblZu/D9/WzIUy0yjj1KVBOSZVuUL4rp4yKFzv/u47UFG/Ay/0YY80lENiXvbIGZvYwCt5VqioARx1PeO6C5+cXdFdzqaP8g9B/9QY4LLrYqplzKxfpoAeGbG3wiuDKhgURY7qIh6axC4GrgPXSiQtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Loerx6e1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48748C4CEEB;
	Sun, 24 Aug 2025 11:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756034426;
	bh=+OkOBQx3yRrZpTiq/fQPXgpZZZmpP5pqcfVE/IglG0g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Loerx6e1x2VjRNcM3MW45r4qwsF0WnebjbFtGiqfIagnabuMUrPsqGjz/8pdXARkw
	 pDcnCxi84CPtleCDboazXwXvUSBdvtnBj6PkheZq+ulDz55VkY8MH8RI90GNG8yesn
	 71NL7ijnhCN0VO3XcIQh5OnC6br9qCwbApjL+qo/Ms5KG+Kbti/S03Yi9OvQxm5F+3
	 JUAxtYBZGnf0WIOQ3MRZeU6DVtDJRx2z5e6hJOlucBxNfcrNKlq8DGN7H9ckKOu5pW
	 RGxFM59tXzm/yIgwyvh1fkMLeuAEnA54Zem231jrT3scTFk0YXJeXXWfgCWTHQvv93
	 GJ5HTTBbOvgjw==
Message-ID: <510f6efb-ada3-4848-ac8e-16fa5d1b5284@kernel.org>
Date: Sun, 24 Aug 2025 13:20:21 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] dt-bindings: iio: adc: ad7768-1: add new supported
 parts
To: Jonathan Santos <Jonathan.Santos@analog.com>,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org
Cc: Michael.Hennerich@analog.com, lars@metafoo.de, jic23@kernel.org,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, marcelo.schmitt1@gmail.com
References: <20250824040943.9385-1-Jonathan.Santos@analog.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20250824040943.9385-1-Jonathan.Santos@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/08/2025 06:09, Jonathan Santos wrote:
> Add compatibles for supported parts in the ad7768-1 family:
> 	ADAQ7767-1, ADAQ7768-1 and ADAQ7769-1
> 
> Add property and checks for AAF gain, supported by ADAQ7767-1
> and ADAQ7769-1 parts:
> 	adi,gain-milli
> 
> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>

git send-email v2*

Not patch by patch. You made it very difficult for us to review and to
apply.

> ---
> v2 Changes:
> * adi,aaf-gain property renamed to adi,gain-milli. Description was 
>   simplified.
> * default value add to adi,gain-milli.
> ---
>  .../bindings/iio/adc/adi,ad7768-1.yaml        | 43 +++++++++++++++++--
>  1 file changed, 39 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
> index c06d0fc791d3..0c39491f6179 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
> @@ -4,18 +4,26 @@
>  $id: http://devicetree.org/schemas/iio/adc/adi,ad7768-1.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>  
> -title: Analog Devices AD7768-1 ADC device driver
> +title: Analog Devices AD7768-1 ADC family
>  
>  maintainers:
>    - Michael Hennerich <michael.hennerich@analog.com>
>  
>  description: |
> -  Datasheet at:
> -    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7768-1.pdf
> +  Analog Devices AD7768-1 24-Bit Single Channel Low Power sigma-delta ADC family
> +
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/ad7768-1.pdf
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/adaq7767-1.pdf
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/adaq7768-1.pdf
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/adaq7769-1.pdf
>  
>  properties:
>    compatible:
> -    const: adi,ad7768-1
> +    enum:
> +      - adi,ad7768-1
> +      - adi,adaq7767-1
> +      - adi,adaq7768-1
> +      - adi,adaq7769-1
>  
>    reg:
>      maxItems: 1
> @@ -58,6 +66,18 @@ properties:
>      description:
>        ADC reference voltage supply
>  
> +  adi,gain-milli:
> +    description: |
> +       Specifies the gain applied by the Analog Anti-Aliasing Filter (AAF) to the
> +       ADC input (in milli units). The hardware gain is determined by which input


I don't think there is no such thing as "milli units". milli is SI
prefix, not unit. So "units" is the unit? Or how exactly?

Basis points were before since 2022 so I don't get why these other
bindings introduced in 2024 could not use it?

Anyway, if you ever do not apply reviewers comment, then your commit msg
should explain this. Otherwise you get the same discussion here.

Best regards,
Krzysztof

