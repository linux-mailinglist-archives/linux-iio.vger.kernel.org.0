Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D18438CB75
	for <lists+linux-iio@lfdr.de>; Fri, 21 May 2021 19:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237507AbhEURB5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Fri, 21 May 2021 13:01:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:43110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237529AbhEURBz (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 21 May 2021 13:01:55 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E94E561074;
        Fri, 21 May 2021 17:00:29 +0000 (UTC)
Date:   Fri, 21 May 2021 18:01:50 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Meng.Li@windriver.com, lars@metafoo.de,
        Michael.Hennerich@analog.com, pmeerw@pmeerw.net,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH] driver: adc: ltc2497: return directly after reading the
 adc conversion value
Message-ID: <20210521180150.0f4d1b5d@jic23-huawei>
In-Reply-To: <20210519092104.pntanimcjg6s6fca@pengutronix.de>
References: <20210512045725.23390-1-Meng.Li@windriver.com>
        <20210519092104.pntanimcjg6s6fca@pengutronix.de>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 19 May 2021 11:21:04 +0200
Uwe Kleine-König <u.kleine-koenig@pengutronix.de> wrote:

> On Wed, May 12, 2021 at 12:57:25PM +0800, Meng.Li@windriver.com wrote:
> > From: Meng Li <Meng.Li@windriver.com>
> > 
> > When read adc conversion value with below command:
> > cat /sys/.../iio:device0/in_voltage0-voltage1_raw
> > There is an error reported as below:
> > ltc2497 0-0014: i2c transfer failed: -EREMOTEIO
> > This i2c transfer issue is introduced by commit 69548b7c2c4f ("iio:
> > adc: ltc2497: split protocol independent part in a separate module").
> > When extract the common code into ltc2497-core.c, it change the
> > code logic of function ltc2497core_read(). With wrong reading
> > sequence, the action of enable adc channel is sent to chip again
> > during adc channel is in conversion status. In this way, there is
> > no ack from chip, and then cause i2c transfer failed.
> > In order to keep the code logic is the same with original ideal,
> > it is need to return direct after reading the adc conversion value.
> > 
> > Fixes: 69548b7c2c4f ("iio: adc: ltc2497: split protocol independent part in a separate module ")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Meng Li <Meng.Li@windriver.com>
> > ---
> >  drivers/iio/adc/ltc2497.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/iio/adc/ltc2497.c b/drivers/iio/adc/ltc2497.c
> > index 1adddf5a88a9..fd5a66860a47 100644
> > --- a/drivers/iio/adc/ltc2497.c
> > +++ b/drivers/iio/adc/ltc2497.c
> > @@ -41,6 +41,8 @@ static int ltc2497_result_and_measure(struct ltc2497core_driverdata *ddata,
> >  		}
> >  
> >  		*val = (be32_to_cpu(st->buf) >> 14) - (1 << 17);
> > +
> > +		return ret;  
> 
> This looks wrong for me. The idea of the function
> ltc2497_result_and_measure is that it reads the result and starts a new
> measurement. I guess the problem is that ltc2497_result_and_measure is
> called to early, not that it does too much.
> 
> But note I don't have such a system handy to actually debug this any
> more.

@Meng Li,

I see from the datasheet that the device can be used with an external oscillator.
Is that the case on your boards, because if so the timing delay of 150msecs may
be far too short.  If not, perhaps the part is right at the upper end of
timings and we just need to add 20% to the 150msecs to be sure of not
hitting the limit?

Thanks,

Jonathan


> 
> Best regards
> Uwe
> 

