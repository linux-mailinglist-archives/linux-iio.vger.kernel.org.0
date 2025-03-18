Return-Path: <linux-iio+bounces-17002-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 859C5A6661A
	for <lists+linux-iio@lfdr.de>; Tue, 18 Mar 2025 03:15:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E68E7A9188
	for <lists+linux-iio@lfdr.de>; Tue, 18 Mar 2025 02:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9036914B07A;
	Tue, 18 Mar 2025 02:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=it-klinger.de header.i=@it-klinger.de header.b="PT2fsCtd"
X-Original-To: linux-iio@vger.kernel.org
Received: from www571.your-server.de (www571.your-server.de [78.46.3.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26EAE3FE4;
	Tue, 18 Mar 2025 02:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.46.3.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742264126; cv=none; b=HdlIvg9nmoCK+5JfCNZoLSoQtpPKAsxH4fpMC6lmeeUmTakhbtWG9jmlLDuNssd5ZZOlX+GSxQp0qLVjCHKcEuBtEr+fiCq9C9OEGt2BTYIgx9o5KudeKuQefGvAkoOArEjMMN3Bz/713cXQ/T3JHEoViNqf2JROLynnmhjgaeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742264126; c=relaxed/simple;
	bh=UCsugMe3R4VlqIfjzzyXANo3ViKHYsxcV+crhZXoH7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VkDrmvHrY5JebmdIMK5Efw5DoY16R9UmzbytYzbnNmSWEbPy1e2/o1FlTbaOWxLpb+ZYN0WG8uraWpNdII8UV6AFbuw2MRGNqj04/+04Ba6ggUYhBUBDQLRyAl5V8FS4pQ6eLcF0Llyib6iLsvkGFVI8p1H6ZOG+lXzUNrvwxjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=it-klinger.de; spf=pass smtp.mailfrom=it-klinger.de; dkim=pass (2048-bit key) header.d=it-klinger.de header.i=@it-klinger.de header.b=PT2fsCtd; arc=none smtp.client-ip=78.46.3.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=it-klinger.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=it-klinger.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=it-klinger.de; s=default2502; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=d7yXPIYtxvHsk5WNCX7Bw/nlbsrMgCFhltSawJEUQRU=; b=PT2fsCtdU+pS29D9LtbbC1sciR
	zY561yeKuoqum50QkoccJ9YfM4yWh3tgvMh82ePzXq0CZeWoQgAQY0w3o6F/gv/mdf3gSunbYptaH
	W+xQB1ar5EgV3s70F53CiA5OJGdNxCIzrRNbW6MLm2+/mRwBXYhYwbc6EtN+g1Yubz1AgprX5lI4u
	9sctAPTSOn+W7N7whH0weNKCq5ZqbnqIjg+bxq9UstVV2FOOtMnDj5IgLS4CiVbKGpFb0qE1iPFA2
	piTyGVhbND7bW3qjiqU0djl5SFMh1KW9ZeBdNXEePF80dVlhhOvAZguT16ZfiduLMJm51vsvrgxAT
	Ahztz6mA==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www571.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <ak@it-klinger.de>)
	id 1tuMU4-0009Jr-0I;
	Tue, 18 Mar 2025 03:15:12 +0100
Received: from [2a0f:6480:1:600:fc64:4dfc:9829:9e5f] (helo=mail.your-server.de)
	by sslproxy05.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ak@it-klinger.de>)
	id 1tuMU2-0007jw-30;
	Tue, 18 Mar 2025 03:15:11 +0100
Date: Tue, 18 Mar 2025 03:15:09 +0100
From: Andreas Klinger <ak@it-klinger.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	lars@metafoo.de, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	javier.carrasco.cruz@gmail.com, mazziesaccount@gmail.com,
	subhajit.ghosh@tweaklogic.com, muditsharma.info@gmail.com,
	arthur.becker@sentec.com, ivan.orlov0322@gmail.com
Subject: Re: [PATCH 2/3] iio: light: add support for veml6046x00 RGBIR color
 sensor
Message-ID: <Z9jXLYYbY7nKDwA-@mail.your-server.de>
References: <20250316113131.62884-1-ak@it-klinger.de>
 <20250316113131.62884-3-ak@it-klinger.de>
 <20250317115005.72a539a0@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9Stg+H01kC8eb1hO"
