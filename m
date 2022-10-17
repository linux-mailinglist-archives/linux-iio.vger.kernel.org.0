Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00AD4600768
	for <lists+linux-iio@lfdr.de>; Mon, 17 Oct 2022 09:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbiJQHLx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 17 Oct 2022 03:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiJQHLw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 17 Oct 2022 03:11:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66C65FAEE
        for <linux-iio@vger.kernel.org>; Mon, 17 Oct 2022 00:11:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1C10BB80F10
        for <linux-iio@vger.kernel.org>; Mon, 17 Oct 2022 07:11:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 654D4C433C1;
        Mon, 17 Oct 2022 07:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665990708;
        bh=3k3hHBPtg350YCzQOnNPuRcipS8Ws24QYqwCfvTIP3g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cRWUrESDlihO+NddIz7/veye+cFDUAHvqBFV5E/78JEgpNkMPe6qOCuLpeOqZRARP
         SjxmBWFwcOsIYgL6DwlEIhWu5fhkNPF+95Z7GJ3HBf3PmCLVQGQp3p2Nt9FA/WmAag
         MBTguStInUmlco7vGXytNoIlHQ5i0ibfA1MPdXenYbEm9ImiZiyOUxGW8rVPE/hNqY
         lApFjO8sB9qQl7StfVq2aUNmtCiv+06zNX87YffcCv9kM23BvSyaR8/v7j5fEfa/hn
         eSawVJej3E0On5EFKNNSaIiWs+qloNIKTj4UVIfOll+gLTfsJA+TegO/QBJE+M4p6C
         jVRZ5WJD7xl0g==
Date:   Mon, 17 Oct 2022 09:11:45 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Jagath Jog J <jagathjog1996@gmail.com>,
        Sean Nyekjaer <sean@geanix.com>,
        Dmitry Rokosov <DDRokosov@sberdevices.ru>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Martyn Welch <martyn.welch@collabora.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Tomasz Duszynski <tduszyns@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 09/14] iio: humidity: hts211: Use
 devm_regulator_get_enable()
Message-ID: <Y00AMdqsBfy4WQxI@lore-desk>
References: <20221016163409.320197-1-jic23@kernel.org>
 <20221016163409.320197-10-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GdtC1NA4ZB0gLRPW"
Content-Disposition: inline
In-Reply-To: <20221016163409.320197-10-jic23@kernel.org>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--GdtC1NA4ZB0gLRPW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>=20
> This driver only turns the power on at probe and off via a custom
> devm_add_action_or_reset() callback. The new devm_regulator_get_enable()
> replaces this boilerplate code.
>=20
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Lorenzo Bianconi <lorenzo@kernel.org>

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

> ---
>  drivers/iio/humidity/hts221.h      |  2 --
>  drivers/iio/humidity/hts221_core.c | 27 ++++-----------------------
>  2 files changed, 4 insertions(+), 25 deletions(-)
>=20
> diff --git a/drivers/iio/humidity/hts221.h b/drivers/iio/humidity/hts221.h
> index cf3d8d2dccd6..721359e226cb 100644
> --- a/drivers/iio/humidity/hts221.h
> +++ b/drivers/iio/humidity/hts221.h
> @@ -13,7 +13,6 @@
>  #define HTS221_DEV_NAME		"hts221"
> =20
>  #include <linux/iio/iio.h>
> -#include <linux/regulator/consumer.h>
> =20
>  enum hts221_sensor_type {
>  	HTS221_SENSOR_H,
> @@ -30,7 +29,6 @@ struct hts221_hw {
>  	const char *name;
>  	struct device *dev;
>  	struct regmap *regmap;
> -	struct regulator *vdd;
> =20
>  	struct iio_trigger *trig;
>  	int irq;
> diff --git a/drivers/iio/humidity/hts221_core.c b/drivers/iio/humidity/ht=
s221_core.c
> index 517158307d8c..2a413da87b76 100644
> --- a/drivers/iio/humidity/hts221_core.c
> +++ b/drivers/iio/humidity/hts221_core.c
> @@ -14,6 +14,7 @@
>  #include <linux/delay.h>
>  #include <linux/pm.h>
>  #include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
>  #include <linux/bitfield.h>
> =20
>  #include "hts221.h"
> @@ -549,33 +550,17 @@ static const unsigned long hts221_scan_masks[] =3D =
{0x3, 0x0};
> =20
>  static int hts221_init_regulators(struct device *dev)
>  {
> -	struct iio_dev *iio_dev =3D dev_get_drvdata(dev);
> -	struct hts221_hw *hw =3D iio_priv(iio_dev);
>  	int err;
> =20
> -	hw->vdd =3D devm_regulator_get(dev, "vdd");
> -	if (IS_ERR(hw->vdd))
> -		return dev_err_probe(dev, PTR_ERR(hw->vdd),
> -				     "failed to get vdd regulator\n");
> -
> -	err =3D regulator_enable(hw->vdd);
> -	if (err) {
> -		dev_err(dev, "failed to enable vdd regulator: %d\n", err);
> -		return err;
> -	}
> +	err =3D devm_regulator_get_enable(dev, "vdd");
> +	if (err)
> +		return dev_err_probe(dev, err, "failed to get vdd regulator\n");
> =20
>  	msleep(50);
> =20
>  	return 0;
>  }
> =20
> -static void hts221_chip_uninit(void *data)
> -{
> -	struct hts221_hw *hw =3D data;
> -
> -	regulator_disable(hw->vdd);
> -}
> -
>  int hts221_probe(struct device *dev, int irq, const char *name,
>  		 struct regmap *regmap)
>  {
> @@ -600,10 +585,6 @@ int hts221_probe(struct device *dev, int irq, const =
char *name,
>  	if (err)
>  		return err;
> =20
> -	err =3D devm_add_action_or_reset(dev, hts221_chip_uninit, hw);
> -	if (err)
> -		return err;
> -
>  	err =3D hts221_check_whoami(hw);
>  	if (err < 0)
>  		return err;
> --=20
> 2.37.2
>=20

--GdtC1NA4ZB0gLRPW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCY00AMAAKCRA6cBh0uS2t
rDsrAPoDe+NMk0vNkPP0+qj1fHuJ+alhHO9PzMf2tnSPci8gfQEA5ik7ct2g+tcS
BwznM+0UA9D3QBqq9OtEDD9lOV3lSw8=
=wSsZ
-----END PGP SIGNATURE-----

--GdtC1NA4ZB0gLRPW--
