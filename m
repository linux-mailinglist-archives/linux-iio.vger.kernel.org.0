Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59D3A32B371
	for <lists+linux-iio@lfdr.de>; Wed,  3 Mar 2021 05:08:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236495AbhCCDxq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 2 Mar 2021 22:53:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236825AbhCBBRC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 1 Mar 2021 20:17:02 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D783C061788;
        Mon,  1 Mar 2021 17:16:22 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id a4so12749430pgc.11;
        Mon, 01 Mar 2021 17:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=akpFf+vvqOEuKGgJ3psjfx1SdrADoawN0rFpIZx1LRs=;
        b=kDCCuIYRdrf56PMMtibCcdaGvfpJ5hi6++3Nw3ykbzeVXyj3D2J+4xgaQltVyy9vls
         l3Sy5UgQvFNg37vdBjdwJoipAEz3SzfOqHxdtDimwbqWaC66Z3S/0xInZBISlwl/N9um
         vG5A+e4CFLadXGAbwQbeKPrUfEsoHMfpVdNzvM37bRB6w+0XBRSYCtcrfUbQrutHGC6l
         UfctAEAGSMtga0R+B1yAMrWP1AmF/Rw4qiq14N9Gh9rKeCZWwk+jrK5zMKynmASu4uSZ
         D+/Ce5z4g8+01XWsV0eK1nxQrpIVDLqghyDfem+MyuY60j74fjKWq253V8ejRCWHwOth
         uP8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=akpFf+vvqOEuKGgJ3psjfx1SdrADoawN0rFpIZx1LRs=;
        b=TtUxTLEfUnU/tlqVdsKBHGrrJebTj5lFnZzb8I2Ia0FokIMT6oKxSCrbtEsjanBXam
         GnhsqleaWRsG4Nt9TEB6ckSSyvRMCyuyHqIr30uLPZnF08g6HA6SRb5qKIaM68248V0E
         PHFO8kHOjUFXQCuQkiP5pGvjzIkq++QCBDjR3lUZiwpYXdzfweH+SrcUUYzIXB9wiYhT
         ezKDEXkAazPNkEIgFxizHcylVG9lJAHkx98f+7qIALHgFu6qTN4OmVDAKM/pHoA/gyPm
         Suk+CrKFB1rQMTlY/WiLtgvauDeBrLGDB1ts0QpkVmTg2fpuaRVybmBKybrBPvmJrngk
         GU2A==
X-Gm-Message-State: AOAM5331H5NS4N6hi5NoiFXGo6ayVCwpTS9GPraKnL7V1CBf5ftsVY7G
        0KHUV+xMcmukz8YSH7cppeo=
X-Google-Smtp-Source: ABdhPJxjHGAj19v409+m/6Bi2u5n3dBNSCrDdlNkNjG0p2YBap4lQtAqpnY8PvWUFvO8zTxQqofb/g==
X-Received: by 2002:aa7:9711:0:b029:1ee:b2c7:ecfe with SMTP id a17-20020aa797110000b02901eeb2c7ecfemr1110418pfg.58.1614647781705;
        Mon, 01 Mar 2021 17:16:21 -0800 (PST)
Received: from shinobu ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id w2sm18954466pgh.54.2021.03.01.17.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 17:16:20 -0800 (PST)
Date:   Tue, 2 Mar 2021 10:16:15 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Oleksij Rempel <o.rempel@pengutronix.de>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>,
        Robin van der Gracht <robin@protonic.nl>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v8 1/2] dt-bindings: counter: add interrupt-counter
 binding
Message-ID: <YD2R33ocanYrlAN1@shinobu>
References: <20210301080401.22190-1-o.rempel@pengutronix.de>
 <20210301080401.22190-2-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="PpXaD6VYZ3EV/ceA"
Content-Disposition: inline
In-Reply-To: <20210301080401.22190-2-o.rempel@pengutronix.de>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--PpXaD6VYZ3EV/ceA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 01, 2021 at 09:04:00AM +0100, Oleksij Rempel wrote:
> Add binding for the interrupt counter node
>=20
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>

