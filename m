Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35FCD418323
	for <lists+linux-iio@lfdr.de>; Sat, 25 Sep 2021 17:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343902AbhIYPQ5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 25 Sep 2021 11:16:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:47006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240972AbhIYPQ4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 25 Sep 2021 11:16:56 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 44ACD610F7;
        Sat, 25 Sep 2021 15:15:18 +0000 (UTC)
Date:   Sat, 25 Sep 2021 16:19:07 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "hui.liu" <hui.liu@mediatek.com>
Cc:     <robh+dt@kernel.org>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <srv_heupstream@mediatek.com>, <zhiyong.tao@mediatek.com>,
        <chun-hung.wu@mediatek.com>, <yingjoe.chen@mediatek.com>,
        <seiya.wang@mediatek.com>, <ben.tseng@mediatek.com>,
        <matthias.bgg@gmail.com>, <s.hauer@pengutronix.de>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-iio@vger.kernel.org>, <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH] iio: mtk-auxadc: update case IIO_CHAN_INFO_PROCESSED
Message-ID: <20210925161907.29a58288@jic23-huawei>
In-Reply-To: <87915f14d20aa780566338e83e2bc0c49c202a22.camel@mediatek.com>
References: <20210914130901.1716-1-hui.liu@mediatek.com>
        <20210914130901.1716-2-hui.liu@mediatek.com>
        <20210918192059.4c13d157@jic23-huawei>
        <87915f14d20aa780566338e83e2bc0c49c202a22.camel@mediatek.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 24 Sep 2021 16:30:09 +0800
hui.liu <hui.liu@mediatek.com> wrote:

> Hi Jonathan,
> 
> In the previous mail(maybe 2021/08/15), we want to support two case in
> our driver: _RAW and _SCALE. In _SCALE case:

_RAW and _PROCESSED I think?  (scale is something else entirely)

> 	*val = *val * VOLTAGE_FULL_RANGE;
> 	*val2 = AUXADC_PRECISE;
> 	return IIO_VAL_FRACTIONAL_LOG2;
> 
> If user call read_raw, will get raw data; If user call read_processed,
> will get processed voltage.
> 
> What's your opinion?

I'm sorry, but I don't understand the question.

I looked back at that earlier discussion and the discussion was about also
adding _RAW.  I think we concluded that, as we already had _PROCESSED and
generally do not support both, we would just continue to have processed.

The suggestion in this review is to use a different choice from the various
ways that IIO can represent values in order to potentially maintain slightly
higher precision.  Whether that actually helps depends a bit of how the
value is being used in your out of tree driver.  If that driver wants
a different scaling (perhaps micro volts rather than millivolts) then,
if I recall correctly slightly higher precision is maintained
https://elixir.bootlin.com/linux/latest/source/drivers/iio/inkern.c#L625

If you prefer to keep the code as is, just address the request for a little
more information in the patch description.

Thanks,

Jonathan
 


> 
> Thanks.
> 
> 
> On Sat, 2021-09-18 at 19:20 +0100, Jonathan Cameron wrote:
> > On Tue, 14 Sep 2021 21:09:01 +0800
> > Hui Liu <hui.liu@mediatek.com> wrote:
> >   
> > > Convert raw data to processed data.
> > > 
> > > Fixes: ace4cdfe67be ("iio: adc: mt2701: Add Mediatek auxadc driver
> > > for
> > > mt2701.")
> > > Signed-off-by: Hui Liu <hui.liu@mediatek.com>  
> > 
> > Hi Hui Liu
> > 
> > This fix is obviously correct but I think we can improve it a little.
> > 
> > 1) Add a bit more detail to the patch description.  Perhaps change it
> > to something like
> > Previously the driver did not apply the scaling necessary to take the
> > voltage range of this ADC into account. 
> > 
> > 2) If you change to
> > 
> > 	*val = *val * VOLTAGE_FULL_RANGE;
> > 	*val2 = 12;
> > 	return IIO_VAL_FRACTIONAL_LOG2;
> > 
> > then you should get a more precise answer.  (Please check that
> > though!)
> > This might be an issue if you have consumers drivers though that can
> > not
> > cope with this particular type.  If so please state that in the patch
> > description
> > and add a comment to the code to say that so we don't end up
> > 'improving' this
> > in future without taking those consumers into account.
> > 
> > Thanks,
> > 
> > Jonathan
> >   
> > > ---
> > >  drivers/iio/adc/mt6577_auxadc.c | 8 ++++++++
> > >  1 file changed, 8 insertions(+)
> > > 
> > > diff --git a/drivers/iio/adc/mt6577_auxadc.c
> > > b/drivers/iio/adc/mt6577_auxadc.c
> > > index 79c1dd68b909..d4fccd52ef08 100644
> > > --- a/drivers/iio/adc/mt6577_auxadc.c
> > > +++ b/drivers/iio/adc/mt6577_auxadc.c
> > > @@ -82,6 +82,10 @@ static const struct iio_chan_spec
> > > mt6577_auxadc_iio_channels[] = {
> > >  	MT6577_AUXADC_CHANNEL(15),
> > >  };
> > >  
> > > +/* For Voltage calculation */
> > > +#define VOLTAGE_FULL_RANGE  1500	/* VA voltage */
> > > +#define AUXADC_PRECISE      4096	/* 12 bits */
> > > +
> > >  static int mt_auxadc_get_cali_data(int rawdata, bool enable_cali)
> > >  {
> > >  	return rawdata;
> > > @@ -191,6 +195,10 @@ static int mt6577_auxadc_read_raw(struct
> > > iio_dev *indio_dev,
> > >  		}
> > >  		if (adc_dev->dev_comp->sample_data_cali)
> > >  			*val = mt_auxadc_get_cali_data(*val, true);
> > > +
> > > +		/* Convert adc raw data to voltage: 0 - 1500 mV */
> > > +		*val = *val * VOLTAGE_FULL_RANGE / AUXADC_PRECISE;
> > > +
> > >  		return IIO_VAL_INT;
> > >  
> > >  	default:  
> > 
> >   

