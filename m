Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7443D3BF4
	for <lists+linux-iio@lfdr.de>; Fri, 23 Jul 2021 16:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235310AbhGWOEw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 23 Jul 2021 10:04:52 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3465 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233746AbhGWOEw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 23 Jul 2021 10:04:52 -0400
Received: from fraeml705-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GWWyy2v0dz6H7LH;
        Fri, 23 Jul 2021 22:33:46 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml705-chm.china.huawei.com (10.206.15.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 23 Jul 2021 16:45:23 +0200
Received: from localhost (10.210.170.238) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2176.2; Fri, 23 Jul
 2021 15:45:22 +0100
Date:   Fri, 23 Jul 2021 15:44:56 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Billy Tsai <billy_tsai@aspeedtech.com>
CC:     <jic23@kernel.org>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <robh+dt@kernel.org>, <joel@jms.id.au>, <andrew@aj.id.au>,
        <p.zabel@pengutronix.de>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <BMC-SW@aspeedtech.com>
Subject: Re: [v2 1/8] dt-bindings: iio: adc: rename the aspeed adc yaml
Message-ID: <20210723154456.00006744@Huawei.com>
In-Reply-To: <20210723081621.29477-2-billy_tsai@aspeedtech.com>
References: <20210723081621.29477-1-billy_tsai@aspeedtech.com>
        <20210723081621.29477-2-billy_tsai@aspeedtech.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.170.238]
X-ClientProxiedBy: lhreml704-chm.china.huawei.com (10.201.108.53) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 23 Jul 2021 16:16:14 +0800
Billy Tsai <billy_tsai@aspeedtech.com> wrote:

> The aspeed,ast2400-adc.yaml not only descriptor the bindings of ast2400.
> Rename it to aspeed,adc.yaml for all of the aspeed adc bindings.
> 
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>

We try to avoid 'wild' card type namings most of the time and instead
name after a particular part number.  I say try because clearly
we let a few in over the years :(

It is very hard to know if this binding will apply to 'all' future
aspeed ADCs.

As such I'm not sure this particular rename makes sense.

Thanks,

Jonathan

> ---
>  .../iio/adc/{aspeed,ast2400-adc.yaml => aspeed,adc.yaml}        | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>  rename Documentation/devicetree/bindings/iio/adc/{aspeed,ast2400-adc.yaml => aspeed,adc.yaml} (93%)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/aspeed,ast2400-adc.yaml b/Documentation/devicetree/bindings/iio/adc/aspeed,adc.yaml
> similarity index 93%
> rename from Documentation/devicetree/bindings/iio/adc/aspeed,ast2400-adc.yaml
> rename to Documentation/devicetree/bindings/iio/adc/aspeed,adc.yaml
> index 7f534a933e92..23f3da1ffca3 100644
> --- a/Documentation/devicetree/bindings/iio/adc/aspeed,ast2400-adc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/aspeed,adc.yaml
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>  %YAML 1.2
>  ---
> -$id: http://devicetree.org/schemas/iio/adc/aspeed,ast2400-adc.yaml#
> +$id: http://devicetree.org/schemas/iio/adc/aspeed,adc.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>  
>  title: ADC that forms part of an ASPEED server management processor.

