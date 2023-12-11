Return-Path: <linux-iio+bounces-821-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F405C80CA9B
	for <lists+linux-iio@lfdr.de>; Mon, 11 Dec 2023 14:15:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FBF01F21083
	for <lists+linux-iio@lfdr.de>; Mon, 11 Dec 2023 13:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 224893D971;
	Mon, 11 Dec 2023 13:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KJHpYZ4B"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC42D8
	for <linux-iio@vger.kernel.org>; Mon, 11 Dec 2023 05:15:42 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40c2308faedso46662065e9.1
        for <linux-iio@vger.kernel.org>; Mon, 11 Dec 2023 05:15:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702300540; x=1702905340; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=flTHmU3eRrYoI/8c0qLvz6fSbAbYN/B/u0kyyBOMAiA=;
        b=KJHpYZ4BSaj54IzB3Nap7dhGJQtUH/tZ8lNBTmzmu56cyG2imtKB/8J3ZJxHYC/Nhc
         ix2IEibxnUhkXIbCPjHis1d6D/732+I8Y8EEE+lnRlHiQDcfdSJqESTKzbvd3eppezYn
         eS6fs3x4XhX0TciZJNk8OUDy144Htntw/IqVCRsK7ot0/QXdhnI+qgByiCz7/hPBE5IF
         OzBQOAZPVpBGceDXzR23XIpbHxW9QrOxyKngy3EI8xPyfXhKAonqIC8tFKGb24LS3UY9
         v9VGAuwJ9P4QkfSDXeMVFzu71XByCD4vOLwRwZcllmaXqRkp77+U9t40lljwjAiKzPyt
         +/Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702300540; x=1702905340;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=flTHmU3eRrYoI/8c0qLvz6fSbAbYN/B/u0kyyBOMAiA=;
        b=BE5h3BiT/w2BAjLhOczqIqvWKQPQHWM7zTBvcvuq5WL8wQckE8B09nvk4DQhWHeIKL
         jhouEUqbai2yhQJfEz1Oq/i/giDPibuVwubXoR7Tn5/C6IvjNc6ZM5KbmVmbVaveZvHQ
         J+J2EZQo21ozF+zWAjCMmXHodpZAzGHHrQ8OHIZaUn/eIPUDmWg+Xn44hGJ/dyvOtgBx
         Wp0Ns+JXqQXGMDkC6SoootBJAGmCGNW/rjRGLHfIqk2VnRzpyZykbe0iaCYlSfrdf4QZ
         Zfc63+o8mLyKU8KCAIaY6NCrRLt86kN1CJW/vYbsaBRZz5UDhnZJX1+0iy8BZXv4T9Rs
         Yhxw==
X-Gm-Message-State: AOJu0YyWprka2rKLC7Qc/1hRaGtoQEDzfXUbpc7G83Ow0L5+EqGQbLr/
	DDuJ9bRaQcMMJUhhVusNlm3btaJ7HVoHMNfJ
X-Google-Smtp-Source: AGHT+IHo5fkeMfUz5+bT4NekFRXZQGQ1HWtuIfOmU/w1zAussTRhMZCY3nyF9R2/Wj2K5oDhmYKFTg==
X-Received: by 2002:a1c:7417:0:b0:40b:5e21:d343 with SMTP id p23-20020a1c7417000000b0040b5e21d343mr2305216wmc.76.1702300540307;
        Mon, 11 Dec 2023 05:15:40 -0800 (PST)
Received: from ?IPv6:2003:f6:ef1b:2000:15d4:fc17:481e:8afe? (p200300f6ef1b200015d4fc17481e8afe.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:15d4:fc17:481e:8afe])
        by smtp.gmail.com with ESMTPSA id m27-20020a05600c3b1b00b0040b38292253sm15221295wms.30.2023.12.11.05.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 05:15:40 -0800 (PST)
Message-ID: <3c6d49a05b1bd0e6a2777c9e4ed3f7121ad9ab0f.camel@gmail.com>
Subject: Re: [PATCH v2 8/8] iio: adc: adi-axi-adc: convert to regmap
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: nuno.sa@analog.com, linux-iio@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron
	 <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, David Lechner
	 <dlechner@baylibre.com>
Date: Mon, 11 Dec 2023 14:18:43 +0100
In-Reply-To: <20231207-iio-backend-prep-v2-8-a4a33bc4d70e@analog.com>
References: <20231207-iio-backend-prep-v2-0-a4a33bc4d70e@analog.com>
	 <20231207-iio-backend-prep-v2-8-a4a33bc4d70e@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2023-12-07 at 13:39 +0100, Nuno Sa via B4 Relay wrote:
