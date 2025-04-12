Return-Path: <linux-iio+bounces-18013-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6709A86DF6
	for <lists+linux-iio@lfdr.de>; Sat, 12 Apr 2025 17:38:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B62D5441AA7
	for <lists+linux-iio@lfdr.de>; Sat, 12 Apr 2025 15:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A7F1F666B;
	Sat, 12 Apr 2025 15:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C2Pnlx+I"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A21F155743;
	Sat, 12 Apr 2025 15:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744472315; cv=none; b=aqnJnsyEdpFDB4Qs1f1OMTGPiQGNtCpUvMC3XNBMOxPZQ5APCOu/lMQVPuMWbLwTOufAWA3ir4h3AbqiSIbRvvixY/8uSMfdrzLM2w7MJlt0h7ZKleKxcseH16fDh3K0S7usSSkt2pKioybmSZSnsJF3UBTIi8R8Iyn8MAmkYTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744472315; c=relaxed/simple;
	bh=nYXK62oZrIkWHjJiviigGvB6gRLznolm2IMTno6Q7Ns=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mRgqGzAW9eX6Pt6JraIETND+Wed9ImxVTKOFCKhTfKljp58pGI84Rjdtmemm5ZYtQ3tcqrQB1e891PQkcIG1Yio5FAz5u1a6beIT6aQfsrc/AOeIOMCfPd8B/o3hVB9eLo79MHt7kkMmTJA4nzj3EdUsU0KaWyR5K+or+BsIqy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C2Pnlx+I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE450C4CEE3;
	Sat, 12 Apr 2025 15:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744472314;
	bh=nYXK62oZrIkWHjJiviigGvB6gRLznolm2IMTno6Q7Ns=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=C2Pnlx+IoLjQWBjxW7J3f/em9MwxcdaPEH1DllbF5ixqwNPCCx0IV5C0U0RIoqQmY
	 UXkPmQ01tVDpQKiX0jBMitcvaOW04u0hgVJzi4wepTEjELY6OeEjYohAuDsOR3b3tY
	 fRblfjXWF633tyG5gwb9/aCcjvrMdhzLuQdja7bXKxc+JmoTtAyTnTqHPt2l5c+bNv
	 SXkMnDMxRqzGP1tMOjj7UY0qau7IsoGLWqIiujnzKGxPOuNpyTsoA8W4E1ExqQM/FL
	 i+Wz7Vf+QTSlZ6FDh0EpsI0kjCEt/aJV41AayfvxMEvP4lrTAsYkojo9kZSyVjw0CO
	 hGWvB7w/A6S8A==
Date: Sat, 12 Apr 2025 16:38:25 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Gyeyoung Baek <gye976@gmail.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Subject: Re: [PATCH v3 3/4] iio: chemical: add support for winsen MHZ19B CO2
 sensor
Message-ID: <20250412163825.250a9435@jic23-huawei>
In-Reply-To: <20250409024311.19466-5-gye976@gmail.com>
References: <20250409024311.19466-1-gye976@gmail.com>
	<20250409024311.19466-5-gye976@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  9 Apr 2025 11:43:10 +0900
Gyeyoung Baek <gye976@gmail.com> wrote:

> Add support for winsen MHZ19B CO2 sensor.
> 
> Datasheet:
> https://www.winsen-sensor.com/d/files/infrared-gas-sensor/mh-z19b-co2-ver1_0.pdf
> 
> Signed-off-by: Gyeyoung Baek <gye976@gmail.com>

Hi Gyeyoung,

A few additional comments inline.

Jonathan

> diff --git a/drivers/iio/chemical/mhz19b.c b/drivers/iio/chemical/mhz19b.c
> new file mode 100644
> index 000000000000..d9a16e022b36
> --- /dev/null
> +++ b/drivers/iio/chemical/mhz19b.c
> @@ -0,0 +1,347 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * mh-z19b co2 sensor driver
> + *
> + * Copyright (c) 2025 Gyeyoung Baek <gye976@gmail.com>
> + *
> + * Datasheet:
> + * https://www.winsen-sensor.com/d/files/infrared-gas-sensor/mh-z19b-co2-ver1_0.pdf
> + */
> +
> +#include <linux/cleanup.h>

Do you use this?

