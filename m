Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 593912F201F
	for <lists+linux-iio@lfdr.de>; Mon, 11 Jan 2021 20:55:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389371AbhAKTzi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 11 Jan 2021 14:55:38 -0500
Received: from mail-oi1-f180.google.com ([209.85.167.180]:45517 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731772AbhAKTzi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 11 Jan 2021 14:55:38 -0500
Received: by mail-oi1-f180.google.com with SMTP id f132so557199oib.12;
        Mon, 11 Jan 2021 11:55:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qR6xjSYWtd3EsSkIf1CxDTXBXyGhzlf0FC2Q2cekedo=;
        b=aaOtU8vR7uhhCqXb0+UuiOExZhg2pFp+n4FWB4Xeh5Gnhk9tcAq9rJrNk8BnYZXHvr
         PtP/iApoOPtmOgKE6TLT/DnDx9L3zgdOoUKkDXp4WQrlkTgZ7qjgpbqF9GCSqCtTW4U/
         V5o3WoGBflt+BEtMueS95UCY/W9Zfid7zpkPKGKeHl6e5ACl8ohmfWnRXC0GXWLTzE5Z
         b4iY5l7cGJR1hpTLfuy5v055qvOiC5fHnsFyocFE822PoJd3VGSCzFdZEH68z3PqMkab
         7oRYbhSBKqDLw3StpwNq9P8EgkrXyld2wkvuJ3cUuMJsBqO88U7qC9c6HOvYDjYVvDM6
         tSXg==
X-Gm-Message-State: AOAM5326/Fz62kTdq6u3YKNrlEdMoEr1DHuz1+T00OyYRm9ZLIEhph0J
        jKHE7dtdg7EmrSaEFcz/yg==
X-Google-Smtp-Source: ABdhPJy5+Ux5GltdZmyc2cZ8Eg2KSJPAtUt4Xud4Xxz2Nabf8ZEF3ce6lP7EfCpR7KPdjP8SrYJm/g==
X-Received: by 2002:aca:ef46:: with SMTP id n67mr274586oih.103.1610394896874;
        Mon, 11 Jan 2021 11:54:56 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id o21sm163507otj.1.2021.01.11.11.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 11:54:55 -0800 (PST)
Received: (nullmailer pid 2966688 invoked by uid 1000);
        Mon, 11 Jan 2021 19:54:54 -0000
Date:   Mon, 11 Jan 2021 13:54:54 -0600
From:   Rob Herring <robh@kernel.org>
To:     Cristian Pop <cristian.pop@analog.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        jic23@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 1/3] dt-bindings: iio: dac: AD5766 yaml documentation
Message-ID: <20210111195454.GA2960719@robh.at.kernel.org>
References: <20210108183739.27634-1-cristian.pop@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210108183739.27634-1-cristian.pop@analog.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Jan 08, 2021 at 08:37:37PM +0200, Cristian Pop wrote:
> This adds device tree bindings for the AD5766 DAC.
> 
> Signed-off-by: Cristian Pop <cristian.pop@analog.com>
> ---
> Changelog v5:                                                              
>         -rename to property to "output-range-voltage"
>  .../bindings/iio/dac/adi,ad5766.yaml          | 64 +++++++++++++++++++
>  1 file changed, 64 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ad5766.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5766.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5766.yaml
> new file mode 100644
> index 000000000000..1deace7c48b2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5766.yaml
> @@ -0,0 +1,64 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright 2020 Analog Devices Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/dac/adi,ad5766.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices AD5766 DAC device driver
> +
> +maintainers:
> +  - Cristian Pop <cristian.pop@analog.com>
> +
> +description: |
> +  Bindings for the Analog Devices AD5766 current DAC device. Datasheet can be
> +  found here:
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad5766-5767.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ad5766
> +      - adi,ad5767
> +
> +  output-range-volts:

Use a unit defined in property-units.txt (-microvolt).

> +    description: Select converter output range.
> +
> +  reg:
> +    maxItems: 1
> +
> +  spi-max-frequency:
> +    maximum: 1000000
> +
> +  spi-cpol: true
> +
> +  reset-gpios:
> +    description: GPIO spec for the RESET pin. If specified, it will be asserted
> +      during driver probe. As the line is active low, it should be marked
> +      GPIO_ACTIVE_LOW.

'asserted during driver probe' is a Linux implementation detail not 
relevant to the binding.

> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - output-range-volts
> +  - reg
> +  - spi-max-frequency
> +  - spi-cpol
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    spi {
> +          #address-cells = <1>;
> +          #size-cells = <0>;
> +          
> +          ad5766@0 {
> +              compatible = "adi,ad5766";
> +              output-range-volts = <(-5) 5>;
> +              reg = <0>;
> +              spi-cpol;
> +              spi-max-frequency = <1000000>;
> +              reset-gpios = <&gpio 22 0>;
> +            };
> +      };
> -- 
> 2.17.1
> 
