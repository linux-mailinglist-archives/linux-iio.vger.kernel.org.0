Return-Path: <linux-iio+bounces-24346-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CC46B8FB58
	for <lists+linux-iio@lfdr.de>; Mon, 22 Sep 2025 11:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B8D2420B5A
	for <lists+linux-iio@lfdr.de>; Mon, 22 Sep 2025 09:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B27E021D596;
	Mon, 22 Sep 2025 09:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Urclyvvg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297602857CF
	for <linux-iio@vger.kernel.org>; Mon, 22 Sep 2025 09:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758532498; cv=none; b=fzSF1/dAk6x5SZACTv9Va0UQN5rttZDr/t7MuDcHTNCjButjAKI7CZf6ckJMqPvp7Uq169S4rHjkH8VzZ5sRqIDmrfJNDhLgm2E9arkXAHKc1j3Q7fxHL/zqWbOCsEuble7elh8u4WOVYkuCtkwVHrGqXTb4vNmXduywX8RzXMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758532498; c=relaxed/simple;
	bh=WKUGkjM2T30oONt865tjAI4q+0yv0rwbPzegEj35MtM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bLiPvdPanqaVdN37rWxBR7HENOcqUMBWw+rtfM0SXvHXRdvKo8NgairE0VgoqyYut3yru+f9NAMUDX/hKHPfM1/cJihthdfgFujdV/valqUfYLCN+htRQihobxInn9rXYmuM1J1DJFMuKWvmgGJWhzxOamqDJHwdZvWYJO1B6yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Urclyvvg; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45ed646b656so36235895e9.3
        for <linux-iio@vger.kernel.org>; Mon, 22 Sep 2025 02:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758532493; x=1759137293; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Gn2IqG/HStQwMzZuYwRDiMRUL3wQ/A40KtFzHlVn8Tg=;
        b=UrclyvvgWERur9nL6QbofVd9R/ftPDzwAGv1lo/mSOgdetq2fE/SppxUVm0ClPAIgb
         qhjczJhohE36VWSmenmQY+AadWA1BkU447syso4YBZNjBE70oVPw9V3PKkjs9o6nRHwG
         ywRrrHcZFNpaoy6Ol2rTJJTm6nCGMGuNw+HAwsTK/SMu58cGvR6O/RqIa4QSpqkYEzLu
         qwIEaHWi8Y7nXp+AXarxGNYJAsHEWL4jmnQcyMMatP9KA9qDfeOohUmlF3zfc2owov+C
         hJO0W24gcbuia/WUZE/v9rKJCXZLuVJM5CbLAoH+ddylaxYxdwHgpH1cZdeni9GwlkjL
         ldfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758532493; x=1759137293;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gn2IqG/HStQwMzZuYwRDiMRUL3wQ/A40KtFzHlVn8Tg=;
        b=g66wmhaUZcO3DDrxsZESEPFHpk1LhfkgxkrNMAQOdd5qPjEk0X0VaQywFBntmVUZFn
         UFwr4ioqFQsKT4SCg/ZAQpA3MrJk4StNU6iuPObT3EwBNznyF51n8uyqU15JofPUTUSH
         khiPqWm7yxbPNjpvzRhfeAxB0QwbZ0FecSnoa1r0FqDdFGEKB28yjem9at9Uo1SQjhLN
         8eFNzeehs0H8nEIXOpS9OyLexq4du+1Ny51XIswK2R78bayQBrp0CLDdEZC3rg0bm47l
         dI365wIF4sonjBmBlETXVFrmTzmTA9BoAb+8udqiOy0Mlb8sUc4hpta+Xo5og8SOp1JX
         SmiA==
X-Forwarded-Encrypted: i=1; AJvYcCXB8VblLUYZMd2pbxEbdYMMuv0jFtSwgm6McivL1WKRx84yrK7cv5jHpHEm+C52HPeVG+1KAN58CO8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJD5pwPmZX2pwhD544IN4bZfIhoNfNPO4LyI6l0lQ7wDgL8Z8i
	ibHmXVNwROB66dNIMeg36thsBwcQQVBUX4dkWhM0I0qLPQ21XahzsY+t
