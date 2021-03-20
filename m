Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE8E9342D2B
	for <lists+linux-iio@lfdr.de>; Sat, 20 Mar 2021 14:52:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbhCTNvj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 20 Mar 2021 09:51:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:44930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229585AbhCTNvK (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 20 Mar 2021 09:51:10 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5167C6193F;
        Sat, 20 Mar 2021 13:51:05 +0000 (UTC)
Date:   Sat, 20 Mar 2021 13:51:01 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luca Ceresoli <luca@lucaceresoli.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Kevin Tsai <ktsai@capellamicro.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org,
        linux-input@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: More cleanup of standard unit properties
Message-ID: <20210320135101.64c5c4e1@jic23-huawei>
In-Reply-To: <20210316194824.3526913-1-robh@kernel.org>
References: <20210316194824.3526913-1-robh@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 16 Mar 2021 13:48:24 -0600
Rob Herring <robh@kernel.org> wrote:

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

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
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

