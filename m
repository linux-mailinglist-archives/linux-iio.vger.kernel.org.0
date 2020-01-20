Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 682E01430CF
	for <lists+linux-iio@lfdr.de>; Mon, 20 Jan 2020 18:28:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbgATR25 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Mon, 20 Jan 2020 12:28:57 -0500
Received: from hosting.pavoucek.net ([46.28.107.168]:38919 "EHLO
        hosting.pavoucek.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbgATR25 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Jan 2020 12:28:57 -0500
Received: from tomas.local.tbs-biometrics.cz (176-74-132-138.netdatacomm.cz [176.74.132.138])
        (Authenticated sender: tomas@novotny.cz)
        by hosting.pavoucek.net (Postfix) with ESMTPSA id 5672710438F;
        Mon, 20 Jan 2020 18:28:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 hosting.pavoucek.net 5672710438F
Date:   Mon, 20 Jan 2020 18:28:53 +0100
From:   Tomas Novotny <tomas@novotny.cz>
To:     Guido =?UTF-8?B?R8O8bnRoZXI=?= <agx@sigxcpu.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: vncl4000: Enable runtime pm for vcnl4200/4040
Message-ID: <20200120182853.37a724fa@tomas.local.tbs-biometrics.cz>
In-Reply-To: <65d5c7b562f9f7c17857310e8538afe0bb1b2ddb.1579531608.git.agx@sigxcpu.org>
References: <cover.1579531608.git.agx@sigxcpu.org>
        <65d5c7b562f9f7c17857310e8538afe0bb1b2ddb.1579531608.git.agx@sigxcpu.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Guido,

On Mon, 20 Jan 2020 16:01:24 +0100
Guido Günther <agx@sigxcpu.org> wrote:

> This is modelled after the vcnl4035 driver. The vcnl4000 does not seem
> to have a way to save power so we just leave it running.

To be precise - only the on-demand measurement is done for vcnl4000/4010/4020
in this driver (so it is not running in the end). The periodic measurement
(only) is done for vcnl4040/4200.

Note below.

> Signed-off-by: Guido Günther <agx@sigxcpu.org>
> ---
>  drivers/iio/light/vcnl4000.c | 126 +++++++++++++++++++++++++++++++++--
>  1 file changed, 120 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
> index 8f198383626b..b0396a3f1915 100644
> --- a/drivers/iio/light/vcnl4000.c
> +++ b/drivers/iio/light/vcnl4000.c
> @@ -22,6 +22,7 @@
>  #include <linux/i2c.h>
>  #include <linux/err.h>
>  #include <linux/delay.h>
> +#include <linux/pm_runtime.h>
>  
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> @@ -57,6 +58,8 @@
>  #define VCNL4000_AL_OD		BIT(4) /* start on-demand ALS measurement */
>  #define VCNL4000_PS_OD		BIT(3) /* start on-demand proximity measurement */
>  
> +#define VCNL4000_SLEEP_DELAY_MS	2000 /* before we enter pm_runtime_suspend */
> +
>  enum vcnl4000_device_ids {
>  	VCNL4000,
>  	VCNL4010,
> @@ -87,6 +90,7 @@ struct vcnl4000_chip_spec {
>  	int (*init)(struct vcnl4000_data *data);
>  	int (*measure_light)(struct vcnl4000_data *data, int *val);
>  	int (*measure_proximity)(struct vcnl4000_data *data, int *val);
> +	int (*set_power_state)(struct vcnl4000_data *data, bool on);
>  };
>  
>  static const struct i2c_device_id vcnl4000_id[] = {
> @@ -99,6 +103,12 @@ static const struct i2c_device_id vcnl4000_id[] = {
>  };
>  MODULE_DEVICE_TABLE(i2c, vcnl4000_id);
>  
> +static int vcnl4000_set_power_state(struct vcnl4000_data *data, bool on)
> +{
> +	/* no suspend op */
> +	return 0;
> +}
> +
>  static int vcnl4000_init(struct vcnl4000_data *data)
>  {
>  	int ret, prod_id;
> @@ -127,9 +137,24 @@ static int vcnl4000_init(struct vcnl4000_data *data)
>  	data->al_scale = 250000;
>  	mutex_init(&data->vcnl4000_lock);
>  
> +	ret = data->chip_spec->set_power_state(data, true);
> +	if (ret < 0)
> +		return ret;
> +
>  	return 0;
>  };
>  
> +static int vcnl4200_set_power_state(struct vcnl4000_data *data, bool on)
> +{
> +	u16 val = on ? 0 /* power on */ : 1 /* shut down */;
> +	int ret;
> +
> +	ret = i2c_smbus_write_word_data(data->client, VCNL4200_AL_CONF, val);
> +	if (ret < 0)
> +		return ret;
> +	return i2c_smbus_write_word_data(data->client, VCNL4200_PS_CONF1, val);
> +}
> +
>  static int vcnl4200_init(struct vcnl4000_data *data)
>  {
>  	int ret, id;
> @@ -155,11 +180,7 @@ static int vcnl4200_init(struct vcnl4000_data *data)
>  
>  	data->rev = (ret >> 8) & 0xf;
>  
> -	/* Set defaults and enable both channels */
> -	ret = i2c_smbus_write_word_data(data->client, VCNL4200_AL_CONF, 0);
> -	if (ret < 0)
> -		return ret;
> -	ret = i2c_smbus_write_word_data(data->client, VCNL4200_PS_CONF1, 0);
> +	ret = data->chip_spec->set_power_state(data, true);
>  	if (ret < 0)
>  		return ret;
>  
> @@ -291,24 +312,28 @@ static const struct vcnl4000_chip_spec vcnl4000_chip_spec_cfg[] = {
>  		.init = vcnl4000_init,
>  		.measure_light = vcnl4000_measure_light,
>  		.measure_proximity = vcnl4000_measure_proximity,
> +		.set_power_state = vcnl4000_set_power_state,
>  	},
>  	[VCNL4010] = {
>  		.prod = "VCNL4010/4020",
>  		.init = vcnl4000_init,
>  		.measure_light = vcnl4000_measure_light,
>  		.measure_proximity = vcnl4000_measure_proximity,
> +		.set_power_state = vcnl4000_set_power_state,
>  	},
>  	[VCNL4040] = {
>  		.prod = "VCNL4040",
>  		.init = vcnl4200_init,
>  		.measure_light = vcnl4200_measure_light,
>  		.measure_proximity = vcnl4200_measure_proximity,
> +		.set_power_state = vcnl4200_set_power_state,
>  	},
>  	[VCNL4200] = {
>  		.prod = "VCNL4200",
>  		.init = vcnl4200_init,
>  		.measure_light = vcnl4200_measure_light,
>  		.measure_proximity = vcnl4200_measure_proximity,
> +		.set_power_state = vcnl4200_set_power_state,
>  	},
>  };
>  
> @@ -323,6 +348,23 @@ static const struct iio_chan_spec vcnl4000_channels[] = {
>  	}
>  };
>  
> +static int vcnl4000_set_pm_runtime_state(struct vcnl4000_data *data, bool on)
> +{
> +	struct device *dev = &data->client->dev;
> +	int ret;
> +
> +	if (on) {
> +		ret = pm_runtime_get_sync(dev);
> +		if (ret < 0)
> +			pm_runtime_put_noidle(dev);
> +	} else {
> +		pm_runtime_mark_last_busy(dev);
> +		ret = pm_runtime_put_autosuspend(dev);
> +	}
> +
> +	return ret;
> +}
> +
>  static int vcnl4000_read_raw(struct iio_dev *indio_dev,
>  				struct iio_chan_spec const *chan,
>  				int *val, int *val2, long mask)
> @@ -332,6 +374,10 @@ static int vcnl4000_read_raw(struct iio_dev *indio_dev,
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
> +		ret = vcnl4000_set_pm_runtime_state(data, true);
> +		if  (ret < 0)
> +			return ret;
> +
>  		switch (chan->type) {
>  		case IIO_LIGHT:
>  			ret = data->chip_spec->measure_light(data, val);
> @@ -346,6 +392,7 @@ static int vcnl4000_read_raw(struct iio_dev *indio_dev,
>  		default:
>  			ret = -EINVAL;
>  		}
> +		vcnl4000_set_pm_runtime_state(data, false);
>  		return ret;
>  	case IIO_CHAN_INFO_SCALE:
>  		if (chan->type != IIO_LIGHT)
> @@ -394,7 +441,22 @@ static int vcnl4000_probe(struct i2c_client *client,
>  	indio_dev->name = VCNL4000_DRV_NAME;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  
> -	return devm_iio_device_register(&client->dev, indio_dev);
> +	ret = pm_runtime_set_active(&client->dev);
> +	if (ret < 0)
> +		goto fail_poweroff;
> +
> +	ret = iio_device_register(indio_dev);
> +	if (ret < 0)
> +		goto fail_poweroff;
> +
> +	pm_runtime_enable(&client->dev);
> +	pm_runtime_set_autosuspend_delay(&client->dev, VCNL4000_SLEEP_DELAY_MS);
> +	pm_runtime_use_autosuspend(&client->dev);
> +
> +	return 0;
> +fail_poweroff:
> +	data->chip_spec->set_power_state(data, false);
> +	return ret;
>  }
>  
>  static const struct of_device_id vcnl_4000_of_match[] = {
> @@ -422,13 +484,65 @@ static const struct of_device_id vcnl_4000_of_match[] = {
>  };
>  MODULE_DEVICE_TABLE(of, vcnl_4000_of_match);
>  
> +static int vcnl4000_remove(struct i2c_client *client)
> +{
> +	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> +	struct vcnl4000_data *data = iio_priv(indio_dev);
> +
> +	pm_runtime_dont_use_autosuspend(&client->dev);
> +	pm_runtime_disable(&client->dev);
> +	iio_device_unregister(indio_dev);
> +	pm_runtime_set_suspended(&client->dev);
> +
> +	return data->chip_spec->set_power_state(data, false);
> +}
> +
> +static int __maybe_unused vcnl4000_runtime_suspend(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> +	struct vcnl4000_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	ret = data->chip_spec->set_power_state(data, false);
> +
> +	return ret;
> +}
> +
> +static int __maybe_unused vcnl4000_runtime_resume(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> +	struct vcnl4000_data *data = iio_priv(indio_dev);
> +	unsigned int msecs;
> +	int ret;
> +
> +	ret = data->chip_spec->set_power_state(data, true);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* wait for 1 ALS integration cycle */
> +	msecs =  data->vcnl4200_al.sampling_rate ?
> +		ktime_to_ms(data->vcnl4200_al.sampling_rate) : 100;
> +	msleep(ktime_to_ms(msecs));

What about setting the vcnl4200_{al,ps}.last_measurement to ktime_get() in
case of vcnl4040/4200? The sleeping will be handled in the respective channel
during measurement. And it will be much faster if you are interested in
proximity reading only (you will be blocked only for proximity's 4.2ms
instead of 54ms because of ambient light).

The sleeping for vcnl4000 is not needed, as there is currently on-demand
measurement only.

BTW the second ktime_to_ms shouldn't be called.

Tomas

> +	return 0;
> +}
> +
> +static const struct dev_pm_ops vcnl4000_pm_ops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
> +				pm_runtime_force_resume)
> +	SET_RUNTIME_PM_OPS(vcnl4000_runtime_suspend,
> +			   vcnl4000_runtime_resume, NULL)
> +};
> +
>  static struct i2c_driver vcnl4000_driver = {
>  	.driver = {
>  		.name   = VCNL4000_DRV_NAME,
> +		.pm	= &vcnl4000_pm_ops,
>  		.of_match_table = vcnl_4000_of_match,
>  	},
>  	.probe  = vcnl4000_probe,
>  	.id_table = vcnl4000_id,
> +	.remove	= vcnl4000_remove,
>  };
>  
>  module_i2c_driver(vcnl4000_driver);
