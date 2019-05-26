Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BBD92AB7C
	for <lists+linux-iio@lfdr.de>; Sun, 26 May 2019 19:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbfEZRuP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 26 May 2019 13:50:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:35844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727950AbfEZRuP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 26 May 2019 13:50:15 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B3D72075E;
        Sun, 26 May 2019 17:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558893013;
        bh=4RM6HYIAkVdicbPI6ObbbcySK0L/DNIMzRDkdPiV9xc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=2nePc8kXjKAIecH5nsEySC0xpCHkO7tXgcqhLSa7cdB4eWBm1aLeXvyaLSZ8YxQFJ
         CFz9W5r9rxJ31VZl6T13wpl8TeNye4CSsVD+Dk5/HUS9Qs508vJB4HCwMPu1QD7VV1
         jA7+41sT0Ff9byeYatkYAf8S4wrYVdUOvACdzVWg=
Date:   Sun, 26 May 2019 18:50:07 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Renato Lui Geh <renatogeh@gmail.com>
Cc:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "kernel-usp@googlegroups.com" <kernel-usp@googlegroups.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "Popa, Stefan Serban" <StefanSerban.Popa@analog.com>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] dt-bindings: iio: adc: add adi,ad7780.yaml binding
Message-ID: <20190526185007.41b5f016@archlinux>
In-Reply-To: <20190525002801.ccq54fczbj3wxhan@renatolg>
References: <9992a318aec777b9b7788bb40d976aa89e5963fe.1558219042.git.renatogeh@gmail.com>
        <20190519123208.26c864ce@archlinux>
        <5d7ad2935d1e357f1c0885badc5ce3c351c8ed89.camel@analog.com>
        <20190525002801.ccq54fczbj3wxhan@renatolg>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 24 May 2019 21:28:02 -0300
Renato Lui Geh <renatogeh@gmail.com> wrote:

> Hi Jonathan, Alex,
> 
> Thanks for the review. Some comments inline.
> 
> Thanks,
> Renato
> 
> On 05/20, Ardelean, Alexandru wrote:
> >On Sun, 2019-05-19 at 12:32 +0100, Jonathan Cameron wrote:  
> >> [External]
> >>
> >>
> >> On Sat, 18 May 2019 19:41:12 -0300
> >> Renato Lui Geh <renatogeh@gmail.com> wrote:
> >>  
> >> > This patch adds a YAML binding for the Analog Devices AD7780/1 and
> >> > AD7170/1 analog-to-digital converters.
> >> >
> >> > Signed-off-by: Renato Lui Geh <renatogeh@gmail.com>  
> >>
> >> One comment inline.  I'll also be needing an ack from Analog on this,
> >> preferably Michael's.
> >>
> >> Thanks,
> >>
> >> Jonathan  
> >> > ---
> >> >  .../bindings/iio/adc/adi,ad7780.txt           | 48 -----------
> >> >  .../bindings/iio/adc/adi,ad7780.yaml          | 85 +++++++++++++++++++  
> >
> >You should also update the MAINTAINERS file.
> >Maybe in a following patch.
> >It looks like there is not entry in there, so maybe you need to add a new
> >one.
> >
> >Something like:
> >
> >
> >ANALOG DEVICES INC AD7780 DRIVER
> >M:      Michael Hennerich <Michael.Hennerich@analog.com>
> >M:      Renato Lui Geh <renatogeh@gmail.com>
> >L:      linux-iio@vger.kernel.org
> >W:      http://ez.analog.com/community/linux-device-drivers
> >S:      Supported
> >F:      drivers/iio/adc/ad7780.c
> >F:      Documentation/devicetree/bindings/iio/adc/adi,ad7780.yaml
> >
> >This should be after this block
> >ANALOG DEVICES INC AD7768-1 DRIVER
> >
> >Note that I added you as a co-maintainer.
> >If you want, you do not need to add that line.
> >  
> >> >  2 files changed, 85 insertions(+), 48 deletions(-)
> >> >  delete mode 100644
> >> > Documentation/devicetree/bindings/iio/adc/adi,ad7780.txt
> >> >  create mode 100644
> >> > Documentation/devicetree/bindings/iio/adc/adi,ad7780.yaml
> >> >
> >> > diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7780.txt
> >> > b/Documentation/devicetree/bindings/iio/adc/adi,ad7780.txt
> >> > deleted file mode 100644
> >> > index 440e52555349..000000000000
> >> > --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7780.txt
> >> > +++ /dev/null
> >> > @@ -1,48 +0,0 @@
> >> > -* Analog Devices AD7170/AD7171/AD7780/AD7781
> >> > -
> >> > -Data sheets:
> >> > -
> >> > -- AD7170:
> >> > -     *
> >> > https://www.analog.com/media/en/technical-documentation/data-sheets/AD7170.pdf
> >> > -- AD7171:
> >> > -     *
> >> > https://www.analog.com/media/en/technical-documentation/data-sheets/AD7171.pdf
> >> > -- AD7780:
> >> > -     *
> >> > https://www.analog.com/media/en/technical-documentation/data-sheets/ad7780.pdf
> >> > -- AD7781:
> >> > -     *
> >> > https://www.analog.com/media/en/technical-documentation/data-sheets/AD7781.pdf
> >> > -
> >> > -Required properties:
> >> > -
> >> > -- compatible: should be one of
> >> > -     * "adi,ad7170"
> >> > -     * "adi,ad7171"
> >> > -     * "adi,ad7780"
> >> > -     * "adi,ad7781"
> >> > -- reg: spi chip select number for the device
> >> > -- vref-supply: the regulator supply for the ADC reference voltage
> >> > -
> >> > -Optional properties:
> >> > -
> >> > -- powerdown-gpios:  must be the device tree identifier of the PDRST
> >> > pin. If
> >> > -                 specified, it will be asserted during driver probe.
> >> > As the
> >> > -                 line is active high, it should be marked
> >> > GPIO_ACTIVE_HIGH.
> >> > -- adi,gain-gpios:   must be the device tree identifier of the GAIN
> >> > pin. Only for
> >> > -                 the ad778x chips. If specified, it will be asserted
> >> > during
> >> > -                 driver probe. As the line is active low, it should be
> >> > marked
> >> > -                 GPIO_ACTIVE_LOW.
> >> > -- adi,filter-gpios: must be the device tree identifier of the FILTER
> >> > pin. Only
> >> > -                 for the ad778x chips. If specified, it will be
> >> > asserted
> >> > -                 during driver probe. As the line is active low, it
> >> > should be
> >> > -                 marked GPIO_ACTIVE_LOW.
> >> > -
> >> > -Example:
> >> > -
> >> > -adc@0 {
> >> > -     compatible =  "adi,ad7780";
> >> > -     reg =         <0>;
> >> > -     vref-supply = <&vdd_supply>
> >> > -
> >> > -     powerdown-gpios  = <&gpio 12 GPIO_ACTIVE_HIGH>;
> >> > -     adi,gain-gpios   = <&gpio  5 GPIO_ACTIVE_LOW>;
> >> > -     adi,filter-gpios = <&gpio 15 GPIO_ACTIVE_LOW>;
> >> > -};
> >> > diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7780.yaml
> >> > b/Documentation/devicetree/bindings/iio/adc/adi,ad7780.yaml
> >> > new file mode 100644
> >> > index 000000000000..931bc4f8ec04
> >> > --- /dev/null
> >> > +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7780.yaml
> >> > @@ -0,0 +1,85 @@
> >> > +# SPDX-License-Identifier: GPL-2.0
> >> > +%YAML 1.2
> >> > +---
> >> > +$id: http://devicetree.org/schemas/iio/adc/adi,ad7780.yaml#
> >> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >> > +
> >> > +title: Analog Devices AD7170/AD7171/AD7780/AD7781 analog to digital
> >> > converters
> >> > +
> >> > +maintainers:
> >> > +  - Michael Hennerich <michael.hennerich@analog.com>
> >> > +
> >> > +description: |
> >> > +  The ad7780 is a sigma-delta analog to digital converter. This driver
> >> > provides
> >> > +  reading voltage values and status bits from both the ad778x and
> >> > ad717x series.
> >> > +  Its interface also allows writing on the FILTER and GAIN GPIO pins
> >> > on the
> >> > +  ad778x.
> >> > +
> >> > +  Specifications on the converters can be found at:
> >> > +    AD7170:
> >> > +
> >> > https://www.analog.com/media/en/technical-documentation/data-sheets/AD7170.pdf
> >> > +    AD7171:
> >> > +
> >> > https://www.analog.com/media/en/technical-documentation/data-sheets/AD7171.pdf
> >> > +    AD7780:
> >> > +
> >> > https://www.analog.com/media/en/technical-documentation/data-sheets/ad7780.pdf
> >> > +    AD7781:
> >> > +
> >> > https://www.analog.com/media/en/technical-documentation/data-sheets/AD7781.pdf
> >> > +
> >> > +properties:
> >> > +  compatible:
> >> > +    enum:
> >> > +      - adi,ad7170
> >> > +      - adi,ad7171
> >> > +      - adi,ad7780
> >> > +      - adi,ad7781
> >> > +
> >> > +  reg:
> >> > +    description:
> >> > +      Chip select number for the device  
> >
> >No need to add a description.
> >This is pretty standard.
> >  
> >> > +    maxItems: 1
> >> > +
> >> > +  vref-supply:
> >> > +    description:
> >> > +      The regulator supply for the ADC reference voltage
> >> > +    maxItems: 1
> >> > +  
> >
> >As I see in the driver, it's not vref-supply, it's avdd-supply.  
> 
> You're absolutely right. Shouldn't have mindlessly copied
> from the txt, even though the txt's was also my fault.
> 
> By the way, a quick look at ad7170 and ad7780's datasheets
> shows that the 7170 uses VDD, and the 7780, AVDD. Are they
> equivalent?
> >  
> >> > +  powerdown-gpios:
> >> > +    description:
> >> > +      Must be the device tree identifier of the PDRST pin. If
> >> > +      specified, it will be asserted during driver probe. As the
> >> > +      line is active high, it should be marked GPIO_ACTIVE_HIGH.
> >> > +    maxItems: 1
> >> > +
> >> > +  adi,gain-gpios:
> >> > +    description:
> >> > +      Must be the device tree identifier of the GAIN pin. Only for
> >> > +      the ad778x chips. If specified, it will be asserted during
> >> > +      driver probe. As the line is active low, it should be marked
> >> > +      GPIO_ACTIVE_LOW.
> >> > +    maxItems: 1
> >> > +
> >> > +  adi,filter-gpios:
> >> > +    description:
> >> > +      Must be the device tree identifier of the FILTER pin. Only
> >> > +      for the ad778x chips. If specified, it will be asserted
> >> > +      during driver probe. As the line is active low, it should be
> >> > +      marked GPIO_ACTIVE_LOW.
> >> > +    maxItems: 1
> >> > +
> >> > +required:
> >> > +  - compatible
> >> > +  - reg
> >> > +  - vref-supply  
> >>
> >> Is that actually true?  I'd imagine it'll use a stub regulator if
> >> it isn't supplied.  
> >
> >Hmm, I also think this can be omitted as required.
> >devm_regulator_get() is used.
> >devm_regulator_get_exclusive() would be needed to make this required.  
> 
> I see. So the difference between devm_regulator_get and
> devm_regulator_get_optional is that the former uses a stub
> when the requested reg isn't supplied, and the latter
> doesn't?
Correct.  If you 'require' a regulator you actually have to use
the optional form and then check if you got one. Otherwise you get
a stub and only find out later that you can't read it's current
value.

