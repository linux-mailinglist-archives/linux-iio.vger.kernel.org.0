Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4044F04E2
	for <lists+linux-iio@lfdr.de>; Sat,  2 Apr 2022 18:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350386AbiDBQbS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 2 Apr 2022 12:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349268AbiDBQbR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 2 Apr 2022 12:31:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B496556;
        Sat,  2 Apr 2022 09:29:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3CA5760B0B;
        Sat,  2 Apr 2022 16:29:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F1BAC340EE;
        Sat,  2 Apr 2022 16:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648916964;
        bh=0zTZVCqwikHoAkGPgno+BTuZyaWtzijYrNpFzKqJ33M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=D3sNX+PDnxEVBgBLoyl/H0BCVQAtjYdWojhjsdti04zD0d0hHa8tqx/bfxguMzeVI
         TxvCDp/8oVW2QmUGNYd98MS4k85VTsrn9zLw1s9+XPYQmB+Uzp2mewNgEgMqnnKBPs
         wtzydlwqx3z2w9zoXW7WtqOqgLOeGvl28ObSa25s1VZeaUGoI2vupaINCbRBRr/OdO
         37M1iBVIVtAx+hvAhGNCeDJLET8nu3v+Pj0egVM9ePucO7bhGq8NgWMDFoj1iH9YOb
         rv2OFfmL5HLGFLAn5f3CfggRypBgV2BFpj1htHzprg+NhOEcRq/2rCCXBAwdIMtgYT
         sOEL6Gpu6Oorw==
Date:   Sat, 2 Apr 2022 17:37:07 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jagath Jog J <jagathjog1996@gmail.com>
Cc:     dan@dlrobertson.com, andy.shevchenko@gmail.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] iio: accel: bma400: Add step change event
Message-ID: <20220402173707.426cb005@jic23-huawei>
In-Reply-To: <20220328203710.GA8027@jagath-PC>
References: <20220326194146.15549-1-jagathjog1996@gmail.com>
        <20220326194146.15549-6-jagathjog1996@gmail.com>
        <20220327175036.4b026481@jic23-huawei>
        <20220328203710.GA8027@jagath-PC>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 29 Mar 2022 02:07:11 +0530
Jagath Jog J <jagathjog1996@gmail.com> wrote:

> Hi Jonathan,
> 
> On Sun, Mar 27, 2022 at 05:50:36PM +0100, Jonathan Cameron wrote:
> > On Sun, 27 Mar 2022 01:11:46 +0530
> > Jagath Jog J <jagathjog1996@gmail.com> wrote:
> >   
> > > Added support for event when there is a detection of step change.
> > > INT1 pin is used to interrupt and event is pushed to userspace.
> > > 
> > > Signed-off-by: Jagath Jog J <jagathjog1996@gmail.com>  
> > 
> > These last two patches look fine to me.  Simply having the
> > event enable the channel makes things simpler.  
> 
> Means do I need to drop the step _INFO_ENABLE and handle the
> enabling and disabling of step channel through the event enable and
> disable?

No.  I was trying to say I like the solution you have now.

