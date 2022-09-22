Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBE9F5E6B1E
	for <lists+linux-iio@lfdr.de>; Thu, 22 Sep 2022 20:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231984AbiIVSkE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 22 Sep 2022 14:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbiIVSkC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 22 Sep 2022 14:40:02 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C85103FA2C
        for <linux-iio@vger.kernel.org>; Thu, 22 Sep 2022 11:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1663871999;
  x=1695407999;
  h=date:to:cc:subject:message-id:references:mime-version:
   content-transfer-encoding:in-reply-to:from;
  bh=OUB2PR5yIZttOiNYYHWuWPavjelX2m3ytWnWZspQAzA=;
  b=eknGD5tUU87yWFzwgXEb2wRSseZcB2xQrc5prEMpCQ3yYKMK1Q+Mgreq
   pRZ5mTZraE4mNkSekqNZPLCucEYexuJkczeeoLygN89LK9kVKe1SBboqB
   J/NPSiW21y815Z6y60+WkhQgreauFiLu2dHhWuseX7ojWsZ0EHyd9mw88
   f0+MAOtRPsAU7WAl1KT+2M3c8KS/7jlUUBc+J6df+vIKhVHjCw6+bPKfQ
   vrQVUr7gkxdTSOpA6SQEHrPEvUvZC8vGaj4dJsNHmMDa2wwchVJBWSB+a
   PREKPlmfpSr/Az+MgMpgei4rBgAt2jDoQNBb7Hjhduv+Zt69z1DzVxxcQ
   g==;
Date:   Thu, 22 Sep 2022 20:39:55 +0200
To:     Paul Cercueil <paul@crapouillou.net>
CC:     =?iso-8859-1?Q?M=E5rten?= Lindahl <Marten.Lindahl@axis.com>,
        "Jonathan Cameron" <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        kernel <kernel@axis.com>
Subject: Re: [PATCH 2/3] iio: light: vcnl4000: Add enable attributes for
 vcnl4040
Message-ID: <Yyyr+4yNbgbCe6lp@axis.com>
References: <20220920180958.2308229-1-marten.lindahl@axis.com>
 <20220920180958.2308229-3-marten.lindahl@axis.com>
 <CU3JIR.R6ZZ1TYIUTVP3@crapouillou.net>
 <Yyxdb6KFxOgb2WGA@axis.com>
 <6E7MIR.YSB8G5DRB84E1@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6E7MIR.YSB8G5DRB84E1@crapouillou.net>
From:   Marten Lindahl <martenli@axis.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Sep 22, 2022 at 04:10:54PM +0200, Paul Cercueil wrote:
> 
> 
> Le jeu., sept. 22 2022 at 15:04:47 +0200, Marten Lindahl 
> <martenli@axis.com> a écrit :
> > On Wed, Sep 21, 2022 at 12:01:24AM +0200, Paul Cercueil wrote:
> >>  Hi Mårten,
> >> 
> >>  Le mar., sept. 20 2022 at 20:09:57 +0200, Mårten Lindahl
> >>  <marten.lindahl@axis.com> a écrit :
> >>  > Add channel attribute in_illuminance_en and in_proximity_en with
> >>  > read/write access for vcnl4040. If automatic runtime power 
> >> management
> >>  > is
> >>  > turned off (power/control = on), both sensors can be kept on or 
> >> off by
> >>  > userspace.
> >> 
> > 
> > Hi Paul!
> > 
> >>  I don't really understand this. If automatic runtime power 
> >> management
> >>  is turned OFF, I would expect both sensors to be kept ON always.
> >> 
> >>  It's not userspace's job to do power management of the chip. Why are
> >>  these channel attributes needed?
> > 
> > I think I understand the problem here. I added the *_en attributes
> > because I couldn't see any way to turn the sensors on without forcing 
> > it
> > on during the *_raw read operation (with 
> > vcnl4000_set_pm_runtime_state(true))
> > after which it is turned off again (false).
> 
> What's wrong with doing that?

Hi!

No, nothing is wrong with that. I was just confused by the fact that
power/control=on didn't have any effect on the device. 

