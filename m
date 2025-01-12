Return-Path: <linux-iio+bounces-14214-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C59A0AA1E
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 15:39:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D9CA164D8D
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 14:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E11641B87CF;
	Sun, 12 Jan 2025 14:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cmi4huFR"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DD818CBFE;
	Sun, 12 Jan 2025 14:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736692787; cv=none; b=JMKbQ+w5ODBd3/P/Ky5uitOVDv6SqMpzgU/7ESow8NpK+CO1ELhuUieRoNq3o4arDX9PlUUMc4e/u/el/YfAYbR7VHN0wDgK90JuaKGLzBbjg9UjFq6JWGXrePCaI8aiPZyZFx2+KM+mfY/z0du/7qd4CiIQQ6K4OOUpNc7y0lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736692787; c=relaxed/simple;
	bh=RlXNDQT/mDFyUVza8wBNT2gU4MCk5VhiUIjwQCl4NNI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BID8+v6JHSzrx4Bnd0w7qwWoNWfa+0GWi3ZIU5fARl96ep/nCy0EHwjaBK6iFs5NLyfJ7JiaNIF1wiQjTNazfwxfcLDp0mvC3MJBbpvWm64BhbrhX7qQos8M+I4IZbuGRwsDe9WkU2NzT10YMBufDgS1dImHTL1iLro0VaHnvdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cmi4huFR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B41BC4CEDF;
	Sun, 12 Jan 2025 14:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736692787;
	bh=RlXNDQT/mDFyUVza8wBNT2gU4MCk5VhiUIjwQCl4NNI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Cmi4huFRx7qbemXsKezPbV+Cdf/gMu3JSSrgkmgMpHdtjkXPIGhj4+I6R7Uozuoah
	 /uA7/KdkmrdPdzNFStOQ7pEgNPHVcGWJ+yaJmrKDnEy7MKjtJdNhwWXFDyg8EWf/d4
	 W61J1z7QIjdseOIeeYj4tg0TDEahjlTLLHTkuGPIsig/qL2yFyQ6njvILkBoTwb2oL
	 AfuB0eyMqial7EIjeCPojTly/Xw3ShlvMV2BlnCsTc5tpuNv4fjnrdnEgUwlTEagti
	 qLL31Qm41OIo6fH9TtZQiYYT8utXZtmQNWX/JCMOKDNbNuJqXyGC5M17k+AqeDcg6D
	 4onOHZuUHOsYg==
Date: Sun, 12 Jan 2025 14:39:34 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Antoni Pokusinski <apokusinski01@gmail.com>
Cc: lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, andrej.skvortzov@gmail.com, neil.armstrong@linaro.org,
 icenowy@aosc.io, megi@xff.cz, danila@jiaxyga.com,
 javier.carrasco.cruz@gmail.com, andy@kernel.org,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, Krzysztof Kozlowski
 <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: magnetometer: add binding for
 Si7210
Message-ID: <20250112143934.78f80231@jic23-huawei>
In-Reply-To: <20250112104453.45673-2-apokusinski01@gmail.com>
References: <20250112104453.45673-1-apokusinski01@gmail.com>
	<20250112104453.45673-2-apokusinski01@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 12 Jan 2025 11:44:52 +0100
Antoni Pokusinski <apokusinski01@gmail.com> wrote:

> Silicon Labs Si7210 is an I2C Hall effect magnetic position
> and temperature sensor.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Antoni Pokusinski <apokusinski01@gmail.com>
Trivial comment inline. No need to change anything.

> ---
>  .../iio/magnetometer/silabs,si7210.yaml       | 48 +++++++++++++++++++
>  1 file changed, 48 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/silabs,si7210.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/magnetometer/silabs,si7210.yaml b/Documentation/devicetree/bindings/iio/magnetometer/silabs,si7210.yaml
> new file mode 100644
> index 000000000000..d4a3f7981c36
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/magnetometer/silabs,si7210.yaml
> @@ -0,0 +1,48 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/magnetometer/silabs,si7210.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Si7210 magnetic position and temperature sensor
> +
> +maintainers:
> +  - Antoni Pokusinski <apokusinski01@gmail.com>
> +
> +description: |
> +  Silabs Si7210 I2C Hall effect magnetic position and temperature sensor.
> +  https://www.silabs.com/documents/public/data-sheets/si7210-datasheet.pdf
> +
> +properties:
> +  compatible:
> +    const: silabs,si7210
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  vdd-supply:
> +    description: Regulator that provides power to the sensor
Not important, but this one is obvious enough I'd not have bothered with
the description text.
vdd-suppy: true
would have been fine.

Jonathan
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        magnetometer@30 {
> +            compatible = "silabs,si7210";
> +            reg = <0x30>;
> +            interrupt-parent = <&gpio1>;
> +            interrupts = <4 IRQ_TYPE_EDGE_FALLING>;
> +            vdd-supply = <&vdd_3v3_reg>;
> +        };
> +    };


