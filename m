Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1A718C428
	for <lists+linux-iio@lfdr.de>; Fri, 20 Mar 2020 01:15:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbgCTAPm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 19 Mar 2020 20:15:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:57220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725787AbgCTAPm (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 19 Mar 2020 20:15:42 -0400
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB7F120775;
        Fri, 20 Mar 2020 00:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584663341;
        bh=OSlquqcH1F8KsOyuUEWI4dxT8R0DknRunxtYQ4e6SkU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pDRtiBhvsn2C3cD7sTKzyxKg3MRHANHuxnnJtZNqYg8bjnRnnyY9Obtwj37LbmS4M
         OjZ9WA2yF186vM0J23vV7BxzaFiktb+WfBqKe0x0tPvDS747DEJ0dUICSGuAYiPuwl
         fF5e8BciNSgxqYIf6qbEeeQEUulSsSzS7QjclNOE=
Received: by mail-qv1-f54.google.com with SMTP id n1so2108278qvz.4;
        Thu, 19 Mar 2020 17:15:40 -0700 (PDT)
X-Gm-Message-State: ANhLgQ1aH6gGCNxMPLrpuBg1CCJKiUJREuWLuTI+3p118Oz+ocakE+dH
        nN/KqlLXcuB5O9WYCN6Z+XiQsq3pIo4+Y8/KUg==
X-Google-Smtp-Source: ADFU+vtDeHt6XN4u8uvVz1l8xo+9/2SGnnkDtYwkNgIcwRW4yk4GSbVrdqQP/nQ7RorZzhOFOnNPoI46lwJxuSM9uDU=
X-Received: by 2002:ad4:4502:: with SMTP id k2mr5779706qvu.85.1584663339950;
 Thu, 19 Mar 2020 17:15:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200307211412.44148-1-contact@artur-rojek.eu> <20200307211412.44148-4-contact@artur-rojek.eu>
In-Reply-To: <20200307211412.44148-4-contact@artur-rojek.eu>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 19 Mar 2020 18:15:28 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+oTCQKUNdfapFjf7p0YnKQSyd6USvaOQQA6FqgwNg0fA@mail.gmail.com>
Message-ID: <CAL_Jsq+oTCQKUNdfapFjf7p0YnKQSyd6USvaOQQA6FqgwNg0fA@mail.gmail.com>
Subject: Re: [PATCH v4 4/5] dt-bindings: input: Add docs for ADC driven joystick.
To:     Artur Rojek <contact@artur-rojek.eu>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Heiko Stuebner <heiko@sntech.de>,
        Linux Input <linux-input@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Mar 7, 2020 at 2:06 PM Artur Rojek <contact@artur-rojek.eu> wrote:
>
> Add documentation for the adc-joystick driver, used to provide support
> for joysticks connected over ADC.
>
> Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
> Tested-by: Paul Cercueil <paul@crapouillou.net>
> ---
>
>  Changes:
>
>  v2: - Add `reg` property to axis subnode in order to enumerate the axes,
>      - rename `linux,abs-code` property to `linux,code`,
>      - drop `linux,` prefix from the remaining properties of axis subnode
>
>  v3: no change
>
>  v4: - remove "bindings" from the unique identifier string,
>      - replace `|` with `>` for all description properties,
>      - specify the number of items for `io-channels`,
>      - correct the regex pattern of `axis` property,
>      - specify the value range of `reg` property for each axis,
>      - put `abs-range` properties under `allOf`
>
>  .../bindings/input/adc-joystick.yaml          | 121 ++++++++++++++++++
>  1 file changed, 121 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/adc-joystick.yaml
>
> diff --git a/Documentation/devicetree/bindings/input/adc-joystick.yaml b/Documentation/devicetree/bindings/input/adc-joystick.yaml
> new file mode 100644
> index 000000000000..b0d2aa28d8c6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/adc-joystick.yaml
> @@ -0,0 +1,121 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright 2019-2020 Artur Rojek
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/input/adc-joystick.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: ADC attached joystick
> +
> +maintainers:
> +  - Artur Rojek <contact@artur-rojek.eu>
> +
> +description: >
> +  Bindings for joystick devices connected to ADC controllers supporting
> +  the Industrial I/O subsystem.
> +
> +properties:
> +  compatible:
> +    const: adc-joystick
> +
> +  io-channels:
> +    minItems: 1
> +    maxItems: 1024
> +    description: >
> +      List of phandle and IIO specifier pairs.
> +      Each pair defines one ADC channel to which a joystick axis is connected.
> +      See Documentation/devicetree/bindings/iio/iio-bindings.txt for details.
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +
> +required:
> +  - compatible
> +  - io-channels
> +  - '#address-cells'
> +  - '#size-cells'
> +
> +additionalProperties: false
> +
> +patternProperties:
> +  "^axis@[0-9]+$":

unit-addresses are hex, so add 'a-f' in there.

With that,

Reviewed-by: Rob Herring <robh@kernel.org>
