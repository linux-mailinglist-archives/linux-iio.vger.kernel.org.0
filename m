Return-Path: <linux-iio+bounces-17611-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E2ACA7BBC0
	for <lists+linux-iio@lfdr.de>; Fri,  4 Apr 2025 13:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA42917AE59
	for <lists+linux-iio@lfdr.de>; Fri,  4 Apr 2025 11:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC6DF1E1DE3;
	Fri,  4 Apr 2025 11:52:05 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6288A51C5A;
	Fri,  4 Apr 2025 11:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743767525; cv=none; b=KNst1w2ObW4NtHjCkUpRwVYdDlz3UPcBqkTXsN132hVm9LJA7JVtnsQRsZBpi+EsGcwaNCPhbDD3u7jbmZRsfNCimnApywdgsw48IuXXm+hwLgTr/0rp7H6KSL5h5lemo8mOZDpNmueaw2D+wLWBtnT5Y9ZZ0wBO+hgs/+7lkPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743767525; c=relaxed/simple;
	bh=GewaFzJ1kJk6EUQQDKJbiGSqmzw6Hr7YwKv5nyEyGr8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S/ghqPjqC6WDfyOKUyifqrwFWcg4dUzOTfqqTX+V5VydMOlNl8zYP2M5Jt1e3F1mWj95ZEgbIGhWH79g8xG1hj+JICMdryAFcjv9Jeslxp0oYCVzhx8/F6xE73UM7ppe5D4TxWpZ6JCIhFj9/y+8Rm29JPT9JQr8Yi4iLhh8A3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZTcLS1bfbz6M4Px;
	Fri,  4 Apr 2025 19:48:16 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id EBE5514080B;
	Fri,  4 Apr 2025 19:51:57 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 4 Apr
 2025 13:51:57 +0200
Date: Fri, 4 Apr 2025 12:51:55 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Gyeyoung Baek <gye976@gmail.com>
CC: <jic23@kernel.org>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <lars@metafoo.de>, <gustavograzs@gmail.com>,
	<javier.carrasco.cruz@gmail.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
Subject: Re: [PATCH v1 4/5] iio: chemical: add support for winsen MHZ19B CO2
 sensor
Message-ID: <20250404125155.0000738d@huawei.com>
In-Reply-To: <20250403053225.298308-5-gye976@gmail.com>
References: <20250403053225.298308-1-gye976@gmail.com>
	<20250403053225.298308-5-gye976@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu,  3 Apr 2025 14:32:24 +0900
Gyeyoung Baek <gye976@gmail.com> wrote:

> Add support for winsen MHZ19B CO2 sensor.
> 
> Datasheet:
> https://www.winsen-sensor.com/d/files/infrared-gas-sensor/mh-z19b-co2-ver1_0.pdf
> 
> Signed-off-by: Gyeyoung Baek <gye976@gmail.com>
Hi.

Various comments inline,

Thanks,

Jonathan

> diff --git a/drivers/iio/chemical/mhz19b.c b/drivers/iio/chemical/mhz19b.c
> new file mode 100644
> index 000000000000..f8f06c01623f
> --- /dev/null
> +++ b/drivers/iio/chemical/mhz19b.c
> @@ -0,0 +1,386 @@

> +struct mhz19b_state {
> +	struct serdev_device *serdev;
> +
> +	/* TO DO, nothing for now.*/
> +	struct regulator *vin_supply;

Unlikely you need this here. Look at the
devm regulator calls.

> +
> +	/* serdev receive buffer.

Fix comment syntax as mentioned below.

> +	 * When data is received from the MH-Z19B,
> +	 * the 'mhz19b_receive_buf' callback function is called and fills this buffer.
> +	 */
> +	char buf[9];
> +	int buf_idx;
> +
> +	/* must wait the 'buf' is filled with 9 bytes.*/
> +	struct completion buf_ready;
> +
> +	/* protect access to mhz19b_state */

Be more specific. What and why?  It's not protecting the regulator.

> +	struct mutex lock;
> +};
> +
> +/*
> + * commands have following format:
> + *
> + * +------+------+-----+------+------+------+------+------+-------+
> + * | 0xFF | 0x01 | cmd | arg0 | arg1 | 0x00 | 0x00 | 0x00 | cksum |
> + * +------+------+-----+------+------+------+------+------+-------+
> + *
> + * The following commands are defined in the datasheet.
> + * https://www.winsen-sensor.com/d/files/infrared-gas-sensor/mh-z19b-co2-ver1_0.pdf
> + */
> +#define MHZ19B_CMD_SIZE 9
> +
> +/* ABC logic in MHZ19B means auto calibration.
One line comment so move the */ up to end of this line.

