Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1725DD93F
	for <lists+linux-iio@lfdr.de>; Sat, 19 Oct 2019 17:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725940AbfJSPHA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 19 Oct 2019 11:07:00 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:44905 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbfJSPHA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 19 Oct 2019 11:07:00 -0400
Received: by mail-qk1-f194.google.com with SMTP id u22so8136403qkk.11;
        Sat, 19 Oct 2019 08:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4x2DM6vZJfp7GFqVdyd8aE+i5ANpX3rPocujCcf6n+Q=;
        b=dSRNpF8Km8Wl/VGIETvgMHBBkwRJyKufEUVuc4wNpOE356LHlaiGiAYHBOVBX/FPgr
         ZJXNGncPQpgh6fTjruSxIV4sdslVcxJiBcNyhTY7sH+J8Uxx+P3NOPwcaJJKN7O7I0/+
         SASQOrK/14FVJDhBc3g+8VJMGKiHP9kyOs5AYz5jH+pm0N66bQT4wnBuj5X/Ntsi5YdU
         112WZFoLH3l9x1tVjdUrrgEIdRILB3F0Fxek+Q5R4do7T3u6lxn4c53nXLnhzFf5hYX5
         8TdtnCbq1wcBmyq4rUE448Ki2aOFyJfMfw3GRpmbyyc5eIS6cDlcstWGy2Lg4MY1aeh9
         e2nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4x2DM6vZJfp7GFqVdyd8aE+i5ANpX3rPocujCcf6n+Q=;
        b=Rq6Jx9ilqTxMsvVwTXLXCM89Hpon3mE1rMR9rDVUhi6jK7hei2fyRTsbgYCet6wBLx
         pH+YvFBOv0ySb51cidwAtgRecQ7DrMWrwLEUxKthJo2MTC7fLjBJuIRxXk00TPIaNSUl
         H3Qs0N5gxUzOwaGOo5/aKCtvy9LQSecVblFp3Swb6iem8tGzghpXnYrhZEDUJkG6xBZ2
         JPMMOTI+jBld3GRwCQKcmHwQx3qXgZdKWRLSWhCXqXeWNnmH2q+YcLkG9ApH1DoK8Exi
         i3bfvWustAGV9hZNYaRNnhQNkxoyZ1uqd2TRa83ssF2g8n3qHZdQAuTY/PHzYRTyYAea
         zZtg==
X-Gm-Message-State: APjAAAVJ52Pib72AmKrYcWgrjZIioRS8HlTkgOhc9X6ni6vVM2RcbsGR
        63a15QnXlJE2MAnPoGmTSUQ=
X-Google-Smtp-Source: APXvYqxhgQLri63K/LbZFQj7lcnficy1+XLo94yeZlvK5RP4VuJQeAGIK9vTjSodOLSIirkggjI2Ag==
X-Received: by 2002:a37:8d01:: with SMTP id p1mr14038731qkd.210.1571497618475;
        Sat, 19 Oct 2019 08:06:58 -0700 (PDT)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id o5sm3120283qtq.10.2019.10.19.08.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Oct 2019 08:06:58 -0700 (PDT)
Date:   Sat, 19 Oct 2019 12:06:54 -0300
From:   Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     jic23@kernel.org, dragos.bogdan@analog.com,
        alexandru.ardelean@analog.com, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        kernel-usp@googlegroups.com
Subject: Re: [PATCH v2 2/2] dt-bindings: iio: adc: Add DT docs for AD7292
Message-ID: <20191019150652.h6bkfz2w2ohemvwy@smtp.gmail.com>
References: <20191016025220.td3xb7oxlfkznxl6@smtp.gmail.com>
 <20191017191152.GA11222@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191017191152.GA11222@bogus>
User-Agent: NeoMutt/20180716
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Rob

Thanks for the review.

I'm having some trouble with the DTC.
I installed the DT tool from https://github.com/robherring/dt-schema.
Running make -k dt_binding_check goes through all the checks (CHKDT), producing
the .example.dts files but then gives errors like:

  DTC     Documentation/devicetree/bindings/arm/calxeda.example.dt.yaml
FATAL ERROR: Unknown output format "yaml"
make[1]: *** [scripts/Makefile.lib:314: Documentation/devicetree/bindings/arm/calxeda.example.dt.yaml] Error 1
make[1]: *** Deleting file 'Documentation/devicetree/bindings/arm/calxeda.example.dt.yaml'

My pip3 installation has:
jsonschema jsonschema-3.1.2.dev6+g0d827f3
rfc3987 1.3.8

$HOME/.local/bin is listed in my shell's PATH variable.

I was trying to follow the documentation at:
Documentation/devicetree/writing-schema.rst

Are there any other DTC dependencies that I am missing?

On 10/17, Rob Herring wrote:
> On Tue, Oct 15, 2019 at 11:52:23PM -0300, Marcelo Schmitt wrote:
> > Add a device tree binding doc for AD7292 monitor and control system.
> > 
> > Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> > ---
> >  .../bindings/iio/adc/adi,ad7292.yaml          | 107 ++++++++++++++++++
> >  MAINTAINERS                                   |   1 +
> >  2 files changed, 108 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml
> > new file mode 100644
> > index 000000000000..40028332d9e2
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml
> > @@ -0,0 +1,107 @@
> > +# SPDX-License-Identifier: GPL-2.0
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
> > +    maxItems: 1
> 
> Not necessary, regulator supplies are always 1 item, so drop maxItems.
> 
> > +
> > +  spi-cpha:
> > +    description: |
> > +      See Documentation/devicetree/bindings/spi/spi-controller.yaml
> > +    maxItems: 1
> 
> This is just wrong because spi-cpha is a boolean. Just 'spi-cpha: true' 
> is sufficient. If this device needs this property, then it should 
> probably be required.
> 
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
> > +        maxItems: 1
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
> > +      ad7292: ad7292@0 {
> 
> adc@0
> 
> > +        compatible = "adi,ad7292";
> > +        reg = <0>;
> > +
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        spi-max-frequency = <25000000>;
> > +        vref-supply = <&adc_vref>;
> > +        spi-cpha;
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
> > +    }
> 
> Missing ';'. Make sure this builds with 'make -k dt_binding_check'. The 
> '-k' is due to some other breakage ATM.
> 
> Rob
