Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 515CE3D4CEC
	for <lists+linux-iio@lfdr.de>; Sun, 25 Jul 2021 11:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbhGYIna convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Sun, 25 Jul 2021 04:43:30 -0400
Received: from aposti.net ([89.234.176.197]:44386 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230370AbhGYIn3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 25 Jul 2021 04:43:29 -0400
Date:   Sun, 25 Jul 2021 10:23:50 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v3 5/5] dt-bindings: iio/adc: ingenic: add the JZ4760(B)
 socs to the sadc Documentation
To:     Christophe Branchereau <cbranchereau@gmail.com>
Cc:     jic23@kernel.org, lars@metafoo.de, linux-mips@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org, linux@roeck-us.net,
        contact@artur-rojek.eu
Message-Id: <QFNSWQ.A2MDJFJLHT1F2@crapouillou.net>
In-Reply-To: <20210724190449.221894-6-cbranchereau@gmail.com>
References: <20210724190449.221894-1-cbranchereau@gmail.com>
        <20210724190449.221894-6-cbranchereau@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Christophe,

Le sam., juil. 24 2021 at 21:04:49 +0200, Christophe Branchereau 
<cbranchereau@gmail.com> a écrit :
> Add both the jz4760 and jz4760b, plus a property to use the internal
> divider on the b variant and document it.
> 
> Signed-off-by: Christophe Branchereau <cbranchereau@gmail.com>

Looks good.

Reviewed-by: Paul Cercueil <paul@crapouillou.net>

> ---
>  .../bindings/iio/adc/ingenic,adc.yaml         | 19 
> +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git 
> a/Documentation/devicetree/bindings/iio/adc/ingenic,adc.yaml 
> b/Documentation/devicetree/bindings/iio/adc/ingenic,adc.yaml
> index 433a3fb55a2e..3eb7aa8822c3 100644
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
> @@ -43,6 +45,23 @@ properties:
>    interrupts:
>      maxItems: 1
> 
> +  ingenic,use-internal-divider:
> +    description:
> +      If present, battery voltage is read from the VBAT_IR pin, 
> which has an
> +      internal 1/4 divider. If absent, it is read through the 
> VBAT_ER pin,
> +      which does not have such a divider.
> +    type: boolean
> +
> +if:
> +  not:
> +    properties:
> +      compatible:
> +        contains:
> +          const: ingenic,jz4760b-adc
> +then:
> +  properties:
> +    ingenic,use-internal-divider: false
> +
>  required:
>    - compatible
>    - '#io-channel-cells'
> --
> 2.30.2
> 


