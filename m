Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B8C14AAD8A
	for <lists+linux-iio@lfdr.de>; Sun,  6 Feb 2022 03:31:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbiBFCb3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 5 Feb 2022 21:31:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiBFCb2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 5 Feb 2022 21:31:28 -0500
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 688EEC043186
        for <linux-iio@vger.kernel.org>; Sat,  5 Feb 2022 18:31:27 -0800 (PST)
Received: by mail-oo1-xc36.google.com with SMTP id u47-20020a4a9732000000b00316d0257de0so6690975ooi.7
        for <linux-iio@vger.kernel.org>; Sat, 05 Feb 2022 18:31:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MfUI3dO27Y6jZHkg7Qy3n7UkUX5qq7YQldEVD0xg1IA=;
        b=m5mMLBKqvSJaQb7ZfoW9vi6fWE8uWBG7BOEskfp1WK8+99H5fTLHyt/Qp8juVyn+e/
         2EgOi/xN3mkZnVi5ukrKuyiE9Mdj6wdsk2SArJgEE8hsBh9xFBxYgnBmQLLxBvc2YuKe
         MsjwADuwBXTM/usA2LGKTY7N7rSV6OyCXnbnc6hXAwLQZrBPSjGYGhAPA5XCZXpn3fw4
         J4IAnFI3sLtGkxgtHI/ZaThh5dh16LTQSdJgae1av/Mq8V9AGlpfzE+vwJc8Htxf3TXw
         tKCsOmYYwzdUOMDbxvg3/SM4WGfE3VF8VJvvu2cQTvrKRWtkYclxQPGacIJ8EQ8ITpGT
         gPJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MfUI3dO27Y6jZHkg7Qy3n7UkUX5qq7YQldEVD0xg1IA=;
        b=lCUAvwP/bvA/cs4jtXGJ6Yj3n1Nxmfhy3Iv0QuV358Wu48I6EdgP5erYLUzS1GiT2O
         s5Yho3r8ycHJjha5XodgcxkhiRy3BDqBfrarMmwZRZGaoXhF8JuaHz7ieYrD5KGSiNzK
         pqLTKzSLnmd6LJ8wyVqEF7W3rsE/oT32ZPVX8GLJsGLQ9vQQUdKEWx54MPOf2Jl5m6ow
         O+abgDMqTzb8eQ+HlYKDVoqCTYhmu6PeWn9fwAv4Bmy8Ydq4pXBfE5/nxzd3qkG3xnBB
         IrCkw/nIaXg7vo6ONdLf9swwxRN0aS+vXuMuyn69ZcLX66xgCrk8f2UirgkmDfITNzVL
         woVQ==
X-Gm-Message-State: AOAM533cYMRZDtQLADH+M3k4hX6BUI8odDVfmU9tPHWR2LhRPYjaXxRy
        MbzE5zuq4dFzWJqO5fH1cWc=
X-Google-Smtp-Source: ABdhPJy4dyGxO0623LyGC8ZfYkjFgOxqWIik4l7fZfGA49Ab4uYni8Ob8ej/BSqiPfnx/7Qrg6d2fw==
X-Received: by 2002:a05:6870:e6d6:: with SMTP id s22mr1654000oak.261.1644114685997;
        Sat, 05 Feb 2022 18:31:25 -0800 (PST)
Received: from marsc.168.1.7 ([2804:30c:b7a:7b00:70e:e3d5:be94:991])
        by smtp.gmail.com with ESMTPSA id q18sm2434820otf.54.2022.02.05.18.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Feb 2022 18:31:25 -0800 (PST)
Date:   Sat, 5 Feb 2022 23:31:21 -0300
From:   Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Nuno Sa <Nuno.Sa@analog.com>,
        lars@metafoo.de, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 15/17] dt-bindings:iio:adc:ad7280a: Add binding
Message-ID: <Yf8y+U0BVK/WOTl/@marsc.168.1.7>
References: <20211205202710.2847005-1-jic23@kernel.org>
 <20211205202710.2847005-16-jic23@kernel.org>
 <Yb5QFJmFoc8EM5Zd@marsc.168.1.7>
 <20220130202914.53a02f26@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220130202914.53a02f26@jic23-huawei>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 01/30, Jonathan Cameron wrote:
> On Sat, 18 Dec 2021 18:18:12 -0300
> Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:
> 
> > Think it would be more intuitive to use the number of active channels as enum
> > elements for adi,temp-alert-last-chan and adi,voltage-alert-last-chan.
> 
> Just to check I understand correctly, you mean active number of channels
> across all devices, or just in the last device?

