Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE70B5E6228
	for <lists+linux-iio@lfdr.de>; Thu, 22 Sep 2022 14:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbiIVMSo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 22 Sep 2022 08:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231273AbiIVMSf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 22 Sep 2022 08:18:35 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FFB3E62CE
        for <linux-iio@vger.kernel.org>; Thu, 22 Sep 2022 05:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1663849114;
  x=1695385114;
  h=date:to:cc:subject:message-id:references:mime-version:
   content-transfer-encoding:in-reply-to:from;
  bh=Nem9zPrz5bOyr19zdGKAw5KYgpl9PDHyvMFldMrZaeE=;
  b=UDajOOJdiF9muN7tQTnjO/8rB+pXqdSxjZ4RViW5LbpCbtqd/HPoW+Ho
   RHKv5JR8HzkfITA6CrDFr3MH4GVNsANmQAMvOQ/YCSgt6uKtVzfjycCrV
   wWsstdESSjmNaDFYGLm1oj9DKUAJg/SY+IVCdmkbfUTU+NhKEEuCM0jRq
   qex8wbeDCUWJARNzpUBSBIHjxMxpgGas8AVqZa0LWh0prKvVOJmOPSylF
   YsC/xEd+BbSSjC3bovsZKz+pgdGRHCKg9fjcvzDKs3Wm10pYgj/VrBOu2
   DjKCqbycSCz8BZHrB5Ou9upTvMfuM+Eb2aLiysFw5jzZlpmCfNlPxcMMx
   w==;
Date:   Thu, 22 Sep 2022 14:18:31 +0200
To:     Paul Cercueil <paul@crapouillou.net>
CC:     =?iso-8859-1?Q?M=E5rten?= Lindahl <Marten.Lindahl@axis.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        kernel <kernel@axis.com>
Subject: Re: [PATCH 1/3] iio: light: vcnl4000: Preserve conf bits when toggle
 power
Message-ID: <YyxSlxwN9WlH0a+/@axis.com>
References: <20220920180958.2308229-1-marten.lindahl@axis.com>
 <20220920180958.2308229-2-marten.lindahl@axis.com>
 <2V4JIR.7354DS8U39Q53@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2V4JIR.7354DS8U39Q53@crapouillou.net>
