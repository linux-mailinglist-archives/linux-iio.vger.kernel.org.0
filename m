Return-Path: <linux-iio+bounces-8528-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4644795576E
	for <lists+linux-iio@lfdr.de>; Sat, 17 Aug 2024 13:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A5B41C20E81
	for <lists+linux-iio@lfdr.de>; Sat, 17 Aug 2024 11:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6928B148855;
	Sat, 17 Aug 2024 11:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p8CUDtQ6"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1839D1C32;
	Sat, 17 Aug 2024 11:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723894270; cv=none; b=bdB44T9dOP9Z/P+JIBazV+7Ug2y32qxVYj3UyYzEDv9tu9LKBP2wQlFpMBerVC/W9ZyIAxZYV7fUFQ9YMztPTQinrEJTM8b9iJetPtHT51kr4yhK+fDkXN3tVKnr0GqAqrz1DKEYCrwFSS1MqgCWNJ4HG4pIZ3UFouQBb+dD6yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723894270; c=relaxed/simple;
	bh=9W4Gme6cRtTBuHzg8OfLvT8gAuHsq9xsw3bjbF+Womo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ayc662l+eNr198PT4SJzdosm3opmEuy2iJ24Opqjt8yDZ4zvuw9+XyzuEb0IzO1v0lWzJpfSNNIZaR2t2t7UqxZW1rQ2v7fispD/2njYicBwr6GXLek/HeyWysWO4Z/tBAqYRMm64wJkqQA66NV7K5EQPz2DrYXiiC1rpc2g4ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p8CUDtQ6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DFA0C116B1;
	Sat, 17 Aug 2024 11:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723894269;
	bh=9W4Gme6cRtTBuHzg8OfLvT8gAuHsq9xsw3bjbF+Womo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=p8CUDtQ681W4xtaNkTIpmYJZ4CMeaZoZ6RlrZKQeeCGfBZUBcbZfTvJ9VHmj1jOiI
	 +18A/oAONog7tEq0AV8lp8IviHxyIJc+wYG3ZhqSQ+swff6x141Sf88NRfZ+Kl40U9
	 u708dy7LSIKxIVgnbW6c2FDbShmWc1GyPynDNAcH+8uk3oL5HzN2MiuCTGClZ24Ina
	 M1tbx7I+ReeVSaVGvl5P7alPyRwTWeeDaq6VbgS6UQojDykMf8sfFHvi4HqqsNn06p
	 DpX7Lv+UlPoL2gz+a/A7KvneQq4twN10xlFU1dLuSzElhGLrncXEaALyfGLxVjE1/+
	 4eRfKNs5nwlMg==
Date: Sat, 17 Aug 2024 12:30:34 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: wangshuaijie@awinic.com
Cc: lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, kees@kernel.org, gustavoars@kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
 liweilei@awinic.com, kangjiajun@awinic.com, Krzysztof Kozlowski
 <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH V7 1/2] dt-bindings: iio: aw96103: Add bindings for
 aw96103/aw96105 sensor
Message-ID: <20240817123034.30cc300e@jic23-huawei>
In-Reply-To: <20240814031808.2852418-2-wangshuaijie@awinic.com>
References: <20240814031808.2852418-1-wangshuaijie@awinic.com>
	<20240814031808.2852418-2-wangshuaijie@awinic.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 14 Aug 2024 03:18:07 +0000
wangshuaijie@awinic.com wrote:

> From: shuaijie wang <wangshuaijie@awinic.com>
> 
> Add device tree bindings for aw96103/aw96105 proximity sensor.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: shuaijie wang <wangshuaijie@awinic.com>
> ---
>  .../iio/proximity/awinic,aw96103.yaml         | 63 +++++++++++++++++++
>  1 file changed, 63 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/proximity/awinic,aw96103.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/proximity/awinic,aw96103.yaml b/Documentation/devicetree/bindings/iio/proximity/awinic,aw96103.yaml
> new file mode 100644
> index 000000000000..54b5bc176d5c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/proximity/awinic,aw96103.yaml
> @@ -0,0 +1,63 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/proximity/awinic,aw96103.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Awinic's AW96103 capacitive proximity sensor and similar
> +
> +maintainers:
> +  - Wang Shuaijie <wangshuaijie@awinic.com>
> +
> +description: |
> +  Awinic's AW96103/AW96105 proximity sensor.
> +  The specific absorption rate (SAR) is a metric that measures
> +  the degree of absorption of electromagnetic radiation emitted by
> +  wireless devices, such as mobile phones and tablets, by human tissue.
> +  In mobile phone applications, the proximity sensor is primarily
> +  used to detect the proximity of the human body to the phone. When the
> +  phone approaches the human body, it will actively reduce the transmit
> +  power of the antenna to keep the SAR within a safe range. Therefore,
> +  we also refer to the proximity sensor as a SAR sensor.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - awinic,aw96103
> +      - awinic,aw96105
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    description:
> +      Generated by the device to announce that a close/far
> +      proximity event has happened.
> +    maxItems: 1
> +
> +  vcc-supply:
> +    description:
> +      Optional regulator for chip, 1.7V-3.6V.
See comment on v6 which I sent before noticing there was a v7.
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - vcc-supply
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        proximity@12 {
> +            compatible = "awinic,aw96103";
> +            reg = <0x12>;
> +            interrupt-parent = <&gpio>;
> +            interrupts = <23 IRQ_TYPE_EDGE_FALLING>;
> +            vcc-supply = <&pp1800_prox>;
> +        };
> +    };


