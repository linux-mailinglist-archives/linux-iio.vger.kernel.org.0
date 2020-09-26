Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28C72279A41
	for <lists+linux-iio@lfdr.de>; Sat, 26 Sep 2020 17:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729371AbgIZPDQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 26 Sep 2020 11:03:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:45422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726239AbgIZPDQ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 26 Sep 2020 11:03:16 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE1A3208FE;
        Sat, 26 Sep 2020 15:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601132595;
        bh=1rNkL38ShwqE3McrNo7YbU6G6prrSO22LA5HWhi+zYc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IEcDV7gAONwvjUJ4WuEF7ztlvcuyrCHrODvdOrA9J7XC3YeS4KI4ubafFXM3xFfN7
         LIg3VEYxNqeje/JbfrGsrq5MetEJWIiHQo9e/fkkydAaM4ACvbrtOYpY6jwGTHtWfo
         NTwySVoJXmvjorhH4P8S261niLTi2tEo8tdT64Og=
Date:   Sat, 26 Sep 2020 16:03:11 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <Michael.Hennerich@analog.com>
Subject: Re: [PATCH v3 4/4] dt-bindings: iio: ad9467: add entries for for
 AD9434 & AD9265 ADCs
Message-ID: <20200926160311.1c9a0444@archlinux>
In-Reply-To: <20200924080518.96410-5-alexandru.ardelean@analog.com>
References: <20200924080518.96410-1-alexandru.ardelean@analog.com>
        <20200924080518.96410-5-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 24 Sep 2020 11:05:18 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> Add entries for the AD9434 & AD9265 high-speed ADCs which are supported by
> the 'ad9467' driver.
> Better describe the family of ADCs similar to AD9467 in the description.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
As this is just an ID and a bit of descriptive text, I'm not going to
waste Rob's time by expecting him to take a look!
@Rob: Of course you are welcome to take a look if you like.

I've tweaked the description a tiny bit as below.

Series applied to the togreg branch of iio.git and pushed out as testing
for all the normal reasons (autobuilders etc).

Thanks,

Jonathan

> ---
>  .../devicetree/bindings/iio/adc/adi,ad9467.yaml   | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml
> index c4f57fa6aad1..579dbc63e3fe 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml
> @@ -4,21 +4,30 @@
>  $id: http://devicetree.org/schemas/iio/adc/adi,ad9467.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>  
> -title: Analog Devices AD9467 High-Speed ADC
> +title: Analog Devices AD9467 and similar High-Speed ADCs
>  
>  maintainers:
>    - Michael Hennerich <michael.hennerich@analog.com>
>    - Alexandru Ardelean <alexandru.ardelean@analog.com>
>  
>  description: |
> -  The AD9467 is a 16-bit, monolithic, IF sampling analog-to-digital
> -  converter (ADC).
> +  The AD9467 and the parts similar with it, are high-speed analog-to-digital
> +  converters (ADCs), operating in the range of 100 to 500 mega samples
> +  per second (MSPS). Depending on the part, some support higher MSPS and some
> +  lower MSPS, depending on the application each part is intended for.
The Depending.... depending is a bit awkward so I'll rephrase that as

Some parts support higher MSPS and some lower MSPS, suitable for the
intended application of each part.

>  
> +  All the parts support the register map described by Application Note AN-877
> +   https://www.analog.com/media/en/technical-documentation/application-notes/AN-877.pdf
> +
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/AD9265.pdf
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/AD9434.pdf
>    https://www.analog.com/media/en/technical-documentation/data-sheets/AD9467.pdf
>  
>  properties:
>    compatible:
>      enum:
> +      - adi,ad9265
> +      - adi,ad9434
>        - adi,ad9467
>  
>    reg:

