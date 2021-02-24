Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5094A32414E
	for <lists+linux-iio@lfdr.de>; Wed, 24 Feb 2021 17:06:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236079AbhBXPqZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 24 Feb 2021 10:46:25 -0500
Received: from mta-02.yadro.com ([89.207.88.252]:44814 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235642AbhBXPOA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 24 Feb 2021 10:14:00 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 2F45F4126D;
        Wed, 24 Feb 2021 15:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-transfer-encoding:mime-version:user-agent:content-type
        :content-type:organization:references:in-reply-to:date:date:from
        :from:subject:subject:message-id:received:received:received; s=
        mta-01; t=1614179590; x=1615993991; bh=0eO6VNk1f53HAPwWXpMh7jBsV
        yQZ19v0fCW+8c0TUuo=; b=jrmgTbiQ0NoCtUhlKoKxmNfjubC3z9Jvut7P2HVhS
        QSvac+T+igJBsfNe2+Kk8cbjKaZzExrFck54HXXX/CG1ptVc1OUpYEEgFmlMXOwb
        aUyoexaUrsG2b8/o1mmn6H4XX5TP6cC/UHMqTAzv5NEO3vxB/GAxabIdwWZdzhHs
        Wo=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id MRZBzwVL1J_b; Wed, 24 Feb 2021 18:13:10 +0300 (MSK)
Received: from T-EXCH-03.corp.yadro.com (t-exch-03.corp.yadro.com [172.17.100.103])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 88EBD41258;
        Wed, 24 Feb 2021 18:13:10 +0300 (MSK)
Received: from localhost.localdomain (10.199.0.44) by T-EXCH-03.corp.yadro.com
 (172.17.100.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Wed, 24
 Feb 2021 18:13:10 +0300
Message-ID: <a1779c73437045b002005865356a7e51031742c2.camel@yadro.com>
Subject: Re: [PATCH 1/2] iio: proximity: vcnl3020: add proximity rate
From:   Ivan Mikhaylov <i.mikhaylov@yadro.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Date:   Wed, 24 Feb 2021 18:20:11 +0300
In-Reply-To: <20210221152049.3b61e20b@archlinux>
References: <20210216145346.18304-1-i.mikhaylov@yadro.com>
         <20210216145346.18304-2-i.mikhaylov@yadro.com>
         <20210221152049.3b61e20b@archlinux>
Organization: YADRO
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.199.0.44]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-03.corp.yadro.com (172.17.100.103)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 2021-02-21 at 15:20 +0000, Jonathan Cameron wrote:
> On Tue, 16 Feb 2021 17:53:45 +0300
> Ivan Mikhaylov <i.mikhaylov@yadro.com> wrote:
> 
> > Add the proximity rate optional option and handling of it for
> > vishay vcnl3020.
> > 
> > Signed-off-by: Ivan Mikhaylov <i.mikhaylov@yadro.com>
> Hi Ivan,
> 
> Other than dropping the dt part this mostly looks fine.
> Please also implement the read_avail callback to let userspace know the
> valid set of values.
> 
> Thanks
> 
> Jonathan
> 

Ok, I'll get rid of dt part then. Thanks for review.

> > ---
> >  drivers/iio/proximity/vcnl3020.c | 123 ++++++++++++++++++++++++++++++-
> >  1 file changed, 120 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/iio/proximity/vcnl3020.c
> > b/drivers/iio/proximity/vcnl3020.c
> > index 37264f801ad0..833c5d5ac0a1 100644
> > --- a/drivers/iio/proximity/vcnl3020.c
> > +++ b/drivers/iio/proximity/vcnl3020.c
> > @@ -40,6 +40,17 @@
> >  #define VCNL_ON_DEMAND_TIMEOUT_US	100000
> >  #define VCNL_POLL_US			20000
> >  
> > +static const int vcnl3020_prox_sampling_frequency[][2] = {
> > +	{1, 950000},
> > +	{3, 906250},
> > +	{7, 812500},
> > +	{16, 625000},
> > +	{31, 250000},
> > +	{62, 500000},
> > +	{125, 0},
> > +	{250, 0},
> > +};
> > +
> >  /**
> >   * struct vcnl3020_data - vcnl3020 specific data.
> >   * @regmap:	device register map.
> > @@ -75,12 +86,37 @@ static u32 microamp_to_reg(u32 *val)
> >  	return *val /= 10000;
> >  };
> >  
> > +static u32 hz_to_reg(u32 *val)
> Hmm.  This is rather odd in the existing driver.   It makes no sense
> to have callbacks like this that both modify the value passed by pointer
> and return it.
> 
> Much cleaner to just pass by value and make caller do the assignment.
> 
> Given I've suggested you drop this anyway probably not that important!

Good point anyways.

> > +{
> > +	unsigned int i;
> > +	int index = -1;
> > +
> > +	for (i = 0; i < ARRAY_SIZE(vcnl3020_prox_sampling_frequency); i++) {
> > +		if (*val == vcnl3020_prox_sampling_frequency[i][0]) {
> > +			index = i;
> 
> 			return i;
> 
> > +			break;
> > +		}
> > +	}
> > +
> > +	*val = index;
> > +	if (index < 0)
> > +		*val = 0;
> > +
> > +	return *val;
> > +};
> > +
> >  static struct vcnl3020_property vcnl3020_led_current_property = {
> >  	.name = "vishay,led-current-microamp",
> >  	.reg = VCNL_LED_CURRENT,
> >  	.conversion_func = microamp_to_reg,
> >  };
> >  
> > +static struct vcnl3020_property vcnl3020_proximity_rate_property = {
> > +	.name = "vishay,proximity-rate-hz",
> > +	.reg = VCNL_PROXIMITY_RATE,
> > +	.conversion_func = hz_to_reg,
> > +};
> > +
> >  static int vcnl3020_get_and_apply_property(struct vcnl3020_data *data,
> >  					   struct vcnl3020_property prop)
> >  {
> > @@ -125,8 +161,18 @@ static int vcnl3020_init(struct vcnl3020_data *data)
> >  	data->rev = reg;
> >  	mutex_init(&data->lock);
> >  
> > -	return vcnl3020_get_and_apply_property(data,
> > -					       vcnl3020_led_current_property);
> > +	rc = vcnl3020_get_and_apply_property(data,
> > +					     vcnl3020_led_current_property);
> > +	if (rc) {
> > +		goto err_prop_set;
> 
> Kernel style has not brackets around single line blocks like this.
> 	if (rc)
> 		goto err_prop_set;
> 
> > +	}
> > +
> > +	rc = vcnl3020_get_and_apply_property(data,
> > +					     vcnl3020_proximity_rate_property);
> 
> From review of binding doc, I don't think this makes a much sense as a
> dt property.
> 
> > +
> > +err_prop_set:
> > +
> > +	return rc;
> >  };
> >  
> >  static int vcnl3020_measure_proximity(struct vcnl3020_data *data, int *val)
> > @@ -165,10 +211,50 @@ static int vcnl3020_measure_proximity(struct
> > vcnl3020_data *data, int *val)
> >  	return rc;
> >  }
> >  
> > +static int vcnl3020_read_proxy_samp_freq(struct vcnl3020_data *data, int
> > *val,
> > +					 int *val2)
> > +{
> > +	int rc;
> > +	unsigned int prox_rate;
> > +
> > +	rc = regmap_read(data->regmap, VCNL_PROXIMITY_RATE, &prox_rate);
> > +	if (rc)
> > +		return rc;
> > +
> > +	if (prox_rate >= ARRAY_SIZE(vcnl3020_prox_sampling_frequency))
> > +		return -EINVAL;
> > +
> > +	*val = vcnl3020_prox_sampling_frequency[prox_rate][0];
> > +	*val2 = vcnl3020_prox_sampling_frequency[prox_rate][1];
> > +
> > +	return 0;
> > +}
> > +
> > +static int vcnl3020_write_proxy_samp_freq(struct vcnl3020_data *data, int
> > val,
> > +					  int val2)
> > +{
> > +	unsigned int i;
> > +	int index = -1;
> > +
> > +	for (i = 0; i < ARRAY_SIZE(vcnl3020_prox_sampling_frequency); i++) {
> > +		if (val == vcnl3020_prox_sampling_frequency[i][0] &&
> > +		    val2 == vcnl3020_prox_sampling_frequency[i][1]) {
> 			return regmap_write(data->regmap,
> 					    VCNL_PROXIMITY_RATE, index);
> 
> > +			index = i;
> > +			break;
> > +		}
> > +	}
> 
> return -EINVAL;
> 
> Would probably be easier to read.
> > +
> > +	if (index < 0)
> > +		return -EINVAL;
> > +
> > +	return regmap_write(data->regmap, VCNL_PROXIMITY_RATE, index);
> > +}
> > +
> >  static const struct iio_chan_spec vcnl3020_channels[] = {
> >  	{
> >  		.type = IIO_PROXIMITY,
> > -		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> > +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> > +				      BIT(IIO_CHAN_INFO_SAMP_FREQ),
> >  	},
> >  };
> >  
> > @@ -185,13 +271,44 @@ static int vcnl3020_read_raw(struct iio_dev
> > *indio_dev,
> >  		if (rc)
> >  			return rc;
> >  		return IIO_VAL_INT;
> > +	case IIO_CHAN_INFO_SAMP_FREQ:
> > +		rc = vcnl3020_read_proxy_samp_freq(data, val, val2);
> > +		if (rc < 0)
> > +			return rc;
> > +		return IIO_VAL_INT_PLUS_MICRO;
> >  	default:
> >  		return -EINVAL;
> >  	}
> >  }
> >  
> > +static int vcnl3020_write_raw(struct iio_dev *indio_dev,
> > +			      struct iio_chan_spec const *chan,
> > +			      int val, int val2, long mask)
> > +{
> > +	int rc;
> > +	struct vcnl3020_data *data = iio_priv(indio_dev);
> > +
> > +	rc = iio_device_claim_direct_mode(indio_dev);
> > +	if (rc)
> > +		return rc;
> > +
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_SAMP_FREQ:
> 
> You could simplify the flow by moving the iio_device_claim_direct_mode()
> and iio_deivce_release_direct_mode() to this case statement.  That way
> the default path can return directly.
> 

Yeap.

> > +		rc = vcnl3020_write_proxy_samp_freq(data, val, val2);
> > +		goto end;
> > +	default:
> > +		rc = -EINVAL;
> > +		goto end;
> > +	}
> > +
> > +end:
> > +	iio_device_release_direct_mode(indio_dev);
> > +	return rc;
> > +}
> > +
> >  static const struct iio_info vcnl3020_info = {
> >  	.read_raw = vcnl3020_read_raw,
> > +	.write_raw = vcnl3020_write_raw,
> >  };
> >  
> >  static const struct regmap_config vcnl3020_regmap_config = {

