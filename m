Return-Path: <linux-iio+bounces-7074-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB5291D0FE
	for <lists+linux-iio@lfdr.de>; Sun, 30 Jun 2024 11:58:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24E4228185D
	for <lists+linux-iio@lfdr.de>; Sun, 30 Jun 2024 09:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902541304A3;
	Sun, 30 Jun 2024 09:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mZOXT5TP"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458472AF04;
	Sun, 30 Jun 2024 09:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719741493; cv=none; b=SDGoYTwyzi/yDiLSFCAEuhPBYKCR7Wv3pPp+FSY9U5e4IcyQRYFS1MDsNMj8fmMWI4sneayik95FMqTo7V3xYM25RANoUn3N9EHg6YbPhKZde8ABcsWwVbnRrlfPCKZLgWEMM0xCYl1EgBYLuVLZa1Y99MFgqhsdD18D7r6aT5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719741493; c=relaxed/simple;
	bh=AjBNdkYQwfWWnH6XmSNLyGzd7W7Nd8bDzrbFrnl6PQI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XJ4fyeM9oIeTbPRlM9/4mQaROuRzQFaWx7xVbmCvxqjnBCgREfYtqph+9hIJfRD5/eWiYicyYJ7NGcl4SuxKFukYEaZrFi770jEb4vHQJ8YTRyUPPPG0yx27RWQeR3iyFcAxNdGeYZexvBh/UgjnCltYlyNkLk6oaBcy8J7eb/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mZOXT5TP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E73BCC2BD10;
	Sun, 30 Jun 2024 09:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719741492;
	bh=AjBNdkYQwfWWnH6XmSNLyGzd7W7Nd8bDzrbFrnl6PQI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mZOXT5TPKyIU5kJCsD86JGwA8QhKVT2Pz9wqyrXKLIhKd6bWKTun4XhDX7OigjJRO
	 9pujv6PjcTPdaNLzEOKvv0lH1eqWxpOpIRlG6+K6nNhjbLl58G3r3ofuw8GyC1zlz9
	 Tvrq9DCo1tzKHCHpk4J5V+Svg/3oFdLQQGAEd8m+dT5scQpbKUtn5n28JQtTjiRPJh
	 AxzbtbQfrIZtCq4VpsC7dBwQj/xzqoHmtn6CQZ5Cv47V5I5+Dpv9rpRerJuam+JdHY
	 sIp9Rc34BbCNQ1HyrOwhFDEfDNJBlQoDaS7OqiGUZ6dBAI+W0zJfselsWJgnZYkrFf
	 lifmA2ws6q2SA==
Date: Sun, 30 Jun 2024 10:58:04 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Alisa-Dariana Roman <alisadariana@gmail.com>
Cc: Alisa-Dariana Roman <alisa.roman@analog.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Michael Hennerich
 <michael.hennerich@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Lars-Peter
 Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Liam
 Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v6 4/6] dt-bindings: iio: adc: ad7192: Add clock
 provider
Message-ID: <20240630105804.67ddf9cb@jic23-huawei>
In-Reply-To: <20240624124941.113010-5-alisa.roman@analog.com>
References: <20240624124941.113010-1-alisa.roman@analog.com>
	<20240624124941.113010-5-alisa.roman@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Jun 2024 15:49:39 +0300
Alisa-Dariana Roman <alisadariana@gmail.com> wrote:

> Internal clock of AD719X devices can be made available on MCLK2 pin. Add
> clock provider to support this functionality.
> 
> The clock source can be either provided externally or the internal clock
> is used. Pair of clocks and clock-names property is mutally exclusive
> with #clock-cells property.
> 
> Modify second example to showcase the mode where internal clock is used.
> 
> Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
> ---
>  .../devicetree/bindings/iio/adc/adi,ad7192.yaml   | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
> index c3adc32684cf..384bff7e9bb7 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
> @@ -42,13 +42,17 @@ properties:
>      description:
>        Optionally, either a crystal can be attached externally between MCLK1 and
>        MCLK2 pins, or an external CMOS-compatible clock can drive the MCLK2
> -      pin. If absent, internal 4.92MHz clock is used.
> +      pin. If absent, internal 4.92MHz clock is used, which can be made
> +      available on MCLK2 pin.
>  
>    clock-names:
>      enum:
>        - xtal
>        - mclk
>  
> +  "#clock-cells":
> +    const: 0
> +
>    interrupts:
>      maxItems: 1
>  
> @@ -169,6 +173,12 @@ allOf:
>        required:
>          - clocks
>          - clock-names
> +  - oneOf:
> +      - required:
> +          - clocks
> +          - clock-names
> +      - required:
> +          - "#clock-cells"

Just a heads up that in the next patch discussion we are considering if the
driver should fail to probe or not if the clock provider stuff isn't here.

This is a bit like io-channels-cells where we have listed it as required
for some devices but not others and left that at discretion of the the
binding writer as it often reflects likely rather than possible usecases.

Here though I think this is possibly a backwards compatibility break we
don't need to make.

Jonathan

>  
>  unevaluatedProperties: false
>  
> @@ -214,8 +224,7 @@ examples:
>              spi-max-frequency = <1000000>;
>              spi-cpol;
>              spi-cpha;
> -            clocks = <&ad7192_mclk>;
> -            clock-names = "mclk";
> +            #clock-cells = <0>;
>              interrupts = <25 0x2>;
>              interrupt-parent = <&gpio>;
>              aincom-supply = <&aincom>;


