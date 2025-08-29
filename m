Return-Path: <linux-iio+bounces-23387-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD04DB3C0AA
	for <lists+linux-iio@lfdr.de>; Fri, 29 Aug 2025 18:27:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 608041BA228E
	for <lists+linux-iio@lfdr.de>; Fri, 29 Aug 2025 16:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25522326D52;
	Fri, 29 Aug 2025 16:27:38 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8118322C72;
	Fri, 29 Aug 2025 16:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756484858; cv=none; b=cR88db86KPwjFBbFgqJMAsNBv8ISfeEVaykCeyeuAoqL168tJMD0+MmtN+a6O9fOSJfNJL9G0jiyW3X6LEq9I4C8lW6Nrrxdai67JgU7cpXXUH6gjy/2ZJ432cWsuERDX6n1km6f9aJg/Iy4myD9XxH2PmGesj5b9VCQb9KbH9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756484858; c=relaxed/simple;
	bh=xqrPYBlj/LolHDgAm/dCuwZwNPFm337/iOFRkXWT6Po=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t+IC9kXDcv6DooTgkw/KWzg+pCNNvJSprKAD2NTBjt8FGhAuf5VNsS6hYpH7KRtR8yqN3leBqS2VWkeZXtmTKgQrioIr5xqb7f7KrRhWj/L0MQLw8GRIkgHLBhMf3f3VZtG9Ig+HPI+CN97/XPmX+6qPwdD+i9SImddaoZetSMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cD3X72RCYz6GFRg;
	Sat, 30 Aug 2025 00:25:11 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 1020B140145;
	Sat, 30 Aug 2025 00:27:32 +0800 (CST)
Received: from localhost (10.203.177.15) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 29 Aug
 2025 18:27:31 +0200
Date: Fri, 29 Aug 2025 17:27:30 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Duje =?utf-8?Q?Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
CC: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Karel Balej <balejk@matfyz.cz>, "Lee
 Jones" <lee@kernel.org>, David Wronek <david@mainlining.org>,
	<phone-devel@vger.kernel.org>, <~postmarketos/upstreaming@lists.sr.ht>,
	<linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 1/2] iio: adc: Add driver for Marvell 88PM886 PMIC ADC
Message-ID: <20250829172730.000079b5@huawei.com>
In-Reply-To: <20250829-88pm886-gpadc-v1-1-f60262266fea@dujemihanovic.xyz>
References: <20250829-88pm886-gpadc-v1-0-f60262266fea@dujemihanovic.xyz>
	<20250829-88pm886-gpadc-v1-1-f60262266fea@dujemihanovic.xyz>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 29 Aug 2025 00:17:41 +0200
Duje Mihanovi=C4=87 <duje@dujemihanovic.xyz> wrote:

> Marvell's 88PM886 PMIC has a so-called General Purpose ADC used for
> monitoring various system voltages and temperatures. Add the relevant
> register definitions to the MFD header and a driver for the ADC.
>=20
> Signed-off-by: Duje Mihanovi=C4=87 <duje@dujemihanovic.xyz>
Hi Duje

A few quick comments. I've tried not to overlap too much with David.

Jonathan

> diff --git a/drivers/iio/adc/88pm886-gpadc.c b/drivers/iio/adc/88pm886-gp=
adc.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..129cff48641f1505175e64cf7=
dbdd0133f265ce8
> --- /dev/null
> +++ b/drivers/iio/adc/88pm886-gpadc.c

> +static int gpadc_get_raw(struct iio_dev *iio, enum pm886_gpadc_channel c=
han)
> +{
> +	struct regmap **map =3D iio_priv(iio);
> +	int val, ret;
> +	u8 buf[2];
> +
> +	if (chan >=3D GPADC0_RES_CHAN)
> +		/* Resistor voltage drops are read from the corresponding voltage chan=
nel */
> +		chan -=3D GPADC0_RES_CHAN - GPADC0_CHAN;
> +
> +	ret =3D regmap_bulk_read(*map, regs[chan], buf, 2);
> +
> +	if (ret)
> +		return ret;
> +
> +	val =3D ((buf[0] & 0xff) << 4) | (buf[1] & 0xf);

No point in masking a u8 by 0xff.

> +	val &=3D 0xfff;
Can't have any other bits set that I can see so no need for this
final mask.
> +
> +	return val;
> +}
>

