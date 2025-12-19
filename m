Return-Path: <linux-iio+bounces-27228-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BFEBCD0F3B
	for <lists+linux-iio@lfdr.de>; Fri, 19 Dec 2025 17:44:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EFA72301A190
	for <lists+linux-iio@lfdr.de>; Fri, 19 Dec 2025 16:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3512833D4EC;
	Fri, 19 Dec 2025 16:40:21 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B71317A2EA;
	Fri, 19 Dec 2025 16:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766162417; cv=none; b=IJcFve5M28fLIRo8yhsrNz5Tg7GKDDHwDhmZqiWZsE5cyrbgG6fVYgrYejt53SyY+5/08dXtPBHA4QlzoMLVwqgNVwi+Yce/enrocOzPUftkr/R24BT00YHtvcxojD8UONcCNE7ujsU56/++jHdxFh/ehri5TF3QJhQ7XJc62Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766162417; c=relaxed/simple;
	bh=Qnt5Ry3F4wGHOQAR8Zm+Q2n2lWPabtn+cXRIdgbU/j4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lsTNk9v13UbKNRd74uySeEYmZ7SFRmZDKAySLihlvDdARuCN4ga229e+qZf37B/Ea5Yj+tZAx8V7Aqd+LR9K18py+U01us4lVuliNWTjVY8Jo5cPdMXt79UU0FaC1Zu+b0iMPdoO4gO8IxfB8Zc9gG+a3yYJZpXEVJ5c+f85JZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dXtY01cMbzJ46Bq;
	Sat, 20 Dec 2025 00:39:32 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 1BC9B40570;
	Sat, 20 Dec 2025 00:40:05 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Fri, 19 Dec
 2025 16:40:04 +0000
Date: Fri, 19 Dec 2025 16:40:02 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Janani Sunil <janani.sunil@analog.com>
CC: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
	<Michael.Hennerich@analog.com>, Alexandru Ardelean
	<alexandru.ardelean@analog.com>, Jonathan Cameron <jic23@kernel.org>, "Rob
 Herring" <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: iio: dac: Add max22007
Message-ID: <20251219164002.00004c74@huawei.com>
In-Reply-To: <20251219-max22007-dev-v1-1-242da2c2b868@analog.com>
References: <20251219-max22007-dev-v1-0-242da2c2b868@analog.com>
	<20251219-max22007-dev-v1-1-242da2c2b868@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500012.china.huawei.com (7.191.174.4) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Fri, 19 Dec 2025 16:31:15 +0100
Janani Sunil <janani.sunil@analog.com> wrote:

Hi Janani and welcome to IIO.


> Devicetree bindings for MAX22007 4-channel
> 12-bit DAC that drives a voltage or current
> output on each channel

This is a very short wrap. Aim for 75 characters in patch description lines
(so slightly shorter than 80 chars standard for everything else).

> 
> Signed-off-by: Janani Sunil <janani.sunil@analog.com>

> ---
>  .../devicetree/bindings/iio/dac/adi,max22007.yaml  | 116 +++++++++++++++++++++
>  MAINTAINERS                                        |   7 ++
>  2 files changed, 123 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/dac/adi,max22007.yaml b/Documentation/devicetree/bindings/iio/dac/adi,max22007.yaml
> new file mode 100644
> index 000000000000..c2f65d9e42d4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/dac/adi,max22007.yaml

...

> +  vdd-supply:
> +    description: Low-Voltage Power Supply from +2.7V to +5.5V.
> +
> +  hvdd-supply:
> +    description:
> +      Positive High-Voltage Power Supply from +8V to (HVSS +24V) for
> +      the Output Channels.
> +
> +  hvss-supply:
> +    description:
> +      Negative High-Voltage Power Supply from -2V to 0V for the Output Channels.
> +
> +  reset-gpios:
> +    maxItems: 1
> +    description:
> +      GPIO used for hardware reset of the device.
> +
> +patternProperties:
> +  "^channel@[0-3]$":
> +    allOf:
> +      - $ref: /schemas/iio/dac/dac.yaml#
> +      - type: object
> +        description:
> +          Represents the external channels which are connected to the DAC.
> +          Channels not specified in the device tree will be powered off.
> +
> +        properties:
> +          reg:
> +            description: Channel number
> +            maxItems: 1

min / max?

> +
> +          adi,type:
> +            description: Channel output type.
> +            $ref: /schemas/types.yaml#/definitions/string
> +            enum: [voltage, current]
This is much more constrained (as only two types of channel) but we do have
precedence for adi,ch-func in adi,ad74115.yaml and adi,ad74413r.yaml

That's not a particularly pretty binding but we should probably stick to
it anyway.

adi,type is too vague a name for this property anyway.

> +
> +        required:
> +          - reg
> +          - adi,type
> +
> +        unevaluatedProperties: false
> +
> +required:
> +  - compatible

For supplies we document as required any that are needed for the device
to function, whether or not we happen to need to specify them on
a given board (given fallbacks that apply on assumption that fixes
always on supplies are in use).  So I'd expect to see at least some
of the supplies listed here.

> +  - reg
> +
> +anyOf:
> +  - required: [channel@0]
> +  - required: [channel@1]
> +  - required: [channel@2]
> +  - required: [channel@3]

Interesting. I'm not sure we have never bothered to document this before and there
are other devices for which some sort of channel config is pretty much needed.
What is the justification to have this explicitly listed here?

> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        dac@0 {
> +            compatible = "adi,max22007";
> +            reg = <0>;
> +            spi-max-frequency = <500000>;
> +            reset-gpios = <&gpio 19 GPIO_ACTIVE_LOW>;
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            channel@0 {
> +                reg = <0>;
> +                adi,type = "voltage";
> +            };
> +
> +            channel@1 {
> +                reg = <1>;
> +                adi,type = "current";
> +            };
> +        };
> +    };
> +...


