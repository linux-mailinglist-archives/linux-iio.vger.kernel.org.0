Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB55E1558A2
	for <lists+linux-iio@lfdr.de>; Fri,  7 Feb 2020 14:40:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbgBGNkx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 7 Feb 2020 08:40:53 -0500
Received: from hosting.pavoucek.net ([46.28.107.168]:45207 "EHLO
        hosting.pavoucek.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbgBGNkx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 7 Feb 2020 08:40:53 -0500
Received: from tomas.local.tbs-biometrics.cz (176-74-132-138.netdatacomm.cz [176.74.132.138])
        (Authenticated sender: tomas@novotny.cz)
        by hosting.pavoucek.net (Postfix) with ESMTPSA id 2C91C1010E5;
        Fri,  7 Feb 2020 14:40:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 hosting.pavoucek.net 2C91C1010E5
Date:   Fri, 7 Feb 2020 14:40:49 +0100
From:   Tomas Novotny <tomas@novotny.cz>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Angus Ainslie <angus@akkea.ca>,
        Thomas Gleixner <tglx@linutronix.de>,
        Guido =?UTF-8?B?R8O8bnRoZXI=?= <agx@sigxcpu.org>
Subject: Re: [PATCH 1/5] iio: light: vcnl4000: convert to regmap
Message-ID: <20200207144049.0f502211@tomas.local.tbs-biometrics.cz>
In-Reply-To: <20200205114606.ydjtyeivc67hewqb@pengutronix.de>
References: <20200205101655.11728-1-tomas@novotny.cz>
        <20200205101655.11728-2-tomas@novotny.cz>
        <20200205114606.ydjtyeivc67hewqb@pengutronix.de>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Marco,

On Wed, 5 Feb 2020 12:46:07 +0100
Marco Felsch <m.felsch@pengutronix.de> wrote:

> Hi Tomas,
> 
> thanks for the patche =) Pls. check my comments I made inline.
> 
> On 20-02-05 11:16, Tomas Novotny wrote:
> > It will be easier to configure various device registers.
> > 
> > No functional change.  
> 
> Yeah.. should we be more verbose here? Regmap also abstracts the locking
> mechanism, provides caches and more..

I used a bit misleading wording. I meant that there are no other features
except the regmap (which should be implicit). Also the bare minimum is
configured in regmap. I will change in v2.

> > Signed-off-by: Tomas Novotny <tomas@novotny.cz>
> > ---
> >  drivers/iio/light/Kconfig    |  1 +
> >  drivers/iio/light/vcnl4000.c | 59 ++++++++++++++++++++++++++++++--------------
> >  2 files changed, 42 insertions(+), 18 deletions(-)
> > 
> > diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
> > index 4a1a883dc061..ae2b9dafb9f6 100644
> > --- a/drivers/iio/light/Kconfig
> > +++ b/drivers/iio/light/Kconfig
> > @@ -475,6 +475,7 @@ config US5182D
> >  config VCNL4000
> >  	tristate "VCNL4000/4010/4020/4200 combined ALS and proximity sensor"
> >  	depends on I2C
> > +	select REGMAP_I2C  
> 
> We can drop the 'depends on I2C' here.

I'm not sure. I'd say that it protects the situation when I2C isn't selected
(thus REGMAP_I2C alone would be wrongly selected). Besides of that, every
other IIO driver in the ligth/ has it, so I would let it as is because of
consistency (or fix all in a separated change).

