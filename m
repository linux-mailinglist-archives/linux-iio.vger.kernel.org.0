Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 032CB5E64CC
	for <lists+linux-iio@lfdr.de>; Thu, 22 Sep 2022 16:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231941AbiIVOLn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 22 Sep 2022 10:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231939AbiIVOLU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 22 Sep 2022 10:11:20 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10CDC86FD5
        for <linux-iio@vger.kernel.org>; Thu, 22 Sep 2022 07:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1663855863; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AFh+WvwUlM7XpdNL2aSXYl8sVEEfsYyCTqt7KsLGIFU=;
        b=Iy3t8X/fAxxMmGqZPTH2LSf1JRKYKPGB92jT9CP5RJuT2A6EwiHTokivj0l9XfD4UQ86tv
        lqxPWwyxh9IXLuvxl04Ni4fkDA3nG1LC4TyJGFZxSQWhIi88HwQ1+VFpcIn4Rtt2h5QMbs
        v/QfvLlS8h0YylNzdXYhSzaj8a/aJ2E=
Date:   Thu, 22 Sep 2022 15:10:54 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 2/3] iio: light: vcnl4000: Add enable attributes for
 vcnl4040
To:     Marten Lindahl <martenli@axis.com>
Cc:     =?iso-8859-1?q?M=E5rten?= Lindahl <Marten.Lindahl@axis.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Uwe =?iso-8859-1?q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-iio@vger.kernel.org,
        kernel <kernel@axis.com>
Message-Id: <6E7MIR.YSB8G5DRB84E1@crapouillou.net>
In-Reply-To: <Yyxdb6KFxOgb2WGA@axis.com>
References: <20220920180958.2308229-1-marten.lindahl@axis.com>
        <20220920180958.2308229-3-marten.lindahl@axis.com>
        <CU3JIR.R6ZZ1TYIUTVP3@crapouillou.net> <Yyxdb6KFxOgb2WGA@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



Le jeu., sept. 22 2022 at 15:04:47 +0200, Marten Lindahl=20
<martenli@axis.com> a =E9crit :
> On Wed, Sep 21, 2022 at 12:01:24AM +0200, Paul Cercueil wrote:
>>  Hi M=E5rten,
>>=20
>>  Le mar., sept. 20 2022 at 20:09:57 +0200, M=E5rten Lindahl
>>  <marten.lindahl@axis.com> a =E9crit :
>>  > Add channel attribute in_illuminance_en and in_proximity_en with
>>  > read/write access for vcnl4040. If automatic runtime power=20
>> management
>>  > is
>>  > turned off (power/control =3D on), both sensors can be kept on or=20
>> off by
>>  > userspace.
>>=20
>=20
> Hi Paul!
>=20
>>  I don't really understand this. If automatic runtime power=20
>> management
>>  is turned OFF, I would expect both sensors to be kept ON always.
>>=20
>>  It's not userspace's job to do power management of the chip. Why are
>>  these channel attributes needed?
>=20
> I think I understand the problem here. I added the *_en attributes
> because I couldn't see any way to turn the sensors on without forcing=20
> it
> on during the *_raw read operation (with=20
> vcnl4000_set_pm_runtime_state(true))
> after which it is turned off again (false).

What's wrong with doing that?

