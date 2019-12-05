Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D9CC114370
	for <lists+linux-iio@lfdr.de>; Thu,  5 Dec 2019 16:21:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729145AbfLEPVc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 5 Dec 2019 10:21:32 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:33058 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729790AbfLEPVc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 5 Dec 2019 10:21:32 -0500
Received: by mail-oi1-f196.google.com with SMTP id v140so3097326oie.0;
        Thu, 05 Dec 2019 07:21:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+WIMxLv19tjffTAX77E2M2L63dzYaMaTLYuDHcPpCEE=;
        b=dv0aeVhzikvm9N1HMR+UCwYiP2sfuHcZ2vr7MutvOVpuAygjQ6Zc0w/aIIIUMhmjPw
         ZhTVJeL4kB0W0J+JkJ2UAuuZjkjBfXiY0tmBaMYmuzES9pVNJFVttX5yroxmB+RpB65d
         RfnpUYJWb7ijrRN1q/WCNHlVPJz20FBqSXGTldNUim8Ad4eWMCfMZTVaOb9LYZUjYyTj
         XWNHsWMnmfmIBvpitnp3+mCwH1qBwTWa8Uw90qzaw6FKt8y4hjDNdgnHQTcXHKKFnsc8
         pED/dWaaQ6waoreFoiZ7AEOsUZOP9JlfZPN4EdC65FwYWojP9iAyPGSsVHn4NsVcOMTb
         89ww==
X-Gm-Message-State: APjAAAW6f9Re+JGaUPXegCRuaRDoEePSYrAokVlmi+NumrfPU+4XQq6C
        taAnqK2U6UuV9NVOQMtiGQ==
X-Google-Smtp-Source: APXvYqxWM2sWW0OmOjxxnjypKw2CsTWhwLb6dpBPypkmM6lnxiLp7y3FhuXuAy+HjZDphQ3sYtuYIw==
X-Received: by 2002:a05:6808:50:: with SMTP id v16mr7227208oic.11.1575559291069;
        Thu, 05 Dec 2019 07:21:31 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id j23sm3560484oij.56.2019.12.05.07.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2019 07:21:30 -0800 (PST)
Date:   Thu, 5 Dec 2019 09:21:29 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rodrigo Carvalho <rodrigorsdc@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        alexandru.ardelean@analog.com, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, kernel-usp@googlegroups.com
Subject: Re: [PATCH v5 2/2] dt-bindings: iio: accel: add binding
 documentation for ADIS16240
Message-ID: <20191205152129.GA13911@bogus>
References: <20191123233510.4890-1-rodrigorsdc@gmail.com>
 <20191123233510.4890-2-rodrigorsdc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191123233510.4890-2-rodrigorsdc@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Nov 23, 2019 at 08:35:10PM -0300, Rodrigo Carvalho wrote:
> This patch add device tree binding documentation for ADIS16240.
> 
> Signed-off-by: Rodrigo Ribeiro Carvalho <rodrigorsdc@gmail.com>

checkpatch.pl complains about a mismatch between the author and S-o-b.

> ---
> V5:
>   - None 
> 
>  .../bindings/iio/accel/adi,adis16240.yaml     | 49 +++++++++++++++++++
>  1 file changed, 49 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/accel/adi,adis16240.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adis16240.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adis16240.yaml
> new file mode 100644
> index 000000000000..8e902f7c49e6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/accel/adi,adis16240.yaml
> @@ -0,0 +1,49 @@
> +# SPDX-License-Identifier: GPL-2.0

Dual license new bindings please: (GPL-2.0-only OR BSD-2-Clause)

With that,

Reviewed-by: Rob Herring <robh@kernel.org>

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/accel/adi,adis16240.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ADIS16240 Programmable Impact Sensor and Recorder driver
> +
> +maintainers:
> +  - Alexandru Ardelean <alexandru.ardelean@analog.com>
> +
> +description: |
> +  ADIS16240 Programmable Impact Sensor and Recorder driver that supports
> +  SPI interface.
> +    https://www.analog.com/en/products/adis16240.html
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,adis16240
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    spi0 {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        /* Example for a SPI device node */
> +        accelerometer@0 {
> +            compatible = "adi,adis16240";
> +            reg = <0>;
> +            spi-max-frequency = <2500000>;
> +            interrupt-parent = <&gpio0>;
> +            interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
> +        };
> +    };
> -- 
> 2.24.0
> 
