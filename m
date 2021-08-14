Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 922813EC3B8
	for <lists+linux-iio@lfdr.de>; Sat, 14 Aug 2021 18:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234875AbhHNQIO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 14 Aug 2021 12:08:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:59188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235458AbhHNQHo (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 14 Aug 2021 12:07:44 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D6B1660F21;
        Sat, 14 Aug 2021 16:07:10 +0000 (UTC)
Date:   Sat, 14 Aug 2021 17:10:07 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "hui.liu" <hui.liu@mediatek.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        <robh+dt@kernel.org>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <srv_heupstream@mediatek.com>, <zhiyong.tao@mediatek.com>,
        <chun-hung.wu@mediatek.com>, <yingjoe.chen@mediatek.com>,
        <seiya.wang@mediatek.com>, <matthias.bgg@gmail.com>,
        <s.hauer@pengutronix.de>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-iio@vger.kernel.org>, <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH v1 1/2] iio: mtk-auxadc: add support IIO_CHAN_INFO_RAW
 case
Message-ID: <20210814171007.6892ae94@jic23-huawei>
In-Reply-To: <042625639032bffe73b60a5c6274511e58e34ef4.camel@mediatek.com>
References: <20210812054844.30575-1-hui.liu@mediatek.com>
        <20210812054844.30575-2-hui.liu@mediatek.com>
        <20210812190725.00007449@Huawei.com>
        <042625639032bffe73b60a5c6274511e58e34ef4.camel@mediatek.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 13 Aug 2021 11:46:24 +0800
hui.liu <hui.liu@mediatek.com> wrote:

> On Thu, 2021-08-12 at 19:07 +0100, Jonathan Cameron wrote:
> > On Thu, 12 Aug 2021 13:48:43 +0800
> > Hui Liu <hui.liu@mediatek.com> wrote:
> >   
> > > Add support IIO_CHAN_INFO_RAW case.  
> > 
> > Why?
> > 
> > We almost never support both RAW and PROCESSED as userspace should be
> > fine to use either.  There are a few reasons we've let drivers do
> > this but I would like know why it matters to you and it definitely
> > needs to be in the patch description.
> >   
> Hi Jonathan,
> 
> 1. To support ADC consumers' different types of requirement: some
> consumers want to call iio_read_channel_raw to get raw data, the others
> use iio_read_channel_processed to get voltage.

Give an example of the consumer using the raw channel readback (without
acess to any scaling information?)

> 2. In our origin driver, if consumer call iio_read_channel_processed,
> read back value is raw data. 
> 
> Could we use SCALE instead of PROCESSED in patch for next version, or
> what's your suggestion?

That would unfortunately be a userspace ABI change.  We can add interfaces
but taking them away is normally a problem :( 

Your reasons here are fine, subject to information on what consumer cares
about having _RAW, please resend the patch with this information added
to the description.

Thanks,

Jonathan
> 
> Thanks.
> 
> > > 
> > > Signed-off-by: Hui Liu <hui.liu@mediatek.com>
> > > ---
> > >  drivers/iio/adc/mt6577_auxadc.c | 16 +++++++++++++++-
> > >  1 file changed, 15 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/iio/adc/mt6577_auxadc.c
> > > b/drivers/iio/adc/mt6577_auxadc.c
> > > index 79c1dd68b909..e995d43287b2 100644
> > > --- a/drivers/iio/adc/mt6577_auxadc.c
> > > +++ b/drivers/iio/adc/mt6577_auxadc.c
> > > @@ -60,7 +60,8 @@ static const struct mtk_auxadc_compatible
> > > mt6765_compat = {
> > >  		.type = IIO_VOLTAGE,				   
> > >  \
> > >  		.indexed = 1,					   
> > >  \
> > >  		.channel = (idx),				    \
> > > -		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED), \
> > > +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |	   
> > >  \
> > > +				      BIT(IIO_CHAN_INFO_PROCESSED), \
> > >  }
> > >  
> > >  static const struct iio_chan_spec mt6577_auxadc_iio_channels[] = {
> > > @@ -181,6 +182,19 @@ static int mt6577_auxadc_read_raw(struct
> > > iio_dev *indio_dev,
> > >  	struct mt6577_auxadc_device *adc_dev = iio_priv(indio_dev);
> > >  
> > >  	switch (info) {
> > > +	case IIO_CHAN_INFO_RAW:
> > > +		*val = mt6577_auxadc_read(indio_dev, chan);
> > > +		if (*val < 0) {
> > > +			dev_notice(indio_dev->dev.parent,
> > > +				"failed to sample data on
> > > channel[%d]\n",
> > > +				chan->channel);
> > > +			return *val;
> > > +		}
> > > +		if (adc_dev->dev_comp->sample_data_cali)
> > > +			*val = mt_auxadc_get_cali_data(*val, true);
> > > +
> > > +		return IIO_VAL_INT;
> > > +
> > >  	case IIO_CHAN_INFO_PROCESSED:
> > >  		*val = mt6577_auxadc_read(indio_dev, chan);
> > >  		if (*val < 0) {  
> > 
> >   

