Return-Path: <linux-iio+bounces-25694-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C29E8C216A4
	for <lists+linux-iio@lfdr.de>; Thu, 30 Oct 2025 18:15:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8386E403364
	for <lists+linux-iio@lfdr.de>; Thu, 30 Oct 2025 17:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6EB236839A;
	Thu, 30 Oct 2025 17:12:20 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E073678D9;
	Thu, 30 Oct 2025 17:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761844340; cv=none; b=PS1Ecjw7LvT6ec040btvFil/ZE/ked+I2Ho/0sHU1p0oJ35CkSDJQzI9paHqNM+QhIgwFILWpWb1ZnK7Aiir6GQXH3GQMZRgGL4SaTn4yljqiIMPzyJXPXiGb8GgrHt+QzXxw4PtrL9QEtAVIlnMQJruoZU9vY7Q6DTJCkCa4tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761844340; c=relaxed/simple;
	bh=Z4l1+K19PrS87Nnkrl3lJLy1OZ65JYlIiTAuPULHAh8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=klUKM/XNFMtXeKXeU1TIGtog3dVVZnYZXfXQWTctdFsEgKc2HFkog9PvPLmdfEUOHSi91rfY/ocWhvH0oZfY0VvS2hktD636ks1+UMkfm7Gimc2IfQfV+9GaFJLKLCXG/poA5rwO6ahnavzxd+XoAP96uWks8u6zo4oeFUsmHZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4cy9db4MhNzJ46BP;
	Fri, 31 Oct 2025 01:12:03 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 50C0E140275;
	Fri, 31 Oct 2025 01:12:15 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 30 Oct
 2025 17:12:14 +0000
Date: Thu, 30 Oct 2025 17:12:12 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Ajith Anandhan <ajithanandhan0406@gmail.com>
CC: <linux-iio@vger.kernel.org>, <jic23@kernel.org>, <dlechner@baylibre.com>,
	<nuno.sa@analog.com>, <andy@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 1/3] dt-bindings: iio: adc: Add TI ADS1120 binding
Message-ID: <20251030171212.00004069@huawei.com>
In-Reply-To: <20251030163411.236672-2-ajithanandhan0406@gmail.com>
References: <20251030163411.236672-1-ajithanandhan0406@gmail.com>
	<20251030163411.236672-2-ajithanandhan0406@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Thu, 30 Oct 2025 22:04:09 +0530
Ajith Anandhan <ajithanandhan0406@gmail.com> wrote:

> Add device tree binding documentation for the Texas Instruments
> ADS1120.
> 
> The binding defines required properties like compatible, reg, and
> SPI configuration parameters.
> 
> Link: https://www.ti.com/lit/gpn/ads1120
Datasheet: https://www.ti.com/lit/gpn/ads1120

Is a somewhat official tag for these. Though better to put it in the dt-binding
doc itself as well or instead of here.

> Signed-off-by: Ajith Anandhan <ajithanandhan0406@gmail.com>
> ---
>  .../bindings/iio/adc/ti,ads1120.yaml          | 50 +++++++++++++++++++
>  1 file changed, 50 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads1120.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads1120.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads1120.yaml
> new file mode 100644
> index 000000000..09285c981
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/ti,ads1120.yaml
> @@ -0,0 +1,50 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/ti,ads1120.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Texas Instruments ADS1120 4-channel, 16-bit, 2kSPS ADC
> +
> +maintainers:
> +  - Ajith Anandhan <ajithanandhan0406@gmail.com>
> +
> +properties:
> +  compatible:
> +    const: ti,ads1120
> +
> +  reg:
> +    maxItems: 1
> +
> +  spi-max-frequency:
> +    maximum: 4000000
> +
> +  spi-cpha: true
> +
> +  "#io-channel-cells":
> +    const: 1

Power supplies should be here and required (even if real boards
rely on stub regulators). 

Looks like there is an optional reference as well - so include that
but not as required (use internal ref if not supplied).

There is a data ready pin as well so I'd expect an interrupt.

All these should be in the binding from the start as we want it
to be as complete as possible.  The driver doesn't have to use everything
the binding supplies.

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
> +        adc@0 {
> +            compatible = "ti,ads1120";
> +            reg = <0>;
> +            spi-max-frequency = <4000000>;
> +            spi-cpha;
> +        };
> +    };
> +...
> +


