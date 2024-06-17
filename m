Return-Path: <linux-iio+bounces-6402-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBFF890B5FF
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 18:14:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D0CC281AAA
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 16:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 723256AB8;
	Mon, 17 Jun 2024 16:14:02 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF951D9527;
	Mon, 17 Jun 2024 16:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718640842; cv=none; b=grDTeUDFQY1kcS3r0z6w8X6IFPWBgDfuFojYRjOHSEH17L8F2vWHQr+3zXI3R7Ehjv9JQaxECYuupvL4hXQncDDN8rLP+okIFU5zFZTYBpsgNCW1pY+JSi1DT8hKvT0ayBtoQoFibG557ytj3X0VAtXT9R7ff48OX3InbRb03m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718640842; c=relaxed/simple;
	bh=As6Uz3CijqcReAOtTSoGO8djlSjq+nTFvynGygBme20=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hSQA0sFBrHxPrES9EUahcF+QAmrQQy0Y6RejIe6VTLvLk3Fq5JiYH0NJG4bS5wAoSwE/Tof3yGAq1xOc0KkmUZbDBICgs4c2Qg89SGyGnMmJossyoWoLtarymXT+73usZ2Kxy8DwB2ULIR3IydVjtE8jCJ2GNkeA1Jb+ArSzSGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4W2vzZ4Ym4z67FbS;
	Tue, 18 Jun 2024 00:12:26 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id A93C6140A90;
	Tue, 18 Jun 2024 00:13:55 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 17 Jun
 2024 17:13:54 +0100
Date: Mon, 17 Jun 2024 17:13:53 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Trevor Gamblin <tgamblin@baylibre.com>
CC: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
	Dmitry Rokosov <ddrokosov@sberdevices.ru>, "Michael Hennerich"
	<Michael.Hennerich@analog.com>, Cosmin Tanislav <cosmin.tanislav@analog.com>,
	Chen-Yu Tsai <wens@csie.org>, Hans de Goede <hdegoede@redhat.com>, Ray Jui
	<rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Broadcom internal
 kernel review list <bcm-kernel-feedback-list@broadcom.com>, Shawn Guo
	<shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Neil
 Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>,
	"Jerome Brunet" <jbrunet@baylibre.com>, Martin Blumenstingl
	<martin.blumenstingl@googlemail.com>, Saravanan Sekar <sravanhome@gmail.com>,
	Orson Zhai <orsonzhai@gmail.com>, Baolin Wang
	<baolin.wang@linux.alibaba.com>, Chunyan Zhang <zhang.lyra@gmail.com>, Maxime
 Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue
	<alexandre.torgue@foss.st.com>, Nuno =?ISO-8859-1?Q?S=E1?=
	<nuno.sa@analog.com>, Linus Walleij <linus.walleij@linaro.org>, Jean-Baptiste
 Maneyrol <jmaneyrol@invensense.com>, Crt Mori <cmo@melexis.com>,
	<linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <imx@lists.linux.dev>,
	<linux-amlogic@lists.infradead.org>, <linux-arm-msm@vger.kernel.org>,
	<linux-stm32@st-md-mailman.stormreply.com>, Uwe =?ISO-8859-1?Q?Kleine-K=F6n?=
 =?ISO-8859-1?Q?ig?= <u.kleine-koenig@baylibre.com>
Subject: Re: [PATCH v3 22/41] iio: gyro: mpu3050-core: make use of
 regmap_clear_bits(), regmap_set_bits()
Message-ID: <20240617171353.00006b1f@Huawei.com>
In-Reply-To: <20240617-review-v3-22-88d1338c4cca@baylibre.com>
References: <20240617-review-v3-0-88d1338c4cca@baylibre.com>
	<20240617-review-v3-22-88d1338c4cca@baylibre.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 17 Jun 2024 09:50:02 -0400
Trevor Gamblin <tgamblin@baylibre.com> wrote:

