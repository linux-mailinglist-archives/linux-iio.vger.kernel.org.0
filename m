Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 307A85E8E16
	for <lists+linux-iio@lfdr.de>; Sat, 24 Sep 2022 17:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbiIXPmV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 24 Sep 2022 11:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233987AbiIXPmN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 24 Sep 2022 11:42:13 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4517F9E8A2
        for <linux-iio@vger.kernel.org>; Sat, 24 Sep 2022 08:42:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 22DA0CE098E
        for <linux-iio@vger.kernel.org>; Sat, 24 Sep 2022 15:42:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F704C433C1;
        Sat, 24 Sep 2022 15:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664034124;
        bh=Pi3r7RFfjB1ZQR5A8zioZunFpZkeCIpGkMpxi2ewfEg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=W+B41+v+ty1jbD3yqbduGtFu4AmDdLMCl2FJln+jZApcqGWouuGdnRQyP+baBZlAg
         19TeyXFd7wsvQKZpZDPHNcPm0tlmIcNwT8CHsQDF08TiJ+rGe5IfLPVMuW0cuP9HPF
         TkWi0+1vaZdoCDnKQy67mCBBncYgIXo2ynWiyttqDIshysJxfvC6cNxNLQA3MyM0at
         oZpfezkiR6IIBYtkvBCr7M56Kn2xtFhIKRbTRwHAEDZZLBSZlQGrpGjQ7NAv7c3fYj
         nUyLtBYKSrtF1J33Omeraw8WzsJ3I7dsEDQvA5kkZs1zJ4IZY1MOy+Uu6GADk/5FqO
         oy7lqqpAe71vg==
Date:   Sat, 24 Sep 2022 16:42:06 +0100
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
Subject: Re: [PATCH 11/15] iio: common: scmi_iio: do not use internal
 iio_dev lock
Message-ID: <20220924164206.37a26d50@jic23-huawei>
In-Reply-To: <20220920112821.975359-12-nuno.sa@analog.com>
References: <20220920112821.975359-1-nuno.sa@analog.com>
        <20220920112821.975359-12-nuno.sa@analog.com>
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

On Tue, 20 Sep 2022 13:28:17 +0200
Nuno S=C3=A1 <nuno.sa@analog.com> wrote:

> The iio_device lock is only meant for internal use. Hence define a
> device local lock to protect against concurrent accesses.
>=20
> Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
Ouch - this driver is fairly new and I missed that it was using mlock.
I guess this is a good example of why we need to finishing hiding it away!

Patch looks fine to me - I'll pick up in v2.

Jonathan

> ---
>  drivers/iio/common/scmi_sensors/scmi_iio.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/iio/common/scmi_sensors/scmi_iio.c b/drivers/iio/com=
mon/scmi_sensors/scmi_iio.c
> index 54ccf19ab2bb..d92f7f651f7b 100644
> --- a/drivers/iio/common/scmi_sensors/scmi_iio.c
> +++ b/drivers/iio/common/scmi_sensors/scmi_iio.c
> @@ -15,6 +15,7 @@
>  #include <linux/kernel.h>
>  #include <linux/kthread.h>
>  #include <linux/module.h>
> +#include <linux/mutex.h>
>  #include <linux/scmi_protocol.h>
>  #include <linux/time.h>
>  #include <linux/types.h>
> @@ -27,6 +28,8 @@ struct scmi_iio_priv {
>  	struct scmi_protocol_handle *ph;
>  	const struct scmi_sensor_info *sensor_info;
>  	struct iio_dev *indio_dev;
> +	/* lock to protect against multiple access to the device */
> +	struct mutex lock;
>  	/* adding one additional channel for timestamp */
>  	s64 iio_buf[SCMI_IIO_NUM_OF_AXIS + 1];
>  	struct notifier_block sensor_update_nb;
> @@ -198,13 +201,14 @@ static int scmi_iio_write_raw(struct iio_dev *iio_d=
ev,
>  			      struct iio_chan_spec const *chan, int val,
>  			      int val2, long mask)
>  {
> +	struct scmi_iio_priv *sensor =3D iio_priv(iio_dev);
>  	int err;
> =20
>  	switch (mask) {
>  	case IIO_CHAN_INFO_SAMP_FREQ:
> -		mutex_lock(&iio_dev->mlock);
> +		mutex_lock(&sensor->lock);
>  		err =3D scmi_iio_set_odr_val(iio_dev, val, val2);
> -		mutex_unlock(&iio_dev->mlock);
> +		mutex_unlock(&sensor->lock);
>  		return err;
>  	default:
>  		return -EINVAL;
> @@ -586,6 +590,7 @@ scmi_alloc_iiodev(struct scmi_device *sdev,
>  	sensor->sensor_info =3D sensor_info;
>  	sensor->sensor_update_nb.notifier_call =3D scmi_iio_sensor_update_cb;
>  	sensor->indio_dev =3D iiodev;
> +	mutex_init(&sensor->lock);
> =20
>  	/* adding one additional channel for timestamp */
>  	iiodev->num_channels =3D sensor_info->num_axis + 1;

