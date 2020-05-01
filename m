Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 982311C1109
	for <lists+linux-iio@lfdr.de>; Fri,  1 May 2020 12:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728645AbgEAKmn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 1 May 2020 06:42:43 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:58826 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728644AbgEAKmm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 1 May 2020 06:42:42 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 76CCC2A059D
Received: by earth.universe (Postfix, from userid 1000)
        id 631873C08C7; Fri,  1 May 2020 12:42:38 +0200 (CEST)
Date:   Fri, 1 May 2020 12:42:38 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Saravanan Sekar <sravanhome@gmail.com>
Cc:     lee.jones@linaro.org, andy.shevchenko@gmail.com,
        robh+dt@kernel.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v11 5/6] power: supply: mp2629: Add impedance
 compensation config
Message-ID: <20200501104238.534ojcpjcjijnusg@earth.universe>
References: <20200430155810.21383-1-sravanhome@gmail.com>
 <20200430155810.21383-6-sravanhome@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ip44x4nvlgnwpabr"
Content-Disposition: inline
In-Reply-To: <20200430155810.21383-6-sravanhome@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--ip44x4nvlgnwpabr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Apr 30, 2020 at 05:58:09PM +0200, Saravanan Sekar wrote:
> Allows the user to compensate the intrinsic resistance of the battery
> to accelerate the charging cycle.
>=20
> Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> ---

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

>  Documentation/ABI/testing/sysfs-class-power-mp2629 | 8 ++++++++
>  1 file changed, 8 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-class-power-mp2629
>=20
> diff --git a/Documentation/ABI/testing/sysfs-class-power-mp2629 b/Documen=
tation/ABI/testing/sysfs-class-power-mp2629
> new file mode 100644
> index 000000000000..327a07e22805
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-class-power-mp2629
> @@ -0,0 +1,8 @@
> +What:		/sys/class/power_supply/mp2629_battery/batt_impedance_compen
> +Date:		April 2020
> +KernelVersion:	5.7
> +Description:
> +		Represents a battery impedance compensation to accelerate charging.
> +
> +                Access: Read, Write
> +                Valid values: Represented in milli-ohms. Valid range is =
[0, 140].
> --=20
> 2.17.1
>=20

--ip44x4nvlgnwpabr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl6r/RYACgkQ2O7X88g7
+pqIhA/8DQEBVc2YPO7pWQLGNWcqwf2OfLDrDYiYoudm47BUVBCZ2G2ZhnAxSx/T
T803qvsx5sdOyL/jUSILMipsCY8+gPwTGcuhjoBJHdwC+jRrPUZoHxy+Rqom12+b
nfOGZ1jDvWklTCx2pLc/K0W0G7cGHx9SXWqIhtLwdGJCEuBkL5TlrJjwG/Iw/OQY
StUT/E2CusoMGVU27fsmlxoKLEw6NyFWaHKZfTuWNbM7Mf7EEhhNp/ZWSVs1TLzO
VT15Hb4rDd4zRZwNQkirI1uCgHoeyvues+maKwUWPLL7wOUU8ymJ9xcj2eSqgRWX
A/KCrfEwLZz0rN6CZvEiGV+dUhwVsJ7dVj4Dq5uW/dKKylmcxXrbpeG/GgVT4Mhy
VzIdfzOunhCGHEBtHsJ+lsD1ZlhlzTyw2J8zgRKncuLcXu7hZ/Tc9n9rEqIrD+M3
l2BlkXMaDoOLsdWE9v3SVPfLSuT4RGfij0p3LoyJJdOcPrsYi2ww52QhYvRD5o/9
uPPZ9q/SphziByPgtpTvadJrD27GCuDrY50pJK+alxQgKOpFn9a9lXiCEZCMBQB7
2uLVAr/51tUbjgGD1cUfF7xhtFbUmF9+S3IfDCR9bpXd5+WsdDlZAQbfZP5esWHV
3wgqnPOXzJ2ggvt+tYOESbK3eieelPdDcOzg2YbaF0Ku3JNpP+g=
=rZay
-----END PGP SIGNATURE-----

--ip44x4nvlgnwpabr--
