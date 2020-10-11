Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3BD128A877
	for <lists+linux-iio@lfdr.de>; Sun, 11 Oct 2020 19:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729634AbgJKRNl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 11 Oct 2020 13:13:41 -0400
Received: from www381.your-server.de ([78.46.137.84]:52260 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728007AbgJKRNk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 11 Oct 2020 13:13:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=qlR3r+LNLfsbtABC9qXeG5gL+SYDTdgxpe/QIZDQnfk=; b=YJebdtrrjxAUX5hnasrOQm135b
        gghhAKkqtn4h3Cj6gjtapX0gS9AfqaTtrYo5TGIfRIj1km79yEwLDr5HxmxEQfPYd/omUQoSxzYRs
        TjuGg/bttqrBS3+Sfj/Z8X3V/Hx8a1xztOhcvgIRf/26GGPWB4Xibnj/ohN4+9ZP6dGTuyTTQO8iQ
        N7YJWe+7ItckXgAOH8T5Tb8yUUFdDo30Sv2PpjS7ZROLbAZN7c+UGRms/p7occLpN4ZVfw8JF2Y3q
        NuM1pqdO5rZVBv8yhOxuCPTtAExew8c3b4t1wvTqpKhqmuHE5XRXq4HU+By7RYU0Dw14mc3/CjuHb
        0JUUwnpg==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1kReua-0002jd-FT; Sun, 11 Oct 2020 19:13:32 +0200
Received: from [2001:a61:2478:ca01:9e5c:8eff:fe01:8578]
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1kReua-000IrQ-Ak; Sun, 11 Oct 2020 19:13:32 +0200
Subject: Re: [PATCH 17/29] dt-bindings:iio:dac:adi,ad7303 yaml conversion
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20201011170749.243680-1-jic23@kernel.org>
 <20201011170749.243680-18-jic23@kernel.org>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <04fb4d49-1a7f-e8d7-09a8-bb57630b6a16@metafoo.de>
Date:   Sun, 11 Oct 2020 19:13:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201011170749.243680-18-jic23@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.4/25954/Sun Oct 11 15:58:33 2020)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 10/11/20 7:07 PM, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Converted to maintain the requirement for Vdd-supply as per original file.
> It is possible we could relax this requirement to make it at least one
> of Vdd-supply and REF-supply.  We need to establish the scaling of the
> output channel and if REF-supply is provided that is used instead of
> Vdd-supply, hence I cannot see why a dummy regulator cannot be used for
> Vdd-supply if this happens.
>
> For now, let us keep it simple.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> ---
>   .../devicetree/bindings/iio/dac/ad7303.txt    | 23 ---------
>   .../bindings/iio/dac/adi,ad7303.yaml          | 51 +++++++++++++++++++
>   2 files changed, 51 insertions(+), 23 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/iio/dac/ad7303.txt b/Documentation/devicetree/bindings/iio/dac/ad7303.txt
> deleted file mode 100644
> index 914610f0556e..000000000000
> --- a/Documentation/devicetree/bindings/iio/dac/ad7303.txt
> +++ /dev/null
> @@ -1,23 +0,0 @@
> -Analog Devices AD7303 DAC device driver
> -
> -Required properties:
> -	- compatible: Must be "adi,ad7303"
> -	- reg: SPI chip select number for the device
> -	- spi-max-frequency: Max SPI frequency to use (< 30000000)
> -	- Vdd-supply: Phandle to the Vdd power supply
> -
> -Optional properties:
> -	- REF-supply: Phandle to the external reference voltage supply. This should
> -	  only be set if there is an external reference voltage connected to the REF
> -	  pin. If the property is not set Vdd/2 is used as the reference voltage.
> -
> -Example:
> -
> -		ad7303@4 {
> -			compatible = "adi,ad7303";
> -			reg = <4>;
> -			spi-max-frequency = <10000000>;
> -			Vdd-supply = <&vdd_supply>;
> -			adi,use-external-reference;
> -			REF-supply = <&vref_supply>;
> -		};
> diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad7303.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad7303.yaml
> new file mode 100644
> index 000000000000..f76c31bf6ee3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/dac/adi,ad7303.yaml
> @@ -0,0 +1,51 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/dac/adi,ad7303.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices AD7303 DAC
> +
> +maintainers:
> +  - Lars-Peter Clausen <lars@metafoo.de>
> +
> +properties:
> +  compatible:
> +    const: adi,ad7303
> +
> +  reg:
> +    maxItems: 1
> +
> +  Vdd-supply:
> +    description:
> +      Used to calculate output channel scalling if REF-supply not specified.
> +  REF-supply:
> +    description:
> +      If not provided, Vdd/2 is used as the reference voltage.
> +
> +  spi-max-frequency:
> +    maximum: 30000000
> +
> +required:
> +  - compatible
> +  - reg
> +  - Vdd-supply
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        dac@4 {
> +            compatible = "adi,ad7303";
> +            reg = <4>;
> +            spi-max-frequency = <10000000>;
> +            Vdd-supply = <&vdd_supply>;
> +            adi,use-external-reference;
This is a bug in the original example. But might as well take this as 
chance to remove the 'adi,use-external-reference' here, since that 
property does not exist.
> +            REF-supply = <&vref_supply>;
> +        };
> +    };
> +...