Content-Disposition: inline
In-Reply-To: <20250317115005.72a539a0@jic23-huawei>
X-Authenticated-Sender: ak@it-klinger.de
X-Virus-Scanned: Clear (ClamAV 1.0.7/27580/Mon Mar 17 10:42:01 2025)


--9Stg+H01kC8eb1hO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jonathan,

thanks for the review and comments. Answers are inline below.

Andreas


Jonathan Cameron <jic23@kernel.org> schrieb am Mo, 17. M=C3=A4r 11:50:
> On Sun, 16 Mar 2025 12:31:30 +0100
> Andreas Klinger <ak@it-klinger.de> wrote:
>=20
> > Add Vishay VEML6046X00 high accuracy RGBIR color sensor.
> >=20
> > This sensor provides three colour (red, green and blue) as well as one
> > infrared (IR) channel through I2C.
> >=20
> > Support direct and buffered mode.
> >=20
> > An optional interrupt for signaling green colour threshold underflow or
> > overflow is not supported so far.
> >=20
> > Signed-off-by: Andreas Klinger <ak@it-klinger.de>
>=20
> Hi Andreas,
>=20
> A nice clean driver.
> A few comments and questions inline.
>=20
> Jonathan
>=20
> > diff --git a/drivers/iio/light/veml6046x00.c b/drivers/iio/light/veml60=
46x00.c
> > new file mode 100644
> > index 000000000000..8e6232e1ab70
> > --- /dev/null
> > +++ b/drivers/iio/light/veml6046x00.c
> > @@ -0,0 +1,890 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * VEML6046X00 High Accuracy RGBIR Color Sensor
> > + *
> > + * Copyright (c) 2025 Andreas Klinger <ak@it-klinger.de>
> > + */
> > +
> > +#include <linux/bitfield.h>
> > +#include <linux/i2c.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/module.h>
> > +#include <linux/regmap.h>
> > +#include <linux/types.h>
> > +#include <linux/units.h>
> > +#include <linux/pm_runtime.h>
> > +#include <linux/iio/iio.h>
> > +#include <linux/iio/sysfs.h>
> > +#include <linux/iio/trigger.h>
>=20
> So far you aren't providing a trigger so I'm not
> expect to see this header used.  Looking at the datasheet
> I see there is a dataready interrupt, but it doesn't look like
> the device has an autonomous / sequencer type mode, so will always
> need to use another trigger (hrtimer, sysfs or some other hardware
> source).

I'll remove.

