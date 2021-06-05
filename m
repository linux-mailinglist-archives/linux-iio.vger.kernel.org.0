Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF6839C942
	for <lists+linux-iio@lfdr.de>; Sat,  5 Jun 2021 16:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbhFEO6p (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 5 Jun 2021 10:58:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:46808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229930AbhFEO6p (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 5 Jun 2021 10:58:45 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4EFF9613AC;
        Sat,  5 Jun 2021 14:56:55 +0000 (UTC)
Date:   Sat, 5 Jun 2021 15:58:42 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Liam Beguin <liambeguin@gmail.com>, peda@axentia.se,
        lars@metafoo.de, pmeerw@pmeerw.net, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v1 7/9] dt-bindings: iio: afe: add binding for
 temperature-sense-rtd
Message-ID: <20210605155842.036edd94@jic23-huawei>
In-Reply-To: <20210604211702.GA3925041@robh.at.kernel.org>
References: <20210530005917.20953-1-liambeguin@gmail.com>
        <20210530005917.20953-8-liambeguin@gmail.com>
        <20210604211702.GA3925041@robh.at.kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 4 Jun 2021 16:17:02 -0500
Rob Herring <robh@kernel.org> wrote:

> On Sat, May 29, 2021 at 08:59:15PM -0400, Liam Beguin wrote:
> > From: Liam Beguin <lvb@xiphos.com>
> > 
> > An ADC is often used to measure other quantities indirectly. This
> > binding describe one cases, the measurement of a temperature through
> > the voltage across an RTD resistor such as a PT1000.
> > 
> > Signed-off-by: Liam Beguin <lvb@xiphos.com>
> > ---
> >  .../iio/afe/temperature-sense-rtd.yaml        | 65 +++++++++++++++++++
> >  MAINTAINERS                                   |  1 +
> >  2 files changed, 66 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/afe/temperature-sense-rtd.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/afe/temperature-sense-rtd.yaml b/Documentation/devicetree/bindings/iio/afe/temperature-sense-rtd.yaml
> > new file mode 100644
> > index 000000000000..4798eda6e533
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/afe/temperature-sense-rtd.yaml
> > @@ -0,0 +1,65 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/afe/temperature-sense-rtd.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Temperature Sense RTD
> > +
> > +maintainers:
> > +  - Liam Beguin <lvb@xiphos.com>
> > +
> > +description: |
> > +  When an io-channel measures the output voltage across an RTD such as a  
> 
> What's an RTD? Not defined anywhere here.
> 
> > +  PT1000, the interesting measurement is almost always the corresponding
> > +  temperature, not the voltage output. This binding describes such a circuit.
> > +
> > +properties:
> > +  compatible:
> > +    const: temperature-sense-rtd
> > +
> > +  io-channels:
> > +    maxItems: 1
> > +    description: |
> > +      Channel node of a voltage io-channel.
> > +
> > +  '#io-channel-cells':
> > +    const: 1  
> 
> Doesn't this belong in the provider?

Potentially this could in turn also be a provider if wired up to iio-hwmon or
similar.  Certainly an option for a temperature sensor.

> 
> > +
> > +  excitation-current-microamp:
> > +    description: The current fed through the RTD sensor.
> > +
> > +  alpha-micro-ohms-per-ohm-celsius:
> > +    description: |
> > +      Linear approximation of the resistance versus temperature relationship
> > +      between 0 and 100 degrees Celsius.
> > +
> > +      Pure platinum has an alpha of 3925. Industry standards such as IEC60751
> > +      and ASTM E-1137 specify an alpha of 3850.  
> 
> Is there a max and min value?
> 
> > +
> > +  r-naught-ohms:
> > +    description: |
> > +      Resistance of the sensor at 0 degrees Celsius.
> > +      Common values are 100 for PT100 and 1000 for PT1000.  
> 
> max or min?
> 
> > +
> > +additionalProperties: false  
> 
> blank line here.
> 
> > +required:
> > +  - compatible
> > +  - io-channels
> > +  - excitation-current-microamp
> > +  - alpha-micro-ohms-per-ohm-celsius
> > +  - r-naught-ohms
> > +
> > +examples:
> > +  - |
> > +    pt1000_1: iio-rescale0 {
> > +        compatible = "temperature-sense-rtd";
> > +        #io-channel-cells = <1>;
> > +        io-channels = <&temp_adc1 0>;
> > +
> > +        excitation-current-microamp = <1000>;
> > +        alpha-micro-ohms-per-ohm-celsius = <3908>;
> > +        r-naught-ohms = <1000>;
> > +    };
> > +
> > +...
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index d3ab0ccc34ab..a7279af85adb 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -8721,6 +8721,7 @@ L:	linux-iio@vger.kernel.org
> >  S:	Maintained
> >  F:	Documentation/devicetree/bindings/iio/afe/current-sense-amplifier.yaml
> >  F:	Documentation/devicetree/bindings/iio/afe/current-sense-shunt.yaml
> > +F:	Documentation/devicetree/bindings/iio/afe/temperature-sense-rtd.yaml
> >  F:	Documentation/devicetree/bindings/iio/afe/voltage-divider.yaml
> >  F:	drivers/iio/afe/iio-rescale.c
> >  
> > -- 
> > 2.30.1.489.g328c10930387  

