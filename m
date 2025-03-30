Return-Path: <linux-iio+bounces-17339-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A76FDA75A45
	for <lists+linux-iio@lfdr.de>; Sun, 30 Mar 2025 16:04:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33CFB1648C2
	for <lists+linux-iio@lfdr.de>; Sun, 30 Mar 2025 14:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 214B319CD07;
	Sun, 30 Mar 2025 14:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L5ZaKBip"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC723FE4;
	Sun, 30 Mar 2025 14:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743343458; cv=none; b=T/GLqJmymrmd0iv/w28KfY8SDQdeurFaUdFszjHq387Wa0SAGiRGaaWKVb3gzjStB963mPx6XX8Wu7Ag4DL3AiXDiDJ9im2+Nj1xMWm7ZmnvFl0eZ1EFOz2oR3PyxS78qYzFMnsAoer6DK7xr4tS9wGbjJ7XM4u2/oUZDqctpQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743343458; c=relaxed/simple;
	bh=dW2fWipsc15woelUWZHZ417w3TciACM4wNgZtCQfZyk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uzTqaicV/hu/kzlKir8JZ6k29ZQhjvahkn2JigryGPkbg/nakdMdgPEb56Uy4igLZma6muquKrD+QgaMtYs9NCvHMI2fuvhI/LmjhjwPwvQOUgE5r0F6BFYy3iwNmtNI6oPe0YbD0B26CN7AoVx03C5pwfyr/84dl3i5oLJYr4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L5ZaKBip; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38A05C4CEDD;
	Sun, 30 Mar 2025 14:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743343456;
	bh=dW2fWipsc15woelUWZHZ417w3TciACM4wNgZtCQfZyk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=L5ZaKBip0v6FtzGwUGqKmhmQRUbsqvFOmDgryUfAc3TTUYGxrQfZeuS6uGDKmGYoE
	 P/viM8het/sCzjGyATREKFU7ZXdMbtp9QbVV0KeLiZeRyXtd94T0RL3TaV6qpSi+Oq
	 XB94xJwQCRkPugbphMGzMmMm8WGreEExJgI0Zf1t1BQdTdI4S1wLoNsbgykZtWmxnj
	 SnTUqNYXGp7xDqm5lO/62ycK4DRH4YNAFSzoVCkm3IvlDMIrHPfUsABLnmB1tGhkqs
	 YWl9Dc40Zpk5l5leav76jkrxD6VOtoQwrwVAnNi0l+oNBg+I+UnfKF1mhHoaJ5lUrf
	 pbOOCwDPRF1og==
Date: Sun, 30 Mar 2025 15:04:10 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Gyeyoung Baek <gye976@gmail.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, lars@metafoo.de,
 gustavograzs@gmail.com, javier.carrasco.cruz@gmail.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org
Subject: Re: [PATCH 1/3] iio: chemical: add support for winsen MHZ19B CO2
 sensor
Message-ID: <20250330150410.23b148da@jic23-huawei>
In-Reply-To: <20250329164905.632491-2-gye976@gmail.com>
References: <20250329164905.632491-1-gye976@gmail.com>
	<20250329164905.632491-2-gye976@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 30 Mar 2025 01:49:03 +0900
Gyeyoung Baek <gye976@gmail.com> wrote:

> Add support for winsen MHZ19B CO2 sensor.
Hi,

Good to add a little more detail here.
> 
Ideally add a
DataSheet tag here so we have a record in the git log on where to find
a datasheet.

Various comments inline.

The big stuff is that you are adding ABI without documentation.
Also that ABI doesn't seem that well aligned with existing calibration related
ABI.

> Signed-off-by: Gyeyoung Baek <gye976@gmail.com>
> ---
>  drivers/iio/chemical/Kconfig  |   6 +
>  drivers/iio/chemical/Makefile |   1 +
>  drivers/iio/chemical/mhz19b.c | 354 ++++++++++++++++++++++++++++++++++
>  3 files changed, 361 insertions(+)
>  create mode 100644 drivers/iio/chemical/mhz19b.c
> 

