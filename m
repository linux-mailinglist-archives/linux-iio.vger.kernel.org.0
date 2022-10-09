Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10EE05F8B07
	for <lists+linux-iio@lfdr.de>; Sun,  9 Oct 2022 13:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbiJIL6o (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 9 Oct 2022 07:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbiJIL6l (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 9 Oct 2022 07:58:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01B8927FD6
        for <linux-iio@vger.kernel.org>; Sun,  9 Oct 2022 04:58:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 901DA60BC2
        for <linux-iio@vger.kernel.org>; Sun,  9 Oct 2022 11:58:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F6F7C433C1;
        Sun,  9 Oct 2022 11:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665316720;
        bh=yDoVUI424rlUKuHhs3ryyynC2XRAQsXx/3wlm/ahdzQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MqJISgSowLyc3IJLVImSHoi97hOfTu4zZRIykvtDpq0qsihUBhz5xMGceDqdddrLt
         uPp2hVITM7SMi4BlVclLhsMdfUlvraK377QxVnRqH9BC3e3MLyjyMtv1gj1mTbYVNn
         Qk+I5xOvepOAEa7oLotMFyOWRDPnzaEdrxu6s95xXZ16hhtkAAg1w5YKCrGNRRIwJW
         CP4UD/ZjSc22q+Bi7NYbfx0PfRAmjZC3lJmAMTXbC+P4RBwdW8jhoEFNQ+jWxoeoaj
         Ij4JFDvZu4GQPfexv6GGdltxDI/0rTESeD/kcuz31f2HhIAoFhONaNofRL1231TViB
         daefmqj/QA/rA==
Date:   Sun, 9 Oct 2022 12:58:56 +0100
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
Subject: Re: [PATCH v2 05/16] iio: adc: ltc2947-core: do not use internal
 iio_dev lock
Message-ID: <20221009125856.2768db05@jic23-huawei>
In-Reply-To: <20221004134909.1692021-6-nuno.sa@analog.com>
References: <20221004134909.1692021-1-nuno.sa@analog.com>
        <20221004134909.1692021-6-nuno.sa@analog.com>
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

On Tue, 4 Oct 2022 15:48:58 +0200
Nuno S=C3=A1 <nuno.sa@analog.com> wrote:

> The iio_device lock is only meant for internal use. Hence define a
> device local lock to protect against concurrent accesses.
>=20
> While at it, properly include "mutex.h" for mutex related APIs.
>=20
> Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
Applied

> ---
>  drivers/iio/adc/ltc2497-core.c | 7 +++++--
>  drivers/iio/adc/ltc2497.h      | 2 ++
>  2 files changed, 7 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ltc2497-core.c b/drivers/iio/adc/ltc2497-cor=
e.c
> index f52d37af4d1f..996f6cbbed3c 100644
> --- a/drivers/iio/adc/ltc2497-core.c
> +++ b/drivers/iio/adc/ltc2497-core.c
> @@ -10,6 +10,7 @@
>  #include <linux/iio/iio.h>
>  #include <linux/iio/driver.h>
>  #include <linux/module.h>
> +#include <linux/mutex.h>
>  #include <linux/regulator/consumer.h>
> =20
>  #include "ltc2497.h"
> @@ -81,9 +82,9 @@ static int ltc2497core_read_raw(struct iio_dev *indio_d=
ev,
> =20
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
> -		mutex_lock(&indio_dev->mlock);
> +		mutex_lock(&ddata->lock);
>  		ret =3D ltc2497core_read(ddata, chan->address, val);
> -		mutex_unlock(&indio_dev->mlock);
> +		mutex_unlock(&ddata->lock);
>  		if (ret < 0)
>  			return ret;
> =20
> @@ -214,6 +215,8 @@ int ltc2497core_probe(struct device *dev, struct iio_=
dev *indio_dev)
>  	ddata->addr_prev =3D LTC2497_CONFIG_DEFAULT;
>  	ddata->time_prev =3D ktime_get();
> =20
> +	mutex_init(&ddata->lock);
> +
>  	ret =3D iio_device_register(indio_dev);
>  	if (ret < 0)
>  		goto err_array_unregister;
> diff --git a/drivers/iio/adc/ltc2497.h b/drivers/iio/adc/ltc2497.h
> index e023de0d88c4..781519b52475 100644
> --- a/drivers/iio/adc/ltc2497.h
> +++ b/drivers/iio/adc/ltc2497.h
> @@ -12,6 +12,8 @@ struct ltc2497_chip_info {
>  struct ltc2497core_driverdata {
>  	struct regulator *ref;
>  	ktime_t	time_prev;
> +	/* lock to protect against multiple access to the device */
> +	struct mutex lock;
>  	const struct ltc2497_chip_info	*chip_info;
>  	u8 addr_prev;
>  	int (*result_and_measure)(struct ltc2497core_driverdata *ddata,

