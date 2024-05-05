Return-Path: <linux-iio+bounces-4813-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 441868BC2E1
	for <lists+linux-iio@lfdr.de>; Sun,  5 May 2024 19:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 653071C20B74
	for <lists+linux-iio@lfdr.de>; Sun,  5 May 2024 17:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E3C50297;
	Sun,  5 May 2024 17:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SQg3g+Tp"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92F936AF5;
	Sun,  5 May 2024 17:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714931228; cv=none; b=hjuXKhtcBdwFgttnJoOF4wBi11PIPs3znEd1pmtfNWBPdDZ2QfJ4+XeszSEAdCeqTZPobjAi+eG31h4CHku8I0WSiGlwR1hkGkU5ZeTtQlxCqJVzT/9CWMpGQ3s1W7RnC1rSI2zpPhYvRttOeCPbqaz7gjR+zm6K+YlLnLnx4TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714931228; c=relaxed/simple;
	bh=lgGXd0jwUma2idY22GRkaZNyTPzjVvVloiGCuFF4b2o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kiIm1FdeykZBSxbMoRC3OmXfuWGfNCC1SCCXYNIGEpeLsu/fzvMeZwmeggOGXHGgL95klEjmXRQSKPyAUuk4n3Nrjx6h2Y+eU76w5OLaz+VOBnyUo5HLl5gLzPGJt67cq5fpd0+6M/Yd8HtM+LCAVZBqx3fhK5cDtWN0+rMMJc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SQg3g+Tp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11AD2C113CC;
	Sun,  5 May 2024 17:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714931228;
	bh=lgGXd0jwUma2idY22GRkaZNyTPzjVvVloiGCuFF4b2o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SQg3g+Tp/N9rX8FDicZSCpjIRvkbVCwoZpuDkY0Yt2cyCZhqWKUuiBAgp37GColwG
	 lSeQm++Gxckeh4y/xrUc0DcdIagI1VDsaAYmjzsoc/sAbDY82U5LJo9zYhrIXWcjkq
	 Y6AhenlE5WnwscgModMv5GjogGNHk5o0Ml+sw/qLLlHTxHRuyy7Ga31S8PkhVxgY2Q
	 ucG3Lq5ak9DaYJVsnh6eEXkriYHdR4U5pjaeRdeU70B0lLCv0bhlrmlYqAIncI5v71
	 pPIqp7an6LgyaeL4LmMP9YIG3WmUSSGLB7NuICxFgLPhjJa4oWbmusG4BPBJYDIUzT
	 7XJvArkiBelsQ==
Date: Sun, 5 May 2024 18:47:00 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Andrew Hepp
 <andrew.hepp@ahepp.dev>, Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] iio: temperature: mcp9600: add threshold events
 support
Message-ID: <20240505184700.5c85b2ba@jic23-huawei>
In-Reply-To: <20240430120535.46097-6-dima.fedrau@gmail.com>
References: <20240430120535.46097-1-dima.fedrau@gmail.com>
	<20240430120535.46097-6-dima.fedrau@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 30 Apr 2024 14:05:35 +0200
Dimitri Fedrau <dima.fedrau@gmail.com> wrote:

> The device has four programmable temperature alert outputs which can be
> used to monitor hot or cold-junction temperatures and detect falling and
> rising temperatures. It supports up to 255 degree celsius programmable
> hysteresis. Each alert can be individually configured by setting following
> options in the associated alert configuration register:
>   - monitor hot or cold junction temperature
>   - monitor rising or falling temperature
>   - set comparator or interrupt mode
>   - set output polarity
>   - enable alert
>=20
> This patch binds alert outputs to iio events:
>   - alert1: hot junction, rising temperature
>   - alert2: hot junction, falling temperature
>   - alert3: cold junction, rising temperature
>   - alert4: cold junction, falling temperature
>=20
> All outputs are set in comparator mode and polarity depends on interrupt
> configuration.
>=20
> Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
> ---
Various comments inline.

Jonathan

