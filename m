Return-Path: <linux-iio+bounces-5116-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CCAA38C9546
	for <lists+linux-iio@lfdr.de>; Sun, 19 May 2024 18:43:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FF921F217DE
	for <lists+linux-iio@lfdr.de>; Sun, 19 May 2024 16:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B897D4CE04;
	Sun, 19 May 2024 16:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qe+hR989"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728801E867;
	Sun, 19 May 2024 16:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716136979; cv=none; b=Qh+TgL8O7yd57rPgIdaeZi9ulVFxaYBCqzWXJVTfVB621BfHXwwtBxDZkfKB0MNJG2jsmAc14AS6CZMCW0kIqtUALTzbqgGDCea3YJZTcsX6Q9tjR9ts1AApyb4t3w5jiYhF2nTOVKygtx+P9WTEx20MEiNULDWYajJMTkYuI+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716136979; c=relaxed/simple;
	bh=nQ6/JUs/BT0cryzioXwW2F5LIo5jOlAOmJQ8JI0DmEY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f4FQbSV32I3erBPtLxvqI08PEu4KJ/dSld3VY0GZawtNocSpW4SO17EguGGGq+lnN67tfdAENt6OSW8zuBdL+8ffnnGnOYpnXA+EUJYfxeGq+6jzDypHsyWxfvPSjbR2I+qCM+K9vI6VdmBAZFXw99xL+h4brm8DXryElF6Remo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qe+hR989; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 833F0C32781;
	Sun, 19 May 2024 16:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716136979;
	bh=nQ6/JUs/BT0cryzioXwW2F5LIo5jOlAOmJQ8JI0DmEY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Qe+hR989oB1bT0GsGN/ESInllYkDRxwSexCGwcaFN8dy1WJ6grjzXX+G+w+BlkLfP
	 XArE0wRKH9//tqtD04SSN23KjgiNaTGjxrT/CYvVm5TJJOAnaH1OVLIBSIyslo0o+R
	 E8AY5ra0B8fHRuIbDx6POM001IUTGpkxNRJi4bX4+u+8q7SmnXxN5adhkcThzLFAdj
	 /X2e1tpE72z853t1n1qNKspG7/j1196f4LlK9zf7CeF6IxBgfG0LbIPOfMyXmwCJdT
	 jFdXXRZNOHt0RZGr6KJob6ox6EMtUGXu4dCy231cN7xs8L9DQPZXGmCNlhGNZzvzZm
	 w7b68tvy5OxLA==
Date: Sun, 19 May 2024 17:42:48 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Andrew Hepp
 <andrew.hepp@ahepp.dev>, Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: temperature: mcp9600: add threshold events
 support
Message-ID: <20240519174248.69f00448@jic23-huawei>
In-Reply-To: <20240517081050.168698-3-dima.fedrau@gmail.com>
References: <20240517081050.168698-1-dima.fedrau@gmail.com>
	<20240517081050.168698-3-dima.fedrau@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 17 May 2024 10:10:50 +0200
Dimitri Fedrau <dima.fedrau@gmail.com> wrote:

> The device has four programmable temperature alert outputs which can be
> used to monitor hot or cold-junction temperatures and detect falling and
> rising temperatures. It supports up to 255 degree celsius programmable
> hysteresis. Each alert can be individually configured by setting following
> options in the associated alert configuration register:
> - monitor hot or cold junction temperature
> - monitor rising or falling temperature
> - set comparator or interrupt mode
> - set output polarity
> - enable alert
>=20
> This patch binds alert outputs to iio events:
> - alert1: hot junction, rising temperature
> - alert2: hot junction, falling temperature
> - alert3: cold junction, rising temperature
> - alert4: cold junction, falling temperature
>=20
> All outputs are set in comparator mode and polarity depends on interrupt
> configuration.
>=20
> Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
Hi Dmitri
Please make sure to address all questions in earlier reviews, either by
changing the code, or directly answering the question.

The hysteresis handling in here is completely different from normal
and the diagrams in figure 5-10 suggest it should not be.

Your thresholds should not include hysteresis at all as it has nothing to
do with event triggering. The hysteresis is presented to userspace so it
knows when a 'reset' of event detection logic occurs. It is expressed
as an offset (in the obvious direction) from the current threshold.

It is always positive as negative hysteresis would be very odd. It's just
magnitude of how far back beyond the threshold the signal must go for
a reset of the signal detection logic to occur, allowing new transitions et=
c.

