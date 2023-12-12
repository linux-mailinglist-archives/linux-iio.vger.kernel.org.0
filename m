Return-Path: <linux-iio+bounces-853-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A1F80EEA4
	for <lists+linux-iio@lfdr.de>; Tue, 12 Dec 2023 15:25:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A1CC1F21595
	for <lists+linux-iio@lfdr.de>; Tue, 12 Dec 2023 14:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C6B73185;
	Tue, 12 Dec 2023 14:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HNxU63j/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97242F2
	for <linux-iio@vger.kernel.org>; Tue, 12 Dec 2023 06:25:44 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-40c2d50bfbfso28012815e9.0
        for <linux-iio@vger.kernel.org>; Tue, 12 Dec 2023 06:25:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702391143; x=1702995943; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ohQ6bxcs1D/V/kHWqcDhhcOEKg3pSMdQsyBVH4lGSvI=;
        b=HNxU63j/MNle8Y8yrqGdByMCdRS03pBoY5s0sYXVNr9yJ+p04rKs6UCmUQdxZXfoI+
         /lTCN7bVwC6AuePrsfY3tpnsghDNPa0U5YTX7I6KBzvnBDbCEcFRyVfhKVc0Ut10jy0I
         JevFmy0wk9BVSGeYvhfFFukMthE5pg8G0p2NaHQgryZssIbbCxHPetTnttRKfoBcj8Wa
         Xz7XJt0YJ3/YOZadVjDqgeugcJ4bjb1ncsxubkNDIlZs58cVQo0FhDNq7SYZQkn+huaw
         /B0pNLtBP71AOmzNp97q4PcjXxu9YeZPPymiKJXOYmW7U2SdUsHBI2qsadBpHHsSe2u4
         IrwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702391143; x=1702995943;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ohQ6bxcs1D/V/kHWqcDhhcOEKg3pSMdQsyBVH4lGSvI=;
        b=R0yyjT9lunkKI0aYDm7sBTHq2vzS7Zvwebhnor0Z/fE5UBsyxzIfq6uYQmNnTxPwwi
         6gxJE+4Tt3zXQWM1VWcauXSrgcTUS/HGSH+PIbdhUkF5OPXK5+Gq3yp61/QUf57HBTI/
         mkgBIj579rmHn4za5iwoEjvuSCTferFkxv0AVKgrtRhtVvFE87iLCgoVvQ1YCCuIt7Ed
         ma67R1LeTrj8ORTRmLxBkUsAMeJnvxB1y5TtWgnhkAkQb06O0v7/xYPVtj/E4kTn8ONJ
         YV0Cmlehi+aOV3kQ4amofCo3ttrHM2+1JsNupjXxJIiqUXjmn914dMOiq7XlEhs1/vJ5
         rFEA==
X-Gm-Message-State: AOJu0YxLYPNA6cvuGwxv2r0jRgKJ0w2IOZz+cStgaLljxkKQUPBAchvh
	/HKwy81Kbn11k/lXoWUwAFS5O57PXAO6VsSy
X-Google-Smtp-Source: AGHT+IFzdGJCrzJi9NoanrIbQKMnnDLoGulzhLcB3zybBuxmQf35LU3/WkUQUayoMWVtW6O5Dv5PZA==
X-Received: by 2002:a05:600c:3511:b0:40c:451b:45de with SMTP id h17-20020a05600c351100b0040c451b45demr2005096wmq.121.1702391142842;
        Tue, 12 Dec 2023 06:25:42 -0800 (PST)
Received: from ?IPv6:2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47? (p200300f6ef1b2000944ccbc71e1c2c47.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47])
        by smtp.gmail.com with ESMTPSA id k3-20020adfe8c3000000b003334460e256sm10953382wrn.92.2023.12.12.06.25.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 06:25:42 -0800 (PST)
