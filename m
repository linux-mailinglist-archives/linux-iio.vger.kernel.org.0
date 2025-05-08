Return-Path: <linux-iio+bounces-19310-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2764AAFFD9
	for <lists+linux-iio@lfdr.de>; Thu,  8 May 2025 18:04:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 330F8176CAF
	for <lists+linux-iio@lfdr.de>; Thu,  8 May 2025 16:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5428E27B4E2;
	Thu,  8 May 2025 16:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="YWfY+wrA"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E4027AC43
	for <linux-iio@vger.kernel.org>; Thu,  8 May 2025 16:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746720237; cv=none; b=LNdSnwbf1IHnAGeW2M+33Yd/bHInYAKqWBHswBigJKJkF04h9rG5ryQ3McGbeZUxkBo8kIfLRbrRMDMsD0esZTLd3jmbvsTxJH8hrLT+ySPmRBW5ZF3kE/d/iV+fa7OWq/7hxH/CHGiGdmpf52pWt+RGiOYGTNibbllpLd4GtMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746720237; c=relaxed/simple;
	bh=sDTduiH5duq9nzrQk9bUcwjiQE27srNEN1ADhAVkqsw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dSycGeL1pfWm52QTHBdlWZG0g023IpG5VeXG5wiyQTVNkd3StIE/3PpE+DCF6kNy7OLO+hDtHMoa3VsQ51Yy+b/T1HnKxarTBDTo74UkWgYi48P35VcI39Df/LUtSeyKUwluI9opjrnskOxKxoJlNrQyMiYwBCs3PJhHHxdfpWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=YWfY+wrA; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-72c40235c34so391563a34.3
        for <linux-iio@vger.kernel.org>; Thu, 08 May 2025 09:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1746720233; x=1747325033; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oJ2Auybmqe77zpsq1EbjQCxmsIAC9WCbVyTDFjFofh0=;
        b=YWfY+wrAi0KJYnVQab222dVlWeJg/E4t7l0AwsceIiB5WXU1a8kG0f9Y57CiEoVBar
         16KFTGbvEh3XIkxOMM4ymQV4mDXR8QDnCVIdp5A7dnO9ASBo8DnbNbbU4zXLZr+v14Ka
         fxJnjOhyCBYyvisSQk2cfGVKrbiEJEbw7WUfCfwg7Ryx4BeQrUZmWdF0+M9gVet0goAf
         BA0eCJRH3mlvAD53QNpkXMFBGEuH6nim22goJ2Etw/j3cIVMbsjkWvCHueX5mG6frZku
         r60LUtdgikv6jWLKIceccsBaX0jeWgvPk0AibQFLGCS/HSI8zsHyTvj3KSJCH19mm7dN
         kIRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746720233; x=1747325033;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oJ2Auybmqe77zpsq1EbjQCxmsIAC9WCbVyTDFjFofh0=;
        b=WgfbS953txPOxc9izd3fK6G+md8P7AbvHcNF74ftgqml5IB4f99/IdSO1fUX4ehcgQ
         jaid4pV4+HTcOVistbwHnS6ErgULY3iK+fLj81NzfLTyUoomK34cEM7Tqu/LYGrozv3U
         wC5z0m0Bw8U/SHPak2XvOVSBkvwj01+F0thcUEJt3Gd2kgZDJgfZ762NHF7E+lrP8AYd
         1icYgqypKDdPD9d656qCXUQ/E3tQEgKF8cWFYfrP/y8W7Qn+XPQB2ccHwsMJF0rgameg
         ytmVaDoqxA7mBXccriAPcXKmdkJ/UWeAnUgAp4eABOA8FPLuD20fcXIZQ8kqy8WFwJiz
         lhoA==
X-Gm-Message-State: AOJu0Yx/giCxkkZPln3K09jt5sf4Ls7aDsJlP4M6c8Q53NPqkQfxwuM/
	bWoq7LGQC1QYipGOMQfuBodYpakjeoLkikWBZAhXHD/2m1/twsAjmTRX3g8Ppa8=
