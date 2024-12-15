Return-Path: <linux-iio+bounces-13490-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0AA39F23B6
	for <lists+linux-iio@lfdr.de>; Sun, 15 Dec 2024 13:28:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 577AC18863D4
	for <lists+linux-iio@lfdr.de>; Sun, 15 Dec 2024 12:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24295183CA6;
	Sun, 15 Dec 2024 12:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aNLK/myI"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC93374FF;
	Sun, 15 Dec 2024 12:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734265719; cv=none; b=MB2fhSkfSlODO7Ijyu48bprh0Vi4P5xTs8HKvgvwpIU29Qky3RQDbzj9NRdR5FT1FLEhsoFZ9hw4UuIaCOisEzMfZKT0tUikqzYR5oIIacsVFGVhEdzh7JzZgZ9ODZET8jkKGXmt27m+nmKBZx7L11wpRVZJRcpJp5TwLAfxkvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734265719; c=relaxed/simple;
	bh=dwCH+0fYRE1FijYjTFxSBPY6i0A9PIbI2v9LnQxznMI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D4t3A7uf77iiSB+R+mf6NC0lLnJBgeE30upNrGrSa/Z6rjhdo5FEQ9nct7w/h5mf8x+cxdQM4hErLe74ADbYU4jK+MCwPP9M7ZFGLs+/6C3k9xSFMWXV0zLwcU8wJvq33ckytlo3r4hxOnw40F38viC2FvwDfJygF3VBjBzTp8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aNLK/myI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77AD6C4CECE;
	Sun, 15 Dec 2024 12:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734265719;
	bh=dwCH+0fYRE1FijYjTFxSBPY6i0A9PIbI2v9LnQxznMI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aNLK/myInAQySGNNpnw+/m8vaUS8NUdoNC3v9OtwVcDMiRxXmd1F70a5DWepneYqK
	 n/m14zXfCJJ14Y01QHD7otzfeI0QY8I7G8QK39zGgPFG0RUI0T0NjILV6o9Eu0FQJP
	 Fr/LgTe6WD8bHfbwLlvLFPvHjm59o1b0zQ6J8VrxjHf6BI3njBXPagYTIqXofUPRV6
	 0dhzKKBKLgNDF6bclKl8JAGQHBatQXLFm1ZODOCLuvySm/7KlBkxdEgExCGA/ncoTH
	 phUBn/C+F7HXjq5WlbC+6HcOxVr/+5zaZJkl4t3QJwNkbZ4FNjoHK6QQ1ZcDiGmNmP
	 wdN1ZDMZTsTbw==
Date: Sun, 15 Dec 2024 12:28:30 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, ak@it-klinger.de, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Krzysztof
 Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v3 1/1] dt-bindings: iio: pressure: bmp085: Add SPI
 interface
Message-ID: <20241215122830.159555e1@jic23-huawei>
In-Reply-To: <20241209233845.29539-2-vassilisamir@gmail.com>
References: <20241209233845.29539-1-vassilisamir@gmail.com>
	<20241209233845.29539-2-vassilisamir@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Dec 2024 00:38:45 +0100
Vasileios Amoiridis <vassilisamir@gmail.com> wrote:

> The BMP{2,3,5}80 and BME280 devices have an SPI interface, so include it
> in the device-tree.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
Stray blank line at end of file.  I fixed that up and applied,

Thanks,

Jonathan

> ---
>  .../bindings/iio/pressure/bmp085.yaml         | 30 +++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml b/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml
> index cb201cecfa1a..017abe8eb9c5 100644
> --- a/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml
> +++ b/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml
> @@ -55,12 +55,16 @@ properties:
>        If not set, defaults to push-pull configuration.
>      type: boolean
>  
> +  spi-max-frequency:
> +    maximum: 10000000
> +
>  required:
>    - compatible
>    - vddd-supply
>    - vdda-supply
>  
>  allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
>    - if:
>        properties:
>          compatible:
> @@ -73,6 +77,16 @@ allOf:
>      then:
>        properties:
>          interrupts: false
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - bosch,bmp085
> +              - bosch,bmp180
> +    then:
> +      properties:
> +        spi-max-frequency: false
>  
>  additionalProperties: false
>  
> @@ -93,3 +107,19 @@ examples:
>              vdda-supply = <&bar>;
>          };
>      };
> +  - |
> +    # include <dt-bindings/gpio/gpio.h>
> +    # include <dt-bindings/interrupt-controller/irq.h>
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        pressure@0 {
> +            compatible = "bosch,bmp280";
> +            reg = <0>;
> +            spi-max-frequency = <10000000>;
> +            reset-gpios = <&gpio0 26 GPIO_ACTIVE_LOW>;
> +            vddd-supply = <&foo>;
> +            vdda-supply = <&bar>;
> +        };
> +    };
> +


