Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 608845FCAE1
	for <lists+linux-iio@lfdr.de>; Wed, 12 Oct 2022 20:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbiJLSqN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 12 Oct 2022 14:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbiJLSqK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 12 Oct 2022 14:46:10 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBBC5C4D87
        for <linux-iio@vger.kernel.org>; Wed, 12 Oct 2022 11:46:06 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id C548760002;
        Wed, 12 Oct 2022 18:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1665600364;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vjroV19fBqrVrQU0CLeJKAqB9gBI/nfXkE660Q+OVoQ=;
        b=WYVkIYufTXY2i59Zs82duyRa6C4cpFF6jK4xzAXLthP2FSn8vweqjlValnPomLu6Em910/
        Fmay9vqO6+I9A+k4XDrbNhb15ys3bnk8Z5OfWXDAeZc8586HaDN9s3Vg/5KkBxRml/p8ov
        n9dzXpZHVsqWii4Mpo7192R8aN/A5fGB+gpkNQucFwNgXdUY0m1pBsaHT8AeNmaQiKWBRh
        dpUbGK9LfhI/3O9BM31a6G2QvLAh5HjuqPE1geV++DHDJr2QEJJb7FaRZgYFEqBOH8i55X
        2+pzbz5cwCJJqoGxfqUcD4h9cz7W6Jxw2eemwiGcasXMndNgevfwf4a/24ZQsA==
Date:   Wed, 12 Oct 2022 20:45:56 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Cc:     <linux-arm-kernel@lists.infradead.org>,
        <linux-iio@vger.kernel.org>, <linux-amlogic@lists.infradead.org>,
        <linux-rockchip@lists.infradead.org>, <linux-imx@nxp.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com>,
        Ciprian Regus <ciprian.regus@analog.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Cixi Geng <cixi.geng1@unisoc.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Heiko Stuebner <heiko@sntech.de>,
        Fabio Estevam <festevam@gmail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jyoti Bhayana <jbhayana@google.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Florian Boor <florian.boor@kernelconcepts.de>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH v3 3/4] iio: health: max30102: do not use internal
 iio_dev lock
Message-ID: <20221012204556.7648df2e@xps-13>
In-Reply-To: <20221012151620.1725215-4-nuno.sa@analog.com>
References: <20221012151620.1725215-1-nuno.sa@analog.com>
        <20221012151620.1725215-4-nuno.sa@analog.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Nuno,

nuno.sa@analog.com wrote on Wed, 12 Oct 2022 17:16:19 +0200:

> The pattern used in this device does not quite fit in the
> iio_device_claim_direct_mode() typical usage. In this case, we want to
> know if we are in buffered mode or not to know if the device is powered
> (buffer mode) or not. And depending on that max30102_get_temp() will
> power on the device if needed. Hence, in order to keep the same
> functionality, we try to:
>=20
> 1. Claim Buffered mode;
> 2: If 1) succeeds call max30102_get_temp() without powering on the
>    device;
> 3: Release Buffered mode;
> 4: If 1) fails, Claim Direct mode;
> 5: If 4) succeeds call max30102_get_temp() with powering on the device;
> 6: Release Direct mode;
> 7: If 4) fails, goto to 1) and try again.
>=20
> This dance between buffered and direct mode is not particularly pretty
> (as well as the loop introduced by the goto statement) but it does allow
> us to get rid of the mlock usage while keeping the same behavior.

What about adding a TODO comment saying something like: "this comes
from static analysis and helped dropping mlock access, but someone with
the device needs to figure out if we can simplify this dance"? Because
the reason behind all this is that we don't want to risk breaking the
driver, but perhaps a simpler approach would work, right?

>=20
> Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> ---
>  drivers/iio/health/max30102.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/iio/health/max30102.c
> b/drivers/iio/health/max30102.c index 437298a29f2d..66df4aaa31a7
> 100644 --- a/drivers/iio/health/max30102.c
> +++ b/drivers/iio/health/max30102.c
> @@ -477,12 +477,23 @@ static int max30102_read_raw(struct iio_dev
> *indio_dev,
>  		 * Temperature reading can only be acquired when not
> in
>  		 * shutdown; leave shutdown briefly when buffer not
> running */
> -		mutex_lock(&indio_dev->mlock);
> -		if (!iio_buffer_enabled(indio_dev))
> +any_mode_retry:
> +		if (iio_device_claim_buffer_mode(indio_dev)) {
> +			/*
> +			 * This one is a *bit* hacky. If we cannot
> claim buffer
> +			 * mode, then try direct mode so that we
> make sure
> +			 * things cannot concurrently change. And we
> just keep
> +			 * trying until we get one of the modes...
> +			 */
> +			if (iio_device_claim_direct_mode(indio_dev))
> +				goto any_mode_retry;
> +
>  			ret =3D max30102_get_temp(data, val, true);
> -		else
> +			iio_device_release_direct_mode(indio_dev);
> +		} else {
>  			ret =3D max30102_get_temp(data, val, false);
> -		mutex_unlock(&indio_dev->mlock);
> +			iio_device_release_buffer_mode(indio_dev);
> +		}
>  		if (ret)
>  			return ret;
> =20


Thanks,
Miqu=C3=A8l
