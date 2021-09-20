Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD32411524
	for <lists+linux-iio@lfdr.de>; Mon, 20 Sep 2021 15:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236530AbhITNCs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Sep 2021 09:02:48 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:46765 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbhITNCr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Sep 2021 09:02:47 -0400
Received: (Authenticated sender: jacopo@jmondi.org)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 0398BE0007;
        Mon, 20 Sep 2021 13:01:17 +0000 (UTC)
Date:   Mon, 20 Sep 2021 15:02:04 +0200
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Peter Rosin <peda@axentia.se>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Magnus Damm <magnus.damm@gmail.com>, linux-iio@vger.kernel.org,
        Wolfram Sang <wsa@kernel.org>
Subject: Re: [PATCH v5 3/4] iio: chemical: Add Senseair Sunrise 006-0-007
 driver
Message-ID: <20210920130204.2oi7yp5aitzeyqqc@uno.localdomain>
References: <20210909094537.218064-1-jacopo@jmondi.org>
 <20210909094537.218064-4-jacopo@jmondi.org>
 <4a393fb1-1123-a95c-dd6b-8cff4cf0f1db@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4a393fb1-1123-a95c-dd6b-8cff4cf0f1db@axentia.se>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Peter,

On Thu, Sep 09, 2021 at 02:04:31PM +0200, Peter Rosin wrote:
> Hi!
>
> Subject looks wrong, shouldn't it be 006-0-0007?
>
> On 2021-09-09 11:45, Jacopo Mondi wrote:
> > Add support for the Senseair Sunrise 006-0-0007 driver through the
> > IIO subsystem.
> >
> > Datasheet: https://rmtplusstoragesenseair.blob.core.windows.net/docs/Dev/publicerat/TDE5531.pdf
> > Signed-off-by: Jacopo Mondi <jacopo@jmondi.org>
> > ---
> >  MAINTAINERS                        |   7 +
> >  drivers/iio/chemical/Kconfig       |  10 +
> >  drivers/iio/chemical/Makefile      |   1 +
> >  drivers/iio/chemical/sunrise_co2.c | 526 +++++++++++++++++++++++++++++
> >  4 files changed, 544 insertions(+)
> >  create mode 100644 drivers/iio/chemical/sunrise_co2.c
> >
>
> *snip*
>
> > + * the i2c bus.
> > + */
> > +static int sunrise_read_byte(struct sunrise_dev *sunrise, u8 reg)
> > +{
> > +	const struct i2c_client *client = sunrise->client;
> > +	const struct device *dev = &client->dev;
> > +	unsigned int val;
> > +	int ret;
> > +
> > +	i2c_lock_bus(client->adapter, I2C_LOCK_SEGMENT);
> > +	ret = regmap_read(sunrise->regmap, reg, &val);
> > +	i2c_unlock_bus(client->adapter, I2C_LOCK_SEGMENT);
> > +	if (ret) {
> > +		dev_err(dev, "Read byte failed: reg 0x%2x (%d)\n", reg, ret);
>
> Nitpick, %02x looks better methinks ("reg 0x04" vs. "reg 0x 4").
>
> [more instances below]
>

Sure!

> > +		return ret;
> > +	}
> > +
> > +	return val;
> > +}
> > +
> > +static int sunrise_read_word(struct sunrise_dev *sunrise, u8 reg, u16 *val)
> > +{
> > +	const struct i2c_client *client = sunrise->client;
> > +	const struct device *dev = &client->dev;
> > +	__be16 be_val;
> > +	int ret;
> > +
> > +	i2c_lock_bus(client->adapter, I2C_LOCK_SEGMENT);
> > +	ret = regmap_bulk_read(sunrise->regmap, reg, &be_val, sizeof(be_val));
> > +	i2c_unlock_bus(client->adapter, I2C_LOCK_SEGMENT);
> > +	if (ret) {
> > +		dev_err(dev, "Read word failed: reg 0x%2x (%d)\n", reg, ret);
> > +		return ret;
> > +	}
> > +
> > +	*val = be16_to_cpu(be_val);
> > +
> > +	return 0;
> > +}
> > +
> > +static int sunrise_write_byte(struct sunrise_dev *sunrise, u8 reg, u8 val)
> > +{
> > +	const struct i2c_client *client = sunrise->client;
> > +	const struct device *dev = &client->dev;
> > +	int ret;
> > +
> > +	i2c_lock_bus(client->adapter, I2C_LOCK_SEGMENT);
> > +	ret = regmap_write(sunrise->regmap, reg, val);
> > +	i2c_unlock_bus(client->adapter, I2C_LOCK_SEGMENT);
> > +	if (ret)
> > +		dev_err(dev, "Write byte failed: reg 0x%2x (%d)\n", reg, ret);
> > +
> > +	return ret;
> > +}
> > +
> > +static int sunrise_write_word(struct sunrise_dev *sunrise, u8 reg, u16 data)
> > +{
> > +	const struct i2c_client *client = sunrise->client;
> > +	const struct device *dev = &client->dev;
> > +	__be16 be_data = cpu_to_be16(data);
> > +	int ret;
> > +
> > +	i2c_lock_bus(client->adapter, I2C_LOCK_SEGMENT);
> > +	ret = regmap_bulk_write(sunrise->regmap, reg, &be_data, sizeof(be_data));
> > +	i2c_unlock_bus(client->adapter, I2C_LOCK_SEGMENT);
> > +	if (ret)
> > +		dev_err(dev, "Write word failed: reg 0x%2x (%d)\n", reg, ret);
> > +
> > +	return ret;
> > +}
>
> *snip*
>
> > +
> > +static const struct regmap_bus sunrise_regmap_bus = {
> > +	.read = sunrise_regmap_read,
> > +	.write = sunrise_regmap_write,
> > +};
> > +
> > +static const struct regmap_config sunrise_regmap_config = {
> > +	.reg_bits = 8,
> > +	.val_bits = 8,
> > +};
> > +
> > +static int sunrise_probe(struct i2c_client *client)
> > +{
> > +	struct sunrise_dev *sunrise;
> > +	struct iio_dev *iio_dev;
> > +
> > +	iio_dev = devm_iio_device_alloc(&client->dev, sizeof(*sunrise));
> > +	if (!iio_dev)
> > +		return -ENOMEM;
> > +
> > +	sunrise = iio_priv(iio_dev);
> > +	sunrise->client = client;
>
> You should check if the I2C adapter supports the needed operations.
>
> 	if (!i2c_check_functionality(client->adapter,
> 				     I2C_FUNC_SMBUS_BLOCK_DATA |
> 				     I2C_FUNC_SMBUS_BYTE_DATA |
> 				     I2C_FUNC_SMBUS_QUICK |
> 				     I2C_FUNC_PROTOCOL_MANGLING))
> 		...
>
> And, I suspect that protocol mangling might not be the first thing simple
> SMBus-only adapters support?? Maybe you don't lose all that many adapters
> by not using the restart-after-wakeup method, when odd things are required
> anyway? That is, if the device gets enough time to wake up properly using
> that method? (see the message from Andy in the v3 discussion)

So, I've tried to apply the change you suggested in v3

static int sunrise_regmap_read(void *context, const void *reg_buf,
			       size_t reg_size, void *val_buf, size_t val_size)
{
	struct i2c_client *client = context;
	unsigned char reg =  ((char *)reg_buf)[0];
	unsigned char databuf[2];
        struct i2c_msg msg[3] = {
                {       /* wakeup */
                        .addr = client->addr,
                        .flags = I2C_M_RD | I2C_M_IGNORE_NAK,
                        .len = 0,
                }, {    /* write register number */
                        .addr = client->addr,
                        .flags = 0,
                        .len = reg_size,
                        .buf = &reg,
                }, {    /* read register contents */
                        .addr = client->addr,
                        .flags = I2C_M_RD,
                        .len = val_size,
                        .buf = databuf,
                },
        };
	int ret;

	ret = __i2c_transfer(client->adapter, msg, 3);
	if (ret != 3)
		return -EIO;

	memcpy(val_buf, databuf, val_size);

	return 0;

And I get a rather unstable system, ie communications -sometimes-
fail.

This becomes more evident when trying to calibrate, due to register
polling, but also simply reading one of the channels fails randomly.

I blame the chip wakeup time requirement between the wakeup message
and the rest. So unfortunately this version cannot replace the two
separate __i2c_smbu_xfer() calls I have now.

As the wakeup time is not characterized, I'll give it 1 msec even when
using raw __i2c_smbus_xfer() as suggested by Andy.

>
> SMBus quick isn't universal either...

This seems problematic, as I see few adapters support this (might be
the reason why there's no i2c_smbus_quick() helper ?).

I tried using I2C_SMBUS_WRITE in place of I2C_SMBUS_QUICK and the chip
seems to work properly (please not my adapater supports protocol
mangling though)

>
> But hmmm, maybe you don't *really* need protocol mangling when you don't
> check the return value of the wakeup call? At the same time, without
> I2C_M_IGNORE_NAK, you'll perhaps end up with boring entries in the log
> or the adapter doing retries or some other inconvenient crap?

Possibly, but I think it's fine as long as I don't check the error
code ?

>
> You could perhaps set I2C_M_IGNORE_NAK only if the adapter supports
> protocol mangling? Any maybe you don't care about losers who don't have
> a nice enough adapter. :-)

:) I'm on i2c-gpio, so it's all but fancy I guess..

Considering the above in v6 I will:

- Keep the two __i2c_smbu_xfer() calls
- Optional protocol mangling
- usleep_range(500, 1500) between wakup and actual message
- Use I2C_SMBUS_WRITE in place of I2C_SMBUS_QUICK for the wakeup
  message not to rule out too many adapters

Anything wrong with this in your opinion ?

Thanks
  j

>
> Cheers,
> Peter
>
> > +	mutex_init(&sunrise->lock);
> > +
> > +	sunrise->regmap = devm_regmap_init(&client->dev, &sunrise_regmap_bus,
> > +					   client, &sunrise_regmap_config);
> > +	if (IS_ERR(sunrise->regmap)) {
> > +		dev_err(&client->dev, "Failed to initialize regmap\n");
> > +		return PTR_ERR(sunrise->regmap);
> > +	}
> > +
> > +	iio_dev->info = &sunrise_info;
> > +	iio_dev->name = DRIVER_NAME;
> > +	iio_dev->channels = sunrise_channels;
> > +	iio_dev->num_channels = ARRAY_SIZE(sunrise_channels);
> > +	iio_dev->modes = INDIO_DIRECT_MODE;
> > +
> > +	return devm_iio_device_register(&client->dev, iio_dev);
> > +}
> > +
> > +static const struct of_device_id sunrise_of_match[] = {
> > +	{ .compatible = "senseair,sunrise-006-0-0007" },
> > +	{}
> > +};
> > +MODULE_DEVICE_TABLE(of, sunrise_of_match);
> > +
> > +static struct i2c_driver sunrise_driver = {
> > +	.driver = {
> > +		.name = DRIVER_NAME,
> > +		.of_match_table = sunrise_of_match,
> > +	},
> > +	.probe_new = sunrise_probe,
> > +};
> > +module_i2c_driver(sunrise_driver);
> > +
> > +MODULE_AUTHOR("Jacopo Mondi <jacopo@jmondi.org>");
> > +MODULE_DESCRIPTION("Senseair Sunrise 006-0-0007 CO2 sensor IIO driver");
> > +MODULE_LICENSE("GPL v2");
> > --
> > 2.32.0
> >
