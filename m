Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D89E94554F4
	for <lists+linux-iio@lfdr.de>; Thu, 18 Nov 2021 07:56:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243483AbhKRG66 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 18 Nov 2021 01:58:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243478AbhKRG65 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 18 Nov 2021 01:58:57 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA831C061570
        for <linux-iio@vger.kernel.org>; Wed, 17 Nov 2021 22:55:57 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id be32so12121555oib.11
        for <linux-iio@vger.kernel.org>; Wed, 17 Nov 2021 22:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=/IhWvJ6fsRPNM+zjbvU87WCRpJyRrpUk+UnKI2rk2wQ=;
        b=lOgrw0ltcpp1fxPDTR0Jpdfy+b287CQTewzFJnT+gmvJrBlBXffxk5JfhE34u0f/6D
         nl/lunHSx6F8QrrbZsRzjVNln2corWffbFkmShl/A1LvKTNT9mobKPDGw/bt6RS2wiNG
         i72QDcMm8zW+XLc7DPd6qYU0bMbdetwMiVGik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=/IhWvJ6fsRPNM+zjbvU87WCRpJyRrpUk+UnKI2rk2wQ=;
        b=FhSCfgtmpj0pYkyeE3nNg1LO5cSXkt+0Tat61HLhz2JRjiduxhCOZgFZDnb2RStP+1
         D0ujvQMx+WLKe0xi1urgKk6ekUP6oJKfuUnsdqhAmy1ucbn1e8u/ClsNs99df+roTOlA
         u742ZyqLMiwO4uZmgcM2NFBAwbcbO3Zl7JHoHeVJfzbS7EP50iZoMbION7tfH25LWVDY
         Uwn4yc1+zhFWP16AAMlhOXDxF87+L0/dSxI86mkieRxSMeBim9sXwkwLUftDA+JgtAbD
         Gr8JAw9p0dt8kQbO3MC9EbsPah/8IzpdGX76YTEmZqC0VJxD7NapHUiOr2L0rUW8skTT
         uGkg==
X-Gm-Message-State: AOAM533nYwMlZuNd/OmpRDc9UG2BS68MuImQ8er8DUM6mE6Gz2HB8gIk
        mTl6NWw3A67mLcV3Ah71ff/8UbRADiT/7EBe8pWezQ==
X-Google-Smtp-Source: ABdhPJzrmhnhk7NO+1WK6LlBCWz++qChaGJ1A3GrZZuU3vSV4HsQN6NglaEhUUpb1XdYLnwhInJQGqmutQ+yuXUzMcI=
X-Received: by 2002:a05:6808:211f:: with SMTP id r31mr5754800oiw.64.1637218557092;
 Wed, 17 Nov 2021 22:55:57 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 17 Nov 2021 22:55:56 -0800
MIME-Version: 1.0
In-Reply-To: <20211117084631.2820014-5-gwendal@chromium.org>
References: <20211117084631.2820014-1-gwendal@chromium.org> <20211117084631.2820014-5-gwendal@chromium.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Wed, 17 Nov 2021 22:55:56 -0800
Message-ID: <CAE-0n52C1bdALC_e=5WL_=j96NCrY=KnRYriYCvoZMqX3kOuNA@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] dt-bindings: iio: Add sx9324 binding
To:     Gwendal Grignou <gwendal@chromium.org>, jic23@kernel.org,
        lars@metafoo.de
Cc:     andy.shevchenko@gmail.com, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Quoting Gwendal Grignou (2021-11-17 00:46:30)
> diff --git a/Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml
> new file mode 100644
> index 00000000000000..5e2e684400e35a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml
> @@ -0,0 +1,136 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/proximity/semtech,sx9310.yaml#

Should be sx9324.yaml

> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Semtech's SX9324 capacitive proximity sensor
> +
> +maintainers:
> +  - Gwendal Grignou <gwendal@chromium.org>
> +  - Daniel Campello <campello@chromium.org>
> +
> +description: |
> +  Semtech's SX9324 proximity sensor.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - semtech,sx9324

If there's only one compatible then it can be

  compatible:
    const: semtech,sx9324

> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    description:
> +      Generated by device to announce preceding read request has finished
> +      and data is available or that a close/far proximity event has happened.
> +    maxItems: 1
> +
> +  vdd-supply:
> +    description: Main power supply
> +
> +  svdd-supply:
> +    description: Host interface power supply
> +
> +  "#io-channel-cells":
> +    const: 1
> +
> +  semtech,ph0-pin:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    description: |
> +      Indicates how each CS pin is used during phase 0.
> +      Each of the 3 pins have the following value -

Can you also indicate that the index of the array corresponds to each
channel?

> +      0 : unused (high impedance)
> +      1 : measured input
> +      2 : dynamic shield
> +      3 : grounded.
> +      For instance, CS0 measured, CS1 shield and CS2 ground is [1, 2, 3]
> +    items:
> +      enum: [ 0, 1, 2, 3 ]
> +    minItems: 3
> +    maxItems: 3
> +
> +  semtech,ph1-pin:
> +  semtech,ph2-pin:
> +  semtech,ph3-pin:
> +    Same as ph0-pin

I'm fairly certain we need to duplicate the ph0-pin description each
time. And presumably ph1 is for phase 1?

> +
> +  semtech,resolution01
> +    $ref: /schemas/types.yaml#definitions/uint32
> +    enum: [8, 16, 32, 64, 128, 256, 512, 1024]
> +    description:
> +      Capacitance measurement resolution. For phase 0 and 1.
> +      Higher the number, higher the resolution.
> +    default: 128
> +
> +  semtech,resolution23
> +    $ref: /schemas/types.yaml#definitions/uint32
> +    enum: [8, 16, 32, 64, 128, 256, 512, 1024]
> +    description:
> +      Capacitance measurement resolution. For phase 2 and 3
> +    default: 128

Can this be a single combined u32 array for each phase?

> +
> +  semtech,startup-sensor:
> +    $ref: /schemas/types.yaml#definitions/uint32
> +    enum: [0, 1, 2, 3]
> +    default: 0
> +    description:
> +      Phase used for start-up proximity detection.
> +      It is used when we enable a phase to remove static offset and measure
> +      only capacitance changes introduced by the user.
> +
> +  semtech,proxraw-strength01:
> +    $ref: /schemas/types.yaml#definitions/uint32
> +    min: 0
> +    max: 7
> +    default: 1
> +    description:
> +      PROXRAW filter strength for phase 0 and 1. A value of 0 represents off,
> +      and other values represent 1-1/2^N.
> +
> +  semtech,proxraw-strength23:
> +    Same as proxraw-strength01, for phase 2 and 3.

Likewise, can this be combined into one array for all phases?

> +
> +  semtech,avg-pos-strength:
> +    $ref: /schemas/types.yaml#definitions/uint32
> +    enum: [0, 16, 64, 128, 256, 512, 1024, 4294967295]
> +    default: 16
> +    description:
> +      Average positive filter strength. A value of 0 represents off and
> +      UINT_MAX (4294967295) represents infinite. Other values
> +      represent 1-1/N.
> +
> +required:
> +  - compatible
> +  - reg
> +  - "#io-channel-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    i2c {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +      proximity@28 {
> +        compatible = "semtech,sx9310";

Should be semtech,sx9324

> +        reg = <0x28>;
> +        interrupt-parent = <&pio>;
> +        interrupts = <5 IRQ_TYPE_LEVEL_LOW 5>;
> +        vdd-supply = <&pp3300_a>;
> +        svdd-supply = <&pp1800_prox>;
> +        #io-channel-cells = <1>;
> +        semtech,ph0-pin = <1, 2, 3>;
> +        semtech,ph1-pin = <3, 2, 1>;
> +        semtech,ph2-pin = <1, 2, 3>;
> +        semtech,ph3-pin = <3, 2, 1>;
> +        semtech,resolution01 = 2;
> +        semtech,resolution23 = 2;
> +        semtech,startup-sensor = <1>;
> +        semtech,proxraw-strength01 = <2>;
> +        semtech,proxraw-strength23 = <2>;
> +        semtech,avg-pos-strength = <64>;
> +      };
> +    };
