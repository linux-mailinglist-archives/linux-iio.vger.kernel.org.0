Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0A81D2B35
	for <lists+linux-iio@lfdr.de>; Thu, 10 Oct 2019 15:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388013AbfJJNXz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Oct 2019 09:23:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:60270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387828AbfJJNXz (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 10 Oct 2019 09:23:55 -0400
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D88B420650;
        Thu, 10 Oct 2019 13:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570713834;
        bh=YLrnV8zZisr0XydXNPW9X6NeAxPAWOsdbyS2yRBi/UY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=xJznIvCT1sLkg8Y6BZ2uO6PgIuEgYNWeo1ONKPp9wMRkn9N8ZzERykXgB9/catV38
         ja2o57c3K/CDyziofLNz5IR6Aj0msf16qOQkKWyVJzSTpxLve1S3B1mCVoqePs/LG5
         O8Utg+Zsg7DU4gpnEl/XAayKKIJMGtCKey2Ymj0s=
Received: by mail-qt1-f175.google.com with SMTP id j31so8664596qta.5;
        Thu, 10 Oct 2019 06:23:53 -0700 (PDT)
X-Gm-Message-State: APjAAAXuyb9gBvwtsiV/yGaFdltDCeqetHhgoUE6nnoXctYRO1Wzogii
        HgCwm+Edd0VgKdqOzbbbXg3mxQ3H1yAyJswgFw==
X-Google-Smtp-Source: APXvYqz2PhZiSPi7UGKHnDHJKGkm9997P6Ft0wR/2lKwzfkipGeeDrItJgltFybrUjKdVzL9R9XcBym/c95uuZWFz+s=
X-Received: by 2002:ad4:5044:: with SMTP id m4mr10089713qvq.85.1570713832995;
 Thu, 10 Oct 2019 06:23:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190918012856.18963-1-rjones@gateworks.com> <20191010012523.14426-1-rjones@gateworks.com>
 <20191010012523.14426-2-rjones@gateworks.com>
In-Reply-To: <20191010012523.14426-2-rjones@gateworks.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 10 Oct 2019 08:23:41 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKtRvpXH6JOcmcMivgnZu2e_ocL7Vd91_yX9VGd+W+dRw@mail.gmail.com>
Message-ID: <CAL_JsqKtRvpXH6JOcmcMivgnZu2e_ocL7Vd91_yX9VGd+W+dRw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: imu: add fxos8700 imu binding
To:     Robert Jones <rjones@gateworks.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Oct 9, 2019 at 8:25 PM Robert Jones <rjones@gateworks.com> wrote:
>
> This adds documentation for the Freescale FXOS8700 Inertial Measurement Unit
> device-tree bindings.
>
> Signed-off-by: Robert Jones <rjones@gateworks.com>
> ---
>  .../devicetree/bindings/iio/imu/fxos8700.yaml      | 54 ++++++++++++++++++++++

Follow the compatible string name, so fsl,fxos8700.yaml.

>  1 file changed, 54 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/imu/fxos8700.yaml
>
> diff --git a/Documentation/devicetree/bindings/iio/imu/fxos8700.yaml b/Documentation/devicetree/bindings/iio/imu/fxos8700.yaml
> new file mode 100644
> index 0000000..f0dbf4b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/imu/fxos8700.yaml
> @@ -0,0 +1,54 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/imu/fxos8700.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Freescale FXOS8700 Inertial Measurement Unit
> +
> +maintainers:
> +  - Robert Jones <rjones@gateworks.com>
> +
> +description: |
> +  Accelerometer and magnetometer combo device with an i2c interface.

Also has a SPI interface.

> +  https://www.nxp.com/products/sensors/motion-sensors/6-axis/digital-motion-sensor-3d-accelerometer-2g-4g-8g-plus-3d-magnetometer:FXOS8700CQ
> +
> +properties:
> +  compatible:
> +    enum:
> +      - fsl,fxos8700

For a new binding, shouldn't this be nxp instead of fsl?

> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  interrupt-names:
> +    maxItems: 1

'const: INT1' instead. However, having '-names' doesn't really buy
much when there is only 1 entry, so I'd just drop it.

But then I read the datasheet and there are 2 interrupts, so you need
to describe 2 interrupts.

> +
> +  drive-open-drain:
> +    maxItems: 1

Should be boolean.

> +
> +  spi-max-frequency:
> +    maxItems: 1

spi-max-frequency is not an array. You should define the maximum for it.

> +
> +required:
> +  - compatible
> +  - reg
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        fxos8700@1e {
> +          compatible = "fsl,fxos8700";
> +          reg = <0x1e>;
> +
> +          interrupt-parent = <&gpio2>;
> +          interrupts = <7 IRQ_TYPE_EDGE_RISING>;
> +          interrupt-names = "INT1";
> +        };
> +    };
> --
> 2.9.2
>
