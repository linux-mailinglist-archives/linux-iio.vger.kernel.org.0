Return-Path: <linux-iio+bounces-8011-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 754A093E8BC
	for <lists+linux-iio@lfdr.de>; Sun, 28 Jul 2024 19:04:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F30D41F2197B
	for <lists+linux-iio@lfdr.de>; Sun, 28 Jul 2024 17:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0526F5D8F0;
	Sun, 28 Jul 2024 17:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NZgieal3"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B188757333;
	Sun, 28 Jul 2024 17:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722186239; cv=none; b=Fm70j3Qg1fH6Mon/KiFCCwYmqB9XtlJSffCMR39tFYo+NAuuXUgCjMwgEa6YMjxA9/VqwDzxpE4au0bfWezg+ubnMOKXVReT/PD0XVtKNrKv8vjRfvw91jCF78kv6wc+pmbV/UPXxBlHdMi82JQ9/YjhAEG84WnzE26PRkZADrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722186239; c=relaxed/simple;
	bh=u1zaNl+nPHi4CHxkR2wCQjtzwE7OjgkzZ9uJp8uxtR0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U2+/vume8zxAXW4/ZrJCtDXUGaWNCRqTHivfeN2otF8Bpj+x3d5b58bu9bNaLhiXBX25mZg8eF+sqgsVCMRnQObSowicQHQg/udmWkhtu2meO+gCDesybvwoc3NZpYh1sz9Km7kUqnIVvIqiYEgZ+OXeLG0lQ0W0wjzvPrEVViw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NZgieal3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E75DBC116B1;
	Sun, 28 Jul 2024 17:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722186239;
	bh=u1zaNl+nPHi4CHxkR2wCQjtzwE7OjgkzZ9uJp8uxtR0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NZgieal3seizRbXi8N8CSc5ZMgzaWJZuuKNxmWNXnjACoMajL+a9r2Q3O6+QBLfkG
	 MJTJYXX6vvshoSrYMKyjvRmQCf5X+G9dQXtdcdCvrjoRsptQEU540O5F5RuBdR6awz
	 C6ZbjhARuB8z8SPITLwjNlRdF2iyS8TG+yt7P/Qo6PgCsxzuIqG5b5ia5WWgJYj5s8
	 CDA1OfEoPZQ4s+dlb+W/456ZxFtW97FrNKTBa9eIW4aQ4Nvz2wixOoyr0VSkDsR7pR
	 dlICdl4rK+gxz7bGtR6gVHBxIFZGUzrAFvJkdO1jy88QdxFcvu1xewGjRgn7xxPp7C
	 u0xT2bF3LFFeg==
Date: Sun, 28 Jul 2024 18:03:52 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Abhash Jha <abhashkumarjha123@gmail.com>
Cc: linux-iio@vger.kernel.org, anshulusr@gmail.com, lars@metafoo.de,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] iio: light: ltr390: Add configurable gain and
 resolution
Message-ID: <20240728180352.510406bb@jic23-huawei>
In-Reply-To: <20240728151957.310237-1-abhashkumarjha123@gmail.com>
References: <20240727132735.052502ad@jic23-huawei>
	<20240728151957.310237-1-abhashkumarjha123@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 28 Jul 2024 20:49:54 +0530
Abhash Jha <abhashkumarjha123@gmail.com> wrote:

>     Add support for configuring and reading the gain and resolution
>     (integration time). Also provide the available values for gain and
>     resoltion respectively via `read_avail` callback.
Hi Abhash,

Don't indent patch description like this.

Also from a process point of view, for IIO (and I think most of the kernel)
don't reply to a previous version thread with a new version.
The upshot is that it ends up far from the most recent emails in everyone's
inboxes as pretty much everyone uses threading.

Also, if sending multiple patches, please add a cover letter.
--cover-letter in git.

That provides a general place for comments like this one and also
gives the series a nice pretty title in patch work and similar tooling ;)
https://patchwork.kernel.org/project/linux-iio/list/?
See the series title column - that's from cover letters.

