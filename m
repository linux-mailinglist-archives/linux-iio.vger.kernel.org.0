Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 337C946CE54
	for <lists+linux-iio@lfdr.de>; Wed,  8 Dec 2021 08:22:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240639AbhLHHZr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 8 Dec 2021 02:25:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240199AbhLHHZr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 8 Dec 2021 02:25:47 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C38AC061574
        for <linux-iio@vger.kernel.org>; Tue,  7 Dec 2021 23:22:16 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id 14so1829644ioe.2
        for <linux-iio@vger.kernel.org>; Tue, 07 Dec 2021 23:22:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I8JmcggFnRKzbTH7VEx1kayDWaOV/lgpkD7s/ofbGg8=;
        b=I7QZQW6H8U+yKCjH+YJ0rqdYXrci8uiYeTUbALQdBpQXNzCaEWqgLASzqX6O/nwj8D
         3yOkcF5Xv9VCQbMszPlG/T4hBw8OdayD4aOx9EeMTrmBHe2YoI5G1Ghzf7IQYkqmasU7
         NbeYt8iWdUDwAmvuo1pIqWuwkQixoc2Cw6t6g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I8JmcggFnRKzbTH7VEx1kayDWaOV/lgpkD7s/ofbGg8=;
        b=cwjuaQfBC7BIE4hoNGn5VYj/sKxWxRnwzDMMgfScapAjRhksqqHs8zmwmVCb0W62rd
         fQdFO5/uPQ3+2yttpmeXXykY417mixZ/jOllUnjtl5tp8axcScavIgAP9gGYGjKQ+GZv
         ydcWaurnNrH81WJQ29bGKRw5pUqr8BjR1NR6oVlMxorRJnjiK6IZBxaP4OasFU8Xu0tK
         GYNBuW0gBgb28xnD7ZNPxEDUxfaN4nxHXbgw+dc40BKJ5C+MBZozWsUgdjW9rXd6FgqW
         KobuKpUV2PLLBpOHa9z9FluApszgKZ+oey8HxmYPIZRyjNTkrlZh0yFok1GgzyOb6LXV
         oOmg==
X-Gm-Message-State: AOAM533MYb17zAiLAEgaEaBEW+MqqjOnVREYFB515GIHYhMwr7r3Ddjx
        Zdn0DbKi9Y+2xJ6nrE6ZOmA7E0uawWipE5KBD2hBQA==
X-Google-Smtp-Source: ABdhPJyo5Tr6qVYiAXKv4dkXejHYsdpA0lUOx6EH7RMnI0wz8q5tsoZIlFka3t4Wr7qYwi3954U50Y+blUe08R1qtpo=
X-Received: by 2002:a05:6602:8ce:: with SMTP id h14mr3915950ioz.177.1638948135681;
 Tue, 07 Dec 2021 23:22:15 -0800 (PST)
MIME-Version: 1.0
References: <20211208004311.3098571-1-gwendal@chromium.org>
 <20211208004311.3098571-5-gwendal@chromium.org> <CAE-0n50Jz0qu+8tog3ex5K+LL4fBTxOxnM0u5TNq5E8M+kRNAQ@mail.gmail.com>