Jonathan

> >  
> >>  
> >> > +
> >> > +examples:
> >> > +  - |
> >> > +    #include <dt-bindings/gpio/gpio.h>
> >> > +    adc@0 {  
> >
> >The adc@0 block should be included in a spi block.
> >
> >So, something like
> >
> >spi0 {
> >     adc@0 {
> >            compatible =  "adi,ad7780";
> >            reg =         <0>;
> >            avdd-supply = <&vdd_supply>
> >
> >            powerdown-gpios  = <&gpio 12 GPIO_ACTIVE_HIGH>;
> >            adi,gain-gpios   = <&gpio  5 GPIO_ACTIVE_LOW>;
> >            adi,filter-gpios = <&gpio 15 GPIO_ACTIVE_LOW>;
> >     };
> >};
> >
> >I know this wasn't the case before, but it should be (from what I recall).
> >  
> >> > +      compatible =  "adi,ad7780";
> >> > +      reg = <0>;
> >> > +      vref-supply = <&vdd_supply>;
> >> > +
> >> > +      powerdown-gpios  = <&gpio0 12 GPIO_ACTIVE_HIGH>;
> >> > +      adi,gain-gpios   = <&gpio1  5 GPIO_ACTIVE_LOW>;
> >> > +      adi,filter-gpios = <&gpio2 15 GPIO_ACTIVE_LOW>;  
> >
> >Rest looks good.
> >
> >Thanks
> >Alex
> >  
> >> > +    };  
> >>
> >>  