X-Gm-Gg: ASbGnctPicl9FGay7VL4oZOptS7NPopTYkNZx2LuQZbHtdSZUYVE+lz7tWA+bs1BlQT
	308CfRe7hlc2iW9Ytloej8R5AgS1NMzq0lKZClmRtNM9RVOORgd708e72MDnbdzAnrvngMTdBZN
	CNeVi2AItuTe0EI6guf0POGZ+M7l7KP3+qWoy+xVI9+tJHJocGjRmun/iZhVlebWfTCES4jAsn7
	AehmGmUjHY5Xk8wSAUaWHKSbiLwv5Fb0QfptbAdzgBDD51wZFaAALxX7B+RGY+1zkY0gLVZn8HQ
	0Uvpzt9NTwjXlUpNj7AdAr0BucrBEkr52nIPzdkHccI9ojaX15a2wAK4bteDHmDZu9NBZsa0vhM
	DdPM0RlZNa6v+qpZXA8qjArg=
X-Google-Smtp-Source: AGHT+IG2aDFH3qrYU5KWdv9fRF0RXYdP1jQjFAVmviDQN/gGJbMgGr6iBzTCzk+VO8oRxQ798o57KA==
X-Received: by 2002:a05:600c:a44:b0:45d:f650:376f with SMTP id 5b1f17b1804b1-467efedab3cmr127633175e9.23.1758532493292;
        Mon, 22 Sep 2025 02:14:53 -0700 (PDT)
Received: from [10.5.0.2] ([45.94.208.160])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3f00cc58b91sm13134182f8f.1.2025.09.22.02.14.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 02:14:52 -0700 (PDT)
Message-ID: <073de1da8b8f04c037f267765235b3334941844f.camel@gmail.com>
Subject: Re: [PATCH 2/3] iio: mpl3115: add support for DRDY interrupt
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Antoni Pokusinski <apokusinski01@gmail.com>, jic23@kernel.org, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 robh@kernel.org, 	krzk+dt@kernel.org, conor+dt@kernel.org
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux@roeck-us.net, rodrigo.gobbi.7@gmail.com, 
	naresh.solanki@9elements.com, michal.simek@amd.com,
 grantpeltier93@gmail.com, 	farouk.bouabid@cherry.de,
 marcelo.schmitt1@gmail.com
Date: Mon, 22 Sep 2025 10:15:19 +0100
In-Reply-To: <20250921133327.123726-3-apokusinski01@gmail.com>
References: <20250921133327.123726-1-apokusinski01@gmail.com>
	 <20250921133327.123726-3-apokusinski01@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2025-09-21 at 15:33 +0200, Antoni Pokusinski wrote:
> MPL3115 sensor features a "data ready" interrupt which indicates the
> presence of new measurements.
>=20
> Signed-off-by: Antoni Pokusinski <apokusinski01@gmail.com>
> ---
> =C2=A0drivers/iio/pressure/mpl3115.c | 167 ++++++++++++++++++++++++++++++=
++-
> =C2=A01 file changed, 162 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/iio/pressure/mpl3115.c b/drivers/iio/pressure/mpl311=
5.c
> index 579da60ef441..cf34de8f0d7e 100644
> --- a/drivers/iio/pressure/mpl3115.c
> +++ b/drivers/iio/pressure/mpl3115.c
> @@ -7,7 +7,7 @@
> =C2=A0 * (7-bit I2C slave address 0x60)
> =C2=A0 *
> =C2=A0 * TODO: FIFO buffer, altimeter mode, oversampling, continuous mode=
,
> - * interrupts, user offset correction, raw mode
> + * user offset correction, raw mode
> =C2=A0 */
> =C2=A0
> =C2=A0#include <linux/module.h>
> @@ -17,26 +17,45 @@
> =C2=A0#include <linux/iio/trigger_consumer.h>
> =C2=A0#include <linux/iio/buffer.h>
> =C2=A0#include <linux/iio/triggered_buffer.h>
> +#include <linux/iio/trigger.h>
> =C2=A0#include <linux/delay.h>
> +#include <linux/property.h>
> =C2=A0
> =C2=A0#define MPL3115_STATUS 0x00
> =C2=A0#define MPL3115_OUT_PRESS 0x01 /* MSB first, 20 bit */
> =C2=A0#define MPL3115_OUT_TEMP 0x04 /* MSB first, 12 bit */
> =C2=A0#define MPL3115_WHO_AM_I 0x0c
> +#define MPL3115_INT_SOURCE 0x12
> +#define MPL3115_PT_DATA_CFG 0x13
> =C2=A0#define MPL3115_CTRL_REG1 0x26
> +#define MPL3115_CTRL_REG3 0x28
> +#define MPL3115_CTRL_REG4 0x29
> +#define MPL3115_CTRL_REG5 0x2a
> =C2=A0
> =C2=A0#define MPL3115_DEVICE_ID 0xc4
> =C2=A0
> =C2=A0#define MPL3115_STATUS_PRESS_RDY BIT(2)
> =C2=A0#define MPL3115_STATUS_TEMP_RDY BIT(1)
> =C2=A0
> +#define MPL3115_CTRL_INT_SRC_DRDY BIT(7)
> +
> +#define MPL3115_PT_DATA_EVENT_ALL (BIT(2) | BIT(1) | BIT(0))
> +
> =C2=A0#define MPL3115_CTRL_RESET BIT(2) /* software reset */
> =C2=A0#define MPL3115_CTRL_OST BIT(1) /* initiate measurement */
> =C2=A0#define MPL3115_CTRL_ACTIVE BIT(0) /* continuous measurement */
> =C2=A0#define MPL3115_CTRL_OS_258MS (BIT(5) | BIT(4)) /* 64x oversampling=
 */