X-Gm-Gg: ASbGnctyUz8e6aPOhcrHeO3SLEOUrbXp8A6QH7zkc/9zWOhe6kDe2K7fsev1T4REMle
	QIaquE5HpMWElTLbW8NFzHRhQfW7xfJVz/uynA8bJIQxHNeCBpHFlUnAFoQ/yGqbOG9AtjPw47V
	mrzHd0jpf/Pw432d8xjNpdAqvETVT2weVOPJ7+h/kcgC3aytMqW3nEtB2J42lzyKppqAqHfCgNd
	im/32R72sVEG0GEsrvJWUbNgnW7B5CR3lcdp1n4qYMxfLIlJiGKsdxGIdVcBPM1JUIahANVbsWS
	KrZ4jHk05RNvLMz4xrIEz6SB5wVvKceMiODotF9BQvTa/BKwTAQWUbqnsDGRpUwOGPQo0UMDu6s
	DH7g70p9mNyPQj+dB41hCPlhqIwmu
X-Google-Smtp-Source: AGHT+IED/v7PAY2y2hARuh161CjGMUHyhUf6i7J7sT6oZ8p+nzPZE5Df4TSSsZV79KrJNYBU72bt/Q==
X-Received: by 2002:a05:6830:648b:b0:72b:9b1f:2e1d with SMTP id 46e09a7af769-732269c8ce0mr224442a34.2.1746720232980;
        Thu, 08 May 2025 09:03:52 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:1120:d1cf:c64a:ac7e? ([2600:8803:e7e4:1d00:1120:d1cf:c64a:ac7e])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-732264d867csm71748a34.37.2025.05.08.09.03.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 May 2025 09:03:52 -0700 (PDT)
Message-ID: <297ec0b1-d6a4-4fc9-95c7-e7f3bef53d97@baylibre.com>
Date: Thu, 8 May 2025 11:03:51 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] iio: magnetometer: qmc5883l: Add initial driver
 support
To: Brajesh Patil <brajeshpatil11@gmail.com>, jic23@kernel.org,
 lars@metafoo.de
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 marcelo.schmitt1@gmail.com
References: <20250508120900.114348-1-brajeshpatil11@gmail.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250508120900.114348-1-brajeshpatil11@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/8/25 7:08 AM, Brajesh Patil wrote:

This needs a description that explains why we would want to add this to the
kernel.

> Signed-off-by: Brajesh Patil <brajeshpatil11@gmail.com>
> ---
>  drivers/iio/magnetometer/Kconfig    |  13 +
>  drivers/iio/magnetometer/Makefile   |   2 +
>  drivers/iio/magnetometer/qmc5883l.c | 471 ++++++++++++++++++++++++++++
>  3 files changed, 486 insertions(+)
>  create mode 100644 drivers/iio/magnetometer/qmc5883l.c
> 
> diff --git a/drivers/iio/magnetometer/Kconfig b/drivers/iio/magnetometer/Kconfig
> index 3debf1320ad1..97f375c75ff8 100644
> --- a/drivers/iio/magnetometer/Kconfig
> +++ b/drivers/iio/magnetometer/Kconfig
> @@ -206,6 +206,19 @@ config SENSORS_HMC5843_SPI
>  	  - hmc5843_core (core functions)
>  	  - hmc5843_spi (support for HMC5983)
> 
> +config SENSORS_QMC5883L
> +	tristate "QST QMC5883L 3-Axis Magnetometer"
> +	depends on I2C
> +	select REGMAP_I2C
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
> +	help
> +	  Say Y here to build support for the QST QMC5883L 3-axis magnetometer
> +	  through its I2C interface.
> +
> +	  To compile this driver as a module, choose M here: the module will be
> +	  called qmc5883l.
> +
>  config SENSORS_RM3100
>  	tristate
>  	select IIO_BUFFER
> diff --git a/drivers/iio/magnetometer/Makefile b/drivers/iio/magnetometer/Makefile
> index 9297723a97d8..f51e7595f5e3 100644
> --- a/drivers/iio/magnetometer/Makefile
> +++ b/drivers/iio/magnetometer/Makefile
> @@ -27,6 +27,8 @@ obj-$(CONFIG_SENSORS_HMC5843)		+= hmc5843_core.o
>  obj-$(CONFIG_SENSORS_HMC5843_I2C)	+= hmc5843_i2c.o
>  obj-$(CONFIG_SENSORS_HMC5843_SPI)	+= hmc5843_spi.o
> 
> +obj-$(CONFIG_SENSORS_QMC5883L)		+= qmc5883l.c
> +
>  obj-$(CONFIG_SENSORS_RM3100)		+= rm3100-core.o
>  obj-$(CONFIG_SENSORS_RM3100_I2C)	+= rm3100-i2c.o
>  obj-$(CONFIG_SENSORS_RM3100_SPI)	+= rm3100-spi.o
> diff --git a/drivers/iio/magnetometer/qmc5883l.c b/drivers/iio/magnetometer/qmc5883l.c
> new file mode 100644
> index 000000000000..68597cdd0ca8
> --- /dev/null
> +++ b/drivers/iio/magnetometer/qmc5883l.c
> @@ -0,0 +1,471 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/delay.h>
> +#include <linux/i2c.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/iio/trigger.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>
> +#include <linux/regmap.h>
> +#include <linux/types.h>
> +
> +/* Register Addresses */
> +#define QMC5883L_DATA_OUT_LSB_REG   0x00
> +#define QMC5883L_STATUS_REG         0x06
> +#define QMC5883L_TEMP_OUT_LSB_REG   0x07
> +#define QMC5883L_CONTROL_REG_1      0x09
> +#define QMC5883L_CONTROL_REG_2      0x0A
> +#define QMC5883L_FBR_REG            0x0B
> +#define QMC5883L_CHIP_ID_REG        0x0D
> +#define QMC5883L_CHIP_ID            0xFF