> + */

> +
> +static int mhz19b_serdev_cmd(struct iio_dev *indio_dev,
> +	int cmd, void *arg)
> +{
> +	int ret = 0;
Move declaraton to the scope where it is used.
Then it will be obcious that it is alaway set.

> +	struct mhz19b_state *st = iio_priv(indio_dev);
> +	struct serdev_device *serdev = st->serdev;
> +	struct device *dev = &indio_dev->dev;
> +
> +	/* commands format is described above. */
> +	uint8_t cmd_buf[MHZ19B_CMD_SIZE] = {
> +		0xFF, 0x01, cmd,
> +	};
> +
> +	switch (cmd) {
> +	case MHZ19B_ABC_LOGIC_CMD: {
> +		bool enable = *((bool *)arg);
> +
> +		cmd_buf[3] = enable ? 0xA0 : 0x00;
> +		break;
> +	} case MHZ19B_SPAN_POINT_CMD: {
> +		uint16_t ppm = *((uint16_t *)arg);
> +
> +		put_unaligned_be16(ppm, &cmd_buf[3]);
> +		break;
> +	} case MHZ19B_DETECTION_RANGE_CMD: {
> +		uint16_t range = *((uint16_t *)arg);
> +
> +		put_unaligned_be16(range, &cmd_buf[3]);
> +		break;
> +	} default:
> +		break;
> +	}
> +	cmd_buf[MHZ19B_CMD_SIZE - 1] = mhz19b_get_checksum(cmd_buf);
> +
> +	scoped_guard(mutex, &st->lock) {
> +		/* write buf to uart ctrl syncronously */
> +		ret = serdev_device_write(serdev, cmd_buf, MHZ19B_CMD_SIZE, 0);
> +		if (ret != MHZ19B_CMD_SIZE) {
> +			dev_err(dev, "write err, %d bytes written", ret);
> +			return -EINVAL;
> +		}
> +
> +		switch (cmd) {
> +		case MHZ19B_READ_CO2_CMD:
> +			ret = wait_for_completion_interruptible_timeout(&st->buf_ready,
> +				MHZ19B_SERDEV_TIMEOUT);
> +			if (ret < 0)
> +				return ret;
> +			if (!ret)
> +				return -ETIMEDOUT;
> +
> +			ret = mhz19b_get_checksum(st->buf);
> +			if (st->buf[MHZ19B_CMD_SIZE - 1] != mhz19b_get_checksum(st->buf)) {
> +				dev_err(dev, "checksum err");
> +				return -EINVAL;
> +			}
> +
> +			ret = get_unaligned_be16(&st->buf[2]);
			return get_unaligned_be16()

> +			return ret;
> +		default:
> +			/* no response commands. */
> +			return 0;
> +		}
> +	}
> +}


Cache the ones that aren't a one time thing then (such as this one).

> +
> +static ssize_t calibration_auto_enable_store(struct device *dev,
> +	struct device_attribute *attr,
> +	const char *buf, size_t len)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	bool enable;
> +
> +	int ret = kstrtobool(buf, &enable);
As below. Either have this in the declaration block or not. This
sort of half and half with extra blank lines is unusual.


> +
> +	if (ret)
> +		return ret;
> +
> +	ret = mhz19b_serdev_cmd(indio_dev, MHZ19B_ABC_LOGIC_CMD, &enable);
> +	if (ret < 0)
> +		return ret;
> +
> +	return len;
> +}
> +static IIO_DEVICE_ATTR_WO(calibration_auto_enable, 0);
> +
> +/* write 0		: zero point calibration_auto_enable
> + *	(make sure the sensor had been worked under 400ppm for over 20 minutes.)
> + *
> + * write 1000-5000	: span point calibration:
> + *	(make sure the sensor had been worked under a certain level co2 for over 20 minutes.)
> + */
> +static ssize_t calibration_forced_value_store(struct device *dev,
> +	struct device_attribute *attr,
> +	const char *buf, size_t len)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	uint16_t ppm;
> +	int cmd;
The line break here is odd.  I'd define
	int ret, cmd;

	ret = kstrou16()

> +
> +	int ret = kstrtou16(buf, 10, &ppm);
> +
This blank line is also then unnecessary.

