Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45A25B5F9B
	for <lists+linux-iio@lfdr.de>; Wed, 18 Sep 2019 10:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbfIRIwu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Sep 2019 04:52:50 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:60589 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbfIRIwu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Sep 2019 04:52:50 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1iAVhQ-0001j8-Tt; Wed, 18 Sep 2019 10:52:32 +0200
Received: from mfe by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1iAVhP-0007uO-Pv; Wed, 18 Sep 2019 10:52:31 +0200
Date:   Wed, 18 Sep 2019 10:52:31 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     "Popa, Stefan Serban" <StefanSerban.Popa@analog.com>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 2/3] iio: adc: ad799x: factor out config register update
Message-ID: <20190918085231.ahofxji7metorpgt@pengutronix.de>
References: <20190917160925.9791-1-m.felsch@pengutronix.de>
 <20190917160925.9791-3-m.felsch@pengutronix.de>
 <6f857959a8cbef3320830676b2280e04ca4f8e96.camel@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f857959a8cbef3320830676b2280e04ca4f8e96.camel@analog.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 10:43:00 up 123 days, 15:01, 70 users,  load average: 0.15, 0.08,
 0.02
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

On 19-09-18 06:51, Ardelean, Alexandru wrote:
> On Tue, 2019-09-17 at 18:09 +0200, Marco Felsch wrote:
> > [External]
> > 
> 
> Comments inline.
> 
> > Factor out the configuration register update to reuse it during pm
> > resume operation.
> > 
> > Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> > ---
> >  drivers/iio/adc/ad799x.c | 23 +++++++++++++++++------
> >  1 file changed, 17 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
> > index f658012baad8..af5a2de9c22f 100644
> > --- a/drivers/iio/adc/ad799x.c
> > +++ b/drivers/iio/adc/ad799x.c
> > @@ -167,6 +167,21 @@ static int ad799x_read_config(struct ad799x_state
> > *st)
> >  	}
> >  }
> >  
> > +static int ad799x_update_config(struct ad799x_state *st, u16 config)
> > +{
> > +	int ret;
> > +
> > +	ret = ad799x_write_config(st, config);
> > +	if (ret < 0)
> > +		return ret;
> > +	ret = ad799x_read_config(st);
> > +	if (ret < 0)
> > +		return ret;
> > +	st->config = ret;
> > +
> > +	return 0;
> > +}
> > +
> >  /**
> >   * ad799x_trigger_handler() bh of trigger launched polling to ring
> > buffer
> >   *
> > @@ -808,13 +823,9 @@ static int ad799x_probe(struct i2c_client *client,
> >  	indio_dev->channels = st->chip_config->channel;
> >  	indio_dev->num_channels = chip_info->num_channels;
> >  
> > -	ret = ad799x_write_config(st, st->chip_config->default_config);
> > -	if (ret < 0)
> > -		goto error_disable_vref;
> > -	ret = ad799x_read_config(st);
> > -	if (ret < 0)
> > +	ret = ad799x_update_config(st, st->chip_config->default_config);
> > +	if (ret)
> >  		goto error_disable_vref;
> > -	st->config = ret;
> 
> I'm feeling this could go a bit further maybe.
> I'm noticing that patch 3 adds ad799x_suspend() & ad799x_resume().

Hm.. I don't know. You're right that this is needed for the resume(). I
wanted to keep the changes minimal to speed up the review process. As
you mentioned below I can squash patch 2 & 3.

> It looks to me (I could be wrong), that this bit of code (with some minor
> re-ordering) is actually a ad799x_resume() call.

I would keep them seperate at least resume() and the probe() path.

Regards,
  Marco

> Similarly, ad799x_suspend() could be added in ad799x_remove().
> 
> If that's the case, patch 2 & 3 could be squashed into a single patch that
> adds ad799x_suspend() & ad799x_resume() & also replaces them here and in
> the ad799x_remove() code.
> 
> >  
> >  	ret = iio_triggered_buffer_setup(indio_dev, NULL,
> >  		&ad799x_trigger_handler, NULL);

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
