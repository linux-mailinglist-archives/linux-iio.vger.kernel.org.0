Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83E472F4F46
	for <lists+linux-iio@lfdr.de>; Wed, 13 Jan 2021 16:55:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbhAMPyX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 13 Jan 2021 10:54:23 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2336 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbhAMPyX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 13 Jan 2021 10:54:23 -0500
Received: from fraeml702-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DGBgN6WJSz67Q7x;
        Wed, 13 Jan 2021 23:48:32 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml702-chm.china.huawei.com (10.206.15.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Wed, 13 Jan 2021 16:53:41 +0100
Received: from localhost (10.47.78.18) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Wed, 13 Jan
 2021 15:53:40 +0000
Date:   Wed, 13 Jan 2021 15:53:02 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Michael Hennerich" <Michael.Hennerich@analog.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        <devicetree@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 23/24] dt-bindings:iio:adc: update adc.yaml reference
Message-ID: <20210113155302.00005d4a@Huawei.com>
In-Reply-To: <8e37dba8ae9099acd649bab8a1cf718caa4f3e6a.1610535350.git.mchehab+huawei@kernel.org>
References: <cover.1610535349.git.mchehab+huawei@kernel.org>
        <8e37dba8ae9099acd649bab8a1cf718caa4f3e6a.1610535350.git.mchehab+huawei@kernel.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.78.18]
X-ClientProxiedBy: lhreml742-chm.china.huawei.com (10.201.108.192) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 13 Jan 2021 11:59:24 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Changeset b70d154d6558 ("dt-bindings:iio:adc: convert adc.txt to yaml")
> renamed: Documentation/devicetree/bindings/iio/adc/adc.txt
> to: Documentation/devicetree/bindings/iio/adc/adc.yaml.
> 
> Update its cross-reference accordingly.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


> ---
>  Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
> index e0cc3b2e8957..22b7ed3723f6 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
> @@ -80,7 +80,7 @@ properties:
>      type: boolean
>  
>    bipolar:
> -    description: see Documentation/devicetree/bindings/iio/adc/adc.txt
> +    description: see Documentation/devicetree/bindings/iio/adc/adc.yaml
>      type: boolean
>  
>  required:

