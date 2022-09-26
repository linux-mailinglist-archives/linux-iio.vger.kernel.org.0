Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C02D35E9BEF
	for <lists+linux-iio@lfdr.de>; Mon, 26 Sep 2022 10:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233816AbiIZIZm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 26 Sep 2022 04:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233287AbiIZIZm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 26 Sep 2022 04:25:42 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B6B25C76
        for <linux-iio@vger.kernel.org>; Mon, 26 Sep 2022 01:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1664180740;
  x=1695716740;
  h=date:to:cc:subject:message-id:references:mime-version:
   content-transfer-encoding:in-reply-to:from;
  bh=rwkwx+t/gl7BVQE4ekuPhYc1yCSZt7IaX+xcNEZgAh0=;
  b=B4joHAtET9ZT+8ULeNflwlD0mQLVTmuwWxHRgmDHltAAeEfGA/svk5Dg
   UWalL8bcRluJetTSdL6sAL3AYN7ir31KUjI0Nwl2gGnVj/LrYnHJF9+jc
   OJatGeJ3Yyb8UoL6CiWX8+QLE8ojt/PP/6tUWfIZzoyN3/f3R76f/ySgk
   chNu0J00cdofQ4N6fIQEVMkmwJfXtGkBgUiMclDO9e+E8ZEZZjnYJHeQe
   FcJybQt3IkXBJSW8Tv86OgXEtrdc6nb+nsJbdqDrFye7IOfI3JOl9JRgE
   6gD7ewHaWNYMg67n5OMBAKBI9HtWlcLSy/l4sHynTKGVbUr4tcqkBPVSy
   w==;
Date:   Mon, 26 Sep 2022 10:25:38 +0200
To:     Jonathan Cameron <jic23@kernel.org>
CC:     =?iso-8859-1?Q?M=E5rten?= Lindahl <Marten.Lindahl@axis.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        kernel <kernel@axis.com>
Subject: Re: [PATCH v2 2/2] iio: light: vcnl4000: Add ps_it attributes for
 vcnl4040
Message-ID: <YzFiAl5zMZjET9em@axis.com>
References: <20220923114031.757011-1-marten.lindahl@axis.com>
 <20220923114031.757011-3-marten.lindahl@axis.com>
 <20220924174044.44ecb02f@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220924174044.44ecb02f@jic23-huawei>
From:   Marten Lindahl <martenli@axis.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Sep 24, 2022 at 06:40:44PM +0200, Jonathan Cameron wrote:
> On Fri, 23 Sep 2022 13:40:31 +0200
> Mårten Lindahl <marten.lindahl@axis.com> wrote:
> 
> > Add read/write attribute for proximity integration time, and read
> > attribute for available proximity integration times for the vcnl4040
> > chip.
> > 
> > Signed-off-by: Mårten Lindahl <marten.lindahl@axis.com>
> Hi Mårten,
> 
> One minor comment inline given I've asked for changes that mean you'll
> probably be doing a v3 anyway.
> 
> Thanks,
> 
> Jonathan
> 
> > ---
> >  drivers/iio/light/vcnl4000.c | 129 ++++++++++++++++++++++++++++++++++-
> >  1 file changed, 126 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
> > index b2ecf8af1aa5..056079b592c6 100644
> > --- a/drivers/iio/light/vcnl4000.c
> > +++ b/drivers/iio/light/vcnl4000.c
> > @@ -17,6 +17,7 @@
> >   *   interrupts (VCNL4040, VCNL4200)
> >   */
> >  
> > +#include <linux/bitfield.h>
> >  #include <linux/module.h>
> >  #include <linux/i2c.h>
> >  #include <linux/err.h>
> > @@ -76,6 +77,7 @@
> >  
> >  #define VCNL4040_ALS_CONF_ALS_SD	BIT(0) /* Enable ambient light sensor */
> >  #define VCNL4040_PS_CONF1_PS_SD	BIT(0) /* Enable proximity sensor */
> > +#define VCNL4040_PS_CONF2_PS_IT	GENMASK(3, 1) /* Proximity integration time */
> >  
> >  /* Bit masks for interrupt registers. */
> >  #define VCNL4010_INT_THR_SEL	BIT(0) /* Select threshold interrupt source */
> > @@ -104,6 +106,17 @@ static const int vcnl4010_prox_sampling_frequency[][2] = {
> >  	{250, 0},
> >  };
> >  
> > +static const int vcnl4040_ps_it_times[][2] = {
> > +	{0, 100},
> > +	{0, 150},
> > +	{0, 200},
> > +	{0, 250},
> > +	{0, 300},
> > +	{0, 350},
> > +	{0, 400},
> > +	{0, 800},
> > +};
> > +
> >  #define VCNL4000_SLEEP_DELAY_MS	2000 /* before we enter pm_runtime_suspend */
> >  
> >  enum vcnl4000_device_ids {
> > @@ -470,6 +483,55 @@ static int vcnl4000_set_pm_runtime_state(struct vcnl4000_data *data, bool on)
> >  	return ret;
> >  }
> >  
> > +static int vcnl4040_read_ps_it(struct vcnl4000_data *data, int *val, int *val2)
> > +{
> > +	int ret;
> > +
> > +	ret = i2c_smbus_read_word_data(data->client, VCNL4200_PS_CONF1);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	ret = FIELD_GET(VCNL4040_PS_CONF2_PS_IT, ret);
> > +
> > +	if (ret >= ARRAY_SIZE(vcnl4040_ps_it_times))
> > +		return -EINVAL;
> > +
> > +	*val = vcnl4040_ps_it_times[ret][0];
> > +	*val2 = vcnl4040_ps_it_times[ret][1];
> > +
> > +	return 0;
> > +}
> > +
> > +static ssize_t vcnl4040_write_ps_it(struct vcnl4000_data *data, int val)
> > +{
> > +	unsigned int i;
> > +	int ret, index = -1;
> > +
> > +	for (i = 0; i < ARRAY_SIZE(vcnl4040_ps_it_times); i++) {
> > +		if (val == vcnl4040_ps_it_times[i][1]) {
> > +			index = i;
> > +			break;
> > +		}
> > +	}
> > +
> > +	if (index < 0)
> > +		return -EINVAL;
> > +
> > +	mutex_lock(&data->vcnl4000_lock);
> > +
> > +	ret = i2c_smbus_read_word_data(data->client, VCNL4200_PS_CONF1);
> > +	if (ret < 0)
> > +		goto out;
> > +
> > +	ret = (ret & ~VCNL4040_PS_CONF2_PS_IT) |
> > +	    FIELD_PREP(VCNL4040_PS_CONF2_PS_IT, index);
> 
> It can be confusing to read ret both as a temporary to build value ad for the
> return code. I would introduce a
> u16 val
> and build the value in that.

Hi Jonathan!

Thanks. I'll do so. As there already is a 'val' I will call it 'regval'.

Kind regards
Mårten
> 
> > +	ret = i2c_smbus_write_word_data(data->client, VCNL4200_PS_CONF1, ret);
> > +
> > +out:
> > +	mutex_unlock(&data->vcnl4000_lock);
> > +	return ret;
> > +}
> > +
