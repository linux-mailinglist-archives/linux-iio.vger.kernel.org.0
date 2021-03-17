Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 990F833ED33
	for <lists+linux-iio@lfdr.de>; Wed, 17 Mar 2021 10:40:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbhCQJjo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 17 Mar 2021 05:39:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:54380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229540AbhCQJjd (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 17 Mar 2021 05:39:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F41ED64F52;
        Wed, 17 Mar 2021 09:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615973973;
        bh=y3xCD3XEtxy7l9rX5aDs99I+yhLU3OuZ2zu6eY4z7zw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ko9caZRsY5PzHGUE5pJZP9AZ7g5siYrUg51n8An+d4l6FZytvgtM9tQPirVnzpexA
         6P2pZRbT7aivtxzE9fwHM67Jm5v4MPRTaXYXYHyQiZX4DS1ut7TmKZBIiHt3eAKHy+
         Z+8Sc7tuuTLJ7nhtP5woLTtIwjk92IjUzKtdttFNnNWr1pBk4A57HKl+z4SnHx655m
         kaLMm9S9JGGfTMwyfj18V/V0O66o8g+GFj2IVJa5Zb9ZmcidkGRJYLo/3QkUho/VlN
         MhW41QL+ck8kSx2H/UDGIh/+lDibFEiUgV1D0faGYPBglK0rGySI9lLiQKzch7MNhR
         ZPkYsQ00vYB0g==
Received: by earth.universe (Postfix, from userid 1000)
        id E3C123C0C96; Wed, 17 Mar 2021 10:39:30 +0100 (CET)
Date:   Wed, 17 Mar 2021 10:39:30 +0100
From:   Sebastian Reichel <sre@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luca Ceresoli <luca@lucaceresoli.net>,
        Jonathan Cameron <jic23@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Kevin Tsai <ktsai@capellamicro.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org,
        linux-input@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: More cleanup of standard unit properties
Message-ID: <20210317093930.7una3kxmovgghtxo@earth.universe>
References: <20210316194824.3526913-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zdkptzpbv4pszvcv"
Content-Disposition: inline
In-Reply-To: <20210316194824.3526913-1-robh@kernel.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--zdkptzpbv4pszvcv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Mar 16, 2021 at 01:48:24PM -0600, Rob Herring wrote:
> Properties with standard unit suffixes already have a type and don't need
> type references. Fix a few more cases which have gotten added.
>=20
> Cc: Luca Ceresoli <luca@lucaceresoli.net>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Kevin Tsai <ktsai@capellamicro.com>
> Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Cc: Sebastian Reichel <sre@kernel.org>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: linux-iio@vger.kernel.org
> Cc: linux-input@vger.kernel.org
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---

Acked-by: Sebastian Reichel <sre@kernel.org>

-- Sebastian

>  Documentation/devicetree/bindings/iio/light/capella,cm3605.yaml | 1 -
>  Documentation/devicetree/bindings/input/input.yaml              | 1 -
>  Documentation/devicetree/bindings/power/supply/bq256xx.yaml     | 1 -
>  Documentation/devicetree/bindings/power/supply/ltc4162-l.yaml   | 2 --
>  .../devicetree/bindings/regulator/qcom-labibb-regulator.yaml    | 1 -
>  .../devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml          | 1 -
>  6 files changed, 7 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/light/capella,cm3605.y=
aml b/Documentation/devicetree/bindings/iio/light/capella,cm3605.yaml
> index 27972938b60d..c63b79c3351b 100644
> --- a/Documentation/devicetree/bindings/iio/light/capella,cm3605.yaml
> +++ b/Documentation/devicetree/bindings/iio/light/capella,cm3605.yaml
> @@ -48,7 +48,6 @@ properties:
>    vdd-supply: true
> =20
>    capella,aset-resistance-ohms:
> -    $ref: /schemas/types.yaml#/definitions/uint32
>      enum: [50000, 100000, 300000, 600000]
>      description: >
>        Sensitivity calibration resistance. Note that calibration curves
> diff --git a/Documentation/devicetree/bindings/input/input.yaml b/Documen=
tation/devicetree/bindings/input/input.yaml
> index ab407f266bef..3fc37478c0c0 100644
> --- a/Documentation/devicetree/bindings/input/input.yaml
> +++ b/Documentation/devicetree/bindings/input/input.yaml
> @@ -32,6 +32,5 @@ properties:
>        Duration in seconds which the key should be kept pressed for devic=
e to
>        power off automatically. Device with key pressed shutdown feature =
can
>        specify this property.
> -    $ref: /schemas/types.yaml#/definitions/uint32
> =20
>  additionalProperties: true
> diff --git a/Documentation/devicetree/bindings/power/supply/bq256xx.yaml =
b/Documentation/devicetree/bindings/power/supply/bq256xx.yaml
> index 18b54783e11a..92ec7ed25668 100644
> --- a/Documentation/devicetree/bindings/power/supply/bq256xx.yaml
> +++ b/Documentation/devicetree/bindings/power/supply/bq256xx.yaml
> @@ -39,7 +39,6 @@ properties:
>      maxItems: 1
> =20
>    ti,watchdog-timeout-ms:
> -    $ref: /schemas/types.yaml#/definitions/uint32
>      default: 0
>      description: |
>        Watchdog timer in ms. 0 (default) disables the watchdog
> diff --git a/Documentation/devicetree/bindings/power/supply/ltc4162-l.yam=
l b/Documentation/devicetree/bindings/power/supply/ltc4162-l.yaml
> index 1f88c9e013f4..6d7aa97a6475 100644
> --- a/Documentation/devicetree/bindings/power/supply/ltc4162-l.yaml
> +++ b/Documentation/devicetree/bindings/power/supply/ltc4162-l.yaml
> @@ -29,12 +29,10 @@ properties:
>      description: I2C address of the charger.
> =20
>    lltc,rsnsb-micro-ohms:
> -    $ref: /schemas/types.yaml#/definitions/uint32
>      description: Battery sense resistor in microohm.
>      minimum: 1000
> =20
>    lltc,rsnsi-micro-ohms:
> -    $ref: /schemas/types.yaml#/definitions/uint32
>      description: Input current sense resistor in microohm.
>      minimum: 1000
> =20
> diff --git a/Documentation/devicetree/bindings/regulator/qcom-labibb-regu=
lator.yaml b/Documentation/devicetree/bindings/regulator/qcom-labibb-regula=
tor.yaml
> index cf784bd1f5e5..1ddc1efd19e2 100644
> --- a/Documentation/devicetree/bindings/regulator/qcom-labibb-regulator.y=
aml
> +++ b/Documentation/devicetree/bindings/regulator/qcom-labibb-regulator.y=
aml
> @@ -23,7 +23,6 @@ properties:
> =20
>      properties:
>        qcom,soft-start-us:
> -        $ref: /schemas/types.yaml#/definitions/uint32
>          description: Regulator soft start time in microseconds.
>          enum: [200, 400, 600, 800]
>          default: 200
> diff --git a/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.=
yaml b/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml
> index 7cd364430573..95a728f4d333 100644
> --- a/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml
> +++ b/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml
> @@ -78,7 +78,6 @@ patternProperties:
>            also known as absolute calibration.
> =20
>        qcom,hw-settle-time-us:
> -        $ref: /schemas/types.yaml#/definitions/uint32
>          description: Time between AMUX getting configured and the ADC st=
arting conversion.
>          enum: [15, 100, 200, 300, 400, 500, 600, 700, 1000, 2000, 4000, =
8000, 16000, 32000, 64000, 128000]
> =20
> --=20
> 2.27.0
>=20

--zdkptzpbv4pszvcv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmBRzlIACgkQ2O7X88g7
+pppig/+NOYjF8K3AE0RbMqalMCOLLj+cI6khlfdlZfQIeK2UOn8Xb+hyv3kEfND
1ntYxOLHcfZ5riN+3Fmz66q0H7nd3hVRF9iaAuZwRNTXEq5ADzqsGM7A74xsNPYi
aR0hwKXtbaui5ZbJyG/IqdlU88q+i9Pp76llY1YmApweHWlQLADnJOb669iHIkK4
iSzxpVdmkueDJ68BeX+bPt2+aJnb6t0dLTVMj9RsbYmXVcg5kZ5dJDifpnqO9ITS
Wo8WpCk91Q33oV5jOiG8J+XJ6rCABW6yzcZ/FDJCwt2na3zkBSvDTcayF7B9xBeh
YyhnLapvtrW4wgWRzE2jMRO/+efd9tcuzAD5O/w5EeQY0C7Wr8qd+LtMN26tRP1e
ec6aE7aqIcvhKIAMjbZOgU4zrLTI2h2N4W4LhAyNXxQeVeZvTSneXj8wVty8OPSF
ALcvkCVBHhqjl1RqS5EcWC0cG24otwcQIXg5fBiNw2dV7YNBZhDYlQNEzji8UiWD
Va8LVfBqa2KtZbrTI1YZBSFd1lPKOGLZbpFaokb9xr7xTMXos8ENNEYhZm8mkugw
vVy5xdPN3LgiQOqaXpLwPDP27wls3Gk+mPIr2sXfXAuZoStGGoRBVmJNpZiVTjro
ZbHSYj60PI9ApW1m9VxcQiY+EOMOs7g9ZXWh8ViPdxJ2+5ahWlw=
=uBZ6
-----END PGP SIGNATURE-----

--zdkptzpbv4pszvcv--
