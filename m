Return-Path: <linux-iio+bounces-4812-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2ED48BC2C9
	for <lists+linux-iio@lfdr.de>; Sun,  5 May 2024 19:18:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2D58B20E77
	for <lists+linux-iio@lfdr.de>; Sun,  5 May 2024 17:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41FDF41C76;
	Sun,  5 May 2024 17:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BIZwSLk2"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC72722611;
	Sun,  5 May 2024 17:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714929522; cv=none; b=GUWoyq/lyPUfvaGUw/dIkYdeKTTqxs1vNbkgito4Dw8y5LIAUxcWANUfv0aGKYveb0HRrm63Gy83zgHoZDM9ni7knkUGMcMtmfeaMcEji7hn/sQ73jF0NzvmeHzsmWbkwkPiOjfj+zgs5RZuNSfXutZZTZtk9tkuPUYnKz0GB9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714929522; c=relaxed/simple;
	bh=siSKxyKMPfbUfgRJE2KkzJJ3nXpR2oCWZyv7uG3ylxU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Aqre7I6VMT/zqXn3AQ2nW17fjoiwbWyRMpRpwSAMbKQEQHjSazXvUrG9Q/NjrXYhrG52axiTmp3205oNJW2eXqJZCyO9drNjgBX6VjhohFOtRDDwJDyn/OJr4oL3XMJh888qHTSosVkYLzYCUHMm3idjqKoxY5PR8zAge7e5r/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BIZwSLk2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95E24C113CC;
	Sun,  5 May 2024 17:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714929520;
	bh=siSKxyKMPfbUfgRJE2KkzJJ3nXpR2oCWZyv7uG3ylxU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BIZwSLk2+l7Kte2EqnSMN++r12JqfbAK7kK2k1vw8+etkQWhYNGyEntJ1DA0pRRIq
	 XNFvTGipBC1su9tm28Cn0YNv1kXyLOHv0Uri81gy+YYV97jLQk18EFxWvlH8M7F3WA
	 /dgGitDAOXj8PlnOW+RxyumaDgp75Pxi6JNRR0la2OMhUZ0BjoUArRGqu8xY5CqPD+
	 9pb20LdeLmS3gHoHtyiMvsRlUjlRQ0ukxnhhUCID21WQ7WiNVe+T5sYuG30TCeofBX
	 OmHXEA3ZfE08A3MieEAsAh4AjtoB7zhJ3zz959fpFw54nODpWtVwgrcLx2lxtXbhNm
	 pNKwGS66V+ctA==
Date: Sun, 5 May 2024 18:18:29 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Petar Stoykov <pd.pstoykov@gmail.com>
Cc: linux-iio@vger.kernel.org, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Rob Herring <robh+dt@kernel.org>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Angel Iglesias
 <ang.iglesiasg@gmail.com>, Conor Dooley <conor+dt@kernel.org>,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/3] iio: pressure: Add driver for Sensirion SDP500
Message-ID: <20240505181829.49864540@jic23-huawei>
In-Reply-To: <CADFWO8EQUkGcbE=RXjxXbub2tZge9+ss=gB-Q6wngFAvwFygRg@mail.gmail.com>
References: <CADFWO8EQUkGcbE=RXjxXbub2tZge9+ss=gB-Q6wngFAvwFygRg@mail.gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Apr 2024 17:27:24 +0200
Petar Stoykov <pd.pstoykov@gmail.com> wrote:

> From 6ae7537517f551540121ca6fb3b99080b7580410 Mon Sep 17 00:00:00 2001
> From: Petar Stoykov <pd.pstoykov@gmail.com>
> Date: Mon, 15 Jan 2024 12:21:26 +0100
> Subject: [PATCH 2/3] iio: pressure: Add driver for Sensirion SDP500
> 
> Sensirion SDP500 is a digital differential pressure sensor. The sensor is
> accessed over I2C.
> 
> Signed-off-by: Petar Stoykov <pd.pstoykov@gmail.com>
Hi Petar