> +#include <linux/completion.h>
> +#include <linux/device.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/serdev.h>
> +#include <linux/unaligned.h>
> +
> +struct mhz19b_state {
> +	struct serdev_device *serdev;
> +	struct regulator *vin;

As inline, you shouldn't need to keep this around if you use
the devm based management for the regulator.

> +
> +	/*
> +	 * serdev receive buffer.
> +	 * When data is received from the MH-Z19B,
> +	 * the 'mhz19b_receive_buf' callback function is called and fills this buffer.
> +	 */
> +	char buf[9];

Use the CMD_SIZE define below for this 9 (having moved it up).

> +	int buf_idx;
> +
> +	/* must wait the 'buf' is filled with 9 bytes.*/
> +	struct completion buf_ready;
> +};
> +
> +/*
> + * commands have following format:
> + *
> + * +------+------+-----+------+------+------+------+------+-------+
> + * | 0xFF | 0x01 | cmd | arg0 | arg1 | 0x00 | 0x00 | 0x00 | cksum |
> + * +------+------+-----+------+------+------+------+------+-------+
> + */
> +#define MHZ19B_CMD_SIZE 9
> +
> +#define MHZ19B_ABC_LOGIC_CMD		0x79
> +#define MHZ19B_READ_CO2_CMD		0x86
> +#define MHZ19B_SPAN_POINT_CMD		0x88
> +#define MHZ19B_ZERO_POINT_CMD		0x87
> +
> +#define MHZ19B_ABC_LOGIC_OFF_CKSUM	0x86
> +#define MHZ19B_ABC_LOGIC_ON_CKSUM	0xE6
> +#define MHZ19B_READ_CO2_CKSUM		0x79
> +#define MHZ19B_ZERO_POINT_CKSUM	0x78
Can we not just calculate these from the buffer contents?

> +
> +/* ABC logic in MHZ19B means auto calibration. */
> +
> +#define MHZ19B_SERDEV_TIMEOUT	msecs_to_jiffies(100)
> +
> +static uint8_t mhz19b_get_checksum(uint8_t *packet)
> +{
> +	uint8_t i, checksum = 0;
> +
> +	for (i = 1; i < 8; i++)
> +		checksum += packet[i];
> +
> +	checksum = 0xff - checksum;
> +	checksum += 1;
> +
> +	return checksum;
> +}
> +
> +static int mhz19b_serdev_cmd(struct iio_dev *indio_dev,
> +	int cmd, void *arg)
> +{
> +	struct mhz19b_state *st = iio_priv(indio_dev);
> +	struct serdev_device *serdev = st->serdev;
> +	struct device *dev = &indio_dev->dev;
> +	int ret;
> +
> +	/*
> +	 * cmd_buf[3,4] : arg0,1
> +	 * cmd_buf[8]	: checksum
> +	 */
> +	uint8_t cmd_buf[MHZ19B_CMD_SIZE] = {
> +		0xFF, 0x01, cmd,
> +	};
> +
> +	switch (cmd) {
> +	case MHZ19B_ABC_LOGIC_CMD: {
> +		bool enable = *((bool *)arg);
Given you could just pass and u16 for the argument and use 0 /1 for
the bool.  The u16 works directly for the ppm value where needed for span
point

> +
> +		if (enable) {
> +			cmd_buf[3] = 0xA0;
> +			cmd_buf[8] = MHZ19B_ABC_LOGIC_ON_CKSUM;
All these checksums should be easy enough to calculate which would be
simpler to follow than writing constants like this.

You are already doing so for the span point one so do that for them
all.

> +		} else {
> +			cmd_buf[3] = 0;
> +			cmd_buf[8] = MHZ19B_ABC_LOGIC_OFF_CKSUM;
> +		}
> +		break;
> +	} case MHZ19B_READ_CO2_CMD: {
> +		cmd_buf[8] = MHZ19B_READ_CO2_CKSUM;
> +		break;
> +	} case MHZ19B_SPAN_POINT_CMD: {
> +		uint16_t ppm = *((uint16_t *)arg);
For kernel internal code use the older types u16 etc

> +
> +		put_unaligned_be16(ppm, &cmd_buf[3]);
> +		cmd_buf[MHZ19B_CMD_SIZE - 1] = mhz19b_get_checksum(cmd_buf);
Using index value of 8 for all these for consistency.
> +		break;
> +	} case MHZ19B_ZERO_POINT_CMD: {
> +		cmd_buf[8] = MHZ19B_ZERO_POINT_CKSUM;
> +		break;
> +	} default:
> +		break;
> +	}
> +
> +	/* write buf to uart ctrl syncronously */
> +	ret = serdev_device_write(serdev, cmd_buf, MHZ19B_CMD_SIZE, 0);
> +	if (ret != MHZ19B_CMD_SIZE) {
> +		dev_err(dev, "write err, %d bytes written", ret);
> +		return -EINVAL;
> +	}
> +
> +	switch (cmd) {
> +	case MHZ19B_READ_CO2_CMD:
> +		ret = wait_for_completion_interruptible_timeout(&st->buf_ready,
> +			MHZ19B_SERDEV_TIMEOUT);
> +		if (ret < 0)
> +			return ret;
> +		if (!ret)
> +			return -ETIMEDOUT;
> +
> +		ret = mhz19b_get_checksum(st->buf);
> +		if (st->buf[MHZ19B_CMD_SIZE - 1] != mhz19b_get_checksum(st->buf)) {
> +			dev_err(dev, "checksum err");
> +			return -EINVAL;
> +		}
> +
> +		ret = get_unaligned_be16(&st->buf[2]);

return get_unaligned_be16()

> +		return ret;
> +	default:
> +		/* no response commands. */
> +		return 0;
> +	}
> +}
> +
> +static int mhz19b_read_raw(struct iio_dev *indio_dev,
> +	struct iio_chan_spec const *chan,
> +	int *val, int *val2, long mask)

