Return-Path: <linux-iio+bounces-844-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E9D80DAB5
	for <lists+linux-iio@lfdr.de>; Mon, 11 Dec 2023 20:16:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C113FB2136B
	for <lists+linux-iio@lfdr.de>; Mon, 11 Dec 2023 19:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0186D524D7;
	Mon, 11 Dec 2023 19:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L3H0f+rc"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2A951C37
	for <linux-iio@vger.kernel.org>; Mon, 11 Dec 2023 19:16:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D77BC433C8;
	Mon, 11 Dec 2023 19:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702322184;
	bh=PxPRPu/LBBXQCxl3dvG+bEG6O64hBCHWX3hld5icBEY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=L3H0f+rcR+W1EKlA6lHFXghagyuUDqWJMMQDLMy+u0Od4QmHUuQwK43nUvXeYbg94
	 iqfG6iUS7TsG0duZiZr+OAXpzZPhr0kiSCucdjAlXeYBasj6ghZU7dqWuLKqasi8uH
	 RIB2m7L3DXgQxpeY+0B3rJOPxnojr5xbO6cdqFgQhhu3ZTFzS5ZBeVLz30/fUyV+WS
	 Vox9Z/c1QdEkia8LZpSY0GvR24porpM9XG0PFxqsycAo73vPVQNjRbMzRxYOzckCQb
	 WtgUjjsn1w+/Pxedj/vw469RmTeSPj9Mdt0J6wILU8sq3J4uNZrX9XzdxWrb2fO2H4
	 BFvZVGkB671uQ==
Date: Mon, 11 Dec 2023 19:16:18 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org, Michael Hennerich
 <Michael.Hennerich@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, David
 Lechner  <dlechner@baylibre.com>
