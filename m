Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2474939B4BA
	for <lists+linux-iio@lfdr.de>; Fri,  4 Jun 2021 10:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbhFDIUq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Fri, 4 Jun 2021 04:20:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:56562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229900AbhFDIUq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 4 Jun 2021 04:20:46 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E05F1611CC;
        Fri,  4 Jun 2021 08:18:57 +0000 (UTC)
Date:   Fri, 4 Jun 2021 09:20:43 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Li, Meng" <Meng.Li@windriver.com>
Cc:     Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "Michael.Hennerich@analog.com" <Michael.Hennerich@analog.com>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] driver: adc: ltc2497: return directly after reading the
 adc conversion value
Message-ID: <20210604092043.0b13f24a@jic23-huawei>
In-Reply-To: <PH0PR11MB519190E44082ED1B0B0D4C90F13B9@PH0PR11MB5191.namprd11.prod.outlook.com>
References: <20210601092805.18385-1-Meng.Li@windriver.com>
        <20210603172025.314b5ced@jic23-huawei>
        <PH0PR11MB5191C26AA8B6D2B855E19D67F13B9@PH0PR11MB5191.namprd11.prod.outlook.com>
        <20210604061319.pbj5ptnhxfsz4cec@pengutronix.de>
        <PH0PR11MB519190E44082ED1B0B0D4C90F13B9@PH0PR11MB5191.namprd11.prod.outlook.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 4 Jun 2021 06:43:20 +0000
"Li, Meng" <Meng.Li@windriver.com> wrote:

> > -----Original Message-----
> > From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> > Sent: Friday, June 4, 2021 2:13 PM
> > To: Li, Meng <Meng.Li@windriver.com>
> > Cc: Jonathan Cameron <jic23@kernel.org>; lars@metafoo.de;
> > Michael.Hennerich@analog.com; pmeerw@pmeerw.net; linux-
> > kernel@vger.kernel.org; linux-iio@vger.kernel.org
> > Subject: Re: [PATCH] driver: adc: ltc2497: return directly after reading the adc
> > conversion value
> > 
> > Hello,
> > 
> > On Fri, Jun 04, 2021 at 02:16:39AM +0000, Li, Meng wrote:  
> > >
> > >  
> > > > -----Original Message-----
> > > > From: Jonathan Cameron <jic23@kernel.org>
> > > > Sent: Friday, June 4, 2021 12:20 AM
> > > > To: Li, Meng <Meng.Li@windriver.com>
> > > > Cc: lars@metafoo.de; Michael.Hennerich@analog.com;
> > > > pmeerw@pmeerw.net; u.kleine-koenig@pengutronix.de; linux-
> > > > kernel@vger.kernel.org; linux-iio@vger.kernel.org
> > > > Subject: Re: [PATCH] driver: adc: ltc2497: return directly after
> > > > reading the adc conversion value
> > > >
> > > > [Please note: This e-mail is from an EXTERNAL e-mail address]
> > > >
> > > > On Tue,  1 Jun 2021 17:28:05 +0800
> > > > Meng.Li@windriver.com wrote:
> > > >  
> > > > > From: Meng Li <Meng.Li@windriver.com>
> > > > >
> > > > > When read adc conversion value with below command:
> > > > > cat /sys/.../iio:device0/in_voltage0-voltage1_raw
> > > > > There is an error reported as below:
> > > > > ltc2497 0-0014: i2c transfer failed: -EREMOTEIO This i2c transfer
> > > > > issue is introduced by commit 69548b7c2c4f ("iio:
> > > > > adc: ltc2497: split protocol independent part in a separate module").
> > > > > When extract the common code into ltc2497-core.c, it change the
> > > > > code logic of function ltc2497core_read(). With wrong reading
> > > > > sequence, the action of enable adc channel is sent to chip again
> > > > > during adc channel is in conversion status. In this way, there is
> > > > > no ack from chip, and then cause i2c transfer failed.
> > > > > In order to keep the code logic is the same with original ideal,
> > > > > it is need to return direct after reading the adc conversion value.  
> > 
> > As background about the choice of the .result_and_measure callback:
> > A difference between the ltc2497 (i2c) and ltc2496 (spi) is that for the latter
> > reading the result of the last conversion and starting a new is a single bus
> > operation and the one cannot be done without the other.
> >   
> > > > > v2:
> > > > > According to ltc2497 datasheet, the max value of conversion time
> > > > > is
> > > > > 149.9 ms. So, add 20% to the 150msecs so that there is enough time
> > > > > for data conversion.  
> > > >
> > > > Version change logs go below the --- as we don't want to preserve
> > > > them forever in the git history.
> > > >
> > > > I may have lost track of the discussion, but I thought the idea was
> > > > that perhaps the longer time period would remove the need for the early  
> > return?  
> > > >  
> > >
> > > No!
> > > I think the ret is essential.  
> > 
> > I'd like to understand why. Currently ltc2497core_read() looks as follows
> > (simplified by dropping error handling, and unrolling the result_and_measure
> > callback for the i2c case):
> > 
> > 	ltc2497core_wait_conv()
> > 
> > 	// result_and_measure(address, NULL)
> > 	i2c_smbus_write_byte(client, LTC2497_ENABLE | address);
> > 
> > 	msleep_interruptible(LTC2497_CONVERSION_TIME_MS)
> > 
> > 	// result_and_measure(address, val);
> > 	i2c_master_recv(client, &buf, 3);
> > 	i2c_smbus_write_byte(client, LTC2497_ENABLE | address);
> > 
> > 
> > With the early return you suggest to introduce with your patch you save the
> > last i2c_smbus_write_byte call. The data sheet indeed claims to start a new
> > conversion at the stop condition.
> > 
> > So either the reading of the conversion result and programming of the
> > (maybe) new address has to be done in a single i2c transfer, or we have to do
> > something like your patch.
> > 
> > What I don't like about your approach is that it changes the semantic of the
> > callback to result_*or*_measure which is something the spi variant cannot
> > implement. With the current use of the function this is fine, however if at
> > some time in the future we implement a bulk conversion shortcut this hurts.
> > 
> > So I suggest to do:
> >   
> > ---->8----  
> > From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> > Date: Fri, 4 Jun 2021 08:02:44 +0200
> > Subject: [PATCH] iio: ltc2497: Fix reading conversion results
> > 
> > After the result of the previous conversion is read the chip automatically
> > starts a new conversion and doesn't accept new i2c transfers until this
> > conversion is completed which makes the function return failure.
> > 
> > So add an early return iff the programming of the new address isn't needed.
> > Note this will not fix the problem in general, but all cases that are currently
> > used. Once this changes we get the failure back, but this can be addressed
> > when the need arises.
> > 
> > Fixes: 69548b7c2c4f ("iio: adc: ltc2497: split protocol independent part in a
> > separate module ")
> > Reported-by: Meng Li <Meng.Li@windriver.com>
> > Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> > ---
> >  drivers/iio/adc/ltc2497.c | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> > 
> > diff --git a/drivers/iio/adc/ltc2497.c b/drivers/iio/adc/ltc2497.c
> > --- a/drivers/iio/adc/ltc2497.c
> > +++ b/drivers/iio/adc/ltc2497.c
> > @@ -41,6 +41,19 @@ static int ltc2497_result_and_measure(struct
> > ltc2497core_driverdata *ddata,
> >  		}
> > 
> >  		*val = (be32_to_cpu(st->buf) >> 14) - (1 << 17);
> > +
> > +		/*
> > +		 * The part started a new conversion at the end of the above
> > i2c
> > +		 * transfer, so if the address didn't change since the last call
> > +		 * everything is fine and we can return early.
> > +		 * If not (which should only happen when some sort of bulk
> > +		 * conversion is implemented) we have to program the new
> > +		 * address. Note that this probably fails as the conversion
> > that
> > +		 * was triggered above is like not complete yet and the two
> > +		 * operations have to be done in a single transfer.
> > +		 */

I'm a little confused by this comment.  It seems to say it will fail if we
ever do have a different address?  That doesn't seem very helpful...

J
> > +		if (ddata->addr_prev == address)
> > +			return 0;
> >  	}
> > 
> >  	ret = i2c_smbus_write_byte(st->client,
> > 
> > Compared to Meng Li's patch this doesn't introduce reporting of bogus
> > conversion results once we implement bulk conversion.
> >   
> 
> Ok!
> Understand.
> I agree you to push patch to upstream and it is more reasonable that the  original author to fix this issue.
> 
> Thanks,
> Limeng
> 
> > Best regards
> > Uwe
> > 
> > --
> > Pengutronix e.K.                           | Uwe Kleine-König            |
> > Industrial Linux Solutions                 | https://www.pengutronix.de/ |  