> diff --git a/drivers/iio/chemical/mhz19b.c b/drivers/iio/chemical/mhz19b.c
> new file mode 100644
> index 000000000000..de900131035b
> --- /dev/null
> +++ b/drivers/iio/chemical/mhz19b.c
> @@ -0,0 +1,354 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * mh-z19b co2 sensor driver
> + *
> + * Copyright (c) 2025 Gyeyoung Baek <gye976@gmail.com>
> + */
> +
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/serdev.h>
> +#include <linux/of.h>
Shouldn't be needed here. I'd guess you want
mod_devicetable.h

> +#include <linux/device.h>
> +#include <linux/iio/iio.h>
> +#include <linux/mutex.h>
> +#include <linux/cleanup.h>
Alphabetical order preferred for includes.  As it's an IIO driver
you can pull that out to a separate include block at the end if you
like. I'm fine with it in alphabetical order with the other headers
if you prefer that.

> +
> +struct mhz19b_state {
> +	struct serdev_device *serdev;
> +
> +	/* serdev receive buffer */
> +	char buf[9];
> +	int buf_idx;
> +
> +	/* protect access to mhz19b_state */
Be more specific. I'd imagine it's the buffer rather
than the serdev pointer...
> +	struct mutex lock;
> +};
> +
> +/* ABC logig on/off */

If the names of command defines are good then we don't need the comments.
I'd modify them a little to make that true here and drop the comments
unless they are adding something more

