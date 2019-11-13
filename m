Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD59FB2E2
	for <lists+linux-iio@lfdr.de>; Wed, 13 Nov 2019 15:52:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727640AbfKMOwG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 13 Nov 2019 09:52:06 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:38656 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727637AbfKMOwG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 13 Nov 2019 09:52:06 -0500
Received: by mail-qk1-f193.google.com with SMTP id e2so1944381qkn.5;
        Wed, 13 Nov 2019 06:52:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+TVONtKMnYlgKfuCSUQF9CV9h8e4BaOkNxZ+ZGZ6OVU=;
        b=mApGCYcyErV7zLFfy/nP6PCbiNXpGvXvKGnmPcBpe5j23rSoHRZ0c0Ut5rcEHnwutK
         mQzPh/GhYoM6t5JxAOWErtVyMwemtLo6vno7vv9gWZ0izHIYGs46xCc1ew4GnWiIglen
         eGzUG/zqeCUz8uazKLFEkF5mSL8EvEgQ/8VxYnOxuejEaqWD/DY9E0/8C0AHrmuXISUn
         I0bV5sf3VI67d3XavWXTp6xxoCGbRkzSKAYgsReJR+IVfQQUC5QVgVPdEqr8VIhmcXHC
         fPVtdSKH2ivRbm8Z8W57UUW1ot5mr4hM7CRV+YWTz5jzhSs67cBii1UiQC3XZDCYU71i
         Enhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+TVONtKMnYlgKfuCSUQF9CV9h8e4BaOkNxZ+ZGZ6OVU=;
        b=Bt9zhv9zFt+7EWFyZZ8Fb7wFV3122dCWcd0t2lWDAsBy2dDTn1raCZarx3psXh7l/1
         vbM/WfX90zuGE7tB29SC0M4d85rJSbJfOnVuwOORF7yny1Y+1GKXEeCJAyyTucnqzSJr
         5S5xgOZ7WkcB8RaD0SW2H1BxLk3fwywHPnRHn+frQi2f+S1n5bw48f42yYoRRn5YClnO
         p4YTSX4dg/2/dYapo3F+6oZuKFR6Ie53S/++DwDJFvhw9dAAnKwj1lfltZquAGZ+3MBd
         GGcCLUoBUjXStidf/MWaYqSNMUzvLj1oB6TQHuw/WP039QXwsZdLYSvWGpTElXXuy9gw
         QSjQ==
X-Gm-Message-State: APjAAAUu3lj4ZAMuUzhs3YPhsjufYuKb0iPXJbojKB23iqA70GeA1OMz
        PSZFZ1QzTt5FHxJ+2u3aImXkvkJW
X-Google-Smtp-Source: APXvYqwjXCIV15LPJW4fCFYIilYLxM9XtYn6XUXfXV20fxrKk9zW39txP4fLxmmCh8MlFtfOpabGrw==
X-Received: by 2002:a37:4f83:: with SMTP id d125mr2888805qkb.205.1573656725214;
        Wed, 13 Nov 2019 06:52:05 -0800 (PST)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id 130sm1075339qkd.33.2019.11.13.06.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2019 06:52:04 -0800 (PST)
Date:   Wed, 13 Nov 2019 11:52:00 -0300
From:   Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     jic23@kernel.org, dragos.bogdan@analog.com,
        alexandru.ardelean@analog.com, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        kernel-usp@googlegroups.com
Subject: Re: [PATCH v4 1/2] dt-bindings: iio: adc: Add dt-schema for AD7292
Message-ID: <20191113145159.vw7icflfve7dnefm@smtp.gmail.com>
References: <cover.1573145089.git.marcelo.schmitt1@gmail.com>
 <a8c614894252bb139a213b8c0219f3f46210b136.1573145089.git.marcelo.schmitt1@gmail.com>
 <20191112193942.GA27334@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191112193942.GA27334@bogus>
User-Agent: NeoMutt/20180716
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Rob,

Thanks for reviewing the binding doc again.
Aparently, this patch was added to Greg KH's staging tree.
What is the right procedure in this case? Should I send a v5 patchset or
just send a patch for this doc?

In any case, I still have some doubts about the maximum constraint of
the channel property. Comments inline.


Thanks

Marcelo

