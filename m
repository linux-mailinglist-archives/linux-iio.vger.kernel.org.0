Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 885412A5D07
	for <lists+linux-iio@lfdr.de>; Wed,  4 Nov 2020 04:12:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729905AbgKDDMo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 3 Nov 2020 22:12:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:50268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729591AbgKDDMo (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 3 Nov 2020 22:12:44 -0500
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 82D99223C7;
        Wed,  4 Nov 2020 03:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604459563;
        bh=2+QNe6OTiPJMJ9+4Q9tyYb0RM+T9E739xEOz6eBkCTs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rsxWc8yon5X0zvH0Qy/XcxQF1C8Pn1OUga0OzuavP4aCts5r/7MdvvaDicU6hrqsJ
         hhhSG8FG2dk2m1zvdqmSTOVlwWdUhevDB0FJjZO/yLwBRveemXpqjzImvBhPLtAlSy
         Fd2zlwGAaK5URID/R+AqRw02Gn4VuzrW0HFfCHJw=
Received: by mail-ot1-f42.google.com with SMTP id k3so6200989otp.12;
        Tue, 03 Nov 2020 19:12:43 -0800 (PST)
X-Gm-Message-State: AOAM5304xWGYDO79ecKL+f0+P53Rjl1inqQRQV1ILEgBIjLdUs1CHuEM
        5oyZZBfO5cox3pGwfIQVWKB2Z62mjt+33PPO9A==
X-Google-Smtp-Source: ABdhPJzshuRbVXMIhNwUDzL6MJbOLDfCNNSZSAp47mZr2tGqfv3nmlKZoE5Q5z9b/CH32WhtFgtOtkaz2xVAa/6Uynw=
X-Received: by 2002:a9d:5e14:: with SMTP id d20mr16404619oti.107.1604459562801;
 Tue, 03 Nov 2020 19:12:42 -0800 (PST)
MIME-Version: 1.0
References: <20201031184854.745828-1-jic23@kernel.org> <20201031184854.745828-3-jic23@kernel.org>
 <20201103161039.GA1754553@bogus> <20201103172834.00007040@Huawei.com> <bc4219af-d77b-0f39-025d-d8905f35b574@electromag.com.au>
In-Reply-To: <bc4219af-d77b-0f39-025d-d8905f35b574@electromag.com.au>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 3 Nov 2020 21:12:31 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLAtMQhsUDG=amAG7i9mMzYq9UTDLMFRrGKOHr5rb3L+A@mail.gmail.com>
Message-ID: <CAL_JsqLAtMQhsUDG=amAG7i9mMzYq9UTDLMFRrGKOHr5rb3L+A@mail.gmail.com>
Subject: Re: [PATCH 02/46] dt-bindings:iio:potentiometer:adi,ad5272 yaml conversion
To:     Phil Reid <preid@electromag.com.au>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jonathan Cameron <jic23@kernel.org>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Nov 3, 2020 at 6:39 PM Phil Reid <preid@electromag.com.au> wrote:
>
> On 4/11/2020 01:28, Jonathan Cameron wrote:
> > On Tue, 3 Nov 2020 10:10:39 -0600
> > Rob Herring <robh@kernel.org> wrote:
> >
> >> On Sat, Oct 31, 2020 at 06:48:10PM +0000, Jonathan Cameron wrote:
> >>> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >>>
> >>> Simple direct conversion from txt to yaml as part of a general aim of
> >>> converting all IIO bindings to this machine readable format.
> >>>
> >>> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >>> Cc: Phil Reid <preid@electromag.com.au>
> >>> ---
> >>>   .../bindings/iio/potentiometer/ad5272.txt     | 27 ----------
> >>>   .../iio/potentiometer/adi,ad5272.yaml         | 50 +++++++++++++++++++
> >>>   2 files changed, 50 insertions(+), 27 deletions(-)
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/iio/potentiometer/ad5272.txt b/Documentation/devicetree/bindings/iio/potentiometer/ad5272.txt
> >>> deleted file mode 100644
> >>> index f9b2eef946aa..000000000000
> >>> --- a/Documentation/devicetree/bindings/iio/potentiometer/ad5272.txt
> >>> +++ /dev/null
> >>> @@ -1,27 +0,0 @@
> >>> -* Analog Devices AD5272 digital potentiometer
> >>> -
> >>> -The node for this device must be a child node of a I2C controller, hence
> >>> -all mandatory properties for your controller must be specified. See directory:
> >>> -
> >>> -        Documentation/devicetree/bindings/i2c
> >>> -
> >>> -for more details.
> >>> -
> >>> -Required properties:
> >>> -   - compatible:   Must be one of the following, depending on the model:
> >>> -                   adi,ad5272-020
> >>> -                   adi,ad5272-050
> >>> -                   adi,ad5272-100
> >>> -                   adi,ad5274-020
> >>> -                   adi,ad5274-100
> >>> -
> >>> -Optional properties:
> >>> - - reset-gpios: GPIO specification for the RESET input. This is an
> >>> -           active low signal to the AD5272.
> >>> -
> >>> -Example:
> >>> -ad5272: potentiometer@2f {
> >>> -   reg = <0x2F>;
> >>> -   compatible = "adi,ad5272-020";
> >>> -   reset-gpios = <&gpio3 6 GPIO_ACTIVE_HIGH>;
> >>> -};
> >>> diff --git a/Documentation/devicetree/bindings/iio/potentiometer/adi,ad5272.yaml b/Documentation/devicetree/bindings/iio/potentiometer/adi,ad5272.yaml
> >>> new file mode 100644
> >>> index 000000000000..b9b7d383bff1
> >>> --- /dev/null
> >>> +++ b/Documentation/devicetree/bindings/iio/potentiometer/adi,ad5272.yaml
> >>> @@ -0,0 +1,50 @@
> >>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> >>> +%YAML 1.2
> >>> +---
> >>> +$id: http://devicetree.org/schemas/iio/potentiometer/adi,ad5272.yaml#
> >>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >>> +
> >>> +title: Analog Devices AD5272 digital potentiometer
> >>> +
> >>> +maintainers:
> >>> +  - Phil Reid <preid@electromag.com.au>
> >>> +
> >>> +description: |
> >>> +  Datasheet: https://www.analog.com/en/products/ad5272.html
> >>> +
> >>> +properties:
> >>> +  compatible:
> >>> +    enum:
> >>> +      - adi,ad5272-020
> >>> +      - adi,ad5272-050
> >>> +      - adi,ad5272-100
> >>> +      - adi,ad5274-020
> >>> +      - adi,ad5274-100
> >>> +
> >>> +  reg:
> >>> +    maxItems: 1
> >>> +
> >>> +  reset-gpios:
> >>> +    description:
> >>> +      Active low signal to the AD5272 RESET input.
> >>
> >> Not a new problem, but active low or...
> >>
> >>> +
> >>> +additionalProperties: false
> >>> +
> >>> +required:
> >>> +  - compatible
> >>> +  - reg
> >>> +
> >>> +examples:
> >>> +  - |
> >>> +    #include <dt-bindings/gpio/gpio.h>
> >>> +    i2c {
> >>> +        #address-cells = <1>;
> >>> +        #size-cells = <0>;
> >>> +
> >>> +        potentiometer@2f {
> >>> +            compatible = "adi,ad5272-020";
> >>> +            reg = <0x2F>;
> >>> +            reset-gpios = <&gpio3 6 GPIO_ACTIVE_HIGH>;
> >>
> >> active high?
> >
> > Good spot!  @Phil.  Looks like the driver is setting the reset line to
> > 0 and then to 1 to come out of reset.   So effectively inverting the logic.
> > I'm tempted to be cynical and suggest we just drop the comment above and leave
> > it vague but is there a better way we can clarify this?
>
> Had a look at a few other iio drivers in regards how they handle the same thing.
> A few do the same thing, ie: the drivers are written to set gpio low to assert reset.
> So they need the device tree gpio config to be active high to work correctly.
> Not sure if this prevents users setting things up as open collector.

The driver is wrong. 'gpiod_set_value(reset_gpio, 1);' should assert
reset as '1' here is set to (reset) active state as defined in the DT.

Given no upstream users, maybe it can be fixed...

We need to make 'reset-gpios' implemented by a reset controller and
stop letting drivers get it wrong.

Rob
