Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADF3C2DE9E2
	for <lists+linux-iio@lfdr.de>; Fri, 18 Dec 2020 20:43:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733210AbgLRTnN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 18 Dec 2020 14:43:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:39202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726177AbgLRTnN (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 18 Dec 2020 14:43:13 -0500
X-Gm-Message-State: AOAM531+gXCfUfNAnwv4l2aUZOfztupp5NWpQmnX/GsU2sieLLjh97Zl
        skqQOLmmc6+/h81u7MY+ylb+b1SZXDkuawmpwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608320552;
        bh=mQT84aDpnYs8EB8cFn/8qYnDx5716aEtFID4Pf2FyoQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OC/DnY2qs0t6WsZCZIf5bI9EaD4Y306LwkFK+nEOI26hXcRi3/Q4eQjolImmeftLO
         zuXAA4XHrIjc6SzRF7Va6L9wNtTqUNPwDkTd7nE7mbkvE/usho/NqudA5WFKbAZDbQ
         0NReHUCnzPDouX5esrkDs4zS6lmwL68et/ZSFskA/KPA51akGMwgwSYD+nDXCPs8P2
         tAifH3mGlv7YHeA/PypFdlAGrMd4X4FIaqD6fuqF11/rFq88mdMzhj897D1gry+2gs
         rwscW6iYMyzMq5N0FfxxYu2RUWgxHf1TBgZyWkREt/AL3IQSCNcTXHn95VkV8j+o5p
         fgByTkZX8atvA==
X-Google-Smtp-Source: ABdhPJynuvAJhAJT69wWAw80PGmLAld92GEZpyQd7brMFdYXXMiH5nz2zC7aVDHWLfje4iUJmYVmaw/dHkn6QYUUY4E=
X-Received: by 2002:a05:6402:352:: with SMTP id r18mr5858162edw.373.1608320550439;
 Fri, 18 Dec 2020 11:42:30 -0800 (PST)
MIME-Version: 1.0
References: <20201031184854.745828-1-jic23@kernel.org> <20201031184854.745828-9-jic23@kernel.org>
In-Reply-To: <20201031184854.745828-9-jic23@kernel.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 18 Dec 2020 13:42:19 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL0ssp2M02+J8teNu_fcwn9qn4HxPwaOu1weTCTQoC5Kw@mail.gmail.com>
Message-ID: <CAL_JsqL0ssp2M02+J8teNu_fcwn9qn4HxPwaOu1weTCTQoC5Kw@mail.gmail.com>
Subject: Re: [PATCH 08/46] dt-bindings:iio:health:ti,afe4404: txt to yaml conversion
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Andrew F . Davis" <afd@ti.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Oct 31, 2020 at 1:51 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> This basically has same questions as for the afe4403.  We could combine
> the two bindings, but as the drivers are separate and it would be a little
> fiddly due to different buses let's keep the separating.
> To repeat questions from the ti,afe4403 binding.
>
> A few questions came up whilst converting this one.
> 1) What is actually required?
>    - Checking Linux driver, interrupt is not, and the tx-supply could
>      be supplied by a stub regulator as long as it's always on.
>      As such I have reduced the required list to just compatible and reg.
> 2) What is the regulator called?
>    - It's tx-supply in the binding doc, but the driver request tx_sup
>      I've left this alone for now.  Andrew could you confirm what is
>      intended for this?
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Andrew F. Davis <afd@ti.com>
> ---
>  .../bindings/iio/health/afe4404.txt           | 29 -----------
>  .../bindings/iio/health/ti,afe4404.yaml       | 51 +++++++++++++++++++
>  2 files changed, 51 insertions(+), 29 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/iio/health/afe4404.txt b/Documentation/devicetree/bindings/iio/health/afe4404.txt
> deleted file mode 100644
> index 0b52830a0d9c..000000000000
> --- a/Documentation/devicetree/bindings/iio/health/afe4404.txt
> +++ /dev/null
> @@ -1,29 +0,0 @@
> -Texas Instruments AFE4404 Heart rate and Pulse Oximeter
> -
> -Required properties:
> - - compatible          : Should be "ti,afe4404".
> - - reg                 : I2C address of the device.
> - - tx-supply           : Regulator supply to transmitting LEDs.
> - - interrupts          : The interrupt line the device ADC_RDY pin is
> -                         connected to. For details refer to,
> -                         ../interrupt-controller/interrupts.txt.
> -
> -Optional properties:
> - - reset-gpios         : GPIO used to reset the device.
> -                         For details refer to, ../gpio/gpio.txt.
> -
> -Example:
> -
> -&i2c2 {
> -       heart_mon@58 {
> -               compatible = "ti,afe4404";
> -               reg = <0x58>;
> -
> -               tx-supply = <&vbat>;
> -
> -               interrupt-parent = <&gpio1>;
> -               interrupts = <28 IRQ_TYPE_EDGE_RISING>;
> -
> -               reset-gpios = <&gpio1 16 GPIO_ACTIVE_LOW>;
> -       };
> -};
> diff --git a/Documentation/devicetree/bindings/iio/health/ti,afe4404.yaml b/Documentation/devicetree/bindings/iio/health/ti,afe4404.yaml
> new file mode 100644
> index 000000000000..187b99b22312
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/health/ti,afe4404.yaml
> @@ -0,0 +1,51 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/health/ti,afe4404.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Texas Instruments AFE4404 Heart rate and Pulse Oximeter
> +
> +maintainers:
> +  - Andrew F. Davis <afd@ti.com>
> +
> +properties:
> +  compatible:
> +    const: ti,afe4403

Typo here, which causes this warning:

Documentation/devicetree/bindings/iio/health/ti,afe4403.example.dt.yaml:
heart_mon@0: 'spi-max-frequency' does not match any of the regexes:
'pinctrl-[0-9]+'

Took me a minute staring at ti,afe4403.yaml to figure out what was happening.

Rob