> Instead of using regmap_update_bits() and passing the mask twice, use
> regmap_set_bits().
>=20
> Instead of using regmap_update_bits() and passing val =3D 0, use
> regmap_clear_bits().
>=20
> Suggested-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>
> Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
> ---
>  drivers/iio/gyro/mpu3050-core.c | 33 ++++++++++++---------------------
>  1 file changed, 12 insertions(+), 21 deletions(-)
>=20
> diff --git a/drivers/iio/gyro/mpu3050-core.c b/drivers/iio/gyro/mpu3050-c=
ore.c
> index a791ba3a693a..ff1c81553045 100644
> --- a/drivers/iio/gyro/mpu3050-core.c
> +++ b/drivers/iio/gyro/mpu3050-core.c
> @@ -197,8 +197,8 @@ static int mpu3050_start_sampling(struct mpu3050 *mpu=
3050)
>  	int i;
> =20
>  	/* Reset */
> -	ret =3D regmap_update_bits(mpu3050->map, MPU3050_PWR_MGM,
> -				 MPU3050_PWR_MGM_RESET, MPU3050_PWR_MGM_RESET);
> +	ret =3D regmap_set_bits(mpu3050->map, MPU3050_PWR_MGM,
> +			      MPU3050_PWR_MGM_RESET);
>  	if (ret)
>  		return ret;
> =20
> @@ -513,12 +513,8 @@ static irqreturn_t mpu3050_trigger_handler(int irq, =
void *p)
>  				 "FIFO overflow! Emptying and resetting FIFO\n");
>  			fifo_overflow =3D true;
>  			/* Reset and enable the FIFO */
> -			ret =3D regmap_update_bits(mpu3050->map,
> -						 MPU3050_USR_CTRL,
> -						 MPU3050_USR_CTRL_FIFO_EN |
> -						 MPU3050_USR_CTRL_FIFO_RST,
> -						 MPU3050_USR_CTRL_FIFO_EN |
> -						 MPU3050_USR_CTRL_FIFO_RST);
> +			ret =3D regmap_set_bits(mpu3050->map, MPU3050_USR_CTRL,
> +					      MPU3050_USR_CTRL_FIFO_EN | MPU3050_USR_CTRL_FIFO_RST);

I'll probably break this line up whilst applying.

>  			if (ret) {
>  				dev_info(mpu3050->dev, "error resetting FIFO\n");
>  				goto out_trigger_unlock;
> @@ -799,10 +795,8 @@ static int mpu3050_hw_init(struct mpu3050 *mpu3050)
>  	u64 otp;
> =20
>  	/* Reset */
> -	ret =3D regmap_update_bits(mpu3050->map,
> -				 MPU3050_PWR_MGM,
> -				 MPU3050_PWR_MGM_RESET,
> -				 MPU3050_PWR_MGM_RESET);
> +	ret =3D regmap_set_bits(mpu3050->map, MPU3050_PWR_MGM,
> +			      MPU3050_PWR_MGM_RESET);
>  	if (ret)
>  		return ret;
> =20
> @@ -872,8 +866,8 @@ static int mpu3050_power_up(struct mpu3050 *mpu3050)
>  	msleep(200);
> =20
>  	/* Take device out of sleep mode */
> -	ret =3D regmap_update_bits(mpu3050->map, MPU3050_PWR_MGM,
> -				 MPU3050_PWR_MGM_SLEEP, 0);
> +	ret =3D regmap_clear_bits(mpu3050->map, MPU3050_PWR_MGM,
> +				MPU3050_PWR_MGM_SLEEP);
>  	if (ret) {
>  		regulator_bulk_disable(ARRAY_SIZE(mpu3050->regs), mpu3050->regs);
>  		dev_err(mpu3050->dev, "error setting power mode\n");
> @@ -895,8 +889,8 @@ static int mpu3050_power_down(struct mpu3050 *mpu3050)
>  	 * then we would be wasting power unless we go to sleep mode
>  	 * first.
>  	 */
> -	ret =3D regmap_update_bits(mpu3050->map, MPU3050_PWR_MGM,
> -				 MPU3050_PWR_MGM_SLEEP, MPU3050_PWR_MGM_SLEEP);
> +	ret =3D regmap_set_bits(mpu3050->map, MPU3050_PWR_MGM,
> +			      MPU3050_PWR_MGM_SLEEP);
>  	if (ret)
>  		dev_err(mpu3050->dev, "error putting to sleep\n");
> =20
> @@ -997,11 +991,8 @@ static int mpu3050_drdy_trigger_set_state(struct iio=
_trigger *trig,
>  			return ret;
> =20
>  		/* Reset and enable the FIFO */
> -		ret =3D regmap_update_bits(mpu3050->map, MPU3050_USR_CTRL,
> -					 MPU3050_USR_CTRL_FIFO_EN |
> -					 MPU3050_USR_CTRL_FIFO_RST,
> -					 MPU3050_USR_CTRL_FIFO_EN |
> -					 MPU3050_USR_CTRL_FIFO_RST);
> +		ret =3D regmap_set_bits(mpu3050->map, MPU3050_USR_CTRL,
> +				      MPU3050_USR_CTRL_FIFO_EN | MPU3050_USR_CTRL_FIFO_RST);
and this one.

Assuming we don't need a v4 for some other reason,

Jonathan

>  		if (ret)
>  			return ret;
> =20
>=20


