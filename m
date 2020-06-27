Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2828F20C27B
	for <lists+linux-iio@lfdr.de>; Sat, 27 Jun 2020 16:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726057AbgF0Oqu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 27 Jun 2020 10:46:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:42860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725850AbgF0Oqu (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 27 Jun 2020 10:46:50 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 53F2D208B6;
        Sat, 27 Jun 2020 14:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593269209;
        bh=8mD5HfkoOC5sXuSWLshxJieEpfSpC92uKbIm8U25v2A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=1tX2ZrQ1EbCeFH05x6zhrOe1TN5vR7nqAlmHSUf0VK3noFpEnBhXHTkv1vXgYqLVx
         McyoHcGIwshwLQVMd1ttN18d8yo8+K7wPpb2/ZKhz/mVeDWiFjig6597blZXjOkaSS
         MtDzbgU0WIEg4yi4siPbuE7mIpAm1AYbfMs2/h8E=
Date:   Sat, 27 Jun 2020 15:46:46 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Berghe, Darius" <Darius.Berghe@analog.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v1 3/3] iio:adc:ltc2471: add dt binding yaml
Message-ID: <20200627154646.012ffd10@archlinux>
In-Reply-To: <053ba6af36636cb5b87c885ef1c6e157405e4412.camel@analog.com>
References: <20200617133523.58158-1-darius.berghe@analog.com>
        <20200617133523.58158-3-darius.berghe@analog.com>
        <20200620163124.29d9cd38@archlinux>
        <053ba6af36636cb5b87c885ef1c6e157405e4412.camel@analog.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 22 Jun 2020 08:05:13 +0000
"Berghe, Darius" <Darius.Berghe@analog.com> wrote:

> On Sat, 2020-06-20 at 16:31 +0100, Jonathan Cameron wrote:
> > [External]
> > 
> > On Wed, 17 Jun 2020 16:35:23 +0300
> > Darius Berghe <darius.berghe@analog.com> wrote:
> >   
> > > Add dt binding documentation for ltc2471 driver. This covers all supported
> > > devices.
> > > 
> > > Signed-off-by: Darius Berghe <darius.berghe@analog.com>  
> > A few things inline but basically fine.
> > 
> > We should however also think about documenting power supplies.
> > Even though the driver doesn't currently control the binding should
> > be as complete as possible.
> > 
> > Jonathan
> >   
> Hi Jonathan,
> 
> And thanks for the review !

> 
> This chips have a fixed internal vref of 1.25V that is output on the REFOUT pin,
> there is no place for configuration here. Or perhaps did you mean the VCC (2.7V-5.5V) ?

Yes, VCC was what I was referring to.

> I'm not sure what the added value would be to add vref-supply and vcc-supply to yaml
> if they are not implemented. I find it confusing.

Bindings are intended to describe the hardware rather than what we've implemented
support for in the driver.   It's fairly likely that we will end up supporting
regulator control sooner or later (tends to happen if a driver is getting much use
as someone will care about powering down the supplies when suspending etc).

So ideally we'd add support to the driver, but even if it's not there we can consider
adding it to the binding docs. However, it's not (to my mind) vital.

> 
> > > ---
> > >  .../bindings/iio/adc/adi,ltc2471.yaml         | 52 +++++++++++++++++++
> > >  1 file changed, 52 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ltc2471.yaml
> > > 
> > > diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ltc2471.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ltc2471.yaml
> > > new file mode 100644
> > > index 000000000000..0b84e14ec984
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/iio/adc/adi,ltc2471.yaml
> > > @@ -0,0 +1,52 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +# Copyright 2020 Analog Devices Inc.
> > > +%YAML 1.2
> > > +---
> > > +$id: https://urldefense.com/v3/__http://devicetree.org/schemas/bindings/iio/adc/adi,ltc2471.yaml*__;Iw!!A3Ni8CS0y2Y!vUpDwSslcaNrc3db6AQ6x3gzYHbR_WxOtQyPinkeZCjgpiQ4elEbjMzDs1OGEYZou4E$ 
> > > +$schema: https://urldefense.com/v3/__http://devicetree.org/meta-schemas/core.yaml*__;Iw!!A3Ni8CS0y2Y!vUpDwSslcaNrc3db6AQ6x3gzYHbR_WxOtQyPinkeZCjgpiQ4elEbjMzDs1OG4cmRuW4$ 
> > > +
> > > +title: Analog Devices LTC2471 16-bit I2C Sigma-Delta ADC
> > > +
> > > +maintainers:
> > > +  - Mike Looijmans <mike.looijmans@topic.nl>
> > > +
> > > +description: |
> > > +  Analog Devices LTC2471 (single-ended) and LTC2473 (differential) 16-bit
> > > +  I2C Sigma-Delta ADC with selectable 208/833sps output rate.
> > > +  https://www.analog.com/media/en/technical-documentation/data-sheets/24713fb.pdf
> > > +
> > > +  Analog Devices LTC2461 (single-ended) and LTC2463 (differential) 16-bit
> > > +  I2C Sigma-Delta ADC with 60sps output rate.
> > > +  https://www.analog.com/media/en/technical-documentation/data-sheets/24613fa.pdf  
> > 
> > Put these two blocks in numeric order.  If we end up adding a bunch more
> > devices it will be much more consistent if they are order.
> >   
> 
> Ack, will do.
> 
> > > +
> > > +properties:
> > > +  compatible:
> > > +    enum:
> > > +      - adi,ltc2471
> > > +      - adi,ltc2473
> > > +      - adi,ltc2461
> > > +      - adi,ltc2463  
> > 
> > Put them in numeric order.
> >   
> 
> Ack, will do.
> 
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +
> > > +examples:
> > > +  - |
> > > +    i2c0 {
> > > +      ltc2461@14 {  
> > 
> > Should use a generic name
> > adc@14
> >   
> 
> Ack, will do.
> 
> > > +        compatible = "ltc2461";
> > > +        reg = <0x14>;
> > > +      };
> > > +    };
> > > +  - |
> > > +    i2c0 {  
> > 
> > Not a lot of point in two examples given how similar they are.
> > I'd just keep the one. 
> >   
> 
> Ack, will do.
> I only chose to give two examples because the chip has 2 possible I2C slave addresses 0x14 and 0x54 depending on the AO pin value being low or high. But you're right, they're too simple and similar.

Agreed

Thanks,

Jonathan

> 
> Best regards,
> Darius
> 
> > > +      ltc2473@54 {
> > > +        compatible = "ltc2473";
> > > +        reg = <0x54>;
> > > +      };
> > > +    };
> > > +  