Anyhow, on to the code.  Various minor comments inline.
In particularly for v3, please look for accidental or unnecessary changes
of code formatting etc.

They add considerable noise to a fairly simple real change.

Jonathan


> 
> Signed-off-by: Abhash Jha <abhashkumarjha123@gmail.com>
> ---
>  drivers/iio/light/ltr390.c | 144 +++++++++++++++++++++++++++++++++----
>  1 file changed, 130 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/iio/light/ltr390.c b/drivers/iio/light/ltr390.c
> index fff1e8990..9f00661c3 100644
> --- a/drivers/iio/light/ltr390.c
> +++ b/drivers/iio/light/ltr390.c
> @@ -25,19 +25,26 @@
>  #include <linux/regmap.h>
>  
>  #include <linux/iio/iio.h>
> -
> +#include <linux/iio/sysfs.h>
Keep a blank line after the iio includes.
However, why this include?  You aren't defining custom attributes in this
patch.


>  #include <asm/unaligned.h>
>  
> -#define LTR390_MAIN_CTRL      0x00
> -#define LTR390_PART_ID	      0x06
> -#define LTR390_UVS_DATA	      0x10
Hmm. Annoying to have to realign this.  However, it probably isn't
worth a precursor patch for this one.
If it were many more than 3 lines it would be.

> +#define LTR390_MAIN_CTRL		0x00
> +#define LTR390_ALS_UVS_MEAS_RATE	0x04
> +#define LTR390_ALS_UVS_GAIN		0x05
> +#define LTR390_PART_ID			0x06
> +#define LTR390_ALS_DATA			0x0D
> +#define LTR390_UVS_DATA			0x10
> +#define LTR390_INT_CFG			0x19

> +
> +#define LTR390_PART_NUMBER_ID		0xb
> +#define LTR390_ALS_UVS_GAIN_MASK	0x07
> +#define LTR390_ALS_UVS_INT_TIME_MASK	0x70
> +#define LTR390_ALS_UVS_INT_TIME(x)	FIELD_PREP(LTR390_ALS_UVS_INT_TIME_MASK, x)
Brackets around x
define LTR390_ALS_UVS_INT_TIME(x)	FIELD_PREP(LTR390_ALS_UVS_INT_TIME_MASK, (x))

>  
>  #define LTR390_SW_RESET	      BIT(4)
>  #define LTR390_UVS_MODE	      BIT(3)
>  #define LTR390_SENSOR_ENABLE  BIT(1)
>  
> -#define LTR390_PART_NUMBER_ID 0xb

..

> @@ -91,32 +98,135 @@ static int ltr390_read_raw(struct iio_dev *iio_device,
>  			   struct iio_chan_spec const *chan, int *val,
>  			   int *val2, long mask)
>  {
> -	int ret;
>  	struct ltr390_data *data = iio_priv(iio_device);
> +	int ret;
>  
> +	guard(mutex)(&data->lock);
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
>  		ret = ltr390_register_read(data, LTR390_UVS_DATA);
>  		if (ret < 0)
>  			return ret;
> +
Not related to the patch content, so shouldn't be here.
>  		*val = ret;
>  		return IIO_VAL_INT;
> +
Similarly.  It's a reasonable change, but not in this patch as it
adds noise.  Feel free to send another patch in the series that improves
the white space though if you like.

>  	case IIO_CHAN_INFO_SCALE:
>  		*val = LTR390_WINDOW_FACTOR;
>  		*val2 = LTR390_COUNTS_PER_UVI;
>  		return IIO_VAL_FRACTIONAL;
> +
> +	case IIO_CHAN_INFO_INT_TIME:
> +		*val = data->int_time_us;
> +		return IIO_VAL_INT;
> +
>  	default:
>  		return -EINVAL;
>  	}
>  }

...

