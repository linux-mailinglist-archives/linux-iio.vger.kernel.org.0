Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC2A39D15
	for <lists+linux-iio@lfdr.de>; Sat,  8 Jun 2019 13:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbfFHLS6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 8 Jun 2019 07:18:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:51382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726872AbfFHLS6 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 8 Jun 2019 07:18:58 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 70EFA214AE;
        Sat,  8 Jun 2019 11:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559992737;
        bh=HN0WFC0hmo9elGNi83hFSQjpI/VdKNPn0HhBOSjD0T0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bROtBkhVP8qeN8x8QusNxhD2lwM1o8jfRU6LSEpbrTqa02WvlntqHVJgI9LQ8nBR1
         RuCHdqMLdlTpgbFoIUslkeqgNOUFBOIpRS/GIdy93nXCkh1d3GY1svLCNLr+GxP3Ba
         s8LusERe0EEcgzjdvBPCUCtGA01Tsep9goq/+jes=
Date:   Sat, 8 Jun 2019 12:18:51 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jonathan Cameron <jonathan.cameron@huawei.com>
Cc:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "renatogeh@gmail.com" <renatogeh@gmail.com>,
        "Popa, Stefan Serban" <StefanSerban.Popa@analog.com>,
        "kernel-usp@googlegroups.com" <kernel-usp@googlegroups.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: adc: add adi,ad7780.yaml
 binding
Message-ID: <20190608121851.7ad02e33@archlinux>
In-Reply-To: <20190606165214.00006f09@huawei.com>
References: <cover.1558746978.git.renatogeh@gmail.com>
        <2426649b2d8224ae72e7706bcb8c4f2c44c581d2.1558746978.git.renatogeh@gmail.com>
        <20190526173911.57ae3d11@archlinux>
        <20190605203554.podktlonhp527iqq@renatolg>
        <d70b1ffcc903495cd5eac04e17fd1600e67b9c53.camel@analog.com>
        <20190606165214.00006f09@huawei.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 6 Jun 2019 16:52:14 +0100
Jonathan Cameron <jonathan.cameron@huawei.com> wrote:

> On Thu, 6 Jun 2019 11:13:52 +0000
> "Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:
> 
> > On Wed, 2019-06-05 at 17:35 -0300, Renato Lui Geh wrote:  
> > > [External]
> > > 
> > > 
> > > On 05/26, Jonathan Cameron wrote:    
> > > > On Fri, 24 May 2019 22:26:30 -0300
> > > > Renato Lui Geh <renatogeh@gmail.com> wrote:
> > > >     
> > > > > This patch adds a YAML binding for the Analog Devices AD7780/1 and
> > > > > AD7170/1 analog-to-digital converters.
> > > > > 
> > > > > Signed-off-by: Renato Lui Geh <renatogeh@gmail.com>    
> > > > Looks good to me, but I'm still finding my feet with these so will
> > > > leave it for a few days for others to have time to comment.
> > > > 
> > > > Michael, looking for a quick reply from you to say if you are happy
> > > > being explicitly listed as maintainer for this one, or if you'd
> > > > rather land it on someone else.  Same applies for patch 2.
> > > > 
> > > > Renato, if I seem to have forgotten this in a week or so, feel
> > > > free to give me a poke. I've been known to loose patches entirely!    
> > > 
> > > Hi Jonathan,
> > > 
> > > Just here to give you a poke. :)
> > > 
> > > By the way, in these cases, which would be easier for you? To send you
> > > an email like I'm doing right now on last week's thread; or to resend
> > > the entire patch(set)?
> > >     
> > 
> > I think in this case, maybe let's wait a bit longer.
> > Jonathan has not been active recently.
> > 
> > I think a [RESEND] would be a good idea when he gets back/active and misses your patchset.
> >   
> Sorry, was away last weekend and haven't caught up since.
> 
> I should be fine to pick this up this weekend.
> 
> A ping like this is fine rather than a resend.

I've applied this the togreg branch of iio.git and pushed out as testing.

Note I'm not planning a pull request for a week or so, so welcome
any additional comments anyone has when they are able to make them.

Thanks,

