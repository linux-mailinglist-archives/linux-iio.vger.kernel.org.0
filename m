Return-Path: <linux-iio+bounces-19312-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C0A5AB005C
	for <lists+linux-iio@lfdr.de>; Thu,  8 May 2025 18:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CBA53AFF66
	for <lists+linux-iio@lfdr.de>; Thu,  8 May 2025 16:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D43F92820B2;
	Thu,  8 May 2025 16:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="k89WTFs3"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DFFF27876E
	for <linux-iio@vger.kernel.org>; Thu,  8 May 2025 16:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746721453; cv=none; b=nh8i/b1I5olLNLfnvkcAEGB9pu7wTinOz0S298ZOHXAfT27IX/TfpizzIPJlLVjJUiXulPv5o8O0cqm548bLuEOlYVoirHxLKODgnwG/mj0q2tqW5qRd41KtB5XdsCMWVYD7LEwYdL9axqf8T9rJd5UJ7Gdqd6S3WcVPB9HZUJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746721453; c=relaxed/simple;
	bh=t3tn6uKOL50qsUsO1X85bUcdjubnWdIaq7pkM+3x/94=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P+b1Ab6YqfffolEUON3xOyVVXiLQMUhfbn0eK930gjxPojexDBQNRf7uPBlaV8y8s5HJ0lMBBQ5wfLHyNEfAozvg++RTKAql908UojgZB0RQrbGe9JQKFfCaRM9AfMy6cYeUTN4sdM1dhlTOvsa5BrzOUxZlmymEf7v/nx9aT7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=k89WTFs3; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-2c7e5f7f0e3so482408fac.3
        for <linux-iio@vger.kernel.org>; Thu, 08 May 2025 09:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1746721449; x=1747326249; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=siSVab6apiCbyEuP9nd4RY6Qv93d0GsyI0YfHMYsfRU=;
        b=k89WTFs3FFEYIe1zmfVRYNS4+Eb4Ch0ACoXN1A3XhmCn0WHOqYl5XWjX//TbJxh53e
         SEEOEYKtSC64r7sy7f93SjiqvsJHoLriEJhHVXBQU4IVNuoMR5/U3Len7J+04hcvzH+/
         e+ebEh8p5AkFazPmu7bkRU2WzuzNKua58yRr6zZCCcQ1UY7kotEJ5EBqMVi/8fVoCdZv
         MyZUIIT/yXNrS9wf6uMgzO/RLiX8QRmh3oBsC16O80NgyoOkFtdEm4q7dXEpsrbfEtwS
         YRxWCM/VlgaUOKIX5NE8M2MJ9HRzuRHwIvD0WX7fgMmhgI6RWvITIFC8sCX35kLaDo3j
         T0Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746721449; x=1747326249;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=siSVab6apiCbyEuP9nd4RY6Qv93d0GsyI0YfHMYsfRU=;
        b=QY5X5e7CHrMhX0Ebf+V1Hw/A3bc4LfqQ3yciheQXSlrGaVX/bumnb+2QRM0yi71VeL
         V5goxXDe6IikawwD2dpmmCTPRntaXzlXBml+gl+zsCXXVc3XhvVu3Sv9jKQkTiGnbYLD
         al+N/1GjIGRCmydlRGw0yWP6pmb8zJCkbf3qBaM3kbh3o+4lY6Qrlx6wVHWsl+vmF++H
         69Pjv9gMwrupHnSgoJ0p5HHoLroPHyOE4mtdBIj29lQ1h5olmRmpWz9MpD9XkyrghrtY
         B3Hu9Pa2F6pBH6qYzSsBgJd0dYy2vbrzhUIgUCe20cJrPdMkVUkN9igo4h9AhEmz2G7S
         uA7A==
X-Gm-Message-State: AOJu0Ywi/+XyYWSGIU17irN+RjQ3LVBs/cx5gMPf70ROng+ZbyX05oBZ
	u1Gs8l5bqk5MCZtjbGbxXiUkj8e9YHymRjHWV/nXPYA5VWj5IbZQ6DGd1sU/S9c=