>  drivers/iio/temperature/mcp9600.c | 358 +++++++++++++++++++++++++++++-
>  1 file changed, 354 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/iio/temperature/mcp9600.c b/drivers/iio/temperature/=
mcp9600.c
> index cb1c1c1c361d..f7e1b4e3253d 100644
> --- a/drivers/iio/temperature/mcp9600.c
> +++ b/drivers/iio/temperature/mcp9600.c
> @@ -6,21 +6,80 @@
>   * Author: <andrew.hepp@ahepp.dev>
>   */
> =20
> +#include <linux/bitfield.h>
> +#include <linux/bitops.h>
>  #include <linux/err.h>
>  #include <linux/i2c.h>
>  #include <linux/init.h>
> +#include <linux/math.h>
> +#include <linux/minmax.h>
>  #include <linux/mod_devicetable.h>
>  #include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/units.h>
> =20
> +#include <linux/iio/events.h>
>  #include <linux/iio/iio.h>
> =20
>  /* MCP9600 registers */
> -#define MCP9600_HOT_JUNCTION 0x0

As below. Reformating in a precursor patch. I wouldn't necessarily bother
though as aligning defines is usually more effort than it is worth over tim=
e.

> -#define MCP9600_COLD_JUNCTION 0x2
> -#define MCP9600_DEVICE_ID 0x20
> +#define MCP9600_HOT_JUNCTION		0x0
> +#define MCP9600_COLD_JUNCTION		0x2
> +#define MCP9600_STATUS			0x4
> +#define MCP9600_STATUS_ALERT(x)		BIT(x)
> +#define MCP9600_ALERT_CFG1		0x8
> +#define MCP9600_ALERT_CFG(x)		(MCP9600_ALERT_CFG1 + (x - 1))
> +#define MCP9600_ALERT_CFG_ENABLE	BIT(0)
> +#define MCP9600_ALERT_CFG_ACTIVE_HIGH	BIT(2)
> +#define MCP9600_ALERT_CFG_FALLING	BIT(3)
> +#define MCP9600_ALERT_CFG_COLD_JUNCTION	BIT(4)
> +#define MCP9600_ALERT_HYSTERESIS1	0xc
> +#define MCP9600_ALERT_HYSTERESIS(x)	(MCP9600_ALERT_HYSTERESIS1 + (x - 1))
> +#define MCP9600_ALERT_LIMIT1		0x10
> +#define MCP9600_ALERT_LIMIT(x)		(MCP9600_ALERT_LIMIT1 + (x - 1))
> +
> +#define MCP9600_DEVICE_ID		0x20
> =20
>  /* MCP9600 device id value */
> -#define MCP9600_DEVICE_ID_MCP9600 0x40
> +#define MCP9600_DEVICE_ID_MCP9600	0x40

If you want to reformatting existing lines, do it in a precursor patch - not
buried in here.

