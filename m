Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48AC85E639F
	for <lists+linux-iio@lfdr.de>; Thu, 22 Sep 2022 15:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231524AbiIVNbe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 22 Sep 2022 09:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231577AbiIVNba (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 22 Sep 2022 09:31:30 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D404E21E8
        for <linux-iio@vger.kernel.org>; Thu, 22 Sep 2022 06:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1663853484;
  x=1695389484;
  h=date:to:cc:subject:message-id:references:mime-version:
   content-transfer-encoding:in-reply-to:from;
  bh=IgYnP2hhEzDmIIz0ajq6KYjw5KDqV/tF6TcJ+4SJ70U=;
  b=FdfY+53lSl89zy1lZqZ1StoGMmpiPGysaYHSMLC8yAhyhqsZdBGcanhc
   gdcgCBQMNx22xFmgups4/OP19iKhIoWUAU1/X9BFsKWwGGj3AqkUB2pGk
   IDVs8a1xNjFkAcSsZJU4f6KgmzlY5GgZyvTDsjyJgiDqE1gsZ1j9JopRR
   C34Y8nahVTp6ung7g2PwSyU8pwVoHgiI5GtvXZ5nJfpccGZDR+Fw0J4N0
   Lr/3ku1oaVCOwFib0uXGZuedfqDxPK9z7BDOVQEU6g9BOVLbiT0gDDa2B
   yB4i0XyvCqJrt9ACLjTOaIapfttueJACzj4KwL79pptC4IoAgFHPAbjqG
   w==;
Date:   Thu, 22 Sep 2022 15:31:20 +0200
To:     Paul Cercueil <paul@crapouillou.net>
CC:     =?iso-8859-1?Q?M=E5rten?= Lindahl <Marten.Lindahl@axis.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        kernel <kernel@axis.com>
Subject: Re: [PATCH 3/3] iio: light: vcnl4000: Add ps_it attributes for
 vcnl4040
Message-ID: <YyxjqIzNr6Fn9w73@axis.com>
References: <20220920180958.2308229-1-marten.lindahl@axis.com>
 <20220920180958.2308229-4-marten.lindahl@axis.com>
 <RC4JIR.84Y31Q6YBI06@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <RC4JIR.84Y31Q6YBI06@crapouillou.net>
From:   Marten Lindahl <martenli@axis.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Sep 21, 2022 at 12:12:27AM +0200, Paul Cercueil wrote:
> Hi Mårten,
> 
> Le mar., sept. 20 2022 at 20:09:58 +0200, Mårten Lindahl 
> <marten.lindahl@axis.com> a écrit :
> > Add read/write attribute for proximity integration time, and a read
> > attribute for available integration times for the vcnl4040 chip.
> > 
> > Signed-off-by: Mårten Lindahl <marten.lindahl@axis.com>
> > ---
> >  drivers/iio/light/vcnl4000.c | 83 
> > +++++++++++++++++++++++++++++++++++-
> >  1 file changed, 82 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/light/vcnl4000.c 
> > b/drivers/iio/light/vcnl4000.c
> > index 9838f0868372..7a207e48335d 100644
> > --- a/drivers/iio/light/vcnl4000.c
> > +++ b/drivers/iio/light/vcnl4000.c
> > @@ -76,6 +76,8 @@
> > 
> >  #define VCNL4040_ALS_CONF_ALS_SD	BIT(0) /* Enable ambient light 
> > sensor */
> >  #define VCNL4040_PS_CONF1_PS_SD	BIT(0) /* Enable proximity sensor */
> > +#define VCNL4040_PS_CONF2_PS_IT \
> > +	(BIT(3) | BIT(2) | BIT(1)) /* Proximity integration time */

Hi Paul!
> 
> Use the GENMASK() macro.
>
Will do!

> > 
> >  /* Bit masks for interrupt registers. */
> >  #define VCNL4010_INT_THR_SEL	BIT(0) /* Select threshold interrupt 
> > source */
> > @@ -103,6 +105,16 @@ static const int 
> > vcnl4010_prox_sampling_frequency[][2] = {
> >  	{125, 0},
> >  	{250, 0},
> >  };
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
> > 
> >  #define VCNL4000_SLEEP_DELAY_MS	2000 /* before we enter 
> > pm_runtime_suspend */
> > 
> > @@ -486,6 +498,49 @@ static int vcnl4000_set_pm_runtime_state(struct 
> > vcnl4000_data *data, bool on)
> >  	return ret;
> >  }
> > 
> > +static int vcnl4040_read_ps_it(struct vcnl4000_data *data, int *val, 
> > int *val2)
> > +{
> > +	int ret;
> > +
> > +	ret = i2c_smbus_read_word_data(data->client, VCNL4200_PS_CONF1);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	ret = (ret & VCNL4040_PS_CONF2_PS_IT) >> 1;
> 
> Use the FIELD_GET() macro.
> 
Will do!

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
> > +static ssize_t vcnl4040_write_ps_it(struct vcnl4000_data *data, int 
> > val)
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
> > +	ret = i2c_smbus_read_word_data(data->client, VCNL4200_PS_CONF1);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	ret = (ret & ~VCNL4040_PS_CONF2_PS_IT) | (index << 1);
> 
> Use the FIELD_PREP() macro.
> 
Will do!

> > +
> > +	return i2c_smbus_write_word_data(data->client, VCNL4200_PS_CONF1, 
> > ret);
> > +}
> > +
> >  static int vcnl4000_read_raw(struct iio_dev *indio_dev,
> >  				struct iio_chan_spec const *chan,
> >  				int *val, int *val2, long mask)
> > @@ -533,6 +588,13 @@ static int vcnl4000_read_raw(struct iio_dev 
> > *indio_dev,
> >  		default:
> >  			return -EINVAL;
> >  		}
> > +	case IIO_CHAN_INFO_INT_TIME:
> > +		if (chan->type != IIO_PROXIMITY)
> > +			return -EINVAL;
> > +		ret = vcnl4040_read_ps_it(data, val, val2);
> > +		if (ret < 0)
> > +			return ret;
> > +		return IIO_VAL_INT_PLUS_MICRO;
> >  	default:
> >  		return -EINVAL;
> >  	}
> > @@ -554,6 +616,12 @@ static int vcnl4040_write_raw(struct iio_dev 
> > *indio_dev,
> >  		default:
> >  			return -EINVAL;
> >  		}
> > +	case IIO_CHAN_INFO_INT_TIME:
> > +		if (val != 0)
> > +			return -EINVAL;
> > +		if (chan->type != IIO_PROXIMITY)
> > +			return -EINVAL;
> > +		return vcnl4040_write_ps_it(data, val2);
> >  	default:
> >  		return -EINVAL;
> >  	}
> > @@ -900,11 +968,23 @@ static const struct iio_chan_spec 
> > vcnl4040_channels[] = {
> >  	}, {
> >  		.type = IIO_PROXIMITY,
> >  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> > -			BIT(IIO_CHAN_INFO_ENABLE),
> > +			BIT(IIO_CHAN_INFO_ENABLE) | BIT(IIO_CHAN_INFO_INT_TIME),
> >  		.ext_info = vcnl4000_ext_info,
> >  	}
> >  };
> > 
> > +static IIO_CONST_ATTR(in_proximity_integration_time_available,
> > +	"0.000100 0.000150 0.000200 0.000250 0.000300 0.000350 0.000400 
> > 0.000800");
> 
> Hmm, this is not how you define a "_available" attribute.
> 
> You need to add a
> .info_mask_separate_available = BIT(IIO_CHAN_INFO_INT_TIME)
> 
> to your iio_chan_spec, then implement the .read_avail callback in your 
> iio_info structure.

Ok, I didn't notice that possibility. Thanks, I will do so!

Kind regards
Mårten

> 
> Cheers,
> -Paul
> 
> > +
> > +static struct attribute *vcnl4040_attributes[] = {
> > +	&iio_const_attr_in_proximity_integration_time_available.dev_attr.attr,
> > +	NULL,
> > +};
> > +
> > +static const struct attribute_group vcnl4040_attribute_group = {
> > +	.attrs = vcnl4040_attributes,
> > +};
> > +
> >  static const struct iio_info vcnl4000_info = {
> >  	.read_raw = vcnl4000_read_raw,
> >  };
> > @@ -922,6 +1002,7 @@ static const struct iio_info vcnl4010_info = {
> >  static const struct iio_info vcnl4040_info = {
> >  	.read_raw = vcnl4000_read_raw,
> >  	.write_raw = vcnl4040_write_raw,
> > +	.attrs = &vcnl4040_attribute_group,
> >  };
> > 
> >  static const struct vcnl4000_chip_spec vcnl4000_chip_spec_cfg[] = {
> > --
> > 2.30.2
> > 
> 
> 
