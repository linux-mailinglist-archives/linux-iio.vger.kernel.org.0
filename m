Return-Path: <linux-iio+bounces-22622-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4998EB22C33
	for <lists+linux-iio@lfdr.de>; Tue, 12 Aug 2025 17:53:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DEF437B6BA3
	for <lists+linux-iio@lfdr.de>; Tue, 12 Aug 2025 15:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9412F8BE0;
	Tue, 12 Aug 2025 15:51:28 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF252F8BC0;
	Tue, 12 Aug 2025 15:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755013888; cv=none; b=jSXAI/cJnKsBXsFTMNWQ8WuGGzdS57XCm/Squ9S3knl/IIXYMQU8Rm3kitCXKkfk5DmeQu5I4SkUPFmtdvsscxYTdTHWjnDq7QA6gJwSzbzvkoKt5MarXhUBvp6H6uenr1RfDkeTy+zAmxqr0unxc8A7K0nqbKql6rBbp/rldXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755013888; c=relaxed/simple;
	bh=cdXT8AVx8pqaZS/+Q3ats7KiTGHzgAqxLywHSBVRKA4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gKk4NrlC4aR59MtcajWkvjc+bcFhwnsaVdZ5qa/uoMymnmlsFJH6W/7Tj7esy4Wk83vm6c2weFGJlhaelVU8Qdo4GbGmOzoDJXBAi29pvtF6mKD9XcPTF0Z5wgLEIiQMoVZ5p901EVWl/qLEVzM2n0sYvJEl8nJHCPeVTXcnuIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4c1bXj5d5Gz6M4cP;
	Tue, 12 Aug 2025 23:49:25 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 3B45A140427;
	Tue, 12 Aug 2025 23:51:22 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 12 Aug
 2025 17:51:21 +0200
Date: Tue, 12 Aug 2025 16:51:20 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Ben Collins <bcollins@kernel.org>
CC: <linux-iio@vger.kernel.org>, Andrew Hepp <andrew.hepp@ahepp.dev>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Nuno
 =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Subject: Re: [PATCH] mcp9600: Add support for mcp9601 and sensor config
Message-ID: <20250812165120.00004f37@huawei.com>
In-Reply-To: <6esdq4e4r7vmxwlyfs4a3sgdomazxospr3go2oaqkwhpgw6mkh@hdca2d3f6zwp>
References: <6esdq4e4r7vmxwlyfs4a3sgdomazxospr3go2oaqkwhpgw6mkh@hdca2d3f6zwp>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 12 Aug 2025 09:08:30 -0400
Ben Collins <bcollins@kernel.org> wrote:

> The mcp9600 dt binding doc claims to support thermocouple-type but
> I don't see where this is implemented.
>=20
> - Add support to detect mcp9601 device type
> - Add support to use thermocouple-type dt prop
> - Add thrermocouple iio info to get/set this from sysfs
> - Add filter-level dt prop to set the filtering level of the chip
> - Update dt binding docs
>=20
> Signed-off-by: Ben Collins <bcollins@kernel.org>
> Cc: Andrew Hepp <andrew.hepp@ahepp.dev>
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-iio@vger.kernel.org
> Cc: "Nuno S=E1" <nuno.sa@analog.com>

Hi

I tried not to overlap too much with David's review.
A few additional things inline.

Jonathan

> diff --git a/drivers/iio/temperature/mcp9600.c b/drivers/iio/temperature/=
mcp9600.c
> index 6e9108d5cf75f..c1fe1e530786c 100644
> --- a/drivers/iio/temperature/mcp9600.c
> +++ b/drivers/iio/temperature/mcp9600.c

