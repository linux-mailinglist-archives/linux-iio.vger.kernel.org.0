Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37CBF602F4E
	for <lists+linux-iio@lfdr.de>; Tue, 18 Oct 2022 17:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbiJRPO3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 18 Oct 2022 11:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbiJRPO2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 18 Oct 2022 11:14:28 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0C65114B
        for <linux-iio@vger.kernel.org>; Tue, 18 Oct 2022 08:14:20 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id E54525FD82;
        Tue, 18 Oct 2022 18:14:16 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1666106056;
        bh=Td70hJqj7+2U7gqPllKJqANiMX54JKWn7J/nb68P4L4=;
        h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
        b=pVEN9zVN2L5PLxG937Jp/y6sjTegtlww870ZRYaAbUe5PyMYB98BTR5ozZaiGUlUx
         ZAOrMI0M9ditD8grC6C++IjpIhpUXV0QpDGWLaiTCAD2X90BIW4CBK97WupFf9M3fw
         xdM2wXjTK+g6O2FNqcppLbWAeunzUObwD4eKkEq2klMKPBtI7pSQOu3879Gev0RSeG
         gMMLnH/i8Tg7oMVUhNQcpxDBrGwVKPpVrx+z3p0Ewv4JBjzyXLmdj4HbJ3Q5+lKAh6
         qoPhsEIYlj5MIGdNp4WesJt8hPWTiRH5RlJ/guc9R0F9WWMyHFsif3YknYZUIDT9sj
         z6PlGk4vC3r2g==
Received: from S-MS-EXCH02.sberdevices.ru (S-MS-EXCH02.sberdevices.ru [172.16.1.5])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Tue, 18 Oct 2022 18:14:11 +0300 (MSK)
From:   Dmitry Rokosov <DDRokosov@sberdevices.ru>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Jagath Jog J <jagathjog1996@gmail.com>,
        "Sean Nyekjaer" <sean@geanix.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        "Martyn Welch" <martyn.welch@collabora.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Tomasz Duszynski <tduszyns@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 05/14] iio: accel: msa311: Use devm_regulator_get_enable()
Thread-Topic: [PATCH 05/14] iio: accel: msa311: Use
 devm_regulator_get_enable()
Thread-Index: AQHY4X0HmZZBrZxISkq4bSdU5Cukz64UE0GA
Date:   Tue, 18 Oct 2022 15:14:05 +0000
Message-ID: <20221018151405.e2nv4wiohskyhdvd@CAB-WSD-L081021>
References: <20221016163409.320197-1-jic23@kernel.org>
 <20221016163409.320197-6-jic23@kernel.org>
In-Reply-To: <20221016163409.320197-6-jic23@kernel.org>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.1.12]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F6FFEB458A7C194990C32D77B6B306B8@sberdevices.ru>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2022/10/18 11:59:00 #20479535
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello Jonathan,

Thank you for the patch! The current devm_regulator_get_enable() looks
much easier to read!

On Sun, Oct 16, 2022 at 05:34:00PM +0100, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>=20
> This driver only turns the power on at probe and off via a custom
> devm_add_action_or_reset() callback. The new devm_regulator_get_enable()
> replaces this boilerplate code.
>=20
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Dmitry Rokosov <DDRokosov@sberdevices.ru>
> ---
>  drivers/iio/accel/msa311.c | 21 ++-------------------
>  1 file changed, 2 insertions(+), 19 deletions(-)
>=20
> diff --git a/drivers/iio/accel/msa311.c b/drivers/iio/accel/msa311.c
> index 2fded3759171..af94d3adf6d8 100644
> --- a/drivers/iio/accel/msa311.c
> +++ b/drivers/iio/accel/msa311.c
> @@ -351,7 +351,6 @@ static const struct regmap_config msa311_regmap_confi=
g =3D {
>   * @chip_name: Chip name in the format "msa311-%02x" % partid
>   * @new_data_trig: Optional NEW_DATA interrupt driven trigger used
>   *                 to notify external consumers a new sample is ready
> - * @vdd: Optional external voltage regulator for the device power supply
>   */
>  struct msa311_priv {
>  	struct regmap *regs;
> @@ -362,7 +361,6 @@ struct msa311_priv {
>  	char *chip_name;
> =20
>  	struct iio_trigger *new_data_trig;
> -	struct regulator *vdd;
>  };
> =20
>  enum msa311_si {
> @@ -1146,11 +1144,6 @@ static void msa311_powerdown(void *msa311)
>  	msa311_set_pwr_mode(msa311, MSA311_PWR_MODE_SUSPEND);
>  }
> =20
> -static void msa311_vdd_disable(void *vdd)
> -{
> -	regulator_disable(vdd);
> -}
> -
>  static int msa311_probe(struct i2c_client *i2c)
>  {
>  	struct device *dev =3D &i2c->dev;
> @@ -1173,19 +1166,9 @@ static int msa311_probe(struct i2c_client *i2c)
> =20
>  	mutex_init(&msa311->lock);
> =20
> -	msa311->vdd =3D devm_regulator_get(dev, "vdd");
> -	if (IS_ERR(msa311->vdd))
> -		return dev_err_probe(dev, PTR_ERR(msa311->vdd),
> -				     "can't get vdd supply\n");
> -
> -	err =3D regulator_enable(msa311->vdd);
> +	err =3D devm_regulator_get_enable(dev, "vdd");
>  	if (err)
> -		return dev_err_probe(dev, err, "can't enable vdd supply\n");
> -
> -	err =3D devm_add_action_or_reset(dev, msa311_vdd_disable, msa311->vdd);
> -	if (err)
> -		return dev_err_probe(dev, err,
> -				     "can't add vdd disable action\n");
> +		return dev_err_probe(dev, err, "can't get vdd supply\n");
> =20
>  	err =3D msa311_check_partid(msa311);
>  	if (err)
> --=20
> 2.37.2
>=20

Reviewed-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>

--=20
Thank you,
Dmitry=
