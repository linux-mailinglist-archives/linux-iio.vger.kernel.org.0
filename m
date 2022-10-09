Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2688E5F8B1A
	for <lists+linux-iio@lfdr.de>; Sun,  9 Oct 2022 14:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbiJIMJ1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 9 Oct 2022 08:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiJIMJ0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 9 Oct 2022 08:09:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 465AF2DA95
        for <linux-iio@vger.kernel.org>; Sun,  9 Oct 2022 05:09:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 074AFB80B93
        for <linux-iio@vger.kernel.org>; Sun,  9 Oct 2022 12:09:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29734C433D6;
        Sun,  9 Oct 2022 12:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665317355;
        bh=a+ioslH5ZrFK62x3g8Zoc7k7bQyq+RGCbyE28/jS2Ko=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=O0XWmv1077JxkBtJhkhNyENj58OE4zSAaaJ8o1YThoYLJBqLSNvKC053z+U9OA/vW
         WTJUaKKJMj7O3TqaOZO05Czdi5q8fSmMo+3sj+SC0siazhzsl2E4YEqL97oIN8EQ48
         EfuOlqTGvfbnOCaIvbz/C7he6W12UaTlZQEz1yMHk45oOe4hQtDtipTWPxyTNaMVfM
         7O1EyGem14SCzn8C/OEMu9PAdZ4mBSdJWbljQZZSYjW6k/7WZRxTnM/0E6nsN/BmLd
         qsctI4powagQi0P/Ra5ooVJgQXOniq2CMkzW1eo3fsUCk8wF1PTpoOb6HK8bdXycnB
         zCERq8Q9QRF1Q==
Date:   Sun, 9 Oct 2022 13:09:31 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Cc:     <linux-amlogic@lists.infradead.org>, <linux-imx@nxp.com>,
        <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-rockchip@lists.infradead.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Shawn Guo <shawnguo@kernel.org>,
        "Lars-Peter Clausen" <lars@metafoo.de>,
        Jyoti Bhayana <jbhayana@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Cixi Geng <cixi.geng1@unisoc.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Ciprian Regus" <ciprian.regus@analog.com>,
        Fabio Estevam <festevam@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        "Florian Boor" <florian.boor@kernelconcepts.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        "Chen-Yu Tsai" <wens@csie.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        "Vladimir Zapolskiy" <vz@mleia.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Jerome Brunet" <jbrunet@baylibre.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH v2 11/16] iio: common: scmi_iio: do not use internal
 iio_dev lock
Message-ID: <20221009130931.0fdd3fc9@jic23-huawei>
In-Reply-To: <20221004134909.1692021-12-nuno.sa@analog.com>
References: <20221004134909.1692021-1-nuno.sa@analog.com>
        <20221004134909.1692021-12-nuno.sa@analog.com>
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

On Tue, 4 Oct 2022 15:49:04 +0200
Nuno S=C3=A1 <nuno.sa@analog.com> wrote:

> The iio_device lock is only meant for internal use. Hence define a
> device local lock to protect against concurrent accesses.
>=20
> While at it, properly include "mutex.h" for mutex related APIs.
>=20
> Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
Applied to the togreg branch of iio.git, but for now only pushed out as tes=
ting
as I'll be rebasing on rc1 once available.

Thanks,

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

