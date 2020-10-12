Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC1D828BE23
	for <lists+linux-iio@lfdr.de>; Mon, 12 Oct 2020 18:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403874AbgJLQiF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 12 Oct 2020 12:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403815AbgJLQiE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 12 Oct 2020 12:38:04 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80A31C0613D0
        for <linux-iio@vger.kernel.org>; Mon, 12 Oct 2020 09:38:04 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id l16so1849906ilj.9
        for <linux-iio@vger.kernel.org>; Mon, 12 Oct 2020 09:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/Gx50nGZcX4AGWkDVX6hjpDj37zozEIQUpXyjJnxQqk=;
        b=BeAIAKtsWa3kqXltsA/Uz51smjmGEtQd2B5JdGPQOmptv8NpfrmObm7M55uuUaz7xf
         zOLuTApYb8+oVM81a5AgFww2ytnrT7jZ9T5RrszSGRyJVzzZEotYASXe76Lv6QBzVMde
         5DxrIVv5TqmaOjV+Mqrbc9q1f6sZmRj0isDE0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/Gx50nGZcX4AGWkDVX6hjpDj37zozEIQUpXyjJnxQqk=;
        b=MGG0xcD79ecL2YI/8z6O47ZtTAst6VMDJDGhghRk53UM0ygxV10Curyf09HkBpPT7b
         KiPUeZkUdiK8VMq61r/ehjYG5B7UD7qfT0wbH5iSR3E17uZNTuJdTjruAiKWzcgh9X2d
         fmBplN2T+hVdNvBgLm9tdXDJanEJelMgShQIiNicsYyoBQ5+PniVA5I6e1st+rlnHyXW
         +2sHlg8gmNIc2kRdANkMLxFGYJ4BtWmfKFBeKy04BF3j6wjL/+tulwPTlQZ1jmLvc+Yr
         VpjFYv4SDf0GGc3qoq8Bhr+9q71sQin07d0/34ybXaMe2Wu2w/a5spP5A+sQL5u+/slG
         tkqA==
X-Gm-Message-State: AOAM532ecTf7ysDEy4pklFBnAW6qIaN59XcfBXAquuHda1hIQSern9jE
        kC3KDK2qg2l6bNFjv12Zjfdr/e5/dryIHsx0sUoDlQ==
X-Google-Smtp-Source: ABdhPJzOdmVdk2tdkS3uP/T+i9kqfyzqedDZNJPnYi2wvWSD7gLtFBDzmsgQv+OQXT8u4Wrki+HBG25nF88zvbrmPDA=
X-Received: by 2002:a92:5f03:: with SMTP id t3mr20516987ilb.25.1602520683833;
 Mon, 12 Oct 2020 09:38:03 -0700 (PDT)
MIME-Version: 1.0
References: <20201011170749.243680-1-jic23@kernel.org> <20201011170749.243680-12-jic23@kernel.org>
In-Reply-To: <20201011170749.243680-12-jic23@kernel.org>
From:   Matt Ranostay <matt.ranostay@konsulko.com>
Date:   Mon, 12 Oct 2020 09:37:52 -0700
Message-ID: <CAJCx=g=Vaf9yCE29F9NtO0HHP2az4Ee8vSzWthR_aUT8p+TUcw@mail.gmail.com>
Subject: Re: [PATCH 11/29] dt-bindings:iio:proximity:ams,as3935 yaml conversion
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
> A straight forward conversion of this binding. I have added
> a maximum SPI frequency from the datasheet.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Matt Ranostay <matt.ranostay@konsulko.com>

Acked-by: Matt Ranostay <matt.ranostay@konsulko.com>

> ---
>  .../bindings/iio/proximity/ams,as3935.yaml    | 71 +++++++++++++++++++
>  .../bindings/iio/proximity/as3935.txt         | 34 ---------
>  2 files changed, 71 insertions(+), 34 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/iio/proximity/ams,as3935.yaml b/Documentation/devicetree/bindings/iio/proximity/ams,as3935.yaml
> new file mode 100644
> index 000000000000..7fcba5d6d508
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/proximity/ams,as3935.yaml
> @@ -0,0 +1,71 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/proximity/ams,as3935.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Austrian Microsystems AS3935 Franklin lightning sensor
> +
> +maintainers:
> +  - Matt Ranostay <matt.ranostay@konsulko.com>
> +
> +description:
> +  This lightening distance sensor uses an I2C or SPI interface. The
> +  binding currently only covers the SPI option.
> +
> +properties:
> +  compatible:
> +    const: ams,as3935
> +
> +  reg:
> +    maxItems: 1
> +
> +  spi-max-frequency:
> +    maximum: 2000000
> +
> +  spi-cpha: true
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  ams,tuning-capacitor-pf:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Calibration tuning capacitor stepping value. This will require using
> +      the calibration data from the manufacturer.
> +    minimum: 0
> +    maximum: 120
> +
> +  ams,nflwdth:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Set the noise and watchdog threshold register on startup. This will
> +      need to set according to the noise from the MCU board, and possibly
> +      the local environment. Refer to the datasheet for the threshold settings.
> +
> +required:
> +  - compatible
> +  - reg
> +  - spi-cpha
> +  - interrupts
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +    lightning@0 {
> +            compatible = "ams,as3935";
> +            reg = <0>;
> +            spi-max-frequency = <400000>;
> +            spi-cpha;
> +            interrupt-parent = <&gpio1>;
> +            interrupts = <16 1>;
> +            ams,tuning-capacitor-pf = <80>;
> +            ams,nflwdth = <0x44>;
> +        };
> +    };
> +...
> diff --git a/Documentation/devicetree/bindings/iio/proximity/as3935.txt b/Documentation/devicetree/bindings/iio/proximity/as3935.txt
> deleted file mode 100644
> index 849115585d55..000000000000
> --- a/Documentation/devicetree/bindings/iio/proximity/as3935.txt
> +++ /dev/null
> @@ -1,34 +0,0 @@
> -Austrian Microsystems AS3935 Franklin lightning sensor device driver
> -
> -Required properties:
> -       - compatible: must be "ams,as3935"
> -       - reg: SPI chip select number for the device
> -       - spi-max-frequency: specifies maximum SPI clock frequency
> -       - spi-cpha: SPI Mode 1. Refer to spi/spi-bus.txt for generic SPI
> -       slave node bindings.
> -       - interrupts : the sole interrupt generated by the device
> -
> -       Refer to interrupt-controller/interrupts.txt for generic
> -       interrupt client node bindings.
> -
> -Optional properties:
> -       - ams,tuning-capacitor-pf: Calibration tuning capacitor stepping
> -         value 0 - 120pF. This will require using the calibration data from
> -         the manufacturer.
> -       - ams,nflwdth: Set the noise and watchdog threshold register on
> -         startup. This will need to set according to the noise from the
> -         MCU board, and possibly the local environment. Refer to the
> -         datasheet for the threshold settings.
> -
> -Example:
> -
> -as3935@0 {
> -       compatible = "ams,as3935";
> -       reg = <0>;
> -       spi-max-frequency = <400000>;
> -       spi-cpha;
> -       interrupt-parent = <&gpio1>;
> -       interrupts = <16 1>;
> -       ams,tuning-capacitor-pf = <80>;
> -       ams,nflwdth = <0x44>;
> -};
> --
> 2.28.0
>
