Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B694010E18D
	for <lists+linux-iio@lfdr.de>; Sun,  1 Dec 2019 12:28:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbfLAL2I (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 1 Dec 2019 06:28:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:41558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725993AbfLAL2I (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 1 Dec 2019 06:28:08 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C7D620725;
        Sun,  1 Dec 2019 11:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575199688;
        bh=8E9mVEGxMzPVKGCaEDRil5O0zFTraSNKPuhq9lQI7k8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rYTwHSvrk5MVom+y6IpCIeEqH6LWh4c8Y2kwb8Qddnt2TJOsgZuA61m4rcaiTu+F3
         sOX3o2Aj9cLwPMM6VaqePyjV5F54lG3Xjd0UM/8ryACKSXnYwGjoD25reHeJnYeveH
         fg5UB9xowgVClbsw1bEu44hmFkNPn0SyOaJFesko=
Date:   Sun, 1 Dec 2019 11:28:03 +0000
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
Subject: Re: [PATCH v3 1/3] iio: adc: ltc2496: provide device tree binding
 document
Message-ID: <20191201112753.156881b8@archlinux>
In-Reply-To: <20191121210007.25646-2-u.kleine-koenig@pengutronix.de>
References: <20191121210007.25646-1-u.kleine-koenig@pengutronix.de>
        <20191121210007.25646-2-u.kleine-koenig@pengutronix.de>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 21 Nov 2019 22:00:05 +0100
Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> wrote:

> The ADC only requires the standard stuff for spi devices and a reference
> voltage.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Rob, even with the issues below fixed I can't build test this and get
'no schema found in file'.

I can't seem to figure out why so if you could take a look, that would
be great.

Thanks,

Jonathan


> ---
>  .../bindings/iio/adc/lltc,ltc2496.yaml        | 37 +++++++++++++++++++
>  1 file changed, 37 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/lltc,ltc249=
6.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/lltc,ltc2496.yaml =
b/Documentation/devicetree/bindings/iio/adc/lltc,ltc2496.yaml
> new file mode 100644
> index 000000000000..af485abeabd6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/lltc,ltc2496.yaml
> @@ -0,0 +1,37 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/lltc,ltc2496.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Linear Technology / Analog Devices LTC2496 ADC
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
> +
> +required:
> +  - compatible
> +  - vref-supply
> +  - reg
> +
> +examples:
> +  - |

Missed this before trying to build test.

Spaces used in DT not tabs, and this should be in an spi block.

Please check the example verifies using the instructions in
Documentation/devicetree/bindings/writing-bindings.rst

Thanks,

Jonathan

> +	adc@0 {
> +		compatible =3D "lltc,ltc2496";
> +		reg =3D <0>;
> +		vref-supply =3D <&ltc2496_reg>;
> +		spi-max-frequency =3D <2000000>;
> +	};

