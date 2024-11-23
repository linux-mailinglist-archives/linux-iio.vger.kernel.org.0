Return-Path: <linux-iio+bounces-12561-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB1FB9D6A65
	for <lists+linux-iio@lfdr.de>; Sat, 23 Nov 2024 17:54:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48DE71618CB
	for <lists+linux-iio@lfdr.de>; Sat, 23 Nov 2024 16:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0F2D13D53E;
	Sat, 23 Nov 2024 16:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YJisVSQL"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CAC5672;
	Sat, 23 Nov 2024 16:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732380843; cv=none; b=DCjFRqHts1geTVPH5CsSiosIrg2n9BHzVlfTjEiq+4JwqMdSXJhyukLdFcJlWsbR+dqX/LiuQEPm3NX1BbB9DcXP1+VzjtGR/ZDmPHJ5u55Xb++wzH4TB//1/DqQq8pMJOTE2ys3hUQ968PaIVceOGvjmwlV0D5IerBtywJ3NNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732380843; c=relaxed/simple;
	bh=Suk0Q33eYhTNEPnfKvTXzF3T2LKeb0Oa978tN5lPa40=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ifC/Yg0eUHc7a9HezLWHJv6XkfH4LqaV2vxxN32ev0puCdi+ig+aTvyAYKZ22zYUnwJyqpbU2mpIhhuEUs7QZkOKGe1kp33XrjbvA6P3P7UNHWNlm50i8fxIB4+DKnbDHOyUTN8LxtyA32wq+CcQ3hTIhGJ8tIjFROsbh+ugZ/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YJisVSQL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28BF2C4CECD;
	Sat, 23 Nov 2024 16:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732380843;
	bh=Suk0Q33eYhTNEPnfKvTXzF3T2LKeb0Oa978tN5lPa40=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YJisVSQLr/+4ArOwA61y2o+j5Pjw1KeaVRFNbfIVjVwNrH2AttqcDZ8FBRgJl0Otg
	 Ry33rQhDMfctyrALvgE6mqWmDrKaNF747c4eXlr+2lRry6h6vASscYDYztjO4SW+2D
	 RvZPcXQfIBCPt6FPHf1xJsfsYuN4l1Ii5E5varH6DLaUcNB9v2bJgdstXvESATmRVL
	 ZsV2IkbEgD2IrWaYkMnClZygEgsXDKo5kX4C7jgVR1qWjI9Vzt9YmsMb8qG2jjihFs
	 9WcRw9W5vHWHTs9o0dbIZZxFB9StJ4WovegCzmI5nI8AE7+0ypSLzbA+ma6BSoqv60
	 XCOvZFEht9bVA==
Date: Sat, 23 Nov 2024 16:53:54 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Tobias Sperling via B4 Relay
 <devnull+tobias.sperling.softing.com@kernel.org>
Cc: tobias.sperling@softing.com, Lars-Peter Clausen <lars@metafoo.de>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: Introduce ADS7138
Message-ID: <20241123165354.0763cc1f@jic23-huawei>
In-Reply-To: <20241122-adc_ml-v1-1-0769f2e1bbc1@softing.com>
References: <20241122-adc_ml-v1-0-0769f2e1bbc1@softing.com>
	<20241122-adc_ml-v1-1-0769f2e1bbc1@softing.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 22 Nov 2024 16:15:36 +0100
Tobias Sperling via B4 Relay <devnull+tobias.sperling.softing.com@kernel.org> wrote:

> From: Tobias Sperling <tobias.sperling@softing.com>
> 
> Add documentation for the driver of ADS7128 and ADS7138 12-bit, 8-channel
> analog-to-digital converters. These ADCs have a wide operating range and
> a wide feature set. Communication is based on the I2C interface.
> 
> Signed-off-by: Tobias Sperling <tobias.sperling@softing.com>
Hi Tobias,

Welcome to IIO.
This should really have been a v2 to avoid confusion but good that b4-relay worked
for you.

Add a little on the differences you mention below to the patch description.

One comment inline.

Thanks,

Jonathan

> ---
>  .../devicetree/bindings/iio/adc/ti,ads7138.yaml    | 64 ++++++++++++++++++++++
>  1 file changed, 64 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads7138.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads7138.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..367d3b27cec3bc5800aac42c8a07497da7de4c1b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/ti,ads7138.yaml
> @@ -0,0 +1,64 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/ti,ads7138.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Texas Instruments ADS7128/ADS7138 analog-to-digital converter (ADC)
> +
> +maintainers:
> +  - Tobias Sperling <tobias.sperling@softing.com>
> +
> +description: |
> +  The ADS7128 and ADS7138 chips are 12-bit, 8 channel analog-to-digital
> +  converters (ADC) with build-in digital window comparator (DWC), using the
> +  I2C interface.
> +  ADS7128 differs in the addition of further hardware features, like a
> +  root-mean-square (RMS) and a zero-crossing-detect (ZCD) module, which are
> +  not yet supported by the driver.
Don't mention the driver in a dt-binding. It's all about the hardware
not so much what we support.
So say what features it has, but not the bit about support.

> +
> +  Datasheets:
> +    https://www.ti.com/product/ADS7128
> +    https://www.ti.com/product/ADS7138
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ti,ads7128
> +      - ti,ads7138
> +
> +  reg:
> +    maxItems: 1
> +
> +  avdd-supply:
> +    description:
> +      The regulator used as analog supply voltage as well as reference voltage.
> +
> +  interrupts:
> +    description:
> +      Interrupt on ALERT pin, triggers on low level.
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - avdd-supply
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        adc@10 {
> +            compatible = "ti,ads7138";
> +            reg = <0x10>;
> +            avdd-supply = <&reg_stb_3v3>;
> +            interrupt-parent = <&gpio2>;
> +            interrupts = <12 IRQ_TYPE_LEVEL_LOW>;
> +        };
> +    };
> +...
> 


