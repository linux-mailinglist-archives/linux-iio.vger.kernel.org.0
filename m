Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D15594A3901
	for <lists+linux-iio@lfdr.de>; Sun, 30 Jan 2022 21:22:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356088AbiA3UWv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 30 Jan 2022 15:22:51 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:38662 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244727AbiA3UWu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 30 Jan 2022 15:22:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C642560AE0
        for <linux-iio@vger.kernel.org>; Sun, 30 Jan 2022 20:22:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F8EDC340E4;
        Sun, 30 Jan 2022 20:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643574169;
        bh=1hjK3gbkEBLxXEFZXthIWkCtzGHfaa8IIRdt1a1f1Wk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ek6O46eLxUsGhiNp+1vguFCaF4CbmSJvBQ7MFnkUh+Kkj+Piipo0wudhz7gAbWyYp
         uPEBkolbRzhw1AdhUaBhBMBN6hXrKWpEK02c6A9/Mkvd/wpFn0Th9ZUEYVYvXO+Nzx
         tQeavXtTYKuVPugrQbGQRVR7Nbf4z+Lgr9COuoqXC/UZx0mrWk3CoxCDNMSZEputl6
         DKdGZGCYVSeAYqLiW3te43GOIhhR2jFPXrPnaOMssF2Ea/y+0L0Cv2bmi2jkEYmckd
         3YtbHA28COjzx4RkenI1E3fiVYBz5etNO30/Edx6+kxbpqhwDqUaJVHmaJBOjKncnI
         jyXJswyp0naYQ==
Date:   Sun, 30 Jan 2022 20:29:14 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc:     linux-iio@vger.kernel.org, Nuno Sa <Nuno.Sa@analog.com>,
        lars@metafoo.de, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 15/17] dt-bindings:iio:adc:ad7280a: Add binding
Message-ID: <20220130202914.53a02f26@jic23-huawei>
In-Reply-To: <Yb5QFJmFoc8EM5Zd@marsc.168.1.7>
References: <20211205202710.2847005-1-jic23@kernel.org>
        <20211205202710.2847005-16-jic23@kernel.org>
        <Yb5QFJmFoc8EM5Zd@marsc.168.1.7>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 18 Dec 2021 18:18:12 -0300
Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:

> Think it would be more intuitive to use the number of active channels as enum
> elements for adi,temp-alert-last-chan and adi,voltage-alert-last-chan.

Just to check I understand correctly, you mean active number of channels
across all devices, or just in the last device?

If all devices it would get tricky to handle because if set to a value
before the last device I'm not sure how we'd handle it.

Or do you mean just index in that device form 1, so when we disable
VIN5 we still have VIN0,1,2,3,4 so 5 devices?

The AUX version as per earlier patch is a real pain to describe. If
we do support it we'll probably just have to fall back to strings
or similar which isn't nice.

Jonathan

> This, though, is just my personal opinion so 
> Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> 
> On 12/05, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Add a binding for this Lithium Ion Battery monitoring chip/chain of chips
> > as it is now clean and ready to move out of staging.
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > ---
> >  .../bindings/iio/adc/adi,ad7280a.yaml         | 87 +++++++++++++++++++
> >  1 file changed, 87 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7280a.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7280a.yaml
> > new file mode 100644
> > index 000000000000..77b8f67fe446
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7280a.yaml
> > @@ -0,0 +1,87 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/adc/adi,ad7280a.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Analog Devices AD7280a Lithium Ion Battery Monitoring System
> > +
> > +maintainers:
> > +  - Michael Hennerich <michael.hennerich@analog.com>
> > +  - Jonathan Cameron <jic23@kernel.org>
> > +
> > +description: |
> > +  Bindings for the Analog Devices AD7280a Battery Monitoring System.
> > +  Used in devices such as hybrid electric cars, battery backup and power tools.
> > +  Multiple chips can be daisy chained and accessed via a single SPI interface.
> > +  Data sheet found here:
> > +    https://www.analog.com/media/en/technical-documentation/data-sheets/AD7280A.pdf
> > +
> > +properties:
> > +  compatible:
> > +    const: adi,ad7280a
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    description: IRQ line for the ADC
> > +    maxItems: 1
> > +
> > +  spi-max-frequency: true
> > +
> > +  adi,temp-alert-last-chan:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description:
> > +      Allows limiting of scope of which channels are considered for temperature
> > +      alerts, typically because not all are wired to anything. Only applies to
> > +      last device in the daisy chain.
> > +    default: 5
> > +    enum: [3, 4, 5]
> > +
> > +  adi,voltage-alert-last-chan:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description:
> > +      Allows limiting of scope of which channels are considered for voltage
> > +      alerts, typically because not all are wired to anything. Only applies to
> > +      last device in the daisy chain.
> > +    default: 5
> > +    enum: [3, 4, 5]
> > +
> > +  adi,acquisition-time-ns:
> > +    description:
> > +      Additional time may be needed to charge the sampling capacitors depending
> > +      on external writing.
> > +    default: 400
> > +    enum: [400, 800, 1200, 1600]
> > +
> > +  adi,thermistor-termination:
> > +    type: boolean
> > +    description:
> > +      Enable the thermistor termination function.
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    spi {
> > +      #address-cells = <1>;
> > +      #size-cells = <0>;
> > +
> > +      adc@0 {
> > +        compatible = "adi,ad7280a";
> > +        reg = <0>;
> > +        spi-max-frequency = <700000>;
> > +        interrupt-parent = <&gpio>;
> > +        interrupts = <25 2>;
> > +        adi,thermistor-termination;
> > +        adi,acquisition-time-ns = <800>;
> > +        adi,voltage-alert-last-chan = <5>;
> > +        adi,temp-alert-last-chan = <5>;
> > +      };
> > +    };
> > +...
> > -- 
> > 2.34.1
> >   

