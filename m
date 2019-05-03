Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1222D12A53
	for <lists+linux-iio@lfdr.de>; Fri,  3 May 2019 11:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727135AbfECJSl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 3 May 2019 05:18:41 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:50717 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726549AbfECJSk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 3 May 2019 05:18:40 -0400
X-Originating-IP: 90.88.149.145
Received: from localhost (aaubervilliers-681-1-29-145.w90-88.abo.wanadoo.fr [90.88.149.145])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id A592060014;
        Fri,  3 May 2019 09:18:35 +0000 (UTC)
Date:   Fri, 3 May 2019 11:18:35 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        wens@csie.org, jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 7/7] iio: adc: sun4i-gpadc-iio convert to SPDX license
 tags
Message-ID: <20190503091835.jx2fosyygkhy67aw@flea>
References: <20190503072813.2719-1-tiny.windzz@gmail.com>
 <20190503072813.2719-8-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ddeoccdv6vp3wp6d"
Content-Disposition: inline
In-Reply-To: <20190503072813.2719-8-tiny.windzz@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--ddeoccdv6vp3wp6d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 03, 2019 at 03:28:13AM -0400, Yangtao Li wrote:
> Updates license to use SPDX-License-Identifier.
>
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  drivers/iio/adc/sun4i-gpadc-iio.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gpadc-iio.c
> index 9b6fc592f54c..cf2bf3ab3342 100644
> --- a/drivers/iio/adc/sun4i-gpadc-iio.c
> +++ b/drivers/iio/adc/sun4i-gpadc-iio.c
> @@ -1,11 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0+
>  /* ADC driver for sunxi platforms' (A10, A13 and A31) GPADC
>   *
>   * Copyright (c) 2016 Quentin Schulz <quentin.schulz@free-electrons.com>
>   *
> - * This program is free software; you can redistribute it and/or modify it under
> - * the terms of the GNU General Public License version 2 as published by the
> - * Free Software Foundation.
> - *

The license here is GPL2 only, not GPL2 or later.

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--ddeoccdv6vp3wp6d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXMwHawAKCRDj7w1vZxhR
xR/3AP9LxurFTEoLfKKf5UUVWYtYBc+a5fX72/5UF72Jinp4/gEAjdVi2+M2F4Tw
jC8P95k9Tn48jKQZ3GKADIypTMkcMQ8=
=LsGW
-----END PGP SIGNATURE-----

--ddeoccdv6vp3wp6d--
