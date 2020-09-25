Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D72412786A0
	for <lists+linux-iio@lfdr.de>; Fri, 25 Sep 2020 14:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbgIYMFB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 25 Sep 2020 08:05:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:58238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726368AbgIYMFB (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 25 Sep 2020 08:05:01 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC4E02083B;
        Fri, 25 Sep 2020 12:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601035500;
        bh=5JS6f9gRAAFsBtkj5okSCjVwQ+33QurOv5HcuSk3oa0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=x0mQAP4H/JYPasau3b9BrJLY3B2fRKMDM2+hIRJUGpkRXcRWVpANO7/Op0Z3u9UNm
         /+TYPgNDx1oQks29s3U5i+kxH5PnkLCxY9dNS0u51i05plRxo0Ye2bgG4G7G2eC3ZV
         70GdQxtXYthixt9j9vfgC65llODcHdMPRxFolJmo=
Date:   Fri, 25 Sep 2020 13:04:56 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Cristian Pop <cristian.pop@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v6 4/4] dt-bindings:iio:adc:adi,ad7768-1: Add
 documentation for channel label
Message-ID: <20200925130456.1203ba5d@archlinux>
In-Reply-To: <20200921133020.62978-4-cristian.pop@analog.com>
References: <20200921133020.62978-1-cristian.pop@analog.com>
        <20200921133020.62978-4-cristian.pop@analog.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 21 Sep 2020 16:30:20 +0300
Cristian Pop <cristian.pop@analog.com> wrote:

Hi Cristian,

> Optional attribute for better identification of the channels.
Dt-bindings need to be sent to the dt-binding maintainer and
list.
+CC.

I'll definitely be looking for a review from Rob on this one as we are defining
a new generic binding.

@Rob, the only new bit in here is the label for an individual channel.
The rest has been defined for a while to allow us to control channel
specific aspects of an ADC.

We should also look to add it to the top level docs.

In this case, probably
Documentation/device-tree/bindings/iio/adc/adc.txt

Currently only ADCs have a channel description to add this to.
We can look at making this more generic if it turns out to make sense
for other types of IIO device.

Thanks,

Jonathan


> 
> Signed-off-by: Cristian Pop <cristian.pop@analog.com>
> ---
>  .../bindings/iio/adc/adi,ad7768-1.yaml        | 31 +++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
> index d3733ad8785a..0c75ce73ffe9 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
> @@ -29,6 +29,12 @@ properties:
>    interrupts:
>      maxItems: 1
>  
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +
>    vref-supply:
>      description:
>        ADC reference voltage supply
> @@ -61,6 +67,23 @@ required:
>    - spi-cpha
>    - adi,sync-in-gpios
>  
> +patternProperties:
> +  "^channel@([0-9]|1[0-5])$":
> +    type: object
> +    description: |
> +      Represents the external channels which are connected to the device.
> +
> +    properties:
> +      reg:
> +        description: |
> +          The channel number.
> +
> +      label:
> +        description: |
> +          Unique name to identify which channel this is.
> +    required:
> +      - rega
rega?  Also, one I learnt the other day.  Need to have

       additionalProperties: false

for child nodes as well as the base node.

> +
>  additionalProperties: false
>  
>  examples:
> @@ -84,6 +107,14 @@ examples:
>              reset-gpios = <&gpio 27 GPIO_ACTIVE_LOW>;
>              clocks = <&ad7768_mclk>;
>              clock-names = "mclk";
> +
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            channel@0 {
> +                reg = <0>;
> +                label = "channel_0";
> +            };
>          };
>      };
>  ...

