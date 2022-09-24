Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DDB55E8E30
	for <lists+linux-iio@lfdr.de>; Sat, 24 Sep 2022 17:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231564AbiIXPyU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 24 Sep 2022 11:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbiIXPyT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 24 Sep 2022 11:54:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6396B261A
        for <linux-iio@vger.kernel.org>; Sat, 24 Sep 2022 08:54:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 22DC8B80E67
        for <linux-iio@vger.kernel.org>; Sat, 24 Sep 2022 15:54:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35240C433C1;
        Sat, 24 Sep 2022 15:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664034855;
        bh=4Q+zv1OTwlHNnGbpSzBP+qJyET/kJyeReqevWtuVea0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vNWIsBFw53OuatO7HkfDmlq2gj0TTPiz/Dexq+L+U429yEnSbSUcVLjAVrdEiXbLJ
         hp4vUqmv3lc7M6BAyrpGT5n00AdB8NeIXkGK5DHjnCDPwEeCtvPOEGVkP8RUeTCk6G
         KkKqmQ8g+68dgZUldfG0wFJl2GbhVTDzPD0ux9J54Z/R30OTmYZgnSu+BKg23u80qp
         SeY9KcCV4uJHyN5lbAEtAm0Ip9K6vqMoNBoEXpCtehW/NjsejAskcZYBlh5XRPSa9d
         siuFlRIf+hDEZSsar8xD6qVnSxmPCeXZ1sAghT7EuGUVF5MS+YWLYNuyFu2AlwCiho
         PpPejzYi4sgaA==
Date:   Sat, 24 Sep 2022 16:54:17 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Cc:     <linux-arm-kernel@lists.infradead.org>,
        <linux-rockchip@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-imx@nxp.com>,
        <linux-iio@vger.kernel.org>, Chunyan Zhang <zhang.lyra@gmail.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Cixi Geng <cixi.geng1@unisoc.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        Fabio Estevam <festevam@gmail.com>,
        Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Florian Boor <florian.boor@kernelconcepts.de>,
        Ciprian Regus <ciprian.regus@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Jyoti Bhayana <jbhayana@google.com>,
        Chen-Yu Tsai <wens@csie.org>, Orson Zhai <orsonzhai@gmail.com>
Subject: Re: [PATCH 14/15] iio: health: max30102: do not use internal
 iio_dev lock
Message-ID: <20220924165417.46a1fc44@jic23-huawei>
In-Reply-To: <20220920112821.975359-15-nuno.sa@analog.com>
References: <20220920112821.975359-1-nuno.sa@analog.com>
        <20220920112821.975359-15-nuno.sa@analog.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 20 Sep 2022 13:28:20 +0200
Nuno S=C3=A1 <nuno.sa@analog.com> wrote:

> The pattern used in this device does not quite fit in the
> iio_device_claim_direct_mode() typical usage. In this case,
> iio_buffer_enabled() was being used not to prevent the raw access
> but to decide whether or not the device needs to be powered on before.
> If buffering, then the device is already on. To guarantee the same
> behavior, a combination of locks is being used:
>=20
> 1. Use iio_device_claim_direct_mode() to check if direct mode can be
> claimed and if we can, then we keep it until the reading is done (which
> also means the device will be powered on and off);
> 2. If already buffering, we need to make sure that buffering is not
> disabled (and hence, powering off the device) while doing a raw read. For
> that, we can make use of the local lock that already exists.
>=20
> Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
Obviously same dance in here as the related previous patch. So same solution
needs adopting.  I just thought I'd reply to make sure we didn't forget to
cover them both :)

Jonathan


> ---
>  drivers/iio/health/max30102.c | 25 +++++++++++++++++++------
>  1 file changed, 19 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/iio/health/max30102.c b/drivers/iio/health/max30102.c
> index abbcef563807..e984c78b99f6 100644
> --- a/drivers/iio/health/max30102.c
> +++ b/drivers/iio/health/max30102.c
> @@ -227,9 +227,20 @@ static int max30102_buffer_postenable(struct iio_dev=
 *indio_dev)
>  static int max30102_buffer_predisable(struct iio_dev *indio_dev)
>  {
>  	struct max30102_data *data =3D iio_priv(indio_dev);
> +	int ret;
> +
> +	/*
> +	 * As stated in the comment in the read_raw() function, temperature
> +	 * can only be acquired if the engine is running. As such the mutex
> +	 * is used to make sure we do not power down while doing a temperature
> +	 * reading.
> +	 */
> +	mutex_lock(&data->lock);
> +	ret =3D max30102_set_powermode(data, MAX30102_REG_MODE_CONFIG_MODE_NONE,
> +				     false);
> +	mutex_unlock(&data->lock);
> =20
> -	return max30102_set_powermode(data, MAX30102_REG_MODE_CONFIG_MODE_NONE,
> -				      false);
> +	return ret;
>  }
> =20
>  static const struct iio_buffer_setup_ops max30102_buffer_setup_ops =3D {
> @@ -477,12 +488,14 @@ static int max30102_read_raw(struct iio_dev *indio_=
dev,
>  		 * Temperature reading can only be acquired when not in
>  		 * shutdown; leave shutdown briefly when buffer not running
>  		 */
> -		mutex_lock(&indio_dev->mlock);
> -		if (!iio_buffer_enabled(indio_dev))
> +		if (!iio_device_claim_direct_mode(indio_dev)) {
>  			ret =3D max30102_get_temp(data, val, true);
> -		else
> +			iio_device_release_direct_mode(indio_dev);
> +		} else {
> +			mutex_lock(&data->lock);
>  			ret =3D max30102_get_temp(data, val, false);
> -		mutex_unlock(&indio_dev->mlock);
> +			mutex_unlock(&data->lock);
> +		}
>  		if (ret)
>  			return ret;
> =20

