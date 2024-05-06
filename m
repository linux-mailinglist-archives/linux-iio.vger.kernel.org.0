Return-Path: <linux-iio+bounces-4839-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1F908BCEEF
	for <lists+linux-iio@lfdr.de>; Mon,  6 May 2024 15:29:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8148B227F2
	for <lists+linux-iio@lfdr.de>; Mon,  6 May 2024 13:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA2B776408;
	Mon,  6 May 2024 13:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DPDLO+So"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88AAF763F0
	for <linux-iio@vger.kernel.org>; Mon,  6 May 2024 13:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715002183; cv=none; b=mXxLVO7f0mCEMiL0nPn6ck0CPo186Ye+ccdvsfUIJsY+wiz3HblChaRnAmuJlDkXz83pZihxXFWIZSJDBIKoR+al4jrn0CnBtd+OFIXx4JcRFrYu/r+u8VFL6KgjonXqhLfKLetnXQdQitUbdpsE73mvE+RjHY8mIZpK84IDt7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715002183; c=relaxed/simple;
	bh=9kGCo9sfvbY0wDZ2byo8ZA/iTwACWcQfuuQ5uuQO80c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pAcdkFtjDyF3+EKqnY3kKXUkSzEt1h2MUjW/URBm93nuixUwmdYvIcQojcS8kpc5fH7TrCP6KbPwBKUboSM0/Es9+4zxuP4TCMriL4K8TRP9PzvqZXCfnSjluBdpivR2XN5uxVs/yPHVJ5UjLftvEQIi9a8MegzxDNDJPn6FACo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DPDLO+So; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BD5AC116B1;
	Mon,  6 May 2024 13:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715002183;
	bh=9kGCo9sfvbY0wDZ2byo8ZA/iTwACWcQfuuQ5uuQO80c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DPDLO+SoKlbQGiBSHVeWnn92CvffRovoEhVzMpNfbAKKV0aA0q3T38uoexjUM4eW+
	 FzyRdh02NTyO3PF+PLeLurcaK1m85XzZAXxxKHsfGwuFl8DzvyLVsA7AjqLq8s9u0d
	 4O6FAjXpJluxRqf/OJJjBU4/R/bgfzdeKp9H/9gDUAKIQnwiGoQ8I+GLU9VD8yFj3c
	 jdrYsDocEpteGbA3/0z1o0MMmrtxJSpiWZWXamMDExntK6FolcL2mTcyQ/EvgBhV6/
	 /N/eAqrcA3i8RGsoi55zRj8jzVkBm+Txvs6rp6CT023SVOMz72HVWp+sBl5IqRvjHv
	 KOT76cTEkACZQ==
Date: Mon, 6 May 2024 14:29:33 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Arthur Becker <arthur.becker@sentec.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: light: driver for Vishay VEML6040
Message-ID: <20240506142933.0956b6fd@jic23-huawei>
In-Reply-To: <ZR1P278MB11173CC7CBE3840843443776811C2@ZR1P278MB1117.CHEP278.PROD.OUTLOOK.COM>
References: <ZR1P278MB11173CC7CBE3840843443776811C2@ZR1P278MB1117.CHEP278.PROD.OUTLOOK.COM>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 6 May 2024 11:43:51 +0000
Arthur Becker <arthur.becker@sentec.com> wrote:

Hi Arthur,

Welcome to IIO.

> From: Arthur Becker <arthur.becker@sentec.com>
> Subject: [PATCH] iio: light: driver for Vishay VEML6040

This email header shouldn't be here. I guess you cut and paste?
If so just remember to drop this bit as it is part of the email
headers on the sent email and doesn't belong in the email body.

> 
> Implements driver for the Vishay VEML6040 rgbw light sensor.
> 
> Included functionality: setting the integration time and reading the raw
> values for the four channels
> 
> Not yet implemented: setting the measurements to 'Active Force' (Auto
> measurements off, and adding a measurement trigger)
> 
> Datasheet: https://www.vishay.com/docs/84276/veml6040.pdf
The line above is a formal tag, so should be part of the tags block
by which I mean there should not be a blank line here.
> 
> signed-off-by: Arthur Becker <arthur.becker@sentec.com>

Various comments inline.

Note this also need a DT binding document. Make sure you include the relevant
DT list and maintainers for v2 as they will need to review that.

Jonathan

