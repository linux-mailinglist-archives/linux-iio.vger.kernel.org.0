Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB79B2A26BE
	for <lists+linux-iio@lfdr.de>; Mon,  2 Nov 2020 10:13:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728254AbgKBJNf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 2 Nov 2020 04:13:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728132AbgKBJNf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 2 Nov 2020 04:13:35 -0500
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4663C0617A6
        for <linux-iio@vger.kernel.org>; Mon,  2 Nov 2020 01:13:33 -0800 (PST)
Received: by mail-il1-x144.google.com with SMTP id p10so12293380ile.3
        for <linux-iio@vger.kernel.org>; Mon, 02 Nov 2020 01:13:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G6vN48ROEcfnp1L/ujKy6U1at09yxtKW3Qm3NsnZ98E=;
        b=FZC9tAc0qn+/I6cywuN/wfPdSOA2gpB9+291+zVidcME1uuLaSObrGDWZmcJ0nm0Cu
         WHIN1OiJRoH/hvmPb4vbAiqzGGcpQjJ2JM7vEpBzxqUVodliJmfBQxdhxUku95371rwk
         sDPI3u3BBa1AcZYG78XL6BBY2STtRkqa2s6xMLqG8v/n8cGMKNB4xIhsPJvLCFGp+/iq
         SOl1mvgTbDJ0lHwCEa51bVFdIObwQZu0ZVSbZQR7RN1wV0+40iKTdG25Aey78tKQN0Z9
         t3uiZIfUY6046/+e6Y/A0bBpQMcbIP+33vIlrwpOup8nYw9ROsQeAjlcBQZfwFvl4ZGm
         W2LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G6vN48ROEcfnp1L/ujKy6U1at09yxtKW3Qm3NsnZ98E=;
        b=L5KXD/ftCSA07FyWjcVBxFzTapYf+ZmXSdcYjnAbMwSnZ8pZb8rd0G6qo3Yi5GkxEt
         +I6ZXdK7zF0p4aLuZNc4+gTS2sS4keBXd0d0xuUwL5V3hpdpi/AhCk+TYyhybfubsVgU
         U3wauo1jWvKuo62PZDqBiDKK2CSXq4fFKS9q07PMyG9nGXYD5VzF81OfdwHBxx9oUktA
         s7n4jIZBcyIqKB7fjo8wHOmU8ERMfU2HGoToQt+i853oM/EyqL5CEWaAgNXSzXiIFeAW
         2PFkAAXPzW6XuFL3sytU5e/X6OIxppO+0RwVs+0K5INZVmQ1yJ0HrHc5LAqhboeDYHXP
         bs5A==
X-Gm-Message-State: AOAM5326zCKILwqfP685Co8hn7jHdsefZzOQYXeM8onpml6eaY250O/d
        Ijww7o2S0f3uA+rxc1LbyZ1NoMw0zeOo6NHryswJYw==
X-Google-Smtp-Source: ABdhPJygXl8emxs8ScpieTpvJ0do2ErPZJih2gsaxBbyeOf4AowamyXOeNGjxaYOG2a/JA/RU1ntjAZasMVEquN85h4=
X-Received: by 2002:a92:d6cd:: with SMTP id z13mr10228162ilp.38.1604308412990;
 Mon, 02 Nov 2020 01:13:32 -0800 (PST)
MIME-Version: 1.0
References: <20201031134110.724233-1-jic23@kernel.org> <20201031134110.724233-25-jic23@kernel.org>
In-Reply-To: <20201031134110.724233-25-jic23@kernel.org>
From:   Crt Mori <cmo@melexis.com>
Date:   Mon, 2 Nov 2020 10:12:57 +0100
Message-ID: <CAKv63uvm4WMk6U=CthTcVTD+cM-kb9FLBxn2Os8Yy2mHJYoJ5Q@mail.gmail.com>
Subject: Re: [PATCH v2 24/29] dt-bindings:iio:temperature:melexis,mlx90614
 yaml conversion
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Linux Iio <linux-iio@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Rob Herring <robh@kernel.org>,
        Peter Meerwald <pmeerw@pmeerw.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,
The commit message should change here as now you did not list all 3
authors as maintainers, because one has a bouncy email address.

Best regards,
Crt

On Sat, 31 Oct 2020 at 14:44, Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Simple conversion from txt to yaml.
> I've listed all 3 authors of the driver as maintainers.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Acked-by: Crt Mori <cmo@melexis.com>
> Cc: Peter Meerwald <pmeerw@pmeerw.net>
> ---
>  .../iio/temperature/melexis,mlx90614.yaml     | 50 +++++++++++++++++++
>  .../bindings/iio/temperature/mlx90614.txt     | 24 ---------
>  2 files changed, 50 insertions(+), 24 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/iio/temperature/melexis,mlx90614.yaml b/Documentation/devicetree/bindings/iio/temperature/melexis,mlx90614.yaml
> new file mode 100644
> index 000000000000..d6965a0c1cf3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/temperature/melexis,mlx90614.yaml
> @@ -0,0 +1,50 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/temperature/melexis,mlx90614.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Melexis MLX90614 contactless IR temperature sensor
> +
> +maintainers:
> +  - Peter Meerwald <pmeerw@pmeerw.net>
> +  - Crt Mori <cmo@melexis.com>
> +
> +description: |
> +  http://melexis.com/Infrared-Thermometer-Sensors/Infrared-Thermometer-Sensors/MLX90614-615.aspx
> +
> +properties:
> +  compatible:
> +    const: melexis,mlx90614
> +
> +  reg:
> +    maxItems: 1
> +
> +  wakeup-gpios:
> +    description:
> +      GPIO connected to the SDA line to hold low in order to wake up the
> +      device.  In normal operation, the GPIO is set as input and will
> +      not interfere in I2C communication.  There is no need for a GPIO
> +      driving the SCL line.  If no GPIO is given, power management is disabled.
> +    maxItems: 1
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
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        temp-sensor@5a {
> +            compatible = "melexis,mlx90614";
> +            reg = <0x5a>;
> +            wakeup-gpios = <&gpio0 2 GPIO_ACTIVE_HIGH>;
> +        };
> +    };
> +...
> diff --git a/Documentation/devicetree/bindings/iio/temperature/mlx90614.txt b/Documentation/devicetree/bindings/iio/temperature/mlx90614.txt
> deleted file mode 100644
> index 9be57b036092..000000000000
> --- a/Documentation/devicetree/bindings/iio/temperature/mlx90614.txt
> +++ /dev/null
> @@ -1,24 +0,0 @@
> -* Melexis MLX90614 contactless IR temperature sensor
> -
> -http://melexis.com/Infrared-Thermometer-Sensors/Infrared-Thermometer-Sensors/MLX90614-615.aspx
> -
> -Required properties:
> -
> -  - compatible: should be "melexis,mlx90614"
> -  - reg: the I2C address of the sensor
> -
> -Optional properties:
> -
> -  - wakeup-gpios: device tree identifier of the GPIO connected to the SDA line
> -      to hold low in order to wake up the device.  In normal operation, the
> -      GPIO is set as input and will not interfere in I2C communication.  There
> -      is no need for a GPIO driving the SCL line.  If no GPIO is given, power
> -      management is disabled.
> -
> -Example:
> -
> -mlx90614@5a {
> -       compatible = "melexis,mlx90614";
> -       reg = <0x5a>;
> -       wakeup-gpios = <&gpio0 2 GPIO_ACTIVE_HIGH>;
> -};
> --
> 2.28.0
>