From:   Marten Lindahl <martenli@axis.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Sep 21, 2022 at 12:23:26AM +0200, Paul Cercueil wrote:
> Hi Mårten,
> 
> Le mar., sept. 20 2022 at 20:09:56 +0200, Mårten Lindahl 
> <marten.lindahl@axis.com> a écrit :
> > As the vcnl4040 and vcnl4200 chip uses runtime power management for
> > turning the ambient light and proximity sensors on/off, it overwrites
> > the entire register each time. In ALS_CONF register bit fields ALS_IT,
> > ALS_PERS, ALS_INT_EN are overwritten. In PS_CONF1 register bit fields
> > PS_DUTY, PS_PERS, PS_IT, PS_HD, and PS_INT are overwritten.
> > 
> > Add functions for preserving the affected bit fields when changing 
> > power
> > state.
> > 
> > Signed-off-by: Mårten Lindahl <marten.lindahl@axis.com>
> > ---
> >  drivers/iio/light/vcnl4000.c | 53 
> > ++++++++++++++++++++++++++++++++++--
> >  1 file changed, 51 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/iio/light/vcnl4000.c 
> > b/drivers/iio/light/vcnl4000.c
> > index 3db4e26731bb..0b226c684957 100644
> > --- a/drivers/iio/light/vcnl4000.c
> > +++ b/drivers/iio/light/vcnl4000.c
> > @@ -74,6 +74,9 @@
> >  #define VCNL4000_PROX_EN	BIT(1) /* start proximity measurement */
> >  #define VCNL4000_SELF_TIMED_EN	BIT(0) /* start self-timed 
> > measurement */
> > 
> > +#define VCNL4040_ALS_CONF_ALS_SD	BIT(0) /* Enable ambient light 
> > sensor */
> > +#define VCNL4040_PS_CONF1_PS_SD	BIT(0) /* Enable proximity sensor */
> > +
> >  /* Bit masks for interrupt registers. */
> >  #define VCNL4010_INT_THR_SEL	BIT(0) /* Select threshold interrupt 
> > source */
> >  #define VCNL4010_INT_THR_EN	BIT(1) /* Threshold interrupt type */
> > @@ -188,16 +191,62 @@ static int vcnl4000_init(struct vcnl4000_data 
> > *data)
> >  	return data->chip_spec->set_power_state(data, true);
> >  };
> > 
> > +static ssize_t vcnl4000_write_als_enable(struct vcnl4000_data *data, 
> > int val)
> > +{
> > +	int ret;
> > +
> > +	switch (data->id) {
> > +	case VCNL4040:
> > +	case VCNL4200:

Hi Paul!
Thanks for looking at this!
> 
> The switch isn't needed, since vcnl4200_set_power_state() is only 
> called for compatible chips.

Yes, your're right. I will remove the switch.
> 
> > +		ret = i2c_smbus_read_word_data(data->client, VCNL4200_AL_CONF);
> > +		if (ret < 0)
> > +			return ret;
> > +
> > +		if (val)
> > +			ret &= ~VCNL4040_ALS_CONF_ALS_SD;
> > +		else
> > +			ret |= VCNL4040_ALS_CONF_ALS_SD;
> > +
> > +		return i2c_smbus_write_word_data(data->client, VCNL4200_AL_CONF,
> > +						 ret);
> 
> Are you sure a race cannot happen here?
> 
> I would assume it cannot, but that's still a bit fishy.

Ok, I see what you mean. I cannot tell for sure, but I can guard the
read and write with the mutex.

> 
> This driver would benefit from a regmap conversion, but it's probably a 
> bit too much to ask...

I can try to do this in a separate patch after these ones if that's ok?

> 
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> > +
> > +static ssize_t vcnl4000_write_ps_enable(struct vcnl4000_data *data, 
> > int val)
> > +{
> > +	int ret;
> > +
> > +	switch (data->id) {
> > +	case VCNL4040:
> > +	case VCNL4200:
> > +		ret = i2c_smbus_read_word_data(data->client, VCNL4200_PS_CONF1);
> > +		if (ret < 0)
> > +			return ret;
> > +
> > +		if (val)
> > +			ret &= ~VCNL4040_PS_CONF1_PS_SD;
> > +		else
> > +			ret |= VCNL4040_PS_CONF1_PS_SD;
> > +
> > +		return i2c_smbus_write_word_data(data->client,
> > +						 VCNL4200_PS_CONF1, ret);
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> > +
> >  static int vcnl4200_set_power_state(struct vcnl4000_data *data, bool 
> > on)
> >  {
> >  	u16 val = on ? 0 /* power on */ : 1 /* shut down */;
> >  	int ret;
> > 
> > -	ret = i2c_smbus_write_word_data(data->client, VCNL4200_AL_CONF, 
> > val);
> > +	ret = vcnl4000_write_als_enable(data, !val);
> 
> You set "val" to 0 if "on", and to 1 if "!on", then pass "!val", this 
> is very confusing. You could just pass "on" here and below.

I agree! I will change it to only use the boolean 'on'.

Kind reagards
Mårten
> 
> Cheers,
> -Paul
> 
> >  	if (ret < 0)
> >  		return ret;
> > 
> > -	ret = i2c_smbus_write_word_data(data->client, VCNL4200_PS_CONF1, 
> > val);
> > +	ret = vcnl4000_write_ps_enable(data, !val);
> >  	if (ret < 0)
> >  		return ret;
> > 
> > --
> > 2.30.2
> > 
> 
> 