Usually, we add _REG_ in these names to make it obvious that it is a register
address.

> +
> +/* Status Register Bits */
> +#define QMC5883L_DRDY               0x01
> +#define QMC5883L_OVL                0x02
> +#define QMC5883L_DOR                0x04

Should use the BIT() macro for these.

> +
> +/* Control Register 1 Configuration Bits */
> +/* Mode (bits [1:0]) */
> +#define QMC5883L_MODE_STANDBY       0x00
> +#define QMC5883L_MODE_CONT          0x01
> +#define QMC5883L_MODE_MASK          0x03

Use GENMASK(1, 0) insted of 0x3.

> +#define QMC5883L_MODE_SHIFT         0

In the driver, we can use FIELD_PREP() with the _MASK value, then we don't need
any of the _SHIFT macros.

> +
> +/* Output Data Rate - ODR (bits [3:2]) */
> +#define QMC5883L_ODR_10HZ           0x00
> +#define QMC5883L_ODR_50HZ           0x01
> +#define QMC5883L_ODR_100HZ          0x02
> +#define QMC5883L_ODR_200HZ          0x03
> +#define QMC5883L_ODR_MASK           0x0C
> +#define QMC5883L_ODR_SHIFT          2
> +
> +/* Full Scale Range - RNG (bits [5:4]) */
> +#define QMC5883L_RNG_2G             0x00
> +#define QMC5883L_RNG_8G             0x01
> +#define QMC5883L_RNG_MASK           0x30
> +#define QMC5883L_RNG_SHIFT          4
> +
> +/* Oversampling Ratio - OSR (bits [7:6]) */
> +#define QMC5883L_OSR_512            0x00
> +#define QMC5883L_OSR_256            0x01
> +#define QMC5883L_OSR_128            0x02
> +#define QMC5883L_OSR_64             0x03
> +#define QMC5883L_OSR_MASK           0xC0
> +#define QMC5883L_OSR_SHIFT          6

Same comment applies to these, we can use GENMASK(), then we don't need the
"(bits [A:B])" in the comment and we don't need the _SHIFT macros.

