Return-Path: <linux-iio+bounces-26435-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 289D6C81E78
	for <lists+linux-iio@lfdr.de>; Mon, 24 Nov 2025 18:30:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4076B3AA426
	for <lists+linux-iio@lfdr.de>; Mon, 24 Nov 2025 17:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EC022C1596;
	Mon, 24 Nov 2025 17:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="aFxsDuRC"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7AB2C08CA;
	Mon, 24 Nov 2025 17:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764005361; cv=none; b=Bf51ggjOLG4VGhyKnF424L+t7aKm1S+qyY/fOU3F2HUUNpaQOW7auuiWLGoVwgvJry93KgqD+eFCwmAy42S0614jRr89Nvh8K4Nvz5/VDafvjvHedkh8lpTPq6tmECRPKmqjvEYN70rmZIsD/yhvp2aKFBMsZbQUrhv7pfWMzuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764005361; c=relaxed/simple;
	bh=pZK7vppatgHDpAKvfeBDFUvY5cNqTwlkjr6axCAT14U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bHzmOkyM0TOQWRQ4uRjScYKlixYPu9AQ1aLNtuIu+eX4+x7EZt+1zGlCPUvRbxIVauN/thggrMRVrYx3zaeHWEKgM1tkKDtXDc3XspAoz+ZPThLV+XzIi3a+q2LespD4nDY62A4yAfqzp5G9jgkGyh75QS9/XFxunh9a6EOEMxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=aFxsDuRC; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from lipo.home.arpa (unknown [IPv6:2a02:2f0e:3e0c:5b00:f1e0:3f4b:286c:9ddb])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id 5FD81160209;
	Mon, 24 Nov 2025 19:29:09 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1764005349;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/wX3MhZ4d9SWgJbAQdtWpWHsxoS+X0UtYW/P4qrtNcE=;
	b=aFxsDuRCQZ/nfwG8TI7hBVV4nQ3lyC7V5k02FTjdL7UVhL5OLbSJLlwfhKkjMbzW+ffsMf
	MkEH5nkUH4LZym/HeBk2f7L37fWlePbdBrNER+KB7xTGgk1nrv2kZVu/hyjhLTsoZz7p3F
	adTSv5VUI72O4yoK/bnoFbcHVOQZDL09ja5gDdyU+CjRd637AZNwB7bwV8ZwzAb8MZQ9+X
	argWfxqzjHFgz4DSiqkdvWlvenct1m2WccMRB8EoTUzE6sd5spVUVQ5rhWuzJatsPN8qh0
	He+czEB5m5HlDzLFcg5O4pUyPYA42JkEeSGCsQI7ZZa2qZzh6JwkeTNfOrCU7w==
Date: Mon, 24 Nov 2025 19:29:06 +0200
From: Petre Rodan <petre.rodan@subdimension.ro>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: pressure: add Honeywell ABP2 driver
Message-ID: <aSSV4lxzatAFds5e@lipo.home.arpa>
References: <20251122-honeywell_abp2_driver-v1-0-7a8e265f9627@subdimension.ro>
 <20251122-honeywell_abp2_driver-v1-2-7a8e265f9627@subdimension.ro>
 <aSRF-DL3rKjyFleg@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <aSRF-DL3rKjyFleg@smile.fi.intel.com>


hello Andy.

thank you for the review.

On Mon, Nov 24, 2025 at 01:48:08PM +0200, Andy Shevchenko wrote:
> On Sat, Nov 22, 2025 at 11:42:45PM +0200, Petre Rodan wrote:
[..]

