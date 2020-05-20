Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20BF21DABF0
	for <lists+linux-iio@lfdr.de>; Wed, 20 May 2020 09:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbgETHYa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 20 May 2020 03:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbgETHY3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 20 May 2020 03:24:29 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C48EAC061A0E;
        Wed, 20 May 2020 00:24:28 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id m11so2638050qka.4;
        Wed, 20 May 2020 00:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=O+/xss7Rkk0KX4d1uqXw1V60AVLQm9vIrr0+J5j1ifk=;
        b=Tq2ySHkk83LU84YTlYvVc5VNGjs9Lzayz6d6h7gncoUixD7iuISoc089WPvJYg6uwP
         HzAPNJHydT/OlIjblA6891NGMau5np5MQe4SQgPDBe7CP2mHSklXGmVoLes5Kn5r3vYO
         xOQ8dc6VUypajI7kC0FeDP8Lnixd/xGN8MjJqeTi9uZdM04+8l5n0ftPtZ1C5mR4Xl/Z
         d1BTw4xBKLn9w5y2wqaR03JFWoWphUL6v3Z06pZplgaBcAIX5eOZMTeyoX9sdGknGPeB
         DhkF8uIeGdu7hFuxE2iSCHW+IukrXBtKhfyyYinIyXhDy1FAsHqIkSoU77MCofQaz51o
         MBXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=O+/xss7Rkk0KX4d1uqXw1V60AVLQm9vIrr0+J5j1ifk=;
        b=TXMiggR1laqKZtDYcpphUcqeWyTIp+uFISRaOYTBFtXpDhBlvAWzpGLcEeqgg23D2r
         //VK7NSck4dPmn56vN9+A+jfk+UiJIaRDSHLUbg0psLkHFM9Uzq+KRqNuFownBcvunH2
         WSM4j1ZSLS9EIeXq3Dj01aBkW0g6mqWtEv+xJz/796TpKxRmbf3yDEnJc7Uu6HZfF0MG
         jZ6/0brnzJsdxCEExMMygKX2baRKFG3SFKsyTtCBtJ3a5SU6eAesaBvhcLUDPsMU9dRv
         yk5gAYDJp5bzPrJm2/hlrTOX7W/G4enuOG+HtWOL1fuRztW4x2HYWOvofspWqhcHoDxS
         V4Ag==
X-Gm-Message-State: AOAM532nEUARAHWg+5Y5AhwwcaEHurfwgbn66hGgseTx/Gb3tsyQu5uo
        dtiLFigO7i7bHC0b6aG6S4W1Wg6VLkJBew==
X-Google-Smtp-Source: ABdhPJwawYZ0CCaDY7dm/f5fn9KnmfwSKVvpJDj4r9YrIJ3nfF+sq8P2IsTItK2JldIX9saCc1s8Cw==
X-Received: by 2002:a05:620a:346:: with SMTP id t6mr3337595qkm.210.1589959467858;
        Wed, 20 May 2020 00:24:27 -0700 (PDT)
Received: from ict14-OptiPlex-980 ([178.23.248.46])
        by smtp.gmail.com with ESMTPSA id h188sm1614344qke.82.2020.05.20.00.24.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 May 2020 00:24:27 -0700 (PDT)
Date:   Wed, 20 May 2020 09:24:23 +0200
From:   Jonathan Albrieux <jonathan.albrieux@gmail.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     linux-kernel@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: iio: imu: bmi160: convert txt format
 to yaml
Message-ID: <20200520072423.GF3361@ict14-OptiPlex-980>
References: <20200519075111.6356-1-jonathan.albrieux@gmail.com>
 <20200519075111.6356-2-jonathan.albrieux@gmail.com>
 <20200519184933.00003f00@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200519184933.00003f00@Huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, May 19, 2020 at 06:49:33PM +0100, Jonathan Cameron wrote:
> On Tue, 19 May 2020 09:50:57 +0200
> Jonathan Albrieux <jonathan.albrieux@gmail.com> wrote:
> 
> > Converts documentation from txt format to yaml 
> > 
> > Signed-off-by: Jonathan Albrieux <jonathan.albrieux@gmail.com>
> > ---
> >  .../devicetree/bindings/iio/imu/bmi160.txt    | 37 --------
> >  .../devicetree/bindings/iio/imu/bmi160.yaml   | 84 +++++++++++++++++++
> >  2 files changed, 84 insertions(+), 37 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/iio/imu/bmi160.txt
> >  create mode 100644 Documentation/devicetree/bindings/iio/imu/bmi160.yaml
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
> Daniel is still active in the kernel, just not at Intel any more. +CC
> 

Oh ok thank you! Daniel are you still maintaining this driver?

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
> 
> As standard for i2c and spi, usually no need to have a description line for
> this element.
> 

Thank you, will remove the description then.

> > +
> > +  spi-max-frequency:
> > +    maxItems: 1
> > +    description: set maximum clock frequency (required only for SPI)
> 
> Standard spi binding.  Probably doesn't need to be included here.
> 

So should I completely remove it from properties?

> > +
> > +  interrupts:
> > +    maxItems: 1
> > +    description: interrupt mapping for IRQ
> > +
> > +  interrupt-names:
> > +    minItems: 1
> > +    maxItems: 1
> > +    items:
> > +      enum:
> > +        - INT1
> > +        - INT2
> > +    description: |
> > +      set to "INT1" if INT1 pin should be used as interrupt input, set
> > +      to "INT2" if INT2 pin should be used instead
> > +
> > +  drive-open-drain:
> > +    description: |
> > +      set if the specified interrupt pin should be configured as
> > +      open drain. If not set, defaults to push-pull.
> 
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
> 
> Take a look at some of the other binding examples.  We normally
> just focus on the driver so don't supply details for the bus.
> 
> e.g. https://elixir.bootlin.com/linux/v5.7-rc6/source/Documentation/devicetree/bindings/iio/adc/maxim,max1363.yaml#L39
> 

Will check :-)

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
> 
> 

Thank you,

Best regards,
Jonathan Albrieux
