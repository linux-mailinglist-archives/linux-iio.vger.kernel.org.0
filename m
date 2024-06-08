Return-Path: <linux-iio+bounces-6070-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78FEE9012F5
	for <lists+linux-iio@lfdr.de>; Sat,  8 Jun 2024 19:19:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09C8E2821C2
	for <lists+linux-iio@lfdr.de>; Sat,  8 Jun 2024 17:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F288ADDC5;
	Sat,  8 Jun 2024 17:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m8rAiRSs"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB121C6A1;
	Sat,  8 Jun 2024 17:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717867169; cv=none; b=PSgU+tdw5VWZ//w3Y4zfYEuri53kRQs4xYHUqrXJd/XvruvrsrSTL6US5tXK9enTSRjbfJxezdlSQ+wX32RFZIXW86DkBfBMWVfzx48KqIgbWP9/BO2/8z/D7GSeYR4Vc2/154qryH7rnulYQ6IwpFAkTA0lVW1nHnbSkpWnLvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717867169; c=relaxed/simple;
	bh=B56FAaq/PYbYmgnYVOvmLDSebWiq6CyrUD51qyszBm8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UpNRhp6DLu7PWKiKY9/h5CTBgdwuVV6RasjpF48TQ1zEFKRMB25FdqJ9dYruRKdth68pceMt7rmgO6xldGdvdgjarjHdoBowNAw9v0LQUQByzT1FxO21yXbvfd1gkxPHfCtUWWXjvTw5Bmqpqo66Nb25Brz5iNgGfgh42AHH+q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m8rAiRSs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84E49C2BD11;
	Sat,  8 Jun 2024 17:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717867169;
	bh=B56FAaq/PYbYmgnYVOvmLDSebWiq6CyrUD51qyszBm8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=m8rAiRSsrfnuVYEiKKHz7RHO6c7G5VlZsiGxZ4RwBA2FZ/yF7NO1lISA3M80TAA63
	 q/ZxlWG1C0aS8oCA/syix8iB0VBlKWC/CI+i7SChJl723c5wRZV9qnjKWLYXorlAZG
	 tomSNm7CJpZoH0htQfKpSY9qfSx+gde2gf0eOlCWfMcyXMDAummg0lvpY5qr8oPVO2
	 jzVqj+E4L7gFmXVRBtzQObnJpTHx/EygC9SN+vWN+6kerFN6XFnE3fpG1f4B2wXBC6
	 lMUkqWZC6hyl6eN6o3eXCLIC/NIvPr5aFqvRTEFt/GBYKX/1ocdPwGRp898bNwfhsl
	 sA/yUrJsCEBww==
Date: Sat, 8 Jun 2024 18:19:22 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Antoni Pokusinski <apokusinski01@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 apokusinski@o2.pl
Subject: Re: [PATCH v2] iio: humidity: si7020: add heater support
Message-ID: <20240608181922.0e8104df@jic23-huawei>
In-Reply-To: <20240607141029.51744-1-apokusinski@o2.pl>
References: <20240607103944.11730-1-apokusinski@o2.pl>
	<20240607141029.51744-1-apokusinski@o2.pl>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  7 Jun 2024 16:10:30 +0200
Antoni Pokusinski <apokusinski01@gmail.com> wrote:

