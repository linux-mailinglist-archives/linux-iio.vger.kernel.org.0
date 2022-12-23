Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8D69655204
	for <lists+linux-iio@lfdr.de>; Fri, 23 Dec 2022 16:26:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236468AbiLWP0X (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 23 Dec 2022 10:26:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbiLWP0W (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 23 Dec 2022 10:26:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A86248EE;
        Fri, 23 Dec 2022 07:26:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1065561497;
        Fri, 23 Dec 2022 15:26:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 071EAC433EF;
        Fri, 23 Dec 2022 15:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671809180;
        bh=zsgzbI+y+B3zcorZp+s237A1XSgIlO7JIhgVXD6bmWs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=m4gJSHONsShKFHx0RDSOVXVfRQ7nCnAmqrCMO3hmPKiVMr5USWLcxd9yUQibucp7p
         pvqGzxwR6djEeBMwz/ulZIcU79wOWmVfJlkhfilgbczA8VcoczTFL/F0GEaYHipBsq
         CfrAHbtQmxbybt/4PQF3ENzWllsw0pb0QoK2cWeydmGSKbyPzmujo+XyZGk/wxyVOJ
         05vHrr04IOfpvHQR2HnjnBZcoac7EtoTtjCccPHD+Mazu/XykmOxSDRh9Gnfqqhp18
         Ryyoy7/cGuyMLmwIr2XyC6vRfnD2Xt5gg8mRDKiL8WZdB03f7T35nq352kEu7D0DMW
         Ih4WseVqvYoyA==
Date:   Fri, 23 Dec 2022 15:39:29 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     puranjay12@gmail.com, lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH v2 3/4] iio: temperature: tmp117: add TI TMP116 support
Message-ID: <20221223153929.3fbad6b2@jic23-huawei>
In-Reply-To: <20221223150728.34d5agqr4ruixjbu@pengutronix.de>
References: <20221221092801.1977499-1-m.felsch@pengutronix.de>
        <20221221092801.1977499-4-m.felsch@pengutronix.de>
        <20221223151056.4f7d4b7e@jic23-huawei>
        <20221223150728.34d5agqr4ruixjbu@pengutronix.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 23 Dec 2022 16:07:28 +0100
Marco Felsch <m.felsch@pengutronix.de> wrote:

> Hi Jonathan,
> 
> On 22-12-23, Jonathan Cameron wrote:
> > On Wed, 21 Dec 2022 10:28:00 +0100
> > Marco Felsch <m.felsch@pengutronix.de> wrote:
> >   
> > > The TMP116 is the predecessor of the TMP117. The TMP116 don't support
> > > custom offset calibration data, instead this register is used as generic
> > > EEPROM storage as well.
> > > 
> > > Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>  
> > A few comments inline.
> > Thanks,
> > 
> > Jonathan
> >   
> > > ---
> > > v2:
> > > - no changes
> > > 
> > >  drivers/iio/temperature/tmp117.c | 40 ++++++++++++++++++++++----------
> > >  1 file changed, 28 insertions(+), 12 deletions(-)
> > > 
> > > diff --git a/drivers/iio/temperature/tmp117.c b/drivers/iio/temperature/tmp117.c
> > > index f9b8f2b570f6..468dafa6fa8e 100644
> > > --- a/drivers/iio/temperature/tmp117.c
> > > +++ b/drivers/iio/temperature/tmp117.c
> > > @@ -31,9 +31,11 @@
> > >  #define TMP117_REG_DEVICE_ID		0xF
> > >  
> > >  #define TMP117_RESOLUTION_10UC		78125
> > > -#define TMP117_DEVICE_ID		0x0117
> > >  #define MICRODEGREE_PER_10MILLIDEGREE	10000
> > >  
> > > +#define TMP116_DEVICE_ID		0x1116
> > > +#define TMP117_DEVICE_ID		0x0117
> > > +
> > >  struct tmp117_data {
> > >  	struct i2c_client *client;
> > >  	s16 calibbias;
> > > @@ -105,6 +107,13 @@ static const struct iio_chan_spec tmp117_channels[] = {
> > >  		.type = IIO_TEMP,
> > >  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> > >  			BIT(IIO_CHAN_INFO_CALIBBIAS) | BIT(IIO_CHAN_INFO_SCALE),
> > > +};
> > > +
> > > +static const struct iio_chan_spec tmp116_channels[] = {
> > > +	{
> > > +		.type = IIO_TEMP,
> > > +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> > > +				      BIT(IIO_CHAN_INFO_SCALE),
> > >  	},
> > >  };
> > >  
> > > @@ -118,27 +127,28 @@ static int tmp117_identify(struct i2c_client *client)
> > >  	int dev_id;
> > >  
> > >  	dev_id = i2c_smbus_read_word_swapped(client, TMP117_REG_DEVICE_ID);
> > > -	if (dev_id < 0)  
> > 
> > Keep this handling of the smbus read returning an error.
> > Otherwise, you end up replacing the error code with -ENODEV rather than
> > returning what actually happened.
> > 
> > 	if (dev_id < 0)
> > 		return dev_id;  
> 
> You're right, I will change this thanks.
> 
> > 	switch (dev_id) {
> > ...
> >   
> > > +	switch (dev_id) {
> > > +	case TMP116_DEVICE_ID:
> > > +	case TMP117_DEVICE_ID:
> > >  		return dev_id;
> > > -	if (dev_id != TMP117_DEVICE_ID) {
> > > -		dev_err(&client->dev, "TMP117 not found\n");
> > > +	default:
> > > +		dev_err(&client->dev, "TMP116/117 not found\n");
> > >  		return -ENODEV;
As per the other branch of this thread.  This isn't an error.
If we want fallback compatibles to work in their role of allowing
for newer devices that are actually compatible, the most we should
do here is warn.

Say a new tmp117b device is released. It's fully backwards compatible
with the exception of an ID - or supports only new features + backwards
compatibility then that would have a fallback to tmp117 and we need
it to work.

> > >  	}
> > > -	return 0;
> > >  }
> > >  
> > >  static int tmp117_probe(struct i2c_client *client)
> > >  {
> > >  	struct tmp117_data *data;
> > >  	struct iio_dev *indio_dev;
> > > -	int ret;
> > > +	int dev_id;
> > >  
> > >  	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_WORD_DATA))
> > >  		return -EOPNOTSUPP;
> > >  
> > > -	ret = tmp117_identify(client);
> > > -	if (ret < 0)
> > > -		return ret;
> > > +	dev_id = tmp117_identify(client);
> > > +	if (dev_id < 0)
> > > +		return dev_id;
> > >  
> > >  	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> > >  	if (!indio_dev)
> > > @@ -148,12 +158,18 @@ static int tmp117_probe(struct i2c_client *client)
> > >  	data->client = client;
> > >  	data->calibbias = 0;
> > >  
> > > -	indio_dev->name = "tmp117";
> > >  	indio_dev->modes = INDIO_DIRECT_MODE;
> > >  	indio_dev->info = &tmp117_info;
> > >  
> > > -	indio_dev->channels = tmp117_channels;
> > > -	indio_dev->num_channels = ARRAY_SIZE(tmp117_channels);
> > > +	if (dev_id == TMP117_DEVICE_ID) {  
> > 
> > Probably better to assume we may get more parts in future and use a
> > switch statement here to explicitly match each value.  
> 
> As you want, I will change it.
> 
> Regards,
>   Marco
> 
> > > +		indio_dev->channels = tmp117_channels;
> > > +		indio_dev->num_channels = ARRAY_SIZE(tmp117_channels);
> > > +		indio_dev->name = "tmp117";
> > > +	} else {
> > > +		indio_dev->channels = tmp116_channels;
> > > +		indio_dev->num_channels = ARRAY_SIZE(tmp116_channels);
> > > +		indio_dev->name = "tmp116";
> > > +	}
> > >  
> > >  	return devm_iio_device_register(&client->dev, indio_dev);
> > >  }  
> > 
> >   

