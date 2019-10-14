Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBF40D681F
	for <lists+linux-iio@lfdr.de>; Mon, 14 Oct 2019 19:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387406AbfJNRPX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 14 Oct 2019 13:15:23 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:39409 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732490AbfJNRPX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 14 Oct 2019 13:15:23 -0400
Received: by mail-ot1-f65.google.com with SMTP id s22so14428600otr.6;
        Mon, 14 Oct 2019 10:15:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=51hGnQn9HtVv2sy2+nwTT4H0ic9KYSiwye/5us4ieRc=;
        b=DzlZf+v54YqofSsK5o9Hh+Osg7lkCuIVrwX/h77wW9Mm70puZvUksIZV+sxIbqNyoX
         A42HqjaNjBIuySF/yrAqdc77arpU7pUU4XanId3xs82H8zburqAdoufl2c0XpcR7yA+K
         Fm699I7AlRGFO3S03L4AXGmfNGRsLlw4ETKgK4GNHfb/O6KGC6ApOsKNrCo82bJkPTPG
         +ziehEnQWE2/Ovmpb9EtItmB7GjI2Qe7tldrupy+CC1rE7GojleKsYIfTi7jhcXhXuSi
         b2d6PApCHdKkEePRq1ajR5wJet8uYstbgZ4p96fm8bVwRKlO4MNU8Jlu2wdD+KbEyjBE
         8KUw==
X-Gm-Message-State: APjAAAXphcSK0i0OyMyG2U3ZUspcfenaq4eM3A7A3n8fQ/zbC51sWXFI
        gUuW4qb+LwHWEJpW2YCyXg==
X-Google-Smtp-Source: APXvYqywtFkb4H/c+bGP1BZknJtq86ggE3rDW9EMPjyvybK5awTu83tIxFdTrVc9/TPmYSqpJUrtEg==
X-Received: by 2002:a9d:7345:: with SMTP id l5mr15994445otk.39.1571073322169;
        Mon, 14 Oct 2019 10:15:22 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 109sm5840698otc.52.2019.10.14.10.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 10:15:21 -0700 (PDT)
Date:   Mon, 14 Oct 2019 12:15:21 -0500
From:   Rob Herring <robh@kernel.org>
To:     Dan Robertson <dan@dlrobertson.com>
Cc:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        devicetree@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: accel: bma400: add bindings
Message-ID: <20191014171521.GA29335@bogus>
References: <20191012192525.21040-1-dan@dlrobertson.com>
 <20191012192525.21040-2-dan@dlrobertson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191012192525.21040-2-dan@dlrobertson.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Oct 12, 2019 at 07:25:24PM +0000, Dan Robertson wrote:
> Add devicetree binding for the Bosch BMA400 3-axes ultra-low power
> accelerometer sensor.
> 
> Signed-off-by: Dan Robertson <dan@dlrobertson.com>
> ---
>  .../devicetree/bindings/iio/accel/bma400.yaml | 39 +++++++++++++++++++
>  1 file changed, 39 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/accel/bma400.yaml

Fails 'make dt_binding_check':

Documentation/devicetree/bindings/iio/accel/bma400.example.dts:22.13-26: 
Warning (reg_format): /example-0/i2c0/bma400@14:reg: property has 
invalid length (4 bytes) (#address-cells == 1, #size-cells == 1)
Documentation/devicetree/bindings/iio/accel/bma400.example.dt.yaml: 
Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/iio/accel/bma400.example.dt.yaml: 
Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/iio/accel/bma400.example.dt.yaml: 
Warning (spi_bus_reg): Failed prerequisite 'reg_format'
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/accel/bma400.example.dt.yaml: 
i2c0: #size-cells:0:0: 0 was expected


> 
> diff --git a/Documentation/devicetree/bindings/iio/accel/bma400.yaml b/Documentation/devicetree/bindings/iio/accel/bma400.yaml
> new file mode 100644
> index 000000000000..31dceac89ace
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/accel/bma400.yaml
> @@ -0,0 +1,39 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/accel/bma400.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Bosch BMA400 triaxial acceleration sensor
> +
> +maintainers:
> +  - Dan Robertson <dan@dlrobertson.com>
> +
> +description: |
> +  Acceleration and temerature iio sensors with an i2c interface
> +
> +  Specifications about the sensor can be found at:
> +    https://ae-bst.resource.bosch.com/media/_tech/media/datasheets/BST-BMA400-DS000.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - bosch,bma400
> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +examples:
> +  - |
> +    i2c0 {
> +      #address-cells = <1>;
> +      #size-cells = <1>;
> +      bma400@14 {
> +        compatible = "bosch,bma400";
> +        reg = <0x14>;
> +      };
> +    };
> -- 
> 2.23.0
> 
> 
> 
