Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB25B134CE8
	for <lists+linux-iio@lfdr.de>; Wed,  8 Jan 2020 21:12:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbgAHUMa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 8 Jan 2020 15:12:30 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:46181 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbgAHUMa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 8 Jan 2020 15:12:30 -0500
Received: by mail-oi1-f196.google.com with SMTP id 13so1938874oij.13
        for <linux-iio@vger.kernel.org>; Wed, 08 Jan 2020 12:12:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=k7+Uq6HkxozZICbgNkuKzFsXaFY2bmpVlgViuwauvZs=;
        b=kAkor6huQO8hn94/1PIirekYsjFmqf8qtndPMHgMOZrUq5lWLNzc5PsylmJ17TzMqu
         oimFkMHO4cvcOZHpXfAMj19WZDQIWlK+G3cUQQas0dBF65TG4TT0sm+ZjgaFv62tLV+t
         9sqczgM0CJlFxlOucNP5rpaqbtpHaooMMpfQCft+K7qM7/BP8qzN5CPBpfQGhO1eMUsb
         6GN7gZrUZnolesEPcr+gOMkCu3SR2aIl7tGiV46mZHr6cdqQtq1hYsPT0eJeWc+P6Euc
         ts7nXiOiewHze0n3BIgoz/jkguhsZoMfdGpWIVFTrxSZXdHu3SoqdGCJaVBltxM2fywL
         gl6w==
X-Gm-Message-State: APjAAAU5eGkAppKx/WBYkFpaKyAzvkJdfwvTtKtV+CpZmWaF9WfnAhi/
        Oh2gWStD6TSwLDihUN/Tq18r/3M=
X-Google-Smtp-Source: APXvYqyM0ysjK9464eLCU3tbdkd9m5aM+OpxGokE+YAGbqlaiEy8X8nuDsU6DaECxVX03nB7IdygNA==
X-Received: by 2002:aca:c08b:: with SMTP id q133mr298265oif.46.1578514348726;
        Wed, 08 Jan 2020 12:12:28 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id c12sm1506422otp.9.2020.01.08.12.12.27
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2020 12:12:27 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 220333
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Wed, 08 Jan 2020 14:12:26 -0600
Date:   Wed, 8 Jan 2020 14:12:26 -0600
From:   Rob Herring <robh@kernel.org>
To:     Artur Rojek <contact@artur-rojek.eu>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Paul Cercueil <paul@crapouillou.net>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] dt-bindings: input: Add docs for ADC driven joystick.
Message-ID: <20200108201226.GA10350@bogus>
References: <20200105001639.142061-1-contact@artur-rojek.eu>
 <20200105001639.142061-4-contact@artur-rojek.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200105001639.142061-4-contact@artur-rojek.eu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Jan 05, 2020 at 01:16:38AM +0100, Artur Rojek wrote:
> Add documentation for the adc-joystick driver, used to provide support
> for joysticks connected over ADC.
> 
> Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
> Tested-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  .../bindings/input/adc-joystick.yaml          | 100 ++++++++++++++++++
>  1 file changed, 100 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/adc-joystick.yaml
> 
> diff --git a/Documentation/devicetree/bindings/input/adc-joystick.yaml b/Documentation/devicetree/bindings/input/adc-joystick.yaml
> new file mode 100644
> index 000000000000..97ae797348c7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/adc-joystick.yaml
> @@ -0,0 +1,100 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright 2019-2020 Artur Rojek
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/bindings/input/adc-joystick.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: ADC attached joystick
> +
> +maintainers:
> +  - Artur Rojek <contact@artur-rojek.eu>
> +
> +description: |
> +  Bindings for joystick devices connected to ADC controllers supporting
> +  the Industrial I/O subsystem.
> +
> +properties:
> +  compatible:
> +    const: adc-joystick
> +
> +  io-channels:
> +    description: |
> +      List of phandle and IIO specifier pairs.
> +      Each pair defines one ADC channel to which a joystick axis is connected.
> +      See Documentation/devicetree/bindings/iio/iio-bindings.txt for details.
> +
> +required:
> +  - compatible
> +  - io-channels
> +
> +additionalProperties: false
> +
> +patternProperties:
> +  "^axis@([0-9])$":

A unit-address means there should be a 'reg' property. I'd just do 
axis-x and axis-y instead.

> +    type: object
> +    description: |
> +      Represents a joystick axis bound to the given ADC channel.
> +      For each entry in the io-channels list, one axis subnode with a matching
> +      index must be specified.
> +
> +    properties:
> +      linux,abs-code:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description: EV_ABS specific event code generated by the axis.

Existing 'linux,code' should be used here.

> +
> +      linux,abs-range:

Drop 'linux,' here and on the rest of these.

> +        $ref: /schemas/types.yaml#/definitions/uint32-array
> +        items:
> +          - description: minimum value
> +          - description: maximum value
> +        description: |
> +          Minimum and maximum values produced by the axis.
> +          For an ABS_X axis this will be the left-most and right-most
> +          inclination of the joystick. If min > max, it is left to userspace to
> +          treat the axis as inverted.
> +          This property is interpreted as two signed 32 bit values.
> +
> +      linux,abs-fuzz:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description: |
> +          Amount of noise in the input value.
> +          Omitting this property indicates the axis is precise.
> +
> +      linux,abs-flat:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description: |
> +          Axial "deadzone", or area around the center position, where the axis
> +          is considered to be at rest.
> +          Omitting this property indicates the axis always returns to exactly
> +          the center position.
> +
> +    required:
> +      - linux,abs-code
> +      - linux,abs-range
> +
> +    additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/iio/adc/ingenic,adc.h>
> +    #include <dt-bindings/input/input.h>
> +
> +    joystick: adc-joystick {
> +      compatible = "adc-joystick";
> +      io-channels = <&adc INGENIC_ADC_TOUCH_XP>,
> +                    <&adc INGENIC_ADC_TOUCH_YP>;
> +
> +      axis@0 {
> +              linux,abs-code = <ABS_X>;
> +              linux,abs-range = <3300 0>;
> +              linux,abs-fuzz = <4>;
> +              linux,abs-flat = <200>;
> +      };
> +      axis@1 {
> +              linux,abs-code = <ABS_Y>;
> +              linux,abs-range = <0 3300>;
> +              linux,abs-fuzz = <4>;
> +              linux,abs-flat = <200>;
> +      };
> +    };
> -- 
> 2.24.1
> 
