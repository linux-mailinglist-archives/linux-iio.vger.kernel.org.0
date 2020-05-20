Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0104D1DAC1C
	for <lists+linux-iio@lfdr.de>; Wed, 20 May 2020 09:29:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbgETH3a (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 20 May 2020 03:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbgETH33 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 20 May 2020 03:29:29 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C27EAC061A0E;
        Wed, 20 May 2020 00:29:28 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id i14so2578676qka.10;
        Wed, 20 May 2020 00:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HTou0WUXzDf0o0mQsx/duwk3hrNBz9rboYojoyLD5HQ=;
        b=tZ2dpYJB4FNN/ruIH8/R+pf4rYd+0NckDU5SgH2l7b7nWMd+tV1DftkaYewtxWFKk9
         kzSQXi3WUnrcDhIUb8BfU0C9cUi5arGmzK+72smcK69MaXPKLYdE7k3i2v/GBpy8mJyv
         HLjKCXJH3Pj2sPK6hQOXO+yN1tN/RK3TqvDrEHMxZADeJx0u82Tx7aCDUSqsZYltcfJa
         Dw9eRuJizPtErqOnV+EABghVnkK0fo0SgFrgsTVTVfC3ql3GK8MCd+atJZJiAuScL6RF
         Ch53P1isQbeYqq40GhEoj4TjbEc+tVyqUNYxVmfE8z2yIKt9o37CusVqoZRrnvcjAK/v
         q81Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HTou0WUXzDf0o0mQsx/duwk3hrNBz9rboYojoyLD5HQ=;
        b=hd+pRQpSJw0BAsda3XsFO7HqelwXO9pzDH3forsHROmKmseZBYhMXlNJGU8KYJJwNG
         iW8gUxQQD8C0HcOz52MD31WQlWhZ1XEyZPFzvefyeF1qjty6rMvfIXZIHrlDZxh8xPqD
         voFk/z4DJ3T0cYM+0972EeJqKvDtBq4GFYCmdGESkp+Qy+0vX5XMzxns4Th9XoDQAcdY
         XtEzaxH/9hp6M6buZNruWSkhw8dTRHjsmqzuMPLsuqas5dGQRSptohnbhAiyxBnob4V/
         htFftuQ5XFzIDoZIu/ZT+6WkWAJgjSogozzqMhBAuEJgY+N37ELMJtRgv9Q2oYSe5t7w
         /yCQ==
X-Gm-Message-State: AOAM532Hdjwb0tHZpKW899AHLDbfWri5osC2NMWOKo1v0kf7RNZYa7p8
        BpxPidl7NodO+wIyIIf9w5s=
X-Google-Smtp-Source: ABdhPJxSr2e4My6HF39ER0wjT+rTL2Jx/3tBpkFRC1TW2tLEbOFEbU7rgeg3puCqKKnn2RGsFxr8fw==
X-Received: by 2002:a37:8d85:: with SMTP id p127mr3040499qkd.35.1589959767869;
        Wed, 20 May 2020 00:29:27 -0700 (PDT)
Received: from ict14-OptiPlex-980 ([178.23.248.46])
        by smtp.gmail.com with ESMTPSA id c26sm1551092qkm.98.2020.05.20.00.29.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 May 2020 00:29:27 -0700 (PDT)
Date:   Wed, 20 May 2020 09:29:22 +0200
From:   Jonathan Albrieux <jonathan.albrieux@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v2 1/4] dt-bindings: iio: imu: bmi160: convert txt format
 to yaml
Message-ID: <20200520072922.GG3361@ict14-OptiPlex-980>
References: <20200519075111.6356-1-jonathan.albrieux@gmail.com>
 <20200519075111.6356-2-jonathan.albrieux@gmail.com>
 <20200519182028.GB342367@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200519182028.GB342367@bogus>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, May 19, 2020 at 12:20:28PM -0600, Rob Herring wrote:
> On Tue, May 19, 2020 at 09:50:57AM +0200, Jonathan Albrieux wrote:
> > Converts documentation from txt format to yaml 
> > 
> > Signed-off-by: Jonathan Albrieux <jonathan.albrieux@gmail.com>
> > ---
> >  .../devicetree/bindings/iio/imu/bmi160.txt    | 37 --------
> >  .../devicetree/bindings/iio/imu/bmi160.yaml   | 84 +++++++++++++++++++
> >  2 files changed, 84 insertions(+), 37 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/iio/imu/bmi160.txt
> >  create mode 100644 Documentation/devicetree/bindings/iio/imu/bmi160.yaml
> 
> Use compatible string for filename: bosch,bmi160.yaml
>

