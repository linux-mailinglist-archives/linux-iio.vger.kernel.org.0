Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA0430CE4B
	for <lists+linux-iio@lfdr.de>; Tue,  2 Feb 2021 22:57:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234233AbhBBV5N (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 2 Feb 2021 16:57:13 -0500
Received: from www381.your-server.de ([78.46.137.84]:54146 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234159AbhBBV5I (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 2 Feb 2021 16:57:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=LnQwN2vEqk8UbAPHy4QObNw8+1L9AEfi2v9UkN3eiYM=; b=QcZ7t6B73TJjLZgr7L7AmWmlun
        goGMrOJDi+SEOzKnf/foGdSqnARXIfhbN3Ur45vAUh8hNH6IVEoHpo986Bi7ZsFmDjOVmKlnbzr8l
        QCgFihZbzj77Jy4SA55AuSKT4sShq9d0+N7uUZe7sLisOsMUEzrkUy3L5rfqOhVMGdIcKyjZf56XF
        s1eKkADP2KTegqRIWuWB2Wa5x/Lh0aYEgJ0WPdvCFG104m7fBCMdC/LYd8CAM4HneUClTVEtBp0ws
        ntenPHaztSY0GdBgw0sdQ1mEQSQk4rfNtpq7heOHpstV1SR/OwafjGGqWsvKIFMaom9eUK/sRoJQH
        1Onmkscg==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1l73eo-0008Ek-5d; Tue, 02 Feb 2021 22:56:22 +0100
Received: from [62.216.202.92] (helo=[192.168.178.20])
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1l73eo-000NBx-0A; Tue, 02 Feb 2021 22:56:22 +0100
Subject: Re: [PATCH v2] dt-bindings: iio: dac: Fix AD5686 references
To:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Michael Auchter <michael.auchter@ni.com>,
        linux-iio@vger.kernel.org
References: <20210202215503.114113-1-robh@kernel.org>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <755532c1-2c28-3796-367a-baec09f2dada@metafoo.de>
Date:   Tue, 2 Feb 2021 22:56:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210202215503.114113-1-robh@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.4/26068/Tue Feb  2 13:21:02 2021)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 2/2/21 10:55 PM, Rob Herring wrote:
> The example and filename use 'adi,ad5686', but the schema doesn't
> document it. The AD5686 is also a SPI interface variant while all the
> documented variants have an I2C interface. So let's update all the
> references to AD5686 to AD5696.
>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Michael Hennerich <Michael.Hennerich@analog.com>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
> Cc: Michael Auchter <michael.auchter@ni.com>
> Cc: linux-iio@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>

Acked-by: Lars-Peter Clausen <lars@metafoo.de>

Thanks Rob.

> ---
> v2:
> - Rename instead of adding AD5686
>
>   .../iio/dac/{adi,ad5686.yaml => adi,ad5696.yaml}       | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
>   rename Documentation/devicetree/bindings/iio/dac/{adi,ad5686.yaml => adi,ad5696.yaml} (77%)
>
> diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5686.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5696.yaml
> similarity index 77%
> rename from Documentation/devicetree/bindings/iio/dac/adi,ad5686.yaml
> rename to Documentation/devicetree/bindings/iio/dac/adi,ad5696.yaml
> index 8065228e5df8..56b0cda0f30a 100644
> --- a/Documentation/devicetree/bindings/iio/dac/adi,ad5686.yaml
> +++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5696.yaml
> @@ -1,16 +1,16 @@
>   # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>   %YAML 1.2
>   ---
> -$id: http://devicetree.org/schemas/iio/dac/adi,ad5686.yaml#
> +$id: http://devicetree.org/schemas/iio/dac/adi,ad5696.yaml#
>   $schema: http://devicetree.org/meta-schemas/core.yaml#
>   
> -title: Analog Devices AD5686 and similar multi-channel DACs
> +title: Analog Devices AD5696 and similar multi-channel DACs
>   
>   maintainers:
>     - Michael Auchter <michael.auchter@ni.com>
>   
>   description: |
> -  Binding for Analog Devices AD5686 and similar multi-channel DACs
> +  Binding for Analog Devices AD5696 and similar multi-channel DACs
>   
>   properties:
>     compatible:
> @@ -48,8 +48,8 @@ examples:
>         #address-cells = <1>;
>         #size-cells = <0>;
>   
> -      ad5686: dac@0 {
> -        compatible = "adi,ad5686";
> +      ad5696: dac@0 {
> +        compatible = "adi,ad5696";
>           reg = <0>;
>           vcc-supply = <&dac_vref>;
>         };


