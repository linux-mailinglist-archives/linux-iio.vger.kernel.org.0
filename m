Return-Path: <linux-iio+bounces-2757-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD7F859F90
	for <lists+linux-iio@lfdr.de>; Mon, 19 Feb 2024 10:22:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0C3F1C21249
	for <lists+linux-iio@lfdr.de>; Mon, 19 Feb 2024 09:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF64249FA;
	Mon, 19 Feb 2024 09:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TyPfW4ds"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E76224DA
	for <linux-iio@vger.kernel.org>; Mon, 19 Feb 2024 09:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708334502; cv=none; b=iUwtAqkdoL9DptLjhb2a8oW14OTmtWZgBQexr9pDfVFconIKAqzd/+oGBV9TeiyDue5iCCf1EilvyQMw9phsj9KouSLYGUzeFPAnZ96WJO4dC8Y27zXWnWuHFuJtvH8dPyz53GQpLenTncu44zVktbcqb9NJ+gRkvW2nTOvn2bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708334502; c=relaxed/simple;
	bh=LiYmPTBSXG9MSSDtsj2ckffMgX+6aowFpwrz/VtAmxI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=foq7DTK7PSHDsy42ASbRwyGccS8mEmULcs0iXFTYkiRpiBeMZatvWEQkZXug2NU4sI1ltdwUZwZbEXYtlf66KrRaIA1zCm217YrWDPgPiWU/pq6LdlEu3kkZs5aFq9wnj9W3F1UZacRSKwruLg92drCwAvBGMVF7olISJfA5RB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TyPfW4ds; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a3e4765c86eso151470066b.0
        for <linux-iio@vger.kernel.org>; Mon, 19 Feb 2024 01:21:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708334498; x=1708939298; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ydMqtvxTbZjnvDhr5ev2Sve2MtehjP2W8ynTUIVcbzU=;
        b=TyPfW4dsEmKSJUqp/JsdHCS+EjvUBTZ82TyAvAc5dToIfzRL3ydW26EXiPIVR17U8w
         Opl/01TcMeiKcOSlcKeOjcbf3uHRLBZlMjAu0YZo97B7yDGCytP69Qg+INEWEKpLRlLQ
         /Q6oMAfqK6aWkDJJCOLrSC8KKe9MlgCuzz7VQs3zYM3dh+yaHp8ElQQQDCBoRpTYnzKN
         qu+41AHMkwBTSnzku662d7100LKHXOXELI+GDsE1QcmARP2nJcm/iKbnSu9CY46E0ALw
         gkuaJjBRU5x/O/3jNo8EfbkhvGO6w9YkdFn/hOSccAa4Hu2PmQi5SjeBp0FHvnD+yA19
         IOmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708334498; x=1708939298;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ydMqtvxTbZjnvDhr5ev2Sve2MtehjP2W8ynTUIVcbzU=;
        b=J01k83/yA9+I3gPnXoGd3f93nKYSvrE9Dh2hqR0+DuR9wmap4j5EPvr3akKeYa0XdM
         pIRbAR1+paSf9bTtruF9gwY1frNyrGS1+QcuTzYlx4+6G/87KvCpciwhol/rLvdCQM++
         xUk7HULkRK8g1tBgMrZVNMAhV2JyfsoRwwJV9AfaCgXEqPfm8iWdCt+JB54NDld6exwP
         TsDU9MloQPo6maevn5sSr213ySCHvKT+Ir+Aaha3KPFIezrW/mbN77qN1hPYCsnetnPQ
         OagaF4pYPjPucDNAahvz+5C/YgT2tAJ9UFvZJflK7KoE+XL6E6prz2t6cly/dAl9KrA3
         xSaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXD/WPjNszjTkAUhHiGx/9EFzH1W5K5HrHo3DcC7U8Fg2B4pWUp++Tztex/DxzdsVZYN35gM0xlCYxIkyG+WL2U8L2AMKVy6EC3
X-Gm-Message-State: AOJu0YwxJKIWHmexO/L3ezJeiExC1ZcGNsXLu+XYeDWBpDSI+0WBeS8R
	RxlzMj4n40quTpBh0zRvkKz1hmtmsa83lsSQLwUmpms0k7Wi6RkQ
X-Google-Smtp-Source: AGHT+IGAPajQptjD2pcbZXinkcZqWJAyA8P5wOMA/XFyr6BZ8GKCPAqDKMmaFzISvGxUNSgXZeHLlA==
X-Received: by 2002:a17:906:d0c4:b0:a3e:922f:71b1 with SMTP id bq4-20020a170906d0c400b00a3e922f71b1mr1291943ejb.53.1708334498104;
        Mon, 19 Feb 2024 01:21:38 -0800 (PST)
Received: from ?IPv6:2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47? (p200300f6ef1b2000944ccbc71e1c2c47.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47])
        by smtp.gmail.com with ESMTPSA id r15-20020a170906350f00b00a3e75490c65sm1292219eja.177.2024.02.19.01.21.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 01:21:37 -0800 (PST)
Message-ID: <7f4f569b9e8edd017f92d1fb583bdbe419fe4e87.camel@gmail.com>
Subject: Re: [PATCH 3/8] iio: adc: ad7124: Switch from of specific to fwnode
 based property handling
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org, Andy
	Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>,  Alisa-Dariana Roman <alisa.roman@analog.com>, Haibo
 Chen <haibo.chen@nxp.com>, Sean Nyekjaer <sean@geanix.com>, Andreas Klinger
 <ak@it-klinger.de>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Date: Mon, 19 Feb 2024 10:24:59 +0100
In-Reply-To: <20240218172731.1023367-4-jic23@kernel.org>
References: <20240218172731.1023367-1-jic23@kernel.org>
	 <20240218172731.1023367-4-jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2024-02-18 at 17:27 +0000, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>=20
