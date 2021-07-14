Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6637F3C8809
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jul 2021 17:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239570AbhGNP5P (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 14 Jul 2021 11:57:15 -0400
Received: from mail-il1-f177.google.com ([209.85.166.177]:45814 "EHLO
        mail-il1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232318AbhGNP5P (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 14 Jul 2021 11:57:15 -0400
Received: by mail-il1-f177.google.com with SMTP id b6so2054810iln.12;
        Wed, 14 Jul 2021 08:54:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UtnLOowfed83TApY/I1ljEH8PDXa3piDoJBSUx6Ta1U=;
        b=IO3+tWQ2DIkeIURx66qn0Ys1Zla9HBmEbdxogSJZIcUPSFvZRV92RSTyVbOi4SZ0wy
         ui1Lz3zDOHFtdm2vT/nqLrRjn3eaony/1WaII3NIqTHJp8Ib/z1u6mISyAOvmpUxQVv2
         9gwsYGQmq0zv+nCaDJaWfTDUw30A2Op3ndLANacBF+L11MiJWeOpBUyB2l4oDOBanLFM
         s491+46bGoVa/2L2fEb75UNPDXzmMoUTkt5isl6Bq56kf1+DDICpKlVH94LXyPlmESay
         YeoGGFm884NFEcs0HfkK9eU55oEG5A82oDVORwxKJ+ZQTYaVupGL92iqrAWgBO6oNp3e
         cUEQ==
X-Gm-Message-State: AOAM532ZOtSZrJglQrm87E/myGdO/lYZJCNpxTTBrVw7G2ABzffQ6pkk
        6PsRCYOadNHh1iacKzn7mA==
X-Google-Smtp-Source: ABdhPJz1YZAUG7Q3KcPDvzACF21Rgc1SI6+q2IQzFNdo8csyMBf/nNNuh4RBg84v3u+sc2nYERPa3Q==
X-Received: by 2002:a05:6e02:78c:: with SMTP id q12mr7500465ils.243.1626278063693;
        Wed, 14 Jul 2021 08:54:23 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id y198sm1486582iof.25.2021.07.14.08.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 08:54:23 -0700 (PDT)
Received: (nullmailer pid 2647107 invoked by uid 1000);
        Wed, 14 Jul 2021 15:54:21 -0000
Date:   Wed, 14 Jul 2021 09:54:21 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 04/15] dt-bindings: iio: dac: ad5380: Add missing binding
 document
Message-ID: <20210714155421.GA2641406@robh.at.kernel.org>
References: <20210627163244.1090296-1-jic23@kernel.org>
 <20210627163244.1090296-5-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210627163244.1090296-5-jic23@kernel.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Jun 27, 2021 at 05:32:33PM +0100, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> A simple binding for this particular DAC familly.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> ---
>  .../bindings/iio/dac/adi,ad5380.yaml          | 70 +++++++++++++++++++
>  1 file changed, 70 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5380.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5380.yaml
> new file mode 100644
> index 000000000000..d599b418a020
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5380.yaml
> @@ -0,0 +1,70 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/dac/adi,ad5380.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices AD5380 and similar DACs
> +
> +maintainers:
> +  - Lars-Peter Clausen <lars@metafoo.de>
> +  - Jonathan Cameron <jic23@kernel.org>
> +
> +description: |
> +  DAC devices supporting both SPI and I2C interfaces.
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ad5380-3
> +      - adi,ad5380-5
> +      - adi,ad5381-3
> +      - adi,ad5381-5
> +      - adi,ad5382-3
> +      - adi,ad5382-5
> +      - adi,ad5383-3
> +      - adi,ad5383-5
> +      - adi,ad5384-3
> +      - adi,ad5384-5
> +      - adi,ad5390-3
> +      - adi,ad5390-5
> +      - adi,ad5391-3
> +      - adi,ad5391-5
> +      - adi,ad5392-3
> +      - adi,ad5392-5

You could do this:

pattern: '^adi,ad53(8[0-4]|9[0-2])-[35]$'

Either way,

Reviewed-by: Rob Herring <robh@kernel.org>