> +
> +static const int qmc5883l_odr_map[] = {
> +	[QMC5883L_ODR_10HZ]  = 10,
> +	[QMC5883L_ODR_50HZ]  = 50,
> +	[QMC5883L_ODR_100HZ] = 100,
> +	[QMC5883L_ODR_200HZ] = 200,
> +};
> +
> +/**
> + * struct qmc5883l_data - device instance specific data
> + * @client: I2C client structure
> + * @lock: mutex to protect register access
> + * @regmap: register map of the device
> + * @scan: buffer for triggered data reading
> + */
> +struct qmc5883l_data {
> +	struct i2c_client *client;
> +	struct mutex lock; /* Protects sensor read/write operations */
> +	struct regmap *regmap;
> +
> +	struct {
> +		__le16 chans[3];
> +
> +		s64 timestamp __aligned(8);

		aligned_s64 timestamp;

> +	} scan;
> +};
> +
> +static int qmc5883l_init(struct qmc5883l_data *data);
> +static int qmc5883l_set_mode(struct qmc5883l_data *data, unsigned int mode);

Can we reorder things to avoid the forward declarations?

> +
> +static int qmc5883l_buffer_preenable(struct iio_dev *indio_dev)
> +{
> +	struct qmc5883l_data *data = iio_priv(indio_dev);
> +
> +	return qmc5883l_set_mode(data, QMC5883L_MODE_CONT);
> +}
> +
> +static int qmc5883l_buffer_postdisable(struct iio_dev *indio_dev)
> +{
> +	struct qmc5883l_data *data = iio_priv(indio_dev);
> +
> +	return qmc5883l_set_mode(data, QMC5883L_MODE_STANDBY);
> +}
> +
> +static const struct iio_buffer_setup_ops qmc5883l_buffer_setup_ops = {
> +	.preenable	= qmc5883l_buffer_preenable,
> +	.postdisable	= qmc5883l_buffer_postdisable,
> +};
> +
> +/* Register map access tables */
> +static const struct regmap_range qmc5883l_readable_ranges[] = {
> +	regmap_reg_range(QMC5883L_DATA_OUT_LSB_REG, QMC5883L_CHIP_ID_REG),
> +};
> +
> +static const struct regmap_access_table qmc5883l_readable_table = {
> +	.yes_ranges = qmc5883l_readable_ranges,
> +	.n_yes_ranges = ARRAY_SIZE(qmc5883l_readable_ranges),
> +};
> +
> +static const struct regmap_range qmc5883l_writable_ranges[] = {
> +	regmap_reg_range(QMC5883L_CONTROL_REG_1, QMC5883L_FBR_REG),
> +};
> +
> +static const struct regmap_access_table qmc5883l_writable_table = {
> +	.yes_ranges = qmc5883l_writable_ranges,
> +	.n_yes_ranges = ARRAY_SIZE(qmc5883l_writable_ranges),
> +};
> +
> +static const struct regmap_range qmc5883l_volatile_ranges[] = {
> +	regmap_reg_range(QMC5883L_DATA_OUT_LSB_REG, QMC5883L_TEMP_OUT_LSB_REG + 1),
> +};
> +
> +static const struct regmap_access_table qmc5883l_volatile_table = {
> +	.yes_ranges = qmc5883l_volatile_ranges,
> +	.n_yes_ranges = ARRAY_SIZE(qmc5883l_volatile_ranges),
> +};
> +
> +static const struct regmap_config qmc5883l_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.max_register = QMC5883L_CHIP_ID_REG,
> +
> +	.rd_table = &qmc5883l_readable_table,
> +	.wr_table = &qmc5883l_writable_table,
> +	.volatile_table = &qmc5883l_volatile_table,
> +
> +	.cache_type = REGCACHE_RBTREE,

Regmap docs say:

"Any new caches should usually use the maple tree cache unless they specifically
require that there are never any allocations at runtime and can't provide
defaults in which case they should use the flat cache."

So why using RBTREE?

