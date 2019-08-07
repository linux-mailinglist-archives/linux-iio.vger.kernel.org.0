Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71AD985142
	for <lists+linux-iio@lfdr.de>; Wed,  7 Aug 2019 18:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730229AbfHGQlv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 7 Aug 2019 12:41:51 -0400
Received: from ns.pmeerw.net ([84.19.176.117]:39136 "EHLO ns.pmeerw.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730010AbfHGQlv (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 7 Aug 2019 12:41:51 -0400
Received: by ns.pmeerw.net (Postfix, from userid 1000)
        id 4996EE0260; Wed,  7 Aug 2019 18:41:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pmeerw.net; s=mail;
        t=1565196110; bh=UpvHWq6DKj02hd6Dz+wN9TDtvpir9uwiPlINm0z3RFM=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=Lez4DDiQ7AMPa+vVPy+KnOWI1fpFvWvhuFwnRMi+0iP5Acx4gUZWZxJT5Jnn9377W
         S8nlMrJFgjIQ5Rfrtv8twDRT4uegDgGVqLl2FUf3f887m0v7Tn2BcYAVrSJQeSHtwP
         MxgsPPYQL2fuKB+bsMXGrzBPB9Naav3pO9ed1DTI=
Received: from localhost (localhost [127.0.0.1])
        by ns.pmeerw.net (Postfix) with ESMTP id 3479CE01A6;
        Wed,  7 Aug 2019 18:41:50 +0200 (CEST)
Date:   Wed, 7 Aug 2019 18:41:50 +0200 (CEST)
From:   Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To:     Beniamin Bia <beniamin.bia@analog.com>
cc:     jic23@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        biabeniamin@outlook.com
Subject: Re: [PATCH v2 4/4] dt-bindings: iio: adc: Add AD7606B ADC
 documentation
In-Reply-To: <20190807133137.11185-4-beniamin.bia@analog.com>
Message-ID: <alpine.DEB.2.21.1908071830110.32509@vps.pmeerw.net>
References: <20190807133137.11185-1-beniamin.bia@analog.com> <20190807133137.11185-4-beniamin.bia@analog.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 7 Aug 2019, Beniamin Bia wrote:

minor comment below

> Documentation for AD7606B Analog to Digital Converter and software
> mode was added.
> 
> Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
> ---
> Changes in v2:
> -nothing changed
> 
>  Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
> index 509dbe9c84d2..2afe31747a70 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
> @@ -13,6 +13,7 @@ maintainers:
>  description: |
>    Analog Devices AD7606 Simultaneous Sampling ADC
>    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7606_7606-6_7606-4.pdf
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/AD7606B.pdf
>    https://www.analog.com/media/en/technical-documentation/data-sheets/AD7616.pdf
>  
>  properties:
> @@ -22,6 +23,7 @@ properties:
>        - adi,ad7606-8
>        - adi,ad7606-6
>        - adi,ad7606-4
> +      - adi,ad7606b
>        - adi,ad7616
>  
>    reg:
> @@ -87,7 +89,7 @@ properties:
>  
>    adi,sw-mode:
>      description:
> -      Software mode of operation, so far available only for ad7616.
> +      Software mode of operation, so far available only for ad7616 and ad7606B.

how about ad7606b to match the properties above?

>        It is enabled when all three oversampling mode pins are connected to
>        high level. The device is configured by the corresponding registers. If the
>        adi,oversampling-ratio-gpios property is defined, then the driver will set the
> 

-- 

Peter Meerwald-Stadler
Mobile: +43 664 24 44 418
