Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFAC714BA6
	for <lists+linux-iio@lfdr.de>; Mon,  6 May 2019 16:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbfEFORt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 6 May 2019 10:17:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:42784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726190AbfEFORs (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 6 May 2019 10:17:48 -0400
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D368520C01;
        Mon,  6 May 2019 14:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557152268;
        bh=KdeRILpTjWSB3lMVpKPyYNeVBsxjh4PqpfZ+DCj85jQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HsrZ9E+hTQoliTdhrcsFRFV6UBvHBT/GsNdDofnH8QvXI+JXYi2Z6PEc7jzsb6SSz
         UbWdoKaw3kkIVN5V2mPE822kfCRi5xS9yd6zpPOYdeS/q0AQE72Je2WuSHnkG4zrtY
         S9lB4qrbZptj7qHsJYGxsJ7jVqKCu3UdJGkt2PO8=
Received: by mail-qk1-f175.google.com with SMTP id a132so7837297qkb.13;
        Mon, 06 May 2019 07:17:47 -0700 (PDT)
X-Gm-Message-State: APjAAAU+pjVlvaTOM668/X9SoHVEVTTKF4ASnV6MRyCCnlpTgdsw7+5A
        DQaVGsm/lE3CLD5MnVM+oTlmRbPwRZ3Q5z7Awg==
X-Google-Smtp-Source: APXvYqx92AuG59JmQNKgfchswPwGNjmkT9qmBU/HsXQfKOJH1UxJadbVwkiAAZKYc7Cbb9Fl0nbc9PqNlHl8GS1wqEw=
X-Received: by 2002:a37:4711:: with SMTP id u17mr19850810qka.326.1557152267032;
 Mon, 06 May 2019 07:17:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190506114610.28083-1-alexandru.ardelean@analog.com>
In-Reply-To: <20190506114610.28083-1-alexandru.ardelean@analog.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 6 May 2019 09:17:33 -0500
X-Gmail-Original-Message-ID: <CAL_JsqL-jKM-qpawVoaLaqTpZhqNNFmgAOjv_azSwOU6zFS08g@mail.gmail.com>
Message-ID: <CAL_JsqL-jKM-qpawVoaLaqTpZhqNNFmgAOjv_azSwOU6zFS08g@mail.gmail.com>
Subject: Re: [RFC][PATCH] dt-bindings: iio: accel: add adi,adxl345.yaml binding
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, May 6, 2019 at 6:46 AM Alexandru Ardelean
<alexandru.ardelean@analog.com> wrote:
>
> This patch adds a YAML binding for the Analog Devices ADXL345 I2C/SPI
> accelerometer.
>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> ---
>
> And now for the RFC part.
> Normally, I would dig into source-code to try to figure this out, but at
> this point-in-time, I am low on time/energy to do this.
> And maybe this helps trigger a discussion about this.
>
> Apologies if this has been coverted on the devicetree mailing list, but
> at least we'd get some coverage on the IIO list (with this).
>
> The ADXL345 device (as others) supports both I2C & SPI interfaces.
>
> Question1: do we write 2 YAML files, or 1 ? I was looking at Zephyr (for
> some ideas/reference) but it seems to me that the YAML DT binding format is
> different than this one ? They write 2 files for ADXL372 (1 for SPI, 1 for
> I2C).
>
> Question1-a: one thing is that SPI requires some props to be `required`
> that would not be required for the I2C binding. This could be solved by
> doing 2 files, but if doing 1 YAML file, is there a way to do conditional
> `required` ? i.e. property is required if `SPI` ? not sure how to check for
> SPI vs I2C, it would be interesting (at some point) to somehow enforce
> SPI/I2C bindings correctness.

The challenge here is there's not really any way for the schema to
know which bus it is. The only ways to know this are knowing all
possible spi or i2c controller compatibles or using the parent node
name (which hasn't been strictly enforced). In order to get this
information available to the schema, we'd need to add the information
to the node. We do this with '$nodename'. We could add a '$bus'
property for example. The tools would have to understand different
buses and things like I2C muxes complicate doing that.

Once you have something like $bus available, you could either have 2
files with a custom 'select' that checks compatible and $bus or we
could have 1 file using if/then/else keywords. However, we don't yet
support if/then/else json-schema that was added in draft7, but that's
being worked on by Maxime Ripard.

However, for this case, I'd just not worry about the issue. Really,
spi-cpha and spi-cpol should not be required. If only 1 mode is
supported, the driver can know that. IOW, it is implied by the
compatible strings.


> Question2: `make dt_binding_check` seems to generate only the first
> example. Is this known behavior, or do I need to take something else into
> consideration ?

That's correct. I haven't figured out how to do a variable number of
examples in kbuild.

> Question3: one idea that was neat in Zephyr, is that there is a 'inherits'
> + `!include` mechanism for including common SPI & I2C device stuff. It
> would be neat to have this. Is there a way to do this now, or maybe this
> would come later ? Maybe, just having a way to include a YAML file into
> another would be interesting.

This is done with the 'allOf' keyword at the top-level. See
i2c-gpio.yaml for an example.

I don't think that helps you here. If you had a long list of custom
properties, then it might be useful. But that's orthogonal to your
issue of needing conditional logic.

>
>  .../bindings/iio/accel/adi,adxl345.yaml       | 63 +++++++++++++++++++
>  1 file changed, 63 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
>
> diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
> new file mode 100644
> index 000000000000..246b90c07aaa
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
> @@ -0,0 +1,63 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/accelerometers/adi,adxl345.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices ADXL345/ADXL375 3-Axis Digital Accelerometers
> +
> +maintainers:
> +  - Michael Hennerich <michael.hennerich@analog.com>
> +
> +description: |
> +  Driver for Analog Devices ADXL345/ADXL375 3-Axis Digital Accelerometers

This is not a driver.

> +    http://www.analog.com/en/products/mems/accelerometers/adxl345.html
> +    http://www.analog.com/en/products/sensors-mems/accelerometers/adxl375.html
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - adi,adxl345
> +              - adi,adxl375

This can be simplified to just:

compatible:
  enum:
    - adi,adxl345
    - adi,adxl375

'oneOf' is only needed if you have different combinations of
compatibles (a variable number or multiple fallbacks). 'items' is only
needed if compatible is more than 1 string.

> +
> +  reg:
> +    description:
> +      The I2C address or SPI chip select number of the sensor

The top-level description should probably say the device supports I2C
and SPI. You don't need a description here for a common property
unless you have something device specific to add.

> +    maxItems: 1
> +
> +  spi-cpha:
> +    description:
> +      SPI clock phase must be set, to select SPI mode 3

Again, standard property, so just 'spi-cpha: true' is sufficient.

> +
> +  spi-cpol:
> +    description:
> +      SPI clock polarity must be set, to select SPI mode 3
> +
> +  interrupts:
> +    description:
> +      A variable number of interrupts warrants a description of what conditions
> +      affect the number of interrupts. Otherwise, descriptions on standard
> +      properties are not necessary.

This description from the example is explaining when you need a
description. For a single interrupt, just need 'maxItems: 1'.

> +
> +required:
> +  - compatible
> +  - reg
> +
> +examples:
> +  - |
> +    /* Example for a I2C device node */
> +    accelerometer@2a {

This should give you an error because the examples default to assuming
a simple-bus. So you need an 'i2c' node around this.

> +         compatible = "adi,adxl345";
> +         reg = <0x53>;
> +    };
> +  - |
> +    /* Example for a SPI device node */
> +    accelerometer@0 {
> +         compatible = "adi,adxl345";
> +         reg = <0>;
> +         spi-max-frequency = <5000000>;
> +         spi-cpol;
> +         spi-cpha;
> +    };
> --
> 2.17.1
>