> +#define MHZ19B_ABC_LOGIC_CMD		0x79
> +/* read CO2 concentration */
> +#define MHZ19B_READ_CO2_CMD		0x86
> +/* calibrate Zero Point */
> +#define MHZ19B_ZERO_POINT_CMD		0x87
> +/* calibrate Span Point */
> +#define MHZ19B_SPAN_POINT_CMD		0x88
> +/* set sensor detection range */
> +#define MHZ19B_DETECTION_RANGE_CMD	0x99
}
> +
> +static int mhz19b_serdev_cmd(struct iio_dev *indio_dev, int cmd, const char *str)
> +{
> +	int ret = 0;
> +	struct serdev_device *serdev;
> +	struct mhz19b_state *mhz19b;
> +	struct device *dev;
> +
> +	mhz19b = iio_priv(indio_dev);
> +	serdev = mhz19b->serdev;
> +	dev = &indio_dev->dev;
These can all be combined with declarations to save a few lines of code.

> +
> +	/*
> +	 * commands have following format:
> +	 *
> +	 * +------+------+-----+------+------+------+------+------+-------+
> +	 * | 0xFF | 0x01 | cmd | arg0 | arg1 | 0x00 | 0x00 | 0x00 | cksum |
> +	 * +------+------+-----+------+------+------+------+------+-------+
> +	 */
> +	uint8_t cmd_buf[MHZ19B_CMD_SIZE] = {
> +		0xFF, 0x01, cmd,
> +	};
> +
> +	switch (cmd) {
> +	case MHZ19B_ABC_LOGIC_CMD:
> +	{

I'd move the { to the line above.


> +		bool enable;
> +
> +		ret = kstrtobool(str, &enable);
> +		if (ret)
> +			return ret;
> +
> +		cmd_buf[3] = enable ? 0xA0 : 0x00;
> +		break;
> +	}
> +	case MHZ19B_SPAN_POINT_CMD:
> +	{
> +		uint16_t ppm;
> +
> +		ret = kstrtou16(str, 10, &ppm);
> +		if (ret)
> +			return ret;
> +
> +		/* at least 1000ppm */
> +		if (ppm < 1000 || ppm > 5000) {
> +			dev_dbg(&indio_dev->dev, "span point ppm should be 1000~5000");
> +			return -EINVAL;
> +		}
> +
> +		cmd_buf[3] = ppm / 256;
> +		cmd_buf[4] = ppm % 256;

That's an elaborate way of doing
		unaligned_put_be16()
so use that instead as it's also clearly documenting what is going on.

> +		break;
> +	}
> +	case MHZ19B_DETECTION_RANGE_CMD:
> +	{
> +		uint16_t range;
> +
> +		ret = kstrtou16(str, 10, &range);
> +		if (ret)
> +			return ret;
> +
> +		/* Detection Range should be 2000 or 5000 */
> +		if (!(range == 2000 || range == 5000)) {
> +			dev_dbg(&indio_dev->dev, "detection range should be 2000 or 5000");
> +			return -EINVAL;
> +		}
> +
> +		cmd_buf[3] = range / 256;
> +		cmd_buf[4] = range % 256;
Same as above.
> +		break;
> +	}
> +	default:
> +		break;
> +	}
> +	cmd_buf[MHZ19B_CMD_SIZE - 1] = mhz19b_get_checksum(cmd_buf);
> +
> +	scoped_guard(mutex, &mhz19b->lock) {
> +		ret = serdev_device_write(serdev, cmd_buf, MHZ19B_CMD_SIZE, 0);
> +		mhz19b->buf_idx = 0;
> +
> +		if (ret != MHZ19B_CMD_SIZE) {
> +			dev_err(dev, "write err, %d bytes written", ret);
> +			return -EINVAL;
> +		}
> +
> +		switch (cmd) {
> +		case MHZ19B_READ_CO2_CMD:
> +			if (mhz19b->buf[MHZ19B_CMD_SIZE - 1] != mhz19b_get_checksum(mhz19b->buf)) {
> +				dev_err(dev, "checksum err");
> +				return -EINVAL;
> +			}
> +
> +			ret = (mhz19b->buf[2] << 8) + mhz19b->buf[3];

That's an unaligned_get_be16() I think. If so use that instead of opencoding.

> +			break;
> +		default:
> +			/* no response commands. */
Might as well return early in each of these cases.

> +			ret = 0;
> +			break;
> +		}
> +	}
> +
> +	return ret;
> +}
> +
> +static int mhz19b_read_raw(struct iio_dev *indio_dev, struct iio_chan_spec const *chan,
Trivial but for IIO I'd prefer we try to keep under 80 chars still when it does
not effect readability.  Here adding a wrap after indio_dev doesn't make it harder
to read.

> +	int *val, int *val2, long mask)
Align after ( 

> +{
> +	struct mhz19b_state *mhz19b;
> +	int ret;
> +
> +	mhz19b = iio_priv(indio_dev);
	struct mhz19b_state *mhz19b = iio_priv(indio_dev);
at the point of declaration above.

> +
> +	ret = mhz19b_serdev_cmd(indio_dev, MHZ19B_READ_CO2_CMD, NULL);
> +	if (ret < 0)
> +		return ret;
> +
> +	*val = ret;
> +	return IIO_VAL_INT;
> +}
> +
> +static const struct iio_info mhz19b_info = {
> +	.read_raw = mhz19b_read_raw,
> +};

> +
> +struct iio_chan_spec_ext_info mhz19b_co2_ext_info[] = {
> +	{
> +		.name = "zero_point",

This is custom ABI.  Before we consider that in detail we
need documentation in
Documentation/ABI/testing/sysfs-bus-iio-mhz19b
It is much easier to review ABI with docs.
All 3 are direct commands to the device, so I've no idea from
what we have here on what they do.

Superficially this one looks like a calibration control.
There is existing ABI for that.


> +		.write = mhz19b_zero_point_write,
> +	},
> +	{
> +		.name = "span_point",
> +		.write = mhz19b_span_point_write,
Also looks like calibration.  See if you can come
up with ABI that matches with what we already have for calibration
of ADCs etc.
> +	},
> +	{
> +		.name = "abc_logic",

Definitely not good logic. ABC is a term they made up as far
as i can tell.  See if you can find existing ABI for this.
I think we have other controls for autonomous calibration cycles.

> +		.write = mhz19b_abc_logic_write,
> +	},
> +	{}
	{ }
preferred for IIO code.

> +};
> +
> +static const struct iio_chan_spec mhz19b_channels[] = {
> +	{
> +		.type = IIO_CONCENTRATION,
> +		.channel2 = IIO_MOD_CO2,
> +		.modified = 1,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
> +
> +		.ext_info = mhz19b_co2_ext_info,
> +	},
> +};
> +
> +static int mhz19b_core_probe(struct device *dev)

As below.  This function isn't sufficiently complex to justify
a separate function.

> +{
> +	int ret;
> +
> +	struct serdev_device *serdev;
> +	struct mhz19b_state *mhz19b;
> +	struct iio_dev *indio_dev;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(struct mhz19b_state));

sizeof(*mhz19b));

