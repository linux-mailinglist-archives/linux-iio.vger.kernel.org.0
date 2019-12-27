Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC14012B3D4
	for <lists+linux-iio@lfdr.de>; Fri, 27 Dec 2019 11:24:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbfL0KYe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 27 Dec 2019 05:24:34 -0500
Received: from honk.sigxcpu.org ([24.134.29.49]:58928 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726354AbfL0KYe (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 27 Dec 2019 05:24:34 -0500
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id C1BF1FB03;
        Fri, 27 Dec 2019 11:24:31 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id BIslT7T3Kqzi; Fri, 27 Dec 2019 11:24:30 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 2E09C49799; Fri, 27 Dec 2019 11:24:30 +0100 (CET)
Date:   Fri, 27 Dec 2019 11:24:30 +0100
From:   Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Allison Randal <allison@lohutok.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: light: vcnl4000: Fix scale for vcnl4040
Message-ID: <20191227102430.GA4358@bogon.m.sigxcpu.org>
References: <4f2a980d87a7d5ae27d61ed1d35c4f310bfc607c.1577114947.git.agx@sigxcpu.org>
 <20191227084720.GA6398@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191227084720.GA6398@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,
On Fri, Dec 27, 2019 at 09:47:20AM +0100, Marco Felsch wrote:
> Hi Guido,
> 
> On 19-12-23 16:30, Guido Günther wrote:
> > According to the data sheet the ambient sensors's scale is 0.12
> > lux/step, not 0.024 lux/step as used by vcnl4200.
> 
> This is only true if the als_it bits are set to '0'. Is it worth to add
> a comment here?

Good point. I've added that to the commit message.
Cheers,
 -- Guido

> 
> > See p. 8 in https://www.vishay.com/docs/84307/designingvcnl4040.pdf
> > 
> > Fixes: 5a441aade5b3 ("light: vcnl4000 add support for the VCNL4040 proximity and light sensor")
> > Signed-off-by: Guido Günther <agx@sigxcpu.org>
> 
> Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>
> 
> > ---
> >  drivers/iio/light/vcnl4000.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
> > index 16dacea9eadf..b0e241aaefb4 100644
> > --- a/drivers/iio/light/vcnl4000.c
> > +++ b/drivers/iio/light/vcnl4000.c
> > @@ -163,7 +163,6 @@ static int vcnl4200_init(struct vcnl4000_data *data)
> >  	if (ret < 0)
> >  		return ret;
> >  
> > -	data->al_scale = 24000;
> >  	data->vcnl4200_al.reg = VCNL4200_AL_DATA;
> >  	data->vcnl4200_ps.reg = VCNL4200_PS_DATA;
> >  	switch (id) {
> > @@ -172,11 +171,13 @@ static int vcnl4200_init(struct vcnl4000_data *data)
> >  		/* show 54ms in total. */
> >  		data->vcnl4200_al.sampling_rate = ktime_set(0, 54000 * 1000);
> >  		data->vcnl4200_ps.sampling_rate = ktime_set(0, 4200 * 1000);
> > +		data->al_scale = 24000;
> >  		break;
> >  	case VCNL4040_PROD_ID:
> >  		/* Integration time is 80ms, add 10ms. */
> >  		data->vcnl4200_al.sampling_rate = ktime_set(0, 100000 * 1000);
> >  		data->vcnl4200_ps.sampling_rate = ktime_set(0, 100000 * 1000);
> > +		data->al_scale = 120000;
> >  		break;
> >  	}
> >  	data->vcnl4200_al.last_measurement = ktime_set(0, 0);
> > -- 
> > 2.23.0
> 
