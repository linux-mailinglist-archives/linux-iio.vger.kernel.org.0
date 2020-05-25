Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BDE51E07FB
	for <lists+linux-iio@lfdr.de>; Mon, 25 May 2020 09:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389064AbgEYH1N (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 25 May 2020 03:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388948AbgEYH1N (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 25 May 2020 03:27:13 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DC2BC061A0E;
        Mon, 25 May 2020 00:27:13 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id i68so13231852qtb.5;
        Mon, 25 May 2020 00:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ajNAsOcF30eG4hqzyeyUa+xAGM7I/tH3z9ZvaPCi0Hs=;
        b=M2fVxMqzJWTj9nG09QoCCO0x3CGpPIPDCEJXBd7mYtK10DN8F363Hl2sGFl16s/7VF
         MUu4GknWz738PbJAO5JsvTicpFlCxb235wNKmSs/jbX7tfp3+FAMULjDyOt6HUWGEq2X
         1uSgoC+hCH4YyfaJFgXAsoPyXIO0oENeuRamZf8NSVATr1otMLFXrIqYgFcfDdiD4pAF
         DUUZrXQ35OmkhuL8L89qoUN9noLF6w+1M3ljyfX27Jx2SyyyN59RbxUZrimarjnEyRBe
         82iXYebWod0GLcC/owOXWYniylb11Md2m4h9qdZ7V+gl0M5Xe+oHjKiXIcgYFpezp44J
         S0Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ajNAsOcF30eG4hqzyeyUa+xAGM7I/tH3z9ZvaPCi0Hs=;
        b=NFJrQHuBZMqxIsVRAywzwuPp+yEhW1I7Z8uN5UNn3cRmrrrZtk8ghd5THhqqIfjzRA
         aw2+OOmba/yG1PUvPMI4ix4lxNT9xYWA6Z05elX6rvl7VscMOHIuru8c/8B9CPNE+mZ2
         LaYclBxWPH/+MA8QEvsNGBTWQ0mn6Zm2SCG1uiQ8d3NlHOyMo4ThxZTwj8AF+xR2sTnu
         T8kanSrAiNU6OyxK2YMs4TPWOH5kzOl0xAiXrNNEso9DlWHjQDM4gC8/MYbVEz2V0/MF
         wW2OUNkuPI3w9pqjUkyTscJcPVjW8c5F4u5orTqk2hJV5kVYCsAxP7POaICz0oBCInrk
         7tVw==
X-Gm-Message-State: AOAM533yH5EwfzSd/E/FfNKeRmWAhixYYLgFTlDcaicqofMCSjbYJhdU
        RDRRtoIR1DxW4zP0G/s2YT0=
X-Google-Smtp-Source: ABdhPJw2kYo4SMNynj5nfsDzzktvz1erwmL4xIZjc6aVXyE3UYv/RojUlPMncQ3dnRqR54OVXr/vmQ==
X-Received: by 2002:ac8:670b:: with SMTP id e11mr27643877qtp.365.1590391632372;
        Mon, 25 May 2020 00:27:12 -0700 (PDT)
Received: from ict14-OptiPlex-980 ([178.23.248.46])
        by smtp.gmail.com with ESMTPSA id n31sm15641781qtc.36.2020.05.25.00.27.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 May 2020 00:27:11 -0700 (PDT)
Date:   Mon, 25 May 2020 09:27:07 +0200
From:   Jonathan Albrieux <jonathan.albrieux@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, daniel.baluta@nxp.com,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v3 1/5] dt-bindings: iio: imu: bmi160: convert txt format
 to yaml
Message-ID: <20200525072707.GB18690@ict14-OptiPlex-980>
References: <20200520194656.16218-1-jonathan.albrieux@gmail.com>
 <20200520194656.16218-2-jonathan.albrieux@gmail.com>
 <20200524124114.7f4e785d@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200524124114.7f4e785d@archlinux>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, May 24, 2020 at 12:41:14PM +0100, Jonathan Cameron wrote:
> On Wed, 20 May 2020 21:46:40 +0200
> Jonathan Albrieux <jonathan.albrieux@gmail.com> wrote:
> 
> > Converts documentation from txt format to yaml.
> > 
> > Signed-off-by: Jonathan Albrieux <jonathan.albrieux@gmail.com>
> 
> A reminder on the maintainer bit as that thread crossed with
> this one.  Also, drop the spi-max-frequency as we don't need
> to mention it explicitly for this device.
> 
> Thanks,
> 
> Jonathan
> 

Thank you, I'll remove it today.

> 
> > ---
> >  .../devicetree/bindings/iio/imu/bmi160.txt    | 37 ---------
> >  .../bindings/iio/imu/bosch,bmi160.yaml        | 76 +++++++++++++++++++
> >  2 files changed, 76 insertions(+), 37 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/iio/imu/bmi160.txt
> >  create mode 100644 Documentation/devicetree/bindings/iio/imu/bosch,bmi160.yaml
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
> > diff --git a/Documentation/devicetree/bindings/iio/imu/bosch,bmi160.yaml b/Documentation/devicetree/bindings/iio/imu/bosch,bmi160.yaml
> > new file mode 100644
> > index 000000000000..46cb4fde1165
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/imu/bosch,bmi160.yaml
> > @@ -0,0 +1,76 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/imu/bosch,bmi160.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Bosch BMI160
> > +
> > +maintainers:
> > +  - Daniel Baluta <daniel.baluta@nxp.com> (?)
> 
> Daniel's reply crossed with this.  Given he's moved on to other things
> he's not happy to be listed as maintainer here.
> 
> Given other threads, either put yourself here if you are happy to maintain
> the binding, or fall back to me but use my kernel.org address.
> 
> Jonathan Cameron <jic23@kernel.org>
> 
> I don't mind either way.
> 

Thank you, I'll add you then for this binding.

Thank for your help,

Best regards,
Jonathan Albrieux

> 
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
> > +
> > +  spi-max-frequency:
> > +    maxItems: 1
> 
> spi-max-frequency doesn't need to be here at all.   We aren't trying to list
> all of the properties that might be present - but rather those that
> are either required or that are part of the description of the device.
> This one is a generic spi binding that may or may not be present.
> 
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  interrupt-names:
> > +    enum:
> > +      - INT1
> > +      - INT2
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
> > +    i2c {
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
> > +    };
> > +  - |
> > +    // Example for SPI
> > +    spi {
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