> +	if (ret)
> +		return ret;
> +
> +	/* at least 1000ppm */
> +	if (ppm) {
> +		if (ppm < 1000 || ppm > 5000) {
> +			dev_dbg(&indio_dev->dev,
> +				"span point ppm should be 1000~5000");
> +			return -EINVAL;
> +		}
> +
> +		cmd = MHZ19B_SPAN_POINT_CMD;
> +	} else {
> +		cmd = MHZ19B_ZERO_POINT_CMD;
> +	}
> +
> +	ret = mhz19b_serdev_cmd(indio_dev, cmd, &ppm);
> +	if (ret < 0)
> +		return ret;
> +
> +	return len;
> +}
> +static IIO_CONST_ATTR(calibration_forced_value_available,
> +	"0 1000-5000");

Check the syntax for available attributes. We don't have a good
way to describe this particular set of ranges. So best option
may unfortunately be to not describe it at all.
Anyone calibrating this device is going to be reading the datasheet
anyway so should know what is possible.

> +static IIO_DEVICE_ATTR_WO(calibration_forced_value, 0);
> +
> +/* MH-Z19B supports a measurement range adjustment feature.
/*
 * MH-Z...

> + * It can measure up to 2000 ppm or up to 5000 ppm.
> + */
> +static ssize_t co2_range_store(struct device *dev,
As per comments on ABI docs patch, I don't think we need custom ABI for this.

> +	struct device_attribute *attr,
> +	const char *buf, size_t len)
Except on very long lines, align parameters with just after ( rather.

> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	int ret;
> +	uint16_t range;
> +
> +	ret = kstrtou16(buf, 10, &range);
> +	if (ret)
> +		return ret;
> +
> +	/* Detection Range should be 2000 or 5000 */
> +	if (!(range == 2000 || range == 5000)) {
> +		dev_dbg(&indio_dev->dev, "detection range should be 2000 or 5000");
> +		return -EINVAL;
> +	}
> +
No need for more than one blank line.
> +
> +	ret = mhz19b_serdev_cmd(indio_dev, MHZ19B_DETECTION_RANGE_CMD, &range);
> +	if (ret < 0)
> +		return ret;
> +
> +	return len;
> +}
> +static IIO_CONST_ATTR(co2_range_available,
> +	"2000 5000");
> +static IIO_DEVICE_ATTR_WO(co2_range, 0);
> +
> +static struct attribute *mhz19b_attrs[] = {
> +	&iio_const_attr_calibration_forced_value_available.dev_attr.attr,
> +	&iio_const_attr_co2_range_available.dev_attr.attr,
> +	&iio_dev_attr_calibration_auto_enable.dev_attr.attr,
> +	&iio_dev_attr_calibration_forced_value.dev_attr.attr,
> +	&iio_dev_attr_co2_range.dev_attr.attr,
> +	NULL
> +};

> +
> +static const struct iio_chan_spec mhz19b_channels[] = {
> +	{
> +		.type = IIO_CONCENTRATION,
> +		.channel2 = IIO_MOD_CO2,
> +		.modified = 1,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),

I'm curious. We have a range control in your custom ABI, but no scale.
So what units is this in?

> +	},
> +};

> +
> +/* The 'serdev_device_write' function returns -EINVAL if the 'write_wakeup' member is NULL,
> + * so it must be mandatory.

Answering that in review was fine. No need for comment
(which is formatted wrong for IIO that uses
/*
 * The ...


> + */
> +static void mhz19b_write_wakeup(struct serdev_device *serdev)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(&serdev->dev);

There was still an open question on that where I asked
if a standard existing callback was the correct minimal thing to do.

> +
> +	dev_dbg(&indio_dev->dev, "mhz19b_write_wakeup");
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
> +	/* void type func, no return */

No need for comment then! I was wrong in previous review.

> +	serdev_device_set_flow_control(serdev, false);
> +
> +	ret = serdev_device_set_parity(serdev, SERDEV_PARITY_NONE);
> +	if (ret < 0)
> +		return ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(struct mhz19b_state));
> +	if (indio_dev == NULL)

For simple pointer validity checks.

	if (!indio_dev) is probably more common than checking if NUL.

> +		return ret;
> +	dev_set_drvdata(dev, indio_dev);
> +
> +	st = iio_priv(indio_dev);
> +	st->serdev = serdev;
> +
> +	init_completion(&st->buf_ready);
> +	ret = devm_mutex_init(dev, &st->lock);
> +	if (ret)
> +		return ret;
> +
> +	/* TO DO:
> +	 *  - vin supply

The code is very simple to just turn on the power supply
at driver load and off at unload. Simpler to do that from the start than
end up with it being added later.

> +	 */
> +
> +	indio_dev->name = "mh-z19b";
> +	indio_dev->channels = mhz19b_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(mhz19b_channels);
> +	indio_dev->info = &mhz19b_info;
> +	ret = devm_iio_device_register(dev, indio_dev);

return devm_iio_device_register();

> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}

> 