Subject: Re: [PATCH v2 8/8] iio: adc: adi-axi-adc: convert to regmap
Message-ID: <20231211191618.686595e2@jic23-huawei>
In-Reply-To: <3c6d49a05b1bd0e6a2777c9e4ed3f7121ad9ab0f.camel@gmail.com>
References: <20231207-iio-backend-prep-v2-0-a4a33bc4d70e@analog.com>
	<20231207-iio-backend-prep-v2-8-a4a33bc4d70e@analog.com>
	<3c6d49a05b1bd0e6a2777c9e4ed3f7121ad9ab0f.camel@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 11 Dec 2023 14:18:43 +0100
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Thu, 2023-12-07 at 13:39 +0100, Nuno Sa via B4 Relay wrote:
> > From: Nuno Sa <nuno.sa@analog.com>
> >=20
> > Use MMIO regmap interface. It makes things easier for manipulating bits.
> >=20
> > Reviewed-by: David Lechner <dlechner@baylibre.com>
> > Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> > ---
> > =C2=A0drivers/iio/adc/adi-axi-adc.c | 85 ++++++++++++++++++++++++++----=
------------
> > -
> > =C2=A01 file changed, 52 insertions(+), 33 deletions(-)
> >=20
> > diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-ad=
c.c
> > index ae83ada7f9f2..c247ff1541d2 100644
> > --- a/drivers/iio/adc/adi-axi-adc.c
> > +++ b/drivers/iio/adc/adi-axi-adc.c
> > @@ -14,6 +14,7 @@
> > =C2=A0#include <linux/of.h>
> > =C2=A0#include <linux/platform_device.h>
> > =C2=A0#include <linux/property.h>
> > +#include <linux/regmap.h>
> > =C2=A0#include <linux/slab.h>
> > =C2=A0
> > =C2=A0#include <linux/iio/iio.h>
> > @@ -62,7 +63,7 @@ struct adi_axi_adc_state {
> > =C2=A0	struct mutex				lock;
> > =C2=A0
> > =C2=A0	struct adi_axi_adc_client		*client;
> > -	void __iomem				*regs;
> > +	struct regmap				*regmap;
> > =C2=A0};
> > =C2=A0
> > =C2=A0struct adi_axi_adc_client {
> > @@ -90,19 +91,6 @@ void *adi_axi_adc_conv_priv(struct adi_axi_adc_conv =
*conv)
> > =C2=A0}
> > =C2=A0EXPORT_SYMBOL_NS_GPL(adi_axi_adc_conv_priv, IIO_ADI_AXI);
> > =C2=A0
> > -static void adi_axi_adc_write(struct adi_axi_adc_state *st,
> > -			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int reg,
> > -			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int val)
> > -{
> > -	iowrite32(val, st->regs + reg);
> > -}
> > -
> > -static unsigned int adi_axi_adc_read(struct adi_axi_adc_state *st,
> > -				=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int reg)
> > -{
> > -	return ioread32(st->regs + reg);
> > -}
> > -
> > =C2=A0static int adi_axi_adc_config_dma_buffer(struct device *dev,
> > =C2=A0					 struct iio_dev *indio_dev)
> > =C2=A0{
> > @@ -163,17 +151,20 @@ static int adi_axi_adc_update_scan_mode(struct ii=
o_dev
> > *indio_dev,
> > =C2=A0{
> > =C2=A0	struct adi_axi_adc_state *st =3D iio_priv(indio_dev);
> > =C2=A0	struct adi_axi_adc_conv *conv =3D &st->client->conv;
> > -	unsigned int i, ctrl;
> > +	unsigned int i;
> > +	int ret;
> > =C2=A0
> > =C2=A0	for (i =3D 0; i < conv->chip_info->num_channels; i++) {
> > -		ctrl =3D adi_axi_adc_read(st, ADI_AXI_REG_CHAN_CTRL(i));
> > -
> > =C2=A0		if (test_bit(i, scan_mask))
> > -			ctrl |=3D ADI_AXI_REG_CHAN_CTRL_ENABLE;
> > +			ret =3D regmap_set_bits(st->regmap,
> > +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ADI_AXI_REG_CHAN_CTRL(i),
> > +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ADI_AXI_REG_CHAN_CTRL_ENABLE);
> > =C2=A0		else
> > -			ctrl &=3D ~ADI_AXI_REG_CHAN_CTRL_ENABLE;
> > -
> > -		adi_axi_adc_write(st, ADI_AXI_REG_CHAN_CTRL(i), ctrl);
> > +			ret =3D regmap_clear_bits(st->regmap,
> > +						ADI_AXI_REG_CHAN_CTRL(i),
> > +						ADI_AXI_REG_CHAN_CTRL_ENABLE)
> > ;
> > +		if (ret)
> > +			return ret;
> > =C2=A0	}
> > =C2=A0
> > =C2=A0	return 0;
> > @@ -310,21 +301,32 @@ static int adi_axi_adc_setup_channels(struct devi=
ce
> > *dev,
> > =C2=A0	}
> > =C2=A0
> > =C2=A0	for (i =3D 0; i < conv->chip_info->num_channels; i++) {
> > -		adi_axi_adc_write(st, ADI_AXI_REG_CHAN_CTRL(i),
> > -				=C2=A0 ADI_AXI_REG_CHAN_CTRL_DEFAULTS);
> > +		ret =3D regmap_write(st->regmap, ADI_AXI_REG_CHAN_CTRL(i),
> > +				=C2=A0=C2=A0 ADI_AXI_REG_CHAN_CTRL_DEFAULTS);
> > +		if (ret)
> > +			return ret;
> > =C2=A0	}
> > =C2=A0
> > =C2=A0	return 0;
> > =C2=A0}
> > =C2=A0
> > -static void axi_adc_reset(struct adi_axi_adc_state *st)
> > +static int axi_adc_reset(struct adi_axi_adc_state *st)
> > =C2=A0{
> > -	adi_axi_adc_write(st, ADI_AXI_REG_RSTN, 0);
> > +	int ret;
> > +
> > +	ret =3D regmap_write(st->regmap, ADI_AXI_REG_RSTN, 0);
> > +	if (ret)
> > +		return ret;
> > +
> > =C2=A0	mdelay(10);
> > -	adi_axi_adc_write(st, ADI_AXI_REG_RSTN, ADI_AXI_REG_RSTN_MMCM_RSTN);
> > +	ret =3D regmap_write(st->regmap, ADI_AXI_REG_RSTN,
> > +			=C2=A0=C2=A0 ADI_AXI_REG_RSTN_MMCM_RSTN);
> > +	if (ret)
> > +		return ret;
> > +
> > =C2=A0	mdelay(10);
> > -	adi_axi_adc_write(st, ADI_AXI_REG_RSTN,
> > -			=C2=A0 ADI_AXI_REG_RSTN_RSTN |
> > ADI_AXI_REG_RSTN_MMCM_RSTN);
> > +	return regmap_write(st->regmap, ADI_AXI_REG_RSTN,
> > +			=C2=A0=C2=A0=C2=A0 ADI_AXI_REG_RSTN_RSTN |
> > ADI_AXI_REG_RSTN_MMCM_RSTN);
> > =C2=A0}
> > =C2=A0
> > =C2=A0static void adi_axi_adc_cleanup(void *data)
> > @@ -335,12 +337,20 @@ static void adi_axi_adc_cleanup(void *data)
> > =C2=A0	module_put(cl->dev->driver->owner);
> > =C2=A0}
> > =C2=A0
> > +static const struct regmap_config axi_adc_regmap_config =3D {
> > +	.val_bits =3D 32,
> > +	.reg_bits =3D 32,
> > +	.reg_stride =3D 4,
> > +	.max_register =3D 0x0800,
> > +};
> > +
> > =C2=A0static int adi_axi_adc_probe(struct platform_device *pdev)
> > =C2=A0{
> > =C2=A0	struct adi_axi_adc_conv *conv;
> > =C2=A0	struct iio_dev *indio_dev;
> > =C2=A0	struct adi_axi_adc_client *cl;
> > =C2=A0	struct adi_axi_adc_state *st;
> > +	void __iomem *base;
> > =C2=A0	unsigned int ver;
> > =C2=A0	int ret;
> > =C2=A0
> > @@ -361,15 +371,24 @@ static int adi_axi_adc_probe(struct platform_devi=
ce
> > *pdev)
> > =C2=A0	cl->state =3D st;
> > =C2=A0	mutex_init(&st->lock);
> > =C2=A0
> > -	st->regs =3D devm_platform_ioremap_resource(pdev, 0);
> > -	if (IS_ERR(st->regs))
> > -		return PTR_ERR(st->regs);
> > +	base =3D devm_platform_ioremap_resource(pdev, 0);
> > +	if (IS_ERR(base))
> > +		return PTR_ERR(base);
> > +
> > +	st->regmap =3D devm_regmap_init_mmio(&pdev->dev, base,
> > +					=C2=A0=C2=A0 &axi_adc_regmap_config);
> > +	if (IS_ERR(st->regmap))
> > +		return PTR_ERR(st->regmap);
> > =C2=A0
> > =C2=A0	conv =3D &st->client->conv;
> > =C2=A0
> > -	axi_adc_reset(st);
> > +	ret =3D axi_adc_reset(st);
> > +	if (ret)
> > +		return ret;
> > =C2=A0
> > -	ver =3D adi_axi_adc_read(st, ADI_AXI_REG_VERSION);
> > +	ret =3D regmap_read(st->regmap, ADI_AXI_REG_VERSION, &ver);
> > +	if (ret)
> > +		return ret;
> > =C2=A0
> > =C2=A0	if (cl->info->version > ver) {
> > =C2=A0		dev_err(&pdev->dev,
> >  =20
>=20
> Hi Jonathan,
>=20
> I'm not seeing this series yet applied in the togreg branch so maybe I'm =
still
> on time. This patch is missing the proper Kconfig change:

>=20
>=20
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index af56df63beff..10e0e340cdae 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -292,7 +292,7 @@ config ADI_AXI_ADC
>         select IIO_BUFFER
>         select IIO_BUFFER_HW_CONSUMER
>         select IIO_BUFFER_DMAENGINE
> -       depends on HAS_IOMEM
> +       select REGMAP_MMIO
>         depends on OF
>         help
>           Say yes here to build support for Analog Devices Generic
>=20
>=20
> Just realized this when working on the v3 for IIO backends. Please let me=
 know
> if I should send a follow up patch or if I can still send a v3 on the
> "iio: ad9467 and axi-adc cleanups" series.
Oops. I forgot to push out yesterday.  Anyhow, would still have been fine t=
o fix
this as always about a week before I push out as togreg unless we are near
the merge window.

Fixed up.
Jonathan

>=20
> - Nuno S=C3=A1