> +	if (indio_dev == NULL)
> +		return ret;
> +
> +	dev_set_drvdata(dev, indio_dev);
> +
> +	mhz19b = iio_priv(indio_dev);
> +
> +	mhz19b->buf_idx = 0;
No need to explicitly zero as it is allocated by kzalloc.  Fine to
keep it though if you think it adds benefit as 'documentation'.
> +	ret = devm_mutex_init(dev, &mhz19b->lock);
> +	if (ret)
> +		return ret;
> +
> +	serdev = container_of(dev, struct serdev_device, dev);

breaking out the _core_probe() makes this more complex as in the
caller serdev is already available.

> +
> +	mhz19b->serdev = serdev;
> +
> +	indio_dev->name = "mh-z19b";
> +	indio_dev->channels = mhz19b_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(mhz19b_channels);
> +	indio_dev->info = &mhz19b_info;
> +
> +	ret = devm_iio_device_register(dev, indio_dev);

return devm_iio_device_register()

> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static size_t mhz19b_receive_buf(struct serdev_device *serdev, const u8 *data, size_t len)
> +{
> +	struct iio_dev *indio_dev;
	struct iio_dev *indio_dev = dev_get_drvdata(&serdev->dev);
	struct mhz19b_state *mhz19b = iio_priv(indio_dev);

to save a few lines.


> +	struct mhz19b_state *mhz19b;
> +
> +	indio_dev = dev_get_drvdata(&serdev->dev);
> +	mhz19b = iio_priv(indio_dev);
> +
> +	for (int i = 0; i < len; i++)
> +		mhz19b->buf[mhz19b->buf_idx++] = data[i];
> +
> +	return len;
> +}
> +
> +static void mhz19b_write_wakeup(struct serdev_device *serdev)
> +{
> +	struct iio_dev *indio_dev;
> +
> +	indio_dev = dev_get_drvdata(&serdev->dev);
> +
> +	dev_dbg(&indio_dev->dev, "mhz19b_write_wakeup");

This doesn't do anything which makes me suspicious. Would
using serdev_device_write_wakeup() as the callback make
sense?  I'm not that familiar with serial drivers but I can
see that a number of other drivers do that.

> +}
> +
> +static const struct serdev_device_ops mhz19b_ops = {
> +	.receive_buf = mhz19b_receive_buf,
> +	.write_wakeup = mhz19b_write_wakeup,
> +};
> +
> +static int mhz19b_probe(struct serdev_device *serdev)
> +{
> +	int ret;
> +
> +	struct device *dev;
> +
> +	dev = &serdev->dev;
> +	serdev_device_set_client_ops(serdev, &mhz19b_ops);
> +
> +	ret = devm_serdev_device_open(dev, serdev);
> +	if (ret)
> +		return ret;
> +
> +	serdev_device_set_baudrate(serdev, 9600);
> +	serdev_device_set_flow_control(serdev, false);
> +	ret = serdev_device_set_parity(serdev, SERDEV_PARITY_NONE);
> +	if (ret < 0)
> +		return ret;

Why check return value from this call but not the previous two?
I'm not immediately able to see a reason this is more likely to fail.

> +
> +	ret = mhz19b_core_probe(dev);

Having a separate _core_probe() seems unnecessary. I'd jut have a single
probe function and put all that code inline here.

> +	if (ret)
> +		return ret;
> +

return mhz19b_core_probe();

> +	return 0;
> +}
> +
> +static const struct of_device_id mhz19b_of_match[] = {
> +	{ .compatible = "winsen,mhz19b", },
> +	{}

Trivial: I'm trying to standardize formatting of these in IIO
and made the random choice of
	{ }
as the terminating entry style.

> +};

Similar to below, it is common practice to have no blank line
between this array of structs and the MODULE_DEVICE_TABLE
to reflect how tightly they are coupled.

> +
> +MODULE_DEVICE_TABLE(of, mhz19b_of_match);
> +
> +static struct serdev_device_driver mhz19b_driver = {
> +	.driver = {
> +		.name = "mhz19b",
> +		.of_match_table = mhz19b_of_match,
> +	},
> +	.probe = mhz19b_probe,
> +};
> +

Typical style for these module* lines is to couple them
closely with the struct. That is done by having no blank line here.

> +module_serdev_device_driver(mhz19b_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Gyeyoung Baek");
> +MODULE_DESCRIPTION("MH-Z19B CO2 sensor driver using serdev interface");


