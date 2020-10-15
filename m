Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 626E528EEC4
	for <lists+linux-iio@lfdr.de>; Thu, 15 Oct 2020 10:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388337AbgJOIt1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 15 Oct 2020 04:49:27 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41753 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388282AbgJOIt1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 15 Oct 2020 04:49:27 -0400
Received: by mail-lf1-f65.google.com with SMTP id d24so2649916lfa.8
        for <linux-iio@vger.kernel.org>; Thu, 15 Oct 2020 01:49:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/Ya02bxBzqoQ9rFqplunA3rH5eOk1H7nY6BN2PgHyAU=;
        b=h61Vo2Ijd5R0mUlbmjxYE96gS7RuXPe8mCRl4yXKCPxTleGwv1FeKj9kpnAM7Xk8Se
         zBoUDyPC6zAu8qfHcUqSeqQYbBxVoAHTxhyq8TQX2xnkln06yWtWT1q+Lgz/lZDnKecX
         CsYIKis4TJNz3Q8cgk9gXPnhxEU7dw9D0eFr7ZY3gjoLIk1CvxhZD23OTEU0jPqW/mBH
         Roh+s2oJ+neUuSYjPH4j1D5vozNP7gajrDBQNKDM9w8B3bbapBhq+3N12JYTNlozCHAk
         SWv8a7SnRi1afZEc3hypjhqMN+CyIx9dkwifNe/MhxxMS70xgcDAf8NKih9k0wC5HfxM
         TS+w==
X-Gm-Message-State: AOAM5326/8fqjS7ZLuM6qYQX30UKEUBzbXBYFYCzJ3zLs0TimRzTbxv5
        Py6Qp2rPJxTq8WsuFWJmEeKJTlqa2K5uvXrh1Ag=
X-Google-Smtp-Source: ABdhPJy3TtZ+NCVN1bqxWgf8oMYwjZa/a5nKEsSXgiBH5/8qUEuPB9W7/8PZqjNTS3VjbN7FjDytQRYCNafhJN4SLvQ=
X-Received: by 2002:a19:c6d6:: with SMTP id w205mr802569lff.94.1602751765027;
 Thu, 15 Oct 2020 01:49:25 -0700 (PDT)
MIME-Version: 1.0
References: <20201011170749.243680-1-jic23@kernel.org> <20201011170749.243680-16-jic23@kernel.org>
In-Reply-To: <20201011170749.243680-16-jic23@kernel.org>
From:   Ricardo Ribalda Delgado <ricardo@ribalda.com>
Date:   Thu, 15 Oct 2020 10:49:08 +0200
Message-ID: <CAPybu_2H--T+54B70mBDu45VxK11Qyp7UnAAHTKtv6MoMemaLw@mail.gmail.com>
Subject: Re: [PATCH 15/29] dt-bindings:iio:dac:ti,dac7612 yaml conversion
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Signed-off-by: Ricardo Ribalda <ribalda@kernel.org>

On Sun, Oct 11, 2020 at 7:10 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Simple conversion from txt to yaml.  No significant adjustments.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Ricardo Ribalda Delgado <ricardo@ribalda.com>
> ---
>  .../bindings/iio/dac/ti,dac7612.txt           | 28 ----------
>  .../bindings/iio/dac/ti,dac7612.yaml          | 53 +++++++++++++++++++
>  2 files changed, 53 insertions(+), 28 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/iio/dac/ti,dac7612.txt b/Documentation/devicetree/bindings/iio/dac/ti,dac7612.txt
> deleted file mode 100644
> index 17af395b99d9..000000000000
> --- a/Documentation/devicetree/bindings/iio/dac/ti,dac7612.txt
> +++ /dev/null
> @@ -1,28 +0,0 @@
> -* Texas Instruments Dual, 12-Bit Serial Input Digital-to-Analog Converter
> -
> -The DAC7612 is a dual, 12-bit digital-to-analog converter (DAC) with guaranteed
> -12-bit monotonicity performance over the industrial temperature range.
> -Is is programmable through an SPI interface.
> -
> -The internal DACs are loaded when the LOADDACS pin is pulled down.
> -
> -https://www.ti.com/lit/ds/sbas106/sbas106.pdf
> -
> -Required Properties:
> -- compatible: Should be one of:
> -               "ti,dac7612"
> -               "ti,dac7612u"
> -               "ti,dac7612ub"
> -- reg: Definition as per Documentation/devicetree/bindings/spi/spi-bus.txt
> -
> -Optional Properties:
> -- ti,loaddacs-gpios: GPIO descriptor for the LOADDACS pin.
> -- spi-*: Definition as per Documentation/devicetree/bindings/spi/spi-bus.txt
> -
> -Example:
> -
> -       dac@1 {
> -               compatible = "ti,dac7612";
> -               reg = <0x1>;
> -               ti,loaddacs-gpios = <&msmgpio 25 GPIO_ACTIVE_LOW>;
> -       };
> diff --git a/Documentation/devicetree/bindings/iio/dac/ti,dac7612.yaml b/Documentation/devicetree/bindings/iio/dac/ti,dac7612.yaml
> new file mode 100644
> index 000000000000..d172b142f6ed
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/dac/ti,dac7612.yaml
> @@ -0,0 +1,53 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/dac/ti,dac7612.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Texas Instruments DAC7612 family of DACs
> +
> +description:
> +  The DAC7612 is a dual, 12-bit digital-to-analog converter (DAC) with
> +  guaranteed 12-bit monotonicity performance over the industrial temperature
> +  range. Is is programmable through an SPI interface.
> +
> +maintainers:
> +  - Ricardo Ribalda Delgado <ricardo@ribalda.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ti,dac7612
> +      - ti,dac7612u
> +      - ti,dac7612ub
> +
> +  reg:
> +    maxItems: 1
> +
> +  ti,loaddacs-gpios:
> +    description:
> +      DACs are loaded when the pin connected to this GPIO is pulled low.
> +    maxItems: 1
> +
> +  spi-max-frequency: true
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        dac@1 {
> +            compatible = "ti,dac7612";
> +            reg = <0x1>;
> +            ti,loaddacs-gpios = <&msmgpio 25 GPIO_ACTIVE_LOW>;
> +        };
> +    };
> +...
> --
> 2.28.0
>


-- 
Ricardo Ribalda