> +};
> +
> +static int qmc5883l_set_mode(struct qmc5883l_data *data, unsigned int mode)
> +{
> +	int ret;
> +
> +	mutex_lock(&data->lock);
> +	ret = regmap_update_bits(data->regmap, QMC5883L_CONTROL_REG_1,
> +				 QMC5883L_MODE_MASK, mode << QMC5883L_MODE_SHIFT);
> +	mutex_unlock(&data->lock);
> +
> +	return ret;
> +}
> +
> +static int qmc5883l_wait_measurement(struct qmc5883l_data *data)
> +{
> +	int tries = 150;
> +	unsigned int val;
> +	int ret;
> +
> +	while (tries-- > 0) {
> +		ret = regmap_read(data->regmap, QMC5883L_STATUS_REG, &val);
> +		if (ret < 0)
> +			return ret;
> +
> +		if (val & QMC5883L_OVL) {
> +			dev_err(&data->client->dev, "data overflow\n");
> +			return -EOVERFLOW;
> +		}
> +
> +		if (val & QMC5883L_DRDY)
> +			return 0;
> +		usleep_range(5000, 6000);

fsleep()

> +	}
> +
> +	dev_err(&data->client->dev, "data not ready\n");
> +	return -EIO;

Would -ETIMEDOUT be more appropriate?

> +}
> +
> +static int qmc5883l_read_measurement(struct qmc5883l_data *data,
> +				     int idx, int *val)
> +{
> +	__le16 values[3];
> +	int ret;
> +
> +	ret = qmc5883l_set_mode(data, QMC5883L_MODE_CONT);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = qmc5883l_wait_measurement(data);
> +	if (ret < 0) {
> +		qmc5883l_set_mode(data, QMC5883L_MODE_STANDBY);
> +		return ret;
> +	}
> +
> +	mutex_lock(&data->lock);

Lock isn't protecting all register access.

> +	ret = regmap_bulk_read(data->regmap, QMC5883L_DATA_OUT_LSB_REG,
> +			       values, sizeof(values));
> +	mutex_unlock(&data->lock);
> +
> +	qmc5883l_set_mode(data, QMC5883L_MODE_STANDBY);
> +	if (ret < 0)
> +		return ret;
> +
> +	*val = sign_extend32(le16_to_cpu(values[idx]), 15);
> +	return IIO_VAL_INT;
> +}
> +
> +static int qmc5883l_read_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan, int *val, int *val2, long mask)
> +{
> +	struct qmc5883l_data *data = iio_priv(indio_dev);
> +	unsigned int rval;
> +	__le16 temp_val;
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		if (chan->type == IIO_TEMP) {
> +			ret = qmc5883l_set_mode(data, QMC5883L_MODE_CONT);
> +			if (ret < 0)
> +				return ret;
> +
> +			mutex_lock(&data->lock);
> +			ret = regmap_bulk_read(data->regmap, QMC5883L_TEMP_OUT_LSB_REG,
> +					       &temp_val, sizeof(temp_val));
> +			mutex_unlock(&data->lock);
> +
> +			qmc5883l_set_mode(data, QMC5883L_MODE_STANDBY);

If someone did a raw read during a buffered read, this would take it out of
standby and the buffered read would stop working, no?

Using iio_device_claim_direct() can solve this by not allowing raw read during
buffered read. I think we could probably drop the mutex lock entirely from the
driver and just rely on iio_device_claim_direct() instead.

> +
> +			if (!ret)
> +				*val = sign_extend32(le16_to_cpu(temp_val), 15);
> +
> +			return ret ? ret : IIO_VAL_INT;
> +		}
> +		return qmc5883l_read_measurement(data, chan->scan_index, val);
> +	case IIO_CHAN_INFO_SCALE:
> +		if (chan->type == IIO_TEMP) {
> +			/* scale = 124 / 10000 = 0.0124 °C/LSB */
> +			*val = 124;
> +			*val2 = 10000;
> +			return IIO_VAL_FRACTIONAL;
> +		}
> +		ret = regmap_read(data->regmap, QMC5883L_CONTROL_REG_1, &rval);
> +		if (ret < 0)
> +			return ret;
> +		rval = (rval & QMC5883L_RNG_MASK) >> QMC5883L_RNG_SHIFT;

FIELD_GET() will simplify this.

> +		*val = (rval == 0) ? 12000 : 3000;  /* ±2G:12000, ±8G:3000 LSB/G */
> +		*val2 = 0;

Don't need to set val2.

> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_OFFSET:
> +		if (chan->type == IIO_TEMP) {
> +			/* offset = 287661 / 100 = 2876.61 °C */
> +			*val = 287661;
> +			*val2 = 100;
> +			return IIO_VAL_FRACTIONAL;
> +		}
> +		return -EINVAL;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		ret = regmap_read(data->regmap, QMC5883L_CONTROL_REG_1, &rval);
> +		if (ret < 0)
> +			return ret;
> +
> +		rval = (rval & QMC5883L_ODR_MASK) >> QMC5883L_ODR_SHIFT;
> +
> +		if (rval >= ARRAY_SIZE(qmc5883l_odr_map) || !qmc5883l_odr_map[rval])
> +			return -EINVAL;
> +
> +		*val = qmc5883l_odr_map[rval];
> +		*val2 = 0;
> +		return IIO_VAL_INT;
> +	}
> +	return -EINVAL;
> +}
> +
> +static irqreturn_t qmc5883l_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct qmc5883l_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	mutex_lock(&data->lock);

