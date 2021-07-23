Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC6553D3D5E
	for <lists+linux-iio@lfdr.de>; Fri, 23 Jul 2021 18:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbhGWPgu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 23 Jul 2021 11:36:50 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3476 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbhGWPgt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 23 Jul 2021 11:36:49 -0400
Received: from fraeml707-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GWZ141rb2z6H7qR;
        Sat, 24 Jul 2021 00:05:44 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml707-chm.china.huawei.com (10.206.15.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 23 Jul 2021 18:17:21 +0200
Received: from localhost (10.210.170.238) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2176.2; Fri, 23 Jul
 2021 17:17:20 +0100
Date:   Fri, 23 Jul 2021 17:16:57 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Christophe Branchereau <cbranchereau@gmail.com>
CC:     <paul@crapouillou.net>, <jic23@kernel.org>, <lars@metafoo.de>,
        <linux-mips@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <linux@roeck-us.net>,
        <contact@artur-rojek.eu>
Subject: Re: [PATCH V2 5/5] dt-bindings: iio/adc: ingenic: add the JZ4760(B)
 socs to the sadc Documentation
Message-ID: <20210723171657.00003d7f@Huawei.com>
In-Reply-To: <20210723085813.1523934-6-cbranchereau@gmail.com>
References: <893d6165-0f12-d0da-44be-449a4ae96ac2@roeck-us.net>
        <20210723085813.1523934-1-cbranchereau@gmail.com>
        <20210723085813.1523934-6-cbranchereau@gmail.com>
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

On Fri, 23 Jul 2021 10:58:13 +0200
Christophe Branchereau <cbranchereau@gmail.com> wrote:

> The jz4760b variant differs slightly from the jz4760, add a property to 
> let users sample the internal divider if needed and document it.
> 
> Signed-off-by: Christophe Branchereau <cbranchereau@gmail.com>
> ---
>  .../devicetree/bindings/iio/adc/ingenic,adc.yaml         | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/ingenic,adc.yaml b/Documentation/devicetree/bindings/iio/adc/ingenic,adc.yaml
> index 433a3fb55a2e..0dc42959a64f 100644
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
> @@ -43,6 +45,13 @@ properties:
>    interrupts:
>      maxItems: 1
>  
> +  ingenic,use-internal-divider:
> +    description:
> +      This property can be used to set VBAT_SEL in the JZ4760B CFG register
> +      to sample the battery voltage from the internal divider. If absent, it
> +      will sample the external divider.
> +    type: boolean
> +
See reply to the v1 patch for hint on how to 'enforce' that this
only exists for the jz4760b

Thanks,

Jonathan

>  required:
>    - compatible
>    - '#io-channel-cells'