> =20
>  struct mcp9600_data {
>  	struct i2c_client *client;
> +	struct mutex lock[MCP9600_ALERT_COUNT];

All locks need documentation.  What data is this protecting?

> +	int irq[MCP9600_ALERT_COUNT];
>  };
> =20
>  static int mcp9600_read(struct mcp9600_data *data,
> @@ -83,10 +148,292 @@ static int mcp9600_read_raw(struct iio_dev *indio_d=
ev,
>  	}
>  }
> =20
> +static int mcp9600_get_alert_index(int channel2, enum iio_event_directio=
n dir)
> +{
> +	switch (channel2) {
> +	case IIO_MOD_TEMP_OBJECT:
> +		if (dir =3D=3D IIO_EV_DIR_RISING)
> +			return MCP9600_ALERT1;
> +		else
> +			return MCP9600_ALERT2;
> +	case IIO_MOD_TEMP_AMBIENT:
> +		if (dir =3D=3D IIO_EV_DIR_RISING)
> +			return MCP9600_ALERT3;
> +		else
> +			return MCP9600_ALERT4;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int mcp9600_read_event_config(struct iio_dev *indio_dev,
> +				     const struct iio_chan_spec *chan,
> +				     enum iio_event_type type,
> +				     enum iio_event_direction dir)
> +{
> +	struct mcp9600_data *data =3D iio_priv(indio_dev);
> +	struct i2c_client *client =3D data->client;
> +	int i, ret;
> +
> +	i =3D mcp9600_get_alert_index(chan->channel2, dir);
> +	if (i < 0)
> +		return i;
> +
> +	ret =3D i2c_smbus_read_byte_data(client, MCP9600_ALERT_CFG(i + 1));
> +	if (ret < 0)
> +		return ret;
> +
> +	return (ret & MCP9600_ALERT_CFG_ENABLE);

FIELD_GET() even if it happens to be bit(0) as then we don't have to go
check that's the case.

> +}
> +
> +static int mcp9600_write_event_config(struct iio_dev *indio_dev,
> +				      const struct iio_chan_spec *chan,
> +				      enum iio_event_type type,
> +				      enum iio_event_direction dir,
> +				      int state)
> +{
> +	struct mcp9600_data *data =3D iio_priv(indio_dev);
> +	struct i2c_client *client =3D data->client;
> +	int i, ret;
> +
> +	i =3D mcp9600_get_alert_index(chan->channel2, dir);
> +	if (i < 0)
> +		return i;
> +
> +	ret =3D i2c_smbus_read_byte_data(client, MCP9600_ALERT_CFG(i + 1));
> +	if (ret < 0)
> +		return ret;
> +
> +	if (state)
> +		ret |=3D MCP9600_ALERT_CFG_ENABLE;
> +	else
> +		ret &=3D ~MCP9600_ALERT_CFG_ENABLE;
> +
> +	return i2c_smbus_write_byte_data(client, MCP9600_ALERT_CFG(i + 1), ret);

A read modify write cycle like this normally needs some locking to ensure a=
nother
access didn't change the other bits in the register.


> +}
> +
> +static int mcp9600_read_thresh(struct iio_dev *indio_dev,
> +			       const struct iio_chan_spec *chan,
> +			       enum iio_event_type type,
> +			       enum iio_event_direction dir,
> +			       enum iio_event_info info, int *val, int *val2)
> +{
> +	struct mcp9600_data *data =3D iio_priv(indio_dev);
> +	struct i2c_client *client =3D data->client;
> +	s32 ret;
> +	int i;
> +
> +	i =3D mcp9600_get_alert_index(chan->channel2, dir);
> +	if (i < 0)
> +		return i;
> +
> +	guard(mutex)(&data->lock[i]);
> +	ret =3D i2c_smbus_read_word_swapped(client, MCP9600_ALERT_LIMIT(i + 1));
> +	if (ret < 0)
> +		return ret;
> +
> +	/*
> +	 * Temperature is stored in two=E2=80=99s complement format in bits(15:=
2),
> +	 * LSB is 0.25 degree celsius.
> +	 */
> +	*val =3D sign_extend32(ret, 15) >> 2;
Use sign_extend32(FIELD_GET(...), 13)
So which bits are extracted is obvious in the code.

> +	*val2 =3D 4;
> +	if (info =3D=3D IIO_EV_INFO_VALUE)
> +		return IIO_VAL_FRACTIONAL;
> +
> +	ret =3D i2c_smbus_read_byte_data(client, MCP9600_ALERT_HYSTERESIS(i + 1=
));
> +	if (ret < 0)
> +		return ret;
> +
> +	/*
> +	 * Hysteresis is stored as offset which is not signed, therefore we have
> +	 * to include directions when calculating the real hysteresis value.
> +	 */
> +	if (dir =3D=3D IIO_EV_DIR_RISING)
> +		*val -=3D (*val2 * ret);
> +	else
> +		*val +=3D (*val2 * ret);

I don't follow this maths.  Hysteresis is an unsigned offset.  Maybe some c=
onfusion
over the ABI? =20

> +
> +	return IIO_VAL_FRACTIONAL;
> +}
> +
> +static int mcp9600_write_thresh(struct iio_dev *indio_dev,
> +				const struct iio_chan_spec *chan,
> +				enum iio_event_type type,
> +				enum iio_event_direction dir,
> +				enum iio_event_info info, int val, int val2)
> +{
> +	struct mcp9600_data *data =3D iio_priv(indio_dev);
> +	struct i2c_client *client =3D data->client;
> +	int s_val, s_thresh, i;
> +	s16 thresh;
> +	s32 ret;
> +	u8 hyst;
> +
> +	/* Scale value to include decimal part into calculations */
> +	s_val =3D (val < 0) ? ((val * (int)MICRO) - val2) :
> +			    ((val * (int)MICRO) + val2);
> +
> +	/* Hot junction temperature range is from =E2=80=93200 to 1800 degree c=
elsius */
> +	if (chan->channel2 =3D=3D IIO_MOD_TEMP_OBJECT &&
> +	   (s_val < (MCP9600_MIN_TEMP_HOT_JUNCTION * (int)MICRO) ||
> +	    s_val > (MCP9600_MAX_TEMP_HOT_JUNCTION * (int)MICRO)))

Why the casts?

> +		return -EINVAL;
> +
> +	/* Cold junction temperature range is from =E2=80=9340 to 125 degree ce=
lsius */
> +	if (chan->channel2 =3D=3D IIO_MOD_TEMP_AMBIENT &&
> +	   (s_val < (MCP9600_MIN_TEMP_COLD_JUNCTION * (int)MICRO) ||
> +	    s_val > (MCP9600_MAX_TEMP_COLD_JUNCTION * (int)MICRO)))
> +		return -EINVAL;
> +
> +	i =3D mcp9600_get_alert_index(chan->channel2, dir);
> +	if (i < 0)
> +		return i;
> +
> +	guard(mutex)(&data->lock[i]);
> +	if (info =3D=3D IIO_EV_INFO_VALUE) {

I would use a switch statement so it is obvious what each case is.

> +		/*
> +		 * Shift length 4 bits =3D 2(15:2) + 2(0.25 LSB), temperature is
> +		 * stored in two=E2=80=99s complement format.
> +		 */
> +		thresh =3D (s16)(s_val / (int)(MICRO >> 4));
> +		return i2c_smbus_write_word_swapped(client,
> +						    MCP9600_ALERT_LIMIT(i + 1),
> +						    thresh);
> +	}
> +
> +	/* Read out threshold, hysteresis is stored as offset */
> +	ret =3D i2c_smbus_read_word_swapped(client, MCP9600_ALERT_LIMIT(i + 1));
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Shift length 4 bits =3D 2(15:2) + 2(0.25 LSB), see above. */
> +	s_thresh =3D sign_extend32(ret, 15) * (int)(MICRO >> 4);
> +
> +	/*
> +	 * Hysteresis is stored as offset, for rising temperatures, the
> +	 * hysteresis range is below the alert limit where, as for falling
> +	 * temperatures, the hysteresis range is above the alert limit.
> +	 */
> +	hyst =3D min(255, abs(s_thresh - s_val) / MICRO);
> +
> +	return i2c_smbus_write_byte_data(client,
> +					 MCP9600_ALERT_HYSTERESIS(i + 1),
> +					 hyst);
> +}
> +
>  static const struct iio_info mcp9600_info =3D {
>  	.read_raw =3D mcp9600_read_raw,
> +	.read_event_config =3D mcp9600_read_event_config,
> +	.write_event_config =3D mcp9600_write_event_config,
> +	.read_event_value =3D mcp9600_read_thresh,
> +	.write_event_value =3D mcp9600_write_thresh,
>  };
> =20
> +static irqreturn_t mcp9600_alert_handler(int irq, void *private)
> +{
> +	struct iio_dev *indio_dev =3D private;
> +	struct mcp9600_data *data =3D iio_priv(indio_dev);
> +	enum iio_event_direction dir;
> +	enum iio_modifier mod;
> +	int i, ret;
> +
> +	for (i =3D 0; i < MCP9600_ALERT_COUNT; i++) {
> +		if (data->irq[i] =3D=3D irq)

This search for a match is a little messy. I'd be tempted
to wrap the generic handler in a per instance interrupt handler
(so have 4 functions) and thus move this matching to the place
where they are registered, not the interrupt handler.

There isn't a lot of shared code in here so you may be better
off just having 4 separate interrupt handler implementations.

> +			break;
> +	}
> +
> +	if (i >=3D MCP9600_ALERT_COUNT)
> +		return IRQ_NONE;
> +
> +	ret =3D i2c_smbus_read_byte_data(data->client, MCP9600_STATUS);
> +	if (ret < 0)
> +		return IRQ_HANDLED;
> +
> +	switch (ret & MCP9600_STATUS_ALERT(i)) {
> +	case 0:
> +		return IRQ_NONE;
> +	case MCP9600_STATUS_ALERT(MCP9600_ALERT1):
> +		mod =3D IIO_MOD_TEMP_OBJECT;
> +		dir =3D IIO_EV_DIR_RISING;
> +		break;
> +	case MCP9600_STATUS_ALERT(MCP9600_ALERT2):
> +		mod =3D IIO_MOD_TEMP_OBJECT;
> +		dir =3D IIO_EV_DIR_FALLING;
> +		break;
> +	case MCP9600_STATUS_ALERT(MCP9600_ALERT3):
> +		mod =3D IIO_MOD_TEMP_AMBIENT;
> +		dir =3D IIO_EV_DIR_RISING;
> +		break;
> +	case MCP9600_STATUS_ALERT(MCP9600_ALERT4):
> +		mod =3D IIO_MOD_TEMP_AMBIENT;
> +		dir =3D IIO_EV_DIR_FALLING;
> +		break;
> +	default:
> +		return IRQ_HANDLED;
> +	}
> +
> +	iio_push_event(indio_dev,
> +		       IIO_MOD_EVENT_CODE(IIO_TEMP, 0, mod,
> +					  IIO_EV_TYPE_THRESH, dir),
> +		       iio_get_time_ns(indio_dev));
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int mcp9600_probe_alerts(struct iio_dev *indio_dev)
> +{
> +	struct mcp9600_data *data =3D iio_priv(indio_dev);
> +	struct i2c_client *client =3D data->client;
> +	struct device *dev =3D &client->dev;
> +	struct fwnode_handle *fwnode =3D dev_fwnode(dev);
> +	unsigned int irq_type;
> +	int ret, irq, i;
> +	u8 val;
> +
> +	/*
> +	 * alert1: hot junction, rising temperature
> +	 * alert2: hot junction, falling temperature
> +	 * alert3: cold junction, rising temperature
> +	 * alert4: cold junction, falling temperature
> +	 */
> +	for (i =3D 0; i < MCP9600_ALERT_COUNT; i++) {
> +		data->irq[i] =3D 0;

All of data is zeroed already so this should not be needed.

> +		mutex_init(&data->lock[i]);

Why per interrupt locks?  Seems unlikely to be a big problem
to share one.

> +		irq =3D fwnode_irq_get_byname(fwnode, mcp9600_alert_name[i]);
> +		if (irq <=3D 0)
> +			continue;
> +
> +		val =3D 0;
> +		irq_type =3D irq_get_trigger_type(irq);
> +		if (irq_type =3D=3D IRQ_TYPE_EDGE_RISING)
> +			val |=3D MCP9600_ALERT_CFG_ACTIVE_HIGH;
> +
> +		if (i =3D=3D MCP9600_ALERT2 || i =3D=3D MCP9600_ALERT4)
> +			val |=3D MCP9600_ALERT_CFG_FALLING;
> +
> +		if (i =3D=3D MCP9600_ALERT3 || i =3D=3D MCP9600_ALERT4)
> +			val |=3D MCP9600_ALERT_CFG_COLD_JUNCTION;
> +
> +		ret =3D i2c_smbus_write_byte_data(client,
> +						MCP9600_ALERT_CFG(i + 1),
> +						val);
> +		if (ret < 0)
> +			return ret;
> +
> +		ret =3D devm_request_threaded_irq(dev, irq, NULL,
> +						mcp9600_alert_handler,
> +						IRQF_ONESHOT, "mcp9600",
> +						indio_dev);
> +		if (ret)
> +			return ret;
> +
> +		data->irq[i] =3D irq;
> +	}
> +
> +	return 0;
> +}
> +
>  static int mcp9600_probe(struct i2c_client *client)
>  {
>  	struct device *dev =3D &client->dev;
> @@ -109,6 +456,8 @@ static int mcp9600_probe(struct i2c_client *client)
>  	data =3D iio_priv(indio_dev);
>  	data->client =3D client;
> =20
> +	mcp9600_probe_alerts(indio_dev);

Why no error check?=20

> +
>  	indio_dev->info =3D &mcp9600_info;
>  	indio_dev->name =3D "mcp9600";
>  	indio_dev->modes =3D INDIO_DIRECT_MODE;
> @@ -140,6 +489,7 @@ static struct i2c_driver mcp9600_driver =3D {
>  };
>  module_i2c_driver(mcp9600_driver);
> =20
> +MODULE_AUTHOR("Dimitri Fedrau <dima.fedrau@gmail.com>");
>  MODULE_AUTHOR("Andrew Hepp <andrew.hepp@ahepp.dev>");
>  MODULE_DESCRIPTION("Microchip MCP9600 thermocouple EMF converter driver"=
);
>  MODULE_LICENSE("GPL");


