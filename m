Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06B86370EE9
	for <lists+linux-iio@lfdr.de>; Sun,  2 May 2021 21:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232374AbhEBT6x (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 2 May 2021 15:58:53 -0400
Received: from smtpout1.mo528.mail-out.ovh.net ([46.105.34.251]:42219 "EHLO
        smtpout1.mo528.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231909AbhEBT6x (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 2 May 2021 15:58:53 -0400
Received: from pro2.mail.ovh.net (unknown [10.108.20.106])
        by mo528.mail-out.ovh.net (Postfix) with ESMTPS id 42D51A3B8581;
        Sun,  2 May 2021 21:58:00 +0200 (CEST)
Received: from localhost (89.70.221.198) by DAG2EX1.emp2.local (172.16.2.11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Sun, 2 May 2021
 21:57:59 +0200
Date:   Sun, 2 May 2021 21:53:47 +0200
From:   Tomasz Duszynski <tomasz.duszynski@octakon.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     Tomasz Duszynski <tomasz.duszynski@octakon.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <lars@metafoo.de>,
        <robh+dt@kernel.org>
Subject: Re: [PATCH v2 1/3] iio: sps30: separate core and interface specific
 code
Message-ID: <YI8DS2MQN+we4zTO@arch>
References: <20210502134431.42647-1-tomasz.duszynski@octakon.com>
 <20210502134431.42647-2-tomasz.duszynski@octakon.com>
 <20210502183220.0ed8ff1c@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20210502183220.0ed8ff1c@jic23-huawei>
X-Originating-IP: [89.70.221.198]
X-ClientProxiedBy: DAG2EX1.emp2.local (172.16.2.11) To DAG2EX1.emp2.local
 (172.16.2.11)
X-Ovh-Tracer-Id: 308496576637197394
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduledrvdefvddghedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpeffhffvuffkfhggtggujghisehttdertddttdejnecuhfhrohhmpefvohhmrghsiicuffhushiihihnshhkihcuoehtohhmrghsiidrughushiihihnshhkihesohgtthgrkhhonhdrtghomheqnecuggftrfgrthhtvghrnheptdehveethfffudetjeeftdekueehjeegjedvteffgfevkefffeegffeugeehgfejnecukfhppedtrddtrddtrddtpdekledrjedtrddvvddurdduleeknecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhrohdvrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepthhomhgrshiirdguuhhsiiihnhhskhhisehotghtrghkohhnrdgtohhmpdhrtghpthhtoheprhhosghhodgutheskhgvrhhnvghlrdhorhhg
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, May 02, 2021 at 06:32:20PM +0100, Jonathan Cameron wrote:
> On Sun, 2 May 2021 15:44:29 +0200
> Tomasz Duszynski <tomasz.duszynski@octakon.com> wrote:
>
> > Move code responsible for handling i2c communication to a separate file.
> > Rationale for this change is preparation for adding support for serial
> > communication.
> >
> > Signed-off-by: Tomasz Duszynski <tomasz.duszynski@octakon.com>
> A comment way down the end.   Basically says that dropping the i2c_device_id
> table is fine with me, but does occasionally cause problems as it's still used
> IIRC by greybus.  Maybe someone will one day connect one of these to greybus :)
>
> Otherwise, looks good to me.
>

Good point. I'll leave it as is then just to make sure everything
behaves as before.

>
> Jonathan
>
> > ---
> >  MAINTAINERS                      |   1 +
> >  drivers/iio/chemical/Kconfig     |  16 +-
> >  drivers/iio/chemical/Makefile    |   1 +
> >  drivers/iio/chemical/sps30.c     | 269 ++++++-------------------------
> >  drivers/iio/chemical/sps30.h     |  35 ++++
> >  drivers/iio/chemical/sps30_i2c.c | 251 ++++++++++++++++++++++++++++
> >  6 files changed, 347 insertions(+), 226 deletions(-)
> >  create mode 100644 drivers/iio/chemical/sps30.h
> >  create mode 100644 drivers/iio/chemical/sps30_i2c.c
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index ccc59fd7e5c0..4b39a9c48736 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -16137,6 +16137,7 @@ M:	Tomasz Duszynski <tduszyns@gmail.com>
> >  S:	Maintained
> >  F:	Documentation/devicetree/bindings/iio/chemical/sensirion,sps30.yaml
> >  F:	drivers/iio/chemical/sps30.c
> > +F:	drivers/iio/chemical/sps30_i2c.c
> >
> >  SERIAL DEVICE BUS
> >  M:	Rob Herring <robh@kernel.org>
> > diff --git a/drivers/iio/chemical/Kconfig b/drivers/iio/chemical/Kconfig
> > index 10bb431bc3ce..2b45a76ab7bc 100644
> > --- a/drivers/iio/chemical/Kconfig
> > +++ b/drivers/iio/chemical/Kconfig
> > @@ -132,17 +132,21 @@ config SENSIRION_SGP30
> >  	  module will be called sgp30.
> >
> >  config SPS30
> > -	tristate "SPS30 particulate matter sensor"
> > -	depends on I2C
> > -	select CRC8
> > +	tristate
> >  	select IIO_BUFFER
> >  	select IIO_TRIGGERED_BUFFER
> > +
> > +config SPS30_I2C
> > +	tristate "SPS30 particulate matter sensor I2C driver"
> > +	depends on I2C
> > +	select SPS30
> > +	select CRC8
> >  	help
> > -	  Say Y here to build support for the Sensirion SPS30 particulate
> > -	  matter sensor.
> > +	  Say Y here to build support for the Sensirion SPS30 I2C interface
> > +	  driver.
> >
> >  	  To compile this driver as a module, choose M here: the module will
> > -	  be called sps30.
> > +	  be called sps30_i2c.
> >
> >  config VZ89X
> >  	tristate "SGX Sensortech MiCS VZ89X VOC sensor"
> > diff --git a/drivers/iio/chemical/Makefile b/drivers/iio/chemical/Makefile
> > index fef63dd5bf92..41c264a229c0 100644
> > --- a/drivers/iio/chemical/Makefile
> > +++ b/drivers/iio/chemical/Makefile
> > @@ -17,4 +17,5 @@ obj-$(CONFIG_SCD30_I2C) += scd30_i2c.o
> >  obj-$(CONFIG_SCD30_SERIAL) += scd30_serial.o
> >  obj-$(CONFIG_SENSIRION_SGP30)	+= sgp30.o
> >  obj-$(CONFIG_SPS30) += sps30.o
> > +obj-$(CONFIG_SPS30_I2C) += sps30_i2c.o
> >  obj-$(CONFIG_VZ89X)		+= vz89x.o
> > diff --git a/drivers/iio/chemical/sps30.c b/drivers/iio/chemical/sps30.c
> > index 7486591588c3..d51314505115 100644
> > --- a/drivers/iio/chemical/sps30.c
> > +++ b/drivers/iio/chemical/sps30.c
> > @@ -3,11 +3,8 @@
> >   * Sensirion SPS30 particulate matter sensor driver
> >   *
> >   * Copyright (c) Tomasz Duszynski <tduszyns@gmail.com>
> > - *
> > - * I2C slave address: 0x69
> >   */
> >
> > -#include <asm/unaligned.h>
> >  #include <linux/crc8.h>
> >  #include <linux/delay.h>
> >  #include <linux/i2c.h>
> > @@ -19,27 +16,14 @@
> >  #include <linux/kernel.h>
> >  #include <linux/module.h>
> >
> > -#define SPS30_CRC8_POLYNOMIAL 0x31
> > -/* max number of bytes needed to store PM measurements or serial string */
> > -#define SPS30_MAX_READ_SIZE 48
> > +#include "sps30.h"
> > +
> >  /* sensor measures reliably up to 3000 ug / m3 */
> >  #define SPS30_MAX_PM 3000
> >  /* minimum and maximum self cleaning periods in seconds */
> >  #define SPS30_AUTO_CLEANING_PERIOD_MIN 0
> >  #define SPS30_AUTO_CLEANING_PERIOD_MAX 604800
> >
> > -/* SPS30 commands */
> > -#define SPS30_START_MEAS 0x0010
> > -#define SPS30_STOP_MEAS 0x0104
> > -#define SPS30_RESET 0xd304
> > -#define SPS30_READ_DATA_READY_FLAG 0x0202
> > -#define SPS30_READ_DATA 0x0300
> > -#define SPS30_READ_SERIAL 0xd033
> > -#define SPS30_START_FAN_CLEANING 0x5607
> > -#define SPS30_AUTO_CLEANING_PERIOD 0x8004
> > -/* not a sensor command per se, used only to distinguish write from read */
> > -#define SPS30_READ_AUTO_CLEANING_PERIOD 0x8005
> > -
> >  enum {
> >  	PM1,
> >  	PM2P5,
> > @@ -52,114 +36,9 @@ enum {
> >  	MEASURING,
> >  };
> >
> > -struct sps30_state {
> > -	struct i2c_client *client;
> > -	/*
> > -	 * Guards against concurrent access to sensor registers.
> > -	 * Must be held whenever sequence of commands is to be executed.
> > -	 */
> > -	struct mutex lock;
> > -	int state;
> > -};
> > -
> > -DECLARE_CRC8_TABLE(sps30_crc8_table);
> > -
> > -static int sps30_write_then_read(struct sps30_state *state, u8 *txbuf,
> > -				 int txsize, u8 *rxbuf, int rxsize)
> > -{
> > -	int ret;
> > -
> > -	/*
> > -	 * Sensor does not support repeated start so instead of
> > -	 * sending two i2c messages in a row we just send one by one.
> > -	 */
> > -	ret = i2c_master_send(state->client, txbuf, txsize);
> > -	if (ret != txsize)
> > -		return ret < 0 ? ret : -EIO;
> > -
> > -	if (!rxbuf)
> > -		return 0;
> > -
> > -	ret = i2c_master_recv(state->client, rxbuf, rxsize);
> > -	if (ret != rxsize)
> > -		return ret < 0 ? ret : -EIO;
> > -
> > -	return 0;
> > -}
> > -
> > -static int sps30_do_cmd(struct sps30_state *state, u16 cmd, u8 *data, int size)
> > -{
> > -	/*
> > -	 * Internally sensor stores measurements in a following manner:
> > -	 *
> > -	 * PM1: upper two bytes, crc8, lower two bytes, crc8
> > -	 * PM2P5: upper two bytes, crc8, lower two bytes, crc8
> > -	 * PM4: upper two bytes, crc8, lower two bytes, crc8
> > -	 * PM10: upper two bytes, crc8, lower two bytes, crc8
> > -	 *
> > -	 * What follows next are number concentration measurements and
> > -	 * typical particle size measurement which we omit.
> > -	 */
> > -	u8 buf[SPS30_MAX_READ_SIZE] = { cmd >> 8, cmd };
> > -	int i, ret = 0;
> > -
> > -	switch (cmd) {
> > -	case SPS30_START_MEAS:
> > -		buf[2] = 0x03;
> > -		buf[3] = 0x00;
> > -		buf[4] = crc8(sps30_crc8_table, &buf[2], 2, CRC8_INIT_VALUE);
> > -		ret = sps30_write_then_read(state, buf, 5, NULL, 0);
> > -		break;
> > -	case SPS30_STOP_MEAS:
> > -	case SPS30_RESET:
> > -	case SPS30_START_FAN_CLEANING:
> > -		ret = sps30_write_then_read(state, buf, 2, NULL, 0);
> > -		break;
> > -	case SPS30_READ_AUTO_CLEANING_PERIOD:
> > -		buf[0] = SPS30_AUTO_CLEANING_PERIOD >> 8;
> > -		buf[1] = (u8)(SPS30_AUTO_CLEANING_PERIOD & 0xff);
> > -		fallthrough;
> > -	case SPS30_READ_DATA_READY_FLAG:
> > -	case SPS30_READ_DATA:
> > -	case SPS30_READ_SERIAL:
> > -		/* every two data bytes are checksummed */
> > -		size += size / 2;
> > -		ret = sps30_write_then_read(state, buf, 2, buf, size);
> > -		break;
> > -	case SPS30_AUTO_CLEANING_PERIOD:
> > -		buf[2] = data[0];
> > -		buf[3] = data[1];
> > -		buf[4] = crc8(sps30_crc8_table, &buf[2], 2, CRC8_INIT_VALUE);
> > -		buf[5] = data[2];
> > -		buf[6] = data[3];
> > -		buf[7] = crc8(sps30_crc8_table, &buf[5], 2, CRC8_INIT_VALUE);
> > -		ret = sps30_write_then_read(state, buf, 8, NULL, 0);
> > -		break;
> > -	}
> > -
> > -	if (ret)
> > -		return ret;
> > -
> > -	/* validate received data and strip off crc bytes */
> > -	for (i = 0; i < size; i += 3) {
> > -		u8 crc = crc8(sps30_crc8_table, &buf[i], 2, CRC8_INIT_VALUE);
> > -
> > -		if (crc != buf[i + 2]) {
> > -			dev_err(&state->client->dev,
> > -				"data integrity check failed\n");
> > -			return -EIO;
> > -		}
> > -
> > -		*data++ = buf[i];
> > -		*data++ = buf[i + 1];
> > -	}
> > -
> > -	return 0;
> > -}
> > -
> > -static s32 sps30_float_to_int_clamped(const u8 *fp)
> > +static s32 sps30_float_to_int_clamped(__be32 *fp)
> >  {
> > -	int val = get_unaligned_be32(fp);
> > +	int val = be32_to_cpup(fp);
> >  	int mantissa = val & GENMASK(22, 0);
> >  	/* this is fine since passed float is always non-negative */
> >  	int exp = val >> 23;
> > @@ -188,38 +67,35 @@ static s32 sps30_float_to_int_clamped(const u8 *fp)
> >
> >  static int sps30_do_meas(struct sps30_state *state, s32 *data, int size)
> >  {
> > -	int i, ret, tries = 5;
> > -	u8 tmp[16];
> > +	int i, ret;
> >
> >  	if (state->state == RESET) {
> > -		ret = sps30_do_cmd(state, SPS30_START_MEAS, NULL, 0);
> > +		ret = state->ops->start_meas(state);
> >  		if (ret)
> >  			return ret;
> >
> >  		state->state = MEASURING;
> >  	}
> >
> > -	while (tries--) {
> > -		ret = sps30_do_cmd(state, SPS30_READ_DATA_READY_FLAG, tmp, 2);
> > -		if (ret)
> > -			return -EIO;
> > +	ret = state->ops->read_meas(state, (__be32 *)data, size);
> > +	if (ret)
> > +		return ret;
> >
> > -		/* new measurements ready to be read */
> > -		if (tmp[1] == 1)
> > -			break;
> > +	for (i = 0; i < size; i++)
> > +		data[i] = sps30_float_to_int_clamped((__be32 *)&data[i]);
> >
> > -		msleep_interruptible(300);
> > -	}
> > +	return 0;
> > +}
> >
> > -	if (tries == -1)
> > -		return -ETIMEDOUT;
> > +static int sps30_do_reset(struct sps30_state *state)
> > +{
> > +	int ret;
> >
> > -	ret = sps30_do_cmd(state, SPS30_READ_DATA, tmp, sizeof(int) * size);
> > +	ret = state->ops->reset(state);
> >  	if (ret)
> >  		return ret;
> >
> > -	for (i = 0; i < size; i++)
> > -		data[i] = sps30_float_to_int_clamped(&tmp[4 * i]);
> > +	state->state = RESET;
> >
> >  	return 0;
> >  }
> > @@ -310,24 +186,6 @@ static int sps30_read_raw(struct iio_dev *indio_dev,
> >  	return -EINVAL;
> >  }
> >
> > -static int sps30_do_cmd_reset(struct sps30_state *state)
> > -{
> > -	int ret;
> > -
> > -	ret = sps30_do_cmd(state, SPS30_RESET, NULL, 0);
> > -	msleep(300);
> > -	/*
> > -	 * Power-on-reset causes sensor to produce some glitch on i2c bus and
> > -	 * some controllers end up in error state. Recover simply by placing
> > -	 * some data on the bus, for example STOP_MEAS command, which
> > -	 * is NOP in this case.
> > -	 */
> > -	sps30_do_cmd(state, SPS30_STOP_MEAS, NULL, 0);
> > -	state->state = RESET;
> > -
> > -	return ret;
> > -}
> > -
> >  static ssize_t start_cleaning_store(struct device *dev,
> >  				    struct device_attribute *attr,
> >  				    const char *buf, size_t len)
> > @@ -340,7 +198,7 @@ static ssize_t start_cleaning_store(struct device *dev,
> >  		return -EINVAL;
> >
> >  	mutex_lock(&state->lock);
> > -	ret = sps30_do_cmd(state, SPS30_START_FAN_CLEANING, NULL, 0);
> > +	ret = state->ops->clean_fan(state);
> >  	mutex_unlock(&state->lock);
> >  	if (ret)
> >  		return ret;
> > @@ -349,31 +207,29 @@ static ssize_t start_cleaning_store(struct device *dev,
> >  }
> >
> >  static ssize_t cleaning_period_show(struct device *dev,
> > -				      struct device_attribute *attr,
> > -				      char *buf)
> > +				    struct device_attribute *attr,
> > +				    char *buf)
> >  {
> >  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> >  	struct sps30_state *state = iio_priv(indio_dev);
> > -	u8 tmp[4];
> > +	__be32 val;
> >  	int ret;
> >
> >  	mutex_lock(&state->lock);
> > -	ret = sps30_do_cmd(state, SPS30_READ_AUTO_CLEANING_PERIOD, tmp, 4);
> > +	ret = state->ops->read_cleaning_period(state, &val);
> >  	mutex_unlock(&state->lock);
> >  	if (ret)
> >  		return ret;
> >
> > -	return sprintf(buf, "%d\n", get_unaligned_be32(tmp));
> > +	return sprintf(buf, "%d\n", be32_to_cpu(val));
> >  }
> >
> > -static ssize_t cleaning_period_store(struct device *dev,
> > -				       struct device_attribute *attr,
> > -				       const char *buf, size_t len)
> > +static ssize_t cleaning_period_store(struct device *dev, struct device_attribute *attr,
> > +				     const char *buf, size_t len)
> >  {
> >  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> >  	struct sps30_state *state = iio_priv(indio_dev);
> >  	int val, ret;
> > -	u8 tmp[4];
> >
> >  	if (kstrtoint(buf, 0, &val))
> >  		return -EINVAL;
> > @@ -382,10 +238,8 @@ static ssize_t cleaning_period_store(struct device *dev,
> >  	    (val > SPS30_AUTO_CLEANING_PERIOD_MAX))
> >  		return -EINVAL;
> >
> > -	put_unaligned_be32(val, tmp);
> > -
> >  	mutex_lock(&state->lock);
> > -	ret = sps30_do_cmd(state, SPS30_AUTO_CLEANING_PERIOD, tmp, 0);
> > +	ret = state->ops->write_cleaning_period(state, cpu_to_be32(val));
> >  	if (ret) {
> >  		mutex_unlock(&state->lock);
> >  		return ret;
> > @@ -397,7 +251,7 @@ static ssize_t cleaning_period_store(struct device *dev,
> >  	 * sensor requires reset in order to return up to date self cleaning
> >  	 * period
> >  	 */
> > -	ret = sps30_do_cmd_reset(state);
> > +	ret = sps30_do_reset(state);
> >  	if (ret)
> >  		dev_warn(dev,
> >  			 "period changed but reads will return the old value\n");
> > @@ -460,90 +314,65 @@ static const struct iio_chan_spec sps30_channels[] = {
> >  	IIO_CHAN_SOFT_TIMESTAMP(4),
> >  };
> >
> > -static void sps30_stop_meas(void *data)
> > +static void sps30_devm_stop_meas(void *data)
> >  {
> >  	struct sps30_state *state = data;
> >
> > -	sps30_do_cmd(state, SPS30_STOP_MEAS, NULL, 0);
> > +	if (state->state == MEASURING)
> > +		state->ops->stop_meas(state);
> >  }
> >
> >  static const unsigned long sps30_scan_masks[] = { 0x0f, 0x00 };
> >
> > -static int sps30_probe(struct i2c_client *client)
> > +int sps30_probe(struct device *dev, const char *name, void *priv, const struct sps30_ops *ops)
> >  {
> >  	struct iio_dev *indio_dev;
> >  	struct sps30_state *state;
> > -	u8 buf[32];
> >  	int ret;
> >
> > -	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
> > -		return -EOPNOTSUPP;
> > -
> > -	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*state));
> > +	indio_dev = devm_iio_device_alloc(dev, sizeof(*state));
> >  	if (!indio_dev)
> >  		return -ENOMEM;
> >
> > +	dev_set_drvdata(dev, indio_dev);
> > +
> >  	state = iio_priv(indio_dev);
> > -	i2c_set_clientdata(client, indio_dev);
> > -	state->client = client;
> > -	state->state = RESET;
> > +	state->dev = dev;
> > +	state->priv = priv;
> > +	state->ops = ops;
> > +	mutex_init(&state->lock);
> > +
> >  	indio_dev->info = &sps30_info;
> > -	indio_dev->name = client->name;
> > +	indio_dev->name = name;
> >  	indio_dev->channels = sps30_channels;
> >  	indio_dev->num_channels = ARRAY_SIZE(sps30_channels);
> >  	indio_dev->modes = INDIO_DIRECT_MODE;
> >  	indio_dev->available_scan_masks = sps30_scan_masks;
> >
> > -	mutex_init(&state->lock);
> > -	crc8_populate_msb(sps30_crc8_table, SPS30_CRC8_POLYNOMIAL);
> > -
> > -	ret = sps30_do_cmd_reset(state);
> > +	ret = sps30_do_reset(state);
> >  	if (ret) {
> > -		dev_err(&client->dev, "failed to reset device\n");
> > +		dev_err(dev, "failed to reset device\n");
> >  		return ret;
> >  	}
> >
> > -	ret = sps30_do_cmd(state, SPS30_READ_SERIAL, buf, sizeof(buf));
> > +	ret = state->ops->show_info(state);
> >  	if (ret) {
> > -		dev_err(&client->dev, "failed to read serial number\n");
> > +		dev_err(dev, "failed to read device info\n");
> >  		return ret;
> >  	}
> > -	/* returned serial number is already NUL terminated */
> > -	dev_info(&client->dev, "serial number: %s\n", buf);
> >
> > -	ret = devm_add_action_or_reset(&client->dev, sps30_stop_meas, state);
> > +	ret = devm_add_action_or_reset(dev, sps30_devm_stop_meas, state);
> >  	if (ret)
> >  		return ret;
> >
> > -	ret = devm_iio_triggered_buffer_setup(&client->dev, indio_dev, NULL,
> > +	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
> >  					      sps30_trigger_handler, NULL);
> >  	if (ret)
> >  		return ret;
> >
> > -	return devm_iio_device_register(&client->dev, indio_dev);
> > +	return devm_iio_device_register(dev, indio_dev);
> >  }
> > -
> > -static const struct i2c_device_id sps30_id[] = {
> > -	{ "sps30" },
> > -	{ }
> > -};
> > -MODULE_DEVICE_TABLE(i2c, sps30_id);
> > -
> > -static const struct of_device_id sps30_of_match[] = {
> > -	{ .compatible = "sensirion,sps30" },
> > -	{ }
> > -};
> > -MODULE_DEVICE_TABLE(of, sps30_of_match);
> > -
> > -static struct i2c_driver sps30_driver = {
> > -	.driver = {
> > -		.name = "sps30",
> > -		.of_match_table = sps30_of_match,
> > -	},
> > -	.id_table = sps30_id,
> > -	.probe_new = sps30_probe,
> > -};
> > -module_i2c_driver(sps30_driver);
> > +EXPORT_SYMBOL_GPL(sps30_probe);
> >
> >  MODULE_AUTHOR("Tomasz Duszynski <tduszyns@gmail.com>");
> >  MODULE_DESCRIPTION("Sensirion SPS30 particulate matter sensor driver");
> > diff --git a/drivers/iio/chemical/sps30.h b/drivers/iio/chemical/sps30.h
> > new file mode 100644
> > index 000000000000..a58ee43cf45d
> > --- /dev/null
> > +++ b/drivers/iio/chemical/sps30.h
> > @@ -0,0 +1,35 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef _SPS30_H
> > +#define _SPS30_H
> > +
> > +#include <linux/types.h>
> > +
> > +struct sps30_state;
> > +struct sps30_ops {
> > +	int (*start_meas)(struct sps30_state *state);
> > +	int (*stop_meas)(struct sps30_state *state);
> > +	int (*read_meas)(struct sps30_state *state, __be32 *meas, size_t num);
> > +	int (*reset)(struct sps30_state *state);
> > +	int (*clean_fan)(struct sps30_state *state);
> > +	int (*read_cleaning_period)(struct sps30_state *state, __be32 *period);
> > +	int (*write_cleaning_period)(struct sps30_state *state, __be32 period);
> > +	int (*show_info)(struct sps30_state *state);
> > +};
> > +
> > +struct sps30_state {
> > +	/* serialize access to the device */
> > +	struct mutex lock;
> > +	struct device *dev;
> > +	int state;
> > +	/*
> > +	 * priv pointer is solely for serdev driver private data. We keep it
> > +	 * here because driver_data inside dev has been already used for iio and
> > +	 * struct serdev_device doesn't have one.
> > +	 */
> > +	void *priv;
> > +	const struct sps30_ops *ops;
> > +};
> > +
> > +int sps30_probe(struct device *dev, const char *name, void *priv, const struct sps30_ops *ops);
> > +
> > +#endif
> > diff --git a/drivers/iio/chemical/sps30_i2c.c b/drivers/iio/chemical/sps30_i2c.c
> > new file mode 100644
> > index 000000000000..123ef23bf0eb
> > --- /dev/null
> > +++ b/drivers/iio/chemical/sps30_i2c.c
> > @@ -0,0 +1,251 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Sensirion SPS30 particulate matter sensor i2c driver
> > + *
> > + * Copyright (c) 2020 Tomasz Duszynski <tomasz.duszynski@octakon.com>
> > + *
> > + * I2C slave address: 0x69
> > + */
> > +#include <asm/unaligned.h>
> > +#include <linux/crc8.h>
> > +#include <linux/delay.h>
> > +#include <linux/device.h>
> > +#include <linux/errno.h>
> > +#include <linux/i2c.h>
> > +#include <linux/mod_devicetable.h>
> > +#include <linux/module.h>
> > +#include <linux/types.h>
> > +
> > +#include "sps30.h"
> > +
> > +#define SPS30_I2C_CRC8_POLYNOMIAL 0x31
> > +/* max number of bytes needed to store PM measurements or serial string */
> > +#define SPS30_I2C_MAX_BUF_SIZE 48
> > +
> > +DECLARE_CRC8_TABLE(sps30_i2c_crc8_table);
> > +
> > +#define SPS30_I2C_START_MEAS 0x0010
> > +#define SPS30_I2C_STOP_MEAS 0x0104
> > +#define SPS30_I2C_READ_MEAS 0x0300
> > +#define SPS30_I2C_MEAS_READY 0x0202
> > +#define SPS30_I2C_RESET 0xd304
> > +#define SPS30_I2C_CLEAN_FAN 0x5607
> > +#define SPS30_I2C_PERIOD 0x8004
> > +#define SPS30_I2C_READ_SERIAL 0xd033
> > +#define SPS30_I2C_READ_VERSION 0xd100
> > +
> > +static int sps30_i2c_xfer(struct sps30_state *state, unsigned char *txbuf, size_t txsize,
> > +			  unsigned char *rxbuf, size_t rxsize)
> > +{
> > +	struct i2c_client *client = to_i2c_client(state->dev);
> > +	int ret;
> > +
> > +	/*
> > +	 * Sensor does not support repeated start so instead of
> > +	 * sending two i2c messages in a row we just send one by one.
> > +	 */
> > +	ret = i2c_master_send(client, txbuf, txsize);
> > +	if (ret < 0)
> > +		return ret;
> > +	if (ret != txsize)
> > +		return -EIO;
> > +
> > +	if (!rxsize)
> > +		return 0;
> > +
> > +	ret = i2c_master_recv(client, rxbuf, rxsize);
> > +	if (ret < 0)
> > +		return ret;
> > +	if (ret != rxsize)
> > +		return -EIO;
> > +
> > +	return 0;
> > +}
> > +
> > +static int sps30_i2c_command(struct sps30_state *state, u16 cmd, void *arg, size_t arg_size,
> > +			     void *rsp, size_t rsp_size)
> > +{
> > +	/*
> > +	 * Internally sensor stores measurements in a following manner:
> > +	 *
> > +	 * PM1: upper two bytes, crc8, lower two bytes, crc8
> > +	 * PM2P5: upper two bytes, crc8, lower two bytes, crc8
> > +	 * PM4: upper two bytes, crc8, lower two bytes, crc8
> > +	 * PM10: upper two bytes, crc8, lower two bytes, crc8
> > +	 *
> > +	 * What follows next are number concentration measurements and
> > +	 * typical particle size measurement which we omit.
> > +	 */
> > +	unsigned char buf[SPS30_I2C_MAX_BUF_SIZE];
> > +	unsigned char *tmp;
> > +	unsigned char crc;
> > +	size_t i;
> > +	int ret;
> > +
> > +	put_unaligned_be16(cmd, buf);
> > +	i = 2;
> > +
> > +	if (rsp) {
> > +		/* each two bytes are followed by a crc8 */
> > +		rsp_size += rsp_size / 2;
> > +	} else {
> > +		tmp = arg;
> > +
> > +		while (arg_size) {
> > +			buf[i] = *tmp++;
> > +			buf[i + 1] = *tmp++;
> > +			buf[i + 2] = crc8(sps30_i2c_crc8_table, buf + i, 2, CRC8_INIT_VALUE);
> > +			arg_size -= 2;
> > +			i += 3;
> > +		}
> > +	}
> > +
> > +	ret = sps30_i2c_xfer(state, buf, i, buf, rsp_size);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* validate received data and strip off crc bytes */
> > +	tmp = rsp;
> > +	for (i = 0; i < rsp_size; i += 3) {
> > +		crc = crc8(sps30_i2c_crc8_table, buf + i, 2, CRC8_INIT_VALUE);
> > +		if (crc != buf[i + 2]) {
> > +			dev_err(state->dev, "data integrity check failed\n");
> > +			return -EIO;
> > +		}
> > +
> > +		*tmp++ = buf[i];
> > +		*tmp++ = buf[i + 1];
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int sps30_i2c_start_meas(struct sps30_state *state)
> > +{
> > +	/* request BE IEEE754 formatted data */
> > +	unsigned char buf[] = { 0x03, 0x00 };
> > +
> > +	return sps30_i2c_command(state, SPS30_I2C_START_MEAS, buf, sizeof(buf), NULL, 0);
> > +}
> > +
> > +static int sps30_i2c_stop_meas(struct sps30_state *state)
> > +{
> > +	return sps30_i2c_command(state, SPS30_I2C_STOP_MEAS, NULL, 0, NULL, 0);
> > +}
> > +
> > +static int sps30_i2c_reset(struct sps30_state *state)
> > +{
> > +	int ret;
> > +
> > +	ret = sps30_i2c_command(state, SPS30_I2C_RESET, NULL, 0, NULL, 0);
> > +	msleep(500);
> > +	/*
> > +	 * Power-on-reset causes sensor to produce some glitch on i2c bus and
> > +	 * some controllers end up in error state. Recover simply by placing
> > +	 * some data on the bus, for example STOP_MEAS command, which
> > +	 * is NOP in this case.
> > +	 */
> > +	sps30_i2c_stop_meas(state);
> > +
> > +	return ret;
> > +}
> > +
> > +static bool sps30_i2c_meas_ready(struct sps30_state *state)
> > +{
> > +	unsigned char buf[2];
> > +	int ret;
> > +
> > +	ret = sps30_i2c_command(state, SPS30_I2C_MEAS_READY, NULL, 0, buf, sizeof(buf));
> > +	if (ret)
> > +		return false;
> > +
> > +	return buf[1];
> > +}
> > +
> > +static int sps30_i2c_read_meas(struct sps30_state *state, __be32 *meas, size_t num)
> > +{
> > +	/* measurements are ready within a second */
> > +	if (msleep_interruptible(1000))
> > +		return -EINTR;
> > +
> > +	if (!sps30_i2c_meas_ready(state))
> > +		return -ETIMEDOUT;
> > +
> > +	return sps30_i2c_command(state, SPS30_I2C_READ_MEAS, NULL, 0, meas, sizeof(num) * num);
> > +}
> > +
> > +static int sps30_i2c_clean_fan(struct sps30_state *state)
> > +{
> > +	return sps30_i2c_command(state, SPS30_I2C_CLEAN_FAN, NULL, 0, NULL, 0);
> > +}
> > +
> > +static int sps30_i2c_read_cleaning_period(struct sps30_state *state, __be32 *period)
> > +{
> > +	return sps30_i2c_command(state, SPS30_I2C_PERIOD, NULL, 0, period, sizeof(*period));
> > +}
> > +
> > +static int sps30_i2c_write_cleaning_period(struct sps30_state *state, __be32 period)
> > +{
> > +	return sps30_i2c_command(state, SPS30_I2C_PERIOD, &period, sizeof(period), NULL, 0);
> > +}
> > +
> > +static int sps30_i2c_show_info(struct sps30_state *state)
> > +{
> > +	/* extra nul just in case */
> > +	unsigned char buf[32 + 1] = { 0x00 };
> > +	int ret;
> > +
> > +	ret = sps30_i2c_command(state, SPS30_I2C_READ_SERIAL, NULL, 0, buf, sizeof(buf) - 1);
> > +	if (ret)
> > +		return ret;
> > +
> > +	dev_info(state->dev, "serial number: %s\n", buf);
> > +
> > +	ret = sps30_i2c_command(state, SPS30_I2C_READ_VERSION, NULL, 0, buf, 2);
> > +	if (ret)
> > +		return ret;
> > +
> > +	dev_info(state->dev, "fw version: %u.%u\n", buf[0], buf[1]);
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct sps30_ops sps30_i2c_ops = {
> > +	.start_meas = sps30_i2c_start_meas,
> > +	.stop_meas = sps30_i2c_stop_meas,
> > +	.read_meas = sps30_i2c_read_meas,
> > +	.reset = sps30_i2c_reset,
> > +	.clean_fan = sps30_i2c_clean_fan,
> > +	.read_cleaning_period = sps30_i2c_read_cleaning_period,
> > +	.write_cleaning_period = sps30_i2c_write_cleaning_period,
> > +	.show_info = sps30_i2c_show_info,
> > +};
> > +
> > +static int sps30_i2c_probe(struct i2c_client *client)
> > +{
> > +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
> > +		return -EOPNOTSUPP;
> > +
> > +	crc8_populate_msb(sps30_i2c_crc8_table, SPS30_I2C_CRC8_POLYNOMIAL);
> > +
> > +	return sps30_probe(&client->dev, client->name, NULL, &sps30_i2c_ops);
> > +}
> > +
> > +static const struct of_device_id sps30_i2c_of_match[] = {
> > +	{ .compatible = "sensirion,sps30" },
>
> This drops the i2c_device_id table.   I personally don't mind doing that, but
> it will cause trouble for anyone trying to use greybus or similar with this part
> (as IIRC they still rely on that id table).
>
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(of, sps30_i2c_of_match);
> > +
> > +static struct i2c_driver sps30_i2c_driver = {
> > +	.driver = {
> > +		.name = KBUILD_MODNAME,
> > +		.of_match_table = sps30_i2c_of_match,
> > +	},
> > +	.probe_new = sps30_i2c_probe,
> > +};
> > +module_i2c_driver(sps30_i2c_driver);
> > +
> > +MODULE_AUTHOR("Tomasz Duszynski <tomasz.duszynski@octakon.com>");
> > +MODULE_DESCRIPTION("Sensirion SPS30 particulate matter sensor i2c driver");
> > +MODULE_LICENSE("GPL v2");
>
