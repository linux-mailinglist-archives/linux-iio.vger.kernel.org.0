Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 019F4262172
	for <lists+linux-iio@lfdr.de>; Tue,  8 Sep 2020 22:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730353AbgIHUwp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 8 Sep 2020 16:52:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:44894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728709AbgIHUwi (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 8 Sep 2020 16:52:38 -0400
Received: from earth.universe (dyndsl-091-096-059-215.ewe-ip-backbone.de [91.96.59.215])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8D8A2098B;
        Tue,  8 Sep 2020 20:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599598358;
        bh=ao279NfKYOLBx5e5BhtMXAapL7y436+nyElVBLR4QNw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=guBdY5xhKG+Xoc1tEmDzX4YL4CPFl9o4OcC82DiG5QmAGIJN+Hasn/FC0YekbeU3n
         xELzxCjVxLMGXkYde2SLdTTOpsFax5W7cf7NbHL9sBdD/kZx8mn2HNt/uXEmZOL8Lt
         pPk35uNl1PSS9IMLfiB3orTXrnCaCMbjc29BVAQw=
Received: by earth.universe (Postfix, from userid 1000)
        id EC0C13C0C80; Tue,  8 Sep 2020 22:52:35 +0200 (CEST)
Date:   Tue, 8 Sep 2020 22:52:35 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 02/20] dt-bindings:iio:adc:ti,twl4030-madc yaml conversion
Message-ID: <20200908205235.aosbh2htudg34z52@earth.universe>
References: <20200905173004.216081-1-jic23@kernel.org>
 <20200905173004.216081-3-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="loa36x33czqo7ckg"
Content-Disposition: inline
In-Reply-To: <20200905173004.216081-3-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--loa36x33czqo7ckg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Sep 05, 2020 at 06:29:46PM +0100, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>=20
> Conversion from txt to yaml as part of a general move of IIO bindings
> to the new format.
>=20
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Sebastian Reichel <sre@kernel.org>
> ---

Acked-by: Sebastian Reichel <sre@kernel.org>

-- Sebastian

>  .../bindings/iio/adc/ti,twl4030-madc.yaml     | 48 +++++++++++++++++++
>  .../bindings/iio/adc/twl4030-madc.txt         | 24 ----------
>  2 files changed, 48 insertions(+), 24 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/ti,twl4030-madc.ya=
ml b/Documentation/devicetree/bindings/iio/adc/ti,twl4030-madc.yaml
> new file mode 100644
> index 000000000000..6781ad2f0f51
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/ti,twl4030-madc.yaml
> @@ -0,0 +1,48 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/ti,twl4030-madc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MADC subsystem in the TWL4030 power module
> +
> +maintainers:
> +  - Sebastian Reichel <sre@kernel.org>
> +
> +description:
> +  The MADC subsystem in the TWL4030 consists of a 10-bit ADC
> +  combined with a 16-input analog multiplexer.
> +
> +properties:
> +  compatible:
> +    const: ti,twl4030-madc
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  ti,system-uses-second-madc-irq:
> +    type: boolean
> +    description:
> +      Set if the second madc irq register should be used, which is inten=
ded
> +      to be used  by Co-Processors (e.g. a modem).
> +
> +  "#io-channel-cells":
> +    const: 1
> +
> +required:
> +  - compatible
> +  - interrupts
> +  - "#io-channel-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    twl {
> +        madc {
> +            compatible =3D "ti,twl4030-madc";
> +            interrupts =3D <3>;
> +            #io-channel-cells =3D <1>;
> +        };
> +    };
> +...
> diff --git a/Documentation/devicetree/bindings/iio/adc/twl4030-madc.txt b=
/Documentation/devicetree/bindings/iio/adc/twl4030-madc.txt
> deleted file mode 100644
> index 6bdd21404b57..000000000000
> --- a/Documentation/devicetree/bindings/iio/adc/twl4030-madc.txt
> +++ /dev/null
> @@ -1,24 +0,0 @@
> -* TWL4030 Monitoring Analog to Digital Converter (MADC)
> -
> -The MADC subsystem in the TWL4030 consists of a 10-bit ADC
> -combined with a 16-input analog multiplexer.
> -
> -Required properties:
> -  - compatible: Should contain "ti,twl4030-madc".
> -  - interrupts: IRQ line for the MADC submodule.
> -  - #io-channel-cells: Should be set to <1>.
> -
> -Optional properties:
> -  - ti,system-uses-second-madc-irq: boolean, set if the second madc irq =
register
> -				    should be used, which is intended to be used
> -				    by Co-Processors (e.g. a modem).
> -
> -Example:
> -
> -&twl {
> -	madc {
> -		compatible =3D "ti,twl4030-madc";
> -		interrupts =3D <3>;
> -		#io-channel-cells =3D <1>;
> -	};
> -};
> --=20
> 2.28.0
>=20

--loa36x33czqo7ckg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl9X7wUACgkQ2O7X88g7
+pp1nw/6A7G647iaQZNZR/N0uxU5rit2o5rh9QyEgoauVJD7Jz6g9wXK0+DItzvR
N2LF+kMXM1h9n+oT/7AUYsRGjVB6KfdmHn62XEcXU+YCGv+UlwYeM70IUDFhvCUC
S2McX58u81MEprhYtKLafYb4N3rZDHPMoJ333Z+p9rSKoJpgIQeL+lJIKdihYFa2
VKx54WIa+H95bcHN0afCjWq0OHikhewupj5mmWkRpLHMHsp/t7Xu5K+Kk8/BvVOW
QpyOBHXn+JhTUicTWj3+fm05p1VIbtgo9a0Xq78ei4yt8kdFGg/BlBwc6F3/VwYM
scLO02x18Wlnz15Hpk25v3XKISjcWc5Yup5zruX4VYTJ3LPXD8421qAiRapdlkOv
X9v5CywJfPsomBI/Gx+GirlhY0LREjcRZP30qkdaulIrKxyC/znmDy5jtDBg8XR/
uper5H0a+jGZWEbakwkhVNVxtIFoqruvJ4DcYHkWrVzDcZcUz99k/wpCEv+43gE4
OfBZ8RaTMykzBN19n/duJe1pAcAmk7Jyfl4ZDISS6cbzY/tZFAswsuFhui8UPWV6
63k8nCbuWh9cPTIKim5/6O6ljjb7iRT1NcrVjfys778acyinEHmLX34a+NL7gDlF
Qc6Hh6F9/YElnKcTMlDYSNpJPiiDR3urCkqNkST6EfxStYy13z8=
=dse5
-----END PGP SIGNATURE-----

--loa36x33czqo7ckg--
