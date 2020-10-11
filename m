Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CDD128AA90
	for <lists+linux-iio@lfdr.de>; Sun, 11 Oct 2020 23:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387403AbgJKVCH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 11 Oct 2020 17:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387399AbgJKVCH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 11 Oct 2020 17:02:07 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BBD3C0613CE
        for <linux-iio@vger.kernel.org>; Sun, 11 Oct 2020 14:02:07 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id q202so6323830iod.9
        for <linux-iio@vger.kernel.org>; Sun, 11 Oct 2020 14:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BwvVAVJ2zGUNAauYXeQYWuK1sF/J5HrGz1192v+Hhdk=;
        b=EduxmHo2n4bPmtCg7ZcsZSPwWF1UZ9Lq2scmhpfKBuAVJ0Y7Zb/OOl1R+51ls9lMJN
         I8KJYnx6mL+Tv31w8imxKWklQNTVX76/HCitm8UNjt6cqsuEuNB6BotoL1xBuZloyUuQ
         PIblNE4rhWb3QPnNduQYB1/Wcs3AMTIM4i+IDSDv9SlCyzTRzMrZES20kAhUQpNwS+gy
         Uc7CK+M+bXxLloWgi/ynN6+L9GemwE41WnchUfwVPidd/tnAqjsLXHt4JI5+I9zM0Tj6
         ICrNQ//EqJg8WBuDLY0BmegAlXFfUFCMGUM2b8Ju4b8dXmsQB9eS72dewW7sQ0YIqWRg
         5sUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BwvVAVJ2zGUNAauYXeQYWuK1sF/J5HrGz1192v+Hhdk=;
        b=ggso2ttJqRO96etk/yK4X1LRSeayvFvsszIGdfM4cvpPwI7FcEw1lkYmLhk58CXGi/
         xZg+ch4nwYyAWeNxwqAhfvWdU6iVRTFrgMnyN4GOOPuMPn6QaxF/Lh5sux2XcKnQZ7X9
         1NNYeMNs+ib1+QoObxg9ccBMFOTEjEg2i1FaAVT3cCDCt81kQEEUJH5DV9yNk4pCjrv7
         pdiTz6QumZseoEnHvTPx9MFZSNg9P902vBEGWhgkuBNN7l/0D/JCVn4+GTKpTp1Ndpoe
         3R+ZpDW76NFoPeVrJ7cLQSbL8xSIOGBY1K+P3hU1/zN1KT9cjGU8lkZIH6qP0b0SQU7f
         BWYQ==
X-Gm-Message-State: AOAM532NJGVwiRoGf0j83+o0Qf8F3iMAp4f9oA0TIqrq7qUDb3e9kcCl
        VQ2M3L7M2EQD2jzfJp+tguajCu/endjDhR1U/RGAsg==
X-Google-Smtp-Source: ABdhPJy2qkEwTb6V1D8ai3Ou/aOo+u8KHrZEP+pvVFex6NwsBeRH51cqzcoRrIC0hd42oB3/oK1g0y+sKYex5s0UfcY=
X-Received: by 2002:a05:6602:2354:: with SMTP id r20mr14488042iot.93.1602450126701;
 Sun, 11 Oct 2020 14:02:06 -0700 (PDT)
MIME-Version: 1.0
References: <20201011170749.243680-1-jic23@kernel.org> <20201011170749.243680-26-jic23@kernel.org>
In-Reply-To: <20201011170749.243680-26-jic23@kernel.org>
From:   Crt Mori <cmo@melexis.com>
Date:   Sun, 11 Oct 2020 23:01:30 +0200
Message-ID: <CAKv63uva=GEH40SjWNgd4FvdHuKU=kQw2pSArt+M6fYmTt1zyA@mail.gmail.com>
Subject: Re: [PATCH 25/29] dt-bindings:iio:temperature:melexis,mlx90632
 conversion to yaml
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Linux Iio <linux-iio@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Thanks for the conversion. No idea which tag to put, so:
Acked-by: Crt Mori <cmo@melexis.com>

