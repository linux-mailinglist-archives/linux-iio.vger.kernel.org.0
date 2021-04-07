Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FDD23569DD
	for <lists+linux-iio@lfdr.de>; Wed,  7 Apr 2021 12:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351201AbhDGKkG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 7 Apr 2021 06:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351158AbhDGKkA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 7 Apr 2021 06:40:00 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F489C061756;
        Wed,  7 Apr 2021 03:39:51 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id E79D01F453CF
Received: by earth.universe (Postfix, from userid 1000)
        id 2F75D3C0C96; Wed,  7 Apr 2021 12:39:46 +0200 (CEST)
Date:   Wed, 7 Apr 2021 12:39:46 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Artur Rojek <contact@artur-rojek.eu>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Lee Jones <lee.jones@linaro.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 07/19] dt-bindings: fix references for iio-bindings.txt
Message-ID: <20210407103946.hxr3yoeasumuzsdk@earth.universe>
References: <cover.1617783062.git.mchehab+huawei@kernel.org>
 <c4e3cfcc666552084df5155c4f3957134b72ef7a.1617783062.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2ca4km7phoijhn6n"
Content-Disposition: inline
In-Reply-To: <c4e3cfcc666552084df5155c4f3957134b72ef7a.1617783062.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--2ca4km7phoijhn6n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Apr 07, 2021 at 10:20:46AM +0200, Mauro Carvalho Chehab wrote:
> The iio-bindings.txt was converted into two files and merged
> at the dt-schema git tree at:
>=20
> 	https://github.com/devicetree-org/dt-schema
>=20
> Yet, some documents still refer to the old file. Fix their
> references, in order to point to the right URL.
>=20
> Fixes: dba91f82d580 ("dt-bindings:iio:iio-binding.txt Drop file as conten=
t now in dt-schema")
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---

[...]

>  .../devicetree/bindings/power/supply/da9150-charger.txt      | 2 +-

This file got converted to YAML in my tree and no longer exists in
linux-next. The new YAML file no longer references iio-bindings.txt.

-- Sebastian

--2ca4km7phoijhn6n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmBti+YACgkQ2O7X88g7
+ppT7Q/+MFaaDYk56GF+wi+QyV+vfgvcoBWD2eDgLGinJVCETdwJNtd7P8qw9BdT
yHp+Mzz5Zq+fpJrZg9JvfEw/kL6eHJfoOimW/r6qQAA4tdHYD053pZXPa9lSPlSU
NgK+TR0UlM6vDXIcl2tUSo0ps/eofdUSvjLmjfAXC+WBOvbokDtijr9FDCm5eXAE
iEtUplHH1SLkxrIBDZhnNoIiHc4xj/D5AaZSg9LB4zHuJsF66vG763wwKyTgtE8A
MqF8F/IR0ZFRuCAlmJDogQ3HM/1lirXhqPX3Ife1uuyzSA1Zz0vqkCRwEV/9itwT
qH0YFWVo/GU2MZeshUOgsP/rMHPEiXIH8pG2s+FUMx3BISgk/CH7WysSei58SSJE
tUyC+ByP3mukLaDYtVBEZVlIDDgypcdO+UH6WrMyPhMaTpVSVYWJ9p2nEgUX5qF5
jWwi6lmeExNir9fqnCsXp4O5V2bk11w0jKr2QepOtRx4ak/7HQJkznQEj+Wmv+DW
Zz60FghpDaMs8yG8x7v8xOcOf0PPtREEYNhCIPffQsIqPclRYS3hgEt+nuU2CxkU
ayf7dN4DsDVG/amwymw40QvKRGjugmGjxK80kkXoPhZ/yVxH0pyjolWkaox2XjxN
LnqE/vsJZGi1NLTbWgg7/MSRIxuGAEmJJCEJLCtPhiCyDv06aas=
=RoNN
-----END PGP SIGNATURE-----

--2ca4km7phoijhn6n--
