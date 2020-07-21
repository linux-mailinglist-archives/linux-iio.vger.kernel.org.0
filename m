Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4D282275CA
	for <lists+linux-iio@lfdr.de>; Tue, 21 Jul 2020 04:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728105AbgGUCla (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Jul 2020 22:41:30 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:36836 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbgGUCl3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Jul 2020 22:41:29 -0400
Received: by mail-io1-f65.google.com with SMTP id y2so19819947ioy.3;
        Mon, 20 Jul 2020 19:41:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BZy2xot0litRpRXUXxFeIS+8iZe62kRKLBlNU28eJM8=;
        b=goxaWbDN7UbxgrLVNMoEcRWg1nmYGHBA0lgI4AUOjxNVlVs9zd7j6fi9k84exhsLgO
         +pMTSKYQzashKrXqrXHBmVnC8EkD6OfDTjiate9hfBrEvWbZlDIl1iHd332iVQAhh66d
         uRuwc0c8KmXhi5vPDh4+LDhlaxV5PO7mkAkus3G10am/YUgZIb4XXF0vkpuKWA/FlsuX
         i8J3fYJYEKevfmssFmlll/i9m8xQu9D+TX4VwzYmZ9uSuJMe78H8rFGufGm79n0mYMMD
         dDjbyvS8DpJlroCRh0HR2icOLUwM0N0ceiKJcxGv09hHMpT/jU9wkB0N331l2UMkBaL0
         JZEg==
X-Gm-Message-State: AOAM531zRxOJU6kW96zia08aq0MrNhftH5ZQ9LtCqJesM2ZtJT4mQKkI
        6hrolBs0ZNWmQhoOAMvdTA==
X-Google-Smtp-Source: ABdhPJx4wq0CR+X1AHsiljLR1qaEuDnmuF0lW90cd/SQASfiIUerJAsLgi1pCx0HCFuTeO43eQ1+aw==
X-Received: by 2002:a5d:8f04:: with SMTP id f4mr26004570iof.33.1595299288770;
        Mon, 20 Jul 2020 19:41:28 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id w10sm9820954ilo.10.2020.07.20.19.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 19:41:28 -0700 (PDT)
Received: (nullmailer pid 3432124 invoked by uid 1000);
        Tue, 21 Jul 2020 02:41:27 -0000
Date:   Mon, 20 Jul 2020 20:41:27 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>,
        Nishant Malpani <nish.malpani25@gmail.com>
Cc:     dragos.bogdan@analog.com, darius.berghe@analog.com,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: iio: gyro: Add DT binding doc for
 ADXRS290
Message-ID: <20200721024127.GA3429416@bogus>
References: <20200715092821.14625-1-nish.malpani25@gmail.com>
 <20200720121633.7a9e5cd7@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200720121633.7a9e5cd7@archlinux>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Jul 20, 2020 at 12:16:33PM +0100, Jonathan Cameron wrote:
> On Wed, 15 Jul 2020 14:58:21 +0530
> Nishant Malpani <nish.malpani25@gmail.com> wrote:
> 
> > Add devicetree binding document for ADXRS290, a dual-axis MEMS gyroscope.
> > 
> > Signed-off-by: Nishant Malpani <nish.malpani25@gmail.com>
> > ---
> >  .../bindings/iio/gyroscope/adi,adxrs290.yaml  | 52 +++++++++++++++++++
> >  MAINTAINERS                                   |  1 +
> >  2 files changed, 53 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/gyroscope/adi,adxrs290.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/gyroscope/adi,adxrs290.yaml b/Documentation/devicetree/bindings/iio/gyroscope/adi,adxrs290.yaml
> > new file mode 100644
> > index 000000000000..a997d945fdb0
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/gyroscope/adi,adxrs290.yaml
> > @@ -0,0 +1,52 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +# Copyright 2020 Analog Devices Inc.
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/gyroscope/adi,adxrs290.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Analog Devices ADXRS290 Dual-Axis MEMS Gyroscope
> > +
> > +maintainers:
> > +  - Nishant Malpani <nish.malpani25@gmail.com>
> > +
> > +description: |
> > +  Bindings for the Analog Devices ADXRS290 dual-axis MEMS gyroscope device.
> > +  https://www.analog.com/media/en/technical-documentation/data-sheets/ADXRS290.pdf
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - adi,adxrs290
> 
> I think we can use const here as only one item currently.

Yep. Really depends if you expect to add more.

> 
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  spi-max-frequency:
> > +    maximum: 5000000
> > +
> > +  spi-cpol: true
> > +
> > +  spi-cpha: true
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - spi-max-frequency
> > +  - spi-cpol
> > +  - spi-cpha

Add:

additionalProperties: false

> > +
> > +examples:
> > +  - |
> > +    spi {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +        gyro@0 {
> > +                   compatible = "adi,adxrs290";
> > +                   reg = <0>;
> > +                   spi-max-frequency = <5000000>;
> > +                   spi-cpol;
> > +                   spi-cpha;
> > +        };
> > +    };
> > +...
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index dd02cfc410e8..0bb8ac90fba1 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -1103,6 +1103,7 @@ M:	Nishant Malpani <nish.malpani25@gmail.com>
> >  L:	linux-iio@vger.kernel.org
> >  S:	Supported
> >  F:	drivers/iio/gyro/adxrs290.c
> > +F:	Documentation/devicetree/bindings/iio/gyroscope/adi,adxrs290.yaml
> >  
> >  ANALOG DEVICES INC ASOC CODEC DRIVERS
> >  M:	Lars-Peter Clausen <lars@metafoo.de>
> 