On 11/12, Rob Herring wrote:
> On Fri, Nov 08, 2019 at 10:56:09AM -0300, Marcelo Schmitt wrote:
> > Add a devicetree schema for AD7292 monitor and control system.
> > 
> > Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> > ---
> > Changelog V3 -> V4:
> > - updated SPDX identifier to GPL-2.0-only
> > - changed maxitems constraint on channel property
> > 
> >  .../bindings/iio/adc/adi,ad7292.yaml          | 104 ++++++++++++++++++
> >  MAINTAINERS                                   |   7 ++
> >  2 files changed, 111 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml
> > new file mode 100644
> > index 000000000000..b68be3aaf587
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml
> > @@ -0,0 +1,104 @@
> > +# SPDX-License-Identifier: GPL-2.0-only
> 
> Sigh, I gave you the exact line to use:
> 
> # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> 
> I've said to dual license with (GPL-2.0-only OR BSD-2-Clause) and people 
> think I mean to pick one. So now I just give the whole line. I don't 
> know how to be clearer.

I thought I could use just GPL-2.0 since the driver code is GPL-2.0.
Anyway, I'll use the above line to specify the dt-binding license.

> 
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/adc/adi,ad7292.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Analog Devices AD7292 10-Bit Monitor and Control System
> > +
> > +maintainers:
> > +  - Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> > +
> > +description: |
> > +  Analog Devices AD7292 10-Bit Monitor and Control System with ADC, DACs,
> > +  Temperature Sensor, and GPIOs
> > +
> > +  Specifications about the part can be found at:
> > +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7292.pdf
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - adi,ad7292
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  vref-supply:
> > +    description: |
> > +      The regulator supply for ADC and DAC reference voltage.
> > +
> > +  spi-cpha: true
> > +
> > +  '#address-cells':
> > +    const: 1
> > +
> > +  '#size-cells':
> > +    const: 0
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - spi-cpha
> > +
> > +patternProperties:
> > +  "^channel@[0-7]$":
> > +    type: object
> > +    description: |
> > +      Represents the external channels which are connected to the ADC.
> > +      See Documentation/devicetree/bindings/iio/adc/adc.txt.
> > +
> > +    properties:
> > +      reg:
> > +        description: |
> > +          The channel number. It can have up to 8 channels numbered from 0 to 7.
> > +        items:
> > +          maximum: 7
> 
> Not what I said either. A slight but important difference in that you 
> are missing a '-' to make 'items' a list rather than a schema/dict.
> 
> Update dt-schema. This should give a warning now.

I'm confused, I don't know how to make this doc the way you want.
I pulled the updates from the master branch of dt-schema repo and
reinstalled it.
Then I tried
        items:
          - maximum: 7
I've tried
        - items:
            maximum: 7
I also tried
        - items:
          maximum: 7
all gave me parsing errors when processing the ad7292 schema with 
'make dt_binding_check' and also with 'make -k dt_binding_check'.
Am I using the right branch? Should I pull from a branch other than the
master?
I was first inspired by the adi,ad7124.yaml doc which has a similar
channel declaration. Curiously, processing the ad7292 schema the way it
was in v4 gave me no errors so, I must be missing something.

> 
> > +
> > +      diff-channels:
> > +        description: see Documentation/devicetree/bindings/iio/adc/adc.txt
> > +        maxItems: 1
> > +
> > +    required:
> > +      - reg
> > +
> > +examples:
> > +  - |
> > +    spi {
> > +      #address-cells = <1>;
> > +      #size-cells = <0>;
> > +
> > +      ad7292: adc@0 {
> > +        compatible = "adi,ad7292";
> > +        reg = <0>;
> > +        spi-max-frequency = <25000000>;
> > +        vref-supply = <&adc_vref>;
> > +        spi-cpha;
> > +
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        channel@0 {
> > +          reg = <0>;
> > +          diff-channels = <0 1>;
> > +        };
> > +        channel@2 {
> > +          reg = <2>;
> > +        };
> > +        channel@3 {
> > +          reg = <3>;
> > +        };
> > +        channel@4 {
> > +          reg = <4>;
> > +        };
> > +        channel@5 {
> > +          reg = <5>;
> > +        };
> > +        channel@6 {
> > +          reg = <6>;
> > +        };
> > +        channel@7 {
> > +          reg = <7>;
> > +        };
> > +      };
> > +    };
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 32bf5f8116d0..5d00e871c4c6 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -813,6 +813,13 @@ S:	Supported
> >  F:	drivers/iio/adc/ad7124.c
> >  F:	Documentation/devicetree/bindings/iio/adc/adi,ad7124.txt
> >  
> > +ANALOG DEVICES INC AD7292 DRIVER
> > +M:	Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> > +L:	linux-iio@vger.kernel.org
> > +W:	http://ez.analog.com/community/linux-device-drivers
> > +S:	Supported
> > +F:	Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml
> > +
> >  ANALOG DEVICES INC AD7606 DRIVER
> >  M:	Stefan Popa <stefan.popa@analog.com>
> >  L:	linux-iio@vger.kernel.org
> > -- 
> > 2.23.0
> > 