On Sun, 11 Oct 2020 at 19:10, Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Technically this could have gone in trivial-devices.yaml, but I have
> kept it as a separate binding due to the detailed additional description
> from the text file.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Crt Mori <cmo@melexis.com>
> ---
>  .../iio/temperature/melexis,mlx90632.yaml     | 55 +++++++++++++++++++
>  .../bindings/iio/temperature/mlx90632.txt     | 28 ----------
>  2 files changed, 55 insertions(+), 28 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/iio/temperature/melexis,mlx90632.yaml b/Documentation/devicetree/bindings/iio/temperature/melexis,mlx90632.yaml
> new file mode 100644
> index 000000000000..b547ddcd544a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/temperature/melexis,mlx90632.yaml
> @@ -0,0 +1,55 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/temperature/melexis,mlx90632.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Melexis MLX90632 contactless Infra Red temperature sensor
> +
> +maintainers:
> +  - Crt Mori <cmo@melexis.com>
> +
> +description: |
> +  https://www.melexis.com/en/documents/documentation/datasheets/datasheet-mlx90632
> +
> +  There are various applications for the Infra Red contactless temperature
> +  sensor and MLX90632 is most suitable for consumer applications where
> +  measured object temperature is in range between -20 to 200 degrees
> +  Celsius with relative error of measurement below 1 degree Celsius in
> +  object temperature range for industrial applications. Since it can
> +  operate and measure ambient temperature in range of -20 to 85 degrees
> +  Celsius it is suitable also for outdoor use.
> +
> +  Be aware that electronics surrounding the sensor can increase ambient
> +  temperature. MLX90632 can be calibrated to reduce the housing effect via
> +  already existing EEPROM parameters.
> +
> +  Since measured object emissivity effects Infra Red energy emitted,
> +  emissivity should be set before requesting the object temperature.
> +
> +properties:
> +  compatible:
> +    const: melexis,mlx90632
> +
> +  reg:
> +    maxItems: 1
> +    description: Default is 0x3a, but can be reprogrammed.
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        temp-sensor@3a {
> +            compatible = "melexis,mlx90632";
> +            reg = <0x3a>;
> +        };
> +    };
> +...
> diff --git a/Documentation/devicetree/bindings/iio/temperature/mlx90632.txt b/Documentation/devicetree/bindings/iio/temperature/mlx90632.txt
> deleted file mode 100644
> index 0b05812001f8..000000000000
> --- a/Documentation/devicetree/bindings/iio/temperature/mlx90632.txt
> +++ /dev/null
> @@ -1,28 +0,0 @@
> -* Melexis MLX90632 contactless Infra Red temperature sensor
> -
> -Link to datasheet: https://www.melexis.com/en/documents/documentation/datasheets/datasheet-mlx90632
> -
> -There are various applications for the Infra Red contactless temperature sensor
> -and MLX90632 is most suitable for consumer applications where measured object
> -temperature is in range between -20 to 200 degrees Celsius with relative error
> -of measurement below 1 degree Celsius in object temperature range for
> -industrial applications. Since it can operate and measure ambient temperature
> -in range of -20 to 85 degrees Celsius it is suitable also for outdoor use.
> -
> -Be aware that electronics surrounding the sensor can increase ambient
> -temperature. MLX90632 can be calibrated to reduce the housing effect via
> -already existing EEPROM parameters.
> -
> -Since measured object emissivity effects Infra Red energy emitted, emissivity
> -should be set before requesting the object temperature.
> -
> -Required properties:
> -  - compatible: should be "melexis,mlx90632"
> -  - reg: the I2C address of the sensor (default 0x3a)
> -
> -Example:
> -
> -mlx90632@3a {
> -       compatible = "melexis,mlx90632";
> -       reg = <0x3a>;
> -};
> --
> 2.28.0
>