Ignoring the patch formatting which others have already given feedback on,
a few minor comments inline.

Also, I'd expect some regulator handling to turn the power on.
Obviously on your particular board there may be nothing to do but good to
have the support in place anyway and it will be harmless if the power
is always on.

Jonathan

>  st_pressure-$(CONFIG_IIO_BUFFER) += st_pressure_buffer.o
> diff --git a/drivers/iio/pressure/sdp500.c b/drivers/iio/pressure/sdp500.c
> new file mode 100644
> index 000000000000..7efcc69e829c
> --- /dev/null
> +++ b/drivers/iio/pressure/sdp500.c
> @@ -0,0 +1,144 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +#include <linux/i2c.h>
> +#include <linux/crc8.h>
> +#include <linux/iio/iio.h>
> +#include <asm/unaligned.h>
> +
> +#define SDP500_CRC8_POLYNOMIAL  0x31   // x8 + x5 + x4 + 1 (normalized to 0x31)
> +#define SDP500_READ_SIZE        3
> +#define SDP500_CRC8_WORD_LENGTH 2

As below. I'd establish these off the data the are the lengths of by using
a structure definition.  That will be more obvious and less fragile than
defines hiding up here.


> +#define SDP500_CRC8_INIT        0x00

I'd just use the number inline.  Can't see what the define is adding.