Jonathan

> 
> Thanks,
> 
> Jonathan
> 
> > Thanks
> > Alex
> >   
> > > Thanks,
> > > Renato    
> > > > Thanks,
> > > > 
> > > > Jonathan    
> > > > > ---
> > > > > Changes in v2:
> > > > >  - vref-supply to avdd-supply
> > > > >  - remove avdd-supply from required list
> > > > >  - include adc block in an spi block
> > > > > 
> > > > >  .../bindings/iio/adc/adi,ad7780.txt           | 48 ----------
> > > > >  .../bindings/iio/adc/adi,ad7780.yaml          | 87 +++++++++++++++++++
> > > > >  2 files changed, 87 insertions(+), 48 deletions(-)
> > > > >  delete mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7780.txt
> > > > >  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7780.yaml
> > > > > 
> > > > > diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7780.txt
> > > > > b/Documentation/devicetree/bindings/iio/adc/adi,ad7780.txt
> > > > > deleted file mode 100644
> > > > > index 440e52555349..000000000000
> > > > > --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7780.txt
> > > > > +++ /dev/null
> > > > > @@ -1,48 +0,0 @@
> > > > > -* Analog Devices AD7170/AD7171/AD7780/AD7781
> > > > > -
> > > > > -Data sheets:
> > > > > -
> > > > > -- AD7170:
> > > > > -    * https://www.analog.com/media/en/technical-documentation/data-sheets/AD7170.pdf
> > > > > -- AD7171:
> > > > > -    * https://www.analog.com/media/en/technical-documentation/data-sheets/AD7171.pdf
> > > > > -- AD7780:
> > > > > -    * https://www.analog.com/media/en/technical-documentation/data-sheets/ad7780.pdf
> > > > > -- AD7781:
> > > > > -    * https://www.analog.com/media/en/technical-documentation/data-sheets/AD7781.pdf
> > > > > -
> > > > > -Required properties:
> > > > > -
> > > > > -- compatible: should be one of
> > > > > -    * "adi,ad7170"
> > > > > -    * "adi,ad7171"
> > > > > -    * "adi,ad7780"
> > > > > -    * "adi,ad7781"
> > > > > -- reg: spi chip select number for the device
> > > > > -- vref-supply: the regulator supply for the ADC reference voltage
> > > > > -
> > > > > -Optional properties:
> > > > > -
> > > > > -- powerdown-gpios:  must be the device tree identifier of the PDRST pin. If
> > > > > -                specified, it will be asserted during driver probe. As the
> > > > > -                line is active high, it should be marked GPIO_ACTIVE_HIGH.
> > > > > -- adi,gain-gpios:   must be the device tree identifier of the GAIN pin. Only for
> > > > > -                the ad778x chips. If specified, it will be asserted during
> > > > > -                driver probe. As the line is active low, it should be marked
> > > > > -                GPIO_ACTIVE_LOW.
> > > > > -- adi,filter-gpios: must be the device tree identifier of the FILTER pin. Only
> > > > > -                for the ad778x chips. If specified, it will be asserted
> > > > > -                during driver probe. As the line is active low, it should be
> > > > > -                marked GPIO_ACTIVE_LOW.
> > > > > -
> > > > > -Example:
> > > > > -
> > > > > -adc@0 {
> > > > > -    compatible =  "adi,ad7780";
> > > > > -    reg =         <0>;
> > > > > -    vref-supply = <&vdd_supply>
> > > > > -
> > > > > -    powerdown-gpios  = <&gpio 12 GPIO_ACTIVE_HIGH>;
> > > > > -    adi,gain-gpios   = <&gpio  5 GPIO_ACTIVE_LOW>;
> > > > > -    adi,filter-gpios = <&gpio 15 GPIO_ACTIVE_LOW>;
> > > > > -};
> > > > > diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7780.yaml
> > > > > b/Documentation/devicetree/bindings/iio/adc/adi,ad7780.yaml
> > > > > new file mode 100644
> > > > > index 000000000000..d1109416963c
> > > > > --- /dev/null
> > > > > +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7780.yaml
> > > > > @@ -0,0 +1,87 @@
> > > > > +# SPDX-License-Identifier: GPL-2.0
> > > > > +%YAML 1.2
> > > > > +---
> > > > > +$id: http://devicetree.org/schemas/iio/adc/adi,ad7780.yaml#
> > > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > > +
> > > > > +title: Analog Devices AD7170/AD7171/AD7780/AD7781 analog to digital converters
> > > > > +
> > > > > +maintainers:
> > > > > +  - Michael Hennerich <michael.hennerich@analog.com>
> > > > > +
> > > > > +description: |
> > > > > +  The ad7780 is a sigma-delta analog to digital converter. This driver provides
> > > > > +  reading voltage values and status bits from both the ad778x and ad717x series.
> > > > > +  Its interface also allows writing on the FILTER and GAIN GPIO pins on the
> > > > > +  ad778x.
> > > > > +
> > > > > +  Specifications on the converters can be found at:
> > > > > +    AD7170:
> > > > > +      https://www.analog.com/media/en/technical-documentation/data-sheets/AD7170.pdf
> > > > > +    AD7171:
> > > > > +      https://www.analog.com/media/en/technical-documentation/data-sheets/AD7171.pdf
> > > > > +    AD7780:
> > > > > +      https://www.analog.com/media/en/technical-documentation/data-sheets/ad7780.pdf
> > > > > +    AD7781:
> > > > > +      https://www.analog.com/media/en/technical-documentation/data-sheets/AD7781.pdf
> > > > > +
> > > > > +properties:
> > > > > +  compatible:
> > > > > +    enum:
> > > > > +      - adi,ad7170
> > > > > +      - adi,ad7171
> > > > > +      - adi,ad7780
> > > > > +      - adi,ad7781
> > > > > +
> > > > > +  reg:
> > > > > +    maxItems: 1
> > > > > +
> > > > > +  avdd-supply:
> > > > > +    description:
> > > > > +      The regulator supply for the ADC reference voltage.
> > > > > +    maxItems: 1
> > > > > +
> > > > > +  powerdown-gpios:
> > > > > +    description:
> > > > > +      Must be the device tree identifier of the PDRST pin. If
> > > > > +      specified, it will be asserted during driver probe. As the
> > > > > +      line is active high, it should be marked GPIO_ACTIVE_HIGH.
> > > > > +    maxItems: 1
> > > > > +
> > > > > +  adi,gain-gpios:
> > > > > +    description:
> > > > > +      Must be the device tree identifier of the GAIN pin. Only for
> > > > > +      the ad778x chips. If specified, it will be asserted during
> > > > > +      driver probe. As the line is active low, it should be marked
> > > > > +      GPIO_ACTIVE_LOW.
> > > > > +    maxItems: 1
> > > > > +
> > > > > +  adi,filter-gpios:
> > > > > +    description:
> > > > > +      Must be the device tree identifier of the FILTER pin. Only
> > > > > +      for the ad778x chips. If specified, it will be asserted
> > > > > +      during driver probe. As the line is active low, it should be
> > > > > +      marked GPIO_ACTIVE_LOW.
> > > > > +    maxItems: 1
> > > > > +
> > > > > +required:
> > > > > +  - compatible
> > > > > +  - reg
> > > > > +
> > > > > +examples:
> > > > > +  - |
> > > > > +    #include <dt-bindings/gpio/gpio.h>
> > > > > +    spi0 {
> > > > > +        #address-cells = <1>;
> > > > > +        #size-cells = <0>;
> > > > > +
> > > > > +        adc@0 {
> > > > > +            compatible = "adi,ad7780";
> > > > > +            reg = <0>;
> > > > > +
> > > > > +            avdd-supply      = <&vdd_supply>;
> > > > > +            powerdown-gpios  = <&gpio0 12 GPIO_ACTIVE_HIGH>;
> > > > > +            adi,gain-gpios   = <&gpio1  5 GPIO_ACTIVE_LOW>;
> > > > > +            adi,filter-gpios = <&gpio2 15 GPIO_ACTIVE_LOW>;
> > > > > +        };
> > > > > +    };    
> 
> 