> > +#include <linux/iio/trigger_consumer.h>
> > +#include <linux/iio/triggered_buffer.h>
>=20
> > +
> > +struct veml6046x00_scan_buf {
> > +	__le16 chans[4];
> > +
> > +	s64 timestamp __aligned(8);
> aligned_s64 now available as a type to use here.
>=20
> > +};
>=20
> > +static IIO_DEVICE_ATTR_RO(in_illuminance_period_available, 0);
> > +
> > +static struct attribute *veml6046x00_event_attributes[] =3D {
> > +	&iio_dev_attr_in_illuminance_period_available.dev_attr.attr,
> I thought we didn't have event support yet?  If not why do we
> have event related attributes?

I started implementing including event support by using the interrupt and t=
he
threshold values which can be programmed on the sensor. It turned out that =
this
is not working as i expected on my side. Then i removed everything which is
about events, but forgot this here. I'm in the process of clarifying this w=
ith
the vendor. The plan is to submit a follow up patch later.

So i'll remove for this turn.

> > +	NULL
> > +};
> > +
> > +static const struct attribute_group veml6046x00_event_attr_group =3D {
> > +	.attrs =3D veml6046x00_event_attributes,
> > +};
>=20
>=20
> > +
> > +static int veml6046x00_set_it(struct iio_dev *iio, int val, int val2)
> > +{
> > +	struct veml6046x00_data *data =3D iio_priv(iio);
> > +	int ret, new_it;
> > +
> > +	if (val)
> > +		return -EINVAL;
> > +
> > +	switch (val2) {
> > +	case 3125:
> > +		new_it =3D 0x00;
> > +		break;
> > +	case 6250:
> > +		new_it =3D 0x01;
> > +		break;
> > +	case 12500:
> > +		new_it =3D 0x02;
> > +		break;
> > +	case 25000:
> > +		new_it =3D 0x03;
> > +		break;
> > +	case 50000:
> > +		new_it =3D 0x04;
> > +		break;
> > +	case 100000:
> > +		new_it =3D 0x05;
> > +		break;
> > +	case 200000:
> > +		new_it =3D 0x06;
> > +		break;
> > +	case 400000:
> > +		new_it =3D 0x07;
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> > +	ret =3D regmap_field_write(data->rf.it, new_it);
> > +	if (ret)
> > +		return ret;
>=20
> return regmap_field_write()
>=20
> > +
> > +	return 0;
> > +}
> > +
> > +static int veml6046x00_set_scale(struct iio_dev *iio, int val, int val=
2)
> > +{
> > +	struct veml6046x00_data *data =3D iio_priv(iio);
> > +	int new_scale;
> > +
> > +	if (val =3D=3D 0 && val2 =3D=3D 250000) {
>=20
> Maybe a lookup table and a loop?

Yes, would be nicer.

> > +		new_scale =3D FIELD_PREP(VEML6046X00_CONF1_GAIN, VEML6046X00_GAIN_0_=
5) |
> > +					VEML6046X00_CONF1_PD_D2;
> > +	} else if (val =3D=3D 0 && val2 =3D=3D 330000) {
> > +		new_scale =3D FIELD_PREP(VEML6046X00_CONF1_GAIN, VEML6046X00_GAIN_0_=
66) |
> > +					VEML6046X00_CONF1_PD_D2;
> > +	} else if (val =3D=3D 0 && val2 =3D=3D 500000) {
> > +		new_scale =3D FIELD_PREP(VEML6046X00_CONF1_GAIN, VEML6046X00_GAIN_0_=
5);
> > +	} else if (val =3D=3D 0 && val2 =3D=3D 660000) {
> > +		new_scale =3D FIELD_PREP(VEML6046X00_CONF1_GAIN, VEML6046X00_GAIN_0_=
66);
> > +	} else if (val =3D=3D 1 && val2 =3D=3D 0) {
> > +		new_scale =3D FIELD_PREP(VEML6046X00_CONF1_GAIN, VEML6046X00_GAIN_1);
> > +	} else if (val =3D=3D 2 && val2 =3D=3D 0) {
> > +		new_scale =3D FIELD_PREP(VEML6046X00_CONF1_GAIN, VEML6046X00_GAIN_2);
> > +	} else {
> > +		return -EINVAL;
> > +	}
> > +
> > +	return regmap_update_bits(data->regmap, VEML6046X00_REG_CONF1,
> > +				 VEML6046X00_CONF1_GAIN |
> > +				 VEML6046X00_CONF1_PD_D2,
> > +				 new_scale);
> > +}
> > +
> > +static int veml6046x00_get_scale(struct veml6046x00_data *data,
> > +				 int *val, int *val2)
>=20
> How is this related to integration time?  I'd normally expect
> to see that read in here somewhere as well as doubling integration
> time tends to double scale.
>=20

That's true.

So i'll also need to present different gain values depending on the integra=
tion time.

> > +{
> > +	int ret, reg;
> > +
> > +	ret =3D regmap_read(data->regmap, VEML6046X00_REG_CONF1, &reg);
> > +	if (ret)
> > +		return ret;
> > +
> > +	switch (FIELD_GET(VEML6046X00_CONF1_GAIN, reg)) {
> > +	case 0:
> > +		*val =3D 1;
> > +		*val2 =3D 0;
> > +		break;
> > +	case 1:
> > +		*val =3D 2;
> > +		*val2 =3D 0;
> > +		break;
> > +	case 2:
> > +		*val =3D 0;
> > +		*val2 =3D 660000;
> > +		break;
> > +	case 3:
> > +		*val =3D 0;
> > +		*val2 =3D 500000;
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (reg & VEML6046X00_CONF1_PD_D2)
> > +		*val2 /=3D 2;
> > +
> > +	return IIO_VAL_INT_PLUS_MICRO;
> > +}
> > +
> > +static int veml6046x00_set_mode(struct veml6046x00_data *data, bool st=
ate)
> > +{
> > +	return regmap_field_write(data->rf.mode, state);
> as below.
>=20
> > +}
> > +
> > +static int veml6046x00_set_trig(struct veml6046x00_data *data, bool st=
ate)
> > +{
> > +	return regmap_field_write(data->rf.trig, state);
>=20
> I'd argue these two aren't worth bothering with because the
> field naming etc makes a direct call to regmap_field_write() obvious enou=
gh.
>=20
> > +}
> > +
> > +static int veml6046x00_wait_data_available(struct iio_dev *iio, int us=
ecs)
>=20
> Document return value as non obvious.
>=20
> > +{
> > +	struct veml6046x00_data *data =3D iio_priv(iio);
> > +	int ret, reg;
> > +	int cnt =3D 2;
> > +	int i;
> > +
> > +	for (i =3D 0; i < cnt; i++) {
> > +		ret =3D regmap_read(data->regmap, VEML6046X00_REG_INT_H, &reg);
> > +		if (ret) {
> > +			dev_err(data->dev,
> > +					"Failed to read interrupt register %d\n", ret);
> > +			return -EIO;
> > +		}
> > +
> > +		if (reg & VEML6046X00_INT_DRDY)
> > +			return 1;
> > +
> > +		if (i < cnt)
> > +			fsleep(usecs);
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int veml6046x00_single_read(struct iio_dev *iio,
> > +					enum iio_modifier modifier, int *val)
> > +{
> > +	struct veml6046x00_data *data =3D iio_priv(iio);
> > +	int addr, it_usec, ret;
> > +	uint8_t reg[2];
> > +
> > +	switch (modifier) {
> > +	case IIO_MOD_LIGHT_RED:
> > +		addr =3D VEML6046X00_REG_R_L;
> > +	break;
>=20
> break indent not matching kernel style. Needs to be one more tab in.
>=20
> > +	case IIO_MOD_LIGHT_GREEN:
> > +		addr =3D VEML6046X00_REG_G_L;
> > +	break;
> > +	case IIO_MOD_LIGHT_BLUE:
> > +		addr =3D VEML6046X00_REG_B_L;
> > +	break;
> > +	case IIO_MOD_LIGHT_IR:
> > +		addr =3D VEML6046X00_REG_IR_L;
> > +	break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +	ret =3D pm_runtime_resume_and_get(data->dev);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret =3D veml6046x00_get_it_usec(data, &it_usec);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	veml6046x00_set_mode(data, 1);
> Check for errors.
> > +
> > +	veml6046x00_set_trig(data, 1);
> > +
> > +	/* integration time + 10 % to ensure completion */
> > +	fsleep(it_usec + (it_usec / 10));
> > +
> > +	ret =3D veml6046x00_wait_data_available(iio, it_usec * 10);
> > +	if (ret =3D=3D 1) {
> > +		dev_dbg(data->dev, "data ready\n");
> > +	} else {
> > +		dev_warn(data->dev, "no data ready ret: %d\n", ret);
> > +		goto no_data;
> > +	}
> > +
> > +	ret =3D iio_device_claim_direct_mode(iio);
> I'm killing these off slowly.  To save a follow up patch,
> 	if (!iio_device_claim_direct(iio))
> 		return -EBUSY;
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret =3D regmap_bulk_read(data->regmap, addr, reg, sizeof(reg));
> > +	iio_device_release_direct_mode(iio);
> =09
> 	iio_device_release_direct(iio);
>=20
> If not I'll roll in the change with the many other driver updates
> this entails.
>=20
>=20
> > +	if (ret)
> > +		return ret;
> > +
> > +	pm_runtime_mark_last_busy(data->dev);
> > +	pm_runtime_put_autosuspend(data->dev);
> > +
> > +	*val =3D reg[1] << 8 | reg[0];
>=20
> That's an endian conversion.  Use get_unaligned_le16() I think
> Or read into an __le16 in the first place and you can use
> le16_to_cpu() or similar.
>=20
>=20
> > +
> > +	return IIO_VAL_INT;
> > +
> > +no_data:
> > +	pm_runtime_mark_last_busy(data->dev);
> > +	pm_runtime_put_autosuspend(data->dev);
> > +
> > +	return -EINVAL;
> > +}
>=20
>=20
>=20
> > +static int veml6046x00_buffer_preenable(struct iio_dev *iio)
> > +{
> > +	struct veml6046x00_data *data =3D iio_priv(iio);
> > +	struct device *dev =3D data->dev;
> > +	int ret;
> > +
> > +	ret =3D veml6046x00_set_mode(data, 0);
> > +	if (ret)
> > +		dev_err(data->dev, "Failed to set mode %d\n", ret);
>=20
> If these fail, error out.  We will fail to enter buffered mode, but
> that is probably the correct thing to do if we are having comms
> issues or similar.
>=20
> > +
> > +	ret =3D veml6046x00_set_trig(data, 0);
> > +	if (ret)
> > +		dev_err(data->dev, "Failed to set trigger %d\n", ret);
> > +
> > +	return pm_runtime_resume_and_get(dev);
> > +}
>=20
>=20
>=20
> > +static int veml6046x00_validate_part_id(struct veml6046x00_data *data)
> > +{
> > +	int part_id, ret;
> > +	__le16 reg;
> > +
> > +	ret =3D regmap_bulk_read(data->regmap, VEML6046X00_REG_ID_L, &reg, si=
zeof(reg));
> > +	if (ret) {
> > +		dev_info(data->dev, "Failed to read ID\n");
>=20
> return dev_err_probe() for this one.
>=20
> > +		return -EIO;
> > +	}
> >
> > +static int veml6046x00_setup_device(struct iio_dev *iio)
> > +{
> > +	struct veml6046x00_data *data =3D iio_priv(iio);
> > +	struct device *dev =3D data->dev;
> > +	int ret, val;
> > +	__le16 reg16;
> > +	uint8_t reg[2];
> > +
> > +	reg[0] =3D VEML6046X00_CONF0_AF;
> > +	reg[1] =3D 0x00;
> > +	ret =3D regmap_bulk_write(data->regmap, VEML6046X00_REG_CONF0, reg, s=
izeof(reg));
> > +	if (ret)
> > +		return dev_err_probe(dev, ret, "Failed to set configuration\n");
> > +
> > +	reg16 =3D cpu_to_le16(0);
> > +	ret =3D regmap_bulk_write(data->regmap, VEML6046X00_REG_THDL_L, &reg1=
6, sizeof(reg16));
> > +	if (ret)
> > +		return dev_err_probe(dev, ret, "Failed to set low threshold\n");
> > +
> > +	reg16 =3D cpu_to_le16(U16_MAX);
> > +	ret =3D regmap_bulk_write(data->regmap, VEML6046X00_REG_THDH_L, &reg1=
6, sizeof(reg16));
> > +	if (ret)
> > +		return dev_err_probe(dev, ret, "Failed to set high threshold\n");
> > +
> > +	ret =3D regmap_read(data->regmap, VEML6046X00_REG_INT_H, &val);
> > +	if (ret < 0)
>=20
> if (ret) here as well.  Good to be consistent for all regmap calls. None =
of them
> return > 0 as far as I know.
>=20
>=20
> > +		return dev_err_probe(dev, ret, "Failed to clear interrupts\n");
> > +
> > +	return 0;
> > +}
> > +
> > +static int veml6046x00_probe(struct i2c_client *i2c)
> > +{
> > +	struct device *dev =3D &i2c->dev;
> > +	struct veml6046x00_data *data;
> > +	struct iio_dev *iio;
> > +	struct regmap *regmap;
> > +	int ret;
> > +
> > +	regmap =3D devm_regmap_init_i2c(i2c, &veml6046x00_regmap_config);
> > +	if (IS_ERR(regmap))
> > +		return dev_err_probe(dev, PTR_ERR(regmap),
> > +				     "Failed to set regmap\n");
> > +
> > +	iio =3D devm_iio_device_alloc(dev, sizeof(*data));
> > +	if (!iio)
> > +		return -ENOMEM;
> > +
> > +	data =3D iio_priv(iio);
> > +	i2c_set_clientdata(i2c, iio);
> > +	data->dev =3D dev;
> > +	data->regmap =3D regmap;
> > +
> > +	ret =3D veml6046x00_regfield_init(data);
> > +	if (ret)
> > +		return dev_err_probe(dev, ret, "Failed to init regfield\n");
> > +
> > +	ret =3D devm_regulator_get_enable(dev, "vdd");
> > +	if (ret)
> > +		return dev_err_probe(dev, ret, "Failed to enable regulator\n");
> > +
> > +	ret =3D devm_add_action_or_reset(dev, veml6046x00_shutdown_action, da=
ta);
>=20
> Mostly we want a devm action to match against a specific setup operation.=
  Here is
> it that the device comes up in non shut down state?  Perhaps a comment to
> make it clear.  Also, how do we know it's in a good state rather than part
> configured by someone else?  I'm not seeing a reset sequence though perha=
ps
> that effectively happens in setup_device()

In veml6046x00_setup_device() all registers are set up to bring the device =
in a
known state. This function also switches the device on. I could move the ca=
ll to
setup_device() up to here and add a comment to make it clear.

>=20
> > +	if (ret < 0)
> > +		return dev_err_probe(dev, ret, "Failed to add shut down action\n");
> > +
> > +	ret =3D pm_runtime_set_active(dev);
> > +	if (ret < 0)
> > +		return dev_err_probe(dev, ret, "Failed to activate PM runtime\n");
> > +
> > +	ret =3D devm_pm_runtime_enable(dev);
> > +	if (ret)
> > +		return dev_err_probe(dev, ret, "Failed to enable PM runtime\n");
> > +
> > +	pm_runtime_get_noresume(dev);
> > +	pm_runtime_set_autosuspend_delay(dev, VEML6046X00_AUTOSUSPEND_MS);
> > +	pm_runtime_use_autosuspend(dev);
> > +
> > +	ret =3D veml6046x00_validate_part_id(data);
> > +	if (ret)
> > +		return dev_err_probe(dev, ret, "Failed to validate device ID\n");
> > +
> > +	iio->name =3D i2c->name;
>=20
> Prefer this hard coded.  Depending on the firmware type, things like that=
 have
> an annoying habbit of not remaining predictable or stable.
>=20
> > +	iio->channels =3D veml6046x00_channels;
> > +	iio->num_channels =3D ARRAY_SIZE(veml6046x00_channels);
> > +	iio->modes =3D INDIO_DIRECT_MODE;
> > +
> > +	iio->info =3D &veml6046x00_info_no_irq;
> > +
> > +	ret =3D veml6046x00_setup_device(iio);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	ret =3D devm_iio_triggered_buffer_setup(dev, iio, NULL,
> > +					      veml6046x00_trig_handler,
> > +					      &veml6046x00_buffer_setup_ops);
> > +	if (ret)
> > +		return dev_err_probe(dev, ret,
> > +				     "Failed to register triggered buffer");
> > +
> > +	pm_runtime_mark_last_busy(dev);
> > +	pm_runtime_put_autosuspend(dev);
> > +
> > +	ret =3D devm_iio_device_register(dev, iio);
> > +	if (ret)
> > +		return dev_err_probe(dev, ret, "Failed to register iio device");
> > +
> > +	return 0;
> > +}
>=20

--9Stg+H01kC8eb1hO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEE7/NrAFtB/Pj7rTUyyHDM+xwPAVEFAmfY1ywACgkQyHDM+xwP
AVHoOAv/diLTnnot5DfLWyFIatb+1ET8vVPt/5xn2bVcoO7DazwDilJpl/wY94HA
YwU4dy49YzEgoHuIKyhZk+YgDmmRggr7uQCKAHwAvNOLpX1ahJXyyy+44718uESc
0N/rFQDNhkzo1oNAfJ5U6B22P0dzVYQeqgLMDqKmhMUzwfYzXbtR0IJHLBB6QuC5
fzgYy/uIMblJPBlROG5p//ZcDdJ3wF8B9IuMN1/686UeoBUkc0lhV4N+iLfgU+X/
d1rIabWmAswbPMhiC7wGJH7YUR+iy76OgtKbBNqJI/cEeFI/xVYVof70UwRKdjCC
lynf8KL1R69WW5mix7rJWtzkaeki/KQezLGBn7E3ooPV/TtC3UztdoKwgOFJ2uzh
WFndYnd5d94lZgTAJQq1IDCPzRGN+RZnQl3J3fd4+h+/vKdiQi79LJakgjJHJtE7
S2D7QDxBmOpqLl9BqPwyF+POEalzsD62M9kuqqyjsod4f1YUAq/EN+aj8SI5kIyV
xAGyJZF8
=pES/
-----END PGP SIGNATURE-----

--9Stg+H01kC8eb1hO--