> =C2=A0
> +#define MPL3115_CTRL_IPOL1 BIT(5)
> +#define MPL3115_CTRL_IPOL2 BIT(1)
> +
> +#define MPL3115_CTRL_INT_EN_DRDY BIT(7)
> +
> +#define MPL3115_CTRL_INT_CFG_DRDY BIT(7)
> +
> =C2=A0struct mpl3115_data {
> =C2=A0	struct i2c_client *client;
> +	struct iio_trigger *drdy_trig;
> =C2=A0	struct mutex lock;
> =C2=A0	u8 ctrl_reg1;
> =C2=A0};
> @@ -164,10 +183,12 @@ static irqreturn_t mpl3115_trigger_handler(int irq,=
 void
> *p)
> =C2=A0	int ret, pos =3D 0;
> =C2=A0
> =C2=A0	mutex_lock(&data->lock);
> -	ret =3D mpl3115_request(data);
> -	if (ret < 0) {
> -		mutex_unlock(&data->lock);
> -		goto done;
> +	if (!(data->ctrl_reg1 & MPL3115_CTRL_ACTIVE)) {
> +		ret =3D mpl3115_request(data);
> +		if (ret < 0) {
> +			mutex_unlock(&data->lock);
> +			goto done;
> +		}
> =C2=A0	}
> =C2=A0
> =C2=A0	if (test_bit(0, indio_dev->active_scan_mask)) {
> @@ -228,10 +249,142 @@ static const struct iio_chan_spec mpl3115_channels=
[] =3D
> {
> =C2=A0	IIO_CHAN_SOFT_TIMESTAMP(2),
> =C2=A0};
> =C2=A0
> +static irqreturn_t mpl3115_interrupt_handler(int irq, void *private)
> +{
> +	struct iio_dev *indio_dev =3D private;
> +	struct mpl3115_data *data =3D iio_priv(indio_dev);
> +	int ret;
> +
> +	ret =3D i2c_smbus_read_byte_data(data->client, MPL3115_INT_SOURCE);
> +	if (ret < 0)
> +		return IRQ_HANDLED;
> +
> +	if (!(ret & MPL3115_CTRL_INT_SRC_DRDY))
> +		return IRQ_NONE;
> +
> +	iio_trigger_poll_nested(data->drdy_trig);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int mpl3115_set_trigger_state(struct iio_trigger *trig, bool stat=
e)
> +{
> +	struct iio_dev *indio_dev =3D iio_trigger_get_drvdata(trig);
> +	struct mpl3115_data *data =3D iio_priv(indio_dev);
> +	int ret;
> +	u8 ctrl_reg1 =3D data->ctrl_reg1;
> +
> +	if (state)
> +		ctrl_reg1 |=3D MPL3115_CTRL_ACTIVE;
> +	else
> +		ctrl_reg1 &=3D ~MPL3115_CTRL_ACTIVE;
> +
> +	guard(mutex)(&data->lock);
> +

As Andy pointed out, you should have a precursor patch converting the compl=
ete
driver to use the cleanup logic.

Another nice cleanup you could do (if you want of course) would be to get r=
id of
mpl3115_remove().

> +	ret =3D i2c_smbus_write_byte_data(data->client, MPL3115_CTRL_REG1,
> +					ctrl_reg1);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret =3D i2c_smbus_write_byte_data(data->client, MPL3115_CTRL_REG4,
> +					state ? MPL3115_CTRL_INT_EN_DRDY :
> 0);
> +	if (ret < 0)
> +		goto reg1_cleanup;
> +
> +	data->ctrl_reg1 =3D ctrl_reg1;
> +
> +	return 0;
> +
> +reg1_cleanup:
> +	i2c_smbus_write_byte_data(data->client, MPL3115_CTRL_REG1,
> +				=C2=A0 data->ctrl_reg1);
> +	return ret;
> +}
> +
> +static const struct iio_trigger_ops mpl3115_trigger_ops =3D {
> +	.set_trigger_state =3D mpl3115_set_trigger_state,
> +};
> +
> =C2=A0static const struct iio_info mpl3115_info =3D {
> =C2=A0	.read_raw =3D &mpl3115_read_raw,
> =C2=A0};
> =C2=A0
> +static int mpl3115_trigger_probe(struct mpl3115_data *data,
> +				 struct iio_dev *indio_dev)
> +{
> +	struct fwnode_handle *fwnode;
> +	int ret, irq, irq_type;
> +	bool act_high, is_int2 =3D false;
> +
> +	fwnode =3D dev_fwnode(&data->client->dev);
> +	if (!fwnode)
> +		return -ENODEV;
> +

And to add to Andy's review, fwnode_irq_get_byname() will give you an error
anyways if !fwnode.

> +	irq =3D fwnode_irq_get_byname(fwnode, "INT1");
> +	if (irq < 0) {
> +		irq =3D fwnode_irq_get_byname(fwnode, "INT2");
> +		if (irq < 0)
> +			return 0;
> +
> +		is_int2 =3D true;
> +	}
> +
> +	irq_type =3D irq_get_trigger_type(irq);
> +	switch (irq_type) {
> +	case IRQF_TRIGGER_RISING:
> +		act_high =3D true;
> +		break;
> +	case IRQF_TRIGGER_FALLING:
> +		act_high =3D false;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	ret =3D i2c_smbus_write_byte_data(data->client, MPL3115_PT_DATA_CFG,
> +					MPL3115_PT_DATA_EVENT_ALL);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (!is_int2) {
> +		ret =3D i2c_smbus_write_byte_data(data->client,
> +						MPL3115_CTRL_REG5,
> +						MPL3115_CTRL_INT_CFG_DRDY);
> +		if (ret)
> +			return ret;
> +	}
> +	if (act_high) {
> +		ret =3D i2c_smbus_write_byte_data(data->client,
> +						MPL3115_CTRL_REG3,
> +						is_int2 ? MPL3115_CTRL_IPOL2
> :
> +							=C2=A0
> MPL3115_CTRL_IPOL1);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	data->drdy_trig =3D devm_iio_trigger_alloc(&data->client->dev,
> +						 "%s-dev%d",
> +						 indio_dev->name,
> +						 iio_device_id(indio_dev));
> +	if (!data->drdy_trig)
> +		return -ENOMEM;
> +
> +	data->drdy_trig->ops =3D &mpl3115_trigger_ops;
> +	iio_trigger_set_drvdata(data->drdy_trig, indio_dev);
> +	ret =3D iio_trigger_register(data->drdy_trig);

devm_iio_trigger_register()

- Nuno S=C3=A1

> +	if (ret)
> +		return ret;
> +
> +	indio_dev->trig =3D iio_trigger_get(data->drdy_trig);
> +
> +	return devm_request_threaded_irq(&data->client->dev, irq,
> +					 NULL,
> +					 mpl3115_interrupt_handler,
> +					 IRQF_ONESHOT,
> +					 "mpl3115_irq",
> +					 indio_dev);
> +}
> +
> =C2=A0static int mpl3115_probe(struct i2c_client *client)
> =C2=A0{
> =C2=A0	const struct i2c_device_id *id =3D i2c_client_get_device_id(client=
);
> @@ -271,6 +424,10 @@ static int mpl3115_probe(struct i2c_client *client)
> =C2=A0	if (ret < 0)
> =C2=A0		return ret;
> =C2=A0
> +	ret =3D mpl3115_trigger_probe(data, indio_dev);
> +	if (ret)
> +		return ret;
> +
> =C2=A0	ret =3D iio_triggered_buffer_setup(indio_dev, NULL,
> =C2=A0		mpl3115_trigger_handler, NULL);
> =C2=A0	if (ret < 0)