> From: Nuno Sa <nuno.sa@analog.com>
>=20
> Use MMIO regmap interface. It makes things easier for manipulating bits.
>=20
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> ---
> =C2=A0drivers/iio/adc/adi-axi-adc.c | 85 ++++++++++++++++++++++++++------=
----------
> -
> =C2=A01 file changed, 52 insertions(+), 33 deletions(-)
>=20
> diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.=
c
> index ae83ada7f9f2..c247ff1541d2 100644
> --- a/drivers/iio/adc/adi-axi-adc.c
> +++ b/drivers/iio/adc/adi-axi-adc.c
> @@ -14,6 +14,7 @@
> =C2=A0#include <linux/of.h>
> =C2=A0#include <linux/platform_device.h>
> =C2=A0#include <linux/property.h>
> +#include <linux/regmap.h>
> =C2=A0#include <linux/slab.h>
> =C2=A0
> =C2=A0#include <linux/iio/iio.h>
> @@ -62,7 +63,7 @@ struct adi_axi_adc_state {
> =C2=A0	struct mutex				lock;
> =C2=A0
> =C2=A0	struct adi_axi_adc_client		*client;
> -	void __iomem				*regs;
> +	struct regmap				*regmap;
> =C2=A0};
> =C2=A0
> =C2=A0struct adi_axi_adc_client {
> @@ -90,19 +91,6 @@ void *adi_axi_adc_conv_priv(struct adi_axi_adc_conv *c=
onv)
> =C2=A0}
> =C2=A0EXPORT_SYMBOL_NS_GPL(adi_axi_adc_conv_priv, IIO_ADI_AXI);
> =C2=A0
> -static void adi_axi_adc_write(struct adi_axi_adc_state *st,
> -			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int reg,
> -			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int val)
> -{
> -	iowrite32(val, st->regs + reg);
> -}
> -
> -static unsigned int adi_axi_adc_read(struct adi_axi_adc_state *st,
> -				=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int reg)
> -{
> -	return ioread32(st->regs + reg);
> -}
> -
> =C2=A0static int adi_axi_adc_config_dma_buffer(struct device *dev,
> =C2=A0					 struct iio_dev *indio_dev)
> =C2=A0{
> @@ -163,17 +151,20 @@ static int adi_axi_adc_update_scan_mode(struct iio_=
dev
> *indio_dev,
> =C2=A0{
> =C2=A0	struct adi_axi_adc_state *st =3D iio_priv(indio_dev);
> =C2=A0	struct adi_axi_adc_conv *conv =3D &st->client->conv;
> -	unsigned int i, ctrl;
> +	unsigned int i;
> +	int ret;
> =C2=A0
> =C2=A0	for (i =3D 0; i < conv->chip_info->num_channels; i++) {
> -		ctrl =3D adi_axi_adc_read(st, ADI_AXI_REG_CHAN_CTRL(i));
> -
> =C2=A0		if (test_bit(i, scan_mask))
> -			ctrl |=3D ADI_AXI_REG_CHAN_CTRL_ENABLE;
> +			ret =3D regmap_set_bits(st->regmap,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ADI_AXI_REG_CHAN_CTRL(i),
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ADI_AXI_REG_CHAN_CTRL_ENABLE);
> =C2=A0		else
> -			ctrl &=3D ~ADI_AXI_REG_CHAN_CTRL_ENABLE;
> -
> -		adi_axi_adc_write(st, ADI_AXI_REG_CHAN_CTRL(i), ctrl);
> +			ret =3D regmap_clear_bits(st->regmap,
> +						ADI_AXI_REG_CHAN_CTRL(i),
> +						ADI_AXI_REG_CHAN_CTRL_ENABLE)
> ;
> +		if (ret)
> +			return ret;
> =C2=A0	}
> =C2=A0
> =C2=A0	return 0;
> @@ -310,21 +301,32 @@ static int adi_axi_adc_setup_channels(struct device
> *dev,
> =C2=A0	}
> =C2=A0
> =C2=A0	for (i =3D 0; i < conv->chip_info->num_channels; i++) {
> -		adi_axi_adc_write(st, ADI_AXI_REG_CHAN_CTRL(i),
> -				=C2=A0 ADI_AXI_REG_CHAN_CTRL_DEFAULTS);
> +		ret =3D regmap_write(st->regmap, ADI_AXI_REG_CHAN_CTRL(i),
> +				=C2=A0=C2=A0 ADI_AXI_REG_CHAN_CTRL_DEFAULTS);
> +		if (ret)
> +			return ret;
> =C2=A0	}
> =C2=A0
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0
> -static void axi_adc_reset(struct adi_axi_adc_state *st)
> +static int axi_adc_reset(struct adi_axi_adc_state *st)
> =C2=A0{
> -	adi_axi_adc_write(st, ADI_AXI_REG_RSTN, 0);
> +	int ret;
> +
> +	ret =3D regmap_write(st->regmap, ADI_AXI_REG_RSTN, 0);
> +	if (ret)
> +		return ret;
> +
> =C2=A0	mdelay(10);
> -	adi_axi_adc_write(st, ADI_AXI_REG_RSTN, ADI_AXI_REG_RSTN_MMCM_RSTN);
> +	ret =3D regmap_write(st->regmap, ADI_AXI_REG_RSTN,
> +			=C2=A0=C2=A0 ADI_AXI_REG_RSTN_MMCM_RSTN);
> +	if (ret)
> +		return ret;
> +
> =C2=A0	mdelay(10);
> -	adi_axi_adc_write(st, ADI_AXI_REG_RSTN,
> -			=C2=A0 ADI_AXI_REG_RSTN_RSTN |
> ADI_AXI_REG_RSTN_MMCM_RSTN);
> +	return regmap_write(st->regmap, ADI_AXI_REG_RSTN,
> +			=C2=A0=C2=A0=C2=A0 ADI_AXI_REG_RSTN_RSTN |
> ADI_AXI_REG_RSTN_MMCM_RSTN);
> =C2=A0}
> =C2=A0
> =C2=A0static void adi_axi_adc_cleanup(void *data)
> @@ -335,12 +337,20 @@ static void adi_axi_adc_cleanup(void *data)
> =C2=A0	module_put(cl->dev->driver->owner);
> =C2=A0}
> =C2=A0
> +static const struct regmap_config axi_adc_regmap_config =3D {
> +	.val_bits =3D 32,
> +	.reg_bits =3D 32,
> +	.reg_stride =3D 4,
> +	.max_register =3D 0x0800,
> +};
> +
> =C2=A0static int adi_axi_adc_probe(struct platform_device *pdev)
> =C2=A0{
> =C2=A0	struct adi_axi_adc_conv *conv;
> =C2=A0	struct iio_dev *indio_dev;
> =C2=A0	struct adi_axi_adc_client *cl;
> =C2=A0	struct adi_axi_adc_state *st;
> +	void __iomem *base;
> =C2=A0	unsigned int ver;
> =C2=A0	int ret;
> =C2=A0
> @@ -361,15 +371,24 @@ static int adi_axi_adc_probe(struct platform_device
> *pdev)
> =C2=A0	cl->state =3D st;
> =C2=A0	mutex_init(&st->lock);
> =C2=A0
> -	st->regs =3D devm_platform_ioremap_resource(pdev, 0);
> -	if (IS_ERR(st->regs))
> -		return PTR_ERR(st->regs);
> +	base =3D devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
> +	st->regmap =3D devm_regmap_init_mmio(&pdev->dev, base,
> +					=C2=A0=C2=A0 &axi_adc_regmap_config);
> +	if (IS_ERR(st->regmap))
> +		return PTR_ERR(st->regmap);
> =C2=A0
> =C2=A0	conv =3D &st->client->conv;
> =C2=A0
> -	axi_adc_reset(st);
> +	ret =3D axi_adc_reset(st);
> +	if (ret)
> +		return ret;
> =C2=A0
> -	ver =3D adi_axi_adc_read(st, ADI_AXI_REG_VERSION);
> +	ret =3D regmap_read(st->regmap, ADI_AXI_REG_VERSION, &ver);
> +	if (ret)
> +		return ret;
> =C2=A0
> =C2=A0	if (cl->info->version > ver) {
> =C2=A0		dev_err(&pdev->dev,
>=20

Hi Jonathan,

I'm not seeing this series yet applied in the togreg branch so maybe I'm st=
ill
on time. This patch is missing the proper Kconfig change:


diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index af56df63beff..10e0e340cdae 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -292,7 +292,7 @@ config ADI_AXI_ADC
        select IIO_BUFFER
        select IIO_BUFFER_HW_CONSUMER
        select IIO_BUFFER_DMAENGINE
-       depends on HAS_IOMEM
+       select REGMAP_MMIO
        depends on OF
        help
          Say yes here to build support for Analog Devices Generic


Just realized this when working on the v3 for IIO backends. Please let me k=
now
if I should send a follow up patch or if I can still send a v3 on the
"iio: ad9467 and axi-adc cleanups" series.

- Nuno S=C3=A1

