Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84DA5611406
	for <lists+linux-iio@lfdr.de>; Fri, 28 Oct 2022 16:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbiJ1OHG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 28 Oct 2022 10:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231354AbiJ1OHG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 28 Oct 2022 10:07:06 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2016B1DC802;
        Fri, 28 Oct 2022 07:07:05 -0700 (PDT)
Received: from mercury (unknown [37.84.150.129])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id DE32C6602925;
        Fri, 28 Oct 2022 15:07:03 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1666966024;
        bh=b+dmykbhnZBjZG+45a2JI9gul2w3DjWzcEXQfAgTb8w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KTluhKw7CYgsqEF4S+rKQSVu+COc3HzX0027zWUxenCHiRYYNXEfrHr1krL6es6qH
         CvIK5Zs8zVS5LDViAgzsCGB+zzoiTExt+d2vtpgfV1UQ6vCBhPqFePyfYJ8UUl9v/Z
         4QFOpUlXR2wvpiT3uB7oQ/u67sfxJgqqiyeJfvcrmeccSSz5KhqCUlODOFZBXGcPHm
         fcMa3LH4UvrOP8TPF1/3mbuEwuiitZYHohY4df7w20ZI5M77thaYSh9IPOMdeUEbwQ
         U8CcXHnEMFhszpEBYlY85zGqGong3XHJevOyZSdnz7+kAo72y3BuC9PxpNRGTT7v4O
         8NFe1MXfA+baw==
Received: by mercury (Postfix, from userid 1000)
        id 88D1510607E8; Fri, 28 Oct 2022 16:07:01 +0200 (CEST)
Date:   Fri, 28 Oct 2022 16:07:01 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Saravanan Sekar <sravanhome@gmail.com>
Cc:     lee.jones@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jic23@kernel.org,
        lars@metafoo.de, andy.shevchenko@gmail.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v4 5/8] power: supply: mp2629: Add USB fast charge
 settings
Message-ID: <20221028140701.e2q2ukiquzzjmhjg@mercury.elektranox.org>
References: <20221024132757.3345400-1-sravanhome@gmail.com>
 <20221024132757.3345400-6-sravanhome@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ohozfzobh33tgn2f"
Content-Disposition: inline
In-Reply-To: <20221024132757.3345400-6-sravanhome@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--ohozfzobh33tgn2f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Oct 24, 2022 at 03:27:54PM +0200, Saravanan Sekar wrote:
> Allows the user to change the USB device fast charge setting to advertise
> host on enumeration helps to accelerate the charging cycle. Altering this
> value resets USB existing connection.
>=20
> Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> ---

Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

>  .../ABI/testing/sysfs-class-power-mp2629         | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>=20
> diff --git a/Documentation/ABI/testing/sysfs-class-power-mp2629 b/Documen=
tation/ABI/testing/sysfs-class-power-mp2629
> index 914d67caac0d..b386d02cb010 100644
> --- a/Documentation/ABI/testing/sysfs-class-power-mp2629
> +++ b/Documentation/ABI/testing/sysfs-class-power-mp2629
> @@ -1,3 +1,19 @@
> +What:		/sys/class/power_supply/mp2629_battery/usb_fast_charge
> +Date:		June 2022
> +KernelVersion:	5.20
> +Description:
> +		Represents a USB device fast charge settings.Altering this
> +		value resets USB existing connection
> +		USB DP:DM[0:0] 0.6V : Hi-Z
> +		USB DP:DM[0:1] 3.3V : 0.6V
> +		USB DP:DM[1:0] 0.6V : 0.6V
> +		USB DP:DM[1:1] 0.6V : 3.3V
> +
> +                Access: Read, Write
> +
> +                Valid values: Represented in bit DP & DM setting. Valid
> +			      range is [0, 3].
> +
>  What:		/sys/class/power_supply/mp2629_battery/batt_impedance_compen
>  Date:		April 2020
>  KernelVersion:	5.7
> --=20
> 2.32.0
>=20

--ohozfzobh33tgn2f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmNb4gUACgkQ2O7X88g7
+ppA9A//Xsz2LxawwvIgJTT4R0ELr5vOGp1GnOoXxK23EFyzkiWcIEVRm0vy9x7t
6Z1Lxbm411qUqgtY367e6Czmv1xEt+UqakkovDD6yG6Sqp3u9hRumfczoVTRc3CY
pQNhS2PmtIm64OXbVwyc+rEQzeqNylEC6OgSp9ZIZawYz8750ailLNBznwZezcNt
NRFja2/a2gH06g2X3M06jnDb+8lcQzn86IyoFnug0XdzLxRh0tEmslE8T5UlyE+y
lwveyYkGrGviNI3VN1N2CIhCQdR9jMWilGfPmUsQAmxw3zZ+vpWKeGNh38jDNix9
picZ7WWmcbNU9b+rMOwOR0MjcUgkFMuFC41aNtw0FyPeXLC11RX5Tu8eyKlk5944
42/IUCLFiSFQj3twYqUT5vY2fD/p+Zkft5a63qAWkm1ZV9xjZ/RNSPEk+h+k1FUG
idY/g5WJtCvkTev43VrtvIjbDEv4CMCfXMGzQi1hqXsuQZ+1/TiWEha8G7daFuN9
1O/zIApo161BoobcSK4DrP31W3Mrh1kN7cnGuwzFUR1cK298akg8+8TfCsgG+rk0
8qchxKXuZxY0pMh9PgEfrA0aH8E0GZpOD04wY4yQN7Hto7LIUKl9HSvIw12lTfyk
Pu31LioqGsPdPqE5i8iuWtX7gpWhZ5txPQd7GbW24ewZ6l3ZT/I=
=mwkP
-----END PGP SIGNATURE-----

--ohozfzobh33tgn2f--