> +/* integration time in us */
> +static const int ltr390_int_time_map_us[] = {400000, 200000, 100000, 50000, 25000, 12500};

space after { and before } preferred.

> +static const int ltr390_gain_map[] = {1, 3, 6, 9, 18};
>  
>  static const struct iio_chan_spec ltr390_channel = {
>  	.type = IIO_UVINDEX,
> -	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE)
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
> +	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME),
> +	.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME) | BIT(IIO_CHAN_INFO_SCALE)
> +};
> +
> +static int ltr390_set_gain(struct ltr390_data *data, int val)
> +{
> +	int ret, idx;
> +
> +	for (idx = 0; idx < ARRAY_SIZE(ltr390_gain_map); idx++) {
> +		if (ltr390_gain_map[idx] != val)
> +			continue;
> +
> +		guard(mutex)(&data->lock);
> +		ret = regmap_update_bits(data->regmap,
> +					LTR390_ALS_UVS_GAIN,
> +					LTR390_ALS_UVS_GAIN_MASK, idx);
> +		if (ret)
> +			return ret;
> +
> +		data->gain = ltr390_gain_map[idx];
> +		break;
As below. 
		return 0;
> +	}
> +
> +	return 0;
return -EINVAL; to indicate no match.


> +}
> +
> +static int ltr390_set_int_time(struct ltr390_data *data, int val)
> +{
> +	int ret, idx;
> +
> +	for (idx = 0; idx < ARRAY_SIZE(ltr390_int_time_map_us); idx++) {
> +		if (ltr390_int_time_map_us[idx] != val)
> +			continue;
> +
> +		guard(mutex)(&data->lock);
> +		ret = regmap_update_bits(data->regmap,
> +					LTR390_ALS_UVS_MEAS_RATE,
> +					LTR390_ALS_UVS_INT_TIME_MASK,
> +					LTR390_ALS_UVS_INT_TIME(idx));
> +		if (ret)
> +			return ret;
> +
> +		data->int_time_us = ltr390_int_time_map_us[idx];
> +		break;
return 0;

No point in carrying on if we are done.

> +	}
> +
> +	return 0;
If you get here with suggested return 0 above, it will be an error as no
match occured.  In that case, return -EINVAL;

> +}

...

>  static int ltr390_probe(struct i2c_client *client)
> @@ -139,6 +249,11 @@ static int ltr390_probe(struct i2c_client *client)
>  				     "regmap initialization failed\n");
>  
>  	data->client = client;
> +	/* default value of integration time from pg: 15 of the datasheet */
> +	data->int_time_us = 100000;
> +	/* default value of gain from pg: 16 of the datasheet */
> +	data->gain = 3;
> +
>  	mutex_init(&data->lock);
>  
>  	indio_dev->info = &ltr390_info;
> @@ -162,7 +277,7 @@ static int ltr390_probe(struct i2c_client *client)
>  	usleep_range(1000, 2000);
>  
>  	ret = regmap_set_bits(data->regmap, LTR390_MAIN_CTRL,
> -			      LTR390_SENSOR_ENABLE | LTR390_UVS_MODE);
> +				LTR390_SENSOR_ENABLE | LTR390_UVS_MODE);

Avoid accidental white space changes. If you want to make them to cleanup
some inconsistencies or similar, that is fine, but they belong in a patch
that doesn't do anything else.  Here it is adding noise and slowing down
review.

>  	if (ret)
>  		return dev_err_probe(dev, ret, "failed to enable the sensor\n");
>  
> @@ -189,6 +304,7 @@ static struct i2c_driver ltr390_driver = {
>  	.probe = ltr390_probe,
>  	.id_table = ltr390_id,
>  };
> +
Don't add this line.  We often use whitespace to indicate connections and
it is common to do it in cases like this one where module_i2c_driver()
is tightly coupled with the i2c_driver structure.

>  module_i2c_driver(ltr390_driver);
>  
>  MODULE_AUTHOR("Anshul Dalal <anshulusr@gmail.com>");


