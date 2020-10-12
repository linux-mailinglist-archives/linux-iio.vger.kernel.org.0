Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9932028B62F
	for <lists+linux-iio@lfdr.de>; Mon, 12 Oct 2020 15:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729878AbgJLNaT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 12 Oct 2020 09:30:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:33252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726742AbgJLNaT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 12 Oct 2020 09:30:19 -0400
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47F71204EA
        for <linux-iio@vger.kernel.org>; Mon, 12 Oct 2020 13:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602509418;
        bh=RvHUvHNwgMthJEq0N1S0PifX1Z79FwWwKXDsKJtGLnc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mb4sfr1WeWhsxWNQxlL5GbRPmzGBOiVyESpxFR0BuxZ27Lht7dKcG3kkIJiEbcAI1
         5op5SgIhSJIG9C0BDReUmETvp9kTx3eT3YeMYm5Ua6tMcaoQGGKf/Iwc4vAZf50DcL
         9ELGER0ISPfSVs0X4QTpd2o1dS+97AcGytjQAY6g=
Received: by mail-oi1-f180.google.com with SMTP id j7so1148399oie.12
        for <linux-iio@vger.kernel.org>; Mon, 12 Oct 2020 06:30:18 -0700 (PDT)
X-Gm-Message-State: AOAM533v7ERlieUJohD86NA6RbBY+OWrshJezJSrAA8WoA4v3UgCeygw
        IE+rO8dShNF2l0mofQIoo1rhr9KafThSRLMFwg==
X-Google-Smtp-Source: ABdhPJxRqK97ww9uS7++bc1iJF7LO43xzAxeOKiuP/iJsOGaXZhSPO7hW7vQFV1MC+ol59Yb93fPMqnfb1TdMeoHoYw=
X-Received: by 2002:a05:6808:10e:: with SMTP id b14mr11160977oie.152.1602509417503;
 Mon, 12 Oct 2020 06:30:17 -0700 (PDT)
MIME-Version: 1.0
References: <20201011163031.240708-1-jic23@kernel.org> <20201011163031.240708-2-jic23@kernel.org>
In-Reply-To: <20201011163031.240708-2-jic23@kernel.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 12 Oct 2020 08:30:06 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+X=K2b62+_SR-x-3ZEmcEnCpVRD22S3eLH_UXZb_dGhw@mail.gmail.com>
Message-ID: <CAL_Jsq+X=K2b62+_SR-x-3ZEmcEnCpVRD22S3eLH_UXZb_dGhw@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings:iio:iio-consumer add yaml binding for IIO consumers
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Oct 11, 2020 at 11:33 AM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> This can be used via $ref by bindings that are consumers of the
> channels provided by IIO devices.

For consumers like this, I'd suggest instead doing 'select: true' and
no $ref. The reason being is we always need additional constraints in
the user bindings, and the 'select' means the properties are always at
least type checked.

I'd also prefer if we move this to the dtschema repo.

Otherwise, looks fine.

> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  .../devicetree/bindings/iio/iio-bindings.txt  | 53 -----------------
>  .../devicetree/bindings/iio/iio-consumer.yaml | 59 +++++++++++++++++++
>  2 files changed, 59 insertions(+), 53 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/iio/iio-bindings.txt b/Documentation/devicetree/bindings/iio/iio-bindings.txt
> index aa63cac7323e..cfaed2b54fa9 100644
> --- a/Documentation/devicetree/bindings/iio/iio-bindings.txt
> +++ b/Documentation/devicetree/bindings/iio/iio-bindings.txt
> @@ -47,56 +47,3 @@ Example for a configuration with trigger:
>                 };
>         };
>
> -==IIO consumers==
> -
> -Required properties:
> -io-channels:   List of phandle and IIO specifier pairs, one pair
> -               for each IIO input to the device. Note: if the
> -               IIO provider specifies '0' for #io-channel-cells,
> -               then only the phandle portion of the pair will appear.
> -
> -Optional properties:
> -io-channel-names:
> -               List of IIO input name strings sorted in the same
> -               order as the io-channels property. Consumers drivers
> -               will use io-channel-names to match IIO input names
> -               with IIO specifiers.
> -io-channel-ranges:
> -               Empty property indicating that child nodes can inherit named
> -               IIO channels from this node. Useful for bus nodes to provide
> -               and IIO channel to their children.
> -
> -For example:
> -
> -       device {
> -               io-channels = <&adc 1>, <&ref 0>;
> -               io-channel-names = "vcc", "vdd";
> -       };
> -
> -This represents a device with two IIO inputs, named "vcc" and "vdd".
> -The vcc channel is connected to output 1 of the &adc device, and the
> -vdd channel is connected to output 0 of the &ref device.
> -
> -==Example==
> -
> -       adc: max1139@35 {
> -               compatible = "maxim,max1139";
> -               reg = <0x35>;
> -               #io-channel-cells = <1>;
> -       };
> -
> -       ...
> -
> -       iio-hwmon {
> -               compatible = "iio-hwmon";
> -               io-channels = <&adc 0>, <&adc 1>, <&adc 2>,
> -                       <&adc 3>, <&adc 4>, <&adc 5>,
> -                       <&adc 6>, <&adc 7>, <&adc 8>,
> -                       <&adc 9>;
> -       };
> -
> -       some_consumer {
> -               compatible = "some-consumer";
> -               io-channels = <&adc 10>, <&adc 11>;
> -               io-channel-names = "adc1", "adc2";
> -       };
> diff --git a/Documentation/devicetree/bindings/iio/iio-consumer.yaml b/Documentation/devicetree/bindings/iio/iio-consumer.yaml
> new file mode 100644
> index 000000000000..5f28cc29edce
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/iio-consumer.yaml
> @@ -0,0 +1,59 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/iio-consumer.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Generic IIO consumer-bindings
> +
> +maintainers:
> +  - Jonathan Cameron <jic23@kernel.org>
> +
> +description:
> +  This binding describes generic properties a consumer of the channels
> +  provided by an IIO device may use.
> +
> +  As well, direct readings of channels on an IIO Device, an IIO device
> +  can provide services to consumer devices. Thes are in the form of
> +  channel readings and properties.  For example, an ADC might provide
> +  3 channels to an analog accelerometer so that an accelerometer
> +  driver can use them to read the voltages that correspond to the
> +  accelerations on the 3 axis and apply appropriate calibration to
> +  provide useful outputs.
> +
> +properties:
> +  io-channels:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    description: >
> +      List of phandle and IIO specifier pairs, one pair
> +      for each IIO input to the device. Note: if the
> +      IIO provider specifies '0' for #io-channel-cells,
> +      then only the phandle portion of the pair will appear.
> +
> +  io-channel-names:
> +    $ref: /schemas/types.yaml#/definitions/string-array
> +    description: >
> +      List of names associated with a given IIO channel by the consumer
> +      device.  An example for an analog accelerometer would be "accel_x".
> +      Consumers drivers will use io-channel-names to locate the correct
> +      phandle based reference in io-channels.
> +
> +  io-channel-ranges:
> +    type: boolean
> +    description: >
> +      Empty property indicating that child nodes can inherit named
> +      IIO channels from this node. Useful for bus nodes to provide
> +      and IIO channel to their children.
> +
> +additionalProperties: true
> +
> +examples:
> + - |
> +   iio-hwmon {
> +       compatible = "iio-hwmon";
> +       io-channels = <&adc 0>, <&adc 1>, <&adc 2>,
> +                     <&adc 3>, <&adc 4>, <&adc 5>,
> +                     <&adc 6>, <&adc 7>, <&adc 8>,
> +                     <&adc 9>;
> +   };
> +...
> \ No newline at end of file
> --
> 2.28.0
>
