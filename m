Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 671661766D1
	for <lists+linux-iio@lfdr.de>; Mon,  2 Mar 2020 23:22:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbgCBWW5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 2 Mar 2020 17:22:57 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:46249 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbgCBWW5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 2 Mar 2020 17:22:57 -0500
Received: by mail-ot1-f68.google.com with SMTP id g96so940120otb.13;
        Mon, 02 Mar 2020 14:22:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Mh10aMF/oi3rjlaRMPp5pf7W/UgyFmkGUHizeqaiF0c=;
        b=ICZUOWsVgpn2nmw9vBnS1fMiPXk46laJtd7Ercxy01j+6nAPObdR6VEPrUTR4WS1OT
         iunzjCUBoqagDPVj6lzd2UDSXaTOSfqqekzwofy2CdIF/wQfzSOHxLJNJrXEN3WhN1rC
         2c2Dr6rCCOYHZwzcDgXgmpw9RAiPhv/t/CXXmpUxxasLpGgZv77ZDTy3BCAefD2Cs/Bs
         EBLe5xkRnNcMiYfX/F72NKyykiwjbrMFfP2DeZMlPAcaWKIzGo2CG61KFUWRTXdFzGCs
         RwmjJnjY44upyQqpdZdae2qeqaYdjg82n1+MjeodMixXHrmlXj4Mcy5qJYC65EyzLCiM
         Ry5g==
X-Gm-Message-State: ANhLgQ3AopyrdfCsJ8V564CjrDOM1eKkn36UGqmJbJz3v+b4jOZ0OIZD
        Gei6jRZhjC+h9BRE5ITdVUISvhg=
X-Google-Smtp-Source: ADFU+vvuu9wwWij0ssVuytqOvpgn2VMZuebstNfd9YdrSFmhnG3DJi+5FQrw+p1aTja3qXR+sr0cVQ==
X-Received: by 2002:a9d:a16:: with SMTP id 22mr1020718otg.31.1583187776486;
        Mon, 02 Mar 2020 14:22:56 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n27sm6848645oie.18.2020.03.02.14.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 14:22:55 -0800 (PST)
Received: (nullmailer pid 5527 invoked by uid 1000);
        Mon, 02 Mar 2020 22:22:54 -0000
Date:   Mon, 2 Mar 2020 16:22:54 -0600
From:   Rob Herring <robh@kernel.org>
To:     Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: Re: [PATCH 5/5] dt-bindings: iio: Add adis16475 documentation
Message-ID: <20200302222254.GA27619@bogus>
References: <20200225124152.270914-1-nuno.sa@analog.com>
 <20200225124152.270914-6-nuno.sa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200225124152.270914-6-nuno.sa@analog.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Feb 25, 2020 at 01:41:52PM +0100, Nuno Sá wrote:
> Document the ADIS16475 device devicetree bindings.
> 
> Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> ---
>  .../bindings/iio/imu/adi,adis16475.yaml       | 130 ++++++++++++++++++
>  MAINTAINERS                                   |   1 +
>  2 files changed, 131 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/imu/adi,adis16475.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/imu/adi,adis16475.yaml b/Documentation/devicetree/bindings/iio/imu/adi,adis16475.yaml
> new file mode 100644
> index 000000000000..c0f2146e000c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/imu/adi,adis16475.yaml
> @@ -0,0 +1,130 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/imu/adi,adis16475.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices ADIS16475 and similar IMUs
> +
> +maintainers:
> +  - Nuno Sá <nuno.sa@analog.com>
> +
> +description: |
> +  Analog Devices ADIS16475 and similar IMUs
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/ADIS16475.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,adis16475-1
> +      - adi,adis16475-2
> +      - adi,adis16475-3
> +      - adi,adis16477-1
> +      - adi,adis16477-2
> +      - adi,adis16477-3
> +      - adi,adis16470
> +      - adi,adis16465-1
> +      - adi,adis16465-2
> +      - adi,adis16465-3
> +      - adi,adis16467-1
> +      - adi,adis16467-2
> +      - adi,adis16467-3
> +      - adi,adis16500
> +      - adi,adis16505-1
> +      - adi,adis16505-2
> +      - adi,adis16505-3
> +      - adi,adis16507-1
> +      - adi,adis16507-2
> +      - adi,adis16507-3
> +
> +  reg:
> +    maxItems: 1
> +
> +  spi-cpha: true
> +
> +  spi-cpol: true
> +
> +  spi-max-frequency:
> +    maximum: 2000000
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    oneOf:
> +      - const: sync
> +      - const: direct-sync
> +      - const: pulse-sync
> +      - const: scaled-sync

According to the datasheet I looked at, the input is called 'sync'. It 
looks like you are mixing operating mode and clock connection.

> +
> +  reset-gpios:
> +    description:
> +      Must be the device tree identifier of the RESET pin. If specified,
> +      it will be asserted during driver probe. As the line is active low,
> +      it should be marked GPIO_ACTIVE_LOW.
> +    maxItems: 1
> +
> +  adi,scaled-output-hz:
> +    description:
> +      This property must be present if the clock mode is scaled-sync through
> +      clock-names property. In this mode, the input clock can have a range
> +      of 1Hz to 128HZ which must be scaled to originate an allowable sample
> +      rate. This property specifies that rate.
> +    minimum: 1900
> +    maximum: 2100
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - spi-cpha
> +  - spi-cpol
> +
> +if:
> +  properties:
> +    compatible:
> +      contains:
> +        enum:
> +          - adi,adis16500
> +          - adi,adis16505-1
> +          - adi,adis16505-2
> +          - adi,adis16505-3
> +          - adi,adis16507-1
> +          - adi,adis16507-2
> +          - adi,adis16507-3
> +
> +then:
> +  properties:
> +    clock-names:
> +      oneOf:
> +        - const: sync
> +        - const: direct-sync
> +        - const: scaled-sync
> +
> +    adi,burst32-enable:
> +      description:
> +        Enable burst32 mode. In this mode, a burst reading contains calibrated
> +        gyroscope and accelerometer data in 32-bit format.
> +      type: boolean
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    spi {
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            adis16475: adis16475-3@0 {
> +                    compatible = "adi,adis16475-3";
> +                    reg = <0>;
> +                    spi-cpha;
> +                    spi-cpol;
> +                    spi-max-frequency = <2000000>;
> +                    interrupts = <4 IRQ_TYPE_EDGE_RISING>;
> +                    interrupt-parent = <&gpio>;
> +            };
> +    };
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f11262f1f3bb..f8ccc92ab378 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1015,6 +1015,7 @@ W:	http://ez.analog.com/community/linux-device-drivers
>  S:	Supported
>  F:	drivers/iio/imu/adis16475.c
>  F:	Documentation/ABI/testing/sysfs-bus-iio-imu-adis16475
> +F:	Documentation/devicetree/bindings/iio/imu/adi,adis16475.yaml
>  
>  ANALOG DEVICES INC ADM1177 DRIVER
>  M:	Beniamin Bia <beniamin.bia@analog.com>
> -- 
> 2.25.1
> 
