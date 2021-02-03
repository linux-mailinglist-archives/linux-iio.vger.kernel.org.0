Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD01F30D538
	for <lists+linux-iio@lfdr.de>; Wed,  3 Feb 2021 09:31:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232563AbhBCIae (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 3 Feb 2021 03:30:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232512AbhBCIad (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 3 Feb 2021 03:30:33 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE90FC061573;
        Wed,  3 Feb 2021 00:29:52 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id k25so25914707oik.13;
        Wed, 03 Feb 2021 00:29:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fw7mhJ/ALXeJZR+44OFAC0sbpDziXpuDZAubERRVzFg=;
        b=Gf4D99yyAGOZ90xVmedTlmHqUPxdM+6hM26isYs20UlmBRFXHcIHNUMpo72aolFpcP
         8D/v/2G6lKq9u/93G2AcMlmE9SPD2mgCAKX7NbV4qrJ3YRlFmvD4BPVXeWq301FClRsM
         y9jxMdbOdkQXEwmh70WVeWxMH3kFRroAyUf3Jh893QymPpT2Jn95lQ1XNn5YDNnXFRSX
         4VDvaQfBcQGtB32mHEEPokjc0knJ37BSW2fajRDHzxR6MQna/o9SMl4902qbGe10iHY7
         zisckfJj2pnkG+quwEg6t03KcL2TVS0yN98jEoVji33sE7MCDp+zhKLLQtyqKRZnrgRT
         pCXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fw7mhJ/ALXeJZR+44OFAC0sbpDziXpuDZAubERRVzFg=;
        b=g6yU4I4Bf1U/1cKCm8sEbUKoGFmplAaFr+vX7XZS43G2cDh4AF6by5orsoWLvcXFLf
         C/nMit/0MX5H9qF1Uwj7duwEMl1mR39Ch353bfVFlMlNXbpBj5vMeT/uoRXsTzk/gbYr
         4zkQQNpxKsGwd0SgNCbTM0TLMaOj0ln+vgV2q+FGPELnQHKtc4RONKQ0Cj6k2t5CLtR7
         1uMPwN0f8ei+6pIJS/MEQENRKIUF18ggioc/SMKDNGVxHdUzL4HEVdAeHH2X28lOShB+
         0ouQsE2M4QL9rhHowlL1XGdQ/FM2NROCKthytLsZQKN0jeSvtK51c2jSXIGlWQNY0oZW
         CIoQ==
X-Gm-Message-State: AOAM533ceS+bjga10ETmI+hU1yRe1L3ULIHSF56LFt/ZPsTIY04k0f6p
        xFdk3wNuGTn2giiXoRUvO1jtH90s4T576Ruj3nU=
X-Google-Smtp-Source: ABdhPJyoWWtBttqrhsG53CwbEqSmRLh1H8YTHimPEVkBZhFUCZ+sKisqTESaxWyAlhg6iF9K81LGmeIyGJN5AGQfyK0=
X-Received: by 2002:aca:4454:: with SMTP id r81mr1268682oia.129.1612340992276;
 Wed, 03 Feb 2021 00:29:52 -0800 (PST)
MIME-Version: 1.0
References: <20210202184434.42644-1-swboyd@chromium.org> <20210202184434.42644-3-swboyd@chromium.org>
In-Reply-To: <20210202184434.42644-3-swboyd@chromium.org>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Wed, 3 Feb 2021 09:29:40 +0100
Message-ID: <CAFqH_52xjAmjWu3DFuFyqQBDYFccZXYp=8wcXVOr4H5deRa2bw@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] dt-bindings: iio: Add cros ec proximity yaml doc
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
        Rob Herring <robh+dt@kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Stephen,

Missatge de Stephen Boyd <swboyd@chromium.org> del dia dt., 2 de febr.
2021 a les 19:53:
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
> Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

Thanks for adding a full example, IIRC this is preferred by Rob and we
are also trying to apply this rule on all the cros-ec related
bindings, so the dt_bindings_check really checks a full example. From
my side looks good to me.

Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

> ---
>  .../google,cros-ec-mkbp-proximity.yaml        | 46 +++++++++++++++++++
>  .../bindings/mfd/google,cros-ec.yaml          |  3 ++
>  2 files changed, 49 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/proximity/google,cros-ec-mkbp-proximity.yaml
>
> diff --git a/Documentation/devicetree/bindings/iio/proximity/google,cros-ec-mkbp-proximity.yaml b/Documentation/devicetree/bindings/iio/proximity/google,cros-ec-mkbp-proximity.yaml
> new file mode 100644
> index 000000000000..d82b929af445
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/proximity/google,cros-ec-mkbp-proximity.yaml
> @@ -0,0 +1,46 @@
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
> +    spi {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +      ec@0 {
> +        compatible = "google,cros-ec-spi";
> +        reg = <0>;
> +        proximity {
> +          compatible = "google,cros-ec-mkbp-proximity";
> +          label = "proximity-wifi-lte";
> +        };
> +      };
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