> +
> +#define SDP500_SCALE_FACTOR 60
> +
> +#define SDP500_I2C_START_MEAS 0xF1
> +
> +struct sdp500_data {
> +    struct device *dev;
> +};
> +
> +DECLARE_CRC8_TABLE(sdp500_crc8_table);
> +
> +static int sdp500_start_measurement(struct sdp500_data *data, const
> struct iio_dev *indio_dev)
> +{
> +    struct i2c_client *client = to_i2c_client(data->dev);
> +
> +    return i2c_smbus_write_byte(client, SDP500_I2C_START_MEAS);
Doesn't seem worth a wrapper function. I would just put this code inline.
> +}
> +
> +static const struct iio_chan_spec sdp500_channels[] = {
> +    {
> +        .type = IIO_PRESSURE,
> +        .info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),

As below. It's a linear scale factor, so I would prefer _RAW and _SCALE
to let userspace deal with the maths.

> +    },
> +};
> +
> +static int sdp500_read_raw(struct iio_dev *indio_dev,
> +              struct iio_chan_spec const *chan,
> +              int *val, int *val2, long mask)
> +{
> +    int ret;
> +    u8 rxbuf[SDP500_READ_SIZE];
You could define this as a struct so all the data types are obvious.

	struct {
		__be16 data;
		u8 crc;
	} __packed rxbuf;
The  __packed let's you use sizeof(rxbuf) for the transfer size.
Beware though as IIRC that will mean data is not necessarily aligned
so you'll still need the unaligned accessors.

> +    u8 rec_crc, calculated_crc;
> +    s16 dec_value;
> +    struct sdp500_data *data = iio_priv(indio_dev);
> +    struct i2c_client *client = to_i2c_client(data->dev);
> +
> +    switch (mask) {
> +    case IIO_CHAN_INFO_PROCESSED:
> +        ret = i2c_master_recv(client, rxbuf, SDP500_READ_SIZE);
> +        if (ret < 0) {
> +            dev_err(indio_dev->dev.parent, "Failed to receive data");
> +            return ret;
> +        }
> +        if (ret != SDP500_READ_SIZE) {
> +            dev_err(indio_dev->dev.parent, "Data is received wrongly");

I'd guess indio_dev->dev.parent == data->dev
If so use data->dev as more compact and that's where you are getting the
i2c_client from.

> +            return -EIO;
> +        }
> +
> +        rec_crc = rxbuf[2];
> +        calculated_crc = crc8(sdp500_crc8_table, rxbuf,
> SDP500_CRC8_WORD_LENGTH,

I'd use the number 2 for length directly as it's useful to know this is the
__be16 only, or sizeof(__be16)
What is the point in rec_crc local variable?

> +            SDP500_CRC8_INIT);
> +        if (rec_crc != calculated_crc) {
> +            dev_err(indio_dev->dev.parent, "calculated crc = 0x%.2X,
> received 0x%.2X",
> +                calculated_crc, rec_crc);
> +            return -EIO;
> +        }
> +
> +        dec_value = get_unaligned_be16(rxbuf);
> +        dev_dbg(indio_dev->dev.parent, "dec value = %d", dec_value);

When you move to returning scale and _raw this print won't add anything so
drop it.

> +
> +        *val = dec_value;
> +        *val2 = SDP500_SCALE_FACTOR;
For linear transforms like this it is normally better to provide separate
raw and scale interfaces.

Then if anyone does want to add buffered support in the future that is easier
to do as it is much more compact + userspace has floating point which is always
going to be better for division than we can do in kernel.

> +        return IIO_VAL_FRACTIONAL;
> +    default:
> +        return -EINVAL;
> +    }
> +}
> +
> +static const struct iio_info sdp500_info = {
> +    .read_raw = &sdp500_read_raw,
> +};
> +
> +static int sdp500_probe(struct i2c_client *client)
> +{
> +    struct iio_dev *indio_dev;
> +    struct sdp500_data *data;
> +    struct device *dev = &client->dev;
> +    int ret;
> +    u8 rxbuf[SDP500_READ_SIZE];
> +
> +    indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> +    if (!indio_dev)
> +        return -ENOMEM;
> +
> +    /* has to be done before the first i2c communication */
> +    crc8_populate_msb(sdp500_crc8_table, SDP500_CRC8_POLYNOMIAL);
> +
> +    data = iio_priv(indio_dev);
> +    data->dev = dev;
> +
> +    indio_dev->name = "sdp500";
> +    indio_dev->channels = sdp500_channels;
> +    indio_dev->info = &sdp500_info;
> +    indio_dev->modes = INDIO_DIRECT_MODE;
> +    indio_dev->num_channels = ARRAY_SIZE(sdp500_channels);
> +
> +    ret = sdp500_start_measurement(data, indio_dev);
> +    if (ret)
> +        return dev_err_probe(dev, ret, "Failed to start measurement");

Blank line here would help readability a tiny bit.

> +    /* First measurement is not correct, read it out to get rid of it */
> +    i2c_master_recv(client, rxbuf, SDP500_READ_SIZE);
> +
> +    ret = devm_iio_device_register(dev, indio_dev);
> +    if (ret < 0)
> +        return dev_err_probe(dev, ret, "Failed to register indio_dev");

We rarely bother with error prints on failure to register as it is unlikely
to fail because of something that happened at runtime and if it does, that
is easy to track down.  So I'd drop this print.
If you really want to keep it I don't mind that much.

> +
> +    return 0;
> +}
> +
> +static const struct i2c_device_id sdp500_id[] = {
> +    { "sdp500" },
> +    { }
> +};
> +MODULE_DEVICE_TABLE(i2c, sdp500_id);
> +
> +static const struct of_device_id sdp500_of_match[] = {
> +    { .compatible = "sensirion,sdp500" },
> +    { }
> +};
> +MODULE_DEVICE_TABLE(of, sdp500_of_match);
> +
> +static struct i2c_driver sdp500_driver = {
> +    .driver = {
> +        .name    = "sensirion,sdp500",
> +        .of_match_table = sdp500_of_match,
> +    },
> +    .probe       = sdp500_probe,
> +    .id_table    = sdp500_id,
I'd not bother with aligning = signs. It just tends to create noise
as drivers evolve and people try to keep things aligned (resulting in realigning
everything).

> +};
> +module_i2c_driver(sdp500_driver);
> +
> +MODULE_AUTHOR("Thomas Sioutas <thomas.sioutas@prodrive-technologies.com>");
> +MODULE_DESCRIPTION("Driver for Sensirion SDP500 differential pressure sensor");
> +MODULE_LICENSE("GPL");