Message-ID: <177d810fc363ecb185df5b919aa249422610286c.camel@gmail.com>
Subject: Re: [PATCH v2 8/8] iio: adc: adi-axi-adc: convert to regmap
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org, Michael Hennerich
 <Michael.Hennerich@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, David
 Lechner <dlechner@baylibre.com>
Date: Tue, 12 Dec 2023 15:28:46 +0100
In-Reply-To: <20231211191618.686595e2@jic23-huawei>
References: <20231207-iio-backend-prep-v2-0-a4a33bc4d70e@analog.com>
	 <20231207-iio-backend-prep-v2-8-a4a33bc4d70e@analog.com>
	 <3c6d49a05b1bd0e6a2777c9e4ed3f7121ad9ab0f.camel@gmail.com>
	 <20231211191618.686595e2@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2023-12-11 at 19:16 +0000, Jonathan Cameron wrote:
> On Mon, 11 Dec 2023 14:18:43 +0100
> Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
>=20
> > On Thu, 2023-12-07 at 13:39 +0100, Nuno Sa via B4 Relay wrote:
> > > From: Nuno Sa <nuno.sa@analog.com>
> > >=20
> > > Use MMIO regmap interface. It makes things easier for manipulating bi=
ts.
> > >=20
> > > Reviewed-by: David Lechner <dlechner@baylibre.com>
> > > Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> > > ---
> > > =C2=A0drivers/iio/adc/adi-axi-adc.c | 85 ++++++++++++++++++++++++++--=
----------
> > > ----
> > > -
> > > =C2=A01 file changed, 52 insertions(+), 33 deletions(-)
> > >=20
> > > diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-=
adc.c
> > > index ae83ada7f9f2..c247ff1541d2 100644
> > > --- a/drivers/iio/adc/adi-axi-adc.c
> > > +++ b/drivers/iio/adc/adi-axi-adc.c
> > > @@ -14,6 +14,7 @@
> > > =C2=A0#include <linux/of.h>
> > > =C2=A0#include <linux/platform_device.h>
> > > =C2=A0#include <linux/property.h>
> > > +#include <linux/regmap.h>
> > > =C2=A0#include <linux/slab.h>
> > > =C2=A0
> > > =C2=A0#include <linux/iio/iio.h>
> > > @@ -62,7 +63,7 @@ struct adi_axi_adc_state {
> > > =C2=A0	struct mutex				lock;
> > > =C2=A0
> > > =C2=A0	struct adi_axi_adc_client		*client;
> > > -	void __iomem				*regs;
> > > +	struct regmap				*regmap;
> > > =C2=A0};
> > > =C2=A0
> > > =C2=A0struct adi_axi_adc_client {
> > > @@ -90,19 +91,6 @@ void *adi_axi_adc_conv_priv(struct adi_axi_adc_con=
v
> > > *conv)
> > > =C2=A0}
> > > =C2=A0EXPORT_SYMBOL_NS_GPL(adi_axi_adc_conv_priv, IIO_ADI_AXI);
> > > =C2=A0
> > > -static void adi_axi_adc_write(struct adi_axi_adc_state *st,
> > > -			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int reg,
> > > -			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int val)
> > > -{
> > > -	iowrite32(val, st->regs + reg);
> > > -}
> > > -
> > > -static unsigned int adi_axi_adc_read(struct adi_axi_adc_state *st,
> > > -				=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int reg)
> > > -{
> > > -	return ioread32(st->regs + reg);
> > > -}
> > > -
> > > =C2=A0static int adi_axi_adc_config_dma_buffer(struct device *dev,
> > > =C2=A0					 struct iio_dev *indio_dev)
> > > =C2=A0{
> > > @@ -163,17 +151,20 @@ static int adi_axi_adc_update_scan_mode(struct
> > > iio_dev
> > > *indio_dev,
> > > =C2=A0{
> > > =C2=A0	struct adi_axi_adc_state *st =3D iio_priv(indio_dev);
> > > =C2=A0	struct adi_axi_adc_conv *conv =3D &st->client->conv;
> > > -	unsigned int i, ctrl;
> > > +	unsigned int i;
> > > +	int ret;
> > > =C2=A0
> > > =C2=A0	for (i =3D 0; i < conv->chip_info->num_channels; i++) {
> > > -		ctrl =3D adi_axi_adc_read(st, ADI_AXI_REG_CHAN_CTRL(i));
> > > -
> > > =C2=A0		if (test_bit(i, scan_mask))
> > > -			ctrl |=3D ADI_AXI_REG_CHAN_CTRL_ENABLE;
> > > +			ret =3D regmap_set_bits(st->regmap,
> > > +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ADI_AXI_REG_CHAN_CTRL(i),
> > > +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> > > ADI_AXI_REG_CHAN_CTRL_ENABLE);
> > > =C2=A0		else
> > > -			ctrl &=3D ~ADI_AXI_REG_CHAN_CTRL_ENABLE;
> > > -
> > > -		adi_axi_adc_write(st, ADI_AXI_REG_CHAN_CTRL(i), ctrl);
> > > +			ret =3D regmap_clear_bits(st->regmap,
> > > +						ADI_AXI_REG_CHAN_CTRL(i),
> > > +						ADI_AXI_REG_CHAN_CTRL_ENA
> > > BLE)
> > > ;
> > > +		if (ret)
> > > +			return ret;
> > > =C2=A0	}
> > > =C2=A0
> > > =C2=A0	return 0;
> > > @@ -310,21 +301,32 @@ static int adi_axi_adc_setup_channels(struct de=
vice
> > > *dev,
> > > =C2=A0	}
> > > =C2=A0
> > > =C2=A0	for (i =3D 0; i < conv->chip_info->num_channels; i++) {
> > > -		adi_axi_adc_write(st, ADI_AXI_REG_CHAN_CTRL(i),
> > > -				=C2=A0 ADI_AXI_REG_CHAN_CTRL_DEFAULTS);
> > > +		ret =3D regmap_write(st->regmap, ADI_AXI_REG_CHAN_CTRL(i),
> > > +				=C2=A0=C2=A0 ADI_AXI_REG_CHAN_CTRL_DEFAULTS);
> > > +		if (ret)
> > > +			return ret;
> > > =C2=A0	}
> > > =C2=A0
> > > =C2=A0	return 0;
> > > =C2=A0}
> > > =C2=A0
> > > -static void axi_adc_reset(struct adi_axi_adc_state *st)
> > > +static int axi_adc_reset(struct adi_axi_adc_state *st)
> > > =C2=A0{
> > > -	adi_axi_adc_write(st, ADI_AXI_REG_RSTN, 0);
> > > +	int ret;
> > > +
> > > +	ret =3D regmap_write(st->regmap, ADI_AXI_REG_RSTN, 0);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > =C2=A0	mdelay(10);
> > > -	adi_axi_adc_write(st, ADI_AXI_REG_RSTN,
> > > ADI_AXI_REG_RSTN_MMCM_RSTN);
> > > +	ret =3D regmap_write(st->regmap, ADI_AXI_REG_RSTN,
> > > +			=C2=A0=C2=A0 ADI_AXI_REG_RSTN_MMCM_RSTN);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > =C2=A0	mdelay(10);
> > > -	adi_axi_adc_write(st, ADI_AXI_REG_RSTN,
> > > -			=C2=A0 ADI_AXI_REG_RSTN_RSTN |
> > > ADI_AXI_REG_RSTN_MMCM_RSTN);
> > > +	return regmap_write(st->regmap, ADI_AXI_REG_RSTN,
> > > +			=C2=A0=C2=A0=C2=A0 ADI_AXI_REG_RSTN_RSTN |
> > > ADI_AXI_REG_RSTN_MMCM_RSTN);
> > > =C2=A0}
> > > =C2=A0
> > > =C2=A0static void adi_axi_adc_cleanup(void *data)
> > > @@ -335,12 +337,20 @@ static void adi_axi_adc_cleanup(void *data)
> > > =C2=A0	module_put(cl->dev->driver->owner);
> > > =C2=A0}
> > > =C2=A0
> > > +static const struct regmap_config axi_adc_regmap_config =3D {
> > > +	.val_bits =3D 32,
> > > +	.reg_bits =3D 32,
> > > +	.reg_stride =3D 4,
> > > +	.max_register =3D 0x0800,
> > > +};
> > > +
> > > =C2=A0static int adi_axi_adc_probe(struct platform_device *pdev)
> > > =C2=A0{
> > > =C2=A0	struct adi_axi_adc_conv *conv;
> > > =C2=A0	struct iio_dev *indio_dev;
> > > =C2=A0	struct adi_axi_adc_client *cl;
> > > =C2=A0	struct adi_axi_adc_state *st;
> > > +	void __iomem *base;
> > > =C2=A0	unsigned int ver;
> > > =C2=A0	int ret;
> > > =C2=A0
> > > @@ -361,15 +371,24 @@ static int adi_axi_adc_probe(struct platform_de=
vice
> > > *pdev)
> > > =C2=A0	cl->state =3D st;
> > > =C2=A0	mutex_init(&st->lock);
> > > =C2=A0
> > > -	st->regs =3D devm_platform_ioremap_resource(pdev, 0);
> > > -	if (IS_ERR(st->regs))
> > > -		return PTR_ERR(st->regs);
> > > +	base =3D devm_platform_ioremap_resource(pdev, 0);
> > > +	if (IS_ERR(base))
> > > +		return PTR_ERR(base);
> > > +
> > > +	st->regmap =3D devm_regmap_init_mmio(&pdev->dev, base,
> > > +					=C2=A0=C2=A0 &axi_adc_regmap_config);
> > > +	if (IS_ERR(st->regmap))
> > > +		return PTR_ERR(st->regmap);
> > > =C2=A0
> > > =C2=A0	conv =3D &st->client->conv;
> > > =C2=A0
> > > -	axi_adc_reset(st);
> > > +	ret =3D axi_adc_reset(st);
> > > +	if (ret)
> > > +		return ret;
> > > =C2=A0
> > > -	ver =3D adi_axi_adc_read(st, ADI_AXI_REG_VERSION);
> > > +	ret =3D regmap_read(st->regmap, ADI_AXI_REG_VERSION, &ver);
> > > +	if (ret)
> > > +		return ret;
> > > =C2=A0
> > > =C2=A0	if (cl->info->version > ver) {
> > > =C2=A0		dev_err(&pdev->dev,
> > > =C2=A0=20
> >=20
> > Hi Jonathan,
> >=20
> > I'm not seeing this series yet applied in the togreg branch so maybe I'=
m
> > still
> > on time. This patch is missing the proper Kconfig change:
>=20
> >=20
> >=20
> > diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> > index af56df63beff..10e0e340cdae 100644
> > --- a/drivers/iio/adc/Kconfig
> > +++ b/drivers/iio/adc/Kconfig
> > @@ -292,7 +292,7 @@ config ADI_AXI_ADC
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select IIO_BUFFER
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select IIO_BUFFER_HW_CONSUME=
R
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select IIO_BUFFER_DMAENGINE
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 depends on HAS_IOMEM
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select REGMAP_MMIO
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 depends on OF
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 help
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Say yes here to =
build support for Analog Devices Generic
> >=20
> >=20
> > Just realized this when working on the v3 for IIO backends. Please let =
me
> > know
> > if I should send a follow up patch or if I can still send a v3 on the
> > "iio: ad9467 and axi-adc cleanups" series.
> Oops. I forgot to push out yesterday.=C2=A0 Anyhow, would still have been=
 fine to
> fix
> this as always about a week before I push out as togreg unless we are nea=
r
> the merge window.
>=20
> Fixed up.
> Jonathan

Thanks!
- Nuno S=C3=A1

