Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33FFE38FC91
	for <lists+linux-iio@lfdr.de>; Tue, 25 May 2021 10:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232260AbhEYIW0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Tue, 25 May 2021 04:22:26 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5549 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbhEYIWZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 25 May 2021 04:22:25 -0400
Received: from dggems706-chm.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Fq6Qg0hHrzwSnk;
        Tue, 25 May 2021 16:18:03 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 dggems706-chm.china.huawei.com (10.3.19.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 25 May 2021 16:20:53 +0800
Received: from localhost (10.52.120.147) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2176.2; Tue, 25 May
 2021 09:20:51 +0100
Date:   Tue, 25 May 2021 09:19:02 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     "Li, Meng" <Meng.Li@windriver.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "Michael.Hennerich@analog.com" <Michael.Hennerich@analog.com>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] driver: adc: ltc2497: return directly after reading the
 adc conversion value
Message-ID: <20210525091902.000074b5@Huawei.com>
In-Reply-To: <PH0PR11MB519159873BE8CB7ACA227826F1269@PH0PR11MB5191.namprd11.prod.outlook.com>
References: <20210512045725.23390-1-Meng.Li@windriver.com>
        <20210519092104.pntanimcjg6s6fca@pengutronix.de>
        <20210521180150.0f4d1b5d@jic23-huawei>
        <PH0PR11MB519159873BE8CB7ACA227826F1269@PH0PR11MB5191.namprd11.prod.outlook.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.52.120.147]
X-ClientProxiedBy: lhreml705-chm.china.huawei.com (10.201.108.54) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 24 May 2021 02:49:01 +0000
"Li, Meng" <Meng.Li@windriver.com> wrote:

> > -----Original Message-----
> > From: Jonathan Cameron <jic23@kernel.org>
> > Sent: Saturday, May 22, 2021 1:02 AM
> > To: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> > Cc: Li, Meng <Meng.Li@windriver.com>; lars@metafoo.de;
> > Michael.Hennerich@analog.com; pmeerw@pmeerw.net; linux-
> > kernel@vger.kernel.org; linux-iio@vger.kernel.org
> > Subject: Re: [PATCH] driver: adc: ltc2497: return directly after reading the adc
> > conversion value
> > 
> > [Please note: This e-mail is from an EXTERNAL e-mail address]
> > 
> > On Wed, 19 May 2021 11:21:04 +0200
> > Uwe Kleine-König <u.kleine-koenig@pengutronix.de> wrote:
> >   
> > > On Wed, May 12, 2021 at 12:57:25PM +0800, Meng.Li@windriver.com  
> > wrote:  
> > > > From: Meng Li <Meng.Li@windriver.com>
> > > >
> > > > When read adc conversion value with below command:
> > > > cat /sys/.../iio:device0/in_voltage0-voltage1_raw
> > > > There is an error reported as below:
> > > > ltc2497 0-0014: i2c transfer failed: -EREMOTEIO This i2c transfer
> > > > issue is introduced by commit 69548b7c2c4f ("iio:
> > > > adc: ltc2497: split protocol independent part in a separate module").
> > > > When extract the common code into ltc2497-core.c, it change the code
> > > > logic of function ltc2497core_read(). With wrong reading sequence,
> > > > the action of enable adc channel is sent to chip again during adc
> > > > channel is in conversion status. In this way, there is no ack from
> > > > chip, and then cause i2c transfer failed.
> > > > In order to keep the code logic is the same with original ideal, it
> > > > is need to return direct after reading the adc conversion value.
> > > >
> > > > Fixes: 69548b7c2c4f ("iio: adc: ltc2497: split protocol independent
> > > > part in a separate module ")
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Meng Li <Meng.Li@windriver.com>
> > > > ---
> > > >  drivers/iio/adc/ltc2497.c | 2 ++
> > > >  1 file changed, 2 insertions(+)
> > > >
> > > > diff --git a/drivers/iio/adc/ltc2497.c b/drivers/iio/adc/ltc2497.c
> > > > index 1adddf5a88a9..fd5a66860a47 100644
> > > > --- a/drivers/iio/adc/ltc2497.c
> > > > +++ b/drivers/iio/adc/ltc2497.c
> > > > @@ -41,6 +41,8 @@ static int ltc2497_result_and_measure(struct  
> > ltc2497core_driverdata *ddata,  
> > > >             }
> > > >
> > > >             *val = (be32_to_cpu(st->buf) >> 14) - (1 << 17);
> > > > +
> > > > +           return ret;  
> > >
> > > This looks wrong for me. The idea of the function
> > > ltc2497_result_and_measure is that it reads the result and starts a
> > > new measurement. I guess the problem is that
> > > ltc2497_result_and_measure is called to early, not that it does too much.
> > >
> > > But note I don't have such a system handy to actually debug this any
> > > more.  
> > 
> > @Meng Li,
> > 
> > I see from the datasheet that the device can be used with an external
> > oscillator.
> > Is that the case on your boards, because if so the timing delay of 150msecs
> > may be far too short.  If not, perhaps the part is right at the upper end of
> > timings and we just need to add 20% to the 150msecs to be sure of not
> > hitting the limit?
> >   
> 
> Hi Jonathan,
> 
> Thanks for your very professional comments.
> I check my board schematics, the pin 35 f0 is connected to GND, so I use the internal oscillator.

Bad guess :( 

> In additional, I am not very understand your comment about the case of using internal oscillator.
> Do you mean that you agree my patch and only need to change 150 into 180?
> #define LTC2497_CONVERSION_TIME_MS	150ULL
> =>  
> #define LTC2497_CONVERSION_TIME_MS	180ULL

Yes.  Just give a little more time in case the oscillator is running
a little slow.

Jonathan

> 
> Thanks,
> Limeng
> 
> > Thanks,
> > 
> > Jonathan
> > 
> >   
> > >
> > > Best regards
> > > Uwe
> > >  
> 

