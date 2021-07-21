Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE073D16FA
	for <lists+linux-iio@lfdr.de>; Wed, 21 Jul 2021 21:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232971AbhGUShT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Wed, 21 Jul 2021 14:37:19 -0400
Received: from aposti.net ([89.234.176.197]:51626 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232419AbhGUShT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 21 Jul 2021 14:37:19 -0400
Date:   Wed, 21 Jul 2021 20:17:45 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 6/6] dt-bindings: iio/adc: ingenic: add the JZ4760(B) socs
 to the sadc Documentation
To:     citral23 <cbranchereau@gmail.com>
Cc:     jic23@kernel.org, lars@metafoo.de, linux-mips@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org, linux@roeck-us.net,
        contact@artur-rojek.eu
Message-Id: <L90MWQ.K24XQ4Q0L9XN@crapouillou.net>
In-Reply-To: <20210721105317.36742-7-cbranchereau@gmail.com>
References: <20210721105317.36742-1-cbranchereau@gmail.com>
        <20210721105317.36742-7-cbranchereau@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Christophe,

Please always add a short description in your patches, even if all you 
do is repeat the patch title.


Le mer., juil. 21 2021 at 12:53:17 +0200, citral23 
<cbranchereau@gmail.com> a écrit :
> Signed-off-by: citral23 <cbranchereau@gmail.com>
> ---
>  .../devicetree/bindings/iio/adc/ingenic,adc.yaml         | 9 
> +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git 
> a/Documentation/devicetree/bindings/iio/adc/ingenic,adc.yaml 
> b/Documentation/devicetree/bindings/iio/adc/ingenic,adc.yaml
> index 433a3fb55a2e..1b423adba61d 100644
> --- a/Documentation/devicetree/bindings/iio/adc/ingenic,adc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/ingenic,adc.yaml
> @@ -23,6 +23,8 @@ properties:
>      enum:
>        - ingenic,jz4725b-adc
>        - ingenic,jz4740-adc
> +      - ingenic,jz4760-adc
> +      - ingenic,jz4760b-adc
>        - ingenic,jz4770-adc
> 
>    '#io-channel-cells':
> @@ -43,6 +45,12 @@ properties:
>    interrupts:
>      maxItems: 1
> 
> +  ingenic,use-internal-divider:
> +    description:
> +      This property can be used to set VBAT_SEL in the JZ4760B CFG 
> register
> +      to sample the battery voltage from the internal divider. If 
> absent, it
> +      will sample the external divider.

Please remove trailing spaces. And you don't need to describe internal 
behaviour; you only need to explain the functionality in a user-facing 
perspective. Something like:

"If present, battery voltage is read from the VBAT_IR pin, which has an 
internal /4 divider. If absent, it is read through the VBAT_ER pin, 
which does not have such divider."

You also don't specify the type of the property, please add "type: 
boolean" before the description.

There should also be a way to make sure that this property can only be 
used with the JZ4760B SoC. So a dependency for this vendor property on 
the "ingenic,jz4760b-adc" compatible string. But I'm honestly not sure 
how to express that... Maybe Rob can help.

> +
>  required:
>    - compatible
>    - '#io-channel-cells'
> @@ -53,6 +61,7 @@ required:
> 
>  additionalProperties: false
> 
> +

Remove the extra newline.

Cheers,
-Paul

>  examples:
>    - |
>      #include <dt-bindings/clock/jz4740-cgu.h>
> --
> 2.30.2
> 


