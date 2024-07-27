Return-Path: <linux-iio+bounces-7978-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C01793DFAD
	for <lists+linux-iio@lfdr.de>; Sat, 27 Jul 2024 16:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DA441C20D7E
	for <lists+linux-iio@lfdr.de>; Sat, 27 Jul 2024 14:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04267172793;
	Sat, 27 Jul 2024 14:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="etpzCSRg"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC31B171679;
	Sat, 27 Jul 2024 14:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722089536; cv=none; b=jPuaAQoltopkjhbXKZoU7Kzqx452FmwMGOtdEArCHScjc02lX+TCy3I2iUHYCHV3vXqSvmtpJ8VHtv2EJmGNyuCuzI5xtD2JPy4UBMLC2WPGGyeaKcWxxr8SVhHCyB6YeqvmvNRShHKh8tPaFUsKZC1bNpmb/oy5vTWfFN81X5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722089536; c=relaxed/simple;
	bh=LAXD1eyCD4cqWYJ3DXOC9Ot083musefdyG8yo+EdFpo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L71obKtvVtvlka6nlDODDnsRqvqp+F/w7ufwvRxApFBBdAf+F7fCkFhuNMgrnpzoFoqwXnmNx0C+Inurd/qgnIZbU0olaFAuZI23BqDJ36c9nRjrZpkllu0tq7GqgxO/oBH9Umjm3QSexreZ2Bup+/wrRRfLAbGja36iWsPH//8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=etpzCSRg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28C1CC32781;
	Sat, 27 Jul 2024 14:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722089536;
	bh=LAXD1eyCD4cqWYJ3DXOC9Ot083musefdyG8yo+EdFpo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=etpzCSRg7aPcW+yfWja0iw8A6aN7EeobFXpEzdIRD9yK3NeOeVIw3SznVnU095EVk
	 EeDZOzOjYfXPpm9ODXfoVnAgT5NyVQjaQmEp88cZPEoERUuLfpiFYu1ocMKHHEIex9
	 RVRN96doH+3/uuAoSicRS1V6tYp8iaYgSJbMmmgKbbCPK8CbAlqi7vOFxTrCONx37Q
	 dN1d/3zgZQRtxqji5JJjbp1047ekTZu/tHDWXN2hKKZjtLjIT3CT77SYKNApz2oBSE
	 1AJxKgvh8LWdM/dPZRoOq2FyXbQRjNmXLwHSoG01dli2hqAL5EvyLuosEPrAELbDds
	 oHco60I1RZOdw==
Date: Sat, 27 Jul 2024 15:12:08 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: wangshuaijie@awinic.com
Cc: lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, waqar.hameed@axis.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 liweilei@awinic.com, kangjiajun@awinic.com
Subject: Re: [PATCH V5 1/2] dt-bindings: iio: aw9610x: Add bindings for
 aw9610x sensor
Message-ID: <20240727151208.667a9df7@jic23-huawei>
In-Reply-To: <20240726061312.1371450-2-wangshuaijie@awinic.com>
References: <20240726061312.1371450-1-wangshuaijie@awinic.com>
	<20240726061312.1371450-2-wangshuaijie@awinic.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 26 Jul 2024 06:13:11 +0000
wangshuaijie@awinic.com wrote:

> From: shuaijie wang <wangshuaijie@awinic.com>
> 
> Add device tree bindings for aw9610x proximity sensor.
> 
> Signed-off-by: shuaijie wang <wangshuaijie@awinic.com>
> ---
>  .../iio/proximity/awinic,aw9610x.yaml         | 61 +++++++++++++++++++
>  1 file changed, 61 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/proximity/awinic,aw9610x.yaml

No wild cards in naming of dt-bindings or within the driver.
It goes wrong far too often because manufacturers love to release
new devices that have similar part names but are completely unrelated.

So we just name everything after the first part supported.

One other thing inline.

Jonathan

> 
> diff --git a/Documentation/devicetree/bindings/iio/proximity/awinic,aw9610x.yaml b/Documentation/devicetree/bindings/iio/proximity/awinic,aw9610x.yaml
> new file mode 100644
> index 000000000000..631b1fe5a900
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/proximity/awinic,aw9610x.yaml
> @@ -0,0 +1,61 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/proximity/awinic,aw9610x.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Awinic's AW9610X capacitive proximity sensor

Title is less important for wild cards but even here I'd just name it
after one part + add "and similar" to the end of the title.

title: Awinic's AW96101 capacity proximity sensor and similar

> +
> +maintainers:
> +  - Wang Shuaijie <wangshuaijie@awinic.com>
> +
> +description: |
> +  Awinic's AW9610X proximity sensor.
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
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts

vcc-supply should be required.
Note this is about the binding documenting the need for power vs
an optional powersupply which some devices have.  It is not
related to whether the dts files actually provide that supply
(though good if they do) because the regulator core will happily
provide you with a fake regulator on the assumption that any regulators
we don't know about must be turned on already.

A well written dts will use a fixed regulator to provide more
description to the drivers etc.

Jonathan

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
> +        };
> +    };