> ---
>  drivers/iio/light/Kconfig    |  11 ++
>  drivers/iio/light/Makefile   |   1 +
>  drivers/iio/light/veml6040.c | 338 +++++++++++++++++++++++++++++++++++
>  3 files changed, 350 insertions(+)
>  create mode 100644 drivers/iio/light/veml6040.c
> 
> diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
> index fd5a9879a582..7ff517b728ec 100644
> --- a/drivers/iio/light/Kconfig
> +++ b/drivers/iio/light/Kconfig
> @@ -654,6 +654,17 @@ config VEML6030
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called veml6030.
>  
> +config VEML6040
> +	tristate "VEML6040 RGBW light sensor"
> +	select REGMAP_I2C
> +	depends on I2C
> +	help
> +	  Say Y here if you want to build a driver for the Vishay VEML6040
> +	  RGBW light sensor.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called veml6040.
> +
>  config VEML6070
>  	tristate "VEML6070 UV A light sensor"
>  	depends on I2C
> diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
> index 2e5fdb33e0e9..ae957c88aa0c 100644
> --- a/drivers/iio/light/Makefile
> +++ b/drivers/iio/light/Makefile
> @@ -61,6 +61,7 @@ obj-$(CONFIG_US5182D)		+= us5182d.o
>  obj-$(CONFIG_VCNL4000)		+= vcnl4000.o
>  obj-$(CONFIG_VCNL4035)		+= vcnl4035.o
>  obj-$(CONFIG_VEML6030)		+= veml6030.o
> +obj-$(CONFIG_VEML6040)		+= veml6040.o
>  obj-$(CONFIG_VEML6070)		+= veml6070.o
>  obj-$(CONFIG_VEML6075)		+= veml6075.o
>  obj-$(CONFIG_VL6180)		+= vl6180.o
> diff --git a/drivers/iio/light/veml6040.c b/drivers/iio/light/veml6040.c
> new file mode 100644
> index 000000000000..7effb712820f
> --- /dev/null
> +++ b/drivers/iio/light/veml6040.c
> @@ -0,0 +1,338 @@
> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>	
> +
> +#define VEML6040_DRV_NAME "veml6040"

