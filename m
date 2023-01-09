Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 413F2662476
	for <lists+linux-iio@lfdr.de>; Mon,  9 Jan 2023 12:43:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234111AbjAILmh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 9 Jan 2023 06:42:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237195AbjAILmD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 9 Jan 2023 06:42:03 -0500
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2615F6391
        for <linux-iio@vger.kernel.org>; Mon,  9 Jan 2023 03:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1673264518;
  x=1704800518;
  h=date:to:cc:subject:message-id:references:mime-version:
   content-transfer-encoding:in-reply-to:from;
  bh=F/FtRDckejOQVJ1GXqQKDRHjhsq2xSpLThubtJPcYmw=;
  b=p0ulHzU1azsWoxsvDBnEQhoomSKYnAmMoYFDwM3s2SEy/5ZPX8NiuXlE
   RMWug8m95/Y6IaXLfpk6GxgyBGKGH7F/66ER5WePBwHLFl/5cYIem/myu
   NMde7ypIgJAoAgG1erFyhLYpTx+J2dc58/dv9dd3xV6xnL2ZSMQ93zTX7
   UojXlPnuSg+u0FMusznPRuHkisddJnrPv6az7LrLlz5coj/WqhK0NTSD5
   Sa2xl49V/Wd3XGU6INU64dGsauoGvcB+rotTcMmcbw1b/s8+vWT8hNYpA
   IwSXDqZ8vmGP2NNlS3tTwMkh9YU+9jacN/kiJg8YXxA6/Jot+QSiaZH/m
   Q==;
Date:   Mon, 9 Jan 2023 12:41:56 +0100
To:     Jonathan Cameron <jic23@kernel.org>
CC:     =?iso-8859-1?Q?M=E5rten?= Lindahl <Marten.Lindahl@axis.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        kernel <kernel@axis.com>
Subject: Re: [PATCH 2/2] iio: light: vcnl4000: Add interrupt support for
 vcnl4040
Message-ID: <Y7v9hP60m52vjRMo@axis.com>
References: <20221220214959.2289330-1-marten.lindahl@axis.com>
 <20221220214959.2289330-3-marten.lindahl@axis.com>
 <20221223160054.316c473f@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221223160054.316c473f@jic23-huawei>
From:   Marten Lindahl <martenli@axis.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Dec 23, 2022 at 05:00:54PM +0100, Jonathan Cameron wrote:
> On Tue, 20 Dec 2022 22:49:59 +0100
> Mårten Lindahl <marten.lindahl@axis.com> wrote:
> 
> > Add support to configure proximity sensor interrupts and threshold
> > limits for vcnl4040. If an interrupt is detected an event will be
> > pushed to the event interface.
> > 
> > Signed-off-by: Mårten Lindahl <marten.lindahl@axis.com>
> Hi,
> 
> Code looks good in general. A few readability related suggestions inline.
> 
> Thanks,
> 
> Jonathan

Hi Jonathan!

Thank you. Please see my reflections below.
> 
> > ---
> >  drivers/iio/light/vcnl4000.c | 163 +++++++++++++++++++++++++++++++++++
> >  1 file changed, 163 insertions(+)
> > 
> > diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
> > index 142d1760f65d..61d18c404ea6 100644
> > --- a/drivers/iio/light/vcnl4000.c
> > +++ b/drivers/iio/light/vcnl4000.c
> > @@ -60,8 +60,11 @@
> 
> ...
> 
> >  /* Bit masks for interrupt registers. */
> >  #define VCNL4010_INT_THR_SEL	BIT(0) /* Select threshold interrupt source */
> > @@ -138,6 +144,7 @@ struct vcnl4000_data {
> >  	enum vcnl4000_device_ids id;
> >  	int rev;
> >  	int al_scale;
> > +	int ps_int;
> 
> Bit big for 2 bits ;)  Maybe size it same as register size.
> 
> Also, probably benefit from a comment as ps_int isn't a particularly obviously name.

Ok, I'll do so.
> 
> >  	const struct vcnl4000_chip_spec *chip_spec;
> >  	struct mutex vcnl4000_lock;
> >  	struct vcnl4200_channel vcnl4200_al;
> 
> 
> ...
> 
> >  
> > +static int vcnl4040_read_event_config(struct iio_dev *indio_dev,
> > +				      const struct iio_chan_spec *chan,
> > +				      enum iio_event_type type,
> > +				      enum iio_event_direction dir)
> > +{
> > +	struct vcnl4000_data *data = iio_priv(indio_dev);
> > +
> > +	return (dir == IIO_EV_DIR_RISING) ?
> > +	    (data->ps_int & 0x01) : (data->ps_int & 0x02) >> 1;
> 
> Add some field definitions and FIELD_GET() to extract them.

I will do that.
> 
> > +}
> > +
> > +static int vcnl4040_write_event_config(struct iio_dev *indio_dev,
> > +				       const struct iio_chan_spec *chan,
> > +				       enum iio_event_type type,
> > +				       enum iio_event_direction dir, int state)
> > +{
> > +	int ret;
> > +	u16 val;
> > +	struct vcnl4000_data *data = iio_priv(indio_dev);
> > +
> > +	mutex_lock(&data->vcnl4000_lock);
> > +
> > +	ret = i2c_smbus_read_word_data(data->client, VCNL4200_PS_CONF1);
> > +	if (ret < 0)
> > +		goto out;
> > +
> > +	val = FIELD_GET(VCNL4040_PS_CONF2_PS_INT, ret);
> > +
> > +	if (dir == IIO_EV_DIR_RISING)
> > +		val = state ? (val | 0x1) : (val & 0x2);
> 
> Whilst I'm sure this is correct, it's not easy to follow. Perhaps
> 		val = state ? (val | 0x1) : (val & ~0x1);
> to make it clear you are turning on an off one bit?
> Also as above, some field definitions may make this easier to follow.

I will do that to make it more clear.
> 
> > +	else
> > +		val = state ? (val | 0x2) : (val & 0x1);
> > +
> > +	data->ps_int = val;
> > +	val = (ret & ~VCNL4040_PS_CONF2_PS_INT) |
> 
> It's been quite a few lines. Probably better to put that ret into
> a reg_val or similarly named field to make it slightly easier to see it
> is retained from above.
> 
> > +	    FIELD_PREP(VCNL4040_PS_CONF2_PS_INT, val);
> > +	ret = i2c_smbus_write_word_data(data->client, VCNL4200_PS_CONF1, val);
> > +
> > +out:
> > +	mutex_unlock(&data->vcnl4000_lock);
> > +	data->chip_spec->set_power_state(data, (bool)data->ps_int);
> the bool cast is a little nasty.  Perhaps != 0 is clearer?

I will rework these lines using field definitions. I'll send v2 shortly.

Kind regards
Mårten

> 
> > +
> > +	return ret;
> > +}
> > +
> 
> 