> +static int
> +pm886_gpadc_read_raw(struct iio_dev *iio, struct iio_chan_spec const *ch=
an, int *val, int *val2,
> +		     long mask)
> +{
> +	struct device *dev =3D iio->dev.parent;
> +	int raw, ret;
> +
> +	ret =3D pm_runtime_resume_and_get(dev);
Probably worth a wrapper that handles the pm runtime stuff and
then calls the rest of this code just to allow simple returns
on errors.  I keep promising to spin a series done ACQUIRE() magic
for pm_runtime_resume_and_get with autosuspend but not getting time
to write it :(  For now, wrapper is the way to go.

https://elixir.bootlin.com/linux/v6.17-rc3/source/include/linux/cleanup.h#L=
330

> +	if (ret)
> +		return ret;
> +
> +	if (chan->type =3D=3D IIO_RESISTANCE) {
> +		raw =3D gpadc_get_resistor(iio, chan);
> +		if (raw < 0) {
> +			ret =3D raw;
> +			goto out;
> +		}
> +
> +		*val =3D raw;
> +		dev_dbg(&iio->dev, "chan: %d, %d Ohm\n", chan->channel, *val);
> +		ret =3D IIO_VAL_INT;
> +		goto out;
> +	}
> +
> +	raw =3D gpadc_get_raw(iio, chan->channel);
> +	if (raw < 0) {
> +		ret =3D raw;
> +		goto out;
> +	}
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		*val =3D raw;
> +		dev_dbg(&iio->dev, "chan: %d, raw: %d\n", chan->channel, *val);
> +		ret =3D IIO_VAL_INT;
> +		break;
> +	case IIO_CHAN_INFO_PROCESSED: {
> +		*val =3D raw * chan->address;
> +		ret =3D IIO_VAL_INT;
> +
> +		/*
> +		 * Voltage measurements are scaled into uV. Scale them back
> +		 * into the mV dimension.
> +		 */
> +		if (chan->type =3D=3D IIO_VOLTAGE)
> +			*val =3D DIV_ROUND_CLOSEST(*val, 1000);
> +
> +		dev_dbg(&iio->dev, "chan: %d, raw: %d, processed: %d\n", chan->channel=
, raw, *val);
> +		break;
> +	default:
> +		ret =3D -EINVAL;
> +	}
> +	}
> +
> +out:
> +	pm_runtime_mark_last_busy(dev);

Drop this mark_last_busy.  The put_autosuspend now always calls it
so should never be any reason to call that any more.


> +	pm_runtime_put_autosuspend(dev);
> +	return ret;
> +}

> +
> +static int pm886_gpadc_probe(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev, *parent =3D dev->parent;
> +	struct pm886_chip *chip =3D dev_get_drvdata(parent);
> +	struct i2c_client *client =3D chip->client, *page;
> +	struct regmap **map;
> +	struct iio_dev *iio;
> +	int ret;
> +
> +	iio =3D devm_iio_device_alloc(dev, sizeof(*map));
> +	if (!iio)
> +		return -ENOMEM;
> +	map =3D iio_priv(iio);
> +
> +	dev_set_drvdata(dev, iio);
> +
> +	page =3D devm_i2c_new_dummy_device(dev, client->adapter,
> +					 client->addr + PM886_PAGE_OFFSET_GPADC);
> +	if (IS_ERR(page))
> +		return dev_err_probe(dev, PTR_ERR(page), "Failed to initialize GPADC p=
age\n");
> +
> +	*map =3D devm_regmap_init_i2c(page, &pm886_gpadc_regmap_config);
> +	if (IS_ERR(*map))
> +		return dev_err_probe(dev, PTR_ERR(*map),
> +				     "Failed to initialize GPADC regmap\n");
> +
> +	iio->name =3D "88pm886-gpadc";
> +	iio->dev.parent =3D dev;
> +	iio->dev.of_node =3D parent->of_node;
Done in core code.
https://elixir.bootlin.com/linux/v6.16.3/source/drivers/iio/industrialio-co=
re.c#L2044
__iio_device_register() so unless you use it before that call shouldn't nee=
d this.

I'm not sure what it is used for though.

> +	iio->modes =3D INDIO_DIRECT_MODE;
> +	iio->info =3D &pm886_gpadc_iio_info;
> +	iio->channels =3D pm886_adc_channels;
> +	iio->num_channels =3D ARRAY_SIZE(pm886_adc_channels);
> +
> +	devm_pm_runtime_enable(dev);
> +	pm_runtime_set_autosuspend_delay(dev, 50);
> +	pm_runtime_use_autosuspend(dev);
> +
> +	ret =3D devm_iio_device_register(dev, iio);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to register ADC\n");
> +
> +	return 0;
> +}

>=20


