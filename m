Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07FFE44F833
	for <lists+linux-iio@lfdr.de>; Sun, 14 Nov 2021 14:48:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231918AbhKNNur (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Nov 2021 08:50:47 -0500
Received: from www381.your-server.de ([78.46.137.84]:53234 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbhKNNum (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 14 Nov 2021 08:50:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=tROnPjxjkGbewZuWgGefkd4wBynloibyaCEs0PLCCfE=; b=OzJeZfhEsEdhM8ycjt4VDJqiuu
        3wwxSA6eZIgTmVIsha4Z8obFJj4ojqJaFW9qvCJyk7C1yU8io8YMf4mQ4W6gPujCUR9x88dKE9wAQ
        JlAMRnMqbtXZ/Noj63ULOksUC3vFyBRIE/ZRsb13quNFr9JzPaqqZNT2vpHoc3HterATeY0fnPf7n
        /3ht3VxvFniBRfWv9dcVpJ5BWVBXKf5BpM8bUCofIWmPReOwBBHn+31uDrfBjzY9MyaIBwtC4Y6Ae
        d5nRpz1/BKhFhEvcO/+YaMQJ8Z9wVdHjPRf2FkaKUGP7kr6O/bTxiCEGHncnNaO5Io8yNWrMV9UHf
        9Rm935wQ==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1mmFrG-000DtK-Br; Sun, 14 Nov 2021 14:47:46 +0100
Received: from [82.135.83.112] (helo=[192.168.178.20])
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1mmFrG-000RpN-3u; Sun, 14 Nov 2021 14:47:46 +0100
Subject: Re: [PATCH 1/2] iio: humidity: Add support for Sensirion SHTC3 sensor
To:     Gilles Talis <gilles.talis@gmail.com>, jic23@kernel.org,
        pmeerw@pmeerw.net, robh+dt@kernel.org, linux-iio@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211114132335.47651-1-gilles.talis@gmail.com>
 <20211114132335.47651-2-gilles.talis@gmail.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <b86bd1eb-8c05-2c54-4e05-e5d72ba3a890@metafoo.de>
Date:   Sun, 14 Nov 2021 14:47:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211114132335.47651-2-gilles.talis@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.3/26353/Sun Nov 14 10:19:38 2021)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 11/14/21 2:23 PM, Gilles Talis wrote:
> The SHTC3 is a digital humidity and temperature sensor.
> It covers humidity measurement range from 0 to 100% relative humidity
> and temperature measurement range from -45 to 125 deg C.
>
> Datasheet: https://www.sensirion.com/file/datasheet_shtc3
>
> Signed-off-by: Gilles Talis <gilles.talis@gmail.com>

Hi,

Thanks for the path. This looks really good, very well written driver.

But we already have support for the shtc3 in the Linux kernel as part of 
the hwmon framework, see drivers/hwmon/shtc1.c.

- Lars

> ---
>   drivers/iio/humidity/Kconfig  |  11 ++
>   drivers/iio/humidity/Makefile |   1 +
>   drivers/iio/humidity/shtc3.c  | 286 ++++++++++++++++++++++++++++++++++
>   3 files changed, 298 insertions(+)
>   create mode 100644 drivers/iio/humidity/shtc3.c
>
> diff --git a/drivers/iio/humidity/Kconfig b/drivers/iio/humidity/Kconfig
> index 2de5494e7c22..7aab6141c64b 100644
> --- a/drivers/iio/humidity/Kconfig
> +++ b/drivers/iio/humidity/Kconfig
> @@ -98,6 +98,17 @@ config HTU21
>   	  This driver can also be built as a module. If so, the module will
>   	  be called htu21.
>   
> +config SHTC3
> +	tristate "Sensirion SHTC3 humidity and temperature sensor"
> +	depends on I2C
> +	select CRC8
> +	help
> +	  Say yes here to build support for the Sensirion SHTC3
> +	  humidity and temperature sensor.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called shtc3.
> +
>   config SI7005
>   	tristate "SI7005 relative humidity and temperature sensor"
>   	depends on I2C
> diff --git a/drivers/iio/humidity/Makefile b/drivers/iio/humidity/Makefile
> index f19ff3de97c5..13020dfad1b3 100644
> --- a/drivers/iio/humidity/Makefile
> +++ b/drivers/iio/humidity/Makefile
> @@ -16,6 +16,7 @@ obj-$(CONFIG_HTS221_I2C) += hts221_i2c.o
>   obj-$(CONFIG_HTS221_SPI) += hts221_spi.o
>   
>   obj-$(CONFIG_HTU21) += htu21.o
> +obj-$(CONFIG_SHTC3) += shtc3.o
>   obj-$(CONFIG_SI7005) += si7005.o
>   obj-$(CONFIG_SI7020) += si7020.o
>   
> diff --git a/drivers/iio/humidity/shtc3.c b/drivers/iio/humidity/shtc3.c
> new file mode 100644
> index 000000000000..ec3d7215e378
> --- /dev/null
> +++ b/drivers/iio/humidity/shtc3.c
> @@ -0,0 +1,286 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Sensirion SHTC3 Humidity and Temperature Sensor
> + *
> + * Copyright (c) 2021 Gilles Talis <gilles.talis@gmail.com>
> + *
> + * Datasheet: https://www.sensirion.com/file/datasheet_shtc3
> + *
> + * I2C slave address: 0x70
> + */
> +
> +#include <linux/crc8.h>
> +#include <linux/delay.h>
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +
> +#include <linux/iio/iio.h>
> +
> +#define SHTC3_CMD(cmd_word)		cpu_to_be16(cmd_word)
> +#define SHTC3_CMD_LEN			2
> +
> +#define SHTC3_ID_MASK			0x083F
> +#define SHTC3_ID			0x0807
> +
> +#define SHTC3_CRC8_POLYNOMIAL		0x31
> +
> +enum shtc3_cmd {
> +	SHTC3_CMD_GET_ID		= SHTC3_CMD(0xEFC8),
> +	SHTC3_CMD_SOFT_RESET		= SHTC3_CMD(0x805D),
> +	SHTC3_CMD_SLEEP			= SHTC3_CMD(0xB098),
> +	SHTC3_CMD_WAKEUP		= SHTC3_CMD(0x3517),
> +	/*
> +	 * Run measurement, low-power mode, clock stretching
> +	 * temperature first
> +	 */
> +	SHTC3_CMD_TEMP_MEAS_LP_CS	= SHTC3_CMD(0x6458),
> +	/*
> +	 * Run measurement, low-power mode, clock stretching
> +	 * relative humidity first
> +	 */
> +	SHTC3_CMD_RH_MEAS_LP_CS		= SHTC3_CMD(0x44DE),
> +};
> +
> +DECLARE_CRC8_TABLE(shtc3_crc8_tbl);
> +
> +struct shtc3_rx_data {
> +	__be16	data;
> +	u8	crc;
> +} __packed;
> +
> +static int shtc3_send_cmd(struct i2c_client *client, u16 cmd, u16 *data)
> +{
> +	int ret;
> +	struct shtc3_rx_data rx_data;
> +	u8 crc;
> +
> +	ret = i2c_master_send(client, (const char *)&cmd, SHTC3_CMD_LEN);
> +	if (ret != SHTC3_CMD_LEN)
> +		return -EIO;
> +
> +	/*
> +	 * This is used to read temperature and humidity measurements
> +	 * as well as the sensor ID.
> +	 * Sensor sends 2 bytes of data followed by one byte of CRC
> +	 */
> +	if (data) {
> +		ret = i2c_master_recv(client, (u8 *) &rx_data,
> +					sizeof(struct shtc3_rx_data));
> +		if (ret < 0)
> +			return ret;
> +		if (ret != sizeof(struct shtc3_rx_data))
> +			return -EIO;
> +
> +		crc = crc8(shtc3_crc8_tbl, (u8 *)&rx_data.data,
> +			    2, CRC8_INIT_VALUE);
> +		if (crc != rx_data.crc)
> +			return -EIO;
> +
> +		*data = be16_to_cpu(rx_data.data);
> +	}
> +
> +	return 0;
> +}
> +
> +static int shtc3_sleep(struct i2c_client *client)
> +{
> +	return shtc3_send_cmd(client, SHTC3_CMD_SLEEP, 0);
> +}
> +
> +static int shtc3_wakeup(struct i2c_client *client)
> +{
> +	if (shtc3_send_cmd(client, SHTC3_CMD_WAKEUP, 0) < 0)
> +		return -EIO;
> +
> +	/* Wait for device to wake up */
> +	usleep_range(180, 240);
> +
> +	return 0;
> +}
> +
> +static int shtc3_read_channel(struct i2c_client *client, bool temp)
> +{
> +	int ret;
> +	u16 cmd;
> +	u16 meas;
> +
> +	ret = shtc3_wakeup(client);
> +	if (ret < 0)
> +		return ret;
> +
> +	/*
> +	 * Sensor sends back measurement results after measurement command
> +	 * has been issued by the host.
> +	 * Sensor sends 3 bytes (2 bytes of data + 1 byte of CRC) for each
> +	 * channel sequentially
> +	 * The command issued by the host determines the channel for which
> +	 * the sensor will first send the data.
> +	 * We select the channel for which we need the results
> +	 * then only read back the 2 bytes corresponding to this channel.
> +	 */
> +	cmd = temp ? SHTC3_CMD_TEMP_MEAS_LP_CS : SHTC3_CMD_RH_MEAS_LP_CS;
> +	ret = shtc3_send_cmd(client, cmd, &meas);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Go back to sleep */
> +	shtc3_sleep(client);
> +
> +	return meas;
> +}
> +
> +static int shtc3_read_raw(struct iio_dev *indio_dev,
> +			   struct iio_chan_spec const *chan, int *val,
> +			   int *val2, long mask)
> +{
> +	struct i2c_client **client = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret = shtc3_read_channel(*client, (chan->type == IIO_TEMP));
> +		if (ret < 0)
> +			return ret;
> +		*val = ret;
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		if (chan->type == IIO_TEMP) {
> +			*val = 2;
> +			*val2 = 670000;
> +		} else {
> +			*val = 0;
> +			*val2 = 1525;
> +		}
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	case IIO_CHAN_INFO_OFFSET:
> +		*val = -16852;
> +		return IIO_VAL_INT;
> +	default:
> +		break;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static const struct iio_chan_spec shtc3_channels[] = {
> +	{
> +		.type = IIO_HUMIDITYRELATIVE,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +			BIT(IIO_CHAN_INFO_SCALE),
> +	},
> +	{
> +		.type = IIO_TEMP,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +			BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_OFFSET),
> +	}
> +};
> +
> +static const struct iio_info shtc3_info = {
> +	.read_raw = shtc3_read_raw,
> +};
> +
> +static int shtc3_verify_id(struct i2c_client *client)
> +{
> +	int ret;
> +	u16 device_id;
> +	u16 reg_val;
> +
> +	ret = shtc3_send_cmd(client, SHTC3_CMD_GET_ID, &reg_val);
> +	if (ret < 0)
> +		return ret;
> +
> +	device_id = reg_val & SHTC3_ID_MASK;
> +	if (device_id != SHTC3_ID)
> +		return -ENODEV;
> +
> +	return 0;
> +}
> +
> +static int shtc3_reset(struct i2c_client *client)
> +{
> +	int ret;
> +
> +	ret = shtc3_send_cmd(client, SHTC3_CMD_SOFT_RESET, 0);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Wait for device to enter idle state */
> +	usleep_range(180, 240);
> +
> +	return 0;
> +}
> +
> +static int shtc3_setup(struct i2c_client *client)
> +{
> +	int ret;
> +
> +	ret = shtc3_verify_id(client);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "SHTC3 not found\n");
> +		return -ENODEV;
> +	}
> +
> +	ret = shtc3_reset(client);
> +	if (ret < 0)
> +		return ret;
> +
> +	return shtc3_sleep(client);
> +}
> +
> +static int shtc3_probe(struct i2c_client *client,
> +			const struct i2c_device_id *id)
> +{
> +	struct iio_dev *indio_dev;
> +	struct i2c_client **data;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data = iio_priv(indio_dev);
> +	*data = client;
> +
> +	indio_dev->name = dev_name(&client->dev);
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->info = &shtc3_info;
> +	indio_dev->channels = shtc3_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(shtc3_channels);
> +
> +	crc8_populate_msb(shtc3_crc8_tbl, SHTC3_CRC8_POLYNOMIAL);
> +
> +	ret = shtc3_setup(client);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "SHTC3 setup failed\n");
> +		return ret;
> +	}
> +
> +	return devm_iio_device_register(&client->dev, indio_dev);
> +}
> +
> +static const struct i2c_device_id shtc3_id[] = {
> +	{ "shtc3", 0 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, shtc3_id);
> +
> +static const struct of_device_id shtc3_dt_ids[] = {
> +	{ .compatible = "sensirion,shtc3" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, shtc3_dt_ids);
> +
> +static struct i2c_driver shtc3_driver = {
> +	.driver = {
> +		.name = "shtc3",
> +		.of_match_table = shtc3_dt_ids,
> +	},
> +	.probe		= shtc3_probe,
> +	.id_table	= shtc3_id,
> +};
> +
> +module_i2c_driver(shtc3_driver);
> +MODULE_DESCRIPTION("Sensirion SHTC3 Humidity and Temperature Sensor");
> +MODULE_AUTHOR("Gilles Talis <gilles.talis@gmail.com>");
> +MODULE_LICENSE("GPL");


