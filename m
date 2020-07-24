Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB54522D09F
	for <lists+linux-iio@lfdr.de>; Fri, 24 Jul 2020 23:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbgGXVgY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 24 Jul 2020 17:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbgGXVgY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 24 Jul 2020 17:36:24 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB009C0619E5
        for <linux-iio@vger.kernel.org>; Fri, 24 Jul 2020 14:36:23 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id j19so6133912pgm.11
        for <linux-iio@vger.kernel.org>; Fri, 24 Jul 2020 14:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=opG3nW4I5rCe1WXghjH5zHF3uH0DeDd34QtX5YmytYo=;
        b=bhcHp287NTRAuUPpjDb0FIIrsLNcEo9h8fImzbO06pVAN20KtOUPdlZEcEsWy3Vj8M
         anX8Wf5x0H5H1KFyaw7bQZlFmjA0iBUCpZB1aSYpOkqESuKAfhAp6ZXpLQDeavjhQVhN
         PpPVmpK4yT9oH13DFieSVLeBj90yDBgjovfSU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=opG3nW4I5rCe1WXghjH5zHF3uH0DeDd34QtX5YmytYo=;
        b=HlDFXtOeY5zCBiZsf7uJapfrF+Et1CE/1nFLwBF/qfQc7yNDy8b19rpAtKGam3wdD/
         I/KMUFuzE0tq6euzNaygghAiY+/hnYp9+iZla4XL3vxQomrlWnI/mk0YXfz+bhtZCvuX
         SCv6oHrDW5j8cXPcZQgdDf7vmZff40ORcW1xuN2cbvaAs7dj+QRMCDSonqlyE2PAzD/Y
         5j/1v5OUWS3e21SoC379cGIAiVtWaA+b15sNyHFydT/8HuAJBfJ1JhuXOQwaT5rFT8+o
         aR/7KT5hNyjLoXvnkYRuL2MtDD0O7rqX78OXFXSnwYeNU16B9NbweEKlhrB4cOn/Yerf
         IMmA==
X-Gm-Message-State: AOAM533b+Sud+8iEyApBqdqCaUg0bODoI0Tjx14dGUnHNi+Ht3Eewwsd
        0YME8WY6SRns+aUS9q3h9/MmWQ==
X-Google-Smtp-Source: ABdhPJy0zuMXOSAiFIUc2m9qjxFtdLkdHu6M3LtvCsg9sjsn7n8N6UxDl/jcILWQb8Bvpg3WVe7m1w==
X-Received: by 2002:a63:ee48:: with SMTP id n8mr10324355pgk.292.1595626583401;
        Fri, 24 Jul 2020 14:36:23 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id k98sm6809320pjb.42.2020.07.24.14.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 14:36:22 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200724213329.899216-2-swboyd@chromium.org>
References: <20200724213329.899216-1-swboyd@chromium.org> <20200724213329.899216-2-swboyd@chromium.org>
Subject: Re: [PATCH v2 1/5] dt-bindings: iio: Add bindings for sx9310 sensor
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Daniel Campello <campello@chromium.org>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        <devicetree@vger.kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Date:   Fri, 24 Jul 2020 14:36:22 -0700
Message-ID: <159562658210.3847286.6400483831020769497@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Quoting Stephen Boyd (2020-07-24 14:33:25)
> From: Daniel Campello <campello@chromium.org>
>=20
> Adds device tree bandings for sx9310 sensor.
>=20
> Signed-off-by: Daniel Campello <campello@chromium.org>
> Cc: Hartmut Knaack <knaack.h@gmx.de>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
> Cc: Rob Herring <robh+dt@kernel.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> [swboyd@chromium.org: Add both regulators and make them optional]
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---

I forgot to Cc devicetree list. Will do next time around.

-Stephen

>  .../iio/proximity/semtech,sx9310.yaml         | 60 +++++++++++++++++++
>  1 file changed, 60 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/proximity/semte=
ch,sx9310.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/iio/proximity/semtech,sx93=
10.yaml b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9310.ya=
ml
> new file mode 100644
> index 000000000000..ba734ee868c7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9310.yaml
> @@ -0,0 +1,60 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/proximity/semtech,sx9310.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Semtech's SX9310 capacitive proximity sensor
> +
> +maintainers:
> +  - Daniel Campello <campello@chromium.org>
> +
> +description: |
> +  Semtech's SX9310/SX9311 capacitive proximity/button solution.
> +
> +  Specifications about the devices can be found at:
> +  https://www.semtech.com/products/smart-sensing/sar-sensors/sx9310
> +
> +properties:
> +  compatible:
> +    enum:
> +      - semtech,sx9310
> +      - semtech,sx9311
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    description:
> +      The sole interrupt generated by the device used to announce the
> +      preceding reading request has finished and that data is
> +      available or that a close/far proximity event has happened.
> +    maxItems: 1
> +
> +  vdd-supply:
> +    description: Main power supply
> +
> +  svdd-supply:
> +    description: Host interface power supply
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    i2c {
> +      #address-cells =3D <1>;
> +      #size-cells =3D <0>;
> +      proximity@28 {
> +        compatible =3D "semtech,sx9310";
> +        reg =3D <0x28>;
> +        interrupt-parent =3D <&pio>;
> +        interrupts =3D <5 IRQ_TYPE_LEVEL_LOW 5>;
> +        vdd-supply =3D <&pp3300_a>;
> +        svdd-supply =3D <&pp1800_prox>;
> +      };
> +    };