Generally, unless we have very long lines align the following sets of parameters
with just after the (
static int mhz19b_read_raw(struct iio_dev *indio_dev,
			   struct iio_chan_spec const *chan,
			   int *val, int *val2, long mask)

Same applies in various other places in the code.

> +{
> +	int ret = mhz19b_serdev_cmd(indio_dev, MHZ19B_READ_CO2_CMD, NULL);
> +
> +	if (ret < 0)
> +		return ret;
> +
> +	*val = ret;
> +	return IIO_VAL_INT;
> +}


> +
> +static const struct serdev_device_ops mhz19b_ops = {
> +	.receive_buf = mhz19b_receive_buf,
> +	.write_wakeup = serdev_device_write_wakeup,
> +};
> +
> +static int mhz19b_probe(struct serdev_device *serdev)
> +{
> +	int ret;
> +	struct device *dev = &serdev->dev;
> +	struct iio_dev *indio_dev;
> +	struct mhz19b_state *st;
> +
> +	serdev_device_set_client_ops(serdev, &mhz19b_ops);
> +
> +	ret = devm_serdev_device_open(dev, serdev);
> +	if (ret)
> +		return ret;
> +
> +	ret = serdev_device_set_baudrate(serdev, 9600);
> +	if (ret < 0)
> +		return ret;
> +
> +	serdev_device_set_flow_control(serdev, false);
> +
> +	ret = serdev_device_set_parity(serdev, SERDEV_PARITY_NONE);
> +	if (ret < 0)
> +		return ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(struct mhz19b_state));

sizeof(*st) is both more compact and obviously correct with out a reader
having to go check if the st in..

> +	if (!indio_dev)
> +		return ret;
> +	dev_set_drvdata(dev, indio_dev);
> +
> +	st = iio_priv(indio_dev);

this line is the same size as we passed to devm_iio_device_alloc()

> +	st->serdev = serdev;
> +
> +	init_completion(&st->buf_ready);
> +
> +	st->vin = devm_regulator_get(dev, "vin");
> +	if (IS_ERR(st->vin))
> +		return PTR_ERR(st->vin);
> +
> +	ret = regulator_enable(st->vin);

Don't mix devm and non devm calls in probe.  In this case you introduced
a race where the power is turned off before we remove the userspace
interfaces which is unlikely to go well...

	ret = devm_regulator_get_enabled(dev, "vin);
	if (ret)
		return ret;

and no need for a remove.

> +	if (ret)
> +		return ret;
> +
> +	indio_dev->name = "mh-z19b";
> +	indio_dev->channels = mhz19b_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(mhz19b_channels);
> +	indio_dev->info = &mhz19b_info;
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}
> +
> +static void mhz19b_remove(struct serdev_device *serdev)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(&serdev->dev);
> +	struct mhz19b_state *st = iio_priv(indio_dev);
> +
> +	regulator_disable(st->vin);

As above - remove will be unnecessary once the regulator is also
device managed (devm_...)

J

