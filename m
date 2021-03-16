Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3EE833DE98
	for <lists+linux-iio@lfdr.de>; Tue, 16 Mar 2021 21:25:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbhCPUZB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 16 Mar 2021 16:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbhCPUY0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 16 Mar 2021 16:24:26 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D2CC061763
        for <linux-iio@vger.kernel.org>; Tue, 16 Mar 2021 13:24:25 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id by2so292286qvb.11
        for <linux-iio@vger.kernel.org>; Tue, 16 Mar 2021 13:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZRTIY2VRWaUelPcwzaEI0tDQLBHGGalGScH52QJUhXk=;
        b=UqJNZek9soDpdnk00d4/dL9psTBxWTzV+tYeYFNDQYV0BKDytCNQ69MvwYN732RSDJ
         9z/KIGy53AmOoKPh/ehQ3LYc6fS8xrLN5mdpgoys0n332oG4dSirW0dLZzdy2WTTTcEV
         ZksLlgxEY/ENzz448sa2tG7moPeAQI1bYgDymRLCqTn29J7rMMO5z2989rzOo1SRnZg3
         Ip9JszE0RmHZ1V5hAd/teTQVOV0DdYlSFK1DTUgIiqdILWASdrjQ9XhdSCC7/S5HCPT0
         5/eob51MuxaEANaot2r+fRJntylbb6jEhQdJeGxjBamauXisA9J2QGE+T5GkiWjaGI94
         1QZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZRTIY2VRWaUelPcwzaEI0tDQLBHGGalGScH52QJUhXk=;
        b=i243dCUqOx6mbJMJ67pE31alTQxpabWsCxhOf/b6ehVGNBQsxQDwASWzXjbLOIFq5X
         2p7XO9ZXJYMETV8UtLQOx9St3VUoNPCx8b3kMxM/KyVnCnv8S+ovowNmDOkdmfV9glZ8
         ilEWONQgmb36Pa+TFQsNcYYkLNNmNkDbEaVeTMVR7TeRl1iS8y7Mt7S6YtQ/niGgDoXk
         CkY5v90k8Mkv0la5JoCTfYUdG3e5pASbczjUGBG554AXNp4MAvV/HwQJf1AdlgKd9CUf
         3Bu8aLconNYgStkRRCJA4w3TWnqED7sA1M69H0XyXjxzp1pDYpZuF1gztvmD9bpAP0F4
         xMyw==
X-Gm-Message-State: AOAM532YCB3MTN5JSOQPbUcYDf546RDDl/09eK0wlPJ/RMGUOKmN2bAt
        7Jw/OQhVBCj3aLpslQ9He9E9rjnxDqyFhwL7wAN+HA==
X-Google-Smtp-Source: ABdhPJzY574Rg7Wz9aGieNKAROsMyGwCIA8qjuCRNbxeNxJMPvzEX83368PfHnm6rqJJhBVCSbQbD7A91+oIns7Ifc4=
X-Received: by 2002:a05:6214:1bcc:: with SMTP id m12mr1656197qvc.47.1615926264430;
 Tue, 16 Mar 2021 13:24:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210316194824.3526913-1-robh@kernel.org>
In-Reply-To: <20210316194824.3526913-1-robh@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 16 Mar 2021 23:24:13 +0300
Message-ID: <CAA8EJpp5R8_aH=mFxaqQMeNBgmBgJG4knjQkRF06Kgq5XXZT1g@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: More cleanup of standard unit properties
To:     Rob Herring <robh@kernel.org>
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Luca Ceresoli <luca@lucaceresoli.net>,
        Jonathan Cameron <jic23@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Kevin Tsai <ktsai@capellamicro.com>,
        Sebastian Reichel <sre@kernel.org>,
        Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org,
        linux-input@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 16 Mar 2021 at 22:48, Rob Herring <robh@kernel.org> wrote:
>
> Properties with standard unit suffixes already have a type and don't need
> type references. Fix a few more cases which have gotten added.
>
> Cc: Luca Ceresoli <luca@lucaceresoli.net>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Kevin Tsai <ktsai@capellamicro.com>
> Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Cc: Sebastian Reichel <sre@kernel.org>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: linux-iio@vger.kernel.org
> Cc: linux-input@vger.kernel.org
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---

For the qcom-spmi-adc-tm5.yaml:
Acked-by: Dmity Baryshkov <dmitry.baryshkov@linaro.org>

