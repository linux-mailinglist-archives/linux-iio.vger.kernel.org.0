Return-Path: <linux-iio+bounces-5573-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A0E8D6FCA
	for <lists+linux-iio@lfdr.de>; Sat,  1 Jun 2024 14:25:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E29A3B21AEE
	for <lists+linux-iio@lfdr.de>; Sat,  1 Jun 2024 12:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68BC6150985;
	Sat,  1 Jun 2024 12:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RomMZCDw"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2494342A83;
	Sat,  1 Jun 2024 12:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717244721; cv=none; b=DnO8l9MQUIKIctkNLc+dtns2efuV/hsI8O321CPKOIMC4QR8tHgyXmWMmtPouJQJdUNCySPX3eUz7XQY66uJIfMnNr7DGpCLzyYr/KW+Dc+zwS5QrNjgQPpwUUCg58fU2oF7I+97wAox9425yUwGnY8mmnRaGya3ICNYUBdrTfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717244721; c=relaxed/simple;
	bh=N9I6RAh8qqeLz3rMMDmczOGfOv05z+Ql9SIXcrBlZv4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IexOMg6TZLQuZujd+vDt9vYs/VOHlH/39l/5pPshJUC+ctiMAs9Dfi5+fUDu/vMiVJtmDtwL8HfplIjkfjSU511Pv4/58LVGTERXlJXuT266bzkz3+OLnfB4fYULsSaqPKW57reois51bU3wsv5BR+D7fQdAOUyP3/l3zTZmUUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RomMZCDw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDF7DC116B1;
	Sat,  1 Jun 2024 12:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717244720;
	bh=N9I6RAh8qqeLz3rMMDmczOGfOv05z+Ql9SIXcrBlZv4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RomMZCDwvHw+ztM0CnMz1MEpFvekKyZxPQ8CaFnjWfabyD6+n4csPXbki26ym9aFY
	 nBUeSyBSRDuAjSp68YFmZLkwSQtTyUpTr/xk39Bd2kD3REjD/mAo41StrATaydSdhw
	 iTVnWxcu37VvuvVJ7isDHDyyWoXIXa9ilDkhWUzaJDtiPb7lZdCMdN2v3TnLg9Zomp
	 pZZarNQLusEl1ZnpTmYjjhNtGCp1dojY9L9PSSpoFcimZ/XDQ8eV8dnGr48HSvwbpP
	 s+uKpDVbP3pEMHl9YrB1JywQkJRVZisevEVjy6De8Z96RzljudZHZNsOZa/7m9ki6d
	 u2/NGUvFCiNDA==
Date: Sat, 1 Jun 2024 13:25:07 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Antoni Pokusinski <apokusinski01@gmail.com>
Cc: linux-kernel@vger.kernel.org, Antoni Pokusinski <apokusinski@o2.pl>,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: humidity: si7020: add heater support
Message-ID: <20240601132507.316f9b50@jic23-huawei>
In-Reply-To: <20240528000858.14459-1-apokusinski@o2.pl>
References: <20240528000858.14459-1-apokusinski@o2.pl>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 May 2024 02:08:58 +0200
Antoni Pokusinski <apokusinski01@gmail.com> wrote:

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
> Signed-off-by: Antoni Pokusinski <apokusinski@o2.pl>
Hi Antoni,

Make sure to +CC linux-iio@vger.kernel.org

Looks fine in general. Some minor comments for v2.

Jonathan

> ---
>  drivers/iio/humidity/si7020.c | 137 +++++++++++++++++++++++++++++++++-
>  1 file changed, 133 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/humidity/si7020.c b/drivers/iio/humidity/si7020.c
> index fb1006649328..f0712ad5944c 100644
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
> +/* Write User Register */
> +#define SI7020CMD_USR_WRITE	0xE6
Ideally register/command/field names should be sufficient for their meaning
to be obvious without needing to check the comments.  In this case I think
it is, so the comment is unnecessary.  Excess comments tend to be things that
get out of date or left in the wrong place when code gets reorganized so
we generally like to keep only the ones that convey substantial  meaning.

> +/* "Heater Enabled" bit in the User Register */
> +#define SI7020_USR_HTRE		BIT(2)
This one, not so good. I would use more characters to make it easier to follow
#define SI7020_USR_HEATER_EN


> +/* Write Heater Register */
> +#define SI7020CMD_HTR_WRITE	0x51
> +/* Heater current configuration bits */
> +#define SI7020_HTR_HEATER	GENMASK(3, 0)
HEATER_VAL or similar
> +
> +struct si7020_data {
> +	struct i2c_client *client;
> +	struct mutex lock;

Locks always need a comment describing what they are protecting.
Here I assume that is the following two cached register values?
If so add a comment to reflect that.

> +	u8 user_reg;
> +	u8 heater_reg;
> +};
> +
> +static const int si7020_heater_vals[] = {0, 1, 0xF};
Slight preference for { 0, 1, 0xF };

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

I think a blank line here would help separate the blocks of unrelated
code a little.

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
>  	}
>  };
>  
> +static int si7020_update_reg(struct si7020_data *data,
> +				u8 *reg, u8 cmd, u8 mask, u8 val)
> +{
> +	u8 new = (*reg & ~mask) | val;
> +	int ret;
> +
> +	ret = i2c_smbus_write_byte_data(data->client, cmd, new);
> +	if (!ret)
> +		*reg = new;
Stick to the more standard flow of
	if (ret)
		return ret;

	*reg = new;

	return 0;

It is a little longer but requires a tiny bit less thinking by reviewers
because the same pattern gets used everywhere rather than doing something
special for the final call.
> +
> +	return ret;
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
> +		mutex_lock(&data->lock);

Consider scoped_guard as then you can return directly.

> +		ret = si7020_update_reg(data, &data->heater_reg, SI7020CMD_HTR_WRITE,
> +							SI7020_HTR_HEATER, val);
> +		mutex_unlock(&data->lock);
> +		return ret;
> +	default:
> +		return -EINVAL;
> +	}
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
> +	return sysfs_emit(buf, "%d\n", !!(data->user_reg & SI7020_USR_HTRE));
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
> +	mutex_lock(&data->lock);
> +	ret = si7020_update_reg(data, &data->user_reg, SI7020CMD_USR_WRITE,
> +					SI7020_USR_HTRE, val ? SI7020_USR_HTRE : 0);
Another case where scoped_guard() would make things neater.  or just guard() in here
given the lack of nee to protect it.

> +	mutex_unlock(&data->lock);
> +
> +	return ret < 0 ? ret : len;
> +}
> +
> +static IIO_DEVICE_ATTR(heater_enable, 0644,
> +		       si7020_show_heater_en, si7020_store_heater_en, 0);
> +
> +static struct attribute *si7020_attributes[] = {
> +	&iio_dev_attr_heater_enable.dev_attr.attr,
> +	NULL,
No comma on null terminators.  We don't want to allow anything after them.
> +};
> +
> +static const struct attribute_group si7020_attribute_group = {
> +	.attrs = si7020_attributes,
> +};
> +
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
> +	/* Default register values */
> +	data->user_reg = 0x3A;

Can you build that up from fields with names?
I don't like a magic value where I have no idea what some of the bits are.

> +	data->heater_reg = 0x0;
> +
>  	return devm_iio_device_register(&client->dev, indio_dev);
>  }
>  