> >  	help
> >  	  Say Y here if you want to build a driver for the Vishay VCNL4000,
> >  	  VCNL4010, VCNL4020, VCNL4200 combined ambient light and proximity
> > diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
> > index e5b00a6611ac..9f673e89084a 100644
> > --- a/drivers/iio/light/vcnl4000.c
> > +++ b/drivers/iio/light/vcnl4000.c
> > @@ -22,6 +22,7 @@
> >  #include <linux/i2c.h>
> >  #include <linux/err.h>
> >  #include <linux/delay.h>
> > +#include <linux/regmap.h>
> >  
> >  #include <linux/iio/iio.h>
> >  #include <linux/iio/sysfs.h>
> > @@ -73,6 +74,7 @@ struct vcnl4200_channel {
> >  
> >  struct vcnl4000_data {
> >  	struct i2c_client *client;  
> 
> Can we drop the 'struct i2c_client' here?

Nice catch. I can get the device struct for dev_* functions from regmap. So
yes, I will drop it.

> > +	struct regmap *regmap;
> >  	enum vcnl4000_device_ids id;
> >  	int rev;
> >  	int al_scale;
> > @@ -84,6 +86,7 @@ struct vcnl4000_data {
> >  
> >  struct vcnl4000_chip_spec {
> >  	const char *prod;
> > +	const struct regmap_config *regmap_config;
> >  	int (*init)(struct vcnl4000_data *data);
> >  	int (*measure_light)(struct vcnl4000_data *data, int *val);
> >  	int (*measure_proximity)(struct vcnl4000_data *data, int *val);
> > @@ -99,15 +102,27 @@ static const struct i2c_device_id vcnl4000_id[] = {
> >  };
> >  MODULE_DEVICE_TABLE(i2c, vcnl4000_id);
> >  
> > +static const struct regmap_config vcnl4000_regmap_config = {
> > +	.reg_bits = 8,
> > +	.val_bits = 8,
> > +};
> > +
> > +static const struct regmap_config vcnl4200_regmap_config = {
> > +	.reg_bits = 8,
> > +	.val_bits = 16,
> > +	.val_format_endian = REGMAP_ENDIAN_LITTLE,
> > +};  
> 
> We should be more precise here, e.g. add write/reable ranges, specify
> cache mechanism and so on..

That's a point I was also thinking of. I've selected limited usage as the
regmap is used solely in this file and the addresses are fixed. The cache is
not selected because the vast majority of accesses would bypass the cache
(the sensor readings). There would be only a few cache hits during
configuration.

That may change in the near future (I saw that PM was already added), so I
would extend when needed. What do you think?

> >  static int vcnl4000_init(struct vcnl4000_data *data)
> >  {
> >  	int ret, prod_id;
> > +	unsigned int val;
> >  
> > -	ret = i2c_smbus_read_byte_data(data->client, VCNL4000_PROD_REV);
> > +	ret = regmap_read(data->regmap, VCNL4000_PROD_REV, &val);  
> 
> Should we use the reg_field mechanism here so we can avoid the shifting
> and so on.

Yes, you are right, I will use it in v2.

> >  	if (ret < 0)
> >  		return ret;
> >  
> > -	prod_id = ret >> 4;
> > +	prod_id = val >> 4;
> >  	switch (prod_id) {
> >  	case VCNL4000_PROD_ID:
> >  		if (data->id != VCNL4000)
> > @@ -123,7 +138,7 @@ static int vcnl4000_init(struct vcnl4000_data *data)
> >  		return -ENODEV;
> >  	}
> >  
> > -	data->rev = ret & 0xf;
> > +	data->rev = val & 0xf;
> >  	data->al_scale = 250000;
> >  	mutex_init(&data->vcnl4000_lock);  
> 
> We can remove the lock if it is used to protect the hw-access.

That lock protects the whole reading (i.e. establish, wait for result and
then return), so it is still necessary.

> > @@ -133,19 +148,20 @@ static int vcnl4000_init(struct vcnl4000_data *data)
> >  static int vcnl4200_init(struct vcnl4000_data *data)
> >  {
> >  	int ret, id;
> > +	unsigned int val;
> >  
> > -	ret = i2c_smbus_read_word_data(data->client, VCNL4200_DEV_ID);
> > +	ret = regmap_read(data->regmap, VCNL4200_DEV_ID, &val);  
> 
> Same here, we can use the reg_field to avoid bit ops later on.

Yes.

Thanks a lot for the review,

Tomas

> Regards,
>   Marco
> 
> >  	if (ret < 0)
> >  		return ret;
> >  
> > -	id = ret & 0xff;
> > +	id = val & 0xff;
> >  
> >  	if (id != VCNL4200_PROD_ID) {
> > -		ret = i2c_smbus_read_word_data(data->client, VCNL4040_DEV_ID);
> > +		ret = regmap_read(data->regmap, VCNL4040_DEV_ID, &val);
> >  		if (ret < 0)
> >  			return ret;
> >  
> > -		id = ret & 0xff;
> > +		id = val & 0xff;
> >  
> >  		if (id != VCNL4040_PROD_ID)
> >  			return -ENODEV;
> > @@ -156,10 +172,10 @@ static int vcnl4200_init(struct vcnl4000_data *data)
> >  	data->rev = (ret >> 8) & 0xf;
> >  
> >  	/* Set defaults and enable both channels */
> > -	ret = i2c_smbus_write_word_data(data->client, VCNL4200_AL_CONF, 0);
> > +	ret = regmap_write(data->regmap, VCNL4200_AL_CONF, 0);
> >  	if (ret < 0)
> >  		return ret;
> > -	ret = i2c_smbus_write_word_data(data->client, VCNL4200_PS_CONF1, 0);
> > +	ret = regmap_write(data->regmap, VCNL4200_PS_CONF1, 0);
> >  	if (ret < 0)
> >  		return ret;
> >  
> > @@ -193,22 +209,22 @@ static int vcnl4000_measure(struct vcnl4000_data *data, u8 req_mask,
> >  				u8 rdy_mask, u8 data_reg, int *val)
> >  {
> >  	int tries = 20;
> > +	unsigned int status;
> >  	__be16 buf;
> >  	int ret;
> >  
> >  	mutex_lock(&data->vcnl4000_lock);
> >  
> > -	ret = i2c_smbus_write_byte_data(data->client, VCNL4000_COMMAND,
> > -					req_mask);
> > +	ret = regmap_write(data->regmap, VCNL4000_COMMAND, req_mask);
> >  	if (ret < 0)
> >  		goto fail;
> >  
> >  	/* wait for data to become ready */
> >  	while (tries--) {
> > -		ret = i2c_smbus_read_byte_data(data->client, VCNL4000_COMMAND);
> > +		ret = regmap_read(data->regmap, VCNL4000_COMMAND, &status);
> >  		if (ret < 0)
> >  			goto fail;
> > -		if (ret & rdy_mask)
> > +		if (status & rdy_mask)
> >  			break;
> >  		msleep(20); /* measurement takes up to 100 ms */
> >  	}
> > @@ -220,8 +236,8 @@ static int vcnl4000_measure(struct vcnl4000_data *data, u8 req_mask,
> >  		goto fail;
> >  	}
> >  
> > -	ret = i2c_smbus_read_i2c_block_data(data->client,
> > -		data_reg, sizeof(buf), (u8 *) &buf);
> > +	ret = regmap_bulk_read(data->regmap,
> > +			data_reg, (u8 *) &buf, sizeof(buf));
> >  	if (ret < 0)
> >  		goto fail;
> >  
> > @@ -253,12 +269,10 @@ static int vcnl4200_measure(struct vcnl4000_data *data,
> >  
> >  	mutex_unlock(&chan->lock);
> >  
> > -	ret = i2c_smbus_read_word_data(data->client, chan->reg);
> > +	ret = regmap_read(data->regmap, chan->reg, val);
> >  	if (ret < 0)
> >  		return ret;
> >  
> > -	*val = ret;
> > -
> >  	return 0;
> >  }
> >  
> > @@ -289,24 +303,28 @@ static int vcnl4200_measure_proximity(struct vcnl4000_data *data, int *val)
> >  static const struct vcnl4000_chip_spec vcnl4000_chip_spec_cfg[] = {
> >  	[VCNL4000] = {
> >  		.prod = "VCNL4000",
> > +		.regmap_config = &vcnl4000_regmap_config,
> >  		.init = vcnl4000_init,
> >  		.measure_light = vcnl4000_measure_light,
> >  		.measure_proximity = vcnl4000_measure_proximity,
> >  	},
> >  	[VCNL4010] = {
> >  		.prod = "VCNL4010/4020",
> > +		.regmap_config = &vcnl4000_regmap_config,
> >  		.init = vcnl4000_init,
> >  		.measure_light = vcnl4000_measure_light,
> >  		.measure_proximity = vcnl4000_measure_proximity,
> >  	},
> >  	[VCNL4040] = {
> >  		.prod = "VCNL4040",
> > +		.regmap_config = &vcnl4200_regmap_config,
> >  		.init = vcnl4200_init,
> >  		.measure_light = vcnl4200_measure_light,
> >  		.measure_proximity = vcnl4200_measure_proximity,
> >  	},
> >  	[VCNL4200] = {
> >  		.prod = "VCNL4200",
> > +		.regmap_config = &vcnl4200_regmap_config,
> >  		.init = vcnl4200_init,
> >  		.measure_light = vcnl4200_measure_light,
> >  		.measure_proximity = vcnl4200_measure_proximity,
> > @@ -380,6 +398,11 @@ static int vcnl4000_probe(struct i2c_client *client,
> >  	data->id = id->driver_data;
> >  	data->chip_spec = &vcnl4000_chip_spec_cfg[data->id];
> >  
> > +	data->regmap = devm_regmap_init_i2c(client,
> > +			data->chip_spec->regmap_config);
> > +	if (IS_ERR(data->regmap))
> > +		return PTR_ERR(data->regmap);
> > +
> >  	ret = data->chip_spec->init(data);
> >  	if (ret < 0)
> >  		return ret;
> > -- 
> > 2.16.4  
> 
