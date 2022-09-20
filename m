Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B27165BE502
	for <lists+linux-iio@lfdr.de>; Tue, 20 Sep 2022 13:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbiITLyk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 20 Sep 2022 07:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbiITLyi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 20 Sep 2022 07:54:38 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18020E63
        for <linux-iio@vger.kernel.org>; Tue, 20 Sep 2022 04:54:32 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 5C20940008;
        Tue, 20 Sep 2022 11:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1663674871;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KSWeYDSeaNehrW42i+XUhWc85tvVrOVAkEEt46DeViM=;
        b=a9Ssla+1spKJ6l7OVaPulJN3hTbI/jtsww5lV2x078/vloTj4E7q0ZvAJTzboMquYaFrOL
        OFasJ54otRKtPTuvJ1zt5mXCO/6PccV8VIpuuUn2hbkw2fSWJhSjEQHFkmqwiOiukzfxvI
        N/Ca4xZXa6fr97ju7+aBYdOej+u0/MpSpOLlK2sy7aHGVmHm0xv79PR/3dt+8XQfgnLk3M
        eoqu2tqf31B7HuEhlBizJNOQWX0+uPF4p5VicrH6Drcz+IK21JM723YJ9XVExul9OIKh0c
        /2+UkecXyMO9Z2k/93nniOv0UA6ksx/2GlCRPtzCGFSIkJMizk9hhgeLTLm3Fg==
Date:   Tue, 20 Sep 2022 13:54:10 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
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
        Jerome Brunet <jbrunet@baylibre.com>,
        "Heiko Stuebner" <heiko@sntech.de>,
        Florian Boor <florian.boor@kernelconcepts.de>,
        Ciprian Regus <ciprian.regus@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Jonathan Cameron" <jic23@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        "Baolin Wang" <baolin.wang@linux.alibaba.com>,
        Jyoti Bhayana <jbhayana@google.com>,
        Chen-Yu Tsai <wens@csie.org>, Orson Zhai <orsonzhai@gmail.com>
Subject: Re: [PATCH 01/15] iio: adc: ad_sigma_delta: do not use internal
 iio_dev lock
Message-ID: <20220920135410.4429694c@xps-13>
In-Reply-To: <20220920112821.975359-2-nuno.sa@analog.com>
References: <20220920112821.975359-1-nuno.sa@analog.com>
        <20220920112821.975359-2-nuno.sa@analog.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Nuno,

nuno.sa@analog.com wrote on Tue, 20 Sep 2022 13:28:07 +0200:

> Drop 'mlock' usage by making use of iio_device_claim_direct_mode().
> This change actually makes sure we cannot do a single conversion while
> buffering is enable. Note there was a potential race in the previous
> code since we were only acquiring the lock after checking if the bus is
> enabled.
>=20
> Fixes: af3008485ea0 ("iio:adc: Add common code for ADI Sigma Deltadevices=
")

To answer your question in the cover letter, I feel like this Fixes:
tag is deserved.

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

> Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> ---
>  drivers/iio/adc/ad_sigma_delta.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_=
delta.c
> index 261a9a6b45e1..d8570f620785 100644
> --- a/drivers/iio/adc/ad_sigma_delta.c
> +++ b/drivers/iio/adc/ad_sigma_delta.c
> @@ -281,10 +281,10 @@ int ad_sigma_delta_single_conversion(struct iio_dev=
 *indio_dev,
>  	unsigned int data_reg;
>  	int ret =3D 0;
> =20
> -	if (iio_buffer_enabled(indio_dev))
> -		return -EBUSY;
> +	ret =3D iio_device_claim_direct_mode(indio_dev);
> +	if (ret)
> +		return ret;
> =20
> -	mutex_lock(&indio_dev->mlock);
>  	ad_sigma_delta_set_channel(sigma_delta, chan->address);
> =20
>  	spi_bus_lock(sigma_delta->spi->master);
> @@ -323,7 +323,7 @@ int ad_sigma_delta_single_conversion(struct iio_dev *=
indio_dev,
>  	ad_sigma_delta_set_mode(sigma_delta, AD_SD_MODE_IDLE);
>  	sigma_delta->bus_locked =3D false;
>  	spi_bus_unlock(sigma_delta->spi->master);
> -	mutex_unlock(&indio_dev->mlock);
> +	iio_device_release_direct_mode(indio_dev);
> =20
>  	if (ret)
>  		return ret;


Thanks,
Miqu=C3=A8l