I was thinking about the number of channels enabled for alert detection only in
the last device.
For voltage inputs, we would have 6, 5, or 4 channels enabled. So the possible
values for adi,voltage-alert-last-chan would be [4, 5, 6], default: 6.
For temperature inputs, things get a bit hairy.
* We may have all 6 AUX enabled.
* We may have 3 AUX enabled if D15:D14 = 01 in the control register. If so, we still may:
  + disable AUX5, or
  + disable AUX5 and AUX3
So the possibilities for adi,temp-alert-last-chan would be 1, 2, 3, or 6 AUX
channels enabled for alert detection.

> 
> If all devices it would get tricky to handle because if set to a value
> before the last device I'm not sure how we'd handle it.
> 
> Or do you mean just index in that device form 1, so when we disable
> VIN5 we still have VIN0,1,2,3,4 so 5 devices?

You mean the index of the last channel (of the last device) enabled to generate alerts?
For voltage inputs, I guess that would end up almost the same as for the number
of active channels. For temperature inputs, AUX6, AUX5, AUX3, or AUX1 would be
the last channels enabled to generate alerts in each of the above cases.
Taking just the indexes: 1, 3, 5, 6.
This seems harder to explain, though.

> 
> The AUX version as per earlier patch is a real pain to describe. If
> we do support it we'll probably just have to fall back to strings
> or similar which isn't nice.
> 
> Jonathan
> 
> > This, though, is just my personal opinion so 
> > Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> > 
> > On 12/05, Jonathan Cameron wrote:
> > > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > 
> > > Add a binding for this Lithium Ion Battery monitoring chip/chain of chips
> > > as it is now clean and ready to move out of staging.
> > > 
> > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > Reviewed-by: Rob Herring <robh@kernel.org>
> > > ---
> > >  .../bindings/iio/adc/adi,ad7280a.yaml         | 87 +++++++++++++++++++
> > >  1 file changed, 87 insertions(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7280a.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7280a.yaml
> > > new file mode 100644
> > > index 000000000000..77b8f67fe446
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7280a.yaml
> > > @@ -0,0 +1,87 @@
> > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/iio/adc/adi,ad7280a.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Analog Devices AD7280a Lithium Ion Battery Monitoring System
> > > +
> > > +maintainers:
> > > +  - Michael Hennerich <michael.hennerich@analog.com>
> > > +  - Jonathan Cameron <jic23@kernel.org>
> > > +
> > > +description: |
> > > +  Bindings for the Analog Devices AD7280a Battery Monitoring System.
> > > +  Used in devices such as hybrid electric cars, battery backup and power tools.
> > > +  Multiple chips can be daisy chained and accessed via a single SPI interface.
> > > +  Data sheet found here:
> > > +    https://www.analog.com/media/en/technical-documentation/data-sheets/AD7280A.pdf
> > > +
> > > +properties:
> > > +  compatible:
> > > +    const: adi,ad7280a
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  interrupts:
> > > +    description: IRQ line for the ADC
> > > +    maxItems: 1
> > > +
> > > +  spi-max-frequency: true
> > > +
> > > +  adi,temp-alert-last-chan:
> > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > +    description:
> > > +      Allows limiting of scope of which channels are considered for temperature
> > > +      alerts, typically because not all are wired to anything. Only applies to
> > > +      last device in the daisy chain.
> > > +    default: 5
> > > +    enum: [3, 4, 5]
> > > +
> > > +  adi,voltage-alert-last-chan:
> > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > +    description:
> > > +      Allows limiting of scope of which channels are considered for voltage
> > > +      alerts, typically because not all are wired to anything. Only applies to
> > > +      last device in the daisy chain.
> > > +    default: 5
> > > +    enum: [3, 4, 5]
> > > +
> > > +  adi,acquisition-time-ns:
> > > +    description:
> > > +      Additional time may be needed to charge the sampling capacitors depending
> > > +      on external writing.
> > > +    default: 400
> > > +    enum: [400, 800, 1200, 1600]
> > > +
> > > +  adi,thermistor-termination:
> > > +    type: boolean
> > > +    description:
> > > +      Enable the thermistor termination function.
> > > +
> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +
> > > +additionalProperties: false
> > > +
> > > +examples:
> > > +  - |
> > > +    spi {
> > > +      #address-cells = <1>;
> > > +      #size-cells = <0>;
> > > +
> > > +      adc@0 {
> > > +        compatible = "adi,ad7280a";
> > > +        reg = <0>;
> > > +        spi-max-frequency = <700000>;
> > > +        interrupt-parent = <&gpio>;
> > > +        interrupts = <25 2>;
> > > +        adi,thermistor-termination;
> > > +        adi,acquisition-time-ns = <800>;
> > > +        adi,voltage-alert-last-chan = <5>;
> > > +        adi,temp-alert-last-chan = <5>;
> > > +      };
> > > +    };
> > > +...
> > > -- 
> > > 2.34.1
> > >   
> 