> 
> > I briefly wondered if we need to care about sequences like
> > 
> > 1) Enable event
> > 2) Enable channel (already enabled, but perhaps this indicates separate intent)
> > 3) Disable event.
> > 4) Is the channel still enabled?
> > 
> > or the simpler case of whether we should disable the channel if the event is
> > disabled and it wasn't otherwise turned on.
> > 
> > However, I can't see a sensible way to do so. Hence I think what you have
> > gone with is the best we can do.
> > 
> > Thanks,
> > 
> > Jonathan  
> 
> Thanks for reviewing the patch series. I will also address all the comments
> from Andy in the next patch v3.
> 
> Thank you
> Jagath
> >   
> > > ---
> > >  drivers/iio/accel/bma400.h      |  2 +
> > >  drivers/iio/accel/bma400_core.c | 73 +++++++++++++++++++++++++++++++++
> > >  2 files changed, 75 insertions(+)
> > > 
> > > diff --git a/drivers/iio/accel/bma400.h b/drivers/iio/accel/bma400.h
> > > index c9b856b37021..c4ec0cf6dc00 100644
> > > --- a/drivers/iio/accel/bma400.h
> > > +++ b/drivers/iio/accel/bma400.h
> > > @@ -39,6 +39,7 @@
> > >  #define BMA400_INT_STAT0_REG        0x0e
> > >  #define BMA400_INT_STAT1_REG        0x0f
> > >  #define BMA400_INT_STAT2_REG        0x10
> > > +#define BMA400_INT12_MAP_REG	    0x23
> > >  
> > >  /* Temperature register */
> > >  #define BMA400_TEMP_DATA_REG        0x11
> > > @@ -54,6 +55,7 @@
> > >  #define BMA400_STEP_CNT3_REG        0x17
> > >  #define BMA400_STEP_STAT_REG        0x18
> > >  #define BMA400_STEP_INT_MSK	    BIT(0)
> > > +#define BMA400_STEP_STAT_MASK	    GENMASK(9, 8)
> > >  
> > >  /*
> > >   * Read-write configuration registers
> > > diff --git a/drivers/iio/accel/bma400_core.c b/drivers/iio/accel/bma400_core.c
> > > index ec2f9c380bda..aaa104a2698b 100644
> > > --- a/drivers/iio/accel/bma400_core.c
> > > +++ b/drivers/iio/accel/bma400_core.c
> > > @@ -24,6 +24,7 @@
> > >  #include <linux/iio/iio.h>
> > >  #include <linux/iio/sysfs.h>
> > >  #include <linux/iio/buffer.h>
> > > +#include <linux/iio/events.h>
> > >  #include <linux/iio/trigger.h>
> > >  #include <linux/iio/trigger_consumer.h>
> > >  #include <linux/iio/triggered_buffer.h>
> > > @@ -70,6 +71,7 @@ struct bma400_data {
> > >  	int scale;
> > >  	struct iio_trigger *trig;
> > >  	int steps_enabled;
> > > +	bool step_event_en;
> > >  	/* Correct time stamp alignment */
> > >  	struct {
> > >  		__le16 buff[3];
> > > @@ -167,6 +169,12 @@ static const struct iio_chan_spec_ext_info bma400_ext_info[] = {
> > >  	{ }
> > >  };
> > >  
> > > +static const struct iio_event_spec bma400_step_detect_event = {
> > > +	.type = IIO_EV_TYPE_CHANGE,
> > > +	.dir = IIO_EV_DIR_NONE,
> > > +	.mask_separate = BIT(IIO_EV_INFO_ENABLE),
> > > +};
> > > +
> > >  #define BMA400_ACC_CHANNEL(_index, _axis) { \
> > >  	.type = IIO_ACCEL, \
> > >  	.modified = 1, \
> > > @@ -209,6 +217,8 @@ static const struct iio_chan_spec bma400_channels[] = {
> > >  		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
> > >  				      BIT(IIO_CHAN_INFO_ENABLE),
> > >  		.scan_index = -1, /* No buffer support */
> > > +		.event_spec = &bma400_step_detect_event,
> > > +		.num_event_specs = 1,
> > >  	},
> > >  	IIO_CHAN_SOFT_TIMESTAMP(4),
> > >  };
> > > @@ -878,6 +888,58 @@ static int bma400_write_raw_get_fmt(struct iio_dev *indio_dev,
> > >  	}
> > >  }
> > >  
> > > +static int bma400_read_event_config(struct iio_dev *indio_dev,
> > > +				    const struct iio_chan_spec *chan,
> > > +				    enum iio_event_type type,
> > > +				    enum iio_event_direction dir)
> > > +{
> > > +	struct bma400_data *data = iio_priv(indio_dev);
> > > +
> > > +	switch (type) {
> > > +	case IIO_EV_TYPE_CHANGE:
> > > +		return data->step_event_en;
> > > +	default:
> > > +		return -EINVAL;
> > > +	}
> > > +}
> > > +
> > > +static int bma400_write_event_config(struct iio_dev *indio_dev,
> > > +				     const struct iio_chan_spec *chan,
> > > +				     enum iio_event_type type,
> > > +				     enum iio_event_direction dir, int state)
> > > +{
> > > +	int ret;
> > > +	struct bma400_data *data = iio_priv(indio_dev);
> > > +
> > > +	switch (type) {
> > > +	case IIO_EV_TYPE_CHANGE:
> > > +		mutex_lock(&data->mutex);
> > > +		if (!data->steps_enabled) {
> > > +			ret = regmap_update_bits(data->regmap,
> > > +						 BMA400_INT_CONFIG1_REG,
> > > +						 BMA400_STEP_INT_MSK,
> > > +						 FIELD_PREP(BMA400_STEP_INT_MSK,
> > > +							    1));
> > > +			if (ret)
> > > +				return ret;
> > > +			data->steps_enabled = 1;
> > > +		}
> > > +
> > > +		ret = regmap_update_bits(data->regmap,
> > > +					 BMA400_INT12_MAP_REG,
> > > +					 BMA400_STEP_INT_MSK,
> > > +					 FIELD_PREP(BMA400_STEP_INT_MSK,
> > > +						    state));
> > > +		mutex_unlock(&data->mutex);
> > > +		if (ret)
> > > +			return ret;
> > > +		data->step_event_en = state;
> > > +		return 0;
> > > +	default:
> > > +		return -EINVAL;
> > > +	}
> > > +}
> > > +
> > >  static int bma400_data_rdy_trigger_set_state(struct iio_trigger *trig,
> > >  					     bool state)
> > >  {
> > > @@ -910,6 +972,8 @@ static const struct iio_info bma400_info = {
> > >  	.read_avail        = bma400_read_avail,
> > >  	.write_raw         = bma400_write_raw,
> > >  	.write_raw_get_fmt = bma400_write_raw_get_fmt,
> > > +	.read_event_config = bma400_read_event_config,
> > > +	.write_event_config = bma400_write_event_config,
> > >  };
> > >  
> > >  static const struct iio_trigger_ops bma400_trigger_ops = {
> > > @@ -965,6 +1029,15 @@ static irqreturn_t bma400_interrupt(int irq, void *private)
> > >  		ret = IRQ_HANDLED;
> > >  	}
> > >  
> > > +	if (FIELD_GET(BMA400_STEP_STAT_MASK, le16_to_cpu(status))) {
> > > +		iio_push_event(indio_dev,
> > > +			       IIO_EVENT_CODE(IIO_STEPS, 0, IIO_NO_MOD,
> > > +					      IIO_EV_DIR_NONE,
> > > +					      IIO_EV_TYPE_CHANGE, 0, 0, 0),
> > > +			       iio_get_time_ns(indio_dev));
> > > +		ret = IRQ_HANDLED;
> > > +	}
> > > +
> > >  	return ret;
> > >  }
> > >    
> >   