> ---
>  .../bindings/counter/interrupt-counter.yaml   | 62 +++++++++++++++++++
>  1 file changed, 62 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/counter/interrupt-c=
ounter.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/counter/interrupt-counter.=
yaml b/Documentation/devicetree/bindings/counter/interrupt-counter.yaml
> new file mode 100644
> index 000000000000..fd075d104631
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/counter/interrupt-counter.yaml
> @@ -0,0 +1,62 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/counter/interrupt-counter.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Interrupt counter
> +
> +maintainers:
> +  - Oleksij Rempel <o.rempel@pengutronix.de>
> +
> +description: |
> +  A generic interrupt counter to measure interrupt frequency. It was dev=
eloped
> +  and used for agricultural devices to measure rotation speed of wheels =
or
> +  other tools. Since the direction of rotation is not important, only one
> +  signal line is needed.
> +  Interrupts or gpios are required. If both are defined, the interrupt w=
ill
> +  take precedence for counting interrupts.
> +
> +properties:
> +  compatible:
> +    const: interrupt-counter
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  gpios:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +
> +anyOf:
> +  - required: [ interrupts-extended ]
> +  - required: [ interrupts ]
> +  - required: [ gpios ]
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    counter-0 {
> +        compatible =3D "interrupt-counter";
> +        interrupts-extended =3D <&gpio 0 IRQ_TYPE_EDGE_RISING>;
> +    };
> +
> +    counter-1 {
> +        compatible =3D "interrupt-counter";
> +        gpios =3D <&gpio 2 GPIO_ACTIVE_HIGH>;
> +    };
> +
> +    counter-2 {
> +        compatible =3D "interrupt-counter";
> +        interrupts-extended =3D <&gpio 2 IRQ_TYPE_EDGE_RISING>;
> +        gpios =3D <&gpio 2 GPIO_ACTIVE_HIGH>;
> +    };
> +
> +...
> --=20
> 2.29.2
>=20

--PpXaD6VYZ3EV/ceA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmA9kdMACgkQhvpINdm7
VJLYYhAAit5cpIwDP7OteMOlRTu29zAg0+c4a3MidRdA0ykemueCz8CRm7i0aNY5
g2JZIhwYWpgUwYrM1Qtpo5KNmf7gg76fSBY892toi1GoS+bs37MEn727wf4DUHx/
V+myppzETibu2wXhWsnRGVnUHbD21u02xmVJcOMuy/NginQYnUINeNAXwqCSHJWd
Wy69lBsme0cic+PpJUP2SfH6nRgfBsFp1Esp9EpaE6EzR6y8tFzFHOQDso+P3D2o
Mk+KQ54RmeApmtzbro4CQA9LV/J2o8BaNf1bcggMbiupTr+9OiKBybzHJdP+WbMZ
iAfoEEALscittlmS7yzxPAX0fp8R4tbxOZ4YxV7gdZuc7MGhXh1DXAHrmDqalCVn
yEK7dOXMsz6evJcyLhim+sQKUldRgwX8N6re2kcugk2XYu4wbt0UzwflYuJX9gPW
F7TjFIk2uO1no6mQzBxDmCXBB6oLejyp3uBHZzydy/RN+fRjYpNGIP8apnZVPRcZ
9hj7GYvI0LsxZif5SRwmFfX5Dsm49627D4sZ8c0RDRlmVsRvnWOjoL/ugQ7YCMSC
QOeJuWym5WroyESzNIx78b1CEW9BaGpw+IrhQ+kLstvPCjw/twjL5qXYMIG/6kiR
ywQeZu9tty7drKMMK/Mo7m0YNTStvostYhIg1CLGOPYRRp4zIbk=
=JwXa
-----END PGP SIGNATURE-----

--PpXaD6VYZ3EV/ceA--