Whilst this is used in a couple of place, the use in the id table
will be odd if this driver gains support for other parts in future.
For the remaining two cases there is no particular reason why the value
should be the same, so I generally prefer if people just put this
string inline.  It's not a 'magic value' so it doesn't benefit from
a define.  Unfortunately what you have here is a fairly common pattern
though :(

> +
> +#define VEML6040_SLAVE_ADDR 0x10
> +
> +/* VEML6040 Registers */
> +#define VEML6040_REG_CONF_RW 0x00
> +#define VEML6040_REG_R_RO 0x08
> +#define VEML6040_REG_G_RO 0x09
> +#define VEML6040_REG_B_RO 0x0A
> +#define VEML6040_REG_W_RO 0x0B
> +
> +/* Bit masks for specific functionality */
> +#define VEML6040_MASK_IT GENMASK(6, 4) /* bit mask integration time */
Good if the field naming includes which register they are in.
Writing fields to the wrong register is a fairly common source of bugs.

VEML6040_CONF_IT_MSK or similar would work here. Not mask on end because
I'd expect the values to be 
VEML6040_CONF_IT_40 etc

If you can use slightly longer names and avoid need for comments even better.
Definitely no need to comment that a mask is a mask.

Another thing that works well is to use small indentation so that the
register and the fields are kept together.  Something like.

#define VEML6040_CONF_REG_RW 0x000
#define   VEML6040_CONF_IT_MASK GENMASK(6, 4)
#define   VEML6040_CONF_IT_40 0
#define   VEML6040_CONF_IT_80 1
#define   VEML6040_CONF_IT_160 2
#define   VEML6040_CONF_IT_320 3
etc.

Note the field values are not shifted because you should use
FIELD_PREP() / FIELD_GET() which take the mask and the contents of the field
(dealing with shifts for you).

Here has the handy side effect that the index = the field value so you can drop
the veml6040_int_time_codes[] and just use the index directly.

> +#define VEML6040_MASK_SD BIT(0) /* Shutdown */
> +#define VEML6040_MASK_AF \
> +	BIT(1) /* Active Force (Auto Measurements 0:on, 1:off) */
> +#define VEML6040_MASK_TRIG BIT(2) /* Trigger Measurement (when AF Bit is set) */
> +
> +/* VEML6040 Command Codes for Integration Time in Milliseconds */
> +#define VEML6040_IT_40 0x00
> +#define VEML6040_IT_80 0x10
> +#define VEML6040_IT_160 0x20
> +#define VEML6040_IT_320 0x30
> +#define VEML6040_IT_640 0x40
> +#define VEML6040_IT_1280 0x50
> +
> +static const int veml6040_int_time_avail[] = { 40, 80, 160, 320, 640, 1280 };
> +
> +static const int veml6040_int_time_codes[] = {
> +	VEML6040_IT_40,	 VEML6040_IT_80,  VEML6040_IT_160,
> +	VEML6040_IT_320, VEML6040_IT_640, VEML6040_IT_1280
> +};
> +
> +enum veml6040_chan {
> +	CH_RED,
> +	CH_GREEN,
> +	CH_BLUE,
> +	CH_WHITE,
> +};
> +
> +struct veml6040_data {
> +	struct i2c_client *client;
> +	struct regmap *regmap;
> +};
> +
> +static const struct regmap_config veml6040_regmap_config = {
> +	.name = "veml6040_regmap",
> +	.reg_bits = 8,
> +	.val_bits = 16,
> +	.max_register = VEML6040_REG_W_RO,
> +	.val_format_endian = REGMAP_ENDIAN_LITTLE,
> +};
> +
> +static int veml6040_enable(struct veml6040_data *data)
> +{
> +	return regmap_update_bits(data->regmap, VEML6040_REG_CONF_RW,
> +				  VEML6040_MASK_SD, 0x00);
> +}
> +
> +static int veml6040_shutdown(struct veml6040_data *data)
> +{
> +	return regmap_update_bits(data->regmap, VEML6040_REG_CONF_RW,
> +				  VEML6040_MASK_SD, 0xFF);
> +}
> +
> +static int veml6040_set_automode(struct veml6040_data *data)
> +{
> +	return regmap_update_bits(data->regmap, VEML6040_REG_CONF_RW,
> +				  VEML6040_MASK_AF, 0x00);
> +}
> +
> +static int veml6040_set_forcemode(struct veml6040_data *data)
> +{
> +	return regmap_update_bits(data->regmap, VEML6040_REG_CONF_RW,
> +				  VEML6040_MASK_AF, 0xFF);
> +}
> +
> +static int veml6040_reset_measurement_trig(struct veml6040_data *data)
> +{
> +	return regmap_update_bits(data->regmap, VEML6040_REG_CONF_RW,
> +				  VEML6040_MASK_TRIG, 0x00);
> +}
> +
> +static int veml6040_trig_measurement(struct veml6040_data *data)
> +{
> +	return regmap_update_bits(data->regmap, VEML6040_REG_CONF_RW,
> +				  VEML6040_MASK_TRIG, 0xFF);

Set only the bits that are being set.  Sure it makes no actual difference
but it does confuse the reader. Just use the mask for both the mask
and value.

However, nothing calls this function so better to drop it.
Drop the others above that are also not used in the driver so far.
You can bring them back when implementing the related features.

> +}
> +
> +static int veml6040_set_it(struct veml6040_data *data, int it_code)
> +{
> +	return regmap_update_bits(data->regmap, VEML6040_REG_CONF_RW,
> +				  VEML6040_MASK_IT, it_code);

As below, I'd use this inline.  Note in probe you have a comment about 
the register being written but it calls this which only writes some bits.
Better to do a full register write there or fix the comment.

> +}
> +
> +static int veml6040_read_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan, int *val,
> +			     int *val2, long mask)
> +{
> +	int ret, reg, it_index;
> +	struct veml6040_data *data = iio_priv(indio_dev);
> +	struct regmap *regmap = data->regmap;
> +	struct device *dev = &data->client->dev;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		switch (chan->channel) {
> +		case CH_RED:
> +			ret = regmap_read(regmap, VEML6040_REG_R_RO, &reg);
> +			break;
> +		case CH_GREEN:
> +			ret = regmap_read(regmap, VEML6040_REG_G_RO, &reg);
> +			break;
> +		case CH_BLUE:
> +			ret = regmap_read(regmap, VEML6040_REG_B_RO, &reg);
> +			break;
> +		case CH_WHITE:
> +			ret = regmap_read(regmap, VEML6040_REG_W_RO, &reg);
> +			break;
> +		default:
> +			return -EINVAL;
> +		}

Pull the error check up to here.

> +		break;
> +
> +	case IIO_CHAN_INFO_INT_TIME:
> +		ret = regmap_read(regmap, VEML6040_REG_CONF_RW, &reg);
Aim for no side effects more locally on error. So
		if (ret)
			reutrn ret;

		it_index = FIELD_GET(VEML6040_MASK_IT, reg);
range check this.  It's a 3 bit value, but we only accept 6 values
so if the hardware goes wrong we might run off the end of the array.

> +		it_index = (reg & VEML6040_MASK_IT) >> 4;
> +		reg = veml6040_int_time_avail[it_index];

		*val = veml6040_int_time_avail[it_index];
		return IIO_VAL_INT;

> +		break;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	if (ret < 0) {
> +		dev_err(dev, "iio-veml6040 - Can't read data %d\n", ret);
> +		return ret;
This is a long way in lines of code from where ret is set.

> +	}
> +	*val = reg;
> +	return IIO_VAL_INT;
> +}
> +
> +static int veml6040_write_raw(struct iio_dev *indio_dev,
> +			      struct iio_chan_spec const *chan, int val,
> +			      int val2, long mask)
> +{
> +	struct veml6040_data *data = iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_INT_TIME:
> +		for (int i = 0; i < ARRAY_SIZE(veml6040_int_time_avail); i++) {
> +			if (veml6040_int_time_avail[i] == val) {
> +				return veml6040_set_it(
As mentioned above, use the field values (not the shifted version) and
I think the lookup here becomes just i itself.

Common trick to reduce indent in cases like this is
			if (veml6040_int_time_avail[i] != val)
				continue;
			return veml6040_set_it()
however, as comments on below, I'd prefer to see the regmap() access
call here rather than a wrapper function that doesn't add much
to readability.
	
> +					data, veml6040_int_time_codes[i]);
> +			}
> +		}
		return -EINVAL;

here to save us looking to see what happens after the switch statement
and let userspace know we didn't do anything because a value we didn't
understand was provided.

> +	default:
> +		return -EINVAL;
> +	}
> +	return 0;
> +}
> +
> +static int veml6040_read_avail(struct iio_dev *indio_dev,
> +			       struct iio_chan_spec const *chan,
> +			       const int **vals, int *type, int *length,
> +			       long mask)
> +{
> +	printk("iio-veml6040 - read_avail\n");

Clean out debug prints like this before sending patches upsteram.

> +	switch (mask) {
> +	case IIO_CHAN_INFO_INT_TIME:
> +		*length = ARRAY_SIZE(veml6040_int_time_avail);
> +		*vals = veml6040_int_time_avail;
> +		*type = IIO_VAL_INT;
> +		return IIO_AVAIL_LIST;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}

...

> +static const struct iio_chan_spec veml6040_channels[] = {
> +	{
> +		.type = IIO_INTENSITY,
> +		.channel = CH_RED,
> +		.channel2 = IIO_MOD_LIGHT_RED,
> +		.modified = true,

modified is a 1 bit flag. Hence
		.modified = 1,
is more appropriate.

> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_INT_TIME),
> +		.info_mask_shared_by_type_available =
> +			BIT(IIO_CHAN_INFO_INT_TIME),
> +	},
> +	{
> +		.type = IIO_INTENSITY,
> +		.channel = CH_GREEN,
> +		.channel2 = IIO_MOD_LIGHT_GREEN,
> +		.modified = true,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_INT_TIME),
> +		.info_mask_shared_by_type_available =
> +			BIT(IIO_CHAN_INFO_INT_TIME),
> +	},
> +	{
> +		.type = IIO_INTENSITY,
> +		.channel = CH_BLUE,
> +		.channel2 = IIO_MOD_LIGHT_BLUE,
> +		.modified = true,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_INT_TIME),
> +		.info_mask_shared_by_type_available =
> +			BIT(IIO_CHAN_INFO_INT_TIME),
> +	},
> +	{
> +		.type = IIO_INTENSITY,
> +		.channel = CH_WHITE,
> +		.channel2 = IIO_MOD_LIGHT_CLEAR,
> +		.modified = true,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_INT_TIME),
> +		.info_mask_shared_by_type_available =
> +			BIT(IIO_CHAN_INFO_INT_TIME),
> +	}
> +};
> +
> +static int veml6040_probe(struct i2c_client *client,
> +			  const struct i2c_device_id *id)
> +{
> +	struct veml6040_data *data;
> +	struct iio_dev *indio_dev;
> +	struct regmap *regmap;
> +	int ret;
> +
> +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
> +		dev_err(&client->dev,
> +			"iio-veml6040 - i2c adapter doesn't support plain i2c\n");
> +		return -EOPNOTSUPP;

Lots of places to use
		return dev_err_probe(...);

> +	}
> +
> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> +	if (!indio_dev) {
> +		dev_err(&client->dev, "iio-veml6040 - Error! Out of memory\n");

I'm fairly sure the dev_err() prints make it fairly obvious it's an error.
We also rarely bother printing errors for failure of small memory allocations.
They are very rare  / should never happen.

Also, which device is effected is printed anyway so I don't think the driver
name helps much. 

If you do keep a print here at all, something like the following would 
be sufficient.

		return dev_err_probe(&client->dev, -ENOMEM,
				     "IIO device allocation failed\n");
> +		return -ENOMEM;
> +	}
> +
> +	regmap = devm_regmap_init_i2c(client, &veml6040_regmap_config);
> +	if (IS_ERR(regmap)) {
> +		dev_err(&client->dev,
> +			"iio-veml6040 - Error! Can't setup regmap\n");
> +		return PTR_ERR(regmap);
> +	}
> +
> +	data = iio_priv(indio_dev);
> +	i2c_set_clientdata(client, indio_dev);
> +	data->client = client;
> +	data->regmap = regmap;
> +
> +	indio_dev->name = VEML6040_DRV_NAME;
> +	indio_dev->info = &veml6040_info;
> +	indio_dev->channels = veml6040_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(veml6040_channels);
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	/* Initialize config register */
> +	ret = veml6040_set_it(data, VEML6040_IT_40);
Better to not have the wrapper. If you have the regmap_write()
here the code will be self explanatory and the comment not needed.
> +	if (ret < 0) {
> +		dev_err(&client->dev,
> +			"iio-veml6040 - Could not set Integration Time: %d\n",
> +			ret);
> +		return ret;
> +	}
> +
> +	ret = veml6040_set_automode(data);
> +	if (ret < 0) {
> +		dev_err(&client->dev,
> +			"iio-veml6040 - Could not set Automode: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = veml6040_enable(data);
> +	if (ret < 0) {
> +		dev_err(&client->dev,
> +			"iio-veml6040 - Could not set Enable: %d\n", ret);
> +		return ret;
Use dev_err_probe() for all error reporting in probe() function and any
code only called from probe().  It both handles deferred probing where
relevant and simplifies the code slightly.

> +	}

	See below (note signature of veml6040 will need to be slightly changed).

	ret = devm_add_action_or_reset(dev, veml6040_shutdown, data);
	if (ret)
		return dev_err_probe();
> +
> +	return devm_iio_device_register(&client->dev, indio_dev);
> +}
> +
> +static const struct i2c_device_id veml6040_id_table[] = {
> +	{ VEML6040_DRV_NAME, 0 },

As commented at the start, I would not use this macro.  It will look very odd
if another part is supported by the driver in future and it only serves
to make the code harder to read.

> +	{},
No comma for 'NULL' terminator like things.
> +};
> +MODULE_DEVICE_TABLE(i2c, veml6040_id_table);
> +
> +static const struct of_device_id veml6040_of_match[] = {
> +	{ .compatible = "vishay,veml6040" },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, veml6040_of_match);
> +
> +static void veml6040_remove(struct i2c_client *client)
> +{
> +	struct iio_dev *indio_dev;
> +	struct veml6040_data *data;
> +
> +	/* Set device to power down mode */
> +	indio_dev = i2c_get_clientdata(client);
> +	data = iio_priv(indio_dev);
> +	veml6040_shutdown(data);
This has an ordering problem because you turn the device off before
the unwind of devm_iio_device_register() which removes the userspace
interface.

Avoid that by registering an additional callback using
devm_add_action_or_reset() in probe() (see above.)

With above suggested change you can drop remove() as it won't
have anything to do. also clear out the i2c_set_clientdata()
unless that is used elsewhere.

Thanks,

Jonathan

> +}


