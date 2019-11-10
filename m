Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA3CF6889
	for <lists+linux-iio@lfdr.de>; Sun, 10 Nov 2019 11:41:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbfKJKle (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 10 Nov 2019 05:41:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:55888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726609AbfKJKle (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 10 Nov 2019 05:41:34 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB16520869;
        Sun, 10 Nov 2019 10:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573382493;
        bh=8aX7Ng2FwK4Icu+JeKRNo0fbb9jxyupsWqO9xe64kqU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=yYbs/+A4hjPccLgIPwCKWBN54nf/BZdqmxb4DOdQNGP6R9pFLPzrFjnkUwCKX08pU
         +Jmnns0opLbtnoY0/8m+kB05iAhh513HSSJyMxxHRqptN6HJ4/ZNUh9Bt66XJBg2sw
         z/4lxRgSWn3QJWlbW8OKtzsOV2xALgUBsdjlFIu0=
Date:   Sun, 10 Nov 2019 10:41:28 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rishi Gupta <gupt21@gmail.com>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        gregkh@linuxfoundation.org, tglx@linutronix.de,
        allison@lohutok.net, alexios.zavras@intel.com, angus@akkea.ca,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v6 2/3] dt-bindings: iio: light: add veml6030 ALS
 bindings
Message-ID: <20191110104128.6ad7e78e@archlinux>
In-Reply-To: <1572881940-15420-1-git-send-email-gupt21@gmail.com>
References: <1572881940-15420-1-git-send-email-gupt21@gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon,  4 Nov 2019 21:09:00 +0530
Rishi Gupta <gupt21@gmail.com> wrote:

> This commit adds device tree bindings for veml6030 ambient
> light sensor.
> 
> Signed-off-by: Rishi Gupta <gupt21@gmail.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to possibly poke at it.
Not sure they actually do dt binding checks though and they pass locally
so that's probably irrelevant for now ;)

Thanks,

Jonathan

> ---
> Changes in v6:
> * None
> 
> Changes in v5:
> * None
> 
> Changes in v4:
> * Added enum in reg property
> * Removed maxItems from reg property
> 
> Changes in v3:
> * None
> 
> Changes in v2:
> * Corrected grammatical mistake from 'is' to 'are' in description of bindings
> 
>  .../devicetree/bindings/iio/light/veml6030.yaml    | 62 ++++++++++++++++++++++
>  1 file changed, 62 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/light/veml6030.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/light/veml6030.yaml b/Documentation/devicetree/bindings/iio/light/veml6030.yaml
> new file mode 100644
> index 0000000..0ff9b11
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/light/veml6030.yaml
> @@ -0,0 +1,62 @@
> +# SPDX-License-Identifier: GPL-2.0+
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/light/veml6030.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: VEML6030 Ambient Light Sensor (ALS)
> +
> +maintainers:
> +  - Rishi Gupta <gupt21@gmail.com>
> +
> +description: |
> +  Bindings for the ambient light sensor veml6030 from Vishay
> +  Semiconductors over an i2c interface.
> +
> +  Irrespective of whether interrupt is used or not, application
> +  can get the ALS and White channel reading from IIO raw interface.
> +
> +  If the interrupts are used, application will receive an IIO event
> +  whenever configured threshold is crossed.
> +
> +  Specifications about the sensor can be found at:
> +    https://www.vishay.com/docs/84366/veml6030.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - vishay,veml6030
> +
> +  reg:
> +    description:
> +      I2C address of the device.
> +    enum:
> +      - 0x10 # ADDR pin pulled down
> +      - 0x48 # ADDR pin pulled up
> +
> +  interrupts:
> +    description:
> +      interrupt mapping for IRQ. Configure with IRQ_TYPE_LEVEL_LOW.
> +      Refer to interrupt-controller/interrupts.txt for generic
> +      interrupt client node bindings.
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        light-sensor@10 {
> +                compatible = "vishay,veml6030";
> +                reg = <0x10>;
> +                interrupts = <12 IRQ_TYPE_LEVEL_LOW>;
> +        };
> +    };
> +...

