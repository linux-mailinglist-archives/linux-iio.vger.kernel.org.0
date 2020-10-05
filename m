Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4BFB283F35
	for <lists+linux-iio@lfdr.de>; Mon,  5 Oct 2020 21:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728883AbgJETAS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 5 Oct 2020 15:00:18 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:55232 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727247AbgJETAS (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 5 Oct 2020 15:00:18 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4C4qfk6hRhzDJ;
        Mon,  5 Oct 2020 21:00:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1601924415; bh=975hfAOBLuSIA/7fHqi7biOTS9X4Wxs7K81sFzFojRI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F1s7tDIkgfw/UC+jWeVyJ6U6PuKigDGNLEuANvaEx5EpM7QIABAlQhmhuFFd+tPHg
         ZD2Cqtk/tI0TnnBtpZ11BQRB/iN5KqwzB44ZGdKbvrjiW3+gMGMrCTRXn4y414UzzV
         mSkQpie/oBQsl10AhXX0vgFCiVbg9n3aoM7gvnpDXsdZP6ruPnSJtqBmLPbWalmC6M
         dC/3Ez+6NUzcHd5MHlwTiuFealjNqgR4o41Zxx5+e6xMCxt3Pu3eqFKF5TUWYQ+R0e
         NQ6D3vb+11w3OnwU0y9s0fJ2dCF/I6JS/Vf+cWYkw16MipvxFsXAIdUDRSpwgQ46ON
         WPlaVwrskUnIQ==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.4 at mail
Date:   Mon, 5 Oct 2020 21:00:10 +0200
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     dmitry.torokhov@gmail.com
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        linux-iio@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: exynos: do not rely on 'users' counter in ISR
Message-ID: <20201005190010.GA29936@qmqm.qmqm.pl>
References: <20201005052420.GA3262631@dtor-ws>
 <20201005110908.GA3243@qmqm.qmqm.pl>
 <20201005173636.GK1009802@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201005173636.GK1009802@dtor-ws>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Oct 05, 2020 at 10:36:36AM -0700, dmitry.torokhov@gmail.com wrote:
> Hi Micha³,
> 
> On Mon, Oct 05, 2020 at 01:09:08PM +0200, Micha³ Miros³aw wrote:
> > On Sun, Oct 04, 2020 at 10:24:20PM -0700, dmitry.torokhov@gmail.com wrote:
> > > The order in which 'users' counter is decremented vs calling drivers'
> > > close() method is implementation specific, and we should not rely on
> > > it. Let's introduce driver private flag and use it to signal ISR
> > > to exit when device is being closed.
> > > 
> > > This has a side-effect of fixing issue of accessing inut->users
> > > outside of input->mutex protection.
> > > 
> > > Reported-by: Andrzej Pietrasiewicz <andrzej.p@collabora.com>
> > > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > > ---
> > >  drivers/iio/adc/exynos_adc.c | 8 +++++++-
> > >  1 file changed, 7 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/iio/adc/exynos_adc.c b/drivers/iio/adc/exynos_adc.c
> > > index 22131a677445..7eb2a5df6e98 100644
> > > --- a/drivers/iio/adc/exynos_adc.c
> > > +++ b/drivers/iio/adc/exynos_adc.c
> > > @@ -135,6 +135,8 @@ struct exynos_adc {
> > >  	u32			value;
> > >  	unsigned int            version;
> > >  
> > > +	bool			ts_enabled;
> > > +
> > >  	bool			read_ts;
> > >  	u32			ts_x;
> > >  	u32			ts_y;
> > > @@ -633,7 +635,7 @@ static irqreturn_t exynos_ts_isr(int irq, void *dev_id)
> > >  	bool pressed;
> > >  	int ret;
> > >  
> > > -	while (info->input->users) {
> > > +	while (info->ts_enabled) {
> > >  		ret = exynos_read_s3c64xx_ts(dev, &x, &y);
> > >  		if (ret == -ETIMEDOUT)
> > >  			break;
> > > @@ -712,6 +714,8 @@ static int exynos_adc_ts_open(struct input_dev *dev)
> > >  {
> > >  	struct exynos_adc *info = input_get_drvdata(dev);
> > >  
> > > +	info->ts_enabled = true;
> > > +	mb();
> > >  	enable_irq(info->tsirq);
> > >  
> > >  	return 0;
> > > @@ -721,6 +725,8 @@ static void exynos_adc_ts_close(struct input_dev *dev)
> > >  {
> > >  	struct exynos_adc *info = input_get_drvdata(dev);
> > >  
> > > +	info->ts_enabled = false;
> > > +	mb();
> > >  	disable_irq(info->tsirq);
> > 
> > This should be WRITE_ONCE paired with READ_ONCE in the ISR.
> 
> Why? I can see that maybe full memory barrier is too heavy when we set
> the flag to true, but the only requirement is for the flag to be set
> before we disable IRQ, so any additional guarantees provided by
> WRITE_ONCE are not needed. On the read side we want the flag to be
> noticed eventually, and there is no additional dependencies on the data,
> so it is unclear what READ_ONCE() will give us here.

Without READ_ONCE you have no guarantee that the compiler won't optimize
'while (flag) ...' to 'if (flag) for(;;) ...'.

Maybe the platform has stronger coherency guarantees than Linux memory model
assumes, but if not, a CPU running the ISR (without paired memory barrier)
might not ever see the store from another CPU (both in current and proposed
code).

> > But is the check really needed? I see that this is to break waiting for
> > a touch release event, so I would assume this shouldn't wait forever
> > (unless the hardware is buggy)
> 
> It is not hardware, it is user. Do you want to delay indefinitely
> close() just because user has a finger on the touchscreen?

Ack. This covers the why of loop breaking.

> > and breaking the loop will desync touch
> > state (I would guess this would be noticable by next user).
> Upon next open driver will service the interrupt and provide new set of
> touch coordinates. Userspace is supposed to query current state of
> device when opening it before starting processing events. Or you are
> concerned about some other state?

From the code I would expect that there is a slight window, wher when the
user releases the touch between close() and open(), the client that open()s
will see a 'pressed' state until the ISR runs again (probably immediately
because of pending interrupt). OTOH, maybe the app should be prepared
for that anyway?

> In any case, this is current driver behavior and if it needs to be
> changed it is a topic for a separate patch.

Agreed.

> 
> Thanks.
> 
> -- 
> Dmitry
