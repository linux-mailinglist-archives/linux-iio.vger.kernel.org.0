Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC3F228AA8F
	for <lists+linux-iio@lfdr.de>; Sun, 11 Oct 2020 23:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387400AbgJKVBc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 11 Oct 2020 17:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387399AbgJKVBc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 11 Oct 2020 17:01:32 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81ECCC0613CE
        for <linux-iio@vger.kernel.org>; Sun, 11 Oct 2020 14:01:32 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id q7so14076620ile.8
        for <linux-iio@vger.kernel.org>; Sun, 11 Oct 2020 14:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WLMx3WnKY0z2tnBg9W6ySIyBw3H95Jb9lFGY0BC7rk8=;
        b=V86SmmdpvnJzmAiasiugEhIqBbq9OYdu7pRCyX+MLNak2KuFo3LHj4+gLSm2K1sRdD
         2fj/vbjcqwV1kgI7Psqhb45us3rX21fRFiqS1H0o4s/k7mbqy+xbWutp2bG9HhNVOy18
         sELaSQJAjONPet8OnhTvXsOGuC/rKZYQscrHFw3wjI/9i6HS1qTbHw61g1UkiJi3kX8N
         E4xx8vyCWzgSHlizi0LdBu1EVFB2g4TiAR/Yo6y86M8nGvfks1se0T2OiKCT6dt2Byj4
         IJzslJ7ZyAcE0fdP1Yjb9RZDKtfdTueAbRIMOwQE3tBBYg2OOj7tV7B1fBKeFuKFM9kN
         PCVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WLMx3WnKY0z2tnBg9W6ySIyBw3H95Jb9lFGY0BC7rk8=;
        b=QDMoeeksSOfY0IUvrhjVCoQIQ6IMhT0xY128iEwDSaIeNzbrNx0ZMK3ubFdByjzWWc
         rEsocGm/LrzWg1YE7gYqxmJZ8Sxkko0qx62mmrsC/CmTtwUEDTh1I4FvjIys6WmX5Osp
         Irk57FAQytdiHCnUDyb75e9IQcI/eNa9x3WMgiX9ALhhC+4f36uWVe7GCxAPNFx/ctVT
         nhdH6WzBOL5Qg++wHeGC8AsZmpykAbPVitSA8gA2t92ewKq6eRZPdon0SeLrtc4FfZX9
         92RYVbmv91oqJ94Hbwcn2+KtjrZbqNzljyVsy6jDu4UNYMohhru7PKhCBYDaHFzWBOhR
         6haA==
X-Gm-Message-State: AOAM532NrLyZ0VTxbJo8bycqkgkd2hZU/CU5iGDQ3gexCIDWcWLWN6qP
        agUxFT58asc4TqX8q3XmLIB1AN5bWClUSzjBvy3Z1i6Tewc=
X-Google-Smtp-Source: ABdhPJxEbzGRYqkDleCTBCtUhMoV7ZJxZxAhvzdhhvn1A/0s8l4e+yElnLgqp/wzHCohaAvAAxK0hQnH3HVh1F5ugAw=
X-Received: by 2002:a92:849a:: with SMTP id y26mr17211574ilk.38.1602450091696;
 Sun, 11 Oct 2020 14:01:31 -0700 (PDT)
MIME-Version: 1.0
References: <20201011170749.243680-1-jic23@kernel.org> <20201011170749.243680-25-jic23@kernel.org>
In-Reply-To: <20201011170749.243680-25-jic23@kernel.org>
From:   Crt Mori <cmo@melexis.com>
Date:   Sun, 11 Oct 2020 23:00:55 +0200
Message-ID: <CAKv63utWrhUTb+QUgy_nHniYEMuvK5UuZzD6-iRLGZaAtVHNHA@mail.gmail.com>
Subject: Re: [PATCH 24/29] dt-bindings:iio:temperature:melexis,mlx90614 yaml conversion
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Linux Iio <linux-iio@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        =?UTF-8?Q?Vianney_le_Cl=C3=A9ment_de_Saint=2DMarcq?= 
        <vianney.leclement@essensium.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Thanks for the conversion. No idea which tag to put, so:
Acked-by: Crt Mori <cmo@melexis.com>

On Sun, 11 Oct 2020 at 19:10, Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Simple conversion from txt to yaml.
> I've listed all 3 authors of the driver as maintainers.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Peter Meerwald <pmeerw@pmeerw.net>
> Cc: Vianney le Cl=C3=A9ment de Saint-Marcq <vianney.leclement@essensium.c=
om>
> Cc: Crt Mori <cmo@melexis.com>
> ---
>  .../iio/temperature/melexis,mlx90614.yaml     | 51 +++++++++++++++++++
>  .../bindings/iio/temperature/mlx90614.txt     | 24 ---------
>  2 files changed, 51 insertions(+), 24 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/iio/temperature/melexis,ml=
x90614.yaml b/Documentation/devicetree/bindings/iio/temperature/melexis,mlx=
90614.yaml
> new file mode 100644
> index 000000000000..dcda203b2ba5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/temperature/melexis,mlx90614.=
yaml
> @@ -0,0 +1,51 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/temperature/melexis,mlx90614.yaml=
#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Melexis MLX90614 contactless IR temperature sensor
> +
> +maintainers:
> +  - Peter Meerwald <pmeerw@pmeerw.net>
> +  - Vianney le Cl=C3=A9ment de Saint-Marcq <vianney.leclement@essensium.=
com>
> +  - Crt Mori <cmo@melexis.com>
> +
> +description: |
> +  http://melexis.com/Infrared-Thermometer-Sensors/Infrared-Thermometer-S=
ensors/MLX90614-615.aspx
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
> +      driving the SCL line.  If no GPIO is given, power management is di=
sabled.
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
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        temp-sensor@5a {
> +            compatible =3D "melexis,mlx90614";
> +            reg =3D <0x5a>;
> +            wakeup-gpios =3D <&gpio0 2 GPIO_ACTIVE_HIGH>;
> +        };
> +    };
> +...
> diff --git a/Documentation/devicetree/bindings/iio/temperature/mlx90614.t=
xt b/Documentation/devicetree/bindings/iio/temperature/mlx90614.txt
> deleted file mode 100644
> index 9be57b036092..000000000000
> --- a/Documentation/devicetree/bindings/iio/temperature/mlx90614.txt
> +++ /dev/null
> @@ -1,24 +0,0 @@
> -* Melexis MLX90614 contactless IR temperature sensor
> -
> -http://melexis.com/Infrared-Thermometer-Sensors/Infrared-Thermometer-Sen=
sors/MLX90614-615.aspx
> -
> -Required properties:
> -
> -  - compatible: should be "melexis,mlx90614"
> -  - reg: the I2C address of the sensor
> -
> -Optional properties:
> -
> -  - wakeup-gpios: device tree identifier of the GPIO connected to the SD=
A line
> -      to hold low in order to wake up the device.  In normal operation, =
the
> -      GPIO is set as input and will not interfere in I2C communication. =
 There
> -      is no need for a GPIO driving the SCL line.  If no GPIO is given, =
power
> -      management is disabled.
> -
> -Example:
> -
> -mlx90614@5a {
> -       compatible =3D "melexis,mlx90614";
> -       reg =3D <0x5a>;
> -       wakeup-gpios =3D <&gpio0 2 GPIO_ACTIVE_HIGH>;
> -};
> --
> 2.28.0
>
