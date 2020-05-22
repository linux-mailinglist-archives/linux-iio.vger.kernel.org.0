Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 121DF1DE1BC
	for <lists+linux-iio@lfdr.de>; Fri, 22 May 2020 10:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729046AbgEVIWP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 22 May 2020 04:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729035AbgEVIWO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 22 May 2020 04:22:14 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5084BC061A0E;
        Fri, 22 May 2020 01:22:14 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id o19so7644606qtr.10;
        Fri, 22 May 2020 01:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qaSTpI+hoKbcDh1IJSe4IFX4jlP4yvAzkKXCdtDTr4o=;
        b=b0ajaNouQvAMtjCixmjNfc52hEaKiDEB4Jvjoj8DxK398h+j0xbvYCInbPEUHWQ0nU
         jV/cjX1jSXXULD/upDhTnRB7AIfmAk2IC0spuad+yxWJwvDsxsCSPYsLC+WltoVsKEo0
         MLAB9emLf2j1hAj5Nd6OLG1gayVQIR+aMYK0e8WuuULbwgPMAAHExV3j0kNjigqPkkga
         5s+MV4u5/qKUfWZv4civronFw+zf33XOdE1R9/2cGxWf6S3S1iMJV7HpK+yYx+CBHFmB
         GPSXVupRzX1l7sNAJ+055AIoIxOCY8wuIZdPaUxVmRaR0DaAattTFdpG4y+yBhJmFCVd
         mi+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qaSTpI+hoKbcDh1IJSe4IFX4jlP4yvAzkKXCdtDTr4o=;
        b=k19annX4tc9wHZjpG51QhEd+fIGwyr8Kh+Wpro/zmx1GEQaOcRmdacslRyBPNDYj6j
         1iJ4jRnjzZvnyqKsFIk6Sj/w0IuqJfOKL2UD3vVeVuPkAPa+sMdTDjHCaF2IUa8mGq9E
         zeV9ExYcWipNScn6TVUpEK2exXAn1/ZoQD5zzPdhr9GQZh9wqonR8cWVZNauEcgmVTOZ
         vP11+pgNNygRzqdx7fpWQLRijmrVgkERqJqWpevmwkzZBkLWG8JFCoxanoHn2BhZKiQy
         QFUmvlLXQFQwz+gCEa+Rcg4orYQXoByxuHitL0bReIOgvCCLwfB5MobW8Rs6HpWGCNQV
         YuZg==
X-Gm-Message-State: AOAM53322p+enVupOiDnjpGOLIqzfcpXbvosDfvJN4dbueZNPLs4LZsE
        uj7yEjm++ID7wzLJZrL082U=
X-Google-Smtp-Source: ABdhPJw7rbep+3/HLbSGIL/XIM433BRRMgPkIPWQm7t0hxdPxucenhrj7Pk8aBzO6cQCZGnwN7SXhw==
X-Received: by 2002:ac8:7659:: with SMTP id i25mr3153642qtr.270.1590135733261;
        Fri, 22 May 2020 01:22:13 -0700 (PDT)
Received: from ict14-OptiPlex-980 ([178.23.248.46])
        by smtp.gmail.com with ESMTPSA id i41sm7734348qte.15.2020.05.22.01.22.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 May 2020 01:22:12 -0700 (PDT)
Date:   Fri, 22 May 2020 10:22:08 +0200
From:   Jonathan Albrieux <jonathan.albrieux@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        linux-kernel@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: iio: imu: bmi160: convert txt format
 to yaml
Message-ID: <20200522082208.GB19742@ict14-OptiPlex-980>
References: <20200519075111.6356-1-jonathan.albrieux@gmail.com>
 <20200519075111.6356-2-jonathan.albrieux@gmail.com>
 <20200519184933.00003f00@Huawei.com>
 <20200520072423.GF3361@ict14-OptiPlex-980>
 <20200521192736.4818f17b@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521192736.4818f17b@archlinux>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, May 21, 2020 at 07:27:36PM +0100, Jonathan Cameron wrote:
