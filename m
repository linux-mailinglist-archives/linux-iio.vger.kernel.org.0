Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18AB85E8E0E
	for <lists+linux-iio@lfdr.de>; Sat, 24 Sep 2022 17:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233831AbiIXPh1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 24 Sep 2022 11:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiIXPh0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 24 Sep 2022 11:37:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48DBB62D9
        for <linux-iio@vger.kernel.org>; Sat, 24 Sep 2022 08:37:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F12E8B80942
        for <linux-iio@vger.kernel.org>; Sat, 24 Sep 2022 15:37:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D806C433B5;
        Sat, 24 Sep 2022 15:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664033842;
        bh=LJqi7hLURG62SF1LoG408xJ7v+7sH/SFRfwWeA9i4aI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=k+LoqzRYEcLCkYHXXj1GwxrHDcMQiE3pFk2kFeNL3FxTjjKD6uWA9CJk/k+O6FdFM
         xtSEFF1xhpvf+E9yGk+CDrY6lRyHi8AqV64aBXxgVMWFPretpSe4jWMbI8PCL9A5IY
         jsGq0orsAFm6sEO56XYQfvJ12OfQpYfXT3gmJvKkH0IH9DiqqfyzRZpJ5S+Z6wjIwi
         6NtkJ+gf+fCrAiYaz4O96eKda6KEVuesY3MNzUX7GRPKDwV/fbXpLhwh/n22d0NnRj
         00W3qhXghhJhDhvv4NG9Ky/ddY5BWFmXcBpr6S/ke5yj7BD06jffBnlWMbWWESj1fM
         vrKwsP0K1nySg==
Date:   Sat, 24 Sep 2022 16:37:24 +0100
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
Subject: Re: [PATCH 10/15] iio: adc: vf610_adc: do not use internal iio_dev
 lock
Message-ID: <20220924163724.41e0c504@jic23-huawei>
In-Reply-To: <20220920112821.975359-11-nuno.sa@analog.com>
References: <20220920112821.975359-1-nuno.sa@analog.com>
        <20220920112821.975359-11-nuno.sa@analog.com>
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

On Tue, 20 Sep 2022 13:28:16 +0200
Nuno S=C3=A1 <nuno.sa@analog.com> wrote:

> In order to drop the internal lock usage we needed two different things:
>=20
> 1) The first place where 'mlock' was being used was a typical case where
> iio_device_claim_direct_mode() fits perfectly.
> 2) In the second case, it was being used to prevent concurrent accesses
> to the device and shared data but nothing was being enforced with
> regards to buffering (i.e, there was nothing preventing from changing
> the conversion mode while buffering). Hence, in this case, a new lock
> was introduced in the state structure.
>=20
> Note that the goal is not to introduce any functional change and that is
> the reason why a new lock was introduced to guarantee 2).

Hmm. If we can get enough review on this, I'd rather claim_direct_mode()
for part 2 even though it is a functional change.  It's a bit tricky
as that function has no error paths currently so no real reason the=20
caller should be expecting errors (generic code will be fine, but generic
code doesn't know about this ABI element anyway).

A request for a refactor precursor patch in line.  It will make
the end result cleaner I think.


>=20
> Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> ---
>  drivers/iio/adc/vf610_adc.c | 30 +++++++++++++++++++-----------
>  1 file changed, 19 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/iio/adc/vf610_adc.c b/drivers/iio/adc/vf610_adc.c
> index c6b16cf6e367..b9addd313ef1 100644
> --- a/drivers/iio/adc/vf610_adc.c
> +++ b/drivers/iio/adc/vf610_adc.c
> @@ -7,6 +7,7 @@
> =20
>  #include <linux/mod_devicetable.h>
>  #include <linux/module.h>
> +#include <linux/mutex.h>
>  #include <linux/property.h>
>  #include <linux/platform_device.h>
>  #include <linux/interrupt.h>
> @@ -156,6 +157,9 @@ struct vf610_adc {
>  	void __iomem *regs;
>  	struct clk *clk;
> =20
> +	/* lock to protect against multiple access to the device */
> +	struct mutex lock;
> +
>  	u32 vref_uv;
>  	u32 value;
>  	struct regulator *vref;
> @@ -467,11 +471,11 @@ static int vf610_set_conversion_mode(struct iio_dev=
 *indio_dev,
>  {
>  	struct vf610_adc *info =3D iio_priv(indio_dev);
> =20
> -	mutex_lock(&indio_dev->mlock);
> +	mutex_lock(&info->lock);
>  	info->adc_feature.conv_mode =3D mode;
>  	vf610_adc_calculate_rates(info);
>  	vf610_adc_hw_init(info);
> -	mutex_unlock(&indio_dev->mlock);
> +	mutex_unlock(&info->lock);
> =20
>  	return 0;
>  }
> @@ -635,12 +639,11 @@ static int vf610_read_raw(struct iio_dev *indio_dev,
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
>  	case IIO_CHAN_INFO_PROCESSED:
> -		mutex_lock(&indio_dev->mlock);
> -		if (iio_buffer_enabled(indio_dev)) {
> -			mutex_unlock(&indio_dev->mlock);
> -			return -EBUSY;
> -		}
> +		ret =3D iio_device_claim_direct_mode(indio_dev);
> +		if (ret)
> +			return ret;
> =20
> +		mutex_lock(&info->lock);
>  		reinit_completion(&info->completion);
>  		hc_cfg =3D VF610_ADC_ADCHC(chan->channel);
>  		hc_cfg |=3D VF610_ADC_AIEN;
> @@ -648,11 +651,13 @@ static int vf610_read_raw(struct iio_dev *indio_dev,
>  		ret =3D wait_for_completion_interruptible_timeout
>  				(&info->completion, VF610_ADC_TIMEOUT);
>  		if (ret =3D=3D 0) {
> -			mutex_unlock(&indio_dev->mlock);
> +			mutex_unlock(&info->lock);

The error paths in here are complex. I'd pull the whole of the
case block out to a new function in a precursor patch and
then you can add the new locking with a goto unlock; pattern.

> +			iio_device_release_direct_mode(indio_dev);
>  			return -ETIMEDOUT;
>  		}
>  		if (ret < 0) {
> -			mutex_unlock(&indio_dev->mlock);
> +			mutex_unlock(&info->lock);
> +			iio_device_release_direct_mode(indio_dev);
>  			return ret;
>  		}
> =20
> @@ -671,11 +676,13 @@ static int vf610_read_raw(struct iio_dev *indio_dev,
> =20
>  			break;
>  		default:
> -			mutex_unlock(&indio_dev->mlock);
> +			mutex_unlock(&info->lock);
> +			iio_device_release_direct_mode(indio_dev);
>  			return -EINVAL;
>  		}
> =20
> -		mutex_unlock(&indio_dev->mlock);
> +		mutex_unlock(&info->lock);
> +		iio_device_release_direct_mode(indio_dev);
>  		return IIO_VAL_INT;
> =20
>  	case IIO_CHAN_INFO_SCALE:
> @@ -812,6 +819,7 @@ static int vf610_adc_probe(struct platform_device *pd=
ev)
> =20
>  	info =3D iio_priv(indio_dev);
>  	info->dev =3D &pdev->dev;
> +	mutex_init(&info->lock);
> =20
>  	info->regs =3D devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(info->regs))