As long as you are using an edge interrupt that just means you won't get
another interrupt until getting well away from what triggered the interrupt
last time.

Jonathan

> ---
>  drivers/iio/temperature/mcp9600.c | 389 ++++++++++++++++++++++++++++++
>  1 file changed, 389 insertions(+)
>=20
> diff --git a/drivers/iio/temperature/mcp9600.c b/drivers/iio/temperature/=
mcp9600.c
> index 22451d1d9e1f..91d811fe9371 100644
> --- a/drivers/iio/temperature/mcp9600.c
> +++ b/drivers/iio/temperature/mcp9600.c
> @@ -6,12 +6,21 @@
>   * Author: <andrew.hepp@ahepp.dev>
>   */
> =20
> +#include <linux/bitfield.h>
> +#include <linux/bitops.h>
> +#include <linux/bits.h>
>  #include <linux/err.h>
>  #include <linux/i2c.h>
>  #include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/math.h>
> +#include <linux/minmax.h>
>  #include <linux/mod_devicetable.h>
>  #include <linux/module.h>
> +#include <linux/mutex.h>
> =20
> +#include <linux/iio/events.h>
>  #include <linux/iio/iio.h>
> =20
>  #define MCP9600_CHAN_HOT_JUNCTION	0
> @@ -20,11 +29,65 @@
>  /* MCP9600 registers */
>  #define MCP9600_HOT_JUNCTION 0x0
>  #define MCP9600_COLD_JUNCTION 0x2
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
> +#define MCP9600_ALERT_LIMIT_MASK	GENMASK(15, 2)
>  #define MCP9600_DEVICE_ID 0x20
> =20
>  /* MCP9600 device id value */
>  #define MCP9600_DEVICE_ID_MCP9600 0x40
> =20
> +#define MCP9600_ALERT_COUNT		4
> +
> +#define MCP9600_TEMP_SCALE_NUM		1000000

MICRO or just use that inline.

> +
> +#define MCP9600_MIN_TEMP_HOT_JUNCTION	-200
> +#define MCP9600_MAX_TEMP_HOT_JUNCTION	1800
Give these units in the naming and  you can include the * MICRO here.
e.g.
#define MCP9600_MIN_TEMP_HOT_JUNC_MICROCELCIUS -200 * MICRO
etc


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
> +	i =3D mcp9600_get_alert_index(chan->channel, dir);
> +	guard(mutex)(&data->lock);
> +	ret =3D i2c_smbus_read_word_swapped(client, MCP9600_ALERT_LIMIT(i + 1));
> +	if (ret < 0)
> +		return ret;
> +
> +	/*
> +	 * Temperature is stored in two=E2=80=99s complement format in bits(15:=
2),
> +	 * LSB is 0.25 degree celsius.
> +	 */
> +	*val =3D sign_extend32(FIELD_GET(MCP9600_ALERT_LIMIT_MASK, ret), 13);
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
> +	 * Hysteresis is stored as unsigned offset from threshold. The alert
> +	 * direction bit in the alert configuration register defines whether the
> +	 * value is below or above the corresponding threshold.

I'm still very very confused by this.  I raised a question in the first rev=
iew
and you didn't provide more information.
This is not how hysteresis is normally defined.  It should not affect the
threshold at all, but instead affect when a reset occurs of the threshold d=
etection
logic. It also does not correspond to the diagrams in Figure 5-10 which look
exactly like normal hysteresis controls.


> +	 */
> +	if (dir =3D=3D IIO_EV_DIR_RISING)
> +		*val -=3D (*val2 * ret);
> +	else
> +		*val +=3D (*val2 * ret);
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
> +	s_val =3D (val < 0) ? ((val * MCP9600_TEMP_SCALE_NUM) - val2) :
> +			    ((val * MCP9600_TEMP_SCALE_NUM) + val2);
> +
> +	/* Hot junction temperature range is from =E2=80=93200 to 1800 degree c=
elsius */
> +	if (chan->channel =3D=3D MCP9600_CHAN_HOT_JUNCTION &&
> +	   (s_val < (MCP9600_MIN_TEMP_HOT_JUNCTION * MCP9600_TEMP_SCALE_NUM) ||
> +	    s_val > (MCP9600_MAX_TEMP_HOT_JUNCTION * MCP9600_TEMP_SCALE_NUM)))

