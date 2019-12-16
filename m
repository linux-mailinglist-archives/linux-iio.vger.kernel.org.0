Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD06121BBE
	for <lists+linux-iio@lfdr.de>; Mon, 16 Dec 2019 22:33:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbfLPVcn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Dec 2019 16:32:43 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:33930 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726681AbfLPVcn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 16 Dec 2019 16:32:43 -0500
Received: by mail-oi1-f195.google.com with SMTP id l136so4536153oig.1;
        Mon, 16 Dec 2019 13:32:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IwX6HJZp4kUU0mQp40RPAIjG9iBuDE869U4douXPaCM=;
        b=oRFCYraemLikzKtfQPGf0LIsieSX34DZvEqiQ04x7dt68F3LfK+R4bgpc4POk7Vj2W
         Pwm7txAeSYRLuXpHhlaGOXs2dqbG/VdOvI7EX5aayjg7vovieqqiHIeuoeqNnyaxRPkX
         Lb85yQANb7heXkI13RoLyFRdScXlcjUyx3WkgLr0u0dHsYap11X2a3SclP+UlW5MAxCi
         p5AF5kO6fXM6KaIaoP39OBRM2INPi9FijmS9ftXqlCjDUqMGHRe+JfIrwrTFN2oQhUnB
         0VYuJ6wWyXfjfAXI+6jocxfWjMZ496B9qs7d33sS2/sAPzmWY9jDJ6n9jMl6XhN+TEII
         yVwg==
X-Gm-Message-State: APjAAAWpymeLUJY4dcJVRE9ayeN/52OonEaAV1M2J4OR2rFZJbtUqNnL
        uToC52yJN4orDx1BZQSW/HNWFVU=
X-Google-Smtp-Source: APXvYqyYoLgBFZUpZNtijSy8O8SasS0luLaBe0bGajSGqQBBqoLECG2BqHBeXpEAA+UelSKWQG+g1w==
X-Received: by 2002:aca:5490:: with SMTP id i138mr672651oib.69.1576531961744;
        Mon, 16 Dec 2019 13:32:41 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l128sm7166832oif.55.2019.12.16.13.32.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2019 13:32:41 -0800 (PST)
Date:   Mon, 16 Dec 2019 15:32:40 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     tomislav.denis@avl.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 3/3] bindings: iio: pressure: Add dlh-i2c documentation
Message-ID: <20191216213240.GA19920@bogus>
References: <20191204100354.16652-1-tomislav.denis@avl.com>
 <20191204100354.16652-4-tomislav.denis@avl.com>
 <20191207113442.08260820@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191207113442.08260820@archlinux>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Dec 07, 2019 at 11:34:42AM +0000, Jonathan Cameron wrote:
> On Wed, 4 Dec 2019 11:03:54 +0100
> <tomislav.denis@avl.com> wrote:
> 
> > From: Tomislav Denis <tomislav.denis@avl.com>
> > 
> > Add a device tree binding documentation for DLH series pressure
> > sensors.
> > 
> > Signed-off-by: Tomislav Denis <tomislav.denis@avl.com>
> 
> One question for DT maintainers.  
> 
> Should the file be named after a specific part of is a generic
> name for the parts covered acceptable?  I would assume it should
> be a part number, but not sure what precedence there is.

I would use asc,dlhl60.yaml I think. The rule is match the compatible if 
there's only one. Otherwise, no hard rule really. Use the first/oldest 
compatible, do wildcard, or vendor prefix and something else.

> Otherwise looks good to me, but I will let it sit to give time
> for DT review.
> 
> Thanks,
> 
> Jonathan
> 
> > ---
> >  .../bindings/iio/pressure/asc,dlh-i2c.yaml         | 51 ++++++++++++++++++++++
> >  MAINTAINERS                                        |  1 +
> >  2 files changed, 52 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/pressure/asc,dlh-i2c.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/pressure/asc,dlh-i2c.yaml b/Documentation/devicetree/bindings/iio/pressure/asc,dlh-i2c.yaml
> > new file mode 100644
> > index 0000000..5de2277
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/pressure/asc,dlh-i2c.yaml
> > @@ -0,0 +1,51 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/pressure/dlh-i2c.yaml#

Note that the filename doesn't match here. Run 'make dt_binding_check'.

> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: All Sensors DLH series low voltage digital pressure sensors
> > +
> > +maintainers:
> > +  - Tomislav Denis <tomislav.denis@avl.com>
> > +
> > +description: |
> > +  Bindings for the All Sensors DLH series pressure sensors.
> > +
> > +  Specifications about the sensors can be found at:
> > +    http://www.allsensors.com/cad/DS-0355_Rev_B.PDF
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - asc,dlhl60d
> > +      - asc,dlhl60g
> > +
> > +  reg:
> > +    description: I2C device address
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    description: interrupt mapping for EOC(data ready) pin
> > +    maxItems: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +
> > +    i2c0 {
> > +      #address-cells = <1>;
> > +      #size-cells = <0>;
> > +
> > +      pressure@29 {
> > +          compatible = "asc,dlhl60d";
> > +          reg = <0x29>;
> > +          interrupt-parent = <&gpio0>;
> > +          interrupts = <10 IRQ_TYPE_EDGE_RISING>;
> > +      };
> > +    };
> > +...
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 39d6f0f..8f0eab0 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -674,6 +674,7 @@ W:	http://www.allsensors.com/
> >  S:	Maintained
> >  L:	linux-iio@vger.kernel.org
> >  F:	drivers/iio/pressure/dlh-i2c.c
> > +F:	Documentation/devicetree/bindings/iio/pressure/dlh-i2c.yaml
> >  
> >  ALLEGRO DVT VIDEO IP CORE DRIVER
> >  M:	Michael Tretter <m.tretter@pengutronix.de>
> 
