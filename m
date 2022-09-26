Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 997955E9BE3
	for <lists+linux-iio@lfdr.de>; Mon, 26 Sep 2022 10:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234049AbiIZIWL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 26 Sep 2022 04:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233893AbiIZIWK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 26 Sep 2022 04:22:10 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6329131DEA
        for <linux-iio@vger.kernel.org>; Mon, 26 Sep 2022 01:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1664180526;
  x=1695716526;
  h=date:to:cc:subject:message-id:references:mime-version:
   content-transfer-encoding:in-reply-to:from;
  bh=7CSSHh6inW3FiYNtrVKZPg/MOO/QUXv+js92qPD0oLg=;
  b=amw0zuxgskD4XwM65WM9iTHXArUkNDXpPKKQGRF4MkD0tRLzmp/arvWz
   fqJRAvLLfqkbzl2VEOhqdDXaFeTC4h9a424P1OPxZIjhqbrxYfYi4irpF
   d466xYekBnAHR6lQvJjkESJemiS49CVqMOFa2sr3RUjKHBLJVOxwskY91
   RwvaGWglXgC8R7GB7o2YufBu9YRsXWnwhK6k+2X8pFuvSpsb/I7v0bJb2
   djqD/2IYKKAS8u7hYR2KfO8CmB6VY1BfT4f+OEKpRreZHc2NYAR2NpwdL
   7kP/vN98samUyEHEQuIbhmV9MRLh3yZykyD0Jn0uRt2jKxqeXRzdgywOp
   A==;
Date:   Mon, 26 Sep 2022 10:22:03 +0200
To:     Jonathan Cameron <jic23@kernel.org>
CC:     =?iso-8859-1?Q?M=E5rten?= Lindahl <Marten.Lindahl@axis.com>,
        "Lars-Peter Clausen" <lars@metafoo.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        kernel <kernel@axis.com>
Subject: Re: [PATCH v2 1/2] iio: light: vcnl4000: Preserve conf bits when
 toggle power
Message-ID: <YzFhK27LmQlRW9p/@axis.com>
References: <20220923114031.757011-1-marten.lindahl@axis.com>
 <20220923114031.757011-2-marten.lindahl@axis.com>
 <20220924173724.374305c9@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220924173724.374305c9@jic23-huawei>
From:   Marten Lindahl <martenli@axis.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Sep 24, 2022 at 06:37:24PM +0200, Jonathan Cameron wrote:
> On Fri, 23 Sep 2022 13:40:30 +0200
> Mårten Lindahl <marten.lindahl@axis.com> wrote:
> 
> > As the vcnl4040 and vcnl4200 chip uses runtime power management for
> > turning the ambient light and proximity sensors on/off, it overwrites
> > the entire register each time. In ALS_CONF register bit fields ALS_IT,
> > ALS_PERS, ALS_INT_EN are overwritten. In PS_CONF1 register bit fields
> > PS_DUTY, PS_PERS, PS_IT, PS_HD, and PS_INT are overwritten.
> > 
> > Add functions for preserving the affected bit fields when changing power
> > state.
> > 
> > Signed-off-by: Mårten Lindahl <marten.lindahl@axis.com>
> See inline.
> Otherwise looks good to me.
> 
> Jonathan
> 
> > ---
> >  drivers/iio/light/vcnl4000.c | 54 ++++++++++++++++++++++++++++++++++--
> >  1 file changed, 51 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
> > index 3db4e26731bb..b2ecf8af1aa5 100644
> > --- a/drivers/iio/light/vcnl4000.c
> > +++ b/drivers/iio/light/vcnl4000.c
> > @@ -74,6 +74,9 @@
> >  #define VCNL4000_PROX_EN	BIT(1) /* start proximity measurement */
> >  #define VCNL4000_SELF_TIMED_EN	BIT(0) /* start self-timed measurement */
> >  
> > +#define VCNL4040_ALS_CONF_ALS_SD	BIT(0) /* Enable ambient light sensor */
>

Hi Jonathan!

> Comment seems inverted. Bit being set is 'shut down'  I would expand the
> name to
> VCNL4040_ALS_CONF_ALS_SHUTDOWN 
> then drop the comment as the name is self explanatory

Ok, I'll do so. Thanks!

Kind regards
Mårten

> 
> > +#define VCNL4040_PS_CONF1_PS_SD	BIT(0) /* Enable proximity sensor */
> > +
> >  /* Bit masks for interrupt registers. */
> >  #define VCNL4010_INT_THR_SEL	BIT(0) /* Select threshold interrupt source */
> >  #define VCNL4010_INT_THR_EN	BIT(1) /* Threshold interrupt type */
> > @@ -188,16 +191,61 @@ static int vcnl4000_init(struct vcnl4000_data *data)
> >  	return data->chip_spec->set_power_state(data, true);
> >  };
> >  
> > +static ssize_t vcnl4000_write_als_enable(struct vcnl4000_data *data, bool en)
> > +{
> > +	int ret;
> > +
> > +	mutex_lock(&data->vcnl4000_lock);
> > +
> > +	ret = i2c_smbus_read_word_data(data->client, VCNL4200_AL_CONF);
> > +	if (ret < 0)
> > +		goto out;
> > +
> > +	if (en)
> > +		ret &= ~VCNL4040_ALS_CONF_ALS_SD;
> > +	else
> > +		ret |= VCNL4040_ALS_CONF_ALS_SD;
> > +
> > +	ret = i2c_smbus_write_word_data(data->client, VCNL4200_AL_CONF, ret);
> > +
> > +out:
> > +	mutex_unlock(&data->vcnl4000_lock);
> > +
> > +	return ret;
> > +}
> > +
> > +static ssize_t vcnl4000_write_ps_enable(struct vcnl4000_data *data, bool en)
> > +{
> > +	int ret;
> > +
> > +	mutex_lock(&data->vcnl4000_lock);
> > +
> > +	ret = i2c_smbus_read_word_data(data->client, VCNL4200_PS_CONF1);
> > +	if (ret < 0)
> > +		goto out;
> > +
> > +	if (en)
> > +		ret &= ~VCNL4040_PS_CONF1_PS_SD;
> > +	else
> > +		ret |= VCNL4040_PS_CONF1_PS_SD;
> > +
> > +	ret = i2c_smbus_write_word_data(data->client, VCNL4200_PS_CONF1, ret);
> > +
> > +out:
> > +	mutex_unlock(&data->vcnl4000_lock);
> > +
> > +	return ret;
> > +}
> > +
> >  static int vcnl4200_set_power_state(struct vcnl4000_data *data, bool on)
> >  {
> > -	u16 val = on ? 0 /* power on */ : 1 /* shut down */;
> >  	int ret;
> >  
> > -	ret = i2c_smbus_write_word_data(data->client, VCNL4200_AL_CONF, val);
> > +	ret = vcnl4000_write_als_enable(data, on);
> >  	if (ret < 0)
> >  		return ret;
> >  
> > -	ret = i2c_smbus_write_word_data(data->client, VCNL4200_PS_CONF1, val);
> > +	ret = vcnl4000_write_ps_enable(data, on);
> >  	if (ret < 0)
> >  		return ret;
> >  
> 
