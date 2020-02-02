Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9BB14FF34
	for <lists+linux-iio@lfdr.de>; Sun,  2 Feb 2020 22:17:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbgBBVRn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 2 Feb 2020 16:17:43 -0500
Received: from honk.sigxcpu.org ([24.134.29.49]:59242 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726967AbgBBVRn (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 2 Feb 2020 16:17:43 -0500
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 1119CFB04;
        Sun,  2 Feb 2020 22:17:41 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id gTUT2lDnnoBF; Sun,  2 Feb 2020 22:17:38 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id BEBFB400E9; Sun,  2 Feb 2020 18:58:51 +0100 (CET)
Date:   Sun, 2 Feb 2020 18:58:51 +0100
From:   Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Tomas Novotny <tomas@novotny.cz>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: vncl4000: Enable runtime pm for vcnl4200/4040
Message-ID: <20200202175851.GA27766@bogon.m.sigxcpu.org>
References: <cover.1580391472.git.agx@sigxcpu.org>
 <237488ddf8f2707e905164c0ec81a7979f1fa9a9.1580391472.git.agx@sigxcpu.org>
 <20200202093408.26bc63b8@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200202093408.26bc63b8@archlinux>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,
On Sun, Feb 02, 2020 at 09:34:08AM +0000, Jonathan Cameron wrote:
> On Thu, 30 Jan 2020 14:42:36 +0100
> Guido Günther <agx@sigxcpu.org> wrote:
> 
> > This is modelled after the vcnl4035 driver. For the vcnl40{0,1,2}0
> > we don't do anything since they use on demand measurement.
> > 
> > Signed-off-by: Guido Günther <agx@sigxcpu.org>
> Hi Guido,
> 
> A few minor things inline, but otherwise looks good to me.
> 
> Thanks,
> 
> Jonathan
> 
> > ---
> >  drivers/iio/light/vcnl4000.c | 135 ++++++++++++++++++++++++++++++++---
> >  1 file changed, 124 insertions(+), 11 deletions(-)
> > 
> > diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
> > index 8f198383626b..1395875d9553 100644
> > --- a/drivers/iio/light/vcnl4000.c
> > +++ b/drivers/iio/light/vcnl4000.c
> > @@ -22,6 +22,7 @@
> >  #include <linux/i2c.h>
> >  #include <linux/err.h>
> >  #include <linux/delay.h>
> > +#include <linux/pm_runtime.h>
> >  
> >  #include <linux/iio/iio.h>
> >  #include <linux/iio/sysfs.h>
> > @@ -57,6 +58,8 @@
> >  #define VCNL4000_AL_OD		BIT(4) /* start on-demand ALS measurement */
> >  #define VCNL4000_PS_OD		BIT(3) /* start on-demand proximity measurement */
> >  
> > +#define VCNL4000_SLEEP_DELAY_MS	2000 /* before we enter pm_runtime_suspend */
> > +
> >  enum vcnl4000_device_ids {
> >  	VCNL4000,
> >  	VCNL4010,
> > @@ -87,6 +90,7 @@ struct vcnl4000_chip_spec {
> >  	int (*init)(struct vcnl4000_data *data);
> >  	int (*measure_light)(struct vcnl4000_data *data, int *val);
> >  	int (*measure_proximity)(struct vcnl4000_data *data, int *val);
> > +	int (*set_power_state)(struct vcnl4000_data *data, bool on);
> >  };
> >  
> >  static const struct i2c_device_id vcnl4000_id[] = {
> > @@ -99,6 +103,12 @@ static const struct i2c_device_id vcnl4000_id[] = {
> >  };
> >  MODULE_DEVICE_TABLE(i2c, vcnl4000_id);
> >  
> > +static int vcnl4000_set_power_state(struct vcnl4000_data *data, bool on)
> > +{
> > +	/* no suspend op */
> > +	return 0;
> > +}
> > +
> >  static int vcnl4000_init(struct vcnl4000_data *data)
> >  {
> >  	int ret, prod_id;
> > @@ -127,9 +137,31 @@ static int vcnl4000_init(struct vcnl4000_data *data)
> >  	data->al_scale = 250000;
> >  	mutex_init(&data->vcnl4000_lock);
> >  
> > +	ret = data->chip_spec->set_power_state(data, true);
> > +	if (ret < 0)
> > +		return ret;
> > +
> >  	return 0;
> >  };
> >  
> > +static int vcnl4200_set_power_state(struct vcnl4000_data *data, bool on)
> > +{
> > +	u16 val = on ? 0 /* power on */ : 1 /* shut down */;
> > +	int ret;
> > +
> > +	ret = i2c_smbus_write_word_data(data->client, VCNL4200_AL_CONF, val);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	return i2c_smbus_write_word_data(data->client, VCNL4200_PS_CONF1, val);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	/* Wait at least one integration cycle before fetching data */
> > +	data->vcnl4200_al.last_measurement = ktime_get();
> > +	data->vcnl4200_ps.last_measurement = ktime_get();
> 
> Hmm.  Feels like these only really make sense if we are turning on?
> They may do no harm in the off path, but better if the code makes
> it clear they are irrelevant in that path.

You're right, it doesn't matter in the off path but it's clearer when
only doing it in the 'on' path.

> No return value.

Duh, wonder why gcc didn't warn about that.

> 
> i.e. return 0;
> > +}
> > +
> >  static int vcnl4200_init(struct vcnl4000_data *data)
> >  {
> >  	int ret, id;
> > @@ -155,14 +187,6 @@ static int vcnl4200_init(struct vcnl4000_data *data)
> >  
> >  	data->rev = (ret >> 8) & 0xf;
> >  
> > -	/* Set defaults and enable both channels */
> > -	ret = i2c_smbus_write_word_data(data->client, VCNL4200_AL_CONF, 0);
> > -	if (ret < 0)
> > -		return ret;
> > -	ret = i2c_smbus_write_word_data(data->client, VCNL4200_PS_CONF1, 0);
> > -	if (ret < 0)
> > -		return ret;
> > -
> >  	data->vcnl4200_al.reg = VCNL4200_AL_DATA;
> >  	data->vcnl4200_ps.reg = VCNL4200_PS_DATA;
> >  	switch (id) {
> > @@ -180,11 +204,13 @@ static int vcnl4200_init(struct vcnl4000_data *data)
> >  		data->al_scale = 120000;
> >  		break;
> >  	}
> > -	data->vcnl4200_al.last_measurement = ktime_set(0, 0);
> > -	data->vcnl4200_ps.last_measurement = ktime_set(0, 0);
> >  	mutex_init(&data->vcnl4200_al.lock);
> >  	mutex_init(&data->vcnl4200_ps.lock);
> >  
> > +	ret = data->chip_spec->set_power_state(data, true);
> > +	if (ret < 0)
> > +		return ret;
> > +
> >  	return 0;
> >  };
> >  
> > @@ -291,24 +317,28 @@ static const struct vcnl4000_chip_spec vcnl4000_chip_spec_cfg[] = {
> >  		.init = vcnl4000_init,
> >  		.measure_light = vcnl4000_measure_light,
> >  		.measure_proximity = vcnl4000_measure_proximity,
> > +		.set_power_state = vcnl4000_set_power_state,
> >  	},
> >  	[VCNL4010] = {
> >  		.prod = "VCNL4010/4020",
> >  		.init = vcnl4000_init,
> >  		.measure_light = vcnl4000_measure_light,
> >  		.measure_proximity = vcnl4000_measure_proximity,
> > +		.set_power_state = vcnl4000_set_power_state,
> >  	},
> >  	[VCNL4040] = {
> >  		.prod = "VCNL4040",
> >  		.init = vcnl4200_init,
> >  		.measure_light = vcnl4200_measure_light,
> >  		.measure_proximity = vcnl4200_measure_proximity,
> > +		.set_power_state = vcnl4200_set_power_state,
> >  	},
> >  	[VCNL4200] = {
> >  		.prod = "VCNL4200",
> >  		.init = vcnl4200_init,
> >  		.measure_light = vcnl4200_measure_light,
> >  		.measure_proximity = vcnl4200_measure_proximity,
> > +		.set_power_state = vcnl4200_set_power_state,
> >  	},
> >  };
> >  
> > @@ -323,6 +353,23 @@ static const struct iio_chan_spec vcnl4000_channels[] = {
> >  	}
> >  };
> >  
> > +static int vcnl4000_set_pm_runtime_state(struct vcnl4000_data *data, bool on)
> > +{
> > +	struct device *dev = &data->client->dev;
> > +	int ret;
> > +
> > +	if (on) {
> > +		ret = pm_runtime_get_sync(dev);
> > +		if (ret < 0)
> > +			pm_runtime_put_noidle(dev);
> > +	} else {
> > +		pm_runtime_mark_last_busy(dev);
> > +		ret = pm_runtime_put_autosuspend(dev);
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> >  static int vcnl4000_read_raw(struct iio_dev *indio_dev,
> >  				struct iio_chan_spec const *chan,
> >  				int *val, int *val2, long mask)
> > @@ -332,6 +379,10 @@ static int vcnl4000_read_raw(struct iio_dev *indio_dev,
> >  
> >  	switch (mask) {
> >  	case IIO_CHAN_INFO_RAW:
> > +		ret = vcnl4000_set_pm_runtime_state(data, true);
> > +		if  (ret < 0)
> > +			return ret;
> > +
> >  		switch (chan->type) {
> >  		case IIO_LIGHT:
> >  			ret = data->chip_spec->measure_light(data, val);
> > @@ -346,6 +397,7 @@ static int vcnl4000_read_raw(struct iio_dev *indio_dev,
> >  		default:
> >  			ret = -EINVAL;
> >  		}
> > +		vcnl4000_set_pm_runtime_state(data, false);
> >  		return ret;
> >  	case IIO_CHAN_INFO_SCALE:
> >  		if (chan->type != IIO_LIGHT)
> > @@ -394,7 +446,22 @@ static int vcnl4000_probe(struct i2c_client *client,
> >  	indio_dev->name = VCNL4000_DRV_NAME;
> >  	indio_dev->modes = INDIO_DIRECT_MODE;
> >  
> > -	return devm_iio_device_register(&client->dev, indio_dev);
> > +	ret = pm_runtime_set_active(&client->dev);
> > +	if (ret < 0)
> > +		goto fail_poweroff;
> > +
> > +	ret = iio_device_register(indio_dev);
> > +	if (ret < 0)
> > +		goto fail_poweroff;
> > +
> > +	pm_runtime_enable(&client->dev);
> > +	pm_runtime_set_autosuspend_delay(&client->dev, VCNL4000_SLEEP_DELAY_MS);
> > +	pm_runtime_use_autosuspend(&client->dev);
> > +
> > +	return 0;
> > +fail_poweroff:
> > +	data->chip_spec->set_power_state(data, false);
> > +	return ret;
> >  }
> >  
> >  static const struct of_device_id vcnl_4000_of_match[] = {
> > @@ -422,13 +489,59 @@ static const struct of_device_id vcnl_4000_of_match[] = {
> >  };
> >  MODULE_DEVICE_TABLE(of, vcnl_4000_of_match);
> >  
> > +static int vcnl4000_remove(struct i2c_client *client)
> > +{
> > +	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> > +	struct vcnl4000_data *data = iio_priv(indio_dev);
> > +
> > +	pm_runtime_dont_use_autosuspend(&client->dev);
> > +	pm_runtime_disable(&client->dev);
> > +	iio_device_unregister(indio_dev);
> > +	pm_runtime_set_suspended(&client->dev);
> > +
> > +	return data->chip_spec->set_power_state(data, false);
> > +}
> > +
> > +static int __maybe_unused vcnl4000_runtime_suspend(struct device *dev)
> > +{
> > +	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> > +	struct vcnl4000_data *data = iio_priv(indio_dev);
> > +	int ret;
> > +
> > +	ret = data->chip_spec->set_power_state(data, false);
> > +
> > +	return ret;
> 
> 	return data->chip_spec...
> 
> > +}
> > +
> > +static int __maybe_unused vcnl4000_runtime_resume(struct device *dev)
> > +{
> > +	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> > +	struct vcnl4000_data *data = iio_priv(indio_dev);
> > +	int ret;
> > +
> > +	ret = data->chip_spec->set_power_state(data, true);
> > +	if (ret < 0)
> > +		return ret;
> 
> I would define the set_power_state callback to return only < 0 for error
> and 0 for no error.  (already true).
> 
> then
> 
> return data->chip_spec->set_power_state(data, true);

Both returns simplified and also the one in vcnl4000_init.

Thanks for having a look,
 -- Guido

> 
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct dev_pm_ops vcnl4000_pm_ops = {
> > +	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
> > +				pm_runtime_force_resume)
> > +	SET_RUNTIME_PM_OPS(vcnl4000_runtime_suspend,
> > +			   vcnl4000_runtime_resume, NULL)
> > +};
> > +
> >  static struct i2c_driver vcnl4000_driver = {
> >  	.driver = {
> >  		.name   = VCNL4000_DRV_NAME,
> > +		.pm	= &vcnl4000_pm_ops,
> >  		.of_match_table = vcnl_4000_of_match,
> >  	},
> >  	.probe  = vcnl4000_probe,
> >  	.id_table = vcnl4000_id,
> > +	.remove	= vcnl4000_remove,
> >  };
> >  
> >  module_i2c_driver(vcnl4000_driver);
> 