> Even if the power/control is set to 'on', there will be no callback=20
> for
> changing the state to active.
>=20
> It seems this does not work in this driver (with or without my=20
> patches) and I
> was confused by how it was supposed to work. But after some digging I=20
> suspect
> there could be a bug in the driver since the sysfs control/* nodes=20
> seems to
> operate on the indio_dev->dev and not on the driver dev, which is=20
> used for
> the vcnl4000 driver pm_runtime operations.

I believe this is normal. The devm_iio_device_alloc() creates a new=20
device, whose parent is your i2c_client->dev.

> Setting the power/control to 'on' invokes the rpm_resume function=20
> which
> checks the dev.power.disable_depth attribute before it calls the
> resume_callback for setting the active state on the driver. But if the
> dev.power.disable_depth =3D=3D 1 (which is the init value) the callback=20
> will not
> be called. And nothing happens. And I suspect the reason why the
> dev.power.disable_depth is 1 may be that it is not the vcnl4000 dev
> object that is being checked, but the indio_dev->dev object, which=20
> has not
> been configured for pm_runtime operations in the driver.
>=20
> Sorry for a long reply to your question, but I suspect that if the
> automatic pm_runtime for this driver can be disabled by the sysfs
> power/control, the *_en attributes wont be needed.
>=20
> I will look into why it does not work.

I still don't understand. Why do you *need* to disable runtime PM?

-Paul

> Kind regards
> M=E5rten
>=20
>>=20
>>  Cheers,
>>  -Paul
>>=20
>>  > Signed-off-by: M=E5rten Lindahl <marten.lindahl@axis.com>
>>  > ---
>>  >  drivers/iio/light/vcnl4000.c | 79
>>  > ++++++++++++++++++++++++++++++++----
>>  >  1 file changed, 72 insertions(+), 7 deletions(-)
>>  >
>>  > diff --git a/drivers/iio/light/vcnl4000.c
>>  > b/drivers/iio/light/vcnl4000.c
>>  > index 0b226c684957..9838f0868372 100644
>>  > --- a/drivers/iio/light/vcnl4000.c
>>  > +++ b/drivers/iio/light/vcnl4000.c
>>  > @@ -125,6 +125,9 @@ struct vcnl4000_data {
>>  >  	enum vcnl4000_device_ids id;
>>  >  	int rev;
>>  >  	int al_scale;
>>  > +	bool als_enable;
>>  > +	bool ps_enable;
>>  > +
>>  >  	const struct vcnl4000_chip_spec *chip_spec;
>>  >  	struct mutex vcnl4000_lock;
>>  >  	struct vcnl4200_channel vcnl4200_al;
>>  > @@ -202,10 +205,13 @@ static ssize_t=20
>> vcnl4000_write_als_enable(struct
>>  > vcnl4000_data *data, int val)
>>  >  		if (ret < 0)
>>  >  			return ret;
>>  >
>>  > -		if (val)
>>  > +		if (val) {
>>  >  			ret &=3D ~VCNL4040_ALS_CONF_ALS_SD;
>>  > -		else
>>  > +			data->als_enable =3D true;
>>  > +		} else {
>>  >  			ret |=3D VCNL4040_ALS_CONF_ALS_SD;
>>  > +			data->als_enable =3D false;
>>  > +		}
>>  >
>>  >  		return i2c_smbus_write_word_data(data->client,=20
>> VCNL4200_AL_CONF,
>>  >  						 ret);
>>  > @@ -225,10 +231,13 @@ static ssize_t=20
>> vcnl4000_write_ps_enable(struct
>>  > vcnl4000_data *data, int val)
>>  >  		if (ret < 0)
>>  >  			return ret;
>>  >
>>  > -		if (val)
>>  > +		if (val) {
>>  >  			ret &=3D ~VCNL4040_PS_CONF1_PS_SD;
>>  > -		else
>>  > +			data->ps_enable =3D true;
>>  > +		} else {
>>  >  			ret |=3D VCNL4040_PS_CONF1_PS_SD;
>>  > +			data->ps_enable =3D false;
>>  > +		}
>>  >
>>  >  		return i2c_smbus_write_word_data(data->client,
>>  >  						 VCNL4200_PS_CONF1, ret);
>>  > @@ -283,6 +292,8 @@ static int vcnl4200_init(struct vcnl4000_data
>>  > *data)
>>  >  	dev_dbg(&data->client->dev, "device id 0x%x", id);
>>  >
>>  >  	data->rev =3D (ret >> 8) & 0xf;
>>  > +	data->als_enable =3D false;
>>  > +	data->ps_enable =3D false;
>>  >
>>  >  	data->vcnl4200_al.reg =3D VCNL4200_AL_DATA;
>>  >  	data->vcnl4200_ps.reg =3D VCNL4200_PS_DATA;
>>  > @@ -459,8 +470,12 @@ static bool=20
>> vcnl4010_is_in_periodic_mode(struct
>>  > vcnl4000_data *data)
>>  >  static int vcnl4000_set_pm_runtime_state(struct vcnl4000_data=20
>> *data,
>>  > bool on)
>>  >  {
>>  >  	struct device *dev =3D &data->client->dev;
>>  > +	struct iio_dev *indio_dev =3D i2c_get_clientdata(data->client);
>>  >  	int ret;
>>  >
>>  > +	if (!indio_dev->dev.power.runtime_auto)
>>  > +		return 0;
>>  > +
>>  >  	if (on) {
>>  >  		ret =3D pm_runtime_resume_and_get(dev);
>>  >  	} else {
>>  > @@ -507,6 +522,38 @@ static int vcnl4000_read_raw(struct iio_dev
>>  > *indio_dev,
>>  >  		*val =3D 0;
>>  >  		*val2 =3D data->al_scale;
>>  >  		return IIO_VAL_INT_PLUS_MICRO;
>>  > +	case IIO_CHAN_INFO_ENABLE:
>>  > +		switch (chan->type) {
>>  > +		case IIO_LIGHT:
>>  > +			*val =3D data->als_enable;
>>  > +			return IIO_VAL_INT;
>>  > +		case IIO_PROXIMITY:
>>  > +			*val =3D data->ps_enable;
>>  > +			return IIO_VAL_INT;
>>  > +		default:
>>  > +			return -EINVAL;
>>  > +		}
>>  > +	default:
>>  > +		return -EINVAL;
>>  > +	}
>>  > +}
>>  > +
>>  > +static int vcnl4040_write_raw(struct iio_dev *indio_dev,
>>  > +				struct iio_chan_spec const *chan,
>>  > +				int val, int val2, long mask)
>>  > +{
>>  > +	struct vcnl4000_data *data =3D iio_priv(indio_dev);
>>  > +
>>  > +	switch (mask) {
>>  > +	case IIO_CHAN_INFO_ENABLE:
>>  > +		switch (chan->type) {
>>  > +		case IIO_LIGHT:
>>  > +			return vcnl4000_write_als_enable(data, val);
>>  > +		case IIO_PROXIMITY:
>>  > +			return vcnl4000_write_ps_enable(data, val);
>>  > +		default:
>>  > +			return -EINVAL;
>>  > +		}
>>  >  	default:
>>  >  		return -EINVAL;
>>  >  	}
>>  > @@ -845,6 +892,19 @@ static const struct iio_chan_spec
>>  > vcnl4010_channels[] =3D {
>>  >  	IIO_CHAN_SOFT_TIMESTAMP(1),
>>  >  };
>>  >
>>  > +static const struct iio_chan_spec vcnl4040_channels[] =3D {
>>  > +	{
>>  > +		.type =3D IIO_LIGHT,
>>  > +		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
>>  > +			BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_ENABLE),
>>  > +	}, {
>>  > +		.type =3D IIO_PROXIMITY,
>>  > +		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
>>  > +			BIT(IIO_CHAN_INFO_ENABLE),
>>  > +		.ext_info =3D vcnl4000_ext_info,
>>  > +	}
>>  > +};
>>  > +
>>  >  static const struct iio_info vcnl4000_info =3D {
>>  >  	.read_raw =3D vcnl4000_read_raw,
>>  >  };
>>  > @@ -859,6 +919,11 @@ static const struct iio_info vcnl4010_info =3D=20
>> {
>>  >  	.write_event_config =3D vcnl4010_write_event_config,
>>  >  };
>>  >
>>  > +static const struct iio_info vcnl4040_info =3D {
>>  > +	.read_raw =3D vcnl4000_read_raw,
>>  > +	.write_raw =3D vcnl4040_write_raw,
>>  > +};
>>  > +
>>  >  static const struct vcnl4000_chip_spec vcnl4000_chip_spec_cfg[]=20
>> =3D {
>>  >  	[VCNL4000] =3D {
>>  >  		.prod =3D "VCNL4000",
>>  > @@ -888,9 +953,9 @@ static const struct vcnl4000_chip_spec
>>  > vcnl4000_chip_spec_cfg[] =3D {
>>  >  		.measure_light =3D vcnl4200_measure_light,
>>  >  		.measure_proximity =3D vcnl4200_measure_proximity,
>>  >  		.set_power_state =3D vcnl4200_set_power_state,
>>  > -		.channels =3D vcnl4000_channels,
>>  > -		.num_channels =3D ARRAY_SIZE(vcnl4000_channels),
>>  > -		.info =3D &vcnl4000_info,
>>  > +		.channels =3D vcnl4040_channels,
>>  > +		.num_channels =3D ARRAY_SIZE(vcnl4040_channels),
>>  > +		.info =3D &vcnl4040_info,
>>  >  		.irq_support =3D false,
>>  >  	},
>>  >  	[VCNL4200] =3D {
>>  > --
>>  > 2.30.2
>>  >
>>=20
>>=20