X-Gm-Gg: ASbGncvSA+IaOxu2u0b90kmEgaTwkSg/zaTu1f7ga4C3IZW4EbDy8wtuxn0HjVfll9A
	yayMjkCINVLLVJXqoLgecLEb0Gelzl/2XXUcPiSjZNkI4cBmYRkwPxTYZ3r2nAFeubAFeA2RVTI
	5jhxrog4S0k+NeA3Z8aMoVKobavxDe/SA6b7eW28rkB2pDBsRxvwPL0U2oiDhEL2uJBVHqaBuFC
	VJBEHLlUNDj5/kQRK5yMg2DH8tmSrGBLvryi+fxwNEQHNckRdbTKuypOK61IppI9bxZ7zlFWrzn
	ad9UQCmMc3aS7+J0vfA49eWQBkHrkXNHUtDwGslGcctCDoqkmUX0DVuJ0+uKBNqWS7zuINx2Thw
	SJBO4Tg+WkNpqTTBLzw==
X-Google-Smtp-Source: AGHT+IGLtpO6UhBgIcL3xiXd/cc2aOBHyXvNzemxDzdALjywytk8j9FQbKGayZ/TpFw4miZ9NDoJ+g==
X-Received: by 2002:a05:6871:780d:b0:2d5:1232:b081 with SMTP id 586e51a60fabf-2dba44dcbfcmr49186fac.29.1746721449161;
        Thu, 08 May 2025 09:24:09 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:1120:d1cf:c64a:ac7e? ([2600:8803:e7e4:1d00:1120:d1cf:c64a:ac7e])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2dba06ff158sm122755fac.19.2025.05.08.09.24.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 May 2025 09:24:08 -0700 (PDT)
Message-ID: <3fdf8296-8839-4b44-8048-3720b0f45787@baylibre.com>
Date: Thu, 8 May 2025 11:24:08 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] iio: magnetometer: qmc5883l: add mount matrix,
 control features and power management
To: Brajesh Patil <brajeshpatil11@gmail.com>, jic23@kernel.org,
 lars@metafoo.de
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 marcelo.schmitt1@gmail.com
References: <20250508120900.114348-1-brajeshpatil11@gmail.com>
 <20250508120900.114348-3-brajeshpatil11@gmail.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250508120900.114348-3-brajeshpatil11@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/8/25 7:09 AM, Brajesh Patil wrote:
> Signed-off-by: Brajesh Patil <brajeshpatil11@gmail.com>
> ---
>  drivers/iio/magnetometer/qmc5883l.c | 89 +++++++++++++++++++++++++++++
>  1 file changed, 89 insertions(+)
> 
> diff --git a/drivers/iio/magnetometer/qmc5883l.c b/drivers/iio/magnetometer/qmc5883l.c
> index 07c65f193def..d26f959ab8c5 100644
> --- a/drivers/iio/magnetometer/qmc5883l.c
> +++ b/drivers/iio/magnetometer/qmc5883l.c
> @@ -7,6 +7,7 @@
>  #include <linux/iio/trigger.h>
>  #include <linux/iio/trigger_consumer.h>
>  #include <linux/iio/triggered_buffer.h>
> +#include <linux/pm.h>
>  #include <linux/regmap.h>
>  #include <linux/types.h>
> 
> @@ -54,6 +55,10 @@
>  #define QMC5883L_OSR_MASK           0xC0
>  #define QMC5883L_OSR_SHIFT          6
> 
> +#define QMC5883L_SOFT_RST           0x80
> +#define QMC5883L_ROL_PNT            0x40
> +#define QMC5883L_INT_ENB            0x01
> +
>  static const char *const qmc5883l_modes[] = {
>  	"standby", "continuous"
>  };
> @@ -80,12 +85,14 @@ static const int qmc5883l_odr_map[] = {
>   * @client: I2C client structure
>   * @lock: mutex to protect register access
>   * @regmap: register map of the device
> + * @orientation: Sensor mounting orientation matrix
>   * @scan: buffer for triggered data reading
>   */
>  struct qmc5883l_data {
>  	struct i2c_client *client;
>  	struct mutex lock; /* Protects sensor read/write operations */
>  	struct regmap *regmap;
> +	struct iio_mount_matrix orientation;
> 
>  	struct {
>  		__le16 chans[3];
> @@ -102,6 +109,9 @@ static ssize_t qmc5883l_show_scale_avail(struct device *dev,
>  					 struct device_attribute *attr, char *buf);
>  static ssize_t qmc5883l_show_status(struct device *dev,
>  				    struct device_attribute *attr, char *buf);
> +static ssize_t qmc5883l_store_control(struct device *dev,
> +				      struct device_attribute *attr,
> +				      const char *buf, size_t count);
> 
>  static int qmc5883l_buffer_preenable(struct iio_dev *indio_dev)
>  {
> @@ -357,6 +367,15 @@ static int qmc5883l_read_measurement(struct qmc5883l_data *data,
>  	return IIO_VAL_INT;
>  }
> 
> +static const struct iio_mount_matrix *
> +qmc5883l_get_mount_matrix(const struct iio_dev *indio_dev,
> +			  const struct iio_chan_spec *chan)
> +{
> +	struct qmc5883l_data *data = iio_priv(indio_dev);
> +
> +	return &data->orientation;
> +}
> +
>  static const struct iio_enum qmc5883l_mode_enum = {
>  	.items = qmc5883l_modes,
>  	.num_items = ARRAY_SIZE(qmc5883l_modes),
> @@ -376,6 +395,7 @@ static const struct iio_chan_spec_ext_info qmc5883l_ext_info[] = {
>  	IIO_ENUM_AVAILABLE("mode", IIO_SHARED_BY_TYPE, &qmc5883l_mode_enum),
>  	IIO_ENUM("oversampling_ratio", IIO_SHARED_BY_TYPE, &qmc5883l_osr_enum),
>  	IIO_ENUM_AVAILABLE("oversampling_ratio", IIO_SHARED_BY_TYPE, &qmc5883l_osr_enum),
> +	IIO_MOUNT_MATRIX(IIO_SHARED_BY_DIR, qmc5883l_get_mount_matrix),
>  	{ }
>  };
> 
> @@ -383,6 +403,8 @@ static IIO_DEV_ATTR_SAMP_FREQ_AVAIL(qmc5883l_show_odr_avail);
>  static IIO_DEVICE_ATTR(scale_available, 0444, qmc5883l_show_scale_avail, NULL, 0);
>  static IIO_DEVICE_ATTR(data_ready, 0444, qmc5883l_show_status, NULL, 0);
>  static IIO_DEVICE_ATTR(overflow, 0444, qmc5883l_show_status, NULL, 0);
> +static IIO_DEVICE_ATTR(soft_reset, 0200, NULL, qmc5883l_store_control, 0);
> +static IIO_DEVICE_ATTR(pointer_rollover, 0200, NULL, qmc5883l_store_control, 0);

More custom attribute that probably aren't needed or need some justification.

A reset is usually only done on driver probe. Not sure what pointer rollover is.
> 
>  static ssize_t qmc5883l_show_odr_avail(struct device *dev,
>  				       struct device_attribute *attr, char *buf)
> @@ -416,6 +438,44 @@ static ssize_t qmc5883l_show_status(struct device *dev,
>  	return -EINVAL;
>  }
> 
> +/* Control attribute writes:
> + * - soft_reset: performs device reset and re-init
> + * - pointer_rollover: enables/disables rollover pointer
> + */
> +static ssize_t qmc5883l_store_control(struct device *dev, struct device_attribute *attr,
> +				      const char *buf, size_t count)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct qmc5883l_data *data = iio_priv(indio_dev);
> +	bool val;
> +	int ret = 0;
> +
> +	ret = kstrtobool(buf, &val);
> +	if (ret)
> +		return ret;
> +
> +	if (attr == &iio_dev_attr_soft_reset.dev_attr && val) {
> +		mutex_lock(&data->lock);
> +		ret = regmap_write(data->regmap, QMC5883L_CONTROL_REG_2,
> +				   QMC5883L_SOFT_RST);
> +		mutex_unlock(&data->lock);
> +		msleep(50);
> +
> +		ret = qmc5883l_init(data);
> +		if (ret < 0) {
> +			dev_err(&data->client->dev, "Sensor Reinitialization Failed\n");
> +			return ret;
> +		}
> +		dev_info(&data->client->dev, "Sensor successfully reinitialized\n");
> +	} else if (attr == &iio_dev_attr_pointer_rollover.dev_attr) {
> +		mutex_lock(&data->lock);
> +		ret = regmap_update_bits(data->regmap, QMC5883L_CONTROL_REG_2,
> +					 QMC5883L_ROL_PNT, val ? QMC5883L_ROL_PNT : 0);
> +		mutex_unlock(&data->lock);
> +	}
> +	return ret ? ret : count;
> +}
> +
>  static int qmc5883l_read_raw(struct iio_dev *indio_dev,
>  			     struct iio_chan_spec const *chan, int *val, int *val2, long mask)
>  {
> @@ -599,6 +659,8 @@ static struct attribute *qmc5883l_attributes[] = {
>  	&iio_dev_attr_scale_available.dev_attr.attr,
>  	&iio_dev_attr_data_ready.dev_attr.attr,
>  	&iio_dev_attr_overflow.dev_attr.attr,
> +	&iio_dev_attr_soft_reset.dev_attr.attr,
> +	&iio_dev_attr_pointer_rollover.dev_attr.attr,
>  	NULL
>  };
> 
> @@ -659,6 +721,27 @@ static const struct iio_info qmc5883l_info = {
> 
>  static const unsigned long qmc5883l_scan_masks[] = {0x7, 0};
> 
> +static int qmc5883l_suspend(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct qmc5883l_data *data = iio_priv(indio_dev);
> +
> +	return qmc5883l_set_mode(data, QMC5883L_MODE_STANDBY);
> +}
> +
> +static int qmc5883l_resume(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct qmc5883l_data *data = iio_priv(indio_dev);
> +
> +	return qmc5883l_set_mode(data, QMC5883L_MODE_CONT);
> +}

The driver is currently only seting CONT mode when reading data, so having
this in the suspend/resume doesn't make sense to me.

> +
> +static const struct dev_pm_ops qmc5883l_pm_ops = {
> +	.suspend = qmc5883l_suspend,
> +	.resume = qmc5883l_resume,
> +};
> +
>  static int qmc5883l_probe(struct i2c_client *client)
>  {
>  	struct regmap *regmap;
> @@ -683,6 +766,10 @@ static int qmc5883l_probe(struct i2c_client *client)
>  	data->regmap = regmap;
>  	mutex_init(&data->lock);
> 
> +	ret = iio_read_mount_matrix(&client->dev, &data->orientation);
> +	if (ret)
> +		dev_warn(&client->dev, "Failed to read mount matrix: %d\n", ret);
> +
>  	indio_dev->name = "qmc5883l";
>  	indio_dev->info = &qmc5883l_info;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
> @@ -693,6 +780,7 @@ static int qmc5883l_probe(struct i2c_client *client)
>  	ret = devm_iio_triggered_buffer_setup(&client->dev, indio_dev,
>  					      NULL, &qmc5883l_trigger_handler,
>  					      &qmc5883l_buffer_setup_ops);
> +
>  	if (ret < 0) {
>  		dev_err(&client->dev, "Failed to setup triggered buffer: %d\n", ret);
>  		return ret;
> @@ -730,6 +818,7 @@ static struct i2c_driver qmc5883l_driver = {
>  	.driver = {
>  		.name = "qmc5883l",
>  		.of_match_table = qmc5883l_of_match,
> +		.pm = pm_sleep_ptr(&qmc5883l_pm_ops),
>  	},
>  	.id_table = qmc5883l_id,
>  	.probe = qmc5883l_probe,
> --
> 2.39.5
> 