In-Reply-To: <CAE-0n50Jz0qu+8tog3ex5K+LL4fBTxOxnM0u5TNq5E8M+kRNAQ@mail.gmail.com>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Tue, 7 Dec 2021 23:22:04 -0800
Message-ID: <CAPUE2uuZ0-ABtgOBY=XXCXAe3hyS552a3XsNt1PwCZz_nYk0-g@mail.gmail.com>
Subject: Re: [PATCH v5 4/5] dt-bindings: iio: Add sx9324 binding
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        andy.shevchenko@gmail.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Dec 7, 2021 at 8:42 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> +Rob *crosses fingers*
>
> Quoting Gwendal Grignou (2021-12-07 16:43:10)
> > Similar to SX9310, add biddings to setup sx9324 hardware properties.
> > SX9324 is a little different, introduce 4 phases to be configured in 2
> > pairs over 3 antennas.
> >
> > Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> > ---
> > Changes in v5:
> > - Use consistent field naming, prefixed with phX.
> >
> > Changes in v4:
> > - Use const instead of single enum
> > - Specify ph0-pin better
> > - Recopy type information for phX-pin
> > - Fix cut and paste errors.
> >
> > Changes in v3:
> > - Remove duplicate information.
> > - Use intervals instead of enum.
> > - Fix filter description.
> >
> > Changes in v2:
> > - Fix interrupt documentation wording.
> >
> >  .../iio/proximity/semtech,sx9324.yaml         | 161 ++++++++++++++++++
>
> Please add Rob for dt binding review. I'm not sure if the
> semi-autonomous robot runs without Cc robh+dt
>
> >  1 file changed, 161 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml
> > new file mode 100644
> > index 00000000000000..ac9581b0d31364
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml
> > @@ -0,0 +1,161 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/proximity/semtech,sx9324.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Semtech's SX9324 capacitive proximity sensor
> > +
> > +maintainers:
> > +  - Gwendal Grignou <gwendal@chromium.org>
> > +  - Daniel Campello <campello@chromium.org>
> > +
> > +description: |
> > +  Semtech's SX9324 proximity sensor.
> > +
> > +properties:
> > +  compatible:
> > +    const: semtech,sx9324
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    description:
> > +      Generated by device to announce preceding read request has finished
> > +      and data is available or that a close/far proximity event has happened.
> > +    maxItems: 1
> > +
> > +  vdd-supply:
> > +    description: Main power supply
> > +
> > +  svdd-supply:
> > +    description: Host interface power supply
> > +
> > +  "#io-channel-cells":
> > +    const: 1
> > +
> > +  semtech,ph0-pin:
> > +    $ref: /schemas/types.yaml#/definitions/uint32-array
> > +    description: |
> > +      Array of 3 entries. Index represent the id of the CS pin.
> > +      Value indicates how each CS pin is used during phase 0.
> > +      Each of the 3 pins have the following value -
> > +      0 : unused (high impedance)
> > +      1 : measured input
> > +      2 : dynamic shield
> > +      3 : grounded.
> > +      For instance, CS0 measured, CS1 shield and CS2 ground is [1, 2, 3]
> > +    items:
> > +      enum: [ 0, 1, 2, 3 ]
> > +    minItems: 3
> > +    maxItems: 3
> > +
> > +  semtech,ph1-pin:
> > +    $ref: /schemas/types.yaml#/definitions/uint32-array
> > +    description: Same as ph0-pin for phase 1.
> > +    items:
> > +      enum: [ 0, 1, 2, 3 ]
> > +    minItems: 3
> > +    maxItems: 3
> > +
> > +  semtech,ph2-pin:
> > +    $ref: /schemas/types.yaml#/definitions/uint32-array
> > +    description: Same as ph0-pin for phase 2.
> > +    items:
> > +      enum: [ 0, 1, 2, 3 ]
> > +    minItems: 3
> > +    maxItems: 3
> > +
> > +  semtech,ph3-pin:
> > +    $ref: /schemas/types.yaml#/definitions/uint32-array
> > +    description: Same as ph0-pin for phase 3.
> > +    items:
> > +      enum: [ 0, 1, 2, 3 ]
> > +    minItems: 3
> > +    maxItems: 3
> > +
> > +
> > +  semtech,ph01-resolution:
> > +    $ref: /schemas/types.yaml#definitions/uint32
> > +    enum: [8, 16, 32, 64, 128, 256, 512, 1024]
> > +    description:
> > +      Capacitance measurement resolution. For phase 0 and 1.
> > +      Higher the number, higher the resolution.
> > +    default: 128
> > +
> > +  semtech,ph23-resolution:
> > +    $ref: /schemas/types.yaml#definitions/uint32
> > +    enum: [8, 16, 32, 64, 128, 256, 512, 1024]
> > +    description:
> > +      Capacitance measurement resolution. For phase 2 and 3
> > +    default: 128
> > +
> > +  semtech,startup-sensor:
> > +    $ref: /schemas/types.yaml#definitions/uint32
> > +    enum: [0, 1, 2, 3]
> > +    default: 0
> > +    description: |
> > +      Phase used for start-up proximity detection.
> > +      It is used when we enable a phase to remove static offset and measure
> > +      only capacitance changes introduced by the user.
> > +
> > +  semtech,ph01-proxraw-strength:
> > +    $ref: /schemas/types.yaml#definitions/uint32
> > +    min: 0
> > +    max: 7
> > +    default: 1
> > +    description:
> > +      PROXRAW filter strength for phase 0 and 1. A value of 0 represents off,
> > +      and other values represent 1-1/2^N.
> > +
> > +  semtech,ph23-proxraw-strength:
> > +    $ref: /schemas/types.yaml#definitions/uint32
> > +    min: 0
> > +    max: 7
> > +    default: 1
> > +    description:
> > +      Same as proxraw-strength01, for phase 2 and 3.
>
> We could have a single property then that uses index 0 for phase 0 and 1
> and index 1 for phase 2 and 3 if we're worried about them being
> different between the two joined phases. Same comment applies to the
> resolution.
>
> > +
> > +  semtech,avg-pos-strength:
> > +    $ref: /schemas/types.yaml#definitions/uint32
> > +    enum: [0, 16, 64, 128, 256, 512, 1024, 4294967295]
> > +    default: 16
> > +    description: |
> > +      Average positive filter strength. A value of 0 represents off and
> > +      UINT_MAX (4294967295) represents infinite. Other values
> > +      represent 1-1/N.
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - "#io-channel-cells"
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +    i2c {
> > +      #address-cells = <1>;
> > +      #size-cells = <0>;
> > +      proximity@28 {
> > +        compatible = "semtech,sx9324";
> > +        reg = <0x28>;
> > +        interrupt-parent = <&pio>;
> > +        interrupts = <5 IRQ_TYPE_LEVEL_LOW 5>;
> > +        vdd-supply = <&pp3300_a>;
> > +        svdd-supply = <&pp1800_prox>;
> > +        #io-channel-cells = <1>;
> > +        semtech,ph0-pin = <1, 2, 3>;
> > +        semtech,ph1-pin = <3, 2, 1>;
> > +        semtech,ph2-pin = <1, 2, 3>;
> > +        semtech,ph3-pin = <3, 2, 1>;
>
> The comma should be removed. Have you run 'make dt_binding_check'?
I did not, and it spotted a lot of errors. I will resend this patch.
>
> > +        semtech,ph01-resolution = 2;
> > +        semtech,ph23-resolution = 2;
> > +        semtech,startup-sensor = <1>;
> > +        semtech,ph01-proxraw-strength = <2>;
> > +        semtech,ph23-proxraw-strength = <2>;
> > +        semtech,avg-pos-strength = <64>;
> > +      };
> > +    };