> On Wed, 20 May 2020 09:24:23 +0200
> Jonathan Albrieux <jonathan.albrieux@gmail.com> wrote:
> 
> > On Tue, May 19, 2020 at 06:49:33PM +0100, Jonathan Cameron wrote:
> > > On Tue, 19 May 2020 09:50:57 +0200
> > > Jonathan Albrieux <jonathan.albrieux@gmail.com> wrote:
> > >   
> > > > Converts documentation from txt format to yaml 
> > > > 
> > > > Signed-off-by: Jonathan Albrieux <jonathan.albrieux@gmail.com>
> > > > ---
> > > >  .../devicetree/bindings/iio/imu/bmi160.txt    | 37 --------
> > > >  .../devicetree/bindings/iio/imu/bmi160.yaml   | 84 +++++++++++++++++++
> > > >  2 files changed, 84 insertions(+), 37 deletions(-)
> > > >  delete mode 100644 Documentation/devicetree/bindings/iio/imu/bmi160.txt
> > > >  create mode 100644 Documentation/devicetree/bindings/iio/imu/bmi160.yaml
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/iio/imu/bmi160.txt b/Documentation/devicetree/bindings/iio/imu/bmi160.txt
> > > > deleted file mode 100644
> > > > index 900c169de00f..000000000000
> > > > --- a/Documentation/devicetree/bindings/iio/imu/bmi160.txt
> > > > +++ /dev/null
> > > > @@ -1,37 +0,0 @@
> > > > -Bosch BMI160 - Inertial Measurement Unit with Accelerometer, Gyroscope
> > > > -and externally connectable Magnetometer
> > > > -
> > > > -https://www.bosch-sensortec.com/bst/products/all_products/bmi160
> > > > -
> > > > -Required properties:
> > > > - - compatible : should be "bosch,bmi160"
> > > > - - reg : the I2C address or SPI chip select number of the sensor
> > > > - - spi-max-frequency : set maximum clock frequency (only for SPI)
> > > > -
> > > > -Optional properties:
> > > > - - interrupts : interrupt mapping for IRQ
> > > > - - interrupt-names : set to "INT1" if INT1 pin should be used as interrupt
> > > > -   input, set to "INT2" if INT2 pin should be used instead
> > > > - - drive-open-drain : set if the specified interrupt pin should be configured as
> > > > -   open drain. If not set, defaults to push-pull.
> > > > -
> > > > -Examples:
> > > > -
> > > > -bmi160@68 {
> > > > -	compatible = "bosch,bmi160";
> > > > -	reg = <0x68>;
> > > > -
> > > > -	interrupt-parent = <&gpio4>;
> > > > -	interrupts = <12 IRQ_TYPE_EDGE_RISING>;
> > > > -	interrupt-names = "INT1";
> > > > -};
> > > > -
> > > > -bmi160@0 {
> > > > -	compatible = "bosch,bmi160";
> > > > -	reg = <0>;
> > > > -	spi-max-frequency = <10000000>;
> > > > -
> > > > -	interrupt-parent = <&gpio2>;
> > > > -	interrupts = <12 IRQ_TYPE_LEVEL_LOW>;
> > > > -	interrupt-names = "INT2";
> > > > -};
> > > > diff --git a/Documentation/devicetree/bindings/iio/imu/bmi160.yaml b/Documentation/devicetree/bindings/iio/imu/bmi160.yaml
> > > > new file mode 100644
> > > > index 000000000000..6b464ce5ed0b
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/iio/imu/bmi160.yaml
> > > > @@ -0,0 +1,84 @@
> > > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/iio/imu/bmi160.yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: Bosch BMI160
> > > > +
> > > > +maintainers:
> > > > +  - can't find a mantainer, author is Daniel Baluta <daniel.baluta@intel.com>  
> > > 
> > > Daniel is still active in the kernel, just not at Intel any more. +CC
> > >   
> > 
> > Oh ok thank you! Daniel are you still maintaining this driver?
> > 
> > > > +
> > > > +description: |
> > > > +  Inertial Measurement Unit with Accelerometer, Gyroscope and externally
> > > > +  connectable Magnetometer
> > > > +  https://www.bosch-sensortec.com/bst/products/all_products/bmi160
> > > > +
> > > > +properties:
> > > > +  compatible:
> > > > +    const: bosch,bmi160
> > > > +
> > > > +  reg:
> > > > +    maxItems: 1
> > > > +    description: the I2C address or SPI chip select number of the sensor  
> > > 
> > > As standard for i2c and spi, usually no need to have a description line for
> > > this element.
> > >   
> > 
> > Thank you, will remove the description then.
> > 
> > > > +
> > > > +  spi-max-frequency:
> > > > +    maxItems: 1
> > > > +    description: set maximum clock frequency (required only for SPI)  
> > > 
> > > Standard spi binding.  Probably doesn't need to be included here.
> > >   
> > 
> > So should I completely remove it from properties?
> 
> Yes
> 
> 
> Thanks,
> 
> Jonathan

Ok I will remove it completely in next patch,
Thank you,

Best regards,
Jonathan Albrieux
