Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFF0F28BE27
	for <lists+linux-iio@lfdr.de>; Mon, 12 Oct 2020 18:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403873AbgJLQkX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 12 Oct 2020 12:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403785AbgJLQkX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 12 Oct 2020 12:40:23 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 341D4C0613D0
        for <linux-iio@vger.kernel.org>; Mon, 12 Oct 2020 09:40:22 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id q202so9000960iod.9
        for <linux-iio@vger.kernel.org>; Mon, 12 Oct 2020 09:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nQXthKWOCuvWYAd3n++v/Kp8SGBPwTxzwdSkA7wW/pI=;
        b=k8i4FcSXIOwp52Ro99GDRJOX0BAyo0bjrEFwFg1T0vovDD8i2YO00YH0Y9f1ZsZa1x
         MhZtuWsV9qtI/pipUQM9Noc+ETU3Fi7+s2QIewkCuMldWwARXpAigBEIWlDbJnLu596U
         GaNDdLRShkO+/r9Vdr863SYVMOFVgEquC5wLc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nQXthKWOCuvWYAd3n++v/Kp8SGBPwTxzwdSkA7wW/pI=;
        b=cZ3RfaBJunO/ab7bYXe/qkqHy+oTviEfWRPyWggb+Z5oYm1k8HlqfTwTu0utz0EuCh
         0VRWNjpkGGCsEw9MFHTahPW44dqJsyE/vA8cPTTDCIXVg+Vdl2pqA6txDlpbyae/OfyA
         6L3X8iRt3s0G2+84XnMSJ8pUMeT+W8nXMRkfgwx02x++vfzUWGCvferEgDOGdPwXNayG
         AcZEkKvJwHoEX4HXV7I44CSsD7mBHJ05zv7BAdXB5sflhF5bHU20rOiqCIUeIALj3PIB
         5j+ukHCrP3aBChxk2OH1gfBdkj0Y7DUuU0owXEdxz8ghBIEe135dgDxye/r5fLT+48a4
         9x0g==
X-Gm-Message-State: AOAM530Ib9AajOASiTQqgi60LDp1xPLrr7ni6TEGHS9rT81GszmgjPEI
        dPjNI1yXZfiEnnXn+ES5yrDQm/DRlsJlc3mhQjg4iA==
X-Google-Smtp-Source: ABdhPJzpL24L11UweDxYKo6pl17VSD+CO5DL2s+w2JX+0P8xf3qzzJ05YBfl0hidBgHLNRSZ5HKRhiBS5qmBUrD7AWc=
X-Received: by 2002:a5e:9913:: with SMTP id t19mr7473519ioj.95.1602520821409;
 Mon, 12 Oct 2020 09:40:21 -0700 (PDT)
MIME-Version: 1.0
References: <20201011170749.243680-1-jic23@kernel.org> <20201011170749.243680-29-jic23@kernel.org>
In-Reply-To: <20201011170749.243680-29-jic23@kernel.org>
From:   Matt Ranostay <matt.ranostay@konsulko.com>
Date:   Mon, 12 Oct 2020 09:40:10 -0700
Message-ID: <CAJCx=gkEiuj5aGo5VXLQdk98q=giVCruwCSQF5dPjD-_dxm7fw@mail.gmail.com>
Subject: Re: [PATCH 28/29] dt-bindings:iio:temperature:maxim_thermocouple.txt
 to maxim,max31855k.yaml
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Oct 11, 2020 at 10:10 AM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Given we already have another maxim thermocouple driver that isn't
> covered by this binding it seems a better idea to chose to name it
> after a specific part.
>
> I added an additional example for the maxim,max6755 to illustrate
> the need for spi-cpha for that part.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Matt Ranostay <matt.ranostay@konsulko.com>
> ---
>  .../iio/temperature/maxim,max31855k.yaml      | 76 +++++++++++++++++++
>  .../iio/temperature/maxim_thermocouple.txt    | 24 ------
>  2 files changed, 76 insertions(+), 24 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/iio/temperature/maxim,max31855k.yaml b/Documentation/devicetree/bindings/iio/temperature/maxim,max31855k.yaml
> new file mode 100644
> index 000000000000..835e2d06b523
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/temperature/maxim,max31855k.yaml
> @@ -0,0 +1,76 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/temperature/maxim,max31855k.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Maxim MAX31855 and similar thermocouples
> +
> +maintainers:
> +  - Matt Ranostay <matt.ranostay@konsulko.com>
> +
> +description: |
> +  https://datasheets.maximintegrated.com/en/ds/MAX6675.pdf
> +  https://datasheets.maximintegrated.com/en/ds/MAX31855.pdf
> +
> +properties:
> +  compatible:
> +    description:
> +      The generic maxim,max31855 compatible is deprecated in favour of
> +      the thermocouple type specific varients.

Typo of "variants"

Otherwise looks good to me.

Acked-by: Matt Ranostay <matt.ranostay@konsulko.com>

> +    enum:
> +      - maxim,max6675
> +      - maxim,max31855
> +      - maxim,max31855k
> +      - maxim,max31855j
> +      - maxim,max31855n
> +      - maxim,max31855s
> +      - maxim,max31855t
> +      - maxim,max31855e
> +      - maxim,max31855r
> +
> +  reg:
> +    maxItems: 1
> +
> +  spi-max-frequency: true
> +  spi-cpha: true
> +
> +required:
> +  - compatible
> +  - reg
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - maxim,max6675
> +    then:
> +      required:
> +        - spi-cpha
> +    else:
> +      properties:
> +        spi-cpha: false
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        temp-sensor@0 {
> +            compatible = "maxim,max31855k";
> +            reg = <0>;
> +            spi-max-frequency = <4300000>;
> +        };
> +        temp-sensor@1 {
> +            compatible = "maxim,max6675";
> +            reg = <1>;
> +            spi-max-frequency = <4300000>;
> +            spi-cpha;
> +        };
> +    };
> +...
> diff --git a/Documentation/devicetree/bindings/iio/temperature/maxim_thermocouple.txt b/Documentation/devicetree/bindings/iio/temperature/maxim_thermocouple.txt
> deleted file mode 100644
> index bb85cd0e039c..000000000000
> --- a/Documentation/devicetree/bindings/iio/temperature/maxim_thermocouple.txt
> +++ /dev/null
> @@ -1,24 +0,0 @@
> -Maxim thermocouple support
> -
> -* https://datasheets.maximintegrated.com/en/ds/MAX6675.pdf
> -* https://datasheets.maximintegrated.com/en/ds/MAX31855.pdf
> -
> -Required properties:
> -
> -       - compatible: must be "maxim,max6675" or one of the following:
> -          "maxim,max31855k", "maxim,max31855j", "maxim,max31855n",
> -          "maxim,max31855s", "maxim,max31855t", "maxim,max31855e",
> -          "maxim,max31855r"; the generic "max,max31855" is deprecated.
> -       - reg: SPI chip select number for the device
> -       - spi-max-frequency: must be 4300000
> -       - spi-cpha: must be defined for max6675 to enable SPI mode 1
> -
> -       Refer to spi/spi-bus.txt for generic SPI slave bindings.
> -
> -Example:
> -
> -       max31855@0 {
> -               compatible = "maxim,max31855k";
> -               reg = <0>;
> -               spi-max-frequency = <4300000>;
> -       };
> --
> 2.28.0
>
