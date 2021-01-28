Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1DB130731C
	for <lists+linux-iio@lfdr.de>; Thu, 28 Jan 2021 10:49:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231386AbhA1JsO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 28 Jan 2021 04:48:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231562AbhA1JpP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 28 Jan 2021 04:45:15 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C14EC0613D6;
        Thu, 28 Jan 2021 01:44:35 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id s2so4598576otp.5;
        Thu, 28 Jan 2021 01:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0tdWQ+d8GDL3L7HHmP75TKjsjBa9nxywgYDQpEEPUMI=;
        b=qF6UUcGv7rR/xG6zbo4KcGYamU0NcafBwayMZozCJfu2pfUZ4uxvA1njh0sSSH2JHC
         dPCkcMnaJM4DvG3j6NIJ15AZ8tuqwwHIGpWbYxaWmrOIGesMq6oNO7xZ6kjRWLVj/f3p
         Yy6N/iKTao/9dTy9qnFgOJwMGl55rNVwLXq/uAs76GO0YBF1StaG4OhrawbdwOUAqAxj
         M+41tv9cIC4/kZUlyKJSH9xvqNk3v79iZcszgaKbWiYjAzizXud3lpC2R5RbD7U8+KM/
         tmy986U2Oe4xr2CJobnkD/KkFnWf3rMqzv1sT8RRqEmsW+dZ1FVOmrTli+1JclJ4QJHC
         NwwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0tdWQ+d8GDL3L7HHmP75TKjsjBa9nxywgYDQpEEPUMI=;
        b=XVRJc3gonjy3NIcpfcd/5mTyOwWPMI2ss5xFNPvg+hv/UdAVQRNUyJCGCLy/fqtcVE
         5/F/+rI5Lqzzd37xwPeaWADFkrOLI2IRkTp/ClEJKxddftOzo9rDawji/P2Kf3Yn2VnZ
         1Fcjn7mQu3AesvZbbJeTkf32wOFRJ/FiqlURV/ec3yTTGpSoMaxiSHeISNxV3Qf9uin2
         LYW91Nt1N0zn0OQ5m9O4eMipNIEUzHkMegCf5DYP+nQDJli3GoTal5+IJa5cjt8juo25
         NMRGouaXt4B+6VFpNie/8LxUyJ//z9eCXdGngcO9Ts1ZrOuZmOMrKQ0Q9xPWN7wqjtdT
         BX1g==
X-Gm-Message-State: AOAM5301dW6jpS0IdO1WasNPQ+wHsyS7FmslfkB8kGndKrI5cMqgdIV0
        QJQ6KNXxoFFG+YZYGv+7jGidTyPq62nwBa07dmw=
X-Google-Smtp-Source: ABdhPJzIlXfimw/RBDw/9rpGBPce2+wmPz+eAKm2A8hM41qrtVG8skXwOyn+I4zFOVOAhHnX/h3OOWAXdRsYYLrx+YA=
X-Received: by 2002:a9d:23ca:: with SMTP id t68mr11045706otb.281.1611827074691;
 Thu, 28 Jan 2021 01:44:34 -0800 (PST)
MIME-Version: 1.0
References: <20210128084011.3270281-1-swboyd@chromium.org> <20210128084011.3270281-3-swboyd@chromium.org>
In-Reply-To: <20210128084011.3270281-3-swboyd@chromium.org>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Thu, 28 Jan 2021 10:44:23 +0100
Message-ID: <CAFqH_53aRCVfRqHCgPoqUvmydybCiVeQdw5bHOAQ6pZr03irwg@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] dt-bindings: iio: Add cros ec proximity yaml doc
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Stephen,

Thank you for your patch. Just a minor comment.

Missatge de Stephen Boyd <swboyd@chromium.org> del dia dj., 28 de gen.
2021 a les 9:45:
>
> Some cros ECs support a front proximity MKBP event via
> 'EC_MKBP_FRONT_PROXIMITY'. Add a DT binding to document this feature via
> a node that is a child of the main cros_ec device node. Devices that
> have this ability will describe this in firmware.
>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Benson Leung <bleung@chromium.org>
> Cc: Guenter Roeck <groeck@chromium.org>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Gwendal Grignou <gwendal@chromium.org>
> Cc: <devicetree@vger.kernel.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>
> Changes from v2:
>  * None
>
> Changes from v1:
>  * Added additionalProperties
>  * Included proximity in cros-ec yaml
>
>  .../google,cros-ec-mkbp-proximity.yaml        | 38 +++++++++++++++++++
>  .../bindings/mfd/google,cros-ec.yaml          |  3 ++
>  2 files changed, 41 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/proximity/google,cros-ec-mkbp-proximity.yaml
>
> diff --git a/Documentation/devicetree/bindings/iio/proximity/google,cros-ec-mkbp-proximity.yaml b/Documentation/devicetree/bindings/iio/proximity/google,cros-ec-mkbp-proximity.yaml
> new file mode 100644
> index 000000000000..c3141c2be286
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/proximity/google,cros-ec-mkbp-proximity.yaml
> @@ -0,0 +1,38 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +
> +$id: http://devicetree.org/schemas/iio/proximity/google,cros-ec-mkbp-proximity.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ChromeOS EC MKBP Proximity Sensor
> +
> +maintainers:
> +  - Stephen Boyd <swboyd@chromium.org>
> +  - Benson Leung <bleung@chromium.org>
> +  - Enric Balletbo i Serra <enric.balletbo@collabora.com>
> +
> +description: |
> +  Google's ChromeOS EC sometimes has the ability to detect user proximity.
> +  This is implemented on the EC as near/far logic and exposed to the OS
> +  via an MKBP switch bit.
> +
> +properties:
> +  compatible:
> +    const: google,cros-ec-mkbp-proximity
> +
> +  label:
> +    description: Name for proximity sensor
> +
> +required:
> +  - compatible
> +
> +unevaluatedProperties: false
> +additionalProperties: false
> +
> +examples:
> +  - |

For this kind of devices it is preferred to see a complete example
rather than pieces spread around different yaml. This helps proper
binding parsing.

    spi0 {
      #address-cells = <1>;
      #size-cells = <0>;

      cros_ec: ec@0 {
        compatible = "google,cros-ec-spi";
        reg = <0>;

> +    proximity {
> +        compatible = "google,cros-ec-mkbp-proximity";
> +        label = "proximity-wifi-lte";
> +    };
> diff --git a/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml b/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
> index 76bf16ee27ec..479a9f15de32 100644
> --- a/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
> +++ b/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
> @@ -94,6 +94,9 @@ properties:
>    keyboard-controller:
>      $ref: "/schemas/input/google,cros-ec-keyb.yaml#"
>
> +  proximity:
> +    $ref: "/schemas/iio/proximity/google,cros-ec-mkbp-proximity.yaml#"
> +
>    codecs:
>      type: object
>      additionalProperties: false
> --
> https://chromeos.dev
>