If we do end up keeping the mutex lock, guard(mutex)(&data->lock); will help
simplify things a bit in many of the functions like this.

> +	ret = qmc5883l_wait_measurement(data);
> +	if (ret < 0) {
> +		mutex_unlock(&data->lock);
> +		goto done;
> +	}
> +
> +	ret = regmap_bulk_read(data->regmap, QMC5883L_DATA_OUT_LSB_REG,
> +			       data->scan.chans, sizeof(data->scan.chans));
> +	mutex_unlock(&data->lock);
> +
> +	if (ret < 0)
> +		goto done;
> +
> +	iio_push_to_buffers_with_timestamp(indio_dev, &data->scan,
> +					   iio_get_time_ns(indio_dev));
> +
> +done:
> +	iio_trigger_notify_done(indio_dev->trig);
> +	return IRQ_HANDLED;
> +}
> +
> +/* Channel definitions */
> +#define QMC5883L_CHANNEL(axis, idx)             \
> +{                           \
> +	.type = IIO_MAGN,               \
> +	.modified = 1,                  \
> +	.channel2 = IIO_MOD_##axis,         \
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),   \
> +	.info_mask_shared_by_type =         \
> +		BIT(IIO_CHAN_INFO_SCALE) |      \
> +		BIT(IIO_CHAN_INFO_SAMP_FREQ),       \
> +	.scan_index = idx,              \
> +	.scan_type = {                  \
> +		.sign = 's',                \
> +		.realbits = 16,             \
> +		.storagebits = 16,          \
> +		.endianness = IIO_LE,           \
> +	},                      \
> +}

Use tabs so that all of the \ line up nicely on the right.