> > +/*
> > + * transfer function A: 10%   to 90%   of 2^24
>=20
> Too many spaces, also this may be a one-line comment.

it was intentional to have the comment multiline.
in case we need to add additional transfer functions in the future for comp=
atible ICs the diff will be a few lines smaller.

> > + */
> > +static const struct abp2_func_spec abp2_func_spec[] =3D {
> > +	[ABP2_FUNCTION_A] =3D { .output_min =3D 1677722, .output_max =3D 1509=
9494 },
> > +};
>=20
> ...
>=20
> > +enum abp2_variants {
>=20
> Why explicit assignments? Is it related to some HW register?

no registers, I just need to ensure the two arrays

static const char * const abp2_triplet_variants[ABP2_VARIANTS_MAX] =3D {
	[ABP2001BA] =3D "001BA", [ABP21_6BA] =3D "1.6BA", [ABP22_5BA] =3D "2.5BA",=
 ..

static const struct abp2_range_config abp2_range_config[ABP2_VARIANTS_MAX] =
=3D {
	[ABP2001BA] =3D { .pmin =3D       0, .pmax =3D  100000 },
   	[ABP21_6BA] =3D { .pmin =3D       0, .pmax =3D  160000 }, ..

keep being consistent and are resistant to later editing.

I feel like I had a better implementation two years ago when I used a singl=
e struct containing all this information and had a custom/NIH search functi=
on, but you kindly asked me [1] to use device_property_match_property_strin=
g() instead and split my single struct into this three parts mess.

[1] https://lore.kernel.org/linux-iio/ZWcUPkzfGqxYsysp@smile.fi.intel.com/

> Can be done easier with a macro with more robustness against typos:
>=20
> #define ABP2_VARIANT(v)		[ABP2 ## v] =3D ##v
>=20
> static const char * const abp2_triplet_variants[] =3D {
> 	ABP2_VARIANT(001BA), ABP2_VARIANT(1_6BA), ABP2_VARIANT(2_5BA), ABP2_VARI=
ANT(004BA),
> 	...
> };
>=20
> but this will loose the possibility to make '.' in the name. Up to you.

thanks, but I need '.' in the name. the dot is used in the part number (and=
 thus in the pressure triplet).

> > +static int abp2_get_measurement(struct abp2_data *data)
> > +{
> > +	struct device *dev =3D data->dev;
> > +	int ret;
> > +
> > +	memset(data->buffer, 0, sizeof(data->buffer));
> > +	reinit_completion(&data->completion);
> > +
> > +	ret =3D data->ops->write(data, ABP2_CMD_SYNC, ABP2_PKT_SYNC_LEN);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	if (data->irq > 0) {
> > +		ret =3D wait_for_completion_timeout(&data->completion, HZ);
>=20
> Where is HZ defined? Include that.
>=20
> > +		if (!ret) {
> > +			dev_err(dev, "timeout waiting for EOC interrupt\n");
> > +			return -ETIMEDOUT;
> > +		}
> > +	} else
> > +		fsleep(5000);
>=20
> Better to have 5 * USEC_PER_MSEC. Also missed comment why this long delay
> is needed (will require time.h).
>=20
> Missed {} as well.

I'm not sure I understand where are braces needed/not needed in this contex=
t.

> > +	ret =3D data->ops->read(data, ABP2_CMD_NOP, ABP2_PKT_NOP_LEN);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	/*
> > +	 * status byte flags
> > +	 *  bit7 SANITY_CHK     - must always be 0
> > +	 *  bit6 ABP2_ST_POWER  - 1 if device is powered
> > +	 *  bit5 ABP2_ST_BUSY   - 1 if device has no new conversion ready
> > +	 *  bit4 SANITY_CHK     - must always be 0
> > +	 *  bit3 SANITY_CHK     - must always be 0
> > +	 *  bit2 MEMORY_ERR     - 1 if integrity test has failed
> > +	 *  bit1 SANITY_CHK     - must always be 0
> > +	 *  bit0 MATH_ERR       - 1 during internal math saturation err
> > +	 */
> > +
> > +	if (data->buffer[0] =3D=3D (ABP2_ST_POWER | ABP2_ST_BUSY))
> > +		return -ETIMEDOUT;
> > +
> > +	if (data->buffer[0] !=3D ABP2_ST_POWER) {
> > +		dev_err(data->dev,
> > +			"unexpected status byte 0x%02x\n", data->buffer[0]);
> > +		return -ETIMEDOUT;
> > +	}
>=20
> I am not sure the chosen error code in both cases is good enough.

I'm open to recommendations on better error codes.

first error: chip reports it's busy 5ms after start conversion command. bas=
ed on the datasheet the conversion should have been ready at this point in =
time. this sounds to me like a timeout error.

second error: status byte contains unexpected flags being set - either an i=
nternal error - see table above or a bus read error. yes, timeout is not go=
od here but what should it be?

I'm using two conditionals because I want to log only invalid statuses and =
ignore simple 'device busy' errors.

> > +struct abp2_ops {
> > +	int (*init)(struct device *dev);
> > +	int (*read)(struct abp2_data *data, const u8 cmd, const u8 cnt);
> > +	int (*write)(struct abp2_data *data, const u8 cmd, const u8 cnt);
>=20
> What is the meaning of const for the POD type parameters? I mean this giv=
es
> really a little protection if any. I do not see a point here to have them=
 being const.

I read a few books about C programming a few decades back and there was a c=
onsensus on using const in function prototypes wherever a parameter was sup=
posed to not be changed.
of course it's not bulletproof, but why do you feel I should stop following=
 that advice for functions that are not tied to any pre-existing kernel API?

> > +int abp2_common_probe(struct device *dev, const struct abp2_ops *ops, =
int irq);
> > +
> > +#endif
>=20
> ...
>=20
> > +#include <linux/device.h>
> > +#include <linux/errno.h>
> > +#include <linux/i2c.h>
> > +#include <linux/mod_devicetable.h>
> > +#include <linux/module.h>
> > +#include <linux/types.h>
>=20
> > +static int abp2_i2c_init(struct device *dev)
> > +{
> > +	return 0;
> > +}
>=20
> Is this stub required?

do I have a 100% guarantee that the kernel will not try to execute a null p=
ointer function in abp2_common_probe()?

	ret =3D data->ops->init(data->dev); // needed only for SPI.

later edit:
since I will remove devm_kzalloc(), the _init will probably go away entirel=
y together with the stub.

> > +static int abp2_i2c_read(struct abp2_data *data, const u8 unused, cons=
t u8 cnt)
> > +{
> > +	struct i2c_client *client =3D to_i2c_client(data->dev);
> > +	int ret;
> > +
> > +	if (cnt > ABP2_MEASUREMENT_RD_SIZE)
> > +		return -EOVERFLOW;
> > +
> > +	ret =3D i2c_master_recv(client, data->buffer, cnt);
> > +	if (ret < 0)
> > +		return ret;
>=20
> > +	else if (ret !=3D cnt)
>=20
> Redundant 'else'.
>=20
> > +		return -EIO;
> > +
> > +	return 0;
> > +}

are you implying that __i2c_transfer() errors out if the number of bytes tr=
ansfered is not cnt?

> > +static const struct abp2_ops abp2_i2c_ops =3D {
> > +	.init =3D abp2_i2c_init,
> > +	.read =3D abp2_i2c_read,
> > +	.write =3D abp2_i2c_write,
> > +};
>=20
> So, why can't regmap I=B2C be used?
[..]
> So, why can't regmap SPI be used?

there are no registers, no memory map, just a 'start conversion' and the eq=
uivalent of a 'read conversion' command.
any reason one would use the regmap API in this case?

best regards,
peter