> From: Antoni Pokusinski <apokusinski01@gmail.com>
> 
> This patch adds support for the integrated on-chip heater that is present
> on all the devices supported by this driver (si7020, si7021, si7013, th6).
> In order to configure the heater, the driver interacts with the following
> device registers:
> * User Register - the 2nd bit of this register is a "Heater Enable bit"
>   (0 means that the heater is off, 1 means that it's on).
> * Heater Register - this register is present only on the si70xx devices
>   and controls the current flowing through the heater. The 4 lower bits
>   of this register can be assigned values from 0x0 to 0xF.
> 
> Signed-off-by: Antoni Pokusinski <apokusinski01@gmail.com>
> 
> --
---

Otherwise this gets picked up in the git log.

Anyhow, I noticed because I was checking b4 picked this one up right.

Excess stuff removed in the description and applied to the togreg
branch of iio.git which is initially pushed out as testing for
0-day to see if it can find anything we missed.

Thanks,

Jonathan
> Changes since v1:
> * macros: remove unnecessary comments
> * macros: add more meaningful names
> * `struct si7020_data`: add comment explaining the mutex
> * `si7020_update_reg()`: change the control flow to more standard
> * use `scoped_guard()` instead of `mutex_lock() <...> mutex_unlock()`
> * `si7020_probe()`: add comment for User Register default value
> * minor format fixes
> --
> Hello, after sending this email I noticed an accidental email mismatch
> between "From:" and the "Signed-off-by:" therefore I send this email
> once again with a corrected signature. Sorry for the confusion.
> ---
>  drivers/iio/humidity/si7020.c | 137 +++++++++++++++++++++++++++++++++-
>  1 file changed, 133 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/humidity/si7020.c b/drivers/iio/humidity/si7020.c
> index fb1006649328..1215fab7b1a5 100644
> --- a/drivers/iio/humidity/si7020.c
> +++ b/drivers/iio/humidity/si7020.c
> @@ -23,6 +23,7 @@
>  #include <linux/mod_devicetable.h>
>  #include <linux/slab.h>
>  #include <linux/sysfs.h>
> +#include <linux/stat.h>
>  
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> @@ -33,17 +34,38 @@
>  #define SI7020CMD_TEMP_HOLD	0xE3
>  /* Software Reset */
>  #define SI7020CMD_RESET		0xFE
> +#define SI7020CMD_USR_WRITE	0xE6
> +/* "Heater Enabled" bit in the User Register */
> +#define SI7020_USR_HEATER_EN	BIT(2)
> +#define SI7020CMD_HEATER_WRITE	0x51
> +/* Heater current configuration bits */
> +#define SI7020_HEATER_VAL	GENMASK(3, 0)
> +
> +struct si7020_data {
> +	struct i2c_client *client;
> +	/* Lock for cached register values */
> +	struct mutex lock;
> +	u8 user_reg;
> +	u8 heater_reg;
> +};
> +
> +static const int si7020_heater_vals[] = { 0, 1, 0xF };
>  
>  static int si7020_read_raw(struct iio_dev *indio_dev,
>  			   struct iio_chan_spec const *chan, int *val,
>  			   int *val2, long mask)
>  {
> -	struct i2c_client **client = iio_priv(indio_dev);
> +	struct si7020_data *data = iio_priv(indio_dev);
>  	int ret;
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
> -		ret = i2c_smbus_read_word_swapped(*client,
> +		if (chan->type == IIO_CURRENT) {
> +			*val = data->heater_reg;
> +			return IIO_VAL_INT;
> +		}
> +
> +		ret = i2c_smbus_read_word_swapped(data->client,
>  						  chan->type == IIO_TEMP ?
>  						  SI7020CMD_TEMP_HOLD :
>  						  SI7020CMD_RH_HOLD);
> @@ -96,17 +118,118 @@ static const struct iio_chan_spec si7020_channels[] = {
>  		.type = IIO_TEMP,
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>  			BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_OFFSET),
> +	},
> +	{
> +		.type = IIO_CURRENT,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +		.info_mask_separate_available = BIT(IIO_CHAN_INFO_RAW),
> +		.extend_name = "heater",
> +	}
> +};
> +
> +static int si7020_update_reg(struct si7020_data *data,
> +				u8 *reg, u8 cmd, u8 mask, u8 val)
> +{
> +	u8 new = (*reg & ~mask) | val;
> +	int ret;
> +
> +	ret = i2c_smbus_write_byte_data(data->client, cmd, new);
> +	if (ret)
> +		return ret;
> +
> +	*reg = new;
> +
> +	return 0;
> +}
> +
> +static int si7020_write_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     int val, int val2, long mask)
> +{
> +	struct si7020_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		if (chan->type != IIO_CURRENT || val2 != 0 ||
> +			val < si7020_heater_vals[0] || val > si7020_heater_vals[2])
> +			return -EINVAL;
> +
> +		scoped_guard(mutex, &data->lock)
> +			ret = si7020_update_reg(data, &data->heater_reg,
> +					SI7020CMD_HEATER_WRITE, SI7020_HEATER_VAL, val);
> +		return ret;
> +	default:
> +		return -EINVAL;
>  	}
> +}
> +
> +static int si7020_read_available(struct iio_dev *indio_dev,
> +				  struct iio_chan_spec const *chan,
> +				  const int **vals,
> +				  int *type, int *length, long mask)
> +{
> +	if (mask != IIO_CHAN_INFO_RAW || chan->type != IIO_CURRENT)
> +		return -EINVAL;
> +
> +	*vals = si7020_heater_vals;
> +	*type = IIO_VAL_INT;
> +
> +	return IIO_AVAIL_RANGE;
> +}
> +
> +static ssize_t si7020_show_heater_en(struct device *dev,
> +				 struct device_attribute *attr, char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct si7020_data *data = iio_priv(indio_dev);
> +
> +	return sysfs_emit(buf, "%d\n", !!(data->user_reg & SI7020_USR_HEATER_EN));
> +}
> +
> +static ssize_t si7020_store_heater_en(struct device *dev,
> +				  struct device_attribute *attr,
> +				  const char *buf, size_t len)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct si7020_data *data = iio_priv(indio_dev);
> +	int ret;
> +	bool val;
> +
> +	ret = kstrtobool(buf, &val);
> +	if (ret)
> +		return ret;
> +
> +	scoped_guard(mutex, &data->lock)
> +		ret = si7020_update_reg(data, &data->user_reg, SI7020CMD_USR_WRITE,
> +				SI7020_USR_HEATER_EN, val ? SI7020_USR_HEATER_EN : 0);
> +
> +	return ret < 0 ? ret : len;
> +}
> +
> +static IIO_DEVICE_ATTR(heater_enable, 0644,
> +		       si7020_show_heater_en, si7020_store_heater_en, 0);
> +
> +static struct attribute *si7020_attributes[] = {
> +	&iio_dev_attr_heater_enable.dev_attr.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group si7020_attribute_group = {
> +	.attrs = si7020_attributes,
>  };
>  
>  static const struct iio_info si7020_info = {
>  	.read_raw = si7020_read_raw,
> +	.write_raw = si7020_write_raw,
> +	.read_avail = si7020_read_available,
> +	.attrs = &si7020_attribute_group,
>  };
>  
>  static int si7020_probe(struct i2c_client *client)
>  {
>  	struct iio_dev *indio_dev;
> -	struct i2c_client **data;
> +	struct si7020_data *data;
>  	int ret;
>  
>  	if (!i2c_check_functionality(client->adapter,
> @@ -126,7 +249,9 @@ static int si7020_probe(struct i2c_client *client)
>  		return -ENOMEM;
>  
>  	data = iio_priv(indio_dev);
> -	*data = client;
> +	i2c_set_clientdata(client, indio_dev);
> +	data->client = client;
> +	mutex_init(&data->lock);
>  
>  	indio_dev->name = dev_name(&client->dev);
>  	indio_dev->modes = INDIO_DIRECT_MODE;
> @@ -134,6 +259,10 @@ static int si7020_probe(struct i2c_client *client)
>  	indio_dev->channels = si7020_channels;
>  	indio_dev->num_channels = ARRAY_SIZE(si7020_channels);
>  
> +	/* All the "reserved" bits in the User Register are 1s by default */
> +	data->user_reg = 0x3A;
> +	data->heater_reg = 0x0;
> +
>  	return devm_iio_device_register(&client->dev, indio_dev);
>  }
>  


