Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30A72526AB
	for <lists+linux-iio@lfdr.de>; Tue, 25 Jun 2019 10:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730214AbfFYIao (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 25 Jun 2019 04:30:44 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:60737 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726702AbfFYIao (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 25 Jun 2019 04:30:44 -0400
X-Originating-IP: 90.88.16.156
Received: from localhost (aaubervilliers-681-1-41-156.w90-88.abo.wanadoo.fr [90.88.16.156])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 202B640008;
        Tue, 25 Jun 2019 08:30:36 +0000 (UTC)
Date:   Tue, 25 Jun 2019 10:30:36 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Stefan Popa <stefan.popa@analog.com>
Cc:     jic23@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        Michael.Hennerich@analog.com, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: iio: frequency: Use dt-schema for
 clock-names
Message-ID: <20190625083036.jrr7kz7f6ks6nqps@flea>
References: <1561389097-26075-1-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3yps4smao6vtc5y5"
Content-Disposition: inline
In-Reply-To: <1561389097-26075-1-git-send-email-stefan.popa@analog.com>
User-Agent: NeoMutt/20180716
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--3yps4smao6vtc5y5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Mon, Jun 24, 2019 at 06:11:37PM +0300, Stefan Popa wrote:
> Dt-schema can be used for clock-names property.
>
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>
> ---
>  Documentation/devicetree/bindings/iio/frequency/adf4371.yaml | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml b/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml
> index d7adf074..8a2a8f6 100644
> --- a/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml
> +++ b/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml
> @@ -27,9 +27,8 @@ properties:
>      maxItems: 1
>
>    clock-names:
> -    description:
> -      Must be "clkin"
> -    maxItems: 1
> +    items:
> +      - clkin

You can even just have const: clkin here

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--3yps4smao6vtc5y5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXRHbrAAKCRDj7w1vZxhR
xQZuAQC9jlgQRUnCtCGNePxUg5qP7pF5UA7RwPOekZVZTRmsvwD/c9wseWa2S6Qf
Iz+4hrxBAEEHVy3f/iOqUj5u6guy/AQ=
=k49w
-----END PGP SIGNATURE-----

--3yps4smao6vtc5y5--
