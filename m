Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D25CA9C514
	for <lists+linux-iio@lfdr.de>; Sun, 25 Aug 2019 19:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728626AbfHYR07 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 25 Aug 2019 13:26:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:42640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728545AbfHYR07 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 25 Aug 2019 13:26:59 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02DF020870;
        Sun, 25 Aug 2019 17:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566754019;
        bh=t0oYoHkLFxsJMeHaRVYelYoALV01M51eu+Ro+0Kcrt4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=zxppyvSOXkK/QctqTXFFYk2BuQo9SXCgKos6+/KQkgGtJ97yDc5kXshdP0L6yysfa
         RY0Len6mxRTU02ENHYBVxoD2yTL0PKgpUNNMSJfrpSizHVkGxiyZRwJU6upjbcDlWC
         L184Qo5n0DTRSqy6RITnH36sdc0Xb9GRRTH5pRIE=
Date:   Sun, 25 Aug 2019 18:26:53 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Beniamin Bia <beniamin.bia@analog.com>
Cc:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <linux-iio@vger.kernel.org>,
        <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>,
        <mark.rutland@arm.com>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <paulmck@linux.ibm.com>,
        <mchehab+samsung@kernel.org>, <linus.walleij@linaro.org>,
        <nicolas.ferre@microchip.com>, <biabeniamin@outlook.com>
Subject: Re: [PATCH v3 4/4] dt-bindings: iio: adc: Add AD7606B ADC
 documentation
Message-ID: <20190825182653.25a685d4@archlinux>
In-Reply-To: <20190821141656.4815-4-beniamin.bia@analog.com>
References: <20190821141656.4815-1-beniamin.bia@analog.com>
        <20190821141656.4815-4-beniamin.bia@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 21 Aug 2019 17:16:56 +0300
Beniamin Bia <beniamin.bia@analog.com> wrote:

> Documentation for AD7606B Analog to Digital Converter and software
> mode was added.
> 
> Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
Tweaked as per Peter's comment and added Rob's Reviewed-by from v2
Seems everyone decided to review this one just as you were posting
the new version ;)

Jonathan

> ---
> Changes in v3:
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
>        It is enabled when all three oversampling mode pins are connected to
>        high level. The device is configured by the corresponding registers. If the
>        adi,oversampling-ratio-gpios property is defined, then the driver will set the