> +
> +static const struct iio_chan_spec qmc5883l_channels[] = {
> +	QMC5883L_CHANNEL(X, 0),
> +	QMC5883L_CHANNEL(Y, 1),
> +	QMC5883L_CHANNEL(Z, 2),
> +	{
> +		.type = IIO_TEMP,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +				      BIT(IIO_CHAN_INFO_SCALE) |
> +				      BIT(IIO_CHAN_INFO_OFFSET),
> +		.scan_index = -1,
> +	},
> +	IIO_CHAN_SOFT_TIMESTAMP(3),
> +};
> +
> +static int qmc5883l_init(struct qmc5883l_data *data)
> +{
> +	int ret;
> +	u8 chip_id;
> +	unsigned int chip_id_tmp;
> +	unsigned int ctrl1;
> +
> +	ret = regmap_read(data->regmap, QMC5883L_CHIP_ID_REG, &chip_id_tmp);
> +	if (ret < 0) {
> +		dev_err(&data->client->dev, "Failed to read chip ID\n");
> +		return ret;

This is during probe, so return dev_err_probe() can be used here and for other
error returns in this function.

> +	}
> +
> +	chip_id = (u8)chip_id_tmp;
> +	if (chip_id != QMC5883L_CHIP_ID) {
> +		dev_err(&data->client->dev, "Invalid chip ID: 0x%02X (expected 0x%02X)\n",
> +			chip_id, QMC5883L_CHIP_ID);
> +		return -ENODEV;

Usually, we don't consider a wrong ID an error though. There may be some
comaptible chip that can use this driver but has a differet ID. Could change
this to info or warning.

> +	}
> +
> +	mutex_lock(&data->lock);

This happens during probe, so mutex isn't needed here.

> +	ret = regmap_write(data->regmap, QMC5883L_FBR_REG, 0x01);
> +	if (ret < 0)
> +		goto unlock;
> +
> +	ctrl1 = (QMC5883L_OSR_64 << QMC5883L_OSR_SHIFT) |
> +		(QMC5883L_RNG_2G << QMC5883L_RNG_SHIFT) |
> +		(QMC5883L_ODR_50HZ << QMC5883L_ODR_SHIFT) |
> +		(QMC5883L_MODE_STANDBY << QMC5883L_MODE_SHIFT);

As mentioned above, we can use FIELD_PREP() for these.

> +
> +	ret = regmap_write(data->regmap, QMC5883L_CONTROL_REG_1, ctrl1);
> +	if (ret < 0)
> +		goto unlock;
> +
> +	mutex_unlock(&data->lock);
> +	dev_dbg(&data->client->dev,
> +		"Initialized with OSR=64, RNG=2G, ODR=50Hz, Mode=Standby\n");
> +	return 0;
> +
> +unlock:
> +	mutex_unlock(&data->lock);
> +	return ret;
> +}
> +
> +static const struct iio_info qmc5883l_info = {
> +	.read_raw = &qmc5883l_read_raw,
> +};
> +
> +static const unsigned long qmc5883l_scan_masks[] = {0x7, 0};
> +
> +static int qmc5883l_probe(struct i2c_client *client)
> +{
> +	struct regmap *regmap;
> +	struct qmc5883l_data *data;
> +	struct iio_dev *indio_dev;
> +	int ret;
> +
> +	regmap = devm_regmap_init_i2c(client, &qmc5883l_regmap_config);
> +	if (IS_ERR(regmap)) {
> +		dev_err(&client->dev, "Failed to initialize regmap\n");
> +		return PTR_ERR(regmap);
> +	}

All error return paths can be simplified with return dev_err_probe().

> +
> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> +	if (!indio_dev) {
> +		dev_err(&client->dev, "Failed to allocate iio device\n");
> +		return -ENOMEM;
> +	}
> +
> +	data = iio_priv(indio_dev);
> +	data->client = client;
> +	data->regmap = regmap;
> +	mutex_init(&data->lock);
> +
> +	indio_dev->name = "qmc5883l";
> +	indio_dev->info = &qmc5883l_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = qmc5883l_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(qmc5883l_channels);
> +	indio_dev->available_scan_masks = qmc5883l_scan_masks;
> +
> +	ret = devm_iio_triggered_buffer_setup(&client->dev, indio_dev,
> +					      NULL, &qmc5883l_trigger_handler,
> +					      &qmc5883l_buffer_setup_ops);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "Failed to setup triggered buffer: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = qmc5883l_init(data);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "Failed to initialize device: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = devm_iio_device_register(&client->dev, indio_dev);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "Failed to register IIO device: %d\n", ret);
> +		return ret;
> +	}
> +
> +	i2c_set_clientdata(client, indio_dev);

Is this actually needed if there is no i2c_get_clientdata()?

> +	return 0;
> +}
> +
> +static const struct i2c_device_id qmc5883l_id[] = {
> +	{ "qmc5883l", 0 },

Can leave out the 0.

> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, qmc5883l_id);
> +
> +static const struct of_device_id qmc5883l_of_match[] = {
> +	{ .compatible = "qst,qmc5883l" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, qmc5883l_of_match);
> +
> +static struct i2c_driver qmc5883l_driver = {
> +	.driver = {
> +		.name = "qmc5883l",
> +		.of_match_table = qmc5883l_of_match,
> +	},
> +	.id_table = qmc5883l_id,
> +	.probe = qmc5883l_probe,
> +};
> +
> +module_i2c_driver(qmc5883l_driver);
> +
> +MODULE_AUTHOR("Brajesh Patil <brajeshpatil11@gmail.com>");
> +MODULE_DESCRIPTION("QMC5883L Driver");
> +MODULE_LICENSE("GPL");
> +
> --
> 2.39.5
> 