>  Documentation/devicetree/bindings/iio/light/capella,cm3605.yaml | 1 -
>  Documentation/devicetree/bindings/input/input.yaml              | 1 -
>  Documentation/devicetree/bindings/power/supply/bq256xx.yaml     | 1 -
>  Documentation/devicetree/bindings/power/supply/ltc4162-l.yaml   | 2 --
>  .../devicetree/bindings/regulator/qcom-labibb-regulator.yaml    | 1 -
>  .../devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml          | 1 -
>  6 files changed, 7 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/iio/light/capella,cm3605.yaml b/Documentation/devicetree/bindings/iio/light/capella,cm3605.yaml
> index 27972938b60d..c63b79c3351b 100644
> --- a/Documentation/devicetree/bindings/iio/light/capella,cm3605.yaml
> +++ b/Documentation/devicetree/bindings/iio/light/capella,cm3605.yaml
> @@ -48,7 +48,6 @@ properties:
>    vdd-supply: true
>
>    capella,aset-resistance-ohms:
> -    $ref: /schemas/types.yaml#/definitions/uint32
>      enum: [50000, 100000, 300000, 600000]
>      description: >
>        Sensitivity calibration resistance. Note that calibration curves
> diff --git a/Documentation/devicetree/bindings/input/input.yaml b/Documentation/devicetree/bindings/input/input.yaml
> index ab407f266bef..3fc37478c0c0 100644
> --- a/Documentation/devicetree/bindings/input/input.yaml
> +++ b/Documentation/devicetree/bindings/input/input.yaml
> @@ -32,6 +32,5 @@ properties:
>        Duration in seconds which the key should be kept pressed for device to
>        power off automatically. Device with key pressed shutdown feature can
>        specify this property.
> -    $ref: /schemas/types.yaml#/definitions/uint32
>
>  additionalProperties: true
> diff --git a/Documentation/devicetree/bindings/power/supply/bq256xx.yaml b/Documentation/devicetree/bindings/power/supply/bq256xx.yaml
> index 18b54783e11a..92ec7ed25668 100644
> --- a/Documentation/devicetree/bindings/power/supply/bq256xx.yaml
> +++ b/Documentation/devicetree/bindings/power/supply/bq256xx.yaml
> @@ -39,7 +39,6 @@ properties:
>      maxItems: 1
>
>    ti,watchdog-timeout-ms:
> -    $ref: /schemas/types.yaml#/definitions/uint32
>      default: 0
>      description: |
>        Watchdog timer in ms. 0 (default) disables the watchdog
> diff --git a/Documentation/devicetree/bindings/power/supply/ltc4162-l.yaml b/Documentation/devicetree/bindings/power/supply/ltc4162-l.yaml
> index 1f88c9e013f4..6d7aa97a6475 100644
> --- a/Documentation/devicetree/bindings/power/supply/ltc4162-l.yaml
> +++ b/Documentation/devicetree/bindings/power/supply/ltc4162-l.yaml
> @@ -29,12 +29,10 @@ properties:
>      description: I2C address of the charger.
>
>    lltc,rsnsb-micro-ohms:
> -    $ref: /schemas/types.yaml#/definitions/uint32
>      description: Battery sense resistor in microohm.
>      minimum: 1000
>
>    lltc,rsnsi-micro-ohms:
> -    $ref: /schemas/types.yaml#/definitions/uint32
>      description: Input current sense resistor in microohm.
>      minimum: 1000
>
> diff --git a/Documentation/devicetree/bindings/regulator/qcom-labibb-regulator.yaml b/Documentation/devicetree/bindings/regulator/qcom-labibb-regulator.yaml
> index cf784bd1f5e5..1ddc1efd19e2 100644
> --- a/Documentation/devicetree/bindings/regulator/qcom-labibb-regulator.yaml
> +++ b/Documentation/devicetree/bindings/regulator/qcom-labibb-regulator.yaml
> @@ -23,7 +23,6 @@ properties:
>
>      properties:
>        qcom,soft-start-us:
> -        $ref: /schemas/types.yaml#/definitions/uint32
>          description: Regulator soft start time in microseconds.
>          enum: [200, 400, 600, 800]
>          default: 200
> diff --git a/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml b/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml
> index 7cd364430573..95a728f4d333 100644
> --- a/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml
> +++ b/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml
> @@ -78,7 +78,6 @@ patternProperties:
>            also known as absolute calibration.
>
>        qcom,hw-settle-time-us:
> -        $ref: /schemas/types.yaml#/definitions/uint32
>          description: Time between AMUX getting configured and the ADC starting conversion.
>          enum: [15, 100, 200, 300, 400, 500, 600, 700, 1000, 2000, 4000, 8000, 16000, 32000, 64000, 128000]
>
> --
> 2.27.0
>


-- 
With best wishes
Dmitry
