Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44C805BE5A4
	for <lists+linux-iio@lfdr.de>; Tue, 20 Sep 2022 14:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbiITMXl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 20 Sep 2022 08:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbiITMX2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 20 Sep 2022 08:23:28 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DA8D74E3B
        for <linux-iio@vger.kernel.org>; Tue, 20 Sep 2022 05:23:26 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id BBBD7E0002;
        Tue, 20 Sep 2022 12:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1663676604;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Vz0KRHaaPiDEBjGr8/ckv9ogXsBMrTGfzxP3dzkZwIw=;
        b=LwPPtConsnc+c5dCJx2IhS0s2fHBrs/wIoKWabd9XGCni0bxCopV79zkpczxbhx9JY/mB2
        fiHYVJetjuADN9fFGdfKXVpr6rekzURcobAkPu69cDLNwpRGwqLjyX0s8EYIaBv0lL0lzo
        y/MuRzTr7FEfBo0R/pHwtAA1cSTXbCHX2IIMDPzecsg4Lv3pCDyqIRzNOLoiavhS0NyTeJ
        lkK3hCRipD6dsNiGH5w+Mfa1Oeodk0lizfsyZSpAliWYlqZDE7jMlwNeaUICkTFJTzqy7v
        WBH0xZHWfBZMHj4xB+2yPzqwC6wLICVVh+oRpEwM84rgDNkRbDOR17qr3G6F2g==
Date:   Tue, 20 Sep 2022 14:23:19 +0200
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
Subject: Re: [PATCH 13/15] iio: health: max30100: do not use internal
 iio_dev lock
Message-ID: <20220920142319.61557023@xps-13>
In-Reply-To: <20220920112821.975359-14-nuno.sa@analog.com>
References: <20220920112821.975359-1-nuno.sa@analog.com>
        <20220920112821.975359-14-nuno.sa@analog.com>
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

nuno.sa@analog.com wrote on Tue, 20 Sep 2022 13:28:19 +0200:

> The pattern used in this device does not quite fit in the
> iio_device_claim_direct_mode() typical usage. In this case,
> iio_buffer_enabled() was being used not to prevent the raw access but to
> allow it. Hence to get rid of the 'mlock' we need to:
>=20
> 1. Use iio_device_claim_direct_mode() to check if direct mode can be
> claimed and if we can return -EINVAL (as the original code);
>
> 2. Make sure that buffering is not disabled while doing a raw read. For
> that, we can make use of the local lock that already exists.
>=20
> While at it, fixed a minor coding style complain...
>=20
> Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> ---
>  drivers/iio/health/max30100.c | 24 +++++++++++++++++-------
>  1 file changed, 17 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/iio/health/max30100.c b/drivers/iio/health/max30100.c
> index ad5717965223..aa494cad5df0 100644
> --- a/drivers/iio/health/max30100.c
> +++ b/drivers/iio/health/max30100.c
> @@ -185,8 +185,19 @@ static int max30100_buffer_postenable(struct iio_dev=
 *indio_dev)
>  static int max30100_buffer_predisable(struct iio_dev *indio_dev)
>  {
>  	struct max30100_data *data =3D iio_priv(indio_dev);
> +	int ret;
> +
> +	/*
> +	 * As stated in the comment in the read_raw() function, temperature
> +	 * can only be acquired if the engine is running. As such the mutex
> +	 * is used to make sure we do not power down while doing a temperature
> +	 * reading.
> +	 */
> +	mutex_lock(&data->lock);
> +	ret =3D max30100_set_powermode(data, false);
> +	mutex_unlock(&data->lock);
> =20
> -	return max30100_set_powermode(data, false);
> +	return ret;
>  }
> =20
>  static const struct iio_buffer_setup_ops max30100_buffer_setup_ops =3D {
> @@ -387,18 +398,17 @@ static int max30100_read_raw(struct iio_dev *indio_=
dev,
>  		 * Temperature reading can only be acquired while engine
>  		 * is running
>  		 */
> -		mutex_lock(&indio_dev->mlock);
> -
> -		if (!iio_buffer_enabled(indio_dev))
> +		if (!iio_device_claim_direct_mode(indio_dev)) {

I wonder if this line change here is really needed. I agree the whole
construction looks like what iio_device_claim_direct_mode() does but in
practice I don't see the point of acquiring any lock here if we just
release it no matter what happens right after.

Unless of course if there is a hidden goal like "stop exporting
iio_buffer_enabled()" or something like that.

At least I would separate this from the main change which targets the
removal of mlock because I don't see how it is directly related.

>  			ret =3D -EAGAIN;
> -		else {
> +			iio_device_release_direct_mode(indio_dev);
> +		} else {
> +			mutex_lock(&data->lock);
>  			ret =3D max30100_get_temp(data, val);
>  			if (!ret)
>  				ret =3D IIO_VAL_INT;
> -
> +			mutex_unlock(&data->lock);
>  		}
> =20
> -		mutex_unlock(&indio_dev->mlock);
>  		break;
>  	case IIO_CHAN_INFO_SCALE:
>  		*val =3D 1;  /* 0.0625 */

In any case, nice series, thanks for writing it!

Thanks,
Miqu=C3=A8l
