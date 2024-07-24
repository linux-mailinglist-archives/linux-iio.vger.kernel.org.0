Return-Path: <linux-iio+bounces-7842-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF4093B172
	for <lists+linux-iio@lfdr.de>; Wed, 24 Jul 2024 15:17:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 675D31F21870
	for <lists+linux-iio@lfdr.de>; Wed, 24 Jul 2024 13:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F8D158D7E;
	Wed, 24 Jul 2024 13:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N1IH6TqL"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961F6157E6C;
	Wed, 24 Jul 2024 13:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721827023; cv=none; b=XbFCkmrLOgSGEpO+S82QgDVFQCpyNARSsy92lzV4O+6LLbj53vZn5UUFF0QXSIczlb8bHlwPPZINulYdNzTr40WsdLkJppVyIxOI+aTQODjhqMWQpVJSv3B2IxL3Em3MupKj6B9PZQPK6uyRJ2UKNT2Wdv8YJ2KZDVEuqwGIWtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721827023; c=relaxed/simple;
	bh=686/eu4zCNarUXzwWa4R0PbPtsFBk7xckZhT7vx3gps=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hzDQhM809ccPgp8lQjWf+q/6LL9m54C+ypOJyRWC+WwGommDyWYzR7vzGTJkbhgA+SgKzn+mObumvmpcpkRFBUX+0LvT9/X8BoCDCui9Qt7z1XuKEqVsAXpYptGYDC0QOn7KQsy/X77q/BtnRRESf7KP4QSE0gW+3urApeSXFWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N1IH6TqL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C437C32782;
	Wed, 24 Jul 2024 13:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721827023;
	bh=686/eu4zCNarUXzwWa4R0PbPtsFBk7xckZhT7vx3gps=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=N1IH6TqLAiiHcBQl8bdVUX54hsYaJa3tBsPmEcDp2zeCK8gPougu8NN4rBkC9Yjsd
	 jp2U2gOiJBJIt0jJYawqcrNnZb45MUFTjLb6nA4to6obrgOEGz8LwOd+UpvQhDzrS3
	 8WSzfxNSCt1EMQTj1/C/THm3CvQu+JkUJMha9GSHiO8yuK19PXxYslQOGz2rSuSz14
	 sur9aMrgks5o7r+tN3/wVFO2VwT+aHS3cxCtccUqFUQOapMG5YLgZZqX7dNYr1XBrN
	 lMkkABxjairOMSoIz1/WfnygZggENJrWHiHs9MiNSr6vEjF+6/G15oAfZ2MMZCpW4p
	 M+jGwAbPiPDhQ==
Message-ID: <20a8ad37-f6ce-4342-a2f7-bf3495dfeb69@kernel.org>
Date: Wed, 24 Jul 2024 15:16:56 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: iio: imu: SMI240: add bosch,smi240.yaml
To: Jianping.Shen@de.bosch.com, jic23@kernel.org, lars@metafoo.de,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 dima.fedrau@gmail.com, marcelo.schmitt1@gmail.com,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Christian.Lorenz3@de.bosch.com,
 Ulrike.Frauendorf@de.bosch.com, Kai.Dolde@de.bosch.com
References: <20240724125115.10110-1-Jianping.Shen@de.bosch.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20240724125115.10110-1-Jianping.Shen@de.bosch.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 24/07/2024 14:51, Jianping.Shen@de.bosch.com wrote:
> From: "Shen Jianping (ME-SE/EAD2)" <she2rt@LR-C-0008DVM.rt.de.bosch.com>
> 
> dt-bindings: iio: imu: SMI240: add bosch,smi240.yaml

Something got corrupted here.

Anyway, please send bindings with driver in the same patchset.

Limited review follows:

> Signed-off-by: Shen Jianping (ME-SE/EAD2) <she2rt@LR-C-0008DVM.rt.de.bosch.com>
> ---

Missing changelog. That's v2, not v1? Provide changelog under --- and
version your patches correctly. b4 does it for you...


>  .../bindings/iio/imu/bosch,smi240.yaml        | 50 +++++++++++++++++++
>  1 file changed, 50 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/imu/bosch,smi240.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/imu/bosch,smi240.yaml b/Documentation/devicetree/bindings/iio/imu/bosch,smi240.yaml
> new file mode 100644
> index 00000000000..5e89d85d867
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/imu/bosch,smi240.yaml
> @@ -0,0 +1,50 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/imu/bosch,smi240.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Bosch SMI240 IMU
> +
> +maintainers:
> +  - Jianping Shen <Jianping.Shen@de.bosch.com>
> +
> +description: |

Do not need '|' unless you need to preserve formatting.

> +  The SMI240 is a combined three axis angular rate and three axis acceleration sensor module
> +  with a measurement range of +/-300°/s and up to 16g. SMI240 does not support interrupt. 
> +  https://www.bosch-semiconductors.com/mems-sensors/highly-automated-driving/smi240/

This does not look like wrapped according to Linux Coding Style. See
Coding Style, so 80.

> +
> +properties:
> +  compatible:
> +    const: bosch,smi240
> +
> +  reg:
> +    maxItems: 1
> +
> +  vdd-supply:
> +    description: provide VDD power to the sensor.
> +
> +  vddio-supply:
> +    description: provide VDD IO power to the sensor.
> +
> +required:
> +  - compatible
> +  - reg
> +
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        spi@0 {

That's not a SPI controller. Your description suggests "imu".

Best regards,
Krzysztof