> 
> > Even if the power/control is set to 'on', there will be no callback 
> > for
> > changing the state to active.
> > 
> > It seems this does not work in this driver (with or without my 
> > patches) and I
> > was confused by how it was supposed to work. But after some digging I 
> > suspect
> > there could be a bug in the driver since the sysfs control/* nodes 
> > seems to
> > operate on the indio_dev->dev and not on the driver dev, which is 
> > used for
> > the vcnl4000 driver pm_runtime operations.
> 
> I believe this is normal. The devm_iio_device_alloc() creates a new 
> device, whose parent is your i2c_client->dev.

Ok
> 
> > Setting the power/control to 'on' invokes the rpm_resume function 
> > which
> > checks the dev.power.disable_depth attribute before it calls the
> > resume_callback for setting the active state on the driver. But if the
> > dev.power.disable_depth == 1 (which is the init value) the callback 
> > will not
> > be called. And nothing happens. And I suspect the reason why the
> > dev.power.disable_depth is 1 may be that it is not the vcnl4000 dev
> > object that is being checked, but the indio_dev->dev object, which 
> > has not
> > been configured for pm_runtime operations in the driver.
> > 
> > Sorry for a long reply to your question, but I suspect that if the
> > automatic pm_runtime for this driver can be disabled by the sysfs
> > power/control, the *_en attributes wont be needed.
> > 
> > I will look into why it does not work.
> 
> I still don't understand. Why do you *need* to disable runtime PM?

There is no special reason to disable runtime PM for the usecases we
have. The original reason behind this patch is a local patch from the
4.19 kernel when runtime PM did not exist in the driver. The local
patch added *_en attributes for turning the sensors on/off.

I will gladly skip this patch, since it has come clear to me that it
doesn't bring any value to the current version of the driver. I will
probably look at a fix for the power/control=on problem, but any fix
for that will be a separate patch.

Kind regards
Mårten

> 
> -Paul
> 
> > Kind regards
> > Mårten
> > 
> >> 
> >>  Cheers,
> >>  -Paul
> >> 
> >>  > Signed-off-by: Mårten Lindahl <marten.lindahl@axis.com>
> >>  > ---
> >>  >  drivers/iio/light/vcnl4000.c | 79
> >>  > ++++++++++++++++++++++++++++++++----
> >>  >  1 file changed, 72 insertions(+), 7 deletions(-)
> >>  >
> >>  > diff --git a/drivers/iio/light/vcnl4000.c
> >>  > b/drivers/iio/light/vcnl4000.c
> >>  > index 0b226c684957..9838f0868372 100644
> >>  > --- a/drivers/iio/light/vcnl4000.c
> >>  > +++ b/drivers/iio/light/vcnl4000.c
> >>  > @@ -125,6 +125,9 @@ struct vcnl4000_data {
> >>  >  	enum vcnl4000_device_ids id;
> >>  >  	int rev;
> >>  >  	int al_scale;
> >>  > +	bool als_enable;
> >>  > +	bool ps_enable;
> >>  > +
> >>  >  	const struct vcnl4000_chip_spec *chip_spec;
> >>  >  	struct mutex vcnl4000_lock;
> >>  >  	struct vcnl4200_channel vcnl4200_al;
> >>  > @@ -202,10 +205,13 @@ static ssize_t 
> >> vcnl4000_write_als_enable(struct
> >>  > vcnl4000_data *data, int val)
> >>  >  		if (ret < 0)
> >>  >  			return ret;
> >>  >
> >>  > -		if (val)
> >>  > +		if (val) {
> >>  >  			ret &= ~VCNL4040_ALS_CONF_ALS_SD;
> >>  > -		else
> >>  > +			data->als_enable = true;
> >>  > +		} else {
> >>  >  			ret |= VCNL4040_ALS_CONF_ALS_SD;
> >>  > +			data->als_enable = false;
> >>  > +		}
> >>  >
> >>  >  		return i2c_smbus_write_word_data(data->client, 
> >> VCNL4200_AL_CONF,
> >>  >  						 ret);
> >>  > @@ -225,10 +231,13 @@ static ssize_t 
> >> vcnl4000_write_ps_enable(struct
> >>  > vcnl4000_data *data, int val)
> >>  >  		if (ret < 0)
> >>  >  			return ret;
> >>  >
> >>  > -		if (val)
> >>  > +		if (val) {
> >>  >  			ret &= ~VCNL4040_PS_CONF1_PS_SD;
> >>  > -		else
> >>  > +			data->ps_enable = true;
> >>  > +		} else {
> >>  >  			ret |= VCNL4040_PS_CONF1_PS_SD;
> >>  > +			data->ps_enable = false;
> >>  > +		}
> >>  >
> >>  >  		return i2c_smbus_write_word_data(data->client,
> >>  >  						 VCNL4200_PS_CONF1, ret);
> >>  > @@ -283,6 +292,8 @@ static int vcnl4200_init(struct vcnl4000_data
> >>  > *data)
> >>  >  	dev_dbg(&data->client->dev, "device id 0x%x", id);
> >>  >
> >>  >  	data->rev = (ret >> 8) & 0xf;
> >>  > +	data->als_enable = false;
> >>  > +	data->ps_enable = false;
> >>  >
> >>  >  	data->vcnl4200_al.reg = VCNL4200_AL_DATA;
> >>  >  	data->vcnl4200_ps.reg = VCNL4200_PS_DATA;
> >>  > @@ -459,8 +470,12 @@ static bool 
> >> vcnl4010_is_in_periodic_mode(struct
> >>  > vcnl4000_data *data)
> >>  >  static int vcnl4000_set_pm_runtime_state(struct vcnl4000_data 
> >> *data,
> >>  > bool on)
> >>  >  {
> >>  >  	struct device *dev = &data->client->dev;
> >>  > +	struct iio_dev *indio_dev = i2c_get_clientdata(data->client);
> >>  >  	int ret;
> >>  >
> >>  > +	if (!indio_dev->dev.power.runtime_auto)
> >>  > +		return 0;
> >>  > +
> >>  >  	if (on) {
> >>  >  		ret = pm_runtime_resume_and_get(dev);
> >>  >  	} else {
> >>  > @@ -507,6 +522,38 @@ static int vcnl4000_read_raw(struct iio_dev
> >>  > *indio_dev,
> >>  >  		*val = 0;
> >>  >  		*val2 = data->al_scale;
> >>  >  		return IIO_VAL_INT_PLUS_MICRO;
> >>  > +	case IIO_CHAN_INFO_ENABLE:
> >>  > +		switch (chan->type) {
> >>  > +		case IIO_LIGHT:
> >>  > +			*val = data->als_enable;
> >>  > +			return IIO_VAL_INT;
> >>  > +		case IIO_PROXIMITY:
> >>  > +			*val = data->ps_enable;
> >>  > +			return IIO_VAL_INT;
> >>  > +		default:
> >>  > +			return -EINVAL;
> >>  > +		}
> >>  > +	default:
> >>  > +		return -EINVAL;
> >>  > +	}
> >>  > +}
> >>  > +
> >>  > +static int vcnl4040_write_raw(struct iio_dev *indio_dev,
> >>  > +				struct iio_chan_spec const *chan,
> >>  > +				int val, int val2, long mask)
> >>  > +{
> >>  > +	struct vcnl4000_data *data = iio_priv(indio_dev);
> >>  > +
> >>  > +	switch (mask) {
> >>  > +	case IIO_CHAN_INFO_ENABLE:
> >>  > +		switch (chan->type) {
> >>  > +		case IIO_LIGHT:
> >>  > +			return vcnl4000_write_als_enable(data, val);
> >>  > +		case IIO_PROXIMITY:
> >>  > +			return vcnl4000_write_ps_enable(data, val);
> >>  > +		default:
> >>  > +			return -EINVAL;
> >>  > +		}
> >>  >  	default:
> >>  >  		return -EINVAL;
> >>  >  	}
> >>  > @@ -845,6 +892,19 @@ static const struct iio_chan_spec
> >>  > vcnl4010_channels[] = {
> >>  >  	IIO_CHAN_SOFT_TIMESTAMP(1),
> >>  >  };
> >>  >
> >>  > +static const struct iio_chan_spec vcnl4040_channels[] = {
> >>  > +	{
> >>  > +		.type = IIO_LIGHT,
> >>  > +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> >>  > +			BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_ENABLE),
> >>  > +	}, {
> >>  > +		.type = IIO_PROXIMITY,
> >>  > +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> >>  > +			BIT(IIO_CHAN_INFO_ENABLE),
> >>  > +		.ext_info = vcnl4000_ext_info,
> >>  > +	}
> >>  > +};
> >>  > +
> >>  >  static const struct iio_info vcnl4000_info = {
> >>  >  	.read_raw = vcnl4000_read_raw,
> >>  >  };
> >>  > @@ -859,6 +919,11 @@ static const struct iio_info vcnl4010_info = 
> >> {
> >>  >  	.write_event_config = vcnl4010_write_event_config,
> >>  >  };
> >>  >
> >>  > +static const struct iio_info vcnl4040_info = {
> >>  > +	.read_raw = vcnl4000_read_raw,
> >>  > +	.write_raw = vcnl4040_write_raw,
> >>  > +};
> >>  > +
> >>  >  static const struct vcnl4000_chip_spec vcnl4000_chip_spec_cfg[] 
> >> = {
> >>  >  	[VCNL4000] = {
> >>  >  		.prod = "VCNL4000",
> >>  > @@ -888,9 +953,9 @@ static const struct vcnl4000_chip_spec
> >>  > vcnl4000_chip_spec_cfg[] = {
> >>  >  		.measure_light = vcnl4200_measure_light,
> >>  >  		.measure_proximity = vcnl4200_measure_proximity,
> >>  >  		.set_power_state = vcnl4200_set_power_state,
> >>  > -		.channels = vcnl4000_channels,
> >>  > -		.num_channels = ARRAY_SIZE(vcnl4000_channels),
> >>  > -		.info = &vcnl4000_info,
> >>  > +		.channels = vcnl4040_channels,
> >>  > +		.num_channels = ARRAY_SIZE(vcnl4040_channels),
> >>  > +		.info = &vcnl4040_info,
> >>  >  		.irq_support = false,
> >>  >  	},
> >>  >  	[VCNL4200] = {
> >>  > --
> >>  > 2.30.2
> >>  >
> >> 
> >> 
> 
> 
