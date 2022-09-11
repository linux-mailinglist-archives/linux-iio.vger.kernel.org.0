Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A26D15B584B
	for <lists+linux-iio@lfdr.de>; Mon, 12 Sep 2022 12:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbiILK2i (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 12 Sep 2022 06:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbiILK2h (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 12 Sep 2022 06:28:37 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59EE639B9C;
        Mon, 12 Sep 2022 03:28:36 -0700 (PDT)
Received: from mercury (unknown [185.122.133.20])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D43596601FDD;
        Mon, 12 Sep 2022 11:28:34 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1662978515;
        bh=Xjl7kTJeZ2nONpBk10Yzpv6u6vfACUqH8y3R+xm4q+8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I0M9rjwy5Q2EeroeuXJ11DmtRSQe8LkTof/d8GMVwx5v6wpaYrt7V0jlMzmODNZw6
         2U9tBHjFMfArkXA6FvEEeLikNsCPUz5DfIYOk7pPEg0ez7Ifr5/EvM3VyeBqMfXNZO
         QnS9W8ZafXgA+yYcskSaNJR3BUi5sbOUA5JKu7310dfyoJvG+cm0vHOwGzq1mlZsEc
         FxvVIMdljhnGWWJJEG4vcyTNOP9eIIH6yFOnHplJhX+lqRRoaSWhViN4B2fuGiQZD4
         XKuQMaSEEjmTNObtFKfBRMUKvKQMbsXBmVzzn0F04avbjWpoZD8n8uWSA1jYKrhCxo
         ZqRyPIK892MEg==
Received: by mercury (Postfix, from userid 1000)
        id 641E71063363; Sun, 11 Sep 2022 15:31:01 +0200 (CEST)
Date:   Sun, 11 Sep 2022 15:31:01 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Saravanan Sekar <sravanhome@gmail.com>
Cc:     lee.jones@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jic23@kernel.org,
        lars@metafoo.de, andy.shevchenko@gmail.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 5/6] power: supply: Add support for mp2733 battery
 charger
Message-ID: <20220911133101.7g6hnwp3dnnqrmgb@mercury.elektranox.org>
References: <20220615145357.2370044-1-sravanhome@gmail.com>
 <20220615145357.2370044-6-sravanhome@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qcqgmqhaojla5l7i"
Content-Disposition: inline
In-Reply-To: <20220615145357.2370044-6-sravanhome@gmail.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--qcqgmqhaojla5l7i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jun 15, 2022 at 04:53:56PM +0200, Saravanan Sekar wrote:
> mp2733 is updated version of mp2629 battery charge management
> which supports USB fast-charge and higher range of input voltage.
>=20
> Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> ---
> [...]
>  	psy_cfg.drv_data =3D charger;
> -	psy_cfg.attr_grp =3D mp2629_charger_sysfs_groups;
> +	if (charger->chip_info->has_impedance)
> +		psy_cfg.attr_grp =3D mp2629_charger_sysfs_groups;
> +
> +	if (charger->chip_info->has_fast_charge)
> +		psy_cfg.attr_grp =3D mp2733_charger_sysfs_groups;
> +
>  	charger->battery =3D devm_power_supply_register(dev,
>  					 &mp2629_battery_desc, &psy_cfg);
>  	if (IS_ERR(charger->battery)) {

Instead of having has_impedance and has_fast_charge feature
flag that are mutual exclusive, store the device type and
use if/else or switch statement to chose the correct attr_grp.
Other than that:

Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

--qcqgmqhaojla5l7i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmMd4xEACgkQ2O7X88g7
+poocA/+Lz3J1X/X7Tv6Qr1eROOD7GUNz0r9mAnvehTOu5seQCOA4N/RO8m9UlOg
94ZqS8NjdOUyr4QuRDmr6fH8WkgTrBzeW4bDHp+tIEwhIsxp6LGwxet3A6165mkB
99Tg0KEddnfGxSQ06ma2Fda8yWPKeYimHgETJLI+e3A7fOeVTnCSB+AOUNpnmc+J
r8Xqbj0uckH4hTecKJPMPRpzMoDmjJh5LDpXN4QM5MnjMXlMLrbEl8XRoNsUMeg+
TeQcsSwPJs+QwyokMUN6odEkuLKjxc64KNovztyhrFYq+ysVOwCYiLD+9yiMqkyQ
A3N3T1Y8/3gHCNuV+3O+ORGsZT7hcUceTzFiRVzGknJpZU0fnRMxv4BUaC6aosHH
r+J4WfD5pJP/O7Ji3y/uhCNHhgXtDQtaqrZlQEUIej+V9FxVGcxJGFeKw9jZkCHJ
+aYW7fT1hg4bkzYZpUcMdkkcc/Y8iHmHvmS4c0iPh6USP66nIGknfxGez5HeVF+E
efr6/kmDDw4gkB9NIA2QFRbfyikPNyW3d48ahY4N9U3cWYq7oGRMmDopQVhq9Ho4
Brl7PjjebDyauG0QGFEaxamtYvg6clTkenevN1BiEGCdnQRsKqG3poh6Gh2iuTtZ
m/DW9+cyjE57uWSIQZ3MDcL4ROK77FLNJ+FNErt1cqbAqOQ4A2k=
=8nRK
-----END PGP SIGNATURE-----

--qcqgmqhaojla5l7i--
