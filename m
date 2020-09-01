Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBAA0258ACF
	for <lists+linux-iio@lfdr.de>; Tue,  1 Sep 2020 10:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbgIAIzB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 1 Sep 2020 04:55:01 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2718 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726020AbgIAIzB (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 1 Sep 2020 04:55:01 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 7EEF86449CFBFFAF30FE;
        Tue,  1 Sep 2020 09:55:00 +0100 (IST)
Received: from localhost (10.52.122.233) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Tue, 1 Sep 2020
 09:55:00 +0100
Date:   Tue, 1 Sep 2020 09:53:24 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     Angelo Compagnucci <angelo.compagnucci@gmail.com>,
        <linux-iio@vger.kernel.org>,
        Angelo Compagnucci <angelo@amarulasolutions.com>
Subject: Re: [PATCH v3] iio: adc: mcp3422: fix locking scope
Message-ID: <20200901095324.00003389@Huawei.com>
In-Reply-To: <20200831151011.10405ac1@archlinux>
References: <20200831125947.74824-1-angelo@amarulasolutions.com>
        <20200831151011.10405ac1@archlinux>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.122.233]
X-ClientProxiedBy: lhreml710-chm.china.huawei.com (10.201.108.61) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 31 Aug 2020 15:10:11 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Mon, 31 Aug 2020 14:59:47 +0200
> Angelo Compagnucci <angelo.compagnucci@gmail.com> wrote:
> 
> > From: Angelo Compagnucci <angelo.compagnucci@gmail.com>
> > 
> > Locking should be held for the entire reading sequence involving setting
> > the channel, waiting for the channel switch and reading from the
> > channel.
> > If not, reading from a channel can result mixing with the reading from
> > another channel.
> > 
> > Fixes: 07914c84ba30 ("iio: adc: Add driver for Microchip MCP3422/3/4 high resolution ADC")
> > Signed-off-by: Angelo Compagnucci <angelo.compagnucci@gmail.com>
> > Signed-off-by: Angelo Compagnucci <angelo@amarulasolutions.com>
> > ---  
> Hi Angelo
> 
> Change log?
> 
> Given I've just sent a pull request including v2, we are probably now in a mess
> if we actually need to use v3.

Hi Angelo,

Just found the discussion with Julia.

Unfortunately that went to my work account and yesterday was a holiday in the UK
so I missed it.

Could you spin a patch with the difference between v2 and v3 asap and add
gregkh@linuxfoundation.org to the cc list.  If he prefers it that way I'll ack
and Greg can pick it up directly.

Jonathan

> 
> Jonathan
> 
> >  drivers/iio/adc/mcp3422.c | 16 ++++++++++------
> >  1 file changed, 10 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/iio/adc/mcp3422.c b/drivers/iio/adc/mcp3422.c
> > index d86c0b5d80a3..f96f0cecbcde 100644
> > --- a/drivers/iio/adc/mcp3422.c
> > +++ b/drivers/iio/adc/mcp3422.c
> > @@ -96,16 +96,12 @@ static int mcp3422_update_config(struct mcp3422 *adc, u8 newconfig)
> >  {
> >  	int ret;
> >  
> > -	mutex_lock(&adc->lock);
> > -
> >  	ret = i2c_master_send(adc->i2c, &newconfig, 1);
> >  	if (ret > 0) {
> >  		adc->config = newconfig;
> >  		ret = 0;
> >  	}
> >  
> > -	mutex_unlock(&adc->lock);
> > -
> >  	return ret;
> >  }
> >  
> > @@ -138,6 +134,8 @@ static int mcp3422_read_channel(struct mcp3422 *adc,
> >  	u8 config;
> >  	u8 req_channel = channel->channel;
> >  
> > +	mutex_lock(&adc->lock);
> > +
> >  	if (req_channel != MCP3422_CHANNEL(adc->config)) {
> >  		config = adc->config;
> >  		config &= ~MCP3422_CHANNEL_MASK;
> > @@ -145,12 +143,18 @@ static int mcp3422_read_channel(struct mcp3422 *adc,
> >  		config &= ~MCP3422_PGA_MASK;
> >  		config |= MCP3422_PGA_VALUE(adc->pga[req_channel]);
> >  		ret = mcp3422_update_config(adc, config);
> > -		if (ret < 0)
> > +		if (ret < 0) {
> > +			mutex_unlock(&adc->lock);
> >  			return ret;
> > +		}
> >  		msleep(mcp3422_read_times[MCP3422_SAMPLE_RATE(adc->config)]);
> >  	}
> >  
> > -	return mcp3422_read(adc, value, &config);
> > +	ret = mcp3422_read(adc, value, &config);
> > +
> > +	mutex_unlock(&adc->lock);
> > +
> > +	return ret;
> >  }
> >  
> >  static int mcp3422_read_raw(struct iio_dev *iio,  
> 


