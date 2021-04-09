Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 054EF35A2B0
	for <lists+linux-iio@lfdr.de>; Fri,  9 Apr 2021 18:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233441AbhDIQI4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 9 Apr 2021 12:08:56 -0400
Received: from mail-ot1-f53.google.com ([209.85.210.53]:41663 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232395AbhDIQI4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 9 Apr 2021 12:08:56 -0400
Received: by mail-ot1-f53.google.com with SMTP id l12-20020a9d6a8c0000b0290238e0f9f0d8so6152483otq.8;
        Fri, 09 Apr 2021 09:08:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6eGZVQs3kdLaQZyoPyHlwGFNs8rWWnWQCue5McfcZbw=;
        b=iB8JSsSD0J5RInJ5Chvom/WtLbta2EEnFmX70vyKILMn1XxVBmwyT6xHp7MMde8p/3
         ZgeNtwrhtouJZm++yyrdMtpNQ+uVP8jaOwvdO7nuCViwIqIIOfsUUn2gY0OGpLvGeq7w
         O47Xzbr+ExhynfgqTYu/yNv896Ovjp181P2LRQpjovUOqW9JxEh8FwCd5/PnbFoAdURx
         pGhZ/DqY5hE3AqGq7VuAfTD95B6hoa/zmaYAdZwtG7+KFLVgdOi0Y/QR3+EaLbruWNq6
         MQjXPHVeFTyUgkLOsjQsv/dtwJTSAAdNbnyIT7nmKe/xZX6+GveIVhn9PDCcsRQrn3Eh
         4TBQ==
X-Gm-Message-State: AOAM530wnaFBzyHAxtvClILG2xk3+z0GV8MW/ZpZTYyRINlhMxdtyTTg
        OVd60b8XzTAeBEsqNMl3AvhamD7blw==
X-Google-Smtp-Source: ABdhPJyB8sLdP9CWTDPrxQzjlOzrCv0AOFkQHjiCjE0qR9gZuzx8I9Ct32nAr/VWyzG4CagAUR5hXg==
X-Received: by 2002:a9d:6b13:: with SMTP id g19mr12677631otp.185.1617984523297;
        Fri, 09 Apr 2021 09:08:43 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 9sm585447oid.17.2021.04.09.09.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 09:08:42 -0700 (PDT)
Received: (nullmailer pid 3737303 invoked by uid 1000);
        Fri, 09 Apr 2021 16:08:41 -0000
Date:   Fri, 9 Apr 2021 11:08:41 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Michael Hennerich <michael.hennerich@analog.com>
Subject: Re: [PATCH v2 2/2] dt-bindings:iio:adc:adi,ad7474: Add missing
 binding document
Message-ID: <20210409160841.GA3735818@robh.at.kernel.org>
References: <20210405162325.627977-1-jic23@kernel.org>
 <20210405162325.627977-3-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210405162325.627977-3-jic23@kernel.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Apr 05, 2021 at 05:23:25PM +0100, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> This binding covers class of simple SPI ADCs which only provide
> data output - they don't have MOSI pin.
> 
> The only real variation between them is over how many supplies they
> use and which one is used for the reference.
> 
> Michael listed as maintainer for this one as it is his driver and
> falls under the catch all MAINTAINERS entry for ADI devices.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Michael Hennerich <michael.hennerich@analog.com>
> ---
>  .../bindings/iio/adc/adi,ad7476.yaml          | 173 ++++++++++++++++++
>  1 file changed, 173 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7476.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7476.yaml
> new file mode 100644
> index 000000000000..bebf5b435947
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7476.yaml
> @@ -0,0 +1,173 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright 2019 Analog Devices Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/adi,ad7476.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: AD7476 and similar simple SPI ADCs from multiple manufacturers.
> +
> +maintainers:
> +  - Michael Hennerich <michael.hennerich@analog.com>
> +
> +description: |
> +  A lot of simple SPI ADCs have very straight forward interfaces.
> +  They typically don't provide a MOSI pin, simply reading out data
> +  on MISO when the clock toggles.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ad7091
> +      - adi,ad7091r
> +      - adi,ad7273
> +      - adi,ad7274
> +      - adi,ad7276
> +      - adi,ad7277
> +      - adi,ad7278
> +      - adi,ad7466
> +      - adi,ad7467
> +      - adi,ad7468
> +      - adi,ad7475
> +      - adi,ad7476
> +      - adi,ad7476a
> +      - adi,ad7477
> +      - adi,ad7477a
> +      - adi,ad7478
> +      - adi,ad7478a
> +      - adi,ad7495
> +      - adi,ad7910
> +      - adi,ad7920
> +      - adi,ad7940
> +      - ti,adc081s
> +      - ti,adc101s
> +      - ti,adc121s
> +      - ti,ads7866
> +      - ti,ads7867
> +      - ti,ads7868
> +      - lltc,ltc2314-14
> +
> +  reg:
> +    maxItems: 1
> +
> +  vcc-supply:
> +    description:
> +      Main powersupply voltage for the chips, sometimes referred to as VDD on
> +      datasheets.  If there is no separate vref-supply, then this is needed
> +      to establish channel scaling.
> +
> +  vdrive-supply:
> +    description:
> +      Some devices have separate supply for their digital control side.
> +
> +  vref-supply:
> +    description:
> +      Some devices have a specific reference voltage supplied on a different pin
> +      to the other supplies. Needed to be able to establish channel scaling
> +      unless there is also an internal reference available (e.g. ad7091r)
> +
> +  spi-max-frequency: true
> +
> +  adi,conversion-start-gpios:
> +    description: A GPIO used to trigger the start of a conversion

maxItems: 1

With that,

Reviewed-by: Rob Herring <robh@kernel.org>