As above, change the units of the defines to simplify this or perhaps
just treat these as numbers and put them here rather than using defines at =
all.

> +		return -EINVAL;
> +
> +	/* Cold junction temperature range is from =E2=80=9340 to 125 degree ce=
lsius */
> +	if (chan->channel =3D=3D MCP9600_CHAN_COLD_JUNCTION &&
> +	   (s_val < (MCP9600_MIN_TEMP_COLD_JUNCTION * MCP9600_TEMP_SCALE_NUM) ||
> +	    s_val > (MCP9600_MAX_TEMP_COLD_JUNCTION * MCP9600_TEMP_SCALE_NUM)))
> +		return -EINVAL;
> +
> +	i =3D mcp9600_get_alert_index(chan->channel, dir);
> +	guard(mutex)(&data->lock);
> +	switch (info) {
> +	case IIO_EV_INFO_VALUE:
> +		/*
> +		 * Shift length 4 bits =3D 2(15:2) + 2(0.25 LSB), temperature is
> +		 * stored in two=E2=80=99s complement format.
> +		 */
> +		thresh =3D (s16)(s_val / (MCP9600_TEMP_SCALE_NUM >> 4));
> +		return i2c_smbus_write_word_swapped(client,
> +						    MCP9600_ALERT_LIMIT(i + 1),
> +						    thresh);
> +	case IIO_EV_INFO_HYSTERESIS:
> +		/* Read out threshold, hysteresis is stored as offset */
> +		ret =3D i2c_smbus_read_word_swapped(client, MCP9600_ALERT_LIMIT(i + 1)=
);
> +		if (ret < 0)
> +			return ret;
> +
> +		/* Shift length 4 bits =3D 2(15:2) + 2(0.25 LSB), see above. */
> +		s_thresh =3D sign_extend32(ret, 15) * (MCP9600_TEMP_SCALE_NUM >> 4);
> +
> +		/*
> +		 * Hysteresis is stored as offset, for rising temperatures, the
> +		 * hysteresis range is below the alert limit where, as for falling
> +		 * temperatures, the hysteresis range is above the alert limit.
> +		 */

I don't understand this comment.
Hysteresis as a parameter in sysfs in IIO is also an offset, so why is the =
current
threshold relevant?

Normally hysteresis is about allowing repeat events. I.e. you have to drop =
below
threshold - hysteresis  before rising again to trigger a rising event when =
passing
threshold.


> +		hyst =3D min(255, abs(s_thresh - s_val) / MCP9600_TEMP_SCALE_NUM);
> +
> +		return i2c_smbus_write_byte_data(client,
> +						 MCP9600_ALERT_HYSTERESIS(i + 1),
> +						 hyst);
> +	default:
> +		return -EINVAL;
> +	}
> +}


> +static irqreturn_t mcp9600_alert3_handler(int irq, void *private)
> +{
> +	struct iio_dev *indio_dev =3D private;
> +	struct mcp9600_data *data =3D iio_priv(indio_dev);
> +	int ret;
> +
> +	ret =3D i2c_smbus_read_byte_data(data->client, MCP9600_STATUS);
> +	if (ret < 0)
> +		return IRQ_HANDLED;
> +
> +	if (!(ret & MCP9600_STATUS_ALERT(MCP9600_ALERT3)))

This duplicates far too much all these call a function that takes
a) This bit,
b) the related channel index.
C) the direction

and call that from all these separate handlers.
Each individual handler become simply:

	return mcp9600_alert_handler(private, MCP9600_ALERT3,
				     MCP9600_CHAN_COLD_JUNCTION,
				     IIO_EV_DIR_RISING);

etc.

> +		return IRQ_NONE;
> +
> +	iio_push_event(indio_dev,
> +		       IIO_MOD_EVENT_CODE(IIO_TEMP, MCP9600_CHAN_COLD_JUNCTION,
> +					  IIO_NO_MOD, IIO_EV_TYPE_THRESH,
> +					  IIO_EV_DIR_RISING),
> +		       iio_get_time_ns(indio_dev));
> +
> +	return IRQ_HANDLED;
> +}
> +

> +
> +static irqreturn_t (*mcp9600_alert_handler[MCP9600_ALERT_COUNT]) (int, v=
oid *) =3D {
> +	mcp9600_alert1_handler,
> +	mcp9600_alert2_handler,
> +	mcp9600_alert3_handler,
> +	mcp9600_alert4_handler,
>  };


