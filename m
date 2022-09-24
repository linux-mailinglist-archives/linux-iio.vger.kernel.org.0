Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44E1E5E8E20
	for <lists+linux-iio@lfdr.de>; Sat, 24 Sep 2022 17:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233535AbiIXPqG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 24 Sep 2022 11:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233410AbiIXPqG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 24 Sep 2022 11:46:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A62DB72866
        for <linux-iio@vger.kernel.org>; Sat, 24 Sep 2022 08:46:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1534CB80E52
        for <linux-iio@vger.kernel.org>; Sat, 24 Sep 2022 15:46:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92C2BC433D6;
        Sat, 24 Sep 2022 15:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664034358;
        bh=31VmF6s9m67JEi4R+AisNT1iAfhlAHfnXHUBZfAaouo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Z8VheRpWRUmUmHSsAN/lhJ2agbF32eXhheWEvuv8n39bfqWnZ2AvLxnmazawQgmkU
         9Bt8rDJkeMXQ9zonxPuESDQmtRDuFdRvg1LQAQghuwqRezLhLbeWUA14Jf45qPV5Jx
         v8D6l1BW8Iw7a2/Kn5Q8RlRtrBHpUtIhC4lJyFMyeeIYbE6gtJfwbrGicZoOaP2eXU
         gvfE6Pgho8QOWXUeDM6J0VZ6YxrB6wmuavilvxaHdg/5FwOBgvfqmc5i3d+Hw/7fOd
         kbDd0XYDOeD9NxzHXHfQlKgYOr9BgYDwmkt3/73ObW2ZYFrXZqa5aReyby8yGvJezy
         Nwgse25Gpv5ug==
Date:   Sat, 24 Sep 2022 16:46:00 +0100
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
        "Fabio Estevam" <festevam@gmail.com>,
        Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        "Shawn Guo" <shawnguo@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        "Heiko Stuebner" <heiko@sntech.de>,
        Florian Boor <florian.boor@kernelconcepts.de>,
        Ciprian Regus <ciprian.regus@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        "Baolin Wang" <baolin.wang@linux.alibaba.com>,
        Jyoti Bhayana <jbhayana@google.com>,
        Chen-Yu Tsai <wens@csie.org>, Orson Zhai <orsonzhai@gmail.com>
Subject: Re: [PATCH 12/15] iio: fyro: itg3200_core: do not use internal
 iio_dev lock
Message-ID: <20220924164600.56abd07b@jic23-huawei>
In-Reply-To: <20220920112821.975359-13-nuno.sa@analog.com>
References: <20220920112821.975359-1-nuno.sa@analog.com>
        <20220920112821.975359-13-nuno.sa@analog.com>
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

On Tue, 20 Sep 2022 13:28:18 +0200
Nuno S=C3=A1 <nuno.sa@analog.com> wrote:

> The iio_device lock is only meant for internal use. Hence define a
> device local lock to protect against concurrent accesses.
As with earlier, add a note about mutex.h include.

Otherwise, looks fine.  My gut feeling is that we should
have a claim_direct_mode() in that write_raw() as well as
changing frequency whilst doing buffered capture is rarely a good
idea, but meh, we don't need to change the ABI so let us not do so.

Jonathan

>=20
> Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> ---
>  drivers/iio/gyro/itg3200_core.c  | 9 ++++++---
>  include/linux/iio/gyro/itg3200.h | 2 ++
>  2 files changed, 8 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/iio/gyro/itg3200_core.c b/drivers/iio/gyro/itg3200_c=
ore.c
> index 0491c64e1b32..358aa8ac0c6b 100644
> --- a/drivers/iio/gyro/itg3200_core.c
> +++ b/drivers/iio/gyro/itg3200_core.c
> @@ -18,6 +18,7 @@
>  #include <linux/slab.h>
>  #include <linux/stat.h>
>  #include <linux/module.h>
> +#include <linux/mutex.h>
>  #include <linux/delay.h>
> =20
>  #include <linux/iio/iio.h>
> @@ -131,6 +132,7 @@ static int itg3200_write_raw(struct iio_dev *indio_de=
v,
>  			     int val2,
>  			     long mask)
>  {
> +	struct itg3200 *st =3D iio_priv(indio_dev);
>  	int ret;
>  	u8 t;
> =20
> @@ -139,11 +141,11 @@ static int itg3200_write_raw(struct iio_dev *indio_=
dev,
>  		if (val =3D=3D 0 || val2 !=3D 0)
>  			return -EINVAL;
> =20
> -		mutex_lock(&indio_dev->mlock);
> +		mutex_lock(&st->lock);
> =20
>  		ret =3D itg3200_read_reg_8(indio_dev, ITG3200_REG_DLPF, &t);
>  		if (ret) {
> -			mutex_unlock(&indio_dev->mlock);
> +			mutex_unlock(&st->lock);
>  			return ret;
>  		}
>  		t =3D ((t & ITG3200_DLPF_CFG_MASK) ? 1000u : 8000u) / val - 1;
> @@ -152,7 +154,7 @@ static int itg3200_write_raw(struct iio_dev *indio_de=
v,
>  					  ITG3200_REG_SAMPLE_RATE_DIV,
>  					  t);
> =20
> -		mutex_unlock(&indio_dev->mlock);
> +		mutex_unlock(&st->lock);
>  		return ret;
> =20
>  	default:
> @@ -307,6 +309,7 @@ static int itg3200_probe(struct i2c_client *client,
>  		return -ENOMEM;
> =20
>  	st =3D iio_priv(indio_dev);
> +	mutex_init(&st->lock);
> =20
>  	ret =3D iio_read_mount_matrix(&client->dev, &st->orientation);
>  	if (ret)
> diff --git a/include/linux/iio/gyro/itg3200.h b/include/linux/iio/gyro/it=
g3200.h
> index a602fe7b84fa..74b6d1cadc86 100644
> --- a/include/linux/iio/gyro/itg3200.h
> +++ b/include/linux/iio/gyro/itg3200.h
> @@ -102,6 +102,8 @@ struct itg3200 {
>  	struct i2c_client	*i2c;
>  	struct iio_trigger	*trig;
>  	struct iio_mount_matrix orientation;
> +	/* lock to protect against multiple access to the device */
> +	struct mutex		lock;
>  };
> =20
>  enum ITG3200_SCAN_INDEX {

