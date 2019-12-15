Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5B7D11F77B
	for <lists+linux-iio@lfdr.de>; Sun, 15 Dec 2019 12:50:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbfLOLuF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 Dec 2019 06:50:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:43570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726121AbfLOLuE (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 15 Dec 2019 06:50:04 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6423D2053B;
        Sun, 15 Dec 2019 11:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576410604;
        bh=7ZEl5SInaPZ7B7UvDnmlJi2h2w0ig60NQ/+aMR/+hIU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TwL6c9LUcCnhvO9RucluGI1f59LWmHBTLc5O859lGAo0hvZGL/GDHOaw2QLdnzooI
         UARJpA8ydyeTy4x/AyifkvQpSsVwIHqBr/CqeRIJPKWeOKm51Tt3eEmfCf00Aw1nq9
         XMkrUqCjrLgp3m4AJPEfRsFzme/3gjd/OB4xnvsc=
Date:   Sun, 15 Dec 2019 11:49:58 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Alexandru Ardelean <alexandru.Ardelean@analog.com>,
        linux-iio@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH v4 1/3] iio: adc: ltc2496: provide device tree binding
 document
Message-ID: <20191215114958.6ad37d19@archlinux>
In-Reply-To: <20191209203248.21555-2-u.kleine-koenig@pengutronix.de>
References: <20191209203248.21555-1-u.kleine-koenig@pengutronix.de>
        <20191209203248.21555-2-u.kleine-koenig@pengutronix.de>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon,  9 Dec 2019 21:32:46 +0100
Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> wrote:

> The ADC only requires the standard stuff for spi devices and a reference
> voltage.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
Thanks for figuring out what was wrong and fixing it up.

I've made a couple of small tweaks whilst applying.  See below.

Applied to the togreg branch of iio.git and pushed out as testing.
I'm not planning to do a pull request until at least next weekend
so plenty of time if a DT maintainer wants to take another look.

Thanks,

Jonathan

> ---
>  .../bindings/iio/adc/lltc,ltc2496.yaml        | 47 +++++++++++++++++++
>  1 file changed, 47 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/lltc,ltc249=
6.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/lltc,ltc2496.yaml =
b/Documentation/devicetree/bindings/iio/adc/lltc,ltc2496.yaml
> new file mode 100644
> index 000000000000..195c8c8f2f4c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/lltc,ltc2496.yaml
> @@ -0,0 +1,47 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/lltc,ltc2496.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Linear Technology / Analog Devices LTC2496 ADC
> +
> +maintainers:
> + - Lars-Peter Clausen <lars@metafoo.de>
> + - Michael Hennerich <Michael.Hennerich@analog.com>
> + - Stefan Popa <stefan.popa@analog.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - lltc,ltc2496
> +
> +  vref-supply:
> +    description: phandle to an external regulator providing the referenc=
e voltage
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/phandle
> +
> +  reg:
> +    description: spi chipselect number according to the usual spi bindin=
gs
> +
> +  spi-max-frequency:
> +    description: maximal spi bus frequency supported by the chip

dropped the "by the chip" as this is also about the wiring on the board.  I=
f it
were just the chip, it could be put in the driver.  The unknown bit is
if there is some other reason why it might need to be set lower than the ma=
ximum.

> +
> +required:
> +  - compatible
> +  - vref-supply
> +  - reg
> +
> +examples:
> +  - |
> +    spi {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        adc@0 {
> +        	compatible =3D "lltc,ltc2496";
You can't easily see it here, but this is a mixture of spaces
and tabs.  Should be all spaces.  I've tidied that up.
> +        	reg =3D <0>;
> +        	vref-supply =3D <&ltc2496_reg>;
> +        	spi-max-frequency =3D <2000000>;
> +        };
> +    };

