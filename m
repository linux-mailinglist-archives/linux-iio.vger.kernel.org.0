Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0746D28A8EE
	for <lists+linux-iio@lfdr.de>; Sun, 11 Oct 2020 20:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730501AbgJKR7w (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 11 Oct 2020 13:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730535AbgJKR7f (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 11 Oct 2020 13:59:35 -0400
X-Greylist: delayed 402 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 11 Oct 2020 10:59:34 PDT
Received: from mail.cosmopool.net (mail.cosmopool.net [IPv6:2a01:4f8:160:20c1::10:107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E8E3FC0613CE
        for <linux-iio@vger.kernel.org>; Sun, 11 Oct 2020 10:59:34 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.cosmopool.net (Postfix) with ESMTP id 27E3C9016EA;
        Sun, 11 Oct 2020 19:52:50 +0200 (CEST)
Received: from mail.cosmopool.net ([127.0.0.1])
        by localhost (mail.b.radempa.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 8CPmQe0rhlN1; Sun, 11 Oct 2020 19:52:49 +0200 (CEST)
Received: from webmail.cosmopool.net (localhost [127.0.0.1])
        by mail.cosmopool.net (Postfix) with ESMTPSA id 5133F9010FE;
        Sun, 11 Oct 2020 19:52:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ccbib.org; s=201902;
        t=1602438768; bh=FWKz+mE9rrMDvHOxI6eky87hSZMwTo9XVbTTvMuRbXs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FUbVN9vFb9Lrd6eAC75wQnw4vRR+3t+trz0HR1dUBgGCXfnZL3uUvgHUAN7Xo/UXj
         M0BXUNItSEtvEWDNg2C1ESYpYFEizxtqa1CL7wzr/aVWNSOzZqJWbRT5h2piiZi2uz
         QViCHlSzeWHc4ubzghJbS5KGAr3stw4P1AziKkOQ=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Sun, 11 Oct 2020 18:52:48 +0100
From:   Harald Geyer <harald@ccbib.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     <linux-iio@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: Re: [PATCH 04/29] dt-bindings:iio:humidity:dht11 yaml conversion
In-Reply-To: <20201011170749.243680-5-jic23@kernel.org>
References: <20201011170749.243680-1-jic23@kernel.org>
 <20201011170749.243680-5-jic23@kernel.org>
Message-ID: <20e7bc0e3f7e55587e431ad97dcca4b5@ccbib.org>
X-Sender: harald@ccbib.org
User-Agent: RoundCube Webmail/0.7.2
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 11.10.2020 18:07, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> The conversion is straight forward, but leaves an open question.
> The compatible for this device has never had a vendor. I suspect
> this because it is non-obvious who actually makes the module. It is
> resold by numerous vendors and it may be that there is no single 
> vendor
> of the parts they are using.  If anyone has any more info on the
> vendor, please let me know and we can add a more informative
> compatible.

I think these parts come from Aosong: http://www.aosong.com/en/

The DHT11 uses a custom protocol, so I don't think other vendors
would be using this. Even Aosong started using i2c by now.

On the other hand DHT11 seems to be more of a trade name then a
part identifier. The latter probably would be something like
aosong,am2302 (trade name DHT22).

However the matching between identifiers and trade names is
confusing for the older products. I'm not sure if it is worth
digging into this. Probably only the people at aosong could
clear this up.

Anyway, you have my:
Acked-By: Harald Geyer <harald@ccbib.org>

Thanks,
Harald

> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Harald Geyer <harald@ccbib.org>
> ---
>  .../bindings/iio/humidity/dht11.txt           | 14 -------
>  .../bindings/iio/humidity/dht11.yaml          | 41 
> +++++++++++++++++++
>  2 files changed, 41 insertions(+), 14 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/iio/humidity/dht11.txt
> b/Documentation/devicetree/bindings/iio/humidity/dht11.txt
> deleted file mode 100644
> index ecc24c199fd6..000000000000
> --- a/Documentation/devicetree/bindings/iio/humidity/dht11.txt
> +++ /dev/null
> @@ -1,14 +0,0 @@
> -* DHT11 humidity/temperature sensor (and compatibles like DHT22)
> -
> -Required properties:
> -  - compatible: Should be "dht11"
> -  - gpios: Should specify the GPIO connected to the sensor's data
> -    line, see "gpios property" in
> -    Documentation/devicetree/bindings/gpio/gpio.txt.
> -
> -Example:
> -
> -humidity_sensor {
> -	compatible = "dht11";
> -	gpios = <&gpio0 6 0>;
> -}
> diff --git
> a/Documentation/devicetree/bindings/iio/humidity/dht11.yaml
> b/Documentation/devicetree/bindings/iio/humidity/dht11.yaml
> new file mode 100644
> index 000000000000..38ec4c302760
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/humidity/dht11.yaml
> @@ -0,0 +1,41 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/humidity/dht11.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: DHT11 humidity + temperature sensor
> +
> +maintainers:
> +  - Harald Geyer <harald@ccbib.org>
> +
> +description: |
> +   A simple and low cost module providing a non standard single GPIO 
> based
> +   interface.  Whilst commonly available it is not easy to establish
> if there
> +   is a single manufacturer for this part.
> +
> +properties:
> +  compatible:
> +    const: dht11
> +
> +  reg:
> +    maxItems: 1
> +
> +  gpios:
> +    maxItems: 1
> +    description:
> +      Single, interrupt capable, GPIO used to communicate with the 
> device.
> +
> +required:
> +  - compatible
> +  - gpios
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    humidity_sensor {
> +        compatible = "dht11";
> +        gpios = <&gpio0 6 0>;
> +    };
> +...

-- 
Es gibt viele Maßnahmen gegen die Klimakrise, die leicht und ohne
Verlierer umsetzbar sind. Das Problem ist immer noch das Desinteresse
der etablierten Parteien.
https://haraldgeyer.at/Klimaschutz.html