> +
> +static int mcp9600_write_raw_get_fmt(struct iio_dev *indio_dev,
> +				     struct iio_chan_spec const *chan,
> +				     long mask)
> +{
> +	switch (mask) {
> +	case IIO_CHAN_INFO_THERMOCOUPLE_TYPE:
> +		return IIO_VAL_CHAR;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int mcp9600_config(struct mcp9600_data *data)
> +{
> +	struct i2c_client *client =3D data->client;
> +	int ret, cfg;
> +
> +	cfg  =3D MCP9600_SENSOR_TYPE(mcp9600_type_map[data->thermocouple_type])=
 |
> +		MCP9600_FILTER(data->filter);
> +
> +	ret =3D i2c_smbus_write_byte_data(client, MCP9600_SENSOR_CFG, cfg);
> +
No blank line here. Keep error check associated with the call.
> +	if (ret < 0) {
> +		dev_err(&client->dev, "Failed to set sensor configuration\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int mcp9600_write_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     int val, int val2, long mask)
> +{
> +	struct mcp9600_data *data =3D iio_priv(indio_dev);
> +	int tc_type =3D -1;
> +	int i, ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_THERMOCOUPLE_TYPE:
If this is something we specify in DT (which I think is valid) then
we probably should not allow override from userspace.

We might want a read only parameter though as type of thermocouple is
probably something that is useful to be able to read back.

> +		for (i =3D 0; i < ARRAY_SIZE(mcp9600_tc_types); i++) {
> +			if (mcp9600_tc_types[i] =3D=3D toupper(val)) {
> +				tc_type =3D i;
> +				break;
> +			}
> +		}
> +		if (tc_type < 0)
> +			return -EINVAL;
> +
> +		data->thermocouple_type =3D tc_type;
> +		ret =3D mcp9600_config(data);
> +		if (ret < 0)
> +			return ret;
		return mcp9600_config(data);
Assuming that never returns > 0.
> +
> +		break;
> +
>  	default:
>  		return -EINVAL;
>  	}
> +
> +	return 0;
Might as well return rather than break above.
>  }


>  static irqreturn_t mcp9600_alert_handler(void *private,
> @@ -418,26 +538,65 @@ static int mcp9600_probe(struct i2c_client *client)
>  {
>  	struct iio_dev *indio_dev;
>  	struct mcp9600_data *data;
> -	int ret, ch_sel;
> +	int ch_sel, dev_id, ret;
> =20
> -	ret =3D i2c_smbus_read_byte_data(client, MCP9600_DEVICE_ID);
> -	if (ret < 0)
> -		return dev_err_probe(&client->dev, ret, "Failed to read device ID\n");
> -	if (ret !=3D MCP9600_DEVICE_ID_MCP9600)
> -		dev_warn(&client->dev, "Expected ID %x, got %x\n",
> -				MCP9600_DEVICE_ID_MCP9600, ret);
> +	dev_id =3D i2c_smbus_read_byte_data(client, MCP9600_DEVICE_ID);
> +	if (dev_id < 0)
> +		return dev_err_probe(&client->dev, dev_id, "Failed to read device ID\n=
");
> +
> +	switch (dev_id) {
> +	case MCP9600_DEVICE_ID_MCP9600:
> +		dev_info(&client->dev, "Identified as mcp9600");

Too noisy.  It is fine to over ride the DT compatible if we match a known I=
D, but if
not paper over the missmatch so that in future a new chip can be supported =
via
a fall back compatible entry without a kernel upgrade.  dev_info on an unkn=
own
device is fine though.

> +		break;
> +	case MCP9600_DEVICE_ID_MCP9601:
> +		dev_info(&client->dev, "Identified as mcp9601");
> +		break;
> +
> +	default:
> +		return dev_err_probe(&client->dev, -EINVAL, "Unknown device ID: %x\n",
> +				     dev_id);
> +	}
> =20
>  	indio_dev =3D devm_iio_device_alloc(&client->dev, sizeof(*data));
>  	if (!indio_dev)
>  		return -ENOMEM;
> =20
>  	data =3D iio_priv(indio_dev);
> +
> +	ret =3D device_property_read_u32(&client->dev, "thermocouple-type",
> +				       &data->thermocouple_type);
> +	if (ret) {

Likewise, must have a default value if it wasn't there from start so with
that in mind can use a similar pattern to the below suggestion.


> +		dev_warn(&client->dev,
> +			 "Missing thermocouple-type property, using Type-K\n");
> +		data->thermocouple_type =3D THERMOCOUPLE_TYPE_K;
> +	} else if (data->thermocouple_type < 0 || data->thermocouple_type >=3D
> +		   ARRAY_SIZE(mcp9600_type_map)) {
> +		dev_warn(&client->dev,
> +			 "Invalid thermocouple-type property, using Type-K\n");
> +		data->thermocouple_type =3D THERMOCOUPLE_TYPE_K;
> +	}
> +
> +	ret =3D device_property_read_u32(&client->dev, "filter-level",
> +				       &data->filter);
> +	if (ret) {
> +		dev_warn(&client->dev,
> +			 "Missing filter-level property, using 0\n");
> +		data->filter =3D 0;
If we were keeping this a common pattern for this sort of property (which c=
an't
be required as wasn't there from the start) is
make data->filter a u32 if it isn't already.

	data->filter =3D 0;
	device_property_read_u32(&client->dev, "filter-level", &data->filter);
	if (data->filter > 7) {
		dev_warn(&...
		data->filter =3D 0;
	}

That is rely on no side effects in the property read if it returns an error,
unsigned property not less than 0  and that 0 is an allowed value.

However as David said unlikely to be something that belongs in DT.


> +	} else if (data->filter < 0 || data->filter > 7) {
> +		dev_warn(&client->dev,
> +			 "Invalid filter-level property, using 0\n");
> +		data->filter =3D 0;
> +	}
> +
> +	data->dev_id =3D dev_id;
>  	data->client =3D client;
> =20
>  	ch_sel =3D mcp9600_probe_alerts(indio_dev);
>  	if (ch_sel < 0)
>  		return ch_sel;
> =20
> +	mcp9600_config(data);
> +
>  	indio_dev->info =3D &mcp9600_info;
>  	indio_dev->name =3D "mcp9600";
>  	indio_dev->modes =3D INDIO_DIRECT_MODE;


