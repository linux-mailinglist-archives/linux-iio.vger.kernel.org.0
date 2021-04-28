Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA7DC36DDC0
	for <lists+linux-iio@lfdr.de>; Wed, 28 Apr 2021 19:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241423AbhD1RBw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 28 Apr 2021 13:01:52 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2947 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241235AbhD1RBw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 28 Apr 2021 13:01:52 -0400
Received: from fraeml702-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FVl7g1YR8z6xhS0;
        Thu, 29 Apr 2021 00:53:19 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml702-chm.china.huawei.com (10.206.15.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Wed, 28 Apr 2021 19:01:05 +0200
Received: from localhost (10.52.123.69) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Wed, 28 Apr
 2021 18:01:05 +0100
Date:   Wed, 28 Apr 2021 17:59:31 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
CC:     Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Pengutronix Kernel Team" <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>,
        "Robin van der Gracht" <robin@protonic.nl>,
        <linux-iio@vger.kernel.org>,
        "Lars-Peter Clausen" <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v6 1/3] dt-bindings:iio:adc: add generic
 settling-time-us and oversampling-ratio channel properties
Message-ID: <20210428175931.00002a7e@Huawei.com>
In-Reply-To: <20210428073208.19570-2-o.rempel@pengutronix.de>
References: <20210428073208.19570-1-o.rempel@pengutronix.de>
        <20210428073208.19570-2-o.rempel@pengutronix.de>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.123.69]
X-ClientProxiedBy: lhreml751-chm.china.huawei.com (10.201.108.201) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 28 Apr 2021 09:32:06 +0200
Oleksij Rempel <o.rempel@pengutronix.de> wrote:

> Settling time and over sampling is a typical challenge for different IIO ADC
> devices. So, introduce channel specific settling-time-us and oversampling-ratio
> properties to cover this use case.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
This and patch 2 both look good to me.  Given Rob gave a minor comment on the
previous version I don't feel I need him to look at this again.

Will pick up in a few days if no other reviews come in to require a v7.

Thanks,

Jonathan

> ---
>  Documentation/devicetree/bindings/iio/adc/adc.yaml | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adc.yaml b/Documentation/devicetree/bindings/iio/adc/adc.yaml
> index 912a7635edc4..db348fcbb52c 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adc.yaml
> @@ -39,4 +39,16 @@ properties:
>        The first value specifies the positive input pin, the second
>        specifies the negative input pin.
>  
> +  settling-time-us:
> +    description:
> +      Time between enabling the channel and first stable readings.
> +
> +  oversampling-ratio:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Oversampling is used as replacement of or addition to the low-pass filter.
> +      In some cases, the desired filtering characteristics are a function the
> +      device design and can interact with other characteristics such as
> +      settling time.
> +
>  additionalProperties: true