Ok thank you, will change filename.
 
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/imu/bmi160.txt b/Documentation/devicetree/bindings/iio/imu/bmi160.txt
> > deleted file mode 100644
> > index 900c169de00f..000000000000
> > --- a/Documentation/devicetree/bindings/iio/imu/bmi160.txt
> > +++ /dev/null
> > @@ -1,37 +0,0 @@
> > -Bosch BMI160 - Inertial Measurement Unit with Accelerometer, Gyroscope
> > -and externally connectable Magnetometer
> > -
> > -https://www.bosch-sensortec.com/bst/products/all_products/bmi160
> > -
> > -Required properties:
> > - - compatible : should be "bosch,bmi160"
> > - - reg : the I2C address or SPI chip select number of the sensor
> > - - spi-max-frequency : set maximum clock frequency (only for SPI)
> > -
> > -Optional properties:
> > - - interrupts : interrupt mapping for IRQ
> > - - interrupt-names : set to "INT1" if INT1 pin should be used as interrupt
> > -   input, set to "INT2" if INT2 pin should be used instead
> > - - drive-open-drain : set if the specified interrupt pin should be configured as
> > -   open drain. If not set, defaults to push-pull.
> > -
> > -Examples:
> > -
> > -bmi160@68 {
> > -	compatible = "bosch,bmi160";
> > -	reg = <0x68>;
> > -
> > -	interrupt-parent = <&gpio4>;
> > -	interrupts = <12 IRQ_TYPE_EDGE_RISING>;
> > -	interrupt-names = "INT1";
> > -};
> > -
> > -bmi160@0 {
> > -	compatible = "bosch,bmi160";
> > -	reg = <0>;
> > -	spi-max-frequency = <10000000>;
> > -
> > -	interrupt-parent = <&gpio2>;
> > -	interrupts = <12 IRQ_TYPE_LEVEL_LOW>;
> > -	interrupt-names = "INT2";
> > -};
> > diff --git a/Documentation/devicetree/bindings/iio/imu/bmi160.yaml b/Documentation/devicetree/bindings/iio/imu/bmi160.yaml
> > new file mode 100644
> > index 000000000000..6b464ce5ed0b
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/imu/bmi160.yaml
> > @@ -0,0 +1,84 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/imu/bmi160.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Bosch BMI160
> > +
> > +maintainers:
> > +  - can't find a mantainer, author is Daniel Baluta <daniel.baluta@intel.com>
> 
> Would help to Cc him perhaps.
> 

Thank you, I will add him too on the next version.

> > +
> > +description: |
> > +  Inertial Measurement Unit with Accelerometer, Gyroscope and externally
> > +  connectable Magnetometer
> > +  https://www.bosch-sensortec.com/bst/products/all_products/bmi160
> > +
> > +properties:
> > +  compatible:
> > +    const: bosch,bmi160
> > +
> > +  reg:
> > +    maxItems: 1
> > +    description: the I2C address or SPI chip select number of the sensor
> > +
> > +  spi-max-frequency:
> > +    maxItems: 1
> > +    description: set maximum clock frequency (required only for SPI)
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +    description: interrupt mapping for IRQ
> 
> No need for description if not adding anything unique for this device.
> 

Will remove it then.

> > +
> > +  interrupt-names:
> > +    minItems: 1
> > +    maxItems: 1
> > +    items:
> > +      enum:
> > +        - INT1
> > +        - INT2
> 
> Just the enum is enough.
> 

Ok, will clean this.

> > +    description: |
> > +      set to "INT1" if INT1 pin should be used as interrupt input, set
> > +      to "INT2" if INT2 pin should be used instead
> > +
> > +  drive-open-drain:
> > +    description: |
> > +      set if the specified interrupt pin should be configured as
> > +      open drain. If not set, defaults to push-pull.
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +examples:
> > +  - |
> > +    // Example for I2C
> > +    i2c@78b7000 {
> > +        reg = <0x78b6000 0x600>;
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        bmi160@68 {
> > +                compatible = "bosch,bmi160";
> > +                reg = <0x68>;
> > +                interrupt-parent = <&gpio4>;
> > +                interrupts = <12 1>;
> > +                interrupt-names = "INT1";
> > +        };
> > +  - |
> > +    // Example for SPI
> > +    spi@78b7000 {
> > +        reg = <0x78b7000 0x600>,
> > +              <0x7884000 0x23000>;
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        bmi160@0 {
> > +                compatible = "bosch,bmi160";
> > +                reg = <0>;
> > +                spi-max-frequency = <10000000>;
> > +                interrupt-parent = <&gpio2>;
> > +                interrupts = <12 1>;
> > +                interrupt-names = "INT2";
> > +        };
> > +    };
> > -- 
> > 2.17.1
> > 

Thank you for your help,

Best regards,
Jonathan Albrieux
