Return-Path: <linux-iio+bounces-13838-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FB819FDAEA
	for <lists+linux-iio@lfdr.de>; Sat, 28 Dec 2024 15:30:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFC4C162174
	for <lists+linux-iio@lfdr.de>; Sat, 28 Dec 2024 14:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8271E156C74;
	Sat, 28 Dec 2024 14:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZhHeLNqk"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3954910E5;
	Sat, 28 Dec 2024 14:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735396236; cv=none; b=imvpN4shZIJy71jZ+3h7kkw9RjhPmGnz4tTKN67htTtJhvYvU5QNqK/fMcGWucgJob63ONYO/0GXvGoPNAEZWobJfv+SQ+0xRlAkjwWGpyEcOoI/pEt53vDLmvJmpCI8JO+rApJ5AwQl0v0LOFxMoL2/ewdocXEXHKF3x65/4hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735396236; c=relaxed/simple;
	bh=42d65e+I2bfgobXIhYC9FAIAFIK/lNe6zGpkmuNmgLM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lmBzkYRKQWKK5pGIXstxL6HoEsYK0yIY1OrC8OPHuhh52OHq0F09Z9Sucu1YuIJvU7S0Oe2/AtAmCW2C4mUC7f+I4U2YjKJhztyq2YZUUuLWrbbC4nXuSSJZ+4Y1AAK619g+b4iedZJXXCwXWGBIKljwohyvJ6hi95rlSF7Iy/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZhHeLNqk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60764C4CECD;
	Sat, 28 Dec 2024 14:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735396235;
	bh=42d65e+I2bfgobXIhYC9FAIAFIK/lNe6zGpkmuNmgLM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZhHeLNqkD+jy83Afh9RHMOXC9iyA271UhFz6zdZJMksmB5YBUs12ft3m14RU6dxMe
	 UNZrLkRRoN5ynwU8hKSef6duCnSjJ1Nv1kCgGZmekK7W+21brchv5vwdyValbMgRRc
	 HZaZKz+isgwfUtv1CbObwsltHCLQr/35wTK76GFCiVQPWn5Vcd7/1DMaWTemULWrUM
	 8Iz/hMLeJ/Uk4t0uuJqqwqes3hbsvwfz4q9cTVi9dF7EaP+Mxjc2uQEQbdF2yrHI+d
	 4b+k/uQFKS4OYWGTn69q1UJaoZ/zDXHoB0yWhaUkiX2SH46LCis7bdW6bHy69IWGUJ
	 KZVcwVefYynhw==
Date: Sat, 28 Dec 2024 14:30:25 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 eraretuya@gmail.com, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v8 2/7] dt-bindings: iio: accel: adxl345: make
 interrupts not a required property
Message-ID: <20241228143025.4af64793@jic23-huawei>
In-Reply-To: <20241225181338.69672-3-l.rubusch@gmail.com>
References: <20241225181338.69672-1-l.rubusch@gmail.com>
	<20241225181338.69672-3-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 25 Dec 2024 18:13:33 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Remove interrupts from the list of required properties. The ADXL345
> does not need interrupts for basic accelerometer functionality.
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
Applied.

Thanks,

J
> ---
>  Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
> index 280ed479e..bc46ed00f 100644
> --- a/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
> +++ b/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
> @@ -40,7 +40,6 @@ properties:
>  required:
>    - compatible
>    - reg
> -  - interrupts
>  
>  allOf:
>    - $ref: /schemas/spi/spi-peripheral-props.yaml#


