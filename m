Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1392A3D3C04
	for <lists+linux-iio@lfdr.de>; Fri, 23 Jul 2021 16:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235450AbhGWOLi convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Fri, 23 Jul 2021 10:11:38 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3466 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235351AbhGWOLh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 23 Jul 2021 10:11:37 -0400
Received: from fraeml702-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GWX9n6026z6G9Fh;
        Fri, 23 Jul 2021 22:43:09 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml702-chm.china.huawei.com (10.206.15.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 23 Jul 2021 16:52:06 +0200
Received: from localhost (10.210.170.238) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2176.2; Fri, 23 Jul
 2021 15:52:05 +0100
Date:   Fri, 23 Jul 2021 15:51:41 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Billy Tsai <billy_tsai@aspeedtech.com>
CC:     <jic23@kernel.org>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <robh+dt@kernel.org>, <joel@jms.id.au>, <andrew@aj.id.au>,
        <p.zabel@pengutronix.de>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <BMC-SW@aspeedtech.com>
Subject: Re: [v2 2/8] dt-bindings: iio: adc: Binding ast2600 adc.
Message-ID: <20210723155141.000039ee@Huawei.com>
In-Reply-To: <20210723081621.29477-3-billy_tsai@aspeedtech.com>
References: <20210723081621.29477-1-billy_tsai@aspeedtech.com>
        <20210723081621.29477-3-billy_tsai@aspeedtech.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.210.170.238]
X-ClientProxiedBy: lhreml704-chm.china.huawei.com (10.201.108.53) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 23 Jul 2021 16:16:15 +0800
Billy Tsai <billy_tsai@aspeedtech.com> wrote:

> This patch add more description about aspeed adc and add two property
> for ast2600:
> - vref: used to configure reference voltage.
> - battery-sensing: used to enable battery sensing mode for last channel.
> 
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>

Hi Billy,

A few comments inline.

Thanks,

Jonathan

> ---
>  .../bindings/iio/adc/aspeed,adc.yaml          | 28 +++++++++++++++++--
>  1 file changed, 26 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/aspeed,adc.yaml b/Documentation/devicetree/bindings/iio/adc/aspeed,adc.yaml
> index 23f3da1ffca3..a562a7fbc30c 100644
> --- a/Documentation/devicetree/bindings/iio/adc/aspeed,adc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/aspeed,adc.yaml
> @@ -10,14 +10,26 @@ maintainers:
>    - Joel Stanley <joel@jms.id.au>
>  
>  description:

I think you need a | after description if you want the formatting to be
maintained (otherwise it will undo the line breaks).

> -  This device is a 10-bit converter for 16 voltage channels.  All inputs are
> -  single ended.
> +  • 10-bits resolution for 16 voltage channels.
> +  At ast2400/ast2500 the device has only one engine with 16 voltage channels.
> +  At ast2600 the device split into two individual engine and each contains 8 voltage channels.

Please wrap lines at 80 chars unless it badly hurts readability.
engines

> +  • Channel scanning can be non-continuous.
> +  • Programmable ADC clock frequency.
> +  • Programmable upper and lower bound for each channels.

I would use threshold rather than bound.   A bound restricts the
value, and I think this is measuring it?

> +  • Interrupt when larger or less than bounds for each channels.
> +  • Support hysteresis for each channels.
> +  • Buildin a compensating method.

Built-in 

> +  Additional feature at ast2600

of ast2600

> +  • Internal or External reference voltage.
> +  • Support 2 Internal reference voltage 1.2v or 2.5v.
> +  • Integrate dividing circuit for battery sensing.
>  
>  properties:
>    compatible:
>      enum:
>        - aspeed,ast2400-adc
>        - aspeed,ast2500-adc
> +      - aspeed,ast2600-adc
>  
>    reg:
>      maxItems: 1
> @@ -33,6 +45,18 @@ properties:
>    "#io-channel-cells":
>      const: 1
>  
> +  vref:
> +    minItems: 900
> +    maxItems: 2700
> +    default: 2500
> +    description:
> +      ADC Reference voltage in millivolts.

I'm not clear from this description.  Is this describing an externally
connected voltage reference?  If so it needs to be done as a regulator.
If it's a classic high precision reference, the dts can just use
a fixed regulator.

> +
> +  battery-sensing:
> +    type: boolean
> +    description:
> +      Inform the driver that last channel will be used to sensor battery.

This isn't (I think?) a standard dt binding, so it needs a manufacturer
prefix.

aspeed,battery-sensing

> +
>  required:
>    - compatible
>    - reg

