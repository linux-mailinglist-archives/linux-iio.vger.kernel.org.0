Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 552BF18EAD8
	for <lists+linux-iio@lfdr.de>; Sun, 22 Mar 2020 18:29:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725997AbgCVR3R (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 22 Mar 2020 13:29:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:49996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725972AbgCVR3R (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 22 Mar 2020 13:29:17 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB28020714;
        Sun, 22 Mar 2020 17:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584898155;
        bh=zfhz4frlqYfSulkRHPiW5gaTisQkKjgaXVLTMLiAmZM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=B/jhkHvTVC87MZEV+fRZcPXI4jp7/Ix+aDQgab8+XAgmFNGP7r1JuvSjmpC0vP8W3
         c1Up7/3DNCQSk1/qzA/pt4Pv9S5nICrFa/dmRMgRAjKlHW5uix+x2JAEU+srUqryKU
         XLU7xOxLaVbnBN9oN86WSoGcmIJo+IEbaJIYvUQc=
Date:   Sun, 22 Mar 2020 17:29:10 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Guido =?UTF-8?B?R8O8bnRoZXI=?= <agx@sigxcpu.org>
Cc:     Tomas Novotny <tomas@novotny.cz>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 1/4] dt-bindings: iio: vcnl4000: convert bindings to
 YAML format
Message-ID: <20200322172910.51456fe4@archlinux>
In-Reply-To: <6182053bb8c442e0b4d72b34c83c7f1565f4a258.1584380360.git.agx@sigxcpu.org>
References: <cover.1584380360.git.agx@sigxcpu.org>
        <6182053bb8c442e0b4d72b34c83c7f1565f4a258.1584380360.git.agx@sigxcpu.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 16 Mar 2020 18:46:17 +0100
Guido G=C3=BCnther <agx@sigxcpu.org> wrote:

> Convert the vcnl4000 device tree bindings to the new YAML format.
>=20
> Signed-off-by: Guido G=C3=BCnther <agx@sigxcpu.org>
Looks good to me. However, I've made far too many mistakes in
DT binding review recently, so will definitely be waiting for Rob to
get a chance to look at it!

Jonathan

> ---
>  .../bindings/iio/light/vcnl4000.txt           | 24 ----------
>  .../bindings/iio/light/vcnl4000.yaml          | 45 +++++++++++++++++++
>  2 files changed, 45 insertions(+), 24 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/iio/light/vcnl4000.=
txt
>  create mode 100644 Documentation/devicetree/bindings/iio/light/vcnl4000.=
yaml
>=20
> diff --git a/Documentation/devicetree/bindings/iio/light/vcnl4000.txt b/D=
ocumentation/devicetree/bindings/iio/light/vcnl4000.txt
> deleted file mode 100644
> index 955af4555c90..000000000000
> --- a/Documentation/devicetree/bindings/iio/light/vcnl4000.txt
> +++ /dev/null
> @@ -1,24 +0,0 @@
> -VISHAY VCNL4000 -  Ambient Light and proximity sensor
> -
> -This driver supports the VCNL4000/10/20/40 and VCNL4200 chips
> -
> -Required properties:
> -
> -	-compatible: must be one of :
> -        vishay,vcnl4000
> -        vishay,vcnl4010
> -        vishay,vcnl4020
> -        vishay,vcnl4040
> -        vishay,vcnl4200
> -
> -	-reg: I2C address of the sensor, should be one from below based on the =
model:
> -        0x13
> -        0x51
> -        0x60
> -
> -Example:
> -
> -light-sensor@51 {
> -	compatible =3D "vishay,vcnl4200";
> -	reg =3D <0x51>;
> -};
> diff --git a/Documentation/devicetree/bindings/iio/light/vcnl4000.yaml b/=
Documentation/devicetree/bindings/iio/light/vcnl4000.yaml
> new file mode 100644
> index 000000000000..74d53cfbeb85
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/light/vcnl4000.yaml
> @@ -0,0 +1,45 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/light/vcnl4000.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: VISHAY VCNL4000 ambient light and proximity sensor
> +
> +maintainers:
> +  - Peter Meerwald <pmeerw@pmeerw.net>
> +
> +description: |
> +  Ambient light sensing with proximity detection over an i2c
> +  interface.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - vishay,vcnl4000
> +      - vishay,vcnl4010
> +      - vishay,vcnl4020
> +      - vishay,vcnl4040
> +      - vishay,vcnl4200
> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +- |
> +  i2c {
> +      #address-cells =3D <1>;
> +      #size-cells =3D <0>;
> +
> +      light-sensor@51 {
> +              compatible =3D "vishay,vcnl4200";
> +              reg =3D <0x51>;
> +      };
> +  };
> +...