> Using the generic firmware data access functions from property.h
> provides a number of advantages:
> =C2=A01) Works with different firmware types.
> =C2=A02) Doesn't provide a 'bad' example for new IIO drivers.
> =C2=A03) Lets us use the new _scoped() loops with automatic reference cou=
nt
> =C2=A0=C2=A0=C2=A0 cleanup for fwnode_handle
>=20
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Michael Hennerich <Michael.Hennerich@analog.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---

Just one minor nit from me... Still, fell free to add:

Reviewed-by: Nuno Sa <nuno.sa@analog.com>

> =C2=A0drivers/iio/adc/ad7124.c | 55 +++++++++++++++++--------------------=
---
> =C2=A01 file changed, 23 insertions(+), 32 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
> index b9b206fcd748..e7b1d517d3de 100644
> --- a/drivers/iio/adc/ad7124.c
> +++ b/drivers/iio/adc/ad7124.c
> @@ -14,7 +14,8 @@
> =C2=A0#include <linux/kernel.h>
> =C2=A0#include <linux/kfifo.h>
> =C2=A0#include <linux/module.h>
> -#include <linux/of.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/property.h>
> =C2=A0#include <linux/regulator/consumer.h>
> =C2=A0#include <linux/spi/spi.h>
> =C2=A0
> @@ -807,22 +808,19 @@ static int ad7124_check_chip_id(struct ad7124_state=
 *st)
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0
> -static int ad7124_of_parse_channel_config(struct iio_dev *indio_dev,
> -					=C2=A0 struct device_node *np)
> +static int ad7124_parse_channel_config(struct iio_dev *indio_dev,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct device *dev)
> =C2=A0{
> =C2=A0	struct ad7124_state *st =3D iio_priv(indio_dev);
> =C2=A0	struct ad7124_channel_config *cfg;
> =C2=A0	struct ad7124_channel *channels;
> -	struct device_node *child;
> =C2=A0	struct iio_chan_spec *chan;
> =C2=A0	unsigned int ain[2], channel =3D 0, tmp;
> =C2=A0	int ret;
> =C2=A0
> -	st->num_channels =3D of_get_available_child_count(np);
> -	if (!st->num_channels) {
> -		dev_err(indio_dev->dev.parent, "no channel children\n");
> -		return -ENODEV;
> -	}
> +	st->num_channels =3D device_get_child_node_count(dev);
> +	if (!st->num_channels)
> +		return dev_err_probe(dev, -ENODEV, "no channel children\n");
> =C2=A0
> =C2=A0	chan =3D devm_kcalloc(indio_dev->dev.parent, st->num_channels,
> =C2=A0			=C2=A0=C2=A0=C2=A0 sizeof(*chan), GFP_KERNEL);
> @@ -838,39 +836,38 @@ static int ad7124_of_parse_channel_config(struct ii=
o_dev
> *indio_dev,
> =C2=A0	indio_dev->num_channels =3D st->num_channels;
> =C2=A0	st->channels =3D channels;
> =C2=A0
> -	for_each_available_child_of_node(np, child) {
> +	device_for_each_child_node_scoped(dev, child) {
> =C2=A0		cfg =3D &st->channels[channel].cfg;
> =C2=A0
> -		ret =3D of_property_read_u32(child, "reg", &channel);
> +		ret =3D fwnode_property_read_u32(child, "reg", &channel);
> =C2=A0		if (ret)
> -			goto err;
> +			return ret;
> =C2=A0
> -		if (channel >=3D indio_dev->num_channels) {
> -			dev_err(indio_dev->dev.parent,
> +		if (channel >=3D indio_dev->num_channels)
> +			return dev_err_probe(dev, -EINVAL,
> =C2=A0				"Channel index >=3D number of channels\n");
> -			ret =3D -EINVAL;
> -			goto err;
> -		}
> =C2=A0
> -		ret =3D of_property_read_u32_array(child, "diff-channels",
> -						 ain, 2);
> +		ret =3D fwnode_property_read_u32_array(child, "diff-channels",
> +						=C2=A0=C2=A0=C2=A0=C2=A0 ain, 2);
> =C2=A0		if (ret)
> -			goto err;
> +			return ret;
> =C2=A0
> =C2=A0		st->channels[channel].nr =3D channel;
> =C2=A0		st->channels[channel].ain =3D AD7124_CHANNEL_AINP(ain[0]) |
> =C2=A0						=C2=A0
> AD7124_CHANNEL_AINM(ain[1]);
> =C2=A0
> -		cfg->bipolar =3D of_property_read_bool(child, "bipolar");
> +		cfg->bipolar =3D fwnode_property_read_bool(child, "bipolar");
> =C2=A0
> -		ret =3D of_property_read_u32(child, "adi,reference-select",
> &tmp);
> +		ret =3D fwnode_property_read_u32(child, "adi,reference-select",
> &tmp);
> =C2=A0		if (ret)
> =C2=A0			cfg->refsel =3D AD7124_INT_REF;
> =C2=A0		else
> =C2=A0			cfg->refsel =3D tmp;
> =C2=A0
> -		cfg->buf_positive =3D of_property_read_bool(child,
> "adi,buffered-positive");
> -		cfg->buf_negative =3D of_property_read_bool(child,
> "adi,buffered-negative");
> +		cfg->buf_positive =3D
> +			fwnode_property_read_bool(child, "adi,buffered-
> positive");
> +		cfg->buf_negative =3D
> +			fwnode_property_read_bool(child, "adi,buffered-
> negative");

I think this is one of those cases where 80col limit hurts readability...

- Nuno S=C3=A1



